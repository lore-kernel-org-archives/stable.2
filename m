Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555176;
	b=G6eShjzIPhT5Bf6gFGT+WZHrhVjlJascZKhZSiOGJKSNquih6xHAsgb+Ox4bN9oZnBcE
	 gZByQVgahd6acL4r+vWOxLKMQrARsl8PNZqJCUDlpH6z82zqXi43uTMDsYUFdo9hkozjL
	 Km8BIO45lU20GGMhvCnXgV4HIlkR3PA7bzdif1CQNPgu3EC3ySGwIV6WdKSaP+d3DNPhq
	 /KXGejBfwr0pt5pRlp+PqI3dgsKJqog1nTYJsXnKKURKbGf7ML1kiw5PWapER9W9ECgFR
	 50rraiPcI7LLy2d5oSAZLtkh/Tnm6BLQTs212/Eha6X+cJkwQGsW6+KT4w1Wljimzig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4ra5/SK4PyEv0el96ww+o2fa14mgOl6L/hKOXN+sF2E=;
	b=pAzvgOCn17r/NRuMfCGGNhoDCxSv1HWe0txpP+KHo4vQCKBK8WqFA23Tz9OD/StDd+4R
	 ky9OcvGt07Us0AWVwRjf3wt8ALN3yY8SQiQkQM8pPeZSYGODeSirtpO1D9UZ6sSXVnb+B
	 eVZAs1Slwi85brv6KqWtCLLkt3C+F45LXfKzaAR3tVhDQ6QZZNPI//B8ApTK4RsIOwjD/
	 amgqfxgkfCXXvzsirrYSC+nr89rbrKUGspQ9j36Fl0xnTjWwBzqG3ssFcrmX/dvcrBkm4
	 lnDdhpp0Swa8siiHUeqLdlJFgX3YQQG0iZw6FUfCBQo/sRKpNCjseO24op7tVVSX4PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6OKct70;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581E606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C581E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6OKct70
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dee593f18so815067f8f.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794555174; x=1795159974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ra5/SK4PyEv0el96ww+o2fa14mgOl6L/hKOXN+sF2E=;
        b=a6OKct70ZG6eI6DeH5mM5WUBeroQ1w0LP+arZrrCd6Io7STDuWpJP+2n2UwoDDcBnj
         gvjj+Dq2k2hlIoK2bnv0ws2Ia7164VCtjy/qh9ZEKT6KBtL4iVEtMGpE93J1jpxtzGk9
         M+8vafOtIVBHx3DVOtzQCMmJgKuz4knbz+NQlteHSFCkvgxY+Z0oVocE5PDChpiSZkgf
         4YwE/ul1QJ+8iE4u0v2g2gyowGWrZKUqrvpZoWJ1FTIA00BoEUcjnYPXAstvFtX77lw5
         KGOLcwQOcXjj2RZ2yNcD2pc494O/eMebz8dI3vebsZDUr5K3D8zu2WUcrcEcPssftSpP
         1miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555174; x=1795159974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ra5/SK4PyEv0el96ww+o2fa14mgOl6L/hKOXN+sF2E=;
        b=m+9oF1TDFE7zJCDMdZeR1+vjBK+Ew38kB6Uyu22nkPPWwRTUVVa+4sYnmVs8WGII8i
         j9Hj0AJr6WgX8zI71JGoUSj3JYI7btBrzM2i2Q0xDRBakvRwqvlOu7fjgtTthFuxAS5I
         oRF2Cbea4zCsLhDXqjyeBezTpm4/0H8SD936mXXWrloUpl3SwYeVYtHhbWl2zsyFsJmX
         5AoCF0pvxyxu31LSagBj8OBASYlB7UKaU91mfmGXxFD0P3Fs3xeRCoxU4RkjbygOjyq3
         8XNp5AfKgtBtcFz0IaMPbtg69fm80cex3BqV4mvUlYVnS+EBH17kldx84nJe23FGoE7Z
         4jwQ==
