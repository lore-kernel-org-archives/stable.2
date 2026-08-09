Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E1367B87
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786266584; cv=none; b=NGrMzcpTvEQdo3tqPsWdwHh6Q3cExwz/Y3Hd0fFTf12zkvIOaff/pxMzJCPM7bRjF+DsI0tEz/ZqMI5b0bFE2NJ/PoK8dlVnl6HfyGXBcLmZU0XV/9Z9eCHigVY8xu2BhdDgrNBC26zH/Po57+8SH6PhPmclw5Ex8AoaUenROSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786266584; c=relaxed/simple;
	bh=5fMhEZBs1Za4/paEsMllPrG/Vj1KhK6BFKcqbNIRgtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EnvRgnrA7NYdYF73RW2qT3ejy+b83y/KAczxYkkvdpPbcrnA4Y4tS5B1uWg0pvIcEJ5K8baq2ClO1W6OMDwzzJFc6cPJQHf2OT/pcQiW6JdaY0l5lGnSvWW/VuDRux5KKSe14OexeNz2ZsDlWTDxZq0XpWqPeGwp2ALVBRf3lVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=I95iC957; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="I95iC957"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-934944f2d22so43470985a.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786266582; x=1786871382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7dUTAoZtVqdPM8YZqDodqEpMlJ3A6YyseiZWnN9riiI=;
        b=I95iC957kWrqvAeV8v8ktD4xXyFGZ6mDw9St46sEDg2GYYY4fVDEtAxhr//TKBhp9d
         dk1LNXuKrGJT6ZPFz3/UvF+N5pPUGLKCR3CNTnWJmjOUS5fio/L3hmwfAwepnxrHYeMC
         hq95J6oUOGBNehNXwwM2hNxo2qI8sIq1kQ7BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786266582; x=1786871382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7dUTAoZtVqdPM8YZqDodqEpMlJ3A6YyseiZWnN9riiI=;
        b=CS+fszgpYDzuLexFE1F+Yc0/CKkF6K4uG5EflV7hm1JobLa9k/1h4wV30X0GvTaRvm
         PIkXZATjuCCnCHPb9nuVz+ya13QRtOB+lE+6hIpL3pom2cML/QBx5wpjXTfeM3UnVhcC
         Tt4lE5MxGbsItin1JrCaCqhyE9A1vz2rU1kEngLWY1CmNvV4vu93iaR+mSvE3LkDggiW
         RnK0h6vMjNsSr2Shp3QGIRxtGNanETm8PEpx40stHEfOrLqTyJLkmDwRBCELtNnauKRF
         N+DQ4/5RKx1u+pIY8OQ7+xwU77HZFmEh093OZsLd9jYO4+sHVgYZkYIbZHnHnXMwH9xb
         VVUw==
X-Forwarded-Encrypted: i=1; AHgh+RqlR1jU8vfEQugdArrSR/g2SpkObWFx8uKY1zr771SWfBrPL24CDI4A4FuF1hw4WGz7QGtS6/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YychWbUABN2hjWN+KaH5MQrSLlbZGKbk9n54tkJx/9iU3tbM3h7
	uQclmzuvSL5CpxzoW4jJBBO0hEkPIWU93newKpdEeXn/xU6lo8uZpuH0UXggiMZzgA==
X-Gm-Gg: AR+sD120OdsEMX9VujXgniT/GXuclCtClxd57Q2KakQGIJtS5r2tphO7G1mi5spcaTU
	zxj6wch9OOobcTjrs1tzGeQ45pVEof0cvx5GvGR46pLDlewY6v/LxY/h0lL5JVSkN2AaRinDjNo
	czdYIYc7CxDTsR7m+PDLBc7ozAehNOmazN5z1M4NhrlwDDNAtFkMS/wX4fPXWUJwoADU+1HDHGy
	+qFZWgbdPeYrqVhg5MeNd+nzcJJipIOdcock8Unv6HsZdS9Sxi62VCsUR/whgoRgx62DNTCzFH3
	ZOl7fFf/EwYOh/Y2ZKBPFTCe9JuGwL14jDe9CM2/toDAGoT85amxzX4fNcCFzY6C5LQxYUDQQdB
	iMyMSp4r1a/caR06WFEZCygzlKPJtjkDtUoJBciNMJ1sqk97ToIkpqiCvR2jteoT68vV260peoW
	3dZXf6PJto20NeyUao26bCUNEsFGRAZtv9gkFvT1J5yrYjYXTCme8F19+qgEMner1qgcsENbf96
	GSR7V79q4MyMKg7EhHSWlQWhZ1HgcTugtYfCR9zKv0P7shi/bRzfhs5Tg==
X-Received: by 2002:a05:620a:4493:b0:936:826e:5ab7 with SMTP id af79cd13be357-936826e6877mr779107085a.45.1786266582243;
        Sun, 09 Aug 2026 02:09:42 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e258608sm530278885a.33.2026.08.09.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:09:41 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
Date: Sun,  9 Aug 2026 05:09:28 -0400
Message-Id: <20260809090928.868186-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
rcu_access_pointer(a->goto_chain) and then calling
tcf_action_goto_chain_exec(), which does a second, independent
rcu_dereference_bh(a->goto_chain) read and immediately dereferences
chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the gact
replace path) can clear a->goto_chain between the two reads, so the second
read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.

Fix the race by doing a single rcu_dereference_bh() read of a->goto_chain
in tcf_action_exec(), checking it once for NULL, and passing the resulting
chain pointer into tcf_action_goto_chain_exec(). This turns the split
check/use into a single check/use on one value.

Fixes: ee3bbfe806cd ("net/sched: let actions use RCU to access 'goto_chain'")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_api.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index f141634df214..600b7804befd 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -41,11 +41,9 @@ int tcf_dev_queue_xmit(struct sk_buff *skb, int (*xmit)(struct sk_buff *skb))
 }
 EXPORT_SYMBOL_GPL(tcf_dev_queue_xmit);
 
-static void tcf_action_goto_chain_exec(const struct tc_action *a,
+static void tcf_action_goto_chain_exec(const struct tcf_chain *chain,
 				       struct tcf_result *res)
 {
-	const struct tcf_chain *chain = rcu_dereference_bh(a->goto_chain);
-
 	res->goto_tp = rcu_dereference_bh(chain->filter_chain);
 }
 
@@ -1170,12 +1168,14 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 					return TC_ACT_OK;
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
-			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
+			struct tcf_chain *chain = rcu_dereference_bh(a->goto_chain);
+
+			if (unlikely(!chain)) {
 				tcf_set_drop_reason(skb,
 						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
 				return TC_ACT_SHOT;
 			}
-			tcf_action_goto_chain_exec(a, res);
+			tcf_action_goto_chain_exec(chain, res);
 		}
 
 		if (ret != TC_ACT_PIPE)
-- 
2.34.1

