Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA80451986
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931220; cv=none; b=ihUfcDNQNxlBqTvI6EUVP+MA5rKdqdRqnRcgPi7SsnwHd0yY9xCAU1sboJdyL5bHaZZv58+i4uUf1cH/UyFS+izF9SyNiYa3T0KR4dvhsS5XIpqMhzytgwGEsBabxiMdLRrwJ1acJNLXtUB+JsT6Ea7d2wFsP5l2L5lRDZpsyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931220; c=relaxed/simple;
	bh=tDRMT7tMo1oh38HV7Wn4/XyqDF0MjI0vaHeGdY4VO8E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P9TAZ641yZqvVa7JfONwIp+rSC9wvAu6zhK6TBL8xJ+NMuKTV3UMQfV8L1IJR/qO+8Fye6dy8pb7Rr/G18qYiuRE2DrUB3fTmroEMIy066WoknsXLID5STq1tO9WK6KMqBvcOflm6w4ERdAl3teLMARn+KPk+awd22KUYcw+zMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TLbmFAOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TLbmFAOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B681E1F000E9;
	Wed,  5 Aug 2026 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931219;
	bh=w5zteKRxySdtCMfLe1wtv287VSCYgx4OhvTqr8owBZY=;
	h=Subject:To:Cc:From:Date;
	b=TLbmFAOiuOCwuWPdLuS4c79aC6UXUPH1NhKx9XR4SDGpRjv63Sh2Jo4gA8MF4t3zu
	 CAyebogGRNYSGXoqh/Nwekayc8WcivIviwkOdzA5i13asH7VyaTGN61bnAUrjuu6+F
	 q7uhoUOeZ3Hgkb3iFyi0TuKdVRkX9MOZi6jI0O74=
Subject: FAILED: patch "[PATCH] can: c_can: c_can_chip_config(): keep controller in init mode" failed to apply to 5.10-stable tree
To: lucas.alves@lumal21.com.br,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:53:32 +0200
Message-ID: <2026080532-clerical-maverick-d119@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 26504844613fb44c7cab1c5f6fcff77861709baa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080532-clerical-maverick-d119@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26504844613fb44c7cab1c5f6fcff77861709baa Mon Sep 17 00:00:00 2001
From: Lucas Martins Alves <lucas.alves@lumal21.com.br>
Date: Tue, 14 Jul 2026 16:48:57 +0000
Subject: [PATCH] can: c_can: c_can_chip_config(): keep controller in init mode
 until bittiming is configured

c_can_chip_config() was programming C_CAN_CTRL_REG without CONTROL_INIT,
which may allow the controller to become active before
c_can_set_bittiming() finishes.

That creates a short timing window where the peripheral can interact with
the bus using a different/default bitrate, potentially generating bus
errors and corrupting traffic.

Set CONTROL_INIT together with the control-mode writes in
c_can_chip_config() (normal, loopback and listen-only paths), so the
controller stays halted until bit timing is fully programmed.

This prevents transient bus disturbance during startup when the configured
bitrate differs from the active bus bitrate.

Signed-off-by: Lucas Martins Alves <lucas.alves@lumal21.com.br>
Link: https://patch.msgid.link/20260714164839.771123-1-lucas.alves@lumal21.com.br
Fixes: 881ff67ad450 ("can: c_can: Added support for Bosch C_CAN controller")
Cc: stable@kernel.org
[mkl: remove space before close parenthesis]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index 3702cac7fbf0..b3b321d9ce68 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -597,20 +597,20 @@ static int c_can_chip_config(struct net_device *dev)
 		return err;
 
 	/* enable automatic retransmission */
-	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR);
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR | CONTROL_INIT);
 
 	if ((priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)) {
 		/* loopback + silent mode : useful for hot self-test */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST | CONTROL_INIT);
 		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK | TEST_SILENT);
 	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
 		/* loopback mode : useful for self-test function */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST | CONTROL_INIT);
 		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK);
 	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		/* silent mode : bus-monitoring mode */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST | CONTROL_INIT);
 		priv->write_reg(priv, C_CAN_TEST_REG, TEST_SILENT);
 	}
 

