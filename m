Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB382EEE65
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396363; cv=none; b=DSrlodOPW050Psgt5zrkvGeTvHgX+InSM/n+/+TtJqfJ5xQLy+U/0RoVyMMuZZrBNvuxuAU07NEe5xno2fz/0u/KunRv+22P/ICSq9iElrTBHOxGTivUy3psLX7uGvJCMOhk8iC6zwsfeDuK3dsue8Fog3Xc0G0jcGNFoRtTmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396363; c=relaxed/simple;
	bh=I1G1C8/wYBb3WmiSqlTLAgAytcyBvzKRDXGeZOuuq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIdssJvmDo9g/6cJZaU45G1+zUL2pRYGtrHu0QPCwaPPbvgYU+N04s9OAfkZNpKIR3OSdGLSxzVRnAfW34pWBAnIgtYVsWZm2DX1PNHbVLQYTX5XHPoPvl7aNWTYuowic+oAynnxYiOJQbV09SNKG6rKbmqPinlafa7onkybXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmDkNehs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmDkNehs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108901F000E9;
	Thu, 25 Jun 2026 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396362;
	bh=VP88iuklqAdf7hC9O/72PM3nS3WsG53c9EmEgxnbPYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VmDkNehswsk2XLp+dg4asuZcbIloqjPE6GcMH8ZSF8ynY4QObCKVmKIN//8JgNsFO
	 PMsZ5OaYp0yAM3c2r18MpKEXBNAdvXWLfU2tLH34eqJZBJvkeFooKIg8GSsb3iJeGL
	 HX0OfAXb60q9rwZ+eCvevHFJJcVeQ8qxXxlAc56l3FEaRm6Tudn18R+kexig4GIoWe
	 jKJkvyF6iDkRuqELTiJK4LX2kxKomxqAZkBfA2d+J4OC12dirU21dfCKOldYgUW53e
	 b36R6/iyrndfu9EaL2QjJR+rJ6Ef+qVwx+YTSe8Ulie9mA0hZVvdaTdWjh1WtLC+4x
	 D2XGlSh0+RAxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stepan Ionichev <sozdayvek@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
Date: Thu, 25 Jun 2026 10:06:00 -0400
Message-ID: <20260625140600.2429183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062538-delicious-errant-833e@gregkh>
References: <2026062538-delicious-errant-833e@gregkh>
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
index ee589ad5266995..7d4841b72df0d4 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -673,8 +673,10 @@ static int dw8250_probe(struct platform_device *pdev)
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

