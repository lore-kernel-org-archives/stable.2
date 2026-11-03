Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706644;
	b=Y22Irv/ZwUmBM6kYSz85I96OVjhHIygJcXD4No+WzXjt2D5/Af41gaPIdigxshihj24K
	 O6jaXKdchCGlhsvRLYd6E68dpc6SubwZasPuiKRQaze/TTFUsumlEvJZu2f2I+Sfl39RM
	 RlDX5CCi9hfz39yHsD4vROrkW2DFBPMqrKuSm6lMxT9GqaG1MqaRvirS54gm/HVOczrkL
	 yj9Qk+X2YPI1fceK9fGlmxadbi8LqY+wBJ6D7qO4F00L0ZNB6qMlFvzmi1192LqrXUcaB
	 PcSS1RiW1cpamEZ3O44xIUoT4tp+DlQgOln6+87bBaE9Ya07sJROH89+0qfsD8hiNsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VJVYoV66ZWlCSKMq9UP4qiOpvHPf91Q6R1ZFhFW7yl4=;
	b=sXrhxKkw//XTNksAVzO4/vgtc0VTg7tNe/zomtV4bmZv92SegbGRy8dGL5KYlQyHS5+t
	 lbTvtNF/NQp7HcGGpsZDBQrA8nsYBXNdJQeJRSyxKMKS8kBWkBN+jr0J81gvHkn77Bdhi
	 RKBaEZMX38Ei9FoSibOMju4uR5oWfxX3mBzHXwYi3Vf+ZpE0O60jvfzkAf7usMOQb/xpT
	 aaFfDNWdYa2tkItnTkquHm0r032Lv+9Lp3hCTKJDGAbdzhRPsR1i95bsJ9QX+YoRa6/9Q
	 Q4vbsahfj7x6DRm8gRmq7wik3+TERHdjDEwjS8W6PbgG50grnNDSGYx9lYkXxUvxUDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JG5+voIm;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D56082BCE
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E24D56082BCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JG5+voIm
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0cf2c0785so32766197b3.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793706643; x=1794311443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJVYoV66ZWlCSKMq9UP4qiOpvHPf91Q6R1ZFhFW7yl4=;
        b=JG5+voIm8YTjfsd55AAV3HQ/hnlIBZ1bqkudSIHYHgBAOg/DZ7069ajknDps976l9V
         Nzl+UX9wxtFe+DU9JmpDHzfsoeKSIl3SGUHJc+DR30NcxrorZtE0Byw5vLSRqn6p8z+5
         7mEhZE1Wju+lm9I1bKBi7AVb75ZwKC2Y2i4YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706643; x=1794311443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJVYoV66ZWlCSKMq9UP4qiOpvHPf91Q6R1ZFhFW7yl4=;
        b=u2vQVRjNcrr+P+UuVYriP75KgAKSFaQfO58zwt/ToYdVFgapKuuLttZ/fE1vBTZmwK
         SVXsqdQUvRXUuwqI4/hups2oSkDQq4+0RlAAwwTrVhoRBKFnSiqy0N0/t7vTzfte7fHP
         ntiMFO3OBK1Ot/BjccRsumFSv9y0Q8qg6TQ1mo/hg5+xLdYImUKEsmekzi3YW1NwMVk6
         JC8wT/XI6fh+eznbjfs1X6MF6VaoS6C05qsZfs6eValawkpj0ZBN96UCGMBxdC7tKgyj
         Kqmr4/YEi7KvmpvM1jD5PhiN0qBh4P//r5m+BxK4mH8LgdIerjzB60M3n7b+ax3wbg0v
         T/yQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+KMitCcT54Sq3vGdj3aAugylvf2vUTn8ywWD4bru7PZGk5/JQ6+x4affVKH3jQkyHeZRhvo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z96Ex0rkLBkZZdTmEKcQff+bNl/IjIdd2eBoL+gcahqUdGJdupL
	wgJO1F7tp/Msz8huT3UtziqQ8vz2jzUudl3If7UWVlkrOCFVFrXlcWEeDHJEjUKiZg==
