Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBB3D47A7
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392476; cv=none; b=eSpQUHKhE65uaXl4C8uaZgwYFzEWhpY+uZmFZYcFJihROh1qSYTCPsYYSjD4cAn9AV/QtGL0zS7qktQ5BhOzGZjys4GlsIuAVRrKJuxlV79YSnMfT5F4Qje8hl4DVknDeTxU1zvR3Ekoq/UqXtKoCKolo8DzZtMxy1teiZsyLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392476; c=relaxed/simple;
	bh=fiwEphd9S1oE1F35wXKS6z4c/fPTVw+0/Jzu6wOUWwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk/urGg/EC4+0U7K69ST5isDRnKI8gImLjTwnqeidLhhtU0bTwIcH4Y2g/jlCzjYqm3201Kf+E0fpbvHWSL+Dim0r6qgr0hZCzRTyM4e2RQ2vJkNm1OxRbvf7N1TMpClrkEYzpVW7UpzORfeeNNjqtZ1l9b7xlQoJcemYtlUtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J70udI0t; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J70udI0t"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed1368so18718105ad.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392474; x=1789997274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kLko4nhJEbxfZ3Fn8wxISTNiqWP9VB1x/ln8iy3awyo=;
        b=J70udI0tUd+BWQBEdV1Uk+AQCBp/IE5kiHZ6Ul5BAJHrTAnZrltuHEIooRWax9RB7W
         gbqZmofc9AjDM9hLSrZ4UhrN9h1CGrprt1Mp/tRDOLc7I99XN7bgiqBhU9COXrjZBYm/
         4DVJyN3ytRH+gSfTGgL/Bju6JMjM5Ajfbu4WocCYxmEIswMWpPVTfFaj0ic8WXhUyN1I
         fwmE1xvfcIhRHUxvLmG/6INnIiAgikah1p+CPqWa4v33WgiNsFVzpZSgUlTfJW11YRAB
         /I4/MePITrD9wofqfMkdxq4JKfR6jOQUEzuuNffAy+qeNu+QEh5ylzyhUcquoG03i46u
         j20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392474; x=1789997274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLko4nhJEbxfZ3Fn8wxISTNiqWP9VB1x/ln8iy3awyo=;
        b=eNLdDj8xtsPux5SXLW/4Faa6qPYpoziJEVKKF80cvVo4Bu9dUIAM/adB+9O1DM3kLg
         DXu/iwYEqcahz6plxlBHXEsNAKcVUjfb7HciTuhQngqnDM1pezcVqdi1jShjzlacyPSP
         FnpZnDY7COpaVlhZJgw2MIGEkM5CPqIraqW8IKLIJyaJVK/1Ocb24HfX54YAxcC9RczA
         SeP9Z0hH11N/bTH+9fPJ6BkR0z9zirFQE2NSQST+59AOR7Y5xNfbNCZpZT2JYVGvdTzH
         WcSFLdUvwfDdoLPMe7WDN2TAiBZgLyV2fBv2kKJg5JZofrLXMeGpGpwHWKfcFTy8Et06
         sdOA==
X-Forwarded-Encrypted: i=1; AKwUvByxA/F7z4FQb7hvtZrDEoZcKR+nsS9/p6yJbCeljSUOm9h6GljYYZaah91h6v1pmcryq2tdguM=@vger.kernel.org
X-Gm-Message-State: AFuF++lBpXInJZR3+hmBGD0ezDf0gaNnKbti7qJ6vP3hHvTZXpkjMN6C
	8c6PXVosaSlm0mWSz9p0W275Myfo/ys/D7GoPq2PW3RqkVThfsXjODYe
