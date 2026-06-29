Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39294A32;
	Mon, 29 Jun 2026 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782705726; cv=fail; b=pmIZyPOWyyPGlZxcBXnsinSOE4xwNhHwaoxQUgqDlXpjEUg83o5OWgC/VV0luMvnFYi0kyYAbPBnLnDgL7YRTeY2wjbRX0nkR3uSs/WB+9AXDbIaXrJ2XjviIKVuNKJNdCDuiJ2ToPJGjBDTElR6t1SnBPRh/bf/KshNIubS9eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782705726; c=relaxed/simple;
	bh=MfYx8m0VFO0DMrPv4uc+5outkPhhMhDuJuwM6FUMh2M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8qFrjUIPJ6disyshecaeAdpGBnNtuvIyalhNYh2Dxa+8rEKSZgOOXakWeyx2epDB5zdRw8Xet7J9s6Jpx6xPWxvEJO73LPU3CK50f2nuQkzvILkctyZvFDuyOkVEC1KukumKQ3WidT43sI9DvE4Bmvp5zME6caudW2M4vkGN/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzOB2/JX; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzOB2/JX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoK8uIq8Wy8WreyKSD16TpaOH3+GF4QgAL7J3unDWHziJ9k/7t5Kum4oXXGxq8sqSjsGZSsJqSzOKn8Dy4vwyr9Qivk1McDSbevCkqnpCNlXHAbqzJKAcNDi0RZJSznSQT4sw0hkfHUrKTW1HjjHi/pUdbx2Xx0TZ1JaJK+1soUjZoXrLkqvQp9zhFX2rfny89Tvl0FRvGFxFfK07J1umh9i8sBi7NmsOAjnTmfn3GeL7SxAVfZI0YPfYRxpkaUU7DcfNywWuwf9TTNPWEqBUvvPcU8hMZtoCMHIN1x58i1zZfCBMsEImATcaViPGeE3inqmtN/1sneE1WKJKprSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AJFPCPl13lM4PjiWiJ8ZgohvKPjZXPbwSegvuAIxxs=;
 b=n84uYG5wsXL426qIbVhMgvDsDH6iA2AiRKwA+HABrtebAX7aaa8gJtT+dMXbk2iKgG87bU/awu6plEYxy/H8RGNUmRyHHBuB7n3KKZQAp15zddQZFdnAA1N0pzRvWkZq4RTCBu96zmjoVEM6BnXEYn8xRcAOUBnJc2HJYrUJ14eZYT0oj5wnTC+3tvVrRjwKZDIvkIj9XZuRpFyMMafiqWpkg/UXO/pQggPsMWOxYyvtjXflM3iflRUAyJ+rnn24Sxo+YwVcjfqsHohVYnjP/B3D6OWMz9yTb2IpBhw6gR2e0RRN7aY9QUcJRpJKGHTAoleDbULL5LapO7mx5Aropw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AJFPCPl13lM4PjiWiJ8ZgohvKPjZXPbwSegvuAIxxs=;
 b=pzOB2/JXw2KoSfoG2lYkVfFo3uq5iKMuRSUI+2j3zcZLXZyPUFIG31oGlDMscO8dMe6BY0sV9jzFQYmPZ9qrFEojNcTkHfmiZg/6DIb+ej/0+dwXb4R5zFp0JYsB6EYqCOwki3Rji36OFl1r3UkvCa/rhPW8i55xkrlsxEKLJZc8Xrf/WgwGtX6pu/F+PQZJKKe/xBC6vxI+xhZ7//kqCdIGojBzWiLpvT36ac1tIJpTj46Mr/MD7EuktYdsLpIfMIx38Mhi+GlOSiq4jWU69C6jVD/Yw6j6GG0ChfrYaJhOXbmJkcF8jLcuEsdOPw2CG65VO0SHl9jG18WZYUPq3Q==
Received: from SJ0PR13CA0179.namprd13.prod.outlook.com (2603:10b6:a03:2c7::34)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 04:01:59 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::94) by SJ0PR13CA0179.outlook.office365.com
 (2603:10b6:a03:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 04:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 04:01:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 28 Jun
 2026 21:01:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 28 Jun
 2026 21:01:48 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Jun 2026 21:01:47 -0700
Date: Sun, 28 Jun 2026 21:01:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v6 1/7] iommu/arm-smmu-v3: Add
 arm_smmu_kdump_adopt_strtab() for kdump
