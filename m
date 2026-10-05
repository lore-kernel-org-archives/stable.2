Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3342E2DDD;
	Mon,  5 Oct 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223358; cv=fail; b=JspsFyssMofmiPsopscADmjaD6g9tjekaI0LCwyHzyB81DZ7wcmyi4QrcPum+72eNPRt8FeXaD/q4qwCRTEoqdwQAVqXtOlaPGCrRUxxWGkvzFqmb2b95xXBNgpad+BNwdKh30W5xFmX7kf1tIwTQG/61mJjLvNxPri7lwMNejo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223358; c=relaxed/simple;
	bh=qPqteqKqJKnfJGjmTS+92EKFez+DvYnWK22SRgaj7I8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P5eBOVXAwCd9yCLku2W6uqNX2/yQOokUlQMAvuykDQH+M1FrI3OfxkvKQ3kFas7K70OJh65tgEZh4hzDtpEEGMHkQtj+h++t1JpCAiPiHzNru2Zbgg4c+4OCwP68vWA88Z5oQx2B3YdV5OcHc3RVli6LbPWPMfMLgG/K9O9g26s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EYxO7m3b; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EYxO7m3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/8xKiiGkYsJt6BIU2KzunrQhgLTfYD47/1oeBE3ckwR1Qz/N6ZKWceNfYyBJEbBEALRqUpIIXyOzyO+A0QxEqfLIEq1NspOeP9c9dFKJVwN7pbrm5iMMMHaT8aVIKcsV2kEGrJ+8SPknfXzWdOWh++z9U6/nEXqYcpfmupa1GdK8l4VAMN6hL6ouI+Ir0XaGL3paYpzLW0Wf+0bdngimK4Dn0nKRrYEqWM6YmyVZ5xqeQZ5wyFOjDNg8969DSWwHJmVYQYhCbKy2m0JmeYp3ActPCC6ENqGWzEqsux14TRPDQ8aOTU3fHYRaB56mTa4FN8L0C5JAdchtojDvUhqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrRbQQfyxavAMqZJL4v4XhKo7k/c+9n8pNe8GCoKdHI=;
 b=fZkr13v5jDop4hJIAsGIsDXMdURPqR5F3vwJ4tHC/sajfe7JevxVjZOZ41Zn40eLhHkLJ30Oftpp8RBAzAz8E4yflMPsWBsoP+7GNlEOy8mdvsmorAiWqMufAVbxBLzNZhAWGEgkzNDR54/4Ed+l9l5Tf9bKvTnawG3NtCwVFHOMbZYSD5p496MOiSLQM8zCGpf9BxMuvvSWKb5yUN0u1wFXkwqfqr8gsvnoeU1MW5ui442xxqDGCL5IS2Zvw9FHGZSCfap87SbbtHxwcFYhOngARC2OR+5kU+OrWrRPDh15WAH6qsiEOhSnnLS3gjfSoetwj/blMRf7Mw93DkZ7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrRbQQfyxavAMqZJL4v4XhKo7k/c+9n8pNe8GCoKdHI=;
 b=EYxO7m3bway3c+JkOzW4oYmed4X7irj6s3mIwba5bJCWEAkGX7viy4NR2yHrdyGuPpxYdNzYxkQbCun6hxGC/MnRIDYi330Xf2c4s9by78qszxMHmih5cyNg+GP8dWN+lMZ+MExbRucj62fDCEw/uf9X46pimxYmrvdPyVTi40Y=
Received: from DS7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:8:54::28) by
 BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 18:02:08 +0000
