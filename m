Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780615;
	b=u7lw4irW5F4SfcTnJ4eQSankEIefqYfyRMZG6t2Yrd5uT16an5Yj9SznsibBu5DrDzl/
	 yJoB0dZ3eDOirHmPTOlWP2Z3HACs/wVZdtZLVE1uqYkE9VFE8gG9w8PFTnbrU31CRh4Am
	 IPkW9IBJzIUlqiiidg9X40XT8hbc/RegP2TsMv55LD4huxglM12uW+tRuVN0LgHPE9cRa
	 SYU6cVjq9K/vBRaBgilJh6t8MFEFxnv3KcxZ6ELZjtsNnZ3u6ezMr1Eyxi6mruUzvGXqA
	 4iAYvkT9LckuCttQ3DfDsr/AGuUd+b6WYxW7oIH7pBrPlYQVje9XgOgVMnhPGvTrIsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780615;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=o0KhQfWyELb3t2ES6b9/zz1yOCJJJPLtbTTc2yq1nEk=;
	b=fWBUpm9h0EyFS/v+K/Wr0KpOXmfhiPJJuwbboUHHtAkqGx32vpmx8yBelW6ToiZbPf2k
	 XV/s6yZLYG9VNhgsQQY8PaerYiiSfm51ka5LztlrhvdqNJeSBgKduvofcGcZm62kp6HC7
	 dImEzRGU4Dv2HmRuA9EKulkPYz58feaItHpH8RNA1eYzJnpkiSXfaFIGuVXWZNUwwIAuF
	 TQYsyIbeNxGjJg5fT16sHUekhGSSr2SiiMDqeLxe6GtTbo9mXALoLW0SzMx+rYQAvZwMb
	 hvlQf7CV7vzMXMI9etdUv1tqRFXZ7OF33EqJJKbRKumkFAI/Kl+8U/Fr0pHesPlGIsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FcqE3s+O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F6606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 642F6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FcqE3s+O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWeDXYHqbe7bjQ2K9wvRLHbDJ6GPS1W+Sf2iAN+m28g4Dk71IBjyCj3xZelZaw4lWjFa0VRwT8yVZQp6Rqd1Uqj6ZgGWzKERnXcK/6fGdFx3nbjL2P8u8GEjwkLj2NI22VCojoeJ0JUSXnrM74y9kyq/y7Ev9DLUZ17mX10GgfJSiTFYmz+dkzxHqjU2TkJ03/0H+twbiNsO0+7Qu5vyZ6qcqESTahHJMBJFKsInBq/lBlYoISIx/huge0V5I1XWqfnsXqW3jMhiAQTeUX7IkxcJrs+YF9EP+BxFCza3pFpHsf/hDSZFLlJSXsaMGNDLHEfRX5ashqiytYV+iI4xeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0KhQfWyELb3t2ES6b9/zz1yOCJJJPLtbTTc2yq1nEk=;
 b=wMUgMIf0/J9yCrXt43YxhovqIEsgbyw9FM9p6PNj5Sa837ZNrlBke5OjRuy5kePLgyg8XGrB7DiZ/vIpCmEBTwxm/YubNXMVnaaULwwZ3IGF6RGxJGdlZ12OOgMQYLC9wmNxWcaE2U6HRhsRWvny4upep3UDvGh5srzSBRQWf/22zQQelcljDHY+uXOhGDALjneoeAs1JrkgFNWkzjTbLHDCvg8FSGGAJaHxqoqxcMMtdmfniaNDZUnw3uudT6M0xuvrS+WEZBHwIg+XeyIprJbYc2NA9V70PxouHOFKdOHadliA2ef6mg10ZDXIMOUvjjsDexE9EgMJJS9WPvvVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0KhQfWyELb3t2ES6b9/zz1yOCJJJPLtbTTc2yq1nEk=;
 b=FcqE3s+O4WtgZTIN7rvhIe7ZRaALGxtA+nBOdZKQdOTVJ6uI4WAnhBLnjajc/pT4fNyYjZy7K92WltACjAEvA7sq6s2fF/OR/y5F3saphBTwC6cUKxv8295AK7+eaVTFuAzXRWnShcbT2AEuDF/tQB2ZOniJl/EGkkinxmZdMuE=
Received: from SJ0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:a03:39c::34)
 by LY0PR12MB967422.namprd12.prod.outlook.com (2603:10b6:408:3bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:56:51 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ad) by SJ0PR03CA0359.outlook.office365.com
 (2603:10b6:a03:39c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:56:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:56:50 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:56:46 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Santosh Shukla
	<santosh.shukla@amd.com>, <stable@vger.kernel.org>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 04/12] iommu/amd: Restore an SVA PASID after PCI reset
