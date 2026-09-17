Received: from mail-qk2-f37.google.com (mail-qk2-f37.google.com [74.125.230.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364952B1CE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.229
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651676; cv=pass; b=s0xktExVOvJ7IbbpMv4kpZiVmLUWGnqA3nJHNdtVh02XZ1c9RJ0Fn1wNf/BeMlOFZwla7clPz+6AXl5x5CiBPhaJf84JSSaIpXHCslFtPukNGA7H6XHXxyLTeRBuzyAbj2dlmxgDOvTrubJPze+XSos1KFThCdKeayCAZizIeP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651676; c=relaxed/simple;
	bh=TXtU25lOH5dMtACZ7iziOB2oxE4cZXtJfR9DIYvkgR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huoeGr+zjeW+TakIKb/orw/ll4u2dH29BJ7ZecvDrxFzf9IOUm5n0RkY8dfiKlfWJUkB9OM3uCX5VpBtY18bXu7lfEem3HpO2TQlXEXoHyo25Sjcl5AbBjuY7Meb18TrRX/SmDty72+yXyBUHryckn4LuUGnvjBvLtAjpBVUuBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Va8wfZDc; arc=pass smtp.client-ip=74.125.230.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Va8wfZDc"
Received: by mail-qk2-f37.google.com with SMTP id af79cd13be357-93910cc46c8so59311885a.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789651667; cv=none;
        d=google.com; s=arc-20260327;
        b=nCIODt52XenTJ0FP4IF089PKBRCUhi146ukv4y+ACrTlqR8vJPLNdwmwXXRzxYgS3y
         +JPidLvnv9I4RpwjVf/nt6bxXRKo091plSh7D3RLnRg82I5WMEnOE2G23p9ahjHmqRbc
         BufsCoajKjXhxJPGaXrzJ7pUu9Q/iLecUQaZxfg5CPkAMkBpoBW50REULyfi8p82NQT2
         jTYcp5pyQRHFVGYCfIsD2FnbioCA2MEcUdFtGBsSp2vjk7DdlV0YQS4yn2BsFvXeWegT
         S8qz7DGpexZQfRvbrTPCNai7gLbApmgfdYy3iYg6pN/RkG4dWMyUC3ADj8gAWE5qSX4F
         ZtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BAW6djXECzYrmSVVgeAoFqiFa+eST1RRqM7bt/yc2VY=;
        fh=t1jJ0AtONtrHRHMnisR/17+2uJ9jxZo3sepxSFs9VCM=;
        b=ZnxxXyJ0Mt0WtiLonh8S9Im2CljN8CvrBUrLqpxfqttkCkCrC8jHjFA6E9qoLJn0IT
         Lpw70jhw3UA/OpyjzCwJJGffiz/dQRMqyeVBnPd8OP7tPsYL5cucKEms+rk7/PbaoDML
         oX41uD83i313llpkcnJsGD8RI97zbSlnBb+RzwIgojA1Ujcy4ilqLdRH+bkVDj2EBwJj
         8gGhRHyhDlJbIcs8ZOUolBFNv7mz2bfR4X8v8bClSQoPVgT9acp1gkimrdlHTjMiV4L1
         v/1HPf5RwYFGCldJa0kgiVAEhXJT9jZM9qAWjc41w/Fl2/9BqTwNW/dOJux+zOQdnakw
         FG0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1789651667; x=1790256467; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAW6djXECzYrmSVVgeAoFqiFa+eST1RRqM7bt/yc2VY=;
        b=Va8wfZDcFdgq5TMDukKEUtut82zznutnHHSqL/nTai4Lixf+OoKnnVWT9hpz8X5ZGm
         pXwI/qhCWChNc8Zm0wqBDkRGtZbzgQqyF1fIWUu3t4dxdJ+wky2d+bFpPc1BnbmtDRGW
         txgCfX2fQpdg9iVF3vU2SNWG90uXd4iIf49QdlkYnIH4cw+f27QvY8MV2XoQdPTX2E1B
         ESj+jKWN3h37kaN1INYNXC+aGUKmD7BdB+GBkLjPaxTv8aCAH1yfZZ3hty+dVpEYHZsl
         xmKTz7BOMO9P7fTs4lPeEhjznS3yXKc+/CcOsO2/KdYApjWPfqFIkGmAnVeiFyTeYzRa
         6Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651667; x=1790256467;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BAW6djXECzYrmSVVgeAoFqiFa+eST1RRqM7bt/yc2VY=;
        b=EDrIgKNsVgvXx8Lhizdo3dvu2CsrE4ePpiSjr9+d5T9zLbxsEtwMTVPfzqVWOACt5z
         iRMBraq5avZEPgCn/QgdQDvlud3R9XGF3tJRCr6PlJxE5eQNKArfm2XHR3Itxnji3Qeg
         HxLloDq1RlepY5tODkAYJEn/MGqMtfD8Qqy/bZOHSs5KIiBc4GEGk7zhb2xIcqQ9UmO9
         0lxEuz4N62eQXg+yMRT1uwDVjZ+Vn5I3ZrCVj426U8FAJXutr4mB3uJ6VVQDtpLms1jH
         BraPmg7U8+/8QAVxauFPMufGuKijrZdD/6G0tM+5LGd8/jc1EV0CHRSFNyD9JluJ/pMK
         V9Mg==
X-Forwarded-Encrypted: i=1; AKwUvBwgAEUVkqBR74NLKEQDQq+ujGpFk5LMBvrB7X+n2Rc7LAuSMF5MdsryPucSj0+xor4hMKHeq7s=@vger.kernel.org
X-Gm-Message-State: AFuF++ksu0IW6NnJy2mpJy0rbECQtjYqJxptvRbTqsj9L2ULk7KnQPhs
	tkDSQjSku8cn1JJkIFoLcJXddZ2NDufQ6kuVhLwAMY8sQcbALuJDkCWcQn8qa1Lav4RoXtuYU1T
	vYIsS1/u123Bg48ShTiDSneaOknCNnl9x/wQ6gRFc6w==
X-Gm-Gg: AYBFou2BPwGTWpqPeNRG4uTD7gU82A7uyqVAlcK3Phkvmp6unUVRHomT7fMZaHmj3Ja
	igME4EbXyszbvKJBr0F/A/7DyX4xEBQfOzrvP8VMUu4Cykkfs2M+ulsl/Mdh6vLtqX95e0aloQ1
	oLZqYKziJoZaOV30AO4Rc2dqcI6avkFUsUcPkRewYxrmRPNZ6C+dtduq1h6Dshhbo6eT1xjngm6
	iqbOnsT0OndiJ77/07X8Sn1J/GScoB1sQHu9Eer9MvzJlN0baMYOTQC+iIT7DbGLqtSVx5XAkdQ
	LD43wgCNSMhnfB0ixx2Pi7u/8nIbpQmWehtDK2k4Zpp/qnV5Jx6JxXZjdE0SePVxNX8wt6HVUjL
	iAsMQRd9W3nWRzRVYjUTdPAneZa5LWmboIXhzFaBerlctBipHl1myRjxNoN+5avFEPDt/qIM=
X-Received: by 2002:a05:620a:450c:b0:939:6dfa:48fc with SMTP id
 af79cd13be357-93bb796a4c8mr1114936285a.50.1789651666676; Thu, 17 Sep 2026
 06:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915090457.2342778-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915090457.2342778-1-lgs201920130244@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 17 Sep 2026 14:27:30 +0100
X-Gm-Features: AcwNN1VtPNHGDzm-Brpio99oWvACBn2y0PZApgP4nD88EIW-t5kvm83lCSZc0OI
Message-ID: <CAPY8ntA2h_ChCWJbAmCVygYiviTdsd9TA2LcVh5ffto__LgZAg@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5647: fix power cleanup on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guangshuo

On Tue, 15 Sept 2026 at 10:05, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> ov5647_remove() disables runtime PM without powering off the sensor if
> it is still runtime active or updating the runtime PM state to
> suspended.
>
> pm_runtime_disable() prevents further runtime PM callbacks and waits for
> pending operations, but it does not force the runtime suspend callback
> to run. If the sensor is active when the driver is removed, the external
> clock and regulators can remain enabled and the power-down GPIO can
> remain deasserted.
>
> After disabling runtime PM, call ov5647_power_off() if the device is not
> already runtime suspended, and then mark the runtime PM state as
> suspended. Checking the runtime status avoids disabling the hardware
> resources a second time when runtime PM has already powered off the
> sensor.
>
> This issue was found by manual code inspection.
>
> Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/media/i2c/ov5647.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> index 3facf92b3841..d42d009772ac 100644
> --- a/drivers/media/i2c/ov5647.c
> +++ b/drivers/media/i2c/ov5647.c
> @@ -1271,6 +1271,9 @@ static void ov5647_remove(struct i2c_client *client)
>         v4l2_ctrl_handler_free(&sensor->ctrls);
>         v4l2_device_unregister_subdev(sd);
>         pm_runtime_disable(&client->dev);
> +       if (!pm_runtime_status_suspended(&client->dev))
> +               ov5647_power_off(&client->dev);
> +       pm_runtime_set_suspended(&client->dev);

I was unsure whether pm_runtime_set_suspended can be unconditional or
should be in the if clause. There are numerous drivers doing each.

As it happens, Sakari's just answered that in [1] that it should be
conditional, so I'd take that as gospel. It looks like he's given a
similar answer on your ov2740 patch.

  Dave

[1] https://lore.kernel.org/linux-media/aqvb_n-aPcXLnEa7@kekkonen.localdomain/T/#u

>  }
>
>  static const struct dev_pm_ops ov5647_pm_ops = {
> --
> 2.43.0
>
