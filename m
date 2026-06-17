Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E643502A7;
	Wed, 17 Jun 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727582; cv=fail; b=vFSgv+k/M3Tkuo3sD/2SRi+uSm6xMHYVQ/bvro17NfFW1lTOTMRagD8KhLtW9jccJQ0J1gUWc0kw+WF5nSQ/OjEqYuTNRP6ZqgNQNFw5AAQbVA39hA3QD/RKnsUzO/RQxZ3SEiLwH2uFCA1jL++hubhVzIdk3jCiiWri5vAsxkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727582; c=relaxed/simple;
	bh=Oi1iqwabja0lUxrCSYAcTtOkuxC2vKK+koW7EOttj8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n6WeZ9k81QLsRo2mqOtnTMUy+rHKgSxaL/nOvxrIlKbfw48MdMzWJk8YKzprtbvyW1lvKYaRkBwbn4oBLDq4plffJ/l4rObcGpi/0ySxfASUDMWmgQxarQ/p3WhD5szqkFiqJCMq946GlIGCqAjsQQwjxIX8qr/WwXpjCdr/xxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RPXr09xr; arc=fail smtp.client-ip=40.107.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RPXr09xr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLLLzhpz/uNromMj9HEvqZRrYR1Z3AIwT37MhmRqhhlTl+EMYBKnH7Q+J4Zi08ALqF8aVw/m8/1cTL2CUgqc+SxRNYRhJ3bwT4j/rY+ofpd1nut73jTIC6LLW1u35MGnTtWRniPtClWWFGuoP1QXIJ6VK5wRlk5kSmuAxNkaeMw5bLxg8PxPLOt98749pbV75AgnIptWW1PGX9C4Ee6ZWvK9pYtHL1gN7G/mPa7kBIcj4pUmmTGQFH19O1RUIfoytaud5Q54R76FICtUmWKGWFqV3kAbS9biIOcR1FoPyu6m/ivHKhgtTiL5zxXYQsC916zHWxBWccNj4XyAMvYi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITBsM2jJoTZAQhu0cVKjcJy1xADTpbuUq/QuG1jyvjg=;
 b=bBWBkhyZuW3vtKOe37nvcWaSB3sPb9FzEychBtr9OjEU29EV9lnjBE4JMWfyxzTPuXvRjTWsqJDmWb3wCfJxALsy63nJ3tsjJNEeDMzWoB+nSJSpj/tvHATOstb/gO79ivLb4Px8sfdXoso+nPh6zkHl7aiQi0+g+Dz+UCPUQUetjNA4gXP7zwY5vlNcVF5ntt13zvkPcX1VWFDTjhLEVRjg4vG157PE+AURJy82T/vSFdNnrHXHc0JgsWjkrmWZR0rfTR1isxehshTEWmRAuSPQWapo3XBi5L3tOaLai8K3px4I7t12Rrfa/AGZjbPtswMRBQtGA4Uo1U1EyIPruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITBsM2jJoTZAQhu0cVKjcJy1xADTpbuUq/QuG1jyvjg=;
 b=RPXr09xrNxlG3Zl79OXOyMG/Cx8W+vdnL0slmm42VlU4PSMyXj/Hg4QXclAY8af2VQhCgDjcnAt2osdT+oh6wX5DVWNWr9KGUjWp1A3rfo74LjS/m82AQ9TKlB1YjXfUxJA3zyvkrQG3PO1XrY/R5KXZILMxN9eM+7FpnsrBJ+4=
