Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0B486B91
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334465; cv=none; b=XfOk4Y0JyPywFDFNyeu/Y9Gc0SbIljiUgQqofMHG/Ar54V16uYuQc5x9pFhJwiERuq7qRQQs7JoW+6onNJcPyzwKpch/ODic83bwEzUJEAZ04dSzy8CBPiwlEB9KYj+a1GoK1/xzjdMIOO++M0Ly+HALiAFP/NrJ4RbUADsxmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334465; c=relaxed/simple;
	bh=+M2kMsZU0N74Iek30Ku272P6ObGYYDDlHEIP12MieL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jma3t5HTFaFCgnc3nhRf9d1AqLGP20XhrHBVu2aPe3SCKdjA7WUuxLDQZQXqOhSUKhrIpdIoAu9Muri/T2RJNGDxUVj2kJJPwab3mIhB4ktvZhM2h4ct2X4W926nnM1RLcQL56D4ljT2LYHHqoBDZjjDcIk/JibJ9HmWYNB4HN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/IlDJcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/IlDJcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC191F000E9;
	Wed, 29 Jul 2026 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785334463;
	bh=EU7QMKEh3IUbMm1OcAYjUxRJXH5xnpo8Drd1+P2rQ7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B/IlDJcVTBvDjhNnqs1su9WtBsvxLD2VodNHFIlKva1yOX+wcOzUcV85Uy8Nj/cb5
	 DVDZQAJl1GEsb54Opv+637wFRnLVH2h+FYjWdFwurY2qPZBPIH/v4DfT28Q9F1Bmdx
	 Fyv6ksh5rIRZUVCmc33LoORfMGUgBo61y1nD9XhtYvoSLb/iBUieCu9ZCptKg8LDXU
	 rH4CUYAyjdR9O2ydYcybW4EY/Ku0SRhl4E3IvT4QVH6M9JtIsng2NdbhSzOJz6O8zu
	 n9a8cO6svzYjFW4DLFNNQDK0ASqLMbwSN0DLmHYxwigrPyAM+R7fTYC5DcSNd2t1ao
	 xg6dFlI0lj+Zw==
Message-ID: <9d8947db-1da7-4d1a-b18a-7b6299f1412e@kernel.org>
Date: Wed, 29 Jul 2026 09:14:22 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y/6.18.y/7.1.y] drm/amd/display: Fix DTB DTO updates
 breaking live pixel rate sources
Content-Language: en-US
To: Matthew Schwartz <matthew.schwartz@linux.dev>, stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260729063340.9287-1-matthew.schwartz@linux.dev>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260729063340.9287-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/26 01:33, Matthew Schwartz wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> commit 76a2db58e95e328007043f54ac3c7336ccbee440 upstream.
> 
> dcn32_update_clocks_update_dtb_dto() and its dcn35 counterpart reprogram
> the DTB DTO of every timing generator in the context whenever the DTBCLK
> reference changes, passing a zeroed pixel rate and never setting
> is_hdmi. Both dccg set_dtbclk_dto() implementations treat a zero pixel
> rate as a disable request. On dcn32 that branch drives PIPE_DTO_SRC_SEL
> to the DP DTO source, so a timing generator actively scanning out an
> HDMI stream has its pixel rate source re-muxed out from under the live
> raster and the OTG stops on the spot. On dcn35 it clears
> DTBCLK_DTO_ENABLE and restores DTBCLK_Pn clock gating, which does the
> same to a live 128b/132b stream.
> 
> Two displays where only one runs a 128b/132b link hit this reliably.
> is_dtbclk_required() holds the DTBCLK reference high while both are
> active, and the moment the 128b/132b stream is torn down (compositor
> switch, display disable, hot-unplug) the next safe_to_lower pass drops
> the reference to the lowest DPM level and the DTO walk freezes the
> surviving screen. On Navi31 the DAL mailbox then goes deaf on the
> DISPCLK hard-min that follows the walk in dcn32_update_clocks(),
> stranding both SMU mailboxes until reboot.
> 
> Set is_hdmi for HDMI and DVI signals so the disable path leaves the
> pixel rate source selection on the HDMI path, and pass the real pixel
> rate for 128b/132b streams so a reference change rescales their DTO
> instead of disabling it.
> 
> Fixes: 128c1ca0303f ("drm/amd/display: Update DTBCLK for DCN32")
> Fixes: 8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [ mschwartz: dcn32 and dcn35 clk_mgr hunks only. The rest is HDMI FRL
>    enablement, absent before 7.2, so the FRL conditions and the
>    req_audio_dtbclk_khz assignment they guard are dropped and the
>    FRL-centric changelog is rewritten. Added the pipe_ctx->stream check
>    the new dereferences need. ]
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
> 6.6.y needs the dcn32 hunk alone and is sent alongside this one. Tested
> on Navi31 with a DisplayPort UHBR monitor and an HDMI TV.
Backport makes sense to me, thanks.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> index 084994c650c4..285689d7ecc4 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> @@ -276,13 +276,20 @@ static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
>   		struct dtbclk_dto_params dto_params = {0};
>   
>   		/* use mask to program DTO once per tg */
> -		if (pipe_ctx->stream_res.tg &&
> +		if (pipe_ctx->stream && pipe_ctx->stream_res.tg &&
>   				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
>   			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
>   
>   			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
>   			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
>   
> +			if (dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
> +				dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
> +
> +			if (dc_is_hdmi_signal(pipe_ctx->stream->signal) ||
> +					dc_is_dvi_signal(pipe_ctx->stream->signal))
> +				dto_params.is_hdmi = true;
> +
>   			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
>   			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
>   		}
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> index bb1ac12a2b09..d154383a3961 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> @@ -264,13 +264,20 @@ static void dcn35_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
>   		struct dtbclk_dto_params dto_params = {0};
>   
>   		/* use mask to program DTO once per tg */
> -		if (pipe_ctx->stream_res.tg &&
> +		if (pipe_ctx->stream && pipe_ctx->stream_res.tg &&
>   				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
>   			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
>   
>   			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
>   			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
>   
> +			if (dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
> +				dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
> +
> +			if (dc_is_hdmi_signal(pipe_ctx->stream->signal) ||
> +					dc_is_dvi_signal(pipe_ctx->stream->signal))
> +				dto_params.is_hdmi = true;
> +
>   			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
>   			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
>   		}

