Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F7439A806
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045324; cv=pass; b=Kl1oXkF9vEtNdCCrQAzycRas1HxnjSRbRRCZcqLC3vDNO/f5yoHqARMNk9LKcnr3Ga3s0ijzTbf9dPTsu1UoMTk4/itsJE1Wp+tAHZzBCbUJHWLwQJNnHEQ3/epHc0GGDrBRol5ysMVBQj8Yv1mRITnyq+D9nN/bH8et+IBn/l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045324; c=relaxed/simple;
	bh=BTNod3yCiVITqkGUTzHOAxx2QYkllbtfz8BL73slXFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hufUdjSfFh4p5M3ME3W7WxeCV7J10QjobKE04mYl9dr7kV8P70ZrqkOHPa7NUZ0nN5umdWasTdWnjflxfTdOoqa6qjMeESGjlIqjhQG9J50zyiDjjEUFxN5b8lD7s7SY0CbLuo5U5NvM9X0+XuuXMAC+WmMvjQ6XnTN8Xp4z/NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCP3YP06; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCP3YP06"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab20f4bso3795266d50.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790045321; cv=none;
        d=google.com; s=arc-20260327;
        b=r6kVXjTagHa/L2KeAP3xEW0S9xOPMrQoqd4dH9kKc6B/JYDoXYH2YtkcgM/kO6t7Ax
         OVKD4iZpi0cq6CBAvvCpQi4QAlYbP1ulAXnhwFOT4DB5xEYYJMj0mWfKU6shNNX+rpV6
         sDGYm/85yG4gPV4938g5NyhjG19TyOBbZb1bzHFw/Gbwr4OGdx4j0+AhFuYkRUNb9i4C
         8LGxZy4K+UvF9JYh3vvuctiWfIfznIdcjUKvu3WuRoC20siKex4Tn2kHoh4oLhvzTXzS
         kqsGTBuEL6S37X4DmbVhWPZFQQZ6e1nkpioLv1Xk59dYKG7XqSlyH0Td9tCtJZRGEMoa
         Ttww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EwWA3LgMjt74XDEZ31Q/wUl2bcv/dp/523dBsTBjRfg=;
        fh=sYE1cK5iPf95Fmh+fc9xFbykbfsbt/zfE14fYWrEJz4=;
        b=s0eP3v0HHshpQLYGO+CXa7EY5Ofqsd7OqQZVGxtG7qXxtPA7b+GjOkZ2T5qa5XAVqs
         TYn6hUJlKMl/xrVdw1LAwDf1hNlh2moEvqd7Hj7xm096mJTP+SzcFLonukJQK/aU/t9r
         ZrctpVjQ72yrSV2ZvhDdLIJRL2O61Up2Q7yM42O3cUeqiNLb2Wgup4/v18eboDZKcvRs
         C1bSfL1vQPzNZwFz3l/vYc0YzZ75WtvA9DsBXuFOTz+55X1HG88QBhIFXdPWqmQTJrOj
         rohQ7hsclzMxAlAMH2ZAyfiqg9bSndo/FYhAGpsrDsy9DQbwHgq/MT307L2j8bMeZuvh
         gwuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045321; x=1790650121; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwWA3LgMjt74XDEZ31Q/wUl2bcv/dp/523dBsTBjRfg=;
        b=OCP3YP06F13D0Is8mrxp+Hl2BJDVBihPjBs3Uo8vxgDg4/VbCZqmai7HtFnRpmbvC1
         xpqWRj2NgtjDsOsJLggDYqTnSf78B+LKs3nDWjbOICMMFG8j00pxUWywGYejUmfuAX91
         0iVt5FXof6FSLCS4Ior4GDPhmBmrCwQVPhKtMM46pUgfRuJZMw5Q2SEng1H4hdGmjXPx
         PX4PY+oL/SekL6FZC8n0Ji000zsDy0cs7sM+xU3BzJkPodvULhQh940ci63re/rWO98D
         2bbVmlJDg6X7pOQRqpjlHGaUNELq7OXtun8yUWfwsjDN5p3oROK477OPz2psy7O6Eavp
         CX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045321; x=1790650121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EwWA3LgMjt74XDEZ31Q/wUl2bcv/dp/523dBsTBjRfg=;
        b=2ahFnsvjn/jjiz8SeMNXzEohtbqIvVxF/0nTqwIXTSMKxAjaLkdpmZk6n2IAgzwHWv
         Hdu0cT/ZSCXUhJPNfCPr/e4ndWTcLuyUYg2qkpSyHCbMeiiiXQHmKQ4q8Cr31BrYsTMa
         45eMQiTbYGGFpP4PJXBQHfobQ4BAGfAodzJIuV5+0/olp9RIb6TFK31NGhGq9eJs7hbQ
         vU8E+2E6P3CSvRFJlvHT7kHQxc7kzyxa/dhoXNM+bxaqTQ4yH9F+q5l/MaFmRwJYDFoS
         aH/3DT1zRlxZRlUc7g+GVh8M1BSUcUOLHy37xh6ylEeplRCcImjflp6dhXYANZQRGOUX
         mK0Q==
