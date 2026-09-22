Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403D2D12F3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092198; cv=pass; b=qNXN5LV+5a5hnZufcmEkCKAFhfUclnhfJTu/SiXf6KpanQ2hbBtC7gERv5DbFAi6q1n4Jt6pgSvp5emU2+LftC6hcZA/YlLfwzh6N8GYZqLPvpqR0L0JaxVFxoB4BMN4IQDWM2TWNh09i/hfhsoOWkkVaS7GJeDZpfavAA8s9vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092198; c=relaxed/simple;
	bh=FwvYiaDcG7fL1f29jUItXT2GNsF0KQa+Oubzhul7ezg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeFmSaxgxjbM3Y+rz0PkHYBBujVUdiN9QhcIIOXXhUDavVlxwggBml4Xb2Eqn6dVucSLRg1+bhnSVzfxvqHaDNfQ7dorIk38AslGfxYv49sqlKRrOkius6o85NerGkUOaTgfXzgWaVa7YFJEODwYeApgXkRhlO8Nq4xezW04LN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=BgxwzVEb; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="BgxwzVEb"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4c4bf3defecso26351b6e.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790092195; cv=none;
        d=google.com; s=arc-20260327;
        b=S4qozllEoRnFK/d1DT5YSrQ10ETaTnDtSTYdMnghte1GSPW9//zkRlIS5t01PtDXyl
         9q7FIBxXpC4wKECAo4Q8UrqFUEBKmVVGB7YKH3SfQD8uV38lswLLI2cZzzYfZE5TbcjX
         OXEqNS9FqTkIFY6GaUAPV6W+0KinPbAHzdmzPXQqjpdZRskcoVZ0t8GaGDmFDkSLGKTf
         lciAV6X5OyFWncDj65iVHpaYEQwaoPaE8IH0uSIfyhzrGX4X8Zm0fRWJ0/Gh3VtAXXfE
         1JM8CdwbfrlVZ8yLkw6Qfv9YXlg6Yrcd7synn569nPTyNOMEQcvb66eYfdIgPZpTpDm4
         QjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+IB+UJijWjaTnFVpSDyUcRlyFG+GunEChS+weWwWm14=;
        fh=fWZ7A/cc9mGbfYs7uL8f9LOQu+jw7ixWdwhBcZ1d/VA=;
        b=tDlYHdDtd7q3kONEfjWCO01ZkBSSESOS2KdB0TEOGMmLI7oyahewWL2WWs/gBMVwMm
         3jgMLwtcguCwvWP7ABJKhAQserl+QuhzsCUf8ptuPoN9CK9O42UY/vcasU+iO1aB04qF
         86K/IQHLU3ctHXOp78qwtmWWNbdiSMV96pjUlYNzLy1gmvQa7LCjt4389SF5HdgyC+7O
         0FQdJJ6WTTAXthSgtju8yEnZxI7bJvwPbEGiuGl+IJIAtgvvi8zNjEHDflmRFI87mGKE
         haP9ytcwAX+x/GnutKmp7Stm9rDkFADfbWuG5/A0xkmgFr9RGlVdBHV08ysQttcWqmoN
         Mtkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1790092195; x=1790696995; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IB+UJijWjaTnFVpSDyUcRlyFG+GunEChS+weWwWm14=;
        b=BgxwzVEblWiqw4mRVWVmI4pnlSxui5x0Bf2OsqGawV5jibxnZZTyjI4MjWPGo2rORP
         UT6n/LXhCEKVuxz8IonyoR1PKSb5yUCKUVvf4DGwH6ODiisG6cGvoZi/pu155G+mFP34
         oPSxUs//AqOi3kpCEhwsxxKi+gjRBPzCP6Ana/VnUzg7JLEY98J6+DsmqNCyE5As9b07
         zioKxS79+XJ1i1Jw2TTEd+bTdobHk1YebdEh1JY/ku0Y72fAbnSF+hT5hbgVAPei9omU
         3pjrJOaLYHmx8r/Q3Sv4TC6ewMkMQF9bysJadkgmINToJbiVvoLNJRONum13BQlWHFoF
         XaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092195; x=1790696995;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+IB+UJijWjaTnFVpSDyUcRlyFG+GunEChS+weWwWm14=;
        b=EsnPTyjF0OZe2AQCVEbX3dxuRW6PpIaSS9m77fNI+xhvgI4bz+8HZhYuQhooosBs8L
         Xg9hIFMTWgpJNWP87Po2fWhWva2xSB18tKD1aodmlSELVlinUQQFnZmRG6gJGKXTetLJ
         OVv3yHM+DcI5jHdTAGBwp8u5hkFXQJXtsRCRI/LKBpaelco9MwEn5kV+HqVVUgCQJaxm
         H71K2tIpBfumwGtfPWzenxzzvO6KKGdiGEyFonBK4kgAjr6luptaL21Cc74YwKVugLsq
         Fe/aKWw7rDRojNqApCGy+mE+0zV3vTogOYYFgD2zR61DnE2ZcMhmwpCc0qksk+8YQ+lZ
         ihUg==
