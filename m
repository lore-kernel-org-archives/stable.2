Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352583;
	b=TM4EX2DrTdpDNiF0eZoah5IMAgs9SKkESoZTX/uFktT/JVXqJRhiEHDueJT7d+2+zinT
	 oIlqCKOhemZKggix9qmrwrjv1qe/5pyCcEGrZz0Y44WGTOBwXbn/d1AaR6bqm2bqDqF8j
	 KVAjpmI1s7q8pKJ1aoNZYygpgIDleoyK45pbYk51AOWxaVASywS6kPhuTJr+sE2cDw07D
	 nesOaiCSKCv+Z1l/FBKyRpKqXXB0hgSc7MvkPRDftPCgcRgMhKEeFMX0q91aNNDr3buSC
	 bwF+fY2OpC8vYxc7k/PfM/qbX5j+tVAHq15Ynej15Mr19kocx6jEi/mh1gG9XoY04Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352583;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dv/X3zChxmEdVfDcOE97c4jF8yJh4gyMuARlIcgLQbw=;
	b=CMlCpPfPJvEA9u6LF6pIMI69lnXyW9lNufe3e4HR4uMlvyi4DRUZQ3tI2MTfWD5vCUCD
	 jQgg4LQ+29DHAyaGCrguNU2tLPRP0HhM6kVhWjbtVJAZfOHUdF+IUKsdl00q7mUx4uRuz
	 QwBatUlRm3diEaNCNWoURAr2Kuh46hJYcpCOiwTsdMKFL1MHNdJjyXc6h+Rve91xIBvaT
	 5ct+srPBAPI/SyjVEC/5P45Oe/jFXkxwHYGr/QPmpJR1iWtBIYJrbaW5Njmztd9F464IK
	 iDu+FbbN2KxyAa461JgRXAbMhVwYA6diAaxhj5pAKEwU2kc6rwgUMvnIx8yR8NJlJ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuPWzVam;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577A606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuPWzVam
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837F91F0093D;
	Tue, 10 Nov 2026 23:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352583;
	bh=Dv/X3zChxmEdVfDcOE97c4jF8yJh4gyMuARlIcgLQbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EuPWzVamN31InI3plei7yhT6FKk83nOiZ8LXeigITZ1tUhfFHq4tHw0KUM4A2rcCP
	 aSUikPI6sLu5sQl7YnA+nvcrHCIgwY/eGZVE1WOu/PpV32Kqt6J6uONAw8wUP/k7AQ
	 I8sF1vFkBULwZx2v+K/JKHmPhUwwbcwzzc+DbzOF7snMMDsjt4w5rT7jrzpjpF8k7e
	 7vfdzCbUHxPPFROW+aCqEY+JcKbY2PGctF8u1pHLrRDJq4FhfCqLyJk8shoK3ztxYT
	 Lhdkup3AfLJ5I6JzSN5RtIDguhzv35eX60rlO6pygjz3g7S2YwTZKISrermvvYbFWZ
	 KHZyR8Z4WFKmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vaibhav Nagare <vnagare@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] bnxt_en: don't leave an XDP program installed when the open fails
Date: Tue, 10 Nov 2026 18:16:21 -0500
Message-ID: <20261110231344.94430-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060824-failed-5.15-78731b46967e@kernel.org>
References: <20261107060824-failed-5.15-78731b46967e@kernel.org>
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
[ sashal: reused the existing configuration block via an apply_cfg label instead of adding bnxt_xdp_apply_cfg() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 8a5009e66a134..8c48c336afae5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -269,6 +269,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	struct net_device *dev = bp->dev;
 	int tx_xdp = 0, rc, tc;
 	struct bpf_prog *old;
+	int old_tx_xdp;
 
 	if (prog && bp->dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
 		netdev_warn(dev, "MTU %d larger than largest XDP supported MTU %d.\n",
@@ -294,11 +295,12 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
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
 		int rx, tx;
@@ -316,8 +318,21 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
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

