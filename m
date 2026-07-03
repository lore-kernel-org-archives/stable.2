Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2E30C366
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783106704; cv=none; b=kUcP5fPGO5TJy5VYyN2vMyizt1a7kuj+J4VUnZS6+Qfx/cQjPhPAxe6UmBFkpNrN/sTGkXbMANBWlRozsDgjKjLv819QmUq6tti8ED/4AcUpiij66nY8Jt8L2A9Q+AQXzp3+jgsiz3XtWTW5FAy6fepjDAXfQjHZvS6m9hq8pFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783106704; c=relaxed/simple;
	bh=yayEeyU4e7p8xCn+5eQp5ki7+IbDFzlKh1940AmQVPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR3i3iCPSmaQZ0HFDa8ZFdlNyOAFDV01IqXA2wFdVC4c4reQmHRM8hg5ghQmrjzuNsoC0GW/2l9nIk+c3ANzAlRNE9v7uQPiShfVLaO4BUMUOSpm2r+pZJzasQDKkjmFnQ21oI3IYr5GbxaA7Ai46/XlV4ejH40uL0JGc6C6S/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AP51E0y6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AP51E0y6"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5c9211d2so64763185a.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783106701; x=1783711501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NXmfnDT9ccdJDht6GSlGH0hP5z1VNfXLI97+RVOH2w=;
        b=AP51E0y6pVvnWmadE3CZA7kSGkhItf7OfAOqmMzC5bSkd3k8X7pgixMHC2NILDfaHK
         xdjddvtA60KldSsaJEpqmywxR2/ywn2yhlMrL3x+PYr6xaJYwQbef2jrSQ5KvZuCHB63
         bP4heJX1gKiGN2khy5GATLUdOzpiXHsWx+sH0ZTiSp9sp6+D1Ya27X3XTkq/QT0Vq+yu
         ioO8Y8Xu5NYcF9cV5oXJKyhwEeKSSE3hGiqTHBQk0UCZrdYipXpuz7pYiPA5xpTHGj9t
         ezZdLSx6g6zYDG8W2o383MIHkh25mfgtDpKOVli0UTz5ch8Vx3eYOorDW4kG/j/Zo6/9
         rAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783106701; x=1783711501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NXmfnDT9ccdJDht6GSlGH0hP5z1VNfXLI97+RVOH2w=;
        b=JSjT9IPOB4MIpqXvoYaUDSjavbsyz+NfmoxxFMIrpmrobYW4P1VgMJTYCA0cJtD6BM
         7ETjFJKuaRp3T5yDZhRgERfpB7ablo3y8bdOf63LgPm3TRBfiq3b2uLrfoKeINPFjnt9
         oGw7gho4g6rwbZJwqUhp3vFFAjDNFuwwqaVVA2LFp2ZkPILEzqktDEsJCPNLe9Rkw7SC
         VvWyKKuiIxg22PrhbdUao3BBMaQzFlbchmWT//0ql8Od7kpr0AXGEROxuGHT5rITIzzd
         xSBGxo0ojumiT2nBZe9Tt6TD1xrhLhVpyRu2/skVznM9EyNND8Swdsz1Jqsw8jK050dO
         wLQw==
X-Forwarded-Encrypted: i=1; AFNElJ9B4nW0SKI0Wv6Utcp4ozJRkXAQWE9S6E4KgV2zfRgdykJLbLYMmOPyy6bvIkusnbuMB2i/Qwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws28eYQzYfcogg66UwscdX42a7nTYH1yw0PGULmyuK1QrtbknH
	NWKCPLUuRyNMh12OiIhb/jJ72e1XzbiZWAjeMlMc6M0KqKlKx0j9Q2LVw1hpqL3CZ+w=
