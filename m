Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614408;
	b=uhTZ/E69n+jQLanvAhc/AhhQB/uD2FzSwnfEEar68rMa5NWFD+Fsp2XfKWHoEmiF5KAx
	 7zRJJGIWidjvYQcJfwbkyd0ObXUr3ivr0Syzrbm1XluGCJ9183LV1EaCrW2nhcri26bnh
	 TNZW2YnubFWrhT2jeWxke0gmMsujD+oVp5qEq7i/po0VRxiMu8Lw5bMoEQbYaBnR//sCi
	 V6e5VndZJ9xIJYHd+ss+emGFMWL8IgIT7h/2DJ1oWcXsVt/zZZ7LWdOjeOAV9Uc+LsZGt
	 f62qg48qSQHNmKj/jaEe4lE1xellgZ8TD8e+jZBqlqsbb6YyD8bEHvbyhfrLiCrWWiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614408;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=huWq9Bjt5HdAoBLF3KkJT+cq+0Sg+quhydLK/cd4tng=;
	b=jdkuQOD09iSBK6YgGCGm1iPyB7vAyPPBwyTL2uBvIEg9Sluhw+o1v5VLKN+0jQ9cmAu9
	 AAtp0Z9xVdQFBrIjRYLfDQlQvnoeeiw0jJ7sAIzHkwTzcak/b1fhiJ/OIgY1SW9I2dVdI
	 77c0SNaJd+S/01Lqljfq/DwAFXjUv8hpCVhrMJZO7JYIBV+r6PJ+1w46TnfefM/cNNFYE
	 WThQNtp/iGHNKnl4INBouWHFZdvcVtRfZSXrafqguyisSJZa1BYGCxTGoFHUBav4fOO6z
	 cm+ZBgq6836fZTgyde6pJg8U5pX+Iyrzy/jMgtHhnWzuoakgfM942gOz+UK7nWpUGog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=qEN7MHSs;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AB606A32D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0AB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=qEN7MHSs
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20VJlW3310981;
	Mon, 2 Nov 2026 10:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=huWq9
	Bjt5HdAoBLF3KkJT+cq+0Sg+quhydLK/cd4tng=; b=qEN7MHSs9NpwIkMuMfLZ+
	9AzIuYSZi9ChKTtAmhGS5e9FB/I5o/Q91BRUWGDc0kulnxLIEFY72VkrCyviOpXP
	qyhGda9LWOKu3IJgcuPqvXjdKujh35HMUA1bdqc5GXLqOMydvqdexHq3MDd5B5Qk
	9kIcvTod8g9BZKDYZWyOwtMhcpCbb1B57GMrkoZsiXc+vAYQVE178CW9R03QbJMI
	dpMAPsfZmp4pIxQEix8abFNQKhLT34bmHkbO46JC5v9KNUHyW05ssqQzCREAeDSq
	VgerCcEZzzbeQZVCF26e1rAx/SExWrtGh4KQJu0mvuCcb4wElDkqjpEtspsxm4ww
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6x01kx4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:13:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Cvk22995860;
	Mon, 2 Nov 2026 10:13:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-9;
	Mon, 02 Nov 2026 10:13:08 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Matt Bobrowski <mattbobrowski@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 08/11] bpf: Fix UAF in sock clone early bailouts
Date: Mon,  2 Nov 2026 02:12:36 -0800
Message-ID: <20261102101239.1557688-9-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: L_Wm1JQFj5gBmWukulXVL8VlVIVRmHpY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXzfipgS7EpN9l
 RiUxy9r6Wls5NnLL2v71Os7sFrs6gs2zlACiro00Q4uS3gCjnDErzURv541frRf0+28p6Qis2tG
 P3Os3mwBBKpMCIHfDhTHN3CrFWSPCVfFAwPaQUxPm9c7pGnKJW0Q
