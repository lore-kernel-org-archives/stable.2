Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EA261B9E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786109775; cv=fail; b=lvIU+U6eEBUQxP8RLEpiDDEmYJcgyDqDmSVMovIZKchErbRFfUWCwEpLJ98RzGBmB2xTEaWf0xwb0TtpFHd3qNs/JvII3YUrp53bTETjpNVEca9UZK5HeM1XV/r/lEM3TioagylAZ0ETshwo+6b/2tzSegQsisq+dr6H1LJjR/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786109775; c=relaxed/simple;
	bh=ZdmsuZ5RWG+Oh1SfKRlmswgoiB++BxBvnkh0eO4iUZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YZ3S2HdTQWmF2z/Q55DQ0P7IKf8IWbt1hHQLvCqAWleq0uh/9OOll8YVXe+rzh3lts7vN5MjWjwuBbiYRifuN86EPI33+E6QEHyo+awXrajXMVdMlhIhQda2tszBsJlXuA6qC0Co+oZ5dAgOnytnFqxHxDVdKFopJnf2s67apys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AjXQ7gBp; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AjXQ7gBp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXtz9nuHeInEq6t8uFjt9pXI8MaEyFHTpedc93I+fu4cCi3aLjZtmZBR17Efps+GVgsn7EguMRjQ/MesPnf95tOsxjr4QutRogsq56HGbUxsD479s638WRqqKECC7Lp0U1S1FOPZZeyD22ZKmLftBhnp7yE5VFB5Zm4Oos78bS92yAPfF+9oXusewjvHX1G470SvL4B9lG41uILith+xD3GGgvp4gxYCJUoHachRE3crV0S4LeznYGusRt2g2J5lhC1hsgpQh0Jc3tyOvgq+QNPR2Sb7JkfrmnktUpSI3xLYF/UUQPY9JbHw+lp7JBcl57+D8raT1NnzaJNoE65ChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcdQPpkYq5Akiz68EQd1rUnlYDt3GCQasRfracEZJTI=;
 b=TryCZr8PCVTVV8e4uZRPwUvjy1Sm5Za71WDU3ttSfRF2j7bPTxQpl7e9aE4FA/QuDyxO4p8cyyuuOc8RWMi8f78qpWn1OnwjEXrjZoo2nQdldRhI2vwNEEb9yLohsz1F/dsNZa2QlRWb3TaR81i/TYrcXHBet1mYAUJPLyYIpAX6l7kWrX/zJ0qIC8Av2NZGotdDiLLu2NDXfpJUuZjjbAMhi5zcQJzoHV+ovcLCT/GpJofNR7Aee0gX3U1auY3X1EEJZL+9ivLL6Hd/f3r46hTAicmQmd0lj5YMjO7pRo1KzX/zHVHdio3ohUfb6gucH0H1FdzYDWaCgjWtUh0BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcdQPpkYq5Akiz68EQd1rUnlYDt3GCQasRfracEZJTI=;
 b=AjXQ7gBpvUn+CqdFDKz1IscnDBXO4qvznbig3T72pv/cUu/cnqKCs1vlNa1ddq67dWa3dFZ5PP4MuFVhnIHXFVSOx21LSOey3qH2SZUEN/dHlv8NYCp1yK6aZh/smd7LRTw/SzEFRzA4w8dhjep03ozmDS+u27LAZ1N+jcJh4po=
