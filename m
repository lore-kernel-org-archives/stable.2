Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440224;
	b=KD/MVWxuiSR0ZsuEcdt0M1MwbEV0WyCNO/2Hm/Wsks0pjYT8G+smP1H9j2YnB/6KcN7N
	 K6IXlbQdVjyeMfw6QFzg5TocdvNM/a9HQsLaJghWHQwlbFS7IOjFvOl9IcYVGu1En2zlI
	 RkZZGt/KKWAdaWn4dhWu0S14x+U71b1IBarT4XdOkoNbAYlBEmKVoVJFV9Rypxg/jb4zt
	 Vn3q0FlYyYkq5NNIzhITTyIfP/tpPWEw4Se9azXabyLzyB/ka163g8xhK+5HVRJwACoMI
	 fNoiwOu25kwfxdxIb6Iu9jYOzaoLRoDVf4XCz2KlSkD7o5m+ayq2Mi8ojGxpF6wvlaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440224;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=a7XJnsrw1a5gmHitwDTAR/cnJ4FEA4vxklFTb+Y9pAI=;
	b=fy7UDjqKjEXJunfTwreQmRFPYmbgYNKNFH/Ir3Jo/NF8weYA8evTlaDgXuCSrAeI/fX6
	 /LpvEgv9djySTweDSu/nGjJlcK7j1d9pX/dn6RnvDmUF5xOtBH0ovIaZhQKrrvieG61PY
	 tsIRVIPGFwf2j0M08l/wPnCWOFK5T0+N9YcnR5hokFwhl2KWs6j5HFGMsxpDsIRqyHA4/
	 JXeAQNWcTM7U/dIIKKw2xgOM+4wxjUB18AIrAaszcKrBkJnG/C0c7BC3NrZVdTxYd5Tnv
	 0EWgNMQbMjlAdTzbzhivWKL1HooG6Z+WW52TLLPxdbg1+9M5t3o4XT6UeNPVBKKYALQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D55mz271;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C21606A31D;
	Sat, 31 Oct 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D55mz271
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB23E1F000C1;
	Sat, 31 Oct 2026 09:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440223;
	bh=a7XJnsrw1a5gmHitwDTAR/cnJ4FEA4vxklFTb+Y9pAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D55mz271223NPR/LC1mWZwbXNt7+1AppD98IF3Xlhmsw7cr59Bv8ph/Qx9T9wBTnt
	 IRwJ7seKAp3Xt9M0DCeWAyLI/MBriK9GHaWUguJRzUqEOo+TiWgX1qd5uRZCu44wc3
	 amVr5MQIuUPQd/aX+pFw1+Aqa6T0sOTHCCeSMgSu05Km1pYzwKn2nx9VLksIuSqedo
	 anriGwlarij1k2nk9IYxr5TA0xhzc7DIcNVboZ7ylnFEKgBq+ljyKATpFJ08imOsjt
	 luKTD8IrLdDRCGXQ76EvNimb8cuzICBrv/G7y1QJwDUhW0eiLn4XandQmIWO1ShaKU
	 YWQzaO32/jcow==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:08 +0100
Subject: [PATCH v3 39/47] mm/ksm: reset the unstable trees of all nodes
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
Message-Id: <20261031-fixes_core-v3-39-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=david@kernel.org;
 h=from:subject:message-id; bh=nUvclxTiUv/Tum9+/Zt09Qv8koZgF+ihTZzvWN6IkJ0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs8SFbm2as8ZL5Oti3XlL6p6yF24d96eSeSMwCaJw
 rLk7vlRHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEykZB/D/7A7eX6mD/nX/Ltk
 832B+LYAgVaxGd9nsTU7uyRtnjjXYQvDP9WEP9ebK1m+eVvpxFrq87b9VOuZltIVvGG+efeHM0U
 fGAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Each full scan resets ksm_nr_node_ids unstable tree roots. Enabling
merge_across_nodes resets this count to 1, even if per-node roots were
previously allocated.

So when toggling "merge_across_nodes" 0 -> 1 -> 0, a scan that starts
while the setting is 1 and continues after switching back to 0 can
encounter stale unstable tree roots, resulting in UAF.

Only root is allowed to change "merge_across_nodes", and the documented
sequence is: "merge_across_nodes setting can be changed only when there
are no ksm shared pages in the system: set run 2 to unmerge pages first,
then to 1 after changing merge_across_nodes, to remerge according to the
new setting."

Let's fix it by tracking in ksm_nr_node_ids the actual number of
allocated tree roots.

remove_all_stable_nodes() and ksm_check_stable_tree() will now scan
more tree roots (skipping the empty ones), which is harmless.

Fixes: ef53d16cded7 ("ksm: allocate roots when needed")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/ksm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index dbfb8f98b1892..9c51925825cbf 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -475,6 +475,7 @@ static void advisor_stop_scan(void)
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
+/* Number of allocated stable and unstable tree roots. */
 static int ksm_nr_node_ids = 1;
 #else
 #define ksm_merge_across_nodes	1U
@@ -3636,14 +3637,13 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
 			else {
 				root_stable_tree = buf;
 				root_unstable_tree = buf + nr_node_ids;
+				ksm_nr_node_ids = nr_node_ids;
 				/* Stable tree is empty but not the unstable */
 				root_unstable_tree[0] = one_unstable_tree[0];
 			}
 		}
-		if (!err) {
+		if (!err)
 			ksm_merge_across_nodes = knob;
-			ksm_nr_node_ids = knob ? 1 : nr_node_ids;
-		}
 	}
 	mutex_unlock(&ksm_thread_mutex);
 

-- 
2.43.0

