Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF8493635
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353938; cv=fail; b=Xfj/olGidBILu9CUWU5qKjKymCN8IYSwYpSau6WJJqj8cOcttx4PPpqLZdxC1hoVWj6mGUtyeRbnK0ED6w8tbmGkwSKBwuXnZlBjgsUib1/Hf30Q2ahVOTv49F1JtbXbeohF5hysC7VrYD4k73OjAPeB/8D9mm9S2ABQsG74xYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353938; c=relaxed/simple;
	bh=UkS+AcyduE3VfXM4SRh+zMmVN2T2pjQ9N3wEPrM7/OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNmX/nTRMp0VieybqTi/JV5tHvnp6rsAN8tx8YmGVloAtswgeAv8qmMzE2XPec6QU73xecNOIu+c9stI5RjqmiqwHupVA1l55obglpkYdD/pM9cuYdUzGbPGmaT92nr4qnB5CWtFxjGYKmF6Bi+XJIlbUeo4room53QqxPvJPIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=v9KVhJ87; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="v9KVhJ87"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stOTHSuO2nm59IqgR05lCQncMSs/BczWkERgn0CBd0YZOfXKrRsbFuDLCV6h+DmTZG64KVNgcmAlLh/bCe7FIOLhIgIKo/r/FFWqpUcDXsvouAE2fig9h2QY7T8C+/Sp67PK9XCGNIju7kEzkQsqm/Ti56b0E9PH1MTXkUZnkQzDrWK1ENltN3+dc4HMsRC1de92N042xtOWo20vLwe9NstwhI7dxNKG4qaolxQQqt+YhPOCxvZuO4ROQyY8nZvIlMiKxOTVvyOJcztWTi34aIBoSOxoXLyHp/gT3cy9ptfeZ9v5cIHk8eHDTS9QEBQoxyEQC9KwQb03z7b/g3OxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtFuLWOeo044dXAap0RsBsuypxn/lF5Pc0jcoVn0jRo=;
 b=t7U7YVF5X/WjbwEUsyHT1C/lp53JNWXHA0zExbeYiB8oDLsyK2juaBMh5Or3HegV4wV3vbn1EnOBVxfgoptS01CfwXm1R5OmTwVzDn965WnDfCkE3xWr4WFHF3GM/FF1Xg5EzfCb0dxyXGaeUiA7z5FKCK8HyCCh5FmH6xpv9MGxB3e8G6o1/l9iLUFud3+cVqfYOofCMMyL3Ro420jIZ985J6nwhm466TyS7TO+Ojq+KyDt0uLs6Y7pJZjY0bzLclulKaYg3RYMJycBB+qNXmiMbuM0BixdWau6mvra5WDjTVWzEuwiNUEtXk1WcZW1KwISSNbCiM80BvCWXyFn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtFuLWOeo044dXAap0RsBsuypxn/lF5Pc0jcoVn0jRo=;
 b=v9KVhJ87Nq0HX+Gr4WbWyCno/9v/9S3NDpjjtM9i7Qqf5pd5/KOu96LP/Jwc/X1XgeVb6hKzTFo7uuXW0R1f8JEfIHd6x3PT7Qz5fPXc+yMhWZ4pgkIdOo7e98Z6qaVjgVjNkJXTJV76TaF3oFLxf3oB1Y8IYFm6Uc1xPz+mNwXV9u+CqqBN6J+faGYmSxp3RcDUvyuaEAYsD5GHV+XW9uct/jqSTgK6n8BUlPd/eBjFsyH7foeEC8+7b0GPxgDpzMWLblX63qFnkSnEFeqLRlHcX1FTQEpZ1zcIrU6alFoUR2U5WH5tEllw/u+0oNHdF+wKxB81MfhBEEXxz2OwjA==
Received: from MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37)
 by SJ2PR22MB4553.namprd22.prod.outlook.com (2603:10b6:a03:558::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:58:49 +0000
Received: from BN5PEPF00046988.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::a0) by MN2PR07CA0027.outlook.office365.com
 (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 12:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN5PEPF00046988.mail.protection.outlook.com (10.167.245.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:58:48 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id E605119244;
	Wed,  2 Sep 2026 15:58:43 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: stable@vger.kernel.org
Subject: [PATCH v1 2/3] drm/bridge: dw-hdmi: optionally ignore rxsense when detecting hotplug
Date: Wed,  2 Sep 2026 15:58:41 +0300
Message-ID: <20260902125842.2357-2-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260902125842.2357-1-ian.ray@gehealthcare.com>
References: <20260902125842.2357-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046988:EE_|SJ2PR22MB4553:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9749d1ab-98cb-437c-6c6c-08df08f1ee88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	d5qlvPJGvmNyMxDiTveNs36Ckx29CsWXv1rmO4lBoBJUQzdq54msfNStR8VVw7wO8bSud7tCLPvY22pir3yIFkIu9eaCpwOdbzDaIq78gDJyrpPwpmXUszid+dGeexVvBZLP08x6xQHfB7QqVE7ktjzazYYUBp4G8Wq63GcmjhCZkR4maz/oPNcItC8yt8b2tSS0jF+sbN9ilpLdk6jBYggUU+Ei4s1aVil+eZW7MIgRSl/t70/alSKfcvwar8ePhVIFKbfq0W+Xn5lac+PoLNuUV58MvDR6so71aCyv1K7BxgF4DEKPlMri0qVtjGgpM6nQ7Sq5fiA9HohPOdLut5LvXSb62JBAwqeV1k62ydfwp8xuI+iuBv7OpusO3vx/gzRHC1Eu84ZeaM3GRLarxGLt4xpOEtndLYC8+OCAR4ZuiUpCQqdX/9A22Kfl+7tyN8YtLOpiRKUR7/h0wpKlZaUvB5Ol0LNq5iSbZ9XQueHvqPJhDG6Ko5yXRPTznaHQuFgqEOjC2SPdRE9l6BJfCf1xMdDnsc4zmZHeheWCbU7vjyNCwAttbCz52GhYRQLmD71JQb60ulglNi14diRwcDoj4b8AU/RDHe8d++6tG7wRtHCI2Wd+JYKvVzCylghWHdVUXKOtHqhtaccmN3xyBHsgR96B25P3EsuU939iGi5ilx7IZqiIYus7F6ok5WfzcqtUOQ7R92ZS0UM9qWJBTQ==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E5qkEtWLYf/gna7Z2jilW17xpdphxuCGwOijIV56/qwMr3GMLCIaSf14Qzi6JqlrjprZ3WyjWeKQGremdVI40GEdhXIAmHz8csPbL9UTD5VDrxcw1qnvvVgm2ToEALqgZMPr33eSm8RMCw/hhctzSwRiPHYyaWIWB+zUdiE3xIe7uE/MYK/TTLskV4+8iVJlBkVKfVQgFpIt7YrhULBa0RfHPIcWPFOLPk5r/nFI76yixcBMEMMARvRvsKie1WcoKcL0J3QbaLsY2Ur51ng4nQvhT3uogZxMlVpOfdLRHbSHdEymv8H4a6FYSETUoJRgXWkUejgHiiQ4qX701kFPHvHod3wqOXlgDx77nH3PaNw7A42kC1Kvhrcl+hm8zwyybR4kgcmyTUSB1uRBHRrFoVdS4r0kgWnvV6k8MXZSdKIZFq/OATJ6rz5fdRAUunBK
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:58:48.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9749d1ab-98cb-437c-6c6c-08df08f1ee88
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN5PEPF00046988.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4553

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

