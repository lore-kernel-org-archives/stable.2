Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426636;
	b=UYDpPE8DOzqtEuyo/CA5RxgxfppFtRtajlYNvm0dHMpfbLhvwb/40Wz3Sb4C7dde4msy
	 dGd3bgX3fZrfe76JSsiyRNg6VWgDVCRmxyQv+mF5R2cG/ug7HQI8UQTovvp4j5gTE4pM/
	 tzt2iQ+4lcunkgX87Z9l8HveS6TqXfDYYivbdvq/C4ZJslWT3w5ugkH6sgPSGigWd12xC
	 9bltwObmqELZJNQ+H6/pK6ayxf1nRO2mugRoHAAszuVHoqrqG+JOByMqM59lnV8MvcTUx
	 2TOS0dIzX57M/MDQiql4IuYT9uCtIoWGWoP4udP1/o9tfTTbJKj6JPrgBGw0hGDu5TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426636;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=SOFQBtcblgakYOLve4ND4PVDb4vowReo5skLYQYXOH0=;
	b=Z30dra7d1noP4afK8ZziePRTq2/9a5w/BS026jGRGtC7Kvbb3zPvJbZs77ClcGQRl7fI
	 vhzibMUXdwQNvWorQoDmwnA5bwpbYZhC9gFa3A7zaIPoONKrDQrs4tg93MNjbQa0iS4aR
	 5vINHruvgmQMM94Imfc4VgVogx0W8/QqIIzfdRcZG3A60Doj5dvJb4uUHN67JoLYhlbxl
	 DnAnOtkgJE5K7HMb3M98zK/tbfKRyPlzDOzjr/3OiXSD9EbIJFjpOrpC5/Xm/n+2MSykL
	 J2r6qN4Y9zF+ZktiUBpMLPbiXtT6dmix7qMywx5kyBXtB0Cj+wZG3eSZhelhwpCVpsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AGqHsybk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.52
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB38606A319;
	Mon, 19 Oct 2026 16:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FB38606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AGqHsybk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwtcvuS0isY/fs1W935njufvwBHJ+HNKDq/hRM6UnCWiIRcgUXBkqdbm8t06Jj16G7PVGpt4zjw7SFMPOS7ndVMPfzy+VnMfOJrCxXIk7o2Oh2p6ALBuL8yCZnaFBSvl29IeRtiU9eMRv2BDhLydHSAugDlBR7PazmFEXVzP/E+23MoG10Q7i++YT65+63DhAB7fyxAfT0/tC1mQIsHsjuZmPOb8uT4eMZIInSN20M0/I0vOT1tFpgj7Gpc8dv7lsC7aL3tI6B98tu6o1ZJGr4yMHiUAFx+gWsTCFg2BryWgqOry+KeCPr3Nd0NkP9Gkkd+4Md97lwnnZ3JOeG6QTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOFQBtcblgakYOLve4ND4PVDb4vowReo5skLYQYXOH0=;
 b=p6wkTfE0VMj9HusRxBIWNAolIhc7J0firuGUFkDNhSTQCxAtK8KWl6kSiw/QBj+adDSp14NR/Ok663uedXce3z2S72EFOvaWs+vw+HaJaVOxth5HvxIWn86mp1io0ypfNs9cXaFj4s9n0ntd4iqV+ftrIod0FI7IoAUoOzF6xogc6fJZ48QbUAlhqmOEcjN8yt7lEWXyNU4UUXFuYuigBkqpo6AC6Srgnmd/dPJCXWLcZm9iXzO5OHCRyfqGqp3pIyjJgP8VFUSsmACJ/s6kWPr4ZeLEcugyLO2ysioSStkwgkkH5xVntgKwOq2DlkvLiVh4rNg2uS7gBv0iQIa22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOFQBtcblgakYOLve4ND4PVDb4vowReo5skLYQYXOH0=;
 b=AGqHsybkDtjwveSyc+qhXCKk2KAAMtwCPQ8x0fIBbN0ioZNADMlPTmDWPbyIA3Cl4TdEOqOfCwIcwJkZy74B8475BwUWnPUzuBkXuDKlzqNksUue7enof/xtUEk//x9qDBgnH9I+bJg0YD2Y0RynhIzIePwyrBYk1JUVsd8UJ4npNNcfCuohwNs0zs5XUTiLyqBwGxY3tGFDg6cftVAdR23rHym1owU+PM1HCOuLcZtl1ZVETWs2dAofmZiE/lPx0aEDxqeRbm9kNOIdd4chAIZmeQXDLogkzKyCjgikOjpzszqS1qQDcleNQbKALHlpzG9wDYIJ4FsWB0BKniHwhA==
