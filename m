Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018413002A0;
	Thu, 25 Jun 2026 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782362554; cv=none; b=kT1/NXuCDbLlwPfUxaPlVIllOrXXHIZp5mHb2fkfbeLAb+Za0EoN3p7jtcRQ3T7oQtJEcOlBW0XNJ4KAmSIytilxnKiXZhlvVArVE0hY6+0M7L6VZEee28kp5oiwODamYuqvczooXd//C5KnWK7B7fyEU5Q9sbxXiNsIj6shyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782362554; c=relaxed/simple;
	bh=2zVst6mLPWuDUyaGdXN+wzX46zSKCBxxH0hRFEmhJ/Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s2+1cLNdG+yZGhF6NI0BS6atvEPDuXzDK0iix28WYShefSVuExlTAlJmYL8fFrlJ6gdikOji4PNVBB2w8Ys3fvIh2k36AHCzTIWhiHVvzUTwCAswJ5Gz8mCq/740MzvpN4IBTUuYYRv3jnvvyginAj/wkZhyyMZZQRUtauHnoio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=i0hVhT/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="i0hVhT/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E311F000E9;
	Thu, 25 Jun 2026 04:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782362551;
	bh=CA0sktO++Ow6VRpzdYwlIlbQ5DKIdcDWBy7MYZV0Fsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i0hVhT/RTreO4fATKMJB2/9g3pPL6K6+1aKqy1vkjPFkSiV2rIS4DOxlirhKwBBDI
	 EnLEEivh6FnqU/wcSGx29p0ih0BtsRKhw53f2g67FoZwvCS8Sh9/yti+VoLV52WXLe
	 niklqSXkacwoAn7Tj6t/L7UF9AlLT5MOqGxGCle4=
Date: Wed, 24 Jun 2026 21:42:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: david@kernel.org, ljs@kernel.org, riel@surriel.com, liam@infradead.org,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, kas@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Message-Id: <20260624214230.4aff522ec8fa4a8f1607c942@linux-foundation.org>
In-Reply-To: <20260625042853.2752898-1-dev.jain@arm.com>
References: <20260625042853.2752898-1-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 04:28:51 +0000 Dev Jain <dev.jain@arm.com> wrote:

> try_to_unmap_one() handles hugetlb folios when memory failure needs
> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
> case page_vma_mapped_walk() returns the hugetlb entry in pvmw.pte, but
> the code reads it with ptep_get() before decoding the PFN.
> 
> That is wrong on architectures where hugetlb entries are not encoded as
> regular PTEs. On s390, for example, a raw huge RSTE must be converted
> by huge_ptep_get() before helpers such as pte_pfn() can inspect it. A
> raw decode can select the wrong subpage, so try_to_unmap_one() can
> install a hwpoison entry for the wrong PFN.
> 
> The userspace-visible result is that a later access to the poisoned
> hugetlb subpage can miss the expected SIGBUS. With DEBUG_VM, the wrong
> subpage can also trip the PageHWPoison check.
> 
> Use huge_ptep_get() for hugetlb mappings before decoding the PFN.
> 
> Before c7ab0d2fdc84, the bug existed in the form of a plain dereference:
> we would check the head page pfn of the hugetlb with pte_pfn(*pte), and
> bail out on mismatch. This would mean that the hwpoisoned entry will not
> get installed.
> 
> I am not sure what is the procedure on such kinds of very old bugs - how
> back should I really go?

I think 9 years is enough ;)

> There are similar old bugs present, in try_to_migrate_one(), check_pte(),
> remove_migration_pte(), prot_none_hugetlb_entry().

Why now?  Was there some more recent (s390?) change which exposed this?