X-Gm-Gg: AfdE7ckeGQHucMfOMiX/McaHUA8GA9IR2aPMxSDFqp2YQKIYfYgZTPZjiOnWIdNux7f
	nfCRkmJWc4Ehl56WVsoVKB52TNus3qxqoHbprvqUb1rE/tVOMIOd4iZbAmMJA4DIYZQO/7NIZmz
	2fEXcjBmuJSbCPCT+EYY9X9TeDfQ2WJxbJS84mTkAYk8prVG5GrHKNo90/+j0UdtjxVQAoulIOV
	Rv1gRnNCi98qoHkW3ib+sjuxKi2JlW5xOZBs31TfcwgD9yS1MK+gdFHR3zSY2/UIipIU+hEe0ec
	nYZnfTzvC0Y88vtVR/GpQoKe8oqJ3Z1tt7hA3vZ7iZGjFP7yRujs6rpZzrQPb3tPwxdZJPCAivV
	KkDY0VpNc8Zn2M3hjWZFO49IueoDPjyXh7H6tqcUEG943bMrwWJILOWZWdPP6QEEptM9qXFYRVt
	krPilzNeoE7gaik8fbFXC8OJ2KVTFkpqYKqets2AUm+ElpXDREJpfOc9g+Ewtr5QE3rkg=
X-Received: by 2002:a05:620a:414e:b0:92e:57ec:a4d7 with SMTP id af79cd13be357-92e9a4ed968mr109865685a.73.1783106700898;
        Fri, 03 Jul 2026 12:25:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ccdf8dsm225956185a.37.2026.07.03.12.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:25:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfjVT-00000008UHZ-0qcN;
	Fri, 03 Jul 2026 16:24:59 -0300
Date: Fri, 3 Jul 2026 16:24:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org,
	catalin.marinas@arm.com, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <20260703192459.GB1978949@ziepe.ca>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <20260703164914.GY7525@ziepe.ca>
 <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>

On Fri, Jul 03, 2026 at 07:57:04PM +0100, Robin Murphy wrote:
> On 03/07/2026 5:49 pm, Jason Gunthorpe wrote:
> > On Wed, Jul 01, 2026 at 06:45:17PM +0100, Robin Murphy wrote:
> > 
> > > @@ -211,6 +213,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
> > >   	if (system_supports_bbml2_noabort())
> > >   		feat_mask |= ARM_SMMU_FEAT_BBML2;
> > > +	if (system_supports_haft())
> > > +		feat_mask |= ARM_SMMU_FEAT_HAFT;
> > 
> > I fear this is going to make SVA stop working on systems it currently
> > does work on, so it might be a major regression.
> > 
> > SMMU HTTU is not a commonly implemented feature.. I think of all the
> > NVIDIA ARM chips only one supports it. Given that a quick internal
> > check is raising concerns this will be breaking for us. We need to
> > check in more detail which cores have HAFT.
> > 
> > Breaking already deployed SVA would be a major functional regression.
> > 
> > I think this should start by just enabling SMMU HAFT when CPU HAFT is
> > on, when possible. Maybe print a warning on the mismatch instead of
> > failing.
> > 
> > Since we can't break already deployed SVA a full solution would either
> > have to somehow turn off CPU HAFT or we ignore the gap in the AF
> > updates..
> 
> TBH I do not know how bad the implications of
> pmd_young()/pmdp_test_and_clear_young() returning a false-negative are, but
> if we aren't considering mismatched CPUs harmless then surely the same must
> apply for SVA. In the POE/GCS cases all that can really be broken is users'
> expectations, if they've opted in to additional security features, but also
> opted in to SVA wherein those features can't protect against DMA. Here,
> though, it's the kernel mm layer itself that's impacted, and I'm not
> confident to say that that isn't more serious.

This has come up a few times now where the SMMU and CPU
incompatibilities in ARM's IP are causing real headaches.

Let's give it some time and I can say for certain if we have impacted
chips or not. I was able to confirm the server chips are OK, but there
is still some concern about the embedded chips..

I also don't know how harmless it is to ignore the aging. I thought
the PTE was designed to be backwards compatible, but I never looked at
how AF works..

> Making HAFT depend on !SVA could only easily be done at the config
> level, which seems arguably even more over-reaching

Yeah, but if you could build a custom embedded kernel with HAFT
disabled in kconfig maybe that is enough for some people.

Jason
