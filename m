Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209072;
	b=zEs9GJbX6cjw0xpA7KpzFrdcQK85j2dpUS6rYfHKyzF0NYndMVB3LxwA2ABGNfJTXiuR
	 bjsBJirL4WqQaZ6TyH9k2MWwwdQy6sA8pV8BvOPuujL7KLyzszGJD7e3kKOh4ypgIAKo3
	 QGZjyoCzM9idCWGsjHH3+jAxA+K6tVFEiFyXTiUlqkQ7gRxlWMUdUl10NzVIFMhQSxV2g
	 pQVYjXOIlZ1HQDruw86DEJxDglobjnSMj78mn5sCFe3y5jFXq2/gRhymWSccof5ElT7BV
	 GG2tNRYPvZPtmBHbTyh0u27x9yNuwKSHzNNYB5IH4xdOhb1egbpuDmlhxLBJF+90ztQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+np9H5/WW8k79AQmUZmL7dcf2+nLZb8rZqIqDwgON38=;
	b=YOXyFOi/mL6OikEyqvY9Czt4tk7NduHU7tIP6L+9PJEKciXu3PsHdJ6CDSCgtIQ17Wn5
	 iD79+nf2Rxkv0fvP8V+W/666kCsbLHfFVRB7QoY/n38lMkBEWLPQ5GfA/rmf7a4LtIMzt
	 sfgxvTxZq3RZPE+E/RsxO7MK7rBXBFwq9Ey0lhkvZ7mkudWcCVEyUdWqcyvs/5oriochX
	 R0IqLTPPBuQZXyZzsxnY7D5kaAIsqbriiML6TA/c8CphkvglM0Vd1IxrxUHFQ1QuFBqGV
	 2KzhfibEujz4deV6vLT42f2jssBSlAdZPeUVei7nWuVmdp4XHNYez01fEJlAg2c8PMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsg+HPNG;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DA606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 07:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B2DA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsg+HPNG
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36ff9c9da34so984045eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 23:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794209071; x=1794813871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+np9H5/WW8k79AQmUZmL7dcf2+nLZb8rZqIqDwgON38=;
        b=Nsg+HPNGdxtdTZzq3djvWYmBMw+t2hulucj9xOOp3AWvjM6rcN7YNAWhvsNBCh1Knd
         5o9871JBsIP/mVo7h9e1K/ZiMLBbIzAL+xbNaet8zL0A6fVksbo7kfCMekOWMoeooI91
         Z7SjW2/BgWrKmJ/K+oRfYzhWl/Ak1bDo5rGlYFd842whNqAqs3y019dEmg/Edzsgm/Wj
         FNZs6d54wd5Z8/8r/WxihyDBQsx5SASmVdBkDyDumMExC9qDHZPLCQAx+NaIKaUunIQE
         Yww0TstAtTL6c/oGlasgOqlznGlFf3Pay7V8F2D7jkaALRtwkEFjiujHDv1rGYh7JbKT
         5abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794209071; x=1794813871;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+np9H5/WW8k79AQmUZmL7dcf2+nLZb8rZqIqDwgON38=;
        b=b34VJETrPfw/LHxGi9lp2Jf9QoQu3PAzxT8aKzs8EpSKtXaoFMFlDSLHAWQbzDyS3B
         R4P7njWu81c9z0oXJNn28bo/XHVrET4ow7VpzU85m+7K9eDZDWf3Rj7wJ0L+IW60SPpr
         7zOswH/rTpRWwjW4XWzvV1cuC6DpLlGwgIF8do7d7UsrxUwL7hkCUeIiYdcPPs4UJwib
         00eTaatr/eJgQwQjOpFDyEbdWAywjb9oFYcpgzq9cTu8iue5DRvx40PO7fjjesjYSwgy
         IYMAKXThhbpFBVA1K6kWx3CBAzp2pELmXDpI84p3DoV4CpFZynMOx8PG1NhHfrqgVIoz
         MUJA==
X-Forwarded-Encrypted: i=1; AL+hErG5sVNtAcTKnNt4TL4hAMcVoJ+YyoV3TT2iZF03+I2+ehbiTOzE4Tow6YZaUVlXz893reb4CUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0wwAXKivfWYbnAMn2POBWO3azz/cK8i1/WpY0WOx+15Sw7sHr
	AUf73lEZl0j57O+XxBI9vea3czZ9ujd8D4uQVPLe7GBFjMnzBPDWh1lN