X-Gm-Message-State: AFuF++ln3yVfZqiM4syHHe/mgYhu8e0ylodhPnKdly9sn2zCMLWUumPj
	AtYM8RyEmTp27fXr5jPdSP9V38d6rLja7vAkPmxrti4okRKozu6dl3T5B4UAwe5FRiXvRpOkGTA
	j2uSTyoKwc1Hy3zOR/gYyOUNMP7EGrtI=
X-Gm-Gg: AYBFou2mJaRGgVXcT97OijA3A6TSbJpOYA4lblq5xKCv9VN/y+8tSG51g/fPoFSQ6DU
	cqCU0fZUPevjPuByjXm9Ty5Z9PlI01XV6rC4+VUJHTofePR5FyCdgjel9fR6PQKleU7xyr+nAWM
	jdOPThoayGZ6GxDtZ/RsZVncebl3/8lhym2SPME+gcRyPYE6VxPLIaMTPphyr9UqXC+SfgZo5NK
	0PxP3ATkxSExRl4MVbuTlsQfcnrn09QlSOMQ/EOoadJHJ6RCKJsJowTeq6FTor7vJk/lPZ8Lx4/
	oVZ4TXipKq5mgnD2g34leo9pLK43wJZ2HlS2ajmMYQ4ksxJ5mzu/R+ij8Q==
X-Received: by 2002:a05:690e:4419:b0:668:9230:e266 with SMTP id
 956f58d0204a3-6717fdb20a6mr2869967d50.46.1790045321076; Mon, 21 Sep 2026
 19:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919175925.3739806-1-lgs201920130244@gmail.com> <arFJeRFJdL-fwRmk@quoll>
In-Reply-To: <arFJeRFJdL-fwRmk@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:48:28 +0800
X-Gm-Features: AcwNN1VhjH0umtEATXdXl4Fw6zfObXCRNks60FtGl0HS8f4Ga7r0Rf1ihREbjxQ
Message-ID: <CANUHTR8we6L7TXR7_HR-xZK1kYWnqpoUY2sGcrjeFOHn=Hxf_w@mail.gmail.com>
Subject: Re: [PATCH] dca: fix provider device memory leak on domain allocation failure
To: krzk@kernel.org
Cc: stable@vger.kernel.org, Maciej Sosnowski <maciej.sosnowski@intel.com>, 
	Dan Williams <djbw@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:13, <krzk@kernel.org> wrote:
>
>
> On Sun, 20 Sep 2026 01:59:24 +0800, Guangshuo Li wrote:
> > register_dca_provider() calls dca_sysfs_add_provider() before looking up
> > or allocating the DCA domain. A successful dca_sysfs_add_provider()
> > allocates an IDR entry and creates the dca%d class device.
> >
> > If no domain exists and dca_allocate_domain() fails, the function
> > returns -ENODEV without calling dca_sysfs_remove_provider(). The class
> > device therefore remains registered and the IDR entry remains
> > allocated. The caller may subsequently free the dca_provider, leaving
> > the IDR entry pointing to freed memory.
> >
> > Since the class device is never unregistered, its device reference is
> > not dropped and device_create_release() is never reached, leaking the
> > struct device allocation.
> >
> > Call dca_sysfs_remove_provider() before returning when domain allocation
> > fails. This unregisters the class device and removes the corresponding
> > IDR entry.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: 1a5aeeecd550 ("dca: registering requesters in multiple dca domains")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/dca/dca-core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
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
