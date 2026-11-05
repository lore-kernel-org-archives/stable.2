Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883861;
	b=sxrjRMVhKz1owiUzFvpML/ZxMRd3X7GB+dUS5Pc076Kbfg944WE9jBNcbuASjWIZuhK3
	 pNu21svm62oJYUPrB0PTXWopIL22fDZM/mv8BkAx7iM2xHTts248JZQ9lunw5G21Ao9G6
	 5yp39rYuguIoU73P4dXFOS3yWAlGZom3Q2VMJDC33KHuuiZ3mPoy1v4/xXETFzWKG1lvs
	 gJrmRutM0owrEs97wFvuQYYpletVL2dxldStWmLd3O4Nkc1KE5aAXsfmsfDDhHN07eNjd
	 ntpHvuAoEwTmx8ffcyR315TUNNz49P1h1Ab5AyImcZRKp9H5BChkKVGtTO4r5HrmG7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883861;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=VGtXYc1r1fEEKTL7Yj84vITN0MZ0IiuZ0W73SGkuDDY=;
	b=b390C0SVJa1/Ru0/hQDee97LRkI/BU4KvkJ3CFduQ6W+8d09j8hUY9F3Y8v30V3TPuov
	 m13xbe4BqWfd6FhTcVctbWwr94z0xfRhgI0Huwfk+hjvgBziLKzHCJvaqpS3SN/1Nxg0W
	 gw5t+qoG9YkNdJe9JOO+9Gg2TzYTuu8zT2DzBtDOuZr3pvmtSUeueEm56flXUZI+m1/z2
	 egPSNhpXr1R9A+a0dAMf+iN3yN2zwDTuUPua5vcXN4kCw5Xhq/jl0XCklz5pE9hZySHr/
	 j81exNYLFIi5U4G/l4DWWz+V5wDZEmcKctkDqoDHzuGpT0Ymj4HiqlPUEICgCfGVaaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyBusioC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56375606A32C;
	Thu,  5 Nov 2026 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyBusioC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A751F00A1A;
	Thu,  5 Nov 2026 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883861;
	bh=VGtXYc1r1fEEKTL7Yj84vITN0MZ0IiuZ0W73SGkuDDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hyBusioCAWpcmb2v5X8AgFwAFzSMoACqD4oDvCV0MPAlZ2X/Vp9gXKQkV/wfO0NyQ
	 VKPTW5B/sjKvciQWPzosqTuDJWgRMUGUjWMSFvvK4Z2AlpcSBfTEuyG2AL3Gx2jM/X
	 zNHXfkVnYBB58fgvZdLSFJI9AKVuXUdmC/H6FVj2DMecvuTjI1HrikoOiFLt/a838U
	 sXLdUKFRrYnYXXbtRAIV29Wl1oG75udM100Ydm9JQw0lcdoR0ZAUu/Z92+qcUhpg0b
	 I8QZzpbh7dvvpZgIzWYegbcKmtjH/JKnCgg3+02Q5v2WbRR+7M+0JAJgWCbwtFBlQg
	 LoO/pZsC44esw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5580C198003A;
	Thu,  5 Nov 2026 08:04:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 08:04:17 -0500
X-ME-Sender: <xms:zn7sagX0bHbqO4A4TRBYez_QTejKPgkzRwAViqmY3Q2vjo9CY_2mzw>
    <xme:zn7sam4INjcHnQFcJfTI6uG9mIag1kAX4vNpX_O9rfCMLv4fmPKeAju4Jcs99CriE
    DQa_mrCnjFsm5GYJWuJFzfMlquu0F1CVwljJtc3OnDCdL6WuZaDTHDc>
