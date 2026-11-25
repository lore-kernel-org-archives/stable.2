Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598746;
	b=4zd3UiwBG8QBCHhmJX6Ao6T+KyHug/pNlO24xexhpcPCcXQgi5gro4jatyLKjzaiy51Z
	 Nw92L6/OECAAkzmyeycmq/qqIdZeDThEQAKwgCpm7h8pH/vsfbyIN8MB8f6S4rE9joQoA
	 C5iPSa/CJKY4mp3l8qn5lt5EKEEoezPNE5jdytL5traD/mc8+LrKCbupDyq4anvhn5Gg3
	 5pMrAKJC6zy23UiHm4k1pvE7IY3HA4Z440PE320T084EM6MfGtuLZxr+tbwhlZf110SdR
	 W0EUMGQMqIfMfIRq4VZPO4TSReqneCaZKW5wjTbb0O90/7TENKXIJICgw1/BUlvvB1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
	b=YIZHsOQ3s0pk4KkXTYGRyLpmz8gtAYib0mu3TYg53FDkVidMqQW+aOJvNtoZ2LGO9cSR
	 MsYID/oN2BFbSUHcm5gHgjaUf+q/eAafo/kkALJA7B6+TgeXUvk9vlbgUUqY3IwCGu0Zc
	 Zrsn0bkl4TsPgeOK3653j25z9XE8yABfIhCg4JsUX7LoJwMUntVdPsp0oIUzaPHJvSpd/
	 0IeWUD9y/wzNiABjWT1ZSlVAAc/TFjrzu4UG7tMhpvXsNtqE/xgwMn3Rjl9EmYm2Rk7cP
	 tKCpFoKUchNgBXWs24cuSj0oIkYy98T9U/NNO8/MWvnBHdPtF0b5qoXZwz3t5wuROWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBMrm9gd;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F8606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F33F8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBMrm9gd
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cddc250d815so2171656a12.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795598745; x=1796203545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
        b=sBMrm9gdnqus0HEyZ36TPEXC7ztphsOoxttRcx58PwveXj4ts+/sEZ3Pm/8yQLq+4m
         pqiE1cUtwgmMxjyyEqI/KrkAg5MG3TWGdH1LxO4BdY/iAHEFgmy3yQVg7I29/MTVqMIs
         I7fOxdpjjiMPL/u1w1D8E79viUZD/8ZcSvyAugxA1Up/CqFm2BPlG6vnCrKj8pEmnvxg
         TCHaA4e7Au0f6q81Zfvsg3nmHG6KG+MBtr7qqQeqWbELDMi0GOwaRuqH2uMfCe8Nwz4N
         SrKiuqSmRcdurwl9gZHN9kpTjVe8v8WuFtJaYgZUo2tJuVdg1d6+3QH2DXtXegEpyZfP
         cW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598745; x=1796203545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MA+Kx+uKQP6OM3muhrQQ7gMLzt5UOS5UjDB/PUfvv7E=;
        b=YjCKYT+p+9DAM9lotSZ3Vb2treiZ4g44fY1P2e7EglaBSz9pHG1PFo5Wz2fG6thgC7
         xrmjzBaTV8IgV7OCwEuInBngMW2RxfxQp+zbK1VWjjdBS3mtSVE6+aDWPRwzkVK775g1
         bfagYObdpAAT01p0Jn0WJ8gRnclBDClJzfIAxKzLqdEl0CqPwpMWPEH5sJNCxnW+R9h8
         YRWEDnkmLCtpv6/vJoQyGii90sLcZoyt21hwLEIo7ba1sAoXN2kKLEwcfb2q9/BKgYKH
         xP3nZSujMwPTwyRNdxR7Ji3WDHEDIoRLdCs2R4I2tBpBUIU6gShFlUFh8zVpZiVgyK1x
         2g7Q==
X-Forwarded-Encrypted: i=1; AL+hErEGVe7JxYSYW/lvyBf/VEBNKczoUdZK1TkQOZXQYPIWR9NIXL3PtJQlYFDMrO0cnkDzOLPS+tw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TXNodv84jhvny3lqXKZ1bLEmsLlZ5Ae+Bh6jdqUa0Mbu7xma/
	G6hMlHiJTY4voVVceRWiVYjHWLt1eA9WMpQw12eSPFEl4o5RZ7B/V0A8
