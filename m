Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E38448D03;
	Wed, 15 Jul 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116267; cv=none; b=Vtpn/qmauKarl2zNjx7Ya2xfo0dU3we5ALV2vZfEugNb6aFwDSz7BGKz+zOLDPjyovEVt2GyIdlWAPOTgJSkgjBPRscHF3i/67zE7P55j7oXlp+QC35Mo0SWPiEf3EraHAb3+pW6lpVldIXfwejbq+TaRK2dgUenYdHGrRCQBBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116267; c=relaxed/simple;
	bh=gOCHKkzFj8Llq3Xow7fLUehPkDztwpHtiB4IBMTq1Ok=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kLeaTVf6njPOfXbYVpHK4CWgiagGq5wkWsLZwChqu6IZPYX6E1cVvl0Duqwt4Zb4obtX76D/ReER1yyId2aEfI0dkGm4c/Lziu7eqB4pRTgYGzcuR8VdcF5HelGL6vLFiENg601g5XKYcqDTxb9yemc+SyW3lCIrC2DglVQMdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ66qRhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ66qRhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5853E1F000E9;
	Wed, 15 Jul 2026 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784116265;
	bh=ZksEdlHG8eYEb4FRJd8G+klMQE6uApl+yisjGGemO8Y=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=BQ66qRhr8Cf7Ao5pin5Mg7ass/PLJZgVVR18pozqglZRQUOgUdlkxX1gXln/er3wF
	 DAkSH6T/tQvfyL+GC2O23VQOqMpTZTcZ3diNwzwkuC++vNxcSKzV4/i7DWhj7RWSDc
	 TbQwpnbR6VEGk9pOoAWdirQ/Lin4X+lud4qjUDSFcVmwGrf2KeDpmwZpZ4FC1Tnasc
	 9yfWFw4z8VO35kZQvIXx9lLN0ELE4SPWJz5PHPePAU0k8zfBJvye/ZhwN3E0/pgIMI
	 C1aPEz3dirXAOLRaVDuN+bw/0kuNIUlimX/Pv/73joOOjcpjY4Iy2SyBQ8Egtvv0Bj
	 wKNlx8QqccvbQ==
Message-ID: <8c7e1294-b906-4636-890c-b64d03b0e1d0@kernel.org>
Date: Wed, 15 Jul 2026 13:51:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: cx231xx-audio: gate wq_trigger on an audio-local
 teardown flag
