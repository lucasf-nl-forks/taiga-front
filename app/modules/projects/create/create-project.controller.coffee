###
# This source code is licensed under the terms of the
# GNU Affero General Public License found in the LICENSE file in
# the root directory of this source tree.
#
# Copyright (c) 2021-present Kaleidos INC
###

class CreateProjectController
    @.$inject = [
        "tgAppMetaService",
        "$translate",
        "tgProjectService",
        "$tgAuth",
        "tgLightboxFactory",
        "tgResources",
        "$tgConfig"
    ]

    constructor: (@appMetaService, @translate, @projectService, @authService, @lightboxFactory, @rs, @config) ->
        taiga.defineImmutableProperty @, "project", () => return @projectService.project

        @appMetaService.setfn @._setMeta.bind(this)

        @authService.refresh()

        @.displayScrumDesc = false
        @.dontAsk = false


    _setMeta: () ->
        return null if !@.project

        ctx = {projectName: @.project.get("name")}

        return {
            title: @translate.instant("PROJECT.PAGE_TITLE", ctx)
            description: @.project.get("description")
        }

    displayHelp: (type, $event) ->
        $event.stopPropagation()
        $event.preventDefault()

        if type == 'scrum'
            @.displayScrumDesc = !@.displayScrumDesc
        if type == 'kanban'
            @.displayKanbanDesc = !@.displayKanbanDesc


angular.module("taigaProjects").controller("CreateProjectCtrl", CreateProjectController)
