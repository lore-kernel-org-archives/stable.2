Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB63D093A;
	Fri, 14 Aug 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714681; cv=fail; b=PjQ8lXAPNj5gcqBwxhWjeJy8YGursnFePFsezhpYGUypLLqEkjXJo/kENk0q2+iBpBnZGBCNTMorQTC8PJ9WPEev4AiLyuxZIftPzj1eaHKq1ErQEUDEi7f7Y9b3WlSE5rd4K+SvzUx2xniO/JbgHhjnqt9/xTO0l/I7DdCRYoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714681; c=relaxed/simple;
	bh=yx+ndDWeRlkIbMHfJI7fKdOqjzC0lxRWpZs5za9MBdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qj6JwdUtlAgMKPQPW3oWrTjIrCh/hbNjJ/OepfiWFjZjfe1Q/QgZ4IIEtc4NyXWOPiQ13/mNadkROZ/FNdx41s+JmV7fwQs4KUH4GfAbCh8maYTcmYRStd++3BOhd6cuNlU+kfFLK7JiH2JgIOqeM6IkUDeVm2B2Dwuxeh6ELhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RCoDov+J; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RCoDov+J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOZON97P84aTJHeBRw021vtwJmYfkZT967q+9lhI5n5xSPduvNc6ViOREh4XL6bWIHHCNXPdE0z7TER4UJl0APCPX+gigS0cDMt0vMhaZmPuSEbiIuC+NGlHrDBfahsLUc257NsCRDlKfXyW1bfljtsylqRb/bplhsgMIHbZi4CXCp0Urm6H1U/7EoAIVNcCeBYnWQ7BE4IB8THSq92IUT0w+bnLQ+L7aV+pOJHAQbOC1pjFbUWji1YmdkAH76ByD9sWhX+JKyKsDe7cFzdAOH/JvhR0CDF0Ptp7TX8ZEZw+6lclvA1OS9ed12WbbMHM/GT6OW6lT8bZALSRD7qkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gFywjOh4yfcKsJ4bq3xLsBWvowRMNq80BXzDSaZPEE=;
 b=dHuEXvpj6eATf3XdXz596mHXj2npnx2NsSSGh4hhwSrOQ13nNdwOm9hWGhj23QzbOlUZIOmy1Ic90OgBZglSaffWpgQ/RaNWSD0hPsOc8p6iGIi/6x4YHAxTC0pcTmA0x/jdaxQBRY4Ki9j+Lny4NmVPDPdWNQXsP7uZ5DChus+cK2l8TEucCN8dFjex2A1x4EYOdzU6/5b4WBG2Ww76B4WDUDYSgIGkm2u77COAyxRqZdK175Y3IHGHeeTMW3bq6ZUBmom3fZGYYB7KInVb1VjLMtjVZ+Bbbp0Hvf04DkoQ6M1Jh/0F9Ursxmi1ZTOxW+4JQAo3w3n4qNKmbvdSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gFywjOh4yfcKsJ4bq3xLsBWvowRMNq80BXzDSaZPEE=;
 b=RCoDov+JQfYaBL9cFZ2S0GPn+LsXXTzafDqA4auMQkjpvsK0jJqxwo0Jn9RXFN94ZaKQT58F+KxPpor7yyHsFsIuGnl+T92ukkppcVtuqev0lU0SkJH9NXmYb9i8GVuZb1zBfUVc+aYtuKOK7etxXjK5+d3Hb4bCdAQnM61Fxdo=
