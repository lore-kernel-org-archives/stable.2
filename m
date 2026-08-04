Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DBB46C85B
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855502; cv=pass; b=YGYMGdHcKQP463IyNicNhQHVZpRw/Cxq4uj2MjtsuToGLJwmaPHb8hVZlOURxlI2O89Y1xWWf/FnlRO4tygSrbY2RbxtUtBWDXuJyrimmEKqReGfP2Q3luDZxhBmOs+TY5FF+j54l04dsgjpTChx+9zkBEg5ibSmvuoEXsP0r28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855502; c=relaxed/simple;
	bh=sqpxW+936twxLe3WmzLdq8tvXCx4QLWmRhhPEOQUQvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emHhGLdl2Q9Cfmb7TbKlFxYIp0xb8XfBLw4umTEGccxBIbUWoMRkgy7kTMICUQ0exPr3pEmKewiTMI+8u3dTecAPZ03QAgclfdbSTljOIVZYLwF2ArLpVIeJbiiHQAOgEwyqfTRxgYdeFVof7nvVIDCXwryDcmbVEYtD21Iix1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qk2xol+U; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qk2xol+U"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso4434067a91.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 07:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785855485; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMY3v5Q3dyoFDUmH8KFrnX/m4OfzIVAUgjflwBKVV5vfLRvWzEv5O3idrBsU9gbdYy
         8gfmGAUXfIP/kwT1RViUVTyujnlHj/A8DePJbRVCKlYSlmbf36mXYh6wqDpwJwfu8Csn
         SCo1Nmbgi09c/mFcvWIhXm63zZYUwzgpFbBcIYir9Lsdd565cntXwqQGgQGKUiUYNwiw
         LDKxv6XwaEkqZ4C6mhE8t7WoWN970UqxG6hMTRpbd53bsOe9Z2u6/WDFje5Edsa8sdAZ
         5ux8VHNng4DBTuyXXrc3wfrvbUhqpQFNy3CoRnNwMr0anXfUczvSK1eIzlmkNSXJbKL1
         fv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXmm83TGVs8V0++ogZvMrKHltLz+j+PoXOcZxjRNY7o=;
        fh=tOKlpq734vgUuTMazLnVU97YnBXGyBMffrBRo790qIA=;
        b=o5UD9v/bKXM9cwsZRQbWiLdXnIxx8n/5CIKsLpVhkx44DdNk0yhyziYYNEJ8wl14gZ
         8JUUuWeAFY10XexVamJRA8Ut0FglFgxEkILYFf71bCFFp7uGKVuhshXB1JCPvzhbMQlR
         UuZ1aRk3B2/4L3vPWrVlnSDiyeDSwfBa3C00sgyFcf6/qUY0MPkWAqEZbOzIty/jbyqP
         a6/NyVLDMCV3qxT0RbV7tSOWIFp/NO2Bn6dXsCj4M+foYK8mnCHErj3G4+l7uJGS0+n9
         McjPUqDjyMZ470PNr6uFxz7p0CI7rSPY6cXhziLXXlwtSX8cGlq2sgSlLWiypGQRQrWG
         vG5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785855485; x=1786460285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXmm83TGVs8V0++ogZvMrKHltLz+j+PoXOcZxjRNY7o=;
        b=qk2xol+U6sdMGjAOwM1AmjBXFqr12EwRzHX92fGk2l0wd5OdvNCUlR1SRoIVIzVepT
         c7YJtnowmOEY+AITa6XQpJz9bSSRXpjIywHv/1QCAmPME834uqCoQ77Qxg4BAg7jVl2D
         i/m+/CREUZsSw2WO77xo7AVLIhXr6zBg53LuZD6mgQaGtsnem2LOjUFjFLx72sCWc6E5
         kuZa2L2tbNa7DKSiw7LXoXXA/6ZMgW5YSKY2MpWZN/BMsalw7ecqVdxSwTUwdgbK55Yq
         K0Jsi4e4Li1Wt86pLFB7UV4mNvB1jgHcG1zGviyq5tczgvUGE2uf83cd8kz4bV0BiCoy
         7lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855485; x=1786460285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXmm83TGVs8V0++ogZvMrKHltLz+j+PoXOcZxjRNY7o=;
        b=I/1IEX8J2/NRY4/bxIjhcSrb/cczh4WZSJJdxlYEf+legHETvgbOVIIhUlm4vno5an
         YDFi+/yZ3QE60ZouDOhA5hwNikFuDXpv43v0g0QuKIoVC3QmGRhUFNOVco0IVpngBUWX
         +SAIN+phUMtOfRAz3nPwGwO1GWPZcGdzzWfvZaDOjsqEuqFyGSFYq8GJPQkmxTfgg9dX
         L5G/ZuulpNLngImiuWmfq++j6aZqvHPQSF13bVFgON4d1XCbJLyomr4MK0nNBsc+CYSP
         cC1AHtmoqwLMusgQyKS8bAC/zVfKytKh7zc6Eu1DxzsIX+SNELH4ASlUVwf+2++2Ishi
         3h1g==
