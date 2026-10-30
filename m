Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329515;
	b=22nDDvDG1aLK7LRcm5WB3XK6Or/PHaf65ZExjfhp31BAENnp+EOAMYYU4xHLPK6t93Cf
	 RCYk2mbI/XfMReyU04Q97X79rbF1PqSgVY2kj91xk/So4Q8QmpithULAfSS98WhempmD/
	 qhV/HFeMe94NDCi0BwUxDJTwFiZiM24Mb6CzkFCKPtqQQBRgwpNNzHvYIL+q9wClRSBsY
	 qG8kr38Y/IZ4rAX5Yqc34Hu6eu1nbdbbgPQxlq53ZnjJHlCngwhrsqVR7Kaqlw6U87Miw
	 lURJikE+NXiH2JfUhPunxGOdAMh51WYMjl/efGXqUzQJAqchP9MWZaPPr41NLuvvCBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329515;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=LrZBfGhAO98liKGA/GRCTc4NQemOV/QG1w7nMj/i7vg=;
	b=GVjCQaFU031yg3GW50L/PDl5BX7iKZHNMMEg6wI3uBZcnDgqT0P+u7RhO2ZZZlq7EqJ4
	 IriNOpG9dr8A5pJYmdGwfVhHr+sFT+eNJF1Tfnazus2gjzNAqmtyyR9XEULdDhXkvj1XU
	 wgsNtjSU8IV7/sctPjIDAHJW+RWZquzl+RersUy00sgRSfwLWFsxXyfR43617psSlL+3v
	 NVZREw9UokvqlYzXvL+dn0jhohs/aemAR7/fGN3AEPP7l8X4teHOn/cA2d0th6VlWWqg/
	 vmLmVudEljKG7wM3PiThz3X/lBtp8yPNGz+4Zx5kAlICCb8U5Bp//bIDFh7FACGsnbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="Ag17yy/r";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC2606A31A;
	Fri, 30 Oct 2026 03:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FFC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Ag17yy/r
Received: from mac.lan (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id C7B9520B7166;
	Thu, 29 Oct 2026 20:04:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7B9520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793329501;
	bh=LrZBfGhAO98liKGA/GRCTc4NQemOV/QG1w7nMj/i7vg=;
	h=From:To:Cc:Subject:Date:From;
	b=Ag17yy/rZkIKrpE7YD42xXo6bQ9ZSR9Cm+1MCLR28QzwlpL6csUl7iVmnD2v8jY+s
	 WYQxpYjVg+x7Hz/O24jtTjzkK08WtL7n7oaWMmAF4zBQHw9cTyvrqxnct2CIzsJusW
	 6vZiZp18ZYfyUTwJS/dRTlpJtQ6xglK8ts3TMOSg=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net] net/sched: fix rate estimator use-after-free when clearing NOLOCK
Date: Thu, 29 Oct 2026 23:04:53 -0400
Message-ID: <20261030030453.31928-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
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

qdisc_create() creates the rate estimator requested by TCA_RATE before
qdisc_graft() converts a lockless child of a locking parent. The
conversion in qdisc_clear_nolock() frees the per-CPU statistics, but
the estimator keeps its own copy of the cpu_bstats pointer and its
timer keeps reading the freed per-CPU memory on every estimator tick.

An unprivileged local user can trigger this. The estimator timer can
access freed per-CPU statistics in softirq context and panic the kernel:

  BUG: unable to handle page fault for address: ff9d8b20ffa47920
  RIP: 0010:gnet_stats_add_basic+0x77/0xc0
  Call Trace:
   <IRQ>
   est_fetch_counters+0x31/0x50
   est_timer+0x52/0x170
   call_timer_fn+0x9f/0x210
   run_timer_softirq+0x6e/0xb0
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Fix by doing the NOLOCK conversion in qdisc_create(), right before
the estimator is created, instead of in qdisc_graft(), so that the
estimator captures the final statistics pointer. Removing the
conversion from qdisc_graft() is safe: a new qdisc is created by
qdisc_create() with the parent it is grafted under, and since
commit bc50835e83f6 ("net: sched: Disallow replacing of child qdisc
from one parent to another") an existing qdisc can only be grafted
again under its original parent. Either way the qdisc was already
converted for that parent at creation.

Fixes: 8a53e616de29 ("net: sched: when clearing NOLOCK, clear TCQ_F_CPUSTATS, too")
Cc: stable@vger.kernel.org
Cc: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---

The bug was found and this fix was developed with the assistance of an
LLM-based code analysis tool.

Backport note: trees without commit bc50835e83f6 (v6.14) still allow
regrafting an existing child qdisc under a different parent and need
an additional fix for that path, for example cherry-picking that
commit as well.

 net/sched/sch_api.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f36c41224bcc..d89f3f0a3c5f 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1247,10 +1247,6 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		unsigned long cl;
 		int err;
 
-		/* Only support running class lockless if parent is lockless */
-		if (new && (new->flags & TCQ_F_NOLOCK) && !(parent->flags & TCQ_F_NOLOCK))
-			qdisc_clear_nolock(new);
-
 		if (!cops || !cops->graft)
 			return -EOPNOTSUPP;
 
@@ -1327,6 +1323,7 @@ static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
 
 static struct Qdisc *qdisc_create(struct net_device *dev,
 				  struct netdev_queue *dev_queue,
+				  struct Qdisc *parent_qdisc,
 				  u32 parent, u32 handle,
 				  struct nlattr **tca, int *errp,
 				  struct netlink_ext_ack *extack)
@@ -1405,6 +1402,11 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			goto err_out4;
 	}
 
+	/* Only support running class lockless if parent is lockless */
+	if ((sch->flags & TCQ_F_NOLOCK) && parent_qdisc &&
+	    !(parent_qdisc->flags & TCQ_F_NOLOCK))
+		qdisc_clear_nolock(sch);
+
 	if (tca[TCA_RATE]) {
 		err = -EOPNOTSUPP;
 		if (sch->flags & TCQ_F_MQROOT) {
@@ -1817,7 +1819,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 create_n_graft2:
 	if (clid == TC_H_INGRESS) {
 		if (dev_ingress_queue(dev)) {
-			q = qdisc_create(dev, dev_ingress_queue(dev),
+			q = qdisc_create(dev, dev_ingress_queue(dev), NULL,
 					 tcm->tcm_parent, tcm->tcm_parent,
 					 tca, &err, extack);
 		} else {
@@ -1834,7 +1836,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		else
 			dev_queue = netdev_get_tx_queue(dev, 0);
 
-		q = qdisc_create(dev, dev_queue,
+		q = qdisc_create(dev, dev_queue, p,
 				 tcm->tcm_parent, tcm->tcm_handle,
 				 tca, &err, extack);
 	}
-- 
2.55.0
