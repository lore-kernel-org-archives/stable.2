Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CE3BADA5
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786266461; cv=none; b=lOFDiMWdz0sysKxePNp/aZMpvwS2DHMDfdmMtxTNL91Lmeb/WfrUxIZMr4o4AgrbIFhBReJ93CjCbN5GlhN/saKtHiA45bAccPQ5IHSxqxUvIy+tGQDh47FsyjPq9hk1vLSopLjjRa0SRPGrQeCb9PLfNlEqUVBQRdqHsttJMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786266461; c=relaxed/simple;
	bh=5fMhEZBs1Za4/paEsMllPrG/Vj1KhK6BFKcqbNIRgtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cekmA/6PZewrjMgYSYFO+zYGFI0Yon6LtDEox9EeGkrm+53JEbKvO27XBmyZe7jL/ruyEdFc75F1Ql0AOiTHqPedQ+Q6R/4Y/AAzaWinWAIjYBF5gSSg8QCYXVfKrm6njzYOOCZDQtpTgS/TLjRWXXpuV43knjuEZrzZm2TWnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=tpG6OSWh; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="tpG6OSWh"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8f29ec73064so4442486d6.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786266458; x=1786871258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7dUTAoZtVqdPM8YZqDodqEpMlJ3A6YyseiZWnN9riiI=;
        b=tpG6OSWhzTPvSEdv7UT/Wjuq0iJ3NW2sVJtIX4DTPjuQbXOyNDqK+TNo47yMDXRn/L
         K4f7YiVUPVSYug2eUvnSIJFs1N1Jih14CBXY1rghzIBmURnm4Rd4ayCVZxlHrXqI07mu
         mpmOh+YMSmqwjNibLPH+k/VR/ewzSEbNO+B58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786266458; x=1786871258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7dUTAoZtVqdPM8YZqDodqEpMlJ3A6YyseiZWnN9riiI=;
        b=hSdpGauWbwWASRWOZslkt2PSzkOwsIdb/M4jG2QSd2nQiVZSJ42FXK6B46T5dyPtSN
         +BTVYeiBRk3S/jlivYItOU1I+UxQBJDcIVfiGgJrb5ys645SgfjyKa/q9eNFpt7pzqg0
         s+aIyZt2ivOoJcTD038JKJ3LTX75F/CUQ2X0MBpKt2enNfYkxBXysvXganeMi01AqVkx
         vbdW0MHWUkRpmfJfKigXhgZ5FGCvcULopbcIxtKiyvL4dxKFML5mVFflUsSU00mJfY5i
         YZqHNJNfDY1NL+KdwBxjCJ0NMoh2nK1+y88X1ghx/4aRbpA8IoYEN0q0/5ff70LG4hvg
         XS5w==
X-Forwarded-Encrypted: i=1; AHgh+Rq1CymWKdFKF21GJEnzFfFxTBdf6BneBKS2HHF6PclnNIhZxLNPGSmemwUw4cSJe99OdvxBjFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+H6cE7QwsWaA3QW23fVlA+XTY4FZ65+zouaPIIs4TNvtp64M
	/PDP9cMF8S6MfuC+Hp6SQr6K0p8eeVN9O5pWfnLXDJ6B0w661fe9BQFQoINlLaxRYQ==
X-Gm-Gg: AR+sD106OdeMVeXKM9mZHLHa1b4kJmnKhmzyFb8mGRBlVcq5eVIVAmoNRpwFt0c1q5t
	H1MqOgzXZBz6emQk2Wv7AKxTnmfY+mYHEEEgHkDVW2t811serNGLY6euhiVIVGDhZLs9uYxB/te
	G+LhnJFCbFS8J7VKflVoYQcKTSY3sj+KLk9LdYoz/eXPvqMVLb3CxCgiCsXk1NECyPQSVXW2lFG
	DlwNgzFUEATm2Hi3fE7RTvssd67iOI41ODiYHj+Ky8mkI8TmrTFvbExsf8T2QBNNin+/ND6zn09
	SgU88eaGrSiJNVdufGzoSSb4AfOyL6DAgQJtu7LdGJXwH6eanOOD67It43PA9xSO8PNoACkx4cX
	lQsA3rPQ2+U6/5H+bywrVZFoEQwhGr17Yxz3bGWVcClnKLSdqQ86XXSLTG1OfgSBXAFhb9SoyS7
	EMhjSoupK20sN1aCl9c6A9PGUvpMxI9zaYSVFaZZQi7tJP8Vxv9Q8Y0hoCciOBz9kzJo8MldwCN
	aJGz+5UDwg27uOzLgYna0mYY5F5h0qCWYTSvq/yeUn4bqkN5Kt0QTdvHg==
X-Received: by 2002:a05:6214:4a88:b0:8ef:4ed2:316 with SMTP id 6a1803df08f44-90881098e74mr463332616d6.1.1786266458432;
        Sun, 09 Aug 2026 02:07:38 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a918dc65sm47112476d6.6.2026.08.09.02.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:07:37 -0700 (PDT)
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
Date: Sun,  9 Aug 2026 05:07:35 -0400
Message-Id: <20260809090735.865439-1-jhs@mojatatu.com>
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

