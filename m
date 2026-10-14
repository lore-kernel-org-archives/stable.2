Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011042.outbound.protection.outlook.com [52.101.125.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BB4EA37B;
	Wed, 14 Oct 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972023; cv=fail; b=CgEn7dFn20k9So95W2D9d19kgAewVN7Rjfy4REqIT9yttMyvF05EF0etnN5l+szNcjKYl3gX6HYYst21Ab0R9p5YfDsKFNsKsCrogee+sdAZ6dvVNpwvCCQFvlCaovZL7Lh25C52p38APHXFtyY8+nOwYHWCXLWgqyt3NxmE994=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972023; c=relaxed/simple;
	bh=GXQ2htJtURXoS8PjkK852Une8t/IwircM0OqBexw9WA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vDQIHe/1Sx2gjx3o/mEv2dltdAwPHjnesrTCvoRrT4mCoztPzPnAZ5ruadczwaSpEZv4UTh3MlIOXwEW9eL5EUNV9UJxAC6w8spvHkQA1I1qvxUcbXpY1AzLRi2bOSO0IIqCnPdz3oGGjke+cwgRXoEuHHSLDz5D+pL4YIUHHzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=hRAOIY9W; arc=fail smtp.client-ip=52.101.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="hRAOIY9W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHV+UOBy784IWe9OcUf4RnsXsIrNJYYNb4ZjjkuQzMH0YIk/ETd3dvvQu87N/JFhQIzEj+jtplIm1QHrFgLLuWhM56jn9r7+ElwQoTOx5JqK6C2ej4HYJ9cUTUnnsH02eE5cvmO3DZPc7hP1v2Wp67yLV/CRu1tAHjFFGc9B0W0G03wZRFfvxoe+P80gKYL3Mc/WsNeT6HQJy4bcdlMWVifzNZ9fLOp3mSTZL6gF6wgdHh+PIyXoFkAf9Dow8u16OsXxPGY0Bhrp1ZM3NeGZSJ/TXNt9kBuBTJir1Uq4hRqnEgWeHU90MX2Sjo2F/hV8f/SW1DDXFF8xYLlWhxO/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u2Jiks/CQfHE45H3F6rYMxv3Ba1GrrYj0YyUJ20fuQ=;
 b=IgjRl/Wsed6IA/KTWOF00R1LnHVPl1UB6HdQ6Rhn6BHaIbDvTwEzNONladXTZBe17dW98IML3uoFyADzhBjbn9i9naAeSayY4CW4anqBtFgjzkHfnkggQlJts61KH+jkFP0oYhaUQaPl4xNuYw1uvHx2SEZEhnvK3N6IOnTKx8Wu521kakpKrO0OITXzecyqEyAiNdACLGHMVSwgiNpKgNSt+b8QfbK2ueaxAHhZ/sZn6tLi9BC/WhXxhK3f/OPYNO85flsUL3+6YMWIj8g8aBsQEXlEp6T8WR8umZdMH9zyvchKPUZttAo0e8MR9+rnWiRWwb8tkJVdytLjrU4ldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u2Jiks/CQfHE45H3F6rYMxv3Ba1GrrYj0YyUJ20fuQ=;
 b=hRAOIY9WGPrYPP7buyauuQ+BEnif93kXYFm9X5nSWTnHhS6g1s5eL6tPLaaO2z6cuvMzHum1Jw3QKhlwEJH17KsQJs5fy/PxD0DfQtWp7i7F+31Puyhoezl9w9DZWORn65ZEGJZGWmVnY01LYvlWB2HLUM4QFLexsoLubqEZKB8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OSCPR01MB12951.jpnprd01.prod.outlook.com (2603:1096:604:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:00:17 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:00:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Au Dang <au.dang.jx@renesas.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH] irqchip/renesas-rzv2h: Preserve TIEN state in rzv2h_tint_set_type()
Date: Wed, 14 Oct 2026 11:59:22 +0200
Message-ID: <20261014095927.635132-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OSCPR01MB12951:EE_
X-MS-Office365-Filtering-Correlation-Id: ef166fc6-3e9a-4c3a-3f57-08df29d9f2fc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|23010399003|38350700014|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wnzEMqCYRfGXRd6Auywgr4oFZfk0x4JM8n7yLPq6ZEWW9KReae3Oj/Wda8JB396CzOEnrd8xNnZbX/ZYfSXE0NPl55HxAm0GKJxznTBUK6DFEKRX94zwGIj1H9lRySNNjHcHwAhbsBroF5rz6EANDJlcKdN4bmLGLr/n0KJ/M9CZvBm/k+FQPPpGOxYZRAara6DGwpU5lLbJIHSEi/qvrlJYRX807emHYLlmLblkrcMyE6lGyzGaQA9FNW7IMFFYgcJBJP3VH8rr+uEnmbWA7o/kKJflT0/m5PbDRVoH8TQnhsN8LfUKUIQJryfYdFU5LFGECvidblbI/SLJEeCiuujvfGHgnJ3J6NlSiVmZzq2+hNaULogsMjvPJo3YDY12TKFkaBBqFmZ2szQWm+X1+JsmqJADWjWJMIeDL2lC0cNWRAfVn6Jnv45ooxv9C8e9ZAwW7BxvFwhJo4gu4H3KoHhT//PXis6CE1dYSbeioFtpRf4i7WLXdcqORMrqN05JIxbxrcrmlgMduyfsMg9LPVLD4pV7Hdjif6BUF2bMjFgtYTAb1Nl+OabnXsIEhSjnRdfZ6zZMc2iIL1revzsh+8TpINv6A0p08oIz/fGJidmGJq/5MSuru07LIUpZbifUPecjVNoioQMoc6A57yKvqGBg4qGsGdGGF9nCX6SzMZhkMjuyJyB+ElvuNIv7CbmezKtih2ME7A89PJBIflgTCy6yrVc7/+vvbgOXNXI3lPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(38350700014)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ze43C2CWNYbBupvQn9Aha9LjG5nUF4dQO5AQcOdLAJey5ITR/TKJyrhlbXp/?=
 =?us-ascii?Q?HNONLXWa2RH/2ppnVRbBv2GZ6tceDkNJEZ9tTNcqjBMp8OrfEDQG9d2SltVY?=
 =?us-ascii?Q?MyxddQHzfpsJ7wqP5Fh5MybKLT5WyhknJmdR5ttUb/hhkJFimugIpq2ZXtXn?=
 =?us-ascii?Q?OrK6NR3z4xbFIMvAGM/13++SR//yJTEVKDerPn0rhE9ocThyqnAKTprqahGZ?=
 =?us-ascii?Q?AI/uYZshBwHLdLFDOPp8PMnNwwGkU1cwM4peIUdXwvrojcld7VeIhD6YOkyQ?=
 =?us-ascii?Q?QDVKRPERk30W2+6HKoPeZyTLb9YJ0f7vAM7vP9WgazVNqdOuzKru0i4AJ6R0?=
 =?us-ascii?Q?vKN99fPUUYINYyoSOkJLRbzULYRtBGRJCvXEBXSbsPdrDyFW19eHdie2F4WK?=
 =?us-ascii?Q?ZLgkKDaSaeRnkeNjf1h4KoGrSx67GHqEh7OiE/PGnWqviwDKMM2QiwlFDcyH?=
 =?us-ascii?Q?EDnZlj5HDjuhALByd+Wgfb1ezqQ9vuzHfZX0RKqilI9s54SrOrWJYmj3zKKZ?=
 =?us-ascii?Q?pYBFIR2Gw1KJ+jXDQo6PBmcnIn+VbLN0S3Yv8vacrczazod4iJ+ykjnlbpZk?=
 =?us-ascii?Q?juw6awh6NffBX1ZlAEDWctbe6AySmSg2omg2EE+ZpWFkSbZkb38cIvmpkL7v?=
 =?us-ascii?Q?NTqtr02iMFk4vdQWd6QUt2icz9MY2uYG83CMJ2Lgnc7ukbtzLkJDjSs5qrEF?=
 =?us-ascii?Q?8Uj/wpwTd9Tngq8KQ6ojGhyUGPa9n4ms5Jtu1pCxFyqrvc533F0R21QMvs5N?=
 =?us-ascii?Q?Nar0Zuc1kpYrSk4IzQx1niNR98ErHgjLPgv5HkfwA8DhLRH+nXxuRcZa6E8F?=
 =?us-ascii?Q?H2I29uczo+0TgHseI6zROzVy4WQNGS2jTbJcsCL12y5zKf10Uw+DkFXsrh5U?=
 =?us-ascii?Q?9mfkTG5w2ZQSdIwD9QN5Gf6BlDbkwmXxk+EjPrcKTQ0OQdLRKdL/8N/5ULaI?=
 =?us-ascii?Q?zgO9TlsQQZcAFzUiur36lFO0O+Ei4GK3BK8S3MTYgenGXq6PXobxHST/jvb/?=
 =?us-ascii?Q?zF/VJzA2ZUrvLD9oaGhAhyPgcNwIMgFPOTiZiKSOVKAflfytm/wi3vvsAJ9O?=
 =?us-ascii?Q?KlwuJEJ6DMkC5n6sVMlIcKdT57JrdOzL60fIkGkRklyq559LBXYT/qRTtQOR?=
 =?us-ascii?Q?bQRxP5jA7vCu46o4Lm/sfgMSC9qJAWBuWokNp3yDQxDJRKHNbuzVOXc4jnyz?=
 =?us-ascii?Q?UrU7/6esTIgIxnSOrytYVNzYVta93e6ou4gqNZL1ztJTmuebcUv8SrzyVg7O?=
 =?us-ascii?Q?VnXTp02F36m0JbDjeJXdt40UzUtksE/QQdt5jqCwmY7AUhz3AOb0eGg9mL1X?=
 =?us-ascii?Q?xuqQxISQ+8nvpA0g1IlHSzH+0kExtWikLu0tk8GGUAEfeY6DJHLY23aOXkeg?=
 =?us-ascii?Q?N/g6FKC8eJLEODlTSKaCcAtqG4JrgvieO2czU9yNIx/43UTiGUiHiJEI8vzO?=
 =?us-ascii?Q?RWdLd1sDj3wSdg4UJ6huwDlc90lea+IM/GmEcEVVaNXCxe3dVCunV0unKLBb?=
 =?us-ascii?Q?SJF6Q0mwr3QXydlDhNbjP2pt8itanNH1KxoFnno7zkKaUp3cb63ufXjhOric?=
 =?us-ascii?Q?so9tJ/BtTuuptxmrjlnd4NNc/Ue1lgFHis125Z0B/bkedn5YuM0IoEeqrjxI?=
 =?us-ascii?Q?tp6avMuMcIAT1rMoRM0X9VewWkP4WxtplpkyXYykclvZFz1jgalA8hfPQiRW?=
 =?us-ascii?Q?QnUWrXpAyhdsaamW+g63LSmoCqSY6Faov72z+cMsIcJ7rtB34Dh4WVcDYDO4?=
 =?us-ascii?Q?2+yxmNogzWeAIXXB5Dep9xJG5V1w3ysU73JGyCt2SJtM6xR3kqYV?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef166fc6-3e9a-4c3a-3f57-08df29d9f2fc
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:00:17.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /izUfkTMDX/vKBjCH1sdBbEjR6P5LOcP1bxdmt5ucujkJpNe82Ms4BaaQ2iHXd9idSmhxP58nkWyak35poUuGaSOwN7Bu1qHIebt5eFKcNwEvz5JiygI5KsgZIy4yVJo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12951

From: Au Dang <au.dang.jx@renesas.com>

rzv2h_tint_set_type() clears TIEN while switching the TINT source and
then unconditionally sets it again, enabling the interrupt even if it
was disabled before the call.

Restore the previous TIEN state instead of forcing it on.

Cc: stable@vger.kernel.org
Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 1a4703a353e9..485c3eea7632 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -420,9 +420,9 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq
 static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 {
 	u32 titsr, titsr_k, titsel_n, tien;
+	u32 titsr_cur, tssr_cur, tien_cur;
 	struct rzv2h_icu_priv *priv;
 	u32 tssr, tssr_k, tssel_n;
-	u32 titsr_cur, tssr_cur;
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
@@ -477,6 +477,8 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 		if (tssr_cur == tint && titsr_cur == sense)
 			goto set_parent_type;
 
+		tien_cur = tssr & tien;
+
 		tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
 		tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
 
@@ -489,7 +491,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 
 		rzv2h_clear_tint_int(priv, hwirq);
 
-		writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
+		writel_relaxed(tssr | tien_cur, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 	}
 set_parent_type:
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
-- 
2.54.0

