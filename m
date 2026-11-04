Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802991;
	b=q4RNr0x2vL30htoptGi4VMdX0zS4WDxcw0ulUvm8EGs5/5xjRLJB4JkOi++yToJtw2hv
	 7EF17Naf6N+8/VjaVb2kzvbmesa283pBDyxLTsT/H40xuoQk56goRDn/i1YJFLbKz8plw
	 MvotyaF0PmWpJI+ESrDYU0goNycyxhfjQjzyPpoHpgcPPdG3mCv9ELwXCi3Rz4ox+AxAZ
	 GAW35Z9yT9DObhanD67AcBIrCDQbLWfv6G8K1Zdr9ol0FBmVw+dgyh4hoLRz6ShPk5TnY
	 gCZ2na2ShSRAArfcYCkvsnDiayeMa2foOUqqeNXomoIOVWsKIXm5aHycReUMv/jE7jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UsTSTNr9Wticc38e58ZIWY5uITUM7R+lCgEyKvDw3nQ=;
	b=BZkSmOX2SqimZtDjYjHwttxv6t+bsBOLSVPnOrNrHaXcuipSpiFpcs/FOrJsTKUiZj89
	 dVNHNWTA+fV1nRnfWzg9CxGgfZiWM4ll++A1WnRb5cGFfX2VhXGxk+F5XW17uayS5YVpG
	 B5AOkqZ6YJNneWL8sbC7bRedDp+sewLC8FkNVdf55pgXOz2srKRi1GCRAMrNdEE0oNmRP
	 NFtt9/0SfMN65G2SCzamxI75ZQdSyloz22M64ejz7zgaaXe+TToa2GezSJukiQWUU0JFh
	 +BsDvZqONtHO1gyvICf/3fQbnu0GXboi8g6RwtYWex8sSYadYUIz0Jy0vi+dgSonH7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hvss5G9m;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E714606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E714606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hvss5G9m
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36d6765756fso495654eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793802990; x=1794407790; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UsTSTNr9Wticc38e58ZIWY5uITUM7R+lCgEyKvDw3nQ=;
        b=Hvss5G9mBXHoAafGDDQUN4FuXzGK2I4F28BMoy1eiwhT/Ce+0lcAUND/RSMKtLy5gv
         CRILA6BnD0J2HIQj41dFspHqJggQedsp/mIiEJX2bqkxwK9kXC2LXdJ//pX9P0I8/VGl
         J+Pg2976Iig95d9xreihq1sFJBOpltsLKsrefYl+1CmiS1Sq506b2jJLXqKF8oHJve8l
         mxrZhRIO7tEVjZjDrQrtGurLoZW4zuzDrhYXJzsnqHxHcr7ErpTrUpvs355jM3IsI3sx
         KEKO4d6t4Q4DfIIXOWGunuATiIAUQL7TLaECVXYfZUSAXX8K7xV5CWsRqyYnmrWXIJbv
         H9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802990; x=1794407790;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UsTSTNr9Wticc38e58ZIWY5uITUM7R+lCgEyKvDw3nQ=;
        b=GZJuKrhBJyje0Z77vkkMxSjWNBVJdHqpl0opM1vmLKdXsTXmH4ibknocJ/UPpIoX3m
         tBwzQANmjT1f5vwx4fNXqj48q6A2NRcfRWNpfqN0mVwcgSuxyJqd6LqavjPsHqlpFZz+
         cDQD3G9S05+9WRsqx7JvOXQjRAv9wmyc8/ZejS89l15+eaLt9R+jBnGBRxDXSW7KR+d9
         33kgUlgDBo95M7kOFhjmrdvFhmM86oSgvuE3SXdV5/Jdm0AmVYk2XBwxKfqrPTULxUqb
         1ZggfdFwUDKu3deGhxjNTQDY37WYFnxWRZFgl5tMGtuisEYg7/djjwS2o02nE47WlXLi
         Uztw==
X-Forwarded-Encrypted: i=1; AKwUvBxMoDE1N3UQVW8rW1x+8WeLK23xXOGQwJWRiJCTiEmchYXah1PuWRHhteSb0iefh3oiAkD13u4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Syty+fnpN2vNvopDY1jWJSL2TJWHZky8uh1Vu3Oil7o4WKfm2
	C6HaEODosVJNhpSSPRyWJ1AcIYluWVQSKh3kqog06bmH5dhYZXABj/5A