Message-ID: <akHuKRctyEv88ytr@nvidia.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <f3d1f938a9b4d540f67d9c1ff394bd62735a4f5c.1779265413.git.nicolinc@nvidia.com>
 <akGnm_dzvoapjwoI@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akGnm_dzvoapjwoI@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: cb524f0a-ca74-4fa0-ced3-08ded5932af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|6133799003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	173+ty3wpEUvv1IIKh1i+HdT3TExiZcSGkzP4kt4f1/TSnjtSqhJUJMUKin0jdRoPyQwZgN1USOTXg9Wz8nRqWawrMZEqeZxQHVqg3PSCGLE7hx+A6zAPDU70qPaxfpwmh+GhgeRw2pkUdaALO+kAN5ff4P1XL9V0tQzE/kbyzPMIAdTBJ2WbwBZFEEM0OaG3jBlyYnggRrSKO/5AlpmLXXKvbZFHMsmGOYsziVBEACMTbRLPaGXJyFo+ab3JNV2Z5IC6L4jLpVqfZEEWX0Ik5cBucw2KMVWyTqL1pQBrrE/TAeNdStgfHhwFqdSneRp3eH2kiR547mAHxDKWvBxSr6/QC3ByFFmnz+aEHN5cpElu1XCp/Zv+Oz1Z3bsyuo/1CP1sZCxIh8S24IG7M+SJf2CFx9X6HCz9WMrndmN3YSX1mXPvHQz+1dUa+fEzT6d6kJaC4GLD3YDaoJdJhcKLSJMj4NewCX7+AiFEMP82k9k2StloeMey65XtJGLHYV7vs5HgANEuH57bzeL/Ptsc9po0+IALLbWupPQEqF64E5AKnD3k3wlENnR4Ao8+cKeLg0jSqhGAOeBJNPoIP376dadHPx933HbEfmcw0UjZjkKYMr3GU3GBy7b5XT0wRp7/33dip9w/t6l8FaCcakkMi+wKoEsMA2FMDAVY4oHFJ565T4QYcop2LwbdBEawahw+jdCAFl1vo0QetS9L0Q8bA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(6133799003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ck5R7iCrd2MyoBnAGjjDVoAW/NrTgDFdj5HStUm//4nmx0XuCphZykVTu1C9oCN2el0JwOFAGMrG0pPlWVvysNQq+PYKRxkFEuvPHHfXnYB4HP07YqOYXlg6OOj4/UdXuGJJLLByYkpZLXly2cQsGkLVZEsDPK4hwcSyrdleiGWLoale7ePT4aPMBi93RJg/K4TiRIBnQWkoIzbARKJtRyArtNRfKHsytEv3K02ZrfE8RI+tOVoe5cxcVebLVGLy4LD83vUcRanF4HjhWbJJ+y0qlzVHjgHIIWftrQ3UcqqvhXVKVsUKeWQiWD4ttX9rgGo6muBL9F5naLjk6R2fePjHb5vjZSFkwMRVzYOVusBdBrbOOOiaA9wzgFQ05EIWJ23jB56pGC1Gb7/HUFebQcnvDywegSHnt3WECZRE92JxpXHIiYROShGGv4HnNj1R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 04:01:58.9233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb524f0a-ca74-4fa0-ced3-08ded5932af1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

On Sun, Jun 28, 2026 at 11:00:43PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 20, 2026 at 10:03:18AM -0700, Nicolin Chen wrote:
> > +static int arm_smmu_kdump_adopt_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
> > +					  phys_addr_t base, u32 span,
> > +					  struct arm_smmu_strtab_l2 **l2table)
[...]
> > +
> > +	/*
> > +	 * Retest the span in case the L1 descriptor has been overwritten since
> > +	 * the adopt. Reject this master's insert; panic or SMMU-disable would
> > +	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
> > +	 * would break all other SIDs in the same bus (PCI case). The corruption
> > +	 * blast radius is already bounded to that bus range.
> > +	 */
> > +	if (span != STRTAB_SPLIT + 1) {
> > +		dev_err(smmu->dev,
> > +			"kdump: L1[%u] span %u changed since adopt (was %u)\n",
> > +			arm_smmu_strtab_l1_idx(sid), span, STRTAB_SPLIT + 1);
> > +		return -EINVAL;
> > +	}
> > +
> > +	size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
> > +
> > +	table = devm_memremap(smmu->dev, base, size, MEMREMAP_WB);
> 
> Why do we use devm_memremap() here but memremap() in the rest of the
> functions (even for the L1 ptr)?