X-Gm-Gg: AYBFou2rBIkU6XD+8nsU2YRRkLcZp8PRwAQXN3XVgN5Mi2IKOLGC54+cY7DzfsBK/TV
	mMjdHA8BDD0MoRZQEYgbHUvhV3DTKowCC9CTDG4S6EVjQhARA3yCduFMOJFQ+T6ODrrGMFzkhN6
	GrSndY8t66g3Fia68f9SBB/mSfWns+rXYNsTLF2SlHVDx96neCUfxsRyKt7O9vc6x7qaCizSnRe
	ufadEZe/DFApG/8J68UVTZ9nmxM0KH5hFD5h+bLm59EQYbHmt2kNTGgulwMjGymO7a1EIAq1FeN
	aJeLwPrsM1AZuCvAiKn8meEcP7smHbXrM9yo0LRRGsVjhD8zE1ms3Mu4AD12lghaQEEOne9MxKc
	+eE7RZwhC8vvGQnmSOC19rT2YEaRQa9GbhhfGmo4/qQCADMbOOdUzDaR5bUXWHCHT9QxRij4GTS
	fYN46mOpUm383B2PdTChrD4DlLlXruVphSlw75+W6gbWwLc1SxT3M25T8gX1ZXLNib0dWqhlsKM
	8iwNFn0B6Ky9fISQ+cj6YSX5imfUuKHc1Jw4SNB1vgEY5Z7E5e+JbHWbLimc1V3HDPa199jXyCZ
	Gp5uAEC6sx9vqT2X5XxUOlwEdJp2dUxoS8dcCbJiR4q21tga2wptQooRtrJ8wLEfvW+V
X-Received: by 2002:a05:7300:f788:b0:35c:f667:8b9a with SMTP id 5a478bee46e88-37256038776mr5838575eec.6.1794209071027;
        Sun, 08 Nov 2026 23:24:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db8bbsm9950069eec.22.2026.11.08.23.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:24:30 -0800 (PST)
Date: Sun, 8 Nov 2026 23:24:27 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dudl@cypress.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: cyapa - fix runtime PM leak in
 cyapa_update_rt_suspend_scanrate()
Message-ID: <avF1HqGfA-82_Q46@google.com>
References: <20260916185015.2093520-1-vulab@iscas.ac.cn>
 <aqwD1o6J4svIevWW@google.com>
 <1794120347.2701234.vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1794120347.2701234.vulab@iscas.ac.cn>

On Sun, Nov 08, 2026 at 06:45:47AM +0000, Wentao Liang wrote:
> Hi Dmitry,
> 
> Sorry for the very late reply.
> 
> It does not have to be the "sync" variant.  I used
> pm_runtime_put_sync_autosuspend() only to mirror the normal flow of the
> same function and the other runtime PM call sites in cyapa.c, but there
> is nothing on this path that needs a synchronous transition: no device
> state has been changed yet, both put variants mark the device busy
> first, and cyapa_start_runtime() sets a 2 s autosuspend delay, so either
> of them would only arm the autosuspend timer before the store returns.
> v2 uses pm_runtime_put_autosuspend(), the counterpart of
> pm_runtime_get_sync() for devices that use autosuspend.
> 
> For the record on how the patch was produced: the candidate came from
> static analysis tooling, and DeepSeek and GPT-6.1 Sol were used to audit
> it and to help write the change.  I reviewed the result and I am
> responsible for it.  v2 is build-tested only: it compiles cleanly on
> x86-64 with CONFIG_MOUSE_CYAPA=y, including W=1, and passes checkpatch.
> I have no Cypress trackpad to test it on.
> 
> Thanks,
> Wentao
> 
> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Wentao Liang <vulab@iscas.ac.cn>
> Date: Sun, 8 Nov 2026 06:45:47 +0000
> Subject: [PATCH v2] Input: cyapa - fix runtime PM leak in cyapa_update_rt_suspend_scanrate()
> 
> pm_runtime_get_sync() unconditionally increments the runtime PM usage
> counter. If mutex_lock_interruptible() is interrupted, the function
> returns without dropping that reference, so the usage count stays
> elevated for as long as the driver is bound and the device can no longer
> be autosuspended. Drop the reference on the error path.
> 
> Use pm_runtime_put_autosuspend() rather than the synchronous variant
> there: nothing has been done to the device on this path, so there is
> nothing to wait for, and with the 2 s autosuspend delay the driver
> configures the put only arms the autosuspend timer instead of suspending
> the device.
> 
> Fixes: 672865080a8f ("Input: cyapa - add runtime power management support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied, thank you.

-- 
Dmitry
