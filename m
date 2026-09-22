Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D762BD022
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045260; cv=pass; b=q6uN1i9uwSJPndK4poVoOfQWFBeM1gW0EQFJ6iDZjAazF/HyNeAekAtt/vf0i9iIywldRB6cVzsz2ZydHzcpMvGuvQ5OStDbNNidbYWac5KkUpZ9MlPAQSzTNVn3bUCrlukFjJwXI0adDF5MDCulIE0FJRPoRXXfPlUvluc0IEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045260; c=relaxed/simple;
	bh=/bF+2i7J9tw/SU9Y8Ch+X0ErYTFXTPP1J7KPqLHGa9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxEzut2qLjiAzCMhLuYKV7hIgARoWyWj7URELILI70Xq+qulZCNnqxzmrlYsFcDKiuqDid4wUXOBQqNVQWsYN+GgRss3t2AY0ipvWKSObgoBj3Xv8gGTU3WWlzyRAC4Lq3UrdxBXW/PtYHWLewa5csUmf8er708ttWYxp4k157E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuLhNOa0; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuLhNOa0"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-671563fb8beso3460694d50.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790045257; cv=none;
        d=google.com; s=arc-20260327;
        b=SEFLLHIq3YMhiqphOUASXKiBip+Rgq/b3RuJ29QvvCX1dEZDtd8CHlA6Y8vdR5e8Go
         10ithey3cl+TK3ca2tUkDFWhxOLM5wDmHV56Mtj27abt7wupNcaZ/TTe0CoAZt+yi7Z/
         r6tvPd2wo91N5vMSpwE3u9QkDWHJNM3o/eNwXUflbVbhx8XWF8a6U/1Th+wlRhyJ1ZUF
         tZGt02aYffHb5O+71KafohEiqq7qI/Tf2YU2Exg0nt4UiH9120x7CaeRvKEElut4ZdFJ
         DZPIJmWYT/3lrky0xBP61L0SNIirlY5Yj3zldLSRdep2R4TelHLwL3axm/AeUCMdezwy
         2GfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K/Pzgg7o0qrlVK5qFQbvKisrC2SDvw/OqmX88foRwCs=;
        fh=q9OYfvPigGnLLqy+6A7VI2RsQLslntXkAglJzMq+fiY=;
        b=MnNq5xK8jEapFgo3v6WM27y+91P7RVVCnm22PV6qFazavN+aAhFBwbiBtmio+KRuKK
         9KsR8oehrDP+UERFWH2cBCcfnBHvLaclPz5F9fNfP0OkbSntP6+s1UV1Qo0nanPeopCg
         9BYeg9veYpMZRrxla6H6fSlq12k6xvEgW7v9GQ2u5eH5WabgIJl2quxiFdc0CDc5fH09
         G4PW8bTgwE1DdnsVuSU1FYtRRPOTt0MhF/2onn2Hmxf8HhDQwjw6Qs2c0ompc/RqSYsk
         lNGDz+eAEkCkZyQXDdyUKSgL5GdFMKaYqmFexZ8ksBoeDZDonepgya0099+PPpZcTzON
         N65Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045257; x=1790650057; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/Pzgg7o0qrlVK5qFQbvKisrC2SDvw/OqmX88foRwCs=;
        b=AuLhNOa0yPL9n4hIKdsmoKbEnxfAuuK/HKtO7P3kdusbH5x7hG67dS6slg21oqqMbg
         cDyWlzyF2x/28pOi5Fl8T/RIaFd6Rjo0MQYcMzadjD+4UENR1PxRRxs87oR+B6Qws690
         feROsiscLY5pVaXM4pP46S1YHdsoShHCTC+QhpmUTCOl30+ifYBaiosiNwHH3VuHfZAB
         nVYqcFnrEttaaf9UVTCXUDWVCgw2bfgmwhMJ31UPwTk2vBwjXgjrmYdrBC08YVpw4F69
         SURYQi6jSnhJWWINrDZnJWp1Y3YNntdOtAhJJYRmUFg6jndk4CwP9X94B6w73xvr6l14
         zZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045257; x=1790650057;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K/Pzgg7o0qrlVK5qFQbvKisrC2SDvw/OqmX88foRwCs=;
        b=Dl0H3Nn0ADtrPaNJcpxMnL7Bg/gNsZG1XK44dt9k5ZiGHc1lG6Z1+KpXT08YPG7zU7
         DJwuUhf5pRBgN1oASAmAYVdyvDBrkb12FDk44ma41GBC9TINlkk/DAqqTv/8qO45M8TJ
         V3HeybIK0SWD3Qx/6MPStxYB/5h6OFmelAdkpm1ASInUISiGPzeMJzN/oDKe+gQaNdJZ
         ZRvtPHp/9hh3lv5r+2Waj6QjOzRvCwbih9mqumz0HFH61jUF5JXTAZE9jiIj9wLs3AYs
         QapZKGcQfDqgHAp+az0St0tqK7YNWdO5Yi1VYerO5rxMsE+A74XoUfKs+gp4nNKxeKJP
         dYEw==