Because it's called by arm_smmu_init_l2_strtab() that is a later
stage (arm_smmu_insert_master) than the other adopt functions.

This is deliberate. Otherwise, no one would undo memremap.

I can add a line of note here.

> > +static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
> > +					    u32 cfg_reg, phys_addr_t base)
[...]
> > +
> > +	cfg->l2.l2ptrs =
> > +		kcalloc(num_l1_ents, sizeof(*cfg->l2.l2ptrs), GFP_KERNEL);
> > +	if (!cfg->l2.l2ptrs)
> > +		return -ENOMEM;
> 
> We shuold ummap cfg->l2.l1tab before returning -ENOMEM here

No. The caller would call cleanup() on the -ENOMEM.

> > +		if (span != STRTAB_SPLIT + 1) {
> > +			dev_err(smmu->dev,
> > +				"kdump: L1[%u] unsupported span %u (vs %u)\n",
> > +				i, span, STRTAB_SPLIT + 1);
> > +			return -EINVAL;
> 
> We leak kcalloc'd mem (l2.l2ptrs) here, also we should unmap cfg->l2.l1tab

Ditto.

> > +static int arm_smmu_kdump_adopt_strtab_linear(struct arm_smmu_device *smmu,
> > +					      u32 cfg_reg, phys_addr_t base)
> > +{
> > +	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
> > +	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> > +	unsigned int max_log2size;
> > +	size_t size;
> > +
> > +	/*
> > +	 * Only a coherent SMMU is supported at this moment. For a non-coherent
> > +	 * SMMU that wants to support ARM_SMMU_OPT_KDUMP_ADOPT, try MEMREMAP_WC.
> > +	 */
> > +	if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_COHERENCY)))
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Cap the size at what the kdump kernel itself would have allocated */
> > +	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
> > +		max_log2size =
> > +			ilog2(STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES);
> 
> Looks like we'd never hit this if condition because we'd never support a
> "linear" strtab if the HW supports ARM_SMMU_FEAT_2_LVL_STRTAB. Please
> see arm_smmu_init_strtab:

It's a defensive check that Sashiko recommended, as we cannot be sure
that the crashed kernel was using the same driver, which I think it's
not bad to have..

> > +	size = cfg->linear.num_ents * sizeof(struct arm_smmu_ste);
> > +	cfg->linear.table = memremap(base, size, MEMREMAP_WB);
> > +	if (!cfg->linear.table)
> > +		return -ENOMEM;
> 
> We seem to skips initializing cfg->linear.ste_dma (it is populated in
> arm_smmu_init_strtab_linear)

Yes, deliberately since it's not used anywhere in kdump adopt mode.

> While the comment notes that arm_smmu_write_strtab() is bypassed in the
> kdump case, leaving cfg->linear.ste_dma uninitialized seems like a 
> ticking time bomb if any other part of the driver ever uses it.

I can't think of a reason...

> > +static void arm_smmu_kdump_adopt_cleanup(void *data)
> > +{
> > +	struct arm_smmu_device *smmu = data;
> > +	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
> 
> I'm worried about reading the HW register here, since this is a devres action, it
> can run after arm_smmu_device_remove() or arm_smmu_device_shutdown()
> (which would call rpm_put()). Please see __device_release_driver[1]:
> 
> 	pm_runtime_put_sync(dev); <--- HW turned off
> 
> 	device_remove(dev);
> 
> 	if (dev->bus && dev->bus->dma_cleanup)
> 		dev->bus->dma_cleanup(dev);
> 
> 	device_unbind_cleanup(dev); <--- This is where devm_release runs
> 	device_links_driver_cleanup(dev);
> 
> Thus, even if we call rpm_get() here it would make no sense as the 
> register contents would've been lost. Can we rely on some SW state
> here? smmu->features & 2LVL or maybe add an fmt in cfg? 

Yes. Sashiko pointed it out too. We can do feature bit.

> > +		 * format, enforce the same format to match the adopted table.
> > +		 */
> > +		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
> > +		if (!ret)
> > +			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> 
> IIRC, this should NOT be set if we selected the linear format.
> Looking at arm_smmu_init_strtab(), if the HW supports 2-level tables,
> the driver unconditionally selects it. What is the expected scenario
> where the previous kernel would have allocated a linear table on 2-level
> capable hardware? IMO, it is a bug if we see linear fmt with this
> feature set. Am I missing something?

Again, the crashed kernel doesn't have to use the same driver.

I will address the rest of your comments.

Thanks
Nicolin
