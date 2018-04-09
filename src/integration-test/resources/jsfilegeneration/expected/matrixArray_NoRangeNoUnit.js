var Module = {
    'print': function (text) {
        console.log('stdout: ' + text)
    },
    'printErr': function (text) {
        console.log('stderr: ' + text)
    },
    onRuntimeInitialized: function () {
        Module.init();
    }
};

function init() {
    Module.init();
}

function execute() {
    Module.execute();
}

function getOutNoRangeNoUnit() {
    return math.format(Module.getOutNoRangeNoUnit(), {notation: 'fixed'});
}

function setInNoRangeNoUnit(_inNoRangeNoUnit) {
    var value = math.eval(_inNoRangeNoUnit);

    if (value === undefined) {
        throw "Could not evaluate input for _inNoRangeNoUnit";
    }

    //check dimension
    var dim = math.matrix([4, 2, 3]);
    if (!math.deepEqual(value.size(), dim)) {
        throw "Input has dimension " + value.size() + " but expected " + dim;
    }

    var array = [];
    for (var i0 = 0; i0 < 4; i0++) {
        array[i0] = [];
        for (var i1 = 0; i1 < 2; i1++) {
            array[i0][i1] = [];
            for (var i2 = 0; i2 < 3; i2++) {

                var e = value.get([i0, i1, i2]);

                var e_num = e;
                array[i0][i1][i2] = e_num;
            }
        }
    }
    Module.setInNoRangeNoUnit(array);
}

