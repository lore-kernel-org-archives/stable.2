Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E8369225;
	Fri,  7 Aug 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113294; cv=none; b=kuMMshg87EGNR+einbfOJRUIHW+S9NQRcmTV6k0Y43GICOkBwsAqvrGb8D9nG2Pvc7ZhnjxcI2WcG+CB3PGWQcFyx2d+xcP0Nf96lVOoZASaeDqyQ78ZQ7pP+1QhVpjR2qztqAKw/isfbHqbhaanrRZYIZRvU5EQSoJZN+jHKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113294; c=relaxed/simple;
	bh=GQtOV0NZ3GRZjvi/C5JQ/QIARX7I/ykUdagOLiBrBtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFlLcVQbKq/oANvnIrAvpJEr6xm0RisOHac/hoiDII/OSe3VlTZ2XfHRvDFEs1Li7vL7K5IF8Cirmm8VVjYMJ6rThua2N6+WSbsSJxSX4gvhoYwzINlnSEqpQHugdbVT3TSoMiNk/0W1ZY3sXtTM4sb9nJQjlM+GF+3gCzvofOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYiX7IKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYiX7IKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878891F000E9;
	Fri,  7 Aug 2026 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113291;
	bh=GQtOV0NZ3GRZjvi/C5JQ/QIARX7I/ykUdagOLiBrBtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jYiX7IKUNH3jXPSIpchsDzDLTYnFo2eKiA7FjkHTUz4yAJFM/DVt/N7PBtCyx+zKa
	 wsmH5ccVl+8a9WmMEkkxO4pHrgcm0EbLOQQ953Kbk8memDgkI8t7zOB5PiBa2f13qS
	 SvS1tlcbyY9udoYXfdmiDgeM14q3qgpqQ4oHfYlGv7MWmxd5XMEgN/cfenFguFVPig
	 KLCBfXzNErb2INleDqpNCj2KgTzCpJ4+F8q4IJbcJuk93t1a2ZRokM9Xer04eXjH2p
	 zHgKWGdVpTvwR9S0KyArixVa3IHj5pD8LSO+nym8iMVxCb1Gn1O5F07+mq71DR7QQK
	 niyX66kGFR81A==
Date: Fri, 7 Aug 2026 15:34:29 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <anXp--mLLEE2Qo0g@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <anCwUb9lV18v6mfN@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anCwUb9lV18v6mfN@kernel.org>

On Mon, Aug 03, 2026 at 06:14:25PM +0300, Mike Rapoport wrote:
> @Dave, @Peter, how do you want to proceed with these?
>

Hi guys, I know as discussed off-list that you are snowed under but there
are bug fixes here that are worth looking at.

I must say I'm a little surprised that the series which came out of the
discussion here has been taken to x86/mm while the actual series hasn't
but there we are :)

The core mm bits my changes rely on have been taken to Linus's tree if that
makes life easier?

In any case - Mike - I think you probably need to respin this on tip
x86/mm anyway?

Maybe worth doing that and seeing if that makes life a little easier for
the x86 folks.

--
Cheers, Lorenzo