X-Gm-Gg: AYBFou1xW1WjQEh0w08sWIoCuuuOcZ0y6cq3HZVGUDp/N8l76Iw+WGH7dTnySHafCiD
	m0Kn/EjeiPu1AVUcrHP4+z7cwORnxjnljUQfgWa7rNdoyTR6eEf2cjKAexhN0CDyI6DS7n+XhTS
	NyOWIuPT0Ni5DEeOCAaZ54+irZ8yPxexhWP6fS7bkTSPO9q6wGFJu5A/jdv58cFLhZVqcfuCm2n
	PhpoTqFWoVew0MQCZSKhV9/L96GOgW5rvCJMoIeF944sdX1Bk8k61Kpm+VM6spp3PhrSZAA8GtO
	Tnc3w5ezUjAF89iIvwKHlMi83tVDXgzYby38yKXkedGkI7oTnzwl8pBa5ZqbWSjcXSGJ7j4EVdt
	4Q1CePd8xksju0Ecq/oGpM+9oyDu9Hs3K8MnReqvmdDzbb+wUTO1fvnuM/904ssoLv6GCEU0Sq/
	uTOjEopDawPlhbnp9SmLMrrneIdt4zxOLOlwUK8F3WwmLMlW/fgaf8j56VYq554P3xfUCEHZcXX
	jPYi5LJw1fd+cw7NFVX4f8s5DA2PxJ4yDic5z4V4B8GZr8V4F9d5i1aJ3oCuQzCG30CKtizIQjM
	y3Q6fRG8GwU7PNXPs473lXPm/mHiKdwJUyOxgb8Phduy/SjSPJuXYzuy3A22ZeuBjzODa/MrFez
	Z1opsdR9svTOZaAA=
X-Received: by 2002:a05:690c:c507:b0:873:5ddf:d872 with SMTP id 00721157ae682-8b2b6749779mr76437497b3.61.1793706642822;
        Tue, 03 Nov 2026 03:50:42 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704d699sm70016857b3.5.2026.11.03.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:50:41 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Tom Goff <thomas.goff@boeing.com>
Subject: [PATCH net v3 3/4] net/sched: sch_teql: reject qdiscs from another network namespace
Date: Tue,  3 Nov 2026 06:50:31 -0500
Message-Id: <SER-NSBD.v3.r0.20261103064310-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
References: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
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

Reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.

The issue:
The teql master devices are created once in the initial network
namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
teql_master embedded in the registered sch->ops and uses it without
checking whether the new qdisc's device lives in the same network
namespace as the master. A qdisc created in another netns can therefore
attach to the init-net master and change its MTU and flags.

The Fix:
Reject a teql qdisc whose device is not in the master's network
namespace with -EOPNOTSUPP and an extack message; same-netns teql still
works.

Initialize the private skb queue before any validation so every
constructor failure path, including qdisc_create_dflt(), which resets the
qdisc before destroying it, sees an initialized empty queue.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y, CONFIG_DUMMY=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
As an unprivileged UID, unshare a user and network namespace, create a
dummy device, set its MTU to 60000, and add a root teql0 qdisc:

  unshare -Urn
  ip link add dummy0 type dummy
  ip link set dummy0 mtu 60000
  tc qdisc add dev dummy0 root teql0

The init-net teql0 device changes from MTU 1500 to 60000. A pfifo control
on the same device leaves the MTU unchanged, and a direct MTU change on
init-net teql0 is denied. The namespace needs CAP_NET_ADMIN; no init-net
privilege is required. With the fix the attach fails with
"Operation not supported" and the init-net MTU stays 1500.

Fixes: 7316ae88c43d ("net_sched: make traffic control network namespace aware")
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050-3%40mojatatu.com
Link: https://lore.kernel.org/netdev/179366641863.488856.17368571591466000274@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2: considers comments from Sashiko (nipa) on the repost2 posting:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v1.r2.20261031160050-3%40mojatatu.com

The cross-netns check ran before the "teql can only be used as root"
check, so every case it did not catch was answered by that check, masking
the assertion that tc-testing case 124e makes.  The root-parent
validation now runs first and the namespace check second; 4/4 adds a
case that covers the namespace rejection on its own.

 net/sched/sch_teql.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 70c948a26f80..dc21cd9704a2 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -200,6 +200,8 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct Qdisc *first;
 	unsigned long flags;
 
+	skb_queue_head_init(&q->q);
+
 	if (dev->hard_header_len > m->dev->hard_header_len)
 		return -EINVAL;
 
@@ -211,9 +213,12 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EOPNOTSUPP;
 	}
 
-	q->m = m;
+	if (dev_net(dev) != dev_net(m->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
+		return -EOPNOTSUPP;
+	}
 
-	skb_queue_head_init(&q->q);
+	q->m = m;
 
 	raw_spin_lock_irqsave(&m->slaves_lock, flags);
 	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
-- 
2.43.0

