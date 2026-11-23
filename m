Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454544;
	b=wkSAtpzu4alxRbp5sItS0jm9f/sC+o4V0R8kHmuSGXWCKxZtcrJF2HXJ+Xm1TiAlm8OW
	 njnTyzP+Xmb9nGVaIxv5ClOxe0K93k6XESo9ifmCf+6aV7fhDdCACfzlRx0ipfkRnjfrq
	 ZZzq6ScFx9hQPikA6uIVuwegRV/Ci8uA3jlnQWQv1KXaos0FS9YgyV8KGnQEbGvgyxc0q
	 wOb4XcMuSVheGsR8rspR288GJMNo3UdlJ9ToQ3La0ZmFi4zKXtUwRPJglMhPCewxJTfnc
	 /af7GbjoT0Bvb70aLGRW/qnjbJCpL5nvYcUt+M72PQ2GWo+/0u66n8NzjdGmQhhU0nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CzA+ST8aLEfD/69rU1J1BqzPV3/gYwSreGIfqCeZJjM=;
	b=v5QovC+uYo7NhDj0VxCXzsEmHecDE9X2TghvcMFULFCoSss5ijZJj7Z73LoHRNa473cW
	 G121akTQDfPHXkpEcCdJIjJeqOnvrzWdyECUfKD3MQM5eHX5dYtRLoF8Sln141Kf/xSUn
	 1hbUELl6MKjv4ICbAu3AQ49gJosHGC3v50xbJGbLACCbVrDXKn5Y0OJpNceKFNO3NXVeR
	 QI4YRM7lJSNHOHNR86efVcJX7zVGYMUb5b7rTmcrtdhdsSvIR4fDxmTKU9FVK9NTIzPnj
	 eG6acfgVExBGyNvkRJz0Cw4xyqQubOLxmUFLWoAdetYR3iFKHGvhYZjl2kK134rJlvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+U04sFZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3314606A31A;
	Mon, 23 Nov 2026 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+U04sFZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD781F00A19;
	Mon, 23 Nov 2026 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454544;
	bh=CzA+ST8aLEfD/69rU1J1BqzPV3/gYwSreGIfqCeZJjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+U04sFZQ/o9rCpO+Qv21Kpc4I2djAiLwzXLcPvG2pwrIkJddJcJnBwwKxeWfvv6S
	 0RVjn+9p3igcaL3vim8OSO+h1L4yef/0SZPWKUaAD5+vKYA7exlr2lnqWXOZ8ez34h
	 iofoUNcpOfK0l6jdMbrXf3H0h2GLt3SGEIyvZWsgwDcZf9qQ9So28BTkmZblIMfJFQ
	 yTqwhhj/DSUsjsItuYESEQg5QR1nLJA5VNxFKXLXc1Wn3HiT39LIyYR5CIJqX7XqcH
	 nWOB4H+Ky9ZDyuI3oTdrNAysA3fBC79keXboINji0LYTnFAOYhySQ6tDcgKpePQPZW
	 1KzoWW9XUNHbQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] remoteproc: imx_rproc: Avoid stale mailbox pointers on request failure
Date: Mon, 23 Nov 2026 17:20:49 +0000
Message-ID: <20261123172140.3547896-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
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

imx_rproc_xtr_mbox_init() stores the result of
mbox_request_channel_byname() directly into priv->tx_ch and priv->rx_ch.
Because mailbox channels are freed on stop() and detach() and
re-requested on start(), attach(), and system shutdown, a failure while
requesting "tx" leaves an ERR_PTR in priv->tx_ch, which is later
dereferenced by imx_rproc_kick() and imx_rproc_free_mbox().  If "rx"
fails after "tx" succeeds, priv->tx_ch is freed without being cleared
while priv->rx_ch retains an ERR_PTR, causing subsequent calls to see
both pointers as non-NULL and skip initialisation, leading to a
use-after-free on priv->tx_ch and an ERR_PTR dereference on priv->rx_ch.

Request both channels into local variables and assign priv->tx_ch and
priv->rx_ch only after both requests succeed.

Fixes: 99b142cf7191 ("remoteproc: imx_rproc: Request mbox channel later")
Closes: https://sashiko.dev/#/bug/linux-ac0f248a-bdfd-41da-95f8-44b8f1f7091d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/imx_rproc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 581bb07f5893..a77a3342e1ed 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -875,6 +875,7 @@ static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
 static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
 {
 	struct imx_rproc *priv = rproc->priv;
+	struct mbox_chan *tx_ch, *rx_ch;
 	struct device *dev = priv->dev;
 	struct mbox_client *cl;
 
@@ -900,18 +901,21 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
 	cl->knows_txdone = false;
 	cl->rx_callback = imx_rproc_rx_callback;
 
-	priv->tx_ch = mbox_request_channel_byname(cl, "tx");
-	if (IS_ERR(priv->tx_ch))
-		return dev_err_probe(cl->dev, PTR_ERR(priv->tx_ch),
+	tx_ch = mbox_request_channel_byname(cl, "tx");
+	if (IS_ERR(tx_ch))
+		return dev_err_probe(cl->dev, PTR_ERR(tx_ch),
 				     "failed to request tx mailbox channel\n");
 
-	priv->rx_ch = mbox_request_channel_byname(cl, "rx");
-	if (IS_ERR(priv->rx_ch)) {
-		mbox_free_channel(priv->tx_ch);
-		return dev_err_probe(cl->dev, PTR_ERR(priv->rx_ch),
+	rx_ch = mbox_request_channel_byname(cl, "rx");
+	if (IS_ERR(rx_ch)) {
+		mbox_free_channel(tx_ch);
+		return dev_err_probe(cl->dev, PTR_ERR(rx_ch),
 				     "failed to request rx mailbox channel\n");
 	}
 
+	priv->tx_ch = tx_ch;
+	priv->rx_ch = rx_ch;
+
 	return 0;
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

