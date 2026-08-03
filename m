Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F46A418A55
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766781; cv=none; b=PVSC1XALfiYHXIOXPc2s0LfFh3rBkN5ZBA6lFuCydA1kLO54L8xqc4f4ozGJQ/V0IIT0Ho9z7x1/r44k2WZnSbpeymON0zPGJ1bhgQL2zuE8bVOu5W5FSZU0zCMHxuhtUoRRejz+CbAe75/Qeb1YzWwoS8SStEiOVqGcQT7js1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766781; c=relaxed/simple;
	bh=9DC6OuxRhS6bV+aafS5/ocz69vO2xPsOdqeLUmXIr6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsnrOO8xytpBDMQ4vTxrTZWEsBHukePdq+SRaufAnK/rczVAk156r0gVzkWcYt06hAdCRsmbtpKa84jrVhsS3aWIJOkZV5V31YokY91rQ0dxdKYINw5zpKsSLWp0XHogqkGdvFfoF9A6+aWT74gjzofNMrJwVdaIaGkjqM7MP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8RVM4Bc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8RVM4Bc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38deea72eebso3261357a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766779; x=1786371579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sTRHW9i9TMtUW5FfPYx0JQrWgxJP2eCw3MQffDw7Un4=;
        b=n8RVM4BcHYe85scpxfqc26BKe3RTLidaVwZFlkBUy4JSAE9v51F+VSGRbJmwX2JT2p
         HiJ9O3kNBlgcIELiWej/NtsuVt2TctwCHSkKm8kaPmUISz5hCsZGg63ip5z6w3keoQ02
         +xwKZZQYVi7tLN/3Cd6OvT9bbtv1ILKeg8tzsaMrZwMUyliHDzsTaTHDqVbLMaJ7DeQb
         znfQshGQxN8ZkBKkrCh/DPFqYwb7HljOt6drQHmi7iKIIPHLHYXJmTb7crMKcnB0XjMQ
         wJubPGZci2wpndosQlnf4hf+bpBoPyTWLCYx/CbsV/goCLgtZrqSRJNDzR48P17TNs4n
         J+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766779; x=1786371579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sTRHW9i9TMtUW5FfPYx0JQrWgxJP2eCw3MQffDw7Un4=;
        b=mU3QrWbQZkcwwcLu/STchmFR+elqwdPpW5my4Pq+CIlI/5puiV8xy3A6S4NHl50Yn/
         imkrZ5JZW/SfHYo5YBtEPbtO2JdQMrZMFoMANjpOjaTVRcO/mUQsQMdGcqDrWJCoQJli
         PwiIKvlB63o6tFo4M0CE4yrzx9vfWxQzM9pMKHZCh1gcE+vgY1Bty1nzTOohQm9dSET0
         TagKPHYL7qmNlbWZ+zXP/Kx7BbS7np09q86HVMzWGF7x9Se15ks91peNQZmX+4WtHtlz
         hJt5h13Qcar37+K4hiR5onVZRviib2f2ETdZjfxs4ji/Mfi9+kbMWnML1+HDsiUEkm/O
         pCCA==
X-Forwarded-Encrypted: i=1; AHgh+RrMPFlfT/e++opXYHA7eGiTKML7HEsc+LANcBm0HMXZ6nL+5Urv80K1M1dPCif2at8azg1D5p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LFrMlx0fs93bl/KT176eeEEsqffccytfbovExPdtR+cQJyfa
	YtaVDDGdRkGcJ3o8EOukuwLfWg6/mjlOVHojU4m292INpOpw9fFlcM4I
X-Gm-Gg: AR+sD12Pb1ZdnSYp0ur04Efnppn2mXs1czSMwCuqgTSrPHOZDt/A8aCwiRE40gyMk8D
	71xf9nHSPP/uPURL8HDl24XhHRw7duNv/LOw7644xV40GUMvuHy9dCksue5ym27651pYNawxWOp
	wIDz4f1sEm2I2fOAENOwaqW839ExUi3enhtRbHfvj7mK1A8xmeEqgGr0dyag4mkewimaI4UMa/b
	Lxet4RGvfIIH5bWAwOUEeq1alU/jqtN54+fMLYBK4d0V8yQwoIUsP70CYUja7AAkBhN8HfM5EdP
	iF6qf7m90dfEbNbzmHrP8qsG4mFloEa5Aa0C3K5uK1GcfCnpp09odQbb+pVnrQ11qbY2wPvAlW8
	5DRqcpNDEhL8SVQ4PwClHrtq2ymoBOwZclv7zj2ODUnEUvtlunMvG5YOgCJ5QQxCQy3B5lbqYym
	Nhs1kBXrZxebjCjt0DNwlRoTJG8mmaAS+9Glczud90NPFMRI+QW35o+h6d6FkbiITEm0Tnxhw7p
	5bo6H0+Z+hZktnXtPyN
