Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352191;
	b=Dpn2hBAFuIbMGTOPS67ccBVAT9x8xC/rJHFxrIBeEN6CkYqu5laRXBmq5u62Lb85o2j2
	 8AEJFQb4SnuUcqs8njrmLnJSj09h5oCOi5WXDElgrbXL8eyQs98ksxoV1bfTrt4SW47/i
	 AWMz185C2TJTxlIDrXIJfyYgukNo6O9Svv8mCF66E2GN3MqCG6TybXfpVVvgQeHp5XfsN
	 1iqu9M+gcmkezawfxaUp+gnmKOHWjc/kzwZSGgrkcuZhpJ+7eT+CcV27MbqgW/H8fOqqi
	 hOcU1DNQrljhyO5MAkzGJqaQiV3m4UCCxhRDi0/JldtGcJaq0DUIxFruvATCsbESYPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7mM8VHV+bG5sDNg6J95scA221xoGBaOocX33cUbEIdU=;
	b=oCbiWh/4bVqBIGf6ILglOvI4TOAlheE76kTKeTFzHhgHiLJ8Ouvu+WMx25KNttynZY4t
	 b+Ks/aW+EsittDVzoqnLmraHF0I8VZXzmQ5rXeJG6ayXBY0ALGMlzIIrC/VMPBs3BsGDn
	 W7gRrAgkNWPi2wL3ZQNBM1SKKNd01SbQx514jV98ImhNlvjg/TfoHh6weVBwCkal0tDtT
	 KXvweCSpNDLWC2oDiRYzbKeNtWgtMhP1u9/aLVs/os/H8Fa6GUCvAb5kIPUwZ2229lZuc
	 kWUvs4UFKFfKyqd/n5hBhvLH3MVs+R7KliqgMsatPLUBpIiiCwGfVTfHY1OWeeAzJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2tCkCgb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E26606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2tCkCgb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFAE1F0093C;
	Tue, 10 Nov 2026 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352191;
	bh=7mM8VHV+bG5sDNg6J95scA221xoGBaOocX33cUbEIdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D2tCkCgbjt6y82jGApbYP8h3kvrPMIP+qbAxnrA3i9kLFJqv8Uv1BgaNdxrc9uVV/
	 um7ed8aAIXg8F3FtEWkHgA1DATPPZVCWCyYBpGy3gbW+Psbwt3ot3mjLCzJrbAzY2I
	 UAiEJoqduYAyvTxT1iTH9YIjGdmjttAyRU63BPuaH7EFAjxIjM1ktlMAgbnfriO0FB
	 CPoWFTI55rUjtbJkCFijs3sG6xV0yJiA/O2mTaP2vEiMnPZ/ouCqXXaUdGU120cncH
	 JGZr221Q5gUcAL2zLZHyPG/8GldRTmY9coTggxi4PlOCxkpHB+1e22horonesu97lZ
	 a1+xditgJkaTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vaibhav Nagare <vnagare@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] bnxt_en: don't leave an XDP program installed when the open fails
Date: Tue, 10 Nov 2026 18:09:48 -0500
Message-ID: <20261110230910.73730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055108-failed-6.1-78731b46967e@kernel.org>
References: <20261107055108-failed-6.1-78731b46967e@kernel.org>
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
[ sashal: replaced the bnxt_xdp_apply_cfg() helper with an apply_cfg label to reuse the existing inline configuration ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 0d787e105b6ae..635f3e46305f6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -390,6 +390,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	struct net_device *dev = bp->dev;
 	int tx_xdp = 0, rc, tc;
 	struct bpf_prog *old;
+	int old_tx_xdp;
 
 	if (prog && !prog->aux->xdp_has_frags &&
 	    bp->dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
@@ -416,11 +417,12 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	if (netif_running(dev))
 		bnxt_close_nic(bp, true, false);
 
+	old_tx_xdp = bp->tx_nr_rings_xdp;
 	old = xchg(&bp->xdp_prog, prog);
-	if (old)
-		bpf_prog_put(old);
 
-	if (prog) {
+apply_cfg:
+	tc = netdev_get_num_tc(dev) ? : 1;
+	if (bp->xdp_prog) {
 		bnxt_set_rx_skb_mode(bp, true);
 	} else {
 		bnxt_set_rx_skb_mode(bp, false);
@@ -431,8 +433,21 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	bnxt_set_tpa_flags(bp);
 	bnxt_set_ring_params(bp);
 
-	if (netif_running(dev))
-		return bnxt_open_nic(bp, true, false);
+	if (rc)
+		return rc;
+
+	if (netif_running(dev)) {
+		rc = bnxt_open_nic(bp, true, false);
+		/* a detach cannot be undone, only an attach */
+		if (rc && prog) {
+			WRITE_ONCE(bp->xdp_prog, old);
+			tx_xdp = old_tx_xdp;
+			goto apply_cfg;
+		}
+	}
+
+	if (old)
+		bpf_prog_put(old);
 
 	return 0;
 }
-- 
2.53.0

