Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563961;
	b=Gtsg+Mkvnscz+sW2W1HcRohAsp8R+svd7dqz9bwQUrBvKqqKr68o3u/3LfUXlAFA6ga0
	 gvE9tRhbjfdNKBePgYm8eObVtGffoutDeo3sJCbLcg5NFxvVV3MoCrht9nlrBwGMe9cki
	 q3WIvjqYeKuQ8SqlBL02NQdJ+KQcUGJSLJ39wQLX/LVCtybtLtswR+Tnpf74tPyYvNYeg
	 mYveBIMT14XxCrEnrUf06utHaeeKc4g/WIysT6+/Gk9pi9S4b1Z3Is7Ux0y1/TtTJhnhy
	 CVuvU13Q3VBZsImTm5cgj//5k2h3/6E0L8ucaA14oRMwwrzv69eSkpa3JlR/DrVKHRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lkQSTzenxhGk82VaYANPLel+QWoFH5mdVxGin9J1VVg=;
	b=twTJjCY4eObE3aJSy8z6GZhmYkOs3yxv4VNqLmpsBmbe+5y4A6twKdrs6EUIXJlrYxqv
	 hk/v/C1ZDfaBbZ1vLMzvCgS7FQpFLmRvLYWmsDWoX+5+gm7N2fuO8RbgJcfvoUbOrAt0G
	 3GaAzF0xx0DXflAbxJmVgvZ99ScdIO0P4nytLDWtMFiNZDU00Enj0D/c1BFeg2jFRMT0i
	 hnCwzto7gbpp+PvUjOSnzqm/irvOaaJ80vinlEJt9lCP/OLELEaPO5HPU1ijDnCfDJQhC
	 QA7UC4+roMQ5VeFklgZW2x1WteXkaxrKw93lF95ZYZw99n6kTiqU40kr3d92k9PJYbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYawpTkY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE8606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYawpTkY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959141F000C0;
	Tue, 24 Nov 2026 23:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563961;
	bh=lkQSTzenxhGk82VaYANPLel+QWoFH5mdVxGin9J1VVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYawpTkY4YnMmCpsLiVZbHulIy7uhz6P9iY/x+yMyrVavC+2K0+CQ+tsQkrsg7hgm
	 vShS8mw0X20TRkgRvpZctHhg/pdI2zofTXQAGaYbF644hp4hKJ8tQLwEO+++Kl/uCf
	 XhDualSrVfXQ8Yo5hyLGcQLMxZKLhSa34SIU1GidQEeWBaW1cNcn98obirRhm4eyg+
	 pApgEPpHLqL0UJ1Cc7KzuI3cuywdM1ZJL7uzIBGrO9s4PIetkHHRe+3tGVCkSolmFn
	 6+Yoeck6pEIFml7Y9EYKe/S4pyQedgUUFsgaeLwRIGaYQLw8MPDYpw584RdVwaWvEi
	 zaUuWfQUzpP3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net/mlx5e: Fix queue stats access to queues without stats
Date: Tue, 24 Nov 2026 18:45:59 -0500
Message-ID: <20261124234547.3359830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112401-catnip-barn-1ab6@gregkh>
References: <2026112401-catnip-barn-1ab6@gregkh>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 9a24799e219b1699bb1c144248c8c500b9504db5 ]

I am seeing the following mlx5e crash in the Meta fleet:

  pc : mlx5e_get_queue_stats_rx+0x4c/0xc8
  Call trace:
   mlx5e_get_queue_stats_rx+0x4c/0xc8 (P)
   netdev_stat_queue_sum+0x78/0x480
   netdev_nl_qstats_get_dump_one+0xf0/0x268
   netdev_nl_qstats_get_dumpit+0x7c/0x1f8

When dumping device-wide qstats, the core calls the per-queue callbacks
for every queue below real_num_{rx,tx}_queues, regardless of whether the
netdev is up. Some of those queues have no stats behind them:

 - RX stats live in priv->channel_stats[], which only has entries for
   channels that have been opened (stats_nch). real_num_rx_queues can
   be larger, for example after the channel count is raised while the
   netdev is down, or after opening the channels failed part way.

 - TX stats are looked up in priv->txq2sq_stats[], which is NULL for
   SQs that were never activated and for HTB queues while the channels
   are closed.

In both cases the callback dereferences a NULL pointer. The dump needs
no privileges, so any user can trigger it.

Return early for RX queues at or above stats_nch and for TX queues
without SQ stats.

Fixes: 7b66ae536a78 ("net/mlx5e: Add per queue netdev-genl stats")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20261104-mlx5e-qstats-null-v1-1-a6a003245cec@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted the patch context for the existing ASSERT_RTNL() in the RX callback and the TX callback ending after packet and byte counters. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1f46eae73319d..d6152dac2432e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5291,7 +5291,7 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	struct mlx5e_rq_stats *rq_stats;
 
 	ASSERT_RTNL();
-	if (mlx5e_is_uplink_rep(priv) || !mlx5e_stats_nch_read(priv))
+	if (mlx5e_is_uplink_rep(priv) || i >= mlx5e_stats_nch_read(priv))
 		return;
 
 	channel_stats = priv->channel_stats[i];
@@ -5319,6 +5319,9 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	 * inactive sqs.
 	 */
 	sq_stats = priv->txq2sq_stats[i];
+	if (!sq_stats)
+		return;
+
 	stats->packets = sq_stats->packets;
 	stats->bytes = sq_stats->bytes;
 }
-- 
2.53.0

