Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BDE2FE07D;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454450; cv=none; b=QUmNcYpQnZOzqnJNS38F1l/Cp+mHnajgc60ou7NZ+IxYOpnaXiEEsbV0KazKUCvYViCjcKNDyzVzsQTgMtDn9PmZ84d6gWWhaqmHgVScyEZU863beQ3g6fZKHlPz6c5jZdojRgjO+AMn0QliRBCbB56GA20woEqImIZlnqYt8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454450; c=relaxed/simple;
	bh=x0QVTAuyZXdCFI0IrcJgKleock7QYH2FQYSmN4duDaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pciHZkobJLrYmlj3azTshBEvZBv5e53tON1Y5I8D82vjcDRf1TQDBUGTKrn0POXmldaeKVRAs4aWNirTAlTrxkaXx72c1GXjBTWFvLVfwZhmGI1bmsCE6Zcv1cFDJCI8wPz4eTlyIcnixfzF5fp/OaePtSpxilUqIbfmJJlIjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YATrYzd/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YATrYzd/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B177AC2BCFB;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786454449;
	bh=x0QVTAuyZXdCFI0IrcJgKleock7QYH2FQYSmN4duDaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YATrYzd/Gv/HGa5OUAJT0BBqVXEQQOQCF0xIYDzJT5M7mp/77Hz6utpsuHEm02FxT
	 qRf0eT9QhaBb5ZBTepbgWsIqwDvxvvUpHTJzQQIMPZgME0QHD8FxmAZY+EgxDuYiIh
	 cPJng4LXzg4yhrXQS58KlMAQmMO54ruUI6uicmN6Ppb7F3+WxaowQVDWpy1gsN3YQF
	 v9EDjtzwX9fCeHTv1kcvoaNa8x72XkKZPevJbvWid6noUIrFzbtRJn9Bxs+KJVtNlZ
	 ZTnQTG6ZjyZP8r9bFen3rhAKr0vKB+MMftnnAf4kl0Zxjb+qNm2Kgk2FIeZm5zXaig
	 F4xgLBg9Ad15A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920E8C5CFCF;
	Tue, 11 Aug 2026 13:20:49 +0000 (UTC)
From: Fan Ye via B4 Relay <devnull+fy15309206903.gmail.com@kernel.org>
Date: Tue, 11 Aug 2026 13:20:50 +0000
Subject: [PATCH net v3 2/2] net: thunderbolt: Mark the connection down when
 bringing it up fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-tbnet-hopid-v3-2-9e75d1b51331@gmail.com>
References: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>
In-Reply-To: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Fan Ye <fy15309206903@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786454448; l=3299;
 i=fy15309206903@gmail.com; s=tbnet3; h=from:subject:message-id;
 bh=0miinm3Lz7SrDSraGcm3AN0xUICy4Dr9QKAchgduLqg=;
 b=/7kr+0KvEhCWRnFPp9/jB33xrwyfZEf2+An1qw670rYQ63BiYj5manbygnKMTh6wx7b8/ul5t
 YzCqbsnWavOBpAUNaQ7WJ4DGro8GDQcMn7yk66aRqFoEJxxHLGN/yJ8
X-Developer-Key: i=fy15309206903@gmail.com; a=ed25519;
 pk=6QsQIrI/kruYWIJyCH9ntPMXsHCqF5JtK/DCMtOCzdc=
X-Endpoint-Received: by B4 Relay for fy15309206903@gmail.com/tbnet3 with
 auth_id=929
X-Original-From: Fan Ye <fy15309206903@gmail.com>
Reply-To: fy15309206903@gmail.com

From: Fan Ye <fy15309206903@gmail.com>

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
Assisted-by: Claude:claude-opus-5
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Two ASMedia ASM4242 hosts, interface cycled down and up, cold boot, only
thunderbolt-net differing between the runs. Unpatched, every mismatch is
followed in the same second by exactly two "ring already stopped"
warnings - host A 11 and 22, host B 12 and 24. Patched, 9 and 13
mismatches produce none.

Applies on top of patch 1/2, which adds the lines this one edits.

v3:
- Rewrote the commit message; dropped the quoted logs.
- Cut the comment in tbnet_connect_failed() to one line.

v2: https://lore.kernel.org/netdev/20260810-b4-tbnet-hopid-v2-0-0eee557e75df@gmail.com/
---
 drivers/net/thunderbolt/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index e5199a87ea7a..2a1728621887 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -626,6 +626,14 @@ static int tbnet_alloc_tx_buffers(struct tbnet *net)
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
@@ -649,6 +657,7 @@ static void tbnet_connected_work(struct work_struct *work)
 		netdev_err(net->dev, "failed to allocate Rx HopID\n");
 		if (ret >= 0)
 			tb_xdomain_release_in_hopid(net->xd, ret);
+		tbnet_connect_failed(net);
 		return;
 	}
 
@@ -693,6 +702,7 @@ static void tbnet_connected_work(struct work_struct *work)
 	tb_ring_stop(net->rx_ring.ring);
 	tb_ring_stop(net->tx_ring.ring);
 	tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
+	tbnet_connect_failed(net);
 }
 
 static void tbnet_login_work(struct work_struct *work)

-- 
2.43.0


