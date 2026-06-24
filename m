Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57565332623;
	Wed, 24 Jun 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328099; cv=fail; b=oa8fZ5g2bMSG5j3hAqLtThzkZJuyoS2/fFZMLKPRdS0pEoXweYk6qPyMg1djT+omiGRUeB5TICgOolo6CEDw01Ouh9FuXxi9Kq6AZ5ApsyHppWwtH1Qi2z0JB50kdkAP3R47Bnk/cdYU/MSIuexSrXo2lin+4U/kwje9wBPFt+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328099; c=relaxed/simple;
	bh=ey5vnOdOTahA8felPdL1kdnnlWrBlGW7G3VRxcREeYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h1vedproHiWyNLM08Fd7f4zMkWxX5LCFQVe0j6TR0IFQ7t7mvR9Laoztg6ZV9LUWbhIb77z1MpYhahUcVcdX0YO9Qs3vckiXfTxY53E8e8kG6asAiOlHSLATa0VR+VBcClan2a+XdMZxdpTe0F6xYDEHzLymYIdmenC7KJYZt/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jm+K7p36; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jm+K7p36"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sreKwBBY8UMUsSWNKBMQ5dBfgR+e/ExJtswVbOaaP05LEv08SQzvTeKp+hcvu/cab6e2Z8qNBTkb670BkjMlBY3HlT2FqymUsrfXKlduFAV2jMKbTTzaQYwOIiU/4Ksq7EOj/w+7OetGczeutyhCC4zmKCPmyGBQBnxXhjOHP9c2amz4J163qB2EG5Y80AXjGn2swwbI/4dGu6XeJtWqZWPqwSfiUBM82No0YWHsoA0KAFedRu8ASBTc6J7MDlEjRf5b2Cr8NLfoZB3scmSWlIAtacaG5Y0rFG4hYl6tT1C5+KIsVHWmp0pNLRncZJySrgZmfBNodntP79wE8ZoADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGNY86/42mEBVmKplgXKLFmafYRBaaF5XYNcq5av0n4=;
 b=TzC5cFIs1PVxYpNVs3dCR9qY84CLzSXzOZPr1EN9DwlF049nSApuptf0qdTVEDvUXXkdCrarp3SNjfRJYnz1ecvHtMkKG+bleIYV/UfWWHHbb/qKn66w6OY7OKHxPXW4cDVJ9tnkkVnmmXZQtwHzX0Ms5xVMmLJNuwkSDqtrL0+GN7wKK1daHw97AwTdSF/baKzHmk5W7oFR5qnAIgI6434lQEwMSutdUzuWju36IXCi1OyKdfZ/sRPEPXL8i11z5dGrD1zKVtyc9hJpiz3todJwu17XM7GvAMBllvbAQMvBrNm4g2vHFDCfRNPrUbmiQ/XsIMIX7TND4x/B464m4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGNY86/42mEBVmKplgXKLFmafYRBaaF5XYNcq5av0n4=;
 b=Jm+K7p36AukpPwRVcDWX3KK+ZoEcnuHgBRLxHOX0j4vc/WK/9ehThoN1SHLArUvw7pvlJNZiJ9mTXzfsSpJlYcNvjTBr/bf2ZTxIkkQZnmLlyPqzOr/aKbl7i1Wm5saOHBWsZ6pGDM/80lPUNQlcykmyhE6zwHqCm+4fz5mqTOU=
