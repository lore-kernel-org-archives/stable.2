Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF822A4F1;
	Mon, 10 Aug 2026 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392986; cv=fail; b=OGmcT6J2HpddCJZFPv4vJsN2iUroJ2ErVJJCxfoJ37JrQ5z94TX1tIXjN7bwouMo2SwBTmvTcEN0vamWKJRShe8zNXahMrZj/NDkfqkZ0UOFpzMUcm7jjgK9a9Ac/E/6LkuzQe6CdwjmrMyYfdKsML82X/JesogM0mENSE/akHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392986; c=relaxed/simple;
	bh=ROoEaEUtCBsAGsqVBmcdFajmEXFAVG7XoTGviEe+AnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dqmm0aBFwEpSUer6GnZHLuWv3YjspjbjrDU0/ZjC27sGsTT3PgEBsBZlDfEzHiKgG/NqeYHW/uc7pzqho0ECP03VFenlqehqNaTWRQp5Kxg0i4haFR46gCH3bowZwh5tDn+WAK4aOxLCCsI54/NW0yCt2EDw7J8AzuttDIJotTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2JSltzFe; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2JSltzFe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz3CaJbBmFyYSS7TMuL/yXCU39hJNB7+k6eSdmS6Wt1otiN2HPBMJd4qq0sbTEs3Du8VoD2wk5ntjHZIbnZGqF7kNiVz5uixzxCKy06qY9Wa9CykGlF0Xe7g5INFwcVjZVOcbwLgcVQhsBj0w2LU1VRlT33fg/IjKOpZcKuqeNJIbkhY+SrigQ7pIc3cQagTYcd+xRSXjP7Kv6LS/wseTt/DYYhFbAG4aLdoed4MYIPhwLtlYj8W6ygq90cMn3ZOF2KTrD/oNfPMyD7v5pkAAdibbBdF304Wxu9vHVSskndiPhTT6ychFyyUxPoH+l7l1k7/pTVuqyCaiaeW2j7tnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcVdT4b+1uhoo+rC+cZ0LBlibcdm+jCrmC09LjhnB1M=;
 b=PD3/0xKiMu22+4aKxO9P9hubG5CnF3YoTj2CJ+AddCRBoABdWA/QvJG2mrHOIjLPwieVry2zYrYessViVwUf5m0ReuHsb2tvckWYjR0uw1XpkbW2iWlLMK4H6OkeEn6llvkILV0rTbupnS+o+z9qh4vlvBD2JfIpiJBHPaXW0qyWp6raQQ8HkAHKAfx+Uf1fDiANh+ky9u+FTT3dy//9iN4S+4LVYCc7hlpircaWnV/Wibutoh6xCtCpVlfcP20N3vs7K2MazwjWuevKbRSGECFPNytXWMhjtF0/jYleBGQ2qFnIIgoUarmtDLqBYE8PQElfjtoF8St+EgVHY4+c1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcVdT4b+1uhoo+rC+cZ0LBlibcdm+jCrmC09LjhnB1M=;
 b=2JSltzFefyiuU5UkLp+XjecNMyEaVD/SxeqMsNLMQUiHVR+JP2Vo8HS02FUberKS2a84YulHZyLwtSQsrmSS5Z0CJGMWnJA9s1mSQkMkSdVm01EHuBkJn0ZfRmAHEFl+NJDsBAB3Vihap6jyCkZOJ7pOpdxV8GIjhnmh4zKncIk=
