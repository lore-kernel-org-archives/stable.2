Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02DB448CF5;
	Mon, 31 Aug 2026 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198743; cv=fail; b=EoEiMcCHlwOtTjXqvNNftVwyPvmOV5lQJgWLBM4A6PuFmtLqsAs9uJeRrvsxINzgeMTih/bhgpioRUOx+uvcls1JaS+EgUUaoY0ol2ln+EKe9ASLZZVTVmNzkmlAWPVbN9LnY34G2QV+8zDyxhHJDDUdbb8MtRbEt206Ys4QX/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198743; c=relaxed/simple;
	bh=uK8oTEsMpibMftbRTbOpcRnPxqxDvya4Xc8LOHkrGbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TrTE3jYrLngQC2bltiNzuPnIaLkhEJlw6Q9jm86MeWIXeW50cB3D28hvV7fBF6BptEsi5Eckh5HSoWD8TKgg+OxLIYJJosZP+j0OverxxbG4AXaSPWOTu1VhOIHJohuEVJdKK5GKPloIatbLOwaDnY1oH7ShfkTGRvFVzGuq9dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sYcSWcHd; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sYcSWcHd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpvPJm7Zeea9vT6sDDI0/7MWsYH39phLcFbaQeV5GUr760YmEE3jej6Oj3gD5dOmF6WzVyegdHeNbQXVLc3Fzagyd64x19jigL/189lvpow0A3Lnm1AGkMC/yuGg7DYvad4LjM/12UcB5s9HahzipbHChIpbQppfJWdGdemEPL9HhdYhqoeFFFiU8Du3fBDh5s0FSy3U2i8ZwgZ+aNuXWQe+uzemJS7LBE4cJFaboK/sqFv6tke99nYHlr17rGTQGdU1ZUYnxGEVOg3iIu11JS+npaapetqwxHlF37jCRVF2I3MokE1zyThQmD6TJlQBvNbmljxl3Rp6BpFmRCZMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt100BL5YmYMmfuGCdDpvLNHqmsWpDSpoHVdnnXr5gY=;
 b=Zh5O3+GgP8qjrKKODsfPYnXfgPXlg0vilVn5yJkNayPGYb2ETrGvtxP8T5majoMrcrbQ6bYd6Tmz9iRvuyO6gH8RwAnOOZFguX1vveyqivx0CAKgCuERdfr/wYh+4C6tEJiy31pu0WlnpepBj6mZnyqbGOZ97qtyi/E6+h38EiHt4holFtUExu9YtEImMzbl6F8XgLtxv2QZ7LxHSwWXZQsZZ3P9H976Rf+5yao0guWrhgmylc/xS72bY3w+bqR93MsA0fOmz0lt4GW1ttrOT4XbgaJd0DBl3suXRvAywABW/cLOSkPYMDScECg+slqCOUyxSy4k381XiwukRjjYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt100BL5YmYMmfuGCdDpvLNHqmsWpDSpoHVdnnXr5gY=;
 b=sYcSWcHdBV9elqDN+hSbREbJOkIYqteqX+zl6TG1MqSAKLYn7wcPUeIzA1D3au+TZ4HBNP3tNXFPzSdkOiMfs6KLc8ZuWCJ8ZU86kkjcot+VGBdUu7EW5jiXANXSNi13gTNe3XU7zk2ZcBKWYXbPFZfrRAZtt22FyfSZ0Oxzlfc=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 17:52:18 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::e) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Mon, 31
 Aug 2026 17:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 17:52:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 12:52:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 12:52:15 -0500
Received: from [192.168.19.2] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 12:52:14 -0500
Message-ID: <13e77e26-7b4e-452f-bc61-a84acadf37f0@amd.com>
Date: Mon, 31 Aug 2026 13:52:08 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/amd_node: Remove smn_exclusive
To: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, Penny Zheng <penny.zheng@amd.com>,
	<stable@vger.kernel.org>, "Mario Limonciello (AMD)" <superm1@kernel.org>