X-Gm-Gg: AYBFou282gAIQdTXRRsaJow14rAiJk8gb2ubKzcRmEFG6t8MQKT1lZGfFL6eFgRU8Fr
	SUtQ+RmgEXeWXZmeoYywL9vEKGBjzCGBeLTXPfalQaA9kNnB5RAhLCRXcftcoG94qVhCrJ4GDOO
	QsUFrxoog45jQ6WethaIenHeQs3wbyc9FmvYj7LFZpQwsQFOkN5Og68A0PdMVG35taRaHY0TYFo
	vM39rr34ctwMx8Vx5y80AL+7nQeKH0CpCBrHnba5EEV2NhyH0Rvvxlpxj56H0R/apz8o0jC9+2E
	GP+8D+xpqbyn3Cxxub/MiHo3Td+xThCCQMREGFPfz+OCnAlCbH89Mzqqtca+1WGNC+GsMCV/aae
	AwLnjYvcWIHbOG1VQQWFvMN0qInR3epSLBapsbA/4pDRwE5nnovHHA2J1AfzOEirvv+xvmOdhfN
	R/ZW6ACiSjtJxV0KWVbON67zORolJH5q8YtGMxULsCYfNz8Qr5V6TQ/zbLs+NLYrW4YWmEtFEdz
	NKJ
X-Received: by 2002:a17:902:f691:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2dd6c6df7e0mr52399065ad.12.1789392473892;
        Mon, 14 Sep 2026 06:27:53 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:dfba:aa04:857a:222b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd428ede1dsm39769495ad.13.2026.09.14.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:27:53 -0700 (PDT)
Date: Mon, 14 Sep 2026 18:57:28 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] configfs: fix NULL dereference in
 configfs_depend_item_unlocked()
Message-ID: <aqf2QDbZK5RgktFA@user>
References: <20260914094426.25595-1-pavankumaryalagada@gmail.com>
 <aqfGt6OFIRuqMC6H@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqfGt6OFIRuqMC6H@gmail.com>

On Mon, Sep 14, 2026 at 03:05:26AM -0700, Breno Leitao wrote:
> On Mon, Sep 14, 2026 at 03:14:26PM +0530, pavankumaryalagada@gmail.com wrote:
> > From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > 
> > configfs_depend_item_unlocked() can dereference a NULL parent when
> > the configfs item is still being created.
> > 
> > The item can be found before it is linked to its parent group,
> > so ci_group can still be NULL. Check ci_group before using it
> > and return -ENOENT if it is NULL.
> 
> The crash itself looks real, but this reads like a fix in the wrong
> place.  include/linux/configfs.h already documents the opposite
> contract for this API:

I agree, I checked the code path again. The race is in f_tcm. The function
instace is published before its configfs item is linked, so usbg_make_tpg()
can see it while ci_group is NULL and pass it to configfs_depend_item_unlocked().

For v2, I will fix the caller in f_tcm.c by checking ci_group before calling
configfs_depend_item_unlocked().

> 
>  /*
>   * These functions can sleep and can alloc with GFP_KERNEL
>   * NOTE: These should be called only underneath configfs callbacks.
>   * NOTE: First parameter is a caller's subsystem, not target's.
>   * WARNING: These cannot be called on newly created item
>   *        (in make_group()/make_item() callback)
>   */
>  int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
>                                    struct config_item *target);
> 
> "cannot be called on newly created item" is exactly the case being
> patched here. 
> 
> If configfs is now going to accept a not-yet-linked item and return
> -ENOENT for it, shouldn't that comment be updated in the same patch?
> 
> And if the contract is meant to stand, shouldn't the caller stop handing
> over an unlinked item instead?

Yes, the existing configfs API contract should remain unchanged. I will not modify it.

Instead, in v2 i will add check before passing it to configfs_depend_item_unlocked().

> 
> > Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support")
> 
> This tag and the diff do not agree.  4bb8548df632 only touches
> Documentation/ABI, drivers/usb/gadget/Kconfig and
> drivers/usb/gadget/function/f_tcm.c; it does not add or modify anything
> under fs/configfs.

You're right. My previous fix was in wrong place.

For v2, i will move the fix to drivers/usb/gadget/function/f_tcm. I will keep the
Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support") tag because this
commit introduced the f_tcm configfs dependency handling involved in this bug.

Thanks,
Pavan

> 
> --breno