X-Forwarded-Encrypted: i=1; AL+hErGCrwN0BLy8zVAvZ6i8NtMWCWLvA6psZjt7jfMGROnFVtK9cMBrHpjBJ5p4fwJq2fAiWdDx258=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nLcsbOHTzqdB0G5w94FnbJcHqr46+MsEyL2NHhvk/uwuIql2X
	f77CLt30CxYM62DjrSCOZg5fv94kLKrkA26w1Z/XSPwPARfJGIWcPRuz
X-Gm-Gg: AYBFou1KabkfCHshc0iiapUB7UdMXuRE9BpNOyxuYARdkDjGV2YNffBZkDbEwlWn46v
	n6NMwLz7HvfUX8psnNyieQ37CsXH0qHYIOsqt4M65tHdzYkDfxS7kSyqOYIGFjcfnBP659PLudG
	KchBukR1E67VKXBOjYaaQ58AJY1Zs2OicrBO2HDp8zGEHu1RX9/Pc8F3pdU/qfo6Ps8kjEVfUK9
	55XCuz791nnsbWK+enNexZr0RNmGpTJvBw2SB5y8GMe0KmgL4u2nM+6+lrhJ4GpFC98fQ22W6T+
	OabI+BzV41hQEdBUmNphSFseUh8O1Nm8qOUDkFC8wFWc60sqWvCcKMVz13001h8f1MbautoqPBn
	NGprNZglAnY+8F1tIioFriFok9JJyshmMstGafe6VHh8roaeTKQrRE5oyCupSJvryD0MhxOKnes
	d80/OfA/Mvv3/B6Vlu1x5Lo2Y/dF7u9ege7PO3t6fs15IpH/8/aLgkO5kK0gb3YhlKriYzrzZnO
	+AmxIn3mCjUeJp+Ldskoazzoy/vc7Xdsm3knH6Mydoq6WkTVy9h4iPwSieCShlwhDaL5OsTdYhx
	ZSly/1GM9nq2SkrYqe9H+KDaSUg7wXz/Yq4=
X-Received: by 2002:a05:6000:98c:b0:491:49c2:3b3 with SMTP id ffacd0b85a97d-49c71d48644mr3357985f8f.51.1794555174171;
        Thu, 12 Nov 2026 23:32:54 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223a29sm3799903f8f.8.2026.11.12.23.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:32:53 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] i2c: imx: return -ENXIO at once when a DMA write is not acknowledged
Date: Fri, 13 Nov 2026 08:32:50 +0100
Message-ID: <20261113073250.1037215-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113073250.1037215-1-mehmet.fide@gmail.com>
References: <20261113073250.1037215-1-mehmet.fide@gmail.com>
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

When the address of a DMA write is not acknowledged the controller
raises its interrupt and no DMA request, so i2c_imx_dma_write() blocks
for DMA_TIMEOUT (1 s) and returns -ETIMEDOUT, where the interrupt driven
write returns -ENXIO.

Let the interrupt handler end the wait when it sees a missing
acknowledge during a DMA write, and return -ENXIO. No interrupt arrives
while the bytes of a DMA write are acknowledged, so that path does not
change.

Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/i2c/busses/i2c-imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1987a0fd8132..09934f3b13ef 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1108,6 +1108,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
 	switch (i2c_imx->state) {
 	case IMX_I2C_STATE_DMA:
 		i2c_imx->i2csr = status;
+		if ((status & I2SR_RXAK) &&
+		    i2c_imx->dma->dma_transfer_dir == DMA_MEM_TO_DEV)
+			complete(&i2c_imx->dma->cmd_complete);
 		wake_up(&i2c_imx->queue);
 		break;
 
@@ -1225,6 +1228,11 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 		return -ETIMEDOUT;
 	}
 
+	if (i2c_imx->i2csr & I2SR_RXAK) {
+		dmaengine_terminate_sync(dma->chan_using);
+		return -ENXIO;
+	}
+
 	/* Waiting for transfer complete. */
 	while (1) {
 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
-- 
2.56.0

