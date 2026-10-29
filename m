Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254481;
	b=iJelNIckr72KaWPmnl2qutIa7VqxAGuxQG16MtzWGYCYVxApW+OSSLt5wFEpgbGtKzpk
	 rw5gw/vDroSoc5e+6pZlhZ/jQc32ALFislF/zh180F4WdsEcuMsp+ATo1G/qVqcvujG2P
	 HWiEklXMdaRNbxaqQCV7FvlDVMe9Nua1+PGUAwoTMBvfPhkYvOtZ+5yzo5LaZgO78oYA1
	 zl3SiHCAXSEM6hOFnH4sTtetQ/6xCCGyVEHlr0BHHGJ2wVn8z3V696wVgKjM3ocW3OQPv
	 lPvOuO2XB5hUP704YBeJJPBZMd1L9aB3ssO3bwJ+FTz5qg9/UqrQSKs4S7IAH278h0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ivEqINlh7ZkJrAoGIP7Qk/ck2w+8V1ulipYhp9Ae/DE=;
	b=1U8FbHwDa8cDhFqtlKfYQ9H/U2rtV6gyGAGKrb0ek+azVJRC/Kj033n5l9/Ip6H3vMwX
	 45HGduIHCeA9eYhfwx0wTCzo8uDPLeM0Uc4Mzp3F0jtZXVcOqCbSPIIpB79q370aroXBk
	 SiqliG05WIq2690MKcosBjcMeoaXb9m7DFteu+2keELW0JlYMViyLqzmPichEo5ddV5fx
	 5Fe0o5pkyDXAz4KO/wQtNEOwF9KNtSm8p92C8yAcUSUwLmgQ9fJB+CroRAECiX731mcAs
	 qVxbVrDLZAxGsmlYKmu0fOL+Yn7SCxsnPVBBU6pCGIlfvWLAMMM9Eh63wzJeB+rEJKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwY+C7Rw;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368B606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1368B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LwY+C7Rw
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so15123685e9.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793254479; x=1793859279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivEqINlh7ZkJrAoGIP7Qk/ck2w+8V1ulipYhp9Ae/DE=;
        b=LwY+C7RwjoAzSYAQqJJgoj7sJsD3GVBFQOiYIFCE69SQJxXZDaHHi37eO1pT6YYceZ
         vZxTMok1DXPfg10dfo33wGjKI7pivZrg89y17+t08DgkvDVShpi05v4gkmKk14fkA9oJ
         oeQIB/1RHXZP979uSUjNX6IPjavD33d/9VzVW5Yh4jh7gOvyJw1qkcVlj7ABAl74DCJJ
         kNoeyfQdp+3kieiHvy6oYTJYbhkW/XLJYATNI40WiHmm5fc3pVAgsy1wwBSIS2COhmk/
         aC77OBQ0ZARdYK+gR8n/QBScxxVuRDZViItMPooS9pdl4YQYsxWp+7DuINUVGmFUrsIK
         67cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254479; x=1793859279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivEqINlh7ZkJrAoGIP7Qk/ck2w+8V1ulipYhp9Ae/DE=;
        b=iHT/5wIQ2iWOKOesCJhZ4r0Bj2wsJRedCXP72gPrM7ikVNa8BQjOkH36kXGPVqS98V
         uzXBnMveNoUnYWKi23gWj+pKNmvgoWFIjigO/FqEW6rbfeEKB/dy4AfLFejCZvR0DY1r
         oAgMgbCM8shCu1cUgkQuUqY/tU/uGUSFgVmp3DY35VeJjbFK91sgfAy8hQpcCs8jjUg/
         N+RUva9fyjh+Fv61QuW5/tushCV/DIJ/E9wIrgLQ3zTNfUYPPF+D74BL/rXSJxp2XlOn
         UoVYZr4pyWeXNtGVD3mbMIHfOQkGCBeCYWZk14n+u7ujnr2Xh0LPSaiSzH1rT/OVPx71
         WUSQ==
X-Gm-Message-State: AFq9FYKXfOjK7HNKajT1O7KA8qOWUnUvAXpiDs5u/a6g2EZ/PPcHZ861
	DgKfcHwBfHI3AkBEHFrdeE1HOgcM0i4RU075HO/F3ijpBJwBiXdiyaILAc+BA90iCW0=
