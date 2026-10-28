Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793220406;
	b=rRv+nzOn1iqaMm3Zs70avUPWllE0kmwI710c021U2g5HD6GpdYgWHBCvP0l1S36lLqnN
	 +KO1uDLZRXNN/JHr9au8bB2HNMV98uTq0w4jP5XaF0oVPjkuNFsgP+htk0bsKCNtrrZL2
	 EK3JYPemdZHhap4pDlMPNeFuqD1ZInH22OV2yoHZasG6CdS36EiWRwCG4zqoEszOUt3Z2
	 aohiRQh3EVTwpZJRIuCX3QwX2FSiJgym5q1exVQscAIlga2WtXxB23/33u6XqbsYA/1jX
	 VcFenmEtOZfW8uTG9WGhpg4UY9WKvDXqLQKdlxfFA1fMYvzHe90xWHmNQEBccxOnxrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220406;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=Rz38guSqw9A9IjGcPuREorv84P/3M9Qr8+PiPPZMAA4=;
	b=5UjZDZv7BLdarxDiYFHbJ+G0NeHAcNRwc5YqcT3Y/kSB4f0aYZ2j2d2ZdLg+ugAcma0e
	 iQStoZwc+OWS8r5spVG087eAghVVI7T/0kcBa/FVe+RJ5cN3FntGB6K2mE7pk/kGG5GiU
	 KC82HQeHBnl/eQI3pp8lBkzEH7XjCx7c3+8dXC+N9M/iXIUJD4SHxyJMLoxeBnYeCSVav
	 D54f2jAr9wte6WX1Auv4er+5UPkh9NcCMkyEREg5tH/xoZ7HIQ9u9aaOdBXwHOPqNcfP1
	 zmHBeUZzSLGzFoTzlhAErdyqXJaZEil5KvV7LZsn3HhX9K8qrvGrezv0E3Jy7SIZTkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="Gph/jV+T";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.7
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE292606A31F;
	Wed, 28 Oct 2026 20:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE292606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Gph/jV+T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfFxRm1ZDYnf33NJwu8UDxdqeMBXFwnyjC8LYrnKgeSIXF8vZDCWlQspjRooCZxBYYAPVaS/PFoONpd8kiHnYfXRCpw5IlNmi/FzX5QjF6NFx/zZdO7oqdpCDmSEhn7lI54hUZw3wdQRwp/DMqO9gzfR7IrRtScqc+jCMIriwoxoXILH47kssOPgZNL5qgrC4kJLLbTLPG5OXSaXpyQ8d/PwL6P9qpnG8YXvqviPIDCSoKjouEFUPvhqZMnJWkDDAonUoeG9EvGv7K3vuX6+FvFRH72Nye3X9tY2WWZ8B+mtAj7OY4NJhvBWjDD82tLFXGpauA23OZkHn5FoUyzN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz38guSqw9A9IjGcPuREorv84P/3M9Qr8+PiPPZMAA4=;
 b=pxuPeu4YgTa8z9Ad2BKwye/tkwfa2dGVVN3ulRzwz1PUEyQrBrRL6pFGk5i3ugnD5PRgtHjL0fFqtJFrvEwqriRJadsGdh/raoR2wUYDKDBvQgifG9X1GU5znT8Li1H09BifLj5lTiShJ4gvY3NjQGqDTDzRsMpOk9dX/tJ+KcYMl3otfaxwnVOtVn9uZaEGDQD9f/XK/nRb3eYo6bQocOQShjV9FHYTzTGACR8WHsMkne1Le1oz9xZqY99I1+TafDKwiHSpOQmHVRySnZOwnA8KDhCcNJN0RFj37Lb3/5h9IuV2jAVe+l4ic4ApE/yiVbiq04gjZzgXrGQG5+k3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz38guSqw9A9IjGcPuREorv84P/3M9Qr8+PiPPZMAA4=;
 b=Gph/jV+ToCjDdJYpEfZ9xDdVYCksGNOGPyfD8VDHuSGAae3CyTNkgKRQ/V+VhP+L8expTPJ2V4XbxerEl7jwuCqnNtK/PX5z1GEBlutLdN7nFVIpTjFjZNs1Q4KWgSUCm7Mo1Kp8RD3z1IMc07POKoBIy2fctE8XIpF8Tr4emdI=
