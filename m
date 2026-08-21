Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA8427F8B
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323819; cv=none; b=trzIyiRPTqcOE3t8+X1zWlrVTHm2052bsR5Qz4DtROfvtO+fjgtr9fDi4M0TPKTleriJNQFPI+Sy66rQTEXPxWTs0e9JMdIk8nrGY+72kEFWF5N904vd8Pd/eR4YUGd/5zs7bxm/AopSHxC6FmzQOuwiwEVMsOZ8qEVexVsGKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323819; c=relaxed/simple;
	bh=1+f6099av0ZbQ5n2zYPKax3BUBLHsgZRMcPjgN88OhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S88BdGpJF/rTWIFB5SieLKXCgcibJauy9Hjs7XfzQOA3tIg4J4neOHLqQq1rXULTSS0uYhKrf+a6MZkWkwX7Jvu5ZHmtKu6WC5hooWVdrxaZP9Ho8L4ZoddMomd8QIy7v9mAm0BkWIZP6PidIUY183yW089V+Sjv5395Mj7Xp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNIS3OdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNIS3OdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2621F000E9;
	Fri, 21 Aug 2026 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323812;
	bh=siMjJsuO3Vt3IG2tSKDuiiFGm8n6ZsK71TtvvIEE+eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNIS3OdV8QGNkdbChUKORt85bzNlSzKjaR6nd7ac5O1B6/5WwbDu7Yvzvi0/2E+1r
	 ClbB5XR3KVvmJQNcqELuf875ug30ZI/8d7LSRmSNzpyDXZRYdF/FbwgaUQHJfZXFQz
	 NCWiaJ9d7IL1TcrruiXs9aCMKUDU0Rc7jCbSrvjSO6jgpHXVHWDAbN65eJbioGq15V
	 mv1eLKCPSrdDwVOxfzLsl3uGPsM/suHJbVz/YSKNEJAvbsMJie1vDtL6r9iJyNgORd
	 aUPVPOQQDqwgusDwfjotwPQRsM1S81pbcvCCfBUNtxZyb3TG3JKP/pNcGa73DN/UcS
	 nncDPD3feHM4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijie Huang <milkory@outlook.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net/sched: reject overly deep qdisc hierarchies
Date: Fri, 21 Aug 2026 10:50:10 -0400
Message-ID: <20260821145010.3430526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081713-crushed-deftly-56ac@gregkh>
References: <2026081713-crushed-deftly-56ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijie Huang <milkory@outlook.com>

[ Upstream commit dedd34b0f2310e28c5f6d4875cfbf4b7ed821c01 ]

Deep qdisc hierarchies can lead to excessive recursion in qdisc tree
walkers and exhaust the kernel stack. The existing loop check does not
cover the create-and-graft path, so a hierarchy can still be extended by
creating a new child qdisc below an already deep parent.

Store the hierarchy depth in struct Qdisc and update it when qdiscs are
grafted. Reject new child qdiscs once the parent is already at the maximum
allowed depth.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zijie Huang <milkory@outlook.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Link: https://patch.msgid.link/1e9ab39597423fd5d13cfaaf52279b8ee3d9fc3c.1785434373.git.milkory@outlook.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Dropped the `extack` argument from the `notify_and_destroy()` context line to match 5.15's 6-parameter version. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sch_generic.h | 1 +
 net/sched/sch_api.c       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index dd6203f3f0a5e..42238e7accb36 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -93,6 +93,7 @@ struct Qdisc {
 	struct hlist_node       hash;
 	u32			handle;
 	u32			parent;
+	int			depth;
 
 	struct netdev_queue	*dev_queue;
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index c9f7e793a375b..a962fe61c3494 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1031,6 +1031,9 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		unsigned int i, num_q, ingress;
 		struct netdev_queue *dev_queue;
 
+		if (new)
+			new->depth = 0;
+
 		ingress = 0;
 		num_q = dev->num_tx_queues;
 		if ((q && q->flags & TCQ_F_INGRESS) ||
@@ -1110,9 +1113,15 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 			NL_SET_ERR_MSG(extack, "STAB not supported on a non root");
 			return -EINVAL;
 		}
+		if (new && parent->depth >= 7) {
+			NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
+			return -E2BIG;
+		}
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
+		if (new)
+			new->depth = parent->depth + 1;
 		notify_and_destroy(net, skb, n, classid, old, new);
 	}
 	return 0;
-- 
2.53.0

