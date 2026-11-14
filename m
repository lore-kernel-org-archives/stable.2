Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794631421;
	b=dQCX61sL1YY872eFnzfbseOfbhYDa5nk1qJaE2FnzVhArx3lYsylfLkNBnu6Xy1JeDwY
	 /3A2qfTVYTQwXU6kl3wYcGaB+90EKkOsP1pNMMS9DTFG5BzfzWvB4DU2DUcO5CUsYdln4
	 QnrX93LKQuW9DDkyeZ2gjQwVj7Vc8Tv/VjjWmhTWVyRfXJ22LeB7u7J4QmMOkWghFj9zt
	 WRMolwifgE++lhFwlHqVL+TDxNuxFHTETxTMy5l0U+Vxunx9B7LXp/Iu8Vlyjo03dX49F
	 farOBd/rSgEnZfQuOKv2sPEHswl4vBvLmhhKAy0QOBv7ZZotncmMTPtH2NVoCaPKsjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794631421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z5l2I/g15C40zdRIpivUZ35UI+Ba61AihNxJvVToEUY=;
	b=pdx7X4l2HPV2mzRmabuZYPsPG2nY9lxFY+WaBO8H+sBLAda1NtUsUAlRjXMfflDaSprS
	 kNHDOMlRHFmzto2vAcZj81roz9kdygVDaD2N8kKXCptmNSU4U1qDbryLV4AstAEvsqUJ7
	 bK0zL/t5zTcT4eDNnc/hbEs8GN6YEqoaLgOtfsa5LWMU7CfY72FILF9FP37Dfq+UpfjY8
	 wi7xp4gACJ7Sks11SM4eyxGK8S5FubDWYFoIIqL8Q677Dhdfp0+zLrB3am7a4MwVky/9W
	 CZuWyoVCMR1f+1XZqM7UVy1p6VfJG/SBF94cbHCAUHlDgHuxbC6IfmZhQ0mv9hmUmRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVfyTBo5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0B606A33F
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVfyTBo5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36BF1F000C4;
	Sat, 14 Nov 2026 04:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794631420;
	bh=Z5l2I/g15C40zdRIpivUZ35UI+Ba61AihNxJvVToEUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVfyTBo5u4owPJKErh8dr+vjvx5RzyWTxyqJEr1WZtDp/53zjX3SANfNzPChCnF+s
	 vCoId1bqXz5tqB8huYlcjsJ6NHztMJXyIq2QI9uNcHR0mIvVLrhE0XX7+IBpBP1BaS
	 5dTQcYHRq5O3d2ilR0eNGGURtG3ywgtPGqdZT5h/UGga1slIRmQ8EV//AN0nkho5KF
	 AIALjcHPBVLlf2K0gOAFfsyJpN08v3tQ0DulPmStukAtrpN9XPk/8Luv0x3xw1lpep
	 w/S/vSoX0uMnwUpHdl4c8eASlb+bSW2NcPZr69pHOOU/NmSFJskpswJfDQyG+a3AaT
	 ZnwcV5vuK6+6A==
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
Subject: [PATCH 6.6.y] mm/rmap: handle device-exclusive entries in folio_referenced_one()
Date: Fri, 13 Nov 2026 23:43:38 -0500
Message-ID: <20261114044309.2942263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201127-failed-6.6-f3c493d2f42b@kernel.org>
References: <20261109201127-failed-6.6-f3c493d2f42b@kernel.org>
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
[ sashal: adapted batched PTE handling to single-PTE processing with the older MGLRU API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/rmap.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index bdd32890d5487..2ae76b671825c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -825,14 +825,25 @@ static bool folio_referenced_one(struct folio *folio,
 		}
 
 		if (pvmw.pte) {
-			if (lru_gen_enabled() &&
-			    pte_young(ptep_get(pvmw.pte))) {
+			pte_t pteval = ptep_get(pvmw.pte);
+			bool young = false;
+
+			if (lru_gen_enabled() && pte_present(pteval) &&
+			    pte_young(pteval)) {
 				lru_gen_look_around(&pvmw);
 				referenced++;
 			}
 
-			if (ptep_clear_flush_young_notify(vma, address,
-						pvmw.pte))
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			if (pte_present(pteval))
+				young = ptep_clear_flush_young(vma, address, pvmw.pte);
+			young |= mmu_notifier_clear_flush_young(vma->vm_mm, address,
+							address + PAGE_SIZE);
+			if (young)
 				referenced++;
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 			if (pmdp_clear_flush_young_notify(vma, address,
-- 
2.53.0

