Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310D2EB5B8
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785589012; cv=none; b=BISe+shI5Y6rCOUcgOhAgXSzcbExFrotTX4UbGnSIh8jhJsOLVwDpsT89qriyGn86jZ6VdM9R9PQ5EgxdFyGQyrHct9Ybx329z//wUMzXdcZapalgJPGgLgZnp2mhcmgS0z62KrFEZ3vwst0Y1xmrw1MMPnuyP3DoAxK0e1pW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785589012; c=relaxed/simple;
	bh=geERCo2KgAe7FLO+4WZjeP/f5zSsTZKZow1tvCYsFlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LvQ1G2xzXQVjAKV96RzZfafUXqO7YmfqMXMEQKoz2qZbYHx31EMDCyVR+n8iRTYfLNCdJ/d4mN8QPYTl9Kh/hav2W7yM7Q4oCXZguYH1hAr64OaEiIB50My+4IrkAeHxPqEGOfcGxUDbb2uYmcuEdsh4BXrKOyCJMdEJaJjOnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mWynFkm6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mWynFkm6"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-934944f2d22so94880085a.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785589009; x=1786193809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZnZ6tTuvahRim61VJUbPOTWzgYIh9PQPJ7MO8TqOfM=;
        b=mWynFkm6s8+YUNaQAqEn1Rx5VPL/7dpOahE66KQ2FZb1gbc3nVaV13DRr7zROvPOBD
         ZJwU+1iZ8bVOMrF3QLC/i6d+u+7xw1WbwNwRGaPcN9KodaSnJm06sSFI6WYvJpfspatm
         oLDlKeIKxie78DT9CJt+LjEUYzmH8k3zWqCnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785589009; x=1786193809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZnZ6tTuvahRim61VJUbPOTWzgYIh9PQPJ7MO8TqOfM=;
        b=YfZ9M3d38/HLk2uUFvvMWyMpDZwZb3Gsu5Yxt4nDMh//0j5GaXqQjMyrRt53J/s+E3
         lnngVobFkmvrxTqdkLVHx5U9mYIHYILp0ZtVP4xE+In0XvERbyuZmOinayFGlGIY5T0L
         M2xDaVGkHHsMzpAx5oXmpgpBTwdZXY8vh2kxfIAQgEiei9uNxgj3TkFkiIMV9R/E5ABs
         X1cqmjHyiLLDOP6ZcsatmmgaBybJou84u0PKjbCU2EbfNAJaZDnwmtJn9PumrMmCvl8m
         9n+Ca6x1pGCJqxD1eoX3ZUsbfeRHGINzeRuMx9vrbz5ujqtD2jHufHluyPmh5CXwQMgs
         qFDw==
X-Forwarded-Encrypted: i=1; AHgh+RorUQvcIiWRwjrUSQfoSKPO4h9U0XknLVJOCMMm6qbmlYUSVXA7PehKjEkUsSoT9hLMqdFMs6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzafznS4VJM8D7Achnw5EZB6BLZmVyecRiS8sERh4FsEFaiG6/m
	gsK9q/6JXYBXssqDTIVXl6sJ/Zt9I5b9D5+emfA630GOwVhypQAca7wuxEoqxlPIAg==
X-Gm-Gg: AR+sD11m0iY+BlKNa1uNetyZVDGQXK28N/JS0lUxycOAEBHcaI/aC4FbfGuD8WJH5W1
	rXLyT86q78Kegkx3Fn+twjMsLzEP6XbVRBBABng2f/AxwcGPy7YcNJk2tQe7J5w/xMl9T3Uezke
	6mm/I/UxeL2c0kiIb8tmSOMGe8C8cwCQ+9jxw0CrI2IWnVUDqv9DKF9HcNq6lqcJS8Lk2DsOluX
	ZrkP+WtbST2Xp91rdn5xqov8tEvgiXTH3h2IQjC5xEJyYDFsSJaBv9sZxERwB6j3O4DON9Dhbm0
	FC2Qmb39UtjS6aTbvh2LvrlM+C4nbzoyxKDhLMTQKyZ8p/xaJO4y/lQLb4G5XA8SVcseA6pjSqg
	j6o3S17mlCXY+As7BcmCq0HXFYKbN5MU7eVXEErfdTgVe0r2kPkpZ3B+12Lg95QIvQNTAsh2kqq
	v6kLXCRVjzaaWS6lWI9FnhDT+gZv8Suev9kF2efL0g1eRBnQbKuMwixw==
X-Received: by 2002:a05:620a:5dc4:b0:92e:fc42:2c19 with SMTP id af79cd13be357-934a0789dd3mr545467885a.11.1785589008902;
        Sat, 01 Aug 2026 05:56:48 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm273036685a.33.2026.08.01.05.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 05:56:48 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	security@kernel.org,
	stable@vger.kernel.org,
	feng.xue@outlook.com,
	vladb@nvidia.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH] net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers
