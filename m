Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E74B1260
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069620; cv=none; b=f8PBT1AbPH0tG0tT1n+H79aMw3IRKXRzoIzuuI1SmJd1Q++mG9fALtSlgWMvb27xp9T8QSWxZhL9sy+/YL1lTbmfdPOKeBkYREcQTIPLUFrffxk5AG+pMxVcsOYl+UUKR9aiYn186XpKjiqgD5LRdcyTcJXJdD9yD9KgQMR68Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069620; c=relaxed/simple;
	bh=Ydb8A5IsSmXFv8QsCXm2Zg3ISAVzToCc4PjSnCMZxDY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlDQbilHu+K+IRAGDe5qhJ/23WqgtIpePOjfRIFekIgD5mDbhYtK955+/CzwnexrQBJimNdqn0BAYzenQr8vhHBzsCN511dVFxwFUVW26paR9qaIwsD0wo9zQEs6gJ0Sy5seeUALu3ktaxbYPgF0ZPEhnzKIZKq/7VaJVlNnNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdrZ9XjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdrZ9XjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00C81F000FF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790069619;
	bh=069+GQ/DIF+/n6F/rVAvVoNM7EVQnIJJNnVPO8L6lWU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=cdrZ9XjIRkpQIxdl0l0Y+Jl9JSLQgRL7EE8hm/8hwWobiOGtRN1xti+y2R36t3vM3
	 PgrgnSlhugjy9OdzTSAfLw0T6pOagpps8Kg5gVmsmGefUfyxgvGDBc6LXfENuI7KOf
	 LzcQHIYS3iF7e5RCYjZwWJE2IXptY+UhR/2LL4QvHpgRN86QFkf3Hd6ieKZntHJyKs
	 CcbnjwXg7ZLXkLRn4bAGUGB1w4eIYbuULh37WWo6mdKaCbFPGrNNDaGKfA8vh68CTo
	 Ijb+B/Oe/jNu1sP1b7/3piCHmYJpqjY4IT2rMs9rdr9LKKrBgDPwedBX7H1DO4Pi78
	 PH5kULd5VW9fg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a49a40209dso4365211fa.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:33:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzga+d5xNB/xJ5+x8vLbHjwfYbwMzCQjG6QtSxFghV7E0saJS41ckNzPxFApweZWUIIdvBv4Xg=@vger.kernel.org
X-Gm-Message-State: AFuF++kaoeIcAAp74AGYTkWNJPwe21jiBQ5bO7+c+95FxWdyNkbGqrAE
	q8R9bMdQrCQ2aVi/Ceh24IRzkc5BYDlZkXSwomM5z+n9BYVjiJfKiElbuF+YJQz1vipq40LGpw5
	YFjlm+DynTKpu6gIhYMlETtbjF5niPkXxin7xK4JRwQ==
X-Received: by 2002:a05:651c:a189:b0:3a5:eacf:9811 with SMTP id
 38308e7fff4ca-3a624d70958mr4810711fa.14.1790069617628; Tue, 22 Sep 2026
 02:33:37 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 02:33:35 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 02:33:35 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260922090955.GA35938@rigel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>
 <20260922090955.GA35938@rigel>
Date: Tue, 22 Sep 2026 02:33:35 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfT-T0pQTvB3a_1BeOhPHztPh5pGs1Br225GVm1pFN_Yw@mail.gmail.com>
X-Gm-Features: AcwNN1XpWe_ilycObMRbYUBy0psjXERCXkaGG5VxtWxmcE7WWxLhXalMicOFPN0
Message-ID: <CAMRc=MfT-T0pQTvB3a_1BeOhPHztPh5pGs1Br225GVm1pFN_Yw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: cdev: fix kernel stack leak to user-space in
 error path
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sep 2026 11:09:55 +0200, Kent Gibson <warthog618@gmail.com> said:
> On Tue, Sep 22, 2026 at 10:52:28AM +0200, Bartosz Golaszewski wrote:
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
>> Changes in v3:
>> - Don't emit an error log message from the line info notifier if we fail
>>   to acquire the chip guard
>> - Link to v2: https://patch.msgid.link/20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com
>>
>> Changes in v2:
>> - Make gpio_desc_to_lineinfo() return an integer return value so that
>>   the error code returned in case of a failure to acquire the guard can
>>   be propagated down the stack
>> - Link to v1: https://patch.msgid.link/20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com
>> ---
>>  drivers/gpio/gpiolib-cdev.c | 32 +++++++++++++++++++++++++-------
>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>
>
>> @@ -2491,6 +2502,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>>  	struct lineinfo_changed_ctx *ctx;
>>  	struct gpio_desc *desc = data;
>>  	struct file *fp;
>> +	int ret;
>>
>>  	if (!test_bit(gpiod_hwgpio(desc), cdev->watched_lines))
>>  		return NOTIFY_DONE;
>> @@ -2521,7 +2533,13 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
>>
>>  	ctx->chg.event_type = action;
>>  	ctx->chg.timestamp_ns = ktime_get_ns();
>> -	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
>> +
>> +	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
>> +	if (ret) {
>> +		fput(fp);
>> +		return NOTIFY_DONE;
>> +	}
>> +
>
> Drop the ret and just test the return directly?
>
> Sorry - should've picked that up in the previous version.
>

I actually prefer the assignment, I find it more readable.

Bartosz
