Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700044;
	b=hXU1GG2/nzb6xNxWnWuyATRDKqLSt2meU6x3yKvgXflIUPAluwf1kcLPm5DJqIpPdFfA
	 I/BPx9/ScWzXP0S6UXCYkRZhUitAGnYvYq/mC34Hbwua1NNmzO92glaRlu3e2wZ58OGLR
	 eIvhJykW1Sv2ats7iE57Da2Ar0ncMpnD+NEr9d8SKKzN8DtdnrkR1JLo0o8LyaRNWWZNs
	 N/U+jqX8ypqvVYxi/nlIsh4jenEoxYh/A54bu7LkJGFuK1QzEgxafeYNNFuqpVjFyzh08
	 FrBSRjGeW8jcmxCwsCgfRg2wBfFzlvdgA9e4VXfKKGQMEGNCZnFLRSdoO1taxz4Yt1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3FsJRBNzOkF5OXCFiCSDbvRkuVUqKiha6GeXyCdWO5k=;
	b=HWC6x4jZXyr4frif9XX35CtI6NskHMOiQOEKpaOmtJqUSXDbnecZf8WvtVA/H0O+PgZt
	 Dy3M5cZ30mdi4Ors3D71iFvcAyMe+gjj42EG7B15xBCJUGKmau6kZsSdq8tHUyep8nLAb
	 XtOUAXG5LImyQt+yjq9ag8Qj+AjDgFz6s91lJHSAS2N0bcSufjNqqk3qJNOQ2oawTDTnt
	 VHKAXBqMeX09IGEpmgEF0WeB6EixTzTsVUNaHTcZyhnF9yDtyexEPeCqJ/puO2KjVlkII
	 33NTpTgPwGWAwCKvjzT6jr4P7JbY5h83M2ZZVebxkJR4aTNJfEhg46NQNS+h/wJ/r2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BybWKAQp;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2575606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2575606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BybWKAQp
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-386c71feeeaso3435145eec.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795700043; x=1796304843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3FsJRBNzOkF5OXCFiCSDbvRkuVUqKiha6GeXyCdWO5k=;
        b=BybWKAQpzbwGMglWcCTMTQQ4vU6GZudVuWNEatYN+jnwhHbw8KIeR3ODi/AhPsEBJZ
         kFBI8wNNo8qzBHrkFZsQXGowFERZbg1ofsltj+W45ivSDHhU7qDGV0NaolHJVHBaxORw
         5BEe/N8R/JVsdkHDrdRKm8lG9r3qL4g8aZD1S+N2WH2vUOX7hjpyyBHzzbul6EjukMZ0
         OCSvB2rUMMSYC1JVaQ8AI9nyMXJlXdm+9i/YgjCx39+0BOTrBhw+yziLS56UEE+Nfe5M
         kXBb8hru7sdUnfwannE5wYgd57A1Fx6K3gRcCE8JgmntQBoiQOXXuy5ZyUjZJhaxX0d/
         xtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795700043; x=1796304843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FsJRBNzOkF5OXCFiCSDbvRkuVUqKiha6GeXyCdWO5k=;
        b=GKm9Rt3SlgdTYom6OSK5xOFXIQS9VbUf6woaTmDm5c8PhJ1EJ0g8f87Uk+MJrUjULY
         tqT+sFxmLpz+9ChzKEZukXHQlDtLEFRza17HkTu6hbazDW43FM++UgI6mw90SnQW7yyv
         hhuUTrFTE6wEnlmJRvxyp92F4vawmULy5bZlKYD7tBPqlDz8IrGPFJ8/FFIvEKd0IATs
         3gtdEX9CSxAJW+CumKNUPnKDptqWNbsJV7quQQecQcrhNxRCSW0vy3tVluq18t1eV4Wc
         Z9upXppIoQhWenDHcD2UsXx6yyLJLOzcprg/G00GzqeFVfBswPVCtv3fXA0q9/3EYAla
         ktAw==
X-Forwarded-Encrypted: i=1; AL+hErH7DRtpa6aLlwFYrPhmgjfrJODNz4kzo1i49v1hMa19Ow1eQAAF1GwZTQMBTvj1xPlyrzSzSzg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LMjIrZJgRJXQDd749Yx2slhVxgk7XqTUfUetwl8QsoxxaD0E3
	8Kh0sFpcM3oDbzHVBVEup5AVK7IvdDK3u4XXrk/NZaY9Ac5ryd6BUf0=
