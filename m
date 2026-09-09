Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1533F59C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976469; cv=none; b=FGjhtPEdPjdYZ/ZWte6SiQ71igov53jEGIQG56G77b4rpCeRLJh/OArqLC+JbKpS95c8D8wkc3g1DDwTM0THfBCV1HIdf/EC22FAutfqpHui8+4azdjgSTldBItTLeAOmC6XfAbMFhKDRAmqmCVUdSlTg/DmD/+j4yuRsZA1NQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976469; c=relaxed/simple;
	bh=fpDvMGAskk5fELv2R6xQI3JMhjey3xOq1XWF0h66gE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0sxkfVu56xk5AgXmcBH5LqJr0QTmKX2I5D9F+o4LB/bgnLYFvhbU5/8hXEZh8jQskixnyXPfeLCsmXCXUdr5jAujumV9w+4C5Fu+Qljnu4px3MtxlQpSRfTBHEnUQ91s/ZZ34Zo3CYA7WK9cMprWIJgxMd0aVrhQhr4Tly21lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2ZPGTMG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2ZPGTMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558181F000FF;
	Wed,  9 Sep 2026 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976467;
	bh=+YHOhBpyzqlITRGUCBz3gvXIY9IZ0XqcPdS7GjjJ78g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2ZPGTMGeeaPbXXKkYwHPGWS4kHcR/Oa1ypNjmk7CBINlBgLhv2AxWvxpT4lO8Qtf
	 cI7FUjqaU3kOdlRwWnCmA2dvt+f38XME0K1k/HQdYL0ktoKTNxG61KJ3DC413gIvMu
	 o3Uood0+ejZjRHn/YaasJszESgRYdOtWCe/myIpdBtBXda1Fj0I2t+eKnURQBUYVw3
	 4f94xiqUFbPyUueGANQijhONnrv8Ypr96dT+AUYVbNqANOXfEvP8MRCuOtqb2/INsW
	 qrRG8LZzl48hQTptJsGGg970Cewfz4Q0XgJLVnacd1CcG2JH+HUiBcjwZCU8Yw4aOp
	 B8iC0EnWA67QA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net: annotate accesses to queue->trans_start
Date: Wed,  9 Sep 2026 13:54:24 -0400
Message-ID: <20260909175425.3373482-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-stinking-autism-dd92@gregkh>
References: <2026090352-stinking-autism-dd92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5337824f4dc4bb26f38fbbba4ffb425a92803f15 ]

In following patches, dev_watchdog() will no longer stop all queues.
It will read queue->trans_start locklessly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Backport to 5.15: retain only the transition_one_qdisc() annotation
needed by 82aeed2400786bd3f79d88cb8b8f42e6127e5923 ("net: fix spurious TX
timeout after dev_activate()"). This preserves the zero timestamp while
providing the WRITE_ONCE() context that the target changes to jiffies.

Drop the virtio hunk because this tree has no virtnet_tx_timeout(). Drop
the other annotations and helper conversion because they are unrelated
to the target; no new functions are introduced. The 5.15 watchdog still
holds the transmit locks, so the broader lockless-access preparation is
not required for this dependency.

[ sashal: Reduced backport -- upstream 5337824f4dc4b touches 14 file(s), this
  backport carries 1. Not backported here:
  drivers/net/ethernet/apm/xgene/xgene_enet_main.c
  drivers/net/ethernet/atheros/ag71xx.c
  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
  drivers/net/ethernet/ibm/ibmvnic.c
  drivers/net/ethernet/intel/igb/igb_main.c
  drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
  ... and 5 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 82aeed240078 ("net: fix spurious TX timeout after dev_activate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 243a1d6b349c7..d55b010285739 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1149,7 +1149,7 @@ static void transition_one_qdisc(struct net_device *dev,
 
 	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
 	if (need_watchdog_p) {
-		dev_queue->trans_start = 0;
+		WRITE_ONCE(dev_queue->trans_start, 0);
 		*need_watchdog_p = 1;
 	}
 }
-- 
2.53.0

