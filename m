Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1253D9DB1;
	Wed, 24 Jun 2026 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315823; cv=fail; b=MxSwIwkN6zkLM8HdwP5+o8XjFdQcGWEVGJMBcmaz4DpQz3ArzV94HK1tJewLa+LZqMhhD9mM0wGLTOjLHYcOnm43TDCvnh0ghH3NDZwDAiXWXnjbPHZkPc+CcynPLyDiqoQRALLD1w8zoNT65+eyg2xfoZEkWl/G/zJ3gluy3lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315823; c=relaxed/simple;
	bh=N+F3BsEDgTMXKarFSOk8IMiVYBKC9W/6OX1WFkYllcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CY+etkXGBz3xW9XyzVnxPxRYaOETxwmmY1MQB7cahMZ6bXiASJmXfH1hH8KkUtrOtmVzbEyArHX9a2VYTv1LJKAn9W6cSam6cw6wuOyawa5XS69NEjph064Xh9TSHyrYlH7xGzkJ6K4TI1ywOaOb5svzbUt6rxiOVW/BQKkoqDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3uwwx75q; arc=fail smtp.client-ip=40.107.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3uwwx75q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQHcBIsmiRebfWfix3/Pt1/8KyeqBT2aVohPS7WedELB0CEzWvAmWlFDqDhUm5N4/IBZ0AvEHKG5Pjo1APXM0TqxDdE8aixSMjtEpLZJ6jUU/IVsnxB+HLraPSFiSWe/hNC6+mWp364O4R+NsOtOoAavNIBAI3CNjGO2HLyVjWiNezoXsahL0N51rHNT3HQjxtXyB6fn6WEcF9oxLImwJhEJ8pLLbrFP2NB6Qew9UVSnAnMt+2TGcEzm4FaGdbrxfHBVDtHjuvY/z8ElKAI+TL1abF6eZgX/Kil92wU9njKfUQPawwELvMkDZK+01GnXoA6Bd4LMbTy+3CAZXittlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjkKOZS2bN6hOF0zG6HMPMd7xo1sFuo6IRFCKOBxfUw=;
 b=wlHsHjBmBjpAsniMUY72dezRixYiZzEuAm3n2bzZ/oadXjUOhDsAkf8bMTCTNoXhYKUWMl6NJyYS0YOZlTqqhny5h/ZBlY6yxfgKxen0UXT8eYBi2Kq5vGulkWnaAb6yf11gKZe/5LZvzEUhJMooArtuoutORJr4m47gTDz/ej8DNabZ/9jp6K/VzxFPYf3//MmDjxNfsvHn/DvP2y9RzOC4VaeySmjUnSOA44NrrL1ir0gGJzlhmKpG7I4TggUzsLWqhwFiFX8E69ekCc68d8g/pWngkrFVan1v94Jnxidm5Tw1nwY/1af2oUNw/QJ9MmNgDEYIVMCqBYnUqYX93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjkKOZS2bN6hOF0zG6HMPMd7xo1sFuo6IRFCKOBxfUw=;
 b=3uwwx75q97B9/QU1uyCbYz56mu6vfKLB8j4BbmXUmQewFwiYL/e8JsGepKdeKSIKGef4Vrgb0T0LKfUkc9fEfKR/ot8PslPj9ITXSu9WTgfK4IPOXSFrFFAwUOtzVqrPK4SIxAdI/DprwPTiRERKrTXsPUIFSvHURuW/lL0nzMM=
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 15:43:33 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::63) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 15:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 15:43:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 10:43:32 -0500
Received: from [172.29.28.188] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 24 Jun 2026 10:43:31 -0500
Message-ID: <48629f88-4b78-424e-a199-d87594c8cb40@amd.com>
Date: Wed, 24 Jun 2026 11:41:16 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
To: Borislav Petkov <bp@alien8.de>
CC: Mario Limonciello <mario.limonciello@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Penny Zheng
	<penny.zheng@amd.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
 <20260623213552.GAajr8ONjXFUnuUOE3@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260623213552.GAajr8ONjXFUnuUOE3@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6462ae25-73c5-4545-768a-08ded20758ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|13003099007|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	8vAXleDk8H6JkgnyEOcYQXwyGFSP76QzxXUUCV6G7MsjhAHDaimTXyJc19F+7pyHOniyWO+kmYPU5VEd9xBZynEQif/FTQO/JT/IBESLpze0IF/YXNDuPKPRB8k0Y2cwI12aey6QWmRjU8KWEVWsCIuoppZOb1NmCt1d0wilLn0e6+mCLefNMLJASRDR5fpJoGfa45J9Jul+JpB9O+MPaausON1WM3aFXFb2GRuJNv3iE1ZUWTE0g+2f6WDMJMDKncgRnM8OyeWvNsyvdKDppzBvHv6LAbKm04Xl8QDTbQSGqj3adsCkpWUr4wqUhGfZJc4MkKBxocMWeNvu5n2TwdsXNDQD16V86fsspz3+yEGw0YDTjSQk0QL8Vc4vKiYuL8SEhskApcScMpJid/5xWeJyi3qerRClmrACspHNCqHYoK2pzwIsW5pobbTbadvXSMQNrcyZWwRckUNQSbLTY7H0p9jq06hf0If3m0I6pC+OZs1YIBufclcqgXLEcgrkF6DbdlLGwYe7kLBBPoAMinNLxsmyl+gUkwb9UmHYfW1N/Z40eUwjo1aY8VXMXcdIs/Xat0ifEGWdBn7DvWePrBWII3W6IsSOeRq3NhHbQD3xYtQF7EabKXvdSS9liUcc3Mj370qhe/FVPaBK/cQUabYsTi3hQsor6N4bFouWsXoXMzECQ8z8BjzUeO3zRp7SyNgiaeHrdND3BoEg3OyD+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iiNoI5z4rZHP6x0U7XF/lEjsI44H29fE4qvKRFPaNlEdpK1eA6M8ZzoANRE/qaonnCmjH0idkr433se/ROM8F4YfnQ9VMtBy2+cLPboy75vwQ0nvZyyUQiAVNGTIoz9NZsCuMvscWHBVSckr2QnkE9uUB7VB57bfrhSrJc/Y4hnhq4focbH5HmZOm6OBUms0DG7UyBqXG0LkKwWxTg1LqXIqx3RQDQNyH3XDjfbl5SZfygpThm0K8yL1omGN2g5nZyshjmRWi5bkDqEhpeQdB5ukJfJIdxcAj59tv3fHgji1Oob7+/TdX5s5A6R0k/G4Q9Uu7uFJVIWvk3ZKpgYjuC2qIJ7FxwVwqbgj085L6HowT2ZgQUU0AAdx4bhS+6dwymIfpQ4nSK8KHpJfr2+E9RoNl/KGzvOpdEnRIhROXBJX7YI/+NGxSNNkwMi9hLyF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:43:32.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6462ae25-73c5-4545-768a-08ded20758ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326

