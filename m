Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592387;
	b=5qVi35vFwlc0kqSs67k/Njathp8b2DG6tHcBszrN6j0T+CmuSJMJy87uslM2pIMO62tQ
	 nAROKqiHdZnXFn1fcjGd1ZklM3OY6/ZL0R08mVfRnOJPVxWHLEFc9WKy5X9vruXlqvk/5
	 8zN9EDwh1kBMNeOrJGVcMXsufYDNx7/sTHRYr1n+8utd52ZtL+XGqnGP+x52PusXCDIsn
	 cYm7SwIxB3qRSs4xf5PcDxMW63nP6RC2AqqiWcQbrU5V5d20J9C8sqAj1FbHV9Kf4RJlW
	 Au7dLk2H745cgKwemkDsNIsOmE9toh8E72q5MRCTjEzmye3Wui4FdsJBubr+EDUWXEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592387;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QyuaUJ+4lg3ErXzz2AqnSWN5VklK1zHAWHe8IsT8cPA=;
	b=r7MOnS2p6jJaIW5OWVVUuu2dfwEcH4GAas94uTmBpD4NDuxukkCDtREdx+NFKAZ8ROT9
	 /UaaxHfLXkEegSc5Xt8gsmeZLUVUzdRyHPJRhsoYKrCEv2AK9biGiBF+wag/lP5b4xNgE
	 RpGUQaqyOe0aCCjGcCiGGTXXZVMW+Bw5Q3o2QrrPTM1A+IBtoMQXFhbVGl7clfhxWHoVn
	 vUFz0+0iusNY0lHLg3pgVOXYt1aNFzRlUigfhQzbwZD6clMFJt1M3MxdQstQoWFXPh4eC
	 tVP446AZxaLRbUzwRYTNkF7Tn2y8LZTXek7iEV6aAhw6MvMn+F4ZEQ/PY6lwMXcFKCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XuevB5jE;
	arc=none smtp.remote-ip=91.218.175.67
Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F476606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F476606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XuevB5jE
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NdER6oRtsKeTuIl117XW6vlFvInI0gofh/dTxKEIjdA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795592384; v=1; x=1796197184;
 b=XuevB5jEtDVT7lbmN3LnMsW89qiwuRnyo76pyWeMbi5FjQ2efMB2L6U1qRcWOfPMRe3C90S/
 OH/FqJpxuOcElORVR6yqFy/NI1OSxwYOfOGvwGh/mRkGo+JzWBchPK7H5vd2A7O6dn04DmYRP33
 5f7iNf+tBRdaWSre6gMvphWA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 882ad378360a5791;
	Wed, 25 Nov 2026 07:39:44 +0000
X-Mizu-Trace-ID: 882ad378360a5791
X-Migadu-Flow: FLOW_OUT
From: "Hui Zhu" <hui.zhu@linux.dev>
To: "Andrew Morton" <akpm@linux-foundation.org>,
	"Kairui Song" <kasong@tencent.com>,
	"Qi Zheng" <qi.zheng@linux.dev>,
	"Shakeel Butt" <shakeel.butt@linux.dev>,
	"Barry Song" <baohua@kernel.org>,
	"Axel Rasmussen" <axelrasmussen@google.com>,
	"Yuanchu Xie" <yuanchu@google.com>,
	"Wei Xu" <weixugc@google.com>,
	"Baoquan He" <baoquan.he@linux.dev>,
	"Baolin Wang" <baolin.wang@linux.alibaba.com>,
	"Johannes Weiner" <hannes@cmpxchg.org>,
	"David Hildenbrand" <david@kernel.org>,
	"Michal Hocko" <mhocko@kernel.org>,
	"Lorenzo Stoakes" <ljs@kernel.org>,
	"Harry Yoo" <harry@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: mglru: reset the mm iteration cursor in try_to_inc_max_seq_nowalk()
Date: Wed, 25 Nov 2026 15:39:31 +0800
Message-ID: <20261125073931.1171242-1-hui.zhu@linux.dev>
X-Mailer: git-send-email 2.53.0
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

From: Hui Zhu <zhuhui@kylinos.cn>

try_to_inc_max_seq_nowalk() advances mm_state->seq without walking the
mm_list, but unlike iterate_mm_list_nowalk() it leaves head and tail
alone. If it races with an ongoing page table walk, the cursor is left in
the middle of the fifo.

The next walker reads that as "this generation already started": it skips
reset_bloom_filter() and resumes after the cursor. The mm it visits are
the ones the aborted walk never reached, so they have no bits in the
filter being read and walk_pmd_range() descends into none of their PMDs.
try_to_shrink_lruvec() ignores the failed try_to_inc_max_seq() and keeps
evicting, so those hot folios are not promoted and refault in the parent
memcg, until head wraps around a generation later.

Reset head and tail with the seq increment, as iterate_mm_list_nowalk()
does. It is safe: get_next_mm() holds an mmgrab() reference and a
concurrent walker bails out at "walk->seq <= mm_state->seq" before
touching head again.

Only reachable from memcg_reparent_objcgs() -> max_lru_gen_memcg(); not a
memory safety issue, since lru_gen_del_mm() repoints head and tail under
mm_list->lock.

Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Reviewed-by: Baoquan He <baoquan.he@linux.dev>
---
Changelog:
v2:
Drop the helper and keep the fix open-coded (Baoquan He).

 mm/vmscan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6a1af9b92349..3601e58f2a69 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4694,6 +4694,8 @@ static void try_to_inc_max_seq_nowalk(struct mem_cgroup *memcg,
 		spin_lock(&mm_list->lock);
 		VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
 		if (max_seq > mm_state->seq) {
+			mm_state->head = NULL;
+			mm_state->tail = NULL;
 			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
 			success = true;
 		}
-- 
2.53.0