Received: from PH0PR07CA0034.namprd07.prod.outlook.com (2603:10b6:510:e::9) by
 CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 20:46:40 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::98) by PH0PR07CA0034.outlook.office365.com
 (2603:10b6:510:e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 20:46:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 20:46:37 +0000
Received: from [10.236.178.151] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 15:46:32 -0500
Message-ID: <de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com>
Date: Wed, 28 Oct 2026 15:46:32 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/core: Create einj_types when EINJ becomes
 available
To: Yongxin Yang <yangyongxin@kylinos.cn>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>
CC: Dan Williams <djbw@kernel.org>, Ira Weiny <ira.weiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261028055401.1626640-1-yangyongxin@kylinos.cn>
 <20261028084934.1735010-1-yangyongxin@kylinos.cn>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261028084934.1735010-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: e423914f-45b5-4e70-1d48-08df35348fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|261026121527099003|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261022075727099003|261022105027099003|261021135927099003|10067099003|18002099003|22082099003|3023799007|261028144727099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	o/KyU1WUseddj54MINBtd51GPmuiMbb14kgiapMYAk/tW7cVaoAATeKrJf1VkE1UkiC75a2kmoQbnRdxrhLtbNz/IcPqqgsX58PowEV3b3kagBNFTNBQTBzqvRiLPtIt8GzjzIwaVhf7kZlJBQZ1ZETJyc6HfsaVJt/r16ONguOXpLY1Ctst8WR2q+MTTJ/VeG4xTniaoSUHjRKyFzV4iEkrckNZFtOxlwhMxj27PITnZB3/mY9EzppS4SmjShAsfYJPMWKh2cDUfDgCkLnGlqB6NK3MMq+/yRMGNx5vhTj/nXDR/jNXPN+wbclbsVG5ufKuPNmkOPK5f5qqGNH8Sf/tQg/81p1K6danAIex/dLEQuTSAj6B8dz0YEHL4EnCG1Og2olyV9WL2MmjvnlX8O4LOvVrCeCpF9IBZsS797kXLbeB3wj2eHwpclkHbMfXobYq/nf6SnE0GtxfN0yBs3f9XSaNL3Cb16N0ZVSXhn/v3Ad4VLo8eDb1KjhzDdNolztG2TAP7+Q4oHqtniZtAZUZJHQ8pIEVhruUm3FXfH46Hz+iyqTkhhvR73EWFvVOxC0KRba6h+SP5bv+5jinVPVbZFOb9EPo6Zfir7Na3mM47KOriyaKdURuLLqB2xDTq1OuH2Is3GXChwrV8rmD1ClGpjB9X8O6XcZlS6fUfUpAVf9c6b/pg5HKq5ofKplGPsHBIied2TDGNSQ9CACt3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(261026121527099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021135927099003)(10067099003)(18002099003)(22082099003)(3023799007)(261028144727099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dB89aqm36a8Xks5UDtKj9ozXLH/oizmoyYgxaJrRbrOQ2+lCTIUwkMBiO1dj7aMTMT9vTh7pEzm7+CpfG8WD7BdbTv9GEGQ0oDxrmQiI7yqqpLnK3C1nWXCgtEBSqqZR/uE+81fxfkF2v4tzx0zJb7rAhReq53+M0usyd/hYFn64TW6Mdji8KlMpZkteFFrg7Onqr2h/Xa6qEE2+9eGYoZ6i1/6vfvhPs9KSt/7G54v9u4jl6s8BiCAn21lQUh6FeXGbrYB1SmKEFeTVCDueBY2AjOPjN2ChdndROQ0FTCZFIWW0LBWKbtEhsfFyV300TYlk3nodkayY8Xurx0YHZQVOiL14odqfmZ3H2vORHlg1wi3Jv/ugo7rVFC9U+Fg7XqCFKiO2NJAIin21OZDU8e1ZxQtVurdTJ3q6AwsL/4syrf2ms0fPHbMpg465hW8H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 20:46:37.6238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e423914f-45b5-4e70-1d48-08df35348fcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

On 10/28/2026 3:49 AM, Yongxin Yang wrote:
> From: Yang Yongxin <yangyongxin@kylinos.cn>
> 
> The einj_types file under the CXL debugfs directory is never created.
> 
> cxl_core_init() runs at subsys_initcall level, while EINJ registers itself
> from einj_init() at module_init level. When cxl_core_init() evaluates
> einj_cxl_is_initialized() the built-in EINJ driver has not been initialized
> yet, so the value is always false and the debugfs_create_file("einj_types")
> call below it is never reached. Users have no way to discover which CXL
> error types the platform supports from debugfs.
> 
> Create the file from both places that can know EINJ is up: cxl_core_init(),
> which covers the case where cxl_core is a module and einj has already been
> initialized by the time the module is loaded, and the dport probe path,
> which covers the built-in case. The dport probe path can run concurrently
> for different parent ports, each holding only its own device lock, so
> serialize the check and the create to avoid a duplicate
> debugfs_create_file() attempt that would only fail with -EEXIST.
> 
> Note that this is still a partial fix: an RCH platform returns early from
> devm_cxl_enumerate_ports() before any dport is added, so einj_types does
> not appear there. Fixing that requires moving cxl_core_init() after EINJ
> is probed, or creating the file from cxl_acpi_probe(), both of which are
> out of scope here.

I'm not a fan of having to write a value to einj_inject to see what values are
possible to write to einj_inject. Maybe if it was changed to reading einj_inject
creating einj_types it would be better, but I think I'd rather see the file created
in cxl_acpi_probe() as a fix.

I was able to make a quick mock up using your fix here and it wasn't that bad:

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 0c21dc03a6..4017500ef4 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -974,6 +974,8 @@
 	if (rc < 0)
 		return rc;
 
+	cxl_debugfs_einj_add_types();
+
 	/* In case PCI is scanned before ACPI re-trigger memdev attach */
 	cxl_bus_rescan();
 	return 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f3705ea44d..0b75792a9a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -811,6 +811,20 @@
 
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
+static struct dentry *cxl_debugfs;
+static struct dentry *einj_types_dentry;
+
+static DEFINE_MUTEX(einj_types_lock);
+void cxl_debugfs_einj_add_types(void)
+{
+	guard(mutex)(&einj_types_lock);
+	if (!einj_types_dentry && einj_cxl_is_initialized())
+		einj_types_dentry = debugfs_create_file("einj_types", 0400,
+							cxl_debugfs, NULL,
+							&einj_cxl_available_error_type_fops);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_debugfs_einj_add_types, "cxl_acpi");
+
 static int cxl_einj_inject(void *data, u64 type)
 {
 	struct cxl_dport *dport = data;
@@ -2589,8 +2603,6 @@
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
 
-static struct dentry *cxl_debugfs;
-
 struct dentry *cxl_debugfs_create_dir(const char *dir)
 {
 	return debugfs_create_dir(dir, cxl_debugfs);
@@ -2603,10 +2615,6 @@
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
-	if (einj_cxl_is_initialized())
-		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
-				    &einj_cxl_available_error_type_fops);
+	cxl_debugfs_einj_add_types();

 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index baa6df2d36..40be8ea938 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -956,4 +956,5 @@
 
 u16 cxl_gpf_get_dvsec(struct device *dev);
 
+void cxl_debugfs_einj_add_types(void);
 #endif /* __CXL_H__ */

---

I only did some quick compile testing with a few common configs and didn't see any errors,
so take it with a grain of salt. The only issue I see with it at the moment is the debugfs
init is now partially decoupled from the cxl_core module, but I think that's just a
maintainability issue instead of a technical one.

You may also be able to get away with removing the locking in cxl_debugfs_einj_add_types()
since cxl_acpi doesn't force async probe, but I left it there just in case.

Thanks,
Ben
