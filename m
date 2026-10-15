Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445748123E
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095397; cv=none; b=Ae1Ea9gJluGCCqDd1VvHHM5q7c4G7QETb3QWH3dwKY36/zS7lksLAEoqcFpB3OqyMOq0f59cMLYWW0eLg55MXP32vESF04kY5qrqanaNJjQmX0aWCLcF+rlYaUI/lZ+Z7nu54h8kZ6iLLag+tBLpNahWqwGtFmtIJEna7nc8AmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095397; c=relaxed/simple;
	bh=eN1x+5Hn6/e2k3mEyta1N57gMIq5bpaCU1jvBuWBEeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfjmGgicqhln/ln1VkBs33yLZDOgWizTquVmU9SNcBCU/R25zf6PCM4mmgRVn/ooa00WihiUZ30kSDSlwq35H2YGbV5pJrHDSSKLdUYmfWA8oN5FelQEr7Flx87HimkNi0j8kGJvl9/AtpY9PwbPyzRET99Kw5z4ymmozJqoS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=MuT2+ad3; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=tWKLfW5V; arc=none smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="MuT2+ad3";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="tWKLfW5V"
Received: from pps.filterd (m0355794.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FIcIqn261855
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=6VqrsXHmAsu6I4kcwECb7Utlh4Uu8hmgdnqU
	Zz4xiKY=; b=MuT2+ad3r0Jf8a0TjBJe9yd2yEN/v+ndU5HoYCOlyoK+q958MDIJ
	6p8YjiGaHkTxMrzobeqoviEIlWpB8eemABDKTJNx/onEpDrcS9VHDi+mnxbuJKns
	+qu6EcU2LjFqfR/QVHRQCR/c4IIVEZf+hcMWXt0c95gbAACwbrH6Y6d9Jtgkb/96
	ooFh2wP6xFDzbLbGkchqJaqMvmr8xXjP+obmCRmUBaR486541Iskbtvfawp320hP
	MgCp7IRDFSmH7s1vqM4hLrMqws9l5VMuHbffjP+obMDBc5wW9y7pv8NKcCOOlX4B
	hLnGVHMlcYd3WGDO59Akvb+Z8iBxVaJbdA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hb49m9n69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:16:28 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53380b67cfdso138789671cf.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792095387; x=1792700187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VqrsXHmAsu6I4kcwECb7Utlh4Uu8hmgdnqUZz4xiKY=;
        b=tWKLfW5VSLv42JkOCHr4Q557mtwn/poZXoUTgjz18SFsueeaS7/RqY9gnhEnmNs4vi
         hdLgHbE5WZ54D60L9JOUebvp9+eBD1HlTf/DZqh0qMvuakLvg4ii7b7wtpHfvYzPEhdA
         5ntbuu/lxKXblTlo9JxplwvzXtAt5FAHCx4y+5zpZ185/y/nPm/jtpr2v0WeEJNzpYlU
         Ligj+qCHWkAOoDUB5VFaHYt94i+QXxH0WjD+F4ThAksAurlgKImgX2k/OMl7HsS4BydF
         x1haHKI3nYqyCQP79lX3BICgIy9v7OFJnySkRiBdlSRyzMS3pqz21RiRcc8hiW3CkCNW
         tN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095387; x=1792700187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VqrsXHmAsu6I4kcwECb7Utlh4Uu8hmgdnqUZz4xiKY=;
        b=IXOR1hYqmsDFeEWhS8QiGwqNggnpw98xvZUnlmGfxgoReeDeX2as7WKJg/K/IiBnIv
         ioPcHTYTIFQ6PsCE4hlOsKa0ecYLNq2LhWIl1dGLW9Xv0QSgR7dgUoELxpd0bD7kJhqh
         c1kYn7C12wCV1jcsty1HaHgEmzb3XIb+NDt6H82ZSx5DbA8uGwPM3kjmwL5bcO7rUyd0
         8gT1F6PbJF6Nlc5RkyH2eQQcEqKOgwO8pYBHLTYt2fTvWLn+In88bcSnrgegC+lXp7ig
         37CtG+msC09BwLJL9BneruUIDOnCD3lq3fIX3A54zMhJoIdlvh1eSpp7xue2ThLpl4UE
         A8ow==
X-Forwarded-Encrypted: i=1; AKwUvBwpb37wHfnMlV37poLi8RkYFo0KXrD0hjU/aCKqnvSrFvgxUmHIs2S9gb4J0pjZoMQtbrxlvYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK32vMLzk498wj+NH4p/lxtQQU/Rv7+l72HGLbd/5PSp6quc7VS
	GUbtNLtLdW1qm9c4CE+V4a3BNDUVQgNQA7K+9XN5D6iI0oDcB5oqwfjPlkz0ZR0ZNwD9X0AyZcN
	utgRvVmcir0m1EjhXirYfIJrFcqEO7Y3Dhu84xq+ZTE6G2gTpgFYu9uQ=
X-Gm-Gg: AYBFou3KWediR5rAC8qxCwcdFqna7P+vVdETXqtKzmdfW8V1mb1w8Cq46DWYQ+9MCzM
	mj4yhskciM2/Go9znEaLipIWlKbnntjcVrFgJC/IoPMi7WEw1+LSKtirBhs8t2EZCzLX2OMEN89
	TeD9rjZh9KDEphmjdzs+qLZm9TfWUcJzSh9bEosHiT8WP8ZkaxNqrlC5TK9XMRBY6U5z6axMGEk
	emgCI8WTtR4PwVQnE4Gp3iBH5LLfiED3vHYud6C8w17G0/drzHpIFiHkjzj1f0OnX7JQNxVaxxl
	QE1+T5mVhEP7QUJ7D+HCjCE4GsagQC5zSysYcCc1xhjlVzRpGdZyS8ZzZetyAI4Y4H39N/s4ZOx
	MQ6XQnyeDpsTHZJsh+RWJri1Hu3h+h34mRCc8
X-Received: by 2002:ac8:5d8b:0:b0:535:859c:b6ff with SMTP id d75a77b69052e-5359fac6320mr338755621cf.20.1792095386172;
        Thu, 15 Oct 2026 13:16:26 -0700 (PDT)
X-Received: by 2002:ac8:5d8b:0:b0:535:859c:b6ff with SMTP id d75a77b69052e-5359fac6320mr338754681cf.20.1792095384885;
        Thu, 15 Oct 2026 13:16:24 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-175.natpool.nyu.edu. [216.165.95.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa19a3asm2389211cf.24.2026.10.15.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:16:24 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH net v3] net: ipv4: add zero check for snd_cwnd_clamp
Date: Thu, 15 Oct 2026 16:15:50 -0400
Message-ID: <20261015201549.4023-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MCBTYWx0ZWRfX9MWKL0WziXzd
 3ZBgYQtqbsq+MlzNYrUTUktXtJWG1OXUEZTlL65DB+1Umfodq7B/D4Bh+aVkL6DLgN+dLQsFgHG
 hnHI91B2wUD/EZqQztGuJx6EeYTfp21KxtPxZ06POappqWowQQWmopGgSR6mHlwegII9T4XIqVB
 PrmsxY/CXJMppWNbpFZN/RkS/0cWDHCW+AtvpZ1QWlIxed1K0DJHqNPMwwBvsPuVrcbmywaW88G
 fiFnr4hJirEF+0/iNYC1otteFVMXnHzcbeDDDaspHSTdCIsbzQXGQdty+F8qlhUou6zdRw3AfYr
 jGJ1yT0WBO5PUMZ3orsr+Lkf/6lMKd9aADdXQ+t+WLPbZAZ9kI0J+H6Xz1bwlUmzuKxd8lb96X5
 VzeSAGZk9tM8NGy7L0XvgO4SUHPgzUsmK23E/4x/niHHTzNi4+uPAqyxXhICupYdBKPO3Zsy+Tz
 F4FBJJm/z0QDFcetYxA==
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6ad1349c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=HR2R1zjsIcTlYEo9jw4mrw==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=A3cO9-ABBa8CDv30UOuY:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MCBTYWx0ZWRfX7TNRM7ouJjoZ
 RZJiXwO/QAqLbHMcZii9CIqYzq0bM29XqazFdOeXZ31Q6eqnddKnpYR7rOzh6IcxOh0scqtboip
 SuAmEFGQ8Z5Dvgx2zY/EyqJwiTIP1wo=
X-Proofpoint-GUID: qDgDvaK7D6ITwmiVFJggyQPRNwKIg4WL
X-Proofpoint-ORIG-GUID: qDgDvaK7D6ITwmiVFJggyQPRNwKIg4WL
X-Orig-IP: 209.85.160.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150080

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

Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch ACKs")
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

