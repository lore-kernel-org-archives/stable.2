Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05043341ABB;
	Wed, 26 Aug 2026 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746560; cv=fail; b=tVB5wsMDq4Ixu6dSK/pXeTsY5wEb7ciWiFdQpLxEpMcC++BG94lOdYPOq6f2EZxqYDHPYVHnqfqrQx37jP2v/QQHxrOzkilGJQs3HNJ/pHeI+7nmisaabQ0CTu6TFzH0yeC880sb34e1SpMrHiEvMy5uYHzlCuUQBfFUeVEEejw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746560; c=relaxed/simple;
	bh=3km3EylddsxBmI0RSNRfbz1LAlBLZQfP1VaxZAolh+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uhi/eZQCPbOQ41LHstK8QJ0+2MoY7rEGZ5sPlv2yiFM6hYdS/Zz7MXfXNeLDMe10lW6DfNrZpwAmRT5GxpeGS8uiOSHe4TAQwzpMAdjq6+k0s7B2xneila0qYLDQtTKU+yp1tOgcMakSl777w6+v8kerszKf2wUsteqvkeXmw/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yHfhiWjD; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yHfhiWjD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N881crfgF9ReADuBb9hXHpOC+wS/QRq42pBHGhIb/nCgG3DLJsqCuB3ASzDx0kEos0kfeEa4sVdoQzczG+Nekt3jCZajrCDcGnlSwbHeh+i1IwWSK6VSPD7YdEwvqRtSqlXcM3UHurF+jvwhxB6VzpC9oIiYirSa24Co1dFL7y364+GWB8NMeFmA812WuNcWlpCRwQKFPfnQqfISXA0dGFfZ3SbLCt+IUGN5AUnyIhaAPPNp7ZhkxBK0Z2fstv88YN1o+JBH+dHs/HJommA0FqrgHK5H5Hw9xHq+wx9ZQ2Zz6c1DBMVosfQdNy2BgCHe5KrElD8g7Z4opdfc1efzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kJd/zlLhBpy1gRjO8Wm5vFAnVXMlDsfpp/LdSWNHcc=;
 b=PWNak1c+ASMlBQTssHHh0NJ9N0oC4bYCen/v7J8ClqYrTA57+bLDCRvvH0tBe3+VDdR76LGuQ8FQudh7F/tm5Ogx5RG9sZtLst7rmaq4DUzjoKrnscd16S02X/3WizYoPpsuZKjY68mRzc90Q1WJO21Yd4RXDbFNYCrncZIq8qRJbzizeL+lNj4LdSkVSYLE9FOOF37n8ncQl0uhAWafiObFQxvqh2OSW93U5AfT4PhS/epUg8jtAn1lOOE3UmbhiLY8VF871SZWihbdhkMNHzTsO5axs20cawaw47s+EnEWkMrIEURaauU2qVXHJSN6UoXJZzl4oKkF5jjHVE6d6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kJd/zlLhBpy1gRjO8Wm5vFAnVXMlDsfpp/LdSWNHcc=;
 b=yHfhiWjDfhSHSBCD7UA4qUjRkVgfnIjFJRUpfOB09quM4X+7suYTOYTrrWI+mYjITp79yn9toeYsO19OlnXQpJ4S2IyWtF47PQZnNtL5iur/xpT69PrPkkXQdKQpCDVLl+cJ1hACNK5t554pge4vGW2HQHX3ZGZVawK0Z9Ep19o=
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 12:15:52 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::9e) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 12:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 12:15:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 07:15:50 -0500
Received: from [192.168.19.2] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 07:15:47 -0500
Message-ID: <e165a4d4-bb36-48be-b422-245ce52a997c@amd.com>
Date: Wed, 26 Aug 2026 08:15:49 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
To: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, Penny Zheng <penny.zheng@amd.com>,
	<stable@vger.kernel.org>