Received: from PH7P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::9)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:17:11 +0000
Received: from PH7PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:510:33c:cafe::11) by PH7P221CA0037.outlook.office365.com
 (2603:10b6:510:33c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 16:17:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF0000000C.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:17:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 19 Oct
 2026 09:16:51 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:16:50 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: <bhelgaas@google.com>
CC: <make24@iscas.ac.cn>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nirmoy Das <nirmoyd@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] PCI: Fix host bridge double put in pci_register_host_bridge()
Date: Mon, 19 Oct 2026 09:16:36 -0700
Message-ID: <20261019161636.2540334-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000C:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f21810-3a7c-4549-28c1-08df2dfc6e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3s4cEN88SaLAo/0LZ15/IketlgVk44wgS070IhKDAW9xwR4YO6dDlR9m1v85MebmR/LbEAwx4/ghd6HIjwPt43MVJPcmpqvdroViBAfD3QUPipYwPUOApWASpm1X9Lz2toNvkwF8nPF7ZeQtpXjw7sLojVIn0FPmE1hcJElKHjqqm0x845O2eoms8HCssz79tN6STeyA4xlacUfrNNMpyVxHYUW7dBmX8A3vjryA6AXXo0eP+HfN9FfK4/WAjF6+UUeU+oeuOeZ4Wk14t0veiudwxncEuE5de19pXuzhZ7bdRCMuw3vT+69yGZysPYHMEQumb2Z2GPtStUA4SZCI6DJaPYW6AGy27voGSO3mVE8+n8TBEQe6+GLKv/NwlqwEv+2gBhNHSFeJwXG5T0o8mycAFmhetwqDM3BBxdvOMyEA+3kDPiUri5KnUfL0SKA4LwO73BfKQhTWj2CiqhUNBNDIGnqpHDGXx+KfFi2vYWje6ULfqqhJQ2Z/Yuqj0qLlVOZVayE+UZpLvHnNAn14cXlLnH3DrkLjZZ7l5XtRMuxTNQSX8a6FlO8NuwXSccVqTxRRFnlJNK8ocVuxWi+kMOZArQMhMFmk6f/cNo2Am3HAQEPxyKtjjrdRt4embuAZRpyeTVhsXCVNkNTwSbwzNSEU+CYIVzOaiCd6/MbWXnlUsqo5bOy1E20Ph5aWvBJsRHQJ54dsEFyveJUBMHQRQQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AJ5hmvZE2xeAc38hJTNAaG9LOMiU5Q0p6VWLSFPtv4EUzDJSnqPY4uWvx2wzkcJJD8INeTJuvTZDQjGMkaESFGtdwaizjyuAWJxlzYbLbg1U6PPT8J6ZpYtG1XSeKYY6u4I8W6mGJjfOBA8miwfGYGSo95AzJSdK+zgYdcW+yKT9DoqPCwa73mbUE678QlfmHGDMtOGYcQIgdU1Yl2sOxyrUSXxECGA1Elll6vF0f42Jpw6rco77AbKR+TeYAZmq3oJ451J/4NmSCjJXeQHn92CeQ4CuExqKcisaeP595s8HU2Ah4sB/BopDcX1Ah21RdqSWeKo1o3M50uqnZQzjBWhl0L6XhfzJ5FuTnEw8M5Q/5AYvDP7sUvBNLTGRaSuneT8PzLQxXb8xV0cljPe8wCgigK46dp9lEEn0CIvz/X+pFfChXYmH0GiRbZ3rPXCB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:17:11.7685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f21810-3a7c-4549-28c1-08df2dfc6e7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

When device_register() fails for the root bus, the unregister path in
pci_register_host_bridge() drops a bridge reference with put_device()
and then releases the bus with put_device(&bus->dev). The bus release
callback, release_pcibus_dev(), also drops bus->bridge, so the bridge
loses two references for the one taken when the bus was set up.

This frees the host bridge before pci_register_host_bridge() returns.
The caller then drops its own reference on freed memory, either in
pci_create_root_bus() or in the devres action of
devm_pci_alloc_host_bridge().

KASAN reports the use after free in pci_host_probe() when the bus device
registration fails:

  BUG: KASAN: slab-use-after-free in pci_host_probe+0x17c/0x180
  Read of size 8 at addr ffff00000699d840 by task insmod/61
  Freed by task 61:
   kfree+0x274/0x4ec
   pci_release_host_bridge_dev+0x88/0xa4
   device_release+0x9c/0x1ec
   kobject_put+0x138/0x24c
   put_device+0x10/0x1c
   release_pcibus_dev+0x30/0x60
   device_release+0x9c/0x1ec
   kobject_put+0x138/0x24c
   put_device+0x10/0x1c
   pci_register_host_bridge+0x63c/0x1244
   pci_scan_root_bus_bridge+0x110/0x24c
   pci_host_probe+0x34/0x180
  refcount_t: underflow; use-after-free.

Tested on arm64 under QEMU/KVM with KASAN, using a test module that
occupies the pci_bus sysfs name so that device_register() of the root bus
fails with -EEXIST. With the fix, pci_host_probe() returns the error and
the devres teardown completes without KASAN or refcount warnings.

Fixes: 804443c1f278 ("PCI: Fix reference leak in pci_register_host_bridge()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 drivers/pci/probe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f467..86dbfd4873963e8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1149,7 +1149,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	return 0;
 
 unregister:
-	put_device(&bridge->dev);
 	device_del(&bridge->dev);
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-- 
2.43.0

