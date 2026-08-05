Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533A3EEAE1;
	Wed,  5 Aug 2026 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929490; cv=fail; b=DcrlOIj8Zw9SXQ13bksm5Qp882DR7YSuP40lfT8ehT8fxwtTMtkVexQPTzwSrWPczx2XXLH2rh9pOY6Zuo/unplUXMHPi/hGeSjPT5gMxN76dIkIo0lGLQDIoCmHvm7gr4r3uJEMhpIn/jx4hJuNZXX+1Z89yHhhvBg8WX4uxSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929490; c=relaxed/simple;
	bh=6wW+8CgyZZPSYmo9HsgTqrh+TdQgLOU3CR6M2bIBt8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuoMaIr7yzIWUGfwyVOYxVI1yxcoFk2L6E+RJ+HetKM/o67BYNY0gjIrtRSyrSAoFSXbViuhXGufXxABi/7D/AVB5XvouD9awFOSQXNC9mGm0NBnIyMGMVAzFb8RpBspJpTr+BcLLqRwXx5SKwr5bZP6pcanUCnVyl9iK2sxz/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bl96pzR5; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ULfERQPO; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bl96pzR5";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ULfERQPO"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755961n2591917;
	Wed, 5 Aug 2026 06:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=LTKHRsueTHU83ENdifdjpRxpDkGj7QwgP+k3f6AlH4w=; b=
	bl96pzR5FuvANgNRRBStgxh3H5mGpPpJTg3EWVvvWBGDRlHT1u7SMR1KzD+vXLEg
	oB2cqk/buAWATW7S/64D1xQm+uLkKJPeQ94iazNuH0YkNbNX/4WB7BbZKZms1jcI
	/n3enLmI6/t6nvpkjueWDCzjBA3P/KIFUCY3JKTt8ED61biTPhwAu4MBfMRDaN5Z
	cwWrSXuwo1i6To6RkMOgOsJv8C05cvs4OQElCSf3xAl8tbCpfek4VUcsoOVj4Gxu
	v2wSlHE6DQw7LN3ePkpLe8YFAKJAhgZGqmpDW3KycCuHPcH2tjVYO9KkQe45DCEG
	UQo+iwsmYD3yDYMPCJi5RQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022088.outbound.protection.outlook.com [52.101.43.88])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fsd7h5m47-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:31:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIeOsj6vBIu+yIAMpRS3pxPpxP1lALlMSAJnrrfOFtxtRyNuvE2b06z+U9rr1ZDzE4aRuhojaeOT7NZeTXnFTKUl1Zl1IYkFnXYIPr48lm8gmpvroD07rHVZ2mYpHOHKjmZ1w80mZC4sJdQP7feHNs9utWO17cGeF0uhGR8vS85J5fZnM+uzesEUhasPtoGTpIsQBTgFUPUBYVPGfh+0+KGX4FaHdvntbPUscOOfi8l745xVuiYyWtD9PU8SCpvRPuD5OQDPnRuWkeWsZywe6K8DHtlRtJiq51odFURoOZBnGp7Czr+RQsjwtrB3YLSViSXCYkk0jhc/CIhJntjUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTKHRsueTHU83ENdifdjpRxpDkGj7QwgP+k3f6AlH4w=;
 b=zRAWJTE47QIlJzB+ZtYPPB1BMJVd06ImONBXJXvNTIUVZ5tEsCsolnAOh53gDV4HEl1nYmTG2ePmTsfpVuD1Di5xHSbXhNFAKl6xqcveJZ/TyYPH3EKvq6fVNOqX7EBEnFCHywY/hjOhjsWO18OSe0NW1I7AeTpnIrBIlbH4LIfCgsOjl1t52f+YBU6D18xNINFIUIsgxFTs5/YKiCMCOWuvXxRs5iNS/bSFtWRQ/V1TrvomqI/wmCr0XWtDhl50Eng94ZRPpn7SxT50kHDqBs1SaNKpUWIb8l7CvTvMe1G5Kwyw5SIa8y3RsDVZUy93Sc7WRTlzyXlUxaeiJRqyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTKHRsueTHU83ENdifdjpRxpDkGj7QwgP+k3f6AlH4w=;
 b=ULfERQPOH/txDJWHWwwRwIvSJrRHVm77dC3DLHq/I1kIdLfEPZLTByLhWes5jE/ErLUIcTx/hLoQe/L2XHpu2IsXiSnmfECp2Xe6LtLQkqsESvUXTBB0SQM46zWlzq38sOGZ8btP8SUv0vyjI/i9n8DCFtY+pGG3/wGc6a47V44=
