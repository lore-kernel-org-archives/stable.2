Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED928DC4;
	Wed, 15 Jul 2026 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097399; cv=fail; b=iubjtONUYWQWqBKTM8FjR0rLvCpwhpJC4VM0pfvUNuPMtCU4W3bbRtB+WTta1fexJat1sxpuN9ZJAOMMRqPDzDWoNQWne6f9/3ZSWJd7679KzRVvA7JVoTDnGcmIV6b04aJt7AdYXacc4bWixJBPm+bK6l2zXsUeL449BikfmPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097399; c=relaxed/simple;
	bh=KS/UiUAY+XhioJZzMWQwdu31Ac4ZTQ+gdp7CEGs8Zmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fdn2OxznKPu/Y46fxsuMC0YLp8tNHh75yPZi3uV/4w9o+IfQRxv4V7cba6Ei3QVaOLVUqVfMkodFZNeVrEQiOn+0v2Q9DhkkihPr1nnQ+crrVBr/s09FaY6/3LYMKDfGL71E/pg9VBgvRY+mObSQg/W+LQ5+UFfg47e7xcYMjZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p0dMcXGq; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p0dMcXGq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLIgtqawqGOyDn9DB5+pIHKDCjbtEaeSDNeYPKPi7NjxEFaVjcQClqPly76RwyGSsEgs1Ayh9CO7hp5To3RuGpK35Clg0YEjI9HV1a94KmqOkRl7Ph4w2qhltq0hZscwyL98fwY9ge1EH5pz43U8IjxoQFYeRpTxibIXM5vK9XzdnGc4jcve1Ej3IAJJAu1IH6FYVIXpZhYJjVexDpxYP3QiB98OLEGB863+B2wP5eQeAnbO+qgJks4HJ1MF+6OTTZD/MIHbUwvo1mQbpJAAXQRThtqGPvmbbKLZVFDfkpCmpW9aKkhADx6MWdj/QlleRMZ/lextBhbyJ0T5wUJuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy/VFIOKwpcv+qhfxh1gI5GnYFkK3GNS/H1CFgO0ycw=;
 b=iuuT1C+ShMZtQn4pY4zq8KqbS3VtCX+3h/ArycJIhrrFXjq3kqwYEKvt52zf8mep1H2RADWTm5FCC4kEsCfRiRVqnMfpHjY2W6fX1WH0eoUugq5hGjIolg/VDdTDHhR3P5Pb/haz411iqRUEK44t9wutljocesSmMPK0o2AAMG4U46XUy3X+NWJn8dUdRq54YRrRzFaDoUkIFE2BDRpKPn6fUspEcDNE7irEmIz7H8mncl48cJeDp2q2AN2hLg6UFon71UdU/81fkGDH0cNVAV6+xo9fQIH1dah3mOMI8HxrsTS/Q78UUEMfDGk2k38l47uFEL0WEJMEimlQXAUqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy/VFIOKwpcv+qhfxh1gI5GnYFkK3GNS/H1CFgO0ycw=;
 b=p0dMcXGqZyvvvM56tpymGNL9o083Uht891wDQ3/eJ/bImL2kK0Fpime9by77/fX7sjedrt72vEiHXoUOQ/W+lNdIYGS2ZOia1LP9qhF7wXmS4UULwQc6cD+MgIYB2wRjpYzmhRxIhrRgCGLrR/DHLMz/J4YktzDBR6A9NQS9Cgs=
Received: from MW4PR03CA0006.namprd03.prod.outlook.com (2603:10b6:303:8f::11)
 by DS3PR12MB999218.namprd12.prod.outlook.com (2603:10b6:8:38e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 06:36:33 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::9f) by MW4PR03CA0006.outlook.office365.com
 (2603:10b6:303:8f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 06:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 06:36:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 01:36:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 01:36:32 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 01:36:31 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@kernel.org>,
	<bp@alien8.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <thomas.lendacky@amd.com>, <hpa@zytor.com>,
	<david@kernel.org>, <yangge1116@126.com>, <ljs@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.gupta@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] KVM: SEV: drop FOLL_WRITE for encrypted region registration