X-Forwarded-Encrypted: i=1; AKwUvBwYdBQnKyxt0RT6LOhSZ9sCytVJLugRLUazBC1g54M498PY1/sDh8mFe77J7ASpq8/9CtjXRLY=@vger.kernel.org
X-Gm-Message-State: AFuF++nzqx+eSEUiHOI4SdpaETxnStuIEPrBYYsxCRfaJyLA4LQvnr1L
	0aD+qvFqGr0/bcGRHMBR1XhFwrSVGmwvaNhEU/nFdycoWUEAvSU8JNbjr1d3krLKuWsopcja8E4
	GuyWd7IM0M1DlWGB5CL/cP4Qn93cdeSE=
X-Gm-Gg: AYBFou3vE+Kr9VsGCMyrS3E8+zO+0liis/IwzLVsrhY5qro0B6q09VUke3hG4LuO/Hg
	hg9ujKSnC3fqTBEHJqlNtbYhz4RpQEBKNveUqbu5OiKK8pctN+AUD+3j40S7wg7G+MFoXyHJCwD
	t1pagUhNN0NgeBRhn+89b/mc5TQ7iZn8TXlI79d/44XXl6wSyd+BEK8ddQCaqujSYE5ZVh0UHNS
	UfrZJGk8LytEq47kWmMSQSB/Bd0Dy9b9od+JxvhelZ+3Y1lziHVMq+ilgqCA5yFWc+xiIuw77/5
	XpU0xntryE/AeAK3JtUJ+0tjoY5Fj5KNcGLpPG0s5pIhILZ7EQgoxrPEtto=
X-Received: by 2002:a05:690e:441b:b0:66f:c1be:84e1 with SMTP id
 956f58d0204a3-672c54b6fb5mr245756d50.79.1790045257564; Mon, 21 Sep 2026
 19:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921073847.63505-1-lgs201920130244@gmail.com> <arFH7F944RO7TUqN@quoll>
In-Reply-To: <arFH7F944RO7TUqN@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:47:24 +0800
X-Gm-Features: AcwNN1VMKLPliQEBYI3cwmxMjQMSd7JsGwSa33n2dtOWCSkj81z1Dp0OO7Y38vg
Message-ID: <CANUHTR-KMdRmJwjpqqk5tsfnQkrwRBroCqkYOr6f9o=6yVewJw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: SST: fix platform device leak on probe failure
To: krzk@kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, linux-sound@vger.kernel.org, 
	stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, 
	Thorsten Blum <thorsten.blum@linux.dev>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, 
	Takashi Iwai <tiwai@suse.com>, Cezary Rojewski <cezary.rojewski@intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:06, <krzk@kernel.org> wrote:
>
>
> On Mon, 21 Sep 2026 15:38:47 +0800, Guangshuo Li wrote:
> > sst_acpi_probe() registers platform devices for the SST platform and
> > machine drivers using platform_device_register_data(), but does not
> > unregister them when later probe steps fail.
> >
> > If machine device registration fails, the already registered SST platform
> > device is left registered. The same leak happens when
> > sst_platform_get_resources() or sst_context_init() fails after both
> > platform devices have been successfully registered.
> >
> > A registered platform device owns resources allocated by the platform
> > device core and must be released with platform_device_unregister() so
> > that the device reference is dropped and platform_device_release() can
> > free the backing platform_object.
> >
> > Unregister the created platform devices on all failure paths to restore
> > the missing cleanup.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: caf94ed8629a ("ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  sound/soc/intel/atom/sst/sst_acpi.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>
I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
