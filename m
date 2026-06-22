Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459E3AE1AF
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133382; cv=none; b=aBa2EwM3jlX4XU2760EDheHG3OSNgnJCyUSfeBfnqelJYUGwyG+47GfStGhyIhcEPtYU+LXyg7iiQcclGw59IIfOidHuG2hquzxZ8D8hBLfhahoHUaykc/SFdFM2dS2IiqyxSjhoDzUZ6sGtDIUXFDsfLBWCg76LZ5JpKS81EVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133382; c=relaxed/simple;
	bh=/S/QI1XHdHqF+2r+ChB1gCQA2E/qjUSnr5ewJwFi7QY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxZzCM9fSQRW8aQUQTHjK523E0IXt74e89nMgZgUwjB2BZkhL36D9a8SIoa7yZfgWB185oer8Vg/qkFRcryZj9GcldSLFWUVR65A1o+ltG5C20gI5Gr52dS5D0mJuUV8Y68hHAaAZRmcQIK0sTjlGJ9kAdYyobc3EXcyVIEnFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huYgY/n3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huYgY/n3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49230a567a9so21116875e9.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782133379; x=1782738179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY8jUB8cUIc6YSwipFGKRU7e5xXhrfeJ0x4AmQghXf4=;
        b=huYgY/n3njTr8njT/6TZ2ll8HxSmvZ1ZnjACCLLI7imrWuNzYYjdR0iw6u6I+kPRIe
         IaoOUH71YWCUY6eRoTtnXQf6zBmNaxQ+1Ww6UM2FcKvHgWZDOlSKE1NAvs2JUHl8nFtL
         2+nFgODIvP53g5w5RC5O5Cp3bMU9XGM4hqHqNN6lFnnV3lhXJD3YRaAHVURXgiW/cyDz
         5eZU8FcSBu7uJsC+CtL+wusfayJPn9TvcrWROsB8yyh9PB7TjDJNv46phnR3tiQIpwAX
         kYh4GiQH4ifNhKEv0z0dHWmKKrTHNKIklNq8tB/kgKbRZMcq24qv7eTbXCL5ySzaAsaM
         UcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133379; x=1782738179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MY8jUB8cUIc6YSwipFGKRU7e5xXhrfeJ0x4AmQghXf4=;
        b=ilOO8K4AV1CPh0XkINuL9lfJ1AkIAwpLOWaAUQLO9EQIANlPlubAA9okYgyePs/gMf
         cIiWz9cOrqE+DmdLXgK6nQn2h8VbfyrRDLz9HwrUTijrRS5JYQ3e2jRWNABnVhnmdjGx
         XnM/1F745EUTUYYIFnMHl4N22jpLZpwuv8TL+fZtaw596Fub5Duy3b4dF9dY/CdDxG9E
         NEHUFnFybSz0lFkNDFXIbtlQInozp/Bmd//Ulr+3at0W494kSS8AldVVkIf8vUgCfldo
         pZyVK2Mbm1zq5TqRkEqbuo5xausyy+8pnNk5YMg+/kRhh16/Ft3Dt5UGgU/QbeQIrvQ9
         O5kQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VRndz4QZpAMA/AkdhmOw1BgQQjB+570sjTDZYAWe9A8jem+uQjoBujakwRfjfLo9FoQScQFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzJ9q0oHZblShZAFXO7JMsOYtuFNanUA5N37xa5L/ktM39rxb
	1OIziMZZ+she8vDY6aNoVC93iGatxpNxU/rQ5/zeWCaemKAYLQczjWNC
X-Gm-Gg: AfdE7cnRopR/5WKwkht4kpb5oLcIyoL0JekSIfyoMiPZeBU6ljp/uTXFzWzH/8Lkm/d
	2UzR1ElpxpC8XhGg2xznHJHOawpFHNNoBXbb3b01j4RZDUAvQdSeRQJDEZwhAhk2UjCcMX7j1rp
	RQXG3sG3YywZOFtGcPUOuBCSZhIvzpPoW7rVt7ILluNmav9uqXd1Cm5XDg8nqd5d8Ev4bGdU/7q
	6H4gOfiN3ONtt6fUBQspFoGGxCoooRdT3vvkTLGTmKgpTKPcaN0IfS5QSiRTS709z3OmT5qfkhS
	sSi+6bQjB53Kkf0i/GpxHo+lUs1gSYMYkjzXkcdgCP2rt5xFMiN2j1FUPfIi4Dps9Gkks3AYlwk
	trMe/dRYnIU3SXDHRAPiSgBRbUuD13UOkNGq8D1hFXP61/XT4KB86HJkOpGout5elsH7jbhDtRK
	09e+UadkjZmVxmPJWMOU4bKORK9zg8y1CPbVXPQw+zBmf4b3TWEQ==
X-Received: by 2002:a05:600c:48a2:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-49240e4473dmr152945135e9.15.1782133378887;
        Mon, 22 Jun 2026 06:02:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm497063795e9.0.2026.06.22.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:02:58 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:02:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Alvin Lim <alvinwylim@gmail.com>, linux-ide@vger.kernel.org, Niklas
 Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Message-ID: <20260622140257.113f2275@pumpkin>
In-Reply-To: <8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
	<8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 20:31:54 +0900
Damien Le Moal <dlemoal@kernel.org> wrote:

> On 6/21/26 19:08, Alvin Lim wrote:
> > The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> > support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
> > can be handed DMA addresses above 4 GB - it silently corrupts data in
> > transit. Reads return different, wrong data on each access. SMART is clean,
> > there are no SATA link resets and no MCE is raised, so the corruption is
> > invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
> > or, on Ceph, mass scrub errors across multiple independent filesystems at
> > once - i.e. host-level, not filesystem-level.
> > 
> > This is the same failure mode already quirked for other controllers that
> > falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> > force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> > ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
> > The ASM1166 currently maps to plain board_ahci with no DMA limit.  
> 
> Have you tried the same quirk, limiting DMA to 43-bits ? It is very likely that
> this adapter bug is the same as the 1061.
> 

It would also be worth checking that you get the read fails with a 44-bit mask.

I'd guess it also requires that you keep the controller busy for (about) 8TB
of reads - which is where sequential address allocation would exceed 43-bits.
But that is just conjecture since I've not looked at the iommu code.

	David