Received: from SN7PR04CA0067.namprd04.prod.outlook.com (2603:10b6:806:121::12)
 by SN4PR19MB997505.namprd19.prod.outlook.com (2603:10b6:806:4fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 11:31:19 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::14) by SN7PR04CA0067.outlook.office365.com
 (2603:10b6:806:121::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 11:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 11:31:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 450AC406544;
	Wed,  5 Aug 2026 11:31:17 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 303ED82025A;
	Wed,  5 Aug 2026 11:31:17 +0000 (UTC)
Message-ID: <fe70c982-5608-4e72-84af-92fe585fec0a@opensource.cirrus.com>
Date: Wed, 5 Aug 2026 12:31:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: cs4265: sort the register default table
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <20260805082413.26174-4-peter.ujfalusi@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20260805082413.26174-4-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|SN4PR19MB997505:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5e78ae-f037-4975-4c2f-08def2e511aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|61400799027|10067099003|11063799006|4143699003|56012099006|18002099003|16102099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PG5qOxLEhI7C5foqvKw6LY3wvEQr4nyC36E827crUmzWIvXdOrq4MiMaeRMjz54NRVCwyqHYfGphlGlpwymlkzFWNlgCuEl2nzOJLO99m32V0CIAnnaya52/1gKwyFccSp4/GVR4QIkQ+iQ8SQWh1V8RqNdIFpirAD1AJatAErS3XLNOJIHnU+nmUu4egU1hzus8lr7qZmXQxB5qrwhgI5SoqNfTm+MROLJB5NcDUFv2FqAicRa3p3rF6PBykWgtGDNAKpXwni1cGO4B3iKJ05CiZcWzRMuKvX1FxLjAEthiUyJbWn4Mesb0A8vjtANHGE49M5RbeShlHe6pov/cjuvTlG6Y/b+AihnRyScEMit5ZBOKsWm3+deXIk43SCMgw3ZkA7GaEANJNy8bbIMxGc9YcyJtyTWXIiVx3DNmZnQISirv6q7+owioquasfg3MaK7dWqbYwtwaAaWXkOgdfoucPCsjkxy7wB/gS//RYgFYXjFqswlLEFV52ZmXv1OVbGZ0eYK6qCGZyFwIXZ55NGRleYfGMBm3E5CXGVwBtE0toW1ts2jVA1Kbw0AmUS8nRwV+RKSOBGkXg//0AuFiJGKHabNvAxlBOFLao0v2g/di00Y/eGkFd6z0uXxEBxIqbScS6ULAdESR0FDJfvIMWqGlvvZyEkup5TtEAGDUxoJt8aVFyZJr/A4UG6M9anpmUYOJecxTW7AtNQpXbtRSCw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(61400799027)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(16102099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VysB1wgdL6EzImMjSjvE5NqQyhjlZ1jAJuUqqEoNzEmj+hDL4nrQKD+UExjKhpf8rXcZ0IOvusnDd4tlBDsj6Bt2Clw/qKr5CuaQZc+KEwDd5PVi6cFpbXm5qSSipmV05YtcLntJiXnSvyYKmrZcQqkiXcUL925HaFTATYFHNbbLyiN/YhbSYqWSzJA250KIeBs9kUrxPtzfAvr1Hnm8Ulf0r0Q1UDNQpwr1XyXVhnqW0FUMWIiy49V2HW1bY1X+L0/0SJ8/kYUE1E/yteunEMIBKKnb6crsbhryWVLPc5n853t1iwtVtVpZlBudQ6DBmvZTfVaeNPduXzZNswKrRz+eX8RV5AmgBBzHQdnlIvBpoc5v9riKlOrp6kdd6CT0FPZRM96uv3I4GpZYhcDw4ND82C200Eq2XobUvnCX49xyA+/es4NLIuj8NMb+7X6c
X-Exchange-RoutingPolicyChecked:
	ZOqlIY1JV49iaW04oU6GAxviMGVimbSmK5zPxqQ85nSYUBKTW0dPDhLY7z4g2finkS9Oc37L8WPsyyQZJs742Gu64ZlER5pANs5xjAz7xs2mSdNcMF6yjzQKgJX2LwItN018/40CyxtXMIn8H9fE+CRwYyl0/vr7/zLBVukNwGFfyBRkhrwxRPNFhtdIZeb2BC3B8nMcJRogWit8T9UsWQjKjqx6enKGdAKhLZeCzIbTluxCSyeukTLqcKzaT51wvzQ3k7rxDJ71byn74GtDPsO3va4eplDHnQWkzY97ooKWVRM+nwxhl2eTn58nIKND04pdm+YMNcch2lXmrOSdMQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:31:18.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5e78ae-f037-4975-4c2f-08def2e511aa
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB997505
X-Authority-Analysis: v=2.4 cv=ZK/nX37b c=1 sm=1 tr=0 ts=6a731f0b cx=c_pps
 a=R/EmBLgrFYJi0SEZwJtDOg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=w1d2syhTAAAA:8 a=h2xXy09JlyD6D64P8P0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o57SXfnR9w_ttu0Cy_bck2RX5ynvbMC1
X-Proofpoint-ORIG-GUID: o57SXfnR9w_ttu0Cy_bck2RX5ynvbMC1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5MSBTYWx0ZWRfXxOl4AFIOFq5X
 VWBlyL56HptpPJ5+Kq/YDsueM8JuA+uHdKFaQEszILWlibQsOfgXnwhet4AphedFkPRN5wmPF/j
 /UcXysyvKncQxcwd1lIxop+qsJ3MpZIdHNdVeIPyw9keofU7OYlaF69gBhqlgwSYQM2snKEy6AN
 nOciubnk70Zt25i5rLylXZFmIgdvPsyMpfzUJrldKYe09Ado9XAkYy3j4G86KDigHpUP8x3/E6k
 YYqvb96Jf7yI+QE1d+1UGePf0xlIXm262dSGtfYvRk5HyPOOoUy9bBl0irMLgy+aF/wuHhB0h17
 nJXs0gvQI30tkU4FyG76lDLtiBC3KVt38pqx21bPyz3n3NwRyGVox2L5D6uJ/wR0ZLCAApsdG81
 W96yZf8jj+PVflLs29H5MN7lE0GjmD2lzZ9JR4etOgtcd0224s7jBQWyspLLNzOgUppnPGX+cUB
 XIUZHF7bXKFG9Kuh34A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5MSBTYWx0ZWRfX2TvaHhqzgYSm
 UCRZT2RGdcJfCX5u1dSagNvIuBw19Ify11uS0/xMxyP8issKYCmWKf0Gfo5SW4yvUUPikUcEOb2
 T0gwLQJl1SEaXqFBOPQ9bjs/o2CpR/M=
X-Proofpoint-Spam-Reason: safe

On 05/08/2026 9:24 am, Peter Ujfalusi wrote:
> reg_defaults must be sorted by ascending register address, as
> regcache_lookup_reg() locates entries in it with bsearch().  See commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> cs4265_reg_defaults[] lists CS4265_INT_MASK (0x0e),
> CS4265_STATUS_MODE_MSB (0x0f) and CS4265_STATUS_MODE_LSB (0x10) after
> CS4265_SPDIF_CTL1 (0x11) and CS4265_SPDIF_CTL2 (0x12), so the binary search
> does not find those three entries.  regcache_reg_needs_sync() then cannot
> compare them against their default and reports that a sync is needed, so
> they are written to the device on every regcache_sync() even when they were
> never touched.
> 
> Sort the table by register address.

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
