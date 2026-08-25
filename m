Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA738B7DC;
	Tue, 25 Aug 2026 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667064; cv=fail; b=BhyEpLgtFAWHaj7Cb6AeHJ8UavYMfx6sBQwyFPaZ8F/ta5xqJhmvKWtUb8+uUaJc8m0yGiSgFJST4CL1prPvrTcOp11Z6pZ5+EtDi3CeOi43MLyoaghFqgQFWlFx316gLamcthsTe5uRjGwxpm2G6UAo9tviGhcKM5jy1YtPZEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667064; c=relaxed/simple;
	bh=EKH1eQEM3+8kJrMDRXhUZnxpHCi1qGr3QaY/ePw8GDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HPVbtT+H/MRZiXuztct8K8dAjgqF6NbaVWaTKecWzW/vjPhn/NmkhkcH9fkjw58N550+RJtzVn7ABbnMHoOORY9YhiyH2i6qx29wZavXVrI56T1o0fvDjo8IAkv8Ty1Qe4VR6Vuvqn0koHHWjzFRkB2L8xbKDjvX0Y0IcjCK7sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rF3jNWKm; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rF3jNWKm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkOMsDzveDPQfeouJEJCbiR+yxeSErVdsCdfYNBcyGXdcNxUcnbG6kbyDsnS9ClwGdQVE1jHaZ3gTb2J5Xq9Vm6O3TUIpobYIISylEZDs4mrYL9Mqf/gWFcTvfWjrDzv56Ckr0UdSiJMNFRCOlnXlZBs+ZF8nWO9E7AJ+ZjbKfLD1Za3Vo4/WgFOiDuxo/VtFFlqjC8c8PPqaxDIl74A1COiN9cgF+yZHSkGq0D0lqYFgqX7QDAin+wfpMrBFa7wuq0svHBO+YwFxXBQf5KdqpzQQcW8fqz6aFclTDTPhUr4J3/y/5C+Z/1fMEjmohpymIsG1XBBoEfLh1uiGEL0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+C6IcR7gMLezFerK+kLfDTZTQduroLvrP7+Csf97/Q=;
 b=YG6DZMpjJhSzf5z7PIVLpWFEIswJFItSp70jN959j1giRUTCn+aIy9VnoqLqLy7lvrjrwcO7HPt/6JJdCphmLqR8tigusJplt3l3C/wr7eFndrGToc7FQYWBF9Yur3pBP5ULmrOv5gV2KZKsK7N/WCdbc5Ua3qeBA2kqUdc5JwWI3MN2COFeW2RvGAzbt0UsUSqVLoX8oN9+PpnuXHps/MsjGVlE42BQsQLSc6emBlqyH1wWmMKR4hrxzkxe8nhJWyWiEW8h81PErTXNRFbOeS/9yF65Degak1zaLzjMt1HiRyHJEe0ElyJDkH6sPiqRNkCksyPiesWMhs3L63gh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+C6IcR7gMLezFerK+kLfDTZTQduroLvrP7+Csf97/Q=;
 b=rF3jNWKm0+LxhOyUHXVlj2rD5RXfDJ+6+H1ohmAIkeadA5dYKsaJshQ7ZWzDDEj24nCO5sb3if7MuBWqMG0KCwj+DRvB/W6mdIewayZSfH8ezQiIoCVzWa6bnPD7gLJoockecksbC2PgFZBtTstSWaU7jerc3WV2qt+ootuMIXA=
