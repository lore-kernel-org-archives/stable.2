Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300F406817;
	Wed,  5 Aug 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923922; cv=fail; b=EosJ1LEaybFYiVewSb6W2iPoGA6XNkGBBFJ0wWu9B8fYyI4YLoowMITX8TEAc8yC1bzA6Tsmu9d91zKNeUVuo1b49tQV39aRUb4U32vFZ1R18Mw4GHRZMsW1mHdlpf5UM6JbIGbLWGlSBi8y/mEyhE5UVs5+AVqE88OoX+vBeAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923922; c=relaxed/simple;
	bh=WCuviFY6rpW0XaTr0yZ8yW7w8cAjP3IwQxrOaOiBU0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASn3Jdji8oucfOt9TfHbVldJhrC7SKO0BCxBo9Oghaithp+DZZ2jyrSS8rJbXbXNqC7jwImcHMYF1HblSuwLzNMCYYOAifScoIU4mDXLOzGxSGWdtTV7MOeebfHaDzlTX7nODY0NmdsyhZzOuqgJv+SaHW8akFB318+4Ri1pPdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=p80lP3DX; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=TEzpBq0R; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="p80lP3DX";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="TEzpBq0R"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675596vf2591917;
	Wed, 5 Aug 2026 04:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Ynq4lSUXFWk97wIo3i3XkT3POf7DdbKYxG/tGKUiDX8=; b=
	p80lP3DXL5xSyH+175cwlkY5lblhvtB0XYhbvJRcKIg9zhaSlCdcSFRYfNkaI+z2
	rvbXZObDevpFo9PZ3CbU+000OKdIggLWMr9a5NVzLLHO1/wCm6fUW4/uWIvWb+h7
	L5wV3ySJ4WCk0yeZrKRVqrOcUc+Xd93KSh729C60ZprZON2oYy9VA4FM9lAEAVTF
	qBYUGDlBREKAX8DH7whJ/BYdJyyJXKytXOhhKz4vsGJHHuTG5+hYQ6riU/TrUCdy
	bIfo9E72x3lJvFh8x3v1O0QjP591b8WwFvrffFI8bm0m1o+HWS0o0r77g1BDlWko
	wp4xpmeTXcuxo4pmML+jPA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020116.outbound.protection.outlook.com [52.101.56.116])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fsd7h5h7n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 04:58:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH3gUuY5MCpplTfREW4Di+bSITiJ9vblS9ff7ajinOT91EiM55pz4Fu3cgBtdJZeqLZ8LuBxXdUEK5DmCE9QEEmd5np4lAGMVCDqIn/iACSHbrNJGNk/OFaxFkT0znZHlTyi2ycSey6vLc68IxKeYhswbNP5KX01rEjOFA/8wAcnmcQF7PdCPSUo0FLl4z7CLGunA+ZHuUIULZjg140RV2rxKf5UK4SzdkIoqWywdcdpVHhlZVVGVaX5hlqx/RomMcvmAUuMrXfEdki7SGCRabvte5GG9opGq/2oH4kjKaOsNe8SnjaRi7PeAVIiS0uGDvv4IiKWV92IC6PnRdAHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ynq4lSUXFWk97wIo3i3XkT3POf7DdbKYxG/tGKUiDX8=;
 b=MqvAdkmxIGG2XeagSJHlMFS/8NIfb8MLzk4ORrXe0z0kL4vnpBCfzHNHtL1jwftFqa2VvaYnMbKLTMn3NOYj+r9Lg1ESxovnIttV27SUoTLUImctIFn0MsiHbDTxhuPo3S9Y7AfskBMmASat7PdbiN4mYqas3CyMTsK72o0Ype49YZ2HiVothcIxY+bNzwNw0M+KDGbtuJBJ1DnP7n6hlalBb+ngRgC30KhNci21IX+X6RenRjLOE7pekt32E8qNMBWe2RAIpeIpiuQ2B09g/kUTGyYq5ozZFjVO3vlZ/l6mze3OfEbOZC2p5f9qK8G17V5w9PtDxD6wQTRop6NCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynq4lSUXFWk97wIo3i3XkT3POf7DdbKYxG/tGKUiDX8=;
 b=TEzpBq0R+uUZ7pMiicmT63KjjCmt8lyepdBQ+S9IErMjHCEfOzQNW8Z7EyOpVdo23OizSxNPK51nMZ4svDiiWEqlYGgKgThXmHj9K4T5+SGSBvDWdlpx722VjfJMEhv4Xfr68QTDMTix8UeLFZ44xwa4XexW7JIjkTP3OAzCO/4=