X-Proofpoint-ORIG-GUID: L_Wm1JQFj5gBmWukulXVL8VlVIVRmHpY
X-Authority-Analysis: v=2.4 cv=J6g/fwnS c=1 sm=1 tr=0 ts=6ae86235 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hWMQpYRtAAAA:8
 a=yPCof4ZbAAAA:8 a=70zJCswRkpu8aivx3D4A:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXysTbJXcpKsCO
 yu+hvrIxGk2+F9noDxPgkllNEz5OhDzPCUhUuo7qw9xwFrufvWndDtWzyTUZ47ndFpE33heqM7H
 biJmOxQm54Emavs5UXddasCBdVYYn0lYh4rIUfS56EURDDpLNNXxh9zVz5GwGuwqhRKLh3eNl9A
 Pm4GX+/LMCv6xj8yu6dpvb7tonH4ic1AGhSpheg1BefAP+cOuvbdqwmnqcy2WPwsdqWMirMXr1B
 VtM9aK/m1+fXQzSsX7LOdAqq8hlA5NyFZbfJLqlVOy2hXMd1Ks+FBTfo7FL3sqANUjMc6tWUWs0
 S5BOMv5GFtymInzY5XZMph7Krnhf0htFaUUXcchnwE6R47nhYP9ChwUEKkpHKj6X4jBbsQ6Cmvj
 fZS+rE7VTUO6TRwvk6Z2jDCG4lCuzSR9w6eRN6Dfr+JWojrAULBjd7UbruE183fC552bkPAZney
 ZuoUMim0idjXDJ8VDbQ==

From: Matt Bobrowski <mattbobrowski@google.com>

[ Upstream commit 7cbd0c4cebe4c9f678d15e6b9ba975e1155a107f ]

Similar to recent commit 9b51a6155d14 ("bpf,fork: wipe ->bpf_storage
before bailouts that access it"), sk_clone() performs an initial
shallow copy of the socket field ->sk_bpf_storage via sock_copy()
for the cloned socket newsk.

If sk_clone() bails out early (e.g. if sk_filter_charge() fails) prior
to calling bpf_sk_storage_clone(), newsk->sk_bpf_storage still points
to the parent socket's BPF local storage. When newsk is subsequently
freed via sk_free(), the deallocation path (__sk_destruct() ->
bpf_sk_storage_free()) destroys the parent socket's BPF local storage,
leading to a use-after-free (UAF) on the parent socket.

Fix this by resetting newsk->sk_bpf_storage to NULL immediately after
sock_copy() in sk_clone(), and remove the now redundant initialization
from bpf_sk_storage_clone().

Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
Fixes: f12dd75959b0 ("bpf: net: Set sk_bpf_storage back to NULL for cloned sk")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20260709025316.999913-1-mattbobrowski@google.com

[Imran : Conflicts resolved:
  - net/core/bpf_sk_storage.c: upstream commit 0db4941d9dae ("bpf: Use
    rcu_read_lock_dont_migrate in bpf_sk_storage.c"), got merged in
    v6.19-rc1, and is not present in these branches. So the line following
    RCU_INIT_POINTER() in bpf_sk_storage_clone() still uses the old RCU
    api (rcu_read_lock()).

  - net/core/sock.c: upstream commit 151b98d10ef7 ("net: Add
    sk_clone()."), merged in v6.19-rc1, moved the body of
    sk_clone_lock() into the new sk_clone(). That commit is not present
    in these branches, and the code relevant to this backport is still
    in sk_clone_lock().

  In all five branches, sk_clone_lock() is the only caller of
  bpf_sk_storage_clone(), so taking the NULL initialisation out of that
  function is safe. ]

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/core/bpf_sk_storage.c | 2 --
 net/core/sock.c           | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 4953abee79fe..9db272dd1d8a 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,8 +191,6 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	struct bpf_local_storage_elem *selem;
 	int ret = 0;
 
-	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
-
 	rcu_read_lock();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 7ad291f06c1c..860b8d3cfb9c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2070,6 +2070,9 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	sock_copy(newsk, sk);
 
 	newsk->sk_prot_creator = prot;
+#ifdef CONFIG_BPF_SYSCALL
+	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
+#endif
 
 	/* SANITY */
 	if (likely(newsk->sk_net_refcnt)) {
-- 
2.55.0

