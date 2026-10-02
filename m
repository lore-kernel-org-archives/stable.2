Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0EA4CDDE9;
	Fri,  2 Oct 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951470; cv=fail; b=Dwot99SFvLbo81w3ekan3jfcoZeD54ldCyZjDpi2PmfrWAhRwsGRN6AwzKOKrCf+ax3ul3kD7AKN3ScHY3/a+82zp2Bl6laQaoMLezL9pGI3q1jZW4UaofnIA+Dz1d1wyoVWdwnSCFxspBtYixmcJ73PeSQwhhkSjqUlIzUJmUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951470; c=relaxed/simple;
	bh=ripgC/bj+tKbQpKJuRP/dQFQlV1A/NNECi8gpQQEsS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t0IUiLjf5fBGurC7ByYKFBthOMcuU8dugkgU1JUkhb9DSuTZwXsc+NJWVmDxccxOA2orprk9iuQWd2yrW59WY/htbqj6+hYSkdru8IFbY08jjLoBw5JpkXD1MaENYcmRkmRJkhytxHsj2gvZQLutvMw5ZXoBaPpoJQJWGkTpweA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=04UH8YcU; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="04UH8YcU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJQ00RacdoY+BQkHL9NuIDVBH7nlnGwUOdh/yJJyiYxwgUCQtG0xUQpPJlJilynPJlNuvKlzPcJdfASJdjrnbsEfIgfEDQu8EK9A6Ef4Vya91z9WpaB9ByHlgM/0DEENqoJV5WHx/L8JUiVvdRKAoufmsajXPp5QUZsxtPO+pPbKBzOg0qSC+2xrZG9rBgpGTIyCvULiOg19BTlDUPwCsD2RmkWhLFzyO0CHZmAWl8sl7+Io93TR4cTkt6jomOXdY5DS8As6YHHZpSJed+eU8eRWtQ3N/wpdLWbfthDd3tjq9UAAocGtuHpxrxgPVQfyLPUqK3Ib8fsm/rrih0aSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJjKaW5Fmcq9XOEg3gklfAkg90rpz3yIzVcvADifBlY=;
 b=vgGbfdnug9CoNyeX4Byjp8oN8WG21uvLtKKqXxQclCAfYv7PR7P1+WV3Nxj9ddAJO3n+JoEHOtgDovdWSWkNN7mz/O10BMAaQjIihfY0iBdi7ChIom8+7SPNUgnmQKcfaoiuZSjzOTkzbT/nXPuzTw7cF5kF/CQmYooSCYvCBR7vy7GHUZeEi/LPDYJkke+pxk+Ob19RZwz0uLE63kfBdrqKPVObeVvKY06daynIEsX9kYlmRR++3o91nkvgxpIvVZ1UhdYTs5rTib8oPri3y3+yowuy7b7A71pjT7ON0H17gc0RXxQpNxocjceQKKUXBoQmrA+kN4d0kc44HfJ11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJjKaW5Fmcq9XOEg3gklfAkg90rpz3yIzVcvADifBlY=;
 b=04UH8YcUt8WNIRPsXAt3gV+w4YRP7U1DVMnO6GHzE3fqEbJ3vLx9qlNsoT3UnopcMhifgtCgkg4vwWyvsH2Zirec/SCYfz9ms1b5XzGHlY3PLz0plF+GnvgIeNzi2PbukI+Pm2pAiyBBk/oA0xoUpeJEhpEhWS4Poqbq7WE38PM=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 14:31:04 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::f) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Fri, 2
 Oct 2026 14:31:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 14:31:03 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:31:01 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
	<linusw@kernel.org>, <mario.limonciello@amd.com>
