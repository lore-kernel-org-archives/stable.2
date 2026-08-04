Received: from va-2-49.ptr.blmpb.com (va-2-49.ptr.blmpb.com [209.127.231.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3C3E8351
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874022; cv=none; b=a6obcuUiAvqtVovUrmm8BZy0Awu6kQTJGYt0XZur4RQUrB7pprYWnicCRlNu+pd6dr8W9TLAqF1ZRoitWtHnUbQ6i9ene6J1vnz4w6+EHyPQ+LWFm7lPupPkxks+pRRFJezsQ1OxSg9l/FpBWSQ3rrocUAEYGfCvQ2Vc0YqeDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874022; c=relaxed/simple;
	bh=AWqkZ/frT8Ig8rD0d5amHm7Rww4cuJ/rYWq8Ww3xRH8=;
	h=To:Date:Content-Type:Mime-Version:Content-Disposition:Cc:
	 In-Reply-To:References:From:Subject:Message-Id; b=RI1c2GwjRzBbAMPW1IhsErSyKgURCCJg8KyVukoG1xJLhlyj0LCxqYwtBPd/S0lOOvlU6bLTtFb+fgZ2VnYIL4InvZbuTy7GymLMSdd4yjVWl58c6Y5ZwaUUsdaag5a/FqTyBTKAVJOLdGAHgoylKHNeqUJYMkcKGCI4SP/KjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=gKOp3Dfh; arc=none smtp.client-ip=209.127.231.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="gKOp3Dfh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1785874015; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=g2+Kq/2ATNpIZmZ2LFcdbtA0odwTHd3mykJnHCsnUyA=;
 b=gKOp3DfhuTuNHuRMxc712H3hwGilUDyt1bjoSOtZsL7mnt5OTRtynmvN6PFejKvtB7fXrD
 ogd5Jq5wU588Hg3oM2tAjpawyV+xlMD1lTCqCecLyCEEA41k1FSjzn/im78QR1gdUNjj7S
 2joaKEigYcHiKpXTedWV6lCfnAwBz7Bhelc0qDLkfbTzs2Fp3u52FTVa0VQln3Mj5QFq/8
 7qpEANNmwnjqCFLOqCCNfg3pwbvciI74D0wvw7r7J1JP1AaPPjmoZXhp8j4tYd3abxSeeo
 /5zilyZDu8wn0xDXk3gWUNYKHtt8Wi1DPQL1hnF8ArwaHnDMRm7ObsulaCdLUw==
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a72465d+0ab012+vger.kernel.org+me@cherr.cc>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, 
	"Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	"Zhouwang Huang" <honjow311@gmail.com>
Date: Wed, 5 Aug 2026 04:06:50 +0800
Received: from pve ([111.42.148.100]) by smtp.feishu.cn with ESMTPS; Wed, 05 Aug 2026 04:06:52 +0800
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Disposition: inline
Cc: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
In-Reply-To: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc>
References: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc>
Content-Transfer-Encoding: 7bit
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: Re: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
Message-Id: <anJGWjlmRxNMoVLG@pve>

On 2026-08-04 17:50, Shengzhuo Wei wrote:
> ---
>  drivers/hid/hid-oxp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 20a54f337220dc2aee3483a14d542b66c487bd60..abd622ff1b26b312ad9c8a4375822832f8371533 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -1501,14 +1501,14 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
>  	drvdata.gamepad_mode = OXP_GP_MODE_XINPUT;
>  	drvdata.rumble_intensity = 5;
>  
> -	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> -	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
> -
>  	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
>  	if (ret)
>  		return dev_err_probe(&hdev->dev, ret,
>  				     "Failed to attach configuration attributes\n");
>  
> +	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> +	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
> +
>  	return 0;
>  }
>  
> @@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
>  
>  static void oxp_hid_remove(struct hid_device *hdev)
>  {
> -	cancel_delayed_work(&drvdata.oxp_rgb_queue);
> -	cancel_delayed_work(&drvdata.oxp_btn_queue);
> -	cancel_delayed_work(&drvdata.oxp_mcu_init);
> +	disable_delayed_work_sync(&drvdata.oxp_rgb_queue);
> +	disable_delayed_work_sync(&drvdata.oxp_btn_queue);
> +	disable_delayed_work_sync(&drvdata.oxp_mcu_init);
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  }
> 
> ---

Hi Dmitry,

Thanks again for the v1 review. Sashiko's v2 review raised two points I
want to act on:

1. "Uninitialized work struct access during early raw events" -- agreed.
   v2 moved INIT_DELAYED_WORK(&drvdata.oxp_mcu_init) to the end of
   oxp_cfg_probe(), widening the window in which an early status report
   could mod_delayed_work() a not-yet-initialized (zeroed) work. I'll
   fix this in v3 by keeping INIT_DELAYED_WORK() before
   devm_device_add_group() and moving only the mod_delayed_work() after
   it: the work is then initialized before any raw event can arm it,
   while a probe failure still can't leave it armed.

2. "Global workqueues permanently disabled on inert interface removal."
   The driver keeps all state in a single static global drvdata, and
   module_hid_driver() binds it to every interface of the device, so
   oxp_hid_remove() runs when any interface is unbound. With
   disable_delayed_work_sync() and no enable_delayed_work() anywhere,
   unbinding an inert interface disables the works for the still-bound
   gamepad interface. cancel_delayed_work_sync() (v1) re-enabled them,
   so it didn't have this side effect.

   This looks like a symptom of the static-global-drvdata issue rather
   than disable_delayed_work_sync() itself -- with per-device drvdata
   each interface would have its own works. Before I send v3, would you
   prefer to keep disable_delayed_work_sync() (and address the
   multi-interface case via the per-device drvdata refactor you
   mentioned as a separate patch), or go back to
   cancel_delayed_work_sync()? I'll hold v3 until I hear from you.

The remaining sashiko items look pre-existing and outside this fix.

Thanks,
Shengzhuo