References: <20260825214805.39148-1-jason.andryuk@amd.com>
 <20260825214805.39148-3-jason.andryuk@amd.com>
 <20260831023016.GEapTnOHTbN8XZGe2j@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260831023016.GEapTnOHTbN8XZGe2j@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 6661b597-6926-46cf-0739-08df0788990e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eiM6PHk7dp5jGz9Tj4iY/zRxYI0zdjr5IHnA/SwbdjDNieAMdzKfEGXOGSdCs1NBt6tCVwdJ96pNNnuL0WaDVK9SwjCOv+woTltVCd4/rKooZ7G4AWrgdVk9ko50ig9WlnEe+7XlCziKtmgcoqeMd952fO4kzoDHQ7c/vJHfhe4VtF++YeRxcaao9NYGe+8Z6436S8lLuodG921th7rMG3uE01X/GS1bjNUEXCCWK/nQsDIhWOfx/VvLKt92MO9keDW53AnwQSq4//iCvfSCs0ukDXHX90fEXOJSnqbx38rJK7CzqBuyG1Tt0miyp1vzoxzZ1pkzA6kPIiA1NjEuth5gXvXZi/Z1u2m6bGI0jMZFMl3ylKnzxeZekaI2wtYOgl7EmMeMdtAX4nFksSy+d9qFV3tiixR9bp1LlzekwxBUIAeQA6V84se0KjI5t+ogSQVO9mEzDl5lnZpqbGV7oqpMnwzK6WE4NW+TFgsbV5gpz91wXrgQ6KBPV4ISEO18INQapRExSQNlQE+m4nxsOJ78r3XXoi35d0QAFVCdpM2ZDBAU9ffMb5MKDdmDsqQViWpz5yO36Wc2d6Nl1MbflzmyX1VThk3b7BsEOYukaLQ5AeEaDotAMX1AdPeM8/dfTQx1I37cHs2O5nm8uzjljreP63X7L31fkYl2jAvMxyreWWavHkFYwHHDKJDsz+E91Adg2O8DeNGsU4lsWPFZ/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r/GCt4Lh2n78h2HEOtomA2TswqupiXfEkPqqiP/n1741EUFm4sZsvCj0YtNsznf+4muOw3v1qoo9/WJwDJ9rrnSo4MzAw2O36BxMWdumr4tGt7DyGMz5U53bSZuEpoUqbrQGFPGoi37vAjmR5P1Xy0tB6WDoSE5VfNVOc0g7GEopsHZWjrgKkXP6VR9etVTJXMTEUliYKQ8EZRkGacvxxhJB4wJQtSoXY+Qs/CP5meCVDWU6QIPd5FZ8TlQG5g04hmhbABiFJNuiGWeFXZ4mKUnxHL2P5D0FmiTNML68woEaonesraK1PwfjsH5X1M7rLy0qOtb96OAIXDtFGYChEzdasHeoPelY5AKzPTaw4Z7FmLTHwfgH5eSRT27DRBbYOKyWYbh0WKQHveUBJ9YxO596AUttpaAraTt4l8vlQBDTL/cwHARLO0UIyT5Nkg7l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 17:52:17.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6661b597-6926-46cf-0739-08df0788990e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700

On 2026-08-30 22:30, Borislav Petkov wrote:
> On Tue, Aug 25, 2026 at 05:48:03PM -0400, Jason Andryuk wrote:
>> -	root = amd_roots[node];
>> -	if (!root)
>> +	/*
>> +	 * non-NULL amd_roots indicates pci_request_config_region_exclusive()
>> +	 * succeeded and userspace cannot access the registers.
>> +	 */
>> +	if (!amd_roots)
> 
> So then this should be
> 
> 	if (amd_roots)
> 		return err;
> 
> ?
No, the code and the comment are both correct as posted.  It's just that 
I wrote the comment reversed from the code to state the positive 
property we want.

Flipping it would be:
"NULL amd_roots means pci_request_config_region_exclusive() failed and 
userspace can access the registers."

But I'd like to reconsider this comment.  There is an existing comment 
before pci_request_config_region_exclusive() in amd_smn_init() stating 
its purpose.  The commit message explains how smn_exclusive is no longer 
needed.  That seems enough to make the code change without adding a 
comment.  I wasn't sure how to phrase the comment because it feels out 
of place to me.

Because the other side is that it is a valid NULL check to prevent 
dereferencing amd_roots.  That is the important part.  Maybe the commit 
messages should have been "Avoid NULL deref in __amd_smn_rw()" to 
highlight that?  When you look at the code as a whole, smn_exclusive 
isn't doing anything, which is why I removed it.

I'll change this whichever way you want.  It's not a big deal, which is 
why I added the comment like you requested originally.

Regards,
Jason