X-Gm-Gg: AZFdTZcL6nYK4jNWmJZrrDDFSHKcZdnhNwVxQo3xXTVyXPvMaGwvzypf+/bMnXL6nBN
	9rU1vpDcQdas5VSASA3F+9kTi83nGaxnxavde/9/cp/QvJVfTr04gcp0vmOLkLGPokQ6AlUIvIX
	zrF8nXRyuVzriZOcD61bV2UxbYYIPCy/IMayWD5Iyoxc5ybezZ6NOYgeT3QqfhfQN3tcSq2RmJm
	Z9t5ICc3rKwsXBBqQIPvdN2i/PYI/X0p6OmXB5Kdbu8SFx8z7sCM6q1qNNrXfm9X5tyxWCak2Cj
	Yk00e2ZAY+AFDxSGou9+Yjv/lkv5vvIWnOt7ibTR5jNvFW8XUCDRdExbeWNr6Mj5kKCfGIFFx0J
	FRjPyXC2iy9NwHmxldW8xmNOc8fSaVFKODRTV5C6c4PuZe1llf/gE8HACLn2DkHPKAofjk4Y9gv
	7XvB9yRg5ycRYrUnRhe0Kwv/js7WRaedx7oI27VgIh85yWZKpNKNKFZ0Ap10s4ZtilVCm3qi8dG
	EbZ1krV9lJ1m027sMyeDIcEkHY2ERJ0Tuuige7G1N0ax16+sixc+9mr5zOKMv2+ShsVpMo/QOhT
	OGxNhUOOzccXz2q3L7rUHWH4heA9NH69ZbLyUTb9wiz30QldC/qYJP768VvWkoVtNBg=
X-Received: by 2002:a05:693c:6010:b0:382:105f:e7e with SMTP id 5a478bee46e88-3857170e441mr26340102eec.36.1795700043018;
        Thu, 26 Nov 2026 05:34:03 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm70967222eec.21.2026.11.26.05.34.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 05:34:02 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Maarten Zanders <maarten@zanders.be>,
	imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: gpmi: fix probe error path when CONFIG_PM=N
Date: Thu, 26 Nov 2026 21:32:39 +0800
Message-ID: <rc-b1-20261110-vc-170-6561daaaf6bd@gmail.com>
X-Mailer: git-send-email 2.50.1
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

With CONFIG_PM disabled, gpmi_nand_probe() enables the clocks by hand
and gpmi_nand_remove() disables them again, but the probe error path
was not updated to match:

- if gpmi_init() or gpmi_nand_init() fails, exit_nfc_init releases the
  DMA channel but leaves the clocks prepared and enabled, so every
  failed probe attempt adds another enable count;
- if gpmi_enable_clk() fails, the jump to exit_acquire_resources skips
  release_resources(), so the DMA channel taken by acquire_resources()
  is never released.

Disable the clocks in the error path when CONFIG_PM is disabled, and
let a clock enable failure fall through to the runtime PM and DMA
cleanup. Builds with CONFIG_PM=y are unchanged.

Fixes: 1001cc117124 ("mtd: nand: raw: gpmi: fix clocks when CONFIG_PM=N")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_MTD_NAND_GPMI_NAND with CONFIG_PM=y (defconfig, =m) and CONFIG_PM=n (allnoconfig, =y), CONFIG_COMPILE_TEST=y (object only; no new warnings in either).
No hardware or runtime test was performed.
Needs a CONFIG_PM=n kernel on i.MX and a gpmi_init()/gpmi_nand_init() failure (e.g. no NAND chip found) or a clk_prepare_enable() failure in probe.

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 019df54c4bb0..fdfe11439a6c 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -2806,7 +2806,7 @@ static int gpmi_nand_probe(struct platform_device *pdev)
 #ifndef CONFIG_PM
 	ret = gpmi_enable_clk(this);
 	if (ret)
-		goto exit_acquire_resources;
+		goto exit_disable_pm;
 #endif
 
 	ret = gpmi_init(this);
@@ -2822,6 +2822,10 @@ static int gpmi_nand_probe(struct platform_device *pdev)
 	return 0;
 
 exit_nfc_init:
+#ifndef CONFIG_PM
+	gpmi_disable_clk(this);
+exit_disable_pm:
+#endif
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	release_resources(this);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
