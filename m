Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196137;
	b=lX730t6kiWi8M26mrY6iya79TVuS63NxbDpxln/nYqDdZUnKWbhD+lMXUzg0ENNneY16
	 jPTZR2AsFnnLjiK4lOvSS73EbGUi1Gcgg5qJCA1jTup5QVjhQ66PFZ8WbULCFTE3G8qxq
	 pT3/1v1TaDZv1jnE94C/E2rZ8iCyuDf9zNK4dVFN5crEPQ1oNXP0AMngBG6uSLs7ELPZG
	 x/88aS7F3pEyGVzRcCGpbwZa/P8c4yVxlg8p+vsQyzqPcTwRpC4lIZdHZVVD9z+1o0ZKG
	 jvXdbxXp3MNNYckp0QS4li60rxj9FZGDRBDNu0RrywU3uVq4xMNSALa5z+Lza0a/DpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196137;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=exfjPLmiPr/gH2qdpIB7g+QBoVPsjOIjS8DPBZRkz+M=;
	b=UMLP20eRPU9kNgR5SbFxiIV7PstIEB0hQnl5hfHf6CaFFLnO1cZB4sBIb4hxZtyIJjEB
	 y4/VSlpfq1Ce3S9xP3zFo6HgZccBN/NZt94T2VUQDNBoET8DKNNIdTIfDel3qVzKqbhfs
	 qNe8vTT99HfuRBT3TWoMqePd+BDOjSqqkQZK43hhi7JxpI5It6x1GPp0aGlw7D9Y4FmFZ
	 McDNROWCYquJJ2Ite2Yp9lP9z9ev2W51VLX7rksCL4e1sjtPViG+6BHhmjvUFM9AH7ZGB
	 bgbF4CWvtvk44ZNB02B0yBgyn8iyyaPQ0Xx3hqSVs1yoKm4AfBO5ZhxySOuz5fSThHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=aoGZMJLd;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3360A261F;
	Fri, 20 Nov 2026 17:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F3360A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=aoGZMJLd
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5573c0ac0;
	Sat, 21 Nov 2026 01:35:31 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Linus Walleij <linusw@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: at91: Fix potential use-after-free on manual unbind
Date: Sat, 21 Nov 2026 01:35:29 +0800
Message-ID: <20261120173530.3924083-1-liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1fa0717f403a1kunmb9744555238baa
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTRhDVkgaGRgeSB9OHUMfTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=aoGZMJLdSHFbZhvNm6OwuS5+U286Sszstb3D07Cxh48kh6OX+6FGYzDtIy9ohgDC4O1u3MYpGsG+GUk6Y52pfDOn1GeECo/Ravcpjpi/Nw+4KSMPfEzNg889ESo5J+k/HH7kKyx3BLPzpacTJoBljOXLIQad6Jldu3OcSHsiPSk=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=exfjPLmiPr/gH2qdpIB7g+QBoVPsjOIjS8DPBZRkz+M=;
	h=date:mime-version:subject:message-id:from;

The built-in GPIO and pinctrl drivers share GPIO ranges and global bank
pointers but provide no teardown for those relationships. Manually
unbinding a GPIO bank frees its private data while pinctrl still holds
its embedded range, which is accessed during pinctrl cleanup.

Suppress the bind attributes for these non-removable SoC controllers
so userspace cannot trigger this unsupported teardown.

This issue was found by our static analysis tool under development.

Fixes: 6732ae5cb47c ("ARM: at91: add pinctrl support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/pinctrl/pinctrl-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 0a57ed51d4c9..81b58a7a44be 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1911,6 +1911,7 @@ static DEFINE_NOIRQ_DEV_PM_OPS(at91_gpio_pm_ops, at91_gpio_suspend, at91_gpio_re
 static struct platform_driver at91_gpio_driver = {
 	.driver = {
 		.name = "gpio-at91",
+		.suppress_bind_attrs = true,
 		.of_match_table = at91_gpio_of_match,
 		.pm = pm_sleep_ptr(&at91_gpio_pm_ops),
 	},
@@ -1920,6 +1921,7 @@ static struct platform_driver at91_gpio_driver = {
 static struct platform_driver at91_pinctrl_driver = {
 	.driver = {
 		.name = "pinctrl-at91",
+		.suppress_bind_attrs = true,
 		.of_match_table = at91_pinctrl_of_match,
 	},
 	.probe = at91_pinctrl_probe,

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