X-Forwarded-Encrypted: i=1; AKwUvBxACNpwpuEhMkIVI6nJ9V/00VyVM91dChNy4/KqJancAq2Zc0DmD9oAL+PcBk6k/8wjgdesFNc=@vger.kernel.org
X-Gm-Message-State: AFuF++mTnhGYb5zyvLWIrF+ODmnSBMHumaG/2F+vu557EnaL3eFMy26A
	4ulxjT23Arc1hm8MKMcBGiVTFQyH4QUyVQsgE1WvIT/My2mnbhYGl1PQWt2vbO1C3X6NfsfjV02
	8N6dESJD8W1qhqTi774JQ8CMdKmkdUmNjv9uY+OYHaw==
X-Gm-Gg: AYBFou2/NBaHMP+okkTNcgZeyRlNkh0ZVX+qGGjUjsJ5rVwX8bVgda3xKITEL7U2Z+S
	TvWtivPk7ANDIKnuie6jYjswbUVyVBQO1mivwqCdS/v+GWGxotX6YtC2/WgGzCc4NN/duvqbeZO
	fjjHkAmRCR+UAbbWmd2Go4oVjUVVniVbaq9jtbXBW1H6LbN3RphGIp/cI9G77hNBOGVmNhzCis/
	8cbpee6LSvY52xtaLrjZXo4mpjbsu6Nn6sOkuoWMR6SFEjBE81gaQEY4ylaEtEr7l1g5PLaZIuh
	/KymGLKZQeQVxpc4IcGpLfhZsZMU6afPEuMxmM4OcXiIrJ7VFkTPRvaWQTeOI5eug5DiRIo/7LM
	C7lc6DhLr2nHkcefp3sSWZWr1Oqvshz1dBhJ7Z+qO9EdwU8tLJWLAh2Q6sxALFxwwO9LfeWo=
X-Received: by 2002:a05:6820:4b91:b0:6cd:3ffc:e32a with SMTP id
 006d021491bc7-6cd3ffcea03mr10302175eaf.72.1790092195059; Tue, 22 Sep 2026
 08:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922084009.506362-1-lgs201920130244@gmail.com>
In-Reply-To: <20260922084009.506362-1-lgs201920130244@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 22 Sep 2026 16:49:38 +0100
X-Gm-Features: AcwNN1UYho_M2TCkxcYs2QRUgoK-S9ENUK4v-9idaeTrzc5fL3QAaoHR4mTs8VA
Message-ID: <CAPY8ntD6kWi7Q57oL43SLe37szXpptdBXs6cs+vxVehA0eJPjg@mail.gmail.com>
Subject: Re: [PATCH v2] media: i2c: ov5647: fix power cleanup on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Guangshuo

On Tue, 22 Sept 2026 at 09:40, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> ov5647_remove() disables runtime PM without powering off the sensor if
> it is still runtime active. pm_runtime_disable() does not invoke the
> runtime suspend callback, so the sensor can remain powered on.
>
> If the device is not already runtime suspended, call ov5647_power_off()
> and mark the runtime PM state as suspended.
>
> This issue was found by manual code inspection.
>
> Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
> v2 :
>   - Move pm_runtime_set_suspended() into the conditional so it is only
>     called when the sensor is explicitly powered off.
>
>  drivers/media/i2c/ov5647.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> index 3facf92b3841..3b3e5653a0c6 100644
> --- a/drivers/media/i2c/ov5647.c
> +++ b/drivers/media/i2c/ov5647.c
> @@ -1271,6 +1271,10 @@ static void ov5647_remove(struct i2c_client *client)
>         v4l2_ctrl_handler_free(&sensor->ctrls);
>         v4l2_device_unregister_subdev(sd);
>         pm_runtime_disable(&client->dev);
> +       if (!pm_runtime_status_suspended(&client->dev)) {
> +               ov5647_power_off(&client->dev);
> +               pm_runtime_set_suspended(&client->dev);
> +       }
>  }
>
>  static const struct dev_pm_ops ov5647_pm_ops = {
> --
> 2.43.0
>
