Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F8434E28
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198540; cv=none; b=TIt16lyCb2CmlYqSms5wY1sllxeC2YpYH+rKhEfboH+lzBzpd2ByE+6Q6fF6S4zif9pGhwO5l5ae55ZAygKReU/Nozq598WNWk2SFMM5e2Avh4bAecsk/bD5bP7z2d6cBpp8OOauyeZcgc3u2cGPlB0ROEO3TQxn5mk27EZ2JPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198540; c=relaxed/simple;
	bh=tcb54Qnt2GyKPrrk5QtRoEjYtXqxoV0Zul100yL4uUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=if/Y2eUFCpHUjqoGRUEizfLLhr56c+skeXA4XEAR4f4Q1Depx9Uj0F3sQTPbyhOyKrTEgOju/pQBlJMFOL4qOLIT8wp9ftQNH3gWAQ8sv7CgzqMSH7JJADC1D3YGcQfHJIQGo1A/nKdjohhR8TSwGnIes5U8f5uC1p9evovmdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=qeY5HF7s; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="qeY5HF7s"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381b831d535so100698a91.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788198536; x=1788803336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vU3022IZTIrb8u3t2YTCnTCe+NuA1eT/LdRMgAStZmk=;
        b=qeY5HF7sPN44DqHyjo9hb6XrePRfPGhYb9ab9rlbWj4ntt1aLxZZ4Iczm7WVQoO7LL
         ZRNQk247JwVLFjzHEEZMRleHvL7l1CWF/MrgYn8I6mbSd8TO4r1ul4zO+OyL3NZECVXa
         W8FZSwd7CXLr1sgLzW10sit2rVI2E8fdmNgMOn0Ia0Ow67LNZnHY57qQE6A77TI4lErs
         gNhJ9AivKD4QHER91YRkPyqE/ZBNXPageMaOMWSTZ47wFXZvipCZX5Hmub4eFJjNQ2hB
         S7aYnKIGYRBnCNHI6s9x7oJjS5cA7R1haR7fOsTH5cb1IhAijKFij4YJefl+pRr1K3Nv
         T9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198536; x=1788803336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vU3022IZTIrb8u3t2YTCnTCe+NuA1eT/LdRMgAStZmk=;
        b=bgt1f2J/zkHQOvaegHvpt6YdiB15+tJ4BYYE9cwA0RBfCFAcYN06zpTfIUqthLOaC1
         3a2WO5+DDrYv1rK9/5P6Op5rrcGVXa7fXOygdBJ71XVVvmJzRb0EuIO9+okKeHQmi4mv
         xpSYfD5G9ewNoonGujLuY8lr8OC5QDH09jy0dxb9X3Mtyn6aXk96+MG+2aR9uIBOZiOX
         Fy4qcU27mhmQ/d2OPMg5ZqoY1iH1iTN6728QHqdQvqh+Wvbl2suVRMnGSdIEkQBemKJT
         6wmV6LenN1JpYZU7VZZh6hTZiDMbBaWipH/Lsor38hlKLSaoRXVGxb1ju+jTdY1fZ04D
         kuPA==
X-Forwarded-Encrypted: i=1; AKwUvBwZ6PbjrCfM+awIKEYGZYsorv0M2HRJSDpyVQSgnMHMi+QJ7azoOg1uh8sc9HWTXZtuWnjCkp4=@vger.kernel.org
X-Gm-Message-State: AFuF++m6gMs6Lv3iUbnRHWmCYSAMcfCgPb9UjXeV+oUV7FBEN+6VD3ar
	C+h9bwV5gjf6nDToSEPLZPWK/72lVAltQYN90dG4YridJhve3MT2tpZy/Kl0Z+5/40o=
X-Gm-Gg: AYBFou3cfuQNj/9x0+nMeMGVatpSa6ydhJ3kN9B/z4Y/Aw06STjKTtjyEkGyZXfcw4x
	eWDBbNwm+F0VIoXJ/BqqmLAGL0sk30Lf/Th3asPQ6tAur/EvTINyGBgHX7XHvWEKrQurXuhWuUm
	YU9sWNhMjGG0BCRJgqNfEFjeWowP1SeWFSseyuKc25Agw9oSLMB1Q75wuehtdItWvc2Epp/yTU2
	+KARY2myouT3dY7AqYY4hqoUIowqbfCh68e1IHunrEsWAau1ry6ou6Xs/yixuHZpPVgzwdZlB4z
	quC+PN4bDBNAB+RwfgVKBoM1ZHpxICi/wfaUVDGXW/ks4JIUy0Bel/0GVhipC2gN+lrbRU3hCEl
	KBGYr4olmC4c7QwaTLq2M74OJD72k7tqMnDXY35QyP7Al2rkB1jy9lqzFpYTBakqYUHdcGu7Rmw
	wt3xCoz+IJRjwsSuZmnv7jn+gIz4fnhnpgJgMKZexWQAan6FaAK3Pc
