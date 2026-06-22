Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AD19D07E
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140543; cv=none; b=HD4azBN2Vrb1YtcsfSc0IGhVv2xxrQAbVN5x/Xuvf2MEZZR+bTrkHcoIkzNJIfjPixd6h0Xzx8K6pFiZjcIC1RhQ0ekRkJiq6tgsfFNZSNSQBFGJS1V9oEd/CQWDZVGQSQWlGHm82bz/bsF4xtd2YFEUs0moIHGZMbKLfJDijfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140543; c=relaxed/simple;
	bh=KoNuMnYjZxo9L6sYPKq9XfiPNioLs5qyXCONHaXw5rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWtCvRlF3Eb4+te8baMG+YPYo/9Wtp56EitlGzStwtYgy0qePqGQEF6JxUAfB0P4MqeI6lhKRcJSPCiJwwxnNvvu6J0rXx2HNHsVZ5yrGov+N9iD9RL3aWMkksIZcsPgCHv1EIS8kE/LweREpG42DKgrGegg7kyerWyBuFvLT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUoGK2dc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUoGK2dc"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c074142cf6dso679993866b.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782140540; x=1782745340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2ItdEcHDfZg3spaR2vkHfWXupwNyd8K/n8D+nYsU+w=;
        b=TUoGK2dcXx0zrEQQQrgl5Ljtmqn1suquBhqlyshDAw4Say2hGKTcsieDmYLVFdn0FS
         F7IA2PAlFC+Eg0fvYztShVgfWsib4ZbvWlwcW82RCL+2quGenmnUIb1nsRZoquVLSVLX
         F8s9lPfy4LC8lnTOY5HXq5uwpb35TvgB0DTiQQ5t2rWcw2tjPvAyFfreJRR+et/Iziy6
         2OiQxWb3NQkx+iOoYgYjEms8Wv7CEr3O1tJGRq3X8YUktaRkkqExKobkXmjvhzJF2ods
         Nc4r3jrZcO6uu2qrfJ7M1a246+lLj4lAZVUJGkhSrRH+7sNOvK0s3MpryLthtC6lycEs
         9kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140540; x=1782745340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2ItdEcHDfZg3spaR2vkHfWXupwNyd8K/n8D+nYsU+w=;
        b=SHLFI33itCc7UhHFvE5rCU576kBjGvKHcHDBubpLGAf7zD3QncnWQHX8amgQ5Fhr46
         ygsOcFqQmL6DB4Rj4A/8LEVQG1+cOkNyvl4rjImRPJ0vE8xFwpyXXpCAAJWX8XZx5+am
         32Aqcge03/AZ6YRdqSKhbkpRXulQvxe1rUZuIkcRltLYmqyAYFgeL/W8cjdv1QLuha+I
         +E4MWVKVPdWoKCLe7XtOM746WmfOkHC6YalRxR7Pr86Hp5cvcjV6+5upDxh9lIWDBQx6
         4Mqft4mCWN4rznZeyFOaMRbORPaa5nS+kLBO73DmoqIb/FfKEO+WaXvt64pNAuYWJhfA
         e3eg==
X-Forwarded-Encrypted: i=1; AFNElJ+MMg3eorDzF7DoTLzrsAxPO1h8jY6urX5CNphtGG41bMIvLkHnhFFNCIatQmFRxwEj/+pVBmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mV/S2MVfKc3M/3ti8O3w5GpW/TmonVANlOm31Tyxee344u72
	/KoY5jWuOLRWJLEEAHbk69W48zmTwMo5f4PHutcDTcHu8rojejT+HYz2
X-Gm-Gg: AfdE7ckXFtMdHRkmDesKNNLpljOk2utv8/JBfPKBeX7gxX5ONacpdT5ZukjULrPexRo
	Y+/VVqBk/OiY+BGSmUZSfrHaBOzgNdRzGn2ZzEKw1jJ11ImwGSswz6BacK5Fj7ePErDeOk3uXS+
	DKd+bj+Ypcp0RKcRL5Z2ssQ1M7045fLRqUMOwbc6GJKrNxVmRdCkFPqNC/918yQUpOHRV1CKnVW
	/yGyBTUei8wyfVtIfvS7PAo2v+67l2DrruRr82BBwXo0YcaE1CMa+1uCOjM/AchI9v3q0fJML7y
	kCqyAKGMo/qwL2GUqZpD94xfFfCe8QucgDrXBZ/QS/0uo09PAO06OyOyNugTxv8MBHTk0nbOAam
	D2ZmK+okhaar+VqpVIrxM6rrLvk0hfBK9Iv08Hq+Yty9fun5g2HwrZdh7qQDelz50whIUflbEgi
	SC3Td4kUfI021pDz3D7AZjRyEOjpiWBLFPu2M9dnOmkuyjfzc4Vg==
