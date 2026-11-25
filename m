Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597909;
	b=AjGKk4aqyNd3ykbW0uzONE0lKEfuTP05u/RVSKQSqVWTSDA+WDfVeYZgMvHwBDJRQclQ
	 1bUa02knH7cZbCZrglASXSrs2VQgvgBECX5bwu9xX4bUPZoXMi+sFtPBbaKA8QBKebEKE
	 8yFJnvMfPq5OWTKDkrqVPj8in6VESSRMFa7GM22uv/fGjLpLnGIsiJ/xAQyqB10hmgoGQ
	 8BM1xm3pjnjxtp2BvqsIDFQPpcfaeL9+AbbyMXOyjooouowgqzEaotqYp2m4SghCh8Us8
	 FsdkWk/+1zIRFVtf4UUHsNZeobCOWVdq+gcZKHT/SflXi8n4fcO2mGuDuFkuIKO/ltg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597909;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8CIrKV1FZIAjIn+HTC5giAI93/BtITTf1IQ7scdhzGc=;
	b=XY6QawxaM2oq14Oe3ODURHPxA/nxxO0H6j6MAlECBWEWif4ThhMPs6H9MtPDr6XQEETZ
	 7+KTLZRxxsSYlCxjjYXGPhGQ5/B/NSkhJNTEEfvEGVPANHVuYP0U84UacXwIg9LLZwwJH
	 WGo3dFBMy7f/JjHD7yPoX9Phrs5SpLVdzLBXtg+H6VUNnjqM+bAkErZaNNQ4N1SrTNs0x
	 CdxvCKG5KTP/XJeZCAnkN0Hq6dq0v+sE8ZNvPke1CIoeswi0CsnlEIrcO2+wbQmcgOU4k
	 Pj6IVUWi0p1zo4MA29P+2OORbbdDPc8nu+rlBq7sYAb1lAvjxlKyXPLzcleACl37VFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xMcdw0hn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E707606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xMcdw0hn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114691F000CA;
	Wed, 25 Nov 2026 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597908;
	bh=8CIrKV1FZIAjIn+HTC5giAI93/BtITTf1IQ7scdhzGc=;
	h=Subject:To:Cc:From:Date;
	b=xMcdw0hn+/l8xu+wSF7o3OGEIfggA/OYKNX9lR98KTargH4zd3lpBm+0YPiFdA+Ry
	 JNaFeLROYDgXGnwExH4K5Nu1R45++ZBJO/kyqHipLW1DMI1tNSPTWCzUAaAP70ak9/
	 7DCIueNZcNGZBr800ahQBkxRttkMwc5pQjscn4Z4=
Subject: FAILED: patch "[PATCH] gve: Fix link flap after ethtool ops" failed to apply to 5.10-stable tree
To: treapking@google.com,hramamurthy@google.com,joshwash@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:59:55 +0100
Message-ID: <2026112555-unsorted-splashy-f7ba@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b1a53c452457d003909ea5a55fb8190012dac947
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112555-unsorted-splashy-f7ba@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1a53c452457d003909ea5a55fb8190012dac947 Mon Sep 17 00:00:00 2001
From: Pin-yen Lin <treapking@google.com>
Date: Mon, 9 Nov 2026 18:20:36 +0000
Subject: [PATCH] gve: Fix link flap after ethtool ops

When modifying device features via ethtool, GVE causes a short link-down
after the ethtool command completes, which can break scripts that use
the network interface right after the ethtool command.

This issue was discovered and actually triggered by the
drivers/net/ping.py selftest. Modifying checksum offload features via
ethtool caused a transient carrier drop ("Lost carrier", DHCP lease lost),
causing the immediate ping invocation to fail.

Fix it by calling gve_turnup_and_check_status() in gve_queues_start()
instead of deferring the link status update to the service task, so the
carrier status is updated synchronously before returning to userspace.

Take netdev_lock() around the link status update in gve_service_task(),
so that it is serialized with the synchronous update. All other callers
of gve_handle_link_status() already hold the instance lock.
Still queue the service task after the synchronous update, so that a
reset requested while the service task was disabled during gve_reset()
or suspend is handled once the queues come back up.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 3b7cc73628ff ("gve: Use link status register to report link status")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Link: https://patch.msgid.link/20261109182036.2910559-5-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index b5e2f39a903c..76ab304f1905 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/sch_generic.h>
 #include <net/xdp_sock_drv.h>
@@ -1431,6 +1432,37 @@ static void gve_queues_stop(struct gve_priv *priv)
 	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
 }
 
+static void gve_handle_link_status(struct gve_priv *priv)
+{
+	bool link_up;
+
+	netdev_assert_locked(priv->dev);
+
+	if (!gve_get_napi_enabled(priv))
+		return;
+
+	link_up = READ_ONCE(priv->link_up);
+	if (link_up == netif_carrier_ok(priv->dev))
+		return;
+
+	if (link_up) {
+		netdev_info(priv->dev, "Device link is up.\n");
+		netif_carrier_on(priv->dev);
+	} else {
+		netdev_info(priv->dev, "Device link is down.\n");
+		netif_carrier_off(priv->dev);
+	}
+}
+
+static void gve_turnup_and_check_status(struct gve_priv *priv)
+{
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+
+	gve_turnup(priv);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
+}
+
 /* The passed-in queue memory is stored into priv and the queues are made live.
  * No memory is allocated. Passed-in memory is freed on errors.
  */
@@ -1494,7 +1526,11 @@ static int gve_queues_start(struct gve_priv *priv,
 			  round_jiffies(jiffies +
 				msecs_to_jiffies(priv->stats_report_timer_period)));
 
-	gve_turnup(priv);
+	gve_turnup_and_check_status(priv);
+	/* Also kick the service task. When the queues come back up after
+	 * gve_reset() or resume, this handles a reset requested while the
+	 * service task was disabled.
+	 */
 	queue_work(priv->gve_wq, &priv->service_task);
 	priv->interface_up_cnt++;
 	return 0;
@@ -1570,26 +1606,6 @@ static int gve_close(struct net_device *dev)
 	return err;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv)
-{
-	bool link_up;
-
-	if (!gve_get_napi_enabled(priv))
-		return;
-
-	link_up = READ_ONCE(priv->link_up);
-	if (link_up == netif_carrier_ok(priv->dev))
-		return;
-
-	if (link_up) {
-		netdev_info(priv->dev, "Device link is up.\n");
-		netif_carrier_on(priv->dev);
-	} else {
-		netdev_info(priv->dev, "Device link is down.\n");
-		netif_carrier_off(priv->dev);
-	}
-}
-
 static int gve_configure_rings_xdp(struct gve_priv *priv,
 				   u16 num_xdp_rings)
 {
@@ -2064,15 +2080,6 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
 
-static void gve_turnup_and_check_status(struct gve_priv *priv)
-{
-	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
-
-	gve_turnup(priv);
-	ops->report_link_status(priv);
-	gve_handle_link_status(priv);
-}
-
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
 							unsigned int txqueue)
 {
@@ -2406,8 +2413,14 @@ static void gve_service_task(struct work_struct *work)
 	gve_handle_status(priv, status);
 
 	gve_handle_reset(priv);
+
+	/* Serialize with the synchronous link status updates, which all run
+	 * under the netdev instance lock.
+	 */
+	netdev_lock(priv->dev);
 	ops->report_link_status(priv);
 	gve_handle_link_status(priv);
+	netdev_unlock(priv->dev);
 }
 
 static void gve_set_netdev_xdp_features(struct gve_priv *priv)

