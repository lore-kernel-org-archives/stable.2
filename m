Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350863;
	b=ckKJiL4NHHpMZAw1DOJhNIixEhqQ0wF14MM+b1FLEqr6CNR3aSlP5kiO6qMf/4bDDhWW
	 h8P0Fz/NhhOyMfgrpirAwTJswnCeWz556l/k8wdRm2zmD2jBgFxpOZO0O2Bh5O4h25hCk
	 CsT5FdytaXoUgjgqD/twtwtto20ooromvo4i/9utpbSpzd4OodUjtgscm0wBgMrLIxo7J
	 9uqPxhCCmG+iiWBmy8WJN0+VOORqoboEv4C1+2qPZvMiv0pnXFnVCZtMEVO4K1PzpGsDE
	 bvwfm5GNCquEqE/GVZCEg/H29bP8J3i6t2HN8/6CryDcBlLoaY+Ub+0rK8KZ8aBrmfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qJj/+8bgADY+BnIS0f9UJKb14WsnfjaAXmyzYxMb6zk=;
	b=VsO/NGuPE1cgozQkyeWq+3K4ejup67VjEj/pe4+i6K3Nds4gpUKQV5zRO1xw55ZtKrnx
	 S8gJGgeK5T5mJZ/VeCejyPJGtx5lM9UJnStfSnltXJVGULW4TLmpV01S7XmjZNU5V11IQ
	 AxdN7w1uW+4opd6egtQKmfTbTy9mYLBHtj2WrCMZsoO+fssWaHfBQs9hft35kjdgk3t3P
	 aGY3SujpAacVAMTtEzbRMFA2u9QV3z73+AaYeyJfPbe9FDymdxrys+3wOkumMw0N2Gbh6
	 yceHcUXhJ3U2TTKtxifRcnOb0ETdDIqVqjMmrrkpn31/nhQ1yKJCwOj9IWClgRgyQ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exJxqRT0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exJxqRT0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7221F0093C;
	Tue, 10 Nov 2026 22:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350863;
	bh=qJj/+8bgADY+BnIS0f9UJKb14WsnfjaAXmyzYxMb6zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exJxqRT0+ukx+Ihn3f6/xNrnMi2pLW3MWHk9OTaYGIICd2Kargvovd0PxcKWympCo
	 ixibrY9JOq5CWQ7kbp0WqNjsVniOt7SxhdX5I/V51PBiIypa+dmBpzIgtsOMhp/kgC
	 drGFjCyixjmSN+KKLIB5Oe/04ktsxL7VyrHW6IfFvbfve0dVhsEfVztZg5nw+29V5F
	 33tqn01jSZzbUZDot4sCiC3OBZPGbkaZLPHSIFcmdE/l77GWXIfwDa0eg/7g/OnDDD
	 4bNzSQf9CRfY/MD52OHLmfXLBfDlxBwwnXFVd2vB4iCIMCafkhnvYRMtpSA18eAoiK
	 /BdqQoehqYZKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vaibhav Nagare <vnagare@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] bnxt_en: don't leave an XDP program installed when the open fails
Date: Tue, 10 Nov 2026 17:47:41 -0500
Message-ID: <20261110224456.4061965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052358-failed-6.12-78731b46967e@kernel.org>
References: <20261107052358-failed-6.12-78731b46967e@kernel.org>
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

From: Vaibhav Nagare <vnagare@redhat.com>

[ Upstream commit 78731b46967e3e7102b5cd5062bef185f3404b5c ]

bnxt_xdp_set() stores the new program and drops the reference on the old
one before reopening the NIC.  If bnxt_open_nic() then fails, ndo_bpf()
returns an error with the new program still in bp->xdp_prog.  The caller
treats the error as "nothing was installed" and drops its own reference,
so bp->xdp_prog is left pointing at a freed program and the next XDP
update dereferences it:

  BUG: unable to handle page fault for address: ff78ecc80ddd1038
  RIP: 0010:__bpf_prog_put+0x5/0x80
  Call Trace:
   bnxt_xdp_set+0xad/0x1b0 [bnxt_en]
   dev_xdp_propagate+0x36/0xa0
   bond_xdp_set+0xeb/0x2d0 [bonding]
   dev_xdp_install+0x1b1/0x350
   bpf_xdp_link_update+0xc5/0x1b0
   link_update+0x104/0x1e0
   __sys_bpf+0x662/0xcf0

