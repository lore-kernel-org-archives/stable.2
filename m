Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61E3DFC84
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914053; cv=none; b=IqM6WYUcHG7oVbNw4Qa9qUy4UDqBlI+ILW4favL0ZSU+QQgmPucxFnKy54v0c5CgfPZc/XdJTnqyOX0h+N+RkuCp3cuJcY6SLIRTOw2PsVBY7lox0CGXMCMjqmH5TAmyraMcwgPx7IUaT3rInZo58BGBzkLWFwvOMh89/c4j9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914053; c=relaxed/simple;
	bh=IqxAX4Aba2RzZgaK+dkv9qfFcI/tCUhgX96jbtXOiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=NVDxSkJB5ApR24XKreFMwDTXjm4WnJYQ3hKHG193u1LqLj3CCX5s68Th8YdjxJYq1E6OK9Zf1XnacpQlKf2XGqJE4meeiWVRcxWkHVHziD4boYCKL0nCp6geDxEPWtQ1ToQpljrKJu7HQJIVaAzA3DECBgIY44L33qW+gSF2wi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A0BciSY1; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A0BciSY1"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260805071402euoutp02d15f232454a162ecf4b7b44b64d82cdf~I11v0vgNq1261112611euoutp02c
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:14:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260805071402euoutp02d15f232454a162ecf4b7b44b64d82cdf~I11v0vgNq1261112611euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785914042;
	bh=0eNQKrDF9VmPUJBv/Q/lWaoxWyqj2UAM/GEwIxIsWCw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=A0BciSY1bB+sfU/Q5QkjzLIWOuP+PDrKnZ2hr0s8mlPYVlEZmSlRZ8wCwRnWCKMZ7
	 H4PHVdawVxYniUJkMFwXl0bfpZxAJU1ScPub/vTsAXfNhVIvFITFf/I7+u349zlmIY
	 KU6x3wTdOMf09V3ezryN5jV7TAYowgDK5VV8HfNI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260805071401eucas1p1dfd928c7fce7a05a79bd360900777dc3~I11vhLnJg0615706157eucas1p1T;
	Wed,  5 Aug 2026 07:14:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260805071401eusmtip242c1de3d7fe9c3e9c4212fa00c1765ca~I11u8Y5hR0408204082eusmtip2s;
	Wed,  5 Aug 2026 07:14:01 +0000 (GMT)
Message-ID: <48bf9a04-a3ff-421f-8fe8-b65b8af0a2f7@samsung.com>
Date: Wed, 5 Aug 2026 09:14:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] media: s5p-mfc: use timer_shutdown_sync() for the
 self-rearming watchdog
To: Fan Wu <fanwu01@zju.edu.cn>, linux-media@vger.kernel.org
Cc: stable@vger.kernel.org, andrzej.hajda@intel.com, mchehab@kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260730071552.292905-1-fanwu01@zju.edu.cn>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260805071401eucas1p1dfd928c7fce7a05a79bd360900777dc3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260730071659eucas1p29e5e6fa1209da048bf1cec7fd821ef77
X-EPHeader: CA
X-CMS-RootMailID: 20260730071659eucas1p29e5e6fa1209da048bf1cec7fd821ef77
References: <CGME20260730071659eucas1p29e5e6fa1209da048bf1cec7fd821ef77@eucas1p2.samsung.com>
	<20260730071552.292905-1-fanwu01@zju.edu.cn>

On 30.07.2026 09:15, Fan Wu wrote:
> The MFC watchdog timer (s5p_mfc_watchdog) is self-rearming: every
> callback re-arms itself with add_timer() and, on a timeout, schedules
> watchdog_work. s5p_mfc_remove() tears this down with timer_delete_sync()
> followed by flush_work().
>
> timer_delete_sync() dequeues the timer and waits for a callback that is
> already running, but it does not prevent a subsequent re-arm. Because the
> watchdog callback re-arms via add_timer(), this is the wrong shutdown
> primitive: once the wait returns nothing guarantees a just-queued re-arm
> will not fire later, dereferencing dev (clock on/off, deinit_hw,
> load_firmware, init_hw) after video_unregister_device(), DMA teardown and
> s5p_mfc_final_pm() have run, a potential use-after-free.
>
> Use timer_shutdown_sync(), which puts the timer into a shutdown state so
> that any add_timer()/mod_timer() from the callback becomes a no-op and no
> later firing is possible. Switch flush_work() to cancel_work_sync() so any
> watchdog_work that was already queued before the timer was stopped is
> cancelled rather than allowed to run to completion against the torn-down
> device.
>
> This issue was found by an in-house static analysis tool. No runtime
> reproducer is available.
>
> Fixes: af9357467810 ("[media] MFC: Add MFC 5.1 V4L2 driver")
> Cc: stable@vger.kernel.org
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> index 32eb402d439c..03e7eac8d1f7 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> @@ -1474,8 +1474,8 @@ static void s5p_mfc_remove(struct platform_device *pdev)
>  	}
>  	mutex_unlock(&dev->mfc_mutex);
>  
> -	timer_delete_sync(&dev->watchdog_timer);
> -	flush_work(&dev->watchdog_work);
> +	timer_shutdown_sync(&dev->watchdog_timer);
> +	cancel_work_sync(&dev->watchdog_work);
>  
>  	video_unregister_device(dev->vfd_enc);
>  	video_unregister_device(dev->vfd_dec);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