References: <20260825214805.39148-1-jason.andryuk@amd.com>
 <20260825214805.39148-2-jason.andryuk@amd.com>
 <20260826044518.GBao5vXvWQx9_a9RzF@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260826044518.GBao5vXvWQx9_a9RzF@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 8557457d-d9cc-4f6d-a1a2-08df036bc57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|56012099006|10067099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	k2uwNBuAvX0/eD4RBEjwoziDrLEQWoR7H9RrRdNSFPnlQe/xn5LNhiVYVUR32TuHyhhqeIt05UE6rLTQr1oQ5G0AwT9SX56/AuOzK9IN9w012Lxk9kFv4ASMOcisUC2qgQbi/noriHIHqyM6b7rlC07FTmydIdF6j8fkMWhLStMhf2EaSUL16OXe9yjYokMdWYuZeqiNvpXzetaOMnKsPm1y/Bdu01u/PuIwT1Sxz+7rlxxXAeksfQuOoVV6JD6LmHuezlc0zvD6go7rO1NX+WnkjE1niy9ouBB5bD9fmoSI7JjmCV+iZcl5BzVoGIDgtroBOZFrvsgZMiBPYQboJ+ku/Uf0fPYBsAH4ICloXKXvh7groURQRUU051EH6knLZvc/UzL7r7lI0bWnuRjDOL8XP0DVLGF+0cJaRMYKXTZGB4lYGc3CUZ7eWhwqXgI/bO+2l9pVZ71ijl7wYo9w8M3kZa5g68EeCs1x+2joTgR3A3fA95zX7WfM9ZwlyidfCYmaXDcQ1rRZ7haVcImGj1mp3kltAGxW50Ad0uPE9NePK0P43hl+LCb2NGL7c+WWpsB993SZDjXMIH8XmF4EKy5kp9dQKg/2lBimzXEavKFbHxiZf0NhgtlN2S22VLny8yoEgOCOM5uw7YvAlzqsWBxmoAxXhoN8jQSuSL27GEgDF2UGTFoXZHR90JVPvLdCNZC6SsAVgPkrAUzTCpphfA==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4FF2PPCzHck3mVP45dPJYY0mMbmv2rMS3+17RCRiyjgjQhZImw+cmxDNmVTHjKxJElOJ5+Y2SrGsXFprCPwyH4tKb014BU2PlzFrac8Rn46T+cRScSkP4paM7cTYkXggtjDo0tIq+Pf1YpnT1W7zdLV+EpdP6seRQOWaFiA5cqtY0PpayZ17n2D5rjU/7ohZa87zXERj4H4qYsEEEzjmFjvupVo8BMXGsAFckSSqOLPtOX1zOmMAIPQkg6Iab+eppno5ORWXFWBwzjITKoko9viw9JvAzT2TWWl6Dr9lHAnMrpQwVR+tNeE+00jAszufNZx7lhdp4okZjUyf1KXEl9r21/XXoLeLXv7V9qZFX/ht9twtJc/kXcgHqoI2rXd0kglpgETdvHroLf0E4cZ2QCE+75tEAWHDbMEjZmSugN0LomWsufN2Dga1qfVyjEpq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 12:15:51.7942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8557457d-d9cc-4f6d-a1a2-08df036bc57e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636

On 2026-08-26 00:45, Borislav Petkov wrote:
> On Tue, Aug 25, 2026 at 05:48:02PM -0400, Jason Andryuk wrote:
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
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
>> ---
>> v3:
>> Add newline to warning.
>> R-b: Yazen
>>
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
>> index 0be01725a2a4..408b9fd48349 100644
>> --- a/arch/x86/kernel/amd_node.c
>> +++ b/arch/x86/kernel/amd_node.c
>> @@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
>>   		return -ENOMEM;
>>   
>>   	roots_per_node = num_roots / num_nodes;
> 
> Hold on - the only way this is fixing something on Xen - and you say that
> roots_per_node becomes 0 - which means that num_roots is 0.
> 
> But a couple of lines above, we have
> 
>          if (!num_roots)
>                  return -ENODEV;
> 
> So we would've exited already.
> 
> num_nodes can't be 0 because you'd explode even with this patch.
> 
> What am I missing?
num_roots is 1, but num_nodes is 2.  Integer division gives 0 for 
roots_per_node.

Regards,
Jason
