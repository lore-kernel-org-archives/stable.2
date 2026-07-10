Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750C42A7B4;
	Fri, 10 Jul 2026 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687854; cv=none; b=Aevk1jv5epBi1FWfdJPySOLMRxSAiR9gMF3wqCMoZGro7VdktjuTRrIl7rXn3pzG52LiQ1g794GAJMnmHYxpC9K2o1ckZGP6QPbwBwAfcB7LZXQcGAGTpL3GItb+fvbiTvihEBRoa+zEVj81RptF/nt9lXsu40kH6tyAlz5edzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687854; c=relaxed/simple;
	bh=eqfPRL5PDNrvEo8yYlc7fDeH7P5HGP5kfrr5vFDoH4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftYNqc4x9gDI/EChgAhMsoeUDkLh6dz1KATo3RmZm+tPpJPUwg4muq4lICqmJINJXE6E8WbuyoW9KYRKFRqsduKeuR2N8fiodQs+CwjdKj8DFuTyC8kJC7fCsDCZZwmLaF1ggt7E5/ul2kWFc9bkd2IS3luj8kS+921osaJRf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtIu9TIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtIu9TIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E541F00A3E;
	Fri, 10 Jul 2026 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783687853;
	bh=1iw77b8X16gJrVhQCh42mIIYra8xo3Yaosq5oDaaVCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BtIu9TIzl1M9XFsV3gqi76cbHzlZ6zMvVfGaZhbvQUI8MMp7QoLK8JO+VaM4s4SAP
	 pFtuUvoD3dzOZV6462v3x1pCtBvz7Vty6NI3aEOq26HbdKscVM4MEmhSC/40xPERaW
	 4vmdkoEU+hDFxJDr5AJNzj9fKWamHGWyNBK9b8RBhWR3mJvn7Y7C0rj3/m6CySE6zP
	 /OmkA4e9W9pVi2Scqj6Q2qnXmMnuMcdklTGTzhnJstjkUPf+06GniKe9a1+x7uJ338
	 p5Gmq0KthQLWuAPGAx9v0l1vLB5V0Griemw1ISgvrxpY8N1FvNSWgOMqTEN+H6Hby1
	 9BUjDFT4Fk0jA==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9CF7EF40244;
	Fri, 10 Jul 2026 08:50:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jul 2026 08:50:51 -0400
X-ME-Sender: <xms:q-pQajhNh2CvMVMs04M2RE_-I5qeg_oeq1NSooS9Ejg2MGa7jtaCow>
    <xme:q-pQajUfLl-n5OeAYWDS5cVYTzxyYzG1O8a1IYAMbhz4qXJaSe1JzSyvUnJeKh81D
    2veYgZ4iul4w1BCOd7R_y_ZBdhFRZVZ2qP3bIHavfR9RskFz4Y8Qg>
X-ME-Received: <xmr:q-pQanKRwL__-j4KAi0qotz1jyqsdJ4IXAFhgt4tODMThg2kTd4pgr8THeWLgQ>
X-ME-Proxy-Cause: dmFkZTGqkcapElgZfb8WjwSkBUsAgnVqOvHxOfUoaJ4ounnuNfZAYA0+YO2qLAIPT58/FN
    Ix7SS+Y5Wcoqe7NAjDsgp9IeAYHG6o6YNMxvMnDIu5Z4Iviba9gq6emkFYIqhRXnurJOw4
    Cge+6seryEkCJ3T22+a2Mb8c1r7a4P9zvoHvKbxIiDqAtMCGr9F7B/1SLGQmC+rnQp+hS7
    kuFuzIAj3ENg+QOoTmsDUnayPmoHZyCy3nvgUZTAyu0O8MtyCOnVof4iQcB8CCLS7IkmZm
    3N1z9AhCnOmG5ydzgdftJsEAwCE8jUoLyHLdBW5RrZhSWqChiWQnk+xE2gOOJtUAtQnDaK
    S9Hgku7WaQp2kh43WURBLaZnl41STtc9QDDTYK7YOI/kXezNye55d3fQWfhMpug69SjUOf
    kOX3fClx1zGFIaUF3psaJGJohc8a9lurgq5FSKaPhxzS33SWLdQbnsU5HSU7mu3I5vLpMS
    LyhJdrAG33EhQ9ZbAru8cK1Mph1OHsPq3kU8U1E0IGiKYJEbKCYq0sY7fnCUNayg46r3Eq
    qxomXq0U2jhuU7+Gl0pm+O62UYTEvv7JxVyKOcfUsT/+XcHpTOkp6uwv4Q561mnPU4JFzp
    vcbelLVQa8ff92o7KW4Ry+H6I6nFf3gn5+T6klUQOaQ9VY6eybKWvzywKRjw
X-ME-Proxy: <xmx:q-pQamqjkc0G63olNJFoMBMX61nqaH2sTVPtDNv2-2vM6yDH5Eu-5w>
    <xmx:q-pQamsTYEFb93c_cm7GArnDbPMJUQgpIFRSUW12wH3H23LGihLW6Q>
    <xmx:q-pQapVs01DUCrPedF183EAtiE4TTT74e34llLlG2XqJGddA8CGKww>
    <xmx:q-pQaq2NxFiMrDb_1jTx9onYvW5oqqIW22BdKL3Y9yXsQo2ywq5bPg>
    <xmx:q-pQaiceiJ_87dsJf3d-KxP0rlTZmo7_1X0ECN3ihJc01wA_VO-VBdF9>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 08:50:50 -0400 (EDT)
Date: Fri, 10 Jul 2026 13:50:50 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Carlier <devnexen@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: acquire mmap lock on page table free to
 avoid ptdump UAF
Message-ID: <alDqg4CMUIu_pLVn@thinkstation>
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

On Fri, Jul 10, 2026 at 12:56:40PM +0100, Lorenzo Stoakes wrote:
> x86 implements page attribute modification using its Change Page
> Attributes (CPA) mechanism.
> 
> This tracks properties of ranges such as cache mode through x86 page
> attributes, and as part of that logic manipulates kernel page tables.
> 
> Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> fragmentation") ranges of kernel page table entries can be collapsed into
> huge page table entries as part of this logic.
> 
> As part of this collapse, it frees the page tables which the collapsed
> entries previously pointed to, and it does so without any relevant locks
> being held to preclude concurrent kernel page table walkers.
> 
> The only way this code can be reached is if CPA_COLLAPSE is specified, and
> this is only set in set_memory_rox() via:
> 
> set_memory_rox()
> -> change_page_attr_set_clr()
> -> cpa_flush()
> -> cpa_collapse_large_pages()
> 
> Notable users of this are execmem and bpf when manipulating executable
> mappings.
> 
> However, this is problematic for ptdump, as it walks ranges it does not own
> and thus runs the risk of a use-after-free on page tables freed underneath
> it.
> 
> This patch resolves the issue by acquiring the mmap read lock on init_mm to
> provide mutual exclusion against ptdump, which acquires the init_mm write
> lock.
> 
> It is safe to acquire a sleeping lock as all the callers invoke
> set_memory_rox() from process context and in any case,
> change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> mutex, disallowing atomic context here.
> 
> We also include cleanup.h in order to use a scoped_guard() to implement
> this cleanly.
> 
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
 
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