X-Forwarded-Encrypted: i=1; AHgh+RrQ4vZ92T3bKxabAYFRGR0UAtNY4+koSi5rgHIOdn2kvX7vSExFHO/2RHaKxHsTycB/eeLsjws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5nntNEwqBv4hL6nfTD0wcbsWrQx8a0bbeX+Zlmxf0iuwH1FW
	ICAL99fYnFgYnmDda91phxNka6VG1COBUl7TlOAmAFcGrivuMPjavWZWkn8p86SChLqeasqysHh
	YV6FFuWMtIa8gH57n8wdzQ8XsoRKyg8o=
X-Gm-Gg: AR+sD13xIdjX1noO8k+uTeWotoaXMhhemQeA9CfOtFYYzYmOFtI39pu3MHYZ2cNQkrI
	q79p2PuWYOGzvfg9i0ta/K4AW4BULzu3LfnnLXQsRZUkikeSIKpPduWvBwSDRVbZiCAM5vxxoYz
	dtdy4HPA86wOOiv/f32JodoPvnBE7gwJDZh8pQt/9o3qJ9BHiB3yCxuFI+GN2TQLe24/oBxjpv8
	3T3YPB77cWQEDEddoeD1DiuCcB4px3UfNYgkrx9oedjuOy8O4S2s4zn4IQEFo4ZLJjpV14Tdu2v
	DtkqXiG3JGLaQ2xiX/xUTYWfNT9bZJHuHGqkIq6Zc5s3oYW0IdiRzXM8+7RQMVKHIv1y7XLnM4J
	dI+f7aQieX4x8OtUiFy8rLn8=
X-Received: by 2002:a17:90b:1c86:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38fbc4249efmr13503882a91.10.1785855484729; Tue, 04 Aug 2026
 07:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804140403.16337-1-kfastov@gmail.com> <20260804162924.0268f80a@fedora-21.home>
In-Reply-To: <20260804162924.0268f80a@fedora-21.home>
From: Konstantin Fastov <kfastov@gmail.com>
Date: Tue, 4 Aug 2026 17:57:52 +0300
X-Gm-Features: AUfX_mxmYF7mTsV_kCbKDVkg1SSi2DOX7EMuysDet_SV7d52zqlljQHcxRDaOHk
Message-ID: <CABWhNekebS6dt=Ft+74iG4YpCq-5ZcV1EvvERNxT612VUOC9Ww@mail.gmail.com>
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Boris,

=D0=B2=D1=82, 4 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 17:29, Bori=
s Brezillon <boris.brezillon@collabora.com>:
>
> Hello Konstantin,
>
> On Tue,  4 Aug 2026 17:04:03 +0300
> Konstantin Fastov <kfastov@gmail.com> wrote:
>
> > Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
> > .pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true,
> > so vma_set_page_prot() removes the write bit from vm_page_prot of
> > shared mappings, and the vmf_insert_pfn() call in the fault handler now
> > installs read-only PTEs even when serving a write fault.
> >
> > For regular CPU accesses this is transparent: the retried access faults
> > again on the present read-only PTE, goes through wp_pfn_shared() into
> > .pfn_mkwrite() and the PTE is upgraded to writable.  But consumers that
> > resolve faults through fixup_user_fault() + follow_pfnmap_start()
> > perform no such retry.  In particular KVM's hva_to_pfn_remapped(),
> > after "successfully" handling a write fault, finds a present read-only
> > PTE, treats it as KVM_PFN_ERR_RO_FAULT and fails the vcpu run with
> > EFAULT.  Observed as AsahiLinux/linux#560: muvm/libkrun microVMs
> > mapping virtio-gpu blob resources die with EFAULT on first GPU access.
> > The traced failing sequence:
> >
> >   follow_pfnmap_start()        -> -EINVAL   (no PTE yet)
> >   fixup_user_fault(WRITE)
> >     drm_gem_shmem_fault()
> >       vmf_insert_pfn()         -> NOPAGE    (read-only PTE installed)
> >   fixup_user_fault()           -> 0         (fault "handled")
> >   follow_pfnmap_start()        -> 0, !writable
> >   hva_to_pfn()                 -> KVM_PFN_ERR_RO_FAULT
> >
> > Fix it the same way commit cb2a2a5b37ad ("drm/shmem_helper: Make sure
> > PMD entries get the writeable upgrade") did for the PMD path: when the
> > fault is a write fault, install a writable entry directly and record
> > the write for dirty tracking, instead of relying on a refault that not
> > every fault-resolution path performs.
> >
> > To do that at PTE level, add vmf_insert_pfn_mkwrite(), the VM_PFNMAP
> > counterpart of vmf_insert_mixed_mkwrite(): insert_pfn() already
> > implements the mkwrite semantics, there was just no wrapper exposing it
> > for pfn inserts with the default pgprot.
>
> The same issue is being discussed here [1].
>
> Regards,
>
> Boris
>
> [1]https://lore.kernel.org/dri-devel/20260804120529.1730187-1-pbonzini@re=
dhat.com/

Thanks, I missed that series, I searched dri-devel but not the kvm list.
Paolo's patches 1-2 are indeed the same fix (down to the same function
name), so please consider my patch superseded by his series.

I have a fast reproducer on Apple Silicon (Asahi, muvm microVM, dies in
under a second on stock 7.1.5) and an automated test rig, so I'll run
Paolo's full series on that hardware and follow up with Tested-by in his
thread.

Thanks,
Konstantin