Date: Sat,  1 Aug 2026 08:56:32 -0400
Message-Id: <20260801125632.360365-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another challenge with unlocked filters.
There is a short window in tc_new_tfilter where a tcf_proto can be found
and briefly referenced by a totally unrelated, unlocked classifier's request
and cause a race.

Feng created a poc which created this race with two threads, one creating a
u32 filter and other a flower filter in the same chain/prio:

1. Both threads enter tc_new_tfilter, both find the chain empty, both
   drop filter_chain_lock
2. u32 finishes tcf_proto_create("u32") first, calls
   tcf_chain_tp_insert_unique() -> inserts u32_tp into the chain
3. flower finishes tcf_proto_create("flower") later, calls
   tcf_chain_tp_insert_unique() -> tcf_chain_tp_find() now sees u32_tp
   already there, takes a reference on it, destroys flower's own tp_new
   and returns u32_tp to the caller.

Flower then hits the kind mismatch check (because it requested for kind
"flower" but tp->ops->kind is "u32") and goes through the errout path
which calls tcf_proto_put() on u32_tp. If the u32 thread has already
gone through its own errout (its change() call failed on the PoC's empty
options) and dropped its create and insert refs, flower's put is the
last one and drops u32_tp's refcnt to zero.

At this point tp->ops->destroy() runs in a context that never took
rtnl_lock. When that happens, it might cause a UAF like the following
(illustrated by the PoC):

[  +0.000710] BUG: KASAN: slab-use-after-free in u32_init (net/sched/cls_u32.c:393)
[  +0.000281] Read of size 8 at addr ffff888120022f00 by task poc_feng_xue/524

  Call Trace:
   u32_init (net/sched/cls_u32.c:393)
   tc_new_tfilter (net/sched/cls_api.c:2378)

  Allocated by task 526:
   u32_init (net/sched/cls_u32.c:378)
   tc_new_tfilter (net/sched/cls_api.c:2378)

  Freed by task 522:
   kfree
   u32_destroy (net/sched/cls_u32.c:662)
   tcf_proto_destroy (net/sched/cls_api.c:446)
   tcf_proto_put (net/sched/cls_api.c:459)
   tc_new_tfilter (net/sched/cls_api.c:2459)

Fix this by having tcf_proto_destroy() take rtnl_lock around
tp->ops->destroy() for locked classifiers whenever rtnl is not held.

To explain why I used a temp variable "not_lockless" I'd like to point to a
semi-related note on rtnl_held vs TCF_PROTO_OPS_DOIT_UNLOCKED (adding here
for future cleanup if deemed necessary):
The rtnl_held parameter and the TCF_PROTO_OPS_DOIT_UNLOCKED flag are
redundant sources of truth for whether rtnl_lock is held. Among the nine
classifier destroy(..rtnl_held..) callbacks, only flower consults the
rtnl_held parameter which it propagates to tc_setup_cb_destroy()
and tc_setup_cb_call(). The other eight (u32, flow, bpf, cgroup, route, basic,
fw, mall) ignore it entirely;-> those that call tc_setup_cb_destroy()
(u32, bpf, mall) hardcode true always instead of forwarding the parameter.

A future cleanup should remove the rtnl_held parameter from the destroy callback
signature entirely and have callers rely solely on their knowledge whether
they are running in an unlocked context.

Fixes: 12db03b65c2b ("net: sched: extend proto ops to support unlocked classifiers")
Reported-by: Feng Xue <feng.xue@outlook.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_api.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index fee4524adc98..4e6a2812a4f3 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -443,7 +443,22 @@ static void tcf_chain_put(struct tcf_chain *chain);
 static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
 			      bool sig_destroy, struct netlink_ext_ack *extack)
 {
-	tp->ops->destroy(tp, rtnl_held, extack);
+	/* A locked classifier's destroy callback (e.g. u32_destroy) uses
+	 * rtnl_dereference() and mutates shared structures (e.g. the
+	 * tc_u_common hash list) that are only safe under rtnl_lock. When an
+	 * unlocked classifier's request (e.g. flower on ingress) loses the
+	 * tcf_chain_tp_insert_unique() race and ends up dropping the last
+	 * reference on a locked classifier's proto, destroy() would run
+	 * without rtnl held. Take it here in that case.
+	 */
+	bool not_lockless = !rtnl_held &&
+		!(tp->ops->flags & TCF_PROTO_OPS_DOIT_UNLOCKED);
+
+	if (not_lockless)
+		rtnl_lock();
+	tp->ops->destroy(tp, rtnl_held || not_lockless, extack);
+	if (not_lockless)
+		rtnl_unlock();
 	tcf_proto_count_usesw(tp, false);
 	if (sig_destroy)
 		tcf_proto_signal_destroyed(tp->chain, tp);
-- 
2.34.1