Date: Fri, 27 Nov 2026 11:54:39 +0000
Message-ID: <20261127115447.209792-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127115447.209792-1-vasant.hegde@amd.com>
References: <20261127115447.209792-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|LY0PR12MB967422:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cdeded-7677-4637-1cb6-08df4c7d8592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|261009223027099003|22082099003|18002099003|10067099003|56012099006|261102123227099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	3yermd4BE6sdxj5z4uOohqCWa1MRS+tKXY1JqiExSroz2sQn6jrArqA9auBFLu77VmY499LXIX8+bC4Fow66SHCj8w1IFzBRbcGKl0ke9yBnfDSNW5LsNZf//yMH9CN9rENm8lmy23mjUUGEG28kd/X4DlzMQgmdtvja+umXz0+eM5UEPd1juVgJHn9N2FbSRSWWjdaUgaVAr0G0Tn+uoSEL4BvBqnYOIFBlRHSxgng+yCHMVKif0ZCH8tc0s0d2/TULN61MO6JN7Bz/yLIwtKFiOo+ve0tttPxWIUSd7oVxKd2bCeMmm8ahw9S5WhgtZSoRKh+FqEolGxkqhC6/IigzqOqy+/heZFtArytL0nZ0xSNH5nDclDtO/peLJP2oAF9t/51PA4X5BvfJXkQnfXJiFqi9mgp/gecoFE9+Bs7tSelIgi8SR8B/0xqmFyq16H8/moPXqkTdH8yGMKt+KymGLpV8KPttGoUuO1lE9+arDTtrHaaEaKwJz6NYx+owplVKh0QVS394qvg5Eb0duwLiJ2XkAeK7hVq6ctOZ8nOIQj3jZYq6Bpff9f3ZNAzvz1pJH9p4v+nlEf6fD8HpK75EyFpVnNwSogXR0rfYygVxvEg3dborl5/i4zBKwp2X6zxQBSA4Kb8pQkf1mfU90VZPnjtaFjrzierXJ7Fj0I1ikDUYG3x76NXI02YOjZl0qyyKrUR3Gt3J4oZ5nCCuIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SLR1QpWCC/6Wwv3So0ND7EnEIWIOto8/ZxacRdSu0L+fnMDf87xNbHGFmx0IeuRxGLdqyjPdavgDYiZQ58Z5IpcrHs2zJelGmYHNkV+4si9xlRs5ODNI7kRII5jSk+BxR8FdEyyDF4Ys9u7hohaqkqXjKKsv0bG03mD1j15GSiz4kTQdZwbqfbUnggYkfHr00r7FM1guh/ZjiC/aosW3lFuw4Oddwb0aR/z1lWQqs1vJQMQZokjsNNbU4Gm8/Nf0ybSKuWH4VSsb7gT01g8xXAO5LfRKmKHsOocc4+8h9hrK+rA+mLIVsfIH0SbYPhbCqHSrMfpAVqWy2D66FyyPfOIGQpu+T2r5OfoTE2h1HtursbfUF8OC3qH+1c+tc591wzCi2Tyrp02Z7kuLhJFKvHJSuZlYapQXajeJnf2Ecm3p6qP1bNSGV8woPNZoKMC4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:56:50.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cdeded-7677-4637-1cb6-08df4c7d8592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB967422

From: Santosh Shukla <santosh.shukla@amd.com>

pci_dev_reset_iommu_done() re-attaches every PASID with old set to the
group's blocking domain. iommu_sva_set_dev_pasid() rejects any old
domain, so the core warns and the PASID stays unprogrammed until the
device is unbound.

prepare() has already cleared the GCR3 entry and dropped the SVA
tracking record. A blocking old domain is therefore a fresh attach.
Replacing one attached domain with another still returns -EOPNOTSUPP.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Cc: stable@vger.kernel.org
[Updated description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/pasid.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 40be5902087c..87fd2688574c 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -109,7 +109,12 @@ static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (old)
+	/*
+	 * pci_dev_reset_iommu_done() passes the blocking domain. prepare()
+	 * has already cleared this PASID, so program it again. Replacing
+	 * one attached domain with another is not supported.
+	 */
+	if (old && old->type != IOMMU_DOMAIN_BLOCKED)
 		return -EOPNOTSUPP;
 
 	/* PASID zero is used for requests from the I/O device without PASID */
-- 
2.31.1

