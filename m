Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363506;
	b=q46cwSJQdQokD/LjzWnNJHvve4udr6dhnZADvIFaWMXoWvYc5i3JTeGjdHnyAHTojZlW
	 k03nWRGV2qe/HCaR0h0Fl/EysOcKQPHQVKSKExlUkV7AS+Kfkr/jY0djXHdV9v/I9qPIy
	 OhMj3cOes5EoqGE7o6A/G90fG+ASDILl24J08ji9h/OPRjq5sIGBB78mGSZbR4rrzw15B
	 BA31ywTDASkx3ugZYf3xh5Knl1J3QjSrOpYSzTeO7VT/ajrAtjCPkyQolsFdIOP8+r38g
	 lumaeNXgA4NCJSH0BC+cseneWLBVnW7I8PeK+QsGn4ZAJe6VrrSBE7xhDmu/CB/EhyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363506;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Ye7lz5yPBlTKRp6rmMII9eO+wDyB35KVo86X+7Ajtzo=;
	b=d3pH6bPydNsVlQHPnfymON+bJSEHao+SM0EKtVcCsy/yFdKVKrMS3SO3ZP99lYp+pLsH
	 78U6Rd71XGSDcWTDYOVvTGUjExWwo108bidJaIVgQQWri3CyCKiOt2175Kja61XYPcQoN
	 +iX3pKkPyAm8uD8spIm9ALUT/LG3qSt8HQSIlTuZVSvWdHXX7mHR345qQ9S3hJf2e4EJX
	 QsT4g7T75Hyq5eXy7VGlgI2X28mMDvRPCMlKLndaKFytQWM60rthRBkPwpJmr0c45HKIi
	 Z+p//5BdJtTRwbjOQ+NH8FPFmkM56ExCctzn1H4+MtzgSwkC8DUJFsT6QznC4J6ulig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=b0o0iOd5;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992BA606A330;
	Sun, 22 Nov 2026 16:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 992BA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=b0o0iOd5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ye
	7lz5yPBlTKRp6rmMII9eO+wDyB35KVo86X+7Ajtzo=; b=b0o0iOd55F4sYi1Cp/
	+iyjxCEW8t6PUP0EwbBkWKThprgDS3tXNdAowsko/gKcmhFQ0zFupDo+TpnE3Zqb
	KlrsKtx/eaC7SI/fO20weCX27Pmaz3nbHV1Y5AVoxS5EeACVwifJwo1I0MhJeTer
	Tjo/34Cb71pq7Xzv9NUO1f5CI=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X+maEgNrRg7sIw--.45840S2;
	Mon, 23 Nov 2026 00:04:45 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: propagate optional GPIO errors in SPI probe
Date: Mon, 23 Nov 2026 00:04:42 +0800
Message-ID: <20261122160442.519858-1-zihengw03@163.com>
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+maEgNrRg7sIw--.45840S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWxZw1DWr4fKr1xWrWruFg_yoW8WFW3pF
	47GFZxKr1rCFy8Xa97XF4rAFyFya1YyrWjgFW0g34rZa17Xr1fKw1S9FWaqF12qas5JFWF
	qF43trWUWFykC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyXdUUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7h1Hl2sDEp2lXQAA38

wilc_parse_gpios() treats ERR_PTR() from the optional enable and reset
GPIOs as valid descriptors. This loses errors such as -EPROBE_DEFER and
lets probe continue without the required power/reset sequence.

Propagate optional GPIO errors so probe deferral works correctly.

Found by LLM-assisted static analysis. Build tested with allmodconfig;
no runtime test on the affected hardware.

Fixes: ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index e40b829f7..97aad9ace 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -169,6 +169,9 @@ static int wilc_parse_gpios(struct wilc *wilc)
 	/* get ENABLE pin and deassert it (if it is defined): */
 	gpios->enable = devm_gpiod_get_optional(&spi->dev,
 						"enable", GPIOD_OUT_LOW);
+	if (IS_ERR(gpios->enable))
+		return PTR_ERR(gpios->enable);
+
 	/* get RESET pin and assert it (if it is defined): */
 	if (gpios->enable) {
 		/* if enable pin exists, reset must exist as well */
@@ -181,6 +184,8 @@ static int wilc_parse_gpios(struct wilc *wilc)
 	} else {
 		gpios->reset = devm_gpiod_get_optional(&spi->dev,
 						       "reset", GPIOD_OUT_HIGH);
+		if (IS_ERR(gpios->reset))
+			return PTR_ERR(gpios->reset);
 	}
 	return 0;
 }

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

