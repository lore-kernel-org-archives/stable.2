Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4F47CC75
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522064; cv=none; b=LfnG7cX6GhX4Atvx4fzxA6dqWY9BKfSkNe0MKss/MuFmPqTKJ3s+rAi5lEE1LQgWfYOKtESY1gL/OEn0uoN2PuxSKUpEWIl2Rnn9xWrNI9XrBnbokqd9wgvUMNWNhf7LRB/dXql7AX6o1OuXek8EVQd92o81z+rlopIq3tKeqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522064; c=relaxed/simple;
	bh=Wm+I/FNrA+d9D0F19TcOy2Tw2EWdGJGikYvv0P4OqtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6OMkwtpdVhpVw5ci4Rz9yRC5QEIw1IciD2LzJX4R9DM4127a5hUSN9Oa+k1HWuSb7Nmj253L0tkfsZha6H4GOkHQOfTm46rlt36OznlDigBGIltKbuvlTONjOqVfEdkGXRdWXj0Gs5b4XrpNK2sxFZrWDAuyZpbj+iaVTMNwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtYEXlAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtYEXlAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1820D1F00A3D;
	Fri,  4 Sep 2026 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522061;
	bh=T+1+wiz9xkyFoASybsA5jb2V5dTwRZMAFdNTaQkDqJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EtYEXlAKdXgN/8h12AjfZzIx+q09oFKCOsGmNkdKO6xGFVmYeb1Sbvb07a0rR4Cso
	 78aYDs5WyGh9JI7zTcdJgVOMyfx/8cgDaSkEZti5f9CmuA0TDvvBJ5Bu8grXTWmwXk
	 zLmZ2u3Sk2bqH1Al5A/2c4DporwElTUxeGl71lJ2RrzP9AeArWsHb54cEjQj6ufEST
	 ZDaJJA7g0WR8rjX4VoBVlA1+swtnh4xXAReueTdc4YnWovv4XBOxOj2IRiwYTIsk/3
	 wW8dPA+n4xy1afxgbTVGZ7Fotf8vABEik+wEIT9sSC/oKWGAUYNwhdwqjfSy9LS97o
	 1ZWL98w0uqk1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] serial: imx: Convert to platform remove callback returning void
Date: Fri,  4 Sep 2026 07:40:58 -0400
Message-ID: <20260904114059.3685169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090332-sizing-praising-4243@gregkh>
References: <2026090332-sizing-praising-4243@gregkh>
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
index 60d48d857b1c0..11d5fa8249f28 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2502,13 +2502,11 @@ static int imx_uart_probe(struct platform_device *pdev)
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
@@ -2677,7 +2675,7 @@ static const struct dev_pm_ops imx_uart_pm_ops = {
 
 static struct platform_driver imx_uart_platform_driver = {
 	.probe = imx_uart_probe,
-	.remove = imx_uart_remove,
+	.remove_new = imx_uart_remove,
 
 	.driver = {
 		.name = "imx-uart",
-- 
2.53.0

