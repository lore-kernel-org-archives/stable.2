Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078361;
	b=SoWZ/IyOeJ7raeu6gDjI0ccvWY1A5pD9FZzeib5SXDrZYR1pM5V4gv7l3J4cIvOBZN9X
	 nrkwmgXkcUjPQmzUr7fzyfFp5XSDuig1gKqvqhcrdUo5KYFB2yasXT7qsZQLTzM4V7WCi
	 x4iJzuM6kdewAlsw/StAqzv3AKk6X+tEeqo4BIF2lDhmaAmgxcY86uUSGGS8zTy2XaXob
	 t8HoSH3LgjxZ60gSVoEWN2vxeHdDlxPtxZZEjflN/muZOf18oTcX7ERdGoFDyouNDsO95
	 BiBbRQiADfiSRPr3KejIoLu/gQh1kSr+HGh3e7c/WEwcTIMwTqoA8/sA+U4EF7RZFsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078361;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=slP12k1/UmuSqVqj4kei7CXwqTFf5wNJ5fzGochv76w=;
	b=T1DUNtwxLQi7FkKHykBbJUlTZCzWLKCd7iz7sD9D4rUOHQ+u7dcBtIjacYg5etClsbf4
	 O/JUlw0JW9IMDtQiCWvTaWdd9LYfVqj0ZkD8+aXxn8ur9WCgJT+OSlXw8uot29MuyF7tm
	 GsJ+HayPnOOwXu7svm8FsDkc7Ljd0QpYti6/s+obWRKkjwpbnJ03Sg+pwz/6cT/u/PEuU
	 ymMT2nNVcYajXYUcBGpBu/cqVQ/8RxDtuUTCNsFvSN3yOoWKhbKF8QgWTa2flCwl4YGOo
	 3QjPcg3R97SdghlFq67Mb9WDY9353Ry8eKJ18V04ZC1rVyETMuyBOV4rVX+Htd++xUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQkCpeqt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924E606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQkCpeqt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F741F000C5;
	Thu, 19 Nov 2026 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795078360;
	bh=slP12k1/UmuSqVqj4kei7CXwqTFf5wNJ5fzGochv76w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AQkCpeqtER/pRkRAMr/L2oDOE2ERxJrbyHH375vGguYu8CugXOzlCmh4jy8w+SA69
	 nxiVYh0Pd2RZq2Y+8m/6KRT/ZMyIBco0fV5jRyZf+cLbEFn4FSS0+OhJVvXDj1C4OY
	 J2DYaVfSdMGNxKaxJT3UTd5u0xOkfStA4kBgZflLhKugqXPXlxrMn0EkOaIqvWySo8
	 yAhl8SVOdu0rGqfS+Gp4BJB2FhDgBt6qBNEfD4kj3ujBCNF/yUlEBKdWvaJpRR2PNS
	 I8PNugYeamptXxk/vL3L1NFXzT8H8wX1B4iHruU9Aq5ouc7CiYZBqWDFH6YJdQV6+S
	 LqamHn8KuBjww==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 19 Nov 2026 09:52:20 +0100
Subject: [PATCH 1/3] alloc_tag: handle a NULL tag in
 alloc_tag_set_inaccurate()
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
Message-Id: <20261119-alloc_tag-v1-1-efcccfd3a9c9@kernel.org>
References: <20261119-alloc_tag-v1-0-efcccfd3a9c9@kernel.org>
In-Reply-To: <20261119-alloc_tag-v1-0-efcccfd3a9c9@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Usama Arif <usamaarif642@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=david@kernel.org;
 h=from:subject:message-id; bh=pQCOEBuVtuHz63BHCaKRIv21JHUplhwXXCn7IFnZRLo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+7Th/8FPU1reKDbNDJlruSM7v6VQ4JH3O3P6fc2h1V
 JKWpsicjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbS9ILhn2JhTcmi67mXXfX2
 KLxMXHRR1tA3pyzhxfp/RY/7XqzXDWb47709PKBozbaH4v5yUs9epYTKLVT0+LeuJ2vlpkpho61
 CnAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

With memory allocation profiling enabled after boot, a slab allocation
can dereference a NULL pointer if current->alloc_tag is not set and
allocating the slab object extensions fails:
__alloc_tagging_slab_alloc_hook() passes current->alloc_tag to
alloc_tag_set_inaccurate(), which does not handle a NULL tag currently.

One way to trigger it is through rhashtable: rhashtable_init() records
current->alloc_tag in ht->alloc_tag, which is NULL while profiling is
disabled. Once profiling gets enabled, alloc_hooks_tag() sets
current->alloc_tag to that NULL tag when allocating a bucket table.

Fix it by handling NULL tags in alloc_tag_set_inaccurate(), just
like alloc_tag_add() and alloc_tag_sub() already do, and drop the now
unnecessary check in __pgalloc_tag_add().

This has low urgency.

Fixes: b9e2f58ffb84 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/alloc_tag.h | 3 ++-
 mm/page_alloc.c           | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 7f2d80a597924..0f9909c6701a7 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -227,7 +227,8 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 
 static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
 {
-	tag->ct.flags |= CODETAG_FLAG_INACCURATE;
+	if (tag)
+		tag->ct.flags |= CODETAG_FLAG_INACCURATE;
 }
 
 static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2fef4092c913c..0b76923145456 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1262,8 +1262,7 @@ void __pgalloc_tag_add(struct page *page, struct task_struct *task,
 		 * clear the tag ref later when page_ext is initialized.
 		 */
 		alloc_tag_add_early_pfn(page_to_pfn(page), alloc_flags);
-		if (task->alloc_tag)
-			alloc_tag_set_inaccurate(task->alloc_tag);
+		alloc_tag_set_inaccurate(task->alloc_tag);
 	}
 }
 

-- 
2.56.1

