class AppController < ApplicationController

def isasquare(points)
	squareis = false
	for poinqt in points
		if points.count(poinqt) > 1
			squareis = true
		end
	end
	return squareis
end

def findsurrounding(row, index, color, grid)
		finalret = []
		if row > 1
			finalret.append [row - 1, index]
		else
			finalret.append []
		end
		if row < 6
			finalret.append [row + 1, index]
		else
			finalret.append []
		end
		if index > 1
			finalret.append [row, index - 1]
		else
			finalret.append []
		end
		if index < 6
			finalret.append [row, index + 1]
		else
			finalret.append []
		end
		top = ""
		right = ""
		bottom = ""
		left = ""
		itera = 0
		selfpotentialcombos = []
		for pos in finalret
			itera += 1
			if itera == 1
				if pos != []
					top = grid[pos[0]][pos[1] - 1]
				end
			elsif itera == 2
				if pos != []
					bottom = grid[pos[0]][pos[1] - 1]
				end
			elsif itera == 3
				if pos != []
					left = grid[pos[0]][pos[1] - 1]
				end
			elsif itera == 4
				if pos != []
					right = grid[pos[0]][pos[1] - 1]
				end
			end
		end
		if top == color
			selfpotentialcombos.append [row - 1, index]
		end
		if right == color
			selfpotentialcombos.append [row, index + 1]
		end
		if bottom == color
			selfpotentialcombos.append [row + 1, index]
		end
		if left == color
			selfpotentialcombos.append [row, index - 1]
		end
		return selfpotentialcombos
end

