Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487724;
	b=HcR6iKpNdTGiplSEGqxDabbHAPiF0x3E7/bEHwA0ABp493C2SZC9cZwy0zN56ZMA12L7
	 6ja1ZlFnXsjTl51rQU2KSCNXF7pxsayGAcyRBzjNAFgOUBAc0wGLK8w5lY5pnNCayMa4p
	 xUSsMsaSZWpIMW6EtJK4eDpdS7ZqSO+boldN+k5sQ9dme8vsdoHy7b5MBep27q0XkGngS
	 ERhy8sUNf+yjlytYv5QpFbmRW6b1injUdTCmn4rYBf9E3HQZj3aRDnGlE5ZLYjTNLtsoh
	 PI+0+Hk1W3+YZMQxQ5Wzgek8jt5WXjPOUyv4RtDmo2G4u6t8pfM5EQ1FlqpiDGuDOQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487724;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1kBfD8tmNb5GKz9dcvc12Kx2gF2AlpDqKRVcvnJg4Ds=;
	b=SI2TRwFKnOkTxZGzxPomIsWPQbbkIuU84mN1y4KlbA8dww7hq/8B+JSfXfEgHksGqIf/
	 LG7RKfXZTLYCizLufl5RpgncH4typGgwpyKqVgH2luZ0q8PrNVjA2jV9EmGDKIXcPc32L
	 9TkFp3a9iVbmmmRoEU0oVjFmDR4KVvQurnvDNrfl2k1nOQEhHjDrf/89u52Vgn8kiC0nP
	 focqKrPPNeuqwIFj9TNKTkbqLrmnbzh4W2HFfIzIfSpS7+TRtArCOvQueosbWtYq8mw7Q
	 4AuTjjEVvNtcl9U8I/38nrqCDuIZ2/r3rktK5NXi9smlVG6SHm5A6KymRLfsT9MebBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=NO4qTmsy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.52
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011052.outbound.protection.outlook.com [52.101.125.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44129606A32C;
	Tue, 20 Oct 2026 09:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44129606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=NO4qTmsy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0gePKQYKCzMkmn4n4NuEFUfVJZSn8rS4O/ulPU7q/V4fs8HRs/204dyHJQw0nkb1vPrZCxWNYPvn5pB8zzFDdUhO2zeWuPiDJVkPE4cCOCU6A6j5lG1mPjdogERNZmLWCn6NUZK88+ws+GlLb9elYQvJR/mvYXrJNj3MicoNV62UJo+nRsF99wGQZjEXcxPkIvUcyLVCoylOl8FwCV+M6i+Jj/4GHYt+hIfl6gnIKG/+OH6Vcf0C6w9FMJgkZocdcU97x3ydqCzuCUamcnFklBSYBDSw7z6pUSndouX2ZbVMOWT68TWMW1KBaeDZJdtsx63VIxRAJa3VXCPkoG8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kBfD8tmNb5GKz9dcvc12Kx2gF2AlpDqKRVcvnJg4Ds=;
 b=YWjTUlFZdBxTCfsTT5stc3rYPZqLdihDIJi4JPEfTZwNll95pSRMOBJJ2OgjVmBimlUAdzc6qU0/4FT6IrlM2Z2y5RHQ/SGWmr69O38eX84gof7d9dO89uopElN4/PyeDk8JfIoqWBmUvjm6ioEpHPmLdSGNB3vNOgHwDsDfY/qc4q0qXqYGHdwMi/V1Ou2zFCJwvwDTjLpSzpR3Flml95vmZmIv8rfcISmSj+SGFFqueBwwc2E5OCMSRmgpt2DuponqVFmKPD3lmKvI4rY0ByqkPEPaSyF/RgyIxtjLqZpanzA0UJHoRBdPaqKLWESjGOnT7st6YQBQBDlJfaQqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kBfD8tmNb5GKz9dcvc12Kx2gF2AlpDqKRVcvnJg4Ds=;
 b=NO4qTmsyuNRHzyg3xf8SoFjKnuipyU4SAdEZ3/p4Pak4nBHu1c+57rw1hgxnHYlibAg8yrMA9PkoN8RZ4KQZ6YTVrZJ4c4SopGZ4gMbATwhv7v0avfVpPPNZnroyQ42XW3RMvlNHjRcWtYh7hLAGA/pv1GvHpglzVTF2CZro2a0=
Received: from SY4P282CA0018.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:a0::28) by
 TYCPR01MB8141.jpnprd01.prod.outlook.com (2603:1096:400:102::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Tue, 20 Oct 2026 09:15:20 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:10c6:10:a0:cafe::17) by SY4P282CA0018.outlook.office365.com
 (2603:10c6:10:a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 09:15:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Tue, 20 Oct 2026 09:15:17 +0000
Received: from [192.168.1.82] (unknown [10.226.92.108])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id EF5E53000274;
	Tue, 20 Oct 2026 18:15:10 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Tue, 20 Oct 2026 10:14:55 +0100
Subject: [PATCH 1/8] i3c: renesas: Fix zero I2C SCL rate on pure I3C buses
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
Message-Id: <20261020-divo-ssgrlpcsrc-2966-i3c-v1-1-30a47f25e515@renesas.com>
References: <20261020-divo-ssgrlpcsrc-2966-i3c-v1-0-30a47f25e515@renesas.com>
In-Reply-To: <20261020-divo-ssgrlpcsrc-2966-i3c-v1-0-30a47f25e515@renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792487702; l=1775;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=DVrBUX0Qt9EcEADAiFPg1E0pKuScHKLjVfZNCV2qjN0=;
 b=j111WSgYHwOqnaOVgLL1bKGVbeOBoSdNdfS2JYvThhKPX3Y+oBldR4h03GS1Vqp5pENTA+XlK
 e0mwWx05IXDCImGNcpOcNoTXQGEcrOKBEwBKkXeRere7njVV8pGvneE
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYCPR01MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4fb111-1f33-4cb0-b274-08df2e8aa8a4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|921020|18002099003|10067099003|22082099003|261009223027099003|11063799006|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	N6cx7r8dyKSHhevcX5Zquww96qekiSUIWUACnOewqilLI7AMIUYrR7auUNBDcWE1+oeyE0HVvYaLm7JsIKmjz0o+SXG2JO1APXaIg84ijjgdTsN5bX/t4NyOF6Wlx+oXEJG0q6Bmgt+ICyzLG0YEFAxri6ilmwQFQkqJRVLUZAUiXjKf0/Gte2Cjs+wlimOKt0cEWTzvcva7G+ruzhtmTSzG9CySj9YSQ/e8WOjgkpmpS/Wgc+oXfT7K+Z9KTb2yrz36cQXflz85xXIvp1Y8N0rcGs2+YUbuxRE2w69bLiTDlyZ6SLehQNxfyDkZGDxSfYlj8oxUGYqAWPt1Cp9Nl3P52fE2xZwbCN1yAdWa/v+qqee8C9gtuUQ+67PhlRHeXvJvYzC/qYWT0DlRZFJLnpIrB7HOxvxLrq9x/JQG9uy7oordG9JxhUU5hn4YxbYaIr+bexwszXYte9WZmTo0xAy+pP+HbFMmofW126eRQmTZnaJHOgQ+/YhtiqJ/XklbOclcSSUMSFWHbrcsqT0Uj1O43YxHGFp2xy/iXeCosiyJZmh+v0Onb3obUfJvcq3PKFNWCWC1IdLkFobLZAt13M1vcqcdzZBe6Lw38V4qs9B10g4lMZ3Xom5Vt4GJFs94X7KQSHbe9G+Quju9dYxi5w2kB70ohHQUsnNESEAjffScqTmq90WevjOnKytJLG/VkMUNytocjAZJPUZAm4ccoSIZdQ7D64s2F0aItNPtIT+p997iKPtlMfLDne6qBcCa
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(921020)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	di3Daw8SA/j9M7IDobwfhRHCoKtXDa2yADRL9IeKKMGeKHyfat8KAHh8a6odiHHkoEm8JAOKfkj1D7SbAf1kSZbgC3F/o818eDCtaAtx1m46A4NZMoEf4VKoQQms7lBr+JUA5tysaO7d1XHPg5a1Mm/VfSY5KNEflANkmb9YOVgAxfDHv9AJj7CoO6Grmlg07PilK1z0+VcQ803upeAKTvOvFpsA6BddxOSUNL2zCH25S/yze2mxAw6/hL0pq5MqhMQY2FPDaBYyn6/hpvcPr9z6nUyRew8qlcI/XJ6DaYUAYSuqnNowIjFhVU/lpjA0G6qpjEhNT0Lo7Bg6UXltWTMzmzTPHuaKCi0MgsMKAm0dlGv8qlioRHz5vvRVMks4gJoRVYVSxfw/o74mJjbSPc1R124crvBAdpDSTs9oXFj/275m2MiBfXqadEA8LxCJ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:15:17.9128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4fb111-1f33-4cb0-b274-08df2e8aa8a4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8141

On a pure I3C bus there are no I2C devices, so the I3C core leaves
bus->scl_rate.i2c at zero if i2c-scl-hz is not specified in DT.
Deriving i2c_total_ticks from that zero rate programs a zero-width
open-drain SCL into the STDBR open-drain fields, which are still used
in pure I3C mode for example in DAA.

Fall back to the 1 MHz FM+ limit instead, the fastest rate an I2C
device could have, so that a sane open-drain timing is programmed.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 8b264f72e55c..1fa115bdab6b 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -579,7 +579,18 @@ static int renesas_i3c_bus_init(struct i3c_master_controller *m)
 	if (!i3c->rate)
 		return -EINVAL;
 
-	i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
+	/*
+	 * A pure I3C bus has no I2C devices, so the I3C core leaves
+	 * scl_rate.i2c at zero if not explicitly defined in DT. The
+	 * open-drain SCL fields of STDBR, which are used for the DAA
+	 * pending read, are derived from it though, so fall back to
+	 * the 1 MHz FM+ limit instead of programming a zero-width clock.
+	 */
+	if (!bus->scl_rate.i2c)
+		i2c_total_ticks = DIV_ROUND_UP(i3c->rate, I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE);
+	else
+		i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
+
 	i3c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i3c);
 
 	i2c_parse_fw_timings(&m->dev, &t, true);

-- 
2.56.0

