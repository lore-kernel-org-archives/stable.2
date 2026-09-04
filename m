Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979F339847
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527925; cv=none; b=pPOHPWwuBU87DgldsPTh75oNpDr5NoLH8cEEMmyoud1rixHbhIK+hC+I4RSL5E/On8hNLf2V92yZfXxB65X0ZsAl6Wd2cSn16fQ0BznpGKf779rlukBAy/2RWLQ1kctu4vPaSFD/cYnKhGPTtbFlHv/XR8iM6sovmEUbYIosPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527925; c=relaxed/simple;
	bh=plZEyHYlyMwx6KrF5ta/2r2fWR0Q8NDbswLuNKqZwvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAqcqUVxM4g38VJ4ZFOCeS4vv243dVBYmW4yL/Dmwzp2TLms5HxKZhJnW9yF5VQUT8De19a7zB1bYWWJIM+9vEHPmKVfk1s/8mfbf7+/lAlib2/Pcd+iTbTNGSTFaENLiWcX/pWDw8oX0yJmEWAFkM259JMHbGIqpeCGZiqpCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buWGQCp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buWGQCp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C453B1F00A3E;
	Fri,  4 Sep 2026 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527922;
	bh=5M7sU7O26eEpyYe2O9Jo+BkNa3cph+KM3so1wtDVF1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=buWGQCp/dpYGEI4X54AvhZ0HGG/iz8JinWi3OCYv5+YTINNxkrkNB2FFzs/UfdjDu
	 lUxZJe2lIZLc2Egk384wHQX+h8clurQqNOL//v7a/6Zo9GjBYzNNja8/wdIXKzTPIE
	 SZdCSuO2EbxW0373HkhBi6dEJexZDD9dXNhGor7M3ChMR85vqvD/wHiFKiJVhW/6Oe
	 Nej+Nhi/GlxL6HKV3naBYlOK/i/w+z1+HeXftcUAgJ2bs0SbVqMnVhAfnfnGxR1/rw
	 zAVS2zeqr4cOsXHaMAKdCpffrbus20eyT9BzaRjsZ+cmS56mZKWv9CjWETgEuveaSC
	 AzNDzfUD3SSJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] serial: imx: Convert to platform remove callback returning void
Date: Fri,  4 Sep 2026 09:18:39 -0400
Message-ID: <20260904131840.506263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090333-scared-direness-4881@gregkh>
References: <2026090333-scared-direness-4881@gregkh>
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
 drivers/tty/serial/imx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b9ef426d5aae3..ba64da1ca7b19 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2484,11 +2484,11 @@ static int imx_uart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_uart_remove(struct platform_device *pdev)
+static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
-	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
@@ -2655,7 +2655,7 @@ static const struct dev_pm_ops imx_uart_pm_ops = {
 
 static struct platform_driver imx_uart_platform_driver = {
 	.probe = imx_uart_probe,
-	.remove = imx_uart_remove,
+	.remove_new = imx_uart_remove,
 
 	.driver = {
 		.name = "imx-uart",
-- 
2.53.0