def findmovesonboard(line1, line2, line3, line4, line5, line6, findindiv, strat)
	grid = {1 => line1, 2 => line2, 3 => line3, 4 => line4, 5 => line5, 6 => line6}

	yellowsquares = []
    bluesquares = []
    greensquares = []
    purplesquares = []
    redsquares = []

	checkup = lambda do |thedots, thecolor|
				if thedots.length >= 5
            		canapp = true
            	end
        	    if thecolor == "y"
        	        colorarray = yellowsquares
        	    end
        	    if thecolor == "g"
        	        colorarray = greensquares
        	    end
        	    if thecolor == "b"
        	        colorarray = bluesquares
        	    end
        	    if thecolor == "r"
        	        colorarray = redsquares 
        	    end
        	    if thecolor == "p"
        	        colorarray = purplesquares
        	    end
        	    for sd in colorarray
        	        yount = 0
        	        for sx in sd
        	            for sa in thedots
        	                if sx == sa
        	                    yount += 1
        	                end
        	            end
        	        end
        	        if yount == thedots.length
        	            canapp = false
        	        end
        	    end
        	    if canapp == true
        	        colorarray.append thedots
        	    end
			end

	anymove = []

	istruemove = lambda do |dotzx, colf|
        	shud = true
        	for dotsx in dotzx
        	    if grid[dotsx[0]][dotsx[1] - 1] == ' '
        	        shud = false
        	    end
        	end
        	if shud == true
        	    for valdot in anymove
        	        couont = 0
        	        for aval in dotzx
        	            if aval.include? valdot[0]
        	                couont += 1
        	            end
        	        end
        	        if couont == valdot[0].length && valdot[0].length == dotzx.length
        	            shud = false
        	        end
        	    end
        	end
        	if shud == true
        	    anymove.append [dotzx, colf]
        	end
    	end

    dotnum = 0
    dotrow = 0
    for row in grid
        dotrow += 1
        for dot in row[1].split("")
            if dot != ' '
                dotnum = (dotnum % 6) + 1
                surrounding = findsurrounding(dotrow, dotnum, dot, grid)
                stringofdots = [[dotrow, dotnum]]
                if findindiv == true
                    istruemove.call(stringofdots, dot)
                end
                shape = "single"
                connecting = false
                if surrounding.length > 0
                    shape = "double"
                end
                for combodot in surrounding
                    stringofdots = [[dotrow, dotnum], combodot]
                    if strat == true
                        istruemove.call(stringofdots, dot)
                    end
                    nextsurrounding = findsurrounding(combodot[0], combodot[1], dot, grid)
                    nextsurrounding.delete([dotrow, dotnum])
                    if nextsurrounding.length > 0
                        shape = "triple"
                    end
                    for anotherdot in nextsurrounding
                        stringofdots = [[dotrow, dotnum], combodot, anotherdot]
                        if strat == true
                            istruemove.call(stringofdots, dot)
                        end
                        nnextsurrounding = findsurrounding(anotherdot[0], anotherdot[1], dot, grid)
                        nnextsurrounding.delete(combodot)
                        if nnextsurrounding.length >= 1
                            shape = "quad"
                        end
                        for aanotherdot in nnextsurrounding
                            stringofdots = [[dotrow, dotnum], combodot, anotherdot, aanotherdot]
                            if strat == true
                                istruemove.call(stringofdots, dot)
                            end
                            nnnextsurrounding = findsurrounding(aanotherdot[0], aanotherdot[1], dot, grid)
                            nnnextsurrounding.delete(anotherdot)
                            if nnnextsurrounding.length >= 1
                                shape = "quint"
                            end
                            for aaanotherdot in nnnextsurrounding
                                stringofdots = [[dotrow, dotnum], combodot, anotherdot, aanotherdot, aaanotherdot]
                                istruemove.call(stringofdots, dot)
                                nnnnextsurrounding = findsurrounding(aaanotherdot[0], aaanotherdot[1], dot, grid)
                                nnnnextsurrounding.delete(aanotherdot)
                                if nnnnextsurrounding.length >= 1
                                    shape = "hecta"
                                end
                                for aaaanotherdot in nnnnextsurrounding
                                    stringofdots = [[dotrow, dotnum], combodot, anotherdot, aanotherdot, aaanotherdot, aaaanotherdot]
                                    istruemove.call(stringofdots, dot)
                                    nnnnnextsurrounding = findsurrounding(aaaanotherdot[0], aaaanotherdot[1], dot, grid)
                                    nnnnnextsurrounding.delete(aaanotherdot)
                                    if nnnnnextsurrounding.length >= 1
                                        shape = "sept"
                                    end
                                    for aaaaanotherdot in nnnnnextsurrounding
                                        stringofdots = [[dotrow, dotnum], combodot, anotherdot, aanotherdot, aaanotherdot, aaaanotherdot, aaaaanotherdot]
                                        istruemove.call(stringofdots, dot)
                                        nnnnnnextsurrounding = findsurrounding(aaaaanotherdot[0], aaaaanotherdot[1], dot, grid)
                                        nnnnnnextsurrounding.delete(aaaanotherdot)
                                        if nnnnnnextsurrounding.length >= 1
                                            shape = "octa"
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                dotnum = (dotnum % 6) + 1
            end
        end
    end

    potentialmoves = []

    for randommove in anymove
        if randommove[0].length >= 5
            if isasquare(randommove[0]) == true
                checkup.call(randommove[0], randommove[1])
            else
                potentialmoves.append [randommove[1], randommove[0], randommove[0].length]
            end
        else
            potentialmoves.append [randommove[1], randommove[0], randommove[0].length]
       	end
    end

    amntofyellowdots = 0
    amntofgreendots = 0
    amntofreddots = 0
    amntofbluedots = 0
    amntofpurpledots = 0

    for linezq in grid
        for dot12 in linezq[1].split("")
            if dot12 == "y"
               amntofyellowdots += 1
            end
            if dot12 == "g"
                amntofgreendots += 1
            end
            if dot12 == "b"
                amntofbluedots += 1
            end
            if dot12 == "r"
                amntofreddots += 1
            end
            if dot12 == "p"
                amntofpurpledots += 1
            end
        end
    end

    for ysq in yellowsquares
        potentialmoves.append ["y", ysq, amntofyellowdots]
    end
    for gsq in greensquares
        potentialmoves.append ["g", gsq, amntofgreendots]
    end
    for bsq in bluesquares
        potentialmoves.append ["b", bsq, amntofbluedots]
    end
    for psq in purplesquares
        potentialmoves.append ["p", psq, amntofpurpledots]
    end
    for rsq in redsquares
        potentialmoves.append ["r", rsq, amntofreddots]
    end

	return potentialmoves
