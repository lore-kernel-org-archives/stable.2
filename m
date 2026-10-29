Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793292933;
	b=RBUw1OtBvBIj2xrRoJHao5JKaaRFD6ds0CeOkrxxE4L9cyOqmoDLJdJX8Pt768LpCZyO
	 YW5Hrs+F3EXriGwiVzS4OcMFExcKi9BJ5WqEv7g7cvlgC4xIBSZhZFLs1ybWafobx487I
	 zaqCbUBigR92m/8zBh62TvSW1SNJgpzWjUh1nhJi7F3BK29xyso1TYuL8U7fLzjOosd/8
	 KdFyBli8D55X3mTOwqpAv0WOaycayAczU2iCaab2i4xGJ4dLBn4sNS1XtSKw6EfJ3rnke
	 fwUI1R/iiw6A8cYz86or1Nsy97fiJ60rmq37nH7fsOyKsw/d5Q7jPT6CHfLZi43r9Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292933;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=TXB64NJFF4WXwJ9sa1LPJLwRXbNGHs0rY5npnlz1t+E=;
	b=oaguDkzQFywOMH20ItzjyFgQSU1N2bj8o/DfQMOfxS6QL4HDCmN7Ndak76Mz5l2PQqHO
	 9qCHaBdWPkpAqpDGWuH0+VsjaevB0vSR0Ozl2csdGMVV9fcg0QnltPtHUbToW/9rwRMAh
	 cltXIRrLz9RBCOs/rs6g71D2LAWxKLIO/7UElDFVUeuPQgO6FuLrZc9LmACfs4UAxM3UR
	 W/ooFeNgCrochs1QcGIVvKT843HFsvjS5pgj3JleyMrjoBqlFSi1GtpeNPIlmYR+WUJBf
	 kgp8e7zPXewHbD7d/BiF/ydhV5ep0Fx0zU+BgYzU04dB7AdgG6b4sqft63fjQ01BCgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RhlV2mA2;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k4loJjiY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B425606A320
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B425606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RhlV2mA2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k4loJjiY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793292931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXB64NJFF4WXwJ9sa1LPJLwRXbNGHs0rY5npnlz1t+E=;
	b=RhlV2mA2079QE8KGFWHDWxyHgvTa1V7KLCMFbGfYjQLmoqrFLrDf6peIwYAp1I8z+dCkbM
	DVBfVI8E/JVazf33ezs84DVdIjzJKcY0AwZ9VukHGHxaJhR0rWb0+s00jGtvBlr+F2XirC
	XvmmUlheQvgshdurmcCGyEHgeJiFpTk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484--QoFQgTLNYCUS4pl7BBYXA-1; Thu, 29 Oct 2026 12:55:30 -0400
