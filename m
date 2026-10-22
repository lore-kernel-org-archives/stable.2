Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660952;
	b=ZU8PkVxM7UPTxDY+WrCU/2i9r/nlodU0u6/0yzuJsC4aTmrx06gs+JcduVBC1v85KCpx
	 e0prBROVqZq+0L0fXtPcRVCehuYkmkctsvYkAC6jEj22O2rjKe4MFfEchLwBM6qMf7iM9
	 La2/F+rotFiKWDy0ZiyUc3qsuru+vAlSe1A8Z+GxHmjTHRVkazYBUUvUQswQhfXhIjsrf
	 J9Vw6Bs8lYD9jBaJgbAXtcBPR9Q82XwTHhPYXsdyXMkNNnuz/h3/lJ6Qg/VU25uba0tnR
	 MlsDBkXgUStaalC2IWW5qE0QFC8dBwaehFD3AR4+DxzBKR8L9vR8Mj0F3rY/YjrZLlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Yk4KE3dyngW5psir5iFSrVdqdFTjy0Bi2iDkl4FIkXY=;
	b=ypxloRAyECsH89MLpxa1wuhWYoKdnzG5y7NkHf/GZPcIDlcYtX1gQ9IWxam95nsGD8EQ
	 FpzxcIOZ/FXuESn9CJrMb9HC6cdXSQ71voAF+aL98RzZdw1eSfrHJOKY61c6+hlFTUcnz
	 K/8SkqKPXZLFHQyPvFyKiztOHUDpdix1aYd83e/qXsus6fFdSzOn76P/F/+Pw6yPWMW3u
	 7GdpupD6qxMeTQlenFojhBOrb+io/KHfPHmjYrGDO8Tr+vZZV35Vs6y5F6gG1DnDskhw9
	 WA1j3+GSY4K36/bhdWsiPEfeCnZngE60gggG0azKarb7ttf1P9JvhI261VE4/EC1HrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dh4NS4Q2;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E234C606A32F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E234C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dh4NS4Q2
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93ece7a73b9so200335085a.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660951; x=1793265751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yk4KE3dyngW5psir5iFSrVdqdFTjy0Bi2iDkl4FIkXY=;
        b=dh4NS4Q299jGzUCS2/Fk81ApiML0bF3rQtTWTfHMdgm0laKWejNmjNHxugbi/q47Xs
         ixX9bzSNKItAawqVaufocQKIisLKTDgG5gU4rgTfGhbDY3B55Vzbzddwd1KjawanIcpA
         VowEbQuWbF266yuSwweTEMPbxNVtNeu5g2BFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660951; x=1793265751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yk4KE3dyngW5psir5iFSrVdqdFTjy0Bi2iDkl4FIkXY=;
        b=o1POBlWxtSj2hECv5isFWqOlYBw8ndqoFKTPb7q0IiiRTTptOvnUgRkuWVPGCO5jO+
         hEM/X3yKndF4BwY0PZLbsvB/aY1+tf1IDmSgFDLIEgkWttX7ruACl3umXahre488eSx/
         Tr9Jrin4MSlew6Drn9U38x0iVVlNNcFjAq7YJntPx8idGdkEks9Y72VBBWIDaJnEyhI/
         rwuw4ZjETVGe+k0t/qY+hLhLUBgNrO+DKA6F+aWxBnYL+v+xz0MyJqKwzFzKuasIBbDq
         mFgSBn4z5EJe0i93qC9GC62kXJZquiXq8N7trOvaLFXonMvpUFZuyCALKRBWsR3Pz/bS
         VpCQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4LNONUW2kNirGeDSFtxN0fzfQk5qUSPt76+2cvOYBYm7mtA4vFI9wNl2O2pXD48VUvKM33ng=@vger.kernel.org
X-Gm-Message-State: AFq9FYJY3CIsNXz6wwcKvZYZujDe0BY5IJtFgNC/mNEVTIZ8G/7vHp5I
	YaRARoKYzvH9rYGWQaKcifwzOb+NhMrKSFKJ7y0ZEqs65EWbYHumWC8aAHOiTcQTzg==