Received: from SJ0PR03CA0143.namprd03.prod.outlook.com (2603:10b6:a03:33c::28)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 13:37:48 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5a) by SJ0PR03CA0143.outlook.office365.com
 (2603:10b6:a03:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 13:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Fri, 14 Aug 2026 13:37:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 08:37:47 -0500
Received: from [172.20.244.139] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 08:37:46 -0500
Message-ID: <95307ce5-e209-4df9-aba4-5fcb668533c0@amd.com>
Date: Fri, 14 Aug 2026 09:37:45 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/amd_node: Remove smn_exclusive
To: Borislav Petkov <bp@alien8.de>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, Mario Limonciello <mario.limonciello@amd.com>, "Thomas
 Gleixner" <tglx@kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Penny Zheng <penny.zheng@amd.com>,
	<stable@vger.kernel.org>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-2-jason.andryuk@amd.com>
 <20260810140747.GB57095@yaz-khff2.amd.com>
 <20260812192805.GBanzJRTgkrti3Bm7F@fat_crate.local>
 <a57bdf5f-c9a5-4417-9d8b-d84cd29238b4@amd.com>
 <20260813235800.GAan5aCCfimjHRUV1O@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260813235800.GAan5aCCfimjHRUV1O@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 40157efb-ce3a-4e2b-5e7c-08defa093a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PsnFM3WnInDNx++XbBtjWX0L7wOyboi3m06JAId0hbT0/tUGHAmsgcfG25vaXKwTOARgotGQ/EoiZ+4bB9efahX/Y7kBvjquxRbZLewrMO/ZMLQAcNe871IrBEittzX+oMdILvAhfFdw1iVflBzkFueJZKRVpNjeZOO1p9s7DsRjdzdZZH+TpY/StHOayl/B6INYB0TjqXV+ECReZ9WHLV65QCSqH7qnHzRP7yOtiM2fUZCaetKDOQH910GpgscXVrzhVjScYESsifYd9NuuEBQTX3Jm4LYKNNfeR81FA93Vx9Ozx8BFRIAWmN7X7jadWUNAJEcrluyRJmKXaNKpnwZetpd0IK2ys7k9IzXTliXY5CEkPrt1OQGRgcQwq225QlqRi0FqniYO8UMbOH9yod/2V7Z86Pjv6wX6ELSuJCiyipAWghn4GPr3lcg4KS63MavaoeD/Yoebz8H4HOUOzq5G1cBhy5Gn2KQtGrU3PsOnfPtnn0DtrGmniSGxZUXNuMB28Pe/ZP1ZUxNf8IZ0klhtXdUaklNmrxczjq2Iux7zq77QXe1+7kqxxuL9zDv3cigKTZuL+SOx97Js5BI6GPMiv6SDwhVBrlh0S9Z/Ha7/ntJMTfhU1ZrqZ6AP972jcA69a6oWUYbo7JkC07IGmtgeBc7SswbywhfbFLbAF0eNe8XYpxqvdNHJ8j0GfARGOpnK8J0uow0/JxNitwfBAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2f2iowU7Gp0SL183oRUkeU3i4LGfBw8QTABiimYZDwwVVV203VdNdaf9Hr4otzUKI8rK8+1vdhb38NbIt0EYi+uCmYJYWfwSX5ESSZE+6ioct8MrCCXJ0FA8cPWSjIiktifZDMk5QLowacmdgCNcCWYuo6nsgoY/Kn6bXyi3YaZmHRKrmd9fmM13cxRtoT/7HjnQ3T2iQoplHDHWLlBFL1jiNOdHGy6qPghZ04xToSIAgzs53zAqWHLvD31088Dw/6Ut2//Pa3o1lBT68c/tG4QKzttupv30v0JHyh0H/hW4z6Ekpnx9lA7r0hJTO81Yc/y+4RAPd6U7aGfkZDFv195364TFqWXMPjm69moeCj//pSO9PlG9jBz3YCAEH699RH6S9wdco6Wp1872M45OK7ZNoRw3uEwuOgcbMUksvoPa2UBkDeQa1GTGsSPbgCiw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:37:47.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40157efb-ce3a-4e2b-5e7c-08defa093a88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661

On 2026-08-13 19:58, Borislav Petkov wrote:
> On Thu, Aug 13, 2026 at 09:40:33AM -0400, Jason Andryuk wrote:
>> On 2026-08-12 15:28, Borislav Petkov wrote:
>>> On Mon, Aug 10, 2026 at 10:07:47AM -0400, Yazen Ghannam wrote:
>>>> 'smn_exclusive' wasn't originally intended to be used for bounds
>>>> checking the array. But the original use is no longer needed, so it can
>>>> be removed.
>>>
>>> Why is it no longer needed? Apparently I didn't get that memo yet...
>>>
>>> 83518453074d ("x86/amd_node: Add SMN offsets to exclusive region access") is
>>> talking about the potential concurrent access. Why is that ok now all of
>>> a sudden?
>> 83518453074d set smn_exclusive after successfully calling
>> pci_request_config_region_exclusive().  smn_exclusive gated access in
>> __amd_smn_rw().
>>
>> Things moved around, and now pci_request_config_region_exclusive() is called
>> earlier.  At the end of amd_smn_init(), either amd_roots == NULL and
>> smn_exclusive == false or amd_roots != NULL and smn_exclusive == true.
>> smn_exclusive is redundant, and amd_roots can just be used directly.
> 
> So you want to use amd_roots to *also* *denote* whether exclusive SMN access
> is enabled. Then you need to at least put a comment in __amd_smn_rw() where
> you're testing it, what exactly that test means.

I'm not sure adding a comment is helpful.  smn_exclusive lost its 
usefulness between its introduction and now.

> Then, your patch has a Fixes: tag and CC:stable which means, it needs to go to
> all kernels but then I don't know what you're fixing.

In my original commit message I stated this removes a potential NULL deref:
"""
amd_smn_read/write() are exported functions around __amd_smn_rw(), so
they are always available even if amd_smn_init() fails.  smn_exclusive
would prevent access __amd_smn_rw(), but it is placed too late.  If
amd_smn_init() failed, amd_roots is NULL and __amd_smn_rw() will fault
over it.  Replace smn_exclusive with directly checking amd_roots to
avoid the NULL pointer deref - writeerence.
"""

I will add something about how smn_exclusive became redundant.

> Looking at it more, you're basically fixing one more aspect of running the
> kernel as a Xen guest and it not having AMD roots exported.

If amd_smn_init() fails for any reason, __amd_smn_rw() will fault.  It 
was seen with Xen, but it is not a property of running on Xen.

> But what you really wanna do, IMNSVHO, you want to make your patch 2 be patch
> 1 and it can go to stable.
> 
> Your patch 1 then becomes a simplification/cleanup patch which goes as patch
> 2 and doesn't need to be Cc:stable but it can be queued later, during the
> normal cycle.
Re-ordering is fine.  With the divide by zero fix, then amd_smn_init() 
succeeds in my test with Xen.  So the other patch isn't needed in that 
case, but it looked like a worthwhile fix.  In the cover letter, I noted 
accesses from amd_pmf_probe(), amd_pmc_probe(), and 
acp_acp70_audio_probe() to __amd_smn_rw() on my test system.  These are 
called even if amd_smn_init() fails.

Regards,
Jason
