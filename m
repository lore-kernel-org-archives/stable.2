Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA148A8C7;
	Mon,  5 Oct 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212043; cv=none; b=iSQ7VPoWqXQ57mZWeyeGv3eTYCdck8YG6T7ztiejbus70oK8p/U+up2Y0yxK+SyYQVZabE7C8tfz9dfN0sun61h6obGlZEyqSNe7mhDlfNLFAdRQVNp47aY0zq0ON1vQLBSlsI1wrIECFORuXMCMaACXUDtMcWz1gVlv2nHCj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212043; c=relaxed/simple;
	bh=mrBfKHy447twU3aeETfr87DO2x0IENzbr8uuCGlRLF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN5f4XW5aH8NlTxFr6zi4qgrgWf0PJvNB5sQvzGml0EZTSJY5dP6QEMyS9MaGb15jPZCbfEaKwffx8LL4FbkerYPpZb/xAD+U9f5072Le3n0Ny74j7KLDfi7nLlTjUou/s7/X6wy01EoiYUfOxBAVXBiN0L3ieTNthiFUbb3Q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Be1sCz+n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Be1sCz+n"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B517840E0486;
	Mon,  5 Oct 2026 14:53:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GxC8E64juKXb; Mon,  5 Oct 2026 14:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791212026; bh=QCTRJrRSMliG1y0HI1fW1TaWT0OQqIRjC93mDJT/OgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Be1sCz+n5/PAMGPvHEB0svqS2EoG27rxXqpG4h78erSha+p+OCiqwepOJAPQPAu4g
	 GUbUIy8uSvkXqVm3yCBFxq6xHimi/UGXuKb2wxNwYzW68ygz2vKjTJMcWpBsSySto+
	 LoMRSKwM2dbGKMvzncFVNTxfVdSeDqzN13ZsOqamzfuyHloJxlaHfoYrPr9u7eu/rw
	 y57EQq151grDPU/ZYMAd2tdLVJL2f1cTC5nwi4IS6etBo+5fdmNH0FGJVy2GwNWJpk
	 spwPYvDmqj/YWQe7Yl673TlJ5WH8yMFEt/ISMbWtoc6oBuMITsn9S86xO3WlYiwbp3
	 Q3r6zp0lwujc9TDSvjjTISJFAlRCKLNkSRb9N95Fjsn6Qe3mf/Xv7//VrkWWTsJRIo
	 sGjrJxRb1GPIEXv9bbsg5cEr2cW7M/SiKwR5kZTB9Spa2l8jQXtwezQd4G/dlSM7pt
	 UU4MKj+17mmykJf4BbgnpZcwDRJafjPzbWZgFnLcmMLXDb9eSMBPUEHxIbZwGE4GwQ
	 GItF+o3akWdEuxVgoQNR7Z1Mbnj5fyH4SPsgvPJOyKFAXCsNOyUDrw+HjUD1Ccglvd
	 hhqJUNYZiByb3jO2Y13o/ZUkSMUAP7bBtwGni5IAdnDvp3FlIbPe26/lgNln1VJGoy
	 dssko10C2ca+xKh2FY3yV1ug=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECE5940E02A8;
	Mon,  5 Oct 2026 14:53:18 +0000 (UTC)
Date: Mon, 5 Oct 2026 07:53:15 -0700
From: Borislav Petkov <bp@alien8.de>
To: Lance Yang <lance.yang@linux.dev>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Pedro Falcato <pfalcato@suse.de>, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
	mingo@redhat.com, x86@kernel.org, hpa@zytor.com, riel@surriel.com,
	linux-kernel@vger.kernel.org, qi.zheng@linux.dev,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	brendan.jackman@linux.dev, jannh@google.com, mhklinux@outlook.com,
	Manali.Shukla@amd.com, mingo@kernel.org, stable@vger.kernel.org,
	toshi.kani@hpe.com, david@kernel.org, mikhail.v.gavrilov@gmail.com
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
Message-ID: <20261005145315.GCasO523MWyIIx2ngl@fat_crate.local>
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
 <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
 <ab077b6a-160f-41a2-a167-813f0560e30d@citrix.com>
 <38541ec6-d796-4f35-a700-75ab097b6df5@linux.dev>
 <7ad90e94-d04d-453a-ba22-9640a5024d8c@citrix.com>
 <6801221a-6307-407a-85fc-46906f95d22e@linux.dev>
 <20261005142216.GAasOymJHYnmn6wD5m@fat_crate.local>
 <de41b083-6368-429e-9928-90aa5440f750@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de41b083-6368-429e-9928-90aa5440f750@linux.dev>

On Mon, Oct 05, 2026 at 10:36:26PM +0800, Lance Yang wrote:
> I don't have an AMD machine to test this on. I spotted something
> that looked wrong in the code and sent it out to see what others
> think.

You send a normal mail - not a patch.
 
> Maybe I'm reading the manual wrong, but is raising a concern
> based on the code and the manual really just "a wild hunch"?

If it is formulated like a patch which is supposed to be even urgent, then
you're reading our process wrong.

https://docs.kernel.org/process/development-process.html

And since you have not tested it to actually fix anything, then this patch is
nothing but a wild hunch.

And to answer your question, no, it is not needed. Definitely not the TCE
angle.

Now, the speculative thing is another story but that whole story you're
referring to needs a lot more debugging.

But we do not apply patches on a wild hunch, without any definitive data that
they fix an issue and, if very much possible, with a clear explanation why
they fix it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
