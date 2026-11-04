Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793794864;
	b=cgKw+X+E/iNcTdLGxmghzIZc0Ly+2wsYzh6IXo/EGthBi4r4rzIcL3dFpLqG83A61c/5
	 MRhOuGt+WGuR4JZGDd8mCTqHKIhh+LNAagcboDqTQhTs6FdxZOpQS8nh06c/nu6lAniDy
	 T4p/0PmYILsZWYuMyLrmxELSyqJ3TJGkixmUQDnl9EMVOCE2CIKTwdVP+FHjQatB5hAdn
	 XiXyRkzCwHzGwZcWk3gCt8Dk9B7u3LHIJiCB0qp2e0QdsyAzz2nmOcMVnVYEUChJewCS9
	 XUh2HcjqE7CQ10iBJo0JfxeVvsQtSP6m6FQU9TgK9OxgDmgM8Hkfsg/67R/XBYvgtoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zpcmkLvepjbGKQ3ACqSVKunOIWNZQhJb9SW/YrhLa2Q=;
	b=sl2UM1vZgUxUM4D9F8i4ytgbKaqD5SKekfAuGyv6vvdYs0f9Ntoz4gadV8Ro06NbDjIV
	 Vm4V+u9B+4Zldr0QMO+HQob9LfEQYdQpktYlIrUePD+X8KL2pmgJCOTuRF3fhWs5cvO7d
	 wmDyX2irP9W2aGWUuZ2w7zfm4rx5VEgPsLylOtIXjKFVEsWSVFG5FA+MFWmcXjcuC3ZDV
	 hNSlxM7EVs98W/7chcz/ScIhvFUu5b50vxZ2ntJvmyDeTX7Yj+/8JYLdiOLii6pTcIaMk
	 FNTfV2UwRJL23KtHOoNjgHe/Dw0+NBloyKbTPneCJ9VgFwVdMpfYWWr8h7xvoAslYfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCA55x4D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7177606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7177606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCA55x4D
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e940d5d2beso2603955ad.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 04:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793794863; cv=none;
        d=google.com; s=arc-20260327;
        b=fqHVTh7qAtnGdKc+xaRlx07geWdvItDQC4hYrYCarRun+fw/JmCNn3Ek/V6fnM08QG
         KSlTHTLxf57QVDskMjxemnfVtsVi+RW4UXAVbVl3D7NjtcAOEm1UlRiddJ7o9XcloIKD
         t5sFmm7rvbVb0OsW+sqscLYxkDO3/zhVcHPX6QJrFnskBs01Iz/9sVM1TSaFZrJOV9iM
         rjTRz0HHWj6HkZyZyZGs2n07ximcwMgtQsLr6gADc8P7Clmu4AWHP8Wk1oYyy3YEDWY4
         iQ/uwwacu/gcSeZfIM0y4/tvVQME7BllKVgAH4ukUiduf+Cr7Wu+LKwsVFq8m15hoj7g
         BR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zpcmkLvepjbGKQ3ACqSVKunOIWNZQhJb9SW/YrhLa2Q=;
        fh=JPJiRM/cwwpYEVADYgvgAa1zL/W7+7zunKUGir5zaWs=;
        b=K8sKJejcjMOeeoShJpdD8VsfHXqnAungXR++B+g7vt59ZmfvnxcVyrRA+M8M1oWV6n
         UzSAPALyiYma9u/ZNqa6Bwh9FNh4jnETulVZSNwznkYrkT2A9CScqJkPI92uBgOlwj7l
         +hlhjPk2pgVyDB/EWs9xxwyotb4znCMyMCRAI1sYM2Pih3xlSpybGw1cMdmOBFUMxno4
         ++II1FIIqtK+oFVkaB7k0l+AaLGGhcGIrPk6GrIqRLgJsWFFHNf64yNPQ3z+Jnc2uJZH
         Z7scyRieG+1UEU5W1PpI4v1DRGK8xzwLjVGNKpuv/6sXRPga+AnGb1k9/MLHfvoFItEd
         0ayw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793794863; x=1794399663; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpcmkLvepjbGKQ3ACqSVKunOIWNZQhJb9SW/YrhLa2Q=;
        b=QCA55x4DMVQpsa4nuGxMFPfFzDhB+DJv6lDYmKzU/yOFbPBpfo1Tnz+n6zfvKL/bmM
         DA+DIemX6mFMJnvumRP7v/p/+1rWEAeR3gxNFXgLOAWDIsuKowV8fbIbTsGaOmv5x3P1
         vL0bnRVr13tnd6f2KeMlWBfWebUT+RxooinF8q1HYOcnF1qJuA3i+KZusxOJn5aPlEaR
         2IGt9aJgdmZZSJOd5241JMU3xM1pEVq+XCtlUNCfPoY85Gh9uXWcTJ8jFnQOAAKe/95D
         oKHpZqGF5nnmPMaa2zMKztX5fByxKRh7is3XGg+06VcDkV4IdmjxMKtbRixUQzlixzsn
         DvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793794863; x=1794399663;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zpcmkLvepjbGKQ3ACqSVKunOIWNZQhJb9SW/YrhLa2Q=;
        b=IbSP6ZCEN6cSgikPpW3U5bkttVcrlYRxEfU+nWuKl5/Fs/5vLCDHZRaIAZFmRLP+Xo
         /QROHyuzTxPWPVr8pam3xPFSFnayWwahN6fy0wfu5fbG7ZkXI6r8DmHQlwdE8aN1sGlv
         3xJg3OjLLjdA21Uk/+WClJqH5IW2E0TuuiJFZP7PilzHbuCJ8rpmQKAaWnTFKWI6TEWR
         5P73AVN/IqF0KHCTXs/Wyo5PYh6YrBmruYhlwnWgONWzY9PorNGE0N9tbWd7E1ogKIx8
         zMWoaE8fDNFJpMsumaHQ82Y0yeiI1VzFbTaHdMAgm4uLhMc2HDDZWAplG3fMI8PZZDco
         gSzg==
