Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19332192F9
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395383; cv=none; b=uxnMOjhggPgaM05PdKt5Uf7kahnD2zGA9CEvtskiBfAvg1FBmMAFM0Nywl+ymD7QwiXMse+SGCV7IkDoIMSQp+CYbU2OeQKThdG9rxUmKm1g3afLPv4Nijf6M/7qEN8ZZorwR/pCDqTP5EIxwW8+i7PYe89VSnPuBhtMG50AqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395383; c=relaxed/simple;
	bh=sK90DKIpXujBmuc6efNUTihY5mOXWkWZ3dpINeyZMUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am0V622sfsamFfM+lNkW2Y9wQyZx2B/bUP61vo5sDk+t40LgQk0lWzDfCGeFMxtsJM3eT8eJ2KSwUJadT8xJepZuQI58tV0se2piutrUQxXogCvKpqEDHy2bP2pnA527pymr8IwA6w55aogkFMYxQiYRj8XC2FAkT0t+Vd5du/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz9Tx4OF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz9Tx4OF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B921F000E9;
	Thu, 25 Jun 2026 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782395382;
	bh=0Ws++Yb8Re/RhT8yz+I2RacKLjDKk/rCZvO++Sb9te8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bz9Tx4OFzSZ6LhcDRi5Nft7TBEHc5lrHs7q6dnz1Np3NYiwxSMqv+0YsDrOQF4o5G
	 rco87hzUsrlssTysrX9+Dk3K8lRBzvue58bFc27PlB4pDmyC/rcYH0OlNsCXa/y9uN
	 Ov4SIVXPuxZK9OGR6W6EzfkTk/Utor06rp4e83GG1JM+3eOZndnq2VhHuGJCAiztVw
	 keDDl2pVIcaIGNz7IBpGVpb2Axu8zDg3rLmX5xvxP+AVMH3vt5N1+XTgpZIBfUUJMS
	 8Og4PQaOzyoponUq6B8quM8f1qzNk9KN567coMO+F4gpx4M0Fd86ZJmugs+zct/7r9
	 MhlFPrSq0sM1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stepan Ionichev <sozdayvek@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
Date: Thu, 25 Jun 2026 09:49:39 -0400
Message-ID: <20260625134939.2415321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062537-limeade-detection-f50d@gregkh>
References: <2026062537-limeade-detection-f50d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stepan Ionichev <sozdayvek@gmail.com>

[ Upstream commit 10fc708b4de7f86002d2d735a2dbf3b5b7f65692 ]

dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
and then, if the device has a clock, registers a clock notifier. If
clk_notifier_register() fails, probe returns the error but leaves the
8250 port registered. The matching serial8250_unregister_port() lives
in dw8250_remove(), which is not called when probe fails, so the port
slot stays occupied until the device is rebound or the system is
rebooted. The devm-allocated driver data is freed while the port still
references it (via the saved private_data and serial_in/serial_out
callbacks), so any access to that port slot before a rebind is a
use-after-free hazard.

Unregister the port on the clk_notifier_register() error path.

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260514143746.23671-2-sozdayvek@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f17dc3de020c19..7b2e72bfeb7522 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -655,8 +655,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_unbound_wq, &data->clk_work);
 	}
 
-- 
2.53.0

