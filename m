Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F8638887C;
	Tue, 23 Jun 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234186; cv=none; b=hkVHn/b4YSsl3DJLwt6TZFu2Zqi6lTgh0hQXzZ18yuxf+WC0zf//q/5L/2ovfQ4eDb+ZRlOj8tda9wcF3X3nQHssj5gyLnqSR6XMjr7JuLAp+CXKvMNCVoHB4hUZtMjLA9A2+CCRymQpxAYvL6qNUTcjSDKj1hsSuLLxwjvHwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234186; c=relaxed/simple;
	bh=bWwbIF8DkHpLJdfgmTAjnt0nuFcP5y92eynr+khybkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sndu7ommMytWK/zO/Fo2O2thv7aMLMCOC46TmH/4ZDTa+/F9p21x4U+NhD9WHBV2MzjdYnBz54tXuStIS/ZEViv3Y60ooogflIDt574CtlYfOytwostl3nMZ0GBoTHuriDa1vmuhf2J7yUp8Z5bQabSItpmYlv+olYdVZRPvTvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF/KWJpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF/KWJpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839AD1F000E9;
	Tue, 23 Jun 2026 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782234185;
	bh=rtTgNffd+ktGj4/4i7jP7FiYW4hi0YlXf5Zh0yOOOxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QF/KWJpt2klgdXVoJvW1tlbNo+5ETlGF4EkCUCZW6Gs9zf92yBEvKI7ADGa3fRUun
	 aS7xcR7mfJhTC0ZPVpD7Ghet9Kw9V3w5y9mCsBYpggpBIO22W7zYO3RqWuM0wXSIRi
	 HCzjwblEI+3qGW8JqXvAzTbSp9LFPsQy2ke1e4BvKL+d48v5vUPn1g2/pFhAHsdyNw
	 BMhqITDRDrmboARk59av/5BpelSc5JhlIJ8dXIWUIDbd/tzcPXBXkfVqrYRHmPP+KN
	 rVz2/SYu3ich1mZpGipBibT2SrcyOLVlI6NElx+lL01dkJy7hCGGhnDLjy0QSCPJsZ
	 scZQc6Vze+ECA==
Date: Tue, 23 Jun 2026 18:02:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com, 
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com, 
	sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com, linux-mm@kvack.org, 
	stable@vger.kernel.org, Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <ajq4_VndR8gwponS@lucifer>
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
 <ajk0N3Aekapljaoh@lucifer>
 <20260622142102.pcmr5pftshj5lvju@master>
 <ajld6RKK02Vi-LxM@lucifer>
 <20260622234518.nnx3r7ckphlxn5vm@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622234518.nnx3r7ckphlxn5vm@master>

On Mon, Jun 22, 2026 at 11:45:18PM +0000, Wei Yang wrote:
> On Mon, Jun 22, 2026 at 05:11:02PM +0100, Lorenzo Stoakes wrote:
> >On Mon, Jun 22, 2026 at 02:21:02PM +0000, Wei Yang wrote:
> >> On Mon, Jun 22, 2026 at 02:46:40PM +0100, Lorenzo Stoakes wrote:
> >> >+cc Lance, linux-kernel
> >> >
> >> >Your subject line is 83 characters long and is way too detailed how about 'fix
> >> >device-private PMD handling'?
> >> >
> >>
> >> Got it.
> >>
> >> >You forgot to include linux-kernel@vger.kernel.org on the mail, lore seems to be
> >> >a bit broken atm but in general it's helpful to include that.
> >>
> >> Got it.
> >>
> >> So usually we send a patch to both linux-mm and linux-kernel? If so, I
> >> remember is later actions.
> >
> >Yeah it's better for dealing with kvack going wrong etc. :)
> >
> >>
> >> >
> >> >Also is useful to make this [PATCH mm-hotfixes] to make it really clear it's
> >> >intended as a hotfix.
> >> >
> >>
> >> Got it.
> >>
> >> >Some commit msg language nits:
> >> >
> >> >On Mon, Jun 22, 2026 at 01:06:51PM +0000, Wei Yang wrote:
> >> >> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
> >> >> before return the pmd entry:
> >> >
> >> >Sounds better as:
> >> >
> >> >	For PMD entries that satisfy pmd_trans_huge() or pmd_is_migration_entry(), we
> >> >	perform the following actions:
> >> >
> >>
> >> Sure.
> >>
> >> >>
> >> >>   * re-validate pmd entry after PTL
> >> >>   * check PVMW_MIGRATION
> >> >>   * check_pmd()
> >> >>   * handle on pte level if split under us
> >> >>
> >> >> But for device-private pmd, we just return after pmd_lock().
> >> >
> >> >->
> >> >
> >> >	However, for device-private PMD entries, we simply acquire the PMD lock
> >> >	and return.
> >> >
> >>
> >> Sure.
> >>
> >> >Also can you please give some justification here as to why all this also applies
> >> >to device-private PMD? Right now it sounds hand wavey.
> >> >
> >>
> >> I thought below paragraph explain it. Not sure what justification is preferred.
> >
> >Something about device private PMDs splitting the same way THP ones do, in the
> >pmd_is_device_private_entry() branch of __split_huge_pmd_locked().
> >
>
> Hi, Lorenzo
>
> Thanks for your detailed suggestions.
>
> I tried to add the justification here, and the following is the commit log
> after consolidate your suggestions.
>
>     For PMD entries that satisfy pmd_trans_huge() or
>     pmd_is_migration_entry(), we perform the following actions:
>
>       * re-validate pmd entry after PTL
>       * check PVMW_MIGRATION
>       * check_pmd()
>       * handle on pte level if split under us
>
>     However, for device-private PMD entries, we simply acquire the PMD lock
>     and return. This is not enough, as __split_huge_pmd_locked() would split
>     a pmd device-private PMD under us just as it does for THP PMD.
>
>     This is particularly problematic when PVMW_MIGRATION is set (meaning a
>     migration entry is sought), as it causes a device-private PMD entry to
>     be returned with a different data layout, causing memory corruption.
>
> Just feel this is not that smooth. Would you mind taking another look to see
> if I get your point correctly?

Honestly I'd just drop the whole pmd_trans_huge()/pmd_is_migration_entry() bit
and say:

	Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
	device-private entries") introduced the concept of device-private
	PMD entries, but did not correctly update the rmap walk code to
	account for them.

	As a result, when page_vma_mapped_walk() encounters device-private
	PMD entries, it takes no action other than to acquire the PMD lock
	and exit.

	However this is highly problematic for two reasons - firstly,
	device private entries possess a PFN so check_pmd() needs to be
	called to ensure an overlapping PFN range.

	Secondly, and more importantly, if PVMW_MIGRATION is set the
	caller assumes the returned entry is a migration entry, resulting
	in memory corruption when the caller tries to interpret the device
	private entry as such.

	In addition, commit 146287290023 ("mm/huge_memory: implement
	device-private THP splitting") allowed device private PMDs to be
	split like THP mappings, but again did not update this code path.

	As a result, we might race a PMD split prior to acquiring the PMD
	lock.

	This patch addresses all of these issues by invoking check_pmd(),
	ensuring PMVW_MIGRATION is not set and checks whether a split raced
	us we do for PMD THP and migration entries.

>
> --
> Wei Yang
> Help you, Help me

Cheers, Lorenzo
