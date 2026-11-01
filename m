Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550754;
	b=BB3BHJamung/GFhLVTMn7YRrY0XyEPLJxxtX7kvzuXo8qIbBzCpdyeEgk9IG1iU7yzJ9
	 PaJojMrnDMIbDA6aSNA7VqLTyf1Nc8HXWGNAHsmPhYV4dUW2oLjA++lxVbcuDYWN8MzbM
	 HqBIQ3/rBmcKE+HuoM2hbarJ+YZiSdT7wXY8fscuTTaINirR3RL7mc5VnzCZBFwq93RL9
	 mviHHAAw9KI9uD/+VYxYD3vNcS0KztljDX8ntOPZLl08eDr9D2FlYexBcJqGulopyn2+h
	 EJSBZjC7BLwA8DXYtpw+o/bd1tLeO8yauas6dXAbEbkGs719DhEXUKV7JL+BedKeS/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wl8EJyyRKTEPWshbokgEqGpgZSXHPnJg0Mbe0q2k6UY=;
	b=B8l7u9mytVBrmb+iTGW/xZZagdzYEPdyIzs7w0Msedba216UxJaBxhJhrnoJ9y+Pp4Iq
	 BMCeFlrrn3UpClFHG+/uyq3U7dTfCPxhKG+GSyNEoA060oxkuCiRGlUuGdku3aJ/gbdJF
	 IHzFCKd4ZFQYiYmxjcGGordIs0kCwkqrOWUYYAbsU5hIaqhkmunTJZfjTMn7lVEtfFYF7
	 mKnt87W18y2hiInYDG7/alsgkQmxyQfabfgFWcTlqqHE51PLjlksaMJg7HfGt1qkeur4m
	 Y9gkWcDrsbP6ZnjeP8wpcYm+vhfW5bX/2szbceI60vnAT+HgxcTnwo6dYOhDAIXy9og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j33ajJ39;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0284606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 16:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0284606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j33ajJ39
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso7658625e9.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550752; x=1794155552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wl8EJyyRKTEPWshbokgEqGpgZSXHPnJg0Mbe0q2k6UY=;
        b=j33ajJ398UI2PYwNfTCQQfiN5vaMMbe8r/8aPGWV4pHq47gZT7GXVarSLmUk7lJweT
         Z5Oe35wgx7g05n/q3rZFV9+28YDm9entY0wu3+QwPoDwBTnrkQIQUQ8/DwXExDPApfCE
         diS1HIoqHFttfHuJtlTEWzckVBnYK/CUGy8BNVdA0wmFs3AXL8AdtNYTEPX9KCX6mBLu
         lPw8kmruZlhHF4ltCqBwFTglllsjyDCKKBpSALHibByHDBvZB4x4IyvMRmLbDa0CIClh
         xqhZ9dkNTwHvKSClppVk+1MnvDsBUuF1WdntnrpRS6l9Q3xRzSBsvgXfSHg6hjbHP6n2
         m5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550752; x=1794155552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wl8EJyyRKTEPWshbokgEqGpgZSXHPnJg0Mbe0q2k6UY=;
        b=2Qj6HNpJRwypzgVSvyk4mMFY/Z4JW+IqXsPDML8l6jWVaG5MUkkhCnnWriUpQn04xa
         TCsYss+UdQ6QeAiPfIpw3zFZc45gWZ4YOVh7S0ppjTLjuBiR/4fy9TWKKARz+Q9SiKqO
         R7BJIwvHeXSr5hQuaVhaLHQAvlotdI0TDrLgCkeXrc03MxMN3ogIdh4/eOm+ibgDcGBl
         jIWM8IcEXCjonb7KU3EWymM1f9vuVAhqKXccWzWwcseFNU3xxD9J04adEZMcHZ/YJOp3
         yWlK6p+pwma7eeKSEBXxGNjAN5SO3UBJF+m4ysKOw13c2Ot5w8LlOmGvF3RDG4oWT4Mx
         aSvQ==
X-Gm-Message-State: AFq9FYK8nG2mUfWSH6wwb6LWDAqrgMVY3vBxhwherR65GmKN00jXir5e
	q3z6lflYmcSuK/NWSVcvxe4tfcRTGHTPgLIW6eOnKmd2QzveNJVcM2RmvmZT0A==