X-Forwarded-Encrypted: i=1; AKwUvBxJAjGUaIHIdD0FLYGPJEDuZjW92sG7OAWjjMmb2U+WOEj4WGOazBgCPtx7xaJlKs7I5xvtedA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YrNogBzkwNXIDrvae70piK8fQMc68xEmw+IUQLuyz5TEYnXV5
	+JU43XkMPhT9ydo++nCk97vy61z2QRDokwiSpaNhkxauUK6EGuKBQEW44heBU6vZ8PvE+HBWjZK
	N0qd37uf6jOlBg9F6jASkwezQKCEXBKg=
X-Gm-Gg: AYBFou2vPrBl49wkr2R+clBWy93zlJfu8A3kRTxE20BGfqx9XLkyqmKPMfobzdTEqGK
	xvN374XBxMVGSr8etxyKqaLNYFC9KZZ8ft7RvkdbUBf5bw0Nye/PKsZ4NPAetG/bifWzd7irKZ2
	keK0bxWCnAMJymzvZUCdpmxd9EPTgaXbzrUFWDpDyg7PGGYf0c8ZvM47Guwmh1vrAI13hZx5n5i
	DF5kV8BR4J5Tw6k3HiEF1s+DasvnhXMErWR7DaTCl1HSIHvX1jZO/jhSlMc94p1lqC6fJIt6iLL
	bdwJ2ozDW9bkczgLEgyO8rDrUS584KiAPgW+1JHIMSWM+LJjU1S+aFVEUD9G+zM/ZbjMynrzSaf
	9BnwRDXpyafpK9A/cGrLOqtCxZyHffK8SNLBkEPwoMIZmKRMpg9JCaWflgadGz6bDHdNUJDA=
X-Received: by 2002:a17:902:ef45:b0:2e9:5b20:1c2b with SMTP id
 d9443c01a7336-2eb36396190mr133772755ad.5.1793794862951; Wed, 04 Nov 2026
 04:21:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-etna-mmuv1-iova-cycle-v1-1-1148f02da254@igalia.com> <eb6dc4502166eac99f1c5f8f579cc4c4fff94ef4.camel@pengutronix.de>
In-Reply-To: <eb6dc4502166eac99f1c5f8f579cc4c4fff94ef4.camel@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 4 Nov 2026 13:20:51 +0100
X-Gm-Features: AclHuK9Q86EuHEL6aid1MOBRmfEEKC9jeoNBaMIn0yDWb2US2IJq23YE1o0-1eg
Message-ID: <CAH9NwWcGfHZ8jVHdyBoDojs67FuOq6xxLNPnvLhqVUgn89oLPA@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Cycle through the MMUv1 address space again
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lucas,

> Am Montag, dem 02.11.2026 um 13:22 +0100 schrieb Christian Gmeiner:
> > From: Christian Gmeiner <cgmeiner@igalia.com>
> >
> > On MMUv1, all clients share one address space and the allocator
> > always picks the lowest free IOVA. When a process frees a range,
> > it can immediately be reused by another process.
> >
> > The GL.FLUSH_MMU write before the next submit does not reliably
> > invalidate stale TLB entries for that range. The GPU may therefore
> > continue translating accesses to the old pages. Writes through
> > these stale entries are lost for the new owner and may corrupt
> > memory that has already been freed.
> >
> > The vendor driver works around this in a similar way. It does not
> > return freed MMUv1 ranges to its free list until the address space
> > is exhausted.
> >
> Do you have more info on which engine inside the GPU causes those
> issues? If the TLB flush doesn't work reliably we have a much bigger
> issue than just address space reuse. If the TLB entries of freed memory
> are not properly shot down the GPU may write to memory that has been
> reused for something other than GPU buffers with a malicious command
> stream. That would be a security issue that is not currently checked by
> our command stream validation.
>
> Can you help me understand this a bit better? Which circumstances do
> trigger this issue?
>

I found this while looking into the flaky GC2000 tests in Mesa CI.

Reproducer: Run piglit "copyteximage RECT" in a loop, one run right
after the other. 20 out of 21 runs fail. With a 1s pause between
runs, the GPU goes into runtime suspend and all runs pass. Some of
the flaky GC2000 dEQP tests (for example fbo.render.color_clear.tex2d_rgb)
fail for the same reason.

In the failing runs, the first part of the texture is correct, but
from some page onwards, all pages still contain their old content.
The GPU either did not write to them or the writes went somewhere
else. The border between good and bad data is always on a 4K page
boundary. The command stream is identical in good and bad runs.

The bug only shows up when a new process gets IOVAs that were just
freed by the previous process. If the allocator does not reuse them
right away, the failures disappear.

So GL.FLUSH_MMU does not always drop the old translations on this
GPU. You are right: the GPU can then write to pages that have
already been freed, and my patch does not fix that. It only makes
it much less likely to happen.

Galcore writes GL.FLUSH_MMU in the same way. It does not run into
this problem because its allocator only reuses freed ranges when
the address space is full.

With this patch, I managed to run 20 rounds of piglit in CI
successfully, with an empty flakes file:

https://gitlab.freedesktop.org/austriancoder/mesa/-/jobs/113663487

Is this the proper fix? I don't know. Maybe we need some special
handling for MMUv1 to make the flush work 100%. I could try playing
with some of the MC_MMU_*_PAGE_TABLE registers to see if
that helps.

Maybe you have a good idea or a gut feeling about how we could fix
this?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
