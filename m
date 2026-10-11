Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985B363086
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738768; cv=none; b=gsIwHHIaM3k5s36LVQ7r9okNzIhXmRHWTktpxMcHw6qdTta/yUHPsnq0pkYfp+9WU+hL/QWOH+Q5bM0pqDAXzIX5jRHtYU2SrtnCXVlCn6reQvEM6g7IpdGIgzCJnOsvPRNjyXzC8GSZbDDPRhKvdHe44W+FaxGxCm5lzYq9VkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738768; c=relaxed/simple;
	bh=z+1ZpdTDW56EA/XM7p5CM05JDe5+3pamXAxQ9H7t6HI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQb7GAesh8WpyZBqmaZX5jrVj1sTJw2rYazIa0XLJEq9vcGVgWqMhoozjmnENpD13YsgKluxEqjftxXmLYRGFR5s7OtkLMywx3y1MQPlwBXBBaX9DjLKEQYq8jk+jNsZiMUJzmlYCPKMeLI4oT67FRxzn5I6LhXCWgNOV1/8CEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBvIBoqp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBvIBoqp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-486e8faff03so467046f8f.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791738763; x=1792343563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=79Z91gLy0Qj3P7l5DuL+kEPlg9n1xATGDeuftWENmqA=;
        b=KBvIBoqpgZk02w21878+tfHeJmiq0VjXiM92RtI3bPmRrKwvVNPJNBigcoHdSRo4nV
         ELH86d6RzhcPKCmixanljp8H94jpIdF1wvnxXDyXjG2Da7HLGgCdGS2MGVI4FxB2RAvP
         GsxzJ38erhXWyYn32iwiB71KI4VCFVur3mELk4ty++MNobi1zUaonhr51ilvpI008Zrm
         ToKmC3+MAt/VUPaqosjo60CBazW2ubwJRmVEriS1pq4Qp0fRdPyckwDsrLOOXeY9pckS
         Ynd+n9cac8iLki84QTHhiK3WkDO5niWcHOgGKfMuRbneWb1m4rBS8dOGN0+PeljZf/jd
         cVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791738763; x=1792343563;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79Z91gLy0Qj3P7l5DuL+kEPlg9n1xATGDeuftWENmqA=;
        b=oUaq1rQdcTvAVWU5ZH5+H73IoAzjmm9FQwho8ARMMlCFCRDawIVtR3Xpym8ALAbje1
         rY77onTncFo0wtaOrSbrL//W31L3K2UgCWqz+wLEY3ySt5yTh8HO7bek2uz5qij+f+wa
         ECEQ336yBCzZdhGgbQhxcoZaG6VrOmxEQJjiS/9AoRGs/ShNxADrMGDLPGFFxZqXUgoG
         1Z5SLfKDlGFY8022KBUSfonn0DqRf7okPrKbsRKBrlYeL2k8UYQpJZLWhoOBlTBR6kYt
         Eod7WPKfyKHDP3dGjrexvSnARDfZxK2arjFbomHt7ItSbN3Tio5TCgSRnHqhU0VT4jbM
         6NDg==
X-Forwarded-Encrypted: i=1; AKwUvByKEBuDiocTZ2ra4wVDlqUXWkyvojWg2h2R/GlxWUENpuck6CNlKscxDqGGgbFRHxSlDoIHqCs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVV/6PsmSyUnkkmsEKQ7SrwBw1p611q8Pk60sEUxEUuybE5I3X
	B5Ht0QUSnHretmEU1/9Cb3rJ3ZHse2kbwX31UVQyeH301st64PYQDvQ1