end

def removedots(lineoneq, linetwoq, linethreeq, linefourq, linefiveq, linesixq, possmove)
    gridline = [lineoneq.split(""), linetwoq.split(""), linethreeq.split(""), linefourq.split(""), linefiveq.split(""), linesixq.split("")]
    pointstoremove = []
    if possmove[1].length > 4
        if isasquare(possmove[1]) == true
            cvb = 0
            for colodot in lineoneq.split("")
                cvb += 1
                if colodot == possmove[0]
                    pointstoremove.append [1, cvb]
                end
            end
            cvb = 0
            for colodot in linetwoq.split("")
                cvb += 1
                if colodot == possmove[0]
                    pointstoremove.append [2, cvb]
                end
            end
            cvb = 0
            for colodot in linethreeq.split("")
                cvb += 1
                if colodot == possmove[0]
                    pointstoremove.append [3, cvb]
                end
            end
            cvb = 0
            for colodot in linefourq.split("")
                cvb += 1
                if colodot == possmove[0]
                    pointstoremove.append [4, cvb]
                end
            end
            cvb = 0
            for colodot in linefiveq.split("")
                cvb += 1
                if colodot == possmove[0]
                    pointstoremove.append [5, cvb]
                end
            end
            cvb = 0
            for colodot in linesixq.split("")
                cvb += 1
                if colodot == possmove[0]
                    pointstoremove.append [6, cvb]
                end
            end
        else
            pointstoremove = possmove[1]
        end
    else
        pointstoremove = possmove[1]
    end
    
    for point in pointstoremove
        pointsaboveremove = []
        num = point[0]
        while num > 0
            pointsaboveremove.append [num, point[1]]
            num -= 1
        end
        num = pointsaboveremove.length
        for pointtwo in pointsaboveremove
            num -= 1
            if num == 0
                gridline[0][pointtwo[1] - 1] = " "
            else
                gridline[pointtwo[0] - 1][pointtwo[1] - 1] = gridline[pointtwo[0] - 2][pointtwo[1] - 1]
            end
        end
    end
    return gridline
end

def home
	roundscores = []

	lineone = "bggppp"
	linetwo = "bgyrry"
	linethree = "pyprbb"
	linefour = "rpprbb"
	linefive = "rybybr"
	linesix = "rgbrgp"

	roundonepossiblemoves = findmovesonboard(lineone, linetwo, linethree, linefour, linefive, linesix, true, true)

	for move in roundonepossiblemoves
    	roundonescore = move[2]
    	potarry = removedots(lineone, linetwo, linethree, linefour, linefive, linesix, move)
    	newpotarry = []
    	for line in potarry
    	    finstrin = ""
    	    for letter in line
    	        finstrin = finstrin + letter
    	    end
    	    newpotarry.append finstrin
    	end
    	strategy = true
    	if move[2] < 6
    	    strategy = false
    	end
    	roundtwopossiblemoves = findmovesonboard(newpotarry[0], newpotarry[1], newpotarry[2], newpotarry[3], newpotarry[4], newpotarry[5], false, strategy)
    	if roundtwopossiblemoves == []
    	    c = 0
    	else
    	    highestpossibledotremoval = 0
    	    bestoutcomefortheround = []
    	    eachround = [0, 0]
    	    for movetwo in roundtwopossiblemoves
    	        moveresult = movetwo[2] + move[2]
    	        if highestpossibledotremoval <= moveresult
    	            highestpossibledotremoval = moveresult
    	            if eachround[1] < move[2]
    	                bestoutcomefortheround = [move, movetwo]
    	                eachround = [move[2], movetwo[2]]
    	            end
    	        end
    	    end
    	    roundscores.append bestoutcomefortheround
    	end
    end

    highestpossibledotremoval = 0
	bestoutcomefortheround = []
	for moves in roundscores
	    moveresult = moves[0][2] + moves[1][2]
	    if highestpossibledotremoval < moveresult
	        highestpossibledotremoval = moveresult
	        bestoutcomefortheround = [moves[0], moves[1]]
	    end
	end

	@test = bestoutcomefortheround[0].to_s + " " + highestpossibledotremoval.to_s

end

end
