X-Gm-Gg: AYBFou3kng8vkC3a7adR8LlhUBCZb2XNXVszj/DafAul0i7elucSXn0h0CZLyYSS/9q
	nduWhs+KBQKQ3pFcy5RCgOCeSllLTD44Yo48QlWlpGUrWhNn38E4zHp+Mx2qkiCb45KYjkYWi7F
	CnBWjhSC+Q6IfLPuY9KeE9a9AQNPgcd+Ll9M1sVvj15QrAg1GcgVuiuJ/4iy3jkIBpe4tSDj6Mx
	8AuCUN6tW8OuwuiP60R/SmkIvvTd8JIJCvnDpkmYZyDjgbPZwR4Xq0SFZ/KNMwi9vJZeNpUdo8J
	I4IHNlU251czyUrDy75HgaePm27DvK9pUd7Nrd1sUCQiAkzmbIggi8jtkjJGYQa/l4hoH75/svy
	dxSH9RARu711L32IqYgW5yqvo/MGUeSwsiCblLWBeDc6NMCHE8HC5Dzd3jRZYJKFVjvKKkOvLWw
	oX5Bt7VX7PNMFq6EN61MdbOLsnjZ2JbdrbpL1bfoGQRDoTDoECv8md4hynZA00q8hSEc5N0ZHMC
	TSQFGQD17zW8dqtBvb16NuXHZ9wSKYozBaBTxLvEfEgZ4qDf6FJ432lLhpuIBc6hscMXnfEgl/V
	lDpIMbY64vvXVkN5W9bTKF3yRMVp/otQTmXgxygbxjjTECI3B07vivnt4NeGBrMnsQ0s/LbtexJ
	RDkonSr+Q+lOjHLilgCcj1iujDNPilAHwx3XVWdV8FavZctwwx+wMVPHWExFrvS5/xaziJ117JS
	8J0rOsnsOb0pRPB5peXL53REEY8tqRQWgloITMhRkB6WUleG382/um
X-Received: by 2002:a05:6000:160e:b0:48e:888:36b4 with SMTP id ffacd0b85a97d-48e5d5c3867mr7911286f8f.9.1793254479252;
        Wed, 28 Oct 2026 23:14:39 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aead-eb01-e474-b637-02f8-0d63.310.pool.telefonica.de. [2a02:3100:aead:eb01:e474:b637:2f8:d63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm32614741f8f.25.2026.10.28.23.14.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 23:14:38 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Yi Yang <yiyang13@huawei.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 5.10.y] serial: tegra: Add missing clk_disable_unprepare() in tegra_uart_hw_init()
Date: Thu, 29 Oct 2026 07:14:27 +0100
Message-Id: <20261029061427.27973-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Yi Yang <yiyang13@huawei.com>

commit 38f28cfe9d08e3a47ef008798b275fef8118fc20 upstream.

Add the missing clk_disable_unprepare() before return from
tegra_uart_hw_init() in the error handling path.
When request_irq() fails in tegra_uart_startup(), 'tup->uart_clk'
has been enabled, fix it by adding clk_disable_unprepare().

Fixes: cc9ca4d95846 ("serial: tegra: Only print FIFO error message when an error occurs")
Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Link: https://lore.kernel.org/r/20221126020852.113378-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
This fix is already in 5.15.y and newer stable trees, and applies cleanly
to 5.10.y.

Tested on the 5.10.273 review queue (6aa0165f18f12) in arm64 Tegra210
QEMU across the FIFO timeout, baud-rate tolerance, and request_irq()
error paths. Without the fix, each failed open() leaks +1 on the UART
clock's clk_enable_count and clk_prepare_count. With the fix, both
counts return to 0.

 drivers/tty/serial/serial-tegra.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ccc6106a5a253..3b86272cdf390 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1060,6 +1060,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	if (tup->cdata->fifo_mode_enable_status) {
 		ret = tegra_uart_wait_fifo_mode_enabled(tup);
 		if (ret < 0) {
+			clk_disable_unprepare(tup->uart_clk);
 			dev_err(tup->uport.dev,
 				"Failed to enable FIFO mode: %d\n", ret);
 			return ret;
@@ -1081,6 +1082,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 */
 	ret = tegra_set_baudrate(tup, TEGRA_UART_DEFAULT_BAUD);
 	if (ret < 0) {
+		clk_disable_unprepare(tup->uart_clk);
 		dev_err(tup->uport.dev, "Failed to set baud rate\n");
 		return ret;
 	}
@@ -1240,10 +1242,13 @@ static int tegra_uart_startup(struct uart_port *u)
 				dev_name(u->dev), tup);
 	if (ret < 0) {
 		dev_err(u->dev, "Failed to register ISR for IRQ %d\n", u->irq);
-		goto fail_hw_init;
+		goto fail_request_irq;
 	}
 	return 0;
 
+fail_request_irq:
+	/* tup->uart_clk is already enabled in tegra_uart_hw_init */
+	clk_disable_unprepare(tup->uart_clk);
 fail_hw_init:
 	if (!tup->use_rx_pio)
 		tegra_uart_dma_channel_free(tup, true);
-- 
2.50.1