X-Gm-Gg: AYBFou2CUzZ4jRiIZSzFmZhJYopW4lpHxJyhbhT2nvcLnoy7ziRCnUmE6fHTVco2CQc
	urPnc6AaFwjGj6hS3/mf4f8fXrSRWsqYzEZYJGFfn0ChEZc/JVpfNq7OmjhSp5zY0JQ/CLusaTV
	YQIwQimz7oNYwFNvL8SYN/LToXVk3f8dSoU447IDohGxnnRK6LS8gLmrlylrdKbI4388ACAAplX
	1vJbUUfEgaPjDMgsmx1Y+KEeRyJ2Z+/N6uYSBIIiqsBe7OCAHfoFfd0nVe5m74fNy0wgh3kWUMD
	ircbCFu71zR6iW0SSm4SPx+MS052JFHiEYmxJhxsnywUndyjqH6yW5xf1MIR1FPbVCQNlmFiAmY
	EDFiyz4y0f0p8m6auqhx52CAMVr1ymJOEQgHdlQJ0XCb4Gl94TfeGmxuRmTeFAdGDcHDP+41rSO
	BxbfrlAUzREZtl5+wUW+Unnp5+DIR5ZKrRElbCyIA1q08OuAjxO0bDPHsGvop7gp/5OVWT6Je9D
	baRxm8XWxkDCMa5/SNHwjnzwPEEw6ssBeJ5Zc9gxLLY3vNgngUK5/MHULl8hl7DRm75aKNprphN
	CwdC7m7luU2L5jOwz6yMHrWQvg==
X-Received: by 2002:a05:620a:3188:b0:93e:c12c:f148 with SMTP id af79cd13be357-93f57f793ccmr769726585a.82.1792660951054;
        Thu, 22 Oct 2026 02:22:31 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:30 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin Varghese <martin.varghese@nokia.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net 2/5] net/sched: act_mpls: reject short linear Ethernet headers after pop
Date: Thu, 22 Oct 2026 05:22:19 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
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

The issue:
act_mpls POP can leave fewer than ETH_HLEN linear bytes after
skb_mpls_pop(), either standalone on an Ethernet device or chained after
act_vlan POP_ETH.  A subsequent eth_type_trans() can then BUG in
__skb_pull().

The Fix:
After the pop, when the skb started as MPLS, drop it if the linear head
is shorter than ETH_HLEN.  Non-MPLS pops and pushes are unaffected.

Conditions to recreate the bug:
- egress tc filter on lo: action mpls pop (standalone), or
  action vlan pop_eth action mpls pop (chained).
- AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=28, and a non-linear
  eth / mpls / inner-eth frame.
- The pop leaves skb_headlen(skb) < ETH_HLEN; a following
  eth_type_trans() can BUG in __skb_pull().

Fixes: 040b5cfbcefa ("Fixed updating of ethertype in function skb_mpls_pop")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mpls.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 4ea8b2e08c3a..4d375033400b 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -57,6 +57,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	struct tcf_mpls *m = to_mpls(a);
 	struct tcf_mpls_params *p;
 	__be32 new_lse;
+	bool was_mpls;
 	int mac_len;
 
 	tcf_lastuse_update(&m->tcf_tm);
@@ -76,9 +77,12 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 
 	switch (p->tcfm_action) {
 	case TCA_MPLS_ACT_POP:
+		was_mpls = eth_p_mpls(skb->protocol);
 		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
 				 skb->dev && skb->dev->type == ARPHRD_ETHER))
 			goto drop;
+		if (was_mpls && unlikely(skb_headlen(skb) < ETH_HLEN))
+			goto drop;
 		break;
 	case TCA_MPLS_ACT_PUSH:
 		new_lse = tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_protocol(skb, true)));
-- 
2.43.0

