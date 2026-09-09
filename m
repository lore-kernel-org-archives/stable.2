Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69ED388E72
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976325; cv=none; b=Vy+w80yT6MnBj6QWmsU9dolBiIpuJB3Gt4xuhLmIZa+42qC/bngIDDmyGqvAadWcnENUGvwrU/xgB2nD18oGMWZ7a8QqGWludU/+iFj4CMhUIAzXQiWdxz3GaY7+0q11vOADKfHJRfV21DYHVNN3Ap4SxbW1WlNdzLFmuDzk/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976325; c=relaxed/simple;
	bh=EOFHUfyfkCwHTcSPzybx1ohFPO//f1I6FJgQq8USGsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWk2kRF5+NTvj2CmP9xk9wX3bWiet6+5n1MD5ZPF+f77njtXaY7/eHt1DviqvVFcRpoKQqRTn7p8VH5Z7QzLz78qNVam1HBS4JbiKeBTdF1w7EWSRAcyEqqtaNlzKSEtx3VMGHSxBKVaPisMFh0oylQ15YTByaU0gWk343mTPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+G+fUiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+G+fUiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C031F000FF;
	Wed,  9 Sep 2026 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976323;
	bh=KS0Sp0rAJc0pjfjIOSaviZI3ZCCh9eHn6NqnAGgzjGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G+G+fUiDaZa9Qgg1ZtdYGiy9jP0efcb/Kep4ZvzZlH05W3CjhZsGdnoWHamr0+dJp
	 OMDBAinOpF0n+3aLsc2mpUInbLk22vAISYDKz2oNK9JRN6V/goGDAWiu6HVZ/Rxc8e
	 R8r9qUsDejiqHZbzKs7ovqKpQCMMAZaDw2zGZ8vLpCGICiFy5ZMMH13kD0uDcmW6eW
	 Qg/pRhVfFzbVw7VRj6vM67XKlYkPJ1EpUiwGh1aVhuX2Vu9w6108aW7lPZO7oyYlGn
	 SLCGLpR50X8WCjQU8OsE3hTa1phLkY9S3zP7IzsiULsHxSei1hy/UQVMn9xGRiryUH
	 cGAlCq9bAF61Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: annotate accesses to queue->trans_start
Date: Wed,  9 Sep 2026 13:52:00 -0400
Message-ID: <20260909175201.3360823-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-dealmaker-grope-80e1@gregkh>
References: <2026090352-dealmaker-grope-80e1@gregkh>
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
index 565970cca295b..f0036693df9e6 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1175,7 +1175,7 @@ static void transition_one_qdisc(struct net_device *dev,
 
 	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
 	if (need_watchdog_p) {
-		dev_queue->trans_start = 0;
+		WRITE_ONCE(dev_queue->trans_start, 0);
 		*need_watchdog_p = 1;
 	}
 }
-- 
2.53.0

