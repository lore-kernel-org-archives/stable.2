Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E23A8759;
	Thu, 13 Aug 2026 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665524; cv=none; b=pgBB5cbRab1vxQwcgP1BgXrhW25J5iRgDOUg+yAsJC0n95E0UEbLLAr23/TR5DOAF+KxJz50r0yza/hCt6oIVA3tr7mAN6kLehtlSw8shrER5mwjUZ6SI4EIkd6fxrH2HtrPhhwApJ5MM9h1Ied24/zaf/Dl5jD3CF/3UlC/RNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665524; c=relaxed/simple;
	bh=PIW4/tNfhuqvpw9bSrnVIUt6VD/pwee7xYih0m7sFUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcyhPp+p5OuOES15PlgTfRA1lcTbNmEmKVJNhnW4dQVhcwu2v9uNHdp1mrogHTuGsBRkR+oudMrV37gg75FyM2T43EGetiU3hyKTvhVzTtPCXHkL085eFNWX8x+gsNKtmMSrH1SHTyXxo1GOinekcPneRBYNIGoUHpykT3ylAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BgqeFhb5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BgqeFhb5"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5583540E019C;
	Thu, 13 Aug 2026 23:58:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LlO7YcrXw7xK; Thu, 13 Aug 2026 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786665501; bh=sh/dyEphPDNyqA2jYsmV9lNQXr+EJFQY91tR1OmnEew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgqeFhb5NJ7gfCwBA2Zu+ZczEqtsNU00QDnqeShWwcW3jSMq+y28sGVYcBttJ95JZ
	 Xd7gFvR/+vGxtDdouSmBI2TQ5QjRVLsF68uqfDV6yQZaPyXGeCKuPrPfANuTWGFYZJ
	 z26eg0ZKB7IdnmVOT1TUQ1UfeOESafqNCdY1aGBVh6W0/C2KaPeWShyJria8kL3PrP
	 U5fXvXXxv+tmSHKF/QhquqeR/8d+tDtIr2DW5v0YwOToS2ygi2FVjTWndueYiUdx8C
	 sqRHlVDdyO19fsrRbp2JMRkuk21q0yGlDftABNVm3GKIjB5hZtM0gr7RQ9xm1UMw/x
	 maj49CN8ilbY+oMKN1z+t7ALvKr2D7yu8CLldVikcIq98Dtq5kK6NYst/iMF+MTr1k
	 qa/GQLFqfdzTlSrP93b7REUjEGgKVfVRLJtVNCTDZNZ6KGEaA6IG9S6eRPBu2+SqDE
	 GYmQ6mxTXsauiz6gsaR/JQit8aHxEaob5D0v7H3b8a4jfffHS104g4DOmXzgTKE9g6
	 H4RX76Lob5og+yTYexQJd0PLV8uSdP8eQedoJdzZjoZlKxt6HkV3rkRHEw1DRxF1Yl
	 +9ptZ7QnTm762soozw7+WoCQ7oru72Qm91h8gYZFFn5vNfqa61NSk5hfCyW+MCg6d3
	 mSU50kM1B/bRg5kwIfIsNTzw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB4CC40E014A;
	Thu, 13 Aug 2026 23:58:09 +0000 (UTC)
Date: Thu, 13 Aug 2026 16:58:00 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: Remove smn_exclusive
Message-ID: <20260813235800.GAan5aCCfimjHRUV1O@fat_crate.local>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-2-jason.andryuk@amd.com>
 <20260810140747.GB57095@yaz-khff2.amd.com>
 <20260812192805.GBanzJRTgkrti3Bm7F@fat_crate.local>
 <a57bdf5f-c9a5-4417-9d8b-d84cd29238b4@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a57bdf5f-c9a5-4417-9d8b-d84cd29238b4@amd.com>

On Thu, Aug 13, 2026 at 09:40:33AM -0400, Jason Andryuk wrote:
> On 2026-08-12 15:28, Borislav Petkov wrote:
> > On Mon, Aug 10, 2026 at 10:07:47AM -0400, Yazen Ghannam wrote:
> > > 'smn_exclusive' wasn't originally intended to be used for bounds
> > > checking the array. But the original use is no longer needed, so it can
> > > be removed.
> > 
> > Why is it no longer needed? Apparently I didn't get that memo yet...
> > 
> > 83518453074d ("x86/amd_node: Add SMN offsets to exclusive region access") is
> > talking about the potential concurrent access. Why is that ok now all of
> > a sudden?
> 83518453074d set smn_exclusive after successfully calling
> pci_request_config_region_exclusive().  smn_exclusive gated access in
> __amd_smn_rw().
> 
> Things moved around, and now pci_request_config_region_exclusive() is called
> earlier.  At the end of amd_smn_init(), either amd_roots == NULL and
> smn_exclusive == false or amd_roots != NULL and smn_exclusive == true.
> smn_exclusive is redundant, and amd_roots can just be used directly.

So you want to use amd_roots to *also* *denote* whether exclusive SMN access
is enabled. Then you need to at least put a comment in __amd_smn_rw() where
you're testing it, what exactly that test means.

Then, your patch has a Fixes: tag and CC:stable which means, it needs to go to
all kernels but then I don't know what you're fixing.

Looking at it more, you're basically fixing one more aspect of running the
kernel as a Xen guest and it not having AMD roots exported.

But what you really wanna do, IMNSVHO, you want to make your patch 2 be patch
1 and it can go to stable.

Your patch 1 then becomes a simplification/cleanup patch which goes as patch
2 and doesn't need to be Cc:stable but it can be queued later, during the
normal cycle.

Right?

Anything I'm missing?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