X-Received: by 2002:a17:90b:562b:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-38fbc4053e3mr8606814a91.6.1785766779400;
        Mon, 03 Aug 2026 07:19:39 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:39 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_)),
	stable@vger.kernel.org
Subject: [PATCH 29/32] clk: mediatek: mt8192: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:56 +0900
Message-ID: <20260803141659.559129-30-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803141659.559129-1-akkun11.open@gmail.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8192 clock drivers can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c | 69 ++++----------------
 drivers/clk/mediatek/clk-mt8192-aud.c        | 26 +-------
 2 files changed, 16 insertions(+), 79 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
index e6ac40e2f12d..92593370f23b 100644
--- a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
@@ -143,72 +143,29 @@ static struct mtk_pllfh_data pllfhs[] = {
 	FH(CLK_APMIXED_TVDPLL, FH_TVDPLL, 0x154),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.clks = apmixed_clks,
+	.num_clks = ARRAY_SIZE(apmixed_clks),
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+	.fhctl_node = "mediatek,mt8192-fhctl",
+	.pllfhs = pllfhs,
+	.num_pllfhs = ARRAY_SIZE(pllfhs),
+};
+
 static const struct of_device_id of_match_clk_mt8192_apmixed[] = {
-	{ .compatible = "mediatek,mt8192-apmixedsys" },
+	{ .compatible = "mediatek,mt8192-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_apmixed);
 
-static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	const u8 *fhctl_node = "mediatek,mt8192-fhctl";
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
-
-	r = mtk_clk_register_pllfhs(&pdev->dev, plls, ARRAY_SIZE(plls),
-				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
-	if (r)
-		goto free_clk_data;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
-				   ARRAY_SIZE(apmixed_clks), clk_data);
-	if (r)
-		goto unregister_plls;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_gates:
-	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-unregister_plls:
-	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
-				  ARRAY_SIZE(pllfhs), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static void clk_mt8192_apmixed_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
-				  ARRAY_SIZE(pllfhs), clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt8192_apmixed_drv = {
 	.driver = {
 		.name = "clk-mt8192-apmixed",
 		.of_match_table = of_match_clk_mt8192_apmixed,
 	},
-	.probe = clk_mt8192_apmixed_probe,
-	.remove = clk_mt8192_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8192_apmixed_drv);
 MODULE_DESCRIPTION("MediaTek MT8192 apmixed clocks driver");
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index f3ebf8713fbb..8625f656a2e4 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -80,29 +80,9 @@ static const struct mtk_gate aud_clks[] = {
 static const struct mtk_clk_desc aud_desc = {
 	.clks = aud_clks,
 	.num_clks = ARRAY_SIZE(aud_clks),
+	.populate_children = true,
 };
 
-static int clk_mt8192_aud_probe(struct platform_device *pdev)
-{
-	int r;
-
-	r = mtk_clk_simple_probe(pdev);
-	if (r)
-		return r;
-
-	r = devm_of_platform_populate(&pdev->dev);
-	if (r)
-		mtk_clk_simple_remove(pdev);
-
-	return r;
-}
-
-static void clk_mt8192_aud_remove(struct platform_device *pdev)
-{
-	of_platform_depopulate(&pdev->dev);
-	mtk_clk_simple_remove(pdev);
-}
-
 static const struct of_device_id of_match_clk_mt8192_aud[] = {
 	{ .compatible = "mediatek,mt8192-audsys", .data = &aud_desc },
 	{ /* sentinel */ }
@@ -110,8 +90,8 @@ static const struct of_device_id of_match_clk_mt8192_aud[] = {
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8192_aud);
 
 static struct platform_driver clk_mt8192_aud_drv = {
-	.probe = clk_mt8192_aud_probe,
-	.remove = clk_mt8192_aud_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-aud",
 		.of_match_table = of_match_clk_mt8192_aud,
-- 
2.55.0

