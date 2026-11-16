Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837884;
	b=2VgPkhFOwLsuNj+OfLOeAJ9SWC9i9pulBbNBoVtq82TddmkE3sCDrrjDZX6+7WhOi8mX
	 Kreg/pRtHVBim+KAupdCxIn2SL+PusWrUWB8dJu4y9VkPy9Wx5DD3hL7G6PoIEm9aueWX
	 U7bIj+uNI5TjwyAIFLjxtK/zzHfytcyW8qdcYz5P4tkFM197d30Q4LhCoEqlXWGBUO59F
	 WOneVoPZZ+iuTz2DZDVS07/qGvC5+DclBXULxfX4IydodZwvRDNaCmJDaxxTaUYazuc8e
	 nzLxvfV2gok/a7TXLsR5s05iJkrx4PEfyYXv5v7YGlx1W+4uD/radyjFiRk0IqXIDHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S/rwSMYRmKycQT+Q+WaK4Jt3aNV8OhLQHxBDEKKQbT4=;
	b=XFYPgfztU0XuQoC3GEBp2mtV1EgxtALch0y+qbdyitfV28Rv0xpiSZYlxoP5u5o+b2LS
	 q7BjMB9+ZEMR3BxChDknuMGHFWyy/WnnvgjtzWU2lTTESHNpdmYCw3ZE+fhrdtrk/puI8
	 8gAwDu4x+uNVgaVEHQKhbxZSnwfiVuGVwQdVsx+y2Jv6GjRQaXUfh65cLTMasdPAe/y1y
	 b0UXUkc/547OHrLuf1bKN1Noy9DODpgc9lrbLaOOOm0T2QjPfOnXdJrjWNBrQnPJlEXQw
	 T7HcVZBspfU6TWpZ4xBBmBrqiy3PjBQjbM7Rz25ebIazry3sgbiwNgzPpcDaaI/v+QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iMDzRrq0;
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5158E606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5158E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iMDzRrq0
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c148d4dbfbso3672143e87.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794837882; x=1795442682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/rwSMYRmKycQT+Q+WaK4Jt3aNV8OhLQHxBDEKKQbT4=;
        b=iMDzRrq039OpnwA08q8wxpS5ic9JrpGL8KQy/z358OVtcUiZ54zbGwg8H+DBTz2TUa
         pv7vbxKyzddHqzhLP12j4t1DO+7iKl/0/M9BHiuLRIyxxj++IfynpWG6k38Gsj2NpTRT
         lnNmpMTz6kojOLl+rxFtA6JsOHtgODkqvBayqBMVmN1im/h4vh7rPe7aLetErqimSCrH
         j3Ti26DTCPJgzhUIndG/qgGDIGZTr4nnqcUKOg9RcAPAGee+qie0GBa166KTYMq1728p
         NWGKLrYv7vYNUbG4/r76nfnL2eLkmsx98ZMIxoE/YwRqTkcYqFkzWBP3UDHylAVc9LRY
         c5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794837882; x=1795442682;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/rwSMYRmKycQT+Q+WaK4Jt3aNV8OhLQHxBDEKKQbT4=;
        b=pdNpAP9nc/H9IMEaT3oEO4em13k472NuG1VedlLeoycGvHnfKHF7oGBjNGjLPkOKSI
         j3QzBgMRc2R3sNkIZcHJkN5l/KJCO2nGtmAb7aZTVXnO+7MfOIET3QkIlpbVb5Rsc1Rg
         vlcs9Wt+0SB8NMONsyvTm8uUSjfmwLTSW2M9+9IC6jAsJzMbNxBrZsL1kXwV5OmHldgU
         mihqN/tsVZwjpmHxjwIUIzPPKS3TK8THDqhqQNcQXztWj3maSJqvKMnRWdVAbt9tU53f
         4kLi8pXUBRMBCPQySOeoSj+iIaiCfc4W2dXdK+j88J1zGCWuLg+D+LLnJ6o0Jo3qlSpS
         67zw==
X-Forwarded-Encrypted: i=1; AL+hErFYLnXVzww3t3gPADhB1L8f+H/bBqvbmxhEEziWSSJIGk7lvy8Xo+Vn2xsPuWvJ+WEAbuXY4Aw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yF7XcHinQr8ckkyiWPXhkVUp0/Bv2GSEwbfIV0qOzJySyJvsx
	jZqnUdZR+Dn4hvyXvQvNjuLw0atgvPZbxqQTpwuZI2OHHXNBSZvKUVo0ZP4Z+MKirg==
