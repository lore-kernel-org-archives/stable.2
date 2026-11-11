Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420891;
	b=QTzvJ5lfDQK1QY8U39A/sL5X3QFQQPKJbD4cxQODZzOHZtCbgXJgbxL69la/SdsUVpOQ
	 +xCOSplekhuqJ7xkCjBsozXTZeSNbTfkgafv/ZTobUUZCVXy8/uinOWRJYnI06kGNDDIT
	 RpE6r66xMnr82D/SSDz/dYyCWQX1ka715tS2+zzxJdAH28HXU4cpr3s59dlQoMRo6bD21
	 AVf+MFfquQ8g6Oqu/Uld6dmiLoNcd7ucfQKk7dsu7IyVgiBFeZD9Vp0S3omcjStYCSGmY
	 T/O9holCry7pHmAaXpzeUSFv+MhG4l+WgTNGXm4lOmK+YiR5tUF/PgUDm0TOtPdTf6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420891;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iBrqxDvAX0jm66MYxGueSU6Y9eUtRw26738r/ikyIJ4=;
	b=OaWUWk/SDEP9UQh3EB99ugRXUnPHXBFyMGYdcw/xlK5ESn2oT26QPbBtpQuo3CoYxOYL
	 Q1w5S7kcOo8xLSr9Ylsdlvgh39vxDZ8T3Z2uNLNbo+sucwhRPCm5shUO0+5ISJSB/wGMI
	 n4qpoysVCweXs6R1fkfVCl6qhgX/J/JyN5fUGCeTU3E+j+/71+Fj26yEJQgPeBDfCF83l
	 X4TM//TUlk1D/xERBJEdkGL+wTkj1ziF6pAohjvKURYPPXhxz0JcobcwgSWF3A9mG9y5O
	 zO/R4rCmX0pwq+0paSr2ZKF4J0oLVPl+N00VZ6kuzM4qC+yWL5TJ+yWflqklgmjJq2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjvbQVSp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A786070115;
	Wed, 11 Nov 2026 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjvbQVSp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFC01F00A06;
	Wed, 11 Nov 2026 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420890;
	bh=iBrqxDvAX0jm66MYxGueSU6Y9eUtRw26738r/ikyIJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SjvbQVSppMTg2svz/QJqu/NneUf/CM9ncBjbTwznaM/ia/FZG2x6VrAbIep9rXiOb
	 9YdTerPAfZDGdMEqtMTQxWjesf/YknFJY9VFVarEG5R94zHAQ5EhvNw7KwlvHF32fK
	 S/lZ+DxCTtd1c3W5mYdwSJhzS+h0PXqRlqD0U7WmBy74VpWmjtwjASpxP+SQbOPr3s
	 16FeyHejGTbuucjHttyObG7cE4/tikgwSeF1Xc2YXO2h2KJIsMLucauyScuuBK1qxR
	 nvxTWBwN+DjqMFRgzCAhRDTILzcMmr7OrRgMaT2Pve7K7/qOAl5asIIhdBgNdzVXwu
	 9kURjg/DKSBGw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:18 +0000
Subject: [PATCH 04/13] mm/migrate_device: allocate THP deferred split heads
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=ljs@kernel.org;
 h=from:subject:message-id; bh=ibMf4g8+XoIQ5HakdVfha6zsUSXLFsCy8+nehPr+V+0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMieU3BEonX2kbI2rkn+W+ZnJUiu/7T6n8Wvmyrbl
 q+RubjoVEcpC4MYF4OsmCLL8y/i+4NEwuZ1XvB3g5nDygQyhIGLUwAmMn8HI8N18Z19Rcp9ndt6
 /NbOdXwU4Ht2nULe5OmXPmSaOzW18T5mZDjcFrl5b7baCYmE9k5jz5oJW5Sn9OTNz05XUblt+Or
 4NjYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Josef Bacik <josef@toxicpanda.com>

A THP that device migration maps into an empty PMD can end up on the wrong
deferred split list when it is later queued for a deferred split.

This occurs if the memcg has no heads yet (resulting in a warning if
CONFIG_DEBUG_VM is set), where deferred_split_folio() will then queue the
folio on the parent's list.

Once a later THP fault in the same memcg allocates the heads,
__folio_unqueue_deferred_split() and the split path resolve folio_memcg()
to the memcg's own, now existing, list and take its lock.  They then
list_del_init() a folio that is linked on the parent's list, racing with
anything holding the parent's lock, and both lists' nr_items counts go
wrong.

Resolve the issue by calling folio_memcg_alloc_deferred() after the charge
in migrate_vma_insert_huge_pmd_page() and falling back like a failed charge
if that fails, as __do_huge_pmd_anonymous_page() does.

This was originally discovered by code inspection.

Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
Cc: <stable@vger.kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ ljs: tweak commit message, remove unnecessary comment ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c..9e5dab8e1b77 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -833,6 +833,13 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 		goto abort;
 	}
 
+	if (folio_memcg_alloc_deferred(folio)) {
+		count_vm_event(THP_FAULT_FALLBACK);
+		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
+		ret = -ENOMEM;
+		goto abort;
+	}
+
 	__folio_mark_uptodate(folio);
 
 	pgtable = pte_alloc_one(vma->vm_mm);

-- 
2.56.0

