Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07B49C4D2;
	Wed,  2 Sep 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354092; cv=fail; b=I54hJqA4l1fXn8g1OMZSiF+5oMwwwVxxIPqWiOvsj4USYvSn5PeEYnIoog/OGSHvvlZf2svKkPTcLs9pc1SaXuh0pAlowpsALKdgSsASsAhh/VLm2+ctPhA0nCQrAqh38/nyG5pknEIFfj4M27TUO6rYoRZcFQEQPF4bh82Kyz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354092; c=relaxed/simple;
	bh=UkS+AcyduE3VfXM4SRh+zMmVN2T2pjQ9N3wEPrM7/OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYEKhYrmfthf6Etazf2dOxaHWnU5njafbevB2V9UjyZtKG3KvH6qqiCQ1e8hMUqVxH13biuWszjyuOzJu17YePrWm/BPmJD7V0mtB7j1RTw7Cm5f8gi76lp8m3oyvTwGrBJZbKH6TvvDZoZ4HBVpXF6FDmvOg+dYyea+U906mOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=VkQ6K+ef; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="VkQ6K+ef"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4R3L5IByp1Qw+BQwXnZOu5AbloTJyFHoORiYxprmyCO9Cl5MViUmAWLTl/QpD1lh6jYquJDnk0eYXgeIUTP/bxDF0/ElKCSDtGbncK2b1eKKNCC5Fo0PpUUS2mOPx+wVsBV7ZMvEU8lXrdxX3NIsPR+k+SodG0+OuJutobIF2pWrXJu+iVmhpm8XC0ndtdxIdCfiGc7oqpixoi3NuonKqGCeclINLS6wyG6dfuBvcbRAgURaXZG7APFDlFC2pqfRiYK4CfFTKEnP15zgMzozimssmsSpDgBhknh/q/HCss+6CLeNw/547uPmogcrWzbcw4YlG1LfJSs3GQGuN3y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtFuLWOeo044dXAap0RsBsuypxn/lF5Pc0jcoVn0jRo=;
 b=mUesI21LzEGLnahwCV9/DfJYuVd0d8t9ieAcCCrJnJHOUz46CVcsNB2mQT5KMwicdnVFPupfmtlvdvqS7NEfKQrGAZ6CwOQ77o7Lp65/U02XvF8flY5vmE3yPsPiqEcm5ywZwt27W9u5RLMRz5nS2cxSWRP4gRG9Hhm5zoEaKO5kTHM9Rgw5NQlZKRRut7Ua4fEuBdpC4xADGuqBQoFObLM4Gu0kBBHtHukoKj95vS9dsfUJdNW9uf3EcQ6w7Zy8++/BaPkHIsVltdEA1bsc3CoRsYUOQQApUd6t5mvfE5ASCSLl9WxbgTtvAP53LnyhHjp2ydwhEy5HJ3JafTI8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtFuLWOeo044dXAap0RsBsuypxn/lF5Pc0jcoVn0jRo=;
 b=VkQ6K+ef44HRAfK0cz+p3Yngs2fgvFRpxYZwZHHA2nmaBMPHVdJL7vkAg90VdVVFgV509XDt2L+l1dC3ZiNOyyNjGdHW8lh975+fNfQ/R+6API7tnK++YSFWhPK6eRFfYA90DeAt6LQNWGoNeRp+0tggnoh1L4T2F+pHLTTF6FM2XM6OjFFPlbGFRSNxFJmCXKTTJR21Ea5ECu3hJ26oTBNBxxwBDAflI8iPjz6ZHponvpsEaLkyGNv/D7GmoWSw8s4fc+WZUxxzQGiR8bHfFJ2nmLGupEsmH5Al67qc9icXVT/aT5QfWO5LEI3sfHEp4T6xMLMutKrlBbKs5WHO+w==
