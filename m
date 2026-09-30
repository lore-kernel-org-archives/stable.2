Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5254C67F3;
	Wed, 30 Sep 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782176; cv=none; b=PJ4cp4t80BifAISSl5UQY8v7B5DrIxbcUutt9/j9TkC7QCZ/KxAi142l0MZjis+jk57/jiwab180nlIjWhSPZIT7aB6Lr8IQQzDAsgSpf7zUy1Es7bRXLHYLjhtj53/Ec1GtgeE4+oinsu750+FvzOyrPoOB/zBDp6YQA8sd0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782176; c=relaxed/simple;
	bh=rgOEJWLF8fMjQxtHHXuWmE11tv/fj/B2PNNtkYOwXsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6aNpwzD1mdHTwWh4siOizX5W2W5dw/oTegkQx56FEWJmjhQ2fXeyQyA7wD86cj9mhjgxZkEI1iFcQUpMC0q+1UfH6HEq6lHphYlTC3dwyanhUMgIkpQ3mKb0pbaS3jf+r3q68gcPN8t6vqBcb1XA8dAS8s2Od/NB8nVyYnQER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ro0Xaq7j; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ro0Xaq7j"
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2BA6B593;
	Wed, 30 Sep 2026 17:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790782050;
	bh=rgOEJWLF8fMjQxtHHXuWmE11tv/fj/B2PNNtkYOwXsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ro0Xaq7jepzZHoQYwP4oaYSE8okA/yRG9K2EU1Pi4LG2Eze2kVxKkZlpTEphjbvM2
	 GNnEWGlD11DH+ibPAJ8JRmmu2GPh3zvIPfeCxG3Hz5FPTxAtS1P1C7FskMRNpb4VhP
	 ZuaarDRks4i2pk47k1UAk8EeNF7dv52CEvVofgO0=
Date: Wed, 30 Sep 2026 17:29:18 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: linux-media@vger.kernel.org, dan.scally@ideasonboard.com, 
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, nayden.kanchev@arm.com, 
	hverkuil+cisco@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: mali-c55: Check the statistics buffer address
 before filling
Message-ID: <ar0qrapmUzt_TMdY@zed>
References: <20260906092429.50046-1-devnexen@gmail.com>
 <20260906092429.50046-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260906092429.50046-2-devnexen@gmail.com>

Hi David

On Sun, Sep 06, 2026 at 10:24:25AM +0100, David Carlier wrote:
> mali_c55_stats_cpu_read() copies the metering registers into the buffer
> returned by vb2_plane_vaddr() without checking it. As for the parameters
> queue, a DMABUF whose exporter cannot be vmapped yields NULL, and the
> memcpy_fromio() then dereferences it from the threaded interrupt
> handler.
>
> Report the failure to mali_c55_stats_fill_buffer() and complete the
> buffer with VB2_BUF_STATE_ERROR.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Same as the previous one
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

> ---
>  .../platform/arm/mali-c55/mali-c55-stats.c     | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-stats.c b/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
> index 655e52a5f288..a9c28b090b2a 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
> @@ -200,9 +200,9 @@ static const struct vb2_ops mali_c55_stats_vb2_ops = {
>  	.stop_streaming = mali_c55_stats_stop_streaming,
>  };
>
> -static void mali_c55_stats_cpu_read(struct mali_c55_stats *stats,
> -				    struct mali_c55_stats_buf *buf,
> -				    enum mali_c55_config_spaces cfg_space)
> +static int mali_c55_stats_cpu_read(struct mali_c55_stats *stats,
> +				   struct mali_c55_stats_buf *buf,
> +				   enum mali_c55_config_spaces cfg_space)
>  {
>  	struct mali_c55 *mali_c55 = stats->mali_c55;
>  	const void __iomem *src;
> @@ -211,12 +211,18 @@ static void mali_c55_stats_cpu_read(struct mali_c55_stats *stats,
>
>  	src = mali_c55->base + MALI_C55_REG_1024BIN_HIST;
>  	dst = vb2_plane_vaddr(&buf->vb.vb2_buf, 0);
> +
> +	if (!dst)
> +		return -EFAULT;
> +
>  	memcpy_fromio(dst, src, MALI_C55_1024BIN_HIST_SIZE);
>
>  	src = mali_c55->base + metering_space_addrs[cfg_space];
>  	dst += MALI_C55_1024BIN_HIST_SIZE;
>  	length = sizeof(struct mali_c55_stats_buffer) - MALI_C55_1024BIN_HIST_SIZE;
>  	memcpy_fromio(dst, src, length);
> +
> +	return 0;
>  }
>
>  void mali_c55_stats_fill_buffer(struct mali_c55 *mali_c55,
> @@ -224,6 +230,7 @@ void mali_c55_stats_fill_buffer(struct mali_c55 *mali_c55,
>  {
>  	struct mali_c55_stats *stats = &mali_c55->stats;
>  	struct mali_c55_stats_buf *buf = NULL;
> +	int ret;
>
>  	spin_lock(&stats->buffers.lock);
>  	if (!list_empty(&stats->buffers.queue)) {
> @@ -239,8 +246,9 @@ void mali_c55_stats_fill_buffer(struct mali_c55 *mali_c55,
>  	buf->vb.sequence = mali_c55->isp.frame_sequence;
>  	buf->vb.vb2_buf.timestamp = ktime_get_boottime_ns();
>
> -	mali_c55_stats_cpu_read(stats, buf, cfg_space);
> -	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> +	ret = mali_c55_stats_cpu_read(stats, buf, cfg_space);
> +	vb2_buffer_done(&buf->vb.vb2_buf,
> +			ret ? VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
>  }
>
>  void mali_c55_unregister_stats(struct mali_c55 *mali_c55)
> --
> 2.55.0
>
>
