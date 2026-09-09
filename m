Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DF366DA3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974273; cv=none; b=OZL/8v+5gfO6kI4oi2O106j9tAN1PukLx1taFJ1YeKeXtwRe2hZxHCFV5kugLu+yWglwYMd04FLf7HTrQieATjw4jC9NTmk/NYOHPmmBBU1WtsCfh2FnqjnkEKma9W66bZEB/cMgTZlAEwQC3U6+AfyFg1ggaLKTMQWuT//+ESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974273; c=relaxed/simple;
	bh=2ox3X1saZ4dfcrV2ZUFX8dsGCIh6jc//Szjwbzu8xz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPk3q+k42SIXZDA9j/sqHUqgYi24JC26KwMhp0C4/EKtQgz+eF1ZpyjqmUEoh5GfedN6YB0FMf+68Qd1dH0v11VhzFqwnmXpM6W/SfE942diLRdalz6Fw9IwxmfxZoZD5nTghRt9qFSersfGj6ik3MVWQvmhqbxo2qWhvHonbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuc/BM2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuc/BM2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251DA1F0089C;
	Wed,  9 Sep 2026 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974271;
	bh=gT4Ab6C1D3j8Dqv3W2+TYF0XKn4AbqTW4VHNUyva0+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuc/BM2bjW7C2G0DcCIQbMBYLij6/cwm0zgUPMkLG8IM9YAimg7ISv1EdT4gT5mIs
	 ouI41N4ncwdJ8fzbGddNo82NU2XAUhlfGcDRYwbYpRYBV4OSc4MXsvm4VliGEpFBFI
	 wiQrxlt+ejoj0xcypT2AXd4rs3u1Pa0m96TZHwiHsC7iQr0S87wi5u6OTBaueYmThb
	 SIgUUJ9n7yQFDc9tRoPRSKtadZiaBHjx56gwl+jkLyuOWAq4mP3znl1OVIR8xMtn7s
	 Dp/mpthesiQYm1kTnaZ+tDJ6vZDHiZuAOI+/dTkrwDKoipaRQhToUTwVfjm13N6QfK
	 8uwtsw8DNrNDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Ye <fy15309206903@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net: thunderbolt: Mark the connection down when bringing it up fails
Date: Wed,  9 Sep 2026 13:17:47 -0400
Message-ID: <20260909171747.3248535-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171747.3248535-1-sashal@kernel.org>
References: <2026090358-language-antitrust-4e97@gregkh>
 <20260909171747.3248535-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ye <fy15309206903@gmail.com>

[ Upstream commit 3c8b26ebf525ba5960510f48c6e9936a79ebe76f ]

Every failure path in tbnet_connected_work() undoes its own work and
returns without clearing login_sent, so the connection still looks
established. The next tbnet_tear_down() therefore takes its main branch
and repeats a teardown that already happened: it stops rings that are
already stopped, which is a dev_WARN() and fatal under panic_on_warn,
and it releases net->remote_transmit_path even on the HopID mismatch
path, where this connection never owned that id, silently freeing one
that someone else is still using.

Clear login_sent on those paths. That is enough for tbnet_tear_down() to
leave the unwound state alone, and login_received has to stay set: it
records that the peer has logged in and carries the transmit path it gave
us, which nothing on this side can make the peer send again. Two things
change beyond keeping the teardown out of the way: the logout request in
that block is no longer sent, and the peer's next login request now
re-queues our login work rather than connected_work, giving the
connection a fresh login instead of a retry on stale state.

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Cc: <stable@vger.kernel.org> # 5.13+
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260811-b4-tbnet-hopid-v3-2-9e75d1b51331@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/thunderbolt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index f329e1d407eb2..badf419d8031b 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -606,6 +606,14 @@ static int tbnet_alloc_tx_buffers(struct tbnet *net)
 	return 0;
 }
 
+static void tbnet_connect_failed(struct tbnet *net)
+{
+	/* Leave login_received set: only the peer can make it true again. */
+	mutex_lock(&net->connection_lock);
+	net->login_sent = false;
+	mutex_unlock(&net->connection_lock);
+}
+
 static void tbnet_connected_work(struct work_struct *work)
 {
 	struct tbnet *net = container_of(work, typeof(*net), connected_work);
@@ -627,6 +635,7 @@ static void tbnet_connected_work(struct work_struct *work)
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
 		if (ret >= 0)
 			tb_xdomain_release_in_hopid(net->xd, ret);
+		tbnet_connect_failed(net);
 		return;
 	}
 
@@ -669,6 +678,7 @@ static void tbnet_connected_work(struct work_struct *work)
 	tb_ring_stop(net->rx_ring.ring);
 	tb_ring_stop(net->tx_ring.ring);
 	tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
+	tbnet_connect_failed(net);
 }
 
 static void tbnet_login_work(struct work_struct *work)
-- 
2.53.0

