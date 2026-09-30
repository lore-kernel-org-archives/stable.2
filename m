Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8E4FC326;
	Wed, 30 Sep 2026 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781902; cv=none; b=WhB9RnwJ+6HWmLzDgYu1U7f2+RcEJaJ91d/vfeWuKcTD3DKhKlvL1fPl9S7shW8ovrv77JCEwUeYtJV1e78DM7evNFzkW9Blx4eGqJEjVAdWG/jMi1VGj4UNEvOyMUVuXz9HBifq0BwGnXML4VTSRsVnTyxgn4BBeDny4gZEppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781902; c=relaxed/simple;
	bh=nmPV0ZmHUP8YtTIKw+qWcm06lsXCBSOHdnGij+/igwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se0pXXTOkUPhSQTuGQ12G2guE2gBAk1KUFqznTI1PtUrCdZ06G54+tHMDdLyo13QfOwvNRrga0vSlXQKYe085hzA5U40mm0q9LEHnJcq2LExQJPxzMrGth/ruiwv6jIC4VFfaYIRsJB867FmRcsiyBuEMfb0gavMQvh3n+hDFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mV8eH+bB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mV8eH+bB"
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1447593;
	Wed, 30 Sep 2026 17:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790781779;
	bh=nmPV0ZmHUP8YtTIKw+qWcm06lsXCBSOHdnGij+/igwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mV8eH+bBa54UgYbLH8JiFTHnU459svRBti1eRXi1AOs1kMEm6MLrh+do36MLr+890
	 w5GF9tvU8V1RQxHOqPY/fCttcbMRNJDdkcqtaVrZ8BWo4+N1u9IUwaquBhB4QHyQoR
	 NYROejZFqnlu80E04G6ghVpI6n0rvdz8x141lg/Y=
Date: Wed, 30 Sep 2026 17:24:48 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: linux-media@vger.kernel.org, dan.scally@ideasonboard.com, 
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, nayden.kanchev@arm.com, 
	hverkuil+cisco@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Free the ISP control handler on
 unregister
Message-ID: <ar0pSq6bkG1e4wOM@zed>
References: <20260906071112.48259-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260906071112.48259-1-devnexen@gmail.com>

Hi David

On Sun, Sep 06, 2026 at 08:10:30AM +0100, David Carlier wrote:
> mali_c55_isp_init_controls() initialises isp->handler and adds the
> capabilities control, but mali_c55_unregister_isp() never frees it.
> Neither v4l2_device_unregister_subdev() nor v4l2_subdev_cleanup()
> touches sd->ctrl_handler, so the handler and its control are leaked on
> every unbind or module removal. The probe error path already frees it,
> and the TPG subdevice does so in its own unregister function.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-isp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> index e128adf6ee37..c45a3760e084 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> @@ -641,6 +641,7 @@ void mali_c55_unregister_isp(struct mali_c55 *mali_c55)
>
>  	mutex_destroy(&isp->capture_lock);
>  	v4l2_device_unregister_subdev(&isp->sd);
> +	v4l2_ctrl_handler_free(&isp->handler);
>  	v4l2_subdev_cleanup(&isp->sd);
>  	media_entity_cleanup(&isp->sd.entity);
>  }
> --
> 2.55.0
>
>
