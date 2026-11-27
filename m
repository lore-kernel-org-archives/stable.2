Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810358;
	b=5fW+nO1wVe13sHl/rm+lgYoyrHLv3IPHhCGmcst4DXAmc4d3ukSKfv29KHvII8MdbKLU
	 7Z3wjHYlR1zzRlorjmrI+jKcunfKgLb0c0Ka5Ne2a0Rz7xfurAiewIQAorkBgDqHWcYn3
	 32sGfYYS0YOGcETd3F2kpjTfB+JzuyPzl+CLH2I8yxfLJNJH+xEJqUbpVcR07f1yRYFQe
	 B2BILSkRqPy9f5trwe1H9dewle3/lM0iGI8JzoV0VGUhpZWVcs34vWzOiEhEzF+wmaNLn
	 pDx6b95C5TlAP+h6fKju/bZnlhhh2aSsP+pKP4KxcVlsoam4ulIUCaZYpPLHIO0l6yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810358;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yxAv8m4xlT0NV0P+L6VwGoxOklVbBhq/IGLIKJdDPJ0=;
	b=D8/C+iR5WeZQcIA3eVgJNS5CxkaOwDe7TGR1zL36TkGHneyqp3GKwQs5uSz54cgaNPlX
	 qanWmg5ezxQ6DWOmKoKVRUBcuB+3MrxK9bi6NekmkP1ZAKrdMCGy/9f+bUp7yt2VgoHqh
	 VCLMkxtTvtXqJYnHAHPnDIWoHpCpfVVrMPyeMWGdpZeP8fkG6RHaTW04zwAZ5StmqlTwI
	 dfatev7xTQ/lT5SjAIagG6zP95NppLDpxUNkyNynUdruuQp75zNrWLzTL38cnRiIopb2+
	 ebYc2Z1j3TDWWvsbmxpq7BpJoZEndgVONAIO1FoA2utdzmGYuGW7RlMzRKyI7reZG9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtlNuFsS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D1606A31C;
	Fri, 27 Nov 2026 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AtlNuFsS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5BB1F00919;
	Fri, 27 Nov 2026 20:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810358;
	bh=yxAv8m4xlT0NV0P+L6VwGoxOklVbBhq/IGLIKJdDPJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AtlNuFsS+61hcU8iYFLe5x5yo8BAekU0rhq6ges+SlGqz6I7AxpETp93XrLMwwpRM
	 xre/dOMdGTHaX8/2Hb+3vt2KaO3XGnHeRzYmBDggVMNLYNtsgXt9t9tLdahJyTByFp
	 dfN6wUWhUBw2Zlz6XeHN/LYYAGAAqBDFI/bjhsNw9shM0jVBtK3ivRNzT/YwCBxAYf
	 NUsy5g6AEuknhjAiobzKLIV8ZducAdjsw+v6iufQMYmekSVqY3826Y/W2c527TerO3
	 /uFrlGyalDVMtA/9NdiHtIc2NrBnX7svVGGL8AB455mC1YsFBoXE9lHfqcgh5GPPwA
	 szKUatzk0EYiQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Fri, 27 Nov 2026 21:12:30 +0100
Subject: [PATCH 1/4] mm/slab: drop __GFP_NOFAIL when refilling sheaves
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-slab-ai-fixes-v1-1-cf13b6be6692@kernel.org>
References: <20261127-slab-ai-fixes-v1-0-cf13b6be6692@kernel.org>
In-Reply-To: <20261127-slab-ai-fixes-v1-0-cf13b6be6692@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

A __GFP_NOFAIL slab allocation in a low memory situation may end up
refilling a whole sheaf from slabs (possibly newly allocated), passing
the __GFP_NOFAIL to all underlying allocations. This can make the low
memory condition worse and it's unnecessary, given there's a fallback.

Given how we use __GFP_MEMALLOC for the refill, there are also some
undesirable corner cases, as reported by Chris Mason. If the allocation
happens in a PF_MEMALLOC task (which it should not in the first place,
but there's no guarantee), the following can occur:

    refill_sheaf(gfp | __GFP_NOMEMALLOC)
      __alloc_pages_slowpath()
	WARN_ON_ONCE(nofail && PF_MEMALLOC)
        retry:
        reserve_flags = 0           /* __GFP_NOMEMALLOC */
        goto nopage                 /* PF_MEMALLOC */
        goto retry                  /* __GFP_NOFAIL */

The allocation will loop without reclaim and no access to memory
reserves.

Additionally the slab page may be marked pfmemalloc, which the sheaf
refill does not expect and handle:

    refill_objects()              __GFP_NOFAIL | __GFP_NOMEMALLOC
      new_slab()
        __alloc_pages_may_oom()
          if (gfp_mask & __GFP_NOFAIL)
            ALLOC_NO_WATERMARKS   the slab is then pfmemalloc
      alloc_from_new_slab()       its objects go into the sheaf

Improve or prevent all of the above by dropping __GFP_NOFAIL for the
sheaf refill. Also perform all adjustments before potentially calling
alloc_empty_sheaf(). While that one already clears __GFP_NOFAIL, it
should also get the __GFP_NOMEMALLOC | __GFP_NOWARN flags, since a
fallback exists.

One consequence is that the WARN_ON_ONCE(nofail && PF_MEMALLOC) in the
page allocator will now only be reachable from the fallback and thus in
case such a caller is introduced, might lurk undetected for a while. If
people think it's an issue, we can duplicate the warning here as well.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 1ce20c28eafd ("slab: handle pfmemalloc slabs properly with sheaves")
Cc: <stable@vger.kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 145a32c334cb..5fd148f11efd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4807,13 +4807,20 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	if (!allow_spin)
 		return NULL;
 
+	/*
+	 * We don't want refills to rely on __GFP_NOFAIL or memalloc reserves to
+	 * succeed, nor to warn on failure. Leave that to the fallback.
+	 */
+	gfp &= ~__GFP_NOFAIL;
+	gfp |= __GFP_NOMEMALLOC | __GFP_NOWARN;
+
 	if (!empty) {
 		empty = alloc_empty_sheaf(s, gfp, alloc_flags);
 		if (!empty)
 			return NULL;
 	}
 
-	if (refill_sheaf(s, empty, gfp | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
+	if (refill_sheaf(s, empty, gfp)) {
 		/*
 		 * we must be very low on memory so don't bother
 		 * with the barn

-- 
2.56.1

