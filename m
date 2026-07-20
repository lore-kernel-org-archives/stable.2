Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F807434E57
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562953; cv=none; b=q5afieCm2E9baNBVrsvI8F9ankA4SfagE1JxIYVa6oKODHZ4uEvS5VU2Ak2R1YA/qbovY87MP/bCZ8FxB55jWKcRStKpwoDOOWJp+Tu1Fmw4SYuYFFzYwIBegiljwklYUBtescmOS1HbviaYgEx5abL1lzJmFrCCzURSOXaipx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562953; c=relaxed/simple;
	bh=WxWu7GJLYb8WflEwdVSMm8xJzrmGm9vOulrQTMwVuxI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NO63dDsNlCbEqFWVLT94hBQ4k0aUU+GzrfZdCX57Pg+JStXLmH9W0z8UpJn/UJpGABV6+lJqpjI71Z7sNtsqDdxE25UP9GWtBXBqp9CBFY8mAHyS3uXsLoyufY+xp9Zk2zEpYkZUi20YiA65OvOQfIl3rMPBjh7aDVHt61ZMSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2hqb+4xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2hqb+4xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714921F000E9;
	Mon, 20 Jul 2026 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562951;
	bh=afi7Zbe+YzvQFRXfUs/HlxyETXuOY8aPkbNxFZ4y04E=;
	h=Subject:To:Cc:From:Date;
	b=2hqb+4xu0VvYnQvgdP+AJq22XkW1wj0GK5x3VRh06+cXpKo6LrDAeK4J1IJ6W291j
	 qsIrTNZWJvLWgN7Qc/yvv7UBsuFexP0j3gzOevlfMv1CXcS2AeAvpvVTYDZs0O7HN6
	 v4Gozq+p9mX2ZT4CvuRQxhGabSxdM/jTFC+hN1WM=
Subject: FAILED: patch "[PATCH] net: mana: Validate the packet length reported by the NIC" failed to apply to 6.1-stable tree
To: decui@microsoft.com,haiyangz@microsoft.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:50:00 +0200
Message-ID: <2026072000-concave-rut-73ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2e2a83b4998af4384e677d3b2ac08565274279bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072000-concave-rut-73ca@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e2a83b4998af4384e677d3b2ac08565274279bf Mon Sep 17 00:00:00 2001
From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 1 Jul 2026 21:12:36 -0700
Subject: [PATCH] net: mana: Validate the packet length reported by the NIC

Validate the packet length reported in the RX CQE before passing it
to skb processing. The CQE is supplied by the NIC device and should
not be blindly trusted.

Cc: stable@vger.kernel.org
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Link: https://patch.msgid.link/20260702041237.617719-2-decui@microsoft.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 7438ea6b3f26..dd4d1c0c582e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2246,12 +2246,25 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 		rxbuf_oob = &rxq->rx_oobs[curr];
 		WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
 
-		mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
+		if (unlikely(pktlen > rxq->datasize)) {
+			/* Increase it even if mana_rx_skb() isn't called. */
+			rxq->rx_cq.work_done++;
 
-		/* Unsuccessful refill will have old_buf == NULL.
-		 * In this case, mana_rx_skb() will drop the packet.
-		 */
-		mana_rx_skb(old_buf, old_fp, oob, rxq, i);
+			++ndev->stats.rx_dropped;
+			netdev_warn_once(ndev,
+				"Dropped oversized RX packet: len=%u, datasize=%u\n",
+				pktlen, rxq->datasize);
+
+			/* Reuse the RX buffer since rxbuf_oob is unchanged. */
+		} else {
+
+			mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
+
+			/* Unsuccessful refill will have old_buf == NULL.
+			 * In this case, mana_rx_skb() will drop the packet.
+			 */
+			mana_rx_skb(old_buf, old_fp, oob, rxq, i);
+		}
 
 		mana_move_wq_tail(rxq->gdma_rq,
 				  rxbuf_oob->wqe_inf.wqe_size_in_bu);

