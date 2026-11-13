Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606379;
	b=MSCTrAxkeJ3pH85NFBiniJFlhOJBDIAp1cSdU+2MvAoVb4V8LzNom2zS8HCg/HXwYxFE
	 wmIZ8bqR0VP3GB142whkB1DqgrPQTQCOzKHr9mn/lBkGLSuQiED2yp6n4bznZ3bx6wOFB
	 AlWWC0qIP3zWd1lmqKzDK8cT7dNPW/e5XEiLXY6oKV58yst48Wy4/qeQ8FSfE8LFyxnGS
	 FOyLUtiW2vs9ksrJHR7RgoHc4SG6cQFtZ7uctetdUxN+lhRxLv0pX9I7HctDNX0UyWXYp
	 +X1GIk835r/9/meCmu692pwlQsTBb6knFsCtDhVhopwnvKJe3riQaHP8N0vSWiqal8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606379;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8rpd6WLSmRU3qOkeaVFoKOfZ/LYCxe6ke3Meyy3vZKg=;
	b=Qo5Ze9Fmkfil4AJQcCZGo38NmETvpv7U3iE9v/o3uw9xwf8QLjoXQGDLssVH8+wSuJw/
	 HIT+E9YCIPywqPj05tXdwe98zfIkpPlN5Ajd0fwEwq7l89jUR+J6FoesWyFMmkjkBK1Wd
	 KiZLa9lkxfY0BqMVTBQMQ7cf/AAmC1HxlDcF24FIlUj3i6mU/ztikwfmkz0+SHnXUvZ84
	 Fa3u8MlwXv2MpuiWunZSAjVUhVbwy7i51L1tKH5MMaKpuigk6VxUd4KjkkDS7dDipH1Rj
	 FtFCfkBqq/b2qy+UfY4zsg0/kc5S0UZ/cIf3ScEN/PdoMa3Wg6aID8TEg+4i/g3cHSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMqPKEaj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C8606A330;
	Fri, 13 Nov 2026 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMqPKEaj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FD51F000C5;
	Fri, 13 Nov 2026 21:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606379;
	bh=8rpd6WLSmRU3qOkeaVFoKOfZ/LYCxe6ke3Meyy3vZKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WMqPKEajsCLhGzUkvEZaGbSQ54SbihrSASdI/IghM9JQNHOHo3SgRPvLWU3fE6OYt
	 zKPrH4MjS6QSlFrH7DEK3hVvWDQgpS7FUSUlvjzmGaIfGT9bQq3wFfXNwspyDCJMIb
	 BYbdz36X4tIC6kUgLslyXhnWQzU1QJQzg81t2YlF5ZDx/akEUFTez5KFc7LOYblgG3
	 ZoMtLAYLzwBipJe1aqFSXoFYe71qroTQZpJif6I2UPdSd2bz+W8KCvXB8KDdBdR+ly
	 MB69v33NXvRXb0PA04gQF5hZ+xlel8KrdpgtKS+NSVoyvvnqr4lKUIdPNXOmb/Ryxd
	 HLmFei1P+LnVg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:22 +0000
Subject: [PATCH v2 04/13] mm/migrate_device: allocate THP deferred split
 heads
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-4-50a2ed382b61@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=ljs@kernel.org;
 h=from:subject:message-id; bh=sueKEVWnjnuf/6gb3KihY296WkpSAIKgZmGa4KnlpQ8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/yoSE/Udbn7csn+WJ7VBzJNikVlk3h/7s1tv5Va8
 W6hXsrXjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExkijAjwyx/t7W1s5IkpaZf
 P1a31/eWh7vL5lgdU8nJ3F0l9SfP32NkWHX98ee0Vac8cw7dKN/pKv7BNG89g4Lnd48dfbcsra1
 CWQE=
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
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ ljs: tweak commit message, remove unnecessary comment ]
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Tested-by: Andrew Morton <akpm@linux-foundation.org>
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

