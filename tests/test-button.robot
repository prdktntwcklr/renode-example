*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset And Load System
Resource                      ${RENODEKEYWORDS}

*** Variables ***
${REPL}                       ${CURDIR}/../nucleo_f446re_custom.repl
${ELF}                        ${CURDIR}/../nucleo-f446re/ButtonLed/build/ButtonLed.elf
${LED}                        sysbus.gpioa.greenled2
${BUTTON}                     sysbus.gpioc.bluebutton

*** Test Cases ***
Button Press should Toggle LED
    [Documentation]           Verifies that the LED toggles its state on every
    ...                       button click.

    LED State Should Be       False
    
    Toggle Button
    LED State Should Be       True

    Toggle Button
    LED State Should Be       False

*** Keywords ***
Reset And Load System
    Reset Emulation
    Execute Command         mach create
    Execute Command         machine LoadPlatformDescription @${REPL}
    Execute Command         sysbus LoadELF @${ELF}
    Start Emulation

Toggle Button
    Execute Command           ${BUTTON} Press
    Sleep                     100ms    # Small delay for debouncing logic in firmware
    Execute Command           ${BUTTON} Release

LED State Should Be
    [Arguments]               ${expected_state}
    ${current_state}=         Execute Command    ${LED} State
    Should Be Equal           ${current_state.strip()}    ${expected_state}
