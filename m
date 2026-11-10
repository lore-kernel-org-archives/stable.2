Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351746;
	b=3a3LcGoMZ8pmNb8JfYPgYAho6o9hrazImRzS0K65DTWV/X4o7DF+blIAy4Vj7NxvsDn4
	 XxglJ5i/v5M8SJSsBEIhibVj7Gbvw5eLB6m+Q/1bGajH+4yfmMEGK7Eh716I6BJO31ZLc
	 x3x0d5+I7qApQywUnTExBo/XadLwIcGUkOXca3peE73AjInSadc6pcygwC7CCwXok4bam
	 YjW2jxvr/PyIbXVkYuyoifuwYD4VPqw5OyMTUWUCHJ36p4VQRn946L36znnwHSuA5V5mX
	 lkJiQ+4sVwCsNJZPimQLxGz6se8EmOpK+g39W0e+J5EIBNongrKebbaRNrtcEJtq8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351746;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5TnXLwguqGB+goPt83aK5soHBfmUuvqATa05d9dQsqw=;
	b=GesiOqF8ncLNhbS/aybpsY3WwhhKQAgdgqYxJXcCziDDfWcnrbOUKdi14TqWmSTBT3wp
	 LyJTRgAezFIa/+LtDJ3nIUkb6cBj9+FUnXm6uuW2B0po+Ei6sTq3NYvZcvd0XdciQVMLH
	 3GHtTL/Yd6k5uEKF6EbgDHCm31IkpbiC1JnvqDFJUJJsD9UfAJUAu6Ut9DFu2HL8Ts4Mv
	 iVy3WJwvbL6SIziAIuIc0JDQZkTx2oU+cuRFpK/GGzE7X9lRrXOOaMDMgnAPtoGxHCiXb
	 3AJw0eXfVVPbE3hwcBPrBA7cLpzS+/RdbWFIHRxy6BbVElgQyqGHYQs3I8KWt5Pu3pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Crj46YEW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Crj46YEW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C20C1F0093D;
	Tue, 10 Nov 2026 23:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351745;
	bh=5TnXLwguqGB+goPt83aK5soHBfmUuvqATa05d9dQsqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Crj46YEW3ZvutBfSoHG/Y1qcRIMB6PFYm6UPDaqyUAQ3QhK3Ly4/BMW7OEPQGTvis
	 qF62pL6TkoTYbMqtuu0U3ekgpRJQRnYjlvHr/9TZabxAJmHdpYXt0D0iZOvqpcMLl3
	 M1B3h5JCrRhVbSrZyfqTCTY/NMJ6tSbzRG0jYJMd4awZ1BcU5SKan5P/hMtecvdamx
	 Lx/ayaSCJU7q9kSt8YcLQmhMT7zv1V3ORUT7qAcJUVYe5t8BydfdBd9IW4t+Ft9HiN
	 82+I4y8GsNrHxYAMUeirtZqDWKRXZYZDyjc2/u60JM/YB53MN0AJReQhkglOuPEz0T
	 uSYCvsm+bd7qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vaibhav Nagare <vnagare@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] bnxt_en: don't leave an XDP program installed when the open fails
Date: Tue, 10 Nov 2026 18:02:23 -0500
Message-ID: <20261110230151.15382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053637-failed-6.6-78731b46967e@kernel.org>
References: <20261107053637-failed-6.6-78731b46967e@kernel.org>
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
[ sashal: replaced bnxt_xdp_apply_cfg() with an apply_cfg label inside bnxt_xdp_set() to reuse configuration without adding a function. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index fc47d45805b75..85a9ffcc4fe06 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -388,6 +388,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	struct net_device *dev = bp->dev;
 	int tx_xdp = 0, rc, tc;
 	struct bpf_prog *old;
+	int old_tx_xdp;
 
 	if (prog && !prog->aux->xdp_has_frags &&
 	    bp->dev->mtu > BNXT_MAX_PAGE_MODE_MTU) {
@@ -414,11 +415,12 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
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
 		xdp_features_set_redirect_target(dev, true);
 	} else {
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