Received: from SJ0PR03CA0095.namprd03.prod.outlook.com (2603:10b6:a03:333::10)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 19:08:14 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::4e) by SJ0PR03CA0095.outlook.office365.com
 (2603:10b6:a03:333::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Wed,
 24 Jun 2026 19:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 19:08:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 14:08:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 14:08:09 -0500
Received: from [172.29.28.188] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 24 Jun 2026 14:08:08 -0500
Message-ID: <4b551319-0a04-47d2-bc57-2f0d4d9923a9@amd.com>
Date: Wed, 24 Jun 2026 15:08:08 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
To: Borislav Petkov <bp@alien8.de>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Penny Zheng <penny.zheng@amd.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
 <20260623213552.GAajr8ONjXFUnuUOE3@fat_crate.local>
 <48629f88-4b78-424e-a199-d87594c8cb40@amd.com>
 <20260624155910.GCajv-zguf0GiBxt2F@fat_crate.local>
 <0500111d-91bf-4105-8de3-af44a113157a@amd.com>
 <20260624171536.GDajwQuLD9pkLRLpLE@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260624171536.GDajwQuLD9pkLRLpLE@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd20b67-dd5d-4c9a-6976-08ded223f0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|22082099003|18002099003|56012099006|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CPYYcwIZpGxSoaM8RW3ZI75QQh9lhMHSRKzr78fEVSMQtFuIB/AiqTVJsitBeBT7Xi0mlmSDcxOx9GnJVYOe3+3I2QpUVFG90gZFXgDjv+4jPQ64m81WGERdWk4JYcEKdk3NxoAjZRgjv4sBaOpc04F3fWJkWt7BoF2yWSexrkYaz7gGJWmz0oBwSY7J1TlJZ+su5amFZqZZKxXVE7vL7I3TVeuCQ4TatHk6o/ymRYnMiTPJWlySKXAATaEC5DLTNgONzQRms2Mjkl6FvUdx6OdotR9TvA0msKzlVpJOzYAbKJo18H27XbXyd3zczPpeW9Hk7kHOkm1sQJCC49FExRzW+Wk8CewhTESPusljWZOgAh+mvvimEdK58pS/5NAJfP87QJYx1F/i0Ug9UmcduGj32L24WrphxWzT4bsbHR0sYnp0tmnR79RNlqbZVdd+Sv2cEkRV1up8aKSqGrISVe7CVXUiQa1QE7WInhgktFoxT/6IiP5+m3GOaH61XJ3VKbp2/9SX3YZedVRrRC5MTQTR9ulbKfdZh308vSLl1Yyi2FjMXJJqYZSEorvHM1eG3rtw5ssXnlOxl88J+HwMBrovRolsOC3ATbnb9IdwOHGPasifKbmhDXJ9K+1tDTI4wKHJyY4rf3jyBmAQoYKQ50hp3oB1h3ZVlHnm/RqAOJ6ACAR0pO2GtcCLFGm+TvpQddhVXnajoEf1q/2p6syg8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(3023799007)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GMku83NupxY31yzoqGIDTqIKm74WICrdRh6JlVuRvO4h1v6A56vq/CDsRtbWaew5eWfZAGaX4YZlHg5o+xncN/Q6qsemae/5DqhnoT2Z+buWYdHHRnetjA6PfWHLdVsWaAhPsMWNkvJSL+t8DY+mw/crWxBeQgszNNPRLDz9t5aidgn7g9aTkrjI/adsLUmdHaKiC0DuQSEYdsHAhTGqNWUCW5VDuFaAJyujOulLjTiFKdhe8okAm/9r757TxEJaLtsFpe6RDexNxwDPRkE2hDd+tI6cw9+dKZolQlJ64BACGz5qKxAR3GkvTIN0yiUfca4xFIhtj9eJQmfSrIuom9UeSMsJKhhF98fFN2hoI9m+WnfbwaOVbbo+8gx0TKIt0gVPB4cmVNMpUKAonXbpG3GU+43Xi/Byn0YeboMy2wFS4xYKvIHKw9wJHqi1Zv9q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 19:08:13.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd20b67-dd5d-4c9a-6976-08ded223f0e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

On 2026-06-24 13:15, Borislav Petkov wrote:
> On Wed, Jun 24, 2026 at 12:41:48PM -0400, Jason Andryuk wrote:
>> I think this is the issue:
>>
>>      The "root" device search was introduced to support SMN access for Zen
>>      systems. This device represents a PCIe root complex. It is not the
>>      same as the "CPU/node" devices found at slots 0x18-0x1F.
> 
> What is that? AI output?

It's from the commit message of 40a5f6ffdfc8f8ed0d8c535dfa3733b31c66a88c

>> We don't want dom0 to access the "CPU/node" devices.  It's the "root" device
>> SMN access I am trying to retain.
> 
> I know what you're trying to do - you want to use SMN accesses on dom0. And
> I'm trying to figure out a stable detection method on Xen which is future
> proof.
> 
>> Many amd_smn_read/write calls have hardcoded node 0, like for amd-pmc.
> 
> Maybe.
> 
> Whatever it is, it needs to be a long-term solution and properly vetted by Xen
> folks so that we don't do crazy hacks for Xen's sake everytime.

Sure.

I think Ingo's suggestion to re-add the check will at least get systems 
booting again.  Then when Xen SMN accesses is sorted out, that can be 
changed as necessary.

Regards,
Jason
