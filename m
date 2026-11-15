Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794735195;
	b=urzyo4fuomrPXRxgt0EzK7T4cIVvPn9dm7LEY+Xi2lJna6pPuBeuugzw80HAWr71DBX/
	 OyIIm3/HrBjiQ0/tyT//fKxdqUdOTq++jd5Gc6GYpxhEPpFBx441PKcRWHJ6+QzzqPZ6Z
	 UN0yyDvcdLLRY5IqJrJ0ZYGaJH8g0vp8OrgpL/uK+HoljelUPf0X6i/HwmpnF5S/aqEpl
	 WMFxkLsW2YuNTGKOtPQbIhvt8nL4AjOEKU3F1KV5l2w/1j6+nJ8wwve5j2FONLTKW6dZJ
	 Q7J2szeIWLbG9L0wEupJYqRr6SvyDaLZHtALvx+AhQwTE1iDcJ4QSrXE+HiZZQ+YTig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=R2O9ixsjiKLUJuRb29OcTSyZsQI1rKD89T0Os+kzNHA=;
	b=NAs2/ojyUm5IeaLD7KgqHabFpQn3xlfZvwHZGC7DCcXae5rIlTxuU4T8/JcmSmevmtn8
	 antv3xqNSYeQpRwacnskytdrGC5jt3UwOuHHVzDABVHZ4HKxFpHZ42RBKlH+pHHShJnpK
	 ct5KmTYbo5ynBIbqnxmG7KG7ke/8iGxS00rXJLijtM/cLcnM7Loll7Ccl17x30sBRgqYf
	 +DWo0OYqbrWRwsTo8OzVtIhxofS8A30M/x3nAkN2GI9jDY3gcJK7Xh+mWh1H9wNZSzFJH
	 xtlwfqrc41QtMaKJrtY/8cpNlxn+T5vvHnUh6PJiPVvsm8386PVIP8+fBk+PB7vnHAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fs/rvhwe";
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FF606A334
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 09:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B18FF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fs/rvhwe
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-7190d9bdb2cso2300016eaf.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794735194; x=1795339994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2O9ixsjiKLUJuRb29OcTSyZsQI1rKD89T0Os+kzNHA=;
        b=fs/rvhwefb3mMzLgtgmDlbzn+euuyqPVkCufyk0vazIKUe0xa7dm7d0OBBKCkgEdxD
         6kBuunuY6gtr/uoLEhtVHv3YQUOutY2hGXGAnR0A2WER43Zx55GOK5iCBeA/oUe+qHjA
         SL62uIko58yfVm5nfUXYhKkeeXv/PK/tbgbqPQQQxVTcoab2WTDU1mDzwMXjqk/atNTT
         estj09AaSWkb7Kz7KxATe0p2h/+pP89t6mzSPfG0H924LT1IEAD05pOKk2c02LynK+m8
         Cu8JFSZYqg2O2pO88MMlkbbUALW1jG/q6Y7EBBIR8Gv9UVhQFj0P2cWFOoACw4U8c6KR
         SmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794735194; x=1795339994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2O9ixsjiKLUJuRb29OcTSyZsQI1rKD89T0Os+kzNHA=;
        b=WyosMzuyNLyymKaDV1awLYByi7xW6Oc2RlvOXxdPuM1aiGmv3YoTl2f/sjv813HKDn
         dUmqpVN0+tF+Dx5VhP4RUR1CRn/rB20RUFMaojzi67bNF7wbkPtLXMDJPFVjMu3kUrrx
         J35x2ZJneksqz2qlAm7mkbTNk6BQy/F+LS3NlCAXF8ZENnnGgGnW6cq40DbvV0KDsj7Q
         drGRH7nsMVYuG9nqeg5T1K05JbIj2tOzipxfVvBmH5EOC1UG+QVfzJP3ExSWhvcrpN6W
         rvbeQ7Eru1AYZME2Bdbu/gbP2WDKGj8RP0e1rqFPYfzeMU+KBtSffYodqrYFgWJ/B3Z1
         vNJw==
X-Forwarded-Encrypted: i=1; AL+hErEFq1+qMv0eiVrHpgPkVTPhR4sQkBCpMbvjPKnTTiuiZaJnmH7Zw5BlwgfdhNKOlBxIg25RjIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z86MDPxPsoLc7Ki8hbJZnEv77LydcEFMWxC8pUaMbCzYESPKUVN
	3aKYcjo6KcqWrMbs7PZQiGmvukEzXaU+CCyjlGsnA3dYdrj4RiMSNr0smeEHZA==
