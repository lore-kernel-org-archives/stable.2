Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B653DAABC
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238381; cv=none; b=G+DeDo0DXJKo0JuUTGSQBsw0ZDS/bAOULAPNlf9WBR9RqI2VO7mmPDeuSFe0pIYM0Lsk7vNhv2NoBr0cILkF+Zevzj6uCxajwr+NN6d78LiSxd1X14ise4RIpFA8/EIBO+mFAXOqURQ6panuukfrk0ihHBLq1ZQxwuDhYw1x9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238381; c=relaxed/simple;
	bh=6JVGRbK80TLwd54dli82mMF8wgELp9wwjUftKthjuDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SF8XDs21KENPiv8uCAlCgFzwUAAG7SoPCnd9NLRMVIztOAjuVk1pHJosmAuXDg9XYZ16QmGKGxrU5HxYh5V5WNNGVwxbWZHkFH/ZWNP0jCrboKjxJKTGlI5riLY8Dfv0fXK7EzvbtT1s48U+q2jk8gQ+MZJPdJTxHA0O479z/pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzBi7hin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzBi7hin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE57F1F000FF;
	Mon,  5 Oct 2026 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238380;
	bh=4kxVyz3W2dIZmkhAHd36nCd+DtLmRSNJ8rOvFEdLpes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VzBi7hinlScdspgqWxXuCHwDumVLo51aLrK5IigoZKTxD6XHEBBJaVvz1Z8nljLp+
	 NSjHFWjtYnW44woqbXNj6Z3RysPruyabeqwG6vg+wi6vB3PApbOnjQ1/fNZ8nR5eYk
	 QTyymeyq/xbVt14NTIQ3Lxm9lumprvXTyq4iN2klJ7nA95yDcYsLUKqIYrgQZ6CRab
	 jYEJ12MkwB0/hvtSbuoan9NCA6VO8ESSCIF3w3EhioZ6/oBeEcucDTTp30KF7u7uxQ
	 deWF17ZFENnqMNqWwdjMICINBvBSNs6qUHmYG396CrMm1xOW7XfKzZj2TIXuMO5ccr
	 zDFR9UvVpIhsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] serial: ma35d1: Convert to platform remove callback returning void
Date: Mon,  5 Oct 2026 18:12:55 -0400
Message-ID: <20261005221225.3435549-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100517-epic-chomp-5963@gregkh>
References: <2026100517-epic-chomp-5963@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit cec346ec4649bb9d741a52da1632db4e6fd13947 ]

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
Link: https://lore.kernel.org/r/20231110152927.70601-22-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 98401cf912fe ("serial: ma35d1: Fix clock reference leak in ma35d1serial_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/ma35d1_serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 6e5458b085541..f6f832ba7204d 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -760,14 +760,13 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 /*
  * Remove serial ports registered against a platform device.
  */
-static int ma35d1serial_remove(struct platform_device *dev)
+static void ma35d1serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = platform_get_drvdata(dev);
 	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
 
 	uart_remove_one_port(&ma35d1serial_reg, port);
 	clk_disable_unprepare(up->clk);
-	return 0;
 }
 
 static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
@@ -800,7 +799,7 @@ static int ma35d1serial_resume(struct platform_device *dev)
 
 static struct platform_driver ma35d1serial_driver = {
 	.probe      = ma35d1serial_probe,
-	.remove     = ma35d1serial_remove,
+	.remove_new = ma35d1serial_remove,
 	.suspend    = ma35d1serial_suspend,
 	.resume     = ma35d1serial_resume,
 	.driver     = {
-- 
2.53.0

