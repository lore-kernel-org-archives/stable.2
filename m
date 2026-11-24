Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528727;
	b=ivIZOaYnnTxcjouJ9dbuyW4PuFkMn2xn7yhe/m+s89z5i5KzUfDcaQl1Z7tx66jR8SWI
	 fpseTB9hz0/UPFzNI4Vqj9+f4tbD/E60KQ50SFK1UfT3uXg2ogX3zTHn+XEi2mJFxS+2P
	 WfrEdWfnIXfreK7XgnLu5LH/pfIH68FlI+ALi3tsvm4GIxjBHUA5g75hG5L1b7eTZGf4l
	 BEyiUHff7f5sX+l+XLnXs7tgg8OFk3Hl9C+/u5VGIDo79cTlvNdf6UQAlxYZlPqCi1eZE
	 qJ7texFua41+XlOK/jZC88kmATuyxlB9icuANQVf2Qj/X70uAssbzm9w38wgwFZnOQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528727;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=ovezNbKq1di3ZHCw1znvhP+NWifa/caqVGbMLX51hiQ=;
	b=KMfIIr6E47pEUjSkSvfCfLFWRP6/hZ5hJxoEeFOqYRvCWLr3GBCbURJsMUaw+WTZb/AC
	 gG+uEAijQQUs5CvcqCpqcFF6WiX7+zkbVcgXrEnPb8xMZPpFGV7Kj9VMycJjHF94m4Vsk
	 SXF9Ep1e8AscipessIC+bsSUqUB3KMcC/R2gZojmKOIf9l6zTdJ4P7acb1fqGfiDU+CDG
	 KP50pDHRBQI7icqyLGeV1frl+0wQz5aiwEQcGLa3kM1IuOyVzOOXY6ty0xCrjgLIsbR5w
	 Hh9ivjmpxO+t33ryRzXH1SJ+u+RhLvRNtheaeY2KXlvgPNaxnKJyPw7Qg58tOLOu/ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=N7ngKo7Z;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3660606A337;
	Tue, 24 Nov 2026 13:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3660606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=N7ngKo7Z
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55d4cdb9b;
	Tue, 24 Nov 2026 21:58:34 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] gpio: aspeed: Fix potential coprocessor bank map leak
Date: Tue, 24 Nov 2026 21:58:32 +0800
Message-ID: <20261124135833.2275409-1-liguangshuo@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa20dd9e9d603a1kunmd236b143342496
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGh9DVh9OGk0dSU8dQ0NJHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=N7ngKo7ZCWnEgm4MR1UoljiLZqL54oYjinK4ncmiSoEaPirLBbsyo+85LUBwKLvBuarDaB8Q5pXvSaCApSG920C+GgMA71CLMTs9mzyz1KjCto5XKCAygIYxfuPQGONJcSRYbG+M8JAZqq1kwgw5mqO94kMa2z9zqcQuEsMxYF8=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=ovezNbKq1di3ZHCw1znvhP+NWifa/caqVGbMLX51hiQ=;
	h=date:mime-version:subject:message-id:from;

The coprocessor bank map is allocated lazily but is never freed when
the GPIO controller is removed. Its only owner is the device-managed
GPIO private data.

Allocate the map with the controller's managed resources before
registering the GPIO chip, so chip removal finishes before the map
is freed. Round up the bank count to cover a partial last bank.

This issue was found by our static analysis tool under development.

Fixes: a7ca13826e47 ("gpio: aspeed: Add interfaces for co-processor to grab GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Changes in v2:
  - Use a managed array allocation instead of a cleanup action.
  - Allocate before GPIO-chip registration so teardown callbacks finish
    before the bank map is freed.
  - Round up the array size to cover a partial last bank.

 drivers/gpio/gpio-aspeed.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 45e90ebaf078..8f66be7ff9b5 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -944,10 +944,6 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 	if (!aspeed_gpio_support_copro(gpio))
 		return -EOPNOTSUPP;
 
-	if (!gpio->cf_copro_bankmap)
-		gpio->cf_copro_bankmap = kzalloc(gpio->chip.ngpio >> 3, GFP_KERNEL);
-	if (!gpio->cf_copro_bankmap)
-		return -ENOMEM;
 	if (offset < 0 || offset > gpio->chip.ngpio)
 		return -EINVAL;
 	bindex = offset >> 3;
@@ -1381,6 +1377,14 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
 				gpio->config->llops->reg_bank_get(gpio, (i << 5), reg_rdata);
 	}
 
+	if (aspeed_gpio_support_copro(gpio)) {
+		gpio->cf_copro_bankmap = devm_kzalloc_objs(gpio->dev,
+							   *gpio->cf_copro_bankmap,
+							   DIV_ROUND_UP(gpio->chip.ngpio, 8));
+		if (!gpio->cf_copro_bankmap)
+			return -ENOMEM;
+	}
+
 	if (gpio->config->llops->privilege_init)
 		gpio->config->llops->privilege_init(gpio);
 

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.43.0

