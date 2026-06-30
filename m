Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C66194AE6;
	Tue, 30 Jun 2026 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793084; cv=fail; b=NcLBaRVbW5/sLh6FXdvQFlVCbpSIxzEtG4850aY/0VIqBRob0qW4KBSF2Td7zF4clA/BidXKO0g7/AwPQeMlRSHJpSF+oWinb8L/nZQe83u7XZngeUzpliZ0B1LtaxUHHKJf86yP4g+nLLGef8q9KMWs4zERn/AzEX5HDx+dxXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793084; c=relaxed/simple;
	bh=V8iTedoSrAStpgWu8zjeltSN7p+R+1JHcnEljXQUndo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmpIBNefaxzQ1dHrLUaYgAFBxVH2jrhsFJYfQOvJRWFVl0RYs3XMjO/B7Tpv6KUCF3w1gZbDiDLcgofQLVOFbZ3dRGD/bcJZrT6CaO3ZyXjYmsqOqe920U9ZrsDltH+asKzd1xxeelDQOzbjEUcdEVLhqvisw0fzI5UwFfjKF+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tFXi5wHY; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tFXi5wHY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbIyq8pIhHYDtgldOlUt+KWDQ8JolbIFj3yTjbcIpwi6q3T+8HX69y1bQLpsKbhPUQSvMh2ySY/mLQVXGlxoT8AYruZ9WSxdS0N/w+q3+VM89dWBX1ugxFFhqJD7qRKKn1YlwTbo8JvJekdGdCZEmkzNo1QSGFPlpntZYCA7N5g6pJf8MJ1olgVRwXtOcYY7DiuiIDihGa1Z9yE3PX0XLTcrwtabHin0yUMH4WkpOccBOESZ3pHwzRccxnKVyYjCTsAKQ8SO7dHUsPtbP3uZy0vwGT4UxeSwG0VvBauzGJIf6+7T7gX42k2KOJNMQk1DxWgfiLxfqDHZaagNcrgc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ93ZshzGsyYGPJREIMmjF26CtrhFp27Uth5ioMv1lw=;
 b=O8p587bftLTa3Se863L67MiLukFFATwkk63OUPNuCBSLfGFjZJNMsi5xM6MekEj9uUwMgsqUy5ipHAKDovii1Q8zQkMlEIyg59oQN3jDBXLgHrjGG+qSdCivy8fo9eASny8Mdn3jFcSuHv3JMctSaHtMFdxqKZLSOwF778IhXvaKKXdg4CpMJmSnUxdeVouw/DCrQs4dXgMVPnhmmHmU2BI/DTv4KkBA2bMzdOpve6JqI8IeQc8jvuW5Mod/E6rxTLNgroNgKCiPgDA5LLfzUK4raxcsTjpQot7XLPpPBVOcRzVUken4qh9G/CChYQHa51pHtsYVfhvmAe4ZgBFhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ93ZshzGsyYGPJREIMmjF26CtrhFp27Uth5ioMv1lw=;
 b=tFXi5wHYqIvq/SPumDUsh0rbhB6TfiJ/FmeMwxVsoHIOdA75LbNnP2ZCWVcNDejlM9eZp0CsdBO8fN/SZ7uXB1mFGRHvkvYicTDzhP0FZPb+uz5W9/0/qWomJR6+ojGHDk/rpvjtc5lRYgqa9SgMqftR4UQP1u8rQfD3gMZx+21yFCxUMjch9HMMK3aIkn/OQxO0Jnb3T1fgnUovpFHzTAx/1rYKG3iN6WtGUg4TroMunU/JdeDFzY2sT7U9bsfFT8p2cgN9/2qeRql6iDwl8amqWSCG6A6o5yo/TGjth7IhbRICQFfprG7RRHeS7Dp0FyE4GFPBRhxX2sKF3A80aw==
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:17:56 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::f) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:17:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 29 Jun
 2026 21:17:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Jun 2026 21:17:43 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 21:17:41 -0700
Date: Mon, 29 Jun 2026 21:17:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v6 4/7] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in
 kdump kernel
