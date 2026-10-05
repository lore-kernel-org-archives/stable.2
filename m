Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAC349CC3;
	Mon,  5 Oct 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210229; cv=none; b=F8JHVOMI9s2eCqa6s7wTJRq5NAe6fcznqaIkSss+WGPJwO5UJln0pFP2OEnAAa41yPcUHTWkmsUrkxQxRA3DWorelhUk74JvLSK8iyLu8LRhogJG3p2wWGI7jRdi4foTfVGjXmd/RT6tidFnY3BrBRhPE+BQIuqOpjOfz4n3Fzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210229; c=relaxed/simple;
	bh=jZLOfI7EStIVEtWBQeUXSu1WMUw32YaxRQuhUpfPZWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCD3sP+igH/hUXrp1XUy4SWyDdGdlG93DDCckuqs4NDDzVXuTpMZ6CpPm1XPzQLjFzjoyx1pSQvI9zvZoZAkMytcpkPCP+fbNwAh/OUffGeYu5NtWfRRqMOoBDrmRCAcHIhuL7nk+Wek7vDkv+oyeA4mBjVSHdMWFZZwifghhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=edwoG1ZI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="edwoG1ZI"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0AE0A40E0481;
	Mon,  5 Oct 2026 14:23:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SfeJXfSwf0Mm; Mon,  5 Oct 2026 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791210167; bh=VtxSKsJ4qGQk3yWu0lOPutFCnBFJGvqMqZUqiGmUgtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edwoG1ZI14EIMdNF67HsrYiBouyMCpEIy3nCTt1PEHsrII7VArul7mdVaTmz1x9CR
	 YdsYOkDAkNx+pRmV4iNo7Ig5GlVFLEKpY0cii8033hQIvYPX7D6Na7Pu8p1ZMMN/A9
	 4piG+QUR6jU5DU0fPhQk5ZcnpRnux/4yAOEWEUMPhOInR3hFVvoBVuEdJDNpoIOkqc
	 p0APwJl1EiGtb8nDKugJqpiHrULK4lo1vcFiUI+zcp4+WUvWo7JjqtD5b4V6VSCCHM
	 p6oLWpG0EQcAkJFCvTi3lrWtHDnVYKa/8iitfr58mgirIxJZf9BzO5kQBxVBRPr1wS
	 h+xWch6cDdnpFTp0S8+PPgjihPufoLiNvMhzLtVQiK7NsK2vcU6Ns4MyZqKpkMEsNp
	 b5ijrkPOrFoTwYD4Pju+0hX1/vmPgbijJJK6AGsQwWRHXcM2wLtnveJRRsOyPRIkVW
	 0Upd+1IXHDK82rszWXX5+wVXRT9qyIbJTfKJgVtNNqf9dydiUdvIpc+2yqiTsspdYq
	 pO8yUmbZ/KazByJV+WiKJqge9S0pHNSxJ5ajuwEzuCMXmnd9qiCKyPrTTd/iKqopWx
	 nWB+OlmoX5pzGQdK+/q2L09ZXXseom19k45twk/kEmWIbFwmFSZpRezvAUKQf9R0zi
	 ngVZO6NsosL1VrqQwhxyMYXw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1A7140E02A8;
	Mon,  5 Oct 2026 14:22:19 +0000 (UTC)
Date: Mon, 5 Oct 2026 07:22:16 -0700
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
Message-ID: <20261005142216.GAasOymJHYnmn6wD5m@fat_crate.local>
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
 <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
 <ab077b6a-160f-41a2-a167-813f0560e30d@citrix.com>
 <38541ec6-d796-4f35-a700-75ab097b6df5@linux.dev>
 <7ad90e94-d04d-453a-ba22-9640a5024d8c@citrix.com>
 <6801221a-6307-407a-85fc-46906f95d22e@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6801221a-6307-407a-85fc-46906f95d22e@linux.dev>

On Mon, Oct 05, 2026 at 06:12:45PM +0800, Lance Yang wrote:
> Which CPU? None so far. As I said, I don't have a reproducer. I'm trying
> to make sense of what the manual says and what the code does ...

So you're sending a patch for which you have absolutely no justification? And
CCing it to stable too?

And that patch hasn't been tested to actually address anything?

Just a wild hunch?

I wouldn't do that in the future if I were you.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