X-MC-Unique: -QoFQgTLNYCUS4pl7BBYXA-1
X-Mimecast-MFC-AGG-ID: -QoFQgTLNYCUS4pl7BBYXA_1793292929
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f568dee56so347004485a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793292929; cv=none;
        d=google.com; s=arc-20260327;
        b=G+jHQijNURleJzTxNEhBH4DZj7JjkCMFqcy4o+LEe8qOj1Cv6vxzm72XEhxt5hMlTi
         Lc0yWIyQSXmQOIdYdsPw/A+lCiUk6xQSPPVcnY0BJqk3b7uTjJt5kvHxQseSAzQiLjLQ
         G3NIvsS3P1c1og16ooBhnzQV8rm3pw2Nu8TSIplDgRnrn/StyUbDQ7ZBKSE4DZqqpBaV
         RK90ta+Z+/ShMBtShfcv3DKuxWsjpUMY0JaxkE1UGZLem/DTFiUSYIKLhQoPV9PhIdj0
         RA5+6G0Yx0ANmSLjwICuEhIUiOePue7eOo/ASBsWUI/w+MzulXZlhKOnJaFUqKxaPoEa
         AE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=TXB64NJFF4WXwJ9sa1LPJLwRXbNGHs0rY5npnlz1t+E=;
        fh=CfH7jyde99rY11SPeAHoCbXvngRkTx/LU6HGcIULoa8=;
        b=fxgd8rMFp4CblizuygQSecM3VOIe4gPmJklVkYD9PR/8m6sFjVzGPPan5ZIJ5futPI
         SLfkj9dNqbbcfyJSYB7v/88bJTAY7E+haqmrBNHE79v5BJPvEW6cbWdY8t1ZUNxgRTtG
         8/b18qJEz2s0sP3Wg2ZM2X/Bafa4ei4qR9ws5fH3R4w1S7izvisEysYvErdwR2gWiq/x
         ybB5E6ssK+Ta6S5Y6XuNrDjlqxvWakmeaczm9uFwO6i9dDZeN/dv1AS55MR7B1PItMqf
         YxYyRsZZrdXTCRUCVzCn4ID7ztDqj/vj2EKGSaKp/JBSG7/6+qL1WY5ILgG46UBa9qLJ
         QuZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793292929; x=1793897729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TXB64NJFF4WXwJ9sa1LPJLwRXbNGHs0rY5npnlz1t+E=;
        b=k4loJjiYuPsPj70mz8xAQiOcH7lPyg94p6jK3SllFObC/N/YQ5DcZOyeymkHcPGTCT
         SmPrvjYWw/GzsmVN6Z2ONecvAiPUdMfvH5E8DBW0D5ypPgHidYgrwS4Ckqh1g2q3ReSO
         f5xRjSUiYvVF1Tcd3NBh5H78zoB5wEZ717+Plw9UvXZxvDqj9XA8UWrmhGGiHd42jFvB
         l2qWA1x9bS5ZyWNalD0dM5nmN0N5ccxEiesOagFI/HOOhR689hGy+TabBO5zBqMwf3wY
         ZLR8thr20iOwmIalPt9giW0sQJMtkolDhwI80W/R2SBs4h3hczloX5AK6CxY0xeAG78K
         nLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292929; x=1793897729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXB64NJFF4WXwJ9sa1LPJLwRXbNGHs0rY5npnlz1t+E=;
        b=KPzUminIKmcqezbU2Ev19Af+XAUX+6Gj/4gFXoQCAviwVzwQ7tLekBNosb1bBNJ3Cb
         lxQDZdYvvaO8edap9+ln4O+Rm/hk+gFw2rwKZQ8M+WwXr3AjWKJvmOlMBtTt0+zXdv/m
         Mk6mWESWnRUM8fql+SCWQRDnf5H8PdgfFRkHociJVw4o5AiP0dDxBemoAHVgNQT1a5/j
         LpfIohQpUhqUn2F3hdJFi0DuYc61vP6hEdvBMIHNCRO5RlFPBpC3w8+Nw4JE6IrntwY/
         3Cw4vpobCJIlaqjpp/ckCZX9OXtldMU9nExKktqjuas3+43gZnR8fMcPPuMUCdA24Nzg
         kz4w==
X-Forwarded-Encrypted: i=1; AKwUvBxfopSvjQx5ifK5JhKOqZzgSI6buKIQGhAgclAdiEtJv6JnaIxaYf/Yz302B9REQaOBw6Z0pIQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD4A45VOVxhBsQOGVv0zRL9j3ZwdjEepD7RDZZ5FjhWHNeJpJG
	Lc0DTuMUUugLxGQknzQGQ4sSvTOn4whljEbjC0CPv4Omb236M5wLvIQ8YtxNFbOmGqrgo1kiBUm
	M2hw1fMgKEBmqDfOKsa8PRD5RCk3I5FhLSrk3FRX6i8tKi22gq7UZeMEqThlcEcIwm6K9FYBRgQ
	XF7BIRdmteuUaRVRivEqWsCcgF2SmqDHYO
X-Gm-Gg: AYBFou3TcmfzUsZoeN71F6G3arJoyHfA4vsbtbf3rIHy804pSCkPgoQMG3S0S/Iukfg
	Xr/dEF5AOwNFeZNWGi9KM4B1NrLAm3CdjmqP8+XUgjZ/n07TbthzRYIUbRouHFn/KEN/pVpSkEI
	obstZx5BK5MsvbcVPJCsS1XTrcNR76+pOSQ882hXQuuZOCMpmqf2cHDcs=
