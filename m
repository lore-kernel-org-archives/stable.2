Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606390;
	b=zxGMeOZ9uj2x5hOrTPdhq0dtp0AyqiG26mZjZG8cJC/aGhATvrQP86rYJuy/GbClCkCW
	 YInhpkqNXw5L4dWxo5bPmJGP3dRI58p28TmjBrqxJejU66fWqubj6utgzEgwKSubEIdUC
	 9wOloBKjjhGz8hZvctbPHatImBPp+L51/VBuzpDwudSW9lx2kU6N1uf+Sa9dYWwIYroiA
	 buwIm0vC8fB6rDO/chDm2rn1NqDE2xI9ZDCTPIOHMxKJWxSGF5II3P6v/1lAbiUMiYwWI
	 wv1mzCHNEPGO0VpT6BNmu+2H4S12A9Xjfk2ccg4wnXMzN7u9uc6KspxCHfR3JSKo0YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606390;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XWkPwjlZlK7x//RkTE3pY9k5+imno9JdLAaVgFYu5TA=;
	b=d4PihDsCXPueiRi5EUrgH2AWNgPRb1Yprd+T1UiKw7P3JQbIYbn6PB/Wj7Iwpsyfs+df
	 mMzpKn7FLN9F7DR52tjUWuVEc4VWOOW1LICj7eG/Fz2nufUBhVOB7DEHunL+2fO6FqA+X
	 Tc2YA2lADwij/Sr5mge0akFqVtvO2VN7it4L72cJIzpRXOz83qkYHlX8oW7SBjrCKl8ry
	 kzALxbYCDU34yFzujgmkUL6gceL5vQccxB3SH1C/xpjE5iSUEnV/2plXQul1M8AMgByeY
	 iAbXpnriSLtUqnfhG4DPAiYUFo3i4DqFffp6QlKEq+IL8bDpNERt4GO9ys4+sGROHow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMoaa9mo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139B606A32D;
	Fri, 13 Nov 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMoaa9mo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79671F000C4;
	Fri, 13 Nov 2026 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606390;
	bh=XWkPwjlZlK7x//RkTE3pY9k5+imno9JdLAaVgFYu5TA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BMoaa9moDEQDEOfY/UeYTlxNutbvDD1ui+qvqyLzW99U7SkkmMYfzNEGLPAXLHqrA
	 cq4MauGAeWbBFSj/AsUIlgwXZtw0LQRWaL/zTm2FrQR5/m6WTi8bTEZ5pRoo9s6x8z
	 TjK9Dj/WatGpdH6zHNjTeA3ZF0XOAeY4bigstcF8nhDFdKVp1vaACaZgqNOCfag+Po
	 SRnzFIr9qD6nRuHvFPf19RMqwy5414rxAqS17dWPGlZRfTQtp2CdH4YgdTremKD7B1
	 0uprRUqjPW3rJTwEvKJFMxWzvXmnUslnqYa6P4WCPOZ5eHQNNQTTyWqbLX1NlDjl/Z
	 tgqeaA3kkghjQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:23 +0000
Subject: [PATCH v2 05/13] mm/migrate_device: don't collect a range twice
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=ljs@kernel.org;
 h=from:subject:message-id; bh=hNj08MXuSQv65gPbpH6iZuCoCEHUbgtpoDb4ETsvU7g=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/yYKOHs4vPqXJ0mr8rdf40RM4UYPAu+uR01nLig5
 qL65Hy7jlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExE2Zbhf9SPzOdfHv6prm1Q
 2jDxQIjhZHUll4ovJY8d3xdM3rByYgMjw4qVyaKeEaIzeX0f3Qli273zw6lHsivTI4J9J0eeim5
 y4gUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Josef Bacik <josef@toxicpanda.com>

migrate_vma_collect_pmd() drops the page table lock to split a large folio
which it finds in the middle of a page table, and then starts over at the
"again" label. The entries for [start, addr) are in migrate->src[] and
migrate->dst[] by then.

While the page table lock is dropped the page table can go away, in which
case the restarted walk invokes migrate_vma_collect_huge_pmd(). However
this is passed start rather than addr, so [start, addr) is collected a
second time.

This can result in migrate->npages exceeding the number of pages the
caller asked for, and therefore in writes past the end of the
migrate->src[] and migrate->dst[] arrays.

Fix this by only handing over what has not yet been collected,
page-by-page, and flush the TLB for those entries which have been
previously replaced, similar to the other returns in the function.

Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ ljs: cleanup commit message ]
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e5dab8e1b77..28ed706109da 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -257,13 +257,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	pte_t *ptep;
 
 again:
+	/* [start, addr) is collected if we get here after splitting a folio */
 	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
-		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
+		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);
 
 		if (ret == -EAGAIN)
 			goto again;
-		if (ret == 0)
+		if (ret == 0) {
+			if (unmapped)
+				flush_tlb_range(walk->vma, start, end);
 			return 0;
+		}
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, start, &ptl);

-- 
2.56.0