X-Gm-Gg: AYBFou35ZeqW8XigLOXzsInxEhCJeVEeWf43VenGFErxHQ58RrRdYeGhJbG/FoIEr4W
	SSMN787UuNtIOn6KJzq/MxNfhORHdDhRS1T0vD+1fJBPhvXioxyuLnusMEQ8a27ki83pwFUNZAa
	ZhONM0ZjDIKEvGalEzDfyXamkoLaCabho0s92BPTFZMi2KHXN609OGjv4XCgg2l6mNH/GhHcp20
	kn3jHwNadrJfM46gSkaQ0ZLYzv/v7ABS0BI7ZENsuN+khN6nWKhX4mwSnXJ4UR52YoQLW0/Gf5D
	WQGRhOgzHP1BKrwPaYLL7vDwao18s9c9jrjk4uQDeZ6ySDE1Hgk0+O0BZ3OjwVPH0uRxiVwkEVk
	5MrFvEjS1MLHT+IRvcWPxudPVc5zb4EjGPzTmgtHYFlj4/AN+OrIEVmn0jTEuUscHsZzFKA39FA
	c7LsqoK5ACX2FP74NUClO1n554vDbZ/YWyvYNVykMoJWjhsPnEovjrZf7h0YOzl5+ueLdoUbSpq
	sJbFCAtwkD7EbD7XxP+/WWG3YGuww788zpSHOZyM715Eds+e97aAWJHdu16ym0ZNI8mbgsCwk9b
	suVutE1By2E1aNGNLoAPRuVPABMwgakI/3VAoSkzzs/hXR+B/wGWxOuLJI2xMsAeqw==
X-Received: by 2002:a05:6512:2208:b0:5c1:5970:ae1f with SMTP id 2adb3069b0e04-5c170a25d42mr3870536e87.63.1794837881958;
        Mon, 16 Nov 2026 06:04:41 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8d66esm20599601f8f.57.2026.11.16.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:04:40 -0800 (PST)
Date: Mon, 16 Nov 2026 14:04:36 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drivers/virt: pkvm: Zero and clean memory before sharing
 it with the host
Message-ID: <avsNdPissIDAb1hA@google.com>
References: <20261116110549.1863653-1-fuad.tabba@linux.dev>
 <avro44jUWOARFzul@google.com>
 <CA+EHjTxWuiyjmUc3vH_KxRtS_3oX5w=CE76LdsLcrqC+RzLGfg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxWuiyjmUc3vH_KxRtS_3oX5w=CE76LdsLcrqC+RzLGfg@mail.gmail.com>

On Mon, Nov 16, 2026 at 12:25:43PM +0000, Fuad Tabba wrote:
> Hi Vincent,
> 
> On Mon, 16 Nov 2026 at 11:28, Vincent Donnefort <vdonnefort@google.com> wrote:
> [...]
> > > +     /*
> > > +      * The host can read the pages as soon as they are shared, possibly
> > > +      * through a Non-cacheable mapping. No caller relies on their contents.
> > > +      */
> > > +     memset((void *)addr, 0, size);
> >
> > Are we sure we want that? The guest may want to setup memory and then share it.
> > I am not sure about modifying this API.
> 
> Right! I wanted to fix the bug for the ITS property table, which is
> shared before it's initialized, and totally forgot that this is the
> path all sharing goes through... I'll drop this, and put that fix back
> in the ITS series.
> 
> > > +     dcache_clean_poc(addr, addr + size);
> >
> > I believe the hypervisor is already doing the cache maintainance when the page
> > is mapped back into the host. (see stage2_map_walker_try_leaf())
> 
> I don't think it does on this path. host_mmu.mm_ops doesn't have a
> dcache_clean_inval_poc() callback, so stage2_map_walker_try_leaf()
> doesn't do the CMO for a host mapping. On the guest's side,
> __pkvm_guest_share_host() only changes the software bits of the
> existing mapping, and the walker returns before the CMO in that case.
> 
> Cheers,
> /fuad

Ha yes of course, that's the host s2 we are mapping into. And on the guest side,
we are only changing the software bits, so no CMO. Actually I should have read
the comment in stage2_map_walker_try_leaf() more carefully.

That said, I wonder if that shouldn't be handled by the hypervisor, just like
hyp_poison_page() do the cache clean.

That would be slightly slower than letting the guest (who has a mapping already)
do it, but pKVM is enforcing isolation between host and guest, and it feels like
it should do it by default no matter the memory transition.

-- 
Vincent