X-Gm-Gg: AYBFou1F1+DX+UN5a5ppSh2geuAfkpBFhtBux+uAQvak4rxWcUwUOX9Kt5P/woZSv26
	/OFY/H6P3FE7XU4B8qD2zoTMvUd/APIk20cuEhKKRL1iFYcuz+LYhCN5T8KtYfXmrSqwV/5nAD3
	ufqPp2wlPm/MIvcLG9m970ok3l+PWoEeLVHjaOL5YV7EF5KBvcEkjvaDvJxoWzry36gIpCnbfyG
	0mvvbnjvpaCsErfuYQizyscnG/X/1BLipsLgfOmr8M9L3ccqUhIrNKtQVwueJ1LsktORucKHOJK
	QcID6GBCGZfwoJCwk0rL1FGryDnKzH0OAaeIjUGKi3GkaGWwe+/SL+e0d05Jqzbjj7Rys+3/EC+
	onpSPazoyMkks2r0C+gtibD37RRQiVON6RwXkaD1LtpUGPmooJuQ3kA72k5pUpFYuO3XJ6BTdQa
	WRhQSC8h20tknkslkIUfbogok5FSNQXwzISgHty2MOIP28mPJc4cLt63sD2ROyog15IkYaBGi2F
	nuZ5yuYAEKOsxCvChCRq7qjrfXS+cL6zJJt682YJZ2xqkfQKOrCCv854tLa38xLtVSop//7Mnkf
	Cy7tC52RaXSWcO1FtOtI26FGUDgC6fJ/KSrN03FNmbtlFpPMOOIJAkPyWws=
X-Received: by 2002:a05:693c:6092:b0:35e:5ca:e0df with SMTP id 5a478bee46e88-36a424609c2mr29593192eec.35.1793802990157;
        Wed, 04 Nov 2026 06:36:30 -0800 (PST)
Received: from [127.0.1.1] (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm6208241eec.5.2026.11.04.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:36:28 -0800 (PST)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Wed, 04 Nov 2026 22:36:11 +0800
Subject: [PATCH] net: ethernet: mtk_wed: fix double free in
 mtk_wed_rx_reset
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
Message-Id: <20261104-double-free-v1-1-efa52326702f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBRF0a3IH2uiRRO2IgZaD18EaRGJ2Ltie
 Ab3XuThGJ7K6CKHgz0vc4CMI7JDM/cQ3AaTSpSWMslEu+xmgugcIIw2RW5VnhZWUyhWh47P71b
 Vv/1uRtjtXdB9Pyt+IfBvAAAA
X-Change-ID: 20261104-double-free-b6b95c2539c6
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Zhi-Jun You <hujy652@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793802984; l=1229;
 i=hujy652@gmail.com; s=20261026; h=from:subject:message-id;
 bh=BAz+fNM/Iyf94+H1t6m97KLkVam+zChfLqMn+estExE=;
 b=n902yQuPJrVcZaUjXryGj97qgtl3JwbpauFUgWDNdIsyHcSg+2Qqp6KztWjzVWsc0l44pJhUw
 UWdl6ZEPjM4AWQvGOzBGd31a3rOHoTI09O+BKXmwl4p8a63U8pOu72N
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=uXjqvnRsKEfHEyUr63sOg4fEJIDs4AmiW/rB1cWarXg=

mtk_wed_free_rx_buffer already calls mtk_wed_hwrro_free_buffer but
mtk_wed_rx_reset calls both subsequently. This would cause double free
because dma_free_coherent doesn't set freed desc to NULL.

Fix this by removing the mtk_wed_hwrro_free_buffer in mtk_wed_rx_reset.

Compile tested only because I don't own v3 hardware.

Fixes: 1543b8ff02f0 ("net: ethernet: mtk_wed: add wed 3.0 reset support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/map/216156
Cc: stable@vger.kernel.org
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index f40ac5794341..5e9674c9e63a 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1723,7 +1723,6 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
 				   false);
 	}
 	mtk_wed_free_rx_buffer(dev);
-	mtk_wed_hwrro_free_buffer(dev);
 
 	return 0;
 }

---
base-commit: 11140c51df12e594d6bf2c8d2af5dec63b0219ac
change-id: 20261104-double-free-b6b95c2539c6

Best regards,
--  
Zhi-Jun You <hujy652@gmail.com>

