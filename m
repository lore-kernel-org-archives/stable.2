Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418258;
	b=YS+EyMxy6Qe4FiDR1GqoX8tQQOlnYYu7QK2JAKnPoUWhIkk2JI5xPPJY4VSDnBDuvLfN
	 yvBINUWroYcVbr2dRagKpRtOs+LJHmK/Z5Pdl9tThmijbPiCTnY369b3uKuDLxU8sZY2D
	 cjnhmS/6Ai6gZ0ulgp6fy87yrnuFgB1t6uqsmuv1mIUsJb9cDtoJYViYGFClZ10AVYsFV
	 Pq/FCSNp5WoLbALEI4YtzyT4GZclXGInza2jK+FEq0RK/8v0ipvQVvFM7n+UlTZ17g568
	 EDFD8N6srKDBiJQ7UiiHtxqUYhF3boLsjJVXYaZG2GTLiSJUeKkV+JQB1eg2irBTtuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418258;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JV5GVKOLEyaBHZnDjhlOtWRQQrsO3dwgvOGbPw+xeI4=;
	b=ZyOgApuXKSEimq6AZeu/1166RQl0lDUQMIToOdjKkPhwA7nZ/OTUERleRcakIP8A661q
	 tfIHLp6XP0SOts5TXA+Hi0JnjidIS9+bWHX0ZyAs+Z+fdwEmLRZ/vprovb3fmfSfy0Qas
	 ape+Go1bp4EWPb1jVLE5xdll5P4TtxKKlRqSTgw3q7v65InliknyTtZs4K+g2VWwYqN4R
	 9qAMTuxNIJk9AbD5LMyde5CnmbrxMEx8c5QQUr4x9POhR84Q4FtD0BdxshPvrCWmoQMcj
	 +0MNZfplM/a6UsiuxbxLNZmC3RzIo0nCle7w6WJrwHf8V9srD27Uuwa4w1TuWox0CMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iobE4ZKR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AA606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iobE4ZKR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7533F1F00A05;
	Wed, 11 Nov 2026 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418258;
	bh=JV5GVKOLEyaBHZnDjhlOtWRQQrsO3dwgvOGbPw+xeI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iobE4ZKR9B+xaUzzMKBTIJhdlAtXVktJlP4nOR+AxQiJvpSAdTl4F7qCr36l6Av+g
	 UIDy66DH2j6m1/gVzv3O6xLoPRCHCsWOnjjarpbEEJn+I1ggfACgujrj22w95VdItl
	 ZkEUDNfZYayd6qGFp+Q59DzYyz8e/plJObYvKqWwlG2DlYvNeD4XvU1UZIhxhh//kY
	 4PsNvmim3bNdoIPYijKFAYdWvjEsYgoImDaq8B9O23byV5/oTWjGitHTxGrdcM17+N
	 yYbwsdv0TkyEWZkbpI9c6KRu7TLXLU5KCNnA5xP4nd84TWpA7sVQS62lSiCeqef1wU
	 rexsn7HWFHFmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/madvise: fix data loss from MADV_FREE on a KSM page
Date: Wed, 11 Nov 2026 12:30:56 -0500
Message-ID: <20261111173037.3570025-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202343-failed-5.15-22d043c1da48@kernel.org>
References: <20261109202343-failed-5.15-22d043c1da48@kernel.org>
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

[ Upstream commit 22d043c1da48d6c7274f9dd900714b6d58b7b9c6 ]

MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
folio remains in the stable tree and can gain new mappings without being
dirtied again. Once marked lazyfree, reclaim can discard data that those
mappings still need.

KSM always marks a folio dirty when converting it to a KSM folio in
try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
PG_swapbacked instead of discarding the folio. This also protects folios
that were already lazyfree when KSM converted them.

Skip KSM folios before clearing their dirty flag, checking under the
folio lock to serialize with KSM conversion.

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Xu Xin <xu.xin@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-34-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Adapted the folio-based KSM guard to the existing page-based APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 367220e1fe52a..779bcf78c6a66 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -654,6 +654,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (PageSwapCache(page) || PageDirty(page)) {
 			if (!trylock_page(page))
 				continue;
+			/*
+			 * KSM pages can gain new mappings at any time, so we must
+			 * not clear their dirty flag.
+			 */
+			if (PageKsm(page)) {
+				unlock_page(page);
+				continue;
+			}
+
 			/*
 			 * If page is shared with others, we couldn't clear
 			 * PG_dirty of the page.
-- 
2.53.0