X-Gm-Gg: AYBFou0Yh9nmHSq1C/35d2k77+sPUP72+1xV/JgLrKYkGSgQLwwBbpdBmJNK9+ThDVm
	ateDPmQZAgeV/NMhQe0aiOvw6zGFkgqbqXI3NpaOl75uAJnTk5m7Lqpkiq2KOXbZ1twchm8aUzt
	HxQLTjcmWroz4fN1RkEMbXr8NikMrE+aIrsXqiaTuvKSkOwBxm4hJFhiVZNFLsYDsHy3ZZMSV5T
	4yLp+ucc+x7RmoK4mrbj1tG/Hjpy8mob9zWgMwcUvZwPD/HyUO9CcqV2QMaAEtE/KKttkNF8h7X
	Xb41OouQ+ZEPx1j6lyt3phkCyGAtU3wBuQV5xCB1jSOeS9QpK5qJ3PJsQ8DH25PDl4ss5R2tBnR
	LJ6C2zmMoQkAGx5WqanS+EXt3JzLUCN0yYQSya9gBHSo7FejK2kbIvRzDf4MCExOoNgnwat+FUr
	cSzaDztI5Dg1KS88I4aCJVeiOz1iwbyKG5BoOl+EXyBy6Lrdb+Ckjvm0CizujM0csJkiRFx+pWP
	MBZRFaGXiDAm9/G6P7Mnwy+i2Xdf006fjXR9j8c5oGg24kwFeQ0BppnyradA5FZ6UG+FdT2BP1N
	4ZiGCHWH9QJQ4jRIlsVFpeuXjo/x0nMHjqa4VHHwMkyOs5eddi33C8vp+JuQuv514y19fA+6wau
	7RuaFEKhQHerGpLPXW1zsyDtG4+W/scQ=
X-Received: by 2002:a05:6000:184e:b0:48b:10af:f85c with SMTP id ffacd0b85a97d-48dbaceba34mr11528014f8f.37.1791738763113;
        Sun, 11 Oct 2026 10:12:43 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db97ce3aasm15337433f8f.21.2026.10.11.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 10:12:42 -0700 (PDT)
Date: Sun, 11 Oct 2026 19:12:40 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261011191240.5a2ba4f7@systembl0wer>
In-Reply-To: <20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com>
References: <20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 17:53:01 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>  drivers/iio/gyro/mpu3050-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Sashiko review came back and the issue doesn't seem so
straight-forward. I'll probably introduce a local pointer
and then assign it to the mpu3050 data struct.

Attaching Sashiko review below.

> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 07c0f9011c63..096fd0dc608e 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1260,6 +1260,8 @@ int mpu3050_common_probe(struct device *dev,
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> +	if (mpu3050->trig)
> +		iio_trigger_unregister(mpu3050->trig);


Does this unconditionally unregister a trigger that may not have been
successfully registered?

If mpu3050_trigger_probe() fails (for example, if request_threaded_irq()
fails), mpu3050->trig is allocated via devm_iio_trigger_alloc() but it will
never have successfully completed iio_trigger_register().

mpu3050_common_probe() catches that error, logs "failed to register trigger",
and continues. If a subsequent step like iio_device_register() fails, this
code will call iio_trigger_unregister() on the uninitialized trigger.

Because the trigger was never registered via iio_trigger_register(),
iio_trigger_unregister() will call device_del() on a device that was never
added, and ida_free() on an unallocated ID, which can lead to a crash.

>  	if (irq)
>  		free_irq(mpu3050->irq, mpu3050->trig);
>  	iio_triggered_buffer_cleanup(indio_dev);
> @@ -1278,6 +1280,8 @@ void mpu3050_common_remove(struct device *dev)
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> +	if (mpu3050->trig)
> +		iio_trigger_unregister(mpu3050->trig);

Can this cause a kernel crash during normal driver teardown if the trigger
probe originally failed?

Similar to the probe error path above, if mpu3050_trigger_probe() failed
during initialization, mpu3050->trig is left allocated but unregistered.

Calling iio_trigger_unregister() here on that uninitialized trigger will
cause the same teardown issues during driver removal.

-- 
Kind regards,
Joshua Crofts
