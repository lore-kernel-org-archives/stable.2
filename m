Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5F538D72
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073418; cv=none; b=krd88GeQvcTDdM/h62f6NR6f0CtLM6OR4xteNUWTr+i/zmAGHbHFqN9t9CxlMJd4qrP8965t1DxSDNorl00hsCNriZJgEYeRn79WoackNBYJHsTCWSb1bXWkFAWodnT9tukt5zs+tNS0TOwx+djNxjU3GMsuz9a5LB83zZV8xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073418; c=relaxed/simple;
	bh=LQPPbzzWnknT0Aq/BgJ4252Y/IZhijSk4u33zoimweA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPT2+1yl0c/as4Fs4P8tWVBOaHA30MZLRF2but+L0XxYadkYXF4TSlXtRGG/c136fXcNKoHf6x5sfJNBRXhrJR67B7sSaAwJP5GFtvb7MC33rPD5Cw15x0FpxE9lKqA3zutpkUvAEp+/1tEyF3BQ81qyXhlRSKdbUJ4KgHHiTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBC/wQOu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBC/wQOu"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso32792815ad.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790073410; x=1790678210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFrSw8g6pQMY5U3KRpdjAipvB+Vk/2tHlUyOShfJMpQ=;
        b=MBC/wQOufI1Q/iyrmXnGNQX5U8OQ301jMEyzLOgznQ+in7jqNBEDig7wFjsQVRm8dw
         sJfyplay0ysDXH2c4g7AyMeiqyYw9NBpBfjIy+95cIjPzwOOORHEUdiVnxHeePTxLdQJ
         rFMTrzcGbVx2Yb/lXKl9T1K8A9zd/D60rjyLXghtca+lY0FtJXP6j+g1lOi83ltOuqpl
         lTisRiyS4rowTYK08iBc6uJS+5gBaIU6trXlSvAWB1KsKWoI66Ars01KK+HTO9nDrcoK
         YQHYi/rxoeuRUY9MPeYxqclvmioaP9/eC638EyxilJ07gtOIJV+gRyoSFWPI9c7tkStg
         ALQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790073410; x=1790678210;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFrSw8g6pQMY5U3KRpdjAipvB+Vk/2tHlUyOShfJMpQ=;
        b=vR/bHSzRDgEajhwjZG4W6KAV7dEH0+5CYAgAUNDKlM+3Iatbt1gJr3PZPU9JCGKjDO
         c7GPhKWlB3ym72I5bMuDO+omygsTy0oGnoPuNXFPFJNJ9sXJ3O0LRh9IXZ4cnpPWsZyF
         N+Gx6X94P8emBfGQg9i43NPjPoGSdaF5jVZC7rRK1vr92G+atm/dmxX2J/Cbt2qt9ogu
         iRSELRHEROo5z+w+6zeBO5eBDMhaTsCNwRTcb7m6HZ2chZKutKMCpSsodxO/wkYNq2e7
         kSJ3ANysXKrD1Zdnme9n1A9girhkiK9QPOLU6BNz3Y5tz++2ZSDW7lef1AFnbPbeDf/P
         c+PQ==
X-Forwarded-Encrypted: i=1; AKwUvByynFeKenJmxzPmhl4stw37ml6IILo+WwWct6f4EWVHMzZsJfhYkFJbTj2unFLNSQ9DTWWhC/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nDtbnMPmFMJvmC2kMI2EfdJyWCtfIfAbzQCi4XfsIzm2qfiwMA
	h+KG6ozW7rMIlu+eMFiTub2XuRfJz6djvQUzE9t1faTbQdnUfgUZz/UNePzOJAEG
