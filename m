Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810361;
	b=zv9h+ol3G43LkaNqjZ4DAtZGqvO/s3a+cjOVtEtn/CObRdlX+npTQwCPu7KeJvz2/M4J
	 ThN5l3L5BRAznzIwJt/lisnCCI1dWa+AU3G6MN9T21/dyER351IC+Cp5J4rak2HsT7pW8
	 TE7Bo4xOOjAOcBCaSVMFdjzEesNwPcTUhaMeREvXhfGjxlD5aJ6rA25bxIwuEgsf1+csi
	 qvNrqKebYSJsjeHGzIdCsuHzaCuOr/3MuvsGRMi9UmJuyHIWuFWEWf/g51A/glikNhhPc
	 v9OEf1bp7K1tlwn2OvjStOjqT4zPr8NQ1u4BkorWSQN1G5AeB3EjaRo9fxA4xvCjT9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810361;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=r4edQ3P70jhub/+FT9FhNdFEoa2jdrX4lY7sL3e6syE=;
	b=4gaEt3c7EbF9OTmLlKteFQS9f1YWwHmGg0GStGhb/Q5BARyhBgrF5HJw+Wf78VFhRw2r
	 IGCWixSyObDZ1qoIwo1VZ1EFFLQ9r3tYqhNsiQyTNcMzToUNjmZtQFyegx7ZGvAvW4zex
	 sdk/FIhcDUP2szySMFC+iL0xe0ua4p/7bxZLnnz3wXU8IwlKfTeDY6KC3l+l7bxYrAdKx
	 TuvKo4CrAjIUFG/OVih1scvjmdVHofUtxVVaShSMABNUcx/ZwcYQ6UWJI5tfcW06KtHuB
	 zpzCfd6BCCoB2lTmI8cofoWeH3PtHNgMFtPXIfDF478XstkKpqoz67ndhXoZDgS9Z8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eJ/WstGl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95892606A31C;
	Fri, 27 Nov 2026 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJ/WstGl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7311F00898;
	Fri, 27 Nov 2026 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810361;
	bh=r4edQ3P70jhub/+FT9FhNdFEoa2jdrX4lY7sL3e6syE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eJ/WstGlMndSxlE0g01Ne+aZWpnghcBlKHV/kolEC8L9JvngRJi220nhuVLggp9x1
	 HcfFVMrtDvglxlgi1RgFGpHel0BhEW39odwl6/jVWbsI1joS7YKTIbl7ZtBz0i1DDn
	 sIYUMz/l8b6tyUUGg3azopov1XHhu21O8lMyfiVgY1TLExSaKitRNbTO9oUk/6uFVk
	 9zAnmGvpBiJtZLNBJ10wwUkN0upcA3iMswozdMXQTRaRjD0I6RP8EzeMfOIVIYYLh/
	 LoaWX4J+JU09VTWf+5xK/H5FjlgrlsplaIjqG29L5Hs56+OQ4TKY6UsQQoSDev4HG3
	 f3u29Nzbu3JeQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Fri, 27 Nov 2026 21:12:31 +0100
Subject: [PATCH 2/4] mm/slab: handle __GFP_NOFAIL better with prefilled
 sheaves
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
Message-Id: <20261127-slab-ai-fixes-v1-2-cf13b6be6692@kernel.org>
References: <20261127-slab-ai-fixes-v1-0-cf13b6be6692@kernel.org>
In-Reply-To: <20261127-slab-ai-fixes-v1-0-cf13b6be6692@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.orG
X-Mailer: b4 0.16.0

If a prefilled sheaf is requested with __GFP_NOFAIL in a
gfp_pfmemalloc_allowed() context, the following can happen in the
initial __GFP_NOMEMALOC attempt.

    refill_objects()              __GFP_NOFAIL | __GFP_NOMEMALLOC
      new_slab()
        __alloc_pages_may_oom()
          if (gfp_mask & __GFP_NOFAIL)
            ALLOC_NO_WATERMARKS   the slab is pfmemalloc
      alloc_from_new_slab()       its objects go into the sheaf

So the sheaf should be marked pfmemalloc, but isn't. Fix this by
removing __GFP_NOFAIL from the __GFP_NOMEMALLOC attempt.

For consistency, also adjust kmem_cache_return_sheaf() in case somebody
would hypothetically call it with __GFP_NOFAIL. Just drop it
unconditionally and also add __GFP_NORETRY there to make returns
cheaper - in a low memory situation, keeping the sheaf from being
flushed isn't a priority.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 1ce20c28eafd ("slab: handle pfmemalloc slabs properly with sheaves")
Cc: <stable@vger.kernel.orG>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5fd148f11efd..20570e4f1795 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5204,8 +5204,10 @@ static int __prefill_sheaf_pfmemalloc(struct kmem_cache *s,
 		return 0;
 
 	gfp_nomemalloc = gfp | __GFP_NOMEMALLOC;
-	if (gfp_pfmemalloc_allowed(gfp))
+	if (gfp_pfmemalloc_allowed(gfp)) {
+		gfp_nomemalloc &= ~__GFP_NOFAIL;
 		gfp_nomemalloc |= __GFP_NOWARN;
+	}
 
 	ret = refill_sheaf(s, sheaf, gfp_nomemalloc);
 
@@ -5345,12 +5347,18 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
 
 	stat(s, SHEAF_RETURN_SLOW);
 
+	/*
+	 * If we end up refilling the sheaf, don't try too hard.
+	 */
+	gfp &= ~__GFP_NOFAIL;
+	gfp |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+
 	/*
 	 * If the barn has too many full sheaves or we fail to refill the sheaf,
 	 * simply flush and free it.
 	 */
 	if (!barn || data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
-	    refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
+	    refill_sheaf(s, sheaf, gfp)) {
 		sheaf_flush_unused(s, sheaf);
 		free_empty_sheaf(s, sheaf);
 		return;

-- 
2.56.1

