Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606400;
	b=X4OdHhjIiEhWCMhREp2qrG+nwoKFalYP7vlaFuX03EPkg3whfJrMlW+ByhUQpPTe8/9G
	 YN5Y0+UoF6jJ7nZ8HTCobHqfrTXOtxyMHS+yxDxNztXZpm1yby6BfkebTEfYSOvrdSscY
	 sZUgmSrYbwVMwRUvXk2e6BRAkj1moBUy12wVkhZzcVoEtHek4nZbImxGTSa3bL1eKbO2F
	 riH4RUV/sWjYwb5XNHHlxPY0TAyjveA5nJGJfY9isuhCIQLjU/W5p9fNwmDkNUO9gQjr9
	 L4Zvp19pAiLlP7xNeR3IXzgHSClYL6D9zB7isBjAUAie2Kj7VnNZXgQ+W6HRvjMeksw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606400;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3YvYeLiyDo2WJY3A7jowQ+v4qJEjUUU9rQqDcUHgwvQ=;
	b=fEG1T/t7GwqVoZfRjm8WjybyUV/fDcHv3bNyNb4l3RAqJd6ukOyGWulrWeGWP42jPpst
	 l2Hm6XSyVL+NMwfnyhjTovODXXIL6VWwJhZAQmp2iTki3RtRfcEdbEeeSoz0FPqZ5zxKO
	 BYJotmodPRF46nWRVKETd1ozaKyBwE7Auh52GGG5xHEdIDzYM+jFmD+8aXyv6Lwf5/oz5
	 Xz+t/H8JnByDYHI3N+IrnYamw/7hNN4+MrivutFjeu+uRw9LqVaIslGYg5cKTSRR8SD0X
	 fm6zMm41D40o/G4vMhpnVWLkGiTiJBoMghad/5OS5gZWeocM1hNtm3Nj8+pB0uwVH+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iyb3feCR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C3606A337;
	Fri, 13 Nov 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iyb3feCR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DDA1F000C4;
	Fri, 13 Nov 2026 21:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606400;
	bh=3YvYeLiyDo2WJY3A7jowQ+v4qJEjUUU9rQqDcUHgwvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iyb3feCR/RX6uerHZ7ydY0Vp8mGc1Mc4S5Oo3mx1S+Fs3s+tMrTp5fGbvr0AuVDRC
	 ln1q1ur2lgU7rWtBP0weSThEceg7c8E5MCfTZoHwo1UgQh0/CeF4ncuMqkcqglDcTb
	 4hFmURSfLRGsJAOfkobYb+CphFQkkGlvA+g7NbAkT4mTnCRSrPVTg9kAd7vVdip4GZ
	 +h4BrGqp5Rce+I7bEuq6l9wvwDLguSyMik88B8XEURh5Emr0sUEGp8DbqOv1WH8hll
	 XnGTX2Xdg2QTQO5t1aybTRgtpRu+xxRuLW/xf4b+jLT4FJHrcdXCA5kpi7m5V8LkHf
	 8KMyp91i+i8sg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:24 +0000
Subject: [PATCH v2 06/13] mm/migrate_device: don't let go of the fault page
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-6-50a2ed382b61@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811; i=ljs@kernel.org;
 h=from:subject:message-id; bh=r+tXZxpV3ZAyP9/DK+jG5Vk1RL1Id83MUXHpqCwRA1Q=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/z8/0Lm7IunAp4JM1rK3BKUA/R7EsuF/3Wz+ZSop
 K1R1NrRUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIlIZDD89zT5cz3oTsi2i3F/
 HL2/2mzreDxNdv73xmOv/q88b1cT84Dhf7iOjbv976LUMu73DRNe3o646Cz88crzN+/CktYYTrq
 pyQUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Josef Bacik <josef@toxicpanda.com>

When migrate_vma_split_folio() has split the folio of the fault page,
the lock and the reference which the fault handler has taken are at the
former head page.

It then moves them to the folio which now holds the fault page, by
taking a reference on and locking that folio, then unlocking and putting
the former head.

split_folio() has unlocked the new folio and has dropped its own
reference on it, so until folio_get() nothing but the page table entry
holds it.

Only the mmap lock is held for read, which does not prevent another thread
from zapping the entry with MADV_DONTNEED.

If this happens the folio is freed which results in folio_get() taking a
reference on a free device page, which the driver can hand out again at any
time.

In addition, folio_lock() can sleep here with the lock of the head page
held.

Utilise split_huge_page() which will leave the lock and reference at the
fault page correctly.

Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ ljs: tweaked commit message ]
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate_device.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 28ed706109da..ae795fdf36f4 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -87,39 +87,20 @@ static int migrate_vma_split_folio(struct folio *folio,
 {
 	int ret;
 	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
-	struct folio *new_fault_folio = NULL;
-
-	if (folio != fault_folio)
-		folio_lock(folio);
-
-	ret = split_folio(folio);
-	if (ret) {
-		if (folio != fault_folio) {
-			folio_unlock(folio);
-			folio_put(folio);
-		}
-		return ret;
-	}
-
-	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
 
 	/*
-	 * Ensure the lock is held on the correct
-	 * folio after the split
+	 * The lock and the reference of the fault handler stay with the
+	 * folio which holds the fault page after the split.
 	 */
-	if (!new_fault_folio) {
-		folio_unlock(folio);
-		folio_put(folio);
-	} else if (folio != new_fault_folio) {
-		if (new_fault_folio != fault_folio) {
-			folio_get(new_fault_folio);
-			folio_lock(new_fault_folio);
-		}
-		folio_unlock(folio);
-		folio_put(folio);
-	}
+	if (folio == fault_folio)
+		return split_huge_page(fault_page);
 
-	return 0;
+	folio_lock(folio);
+	ret = split_folio(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+
+	return ret;
 }
 
 /** migrate_vma_collect_huge_pmd - collect THP pages without splitting the

-- 
2.56.0

