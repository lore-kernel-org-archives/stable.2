Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379285;
	b=ZKmpnWRGMH14DSpOpKHff41AAAzgQgEUXX/EveC5CNgFp73J4fSbZqyAsz0D4ritLopJ
	 ZIifzamOJKXcW8nqVdWL2Fzt/qnfhMfoSXRfBhmMQCnJUaZpMdkUP2Va8I3gA9ptxVPjb
	 jV65k5wwRsAVVhIVvq1ss91AYCgDOQSDkFcjOX4lJ4c9qfnd9spNyEEm5NQzbWi6lnWoE
	 cp6Icxm3qF+rHV9EjOmdDPzmKfMZaDakDSLNS7r8zHBrr2MxYc3rZw5n5GPVon+3EPsI4
	 Ozv2C6j4BM3tcJCHg8Cygnq+JKxteVevenPTx9dbopZLQMkgQmtbcYLNfJVM+Z6tvEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379285;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=gqsTvJ7a41yrqqE2dPsUN6jUpWjVThA+jIrQQJW3MfE=;
	b=vlX9tznXM+MPuuFaH2QgNcTTGVvybrJvwhRqTD3V5cN4+hJbVCkIPJDoB/p1HoFMi1tZ
	 qFVmKJPdLNBXR2Ao3d5FTortpBeQK2mgpkOxgMw+zuoNVJyp3oHUbkltq2S2NkkoXuQ64
	 RiYWi7ZzMHeyjfJ0c+7Bd94ACBQSseoCtQMJnJzFOzvUdC/NF6SRS8tULjGoghz3lMOgv
	 xC12jvP4EWz+yrUMwBRN4bhaEUvMW/y09Wp0A8569JvCM5BHrI4q/U0JaVCFPCEkn7lIl
	 u69urwhy0hcJE3B3SOyfRX5VfarCOSCXzLv/614gW6pWVZLBIv4f1Sb8gtiFE/UJNJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PbHeaCVv;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C4606A321;
	Fri, 30 Oct 2026 16:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=PbHeaCVv
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f74f11b;
	Sat, 31 Oct 2026 00:54:33 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Lee Jones <lee@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	stable@vger.kernel.org,
	Support Opensource <support.opensource@diasemi.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mfd: da9055: Fix potential use-after-free during removal
Date: Sat, 31 Oct 2026 00:54:24 +0800
Message-ID: <770185795ca9b919a9609a329362253befa6d26a.1793377422.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
References: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa18dbc0a6403a1kunm46158e5a52a1c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSx9NVklKTBlCTE1OSB1IGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=PbHeaCVvvrXXrsiivjWdRruKkTkmTs+Crsd1ApkWew7M0oE+Wxk/4mwlDeRb11SmBVKJnGnt41w1WQiUznmMOYgtFdYdlKqyf6aMpN1U2BXfg3SxtRfUoQoJ/tFzG4jGbcqYhPNcoakomUKA3YGyeoSXzW5h0LAliZRqWaV9ZMc=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=gqsTvJ7a41yrqqE2dPsUN6jUpWjVThA+jIrQQJW3MfE=;
	h=date:mime-version:subject:message-id:from;

da9055_device_exit() deletes the IRQ chip before removing its children.
The onkey driver's remove callback then uses the freed IRQ-chip data to
look up its interrupt number. Remove the children before deleting the
IRQ chip.

This issue was found by our static analysis tool under development.

Fixes: 2896434cf272 ("mfd: DA9055 core driver")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed object with x86_64 defconfig plus COMPILE_TEST
and the driver dependencies (W=1).
No runtime or fault-injection testing was performed.

 drivers/mfd/da9055-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index 158590ad37d4..72820c153f23 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -393,8 +393,8 @@ int da9055_device_init(struct da9055 *da9055)
 
 void da9055_device_exit(struct da9055 *da9055)
 {
-	regmap_del_irq_chip(da9055->chip_irq, da9055->irq_data);
 	mfd_remove_devices(da9055->dev);
+	regmap_del_irq_chip(da9055->chip_irq, da9055->irq_data);
 }
 
 MODULE_DESCRIPTION("Core support for the DA9055 PMIC");
