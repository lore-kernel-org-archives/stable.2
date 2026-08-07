Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60ED47799B
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108413; cv=none; b=anoduHitBLNs0kLZGb0hj4d5xQCBkzRncLReSV6OgwfCd/BLpsVh1jr/jGnAWDnl2Glgw4ZTP67GY/5Yppj2G9W5TvSHcUPoRjsYVzSI0Wa/d7EhK1U0mSWTJqso3G5TtLS2sTB+73ahCxHTpItoIiNgceSI2eYObfqBPRXySmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108413; c=relaxed/simple;
	bh=3XsPpZp9gpm0fpVOyppqj2HkJY7VrXEN9Xi1g0hSkhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDO+s+XyIPhyDMgJfLRwT1f7Bto00DwO90BI0aCecNL75WQw9o0Rp0Yt+FKFUN2hQJpx9G1QNSO1/pEmSs4dr2cQo5Lv+p5jF4/mGhcxNU7dycSpIsTS/bxH4qcywjtL+fiSPBFAzjtPDsW3ZOrV+1L+5DGj2m6eKFsxjcc3gjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S9SyPOA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9SyPOA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607141F00ACA;
	Fri,  7 Aug 2026 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786108403;
	bh=rFrIU7vsNDPQRVMXbSH/6unLbjL5HVlLQBLe8BV0HAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S9SyPOA8B5HtUNAKO55avQJ32y12p8MCp1LKPASgjQARc9bWixTTc21g60qbLFHzg
	 zSpL7O4SUPhkO0ZnnafxHnxCGAuyL/ptaIM6tQvxObfYaxyjcg3X45Th9MaV5QTWs5
	 p4wOV4tLy8K4zUIeVYGH2BuJY81bS9pIJH5dR6hg=
Date: Fri, 7 Aug 2026 15:13:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Viktor =?iso-8859-1?Q?J=E4gersk=FCpper?= <viktor_jaegerskuepper@freenet.de>
Cc: Sasha Levin <sashal@kernel.org>, Wayne Lin <wayne.lin@amd.com>,
	Ray Wu <ray.wu@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
	daniel.wheeler@amd.com, Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: Re: Drop "drm/amd/display: Add AV mute wait frames to
 dce110_set_avmute" from stable queues
Message-ID: <2026080756-garage-series-d50e@gregkh>
References: <a464c560-8f7b-4609-8bbe-b7048f603d26@freenet.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a464c560-8f7b-4609-8bbe-b7048f603d26@freenet.de>

On Thu, Aug 06, 2026 at 10:10:00PM +0200, Viktor Jägersküpper wrote:
> Hi Greg and Sasha,
> 
> I noticed that the following patch is in the queues for the 7.1, 6.18 and 6.12
> stable trees:
> 
> >From 443290d70b01e9c35830c300e3247c06581b594c Mon Sep 17 00:00:00 2001
> From: Ray Wu <ray.wu@amd.com>
> Date: Mon, 13 Jul 2026 22:23:34 +0800
> Subject: drm/amd/display: Add AV mute wait frames to dce110_set_avmute
> 
> From: Ray Wu <ray.wu@amd.com>
> 
> commit 443290d70b01e9c35830c300e3247c06581b594c upstream.
> 
> Port the three-frame wait logic from dcn30_set_avmute to
> dce110_set_avmute so that older DCN versions (1.0, 2.0) also
> wait for GCP packets to be sent out before proceeding.
> 
> This ensures HDMI sinks properly process the mute state,
> preventing garbled display after link re-establishment.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5167
> Reviewed-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Ray Wu <ray.wu@amd.com>
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 414da24137ace80d8c59fefd43ba3ec9f5f854ba)
> Cc: stable@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |   21 +++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -1320,8 +1320,27 @@ void dce110_blank_stream(struct pipe_ctx
>  
>  void dce110_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
>  {
> -	if (pipe_ctx != NULL && pipe_ctx->stream_res.stream_enc != NULL)
> +	if (pipe_ctx == NULL || pipe_ctx->stream_res.stream_enc == NULL)
> +		return;
> +
> +	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
>  		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(pipe_ctx->stream_res.stream_enc, enable);
> +
> +		/* Wait for three frames to make sure AV mute is sent out.
> +		 * Some HDMI sinks need additional GCP packets to properly
> +		 * process the mute state, especially after link re-establishment
> +		 * with HDMI 2.0 scrambling enabled.
> +		 */
> +		if (enable && pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg)) {
> +			int i;
> +
> +			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
> +			for (i = 0; i < 3; i++) {
> +				pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
> +				pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
> +			}
> +		}
> +	}
>  }
>  
>  enum audio_dto_source translate_to_dto_source(enum controller_id crtc_id)
> ---
> 
> Please drop this patch because it leads to a regression which I reported for the
> mainline kernel here:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5557
> 
> A fix for the regression is already available, but it hasn't landed in the
> mainline tree yet. Since the patch above fixes an annoying issue, I propose to
> postpone it until the mainline tree has the fix so that both patches can be
> applied to the stable trees in the same release. I will notify you when that
> can be done.

Now dropped from all queues, thanks.

greg k-h