CC: Olzhas Marat <marat.olzhas@gmail.com>, <stable@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
Subject: [PATCH] pinctrl: amd: Clear S4 wake bits when firmware has _AEI
Date: Fri, 2 Oct 2026 09:30:37 -0500
Message-ID: <20261002143040.37200-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec94395-812a-43dc-bcdd-08df2091c9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|18002099003|10067099003|13003099007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	w4RM4FBOA+/yvwtbBWwTQR+b+iD3upz2QNpf9BKrnTff9Lz7FR80gKUi9IhSMx562lXwbXftECHBYXnrPzRIBH4trbVDeUrTLB9411Hd8hoWZgfG4mA/Xh/5953VID623Bf3oA+9AsF0ZVhakxZxL/paKHy7oamb2wrFZoz2buCpuqsa0jeNz+Z938GBwybbn+SWLrVIGz2r5mu67I49SIkXnHaiu5yd98J59xQ4pe9gkfyqpy3TSbiviYV63pzW6y2cxhL4bSDs9w3IUyY5otfZtY/D4u3WGyon8/soxVxngnNS5n9j2L8w5U8BMss7JQNVm9gtqCGku9zlbi9CHK1fviXun8+Yxt1dR88oeTfukPIkqBvD183hOjeZlBWXZQcdjMLxYnYF2eRLlliiFaUmi4kYPhiXmvFxlSYFRJb9/GAzfBtpajgPm+5/ATpVkBXW/EhrJJICA6WAFrOGVSQzje76rSGwREu8FxWecSlMKdDyDa55r+PoGs8F5lUJXTtXlNNNBR0M9c2pLN/E0QuiXJV9rHD77MooJbPaPQWJ7CZ6WuswUU5j0XC3LEsrJugOcxUtoRnF6/WT1a6kDxiYatD/zJWnH/k88gHmVQATLuy+wszW2joYm1p1HYTbKVQmOUD4vg9qwZjCIO0vCOmcr+s2k4KqeQ/eHJ2tAZ0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(18002099003)(10067099003)(13003099007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3w+sOwmC2+1Ekuc/aTjt7hMXqBvM9bw8vxNUxvLZdA63apRRb8un2dtd+1wNr5qoWqlkp9ROR9pVqWvllVyVUeiFBnsb6XcVr/sYldbIQM3AiWKWkfc9X6aWkSZhBaEgPJzKyUuc2v3XsmMfv3vZ6NHGbw4bNohqmFyyF7AaJZU+Ee2RbA3uL4pgd2nywp3au6PPx0SIugcM79A3FARXc6sTWiABfvl67hVgq2Q0bB7vefvnZwI76bpqcdtbRybvD41IHPjM1QGfW6KeBd4lcjJUvHn4B2PlDrpaJ3wXxa+PxzflNJDDwhpckVOwS9Efwc4gVEC4WV2E1l1nwZRLUOgvQI3jqFZGp4jXiUzom5uI6BovNugeNj9Tbtutimp9QKwm5uAhLxVUs2/pHNbOBsUny7o0tF6nDPAph+0hRc95FjOIkYVITahfdFskyLjW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:31:03.6071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec94395-812a-43dc-bcdd-08df2091c9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Commit ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
preserves firmware-programmed S4 wake sources because some PCIe devices
rely on them for Wake-on-LAN. The system that motivated that change does
not expose ACPI GPIO events through _AEI.

On a Chuwi CoreBook Plus, firmware exposes _AEI but also leaves the S4/S5
wake bit set for GPIO 24. This causes the machine to power back on
immediately after shutdown even though Wake-on-LAN is not enabled.

GPIO register dumps show that the only relevant difference is bit 15 on
GPIO 24. Clearing that bit makes the machine remain off. However, GPIO 24
is not itself listed in _AEI, so clearing only the pins described there
would not fix the problem.

Use the presence of _AEI to distinguish the platform's GPIO event model.
Continue clearing S0i3/S3 bits on every system. Clear S4 bits when firmware
exposes _AEI, indicating that the platform uses OS-managed ACPI GPIO
events, but preserve S4 bits when _AEI is absent for firmware-programmed
sources such as PCIe PME that bypass the GPIO IRQ wake API.

Fixes: ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
Reported-by: Olzhas Marat <marat.olzhas@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222041
Cc: stable@vger.kernel.org
Tested-by: Olzhas Marat <marat.olzhas@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 15a398bb3be23..dca01c5d2231b 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -880,12 +880,25 @@ static const struct pinconf_ops amd_pinconf_ops = {
 static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 {
 	const struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	acpi_handle handle = ACPI_HANDLE(&gpio_dev->pdev->dev);
 	unsigned long flags;
 	u32 pin_reg, mask;
 	int i;
 
 	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3);
 
+	/*
+	 * _AEI indicates that the platform uses OS-managed ACPI GPIO events.
+	 * Without it, preserve S4 wake bits for firmware-programmed sources
+	 * such as PCIe PME that bypass the GPIO IRQ wake API.
+	 */
+	if (handle) {
+#ifdef CONFIG_ACPI
+		if (acpi_has_method(handle, "_AEI"))
+			mask |= BIT(WAKE_CNTRL_OFF_S4);
+#endif
+	}
+
 	for (i = 0; i < desc->npins; i++) {
 		int pin = desc->pins[i].number;
 		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
-- 
2.43.0