On 2026-06-23 17:35, Borislav Petkov wrote:
> On Tue, Jun 23, 2026 at 05:19:03PM -0400, Jason Andryuk wrote:
>> Xen synthesizes the CPU topology, so the num_nodes and num_roots values
>> may be surprising for amd_smn_init().  Specifically:
>>
>>      roots_per_node = num_roots / num_nodes;
>>
>> may results in roots_per_node == 0 which leads to divide by zero in
>>
>>      count % roots_per_node
>>
>> As an example, I have a system with a Xen PVH dom0 that reports:
>> Found 1 AMD root devices
>> Found 2 AMD nodes
>>
>> Ensure roots_per_node is at least 1 to avoid the divide by zero errors.
>> num_nodes are allocated for amd_roots, so roots_per_node = 1 will
>> populate all the entries.
>>
>> Also add a pr_debug() for the number of nodes.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
>> ---
>> This is an alternative to
>> https://lore.kernel.org/xen-devel/20260506055528.476493-2-penny.zheng@amd.com/
>> but it leaves smn available for dom0.
> 
> Does this alternative work too?
> 
> https://lore.kernel.org/r/20260605230949.GBaiNXPZ2ztjVL7DBg@fat_crate.local

It boots as dom0, but smn is disabled.

Yours:
$ journalctl -b  | grep -e amd-pmf -e ypervisor
Hypervisor detected: Xen HVM
amd-pmf AMDI0107:00: error -EINVAL: error in reading from 0x13b102e8
amd-pmf AMDI0107:00: probe with driver amd-pmf failed with error -22

Mine:
$ journalctl -b -2 | grep -e amd-pmf -e ypervisor
Hypervisor detected: Xen HVM
amd-pmf AMDI0107:00: No Smart PC policy present
amd-pmf AMDI0107:00: registered PMF device successfully

amd-pmc also fails with yours.

dom0 is the privileged hardware domain and sees the physical PCI 
devices.  get_next_root() is looking for AMD or Hygon vendor ids, and 
dom0 will find those.  A regular domain (domU) would see QEMU's emulated 
pci host bridges, which will be Intel.

I have wip s0ix support with Xen where dom0 issues the amd-pmc calls to 
enter s0ix.  I'm not sure of all the uses of SMN, but with Xen 
dom0/hardware domain running most drivers, I think it should be available.

Regards,
Jason