Received: from MN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:208:530::35)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 13:36:06 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::17) by MN0PR02CA0017.outlook.office365.com
 (2603:10b6:208:530::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 13:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 13:36:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 08:36:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 06:36:05 -0700
Received: from [10.4.12.179] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 08:36:04 -0500
Message-ID: <e1b3c2ec-315d-4e44-9079-3253ad4c2f5b@amd.com>
Date: Fri, 7 Aug 2026 09:36:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before
 programming
To: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, David Weber <weber.aulendorf@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>
References: <20260805163314.214623-1-sunpeng.li@amd.com>
 <20260806021809.0021-sashal@kernel.org>
 <ac4c0e75-fbaf-4264-8794-d3f86eebb014@amd.com>
 <2026080707-deem-ascend-927c@gregkh>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <2026080707-deem-ascend-927c@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c678d1-a07e-4bd3-05cf-08def488d4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|42112799006|22082099003|18002099003|4143699003|56012099006|11063799006|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info:
	CG873WK4wfU/cRGT8N41Gh56hJOSIGxUML/v1gObasMWF6kkbHAN/Lu/NUspIwKFS9p/N+TrrwL0Yazy3JyxV+0gu4ZUKQc/zdQpcTquNBh4W4KOHoLHXaVix0TYM/Y/1rxstbNRoKfjQjjdpzrsuesZg6m2iXxSYcnItCJuJRnfRkrEzUYNm1FDeiA1GtOxvfqZIQEa4r3b1s4hcMH4g0Wl8f9wcaB3f6UdTMdM5UIYmgYQomxMwDeCVYQmClCpsmbkhLLp2lllswMp8oWCIyv9nu961+ueN1Feco5RDd822Ot6LG+KCqOAkaIckgpjTlBe3+B0rPc3sXbDpUg8gW3b4CtM6y2TWXjWtv64Yi5mwwHPx/kOwsc+ceb+h3uSKRsHPxAEeQ7YH29023p58IulVd+8oLxHD8gQzqSmmbtCLZvFNbMEsgjIqMpqbxFIBPpEdTHdH0WtODo5Xu1Lyqaey7kcW+vikoBQ8uZOjSbCxP+gvW9cbkQ4rzBreJquXV2Dg9B2PG5TId2Zi4oXWL0moKU+eRkCOcEfx5CCzDkco+xbhL/oYABMxncKdPuHtvvGAHrHO9cBSTbREveXYiyRiPRp7y15h4YalKQW+zyTh3Wo3snIs0g4yvV3O0n8cFEb6BMmxbHFtKCnSHWzQtOPsBbuF36mgZc7FbMM79pLg2tbc9KyoqxmgB0ahG4wTYTcSw/+Ayc/1xMBrkj1gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(42112799006)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(13003099007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fKG0tcj/GTDsdUWCn8B6jd9QZ6RFTCFjyXFQRNiYzhfGDUFGdERlHkGgigjmo2QJf5vrG22LPM2zOj+fnr3wLo/3RSBzwFoS4C3iEu709CM5HFrSH4XBalB0fLkBvZhE/5dmM8TthqoCPWGQXfmTpK3Rc2SOJZNY4tb7GT3OW1vqBv9VvF5sWJ/hydNYdpPqk3KhHxtNrgdHajsWHuqGR0Pj9Hz7NJSzMb84mYuJyfO/V32Q+18NRSxCAVhBMh29iSFlA+KkraBvpyyf+yLTEF/UzP6KZ6OaFlMap3rANNNzrMIv7/9x3eBpKZTSH3wiIJg2mUaj/M2MPRVt41K0+zGnL6f17wicleIpdRlk4DHi+4ptlLxNVoSxbgM7t8j2MW8HwKUYwkceb3zjKn/LRVYg94d6X3niJNhig3U7uufaLE0g1WMW5VuFZbHFR1b/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:36:05.8711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c678d1-a07e-4bd3-05cf-08def488d4fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906



On 2026-08-07 05:20, Greg KH wrote:
> On Thu, Aug 06, 2026 at 09:42:42AM -0400, Leo Li wrote:
>>
>>
>> On 2026-08-06 07:36, Sasha Levin wrote:
>>> This doesn't apply cleanly to 7.1?
>>>
>>
>> Hi Sasha,
>>
>> Looks like the tagged "Fixes:" hasn't landed in 7.1 yet. This patch depends on it.
>> See the 7.1 backport of it here: https://lore.kernel.org/stable/3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com/
> 
> So what are we supposed to do here?

Hi Greg,

The two remaining fixes for 7.1 and 6.18 are this patch, and

[PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before sending event
    https://lore.kernel.org/stable/20260729173742.950965-2-sunpeng.li@amd.com/

[PATCH 6.18.y] drm/amd/display: check GRPH_FLIP status before sending event
    https://lore.kernel.org/stable/20260729175748.981393-1-sunpeng.li@amd.com/

Looks like Sasha queued them just now:
https://lore.kernel.org/stable/20260806234000.stable-0001@kernel.org/

Thanks, and sorry for the confusion!
Leo