Received: from DM3PEPF000265B7.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::46) by DS7PR06CA0040.outlook.office365.com
 (2603:10b6:8:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 18:02:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B7.mail.protection.outlook.com (10.167.23.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 18:02:05 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 13:02:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
	<linusw@kernel.org>, <mario.limonciello@amd.com>
CC: Olzhas Marat <marat.olzhas@gmail.com>, <stable@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
Subject: [PATCH v2] pinctrl: amd: Clear S4 wake bits when firmware has _AEI
Date: Mon, 5 Oct 2026 13:01:47 -0500
Message-ID: <20261005180150.1024336-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B7:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e20fee-705c-475b-c27f-08df230ac438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|6133799003|18002099003|13003099007|56012099006|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	q5RQZKZhcp51kYmsa6cBqkaRG2GzjUB3YTB8YcQNAcHBr2vxDivmPZGWbIQ+8K8p6EHCGNrrP9DeHI5zq6fY9uXD4D0+oBr1d37rcjAzXU8MpjWmk19NpO53Gxoq5osA1uWsRdcwuHj1xnydrOl4UzBvYC3EmirTWn+4gfCYFmY3JIjJcYlpD0LpUNX3xfdf2d+/8w+bM1B9JHJRypqjeZgVhvEYdkzUZsP8RNsviKhTr9y0/TqxYI36nuInVB8Rwm4iZXgCXznS9A1pXti77Jlwx0E32MbxYB5xDKASe/30hapohBKLJwH/Sfy1p55+wutzH6XbbIyG/yL2VJLQxcFwG2mVVP7V/D7k9Y4h6JOmOP8XwWmAoTHYJ6/sDHgL3TA3WVxNBU90wrY5e/1vr4cIkeKXmWR5XQT1Lrn6cN8jOGKcuJJuQ2LHLW7nYjXJB/OqaDpO1rLDSiW7Tf+W9KkpHBFvNbQcNjc4bqGiUPhnKKlj2MVMkhXYry+yXpV4f1G859nEyCz8pzajhhQWa8EifPfm42CVQ5WHuM2r0PKho/Dqy4ZrW/YkbJirNJ19oxC6m046CBctds2/PHLABCc+zQLXu7M/T4hya1KgTb2R+Yvw6b7w08Ss7dZo2fA7DYW2Vn+NX+WL3LqvuLlyauLvjIG+EIOib+8CwYbQOHq5LNHxqeLXGfBXFG/E3NTKP/I0mMzT1VwlXXaKA+IzPw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(6133799003)(18002099003)(13003099007)(56012099006)(10067099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zFvhbz1Hn5uq9eMPY26v3HWBI7wal+zBKSSFQsthQxkzd/7+1b5XwyGyUD2Ers36gNP7zRZntU16jjs4kUkU1FH+y1h/Z3CMoW2eXmxYDaBforJukCgpbsLi3MIBBcYIn4HQdCy2nfJy1sjRMkrvpO6QCKUoV9dqFfVanZAtaZqMmp35UdJbVgGMOGVaBXh/Z/C4Crjzh+2UVYQfrq5KUJFcy37WwS1nqreQtSzptcU7kwLIAyziPW0wUC0ZnfvOfJUBzE5K7CZxmDPVVP0Zr3a2gYIckuGHys+a7X0DBcO6uH9pQQvfkxQRhD+2TOzIGOvy2LtwGf4HKWBKSo56LeVA6bK4AROyjmOAPZEemTjKXft4AsVlYZrMY8DXccDfMwYxaWDftZ6BtKIf526IZkCpkRU38OENN5scmbmgSsOovJfuYYUJVPt4haqc+L+d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 18:02:05.8189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e20fee-705c-475b-c27f-08df230ac438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097

Commit ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
preserves firmware-programmed S4 wake sources because some PCIe devices
rely on them for Wake-on-LAN. The system that motivated that change does
not expose ACPI GPIO events through _AEI.

On a Chuwi CoreBook Plus, firmware exposes _AEI but also leaves the S4/S5
wake bit set for GPIO 24. This causes the machine to power back on
immediately after shutdown even though Wake-on-LAN is not enabled.

GPIO register dumps show that the only relevant difference is bit 15 on
GPIO 24. Clearing that bit makes the machine remain off. GPIO 24 is not
itself listed in _AEI, so _AEI is not a per-pin indication of which pins
the OS manages; it is a platform level signal of which wake model the
firmware follows.

Use that signal to decide what to clear. Continue clearing S0i3/S3 bits on
every system. Clear S4 bits when firmware exposes _AEI, indicating that the
platform hands GPIO events to the OS, but preserve S4 bits when _AEI is
absent so that firmware-programmed sources such as PCIe PME that bypass the
GPIO IRQ wake API keep working.

A platform that exposes _AEI for some pins while routing a wake capable
device through a raw GPIO not listed in _AEI would lose that wake source
unless firmware re-arms it during the sleep transition. No such system has
been reported.

Fixes: ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
Reported-by: Olzhas Marat <marat.olzhas@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222041
Cc: stable@vger.kernel.org
Tested-by: Olzhas Marat <marat.olzhas@gmail.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Add tag
 * Drop handle declaration
---
 drivers/pinctrl/pinctrl-amd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 15a398bb3be23..6835e943909ca 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -886,6 +886,15 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 
 	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3);
 
+#ifdef CONFIG_ACPI
+	/*
+	 * Platforms without _AEI leave GPIO wake sources to firmware, so
+	 * preserve their S4 wake bits.
+	 */
+	if (acpi_has_method(ACPI_HANDLE(&gpio_dev->pdev->dev), "_AEI"))
+		mask |= BIT(WAKE_CNTRL_OFF_S4);
+#endif
+
 	for (i = 0; i < desc->npins; i++) {
 		int pin = desc->pins[i].number;
 		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
-- 
2.43.0

