Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538740;
	b=07prPJDoTh6nAy4pGlpEVyLpBN/3aRK2gVZ+wgV2jnUO6EILJ5usU8LXNAn1GLcuf5yj
	 PbstfBfXyDdj/MynaFXTfuzgGGXM1GdWj2j0iep/xKs/WgAZnfVXBZihkLllQZfaJ6Oly
	 NFnYbbr8IS96vhMAlQ+GRyO16Iy0arie+oKGLmMXs3leFkYA1wJanLyM+v80x548s0TlO
	 GR4PGku6m/Gdq/Ir1DUi9sphjt2mDIv11ubsIfy309GlMXS04FO9vjUwE65IZ7QsKPXTz
	 Z39fKohVQpGUoNq/ZG/ZCUiZaqQKJgRtjxvZKlGhWVGk+70nWN6n08au16co6VaqR1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538740;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XzT2Go3eqUUnXjs7kAT1XsoxXEeM5nz0Og1UBfw8u6s=;
	b=qUu7Qhs3q/c/S3IYZGIoP5rjz73PLQ4IOQCu1ZST5ytPoHnNcjjuhgAH3p/iB3Ip3G+B
	 GWHittgVhiiKZsVP++6/WJi/mfM1XP5wUVVn82f5l5DAA9R4vVJE8FQEzLlL8w7AIpTMk
	 meaE10afUC4IxxLJ03w8F9fkd09g6Zwk4jWtinIk8nH0EmdLobJgBpkTeR35xuXPtGPhQ
	 a2yck5YiCZvm6c8kOB91Ya1YtOvlQTr3cgnplGz34Jo01AZ66iO0UVdsIhPsII8F93F+J
	 PlwTclDqwSTXXmrGW4bvnDa32UeiVlX07xnXb8DdcozYnRLiRrfd8yc8M5HaHB9i/wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a54hSiI5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F5606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a54hSiI5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC18E1F000C0;
	Tue, 24 Nov 2026 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795538740;
	bh=XzT2Go3eqUUnXjs7kAT1XsoxXEeM5nz0Og1UBfw8u6s=;
	h=Subject:To:Cc:From:Date;
	b=a54hSiI5b3qHPgmYwobzPJTL42ubE7qqy6Uihy+nh3mmjVuCy+Ew+u37/GrdfL0ju
	 hV3t0bXUgStPnxsot4V22FQnxHchHyR6M8Jmovwl5VPFzQwNfmFyiyWpQAsIAuk+2W
	 3jLzBNHP0XaF6bIHbE+IhpaAItPCQD93+NsORTVw=
Subject: FAILED: patch "[PATCH] net/mlx5e: Fix queue stats access to queues without stats" failed to apply to 6.12-stable tree
To: leitao@debian.org,kuba@kernel.org,tariqt@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 17:46:01 +0100
Message-ID: <2026112401-catnip-barn-1ab6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9a24799e219b1699bb1c144248c8c500b9504db5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112401-catnip-barn-1ab6@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a24799e219b1699bb1c144248c8c500b9504db5 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Wed, 4 Nov 2026 09:04:11 -0800
Subject: [PATCH] net/mlx5e: Fix queue stats access to queues without stats

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

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c3c2c5720c6f..72bca10c579d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5489,7 +5489,7 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	struct mlx5e_rq_stats *xskrq_stats;
 	struct mlx5e_rq_stats *rq_stats;
 
-	if (mlx5e_is_uplink_rep(priv) || !mlx5e_stats_nch_read(priv))
+	if (mlx5e_is_uplink_rep(priv) || i >= mlx5e_stats_nch_read(priv))
 		return;
 
 	channel_stats = priv->channel_stats[i];
@@ -5521,6 +5521,9 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	 * inactive sqs.
 	 */
 	sq_stats = priv->txq2sq_stats[i];
+	if (!sq_stats)
+		return;
+
 	stats->packets = sq_stats->packets;
 	stats->bytes = sq_stats->bytes;
 

