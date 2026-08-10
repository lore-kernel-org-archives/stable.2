Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223A28CF5D
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786340804; cv=none; b=KDu0EBm97rF3r7lvlHpCMTVeoYD8SM3fWlveiqQwbPG2EizwGWjSwWmI/BcArVDbWg7pXLCdDcHT0GO3Ql8SMrXYvpi+sW2vuLjV7lwgbVRKMA4u1dGoMsIDHCyX4c0UQuxLUFrl9yYcVSLtrdfxus1hOH9pn9DOAmkWaF12lWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786340804; c=relaxed/simple;
	bh=xl10QUz+gzTRAGL9THnBRDwCl/VTrpzoIwrgNOtpKZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R5BiFZKCHBxH0MJd0sXPvFerK9CQBVjNOpRoSgjTwawsFWZjlCCfcMa2sW59nWFrE6DwimWlwoMOJVvipo/RUG+2kxvOUn7Ydvu/bIp7FcPjZ1bQwKjyX8Tk9watsxZlux1FaZZc16hPQ52EvFDvrQAHOlZuzNyt+59DBJQ4ctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTQgY9fA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mf0O32Cb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTQgY9fA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mf0O32Cb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5HphL310566
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1Dj7BlpoxGwRzdnJpfUKDq
	CArhBsuZ4in/P+GRdEWqs=; b=QTQgY9fAYtMRz6rM9nNNt8WssZlgBY27uWyUgR
	rUVr2NOXrPUO16WgjZSlMemU94ve0SpjoiXclan4muYXdXfyaqnzPbdO/8VpxjD0
	mxpDrb+A6sEoK0th5ON+3mAcBT0BZEoeshPvnfW54LxQQUoJ8WPCBxX2I87b3tWo
	4TSdez3eeCLdxOpZ96Kc8kOXH+1fVZZygLfS6II4Aykjk7DXHYZaicxkvZih23GS
	nnVnRadCZ9w522uzUMjKWUE/pBl6BPOaylzvdQm1q460ZK+F4FxygFWY9v74FvuQ
	xZ2/6euTzZXZO72PbpvlSELyks/npMpvjesjTcp7pR6USQ5A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fww7cvg9j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:46:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso2632305a91.3
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 22:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786340797; x=1786945597; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Dj7BlpoxGwRzdnJpfUKDqCArhBsuZ4in/P+GRdEWqs=;
        b=Mf0O32CbvaZ9RHwC2u/BnBka41pWIdds1TiLZxdQ+h0vRe9ufKP4dJncfAiaujN7nN
         EkFzNnNoLmUyLE43T08C9xwBxanyxw05/QAnjoi4i+y45Rpp1G1KqqSZ9GzZqqqcgTiM
         K5Bs0uTOkrSAnuU3sLP0LUXN75kLntIw8Itdzdmsnr4GLnbceYdtEQA+loFhlODmnvN6
         67K0xhjVekOIr8yk4hGpNPWuY/9B/JpIur0li2AN2541Ai1OqakoQ2DG7k4gE2Dv94IL
         uQ0AN9CsvV/YjpauzKvNi4BY5gtvukIcJyuMFPdVpZfz75ngLitVbGVn9p4hAvpoxMPB
         R6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786340797; x=1786945597;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1Dj7BlpoxGwRzdnJpfUKDqCArhBsuZ4in/P+GRdEWqs=;
        b=TIH576P5wqre2X+siS5UiEBVIUU9JUlAGESPJ88yKxRRBeTOUlRHb7weRMF6VAl0OA
         jE8tc+xPFeGf67L6oZjpo/WhE9z3cmcUyoQupqHbqtEvJc6gMee7Ez1AqvfNxLquKbTP
         IEKzHiqEHwu6gN+xZ2VWavMqTYgcp6l5SccIcNym6n0f/DNTD2B67vIsN9Lo9wwUPbYd
         mFwctkEYR55jRimxHAt7ro7tpP7/yHls8Gsi9h/73c0VshVTH6/kVNHEetli1l9YdlwK
         snSmTjZNJTb1hXv+G6DbbSF9XLjzUa2iRCatkO5rpLFeSTyW5DzGqqjRh/QD0Xsy1L7z
         TqoQ==
