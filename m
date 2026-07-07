Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C82F8EA5;
	Tue,  7 Jul 2026 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418177; cv=fail; b=CaT65JVevQ699TM8FKnH01fs0LGntuu9b6X3yBm0DVH/IYeQxkK1cd49j0xelVFwZo9CoqQb84K7ao6q8ITPfKJD/FywBsJyEEgKH9n+I5Nnvmc+0JjAGJJ1+umr52gx2tLg4wVpEOjpWgLxNcTu+BUYD5EuUIZ1yl2belwBN8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418177; c=relaxed/simple;
	bh=8s2j3syt0pSYOWn47TXxwrOqU3y9gtCHMkuFaR2N8CM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5pYd7AIBNW4i169jHuip/QpAEJ1KfR7ckVEipOikklpW8Fd8WCcxsmcaAKqluqMAWa/8o1ylUO9kSXtIjhxpqU/+53PlJySk0hNA7npQpZTLSNTS2xv4ZXkjwdHIWpSVAw8/vw3gG5yVp2ZwShYi1DtWdVlzsg4CRmujIjTjHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GO9kIm3A; arc=fail smtp.client-ip=40.107.200.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GO9kIm3A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aavT+D1vNglpcSNTuZ6RxmKvNCAQlScPnUAcX+pX4YZTopBznx6RADujbWxB9guf7riA5r8RoG7poGMRNNIfvPd2Vet7MQTbAmxmwrv1NDRW8Lpx1Eb/I/Pe/BIQTBHIAQlY+3bkGbzXymOXGaoNT40VClg0cU+QrrSTIPqH2WE7RxihwXpWRP7s+oC8YkY485rAYnNTc+J5uZtQx8RmhETXuwHQLnMH10+7n0i4B1to9Upl5xBbgQcYrwzRf8CU7IJPfRATzhK7OHFHk7nAFZddgStwFJKQeieJVILPTZYsUFpVlQwnJe/1WzSo+tJQXgmr3/oz9/F1XcXqP3s6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slH5LLKaMKXyIbs0Lj92CORAfRl+Mbj1m59qD3l8h50=;
 b=m+5Vrtt0j2mX55AhnQVxRf3XryWtfkhxRV9/OvNdI/dR1gpEtN/hznCCgYIXExi+7H+pEpARKfsliUWOWFvkQWRDN6bENcg7MRNSZ0EFGMfdM5XGM6fG3kg2pKs6Ayg85XqovhrapaYQtITiJgNA7i8f48Ljg/9iip/FwU+WN495K6JESGSnl6SlWh1OzXnze8wRIk1e+GOBJsvxs/OdzisqVsZEy1Nl688yYycksGJL7bADFtmVJrUdu4dN8qt49VbLEvoKQJEXPZfsNEaJqi9qxwVU7fJVVWYRM1XOmCtbSEb51iLIN0AHPJJcicx0lMBpjXKtjG9O374AOxSSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slH5LLKaMKXyIbs0Lj92CORAfRl+Mbj1m59qD3l8h50=;
 b=GO9kIm3A84QBp7/0OnXnbB2M/JMiRcSGsLpTl4XoVKTutiFlXCOoRvXGLxUpPJ9ZVC1X/UUzMK2Yt6yxLDoo2g2dxMmPHHY8yTZgqY5UjkKsc/fm5VkUDwFQ4+ga+zB0MitThY0VV5Pu+7Tvz7jmW+dEkdjDLuFPmff7X8WguT8=
Received: from BL1PR13CA0372.namprd13.prod.outlook.com (2603:10b6:208:2c0::17)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 09:56:12 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::a0) by BL1PR13CA0372.outlook.office365.com
 (2603:10b6:208:2c0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 09:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 09:56:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 04:56:07 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 04:56:04 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <git@amd.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/1] RDMA/ionic: Preserve and set Ethernet source MAC after ib_ud_header_init()
