Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420900;
	b=4Huh181URdexqQlft4qd4Ov+/EaIROjWby/oynthYxX2JGpe+djEfZiT0ppbPiiTxac3
	 9Jj4W5sZFSJEGtVpiGhK2t/BMinz6E2/g6yi+twqIUG9kz2hlKvOC9EtHVPw3MxU3ilkc
	 U2OsA6PHJOe+KTRYPXAr0GkqiSh9iTK5dKlOWVxwFR1XfdOMbrJYxmLKZiOvEL6Axz7JH
	 r+WQn8Db77Vmt8fnYER2zdccDTbAU31VnE2MUB18vic7idM0I9xgdlY2vCehyqUMEVldO
	 Kmm8PaP7vAOJtgz1n6RX7ipE13KDvEoFXt6cUNPawl+LDFvb+DwWjtNrgc+7nL/PuuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420900;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Buk3PCdlUKSvrN/rLV6mnuKwPReLzCz01F1nyw9gMnE=;
	b=GEtgg05wXZYRdqTEiPvScYOQJ9LjpvHAospVXtthW/I0KGJKQe1+YSUTxuY7eYJyRyAw
	 omsyKnTi56bCScl1Hq0kcLys61k2XzeP7qn5WmkUxoH9RhUaTpyvUi/vCDwbsBeRxoOK1
	 mRi7wjpd2pLq8rVLLf7VD4DE5/AhYEXqcE6L7JHOM/lYwEX1E61HoKiUjJdWy8xjqJSQv
	 hK3catowwdkvnwhIt/mFb7BSZl5DVe1ddLDb20u7cOI1j7wa3fpTr6pza7rguXOQF5GBQ
	 qhfRd7XnmHzZez3Nw8EuOsY1DBftZ9fquNlphkukX7rxeM0rPbqKQra+DZE6G/7+OFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mAqi/pv4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21C606AE09;
	Wed, 11 Nov 2026 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAqi/pv4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AF11F00A07;
	Wed, 11 Nov 2026 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420900;
	bh=Buk3PCdlUKSvrN/rLV6mnuKwPReLzCz01F1nyw9gMnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mAqi/pv4v4Iopb7CiXqu2cDOEuZ0ArviQcECPk+lduBzPgLoWeozZ1fBgRqlh0Wr3
	 9cT2tSNJOstlvhqtkHbi4OuiUFT9CKQWwe1+dOzvcOjsR+THcIH8JG+GlC/NZ1wjpt
	 TPa9A8G/HZyD0IdR/MwzymJuCdDpoNunYGdeaq2pO8zG3mJ33r3WkEoaNrifY60Khh
	 jvF3sPAaiqsS5SJgJYU2jQdfID7nMJiLqBriAFrbWOQ5fuLDTKYd5oJHo2k5jKQAjr
	 vMIfcelKI2iCjeyul09CNd9l7vyc+Ja3PuxltmkMtbkpDvvOQaKIStx0g/H73U6OcR
	 qT0CDECZKQozA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:19 +0000
Subject: [PATCH 05/13] mm/migrate_device: don't collect a range twice
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-5-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=ljs@kernel.org;
 h=from:subject:message-id; bh=kqozfbS2qa3Y1PRYknIOHsgbbOevcTlvnNv/lqyBKgQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMhW/5h0cbeo9p9lTYXl0Va55ocYqntOGgrd7L59k
 1HZZfH8jlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExkSTQjwxOmvrkm7Gs/Wezr
 yL0QPGd5epJ12LNFdmrdU7q3LtuwaRsjw+c1LptN8o5a6mhy/HBOOhSxjzvYaEtxyH91680LFxz
 cxgQA
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ ljs: cleanup commit message ]
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