X-Received: by 2002:a17:90b:6c7:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-396d0e25905mr43315795a91.2.1788198536190;
        Mon, 31 Aug 2026 10:48:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990c40d0c9sm731964a91.7.2026.08.31.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:48:55 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Damato <joe@dama.to>,
	stable@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming
Date: Mon, 31 Aug 2026 10:48:35 -0700
Message-ID: <20260831174836.3102406-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Charges that exceed memory.max and return through the nomem label can
raise no event and simply return -ENOMEM.

A non-blocking charge can hit the limit, get rejected, but is not
visible in memory.events.

This was noticed in a production setting where bpf_mem_alloc() attempted
to refill its per-cpu freelists, which triggered a non-blocking charge
while at the limit.

Commit d6e103a757fa ("mm: memcontrol: do not miss MEMCG_MAX events for
enforced allocations") added raised_max_event to cover charges that are
force charged without ever reaching reclaim, but charges that are
rejected outright were left out. Getting an allocation failure without
the corresponding MEMCG_MAX event is unexpected and makes debugging and
monitoring harder.

Raise the event on the way out for rejected charges as well, by routing
the -ENOMEM return through the same exit path that already covers forced
charges. The existing behavior of raising a MEMCG_MAX event on every
charge/reclaim/retry iteration is left unchanged.

Tested with a module that performs accounted GFP_NOWAIT page allocations
from a task in a cgroup at its memory.max, and measures the resulting
memory.events:max delta. Without this patch the rejected charges raise
no event at all; with it the delta matches the number of rejected charges
exactly. A GFP_KERNEL|__GFP_NORETRY control, which reaches reclaim, raises
the same two events per failed charge before and after, confirming the
existing charge/reclaim/retry accounting is unchanged.

Fixes: d6e103a757fa ("mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations")
Cc: stable@vger.kernel.org
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Joe Damato <joe@dama.to>
---
v2:
  - v1 raised MEMCG_MAX once, as soon as the charge was known not to fit, which
    collapsed the existing per-iteration events raised while a charge loops
    through reclaim and retry. Instead leave that event where it is and route
    the -ENOMEM return through the same exit path that already covers forced
    charges, so only the rejected-charge case changes, as suggested by Shakeel.
  - Add Fixes tag and CC stable, as suggested by Shakeel.

v1: https://lore.kernel.org/cgroups/20260827233119.411152-1-joe@dama.to/

 mm/memcontrol.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1271d390b617..158b0562e8df 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2656,10 +2656,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool raised_max_event = false;
 	unsigned long pflags;
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
+	int ret = 0;
 
 retry:
 	if (consume_stock(memcg, nr_pages))
-		return 0;
+		return ret;
 
 	if (!allow_spinning)
 		/* Avoid the refill and flush of the older stock */
@@ -2770,16 +2771,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * put the burden of reclaim on regular allocation requests
 	 * and let these go through as privileged allocations.
 	 */
-	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
-		return -ENOMEM;
+	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH))) {
+		ret = -ENOMEM;
+		goto out;
+	}
 force:
-	/*
-	 * If the allocation has to be enforced, don't forget to raise
-	 * a MEMCG_MAX event.
-	 */
-	if (!raised_max_event)
-		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
-
 	/*
 	 * The allocation either can't fail or will lead to more memory
 	 * being freed very soon.  Allow memory usage go over the limit
@@ -2789,7 +2785,15 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
 
-	return 0;
+out:
+	/*
+	 * Don't forget to raise a MEMCG_MAX event for forced or rejected
+	 * requests.
+	 */
+	if (!raised_max_event)
+		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
+
+	return ret;
 
 done_restock:
 	if (batch > nr_pages)
@@ -2848,7 +2852,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	    !(current->flags & PF_MEMALLOC) &&
 	    gfpflags_allow_blocking(gfp_mask))
 		__mem_cgroup_handle_over_high(gfp_mask);
-	return 0;
+	return ret;
 }
 
 static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-- 
2.53.0-Meta

