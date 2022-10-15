
local objectSeal = assert(require("scriptlee").objectSeal)

local inn, out, log = io.stdin, io.stdout, io.stderr
local mod = {}


function mod.getExports()return{
    --doWhatever = mod.doWhatever,
}end


function mod.printHelp()
    out:write("\n"
        .."  TODO write this help page\n"
        .."\n"
        .."  Options:\n"
        .."\n")
end


function mod.parseArgs( this )
    local positionalArgNr = 0
    for iA=1, #_ENV.arg do
        local arg = _ENV.arg[iA]
        if false then
        elseif arg == "--help" then
            mod.printHelp() return -1
        elseif not arg:find("^%-%-") then
            positionalArgNr = positionalArgNr + 1
            if false then
            --elseif positionalArgNr == 1 then
            --    this.whatever = arg
            else
                log:write("Unexpected arg: ".. arg .."\n")return -1
            end
        else
            log:write("Unexpected arg: ".. arg .."\n")return -1
        end
    end
    if not this.whatever then log:write("TODO write errmsg here\n")return -1 end
    return 0
end


function mod.run( this )
    log:write("[INFO ] TODO impl what the prog should do\n")
end


function mod.main()
    local this = objectSeal{
        whatever = false,
    }
    if mod.parseArgs(this) ~= 0 then os.exit(1) end
    mod.run(this)
end


if debug.getinfo(3)then return mod.getExports()else mod.main()end