Received: from SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 20:16:20 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::50) by SN7PR04CA0165.outlook.office365.com
 (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 20:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 20:16:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 15:16:19 -0500
Received: from [172.20.244.139] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 15:16:18 -0500
Message-ID: <06ee9889-6b88-4016-a323-7081693ef86a@amd.com>
Date: Mon, 10 Aug 2026 16:16:13 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, Penny Zheng
	<penny.zheng@amd.com>, <stable@vger.kernel.org>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-3-jason.andryuk@amd.com>
 <20260810144706.GC57095@yaz-khff2.amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260810144706.GC57095@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e1f8f2-192a-4038-c32c-08def71c3da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|4143699003|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	f92V8dhIwkC0JUdjNcHosoYNE8xu1iTlkjNEfHAqlrAxWaqcILYOQzikI4tkloubB/CAJ8RWOkDJcGrcoSM0mkfl2/juOGEHdgQuvdQZA9zu/BDstWSMU7eGZQWUn/PVI1bhuZvZMuyFM4xlPH34Hv4zQSmcbkVhuBHjfywGLnKpSoB2wKBBoFSYWEuQHUW2/agmvLGaSCIGjkaWe8I294zDFOht+/jgSKdpLxTH0dFDkqYH4a4XRi5zxlTy4nBfHSn2E1bFxfOzar7ShH7QipRRcMIaS5MI0unc1M4yn5xvtZGtfVvQ9Ay/ntNvKjLWHhyPLr4Qv6wKZbgwWagOhzVm5JVCpuCdpTrLFYyaTTGw3oTg2fjingA8uCcAKmtL4HI+KTOH3qP5Mr2fdBy0Xi7EptJOCLERHkGxgJ86I2+P6DZ/bzH3FAOjq0OGB0Bd+aEUGpja/ryge91iTPgsTQWHnVxAce5ja2BUYdlwFvo9yvmExuJ2+Y646syD0WIjxDF5nKoKHO60ARJUge5efa4cI4UETtX0AtxLIAMfSzVcSPtsZ2XkikQ/h4vPKSsKxjiXR/AjbWENEkKWB9s94bG5SXSHfhuRDjkY14TwPf1jdxiSaHxEr1x5rXJwosKQIL6urDNyvPJs/b8/AFo1R+U326Nc7BCn4nzG5+YEXGclDjy+9K8l4L3I75TMDEUuYOBglQ+1ZK2LjU1BdA6mLA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YyNO0JLFWCWAgSynZdm0F8gkY+9mIms0IMMO/GytdNdV6WYm0ai5rFw8heFhEc0GIfvj1CzY4UJN0hRji7/U5Wti9M996XXASKHoTlidvcxuWcPB/u1VIA1oqMheZqfRx64ZV+rAPvHb5SFPlnOTGcVJrZXpZqjuWgnzHX1p4KJQi75hkbV+X3l+GOJpdN87qKv8KycNpFHFboqzt3QOBgLXeNHCY5oUPh+11f0Li3+nDRszpWJKqawAnHWSa/KqiHFABTtHjfubRG5jPydJ7NIGezzYK3BsH9rKQXOMfa/SzR4c8tP8OW2mP+yXN8905bjaoS7IA+T8JnnGSZ1oN+Wch2NnkQMi+lEk8DpKBk/3ck5p5aZQ7GYZETUFoyBXkNBwl+2rmrW0nB7zi+R9wP9VbK9PPrim1CB4ZXDpgfCDzHbk0TRy0R4XwqbzC9i2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 20:16:19.8205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e1f8f2-192a-4038-c32c-08def71c3da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684

On 2026-08-10 10:47, Yazen Ghannam wrote:
> On Thu, Aug 06, 2026 at 12:01:57PM -0400, Jason Andryuk wrote:
>> On a virtualized system, the number of nodes does not have a
>> relationship to the number of roots.  A Xen PVH dom0 can calculate
>> roots_per_node as 0, which crashes with a divide by zero in:
>>
>>      if (count++ % roots_per_node)
>>
>> On a virtualized system, default the value to 1.  The issue is seen with
>> Xen, but it could affect other systems.
>>
>> Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> 
> I agree with the idea with some minor feedback below.
> 
>> ---
>> X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
>> ---
>>   arch/x86/kernel/amd_node.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
>> index ea553267e5fa..c5025e5291b6 100644
>> --- a/arch/x86/kernel/amd_node.c
>> +++ b/arch/x86/kernel/amd_node.c
>> @@ -286,6 +286,11 @@ static int __init amd_smn_init(void)
>>   		return -ENOMEM;
>>   
>>   	roots_per_node = num_roots / num_nodes;
>> +	if (roots_per_node == 0) {
> 
> Can be '!roots_per_node'.

Sure.
>> +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
>> +			pr_err(FW_BUG "Error detecting roots per node.\n");
>> +		roots_per_node = 1;
>> +	}
> 
> I don't think this is necessarily a Firmware bug.
> 
> Likewise, it can be a 'warning' rather than 'error'. I interpret 'error'
> as something known to be incorrect. This was my position before on this
> topic. But the various contrary reports changed my mind (even if they
> come from virtualization).
> 
> Furthermore, I think 'warning' is more appropriate. It says "We found
> something unexpected. We're letting you (the user) know about it. And
> we'll mitigate it to avoid an error."

Makes sense to me.  Boris suggested error in 
https://lore.kernel.org/lkml/20260624192530.GGajwvKuhxbnHe0s42@fat_crate.local/

(I probably should have used Suggested-by.)

> Anyways, I just wanted to write out some thoughts since this topic has
> come up a few times.
> 
> Possible rework for the above change:
> 
> 	if (!roots_per_node && !cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
> 		pr_warn("Expected at least 1 root per AMD node.\n");
> 
> 	roots_per_node = max(roots_per_node, 1);
> 
> In any case, we should just go with a simple fix for the virt cases.

I'm okay with this.  I'll wait to see if anyone chimes in further.  If 
not, I'll go with your approach and Suggested-by.

Thanks,
Jason