X-ME-Received: <xmr:zn7sajHIz1M1ojP4JndE-bnH5Lboc5LvmijY9MxwNCATfeQhkUyt2mKr1Ng>
X-ME-Proxy-Cause: dmFkZTGWioZ5UsUZvGXjaow1BsUGadLs8aZQdTF4UnV/07NAN/af8tN6pM/FfLXYfyZLfb
    xRpT19JopPsgAFGYsm8FzaqvOcRv05DtuUalhGCfVBg5TYHs9JXv+Q47gmOf937P2Gi3S+
    U2sfvRv8HM/m1nYX6eGi2a4miDiVYyQMuuHiidk1Rop6z5ppK7guJf5jvUfTyMXleQeyL+
    YFG9WYCksR8P+f/IoUx4Wo08VB8Mvto3/EHOpPBXbwb98JXOAs0bmRST4eO1cbxBPUkzyb
    YU+NZSxhcSt0KRFVrgpydwZFv0ufeT4P8d+qRyppjSLMzQpNREs19lQwYqTs8BowLu6Nf0
    PR/JbnTjTlqcoe9z9eXCxtppE/iBqN4lxahyvqAWND3wSza41vyy/g8b8tJb119KbVZ8CZ
    MuRhok4swEs4IKe4vdUOtIKHZ5plH23vTgaYw6PfyI344YttADPGpvH6z1snl9sRY/w6tT
    BrCIVHE4Cs5mpSXa/717IOVH1XtBwbuOkBGFH1n9JQAOTVfvpnco/Iz5sDs/mRgagaVrey
    cq6c90syhHHUbEfhX1t/E8+JdiHng3sYYvf5nhsjkohkNfCEDaVAHGUsNyVx8+QglNqqXK
    ulKWha96KxsFQer7kolLJlTQQ/AiVpLrSfhPXbnzPLT0MJ4ciPeh+uKeOiLg
X-ME-Proxy: <xmx:zn7sasRYreFG1B12dgaWNLJaMTnvJum9gmqOKA_t2ZzUrKeUn33c3Q>
    <xmx:zn7saoMA0D4Uv985DwquZetStTw113Ib0q1_tpUBZ9ajeeEzbsBWxQ>
    <xmx:zn7saseZmeGUWPdwDHpB1Rp0nFyftZwCqUaODIf3SBWPBFb_Kb9U9w>
    <xmx:zn7sarVZeG7-wD1HvalF6WI07O4X-rs7VxKwjsOGPZyZuRFNzx6Y1w>
    <xmx:zn7sat-3I3FOwm9xcmy-LlgXxJQcXUcQS1qD5nrBScIbL-4eJN9kZEQj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 08:04:14 -0500 (EST)
Date: Thu, 5 Nov 2026 13:04:13 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: free unused page table when setting a
 huge PMD fails
Message-ID: <aux-ZdKu97JHLY96@thinkstation>
References: <20261105-khugepaged_set_pmd-v1-1-cb79ab117199@kernel.org>
 <aux9liPvdZgpKCpa@thinkstation>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aux9liPvdZgpKCpa@thinkstation>

On Thu, Nov 05, 2026 at 01:02:08PM +0000, Kiryl Shutsemau wrote:
> On Thu, Nov 05, 2026 at 01:16:05PM +0100, David Hildenbrand (Arm) wrote:
> > do_set_pmd() can allocate vmf.prealloc_pte on architectures that need a
> > deposited page table, such as PowerPC with the hash MMU. If the PMD is
> > no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
> > without consuming that table.
> > 
> > Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
> > userfaultfd operation can install a PTE table before taking the folio
> > lock. If that races with set_huge_pmd(), the unused preallocated table
> > is lost when its local vm_fault goes out of scope.
> > 
> > Free vmf.prealloc_pte on failure, as do_fault() already does. Successful
> > PMD installation consumes the table and clears the pointer.
> > 
> > Having to do this cleanup outside of do_set_pmd() is rather nasty, but
> > other callers depend on it already having been allocated. This needs a
> > cleanup at some point.
> 
> I hate this being outside of do_set_pmd().
> 
> What about making do_set_pmd() freeing ->prealloc_pte if it was
> allocated inside? Nothing changes for caller.
 
Or if we want to keep in set_huge_pmd() then set_huge_pmd() has to
allocate it too. At least, it makes some sense.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
