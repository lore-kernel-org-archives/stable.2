Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627121;
	b=iPwIWTZVzlti6TKXY9L1OOqAEKgsJsg14/F37LuyeOwiMd8zO+92Z/ZvFKOMoYkuDJmE
	 4/5dIjW0cqch5QXaZBEbubVgJOwWLALsSLmdCMmtQ5Ctb8EFdvQDtzEpn11kk98N/q49S
	 qqAwS8gDh5oy3hfdBjLLfHrjV8KRiRchU1qZC4GPbYpMrobtxWK1baZdPhdoarZ0ydyCT
	 JGr9uRIKQSgyKVqH7X4LQ+9NzCDfvmjJ3PhIEh0wctOWKRUbKWigdd7ec3lCNPwY0f5J7
	 9ftKaI4mMVfJu10devhPllBRTNhSz/lvc0iEmGvXnQW6VpUhGLS0kFvEQP1BUWJC3Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627121;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=ctT4r30SdHriATAt3tjrtdUslXAqf/DWdqMV6ZVr+/4=;
	b=ExPeJnSlU7uESRhf13xeHb95J7OxmD9knBZfQA40AZXg2HVBkj+tiKllHA5ctXoDAOEe
	 dHyWA3Qg8j7ytqLTBPDDLFCivtOFi23v1snbBR9l7yHtwZ8zIizyzDLWNqfWDo/tQYcCz
	 HDLPAiL9VRLXEnQ0jmAgpf4Npcijbd4I+iflRfAkquGoTtJOwHaniHM7MT0eayaNx7lWr
	 QwVJl4R+jteTd2GWAMqOUFXGvqw1g66yqcEHJeoWfkMJ3UPzzlvQ3CfFCuwDTcBgYDsQ6
	 rVG7sWGCPbvLLufT3vRSeBcqRsYE+GvA2WSbJXJ6gJGzNB8BMkc1t+oEDsU2Hj2NH2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=a6Fa3OUA;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=iKFmqBiQ;
	arc=none smtp.remote-ip=67.231.153.242
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33361606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 23:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33361606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=a6Fa3OUA;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=iKFmqBiQ
Received: from pps.filterd (m0355792.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LNenlc2170058
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 19:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=ctT4r30SdHriATAt3tjrtdUslXAqf/DWdqMV
	6ZVr+/4=; b=a6Fa3OUALD4rsno1wFvYCWfxol6f93BK/7jIGkuJwPRRVDp7Hg+B
	vHwhuB2quDUiWyHSn3yJYlg8VFiilOkzJhQxgWJKL5P9cymXCeQwT2f0H0S5Q63T
	yz3qDOut/6kqN6f+M1vRPArcNj6eJPmJsbIwPL9SurwsgTGzoPs61rzPiRyiGJFd
	JrJqYRXLwl7y7RzB9q8S2UiXDVNnWvNFoZ/h/P0DEyMkea7bUL1+TBaUpJqZs/6q
	aYu8zsI0KM9WwZU4Ly2Cz5pTSO35wvv2xX4/TUkr/m6cBnz83It91Ki/fphz1+7f
	8mkRf6qq3w3YgL6kKJuHVUh7Q+WLQufbiQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hf79d0532-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 19:58:33 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917a7c17166so27511706d6.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792627112; x=1793231912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ctT4r30SdHriATAt3tjrtdUslXAqf/DWdqMV6ZVr+/4=;
        b=iKFmqBiQoME4CJZuMCqM9oCLLLOFxRlQAiaFaKGJMkT0DKbt3h5b2Ue/N98cR8h8dX
         lRXQ25clRcBufagsaczVqfYMEa/ZbPfZFRs2SDzwqljVW/4gHlix3iAGX9tNalnwC2gY
         rNxdJQCBywE7HWn3sj1BH686YBFjL0pSZdOrWzOT7T/uLH/oazJgEuXJBugazy0t6tsl
         VQdfVKO1qlPjQD/LZuRJVaNclis6eWCwA/nD53hXsQs/bziuvGKGjNfsd0JrW9gjW72Y
         VYOV2XN0ZTKLkVdzO+eM/m1wF0hLleTF40Q3dSpuHVzjH3/M/ETVR7tol9oDk1ZvEOrU
         ODNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627112; x=1793231912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ctT4r30SdHriATAt3tjrtdUslXAqf/DWdqMV6ZVr+/4=;
        b=t4fCXPrjLJWwrkY+9gIHwRudwtLEZJ67LNwO8gpB4qCmdxGYOMTN48kywIgvBqZXqX
         hwBiRDhPThYZnlEaShxHpb7nPj87ewt9v16aS3i4ybk7klfbXGTPBMtRZxHahykKGqFa
         yH0TfdO275Ut9npLgwfuU6IGnXe0PzUhxdelPldh3LP0WJMZ5R2LhVGZYLDKzwT/+doh
         u/d93koGK9rCVWdLps2zYs2FemUA1PbDgZ8kbP8WrhfCb/5NGeoyqwbp/bCzMBX4VzGt
         CnSzEIC1N+T2/1/P8XXNOtvkZ/311Z3QommPeWe9GXcaBOnxqEppdVQrsW9zIabInia7
         HdTg==
X-Forwarded-Encrypted: i=1; AKwUvBw702352vFKrCv21ED7WoWIQfrFEsJeLISN2UFh9jeTFE3E+gJLEMEC99Hm5uBgr3Ylh74dm90=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9PCqf04VS9tT2pCIL+g5UjyZD39JiPWlFGbTzpHGY8shPGI/A
	OcMBFav9yt3xRFE/yUlQJM2blsjbtMl7cgHYP2RiLvp2hValhh0pgVJFpEcoB2U9rfx0OpqdCIp
	EO3CORj6F23InRk+9d7X+HooyH2v7i/SroACKyv1SpLBtR1vKK1aI42s=
X-Gm-Gg: AYBFou0TKhrBD8zCrERi+B/J8bX1j4lM1slkarWJaei0yF+9W8AIxpnUravSj3wUb7O
	2vdEKIxV/ZjuK2rVfSlomwwvVXzKPThmF6sbzgtT+S5+UvDdkwdQCG3yPAG3uJ24XtGDIeLN3hW
	bjRvcBAUZjo38+58NMHzAc6Nfp3jTZS/rTH1nR4K8yQXKRUhG/LWN0qM9vVpNHYVBZgBgvL/Gze
	3VLReU24F6xoHdtzIu4Fp8q2j5Sob96PPCazo+BNsoSjb0I35CVXPWNIhzRgH6TlowIcKamqfzP
	NjtDBE+sOLNmg0vClo5pm4qaMb3ViZcfgb+hjpSBFErWFqeSZ9RyOnG63afKUEuDJxlBavD+JmL
	yR0aoYNBn1Rdqi5YjcZCyVFiPbVXT07CVoxQD
X-Received: by 2002:a05:620a:608a:b0:93f:3bb5:545d with SMTP id af79cd13be357-93f57f058fcmr744903385a.27.1792627112594;
        Wed, 21 Oct 2026 16:58:32 -0700 (PDT)
X-Received: by 2002:a05:620a:608a:b0:93f:3bb5:545d with SMTP id af79cd13be357-93f57f058fcmr744901285a.27.1792627112155;
        Wed, 21 Oct 2026 16:58:32 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-137.natpool.nyu.edu. [216.165.95.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d98e66sm387488585a.11.2026.10.21.16.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:58:31 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net v6] net: ipv4: add zero check for snd_cwnd_clamp
Date: Wed, 21 Oct 2026 19:57:33 -0400
Message-ID: <20261021235732.1313305-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5NSBTYWx0ZWRfX1f5lGGhby0zG
 7w8pX6bXsOzgXqOEeMqLmNYv/1m4AisN1vvErVgcSJvsrC1GmrfZRu+dVM5DjUaTjW4oUv1tzcW
 VdZJ8Z5cuJXaGPlEUuQ4zx8oFdruAf+eQ1i32l6ERWZVmyowRTyXy8jGCY5hTp/z5Klkmh4w73H
 KGFY9+R9IKqndjNEJpt6nvrMwi9tfQTbdcg9kL0JVuqQl7TKmB8qI1wsFopmo+kXKThUpaOhUVG
 +rWd8WKBKHZHa7QJgbHm2zChKWijXsdF3hwbySFQgTjsSCXQ1mbb7w15BqyhamiceWb0ENNd1Pg
 /loKlJguOecilNI3tq8kCZ89Gk74IDfnjN9bDiurQiek1h3/s0Gp6K3DI/YdjSKOE9dq6EjNZbS
 QqH72KKLL0/zZNV2Z4gD3a/wNV76UkPPdOXLlKBH0A0xk9u1NvBH4GLTQ2ZOBbxdz+C/PAXcuSd
 EyErffWKnSyp3RSFr8A==
X-Authority-Analysis: v=2.4 cv=CPq/zhrD c=1 sm=1 tr=0 ts=6ad951a9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PTGulf1M+RQ7eJaEhEW9rA==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=16cGfGHOS5B3VL_TWyp6:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: JkiN5XCyvrkvuOBB4sTieDwuXq4Wowmd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5NSBTYWx0ZWRfX1Tn+QPTIrOLJ
 C/jFZquuqzppPKQ0maC+27F7vMUNQLXm/VKp8qI0nHVgBlBPiC+sLQUpQ557F12mYyhlJrJMX7h
 jVEzf5lPPjUg6A5QApH1Aw4JGXl0gHM=
X-Proofpoint-ORIG-GUID: JkiN5XCyvrkvuOBB4sTieDwuXq4Wowmd
X-Orig-IP: 209.85.219.69
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210095

When RTAX_CWND is locked, user is able to pass 0 into it.
This could lead to writing 0 to tp->snd_cwnd, leading to a
division by zero error.

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
Call Trace:
 <IRQ>
 tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
 tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/tcp_input.c:4440)
 tcp_rcv_established (net/ipv4/tcp_input.c:6685)
 tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
 tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
 ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
 ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
 ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netfilter.h:319 net/ipv4/ip_input.c:262)
 ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./include/li)
 __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
 __netif_receive_skb (net/core/dev.c:6410)
 process_backlog (net/core/dev.c:6761)
 __napi_poll.constprop.0 (net/core/dev.c:7830)
 net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
 handle_softirqs (kernel/softirq.c:645)
 __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq.c:758)
 irq_exit_rcu (kernel/softirq.c:775)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discriminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)

Fix by checking if user pass in zero as parameter and if lock is present.

Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch ACKs")
Cc: stable@vger.kernel.org
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reported-by: co+71b6509cb791e531@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 net/ipv4/metrics.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..4052a90249c6 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -60,6 +60,11 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 	if (ecn_ca)
 		metrics[RTAX_FEATURES - 1] |= DST_FEATURE_ECN_CA;
 
+	if ((metrics[RTAX_LOCK - 1] & (1 << RTAX_CWND)) && !metrics[RTAX_CWND - 1]) {
+		NL_SET_ERR_MSG(extack, "Locked cwnd metric must be non zero");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