Received: from BN9PR03CA0343.namprd03.prod.outlook.com (2603:10b6:408:f6::18)
 by MN2PR19MB3904.namprd19.prod.outlook.com (2603:10b6:208:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 09:58:32 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::8f) by BN9PR03CA0343.outlook.office365.com
 (2603:10b6:408:f6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 09:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.0
 via Frontend Transport; Wed, 5 Aug 2026 09:58:32 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F3C9740654B;
	Wed,  5 Aug 2026 09:58:30 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id EA99C82025A;
	Wed,  5 Aug 2026 09:58:30 +0000 (UTC)
Message-ID: <37ba7196-9102-4fde-b273-2c2576f19f12@opensource.cirrus.com>
Date: Wed, 5 Aug 2026 10:58:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: cs35l41: sort the register default table
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <20260805082413.26174-2-peter.ujfalusi@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20260805082413.26174-2-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|MN2PR19MB3904:EE_
X-MS-Office365-Filtering-Correlation-Id: e7487b66-1ec7-4a32-2fb7-08def2d81bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|23010399003|376014|82310400026|56012099006|10067099003|4143699003|11063799006|16102099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IR2jBWhwDrhDkkl4Q3beZuvOtpV10mnEKvv+LOjb7qP4AZKlhIhKyroGHGxExhoFPznKAncephiCJLYRS55Qp9621i/diKpRmw6hsKvph3L1C+1LclNLY0enI8PuPIm4cxvm51frMRpPguvE/xRDh5qy4SiuMoq1BY+1/p9moqhT9txz2fvhBZfMx8oxuDGnKnM0KieQ7uwr8qaXZPvGPUFTYwoWe/Kkrg/h88bMgFxvM8eNUFxUjKuuQvsaL6VdEOWcuHVDAudxe8BxROGZ+EvCnzYdh8qQz1Jok9BkCmzCKaI8rx8zNZX1h4NXp9u2yYIS+HKUltR/PK5SROl2r7Ygjb3lPpHIvEtScCX/A9oo5u+3cuznnTbdW+X0CJftc8CcGyl0Qu9C64W5Z6IchuWBB0ccPGlwAoxD7G+c+QJ6uuQuBCtW8oCgugLQBdujlsEtNikmXxwiFJiPs8rsODV1Fn0EjW36OCiraYiWUpE/RnXMj2L6mdJ6cDLzEvaAyy50RmQ8gT0e7t98EEioGcSWzdrGRWdy87z74euGbzuFenlV6wuCHuiDqYfqmOWifPROjdlDS/jrIxFKLsTwRACquJMZSsMfvhoOj7hwIy3IGe6sZvhWQgoFEJFPKioIXxZkc1OcD1QJT6n3N2BH1dReqWq1zmKRX04y1zarqfZMWy6RUjzUyH01p/JtCOY1Z+07JLyzWi/bE6icVR0N5g==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(4143699003)(11063799006)(16102099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	chA7Grft/kn5FEU/6qwr5lDbyRwKmcFmAIEAXMbel0W2m20sSNIIfhXbAIpWz0nwlaqDuhcK7SLRvnGma2gDq2rbhLCjGI/1hA6BcdnmPumssH1i7uoQj4Mz1+fpLEBXCkOaC+cXnjyxAIabDev73rEV6qr0bjNUCtsPddNeX0LqS23FBkv53Ok8ic0H5V+3BVJIyZeI7AdHd+qyK9rr/2cKEjLpWk2+QZQef30C4neNMK189QvxXYzfjYZoRMlk2vqydp4qXNWgXSS0gicLbo9yKo7cy2mfP16bt4yR+fbtjkBLwuV18aSnW2nxGERbd8RQZJNV7iXaDbfMUXqSLR6y1Hzo5wg08L+HYerQigjfdExQoJTKs8oODc44w6mNgKRqyyazt68yeG0cEvqnJZ8SWVKHBvaRE6POye4iKn+3j4m5iASiHwLEFnrMocFb
X-Exchange-RoutingPolicyChecked:
	QaCu5PlGs2RTN3covMZ+TAByVoRslG0NEZvvX28XgEPblEetRYdLCmiIFUrHrSVenGX2O0BEh/bFqW7y8FL/56X/+5+4YcWWNhoCmQrGjtz58f0r+DZJ/0X0oQcz/Q4arYAC/8A2UmV4iQUJrRstOZHGrwEk0ti3AM6W7YBYZ4WtFRGlZzkDa6uLa1JA6w5//oiBhz03cO2TY/5hxTTFaIp+bKZY9v7XCIl4G7gFeB69l6zvbobEE+y0wuX8js6sepxYMd2YcH9FwvtAGrxTc3FiSOOOPwQ1zH8vSuHv58sF76lgVw8rDdexAe9z/Lt8UqDPyx2cKOsJrBwfoKegnA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:58:32.2507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7487b66-1ec7-4a32-2fb7-08def2d81bb1
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3904
X-Authority-Analysis: v=2.4 cv=ZK/nX37b c=1 sm=1 tr=0 ts=6a73094b cx=c_pps
 a=FLswIYeaSHgFEUgczhqdSg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8 a=Qvb7KXIr1dtEM6bKgH4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BaIH1N04d1TMSeAM_5GVtTQJXRpeXEyj
X-Proofpoint-ORIG-GUID: BaIH1N04d1TMSeAM_5GVtTQJXRpeXEyj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3OSBTYWx0ZWRfX3ccwDM8U24LW
 4Es2to3PHsIwa1MeRN2mLePEK9iqIDnfBUaehkJbEv7bRrHk0TbTKTeH6UWh6SeCtRmAixJs7/t
 yLSCYwoxTs4svxK4xr2ZdZcil1EhjH7pXsJOiwi+rb0m4eXcySZVf3EpNpBPPCgrEK+gOsBJAm2
 XzgW7XWBT8tBJqhnmeBSJcrcI5UF4bP1gVg2z4okonGWEL5O8V0YoZapTWsY/p0kGd1VJKzc9vG
 9DpsqTXOGeZSszB9rRYVXxbUeFh6XF6Wz78QhaQtup3LJ/8tyY+LmYgzzvz4Q8m4zsZDK/TEdoE
 POz+LaVQ6RWPy9HutettABlGmWP+QhW5/d3k6qzPNY43lQK8CnKNpRuhurqqNzDk2j9KCmKj5gD
 1yjVRQu+mE3AEOxL1+zH/cO60Eah04Y8pBV90WoZKjkomHrt5lpcgVu2R5zfy1ecCFPIC5MMhLS
 JdxqN8oWUdypoLwINaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3OSBTYWx0ZWRfXy3ou1L50gAgd
 CMlohTNiHpFJ6m4y80ljfZWiUoXO7kBQ2RFan1t407M8IM+CU1FVSvorOKZfjIpiAlFueT8+Hah
 jnFmHLEpjMH9HrSM9JgSZDkNK/MtmD4=
X-Proofpoint-Spam-Reason: safe

On 05/08/2026 9:24 am, Peter Ujfalusi wrote:
> reg_defaults must be sorted by ascending register address, as
> regcache_lookup_reg() locates entries in it with bsearch().  See commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> cs35l41_reg[] lists CS35L41_BSTCVRT_PEAK_CUR (0x3808) after
> CS35L41_BSTCVRT_COEFF (0x3810) and CS35L41_BSTCVRT_SLOPE_LBST (0x3814), so
> the binary search does not find those two entries.
> regcache_reg_needs_sync() then cannot compare them against their default
> and reports that a sync is needed, so they are written to the device on
> every regcache_sync() even when they were never touched.
> 
> Sort the table by register address.
> 
> Fixes: 5f2f539901b0 ("ASoC: cs35l41: Correct handling of some registers in the cache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
