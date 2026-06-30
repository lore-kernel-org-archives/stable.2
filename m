Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5E360ED7;
	Tue, 30 Jun 2026 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847674; cv=fail; b=rD+siF4/a9V4YD3laVlcLVTFycMBFbM4BPxPHmgjuEL28BqtnILZgW+ZG5l81FSCPf+qMaz0OEUik4q0DnedrCRx4HmF9FkaCE2mLjkZUDh1eQf1xStAQely/WU5xTHtlhqMuiL/N9wM0AyqSoTR5LnwsByBBEmOpJAeVqUy0GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847674; c=relaxed/simple;
	bh=eAa0LJNkfAAsefkwqhEXbeHtJULirKczTYni62tzwYc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmaK8KmAYVtvzEMEuTSb7QWGZYd7HDXeTx3X3Jcy4md60eHgFVdXJk4mOwefdI9gWEiSUNZKk42oT8rEG6ERR1hD2CmmdX2flccbViji+zoYJRnX5cUd8RdtEWSDHT48uq/eNblCz4pZ9SxfCBtQb1fDjbeuYPC47tRIAm6ATmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PNgKFoaz; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PNgKFoaz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC0BsU+Onlsikazw3b3RzIcJIx83Y/2A0Bjs0ovgKNISQd/tZFicK42sYNXIjD+sQTQ5P39CESOSw6Yl1JMue0XxYJus5cX2ZDhJUpe13C1l+49ofVWBg/wEZRT/8naUpsIeAN0hxnE3B0ASU1khIY9tpUiVwkE8fQNjmY2FJRa7fXnWRt6Xdo2gmzm5tUDFH/lpuFtnvQBfNqczOTDlhAF3JNoHJlKX8Z7ZT9AjTw9Ospvk9bkIsGnX9bDUGUut8WQmP+uqdKsZFqRVw/s+zsHfePJwBkn+Dz7E5Bv4qkXBWtj6YGAmH1o3MsRgjS4CmOZsAM08r7ZLNgWnGdoPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAa0LJNkfAAsefkwqhEXbeHtJULirKczTYni62tzwYc=;
 b=RdRpXUz8DVz+iwGJZ2H1UHkgfdxjb9MLpzsJhPljoCC3q8y9aja8xpy3oKmgF8k42TXqnQ8498MlDyibOKCV4nCW/kILo3SAKY+eYFTHgoG/gVmuXId0tP/RxuRUHxE+VJh5ww3vnpJVMyX4mUGebn8TmqnCmpScGGPxIAPmQ98X44pc7J9Pb8S7Dm5aFkUCk6KBeDzB5VQcTP3f9d8cFN1VmnnFk/kR7DTcKc4TxqzRoCYxIWTO/DkCN1u8lfOGL7RWmAvo08/hOSYcSgRW5nvktxgDBnR9k6wVf+jGHGygPR6KB4dw0bsqFhgccRPFlGP01NC3oqgp83HweUJNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAa0LJNkfAAsefkwqhEXbeHtJULirKczTYni62tzwYc=;
 b=PNgKFoazOWH2UjLTU3TzsswRojw08VnTlk0zNj+SJ1oVjkzAH0/kF0lU191rEiRS1HNPV0c4KYuoHwOfbF5wpIwuxBZdeZjHv45P4eNr7LNRubOsczmeBsuyz8Jz5cUzbx5k191xAPYpB7mGH76hzh4glKV9G8W+GhUikkvUAcmZfBdyNxh7K55ym9Wxzw9QhgZsiUW4fvAqo3RijIUGptDZiUw+4Qcms61b9fN/Gcf8cFN4lAk+fyzIKYHqct6tigO9AtJlYDln2/QXiUb2QQEaXnNA+d3YtTCDkRLyOlE2pzI+IErAxoLnjnsJrZLPWTfeANye1LKPgP31+HyvrQ==
Received: from DS1PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:458::8) by
 MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Tue, 30 Jun 2026 19:27:47 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:8:458:cafe::34) by DS1PR06CA0002.outlook.office365.com
 (2603:10b6:8:458::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 19:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 19:27:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 30 Jun
 2026 12:27:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 30 Jun 2026 12:27:35 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Jun 2026 12:27:34 -0700
Date: Tue, 30 Jun 2026 12:27:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akQYpCdwGnpKTnjN@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akPB6l-fuJUcg4a2@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b90db3-cbf6-436f-5914-08ded6ddaa90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	92RuoswarncHn0MVRyawZoAOb3kJwi3O/lZBeBPMdcbL2dZsHNyNigoFvRTDFX2ILPR3GuwNXl4pQxhqfHbxBndt14PO72jswE7P/QsYT5OsP24oJ+utOtA9wJ7pqzNoNorzM+Dp9ahot2HiYt6pyi9fJZIjhJYUTdts2yONQJqXgYqr1Cxf5MHB13SMac+28yXD9hsufYsj5/A9TQYZxGIRd+VkLeCMH8VSKuELHHocEHypMtdDlTsyV+KuWhYw2Qf/21TI6wEhQl3xKRDnYoUI2bfrvhkRJublhQNIDotIptZAzjrI2rScuC9BecyDsiX3BuINURaRhxN8PJs4Ut0Z4Q6LT7GmRN9YKSt4G2Y+wdxQmXw3Pk0l1JJdOSSfPDBqGnni8js2BA6Y43x+ESSz6I3nBb/3Svja7rnB38140Oeo9JSsCEarJzQ5vA5F3etp122OnM9LWMmDFnJ5mG3kv6erlTpI+iot87R2zuXkxLu1nLYR0TEw4vW68eNPPJJtgrorlXjgtMGlUfTU7iw9/RLDwhlFy7y46NO5JaoyGxTWGnKTnx5We38//7/ypHXt+yvHxUbK4cOxSb7R0hREViQqWgtNAkAvg/5s10Pz6YvatnbM3GZJFS60WOjZKRAc3t4roFBhLRvO7n13S5tK7f6H0MRMIciVu9A8Dxa05G1mbXNyO/QGIMbSBFGKDr50Rr4+9mt+oSssTkuguA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tSullCQglEA82Vh5ILEo9V1wv0g0VqOC9eAYIJaEiIfF63H+fXMxYsgzRN+zFy3DJdzLG8dbiqDtBHhM/9phJmMwhFod3IM7Z8YZ+J0NZhptK4MHN9M4GcfUXyPkkTNIr2LCJqKc0lBqcCIldPrwzhuhrH3UiNsNxcLgz4zufPnSVkMLrc8ROaDnpaxaDaZj93CCccbjH8sdqpksq3DfCHPG+rAA6CVb5Oe40DFI1WKfWSnr9EVTdIfXk4qFJRAw/9Eg7sY1fFRK0M9rWSjRaL912yhLcUbkiebq/K7va0KuinKMmDRoM//64x/uTJdl4MSrfiAtqXGZ8SmbUNvMlFBvp/UCcluzq3MPT7Xt/vWox7QuAA5Feou7GoiA55RN6tAjZ46DhC+GdI4X8aOebAEyoIu/qrjo8wVuMMewCZ+QDg9MI7icw9JYcbd1dbKd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:27:47.0077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b90db3-cbf6-436f-5914-08ded6ddaa90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835

(I think Jason has answered most of the questions here.)

On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> For example, patch 4 disables the EVTQ to avoid events as there might
> be a lot, why are they not fatal also?

FWIW, the PATCH-4 doesn't disable the EVTQ: EVTQ is disabled in
kdump case prior to the series; PATCH-4 just makes sure it won't
get enabled transiently.

Nicolin
