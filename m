Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44E4A2E1A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002306; cv=none; b=ToqqqBnnIEDW1QhlbKYso2YvUDSh1kZOIr9LxYfegsFp790olJLc1PppVo5b2CTPagaW3FPZr8L8jXQwJDt6lvPPtDKkqknUOQp34/Mkc2Alh6RywYcwpGHl7MZLWBhY15eYvbxGpN+NN04USCcW+1MeVZjjIFrBP5ujkTV4HQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002306; c=relaxed/simple;
	bh=J/dVafMLo+higmRBi49yI0qBk9RLrQcNkd4edlOSrNE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ6TBR2LBUmlbhh7rpCquFfRQrZJz7M6WQduz91H8VfALO43wQ9tIEesqd1yAFTJD8wEcr9vkYBRF7cNTmL3v42xFax8ObSYxTXvfhP4YKH6NbAIe/BDGF/y0h+EDO/suva+ysalYFkf1wzGk2LqxvSsNxgyzANlYFKzMgQ/2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOK/cou2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOK/cou2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D221F00893
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790002304;
	bh=Ts7fPQfO6L1Xr5sR8XD5bM5e85VTo6NwQNgErntbsS0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=gOK/cou21emnUAlAs6ztTC0yYGzZp8pyXoDxPOm3fnrrGeODiz/2weJ1q9qC2xBms
	 GoN7x/Vi3hYVCHi+RilKLGjRolzhBf+yQwK8juX0sM111VwWO6fjzTCaO0l22rSvLe
	 C5J+2O0l5hQHel93FQx8/9bcgZcHEhHDYsRXtz1dX6nbhqQV7yQLeCIVDNjAPN5RZW
	 K2pUcA6vprARBJObmOxH8P58yMe2qPttSDoZBi3MhSrZd4xgany+z9wpCvKbJLTgLs
	 eHI1hTzYUAQyS5FOVPKrC1bBDwRShOC8/urW/QZyJh4E927tftjfNKpvxpbrN0hcyi
	 GhoXrfBwRWBZQ==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59bc470d6so26416111fa.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:51:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByn4Tr/v77WC8Xqz5/7JWHtsODRXKFqSMIx8Q5I9SgCAUC+ADNyaosOmyh3A2J3X+6buZ2vpJY=@vger.kernel.org
X-Gm-Message-State: AFuF++lKtGvw342EvCGGXtirMQE+qD2q7opV62L7iJB6k4Ib5zH3rNYl
	g6NqnjC+wQgjb7/D2Dxmu7sBHkQ2QJISIWeLh/0NPhlOsTS87dC4fod8OJwuwTG18BPK2nQEYVI
	YowPGEfgdziCcRMyOTw7H7/nnaH2mfdK4JTCSKrCNsQ==
X-Received: by 2002:a2e:be10:0:b0:3a5:b6af:2973 with SMTP id
 38308e7fff4ca-3a5fbe86f32mr23860151fa.5.1790002303600; Mon, 21 Sep 2026
 07:51:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 10:51:42 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 10:51:42 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260921133505.GA90171@rigel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com>
 <20260921133505.GA90171@rigel>
Date: Mon, 21 Sep 2026 10:51:42 -0400
X-Gmail-Original-Message-ID: <CAMRc=MeeVLALF6DU70DMwg7=F6d0kVdWEz=ugYJFt2dOR2T9YQ@mail.gmail.com>
X-Gm-Features: AcwNN1WNwd2vGvSwTAltFFQ82w381AeNA2BKm3xzOM8thzpgNI5Tc8azTbhAE_Q
Message-ID: <CAMRc=MeeVLALF6DU70DMwg7=F6d0kVdWEz=ugYJFt2dOR2T9YQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: cdev: fix kernel stack leak to user-space in
 error path
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sep 2026 15:35:05 +0200, Kent Gibson <warthog618@gmail.com> said:
> On Mon, Sep 21, 2026 at 02:56:58PM +0200, Bartosz Golaszewski wrote:
>> If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
>> return immediately before zeroing the info struct we'll end up passing
>> to the user-space later in lineinfo_get_v1(). This may leak the kernel
>> stack contents. Make gpio_desc_to_lineinfo() return int so that the
>> -ENODEV returned on failure to acquire the guard can be propagated to
>> the callers.
>>
>> While not strictly necessary: move the memset() before trying to acquire
>> the SRCU read lock too for good measure.
>>
>> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
>> Cc: stable@vger.kernel.org
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260912123529.7951-1-tzungbi%40kernel.org?part=3
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Make gpio_desc_to_lineinfo() return an integer return value so that
>>   the error code returned in case of a failure to acquire the guard can
>>   be propagated down the stack
>> - Link to v1: https://patch.msgid.link/20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com
>
>> @@ -2521,7 +2533,14 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>>
>>  	ctx->chg.event_type = action;
>>  	ctx->chg.timestamp_ns = ktime_get_ns();
>> -	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
>> +
>> +	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
>> +	if (ret) {
>> +		fput(fp);
>> +		pr_err("GPIO controller that generated the line info notification was removed\n");
>> +		return NOTIFY_DONE;
>> +	}
>> +
>
> Does resolving a race warrant an error?
>

I guess not, we can just not do anything in this case.

> Also, compared to the kzalloc_obj() error path earlier in the function, here
> you flip the order of the fput() and pr_err(). Is that significant?
>

No, if anything this version is more correct as we drop the no-longer-needed
resource before printing a log. But with the above it's irrelevant anyway.

Bart

> Other than that, looks good to me.
>
> Cheers,
> Kent.
>
