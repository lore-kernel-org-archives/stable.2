Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9430568B;
	Sun, 12 Jul 2026 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783853206; cv=none; b=oRRimwcRAi+em9LPX9kDmUDxdfOw+3YR/ZvugC3oKGfiCPlZikJLDHAY/NA3QHHsfHFxCAjwOImw9K1m8Mg4C1fXv1fic6C2aZfJN+t56XvdXyhFIsqcspbSCz4G9X6V2hlRa4H0ziSkM8SLDVWzjAtAJVIr6eJ4qBm7KrbLe/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783853206; c=relaxed/simple;
	bh=IOUDvUEy6TKOQq0Pr9YmzerkWeQFM6q4kLvyq82Q8as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQx0Q/e5lrpj9AjejUp07I77fQ0sMLcGBb72DINFy1VMH7etbf1sv3cf9UJ6qh6suwdr8ioob161dF0dFcuBEwJgu2xRgLjiP2CDbKYWqatG5kyqSMPJRDQ29NZOMY0o39osm2zgHFHBUHnWwpN5S2MPucSpnayyz2b+ZW6omZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKTQ6vWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKTQ6vWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9671F000E9;
	Sun, 12 Jul 2026 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783853205;
	bh=IOUDvUEy6TKOQq0Pr9YmzerkWeQFM6q4kLvyq82Q8as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PKTQ6vWXX63l864cAkgQJT1N7/Kyzos1q+xOsJJWgJcP33PxRcUUaQilhxJIIuNVP
	 uLRI5TjlTGyTKaIYAcZAkmJ/Nqw6H1rGLFCZtVfjox2s4ML5vrToRtpAXbyrBm5x1x
	 HXYWhZcw7qmFabZ6IXVl+5UjUKDprf1XzKFdoBEExm7an3lyYxiLSL7ZHbledfUkk+
	 DpmSmW/nL09o21U05djkTJcLO1r7w3jNWcA+4kAWGYU5mxmblc2j1XeHQHw9O5g0zI
	 CravUsr9bcF38MZz/twHZNpG1+pDnjOBgQthLv48XiiG9FuFKa/gVii3M2hXkreG87
	 TVdR/fXbkO4lA==
Date: Sun, 12 Jul 2026 11:46:30 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Carlier <devnexen@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: acquire mmap lock on page table free to
 avoid ptdump UAF
Message-ID: <alNwO-lnRDsWPrB6@lucifer>
References: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>

FYI please don't take this patch as it's been superceded by a v2 in the series
[0].

In the end agree with Mike that it's just simpler to keep everything together as
one :)

Cheers, Lorenzo

[0]:https://lore.kernel.org/all/20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org/
