Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E203AA1BB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682398; cv=none; b=pUmShona+zKhMVXErpqjrqmdo4no9DS7Gf5z2hwSIbsKsDbOrC/8uqp4aZ5+2bsv6mtRF56DOGRuY7Bi8aHJzLhuXf7wtZWfVY/x36akx09QhAdSADY01djb/PTR+ujaWON8f1ggSiB5Jr0Yj3FMqg96qT/qI7xW5G7CjSGICSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682398; c=relaxed/simple;
	bh=ip41HoXWI4YcOSbW1mEcNQBv0yfH8oGIibej8w1DMvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j++NThJpfmXO5bMNg/7n7UIov5MyQXa6FqMdkBeIFc4Lw45KeQdR1rtM8ZcGV+rhmJJWdiWCitnuuObhFrI1ktLvbkDjcLsPKclPU8wkmsWTaJKo56sYeAfygWH4+l1KnODzJDy6lfYLFc+DWw1pnFG27etMjIgrkYgkgR6dS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HRh7bnsf; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HRh7bnsf"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99391ffb2so169821a12.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789682395; x=1790287195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r4cnNziyY5ivazygxhgE+WIDjeZucbip+tFrsvHGAeg=;
        b=HRh7bnsf5/jUBcvfJ8Zp+mxY42hIHGPDJm1Q3pCnXP+ZKLKVpda/k/q6OFJoL1/+I0
         UoWWzxADo8TYTAvgWx7k0c/D5KuqdySxt3AWCL9G4lCqaBfXKUYqVsnTuXEeaI1OOZ/q
         yvinHrJIrsvHNilrdW+kSuls/2hMWlgeIaTWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682395; x=1790287195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4cnNziyY5ivazygxhgE+WIDjeZucbip+tFrsvHGAeg=;
        b=PNuFyuJs1uQC5CV9ZV5Hkd7tNWfbAMePFPD08kjkTIC+kW51++mRHHaQYJcudLpHoM
         rDvq5qbPeF7xhJsKRO53rN2lxiawX/IXTQ1/tcgPSWQL3WWLlVdeP57FTqbQUQ5EPIcp
         9jNElhYV62knLcWW0lQLPUYB7RTEIzliPvJv2kxgZ6mSDuiY+AQvaT9X/wRHMpl4iFMN
         5O1VIDTcBiNVTvXveh9d5im7wnRF73BtYe8sVDtWEDBmqKwH7UzizGXiCbAf7DX4WuiL
         caYsKbfXh/C+a7YpJW5ToIBRXWP2eNnIg8BKMURnnCz00UcRl2oMGKgonKOlT4wQRySf
         aYOw==
X-Forwarded-Encrypted: i=1; AKwUvBxkAP/g0H/JtubMdt2PEU2mkMT9mnndKA8oI8+AYZsng1rA3z+g711tZOtQ5GkPKFTJcENihI8=@vger.kernel.org
X-Gm-Message-State: AFuF++ktGcQPwbiHDoKMq/gA/a4jvtL/HDTwGn5o0opGbAEM+hEKj6ad
	vxfg1bVQ86btcT59ZhsK2/vDROonkN51ecBqYnnK8fLsN0YlrL1h6wiOTsjlY97/IjmPGNQ2/hA
	isky02Q==
X-Gm-Gg: AYBFou1NO2/tQQ6IhGkAKKWsSUscuvauL+8K+fk8K1XNvSBC42hvkkxaIhzBa8dhF93
	OUOBUKRFGZWV8u3dc8jHQ6KLZJW60LrL/Ant8kPaYzFKVo3ZHM+3pA+rWq/L0Z2nXKveavCVc9s
	ypiU5hz6z2MqjDxP06bWrGd0RIhuz/JBqXJFHrLMkACGn9QXN+d+IwMa4NmQjM18oCooTWIjNUd
	CaXPMadmr9/ZIH4l4NtLMNe+W9QLaLL3IAEd6Btfhc+9VJH7T/58oN95IDey53aTwQiQsCA+3dm
	18V6DrisD15haMRwm3SusAK4QVpRv7HItWC6mKCMAwrpwN86oTIfUfRCcqd0H61yWrGQ+zkeAYZ
	tYS2Ff7PaWXFQfyT0GVY1ynqhVRJabT2fJN5L0kqf6HUHeTmP7gKnW6bWr8+w4HVn28s/o1/6eU
	ZD4WkDDfzPDZj1+MH9UlICGZX1Lx60Aryc0HJjBG/ySR9t5zQPoUVAwDfVOIgu1tZZhpVDmSPQX
	Cro9yZlPhtO8fS/10BAYVg5EU8lUi9Vwt0uBaYrlc/fwbB3
X-Received: by 2002:a17:907:3e94:b0:c29:367b:b7ba with SMTP id a640c23a62f3a-c2a15e10553mr56927366b.34.1789682395019;
        Thu, 17 Sep 2026 14:59:55 -0700 (PDT)
Received: from mail-wr2-f14.google.com (mail-wr2-f14.google.com. [74.125.225.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de4866d9sm344108266b.23.2026.09.17.14.59.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 14:59:53 -0700 (PDT)
Received: by mail-wr2-f14.google.com with SMTP id ffacd0b85a97d-482f6350f88so23287f8f.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxT+GSoXH7ewL+uWb2CMZKcv6RYF5YO8W9PCmGrkmIjPFjXgJHPqgqU7cIc9hw0sp2DCtG8Yio=@vger.kernel.org
X-Received: by 2002:a05:6000:2211:b0:487:a49:69d3 with SMTP id
 ffacd0b85a97d-4871e373af6mr289328f8f.55.1789682392891; Thu, 17 Sep 2026
 14:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917155523.2161202-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917155523.2161202-1-vulab@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 17 Sep 2026 14:59:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTr4Q7gOQts8HasSQoeovYMLu7ic8V2fkuy2TgyUuB3A@mail.gmail.com>
X-Gm-Features: AcwNN1UiO2RFa1YhyTUqFm7bdR6dSYURtFzuPkFnJib2ceEhsCbcSdyptjfk5VE
Message-ID: <CAD=FV=VTr4Q7gOQts8HasSQoeovYMLu7ic8V2fkuy2TgyUuB3A@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: Fix tty driver reference leak in configure_kgdboc()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alan@redhat.com, danielt@kernel.org, gregkh@linuxfoundation.org, 
	jason.wessel@windriver.com, jirislaby@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 17, 2026 at 8:55=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> tty_find_polling_driver() returns the tty driver with an extra
> reference taken by tty_driver_kref_get(). configure_kgdboc() stores it
> in kgdb_tty_driver but the reference is never dropped: it is leaked when
> kgdb_register_io_module() fails, when the configuration is cleared, and
> on every reconfigure.
>
> Release the reference both when unconfiguring and on the error path.
>
> Fixes: 7d7b93c1452f ("tty: kref the tty driver object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/tty/serial/kgdboc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Looks right to me. Even the "Fixes" looks right since the tty change
landed after kgdb was added to the mainline kernel (by a ~6 months).

Reviewed-by: Douglas Anderson <dianders@chromium.org>
