Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794632021;
	b=XotpeSlX+uNdny3JfBwogQFyNfy+LAYbPr0sgeYT9Zo1J2+YoWDlpe+7TzsER+/U3e8u
	 9UmBgfS6/BfhiVDJCmWBOQ6ksLKrajPD2xbM4jwFGVywGH4EyaXDPMwnFIl3vLCw9Nqf7
	 r+u+vuj31midyriz3CC1rHdD9nj6QE7ZYFfq3X6uXOre6jVkImQFVGdjSRmVX9l1EWSPD
	 U+V2tUFhkCnwpx/iUEA+/YaKhkUCV0yCNO0gd73uY2FPMEBw0afHReAuly9vhHXPpyU6k
	 dxMnXd1H/jTBm+SxE2RTZ5ubB1+3hv50N8k8UZP/p4LQ3MeuXXX+vJdUWnWHM5h8LCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794632021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Yti5qze33LbOqgNi3ZBWFbak05+I9zzYMvPdLNzCrF4=;
	b=XJgGRDNKesLuLny5rYf6tckADO2bGbl3wREUUistNw0vGqAOEtpW6JQo1TC9QMg6ty/u
	 R3zJyJ5fHzkqAil1TZrwv8VS1v0fGr3LPxZLBNX+46j4OzrYOeBXuHfOpewnbwB/s+nI+
	 f0cauS/Og0ReFFWIz3lo8YOtE4vjVrO95n9lfgS5P6NGaPfSWuTEksvLJnIF3kcwuIzwV
	 vWQrJs0Zg9NweapEX+9Loz2l3NEuTQw+O2SDbCDTKJj7F37QnOEhS3Wf8CMuRVIfW1vku
	 ukOQ7cZ6mQoNJfUirGxf4sXADqBuBsZxhiIMr7ZPQqvFos7FA4haTEg1zLqdRh+2TSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgduWwdT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FDE606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgduWwdT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84711F000C4;
	Sat, 14 Nov 2026 04:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794632020;
	bh=Yti5qze33LbOqgNi3ZBWFbak05+I9zzYMvPdLNzCrF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jgduWwdTGuBS1smC88I1/V1wLcG/ye/Ft1IBEXbVUziJi35cTo7lifrObLfhb1EqY
	 z8X03xa5fEKv9j1qg38ghk74Q7gH1BoFYpmRnUIbk7f6cRuxl/1NCyn93ovz6A2ThA
	 LtHLbK43+9S1d8hKMbud+EVuAsgqReFb2v8RMjDVr4piQz8YT3sUHeSN6/+5vFmJoX
	 frG8kk6l9vY5eTCeTZq6JMWFvtRzrDU2hyh6E41rKTni19kBGuYZxFa6QIDldK6p+j
	 dEz+Rd56tn7L1wZ21/n9JenvzZxGRLBjtnwZJtHkkMQdkFQK0dPIXOolfWXaACD5x8
	 1+8wmCMYxwu5g==
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
Subject: [PATCH 6.1.y] mm/rmap: handle device-exclusive entries in folio_referenced_one()
Date: Fri, 13 Nov 2026 23:53:38 -0500
Message-ID: <20261114045314.2959343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201603-failed-6.1-f3c493d2f42b@kernel.org>
References: <20261109201603-failed-6.1-f3c493d2f42b@kernel.org>
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
[ sashal: Adapted batched PTE handling to the single-PTE flow using the older void-returning MGLRU helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index dffd859bdeb96..4ade867a55cf9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -827,14 +827,26 @@ static bool folio_referenced_one(struct folio *folio,
 		}
 
 		if (pvmw.pte) {
-			if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
+			pte_t pteval = ptep_get(pvmw.pte);
+			bool young = false;
+
+			if (lru_gen_enabled() && pte_present(pteval) &&
+			    pte_young(pteval) &&
 			    !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
 				lru_gen_look_around(&pvmw);
 				referenced++;
 			}
 
-			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte)) {
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