X-Forwarded-Encrypted: i=1; AHgh+RprIAoo8XXKzzFI+KKnCN2Y/98CLrPCQWSg7jIxQBwmyPNAkqOfQCFlqTiRKe2yZPMzyaZefvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZj/quxgcwfjdGLZLR3cyKyqX3vqBwizq80bwBZ9t4gI8yw38x
	rnGIlXu56aneuRL5oCR9/wmzpkeNKez5wxvKWxsaL4x1WMZnLs7mq9Z3yftHxSXKWWLDani3qgI
	mqmafHJ2x4tAe78esyacWRPhtY4ijhkP3YgrIM33LkL0xXj+ffXEaaz1DVBAgtedIO+Q=
X-Gm-Gg: AR+sD13CRa5izhp8K/nr8MJdmpMTxPsDwN5GghXeQAXq/SWz+a1TlLwqXyUPEorcp1e
	cApP42YLR2j1asUgNIvBGIIWrLSL81FgsEfBxhYS4dNsp/qTeG6ZBfOi5bTjDS974Ylne4x+921
	VUh4iwQy1kzu8OtzlpiCUoQtXonCLS3oo6YJxNdC2k6ZbXeaDjqgL96U3Un2+mWpjJ/WtF6qv0M
	GNVxq7fh9WUG5j/gYPTnAUf1sWVAR1Me1zYVEK2cSB8qvymUNbWFMUbf7yQXuNXNztJDKDeQgdN
	CZ26tiMDJHq5JEv0s9IXo3SU7mKnZpSUV3tcORHh8im04PqYrB73bJljzS+3DcUJLGaVXReingq
	NLu5lORMj3lUIyaLSRB1NvAi15uSqPqc=
X-Received: by 2002:a05:6300:670b:b0:3c3:a1ed:3c23 with SMTP id adf61e73a8af0-3cb85ea6f5cmr48532886637.23.1786340796747;
        Sun, 09 Aug 2026 22:46:36 -0700 (PDT)
X-Received: by 2002:a05:6300:670b:b0:3c3:a1ed:3c23 with SMTP id adf61e73a8af0-3cb85ea6f5cmr48532843637.23.1786340796277;
        Sun, 09 Aug 2026 22:46:36 -0700 (PDT)
Received: from hu-guptap-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde308sm39107186eec.20.2026.08.09.22.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:46:35 -0700 (PDT)
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 11:16:30 +0530
Subject: [PATCH] mm/memcg: fix NULL nodeinfo[] dereference on late-onlined
 nodes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-memcg-nodeinfo-null-guard-v1-1-77a73204d63a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALVleWoC/x3MTQrDIBBA4auEWXfAmB9Mr1K6EB3NQByLkhIIu
 Xsky2/x3gmVClOFd3dCoT9XztLQvzpwq5VIyL4ZtNKzMspgouQiSvbEEjLKvm0Yd1s8ekdTmAe
 rh3GB1v8KBT6e9+d7XTdGHwzxawAAAA==
X-Change-ID: 20260808-memcg-nodeinfo-null-guard-dce5f63a2349
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-arm-msm@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: -VC_-YlK8nJ29QguRlvidN3H-tr1afGt
X-Proofpoint-ORIG-GUID: -VC_-YlK8nJ29QguRlvidN3H-tr1afGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA0NyBTYWx0ZWRfX7loApN4ft7e4
 qaZI/lQJ8tlwKFrfF/xuVV/OXqNyV5ED0RT+q6EYtKlPI4SVRSTRdm8iquRMdBO9QQzmyVbtAxf
 q/f/P2r1BtcQElx9JWbHjiB7fmgR7lG5StJ93F6XbaADTMKsi8ICHS0ZlYR5tnwyHiYML0927zp
 JZov47AkqzQN7D119bt4XqPWeW0FonYJkSjzqMao3A/ids0ja5sBxQ18GZltsiS5AJ+JcjEAXqQ
 1xjOUKoR+89drKTm1lowezbajUVqtr/rD2VVeDNE4UqFaBtDG0zNPvgiEL1hf4LcGW+9+69rEUv
 Ape385NE3CgzzW5Ov/Qkhvzva7wN6eG/MkzAv7yk87L3i/PW7LDiOCVQXZqf4iSf6YZmIaby2hP
 MSdEgeF/YpN8jpBF3zPO9lydAg8n5WCWC6QFkyMCWUecvQQgHESzmNmId64jbeg0WHlsMsgvX7D
 zehW3ovHq7EXYlcg0aA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA0NyBTYWx0ZWRfXxa2k6aq/PXCq
 m+4P8f6SI0XH1Ap17RkzFiG7WfPdK0atmuyeqouc4z4cHoZNRNdPoVjJK/jriQOVgWIocxh0lrf
 oIyhCHO9Cr9Ljk+ecJ0caVeFqJOZHBQ=
