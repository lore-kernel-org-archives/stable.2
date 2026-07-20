Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB8207A20
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591066; cv=pass; b=Nts6vMOnf0pD6v7V6BmrCBOXeWNcoiIlw716RHPd7lP8bbiE0taoKsS+dDptRl+4CEeOvfstyfXIQFYCbKsDQwLkjTtkxsvFLCwTxoY3bOYSGLq3kJ8uKY4AX/YvhzDXGG8WAfxVWhiJIK4qElySuEX4TbNx3cfsDiHDkiT/8H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591066; c=relaxed/simple;
	bh=riG3LbV3k8BvVbdgieZV9J6mlRu1bGRgQczBpq3mS/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEKv+Tp5F6RGEGfH06va9zGdT3Jjh/RaXdk0PJ3LRIvNtkUvjIUT5ndhmbhyC6+TlwZwMcqzhkTx4kzoA2kjdgOHvOA10diZFtgan8+Qx+AhihOvy76ati46Vs35gaFdr/sLltqFJTLnfcucDrVeepQRgRjDh9xRZbRuv4I2Uzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4mRYLgM; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4mRYLgM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cab97c86bdso468035ad.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784591064; cv=none;
        d=google.com; s=arc-20260327;
        b=CBfr8D7eIG4Um2SFmgntKAVuSMTIil41h2iVMheBs7SLi1rLW0khpgiqn0ZoPlVTPh
         mm30UBEzaGsu/Kj+NPrDaOtMY2epK3esZZI17iXE/rPvNCre59ta1lAQWDc97tibIeE+
         hPC/DnoDi1mKsl5BHx33II+PwXkUT05a0dx8Bba7DAqcJCVkFBR+/vV/2Ju8VI+e18A5
         1+T8G9tJuVEM6/QWDtGbmEd3YpNTVHUznyDMrpOFWN9nFwbizn8pbHmj1Co3ma9UXXaj
         AUfQ+0xPHCUqDQgoe3a+3ZzuO7A3eMxq03GSSFiZlKKokrgIlBr9lNl2BkdntGeLYLsC
         dFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=riG3LbV3k8BvVbdgieZV9J6mlRu1bGRgQczBpq3mS/M=;
        fh=lCIGypvCr4Molt0WarTU9xCL3+ilFBv8Xd6UJSqcoDY=;
        b=l5VvY9YwNP/IN26VEd2Kvt5y4YtbTaSBUx/cX03GW24+73z4CZGgsnSPgBUuPohnj3
         eqPfcuGElirmSD+gehyHKkjx83O06s7VRfMOqkZqLZqDiaH/HD7GWWSA9NHIhGXeE1XO
         fdxC/bTRDTjpQ/1nDjWfNrfeS+uFUdTfmFD4UEJNJlX71X2r2kXgDdi2XeuPKhHbDimw
         wGRkvUiDw7TwVcj9u7rdzFJdP0RTaPzLqT+et2UxUqysxk76+vThucFSP9UN+CvaNcDv
         sAhns8XxRRjntW5RbVIT8SQfv+MR2nJ0T8Xn0mCQWndd4HGi3sqbBLGKT3b9cPLuqhER
         whbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784591064; x=1785195864; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riG3LbV3k8BvVbdgieZV9J6mlRu1bGRgQczBpq3mS/M=;
        b=v4mRYLgMqIlVLzp4GKrs0KljX7L5yOusIrxC+R/2qtNcSk/1YQz0Ehh129uB27hwUy
         MnY+StE/vUAcLxXi+b2XmOI88pJuSpaEryXduHyzPD8SB6DCr48r89+GjVpLUKafadDR
         F2rber+lPKYxGWfxjJf+wzmU7nXUX8E357sfOjEWHcmzIT5d/zY0Rrs18RDzqR/jszrj
         0vLl3vt+1TWGVA2VoJdMIwnlZCe1lhfZJat4r4oeYpp23h5blM/qy7fPmz20Y2gfge7S
         vRBkRHX+x8p5insA1pslUqxm8klc0HQUj/hOl07NvmCyBbuXpH7GG+D4/yWvyITb7ZBF
         YwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784591064; x=1785195864;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=riG3LbV3k8BvVbdgieZV9J6mlRu1bGRgQczBpq3mS/M=;
        b=JGSHEDqTW2WdPfT9zq7baPTnrOI2fzNcR66iCYnJP0ii27p5QBYeEjFg/lVbSJ3qmT
         l/H3T+WrYZoGofLaeVj4Z+bPCJFgRnNMRfU5N11UUOxfHYdsx2J/2yxCNYN2EKKXPrNS
         KGU8wdM8TPm4D0DEWCrtZTeRb7IABip4Xbb00q9UIKz1IUv/VHPvfDcbvtylPFiaSWDX
         /NKxrZzPsqpx8gMnvyge4yQ+X0NEPZChtGPK0oyt4IFNeNHR7uyY8GGf7nyYwWmU9mFm
         mhQIKzd4zpk7/xhl8+5feFsio/ZzkFJgHpngSpy6/obmIb5Mi7RhO62w97DspxL0cON1
         6Asw==
