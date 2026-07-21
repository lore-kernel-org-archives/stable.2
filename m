Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEC146588
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644873; cv=none; b=BgyBSIq9NrhuJ0AIPvGw64gEyiprfoefGZJIKobSDOEnDpdHTw5L9TzpqpQDbgzjtblTvf0oqO26ViLmVIzvLa7Zg3e2gRalEnNrMytUAERJnHhTBiIfLFhNG9LG08KosE208I+oLSdTHevQpL/Nu9+VRxjkrQ5zeysAXul2gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644873; c=relaxed/simple;
	bh=zv+pg/drn87aQlQW2C1G4XCW4fV2oM87oZahIILRgDI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qpEwPHRynJhRVIzLEu6Ds74zGWQKVRXbMvBTOgN1U35p6f52xWawDzB89cUTdiDG8dZFumH5w0fVVDhTNcDApkyrlDVyO/AJudMWnRmSW4yoN753CQ7x917SvZ8zGxyVWGa62lbrbO80U41c68IH2STQgptZF/Zra8M5/T5CStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u89PIDEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u89PIDEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE3E1F000E9;
	Tue, 21 Jul 2026 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784644871;
	bh=nswFRb5Tb9cBCZwmMVcLu5nnee7vVVZGNdwfdQQPRVo=;
	h=Subject:To:Cc:From:Date;
	b=u89PIDEnqeTWhnNFMo1iczgaR8xrGxu4fc566H7jjoF6NuGDBlX1PoFaFvPAJJVuH
	 MIeewFiV8EPnR1BbBqWrd/0JGyC2GzAFBf917I3sYo1r0UrSu+QlsGrSHgakHE6QZU
	 szo/l31uinmKImmGFmqAcGxYlSbl7r9CGeBIvlKQ=
Subject: FAILED: patch "[PATCH] net: airoha: Fix register index for Tx-fwd counter" failed to apply to 6.12-stable tree
To: win847@gmail.com,kuba@kernel.org,lorenzo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 16:41:02 +0200
Message-ID: <2026072102-stack-mardi-5c7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 1402ecccf5630a0b7fa4749d7d2e72abc3f3d73d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072102-stack-mardi-5c7c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1402ecccf5630a0b7fa4749d7d2e72abc3f3d73d Mon Sep 17 00:00:00 2001
From: "Wayen.Yan" <win847@gmail.com>
Date: Fri, 12 Jun 2026 07:09:13 +0800
Subject: [PATCH] net: airoha: Fix register index for Tx-fwd counter
 configuration

In airoha_qdma_init_qos_stats(), the Tx-fwd counter configuration
register uses the same index (i << 1) as the Tx-cpu counter, which
overwrites the Tx-cpu configuration. The Tx-fwd counter value register
correctly uses (i << 1) + 1, so the configuration register should use
the same index.

Fix the REG_CNTR_CFG index from (i << 1) to ((i << 1) + 1) so that
the Tx-fwd counter is properly configured instead of clobbering the
Tx-cpu counter config.

Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
Signed-off-by: Wayen.Yan <win847@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/6a2b40e7.4dd82583.3a5c46.e566@mx.google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd78d..329988a8400c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1256,7 +1256,7 @@ static void airoha_qdma_init_qos_stats(struct airoha_qdma *qdma)
 			       FIELD_PREP(CNTR_CHAN_MASK, i));
 		/* Tx-fwd transferred count */
 		airoha_qdma_wr(qdma, REG_CNTR_VAL((i << 1) + 1), 0);
-		airoha_qdma_wr(qdma, REG_CNTR_CFG(i << 1),
+		airoha_qdma_wr(qdma, REG_CNTR_CFG((i << 1) + 1),
 			       CNTR_EN_MASK | CNTR_ALL_QUEUE_EN_MASK |
 			       CNTR_ALL_DSCP_RING_EN_MASK |
 			       FIELD_PREP(CNTR_SRC_MASK, 1) |