Date: Wed, 15 Jul 2026 01:36:26 -0500
Message-ID: <20260715063626.65899-1-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|DS3PR12MB999218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4120c0-f493-4596-f360-08dee23b6948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|13003099007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	S/WANHgDNjS7xD6d0WyowOpiWDOYsKhz1sBxJkkHYQWNQSxJz2NGxC+giybkC1Y/ndYOuPWahVb+WJhU+ExNUtPQgqqgwcJMbSQKoyUVy0RgQplpwZFLn6CrLW8tspOUSkC5gH+HnpD/pQfGVZMS+Rx8GmRY35VSGaEdtNYBs8swpQFdpill1rMbGi3Nti3S/78JqcBfsvUZHH6LhkuxJGG/K/TiJ1Zj1XNXGnWSGCz+mQDzBDZXh2ON5NFdKF7R5HWp1HKXqqlJ3e69LgwPM7gwMy4rPpKmiue9M38syjnQYBl1cxRD+c1gJb7UrugWY/37LgFhPvJ+VA2z6Nfcz15jsJZ8aTSRqdMm2EOCXpEuU1xKHkKAAXkQgnMF9H/DdpDBh7hfQ07f++rf6K1/aCvhA7BQSrP40Tgsp5TsPPj2jjen6WZuVdozzwSKv6fX1QCfk55yU945O36I0acR7Gwj+vuY9utIswqg1zdcqes2lqLqhhKUvsQDkyfj11Um+VA/szfSRp250JlMXKKe0JqfHqDNBZu0rf0AuHSmuhpOI7rH6pWd1fswG3f5Sl/0HB/6P9bHDt/P/Pokb+AUdgJsUoBoDrnbE+z7PZs1gzhmfl0Dleo8XAFhNlcAL8LHiinQvq7VSqnkazK5mDfyXHS1WAPCbFLmZGc9ISkl4K/uDlkNt7XRzZ9GTmbA3T+L/e5FDGHQrgaKSOwTkI7hXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+a93zymZty1RB38pi/WJzy1Hn3CaYCL+UudLI6867Zv4A1z1NR5jFVKmxhe+Quo0yz6wMeWgEwoC3elDK8Y2G6njl+lfuU7Z7f43Bij8K0/yxzeqB0FmcLLWNXILdaj4Vka5Rrm8ZsU2xhyTm2vhXs9Zi1f+dLQLkdurVIaMhDfXq5fKUxA0s9clLW1bubLpBUne46h2PUxO1uoWQeE3qdnNRCiPCQaW7zfKrL/2O2wKyrMJ7ZjFQ3y6Izdzc0kwT4hKEo2m6fpeAIpgZeeYmIyUxOYSowwUbi3VoTezYHNste5w1HaDHcpnEtT+eIdo0ISte6XRfHuuUxrBITnZjitLEG2lA9UyEylvCirvWzKVpInW3fF7evNB3vNqV6AYS8cTkxchLZoMaLTHSQ27xWWxgdNHW7CHZ2OlYzxUjtjEXLz4wsrcqLqwCXxiDZ3S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:36:32.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4120c0-f493-4596-f360-08dee23b6948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999218

Commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering
encrypted memory regions") added FOLL_LONGTERM to
sev_mem_enc_register_region() so anonymous guest RAM is migrated out of
MIGRATE_CMA/ZONE_MOVABLE before a long term pin. It also kept
FOLL_WRITE on the pin.

Combining FOLL_WRITE with FOLL_LONGTERM breaks registration of file-backed
guest memory, such as virtio-pmem host memory-backend-file mappings
(MAP_SHARED). GUP rejects long-term writable pins on dirty tracked file
mappings since:

commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").

Region registration only requires long-term pin to prevent page migration and
does not write through this GUP pin.

Drop FOLL_WRITE and pin guest memory only with FOLL_LONGTERM.

Fixes: 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
Cc: stable@vger.kernel.org
Suggested-by: "David Hildenbrand (Arm)" <david@kernel.org>
Link: https://lore.kernel.org/all/ad784f05-b36c-4e91-9f17-4c5b826735d0@kernel.org/
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
v1 -> v2
- Remove FOLL_WRITE when the pin is not used for host writes

v1: https://lore.kernel.org/all/20260701144543.39582-1-pankaj.gupta@amd.com/

 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 427229347876..5f2998761462 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2752,7 +2752,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 		return -ENOMEM;
 
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
-				       FOLL_WRITE | FOLL_LONGTERM);
+				       FOLL_LONGTERM);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
 		goto e_free;
-- 
2.34.1