X-Forwarded-Encrypted: i=1; AHgh+Rpd9W7bx05oLtmTXkebw6GuSzLy+i3ds/TQ6YFoQd8EAlinm6O6QxBuXEbZg8RzN1WapEJHK9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9D4pkWx0piPMgTQ7TCbgHJCPhujPJBbdF42EKAx88/WB3w8bE
	VgJwDGNn25Qi/qTTbUB1Fj1DZBgf0NvexbpenCHQtLmb9GcWYAU4yMuQCfYdv/QwWEV07ksuShT
	11Xzmc+qyHpR+VTElj0eP1gaz2w7sUXJN6uG5E8ol
X-Gm-Gg: AR+sD11s0nNc+5lYK18OltRVPf3rAqDlCiPyQHQIqhnJRWg8OBauhgAYDzdSBtZRJR/
	Hz4Al5mTeR9Qxc3y842wHdQZ0AazVkMGOt2eySi3fSysSkqDZj7+GNI8em37QV0lMolgvq5J/am
	BOSmuyw0J13HPcopZ/Fv7hHMFt7KMkkM6CwyrDCPcBLfBV/HdFBI6y3bVy0kv2JvhLNXInI+IH0
	2juPr3GbLNfgF/cjqfktQobHUxDcFZVyPOssPn3YxZRyFQriHH2sneFrdpg+ZY3nymrAFbjafGf
	fzbPtUfxErv16okN
X-Received: by 2002:a17:902:c94e:b0:2cc:a859:d404 with SMTP id
 d9443c01a7336-2cf7b6d3247mr3540335ad.23.1784591063975; Mon, 20 Jul 2026
 16:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717002311.681748-1-linkl@google.com> <20260717002311.681748-3-linkl@google.com>
 <29457fe7-0fe6-4bc0-81a8-9e67f85b3a3a@kernel.org>
In-Reply-To: <29457fe7-0fe6-4bc0-81a8-9e67f85b3a3a@kernel.org>
From: Link Lin <linkl@google.com>
Date: Mon, 20 Jul 2026 16:44:12 -0700
X-Gm-Features: AUfX_mx2yFU1L9Gcg6BFQSpQ6hI0WeLlvWjDg_00zh0kZZHsctUEsZJDtTWk7bI
Message-ID: <CALUx4KT_EPWmKhEb5hTD2tk5k+WU2oT+q9Bwk4z1sHBKi0ZJ7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio_balloon: avoid shrinker execution during PM suspend
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jul 2026 02:17:24 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > reclaiming free pages under memory pressure can trigger page reporting
> > which might access the deleted reporting virtqueue if it is not yet
> > frozen, or interact with other parts of the driver in a teardown state.
>
> i feel this is the thing to fix then? not the freeing itself.
>
> ...
>
> this is remove, taking locks seems futile - if something will acquire
> the lock here, we will be in trouble.

On Fri, 17 Jul 2026 11:30:44 +0200 David Hildenbrand <david@kernel.org> wrote:
> Why not set the boolean immediately after this, and call it "shrinker_disabled"
> instead of "suspended"?
>
> Then you can keep calling "return_free_pages_to_mm(vb, ULONG_MAX);" here.

Hi Michael, David,

Michael, your intuition here is exactly right: the freeing itself is
perfectly safe, and taking locks in the teardown path is an
anti-pattern we should absolutely avoid.

After re-tracing the execution paths based on your feedback, I
realized that Patch 2/2 is completely unnecessary.

The FPH shrinker doesn't touch virtqueues itself. It simply returns
pages to the buddy allocator. While this can trigger Free Page
Reporting, Patch 1/2 migrates the reporting worker to
system_freezable_wq, meaning the PM core natively guarantees that
worker is frozen before virtballoon_freeze() ever runs.

Furthermore, any asynchronous FPH hinting work happens on
vb->balloon_wq (triggered via config changes). Because vb->balloon_wq
is natively allocated with WQ_FREEZABLE, the PM core successfully
freezes this worker prior to virtballoon_freeze() as well.

Because all downstream paths are safely frozen by the PM core, a
concurrent shrinker call during suspend is entirely harmless. It will
merely return 0 (since remove_common() safely drains the
free_page_list anyway using ULONG_MAX) or safely execute without
interacting with a teardown state.

David, thank you for the cleaner `shrinker_disabled` suggestion, but
since the asynchronous workers are already natively frozen, we can
avoid touching the teardown paths and locking logic altogether.

I am going to drop this patch entirely from the series. I will send
out a single-patch v3 consisting solely of the page reporting fix
(Patch 1/2) shortly. Thank you both for the rigorous review that
steered us away from this unnecessary complexity!

Best,
Link
