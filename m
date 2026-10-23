Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763273;
	b=xn0gqSUck+FexibuOr2AYAP8UAwsN/1d9e3mjYkh4qOo/GltaCEjeg+oiI8wjbGgHFmu
	 /dvwy4e0E/Wz6kTbDhrgIv7LRrbdoMQqvKf1O7Yf2rnAp9uFNzay5W8Z7WZmxsLm6ZFHc
	 d4wlZ4AOz7LWIBXdmQgLKb65ChJwrVvjcNHN9x4zxIjuExRs5amcgvjdtBFTU5yJTf0J2
	 xfn9Y42MjQh/InAHn3XgHC21XVYZIBGuHvv9m1CGPVkhA/JzeE2fJ2tQCPcoOUnKc+7gB
	 ZtYfwwhKurFMSFvl4XlMSXAQWvsSDUqhDo7Te5FxUC+eiblRmWiuxS7XuqghNW/pbwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763273;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=b8PlXFeXPIMULatUGJPR39iwhYNo68iKGZKAUipKPAE=;
	b=sjkOkZYrMt3DXRaKqvBiSnF6xXzcpdAV1NP4BCSe88dSCIkEUL9WbIQzIL8DodnVUPdR
	 icf0Lxj/DUyboVItyEVkKimSEJXfKcGA/9VSmhikswiu3zbJ+7iUq3ueLa+PDJaXGEOkO
	 xDtrpXDPayhX+i/7nqEzrFZheu/S7QAFXGQLGkY9SzotINnYB94aab/sUo5rks8PWJY3l
	 zYZuBpiujBHlJ/84rVQHqhF/9Eih11W0/GHzPHzrnD3TExpK9GrB8l/8LLPGIx2Lo0nSn
	 N5HGklUZKymnnKjrmeWlITNhXAGfo16799LBhhLV2JYR6t1A19Bz/tJ312rF5p3XJxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyfrLfRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66A606A31A;
	Fri, 23 Oct 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyfrLfRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FB51F01825;
	Fri, 23 Oct 2026 13:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792763273;
	bh=b8PlXFeXPIMULatUGJPR39iwhYNo68iKGZKAUipKPAE=;
	h=From:Subject:Date:To:Cc;
	b=EyfrLfRl/6eXOF1vlZq5joi0UMItutPbnKgTKaw48KYGj5nVzLNp5o2T2UtIYV4wU
	 VoxIzdynZyu54LaS06o75JX2ti/uMCzukL7vsGN0hNYQP5kpRxCXEDWoja5YiLp9BS
	 /PMwA2eIvSQKrUDZBxfgwBZ33QoAfsGOOJ8nQ+eVCGxiHTZdGhqpfhgousYKZRYN5U
	 oBOw72KcnWbfhICt+PctlhQpYrigpAoZtTbdOZjdQqvPEq+n7GnfhrkSTCmZJyFlNd
	 qGrBLiDQtZzXd5KZlPizVXJJBqWVb0eBG/2ck2kTWG41KdoWa+TujokxAc92dJMqMF
	 acTC4PfhottSg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/4] mm: avoid losing atomic VMA flags
Date: Fri, 23 Oct 2026 14:47:26 +0100
Message-Id: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkH3INVXooPoVntQQyMC8e9Jx
 4GZqVA4CxdYhgqZHymSYgc9DuBOGw9G8Z2BFBmtiHCXF59g0d4piMPJzVrt3hhLE/ToytyNf7h
 urX35R/AfYAAAAA==
X-Change-ID: 20261022-fix-vma-atomic-8c910fd66a28
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, 
 SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
 Colin Cross <ccross@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=ljs@kernel.org;
 h=from:subject:message-id; bh=EzgA8OpuDj/HPokV0+ioX4khGkGy32kgZSQsaHsUjdg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJup7ZMnpOUIbnRwN6Ox/PBp08arqWV3rmP170vZgpqb
 T8TUX2zo5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABP50cjI8PBXyvrFEzh9yt+v
 eHfuRJpTQp6RaNWHUC63KbJM/ifvfmL4X2DkzJ7DFCK9+Ym1bO2lBkXV53pTLCZ+DNzmO903+cQ
 HbgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Since commit 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove
under VMA lock"), VMA_MAYBE_GUARD_BIT can be set atomically under the VMA
read lock.

However, a number of places wrongly assume the flags are stable under the
read lock, which can cause stale atomic VMA flags to overwrite existing
valid ones.

Additionally, one case in which VMA_SOFTDIRTY_BIT was overwritten is also
addressed.

This series addresses each of these, while keeping the logic inline with
existing conventions.

Each patch in this series is a hotfix.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
David Hildenbrand (Arm) (2):
      mm/vma: write lock source VMA before duplicating it in __split_vma()
      mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names

Lorenzo Stoakes (ARM) (2):
      mm: do not unintentionally overwrite atomic VMA flags
      mm/vma: avoid losing atomic VMA flags when setting sticky VMA flags

 include/linux/mm.h                | 166 +++++++++++++++++++-------------------
 mm/madvise.c                      |  10 +--
 mm/mlock.c                        |   6 +-
 mm/mprotect.c                     |   2 +-
 mm/vma.c                          |  57 +++++++------
 mm/vma_init.c                     |   3 +
 tools/testing/vma/include/dup.h   |  78 ++++++++++--------
 tools/testing/vma/include/stubs.h |   2 +-
 tools/testing/vma/shared.h        |  16 ++--
 9 files changed, 185 insertions(+), 155 deletions(-)
---
base-commit: 5f980b2d53abf3950caff5d77b5c69dc6ebb19b6
change-id: 20261022-fix-vma-atomic-8c910fd66a28

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

