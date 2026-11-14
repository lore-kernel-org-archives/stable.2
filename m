Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630953;
	b=nJr5/WAMU+hQXYTgWjbnv5aQXIWCqEaDrtuC7mV7dHiDiSDTDrjn5kzH56/Rxsd7di8G
	 BJdfolgnlZPU58xNHgG7urscZfA7xCIDX6CsrO5TVkkhwKHoTBIXiVZMwdqKuhx/m4LdG
	 kV5wAtURnGc8BKebyfZZ6jqg8e2r+flTwm3WXLExfGWx/PoxjdODLIhN4Fh2515qFPVwV
	 cf8GveLdLg9Meb/JX+KWl5/QYPE8ztrElnUYefzMeT2v0JQ4V1ie3HKAhH0wcpqD/iOXn
	 OSzefhKz3H7pa3YeZzy9zcCMzHl1ygARyUZHcXc/mru6tj0nAmkwhOCLgIGvcY0YqEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GDKGkEnTL68rJqBQ+nRJ/Lch17n/hgHi13XjPrPrUHk=;
	b=J60nnH7gJIcYd854/co+uH1eTsiKUbwJ9g7l3P1uO1RXZLgGueJthyEyWflDPV67MVZr
	 beO+wfEUw2HJvFqxIlaJnO2V3H9UUFNpZ29+//t848dttY30Yu0Po4mDThf7c0sIu4gnX
	 tTmfBHkKRgFZzQ3Fo5M4BDrSItPJr7I4AAecJX1QFdbegjCiMEm2QnLA6w35/a/qTZAiD
	 7koW+skt5mIIh5GO/Fgw4CC4QADN4lRkuwZMB0egyJjpo22wdLouRfKJ3Bj5CZFwFodNp
	 zonWfYipaMueDuL/avmIh1Xj6P6uIlDiHxYaW0U7N6hBda0WoWuNEHBLasNrApgYAQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCsEg7de;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD4606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCsEg7de
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008981F000C6;
	Sat, 14 Nov 2026 04:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794630953;
	bh=GDKGkEnTL68rJqBQ+nRJ/Lch17n/hgHi13XjPrPrUHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gCsEg7denaw74w1h/X2mJS2Bmps48vy92xqgkWnRT+JKW/vbSJvf9JoOsJyNMShD7
	 19K6pi5w2vzlTeFGRs8OsyzpGB2iQAtcwtE/xx4A16p7IWTQe2XNmgF48tt5XNKHqM
	 W4iROD2WLAs5HaqXVPzooj+St4/jCkricqOG8TZ+YEceeMHEkH7bJGWg70eAwTHY2h
	 dj0SUIfOn/iuULhW1A5G6VGH4IgiCKUY12IuwC+RXCRQMEbaQn9vj5TK55sWXw4wsW
	 NxrMomByUb6AEUifyqhrzEmkOhtC+0JwGyqrbZl1r7JVTOIUiSxHxFnYwMkNYlGix7
	 HeD9MHz+QPIXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/rmap: handle device-exclusive entries in folio_referenced_one()
Date: Fri, 13 Nov 2026 23:35:50 -0500
Message-ID: <20261114043159.2903703-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200709-failed-6.12-f3c493d2f42b@kernel.org>
References: <20261109200709-failed-6.12-f3c493d2f42b@kernel.org>
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

[ Upstream commit f3c493d2f42b5f44a5c134d8d7ea7f960caf5e2c ]

page_vma_mapped_walk() can return non-present device-exclusive entries,
but folio_referenced_one() passes them to PTE young-bit accessors that
require present PTEs.

We must neither call clear_flush_young_ptes_notify() nor
folio_pte_batch() with non-present entries. For example, clearing the
young bit on non-present PTEs can corrupt the entry: on arm64
PTE_AF overlaps the swap type, so clearing it turns a device-exclusive
entry into an ordinary swap entry.

folio_pte_batch() will VM_WARN_ON_FOLIO.

Apply the same approach as the previous fixes to e.g., damon_ptep_mkold():
treat these entries as old from the CPU's perspective and obtain their
young state through the MMU notifier.

Skip PTE batching and MGLRU look-around for non-present entries, and
don't modify non-present PTEs.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-9-d6437171ecc3@kernel.org
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Adapted batched PTE reference checks to the existing single-PTE walker. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1bf83e939583f..ad0c6b1eebfec 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -850,6 +850,7 @@ static bool folio_referenced_one(struct folio *folio,
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	int referenced = 0;
 	unsigned long start = address, ptes = 0;
+	pte_t pteval;
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
@@ -892,12 +893,25 @@ static bool folio_referenced_one(struct folio *folio,
 			return false;
 		}
 
-		if (lru_gen_enabled() && pvmw.pte) {
+		if (pvmw.pte)
+			pteval = ptep_get(pvmw.pte);
+
+		if (lru_gen_enabled() && pvmw.pte && pte_present(pteval)) {
 			if (lru_gen_look_around(&pvmw))
 				referenced++;
 		} else if (pvmw.pte) {
-			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte))
+			bool young = false;
+
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			if (pte_present(pteval))
+				young = ptep_clear_flush_young(vma, address, pvmw.pte);
+			young |= mmu_notifier_clear_flush_young(vma->vm_mm, address,
+								address + PAGE_SIZE);
+			if (young)
 				referenced++;
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			if (pmdp_clear_flush_young_notify(vma, address,
-- 
2.53.0

