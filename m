Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614904;
	b=TF/NUlFHxYq7PEVj8wWmm9M9LGd2CGzoj2hU7QL+4MifPDej2tPeyE6ZhUez9zEsLAE1
	 8R+ii411EMbK+KL8k6/FAE/KicKngOND68W+VITCeNpeokHOBiUdH1p6IMoaSfaHTmg6+
	 qccCrrsbSpjdFpKGC24eOlfbyerZIHMXaE191fZ5+F2jBegXqGYVpz/HW34w3R8DLxAuF
	 mCGo3zHAhF16KIeLnBCVxC60Ux/eEcTfMpdp9pR5ikk6UmpxVREYRbI3FOUhFuVa/adyG
	 8aeZKAr3w4fwX63U0hKfd/l1wY/gTY/D637jllIZ9RlexJKp8b8yh+f3D8uvXf3BibQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614904;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=QaxbI6atKW20N91KEv+tejJPUoSeBlS0MmVcpfGagZ8=;
	b=NBlz/zEpaDHNmIbCYbmJqKwx6dycPTXOzjLASAJKxeeG1+52G0IiY72qxfgmdoZY5fwm
	 y/BrurE2GSfO6k2bZqI2v49j+vq76nWqzUr/bxWPnqyXsD9MFR5VnyKedVwsKpeAKpHXE
	 uw2x8+FH6AEJrsrDM6Xw60jQVcG3kHRqwvpj7bd8ipl95PcV3lCLvP8qHXq2/bUFxq7Ml
	 OkpJJ7BjwWGP1mmOKipLvyojmC8iiY0uJAagVw1uKRx4UsTf3qZ/e5GYa7vu0FnGzeGh8
	 h4V/3TolpTq1qYLrcKBc6tNUDS8yZkGGsMzPDngRoXflw3YPLTTXzOqtaWdkbS3siIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=WnqR3qEm;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD65606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD65606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=WnqR3qEm
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A22U2Ub3502493;
	Mon, 2 Nov 2026 10:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=QaxbI
	6atKW20N91KEv+tejJPUoSeBlS0MmVcpfGagZ8=; b=WnqR3qEmq37Y5/867BeiY
	pLPC/3xkk5BF5VatvN5g0UlDH0B3ppjWXpFWdnFLrrhZrh+BXrJCiwtM6RiMLvJS
	ULQucHd9MgGe1WfehsF5tHsL8MFZa7Wnza43zQ/e8DHb/u1TNKb+Z61+69IuBSjg
	gFVCSufNr9NESBVhjCEr06AqUAT/y/Dx7XmMF1b1LkWeBlj2clxlSSXtILx3+9nk
	D7acdG77uvhnHDyENW+YBG3eyZ0+9uv4oPtg6Rk5WGZoDg2jATrYg7XT5ybwg/wk
	QGkPpSZ/5AblVeW7YzoFqSak+BkJwoIqe1cw4Z36V2P6TNU0MMYYHp2wB2HdNovg
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6x01m7e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Cw2K1424216;
	Mon, 2 Nov 2026 10:21:24 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-9;
	Mon, 02 Nov 2026 10:21:23 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Matt Bobrowski <mattbobrowski@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 8/9] bpf: Fix UAF in sock clone early bailouts
Date: Mon,  2 Nov 2026 02:21:03 -0800
Message-ID: <20261102102104.1558500-9-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: 0siPBEXDZpjDbwao14Cms2wS-hqKUiLW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX10SvPKRBQ2+N
 oG7yPOyQXhYmCgs5L+z1TzWRbPA1TtzyaoDmPjVNaujhJQtBZRItEfZ4icoHXYlOsQ59pCBRbFx
 tqHn94ee8k7ZuNkhr48YaPY0xSoIy4mQIj6tgB56xLy+8d9vFMFj
X-Proofpoint-ORIG-GUID: 0siPBEXDZpjDbwao14Cms2wS-hqKUiLW
X-Authority-Analysis: v=2.4 cv=J6g/fwnS c=1 sm=1 tr=0 ts=6ae86425 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hWMQpYRtAAAA:8
 a=yPCof4ZbAAAA:8 a=70zJCswRkpu8aivx3D4A:9 a=KCsI-UfzjElwHeZNREa_:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX2o8FlZfs2/rr
 xkXAPhrfBSIXSMq3wk8vKfV9UioCMjhMhoLXf4efAZm+RWkqRBZFg+K1/5ZvgMjvSYDWzM+Rz+u
 J6nOkUuMuFl7A9xi4kdm1huPqbewagG8E1ksiuepim2kR1fuuU2Fby6bEyxyfBSuMNe5Ne6ZU2+
 w/uiWEYanHGnIHDrB20hL058lksqkuGR7omupIgmkhg0n4GFtPi91UewMz6C4V/j7pMTu0e6wm4
 ZQsRHrxw6s6aaYeEfZRjJjzvhdDcXvpoiEulBaRW1dLdDCLjCjYcoyB3C8T+X/JAoOQTKTmXc7C
 Ft0B0UtmMn05TPmbrIuSDkuvPja7CzgAyFer0vjKtGnIGJoTvvwdmb5qG6Gz5tlIRj/kZsdHzz0
 zd7LkJqGOsIEtCKhAFkvyX3A7tTsK9preNcNA1GpWmbMZ/pgAa7+v75inye/ci2vqalJ4jwLnBQ
 fWccPA71AZl+pCwFrZRA9PigoQ6sRQRgPPvBzQDM=

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

[ Imran: Backport to linux-5.10.y, linux-5.15.y, linux-6.1.y,
  linux-6.6.y and linux-6.12.y. The same patch applies to all five
  branches. Conflict and context differences:

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
index a811fe0f0f6f..d651b3e87875 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -190,8 +190,6 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	struct bpf_local_storage_elem *selem;
 	int ret = 0;
 
-	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
-
 	rcu_read_lock();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 07a90a08a4ed..7d645d85da9f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1914,6 +1914,9 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	sock_copy(newsk, sk);
 
 	newsk->sk_prot_creator = prot;
+#ifdef CONFIG_BPF_SYSCALL
+	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
+#endif
 
 	/* SANITY */
 	if (likely(newsk->sk_net_refcnt)) {
-- 
2.55.0

