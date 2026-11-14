Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794632568;
	b=koBRn5BnfdmllI5NQVknGxnVL9k5Be6nKeBT3Tc4RSkj1UiCSShmvMAuXt2IqqRkJ1EI
	 4T47DoPancvecXknyRgHmK2Ox5MlAIyuTylBdliaEBVM6aRjLGSRiO109Iiy9+sNhImrf
	 eWLqPN7koKmA8QyJjAuEzdNFpT8Yp9QTMYcgWwJ0Q4q8qCiSWKz/XIXKZmgOpWzhSxy5r
	 t/d+gPac0Hw9Im+AdIISXcTcykSYTKv/rQYfoufM43QFzxvxftixUJJhqJpTEdI0xiE1/
	 /fyHrVY8e7G56M3NqlkEaPCzH1pHYlRZHpI0AajMkTrGzJyzqkWZa8cUxJigV+enOTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794632568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q7d8MkeTfCosGM5tuoxtliBEXw8jkDKyBMHBATpXCU4=;
	b=RBzx1uFjUqLJfKDMbF+aiKL0sNw/kGQBztffLj7ynCjNUNCCQEfH6XA3DvG0DmKE0RFY
	 nN2dvtKSWrCh4ZALFJHqzY820ox47M3OrBxf2SLFFejBcbeBOQzXkeYUM/hDZMn8qlY7g
	 d1tNMCu7zqxX7jTiR3oOEpA5WOa4nEmzQCyHrm3G+cNHqfU0jL3J2a9lGT6BNBINA2g6o
	 QMOiHWwnrKY48kqVmCllew/QfVMaEq0y4bHG3Am1PxKvWN1Cp0fOZbWyfseBQD+2Xob3Q
	 HRrBPLSElqncDUjMS53TFyvUGutaKXVPQGiqn1gWA+uHPInqmVW5r/Z+iVOgdcL5qPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ3KQkpf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BA606AB4D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ3KQkpf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1952D1F000C5;
	Sat, 14 Nov 2026 05:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794632568;
	bh=Q7d8MkeTfCosGM5tuoxtliBEXw8jkDKyBMHBATpXCU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fJ3KQkpf/K45hYtSu0FO8GyxfrT0oZKcfBUnTeqekoBvoCfCWxh5+ydPAxqu7v8ss
	 xCht9J03UrOtK45L0vTQPdQQrYcllO5QDI4RNUOCSrXCr+elWLDsNXqijhEVjMAMEH
	 S/j9j+xPLocu4Z07H2wHGx1Gc9wZZ9OOFzkDEeQhAnMkxAjpa62ASZSMQDwnlvFWvF
	 95QaaG5fAN6BZjWJ1xUkdkFlV2gTjsJEf25E/J2BeQz1u1Xqy53abGcGJDA8z3ib9K
	 rO7FXmVqhpRnxtxJXVGNed83FQ19wiZ1NbW8quYB6XE2mQQXdALH2XAfKcRjVX5qhX
	 1d08xKTklkl6w==
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
Subject: [PATCH 5.15.y] mm/rmap: handle device-exclusive entries in folio_referenced_one()
Date: Sat, 14 Nov 2026 00:02:45 -0500
Message-ID: <20261114050221.2996655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202116-failed-5.15-f3c493d2f42b@kernel.org>
References: <20261109202116-failed-5.15-f3c493d2f42b@kernel.org>
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
[ sashal: adapted folio_referenced_one() changes to page_referenced_one() using single-PTE operations because batching and MGLRU are absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 24da8320a6015..544999a055c49 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -797,8 +797,19 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 		}
 
 		if (pvmw.pte) {
-			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte)) {
+			pte_t pteval = ptep_get(pvmw.pte);
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
+			if (young) {
 				/*
 				 * Don't treat a reference through
 				 * a sequentially read mapping as such.
-- 
2.53.0

