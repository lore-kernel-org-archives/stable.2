Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B8486410
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007822; cv=none; b=pPcxq9w/6cbsfmXt8imW5g2/6hwdvaH8osYDXM6twruSTojnynHeG0nf+TSlr/EzI3R34jgfSV06+gTfMHFg+fTGojWCyRFxjf0X7EEwQQJ90uXFB+aDdHAAHkyEaJZ/kjv53CNeYXwqBjstlI+FbwpuquQH/lJkpB2mJfA5q2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007822; c=relaxed/simple;
	bh=VxmCR6RZG34puMftg8s03NryxNCg7LImLRc/GRgXE2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBP9u0+rpvTNBiPGtqwG2yeaxqbDt+iqSAZxMgI1GWJsNiP9Vl09K7uuBydx/cvruU7LkWix0K0YHwdbHfNCmlrdXCKy/a9ZfZU6H0RbacjMugE8DXcbblnQbPF7gjXbSVzM/O5UuIpqXXgaAyVoabgtbHFmXI4aLgcHRVKZzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=y4AE6z9P; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=K8Gin2S8; arc=none smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="y4AE6z9P";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="K8Gin2S8"
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EGZMSG3784360
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=dm3JPEpVSI8PQ0BF6xKoWaANpbsmtysnXtnv
	IY1XHD4=; b=y4AE6z9PwZWkpayV0uaZbMNPd9zqnbW9JVpKQns6vJ3YIzKTM2KG
	epvzum/sRrsdfGAZMWz5gW3/sVjMqH80QYHX3Ugcs91XwchwvwhOAH/FJc4pOfpy
	uHXIlbwY1/xHhqt7keateQ2qfrTRMQu21o0e2WoerRBj65T7DYEDyv+3dsal+pvG
	hUoDdtlbx2+H0lIq6rRZvtxBXhSHoRjcb+Oywisobmg86MwheqbRpfKiNjlpWpj5
	lejiby1ldqwA6mifaSdmYkFcy/KlEX89t7bvZa8e24qMOGuUE/CbL+XKtN0YMWs0
	gpLYxsmqgs5/xqikcDSQyhbGX84OJeC5tw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hadd1bbkt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:56:54 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9179743a76eso99054046d6.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792007813; x=1792612613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dm3JPEpVSI8PQ0BF6xKoWaANpbsmtysnXtnvIY1XHD4=;
        b=K8Gin2S8QCf9CyY68CWBvqJXFZRrplB04gemjmwcl9qiMSxybuOZPr28cKsuQP14qM
         8AU0cp6Y8wvpIUy4hQk/ccZNRN8ij6yA/4EA0GrG77sNNTYyS1cgZfn2E6fWKTCZAYOG
         Jhu9zsHMnNr1XBg8iSQmZZFD7OPyuiFJR9zja7+p7EFY5Hlkkl2pf5J63cl3/yA9PaYV
         eqnAIs/o6VuQEHLeRSbt6ngboTDQAtHbDA/iCc5+BX6M7g6bJahcGEEiobqtTDCE96Z9
         jY6T76k7Rg0OQvx5m4R6pqCOwNod5GS1MT27nW1hWGByWiRgMerLj2HeQyOASkrkZjxC
         QC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792007813; x=1792612613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dm3JPEpVSI8PQ0BF6xKoWaANpbsmtysnXtnvIY1XHD4=;
        b=l3cccxqYZ8jQH/dQ5sbUIpR68LfiGwJhOd/HTUpavdSSuJXdlcPel5vELUo2Qg8AXY
         6u1+GqlV0MwcP3+DJs9WraZcN5FkhmnpAZOxeOzkijIIKuYeA8z6zrt88Hg9XKvMr9YT
         Doh6WktCC3zwXzGH35/tmhzuqLZX1/yPzlScER5s4E89bImrSWBuwWq8e9L6Z6i1IywJ
         +JZm15BXlXNMQbtVZJr1HH8h85uEfQeGRtwSM4beVLALto+i4QrDutHBMS9RYzbe3+cg
         i8ZmOFx8V+hB8+olscwVe04m+swTgmJg96qD2YJoD1T+XvjsdauI4GK0WQT+XUcCPmI5
         lLog==
