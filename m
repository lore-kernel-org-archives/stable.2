Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D93438461;
	Tue, 28 Jul 2026 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240718; cv=none; b=VqzfA73pKjdMlz385DO2/Y2AitG+FS5IKu1gpsF/iVAwvPvqbs1WkWsDEvlcICpZD2ZalbXkykXzKe4NVDeDbcL3LJnK5zMYemCApC07EhNWweitSPPNyLtA73/854kgQL/3SCwzusyG0rBATTbchxXS6Lwety8bJOkR0bacZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240718; c=relaxed/simple;
	bh=6lBDnfXQfeUOwV/kUF3Gsl2vbQY7z00tTsQAFo4mX7o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OdEHGHB9pqf62N4LfacDmQ4SxkeiZqG4GLNfLyFeF5QotT597vbsXKOWC1CSV3BLNnPQnAHBNovL+yNK+GPSYZ3dg6dc2d8ybbwl8Xps/zc9AYPYjUqffXOqBypDSaxxKn+DTh58zTAkM/ZgV1xwr2nmcMCgLFDY5UwEV2EANtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVZFW/6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVZFW/6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD01F0155D;
	Tue, 28 Jul 2026 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240713;
	bh=n99i02Gu7p+ZioXqd7dLXXBNhh5AAfhsFukBthP4AHQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=HVZFW/6ygVur7hpj2Y4Jrsa1fJ33jPFIhdpL719mNJsPahZQ7AjI8d4SPM2qdzFS2
	 xEndt6xHtRb4kzbTg4SmOyPY+/Tz7ELZRiFn0J4qLDiPfx+jW7H1x8kyUm+mKQf2S/
	 4sWEL5Cb1ofPQFXUhOQGUpFDlBCOCOo3BQ2YhXnc9ajzl2kNg+a32IOmGgDCz2/0Nk
	 7wNjlS9jcCeFchWtQS2d5q5AY5ci1d18O9ka0OfVAOFL69kUyx5OOP8VJDik/GKD1F
	 78RO55+6y0de2ns87KX25rOkA+r8mQjplqZfFxQamfEtIUlbaKVpGt4JszjHJiwIhg
	 wqevlukUNeTzQ==
Message-ID: <efb34ca7-27bf-413e-85b2-e7bb6b80cf2c@kernel.org>
Date: Tue, 28 Jul 2026 14:11:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v2] media: nuvoton: npcm-video: quiesce VCD IRQ before
 teardown
To: Fan Wu <fanwu01@zju.edu.cn>, kwliu@nuvoton.com, kflin@nuvoton.com
Cc: hverkuil@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <04a332fc-2025-4a74-ae4d-1d8f30fe20bf@kernel.org>
 <20260716101539.3129478-1-fanwu01@zju.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20260716101539.3129478-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Can Nuvoton test this patch? I feel happier if this is given a quick test.

Regards,

	Hans

On 16/07/2026 12:15, Fan Wu wrote:
> The VCD IRQ is devm-requested, but npcm_video_remove() frees the video
> object before devres releases that IRQ.  The threaded handler dereferences
> video->vcd_regmap before checking VIDEO_STREAMING, so an interrupt in that
> interval can access freed memory.
> 
> Request the IRQ with IRQF_NO_AUTOEN.  Enable it after starting capture and
> setting VIDEO_STREAMING, and disable it first in stop_streaming().
> disable_irq() waits for an in-flight threaded handler to finish, after
> which stop_streaming() can mask and reset the VCD without a handler
> re-enabling it.
> 
> Use vb2_video_unregister_device() during remove.  It releases the vb2
> queue and calls stop_streaming() for an active stream, ensuring that the
> IRQ is disabled before the video object is freed.  Do not release the queue
> separately.
> 
> If streaming is never started, IRQF_NO_AUTOEN keeps the IRQ disabled
> until devres releases it.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> Changes since v1:
> - Follow Hans Verkuil's suggestion to tie IRQ enablement to the streaming
>   lifecycle (IRQF_NO_AUTOEN + enable_irq/disable_irq) and to use
>   vb2_video_unregister_device() for teardown.
> 
> Compile-tested only; I do not have NPCM hardware, so runtime testing by
> the Nuvoton maintainers would be appreciated.
> ---
>  drivers/media/platform/nuvoton/npcm-video.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
> index 52505af35c08..c28d9d7edd83 100644
> --- a/drivers/media/platform/nuvoton/npcm-video.c
> +++ b/drivers/media/platform/nuvoton/npcm-video.c
> @@ -120,6 +120,7 @@ struct npcm_video {
>  
>  	struct list_head buffers;
>  	struct mutex buffer_lock; /* buffer list lock */
> +	int irq;
>  	unsigned long flags;
>  	unsigned int sequence;
>  
> @@ -1486,6 +1487,7 @@ static int npcm_video_start_streaming(struct vb2_queue *q, unsigned int count)
>  	}
>  
>  	set_bit(VIDEO_STREAMING, &video->flags);
> +	enable_irq(video->irq);
>  	return 0;
>  }
>  
> @@ -1494,6 +1496,7 @@ static void npcm_video_stop_streaming(struct vb2_queue *q)
>  	struct npcm_video *video = vb2_get_drv_priv(q);
>  	struct regmap *vcd = video->vcd_regmap;
>  
> +	disable_irq(video->irq);
>  	clear_bit(VIDEO_STREAMING, &video->flags);
>  	regmap_write(vcd, VCD_INTE, 0);
>  	regmap_write(vcd, VCD_STAT, VCD_STAT_CLEAR);
> @@ -1707,9 +1710,10 @@ static int npcm_video_init(struct npcm_video *video)
>  		dev_err(dev, "Failed to find VCD IRQ\n");
>  		return -ENODEV;
>  	}
> +	video->irq = irq;
>  
>  	rc = devm_request_threaded_irq(dev, irq, NULL, npcm_video_irq,
> -				       IRQF_ONESHOT, DEVICE_NAME, video);
> +				       IRQF_ONESHOT | IRQF_NO_AUTOEN, DEVICE_NAME, video);
>  	if (rc < 0) {
>  		dev_err(dev, "Failed to request IRQ %d\n", irq);
>  		return rc;
> @@ -1807,8 +1811,7 @@ static void npcm_video_remove(struct platform_device *pdev)
>  	struct v4l2_device *v4l2_dev = dev_get_drvdata(dev);
>  	struct npcm_video *video = to_npcm_video(v4l2_dev);
>  
> -	video_unregister_device(&video->vdev);
> -	vb2_queue_release(&video->queue);
> +	vb2_video_unregister_device(&video->vdev);
>  	v4l2_ctrl_handler_free(&video->ctrl_handler);
>  	v4l2_device_unregister(v4l2_dev);
>  	if (video->ece.enable)

