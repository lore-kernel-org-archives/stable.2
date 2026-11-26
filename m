Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711276;
	b=bRHI7SNYR4tRRtVOAErgyOuCVqoQ26R9rszxcn/jx0FkGcxfsKHdnKSKht2PLAC93LiT
	 UJXqPpeKyKCr9a9XL5vfDHrwg62Hnmc7526v57JqFBouK5aOPTqkoFEyfO+GO53bHSXP9
	 AYlP5CJnqKPYb9/gpdhHlfoAXmhsq/XJGGdwvjjbc0IdTorQJyQHBZgHunSbk6gRSBFmE
	 NcmQwBIT+2nmAKR9whvI639xokPrscFmAlJy942Dl+4truvqO2Ko0ynpFrgxhdnzvYhdf
	 H0gOPiuPvvDF5f6E5HoYxH6D3dZIBuR2QaAcXQfMWxvg6XfYzpt5aB7St6qqHHnc3Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jU16bWHumwV20jpiMrBRT2UNHlED4a7CUl264/set1s=;
	b=GCaOuplI7AjfSWouvGkitDzmjWhi4L0tJ6vH3VY1bnDXczeWXAxnrJe/0CY4ZFJ0CSNM
	 MozM1WHULQZx8gmiyActlhk/qz2rPob8/fJsnCAUETEdpgQQIaq0A2scPOmxuDURC9pJE
	 02QCCs8Yivnyf2c9fh8/0G3EZ1aSPp/VYWA84OHeLJoYh8aCXLqSKUPdJ9E5hcKNhIPAi
	 QGcUzyMRrXf5H0TXeVsy7tBHrR6VNKk/0KRD4LbUJvTY+lf8vksCJ7r+IuKpLER7+n9li
	 KW4UTiotSPPF8zJgutZYnXoO86lclZRrW6JV5l5I5zUeWwcgq6qQgQDE3QcNd5hF8fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lp1ALPeY;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A144606A333
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A144606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lp1ALPeY
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a9be758734so4592191f8f.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795711275; x=1796316075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jU16bWHumwV20jpiMrBRT2UNHlED4a7CUl264/set1s=;
        b=Lp1ALPeYbN3Y4Q21lzfxRACgs9teSones3Qdq3Ep5tB5MOFjC1Lqgzk38Ymp9xH78z
         HUv39VyynAoh3n2mwZ9LOUBIrQvM0c3ILn0bc/kNW/w/NAoiNMegggP4rHfvsO17YfII
         Q7x6lKJbGU5wojgYh27VOfk20edTCgwfYLFTUF5C28NIjPWKnwCHUnVr5vK32lVBOh6U
         MAz9NmLiqQVyTsiHksXcFvF9UcgcIoi+zCqSQ1cVJYGqMVPpSQsdGIqVBjuwB8gH2iwW
         DHhBTSlHTOJXXFmN01OoDQlthI+w/Ld28JqJC94bVpGjZDFQ7ODPj4ZVXsnuBY7qq7Y0
         /EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711275; x=1796316075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jU16bWHumwV20jpiMrBRT2UNHlED4a7CUl264/set1s=;
        b=rbapeIMDrPhzhVA44Uw284obzdW1w9V0gBtQaUxOZYtQMuVprwBrGNRZzTEEWcUaKN
         6lGK2YRTLByZiD4/5omAia5K7PGTAS7Vhxz/rWLSTZpBTU5keoujJHjvLQxJz3QjkZfC
         5o45EZUG3aMl9QDEjZ2P9BuWjSgOysKDRuDUCZ6l1iAeHohxbBJsXaLkTceVX51Eq9PU
         E2wYZjA+WYA+AdmCEyGAxJ89suIbsBJHrIu6lee9AdCvu8/APYGiz8nSfMvcia0HJ+GX
         JtVfZg8oA1K9BjJYInKNgPkvkpBkcpaAYgKpVbIUjKDI12DgwhdCB+QKD4j6aV+9bq5C
         Tc0Q==
X-Forwarded-Encrypted: i=1; AL+hErFTjOOH+Pd4ewtK06W/j2eLdWJl5kEUH/V3BGmcI9DbfxHkSdTJYJjGOwtqzXycTWHeN7hKzdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/oMKLmUXfSLVEKqL+WHMxBqDfCs11y5pZkBYYH6gYLYi774ks
	gGJRg7JNcOEGQ/A0DJ9m/jLN7cuExNewNjJ3bwel+aSoPrWuhXZedTVI
X-Gm-Gg: AZFdTZeo7eQ3O37Wga8RXEu5STrfH0QDn4MPlY9i/FbEFxWPfSsIduqQpi3DS0Uy265
	NVSd6XM/fdnNG4u/F7zVQglCiVFF+BscH1UiiB51HJNwDLHujJrlJmrdAv5owz++ywMCqlW6cyQ
	g5UJhPhrbOw9YDJC2iKISfyGLHQVWdH3YBlAnNUJvVERkqBP/m/3dHzm3K4Qwg+RnUk9+h5Q8Ae
	xUYyZAJwnF/QX0q9GNpn2kULUUOVR3xqFhP7LNBRp5mCkc1aQPbysLJt2J1sCc6ekGpLdfPryAX
	PP8WpOCNRdTw9rzchCZTPYn7DCtrxNa3oMPXbm0FhxZarEQW/q4vTlV/Ji/TGcp+dXlVEJDnd4A
	jjjYJXr+KiUjlPqvUB4C+/mDpG3yPCumjlEJBClX7MbWyb88G3wpegmh5xbR7C9DPhq+iuHE5u5
	uebpW4v/TjTJwR8Vi3PGBTr9ROqcrI7jZLdGF1o/ZtigQpV7KqH80QYkxG7SVdvFLyTxp4ZBgvB
	wlTmopHC1VGGAXI+EonESJFo/o9tJ2vABzJ3F+Nyg8k/ts4ypFW4j4fpjFP5GAvtgA2hySLDEXD
	QXjv0j55AN9BLSJHCWEgsmv4X35YXe4ZmTtRKzCfipLbnujY5nAKVpM=
