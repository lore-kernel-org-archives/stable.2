Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5253CCFC4;
	Fri,  3 Jul 2026 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080879; cv=none; b=XuU5Yd16W5EVAVj+XE6uS0DVSN5ImG7rizqT6y8/pyT3DdlH36XqGtx8xcaoRH2Y/KrjBJydwhhNtuBTwWkcebdllOkhrWmqVYUfVznJBDAjh2rH3lA1TwzdHWh4TpSDzyjwn8Q06QDIjy3Rbk4fqSmKdWo0gWlFQEZ2UwNOUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080879; c=relaxed/simple;
	bh=KWWCjLkg4h9x3km9rFZ2Wfc0d2ZwVc895DbuVuZ74O4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LITYEpjkICKds7eyG9iCs9Ip3nCPlwpL8rBVfo3YcjYhuSnaH1vkXdeUE4TgznHVZl8mYB3iK0axJGto4ZrIfZb15thfsprPHi9LZB4z4vBiZCvvA0XwgY32rskxlfUtGrfyj7pNYb2mPJbhIHjpvTPR1rbcxmqyQ7edYj0WZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=AG6PM/yh; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="AG6PM/yh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1783080866;
	bh=KWWCjLkg4h9x3km9rFZ2Wfc0d2ZwVc895DbuVuZ74O4=;
	h=From:To:Cc:Subject:Date:From;
	b=AG6PM/yhZE5mNO0tX1LnotZZjELMcvmJXDmIX/c8ZQZZRmqb4F+z0DwHJeotD5bSo
	 TMCq+vjZRGTadIb7+1dbJQ4mZJLRTcvuT0XKke14kfpTeDOD8za86PV9FoyLs1RnBQ
	 3hI1TUZPvcv0wUNdz7lvmh6yV9xjQyEEgBwL4VaFVO6f5DaDS1EN002XeBlTl/3nIZ
	 ESitHEAvo/Td6xMh19gW7Xf9LS8PoQZ2wjJJgg4NfaYW8k8qFMi0eoi2H+9Z0BLPSO
	 UpSs8207PQNBTZCwMoiVP4kNBwE+zC461C4uFRpI2f2Hma1MSzkRnZviL7bMuZ78ee
	 V/9JZ6zwwVMYA==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id E39021F42D;
	Fri,  3 Jul 2026 15:14:26 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri,  3 Jul 2026 15:14:24 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.198.56.105])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gsCNb6Flsz1Q8W;
	Fri, 03 Jul 2026 15:14:23 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Abel Vesa <abel.vesa@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Adam Ford <aford173@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Brian Masney <bmasney@redhat.com>,
	Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] clk: imx: Add check for kcalloc
Date: Fri,  3 Jul 2026 15:13:38 +0300
Message-Id: <20260703121338.25747-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/07/03 11:40:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: adiupina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 112 0.3.112 7c8d497b0e572fbfa504a2ee62037c045a8cb4ec, {date_rfc_vio_soft_silent}, {Tracking_ml_letters}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204227 [Jul 03 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/07/03 10:45:00 #28371015
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/07/03 11:40:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

commit ed713e2bc093239ccd380c2ce8ae9e4162f5c037 upstream.

As the potential failure of the kcalloc(),
it should be better to check it in order to
avoid the dereference of the NULL pointer.

Fixes: 379c9a24cc23 ("clk: imx: Fix reparenting of UARTs not associated with stdout")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Link: https://lore.kernel.org/r/20220310080257.1988412-1-jiasheng@iscas.ac.cn
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
Backport fix for CVE-2022-3114
 drivers/clk/imx/clk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index d4cf0c7045ab2..be0493e5b494e 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -173,6 +173,8 @@ void imx_register_uart_clocks(unsigned int clk_count)
 		int i;
 
 		imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
+		if (!imx_uart_clocks)
+			return;
 
 		if (!of_stdout)
 			return;
-- 
2.47.3
