Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109760;
	b=4pvap4sbN0ZOfGWuPezFEb274BGhF8Dacf9OE4w/Zjzm3oNf4sO2NA9Pev9RoL/PP4So
	 yywwhtIKW4pmuI3qZpcSotHgkqbIO0fT8EDePBuDIHH4Uaxzec76TtjEiGscg5yg8LKgL
	 f3Q32DcdcRC2xXeaI/TRGEi2qWVXfPCeVk9CeZe77kC5wl8H1P+MSQLK/J9laX0vKQOWu
	 cp0kZ3aJ1OMiGXy5KlPUb/pJpBq87Wsg+qE5gWf5vjmdSKqXlkYWEh/9cD8eruvjRg/nT
	 I2WT5gv3TxRr8gKj1eV3xMeaZK6wmb9Gxy/zXi9TDKnxOR8Q91hACOJFD3/E2cTGPIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=1o9096nWf9ghL1mNo+bNKs9Dd0gIk9ZEkL7EBJmA/hI=;
	b=SQQlkLEgZ2L+JMWCXFMArR5MteFlEzGasdv6eKY2WLgJdeQDYt1pUaJd2yxm9ynXT/Cy
	 ywBU1wN1c8UeIFaPamIXmmkEinONq/iXZkCQQykBAOI/3rgKKf1mjKEb3YsIgRdsM9uVl
	 oqWpz6h+dIr6ElNPGALr5gq5pieNkJkPX5cl7CoEuKRjZoVbhgz7hdIBx1hE+DVpt6nEu
	 ZflQlJOw14XWkEGaVZ0aYpbuqcndc9dTd2aZN/H5SuyIZJGkb8uPfGUAiWPXqWb3whxVU
	 Q32Q/d0gvJ60yXyF3gCuVena0id1AA8MHbTo5eVC3LAwluVnvWrwDbYE9TNC9urb5Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ir3jNTPw;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E3606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 461E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ir3jNTPw
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eafb65e169so2862282e0c.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793109759; x=1793714559; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1o9096nWf9ghL1mNo+bNKs9Dd0gIk9ZEkL7EBJmA/hI=;
        b=ir3jNTPwDNyatsm9BxPi+Aw5N3wKTKrSGFy/dToJ1/s9I5I79ZVy2JXbTFkOXOeGnl
         Q0/mimig9l4XQK4eNW0ry4CJXFT9lsvyZ4jZAlvjOxdi73pFY4bxT9C+v47TA1qbv9un
         aneBQAzm9dOpyJjj4PGNtKkSebDoXSx3dauhR6v5iJtW8JfvpThzZFuoBTXh0lxm5KWr
         4hGokWEMLRiSsYAxqkcaGPh5iMZFrSVDzAOxKiTZzgUI4mETGcQbJCwMFrtBKHx+rash
         Lg/HHYFDUrxWL1/fGVZXKxKlOEuQky0mqxfOS9vG7EKL7IGfAhnbh5k3pNEJgZGL11J7
         5MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109759; x=1793714559;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1o9096nWf9ghL1mNo+bNKs9Dd0gIk9ZEkL7EBJmA/hI=;
        b=J3jRMNFokpzLVhkzCtCTYkIEbA7Pcpb/5NeH5AGPT+g90+pN/MgkhZkoo1tapqar0q
         jPW+vhsdUCPDW50N5+LYWDB2shbSU8GWA2q2VrQezQOHROkOl8+Z9hk7jLJ4wWcfuYGi
         urJUE3xqXM45lf8go600pWfbkhtsD5qTJ/O89vb0yDdtLWOMGAG7z0h1SwB25AtFJDvK
         enku9pDMdfxhFZnEEHGV3l7qwbvXK1cBiCysSfEes+DWW0bWMKLs7p6E7wQbptMZW+vx
         djTgEVphw4I26GJDRt6mQj+x1qyUVVAZk7jNdjHAxbTuUiCucfqRyMvuMxWkJsyF04iC
         HG/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzXoLiza+AQyaykScrIpnayz1BPC8TM/+466PCc1prqJQZdgT2b5LaY3e0cPha3LH0CrDb0k80=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9IH4yRqu/+aBNr7ISHMWvIszFuAHNac0aJcac7sr/5deUmRVU
	mjb6asQyjCwftJ95g5PlnqlE08/Xri/P2yGp7qowb/ihBOgJ2u0MELuU9WBfdxaYkRc=