To: Fan Wu <fanwu01@zju.edu.cn>, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260708141622.3936490-1-fanwu01@zju.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20260708141622.3936490-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2026 16:16, Fan Wu wrote:
> audio_trigger() is deferred work (dev->wq_trigger) armed from
> snd_cx231xx_capture_trigger() on every PCM START/STOP; it dereferences
> dev->adev state and may free the URBs via cx231xx_isoc_audio_deinit().
> cx231xx_audio_fini() tore down that state (snd_card_free_when_closed,
> alt_max_pkt_size) without draining wq_trigger, so work armed before or
> racing fini ran against freed state.
> 
> Adding cancel_work_sync() alone is insufficient: in capture_trigger() the
> DEV_DISCONNECTED test and schedule_work() were not atomic, and
> DEV_DISCONNECTED is only set on USB disconnect, but fini also runs on
> cx231xx-alsa module unload (cx231xx_unregister_extension()), which never
> sets it.  A trigger that passed the check could still queue work after
> fini's cancel returned an empty queue.
> 
> Add an audio-local teardown gate (dev->adev.teardown): fini raises it under
> adev.slock, releases the lock, then calls cancel_work_sync() outside the
> spinlock.  Both arm sites perform the teardown check and schedule_work()
> inside one adev.slock section, so once the gate is visible no new work can
> arm after cancel returns.  Initialize the lock, work and gate at the top of
> cx231xx_audio_init(), before any fallible allocation, and clear the
> partially-built audio state on its error path, so fini is safe even if a
> later step fails.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 61b04cb24a12 ("[media] cx231xx-audio: fix some locking issues")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/media/usb/cx231xx/cx231xx-audio.c | 42 +++++++++++++++++++----
>  drivers/media/usb/cx231xx/cx231xx.h       |  1 +
>  2 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/usb/cx231xx/cx231xx-audio.c b/drivers/media/usb/cx231xx/cx231xx-audio.c
> index 9c71b32552df..44ca75b18a5d 100644
> --- a/drivers/media/usb/cx231xx/cx231xx-audio.c
> +++ b/drivers/media/usb/cx231xx/cx231xx-audio.c
> @@ -441,6 +441,7 @@ static int snd_cx231xx_capture_open(struct snd_pcm_substream *substream)
>  static int snd_cx231xx_pcm_close(struct snd_pcm_substream *substream)
>  {
>  	int ret;
> +	unsigned long flags;
>  	struct cx231xx *dev = snd_pcm_substream_chip(substream);
>  
>  	dev_dbg(dev->dev, "closing device\n");
> @@ -470,7 +471,11 @@ static int snd_cx231xx_pcm_close(struct snd_pcm_substream *substream)
>  		dev_dbg(dev->dev, "released lock\n");
>  		if (atomic_read(&dev->stream_started) > 0) {
>  			atomic_set(&dev->stream_started, 0);
> -			schedule_work(&dev->wq_trigger);
> +
> +			spin_lock_irqsave(&dev->adev.slock, flags);
> +			if (!dev->adev.teardown)
> +				schedule_work(&dev->wq_trigger);
> +			spin_unlock_irqrestore(&dev->adev.slock, flags);
>  		}
>  	}
>  	return 0;
> @@ -509,11 +514,14 @@ static int snd_cx231xx_capture_trigger(struct snd_pcm_substream *substream,
>  {
>  	struct cx231xx *dev = snd_pcm_substream_chip(substream);
>  	int retval = 0;
> +	unsigned long flags;
>  
> -	if (dev->state & DEV_DISCONNECTED)
> +	spin_lock_irqsave(&dev->adev.slock, flags);
> +	if (dev->adev.teardown || (dev->state & DEV_DISCONNECTED)) {
> +		spin_unlock_irqrestore(&dev->adev.slock, flags);
>  		return -ENODEV;
> +	}
>  
> -	spin_lock(&dev->adev.slock);
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  		atomic_set(&dev->stream_started, 1);
> @@ -525,10 +533,10 @@ static int snd_cx231xx_capture_trigger(struct snd_pcm_substream *substream,
>  		retval = -EINVAL;
>  		break;
>  	}
> -	spin_unlock(&dev->adev.slock);
>  
>  	schedule_work(&dev->wq_trigger);
>  
> +	spin_unlock_irqrestore(&dev->adev.slock, flags);
>  	return retval;
>  }
>  
> @@ -576,12 +584,20 @@ static int cx231xx_audio_init(struct cx231xx *dev)
>  	dev_dbg(dev->dev,
>  		"probing for cx231xx non standard usbaudio\n");
>  
> +	/*
> +	 * Extension init errors are ignored by the cx231xx core, so fini()
> +	 * must be safe even if initialization fails part way through.
> +	 */
> +	spin_lock_init(&adev->slock);
> +	INIT_WORK(&dev->wq_trigger, audio_trigger);
> +	adev->teardown = false;
> +	atomic_set(&dev->stream_started, 0);
> +
>  	err = snd_card_new(dev->dev, index[devnr], "Cx231xx Audio",
>  			   THIS_MODULE, 0, &card);
>  	if (err < 0)
>  		return err;
>  
> -	spin_lock_init(&adev->slock);
>  	err = snd_pcm_new(card, "Cx231xx Audio", 0, 0, 1, &pcm);
>  	if (err < 0)
>  		goto err_free_card;
> @@ -596,8 +612,6 @@ static int cx231xx_audio_init(struct cx231xx *dev)
>  	strscpy(card->shortname, "Cx231xx Audio", sizeof(card->shortname));
>  	strscpy(card->longname, "Conexant cx231xx Audio", sizeof(card->longname));
>  
> -	INIT_WORK(&dev->wq_trigger, audio_trigger);
> -
>  	err = snd_card_register(card);
>  	if (err < 0)
>  		goto err_free_card;
> @@ -651,14 +665,18 @@ static int cx231xx_audio_init(struct cx231xx *dev)
>  
>  err_free_pkt_size:
>  	kfree(adev->alt_max_pkt_size);
> +	adev->alt_max_pkt_size = NULL;
>  err_free_card:
>  	snd_card_free(card);
> +	adev->sndcard = NULL;
>  
>  	return err;
>  }
>  
>  static int cx231xx_audio_fini(struct cx231xx *dev)
>  {
> +	unsigned long flags;
> +
>  	if (dev == NULL)
>  		return 0;
>  
> @@ -669,6 +687,16 @@ static int cx231xx_audio_fini(struct cx231xx *dev)
>  		return 0;
>  	}
>  
> +	/*
> +	 * Block new trigger work before draining already queued work.
> +	 * cancel_work_sync() may sleep, so it must run after dropping slock.
> +	 */
> +	spin_lock_irqsave(&dev->adev.slock, flags);
> +	dev->adev.teardown = true;
> +	spin_unlock_irqrestore(&dev->adev.slock, flags);
> +
> +	cancel_work_sync(&dev->wq_trigger);

If I am not mistaken, it should be enough to use disable_work_sync() instead of
cancel_work_sync(): this disables the workqueue as well, preventing new work from
being queued. That avoids all the fiddly 'teardown' bits.

Regards,

	Hans

> +
>  	if (dev->adev.sndcard) {
>  		snd_card_free_when_closed(dev->adev.sndcard);
>  		kfree(dev->adev.alt_max_pkt_size);
> diff --git a/drivers/media/usb/cx231xx/cx231xx.h b/drivers/media/usb/cx231xx/cx231xx.h
> index 19f5036a78d7..99c6a279944f 100644
> --- a/drivers/media/usb/cx231xx/cx231xx.h
> +++ b/drivers/media/usb/cx231xx/cx231xx.h
> @@ -418,6 +418,7 @@ struct cx231xx_audio {
>  	struct snd_card *sndcard;
>  
>  	int users, shutdown;
> +	bool teardown;		/* audio fini in progress; set under slock */
>  	/* locks */
>  	spinlock_t slock;
>  

