Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51B39526F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613440; cv=none; b=Jn6hljbwEa/+EU5Q9q11wJKzL+xf82BCHVd8deM+z8PkkHO3Kxl6HzHTBA3syh0BRL0VDX8lPg9ygpGJ7aMpEicLqKnTDBj6wKVjSzs2gldZcfsQq8Hsulp3dVVY1Kl8XtLOMTrX/LX9XVrTFPWBocJ05HtusA+VPuF2ltoOFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613440; c=relaxed/simple;
	bh=nD4DayDVCHm+0xaiQMqO+1CUP3Cf3B+hZMupNhLObrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWDCm+lFsssf99P0e6Ai4hi68Q8tcTt5qOD50JixaEm6Cu8b5h2k26/rhJfL1EigHadGDIPmKCvI1LMZlRgjTBZFFfP12u7ORKDDbX5tBjsOhUCyXMTV1tJmMDIYD+ZCVVRw6d2cewYnoM+0InkaEren3E436o+gMqJ3D5lRcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAJ4AiBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAJ4AiBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F171F008A0;
	Thu, 17 Sep 2026 02:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613423;
	bh=Nld+jt3sF/b5MM5riuDPM1Nr4dKImcvg1+QP9i2r0To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TAJ4AiBK2IQLMKr4Hd7tQ/u6mGvWv/DqsY4fmuRHtHYwqqLxjvpHyrJVBNMNuk6qg
	 gsv4zb5rhq99+COPs0Yy5MC+bnTj6fC6KwTVGWQ4YdcFJKv8g0/GUB/Dpu9NyqQnl6
	 HVDd2IUOXUM53hINfhO9SH8yt62TS4il/X7Pxjnh7FL53CZMB5z317dkE6LiZDeqpI
	 DDHqbwdlIP8hKtEt4yXN389RfKCYQb/at8dhr0Tpi4au0CL2/7zT8Hbg6/Lppt0Pxq
	 LU75+61Wt8O/YReVbe0LIC8//IqUI9oMGvULBkQe1yDnKht4JeC00LWKx7v1X8YIUA
	 frALV9cmsuZag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ieee802154: cc2520: fix FIFOP work use-after-free
Date: Wed, 16 Sep 2026 22:50:21 -0400
Message-ID: <20260917025021.3917468-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091624-vocation-confined-5580@gregkh>
References: <2026091624-vocation-confined-5580@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit ff5891b266a7fc6a062710836be84f1cc19338b5 ]

The FIFOP interrupt handler queues cc2520_fifop_irqwork.  On removal,
cc2520_remove() only flushes the work.  The devm-managed FIFOP IRQ
remains active until after ->remove() returns and can queue the work
again after that flush, allowing it to run after the private data is
released.

Disable the work with disable_work_sync() instead of flushing it, so
the handler can no longer queue it once removal begins.  Destroy the
buffer mutex last, since the worker and the stop callback invoked
through ieee802154_unregister_hw() both take it.

Found by an in-house static analysis tool.

Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio")
Cc: stable@vger.kernel.org # v6.10+
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://lore.kernel.org/20260812061714.175966-1-fanwu01@zju.edu.cn
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
[ replaced unavailable disable_work_sync() with disable_irq() followed by cancel_work_sync(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/cc2520.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index a94d8dd71aad9..10bdc317ae282 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -206,6 +206,7 @@ struct cc2520_private {
 	bool is_tx;			/* Flag for sync b/w Tx and Rx */
 	bool amplified;			/* Flag for CC2591 */
 	struct gpio_desc *fifo_pin;	/* FIFO GPIO pin number */
+	int fifop_irq;			/* FIFOP IRQ */
 	struct work_struct fifop_irqwork;/* Workqueue for FIFOP */
 	spinlock_t lock;		/* Lock for is_tx*/
 	struct completion tx_complete;	/* Work completion for Tx */
@@ -1117,8 +1118,9 @@ static int cc2520_probe(struct spi_device *spi)
 		goto err_hw_init;
 
 	/* Set up fifop interrupt */
+	priv->fifop_irq = gpiod_to_irq(fifop);
 	ret = devm_request_irq(&spi->dev,
-			       gpiod_to_irq(fifop),
+			       priv->fifop_irq,
 			       cc2520_fifop_isr,
 			       IRQF_TRIGGER_RISING,
 			       dev_name(&spi->dev),
@@ -1156,11 +1158,11 @@ static void cc2520_remove(struct spi_device *spi)
 {
 	struct cc2520_private *priv = spi_get_drvdata(spi);
 
-	mutex_destroy(&priv->buffer_mutex);
-	flush_work(&priv->fifop_irqwork);
-
+	disable_irq(priv->fifop_irq);
+	cancel_work_sync(&priv->fifop_irqwork);
 	ieee802154_unregister_hw(priv->hw);
 	ieee802154_free_hw(priv->hw);
+	mutex_destroy(&priv->buffer_mutex);
 }
 
 static const struct spi_device_id cc2520_ids[] = {
-- 
2.53.0

