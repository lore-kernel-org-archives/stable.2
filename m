Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339B3ED128
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086736; cv=none; b=DGScxWx19UjCvpOGEbacnQQqcIFJMGf1StOr/U3T0RHr7SEXalYxX6r7omXxKAEG9WJQtLkc2Kwt3C2KdtSBInH0F2QsB/UAatxc3+ZsYQHgs5e703zM0IEDvSK4bIjNpyee9wYb0BwFEHXhclX7m/yZooF7of9i83vM4dLADdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086736; c=relaxed/simple;
	bh=Ic9CEGREOD5y9X3l20lpqUpOb9jCx8JtdNqVvsEVd8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QdjnUbe/vLmVjtnVi4yLf3cX0iSiodZhCAeJgGopb9ZXOp+gMfdcoafdkuL4O03ezTa2s8fQPorIAh66zyqlXYo+Flhpg06/4/yDGHo/5PMviZmAp3qag/cAAo/zNbkciW4/bc3mGgNZaHZ81aB5MDDz212dI7JOtfjeouxpO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Kx3DhUUK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Kx3DhUUK"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5175b6c4e19so68956091cf.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781086734; x=1781691534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPIESdLDZGUXa6Ogop7LK04l+zl3x/dImkvKUuXByAA=;
        b=Kx3DhUUKxN/t46QDz5xOZLD+6QbFSTufpk1CEKNfZY+ecKvHnuqw9p/UR5CE4WxDN/
         a8Iq32yMYPrm9JsDZ25K8cSe09QaE6qjQq2TMM2c39AwA5P/mEermaEk8B1SjZRatVY0
         6v4HPQtiTfpkI1M1A0qAlO9g1BBRkGJAgxm58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781086734; x=1781691534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPIESdLDZGUXa6Ogop7LK04l+zl3x/dImkvKUuXByAA=;
        b=NWaODVWaDEuXgoqco31AdJnzNUIMs9V2kZQwPFWzJcdxnvkDcucjH1RgPET2PGXJ3l
         +/RCZg4ntAMxT2fQm/5PxMfAQws8A89+X+GVpRmIXguffmlutMffqTgMtLwuMKYgwrsD
         0rpwQdLOiy1h7xKN/bqgsI3rUKLRnS6F9FxY9ZTzZByjav4tOuBy67OnjVb30gcDn4I8
         DZTRHNslUtE5ndCJukxDghuOjpYbgNEfv5kezYtfwT7dR+suNIYfgg02UzGLerVqt0kS
         58NojRmVzrTd2fcjbEQPiUeRy3LROctYBfrX7+We3iJmaSGMlVSeAuFfs1fxT/dBJOYH
         JzIg==
X-Forwarded-Encrypted: i=1; AFNElJ/5u7Lwn8hM+AX3Zufd/Qdy+rqYZVTWkhlKyFXf9GCWDKDsFcKpzE7kNwfBBzJ/X0Du+GnFXFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9dZPLGCP/pSdveYrKXD2UIfPV4FFL8GlrwFQO4F9n7HhU6uP
	DdH/iYt1U88ZaMPY6MwE4MAwHgnnQt4vfwNfbMowqFpee4AngfVDB4DevEoD4WQX5oTQo2E1R3h
	jHMiM8Q==
X-Gm-Gg: Acq92OGc4S2hE5n/jMO8bOZ13ymBQfTeuyjVZW9yjWdyFd8PBT5zMVzge1pZL3ceik5
	o6q1wDBnJcMHZgfhXzRdz19bX9ukD00J/nxcq8y9/haczsEV8m+O0QnrngtZi9/ukqYcgk90/fu
	qQmMtvf7Z9noWrHRaOziceM13kJRqs8EYTmgG2/yPw8eOFraJdbNjSxwmnlGUKfcrGih8519fYn
	rH7zPQnQb/1DZeDGhv1tLcwU9G+0mK+t/wOehzdCOCorgSWCtvf6bVF49oqpSJqbo52wKkVTONT
	WgVrN97vSydfubHZdJhJiqkm7Dc0pwb05pHkISqZMNj1nChTsDc5YUlDNNPhqXPK7alc6p5ckJH
	K48M0HUmm6MB+qYeuWYcOCSokn65JxLbwsDght5IyxTYjKOIMQP3reFWvYPMUZkJgVhvgHxZOCz
	cMdTNJTC78HWZoWPwzE1wcCIqmATL1Xb6lnBRALQ==
X-Received: by 2002:a05:622a:58c8:b0:516:d66e:7b1f with SMTP id d75a77b69052e-51795c6b5ecmr354207001cf.31.1781086733907;
        Wed, 10 Jun 2026 03:18:53 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2682f8sm230139796d6.43.2026.06.10.03.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:18:53 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	kylebot@openai.com,
	stable@vger.kernel.org,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: cls_flow: Dont  expose folded kernel pointers
Date: Wed, 10 Jun 2026 06:18:39 -0400
Message-Id: <20260610101839.14135-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flow classifier falls back to addr_fold() for fields that are missing
from packet headers. In map mode, userspace controls mask, xor, rshift,
addend and divisor, and can observe the resulting classid through class
statistics. This allows a tc classifier in a user/network namespace to
recover the 32-bit folded value of skb->sk, skb_dst() or skb_nfct().

Align with standard kernel practices for pointer hashing and replace the
XOR folding with a keyed siphash (which is cryptographically secure)

Fixes: e5dfb815181f ("[NET_SCHED]: Add flow classifier")
Reported-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_flow.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index ab364e4e4686..356c68ebc389 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -21,6 +21,7 @@
 #include <net/inet_sock.h>
 
 #include <net/pkt_cls.h>
+#include <linux/siphash.h>
 #include <net/ip.h>
 #include <net/route.h>
 #include <net/flow_dissector.h>
@@ -57,11 +58,15 @@ struct flow_filter {
 	struct rcu_work		rwork;
 };
 
+static siphash_aligned_key_t flow_keys_secret __read_mostly;
+
 static inline u32 addr_fold(void *addr)
 {
-	unsigned long a = (unsigned long)addr;
-
-	return (a & 0xFFFFFFFF) ^ (BITS_PER_LONG > 32 ? a >> 32 : 0);
+#ifdef CONFIG_64BIT
+	return (u32)siphash_1u64((u64)addr, &flow_keys_secret);
+#else
+	return (u32)siphash_1u32((u32)addr, &flow_keys_secret);
+#endif
 }
 
 static u32 flow_get_src(const struct sk_buff *skb, const struct flow_keys *flow)
@@ -596,6 +601,7 @@ static int flow_init(struct tcf_proto *tp)
 		return -ENOBUFS;
 	INIT_LIST_HEAD(&head->filters);
 	rcu_assign_pointer(tp->root, head);
+	net_get_random_once(&flow_keys_secret, sizeof(flow_keys_secret));
 	return 0;
 }
 
-- 
2.34.1

