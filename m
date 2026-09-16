Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1C3AFD05
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574921; cv=none; b=OYZC8RUpaj5znd3M/OupyiEhD7CBximE9u8/DP4FYUPyfKmsH9jitjhkWi6AWQ1PH6icx/5m3dMpHERAV4+OK0dgXMNzTDXoda3y4DXUaFROT1T+4ziLD4Cc/Yt/4wuvgq4z4NKcdZX4b7SdfTcd5LXH1oItA47CLoQ7LtD6Nn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574921; c=relaxed/simple;
	bh=5g2l1JmM7sYfru+NxuOZAc0S+rWgAYF/vqrte3O0gAI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a1VwmIOuWosKP6i+jdo/EleAQy02Yyr5LJzRV9wkIJFYCyb5JL2viyKr3xwna0y5nO6QPs1M/7rxKcB8UZ3gp3qAqA9+RXxB/+4Vlo/1Lu0bEF6lOrciaPFV3hT/q2DGXBOr7PVTtBlbWO5pxZb9wP11N98yyGNzqeYZuvMuOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WGjkTpvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WGjkTpvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074D61F000FF;
	Wed, 16 Sep 2026 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574916;
	bh=5o7NhT7vxtLqWBjPfe/ttX8k9buh9lBHegobZ/jBwC4=;
	h=Subject:To:Cc:From:Date;
	b=WGjkTpvCz/ajHw961JNDV9tWxBbLaj7Kq0o9SMfJD+f8Uy732MGU7fRSOnLr8DNEO
	 fVoZqkUtxvvlJpnez1Urb7ge6pTQOxaSwLg9qQPtVeKaqQwIKHO6fkYjxoGxnN7vRO
	 1ASTEuUj3YzqQc6ivE3kIMSK1L88SXab62g6x5e4=
Subject: FAILED: patch "[PATCH] ieee802154: cc2520: fix FIFOP work use-after-free" failed to apply to 6.1-stable tree
To: fanwu01@zju.edu.cn,miquel.raynal@bootlin.com,stefan@datenfreihafen.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:58:24 +0100
Message-ID: <2026091624-backwater-icon-9e07@gregkh>
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
git cherry-pick -x ff5891b266a7fc6a062710836be84f1cc19338b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091624-backwater-icon-9e07@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ff5891b266a7fc6a062710836be84f1cc19338b5 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Wed, 12 Aug 2026 06:17:14 +0000
Subject: [PATCH] ieee802154: cc2520: fix FIFOP work use-after-free

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

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 2b7034193a00..abfcfe07246a 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -1156,11 +1156,10 @@ static void cc2520_remove(struct spi_device *spi)
 {
 	struct cc2520_private *priv = spi_get_drvdata(spi);
 
-	mutex_destroy(&priv->buffer_mutex);
-	flush_work(&priv->fifop_irqwork);
-
+	disable_work_sync(&priv->fifop_irqwork);
 	ieee802154_unregister_hw(priv->hw);
 	ieee802154_free_hw(priv->hw);
+	mutex_destroy(&priv->buffer_mutex);
 }
 
 static const struct spi_device_id cc2520_ids[] = {

