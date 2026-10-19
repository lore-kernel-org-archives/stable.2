Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.150.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448745;
	b=4XQtH0pz0sce/Auy19gCk/Kto9jA6BN7jgylCS/dO9HQvAtX4JR8JHEOpLiNYA2FVHm6
	 /6FUSWeAiSP0D8AL84oBzbAru2pN7cchJtbaW9sMOTFWcG5dnJliLRpYVETb5qoJVvSkV
	 wQkfbXkdF7CKXpTTeutP3ijXyNz6lFRoAv1JMDAr6/jrDuxlZ4F50q+vJX2I+4nAVFybt
	 iP6USK57HCsBSVdGM+ajtUkp1yi1jhsgt2oOOTzd7xtLJTTscBrVGH4kqWO1Cq3juwBYo
	 WbP/fKF2Cfs45JojssBVTIEK82eGb2ZL5Nz0yMAZ9PaJXVSK0cL91xG8eLIFPDh9RvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448745;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=NnuswPbu+Jp2bjPIKsOTDcJ/wnKhhsaCrp4KnzCmYag=;
	b=eH6VC3q5fDTXRpbjdzLNAvMp3I97vLmKEpPbaOjOg5YeNH0RJBdThr3mGLZMUSPF+SMJ
	 nexUge6lIGQ0i/s0UP2iyJnOLDHjPnfBq8YmagKDuXyNM+wEiMlLrJEYl2rGHZGcZOZem
	 11GSZVYqkeazDfOTqsF0HiIsARFEZGEkrTZB9bwclX86DBEdWDaef/l0iZOEQW7SBPc7H
	 qd4ts445aH69cQWMimZW7zVo1aQWeeacpYrXGvNbKUKFlf0eg5klOtla7KDcMqOefp/Xk
	 jGnA8jf8GJTdFQ14xrbJC2FPaHJ9ESJg34e7pjixiII0WNM6G9qZzP+K5L4Lnv7GL8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=y+QFTAU7;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=H3ZTe2Zu;
	arc=none smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FE606A319
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F9FE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=y+QFTAU7;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=H3ZTe2Zu
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JLcPHO320168
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=NnuswPbu+Jp2bjPIKsOTDcJ/wnKhhsaCrp4K
	nzCmYag=; b=y+QFTAU77Tn8ATA2i+mTXvVjb1amkAsQrsHGuLSJX+lmuDwbigSg
	bfsdv1O0rZVoChfwfz5urvEcu8TckVfXX/5hcU/7NYp/cl4WUOipeJcm9HcAz4Xg
	+G5ALKvw/+YHC9/8HQqgR4O50CehHZaO+YPluDhKJme00q5NODrIUHTl5dAHr9fI
	rwe+72Y9fcK2jxbfSJmAWcrD9dfzLQq+TWiinTrVXtkwP1isSNS50/o+EhmmMtxL
	EMOL2Kpi8T92iQ1fwUy9vuLJ7Fm7hWAs+3N3e0EP1FhIlUdtCwZhOZLYI+SoNbDP
	ZZUrB55/q5Kjg8pVBZZgsuER6P4vyWjcmg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hdua30k1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:25:36 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so563507485a.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792448736; x=1793053536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NnuswPbu+Jp2bjPIKsOTDcJ/wnKhhsaCrp4KnzCmYag=;
        b=H3ZTe2ZuXlKQDzJRe2SAUWxM2592O/pn/x+OWe7ZUgqSWwdAQK8R3+jtzHhU7MvAmC
         pDEmk8393ISa2njkew2PHY8tswIOkGTm+2dPxRsbNqWv7GGBK9ntLznSyHTKL/iuHinf
         L6Q8mqREp3ziZXgiWaHTiEhkJx23Sn72hZGEgB92N1NiKp0/PXvxY5VdELYuk/m9ekcn
         evOXAIxOtbtzyQfP00FMutgUjVdN3SEybLUN+CR7vTldpchCoup+cIHoALLzv4szaUz4
         muig3Nblg3/O6FNIAAOU2/HPzW4E3Z/e01OtbQ+DAlGgO4TUp3CMHi+nMKWMK494KccP
         xMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448736; x=1793053536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NnuswPbu+Jp2bjPIKsOTDcJ/wnKhhsaCrp4KnzCmYag=;
        b=1SGK8uOOrLVNSFtoSe18r9WfZXKZk4apawQ0f+WnR9G4HSkg4v6dJnZ5rjhxGDyWc1
         iCdxoBfVOhkF+DwbI6yUMS6sts7cxWr5HsRvwD6qH4VL7PJ6ECsq6NJ16Vb/nqOuPiET
         /pisaA+ZAK5A9uvZCF8gh/YmaVr1X9keZEFVYPzOw5XOL2dOXvntxBmWI5uom64yVhyW
         xtpIGSY3M2Hg3PvsmbJGGjtMRV9dZiIK1asAKMUZjAlZKsNndEMYOCrFZbk2bAamBkAY
         F20TDTwzj37vJLF6rM0n9Ka/wmFLkj6kmGI4u+H46w6j2Ta8uPzt9o4FmudvDX6dj4Px
         R2KA==
