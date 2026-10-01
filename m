Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1651AFD6
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864729; cv=none; b=F14jUqYRRUuajGvNAoPdoUrRn3tCYj+5hPB/4plQ3VXH14xpkXzFZNVPrTjCq0EOycUzxGBeX3Xn4QxuulYR++qLAIzWE4yV4Arxg3rv5Hp0OaXI8u7Hf3+buhApVvGV1CmFU3N3J8ReHB0oHatNh0MTaiJTvbezZekivpheR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864729; c=relaxed/simple;
	bh=nAXCB2HbY7Mf+wmDfZkiXREuGwS2H6D9YJ4ox3hdyYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SasbmAExDK5VM6btyQjFzmGa9QIkF6iPdNW0C0bactrkK0s+7FkFnBbvbBY6GbEUWZEUNq5wpQMnycuw6vqDPX8XYJVNyPFOkwOBS6aMGLlNoqcoRwWUPyETpPsIpqV4FddZkm1WPJK/Iaz1UoZzKi3KNogkEiOAhDrqWtOyLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXECmK3k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXECmK3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790864726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+RQauoITMstIPGsYZHrV59o4U7Nh5j8XAKzdsfn+Yig=;
	b=PXECmK3khYnAAIYL7LQm3a4ptt01U1uXXjDVfNS5W5CzThrXw6bOu652SNj7O6HnjLmfCY
	n0otvT0AOyhkDbpd4JHUbwFboeWssTIU30aNBtynnLxkNexz8GNNfRDKTe21BQKadTAkyk
	ayi5MwdiIftRYfDJecRUHACk9fweXcE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-9m2QvmfuMBeug2vV4AyS8A-1; Thu,
 01 Oct 2026 10:25:23 -0400
X-MC-Unique: 9m2QvmfuMBeug2vV4AyS8A-1
X-Mimecast-MFC-AGG-ID: 9m2QvmfuMBeug2vV4AyS8A_1790864721
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8513B18007FD;
	Thu,  1 Oct 2026 14:25:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B16B30000E4;
	Thu,  1 Oct 2026 14:25:18 +0000 (UTC)
From: Vaibhav Nagare <vnagare@redhat.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nagarevaibhav@gmail.com,
	Vaibhav Nagare <vnagare@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] bnxt_en: don't leave an XDP program installed when the open fails
Date: Thu,  1 Oct 2026 19:55:16 +0530
Message-ID: <20261001142516.1386525-1-vnagare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Restore the previous program and its ring and feature configuration
when an attach or a replace fails, and release the old program only
once the change has been committed.  The configuration matters because
bnxt_init_one_rx_ring() only assigns rxr->xdp_prog in page mode, and
__bnxt_set_rx_skb_mode() derives dev->max_mtu from the installed
program.

A detach is not undone: dev_xdp_detach_link() releases the core's
reference whether or not the driver returns an error, so putting the
program back would leak it and leave the driver running a program the
core has already detached.

Fixes: c6d30e8391b8 ("bnxt_en: Add basic XDP support.")
Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
  v3:
   - don't undo a detach when the reopen fails.  dev_xdp_detach_link()
     releases the core's reference whether or not the driver returns an
     error, so restoring the program leaked it and left the driver running
     a program the core had already detached (Sashiko AI review)
   - v2: https://lore.kernel.org/netdev/20260930070901.1218980-1-vnagare@redhat.com/
   - v1: https://lore.kernel.org/netdev/20260928131458.1012180-1-vnagare@redhat.com/

 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 49 +++++++++++++------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 9e5009be8e98..430272fc0594 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -381,11 +381,31 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 	return nxmit;
 }
 
+static void bnxt_xdp_apply_cfg(struct bnxt *bp, int tx_xdp)
+{
+	struct net_device *dev = bp->dev;
+	int tc = bp->num_tc ? : 1;
+
+	if (bp->xdp_prog) {
+		bnxt_set_rx_skb_mode(bp, true);
+		xdp_features_set_redirect_target_locked(dev, true);
+	} else {
+		xdp_features_clear_redirect_target_locked(dev);
+		bnxt_set_rx_skb_mode(bp, false);
+	}
+	bp->tx_nr_rings_xdp = tx_xdp;
+	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
+	bnxt_set_cp_rings(bp, true);
+	bnxt_set_tpa_flags(bp);
+	bnxt_set_ring_params(bp);
+}
+
 static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 {
 	struct net_device *dev = bp->dev;
 	int tx_xdp = 0, rc, tc;
 	struct bpf_prog *old;
+	int old_tx_xdp;
 
 	netdev_assert_locked(dev);
 
@@ -418,25 +438,22 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	if (netif_running(dev))
 		bnxt_close_nic(bp, true, false);
 
+	old_tx_xdp = bp->tx_nr_rings_xdp;
 	old = xchg(&bp->xdp_prog, prog);
-	if (old)
-		bpf_prog_put(old);
-
-	if (prog) {
-		bnxt_set_rx_skb_mode(bp, true);
-		xdp_features_set_redirect_target_locked(dev, true);
-	} else {
-		xdp_features_clear_redirect_target_locked(dev);
-		bnxt_set_rx_skb_mode(bp, false);
+	bnxt_xdp_apply_cfg(bp, tx_xdp);
+
+	if (netif_running(dev)) {
+		rc = bnxt_open_nic(bp, true, false);
+		/* dev_xdp_detach_link() drops the ref even if we fail */
+		if (rc && prog) {
+			WRITE_ONCE(bp->xdp_prog, old);
+			bnxt_xdp_apply_cfg(bp, old_tx_xdp);
+			return rc;
+		}
 	}
-	bp->tx_nr_rings_xdp = tx_xdp;
-	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc + tx_xdp;
-	bnxt_set_cp_rings(bp, true);
-	bnxt_set_tpa_flags(bp);
-	bnxt_set_ring_params(bp);
 
-	if (netif_running(dev))
-		return bnxt_open_nic(bp, true, false);
+	if (old)
+		bpf_prog_put(old);
 
 	return 0;
 }
-- 
2.55.0