X-Received: by 2002:a05:620a:1a27:b0:93b:ef24:bc8c with SMTP id af79cd13be357-94408cde203mr957070485a.47.1793292929310;
        Thu, 29 Oct 2026 09:55:29 -0700 (PDT)
X-Received: by 2002:a05:620a:1a27:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-94408cde203mr957065685a.47.1793292928789; Thu, 29 Oct 2026
 09:55:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 09:55:28 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 09:55:28 -0700
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <18f0bae1-5cdb-460c-a147-33cd1fa2acdf@leemhuis.info>
References: <20260804140403.16337-1-kfastov@gmail.com> <20260804162924.0268f80a@fedora-21.home>
 <CABWhNekebS6dt=Ft+74iG4YpCq-5ZcV1EvvERNxT612VUOC9Ww@mail.gmail.com> <18f0bae1-5cdb-460c-a147-33cd1fa2acdf@leemhuis.info>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 09:55:28 -0700
X-Gm-Features: AclHuK-xgAN_fR_dbuTYNWejWEVdFE5MAwn_KoUGHzvKxdpt-_9FR1Wg7w13_Us
Message-ID: <CAAiTLFXd=LK93e=f3PE1f6y5m15yVknqqVNBei5rLz2AnSJ4pQ@mail.gmail.com>
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
To: Thorsten Leemhuis <regressions@leemhuis.info>, Konstantin Fastov <kfastov@gmail.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> [CCing Paolo and Sergio]
>
> On 8/4/26 16:57, Konstantin Fastov wrote:
>> =D0=B2=D1=82, 4 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 17:29, B=
oris Brezillon <boris.brezillon@collabora.com>:
>>> On Tue,  4 Aug 2026 17:04:03 +0300
>>> Konstantin Fastov <kfastov@gmail.com> wrote:
>>>
>>>> Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
>>>> .pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true=
,
>>>> so vma_set_page_prot() removes the write bit from vm_page_prot of
>>>> shared mappings, and the vmf_insert_pfn() call in the fault handler no=
w
>>>> installs read-only PTEs even when serving a write fault.
>>>>
>>>> For regular CPU accesses this is transparent: the retried access fault=
s
>>>> again on the present read-only PTE, goes through wp_pfn_shared() into
>>>> .pfn_mkwrite() and the PTE is upgraded to writable.  But consumers tha=
t
>>>> resolve faults through fixup_user_fault() + follow_pfnmap_start()
>>>> perform no such retry.  In particular KVM's hva_to_pfn_remapped(),
>>>> after "successfully" handling a write fault, finds a present read-only
>>>> PTE, treats it as KVM_PFN_ERR_RO_FAULT and fails the vcpu run with
>>>> EFAULT.  Observed as AsahiLinux/linux#560: muvm/libkrun microVMs
>>>> mapping virtio-gpu blob resources die with EFAULT on first GPU access.
>>>> The traced failing sequence: [...]
>>>
>>> The same issue is being discussed here [1].
>>> [...]
>>> [1]https://lore.kernel.org/dri-devel/20260804120529.1730187-1-pbonzini@=
redhat.com/
>>
>> Thanks, I missed that series, I searched dri-devel but not the kvm list.
>> Paolo's patches 1-2 are indeed the same fix (down to the same function
>> name), so please consider my patch superseded by his series. [...]
> FWIW, it seems that series takes a while to get polished and mainlined:
> https://lore.kernel.org/all/CABgObfYgZ87%3DW%2B6E%3DN%3DWwTuyYkaoKU3hqd84=
JDTSAvT3_9dh6w@mail.gmail.com/
>
> To quote: "It ballooned a bit and getting acks from everyone involved is
> hard... Either I or Sergio will get back to it."
>
> Is that something you/AsahiLinux/the world can live with?

Asahi still ships their own kernel with downstream patches, and have
backported Paolo's series. But for the rest of the world this is pretty
bad, as it means anything that requires virtio-gpu with blob mappings
(venus, native context, etc..) is broken.

Since the proper fix is going to take a while, I think having some form
of interim solution could be a good idea.