X-Forwarded-Encrypted: i=1; AKwUvBwGfQQ+aCrjWElJJl76MInJxC8ptyM+SUaGFFXEgoJRL+qT5QE+q/B5oeHXpCk24gf0waSznDE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlNWTQlNKHFQMztfpPSJ8HGgRKfLujjGc+CNx5ZfYnkoK/USLo
	VKLftLdTkL1mA0sY+Oyg9WCOSFN2XE1LhEGLAc54e5BnU++tfTp/k+25JupgNmkkz4ykhUG19Jx
	B3NWyjSA78qqJ2cgevmhSgAJ22ILiADf+JIv0+gGheHFPYtbGJfuoaSQ=
X-Gm-Gg: AYBFou2mMqKemcGNs45cfyZ8Pn56NzKKo1UoI8OJr3v0jstU4BkutrfU6qLcmf4nWe8
	kLcML7H5y7goiYk9CiamFFN+JgT4ImiQb+o9xdiqlS97heauW3+VzTNakIT52ynrVLCfYMT5AJA
	cc1nkj5ArNpikiHe04Vv8kOG11rxvgsodoyyZ8gMY4dv/wB9FXId35LmqsNeJh8BEhDVRiQqwmh
	2K2+/xaicVekMbBdIovQowl5JKGlg3a/hUsT56bAUeMy9ZVr7eI0UtjIWtXe8FLhZWgFN3FWOkW
	toLLQO8/8CX2cyO+poXDAY1ZOwY6/T78eHp40jWRVV2zgCa2zkhHLv2jkFRyEE1mXVqC6O/J+sW
	1/CN5cLw7H2mMxxusuH3UX6al2982nkjUpKlX
X-Received: by 2002:a05:6214:4586:b0:917:7cc7:8768 with SMTP id 6a1803df08f44-91b53a5192emr265642716d6.11.1792007813417;
        Wed, 14 Oct 2026 12:56:53 -0700 (PDT)
X-Received: by 2002:a05:6214:4586:b0:917:7cc7:8768 with SMTP id 6a1803df08f44-91b53a5192emr265642296d6.11.1792007812796;
        Wed, 14 Oct 2026 12:56:52 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-143.natpool.nyu.edu. [216.165.95.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b383dasm61171016d6.8.2026.10.14.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:56:52 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
Date: Wed, 14 Oct 2026 15:56:41 -0400
Message-ID: <20261014195640.430824-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfXxqbY9UCXkE8C
 2NMOcvrZ8fmgNuGjqZBjNKBwuwCufTD3cfzVX7lIqO/k342hSbB/pJoloIkYN45XRLtgnp2rPPJ
 EzA7bIQmAk/+h3OKtD51L3cW8OMSIGs=
X-Proofpoint-ORIG-GUID: hakpeylfSGVTc7Nn3AYobaL7QjUaPOId
X-Proofpoint-GUID: hakpeylfSGVTc7Nn3AYobaL7QjUaPOId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX33cbeK4qeoYE
 pruyH93VVRkbnnWgP/fOR6TjJdm0aG+9lbqfJnrc6QWmVVEsiMUvk5kk6wFXA54mbA1CSGn8AtT
 rI6naLbsSR2f3gaplC47kKnEq9Adi2i4fBD/ONXC3nIu3Isf/njYzT73Q8ic33NcUq68gEXwzpa
 Uh08DIbXzYzuOihlQpk3Bha6qNo5dwXQ9f34OlbnprgZDaBTi2GArvkBycUWQwAfNE8vCMDBYT+
 z29gU0Uq4APdkuNq6qgVoUFh+GN5ljyfulALLixHp/xLr3zgBYqsqikVYQtl+PX8eX53KuSCYjZ
 gO9n+ByYT2quzbZZAtzuTw2aZj6b/KRAKNI7E3387UFmR+VsvrrL89huizwmFMnprqjbZ3HW879
 inHlv/FgAgq8GkC8t6J6SnjxBAEaDlTwCHDUJTcH+9A6T9DIoERV+ZRM3cm70raGb4h3QYdc0ol
 hQU1X1msJhHrGGaVPFA==
X-Authority-Analysis: v=2.4 cv=IaESymqa c=1 sm=1 tr=0 ts=6acfde86 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=iAeFBqZmEazvcMjDlvn68Q==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Orig-IP: 209.85.219.69
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140079

User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
This could lead to division of zero error if not checked properly.

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

Fix by checking if user pass in zero as parameter,
if so reject the value zero.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Cc: stable@vger.kernel.org
Reported-by: co+71b6509cb791e531@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 net/ipv4/metrics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..e83a129a25b6 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
 			return -EINVAL;
 		}
+		if (type == RTAX_CWND && val == 0) {
+			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
+			return -EINVAL;
+		}
 		metrics[type - 1] = val;
 	}
 
-- 
2.43.0