Received: from BN9PR03CA0587.namprd03.prod.outlook.com (2603:10b6:408:10d::22)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 20:19:37 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::3) by BN9PR03CA0587.outlook.office365.com
 (2603:10b6:408:10d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 20:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 20:19:37 +0000
Received: from [10.236.188.227] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 15:19:36 -0500
Message-ID: <4142d143-8bfe-4364-bfa7-73a48d214f25@amd.com>
Date: Wed, 17 Jun 2026 15:19:35 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/mce: Make the MCE notifier per-region
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <djbw@kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<flavien@nus.edu.sg>, <stable@vger.kernel.org>
References: <20260616224912.2567474-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260616224912.2567474-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c578ae4-871e-4e6e-6152-08deccadc135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jiJ+bqqdYRLqOZi4aVIqzN5cPFdGuRuoKp/hB9CQX05cfSA7kB0JGepxCKLXVmF1NUNbCnf1BUni8Xm9ix1K6Ij8CGkC53hvBeGHXM8WipzoL8C67fKNAsQa9lZl/hodUZpOOvI0hfS7Oh5WZexBJmVQ8KwMBruEjcygqmN0NuUG29Ap8X+K9HjEOQ9QHh+ITtzxsj31QDTQamP1ikwxnv60IB9rfGXOO369cvOAQ0Bzwygh1BGJhc7THQKImSV02Hqj0EyphuJAHykk4pBXlXcv640dzSoEkvTKzZ6b1cYCX6CcY1FFNTxjweYHNP0Ga1svs+pLDlIdHVVm6HLSZDVSBKz0y8UU+79FMvBs3Uqh9Kd/WgzzdJwNfeTDJWCSx8VsU85Mvv1UwGdZi2jJbYI3H2UFGfyxlnTousmCHkfP9toeNVkufvTJx0tjWuOzjYGz8Ax8CHNz3QmSTLeLs/oWB+V0exSvWY1atRnbILdVkGeEj+eksTu4W/PYf9WyCBFawlNsDPxVZS7VBu55qQmilge9N5S6RWNyanrqK//G+OxH6sjpqInWHqG7diOlTQBdJ7RuGegMjD4f3Dr7Pg4BV6Icx7dRyHjscL+8B8NFnXakIMkWMqQkbyN+sYf2b91mouVqVSJVzNkfQQfRdRCVp4iJ+g9kCgr6eDUlwGV5wlnHTZi4PVphNeIRcaIQKg+MuyBYOX7B/RA9Cw+etGWMCbNCVFMMLDWcKBwJYTs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eMnEWFxt0QvQObuVJxNrB6NOINXVgC5b35Q4lkbpVSkrDq8YgEPoK04Y3j8lLUGNVRKMRLdS3i+UlkFrX3QRqX+/jBBcut0WUUyfsRRRXPMfaWwZ3K4tDoj8E9H0E6nF+fy2CfkwOBqqgj1W3FPeER42thPsBf+SQR26aftIk7J+evr2lkj0rIeTkwVyb9uCvSSANT//jeArsqVk2q7F5au3GirhYeCIvGNOJgYJcSva9QAXEWohvJ6mkFTOju6PNf0CnmS+/4p97SADa3YBHPiB97PH6Kqu4r+5x52NESaNq97lPPO6NP4uijIFt6XYkaqLIjMbQ8FvAmj4WfTIhSdQRiXRX5jiRanc1hkWOJCpY+Mls1hWYzOHvn7FFb870XeCFC05JV/ao7SSTrS/DgNswrw8dtRbHclRWxGxWdaz6zNGvC0EWyr/01xsvSNC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 20:19:37.5668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c578ae4-871e-4e6e-6152-08deccadc135
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

On 6/16/2026 5:49 PM, Dave Jiang wrote:
> Flavien Solt reported lifetime issues with the CXL MCE notifier, which
> can lead to NULL dereferences and use-after-free in the MCE handler.
> The notifier was registered per memory device and stored in 'struct
> cxl_memdev_state', even though it only needs the region state (the
> region's SPA range and its extended linear cache size).
> 
> Instead of keeping the memory device and endpoint alive, the correct fix
> is to move the notifier into 'struct cxl_region' and register it from
> cxl_region_probe() as it should be a per-region notifier. Setup the
> registration to only happen for regions that have an extended linear
> cache as that is the only current usage.
> 
> Remove cxl_port_get_spa_cache_alias() as it is now dead code.
> 
> Reported-by: Flavien Solt <flavien@nus.edu.sg>
> Suggested-by: Dan Williams <djbw@kernel.org>
> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

One nit below, but looks good otherwise:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

[snip]

>  static int is_system_ram(struct resource *res, void *arg)
>  {
>  	struct cxl_region *cxlr = arg;
> @@ -4070,6 +4043,19 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * Regions fronted by an extended linear cache need the MCE notifier to
> +	 * offline the aliased page on a memory error.
> +	 */
> +	if (p->cache_size) {
> +		rc = devm_cxl_register_mce_notifier(&cxlr->dev,
> +						    &cxlr->mce_notifier);
> +		if (rc == -EOPNOTSUPP)
> +			dev_warn(&cxlr->dev, "CXL MCE unsupported\n");

I would demote this to an info() or dbg() print. A warning print here is a bit overkill
for essentially having a config option disabled that's largely dependent on the platform.

If you think a warn() is warranted, I'd change the message to say the config is disabled instead
so that the end user is pointed to why it's unsupported.

Thanks,
Ben
