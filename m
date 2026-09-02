Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF489377A8B
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371167; cv=none; b=KKMW5MfbRXkMhU5B/2yBwPXObROmTqQc5XsfBzVGdajCsr98mIW1PgdeCN8aoyKzjkkLkpNEQ3a4V1zjnyD5vgD3jdcppnFWKU8kdSuFjWyMjeJ/bH8VuEkoO63vY9mYY1C/8Loup2gCNto/LtI9NWca243wSL3B2CDsNooeucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371167; c=relaxed/simple;
	bh=ukYqhyi0RGuOSajWaOkTQRPODSNPDMI/uvdyQNdZhaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3d22PCP3XGyaOqK38ArfN7my1PuVMl47Xmte/h9Jo+A7dYJ4ZSSXKwbSSp69ww3nqv30i03MUpmWME8mZ8euAsWWjF6/ElSds/sWubtrVLfKdrT9DpeIzOVEMsaIGHVI1+Vb0qA6FPGHOCWgLPKbt2jbeov2NUgHf284MzXqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MS5P6Fdx; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MS5P6Fdx"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90e7d9c747eso16800596d6.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788371165; x=1788975965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ezr6Kp9rH9+35ejy6kYQ0m2wIG/3JEQzG3offk+MEvQ=;
        b=MS5P6FdxRTf6zZMhQdQyRdyCYJgoZHjc+ksJJWvMOaQdqxglDX+yxi/yZD7mioXPLX
         tinPOUIPNe4cwKb1skSYehRaoBNvQksly4nD3FYSKBf2p+yEM+Cf6Qx0GxpBS1ZfNAKD
         65Bg27dO99juvhMITqqGWJugJFBF/6rnSdoFrSu87+juUCmCYuUo2jV90QcGVyc/A17I
         A9Cs7klleg/fgNhuFzm8uUd/6kXEBxuMzgLsyf5OIzFQzOpJiCkNiJ8cyB5u2EIABZDB
         ohKUoHMIld6Z5OIjs77jo+R7syxC4oQEIF6UZcrFKDWgirEn6ZXesTjWOvf813r7nFXp
         6Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371165; x=1788975965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ezr6Kp9rH9+35ejy6kYQ0m2wIG/3JEQzG3offk+MEvQ=;
        b=QaLFWY0+MIw87KG56AbkmbJJu6kyhJyBumZLZQK89oVDWZH3CMfhw/+axfRvEKhf1d
         s9bjcw6MnzV5Vbv0gw+9gH497fK/XXm+LMFc6M3MbEdzkfeKo8AHFcmgErDV7aIPuPLA
         gmADzG1dCqTMxM2pMNffT0eKpL2QDcpLd27pgvnC+na9jPJSZUSyacojWr68QDc7RLzs
         QeH5S/4VgbHychZEBUvnqJgJb6cvCNrNMKkwlyvyxn6W+1kVfvfkH/nlde2OhoCChhgf
         ZSZwF4I4O3NlpH4YHJrBBRPpE9JoKF027sa4enNOoXpbk8p2UmkbghFb+v/HGS9IKr2A
         ESew==
X-Forwarded-Encrypted: i=1; AKwUvBzOcha6YJbAZRLl01fzR1Lu+Udz2XR2ZTyUosveUXnue4QkmYghbJflJmuXqHtxvpPbhvxr+cA=@vger.kernel.org
X-Gm-Message-State: AFuF++mLRWD67A/wNtYifA328GCs7NMkqTRa39AUaNJnfTyyIwYZ53zN
	XZ9o1FsRr2kLu/7z0TWKJgY/XSg/DmTAlY5HFNn1a5tvGC2R57iYm6ane3uyCtX1f4A=
X-Gm-Gg: AYBFou0AtNJtheixiM98zeDZw1PMUpxDmEgdU9XT+eYxeXjoAOyfOW4YDPWPRpBx5FZ
	OMmTYCRUWTecBK+zBHwuauNWkj31oAhh09c/L8f/TeInURnxtTM/twse/Nf2swVYiHv4eJnjiSb
	44RP26mkRKAsE08oHVNfSBqQ4/GFVBxX6gOVjVumjYSdHLH4w7EMQouQHTiADt1NCQX7kegQDiP
	psvQ175W+IxwgmnYgqZi2bp2AV9H8jIZ+MH61Sn6qQoYnfHfwKQ8fVMfcBykNieHz6xoXMoY3Nq
	cgT8FQEBmiI6ZVX1Q4Fen5Dm9RM8VVAtjrne1TFC33iLA0Fa3MMtbfMcfLOycdooPLQjCng8GZ+
	DoTwgzfbkzHXS444VlZWI/0Fb1jgol07j81177V0ZwG11KpreGCiOoYg4vBvI5/T1FiRrR9rQhd
	GHCMncsVOzRn0RaAYx07INOi7/KF3Doygo+JZLtXbOy/y19equxJqnVbKkygACT+5pUH8nzPAzk
	64Md3ghzZL0ywfczeUdszsEHa2OQavQ9pkMhm/tKaSA1WtAzWsy/1O3
X-Received: by 2002:a05:6214:2a84:b0:910:3453:7d8a with SMTP id 6a1803df08f44-91034538000mr9552376d6.31.1788371164336;
        Wed, 02 Sep 2026 10:46:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee41b5dsm23518966d6.21.2026.09.02.10.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:46:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x1p2B-0000000Emsa-0EzE;
	Wed, 02 Sep 2026 14:46:03 -0300
Date: Wed, 2 Sep 2026 14:46:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Hu <dhu@x6u.co>,
	sumit.semwal@linaro.org, alex@shazbot.org, ankita@nvidia.com,
	chriscli@google.com, david.laight.linux@gmail.com,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	jmoroni@google.com, kevin.tian@intel.com, kpberry@google.com,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org,
	viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Message-ID: <20260902174603.GE2890729@ziepe.ca>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
 <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
 <20260902095338.GU24140@unreal>
 <65dc4ca1-6882-490d-baad-3e0abd708af3@amd.com>
 <20260902105919.GV24140@unreal>
 <7471c6e1-fbba-4430-a196-3f57a73505b7@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7471c6e1-fbba-4430-a196-3f57a73505b7@amd.com>

On Wed, Sep 02, 2026 at 03:34:18PM +0200, Christian König wrote:
> On 9/2/26 12:59, Leon Romanovsky wrote:
> ...
> >> The PCI_P2PDMA_MAP_BUS_ADDR is not supported by DMA-buf and as
> >> far as I can see is a complete dead end.
> > 
> > Maybe you mean DRM, but VFIO works perfectly with
> > PCI_P2PDMA_MAP_BUS_ADDR flow in DMA-buf.  What am I missing?
> 
> Well not quite.
> 
> The approach PCI_P2PDMA_MAP_BUS_ADDR takes is fundamentally tied to
> only map a physical CPU address into a PCI address and doesn't take
> into account that in a lot of configurations the CPU can't access
> all resources.

It is called PCI P2P. If the flow only uses PCI devices it should
always work because it relies on PCI spec things that happen outside
the CPU.

It does not try to solve the general embedded problem of arbitary
communication between blocks inside a SOC, scale up networks, and so
on.

So, yes, it does not solve every problem DMA buf faces, but no it is
not a "Dead end" as it 100% solves PCI to PCI communication which is
still a very common use case.

DMA buf users that are exporting from a PCI device, over PCI MMIO
should be using this API. It is the only way to do PCI to PCI
communication correctly in the kernel.

Jason
