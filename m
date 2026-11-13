Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598570;
	b=GjFcpjvx9z3joh6CMcifYMc2lT+wxMqjlbrQ2RV5FZH6JrAOZLYhFpikOTErzexlfKAn
	 9/H0uKnjQzLpdYbZmtLnhF6WhCUvOHQnJrxEXxnEcIaQ6fYBfVCsqEtt3vywVT6TI24md
	 G5WIS0FcR/oxit8BIj/eqE0z8a65U2TEGJ7ROPPZ1XkJ3yEx0m1wHKF4Y7ofOViWBNdt5
	 xS2EPItkcoPzF8+j92hlobyIfv8NrHyvjKSvStmPi3e0cm6WCY5KFnvL7sX1Enz3tBqwO
	 8uYosP2HFR3mKpOFwqxrUO/4m0sjQYj5WtRshm9SiXlBehwiCKDi11MxXSlEu83oyCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598570;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6KbqMHXHGqHunvle755ZkxdZ+Z6xi5+iGSfarwvLdzs=;
	b=R0jWWFbelpOqxohDcGoK5drvns7SO4M9nG5UUmlkMdCKxJCW9Zz5j9AITgA6RB+AzjN8
	 ImyG//tG1CNeNczc+TCAHNCfQj/1rnQ/Ujtan4wITinkdVBKzxEM4cOSyNtxHLySRkZWK
	 pH5X3stAtENT3NT37fk8vMQrQQcfdBHiAI5UizAh0KqVV6PP8RvrXhl4UECg/qVX/qm5a
	 dYNH2U1oyJj9zpYpFxd5gB4N3X2YFZpiFyQu9N8bkLZ+Ba2n4VqDdHBHnwMmC0U0P7ngq
	 qk2d+GC7tnZ4conEOv9vbhGC+wyNW0oZYP72j8PhfX1fJOv2o1H/2hre6QzRMMtspzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCHA9RhQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE14606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCHA9RhQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72AA1F000C4;
	Fri, 13 Nov 2026 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598570;
	bh=6KbqMHXHGqHunvle755ZkxdZ+Z6xi5+iGSfarwvLdzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZCHA9RhQXQ+Cib/tEABr6tCyH/HEt90HEKc9DiDIEpysAFaALyOF032Kjz4WcT/GP
	 +vxZ22WtSf74EWB7Wi4KsUSysQPKlDJLV8Tl+P1cDIWCLirD4fmDjsmtlVLSazIxQM
	 D5ugS39CflrYvDsg7binPjt3yHbPp04/UctfKxBAU5nxBIP6QSHYxeGlkb97sq/Y3L
	 sMXT5hZaSTeqif//6jFqHiTw8KIgTqnnT+thIiuDhW9jperAPxXEPO72e0yGxPSS0y
	 ktNzjJ1C5qzElqoCLmuPjEq+iE4MkpZXvX5cy09M6XEiQ0YSS+7Ij04TEhJJ2bgxuX
	 jB6N9CjnToAWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	SJ Park <sj@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Colin Cross <ccross@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names
Date: Fri, 13 Nov 2026 14:36:07 -0500
Message-ID: <20261113193528.2433150-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200754-failed-6.12-652f15be3c11@kernel.org>
References: <20261109200754-failed-6.12-652f15be3c11@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 652f15be3c11415725694ccea317c51e35c0b582 ]

When changing the anonymous VMA name, madvise_update_vma() calls
vma_modify_name() to possibly merge with adjacent VMAs. We don't call
vma_modify_flags() and consequently don't obtain the new VMA flags.

Later in the function we update the VMA flags to the stale new_vma_flags
we obtained before. This can result in us losing the VMA_SOFTDIRTY_BIT
flag set on a VMA we just merged with.

There is no need to update the VMA flags at all, so just exit early. This
skips calling khugepaged_enter_vma(), but since the flags didn't change
this is fine.

[ljs@kernel.org: minor edit of commit message, rebased]
Link: https://lore.kernel.org/20261023-fix-vma-atomic-v1-3-8ff4fae1fc85@kernel.org
Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: SJ Park <sj@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: <stable@vger.kernel.org>
[ sashal: inferred name-only changes from pre-merge flag equality instead of using a separate name-change indicator ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 6ce97106d6d44..2f2f4ba351a0b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -140,6 +140,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct anon_vma_name *anon_name)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	bool set_new_anon_name = new_flags == vma->vm_flags;
 	int error;
 	VMA_ITERATOR(vmi, mm, start);
 
@@ -157,6 +158,9 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
+	if (set_new_anon_name)
+		return replace_anon_vma_name(vma, anon_name);
+
 	vm_flags_reset(vma, new_flags);
 	/*
 	 * If the vma become good for khugepaged to scan,
-- 
2.53.0