Received: from MN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:52d::30)
 by IA2PR22MB5529.namprd22.prod.outlook.com (2603:10b6:208:4ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:01:26 +0000
Received: from BN3PEPF00022BDA.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::a9) by MN0PR04CA0009.outlook.office365.com
 (2603:10b6:208:52d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 BN3PEPF00022BDA.mail.protection.outlook.com (10.167.248.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:01:25 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 6C55719244;
	Wed,  2 Sep 2026 16:01:21 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] drm/bridge: dw-hdmi: optionally ignore rxsense when detecting hotplug
Date: Wed,  2 Sep 2026 16:01:14 +0300
Message-ID: <20260902130117.2731-2-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260902130117.2731-1-ian.ray@gehealthcare.com>
References: <20260902130117.2731-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDA:EE_|IA2PR22MB5529:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e1d66381-cdf1-49d4-30f1-08df08f24beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|921020|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xxj/VjG7TKA1oXvn/OGtw4uLaELP0pdmYCSdkT3TFlcCzBYmqlrDgaHwBnEYDnccnCXqYv7zOwVSdd2wZKwcLkcRNJWGdOP/XYwGrKlqohvYr1NLvcIx/FV52TwfREO7FslLdDuEP/1q31Z067vHbgfEiBkfMyrAdJAJvXnanAkEZhyOkL1SIcXVbl9YjKbH4nK8mHUu5y/7FeBLh5u8xdnlVMZojbgxCnJj8bkwJ6ce87DErzWlWb4fv/X+Khghp2Zs5uMsLJGIugkHG32l1eAW8cjcsSkc3N4skn5m+OW3m72QGNOZWv8qKlCprV+X5vtQUG4pPp1NYijOWG6Wnu2Z0mofnzx2QwNYiILe4U1dFUG7w9yAAkFvAvDqZ/hkT6GKS4tZQZ1uu6MdTuylDu/fp7IWN7asC5xbTj5aDputet6Yh3juN0LjkDXHzt3fmqEi0turbkEDbOspARD1f5eJ9k6v41XHP1tgvkwxQNQcCZ8UvgYGeemnbQ5Vf5WZRJh6BQfsj2cx6qrNJPab8XboRECuLts17b1K68ngHiBvPaYFXlOBenM05nXU4pRNfzjOyVTM9G8dr30/se1xxjVImS9/AtSrT8NMdo5amXrq6enwR2ROzkIEAkCqb/n4lKfh5l+WnWtWMNq6LUpmc57Jm+NNEPLb9mpz+85+Ac5Sj621Nz4tI+iRkNIRS340A0V5/pkkJCHmG844fdr7VKMs585HhICrYJe3x8n5GDUTQtvBnPCHeaHZn/gVjm1G
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(921020)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CApEjhy4nBq9HLkQQ9dr9zHZBEgmzQ1NsFoTXT7tEKhWH7omOmU9FJvmNyuzQcCGcBkX0CD1XnmYJ1kVgSdFnDT2OyBrclAMUhMOS9jhB3hRavq3rqWWGl0Ex4Sv549+Rl9JR9t9BBh86SBpplSrBr0RGy6v1dTqk0tEV0V0zh7DiGrbB9UZYLqtAA9JQ0ulx9KjfpWxqe7i+qqMI++kQEMouHM5VuzYNSB3MtCRHClQSNXKoik+QykMC9QN8cGIhVPTfCAs7ox/WanktVmTmq4vqJaiRuO4/uYcyaItqRC47kDb+wte5XGxSo2k1lfJ9pbVXOMR34CL/+0Wz21qQ5FYJ9HjdPHAyJb2tmX5e2Aq4mQDxR7Awl6rCMdK3Y4bnIW+JRCfrOIbWUydn/IGurpcdx8QfQH/PNSv5SmTCGvhzyUnYCQf/+7yU8NuZ+To
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:01:25.5588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d66381-cdf1-49d4-30f1-08df08f24beb
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BDA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR22MB5529

Commit da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event
on link change") changed the way hotplug is detected to take into
consideration rxsense.

That change is problematic for boards where rxsense is always detected,
such as when an HDMI to DP converter is used.

Introduce an optional property 'ignore-rxsense' to handle such boards.

Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on link change")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 34c5f583e910..a9337d1f4b88 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -171,6 +171,7 @@ struct dw_hdmi {
 	bool disabled;			/* DRM has disabled our bridge */
 	bool bridge_is_on;		/* indicates the bridge is on */
 	bool rxsense;			/* rxsense state */
+	bool ignore_rxsense;		/* use HPD only, ignore rxsense for detect */
 	u8 phy_mask;			/* desired phy int mask settings */
 	u8 mc_clkdis;			/* clock disable register */
 
@@ -3156,6 +3157,9 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 		if (phy_stat & HDMI_PHY_HPD)
 			status = connector_status_connected;
 
+		if (hdmi->ignore_rxsense)
+			phy_stat &= ~HDMI_PHY_RX_SENSE;
+
 		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
 			status = connector_status_disconnected;
 	}
@@ -3362,6 +3366,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 	mutex_init(&hdmi->cec_notifier_mutex);
 	spin_lock_init(&hdmi->audio_lock);
 
+	hdmi->ignore_rxsense = of_property_read_bool(np, "ignore-rxsense");
+
 	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
 	if (ddc_node) {
 		hdmi->ddc = of_get_i2c_adapter_by_node(ddc_node);
-- 
2.47.3