X-Gm-Gg: AYBFou3mvlpW3JRxHwo4ugrkU4VXUuwYfXTWS6VXCSsEDO+q+8jGd21oOrWX1CY4i93
	oR+vazh+TqB8ZaWyOAUziTgt2epTtBbPzklyo/89fdVETnMCk7sTvU8WBKkytQ58DDq7qkepKF9
	7qtRnmjl32ZRoY5voNt4i8v36ZppKhY2n0mRVJb4gRcAVSvGi5jUgAvRmcc6bCtB6OXey+fmDJI
	GDhzGtvaqbjSQcRj1qyZXif8JBQM44guWvgpR2Fy1sMKEnD2Va7Gd7lebcayQMiNvBMcGzI2rPZ
	mUVcnsm5zxXsvsonFAV5DadvjIbHKa1Qh1RR5Zu7w3yTpXAqAlAswZvMMnf7Mjlg6LvdL6s7kfG
	S7aMH4M5jCgYXk4WCBnc9kLqhQWBjNBe0wB6y3QiiV5xhY5amkQPvbLZuhOd8u89JTqS1Lc90JJ
	1q87uP9CTK92QsUgkzLifsh1/FWksWsYxqXoQw6S3f8L6LyuUDyZHSS/Sm24g5w1e2VMnMB8qSV
	M6zV8DsBlWki9yrPg==
X-Received: by 2002:a17:903:19ec:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2df609d11f5mr8150535ad.18.1790073410417;
        Tue, 22 Sep 2026 03:36:50 -0700 (PDT)
Received: from rigel (194-223-74-160.tpgi.com.au. [194.223.74.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5cf827b7sm7575295ad.4.2026.09.22.03.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 03:36:49 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:36:43 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3] gpio: cdev: fix kernel stack leak to user-space in
 error path
Message-ID: <20260922103643.GA40044@rigel>
References: <20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com>
 <20260922090955.GA35938@rigel>
 <CAMRc=MfT-T0pQTvB3a_1BeOhPHztPh5pGs1Br225GVm1pFN_Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfT-T0pQTvB3a_1BeOhPHztPh5pGs1Br225GVm1pFN_Yw@mail.gmail.com>

On Tue, Sep 22, 2026 at 02:33:35AM -0700, Bartosz Golaszewski wrote:
> On Tue, 22 Sep 2026 11:09:55 +0200, Kent Gibson <warthog618@gmail.com> said:
> > On Tue, Sep 22, 2026 at 10:52:28AM +0200, Bartosz Golaszewski wrote:
> >> If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
> >> return immediately before zeroing the info struct we'll end up passing
> >> to the user-space later in lineinfo_get_v1(). This may leak the kernel
> >> stack contents. Make gpio_desc_to_lineinfo() return int so that the
> >> -ENODEV returned on failure to acquire the guard can be propagated to
> >> the callers.
> >>
> >> While not strictly necessary: move the memset() before trying to acquire
> >> the SRCU read lock too for good measure.
> >>
> >> Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Closes: https://sashiko.dev/#/patchset/20260912123529.7951-1-tzungbi%40kernel.org?part=3
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >> ---
> >> Changes in v3:
> >> - Don't emit an error log message from the line info notifier if we fail
> >>   to acquire the chip guard
> >> - Link to v2: https://patch.msgid.link/20260921-gpio-cdev-stack-leak-fixes-v2-1-3307c4320352@oss.qualcomm.com
> >>
> >> Changes in v2:
> >> - Make gpio_desc_to_lineinfo() return an integer return value so that
> >>   the error code returned in case of a failure to acquire the guard can
> >>   be propagated down the stack
> >> - Link to v1: https://patch.msgid.link/20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com
> >> ---
> >>  drivers/gpio/gpiolib-cdev.c | 32 +++++++++++++++++++++++++-------
> >>  1 file changed, 25 insertions(+), 7 deletions(-)
> >>
> >
> >> @@ -2491,6 +2502,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
> >>  	struct lineinfo_changed_ctx *ctx;
> >>  	struct gpio_desc *desc = data;
> >>  	struct file *fp;
> >> +	int ret;
> >>
> >>  	if (!test_bit(gpiod_hwgpio(desc), cdev->watched_lines))
> >>  		return NOTIFY_DONE;
> >> @@ -2521,7 +2533,13 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
> >>
> >>  	ctx->chg.event_type = action;
> >>  	ctx->chg.timestamp_ns = ktime_get_ns();
> >> -	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
> >> +
> >> +	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
> >> +	if (ret) {
> >> +		fput(fp);
> >> +		return NOTIFY_DONE;
> >> +	}
> >> +
> >
> > Drop the ret and just test the return directly?
> >
> > Sorry - should've picked that up in the previous version.
> >
> 
> I actually prefer the assignment, I find it more readable.
> 

I'm the reverse, but I can live with it.

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
