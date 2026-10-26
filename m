Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057387;
	b=HZ+uv9kUUtwm+Rny7fJoc//7EAhgs5QM8LA0bt56tdlELDcO31fwKf8025sRjtY3RMG+
	 9XB+Mm8utf4wOK7VBqbeHih7rANnUcjLl5vgeoM9z3nOkZKfqNqPbRwMR+crN7ApRsIqu
	 uA0WQx5iLJ7bvvw5nCFWiu9IgNwSnwq3T9EHTcVi5X5MqSZ8x+F7QqfHpuJb0Wf04T1qI
	 IC+xQcz7z6bp7Dtfi2eLrYFH7NLTHvclKbYCRGLr2eMhBPH5VYNz/jLpMNWA2U7nwvjkp
	 yWp2M1Xk3Em7u9EtjqDpDmPoOOIXgjmX9SbYW65cnyniqbfkO/+rzGXHBHZzRaLZswA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057387;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=coOQRGDsT+wJUVW51ZA0Qbw+6l1l2M6ICO7oefEeEsg=;
	b=JtDMCXwemeSfcATp4nZmZL8embjMxH6uT/czFoXp8h1gnyphrhOoVFb8tOLe2FVJeune
	 3LqnRyHNKCB/vsJtWHkHnOVKDEPTMynN42BXUkWiYsT7F2F/UCP5WG5dMwMlAcHYj1B6o
	 dBcx5e/39TPVh9+JH0B4cL46l0ySSm+7WK60eB/B4LhidbhGWxnCJE4qZnlW0yVpS4GWt
	 J1TrWP5q+WD+wgD0QAKP/T8ITS9XVOxrZZI20Qz93EetxxDTSgj2CF341rWneyMAUdRLt
	 z70VQ2wymIETmaPTU+EJ62zJNTihOMSXf8c3hl9xeoYKTozAgzUSh4vaTrLoFat+aPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GiO4u4AK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA92606A320;
	Mon, 26 Oct 2026 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GiO4u4AK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776751F01825;
	Mon, 26 Oct 2026 23:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057386;
	bh=coOQRGDsT+wJUVW51ZA0Qbw+6l1l2M6ICO7oefEeEsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GiO4u4AKmDnNc8YPvYmnDQq3BaIr+RptwEAcqRK360IcwrF2iBXGw1J4DWyV4sHLw
	 MSmQi5baxNEw+IWu5HmCurp2H0sINX0XT1PqKiMpshw1F2bnM249lb1mP7hvV3dxpi
	 N+m8PyNfp4nCcfiSAuW26vuJptP/q9S+unB4blp/je/Ms+iGljDFKSrQg9w5cS7geq
	 1CVPNZZRNDlD5jgns/lYTAziDHZsp0MK3FeSKb4cJb9NqDwRkM1P3hdksaafMGCq6r
	 tMOZBP+r6O5Og0wsloC7zDVaRJvM5uwjDSdXuTuIZRJxrM835hsFQah5qSZ7+y6oUc
	 T4SZkCG4ibHWQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:58 +0100
Subject: [PATCH 38/46] mm/ksm: reset the unstable trees of all nodes
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
Message-Id: <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=david@kernel.org;
 h=from:subject:message-id; bh=FsjPKsNWJYzmMrPhyxtJFP2mccjtdE2o5Mf6O6Ctwdk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/BVZrBpbfEKWi9gCZPyGl1UYv5LxucgjodX84/d
 nXj1IAzHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkcSMjw92qMGGWqxeDpB/t
 55ue9/pO5JsfnUq5j/YnlKxvV5Iv38fwv0hX1t79y//MtLXGB8QSL6zP3r7r9IbVn0+8efTB5KH
 fXW4A
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

