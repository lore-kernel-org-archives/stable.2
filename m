Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614395;
	b=R4xJcpt7oS26Yw0nB3t1+aYdvJQGfNE3+DZGlXEkL9F/XOgjB5YhfKReRMo9ZmuRu7oX
	 YlMbEkwoHR/esNgbtmbww0Rl4WFCQsyXNIzFXWR6TdsCBhgik8dGEtCvLH1CyH9HYYGiC
	 4/o/9SvsZP7ElBLkVwf6RMR4aoCDsVhUg/VdoALeCaI4BXdvLylGU8TUkNCvEPNGYiKP1
	 dJ9YKUN042e8gc13fJ5C062cIOF4GdrYvLmjzORcxA2zsgRVHE9kSGvvRdK83VjWCvCB2
	 E9hTuehzWRnxiHDsdJjJF7s+8DnQvK3tkaUit2PI072VLaEev+8jtHPok2u9gSUjEzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614395;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=zN6YwKVtu2ZSj2TAF+9YvL7ESUe8jc5tV+72NfoEBqQ=;
	b=nHdcPesD+sjv6mFCj6SRj5WOxyVuksGX1mmUYeZPbQPH5VtZl1KOj5THyjFWcXolp82d
	 omE87lf0HXqb6YzJACYMOQ5B1Rn+mIJ3AFnlsiDMM8qe3a+dxoN4VKFbINpFY1Lz1Qjk/
	 hz32jyf91fSx9GPipOMUMx8MtX5/p/YzTGxxTKPf6AaBBaHjowxS5R8GrWxGBIa0ocF99
	 dRC4Y+1RT2fp+k2QoR/zZxyKwwp/eu3nh32Cps0qGi1YVff4nSr2VftX4j4PpZdQhuQ1q
	 1waGJWtqjRK77v6n0nhAmm1xNnkqdbfNXMbV3vz0DmxkL/XiMUBDhiy2m5/Qkmfrfmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=itCJIy4W;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9C606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80C9C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=itCJIy4W
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20lEAE1939749;
	Mon, 2 Nov 2026 10:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=zN6Yw
	KVtu2ZSj2TAF+9YvL7ESUe8jc5tV+72NfoEBqQ=; b=itCJIy4Wmlpr5+GlcgLf3
	r3aJB2C8hOLWgTQYVvTdcy3wJKZQng3BwgeGpt3xZHBgCdsdx4hujrP3/9rJpTsu
	4u3cuzZJyXnPt8r4/or0iLUBjZNfmSgo2FgtFcr9QFeJVmF5Elb61W31SaiLMeVs
	Sb2viA0zohgffvQ9LfKxtafIhFBF5aVVxu2wov8IOr4CaApDKKUaaXxsbJdHBvTZ
	WUmtRaz7p61WKOj7U2xKcT4AcyElWsCDjovjvEW27tTaVO2+BlfCXElP9nZqd2n2
	ps19acHCOD6JFGHf9YTDDTjn4LMpJ+AQo8vHvylME5NJCTAi8mU4WcqMaQFKdrwb
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn78a9m7r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:12:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CqOe2995668;
	Mon, 2 Nov 2026 10:12:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-3;
	Mon, 02 Nov 2026 10:12:54 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Inseo An <y0un9sa@gmail.com>, Florian Westphal <fw@strlen.de>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 02/11] netfilter: nf_tables: fix use-after-free in nf_tables_addchain()
Date: Mon,  2 Nov 2026 02:12:30 -0800
Message-ID: <20261102101239.1557688-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
References: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-GUID: uoTFvwD02QoFNEEuXoIe9gj-MAbfkO36
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXxD5o6ITvyrNh
 dr82dgj9n3pEEMZBohFzbn/jDaYWnundtH4QV6isMTI0rccuo7i9nzbaArEtID2tcypQ2cmNVJr
 9j9LmyhdyEBv4PeNVB9mU5TNGiAEfr9WYJ3yVn/bByrj5bs3Aoc5
X-Authority-Analysis: v=2.4 cv=Mo3HeGae c=1 sm=1 tr=0 ts=6ae86228 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=QjOa6A-HqW6lW5RNUFEA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX0pL/ti6TLzdz
 fOtti3ajq1tLP2BlLEjO0cgASAqXol8OCV1aW8rNPPeakP7PFBGkbqZmhMNQwRuhR50OABldB/Q
 pvhvhbmuHqEp7b6+2RJLeFTHC5Vfwma6F+ajFSgzqi+p52z1PLYOH4SlSerkJL4y2j729VgT/P0
 pT9+FCs0Rr96AWU/SQL3csm/oBza3s6fOzfgvCqFc/SHvtqwq5jcJ9IYwtkPI/elricBi4RpNBW
 psWRQSnW7N6Z5ZKb79lC8jSlP3eErsqLC/ImG2fpR6sxMWd5kSR7ku7Nu9Owj8wduZYcZb74xNh
 CnQ60kGBVlRHJjw6hSkbWyrhfJN6PHlLBpk65TjiLmhe0cvmn1iKXXfDMWXO8jJmFd68ZJapweA
 6Tx2qKt69OANhlv4ROe31zFfgIk6O1kdjPrFTYgFeuf5GK24TRIE/nyDSk0LjrZX72Mat69hSQ3
 EmxaQaCEhzHmgn0EHNg==
X-Proofpoint-ORIG-GUID: uoTFvwD02QoFNEEuXoIe9gj-MAbfkO36

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
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f2332b097745..c12b2ded6519 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2451,6 +2451,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err_destroy_chain:
+	synchronize_rcu();
 	nf_tables_chain_destroy(chain);
 
 	return err;
-- 
2.55.0

