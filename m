Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.69.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795467195;
	b=cN/6+l5VYI+0QFgdinDrFnF73gHa9AjEcUzBdrkmVqXTWtP1RYG3KMtFMYrobJtno4U1
	 7cEHux2zcaWZW3b5bXX44JtjxQjiP8w7mKAKD9wnF44sMKShFGFadvgjkGd/yTcGBAnu2
	 +YUwb2bhCK7fpAjQQMoKiCzHqSSB0xU101D8tjk1Bi4sQPiTEg7CSpkZXOkB1JDzEoypn
	 DXwQO2XaED78+9jM7iHueVtDpFE4zgr7+73kFRyD0TM7FfGZeuhPLR1ED+dvmSCTypCvc
	 VRhrSGI9hY6uY3p5qGpf4Mlxb7AdF8/+ox9yy+Hkxfcudv/hAsvxdwnl5JbYx0Jg+hQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467195;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fxl9L+3HNA632eMlFsKvn8+iU+IZYlYl8FjyvLzrO+s=;
	b=lMWgW/PgRTlw89qW+wsAMmPL2SJDGHx4N7I9PtZNYI64jKf0r0r65Pl85FICHvYnlR8I
	 vKRalTSoHV5Es0N7vBfbPOVSheOiQhSoDrd7ZcmWpH8JcOPYGfcSc0X4C/Fbj9s0rius8
	 70nnXarEbmd6rZsKxk/pR5p1benbmeA10aifbcPUTgNPcGfIxOGVzQor4RWJl/wjdZkWn
	 mqLr58mlg/bpQJDOp+J1J3awbpV9En+jefTQgUOHNa2tbVF4p5aKfSWfGzYVGeGikDLav
	 jY8SoUx9EG2MqzZOF3lKKESg2EzE0ybHJYiJg4v69Fvq64PXIW3d31KyzHRYY7vUfhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=OuQWrKHH;
	arc=fail smtp.remote-ip=52.101.69.74
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020074.outbound.protection.outlook.com [52.101.69.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F953606A31E;
	Mon, 23 Nov 2026 20:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F953606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=OuQWrKHH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/NFcm+D1kOHJuAujdQQZfsGx7V8U2A6vY5pD2ntGE1ugpl52QvAYgAbm7sZcftvnxoG3fUPdNgX0KByAE8e0KXDelGyjfhOkGa7lPFe0059a6EAMsQPuvonpsszA/g5628L9fXVjkVLEzgOqZb901XfeW6G8JPIqqphq1/dUYRWK2ZEOgRhYzzcyBRrK8x+S0owluSqiUS780IpQ254POpsD1GfF2rMA1Tu8YEBBn3kl9yzG5AONQ0X1cv5F6yGLA1Op/b0QKPn576xkXBy34mHhvrMAJ9EPXjFThTm18rSUAr2nQ8xRfd4AmyI0W//yB3G0c99WoZLf2MxvBUxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxl9L+3HNA632eMlFsKvn8+iU+IZYlYl8FjyvLzrO+s=;
 b=rfGd89QR2fRtRc0s9kGtBOMng+OWJYDB24/Q7/BtKZF8dEGKhsHb1oNhdR4Bf0Q612dfkgzAQxU3yJwubDat1tK93l02wzwndhKpt9vvtHQs/2Nm3ZWMgNQkZD/bgvUgqNVB0k3zjYDz+5xG8vu0KmGbHOGNwqCeN1jLRoPQxV0Kw6PMyol1afQZnfmIehQFHL4GTGvZBKnsORWPI1xhZ4R9cPNpUSYY+9esm6TbMtgOK1LuXLG5U7IRI8KfTApPi3iIH4U6CJLoA9FHrx+AwPA3noGMP4ix9Zwm6SvYBGPQL89VK+EQGOrQq/FFomwF3iT51HUJfP1leyP+E4T9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxl9L+3HNA632eMlFsKvn8+iU+IZYlYl8FjyvLzrO+s=;
 b=OuQWrKHHJ970RvVgNttx/uHtiIma7ohbds8Ah3zjP7XLuENhPwHhqrdj2ICXnIh8+cOy4RJ5Kt++ExL7gkwfVolpf3/oVKRKwhcExk1TlOm2I0XbYWKSLhUSaUfjcArHLo72+wOXr7J31Rp0eymjUZPuw9558OeQgkNOPYlTX0Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from AMDPR08MB999846.eurprd08.prod.outlook.com
 (2603:10a6:20b:70a::22) by VI3PR08MB670600.eurprd08.prod.outlook.com
 (2603:10a6:800:372::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 20:53:10 +0000
Received: from AMDPR08MB999846.eurprd08.prod.outlook.com
 ([fe80::a2f1:726a:58fb:8320]) by AMDPR08MB999846.eurprd08.prod.outlook.com
 ([fe80::a2f1:726a:58fb:8320%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 20:53:10 +0000
From: Shukai Ni <shukai.ni@kuleuven.be>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shukai Ni <shukai.ni@kuleuven.be>,
	Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH] swiotlb: clear read bounce buffers on confidential guests
Date: Mon, 23 Nov 2026 21:53:02 +0100
Message-ID: <20261123205302.1034348-1-shukai.ni@kuleuven.be>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0073.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::27) To AMDPR08MB999846.eurprd08.prod.outlook.com
 (2603:10a6:20b:70a::22)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMDPR08MB999846:EE_|VI3PR08MB670600:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a9b0c9-a60e-4a4c-1890-08df49a3c88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|786006|10070799003|23010399003|366016|6133799003|261009223027099003|18002099003|56012099006|11063799006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	D3Zo7Z4q2HG80RppVoMotlHlo0sEnvnQnkDgZabfMebxFaJOpD3J5wnBGkXUkWnzwA2ImgRLOa1/jWZc/RsN7t0+9vCmhG/Nz39tAvVaWEnuUu6WGoGxXGdpNdkAp0Ttnhno3nDo12NIGxG1nZzW/Kp67Ukftqim+LHUupCX73emTlSSAngEvuzHhnYNAFiQm3oQVKisg9Wetf0fJ5RyeY3HIdov0T8KTvPccwTZ5ZWsYykrNC8nqZQexdhgxslP792hYff8Xxttanb0DZj6iXrBP8U8ISfFXrI2GvcZKAAkpGoz1Lcm4XZoOkjKqdFMjbRAINv/NlPoGoh8WaDIbEfVM5zUWOp2X6979SXYNGbSjYPlMp9yrTOhChmuHcD/nCV8OLnOVNA7KSrJIFNHpE8vFq34rpIyjD0SHEA9w8fmXkCBx5NOJ8KqRGdUrtoB6O3Vet9pe8yYPnSARJjzA+YZAY5VJG2aFQw6Flqh2Kqm3VCkBLeHtpQFbnNfcT1IkUfx6R4KSI/9hd05vf3SNjyVgNewjenProtamIh7ogxZYP83H5R0LIu1eOVm0ME6flJQ+31LQA/+QYFhEUek0cnjqXvGcZXZbY2a+fdyNJHY4EpatewivtB+I9eDITGK0JbUd/DbgSuz/u5laP6w73xZ85GrkcUF625tBJYc3Lg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMDPR08MB999846.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(786006)(10070799003)(23010399003)(366016)(6133799003)(261009223027099003)(18002099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?95AwPYrWCC+fxoJ81PTXIu86pc3NQz/AD1AtQhLRpLz5TbgnWnKEcEV7R1Y5?=
 =?us-ascii?Q?jMXEj+AEfOHVinSDs2ixYBRuUM/I+B5uAv6pt3u5xuGiODmWFzWbs8u7n9h3?=
 =?us-ascii?Q?WbZLOLYgPC0dkN2DSubl4WCRNGC9aYRcu8FugIg7Q8KU6PBxoLhlJT4EVGs+?=
 =?us-ascii?Q?RvRS1O7iAnDDc+7pOWg3RTLsiM1La9BruNqc/+8cQVBTFaNiIrqjaUkvmFg1?=
 =?us-ascii?Q?TWPPqO75bn0lwkSWl+cRrIow2WQQ8T2rorNKo08Ilw6ac+D39h67VLNkLFP+?=
 =?us-ascii?Q?rjRZdK/vx/VuP14V/arsvJVun0IjValg1pVaHeBp+F+DnWZWaXHc+OXETI7/?=
 =?us-ascii?Q?5wJ5J8Ea0/bzRfB2b51Z8M69TqLSTFLs8ktE/1EEuT86nhjWNc4vmiLPARY1?=
 =?us-ascii?Q?xHyrFjvetNRRxr4/J0km757IoeqotEFM4B2/DOutCAEZl7cKDH+zsvG3iWpP?=
 =?us-ascii?Q?o9zwfB/JmFyXfmHd7fKGyQiuKoTeMMr/nbgZxwsb+MFPos5/tzBw9JiE0V67?=
 =?us-ascii?Q?wvAnF17+f7agjJLJgSdGYzCKW6G/WdEUMqQjbKLmySdnRk4dC4wskZarZoao?=
 =?us-ascii?Q?LsPDp3L5FYlyncZfsZLw8/VU/wn0cnUkbZu0Nyb/8n/Tf7ETTtpdKuhz8eR5?=
 =?us-ascii?Q?i3QfuK+9C+HVro64avTreiVdmGXQNxvqeJOCOhMMyLIQ+jBM2GOXbyJo0zTl?=
 =?us-ascii?Q?tqhktwX6e1bvDWoA2aGJsM/qlvp85N+tjq6MzMfL18Cssx8FAmiOseqs+2ky?=
 =?us-ascii?Q?6uNZo+Q4YdGi4pJnisoeuDewMe+dm7uC1LEtTaVseRWaYz2giIRgLa7BZ0Cm?=
 =?us-ascii?Q?NYSPLXWlgu1oVyXoC2zVhsDXRMVgAJJch3iPkonScs0Ha09nnmIfJHaTI0ix?=
 =?us-ascii?Q?3MV2rseTqxMz9ixRIMDYYUSDGQ1P3W4Ym1CmGx1YPtMQfvukSWVQsjqWh2IE?=
 =?us-ascii?Q?WkUiMEvEuC8nPMAYAkzbKEB8cytZRSVtuTU2w9xtfw/Nu7lDj6cyEV2lR6c3?=
 =?us-ascii?Q?tFiescydmwVZgjHKE3fD9v6YlrdB0uKKT7JNLKSNo0Kf5SsaC2/LvSXxRtSD?=
 =?us-ascii?Q?5CDi8DNbzh67jPgpCjx8GhgLUB5w5cZpv/42FYDCiDIu9yZu35HOxQdCr2Qj?=
 =?us-ascii?Q?cz8XRTbXXCp/YD0iJyZ7HgjNpaiaUjJJBsXo/Ez//V1RarqRjWnY/t0yknzM?=
 =?us-ascii?Q?SovorYh5Om69rixEBXZcuvsgshoKBs5mvpFoCgYy3d9qV/5r+lKLCP8R8A7i?=
 =?us-ascii?Q?If06aEVOOP3btELJVSc08CazFix+/KlheJWCxPYZ+vBcZGeknPrpKhBI2dm7?=
 =?us-ascii?Q?8coAOXQt+cV6Eopz75XR4ap2vU7MJuFlIBS1X0nQWiS1B5ggJkcYbeQ85+nK?=
 =?us-ascii?Q?h8K92Pr/7Ju6ezmetmsXkmzow/DkPymNRrp18SvDPnwDLF1Nyo6hs1lN9jgf?=
 =?us-ascii?Q?YTthhxz/FVJgwxt2am+Uw5UZRyI9pJtWFn2/O7ChrxqmIIKW8dKka60yjDgd?=
 =?us-ascii?Q?yqHdMTtRKNjMoc7Ro5krEDaO4eguqH1sPA/wHSHl8FMPIEEA6jKqv2S2AXck?=
 =?us-ascii?Q?F0p60jbV4LJSMEEQG5vPro2WjB0afMfMuEMMRkQ8Fukl0bZqF898MpmT+4+w?=
 =?us-ascii?Q?e8yekScbs5Gg7163Xi6d/bfc56m2KmibFFroQSgW9jZ022Uw9ftIWyJMaNem?=
 =?us-ascii?Q?zxZsfsy42CgCIBsTWME9KmxA4riuuYHVUInkMPMU8tgy8n/oQO95lo6zWesx?=
 =?us-ascii?Q?5DzrziiOp4JehvVeYeSaOM9GQIvTxo339rbS9cuLU+G7juoFwsxW?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a9b0c9-a60e-4a4c-1890-08df49a3c88f
X-MS-Exchange-CrossTenant-AuthSource: AMDPR08MB999846.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 20:53:10.4186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd+/R+QlH+62nP9v/RJn/zh5dqIvXsSp392NrVaDmWg0gZu1wIpjpTrxW2t0Upei7kWltemRp1pWQM1LCq4bww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB670600

On confidential guests (AMD SEV, Intel TDX) all device DMA is bounced
through swiotlb, whose pool is shared with and readable by the untrusted
host. swiotlb_tbl_map_single() copies the destination buffer's current
contents into the bounce buffer at map time even for DMA_FROM_DEVICE. For
a reused read buffer that still holds private data, the host can read
that data from the bounce buffer before the device overwrites it.

For DMA_FROM_DEVICE into a host-shared pool, zero the bounce buffer
instead. Zeroing rather than skipping the copy keeps a short read from
returning a previous transfer's data.

Fixes: ddbd89deb7d3 ("swiotlb: fix info leak with DMA_FROM_DEVICE")
Cc: stable@vger.kernel.org
Co-developed-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Shukai Ni <shukai.ni@kuleuven.be>
---

Notes:
    We are open to discussing a different approach: e.g. clearing the
    residual when read back, scrubbing slots on free, or extending zeroing
    for bidirectional DMA.

 drivers/iommu/dma-iommu.c | 3 ++-
 kernel/dma/swiotlb.c      | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba..42e0bfced 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1187,7 +1187,8 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	 * Untrusted devices should not see padding areas with random leftover
 	 * kernel data, so zero the pre- and post-padding.
 	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
-	 * the contents of the original memory buffer.
+	 * the contents of the original memory buffer, or to zero for a read on
+	 * a confidential guest.
 	 */
 	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
 		size_t start, virt = (size_t)phys_to_virt(phys);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 786954bc5..351bc7c54 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1630,8 +1630,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * the original data, even if it's garbage, is necessary to match
 	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
 	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
+	 * Exception: on a confidential guest the bounce buffer is host-shared,
+	 * so for a read zero it before sharing.
 	 */
-	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
+	if (dir == DMA_FROM_DEVICE && mem->cc_shared)
+		memset(pool->vaddr + tlb_addr - pool->start, 0, mapping_size);
+	else
+		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE, pool);
 	return tlb_addr;
 }
 
-- 
2.53.0

