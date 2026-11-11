Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420919;
	b=VzsmssmN2KQGCeUdUQtufNSm0tb33GIofRobybgVOzgoYpWUaeF+OJJLwvVEcqZTXVYJ
	 IV2LwaBaLoqaPBShbuFwW38QA5Ml3/V8udexzlDcmzTOcVC7UlJOaohMaY0rsvZfIN+3O
	 CqGuxw4AnUN3ZHepk5wORTgShjs+YMgEfd95R7D7O6ZFCEeeYQwxJCTCIK//bUII4QzuA
	 TAaabO3qpAmkL3KDdHgiZKgRb/Qcxb6cQrwIwnZcq2F2SB+dnE2V81kR2rh3t+vdB0/sp
	 sAayeI8Ph+vnA5GJiuKw3P+jzv8r2F4oG8fKUXE0P7fip8YZSHsvN8o6WVJtd1H47cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420919;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=h/gMKka0KRVoDYIjz1ajHMHaZowebVJOe2Ih0vRtI6w=;
	b=abUMFIQzW1wGAtakasGIUVvs5YquvbrvEjCuquQCyyLqcSPM7CRSLY4MnPfDItQGqsf2
	 8i+BYfq+M7T8FPtRkDJvHHD1udv3YmItff5KTcWjotqz4Q11n88CBJDMJ/OX5CLi6BPT+
	 Ys1bQnAA+vr7WueARjtXvBCBSV486Tw54j88N1Cgt52cG7cjmciMdb/D5+opIPSVMUKI1
	 vCtrU3Rzq9rhVfsLMHBwXtqBbpa+3bslo4TGtHAsQVJP5069VtTNrIY/yWGspjVKUwtGp
	 YRLyCMR5mY8U1UuucXV1q/SvGFT96yegBFxpSLt7E1UaI174QXePDAFnmMXO8/176Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G3G/Avwr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF2606A88D;
	Wed, 11 Nov 2026 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3G/Avwr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AEC1F00A05;
	Wed, 11 Nov 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420919;
	bh=h/gMKka0KRVoDYIjz1ajHMHaZowebVJOe2Ih0vRtI6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G3G/AvwrGxMCrgciaaymdYokDEwWVMqcW7sQoSgNfmLG73ObWU4/CgPD83q/GF3HC
	 l6OrGPBF3VkAfcGm48h26cMxgB7gl+iWHYpL9jLI89e5MkWICAxZ9cXNa5RVf2AuDd
	 NkZMzfZtPNsjZ6C8UMlihXtXGK53CtGfw8s5FG19kEVcWjA6DBL+cbnKSq6cCfxLH6
	 H/tt27z5bi9yoy5sBEc4ixkK0plFfI3O6qSdFra3ueHxclDVFiCV6jAOKMIFxwQlzg
	 0uQHib+dInkNx5CR9sn3rPUgt8skTptKHSpECdXZOq/WGl6wPw96Z1SlCiYG6AtzPM
	 32lhC+r1+zjBw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:21 +0000
Subject: [PATCH 07/13] mm/migrate_device: look up fault folio after a split
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-7-3d2454362e8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=ljs@kernel.org;
 h=from:subject:message-id; bh=4y13Zn4Hv1aBFdu53Ug8OJJPI5ryvtg3+l0TbgSLV/c=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMiuPGJq8Kpaq2TdZ+lvpce7bHgDLux73dg61z/n8
 1/R4EVTO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjAR/VMM/5TmGzLqzJ/p75i+
 4/qipbOme54KaW6avPTDk0kZpg8Kz5QwMvQsmeGpL6hfW2uxSua96fsk/f/LAxdMWOl7fOvHrQ/
 2K7AAAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Josef Bacik <josef@toxicpanda.com>

migrate_vma_collect_pmd() looks up the folio of migrate->fault_page once,
when it is entered, at which point the folio is locked.

The fault folio is assumed not to change after this, however if
migrate_vma_split_folio() splits a PTE-mapped large folio which contains
the fault page, the fault page ends up in a different folio.

Resolve the issue by looking up fault_folio again after each restart of the
walk.

Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
Cc: <stable@vger.kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ ljs: pared down commit message ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index ae795fdf36f4..45e571dbfb4c 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -233,11 +233,14 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long addr = start, unmapped = 0;
 	spinlock_t *ptl;
-	struct folio *fault_folio = migrate->fault_page ?
-		page_folio(migrate->fault_page) : NULL;
+	struct folio *fault_folio;
 	pte_t *ptep;
 
 again:
+	/* The fault page is in another folio once its folio has been split */
+	fault_folio = migrate->fault_page ?
+		page_folio(migrate->fault_page) : NULL;
+
 	/* [start, addr) is collected if we get here after splitting a folio */
 	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
 		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);

-- 
2.56.0