X-Gm-Gg: AZFdTZcTr+ExEgnwe+snYrBgq6g0oE2k6zD66+N+4xOjgjdG1JU1K48h4YYhigPucYP
	cpXB1/MXY0eC4Udgfmy1y6F+Rh+xDeKF4WC0ldcpL+O/P+1gA2tivhoRKCZUu8MMj2+eMoKS54k
	EISuSuQp4ZJ7CQgetG02scT19oV8PUoJaeurTQSvE4HMDkrtbLWHH6z7Y+0gyPc1tM9bavhNBIE
	rxRLL/8gpqpRZaZZo7dW0R+OhGcjfdCuJc86yaU+fu0kHTtxdZqpqgD5Cz/ZDXJzjAuWrrT/BZY
	ZWXNOUiWFjonBYxnYPqhc86By6Eo/C59QvRdkZGDwHo8NJLyp2h62PwUhJxxEq4kOAOWplzYNTm
	siH17mYjluCSA28W8/zzFpSJ5xnewpu1SqJSrY7ovnh4cX9k5ycis5unP5Z26Wdahf6tK6cO+rp
	2GHgfQ1ysa65vvdFZuDEEpmZZyOacTP0TAVgXMzV883LKMNbJw6vIN/eTMhnlw+DWdqSQOR3KIL
	dOdUQQm+w4qRlsCcLFX2rbyxXqgOUjZzXFd+/kd/YbSM71a/qM05pR6G3dfX9tkI29KW56Bm7up
	5aqW3bPjcvDmpg5cLLcjGkF56QW4hvMtGw==
X-Received: by 2002:a17:90b:2f0e:b0:3b4:fd89:5f97 with SMTP id 98e67ed59e1d1-3b4fd8969ffmr544920a91.33.1795598745341;
        Wed, 25 Nov 2026 01:25:45 -0800 (PST)
Received: from server225.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f142b8bsm80883155ad.70.2026.11.25.01.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:25:45 -0800 (PST)
From: Ping Li <leeonion.muyu@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ping Li <leeonion.muyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] mtd: rawnand: intel: declare NAND_USES_DMA
Date: Wed, 25 Nov 2026 17:25:36 +0800
Message-Id: <20261125092538.1938516-2-leeonion.muyu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125092538.1938516-1-leeonion.muyu@gmail.com>
References: <20261123070440.3060882-1-leeonion.muyu@gmail.com>
 <20261125092538.1938516-1-leeonion.muyu@gmail.com>
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

ebu_nand_read_page_hwecc()/ebu_nand_write_page_hwecc() feed the
page buffers provided by the NAND core straight to the DMA
engine, but the driver never declares NAND_USES_DMA.  Because of
this, nand_base cannot know the controller DMAs these buffers and
never bounces non-linear-map ones (see the use_bounce_buf logic
in nand_do_read_ops()/nand_do_write_ops()).

Non-linear-map buffers are not hypothetical here: mtdblock's
write cache is vmalloc'ed and UBIFS passes vmalloc'ed LPT buffers,
so such buffers can reach the controller's DMA engine, for which
they are not a valid dma_map_single() input.

Declare NAND_USES_DMA so that nand_base bounces non-linear-map
buffers through chip->data_buf, as the other DMA-capable
controllers (arasan, denali, meson, mtk, nuvoton...) already do.

Fixes: 0b1039f016e8a ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Ping Li <leeonion.muyu@gmail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index cfb4b231e067..1f493fb426d6 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -688,6 +688,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	nand = &ebu_host->chip;
 	nand->controller = &ebu_host->controller;
 	nand->controller->ops = &ebu_nand_controller_ops;
+	nand->options |= NAND_USES_DMA;
 
 	/* Scan to find existence of the device */
 	ret = nand_scan(&ebu_host->chip, 1);
-- 
2.34.1