Seen on a 6.12 based kernel after bnxt_alloc_mem() failed an order-4
allocation on a fragmented host:

  bnxt_en 0000:a0:00.1 ens4f1np1: nic open fail (rc: fffffff4)
  bond1: (slave ens4f1np1): Error -12 calling ndo_bpf

Bonding is not required to hit this; a plain XDP attach on a bnxt
interface takes the same path.

Restore the previous program when an attach or a replace fails, and
recompute the page-mode and XDP TX ring configuration from it.  The
configuration matters because bnxt_init_one_rx_ring() only assigns
rxr->xdp_prog in page mode, and __bnxt_set_rx_skb_mode() derives
dev->max_mtu from the installed program.  Release the old program only
once the change has been committed.

A detach is not undone.  dev_xdp_detach_link() clears the core's record
of the program even when the driver returns an error, so putting the
program back would leave the driver running a program the core has
already dropped.  If the reopen fails during a detach, bnxt_xdp_set()
therefore returns 0 with the device closed; bnxt_open_nic() has already
logged the failure.

Found in a crash dump; the change was not tested on hardware.

Fixes: c6d30e8391b8 ("bnxt_en: Add basic XDP support.")
Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20261012072802.2153706-1-vnagare@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: adapted XDP configuration to existing redirect-target APIs and an inline completion-ring calculation under RTNL locking. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 54 ++++++++++++-------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 2c16348d3b8cb..fcdffdc3ffa8c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -380,12 +380,34 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 	return nxmit;
 }
 
+static void bnxt_xdp_apply_cfg(struct bnxt *bp, int tx_xdp)
+{
+	struct net_device *dev = bp->dev;
+	int tc = bp->num_tc ? : 1;
+	int tx_cp;
+
+	if (bp->xdp_prog) {
+		bnxt_set_rx_skb_mode(bp, true);
+		xdp_features_set_redirect_target(dev, true);
+	} else {
+		xdp_features_clear_redirect_target(dev);
+		bnxt_set_rx_skb_mode(bp, false);
+	}
+	bp->tx_nr_rings_xdp = tx_xdp;
+	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
+	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+	bp->cp_nr_rings = max_t(int, tx_cp, bp->rx_nr_rings);
+	bnxt_set_tpa_flags(bp);
+	bnxt_set_ring_params(bp);
+}
+
 /* Under rtnl_lock */
 static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 {
 	struct net_device *dev = bp->dev;
-	int tx_xdp = 0, tx_cp, rc, tc;
+	int tx_xdp = 0, rc, tc;
 	struct bpf_prog *old;
+	int old_tx_xdp;
 
 	if (prog && !prog->aux->xdp_has_frags &&
 	    bp->dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
@@ -412,26 +434,22 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	if (netif_running(dev))
 		bnxt_close_nic(bp, true, false);
 
+	old_tx_xdp = bp->tx_nr_rings_xdp;
 	old = xchg(&bp->xdp_prog, prog);
-	if (old)
-		bpf_prog_put(old);
-
-	if (prog) {
-		bnxt_set_rx_skb_mode(bp, true);
-		xdp_features_set_redirect_target(dev, true);
-	} else {
-		xdp_features_clear_redirect_target(dev);
-		bnxt_set_rx_skb_mode(bp, false);
+	bnxt_xdp_apply_cfg(bp, tx_xdp);
+
+	if (netif_running(dev)) {
+		rc = bnxt_open_nic(bp, true, false);
+		/* a detach cannot be undone, only an attach */
+		if (rc && prog) {
+			WRITE_ONCE(bp->xdp_prog, old);
+			bnxt_xdp_apply_cfg(bp, old_tx_xdp);
+			return rc;
+		}
 	}
-	bp->tx_nr_rings_xdp = tx_xdp;
-	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-	bp->cp_nr_rings = max_t(int, tx_cp, bp->rx_nr_rings);
-	bnxt_set_tpa_flags(bp);
-	bnxt_set_ring_params(bp);
 
-	if (netif_running(dev))
-		return bnxt_open_nic(bp, true, false);
+	if (old)
+		bpf_prog_put(old);
 
 	return 0;
 }
-- 
2.53.0

