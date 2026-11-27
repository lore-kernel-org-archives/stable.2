Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810364;
	b=iLex24oWgZl7wYbJi7JB3HlexC03kPDuwjMSJqHtsefHcdBMRyaCW4fpTTDrpp3czqzy
	 wies4QfenP/trr3FgNoQ1Bm4h/0tfAoJ8Zp0jnhgrGnLsyAlD/2r1tk0OVrevQQBYcJUq
	 QiOHQb+tlhDvskB1iJn04TiouS6ii2fey9iss0fNehFsTN2uJ5tKrSzMmPKK8LD4i52Ta
	 tagvP8DlhQ3dNg+sWQNuS0oa7toDRtqrwdwU6+gwhruQk34HVjGZ3FysSx/HBicciwQQb
	 RQ3Su6mLZNHXhjmOcbmCkcoK3lFahjGAye5Y3eTnNyBlXEIZ6eDI5rJYGCIhu6bvYfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810364;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=iWHH1eS1AYYU4zFf0vBwy2i6v/2UwahO8vVO1074qDo=;
	b=ctCnEFtpdqbh4W3EwToIEM1PnD9frxWVghFbbW7r4yTsEKz5CojdgS+1ivJiZzRMKpAs
	 s8X6Y2eCEPP9PY9LVZy/dasXJIS6BwVQ6MlCz68/vp0LDrkCvetW2oZOupObvLtzvuOV2
	 K1HMG+u4slLEIF9moSZaAldgbA8bSzwN7mBGY4p6DmV/NYJg1EbIbIOhdx/vI7ZHBEZIM
	 TCHqUXxA9vBLKpDH1RKYFvENrVWfDUxqoVrgXMF2NO5zDP5LB4V+M2x8IWLh7Ql+0dWOd
	 E2B70nvAH0xtY55iH/HEwBlDAxN8XRySVHFWtqqqKQbSt2ZM0U0Cnbc2WProZINAx2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmqyPwPB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BC606A323;
	Fri, 27 Nov 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmqyPwPB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605921F00898;
	Fri, 27 Nov 2026 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810364;
	bh=iWHH1eS1AYYU4zFf0vBwy2i6v/2UwahO8vVO1074qDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MmqyPwPBxuH4KFetP3KoUyJuRlpPpebr9NLFx05QU6dle19QXSZcfpDL1G86i4Nfz
	 2L/EDXoNvqIr6I6jMeS5ouhbF9whO5td4SXMbJWdM8PTpbmRXNfWlYqmE3Ecp07jWb
	 mhRctWegQr8NpojL3RaS4AMp6aYf4l3T2EMFLPM+vcp422YVMttQiK8kH+6YtgvwLM
	 0qqroaqE1kPzwBv5X9/Wn1DdI4yDLAFiYhXvavvUX9r+CbVUTbu6HdtzfDLFPlycS/
	 bcOV1Jd57dvsLhqd7P5gHG7NegsJVPcLRx6eGQaqKKVvajg9GdD1YK2lCc5z85GgrQ
	 TtVhRBxq8UdTQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Fri, 27 Nov 2026 21:12:32 +0100
Subject: [PATCH 3/4] mm/slab: keep caches that drop debug flags unmergeable
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
Message-Id: <20261127-slab-ai-fixes-v1-3-cf13b6be6692@kernel.org>
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

From: Chris Mason <mason@kernel.org>

When slab_debug boot parameter contains the O flag and a list of caches,
two caches can get the same id in /sys/kernel/slab, so sysfs warns about
a duplicate filename and one of them is missing there as a result.

create_unique_id() builds the id of a mergeable cache from its size and
flags, so caches that are mergeable and result in the same unique id
must get merged - otherwise a duplicate id would try to be created.

But find_mergeable() doesn't merge a new cache that has (at that point)
debug flags, and with O do_kmem_cache_create() later drops the flags
that store metadata if they raise the minimum slab order, and the cache
can become mergeable again, but too late. An example with the id:

    slab_debug=OU,sgpool-128

    biovec-max   mergeable                              :0004096
    sgpool-128   has U, so not merged into biovec-max
                 later U dropped, so mergeable          :0004096

sysfs_slab_add() has a check for such caches since commit 11066386efa6
("slub: fix sysfs duplicate filename creation when slub_debug=O") but it
tests only the global slub_debug, and flags given for a list of caches
don't end up there.

The fix used here is to mark the cache unmergeable when its debug flags
are dropped. With that, we can also effectively revert commit
11066386efa6 since the global slub_debug is covered by this fix too.

Ideally we would evaluate mergeability with the O flag precisely
(dropping the U soon enough to merge) but that would be a more involved
change and probably not worth the effort.

[vbabka: revert 11066386efa6, tweak commit message]

Fixes: e17f1dfba37b ("mm, slub: extend slub_debug syntax for multiple blocks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Co-developed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 20570e4f1795..9bb031f9a41f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -8864,6 +8864,8 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 			s->offset = 0;
 			if (!calculate_sizes(args, s))
 				goto out;
+			/* Created as unmergeable, so it has to stay so */
+			s->flags |= SLAB_NO_MERGE;
 		}
 	}
 
@@ -9825,10 +9827,6 @@ static int sysfs_slab_add(struct kmem_cache *s)
 	struct kset *kset = cache_kset(s);
 	int unmergeable = slab_unmergeable(s);
 
-	if (!unmergeable && disable_higher_order_debug &&
-			(slub_debug & DEBUG_METADATA_FLAGS))
-		unmergeable = 1;
-
 	if (unmergeable) {
 		/*
 		 * Slabcache can never be merged so we can use the name proper.

-- 
2.56.1