X-Gm-Gg: AYBFou2GWfKpPKD/lHDjlSTH5WahVdfF4yoQ4Y/4ZMWPjnEjIDKV3aa2izRvLlGcXci
	uFw2IJtp774mJK2WbR9UjzAKWhSUqkuqQGouD0op+Iy8SYnX6MaPTVEpReUtP2Tno7tT5fS3A0N
	yoPR36ju/FGjrjQJDNsya0swXcDRpvt/4Ecr+x5qkJgzMS4i17eXPwlMyz1gbcRD/OEHt/p6lW5
	5Dtq5+3MxBdRwc8CAWe/qo39DfmQk2nJPxA6t8n7ytGK3C5q3D9MT0K71ulTN4XbB350bVuuUPm
	490KdkKQ8uCe0BdMC7381O4l7Hj109P71qXdV1oe6gck4vqm4spWV2xaiA0CmJ7ijNKFtEJn4P0
	Ff00HCyTaDc9uEdNWzgMFw+kyIVtsPjusfG3g/euwSFZd4zZ5CeQugwor18j2icMC8AoNxcdhb5
	ayBHbxiKPFy6nqwpt7xrjWOqoahjuB1ZviJ+fwEbspXk7hTF1mqvWCaoRGnEmnUZMXTkNBA5FOs
	ZsoHy9mgTLjovfxrgVfrvBt11vM75bSWLBC1L5g6sMfGFDufcIoFGxy71t3k5TmNWKiK9LPatZg
	bG494aZwtCKS9Ec56C/ImWw4P331AK56pR7EQTv18KTIddYYdQ==
X-Received: by 2002:a05:600c:a293:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4ac17d19a54mr118596575e9.2.1793550752154;
        Sun, 01 Nov 2026 08:32:32 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm97219875e9.0.2026.11.01.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:32:31 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Vasut <marex@nabladev.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	Quanyang Wang <quanyang.wang@windriver.com>,
	Itai Handler <itai.handler@gmail.com>
Subject: [PATCH 5.10.y v2 1/4] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
Date: Sun,  1 Nov 2026 18:31:51 +0200
Message-Id: <20261101163154.2274099-2-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261101163154.2274099-1-itai.handler@gmail.com>
References: <20261101163154.2274099-1-itai.handler@gmail.com>
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

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

commit 58eaa7b2d07d3c25e1068b0bf42ca7e7464f4bca upstream.

There is a PM usage counter decrement after zynqmp_qspi_init_hw()
without any refcount increment, which leads to refcount leak.Add
a refcount increment to balance the refcount. Also set
auto_runtime_pm to resume suspended spi controller.

Fixes: 9e3a000362aec ("spi: zynqmp: Add pm runtime support")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Tested-by: Quanyang Wang <quanyang.wang@windriver.com>
Link: https://lore.kernel.org/r/20210415074644.24646-1-dinghao.liu@zju.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
[ itai: 5.10.198 carried this change as commit 2cdec9c13f81, taken as
  a Stable-dep-of 1527b076ae2c ("spi: zynqmp-gqspi: fix clock imbalance
  on probe failure") but under the ID and message of a21fbc42807b, an
  earlier upstream commit of the same subject whose change the merge
  into v5.13 discarded, and 5.10.199 reverted it in commit 1ceaf0d3a883.
  Without it, probe leaves the usage count at -1 and no flash access
  ever runtime resumes the controller, although commit 24159580abcc
  ("spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue"), in
  5.10 since 5.10.37, removed the clock enables from the setup path
  because runtime PM provides them.  Context only: probe registers the
  controller with spi_register_controller() in this tree, as of commit
  aeb00d7e89ca ("spi: zynqmp-gqspi: fix controller deregistration") ]
Assisted-by: LLM
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 5c470daf9367..7223eee6db88 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1139,11 +1139,16 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to pm_runtime_get_sync: %d\n", ret);
+		goto clk_dis_all;
+	}
+
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -1170,6 +1175,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
+	ctlr->auto_runtime_pm = true;
 
 	ret = spi_register_controller(ctlr);
 	if (ret) {
@@ -1177,9 +1183,13 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 clk_dis_all:
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
-- 
2.34.1