X-Forwarded-Encrypted: i=1; AKwUvByUXrzlv8p4JuNIVs6UL2DI/O6tbQxDxoihc7UEz8AIbAF6rXhUoT4KDasnq2f+e5LLb3bXRAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjymKOu7A0Y4CImMIIrleiXQbMGlumwofua1Olq9C1K9/V2dbx
	7i5clQs4gpaDTazDevkX5u9ywKrNdhrFIWIYwsPBW7siNCy6ZVEGTKBlS8VRLJSbUx0YvKMDNks
	Mca3FvBptYfILc64i6datw/TEZ11qjVeOEn9EY5L0LjkhJ/oM65tutGY=
X-Gm-Gg: AYBFou2FU+Q2BiddR/ljri7irHYLKrPJU5rzFP/UhhUubWvUWmGpRNFq6LbylYfgTeI
	58A4M9V6K4+ZDY/k9NYSmy3vhmKTKQ24jvd92Q0EAvMMaZRkbzytiigI1mMvjbcgMmXPmxib0S/
	jnFaghjmQO6rW52p2oC4rAmaAGF8H1vspsPdzSG/1oSN/00nWjiTEcaP7POFUDdzFDQgvDl/orL
	SfUyqrCuKaiSedGJ2pXU49vN5NOT2eNIBAuvPKvDOgRs2IiPoJZwDLE3ufRNxJ0OYOznH6iJItz
	TII2lkajVc7MaveSvzhAu6A0ktmjWfLHSpyOYjDUT9EqbS1L+2N4p9yupcnlus43QKnsjia79+W
	QD2eIdSw7f4YwSUXc2YIY48x3gOrUDbUSMYyk
X-Received: by 2002:a05:620a:3949:b0:93f:175a:f4ce with SMTP id af79cd13be357-93f29dd7b2bmr1657518685a.80.1792448735922;
        Mon, 19 Oct 2026 15:25:35 -0700 (PDT)
X-Received: by 2002:a05:620a:3949:b0:93f:175a:f4ce with SMTP id af79cd13be357-93f29dd7b2bmr1657514985a.80.1792448735368;
        Mon, 19 Oct 2026 15:25:35 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-167.natpool.nyu.edu. [216.165.95.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c06e9c82bsm1643376d6.24.2026.10.19.15.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:25:34 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH net v5] net: ipv4: add zero check for snd_cwnd_clamp
Date: Mon, 19 Oct 2026 18:25:31 -0400
Message-ID: <20261019222531.1073-1-kj2864@nyu.edu>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX9/vDBWauZzsG
 /S0IZxAkBPOIsFY81Fqz7fXgh8KE9nHuZxl3jaii1Qx/JboEvdebcmoo81+Uk7rDHpC9K+j+2x1
 XBEF3XAKsAd4g1Pf95WefzNkB3Arok8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfXx+YWGJDF6qqV
 8EgDhFIbk+PGAyXEwXfWNLXKbU9E1N4YkcGAvE5H1sySZVoNwU1/oHokaj5Um3vP28aTwQio3tb
 K6xa/lleXyQAVFV/xNF9lAw0v+iceK+qXAM2qLdrmwsYIJXlMQTlEWylEfPy6WV5FY00J26xbY2
 mSbBC/G4ADlk4IAGJo0oqVH/0bwVDf5Z6XAML7ld9jnRQvm5UlxcAI5+2xBTdXDrDeSkcSaqhdS
 Mkvj3waeADTFreVpo0+oxeRp+BUe0CxDDTs/X9hMLWIuKRSuj7Dn8z1j3uKJiWawJKU83TDybIV
 2KosYtkXjhTqxyRVfPz5R+KrcqA0Tq+x3gcT/y9QQ6qKWQy4OtgstcWDGsnESQG1D6Rb8zUvPcr
 0wnFu+bewvfnAS6Im94bKpumM4O10rsKbHXzn8CdQR4dWtJhoAoEfR/1p54Qf1fVaEKTqLOILLs
 T+sARyrJmpGa9TjBzrA==
X-Authority-Analysis: v=2.4 cv=FdqiV5+6 c=1 sm=1 tr=0 ts=6ad698e1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=yOGPcoH5O6SU1yo2J2Kppw==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: JuhghX3PY3LJdiTe0KdKqcz5Zk6Qs5TI
X-Proofpoint-ORIG-GUID: JuhghX3PY3LJdiTe0KdKqcz5Zk6Qs5TI
X-Orig-IP: 209.85.222.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190089

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
 include/net/tcp.h  | 2 +-
 net/ipv4/metrics.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4416cdf9bf30..9f605d9ecb35 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1522,7 +1522,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
 static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
 {
 	WARN_ON_ONCE((int)val <= 0);
-	WRITE_ONCE(tp->snd_cwnd, val);
+	WRITE_ONCE(tp->snd_cwnd, max(val, 1U));
 }
 
 static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..cb36686973e5 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
 			return -EINVAL;
 		}
+		if (type == RTAX_CWND && !val) {
+			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
+			return -EINVAL;
+		}
 		metrics[type - 1] = val;
 	}
 
-- 
2.43.0