Date: Tue, 7 Jul 2026 15:25:40 +0530
Message-ID: <20260707095555.3939295-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707095555.3939295-1-abhijit.gangurde@amd.com>
References: <20260707095555.3939295-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a27be4-cf95-4a09-77a0-08dedc0dfa2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	cXyBSM9ppuDspBjo1/scOQkgxYrDhDJ4Gl5B0yizlXwFPJ4EEgv3Go9SZ8buDOQu6Idiq33W30MmQXCbuBHSfrAYdO2nsYpufZin2MqyzG4Ozn35pFxzkXkV8Sj+Dqm3lLNiMm9d9XEdX7x5CJF0eBbKHLuHfwVXRpEVGrYl95oJZJTUB9lWs7voD2MKS8V8Gjjyl0/ykiRyu3x/+JZGts6xaLV69NUf3aJKeW21U8Uiq0VAONWGb5sr8uF0ueFDrSdhilyLgIdgVwRKNQATr+aIbm1eT6ClzJHSGYORZSFYgW3G43KwflNk/4byR2HWrAu44G4/9N5TUJXCM3bDwa+K6Tu6qOE+Tg6cSmeZrF/JfYTtHeQGU/Vfc/vdn1/i0C40FA8t3ZY1DyE3y3i+7MH+PQ0WzWySqWgBMEgwCEiGIxbtuofYav2CdHEL1LL/57SE1Ws4EhOlHovKnZMRTh5WFIJsQSBPLdThHTcJ58xQAQ9mFsd0WBXScLYqh2/aJ/UYiXUX62SwXZIhWsIQEixSVtzZXiYBuqHQkmAZ8optoTNRLn9yE/fvyT1eK5ljukKJNB6Pio5EZ0iiyCObULqLrlRPy1kekP/4ZNZ4n/DsJlnT3WYB11Dt6nxCKH3d4+53mQDudzzbICkbkO5t/NgGDAWhxCUa6NsKQU+N6WAjtGU4mjkrHmtt3GzS/f9FZ3kn+IlqbXK/y/LL6iYBVg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ly3uRGweDMEDKK4T4jQASwuNiEUFYxvsMWdL5TfPGw0t2FtoyCEuKuOXMU8WA/h6nBRZKFv5eu4cVRKZF4R/XuIeVuXiMS6Q1/4z6GWn7c1a49OIABubvtyxxF29AR/V7FO5YYvaPn7px76XDdhkQIYHC+V2OJsyZPbXScVQXcq2FrSjZVLrvDF4WU+tvF5hezab2iq9A6xSeMfwWe4Ab2Y+2HXzoYcylRIZ0JDJZejeRDnqzNoRR/h5QojLUuL7MilSDW4FbX8/oEt4pMPeYPsGXIvNNBwGJRYp4+YGJ3zRAVcVqkMNDsSVyHxpIDpAvDptS+L2qSVEo8cA+HiwZAtIGnRc/b4xpIUl3+zWO3FtERqxbajR0MU14CFFmkOQYA3sIohCgXeX6amipol/i1o1xzFO/WAuuNajs4dpu1AEeJjT/TkFdSbEf2iNjSL7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 09:56:12.2872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a27be4-cf95-4a09-77a0-08dedc0dfa2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822

ionic_build_hdr() populated the Ethernet source MAC (hdr->eth.smac_h) by
passing the header’s storage directly to rdma_read_gid_l2_fields().
However, ib_ud_header_init() is called after that and re-initializes the
UD header, which wipes the previously written smac_h. As a result, packets
are emitted with an zero source MAC address on the wire.

Correct the source MAC by reading the GID-derived smac into a temporary
buffer and copy it after ib_ud_header_init() completes.

Fixes: e8521822c733 ("RDMA/ionic: Register device ops for control path")
Cc: stable@vger.kernel.org # 6.18
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index ea12d9b8e125..84bc5f17a700 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -508,6 +508,7 @@ static int ionic_build_hdr(struct ionic_ibdev *dev,
 {
 	const struct ib_global_route *grh;
 	enum rdma_network_type net;
+	u8 smac[ETH_ALEN];
 	u16 vlan;
 	int rc;
 
@@ -518,7 +519,7 @@ static int ionic_build_hdr(struct ionic_ibdev *dev,
 
 	grh = rdma_ah_read_grh(attr);
 
-	rc = rdma_read_gid_l2_fields(grh->sgid_attr, &vlan, &hdr->eth.smac_h[0]);
+	rc = rdma_read_gid_l2_fields(grh->sgid_attr, &vlan, smac);
 	if (rc)
 		return rc;
 
@@ -536,6 +537,7 @@ static int ionic_build_hdr(struct ionic_ibdev *dev,
 	if (rc)
 		return rc;
 
+	ether_addr_copy(hdr->eth.smac_h, smac);
 	ether_addr_copy(hdr->eth.dmac_h, attr->roce.dmac);
 
 	if (net == RDMA_NETWORK_IPV4) {
-- 
2.43.0