Received: from BL1PR13CA0403.namprd13.prod.outlook.com (2603:10b6:208:2c2::18)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 14:10:54 +0000
Received: from BN3PEPF00022BDA.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::45) by BL1PR13CA0403.outlook.office365.com
 (2603:10b6:208:2c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 14:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BDA.mail.protection.outlook.com (10.167.248.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 14:10:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 09:10:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 09:10:52 -0500
Received: from [192.168.19.2] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 09:10:49 -0500
Message-ID: <4b253fa1-1d2e-49e4-9d1a-ea4ff81d4486@amd.com>
Date: Tue, 25 Aug 2026 10:10:48 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
To: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, Penny Zheng <penny.zheng@amd.com>,
	<stable@vger.kernel.org>
References: <20260814214255.83127-1-jason.andryuk@amd.com>
 <20260814214255.83127-2-jason.andryuk@amd.com>
 <20260825040039.GAao0TZ6b8j0kp2RKk@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260825040039.GAao0TZ6b8j0kp2RKk@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDA:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 318eba26-517d-439e-c1fa-08df02b2ad0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|10067099003|3023799007|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	KjIhliTh3Yvgh47rdgkzVuj/nXVMIwUCXhPc5UBr0nWWIw903V18NUS/uFHUHouIr29RnJQjGEw0UbzjSp0lLkF9Zml3i7yCMiMhVIzUB7tYgjUS65zE7ZJwyqqvJooEMQmzcKgPNEUrS2nh/a2nixspBHwhJTitHBqfYQblLT9E4sZ8aq/DqWPQa629yyLgC21m8nSUywpU42kfh5bMFnhzry112J0g0P7Nop/65bgNFi2k+vUWyfNKvRj4dxPfRENS5ru+TQy+S7R4KEL5eIOYZNB2iMeR4QMbMKqK+mUDbgf4nVs5FENucqeDjm1e49VOmlc84E1qXqBFbk8DDe2gAntAPqcfUzHaDxDxeLBuFmdpiXaT2Pt9gAg6b/RVY41094PhsWTvgNdAEQti62DOluJKZ5luZYzyoAJrLam+kaUOWxT294OEaD58kqopOEUsFo1hlK73H9fQ5NuZIj0KpxtMbrCLwKL+Wv4HDEG/l7bRVICe9K12L+wBxVSb86qc/X5R1266zdG1pqHpNoBSneIjUB4vedmjWOdHjb9cbTNxGrBjyXonQ0/l6hDT/25AAxAMgq4z0yYJU0WmTdC2IMGONjqyZKaIfKm71hrmzG/Dr59pOgP78NU9LZcWP0kbhPyCyVcpcZahCSdcow==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jU648oDu4BHR8qOE+rzQFLZMw/N0BmOrbf2Vwyl/Df0UquTC22b4rMPDIH0tI7j8SObiacRmVDFl1eND88qTH0SCZzdLulIz3XpYg9D94fmSJMmUMm7eO8gzrtk8A5kvQvLZ4Z1MBWuGlBRZlOsWj3Yu9uL0PTdTq1sNeS8C7s6bFTEUlFl1FD0ZBwbVm6/nbkx/ZaO7H2LgRH+FZOd/nh+BJwq2Jr9gIGW85VNy3IpZ62zCAC2SiJYu6jQzMhrHL7k6QmCVz3y3+Yq4R1M1YbDUcaWP5gJZ37GGSTL6tG5tAC/3wPAXY1bN1WdrWWTCXwATpz8ZUoY02AhbNEhwuVpy7PzYGFCQWPQCI7R1Awe6UrZZBS3ppidwtWA5AJse+iyX13xcInX10+qpk01oTrZqYqTJ6Affo55s8TtXdKFYN1/lWrHY0+S/o1HbaTZG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:10:53.8837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318eba26-517d-439e-c1fa-08df02b2ad0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BDA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

On 2026-08-25 00:00, Borislav Petkov wrote:
> On Fri, Aug 14, 2026 at 05:42:52PM -0400, Jason Andryuk wrote:
>> On a virtualized system, the number of nodes does not have a
>> relationship to the number of roots.  A Xen PVH dom0 can calculate
>> roots_per_node as 0, which crashes with a divide by zero in:
>>
>>      if (count++ % roots_per_node)
>>
>> The issue is seen with Xen, but it could affect other systems.
>>
>> Change roots_per_node == 0 to 1 to allow the system to boot.  Print a
>> warning when this is performed for non-virtualized systems.
>>
>> Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
>> ---
>> v2:
>> Print as a warning instead of error
>> Use "!" instead of "== 0".
>>
>> X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
>> ---
>>   arch/x86/kernel/amd_node.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
>> index 0be01725a2a4..c3e214925d9c 100644
>> --- a/arch/x86/kernel/amd_node.c
>> +++ b/arch/x86/kernel/amd_node.c
>> @@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
>>   		return -ENOMEM;
>>   
>>   	roots_per_node = num_roots / num_nodes;
>> +	if (!roots_per_node) {
>> +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
>> +			pr_warn(FW_BUG "Error detecting roots per node.");
>> +		roots_per_node = 1;
>> +	}
>>   
>>   	count = 0;
>>   	node = 0;
>> -- 
> 
> https://sashiko.dev/#/patchset/20260814214255.83127-1-jason.andryuk%40amd.com
> 
> And this one specifically (the other two are being addressed):
> 
> "Are we missing a newline character at the end of this warning message?
> Without a trailing \n in the format string, subsequent kernel messages might
> be appended to the same line, resulting in malformed dmesg output."

Yes, thanks.  I'll fix.

Regards,
Jason
