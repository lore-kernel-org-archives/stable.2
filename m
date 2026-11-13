Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606410;
	b=rdUUnd5iekUDUIOzL4QtK0fTkcGjPJ2npMHhWT90Kcn7Unip2/MQguXOcjfTZ9fcmnlA
	 j8eYctBBcMdYO6yJPaCg0zKiCD5/6Nikz7ugTLalS/IkB/iYM8U1NA70wiMN7fQJS+isI
	 ekml4VQH7uYDp6jMVdQKfTyjoF050ip4ZUXu6slgseQkN9f0RhcQz0bxX2DXbxIVv5z9F
	 FlwI96Hrc5OEc+YPl3cuZFVtiORtA21BpSLk6Bzo3Saw17IRa9w8HaOHNKiTdcGi/oROn
	 i1T2w7YbK4ew3a8/GWMlpN0pJHSgp/e/cjDA+EggwtXbF0Ijpho9z0cKCSB/P9LcK0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606410;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SbhSMWJZhoke2qAl0UjjAwvOzQBu4RiiX5KWSyo8Ios=;
	b=pVzHVkt3kjPzhUYHwiEgHMrlICPqvL0bjzmXybF3PqAAt7w24CqQh+qmYobbmJFsatfR
	 f748pziQDVJBMUJGEXdX1ZoBo7P/AfnikVGvLOngw0f1oKCBInmMZZe4CeTjILqxPHJrT
	 RwG+rVdTboogTGOCeggayrSruP/db+WAQadBtB9VhvHk3Pt2T+u1fm//1wNCXyZ/NPcJ8
	 KHDQg4wNbJyg/I8taENK1ZjD5h+tjT8SeEelCHUNbtJ84vBCqTOdX1lBK/MJCgpV8nixO
	 tRJmxT+VcaxPzx/mYeOnQDCALU2R+0YWJ0hmrJwKh6UPH89hmgexyXs6YCjPGlcCoww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU8D9s6j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5B606A333;
	Fri, 13 Nov 2026 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU8D9s6j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20511F000C7;
	Fri, 13 Nov 2026 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606410;
	bh=SbhSMWJZhoke2qAl0UjjAwvOzQBu4RiiX5KWSyo8Ios=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hU8D9s6joQEtJUegFkkfvSvT2iHHsk8iGzhEVv/uUzwH0PWF1GXbVRGwT4bHxvrfn
	 2EZcYgGgzpl8nEakZMp2ukOZuBhscxUIKsBNmlylUAMN4zuHbEKxOtMIyY9uSkF3Sq
	 +Ej6ej6y+vU3SBRKADrtJgUejWo4lRa4QkqfhHi1GffmudNcx3vkK4swiTwZxZLEYE
	 1wUR1VOSl9R38mrkzmCSOrdHetR+zQ1eXRJH8U36PauhLGeMWgnv2UYVqE79iEnSFr
	 WP5M3yisa3L1br9ED2b+ibn17z430NFhzGSE5k7bC4vKyU2xfkay79I6BxX4AKR50C
	 iWuLW73rJ9YDA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:25 +0000
Subject: [PATCH v2 07/13] mm/migrate_device: look up fault folio after a
 split
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-7-50a2ed382b61@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=ljs@kernel.org;
 h=from:subject:message-id; bh=aaALv9FtajCSrXDaml0a4kDLKsK9tSim3Q9wP7uXhCw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/x8F1Tw/u3iVyvYXMvz/ZR1VY7MO7cw5/PtKw+8P
 m7c+0LMpKOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATyZRk+CtYFmrVcoe3YOfd
 6OoH2YbLy7OzC3qdDjtsmn6gyLJUrI7hn55t+VeLKJ3+pANvMyYWqd8yijPct0XJ/lrK3MM606S
 XswMA
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
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ ljs: pared down commit message ]
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
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

