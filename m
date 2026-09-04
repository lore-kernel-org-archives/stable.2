Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC543DA20
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522485; cv=none; b=hhtekQ6fWPsbxMOHbD2vmpxX3pWn9z5LdrIVP6WH3BlhRipdeXMtGzr3HuNxVXUzN95Ya3eWZiHgkEMGLoRgAqeQC2TKCe4b4Xj4HSBj8BLVMa10ywJ54QukGodCfY225h9CfSho6lmPxtMvlkHsB/CJ3nxCqLSe7xIGYEs8hL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522485; c=relaxed/simple;
	bh=PMVHlQ+lhEnLgdxcgIqty8LXVk2+tGnBne4lOgrKIXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmSWyCloKp6rs/Vet0RH2ZMKkSvcoQnZsDOVSB8KAIFNWsOwkCYn9iLHe/p8pyqBlvKxtLgBz4elHm9ABQzaT2LEv6UHW8LZy+i6AlKDTnG1Y2IpFle4nt3MBJV8N6urCJDnX8E9CPsJNPjqTwUD3nVBpZ7nwDBo3YTbGfM0oyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoHuvIaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoHuvIaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE481F00A3D;
	Fri,  4 Sep 2026 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522483;
	bh=CloU/G0xaWfk6L26mptspaEPc6Uk5d3zfq56gmPk64I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SoHuvIaIJTapf71EHQMAdOJ9XFwGSLdqJ8jWNXiJi/BvDcBklNHHObiHvFU3lUbEu
	 jD6KtJkhWvXyTeeId42xSefkHqgdb4+M7MqtLA3TBLBHYN/YAWqdj7LbqxI6GhQqbm
	 NwOpmLZS2PQXUm5MqvmK1iRzDRaaODh9t1XLwGIiagZHNfLmisKN73jHP/njcYEZNi
	 s4ACrHWkKdzXThpr3kAeeXrc1OR30ddBSEafOQUYmIZ8KSo5thA5DzTmAJKTbBbBTX
	 JmZtxANujaCw/G3Qiv2oqhXz6vJkaSboDFjQarCcZBJw6kWEuUi9jY+0zEdGO3N7HM
	 Dc6+JjTAQyq7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] serial: imx: Convert to platform remove callback returning void
Date: Fri,  4 Sep 2026 07:47:59 -0400
Message-ID: <20260904114800.3757105-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-deputize-flying-c9c8@gregkh>
References: <2026090332-deputize-flying-c9c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit c066f87314b7fbbf4d72d38957436a98e7b7e503 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231110152927.70601-18-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8b0b29fdcb47 ("serial: imx: serialize imx_uart_ports[] lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 47e59664dbde6..020ede9568af4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2534,13 +2534,11 @@ static int imx_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_uart_remove(struct platform_device *pdev)
+static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
-
-	return 0;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
@@ -2709,7 +2707,7 @@ static const struct dev_pm_ops imx_uart_pm_ops = {
 
 static struct platform_driver imx_uart_platform_driver = {
 	.probe = imx_uart_probe,
-	.remove = imx_uart_remove,
+	.remove_new = imx_uart_remove,
 
 	.driver = {
 		.name = "imx-uart",
-- 
2.53.0

