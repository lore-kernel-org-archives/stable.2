Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047799;
	b=rTvy9Zm0rE6hPxpVon6BG3n6lBPIOAL6A8rgBCGH4Mp0Pp6NGhjFPcjzmHrBzmuVONZp
	 FaPH3Be5c3CTQuFA2pR9VI+DHf3U04Y5MeiODE4T221n/wUz0oFrURdBX7V9SyENfcCF/
	 ashcKLeUAwq7nMf6QovydlS697fPJbmVE3+//G3vU6uOIU1sEgAKZMpo1+zCfVC+ryFu6
	 KiYx8uU/k80T3uMk0Botq3RyB0ItAFkKV5LB3Q33Jmxmlnnl3E4jIs7FzEO6wz3Zgs97x
	 5J0Xy2IM1XuLVyBS6zYdUJaMSJtEEFKBsagi9Y2R3R+Zr9lifjJ0CjkkAIMfIW1WWng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6IqFER2Of5bZNJBB2WhctM7WHMxnc4xEJSyKdDQTT2o=;
	b=cehikcHuJKjYYBqCPn8bnc8KwG5eBHDu+vPXpgO4NZIL6kyg6Sk4O0zk4Pl48+6MNKwz
	 TVtZnuq422ynVVC7SsPHBSDtwi6z+E0o2UN2Zx67MRymrUsJA4WyHK5tZdbUeutNLFZCb
	 eTTeF0H0XLKq1JDRUHOkw/H/ZRcOB9M99soHB3dIQ2t5+l4v/AYnagBVwDlH03dc/GiZc
	 7MFeJxzdaO+0jlWWNTmLijsNW9WF+B1h2jak4oVAC0Eft73puvmvMXPuYW0G8rq7h8060
	 ZL5PZB02S7M1klZVjTs64LCn968JYdF9skxfmW7dl3dLN3i4BA/xY6vuVUKYUx/DDlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vzrkkasa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vzrkkasa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91C21F0089F;
	Sat,  7 Nov 2026 10:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047799;
	bh=6IqFER2Of5bZNJBB2WhctM7WHMxnc4xEJSyKdDQTT2o=;
	h=From:To:Cc:Subject:Date;
	b=VzrkkasaCSjTmRu9rhNPumALLDBh9oErRBfy4wAWS7zNhA0GiIvY0d7V/lzCyhkgi
	 57cFeoAOCUMJ+ATVY+a+gbjEKSEYeTGfbPPoA2OqcUwbPNRbJ9kicxvz/zPvq3aley
	 3UDeIwFzqxoTfuoU6IbGX+S7GEZUyM5+c1zWemBPqJ9/eR7MZ3mw4+H5MzFZF5pwxj
	 bQAIfuVKcp+FQb3Mm+EvLXx0U0pwFs7RlaFadjWgriRdkTe81EYdAsR6jJJXbo+TZI
	 teGAMAAT1vejYNhbA1uG9kl42L10DAQj5vQtuvXfqIhJrU3qbUqVWyLAhreadYE1jw
	 qwlncBOlDCpow==
From: Sasha Levin <sashal@kernel.org>
To: vnagare@redhat.com,
	horms@kernel.org,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] bnxt_en: don't leave an XDP program installed when the open fails" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:37 -0500
Message-ID: <20261107053637-failed-6.6-78731b46967e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 78731b46967e3e7102b5cd5062bef185f3404b5c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053637-failed-6.6-78731b46967e@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 78731b46967e3e7102b5cd5062bef185f3404b5c Mon Sep 17 00:00:00 2001
From: Vaibhav Nagare <vnagare@redhat.com>
Date: Mon, 12 Oct 2026 12:58:02 +0530
Subject: [PATCH] bnxt_en: don't leave an XDP program installed when the open
 fails

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
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 49 +++++++++++++------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 9e5009be8e989..96845c8646e06 100644
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
+		/* a detach cannot be undone, only an attach */
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
2.53.0




