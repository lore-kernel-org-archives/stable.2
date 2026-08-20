Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EADF3C10A8
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219870; cv=none; b=YaVzr26rOcDjAwvooQqb2VA0yzWPPgj2mW6L7zUmLPmxd3V9zXeG8M8gplrPuG7ciXW2eh40PbyGsIo4yIUmK3ziuCOAp14sNaR65Wiu1bOwtlRCYpwH+TP9PflB/Lm8aYOVFM80dqr1piyXHvhDQ8/Znxe3tH4/Xb6LHEDI9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219870; c=relaxed/simple;
	bh=U/wixShyu10A4AT9h30/voJvGjaqHe845FsoIYSl9ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QsTUCrTtZ8UXSU/3yF0HhWJHR7xS7Cm+0Ys2+fiiF5iYwQ/ESowu8aIPE+VJwxYtefRDEJXc2aPO5hwDGG6ClomI7SdqVaF3WKGVEhjdAa3Dt+eflX2sqEgR/vM4J0WiJfpJ/Buel9A2UXkyM22adkNaiX3MKSMdjQyg6B1l7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ZOru24Uz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ZOru24Uz"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52d7a3defe8so12458061cf.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787219866; x=1787824666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hsCp/I13XrlSV13nvixD/aFZtUTWYd+PouN++96+VBo=;
        b=ZOru24UzSVWvrxNzKwM9yNwv9uquDrWtTMmT9vQ04CMnXOZF98ZDNUTVNWn1Q4aRL1
         PSW++cY2kwX6dhDVnCsbuZdXcXfVP327hb1a59dM2lZgtJLvRpyNGw9oAMl2Jgm4Oain
         HxtQKdmK7hhls2vU5yLSRB7f76Rtk/G9PVJbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219866; x=1787824666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hsCp/I13XrlSV13nvixD/aFZtUTWYd+PouN++96+VBo=;
        b=sdb5qAGm+5+j2+MiOr6p5J0Qvfa8m9tzteKXeG7sSOL/2RWu1lRaXj2dwp/lgEMbUE
         0tp2w058lMdiOxCSHMA+TovPp2hw9SgNm/M1+M0cxaSQpcMjhcbmrCOM3loT+p0uUENn
         6nc3CXyC7mC7VtH6YaTVaDc7LjgLsXna98TlvCmHJWvuRp11a5m1AnsnfDbdqn1iuatq
         HWnTcbwz5hGB93r0aewKgr9SzeoIDZ5qt0i/vLFPwiNn2UbQ9jkSd5DftYCg4C67QL/e
         AN84mKdLVNlqADH0aAYGP5S/ldV5XCKGmzZAEqrlfvlO2M6M7YiPEe+6Co7sbJMVwKCk
         +8Gg==
X-Forwarded-Encrypted: i=1; AHgh+RpslAoDBtr9CZ31eG5Uchnt3ghVR8qaioSRV0Aju/ND/s8u+8gHZ7vjpkwjDgObqtr02lxK4FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvc5PVMLq8+1Y2scZK7y2vIV7nQlVL7Y92EvDRtvxniU5mJmS
	60aYUlre1DUC7NVz6/tnzZUxOLoKRKm8owb/GTRLgKU1fqbMpb+DnOsqS7G3HYBr2A==
X-Gm-Gg: AR+sD13tzXYpMBY4W47dSap4qLetOvkAZajuLOdr9VugtGmI22qCeoVgigL7qmbntm3
	52vBc0n2iQr5ZsqLsHrJCtzuQpdDcKPsdwhxC/eXjlqEkZKghQmY6SSdr9YpE7lkbFeNS44KSfQ
	vBb32/uMZW1oBn58GD5HGZQR2iABWB3SVx1LvqJ2Q9eHJdhJ4y6S8R05VPKUZ52A35ggv9P9V+p
	RNAyLmJCy1kn9o4VTjW2FynpswLlj14bu4JhU/0URAmnvOf/Z+5QqnXxK2qQFcrOAMbzSHaqgfM
	bRo9eKhGM98lkZHUWrPa3CuG93wvhG9975Yepc/e4ijUOQTYJCmf64SiDXT13M8ZCu+mVvj1T/Y
	RSffVnpAEzycy5LYxP5uNxIM+HD14WIL41FYIRD+OxRJpei5hpZM+fsbLyexmS2+10nBlkqOmdi
	44XYjy4mwOWgOxL/fs3x9jrVyKjLcj2qGfEzlIv/fRbtQY23jVSq0DvkKn2376c3+/k2TcPUUpc
	z1C62VR0XN/en6fj/o8P9WA39LojSceQOENxTEwZfjjHw==
X-Received: by 2002:a05:622a:191c:b0:51b:f640:2a4f with SMTP id d75a77b69052e-52dd57bc618mr109829491cf.4.1787219866550;
        Thu, 20 Aug 2026 02:57:46 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b8164sm34565336d6.48.2026.08.20.02.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:57:46 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	"Victor Nogueira" <victor@mojatatu.com>
Subject: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and account to memcg
Date: Thu, 20 Aug 2026 05:57:41 -0400
Message-Id: <20260820095742.68511-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
bound. An unprivileged user (via unshare -Urn) can set a huge
tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
memory, causing a system-wide OOM.

Cap the ring size to 65535 (default tx_queue_len is 1000) and use
GFP_KERNEL_ACCOUNT so the allocations are charged to the allocating
process's memory cgroup. A pr_warn_ratelimited is emitted when the
ring size is capped so the user is not silently clamped.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn).
- Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
  while the devices are down.
- Attach mq at root, then replace each child queue with pfifo_fast:
    tc qdisc replace dev veth0 root handle 1: mq
    tc qdisc replace dev veth0 parent 1:1 pfifo_fast
    tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
- Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
  rings of tx_queue_len entries (~12MB per qdisc at QLEN=500000).
- On the unfixed kernel this exhausts global memory in ~28 iterations
  on a 2GB guest -> OOM panic. On the fixed kernel the ring is capped
  to 65535 entries (~1.5MB per qdisc) and charged to the memcg.

Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_generic.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf51564..e98fd236afa0 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -910,11 +910,17 @@ static int pfifo_fast_init(struct Qdisc *qdisc, struct nlattr *opt,
 	if (!qlen)
 		return -EINVAL;
 
+	if (qlen > 65535) {
+		pr_warn_ratelimited("pfifo_fast: capping ring size %u to 65535 for dev %s\n",
+				    qlen, qdisc_dev(qdisc)->name);
+		qlen = 65535;
+	}
+
 	for (prio = 0; prio < PFIFO_FAST_BANDS; prio++) {
 		struct skb_array *q = band2list(priv, prio);
 		int err;
 
-		err = skb_array_init(q, qlen, GFP_KERNEL);
+		err = skb_array_init(q, qlen, GFP_KERNEL_ACCOUNT);
 		if (err)
 			return -ENOMEM;
 	}
@@ -957,8 +963,14 @@ static int pfifo_fast_change_tx_queue_len(struct Qdisc *sch,
 		bands[prio] = q;
 	}
 
+	if (new_len > 65535) {
+		pr_warn_ratelimited("pfifo_fast: capping ring size %u to 65535 for dev %s\n",
+				    new_len, qdisc_dev(sch)->name);
+		new_len = 65535;
+	}
+
 	return skb_array_resize_multiple_bh(bands, PFIFO_FAST_BANDS, new_len,
-					    GFP_KERNEL);
+					    GFP_KERNEL_ACCOUNT);
 }
 
 struct Qdisc_ops pfifo_fast_ops __read_mostly = {
-- 
2.43.0

