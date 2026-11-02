Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614895;
	b=Quqpzd5pfAe0mEOpwu5l1tM4HhgwXMnPCwv+SDTOqkZMvHYkno+gWplsWHjqOzsoamjc
	 DLAeQA7wtYU2hwKOnPdZrv1QAahbZ/qxWmdct0n+uKyvwNsjcaZBWwPnl0BZFgLASIQn5
	 Ma4jV78LO7TijIK6rzH4FsfOBCoXSIwZ01IFOyK1R2xFY5R8MgEQlzn2KbjXj/ZeK2mjT
	 P6qmuXMYdB38V9nuxPLoPccdpx7KfNSTYMePKMuWhH0q0zO3FbxE8TAAxUEvtPzxrRsxu
	 5UKhqzZDndfy3DjpXWUe8DMYQ3FYgTZ2LNs9dWa5e9Reg0dQ9tuCrGcuiH7aqr84Q2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614895;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc;
	bh=QWytiepXutFTsTSCSDpRiZvRF2lG5vZz/Rih6Uh1kn0=;
	b=MeeYyj5UMkolZl/Mcmi1Xts2009GXNe8kYGoLXFHkIk/vzFGZbFnj1ieZCzX+dlHEPSh
	 /ae9GJJ8NcRUzgNu0hr1LBPPSWOhAHOdZLbGsdstKCg3upNQNPNnHrUv+Pq9wEvdAiIxC
	 JwnJA3QZDU/ZFKrRprSqYZ5fczr6kgal0yOGbwXnxS+ZzBjo8hxkD4ZenHFjnYhTB+hV8
	 Rkhp39TBVprbEo246RRfP5AwSVQMo4b5Noq+auqJk/vIR9o0e6bzsEnKgWyfnWKkmo2nS
	 jYAsQzFI3d0LHSL4WjdOmgtaNtk06pQZB+fjacV2mtBaeEK83s380inAGRKKRiQ2S9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=KwTp+CDM;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5FE606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF5FE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=KwTp+CDM
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A21AfJC936938;
	Mon, 2 Nov 2026 10:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=QWyti
	epXutFTsTSCSDpRiZvRF2lG5vZz/Rih6Uh1kn0=; b=KwTp+CDMl8gtsAPMigCjM
	CHc7yR176wxji5h8D4P/W21StD8e3GyKOf7aaWV2Op5siRXvPWdYeGtHERl3UPdO
	iLueEnsqLEqNMsFsQmulv0KRjGXSqVMT8CkcXmeke/v4vLs7xXD97H6cyaOVaTQX
	BYv1zBontC3jIFc8SINW2QWQ73b6pNAl0++MYEPb36nqZgsK9iMsxQDWjQkV5gVA
	KV/6RRGU9EOkYYMWw++YkQTDNW6FwMLC0jxxdZOC3qiLCaAh3+TrEv69xW/bP4xm
	BEG3FoXd6cJhEewjftmAIiIdid+9oOVW0K9Fu3AKuTRSmTxCym7GTGGcKil6bZ9L
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn7431kxd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Cw6l1424206;
	Mon, 2 Nov 2026 10:21:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-5;
	Mon, 02 Nov 2026 10:21:15 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Inseo An <y0un9sa@gmail.com>, Florian Westphal <fw@strlen.de>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 4/9] netfilter: nf_tables: fix use-after-free in nf_tables_addchain()
Date: Mon,  2 Nov 2026 02:20:59 -0800
Message-ID: <20261102102104.1558500-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
References: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Authority-Analysis: v=2.4 cv=OpXaWC/t c=1 sm=1 tr=0 ts=6ae8641c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=QjOa6A-HqW6lW5RNUFEA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-GUID: rZf5msVLfIuKt0pZVzrUqcY8FqrAfHeU
X-Proofpoint-ORIG-GUID: rZf5msVLfIuKt0pZVzrUqcY8FqrAfHeU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX9j3YkpzH7N9u
 vT+uwbfEHighhxa+/v9XW1s9lvlJu3T/kp/qB80a4Gsm1a5OLrye/sFhFi0B7JbbmVIXBSK0uB3
 OD6uX8nsi2e9uOpzF0/CfEbsQqZ9uvcugXpn0S7e34iidwcf0ruT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX9FrueXlzxv6/
 5mU7x0Ir18B9O52PPGlgeOrZpkLwOLP1371BGgjb9voF5l30n7iMnD/4Krx1+1pyK8zRsLQuu/P
 /oi+8uRubMUmWXzxUkuEzp+Go/GuJBuCLAC74A3xzWtTgHgw/cnvBSjJZcsigQEdseqlzreWJvo
 oglF/RQpY6OAMCM7ec05eRohuQAqdSF8mSnX2H9RsB86jDb9DmhdnwvbSVCUbep1sRDkEOzL2OR
 6HbLOv2higzxX+1pw44S6T42c9g10VsUUpMiazO8tD/0rqn+L1DzTL0bm/H2G4BuSPL7oCIcpdK
 cR8+W80F5DEhshFEq22m4xgS35bvqNeOPo0atWhooD/RQezTQcgJ92FBu/B87UKZA+pkjYuShki
 twYvMBzXeMuJ0ISFxVp25nq3UFC9dJwARkAvfGEDZBAJ1aC1Uw8t2XIxQMR11/cEeHxIVxzEWcp
 fA5wCnZRre9KjTgTkWjQdOH9eoczmDMcHaCeKn20=

From: Inseo An <y0un9sa@gmail.com>

[ Upstream commit 71e99ee20fc3f662555118cf1159443250647533 ]

nf_tables_addchain() publishes the chain to table->chains via
list_add_tail_rcu() (in nft_chain_add()) before registering hooks.
If nf_tables_register_hook() then fails, the error path calls
nft_chain_del() (list_del_rcu()) followed by nf_tables_chain_destroy()
with no RCU grace period in between.

This creates two use-after-free conditions:

 1) Control-plane: nf_tables_dump_chains() traverses table->chains
    under rcu_read_lock(). A concurrent dump can still be walking
    the chain when the error path frees it.

 2) Packet path: for NFPROTO_INET, nf_register_net_hook() briefly
    installs the IPv4 hook before IPv6 registration fails.  Packets
    entering nft_do_chain() via the transient IPv4 hook can still be
    dereferencing chain->blob_gen_X when the error path frees the
    chain.

Add synchronize_rcu() between nft_chain_del() and the chain destroy
so that all RCU readers -- both dump threads and in-flight packet
evaluation -- have finished before the chain is freed.

Fixes: 91c7b38dc9f0 ("netfilter: nf_tables: use new transaction infrastructure to handle chain")
Signed-off-by: Inseo An <y0un9sa@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>

(cherry picked from commit 71e99ee20fc3f662555118cf1159443250647533)

Conflicts:
 - Only race 2 can be observed in this codebase.

Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>

Changes in v2:
 - Use latest 5.15.y branch.
Changes in v3:
 - Added upstream commit details.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index cde499274fd3..6560da6b0b2e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2372,6 +2372,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err_destroy_chain:
+	synchronize_rcu();
 	nf_tables_chain_destroy(chain);
 
 	return err;
-- 
2.55.0