X-Gm-Gg: AYBFou1pCTT5NqH+JdOGrnNjVgoqMsAl5zuiA/XdkkTQIX/Q2c6nWeYJqiOmO1Z8joW
	7g3BUD9dv0Y6tzyK6fsF3u6zR64xpyRYPIwLtG0junEeTyv8ixV7ASypeErOSFuLaHoMydGyIQZ
	scjLfHrECPng/W0hmh9x5uTkwSGriA5TZFpCOQJ8k2Hp1K5HxGzVqQHc+YVnp2dBtqAeO47i3tc
	aO8HjkBfwP44WQ9XhydO/ZO8LnnOvqvTRZvT982AfXc9II7HdfPXxNfHoXAUkeLJIboSHwKZYC2
	16pZZT39hpgibcKMxkT83E196tyY6vGgEGgRyZ+Gs3sAdtHdpqrN7LXKVax/Uobe6MYRt/Y6P5F
	91zpk9g4yAuyiOEpalH/AYLTfJ9K7DuHB4Q33IVjvdciStZXwVeEndPJSyDtstuf0HyVxdtCDOi
	Ei1lO7nIN19fJfD1dO3v9t5O9uPMp8tcd9ftJX9W3l8I8y0/4Ki4b/pVXyQU2fINQYrquTzsVwH
	LFz3bKp28zRvfsf0vmWCeyUxIU9fFoYN880CoCgNw8XOmr6ziVLNVNrVAY5YNIsHYwvi2LrwHvI
	eGAuqhRnmKrEcmgxY3mSgRZ45GQ/9j0YDhPhdWiIGjbsKknheH3/sfLHJxFJvd3coZWndIUzDqi
	1kj6yoLzGFEZxYY5EUpqrZxvYbImYDXGMLpUPJbZKvN20Jw8cweXBZjmzFw2uEpSqxOunSqxt7z
	dFj3hOe1feeJL8G2Qx6IJbHvrpkuiEEI+eSE1xcGdA20ulvzrVpms=
X-Received: by 2002:a05:6820:c3d8:b0:717:da:ba3f with SMTP id 006d021491bc7-71ab4fa7032mr3576066eaf.18.1794735193626;
        Sun, 15 Nov 2026 01:33:13 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab43347b9sm5933617eaf.12.2026.11.15.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 01:33:13 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 02:32:49 -0700
Subject: [PATCH v4 1/9] dmaengine: sun6i: fix physical channel index in
 interrupt handler
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-submit-sun6i-dma-lifetime-next-v1-v4-1-043cd476a45f@gmail.com>
References: <20261115-submit-sun6i-dma-lifetime-next-v1-v4-0-043cd476a45f@gmail.com>
In-Reply-To: <20261115-submit-sun6i-dma-lifetime-next-v1-v4-0-043cd476a45f@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>, 
 Maxime Ripard <mripard@kernel.org>, Jens Kuske <jenskuske@gmail.com>, 
 Jean-Francois Moine <moinejf@free.fr>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, 
 Chengfeng Ye <cyeaa@connect.ust.hk>, 
 Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

From: Hongling Zeng <zenghongling@kylinos.cn>

The interrupt handler iterates over register banks in the outer loop,
but the physical channel lookup uses only the inner loop index. It
therefore handles every bank as if it belonged to the first channels.

For controllers with eight channels per bank, interrupts from channels
8 and above are routed to channels 0-7. On A733, each bank covers one
channel, so every interrupt is routed to channel 0. This can falsely
complete descriptors for unrelated channels and corrupt their data.

Use the absolute channel index, calculated from the bank number and the
controller's configured number of channels per bank.

Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
[james: use the configured bank size and describe the A733 case]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/sun6i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a57f530c6f70..885cb237b2b9 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -605,7 +605,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 		sun6i_write_irq_stat(sdev, i, status);
 
 		for (j = 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
-			pchan = sdev->pchans + j;
+			pchan = sdev->pchans + i * sdev->cfg->num_channels_per_reg + j;
 			vchan = pchan->vchan;
 			if (vchan && (status & vchan->irq_type)) {
 				if (vchan->cyclic) {

-- 
2.53.0