Message-ID: <akNDZM7n/EpBmajY@nvidia.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <1280ac4fdb37f998fd6dcb2bf8f4437283279395.1779265413.git.nicolinc@nvidia.com>
 <akKMCYsdH4lVSyf7@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akKMCYsdH4lVSyf7@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bec1407-a644-4fca-9f57-08ded65e8fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|23010399003|6133799003|4143699003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DmwjgnW0t4LsY1A7FXyqkjCho2dmQcvsvDKHL1HOyIz5VE+MyqDfC51h2Bo2mkrWReo8BA56YAZC7DBW5WofRfvCFe0pjXDfpJMPxxUwnKH75xZx8tbLv7zkqv8IgAIbOKxpURiBTzD7qs+DhGBHcUg8XPGytUCeiSL7EZ/KwPW8Wlg225ySBdtNwhwm3W/1rwoirDXSuc6PJlHdRiuHnvlLO2UZE12sAA+Cto5qJ8MTDMHYtEcz9wtn0lZ3iUHmuFHteO5EMN3ZgQUff94M11CcghFTupgq3k6o/bz7lR8l/52FfkuKBHyCJWTzmC+5ZmchXG239gRkgA/37wo0eWDoWWVVMV0TpnGjq0BaRth9XdjKxOPne1i6m/SdL0y8ceoZgAx7dZD/lxfQCvgj5k3i4HlCCsFUuo2/SQb/29OJ42IYZjSmGOIsTHsB9gGPxR/5+2cEX9W9Sgq+VKoBEmO292QmDcpO4JASjKP5wrnWQz+YzOfky4F8/AsaXShzwmMn3sasBMhjkJFm13uZBX4kcnetuSODG4MK82kTs+xzelCZeKJRlf62rvqwDq7rwkIcq+6eWjUedHpWaCgrLRTHRHCPVfGO8K07iB71Hz8+VpWBGFvwWiPTsiApznsE3x3HjbaamnxpeqcISvj+f4DYM/hTBLJD9daPkFFqHp3jEQOY6gIeTkeD4CzloAPWaKmPnOisixENppbEgtmIjw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(4143699003)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n15zsCmdxa0C8FWjdHloDXIGifMtksRVFB9TM8Kc+BfQYdCPyDZ6x+AoRsDlJkCdU+Hef9VacNouAO293+pZp4x+jsJ0rWFfz4ceVYMkNwpG+j7Wy/RuKGpGec2wcCN9XuLmzscdbgqb1aphb0CfyljdL+s4JBTN7r+aiPX0JieNX+N09xSNyxAOwnBfhNUbMGgxO7CqFjxgn+eK9ffdEza3PdqXKfwuPFCVTaycIXXbWTqpYrNaYvxzmdfs/L4CQsY/ZEkLbttOZ3zX29hBkkzg8gj+V7BfJiaVJfI5o5fqzJkpAm85MGQh3A1dUwmTanPRVC3yPX9x2Por0e5CpfZwv+cPNBnxdS+LN0GuXjhRdwy9z5GmxjgobU0T1ypb934/yH75B6FQzecjBdhXLUv9yZKUl6eG9X1kcaTjM7EliUKh8sTF2xkR2JrLlSGK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:17:56.0138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bec1407-a644-4fca-9f57-08ded65e8fd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

On Mon, Jun 29, 2026 at 03:15:21PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 20, 2026 at 10:03:21AM -0700, Nicolin Chen wrote:
> > +	if (!is_kdump_kernel()) {
> > +		writeq_relaxed(smmu->evtq.q.q_base,
> > +			       smmu->base + ARM_SMMU_EVTQ_BASE);
> > +		writel_relaxed(smmu->evtq.q.llq.prod,
> > +			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
> > +		writel_relaxed(smmu->evtq.q.llq.cons,
> > +			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
> > +
> > +		enables |= CR0_EVTQEN;
> > +		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> > +					      ARM_SMMU_CR0ACK);
> 
> Nit:
> I believe only the write_reg_sync(CR0) should be under this if condition
> do we see any weird behavior if we perform the reg writes in
> kdump_kernel?

Since CR0_EVTQEN isn't set, the other three writes are dead code.

So, I skipped them.

Nicolin