X-Authority-Analysis: v=2.4 cv=IPsyzAvG c=1 sm=1 tr=0 ts=6a7965c2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GS4ghhMgoEJMoUnwAloA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100047

memcg->nodeinfo[] entries are allocated only for nodes present at
css_alloc time. When a node is onlined after a memcg is created its
nodeinfo[] slot remains NULL. Two call sites dereference these slots
unconditionally:

lruvec_stat_mod_folio() calls mem_cgroup_lruvec() which reads
memcg->nodeinfo[pgdat->node_id] without a NULL check. On a system
where a node is onlined after the memcg is created, any folio stat
update for that node crashes with a NULL pointer dereference:

  Unable to handle kernel paging request at virtual address ffffffbebf7e1908
  pc : lruvec_stat_mod_folio+0xf0/0x444   [6.18.21-android17-5]
  lr : lruvec_stat_mod_folio+0x88/0x444
  Call trace:
   lruvec_stat_mod_folio+0xf0/0x444
   folio_add_new_anon_rmap+0xac/0x2b8
   do_wp_page+0x768/0xc80
   handle_mm_fault+0x37c/0x8c4
   do_page_fault+0x140/0xa1c
   do_mem_abort+0x54/0x74
   el0_da+0x48/0x8c
   el0t_64_sync_handler+0x20/0x130
   el0t_64_sync+0x1c4/0x1c8

__invalidate_reclaim_iterators() iterates for_each_node() and reads
from->nodeinfo[nid]->iter without checking for NULL. for_each_node()
visits all possible nodes, so this is reachable whenever a node is
onlined after the memcg was created.

Fix lruvec_stat_mod_folio() by checking nodeinfo[pgdat->node_id]
directly and falling back to mod_node_page_state() when NULL, mirroring
the existing !memcg early-return path. The fallback must not go through
mod_lruvec_state() since that calls mod_memcg_lruvec_state() which uses
container_of() to recover the mem_cgroup_per_node from the lruvec
pointer; passing &pgdat->__lruvec there produces a garbage pointer.
When nodeinfo[nid] is NULL the memcg has no per-node accounting
structure for that node, so node-level accounting is correct.

Fix __invalidate_reclaim_iterators() by skipping NULL nodeinfo[] slots.

Also switch lruvec_stat_mod_folio() to folio_memcg_check() which uses
READ_ONCE() to safely read folio->memcg_data in an unlocked context.

Fixes: 6c77b607ee26 ("mm: kill lock|unlock_page_memcg()")
Cc: stable@vger.kernel.org
Assisted-by: pi:claude-sonnet-4-5
Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
---
 mm/memcontrol.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6dc4888a90f3..2a6f02956b89 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -977,11 +977,12 @@ void lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 			     int val)
 {
 	struct mem_cgroup *memcg;
+	struct mem_cgroup_per_node *mz;
 	pg_data_t *pgdat = folio_pgdat(folio);
 	struct lruvec *lruvec;
 
 	rcu_read_lock();
-	memcg = folio_memcg(folio);
+	memcg = folio_memcg_check(folio);
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
 	if (!memcg) {
 		rcu_read_unlock();
@@ -989,7 +990,18 @@ void lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
 		return;
 	}
 
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	mz = memcg->nodeinfo[pgdat->node_id];
+	if (unlikely(!mz)) {
+		/*
+		 * nodeinfo[nid] is NULL when a node is onlined after the
+		 * memcg was created. Fall back to node-level accounting.
+		 */
+		rcu_read_unlock();
+		mod_node_page_state(pgdat, idx, val);
+		return;
+	}
+
+	lruvec = &mz->lruvec;
 	mod_lruvec_state(lruvec, idx, val);
 	rcu_read_unlock();
 }
@@ -1320,6 +1332,8 @@ static void __invalidate_reclaim_iterators(struct mem_cgroup *from,
 
 	for_each_node(nid) {
 		mz = from->nodeinfo[nid];
+		if (!mz)
+			continue;
 		iter = &mz->iter;
 		cmpxchg(&iter->position, dead_memcg, NULL);
 	}

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260808-memcg-nodeinfo-null-guard-dce5f63a2349

Best regards,
-- 
Prakash Gupta <prakash.gupta@oss.qualcomm.com>

