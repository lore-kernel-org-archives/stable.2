Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A537757D
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331145; cv=none; b=c8aFKzXmKu1tLSSVohi4fEyQJqEFb0rrX2IGWED6GlXMNR8uehhDQhKBu1gFDNe/JJwxiJlA+WP87PhJKH1v9Fda/ibsp8Mhh3BrV7vCOrc0+oKtR8lvSFb8BgiVnAf3r0C5oF/oHMIZOZOV6gcavJFMTqEedTFxAVAFg2XO41E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331145; c=relaxed/simple;
	bh=2iDpSVyZ/HKdM2XBlBDm6cScDhlMnZ7mZqXRQinwwJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3Rw86vFU+3NojzX3cE8p16jjJd7k4dxZKioeUygZ0PlC6ouT+/0sk0/OzCoqHvb9ZRNCrgdAsTRlE7N1aVBlWdWnvHWIwS/HvSjkxySzpeA2sVPfd8s0h6WOlr2tPnb8saLvHSjba7wVsNJaQ7XQZ8w4/+oKLbo1CC6VeFMH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anASQnSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anASQnSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225B21F01561;
	Fri, 21 Aug 2026 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331143;
	bh=5fLZBtvyECqxVkiHtU3fpa5gecht92C6aSpecag711s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=anASQnSSg1SBm5G3Wcgd7/YdMjWB0rmSk3mgrxmCiaZmv7seZi4XYPYLVi9h/NtfF
	 /BKRkRHUuvt3QkK1RPLLty1iuyWaQDUZKBTuijlk3+lFvHq88DoBD7Yu27I7p7XbvT
	 UV8lY627e13RDV1W7KXBDD3+QM5f5UP7AV5Kf6FiK44edAs7p4/AjrH/KfNEhN5Nqf
	 6ZiXU2xvy9YGQ+sxDcs+P8C3rs9/6dGfnbdRE4S2dwezVqaf18uAxEeAAETTJcRIyh
	 34WVfCZZ921d52afD3gaxitABbnk8/YJfIVR1fD0ehy/AJUH83J8tt1fF/XzleOtnQ
	 R/j8Kv5617lHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zijie Huang <milkory@outlook.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/sched: reject overly deep qdisc hierarchies
Date: Fri, 21 Aug 2026 12:52:21 -0400
Message-ID: <20260821165221.3595405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081713-handiwork-idealness-deb8@gregkh>
References: <2026081713-handiwork-idealness-deb8@gregkh>
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
index a4c670ad8c4ac..b46a70602da44 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -86,6 +86,7 @@ struct Qdisc {
 	struct hlist_node       hash;
 	u32			handle;
 	u32			parent;
+	int			depth;
 
 	struct netdev_queue	*dev_queue;
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 932c98b5b347e..9c90b54e46300 100644
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