X-Gm-Gg: AYBFou2A8NKCn3mqa85aahcx8cVANyG5Jn3cKlH7uWiWoR9Sj6OPuy5eEkjiteVzyxi
	c44dwXUwEdHWdfatwQkYsOQXs75ZctJQMByMAhX5CUA8NboXph+qMoWU12F5hBwumXtOw3ABM5o
	NvmLb5474ZyfknILEe08kKyfOO7xi3vabJ5uBXrnN/jS/Q6OzzPnhM1PiHp6931569QX2DBIJ7Q
	CbQ7ehW2rFQsFfi2gGI0aCFSHf9/HQqpOAYyIfS+oQtFPJu+QHMaEzldh57Gi6Vic9YLw3ElYwf
	OZot+pkh1N3hR0pfPT6dlxkPsrxgmXz9BUXJZWTJbsga5IVEuRP+iedRZF7QO2KGCIHBW5X/h/J
	b9I3uzZM+OKgUz0khu7k5vTaqxO4F0YOiPu43olGt/Ys1SpxJiwgMtocpJTqJgYnudJ3yIVD11K
	2YUPrRw66MAIU1AUGJnzFQSLWBajRn0/wjQWOCnlwa4BxsGFSv6Gp5ed+QWPHR+3welnBCUh4T7
	LqpliY/RLGhM3Df5pUVfj22xuc45dEyudULnhX4geb7/vOlw0Swg9PFpV0pgqZj5rv6Cq2mI0ju
	uQKdPRKQHToADPIeXNObBK2w/JuQtJzo6hnhlQ8320P4azgb2PrwmB236u8wPsFYwKVh0nsZXlu
	a
X-Received: by 2002:a05:6122:3c4c:b0:5ea:e197:702e with SMTP id 71dfb90a1353d-5ec23326373mr4106967e0c.20.1793109747918;
        Tue, 27 Oct 2026 07:02:27 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bda586sm103188516d6.8.2026.10.27.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:02:26 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/mempolicy: recompute automatic interleave weights
 on memory hotplug
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 akpm@linux-foundation.org, ziy@nvidia.com, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, honggyu.kim@sk.com, 
 stable@vger.kernel.org
In-Reply-To: <13a3b600-8a87-478e-adcc-2425c75f98c6@kernel.org>
References: <20261024170415.4121901-1-gourry@gourry.net>
 <e3a1ae72-9370-4c3c-8935-6a410a74377b@kernel.org>
 <at91WFlW96PH-a8A@gourry-fedora-PF4VCD3F>
 <13a3b600-8a87-478e-adcc-2425c75f98c6@kernel.org>
Date: Tue, 27 Oct 2026 10:02:25 -0400
Message-Id: <179310974571.2232644.3181896214940432050.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 14:04 +0100, David Hildenbrand (Arm) wrote:
> >>> +	/*
> >>> +	 * HMAT and CXL report a node's bandwidth only when it first gains
> >>> +	 * memory, so recompute the weights whenever N_MEMORY changes.
> >>> +	 */
> >>> +	wi_state_refresh();
> >>
> >> If the function fails, should we at least pr_warn_once() ?
> >>
> > 
> > The only failure state is -ENOMEM, wasn't sure that was worth warning
> > on.  I actually debated whether to just make this a void function.
> > 
> > I don't have a strong feeling here, but happy to add a warn if you
> > prefer it.
> 
> I'd assume we'd at least want to tell the world somehow that something is now
> imprecise?
> 
> Or is not updating that harmless?
> 

It's a potential performance regression, but if we just -ENOMEM'd a
kernel buffer to hold the weights, there's bigger issues.

I'll add a warn.

-- 
~Gregory