X-Received: by 2002:a17:906:8e14:b0:c08:7c60:9069 with SMTP id a640c23a62f3a-c09ba166c64mr632036266b.32.1782140539479;
        Mon, 22 Jun 2026 08:02:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm27559018f8f.29.2026.06.22.08.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:02:18 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:02:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Alvin Lim <alvinwylim@gmail.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Message-ID: <20260622160215.67e6def5@pumpkin>
In-Reply-To: <ajk2WIzpNgQSJ2dh@ryzen>
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
	<8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
	<20260622140257.113f2275@pumpkin>
	<ajk2WIzpNgQSJ2dh@ryzen>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 15:19:20 +0200
Niklas Cassel <cassel@kernel.org> wrote:

> On Mon, Jun 22, 2026 at 02:02:57PM +0100, David Laight wrote:
> > On Mon, 22 Jun 2026 20:31:54 +0900
> > Damien Le Moal <dlemoal@kernel.org> wrote:
> >   
> > > On 6/21/26 19:08, Alvin Lim wrote:  
> > > > The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> > > > support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
> > > > can be handed DMA addresses above 4 GB - it silently corrupts data in
> > > > transit. Reads return different, wrong data on each access. SMART is clean,
> > > > there are no SATA link resets and no MCE is raised, so the corruption is
> > > > invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
> > > > or, on Ceph, mass scrub errors across multiple independent filesystems at
> > > > once - i.e. host-level, not filesystem-level.
> > > > 
> > > > This is the same failure mode already quirked for other controllers that
> > > > falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> > > > force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> > > > ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
> > > > The ASM1166 currently maps to plain board_ahci with no DMA limit.    
> > > 
> > > Have you tried the same quirk, limiting DMA to 43-bits ? It is very likely that
> > > this adapter bug is the same as the 1061.
> > >   
> > 
> > It would also be worth checking that you get the read fails with a 44-bit mask.
> > 
> > I'd guess it also requires that you keep the controller busy for (about) 8TB
> > of reads - which is where sequential address allocation would exceed 43-bits.
> > But that is just conjecture since I've not looked at the iommu code.  
> 
> The iommu code will by default try to allocate a 32-bit IOVA by default:
> https://github.com/torvalds/linux/blob/v7.1/drivers/iommu/dma-iommu.c#L780-L799
> 
> Only once a 32-bit IOVA allocation fails, will it start using 64-bit IOVAs.
> 
> 
> It is possible to to set iommu.forcedac=1 to allocate from the full usable
> IOVA range immediately:
> https://github.com/torvalds/linux/blob/v7.1/Documentation/admin-guide/kernel-parameters.txt#L2619

Ok so SAC => Single Address Cycle and DAC => Double.
This all makes less sense than before - especially if that message
isn't being output.

That all rather implies that with the iommu enabled it is unlikely the/any
device will see DMA addresses above 4G.
(Unless you manage to have approaching 4G of active buffers.)

If changing the dma mask is causing bounce buffers be used (and there is no
reason it should when the iommu is enabled), then the difference starts
looking like a timing error.

Have you identified the type of corruption that happens for disk reads?
I'd guess typical errors are:
- Buffer not written at all.
- End of buffer incorrect.
- Buffer written with data from the wrong sector.

The PCIe write TLP associated with disk reads are relatively simple.

I learnt more that I wanted to about read TLP diagnosing a corruption
caused by an fpga implementation failing to correctly process read TLP
that generated more than one data TLP in response.
We managed to loan a PCIe analyser (very expensive, difficult to setup
and difficult to use) by suggesting to a salesman we might buy one!
and identified the problem, fortunately the bug was in logic supplied in
source form so we could fix it.
I then added logic to our fpga image so that we could trace the TLP and LSSM
state changes.

	David


> 
> 
> Kind regards,
> Niklas