X-Received: by 2002:a05:6000:4b1e:b0:48c:7143:610c with SMTP id ffacd0b85a97d-4abb2910b8fmr41814928f8f.36.1795711274674;
        Thu, 26 Nov 2026 08:41:14 -0800 (PST)
Received: from vitor-21h1cto1ww ([2001:8a0:c4c6:f00:6ce3:c28c:2097:7d09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm39333942f8f.34.2026.11.26.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:41:14 -0800 (PST)
From: Vitor Soares <ivitro@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Advait Dhamorikar <advaitd@mechasystems.com>,
	Marek Vasut <marex@nabladev.com>,
	Peng Fan <peng.fan@nxp.com>,
	Adam Ford <aford173@gmail.com>,
	stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 2/2] pmdomain: imx8mp-blk-ctrl: fix suspend/resume order
Date: Thu, 26 Nov 2026 16:40:59 +0000
Message-ID: <20261126164058.2373605-6-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126164058.2373605-4-ivitro@gmail.com>
References: <20261126164058.2373605-4-ivitro@gmail.com>
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

From: Vitor Soares <vitor.soares@toradex.com>

As in imx8m-blk-ctrl, the GPC domains behind the HSIO and HDMI blk-ctrl
are driven through the virtual devices from
dev_pm_domain_attach_by_name(), which have no parent and no device link
to the blk-ctrl or its consumers, so nothing orders them in dpm_list.

On Verdin iMX8MP, with the phy-fsl-imx8m-pcie module loaded after the
HSIO blk-ctrl has probed, the virtual devices are suspended before the
PCIe PHY, and the CPU hangs in genpd_suspend_noirq() of
32f00000.pcie-phy with the HSIO bus domain already off. The system
never completes suspend to mem.

Add a stateless device link from the blk-ctrl to each virtual device,
bus domain included, so they are suspended after and resumed before the
blk-ctrl and its consumers.

Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Cc: stable@vger.kernel.org
Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 29 ++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index 212d491c75e4..e967ae7eda30 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -657,6 +657,17 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
 				     "failed to attach bus power domain\n");
 
+	/*
+	 * Make the genpd virtual devices suppliers of the blk-ctrl so that
+	 * they are suspended after and resumed before the blk-ctrl and all
+	 * its consumers.
+	 */
+	if (!device_link_add(dev, bc->bus_power_dev, DL_FLAG_STATELESS)) {
+		ret = dev_err_probe(dev, -EINVAL, "failed to link to bus\n");
+		dev_pm_domain_detach(bc->bus_power_dev, true);
+		return ret;
+	}
+
 	bc->power_off = bc_data->power_off;
 	bc->power_on = bc_data->power_on;
 
@@ -716,6 +727,15 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		if (!device_link_add(dev, domain->power_dev, DL_FLAG_STATELESS)) {
+			ret = -EINVAL;
+			dev_err_probe(dev, ret, "failed to link to %s\n",
+				      data->gpc_name);
+			dev_pm_genpd_remove_notifier(domain->power_dev);
+			dev_pm_domain_detach(domain->power_dev, true);
+			goto cleanup_pds;
+		}
+
 		domain->genpd.name = data->name;
 		domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
 		domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
@@ -726,6 +746,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		ret = pm_genpd_init(&domain->genpd, NULL, true);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to init power domain\n");
+			device_link_remove(dev, domain->power_dev);
 			dev_pm_genpd_remove_notifier(domain->power_dev);
 			dev_pm_domain_detach(domain->power_dev, true);
 			goto cleanup_pds;
@@ -775,10 +796,12 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 cleanup_pds:
 	for (i--; i >= 0; i--) {
 		pm_genpd_remove(&bc->domains[i].genpd);
+		device_link_remove(dev, bc->domains[i].power_dev);
 		dev_pm_genpd_remove_notifier(bc->domains[i].power_dev);
 		dev_pm_domain_detach(bc->domains[i].power_dev, true);
 	}
 
+	device_link_remove(dev, bc->bus_power_dev);
 	dev_pm_domain_detach(bc->bus_power_dev, true);
 
 	return ret;
@@ -795,12 +818,14 @@ static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 		struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
+		device_link_remove(&pdev->dev, domain->power_dev);
 		dev_pm_genpd_remove_notifier(domain->power_dev);
 		dev_pm_domain_detach(domain->power_dev, true);
 	}
 
 	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
 
+	device_link_remove(&pdev->dev, bc->bus_power_dev);
 	dev_pm_domain_detach(bc->bus_power_dev, true);
 }
 
@@ -815,8 +840,8 @@ static int imx8mp_blk_ctrl_suspend(struct device *dev)
 	 * can power down our domains and more importantly power them up again
 	 * after resume, without tripping over our usage of runtime PM to
 	 * control the upstream GPC domains. Things happen in the right order
-	 * in the system suspend/resume paths due to the device parent/child
-	 * hierarchy.
+	 * in the system suspend/resume paths due to the device links to the
+	 * genpd virtual devices added in probe.
 	 */
 	ret = pm_runtime_get_sync(bc->bus_power_dev);
 	if (ret < 0) {
-- 
2.53.0

