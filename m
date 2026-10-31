Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793454648;
	b=z4x/EBP/tIIKfq5bCYbU/Pd+2bc52zYPLVA2AnKfsGiO/jVwstdE+l9b8jYOyI8Zx47n
	 ErRB8T0MLIIGAAOn1QDPFQ2c4CvdAxwZ5RGRQAhs4sAYy4BXcdx8LrFlX3cACbLK7kGBS
	 fyFsDll9La1ZO/VA75YQ5LoULbFi/glRSUWDoIDsu/BByesF/Hylud6WgYEIqRwcI/7BK
	 YB9sr864QjVZS1Dgdnpb9bOjnuGWdgLfmxI83SxSrfPPmybFtpJhSMvdeXs+M2JK+Cbh+
	 qBNhM5JVDPnGREulD1d1lQ44Zn3WUiQM6monpOjizN0p51hxUVA7zVSSSs5K+yjCbcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454648;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=r89qqj7ZehlIw26wCt6lB4H+ayR5sCBpdsKCG6AtHok=;
	b=dIvlOIcIXjsaZRIjuP7fGWAf9ZOBrY/FF8oNg0j7+xRTDC+/iLwh8tprQLUNAn+uCxxd
	 dQd1tHkmyD7mDwpnpmh5y0G/EOoA8rFlu0AOthjRYe9FhfxTYPrO7PPgs0aso4hdaFVxg
	 w2v9heOJtxHskZHZV5A8obrl+Ok7Ct8P+tDc6CwGctd7i+4msJU9nmeP6BcQ09dc+A4Te
	 W9qUvG4TdaBnljVYT8t+ZaolHON9XI9gye63gHuFdpOhUqxYnllUxTJYm7RNSU4hDOqRu
	 bvIkP4Dh+9dLyhH3JnWQ2hdpjA+HtPKGRL6t6cQDlPKELOe4ny1Tt5WPJZfGSjK7Hzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Uzr6ABiu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.17
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4745606A31A;
	Sat, 31 Oct 2026 13:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4745606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Uzr6ABiu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQny3ntYfsray6K/mhQscjKfsG1CGzL/R9kBahyO+v8ZLRYMEDPPhAQ3PE/jSyuFRfvaMywl2uljRAMpT/Z3d+IN72DVTUp8gmhBZbkUcXWO4NTqBE/oVQ8IyUS+TtMN0DXHnzGjr8yCDPgJ4otU9NKcA3vmRBF16iWkhtBEhShNgLt6KSByt1d4KsjA/3JNwDreUAlazxz+eEF23kpLcPbQGr7MypW/J2AqKYvC+0AnTDlem3lbOT5MCERmbnyl7nMBgTG3OJZYo9Maf52hisyx+y7qck50zphVUT6HC6+Y1FVuWzCvaK4Er7FrhfrF1ntFgGZNvu/3CT3nKlHRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r89qqj7ZehlIw26wCt6lB4H+ayR5sCBpdsKCG6AtHok=;
 b=gTcJvP8p4GvY0KvOIz96muRfHvl06+4SJLbHrJFfOQu6EPI4DQK9StHsT9QFQ3hepx1TIrEqFAEJ4w/r9lTSLO85twZi7xbu0LESnEVN4NnjDRlR/uDdaNhuzwqfo5MUXNLV8rCATEAKZ8O4FOoVd/mPi6krCWwqG/y9b3cPDum7Aas/hzmLzsx4EzsLSHwT7jsgdCJTUCXqoj1CzcKL85ZcEsDtO/ZMfwex0T4d04iKeZzLVjSOiJv1n1fZVLuo6kdeNK7Ct4bxiMalJdzF+gLBFgcTa1zPIf3qPkA7yBKRoFSO+47Wt+Q+4Mnq6ilsWGqSu+4Ihv7mXkPiOCF11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r89qqj7ZehlIw26wCt6lB4H+ayR5sCBpdsKCG6AtHok=;
 b=Uzr6ABiue77RgU/2GAH7T6/mSjfjY7woOkbAIp1b0P+hkgyVWQGxeTn9v/RGgDO8cwdfEGf2FQ5JD69ABu092Eqb+KCBGbCN2DDN7nIUpU4XrIaxXEkbSdLF8dxQQEoC/ApnXQU50/uE/jfU1bgudzo+1Kvw95Gptl8y4lqgzK8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 13:50:42 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 13:50:42 +0000
Message-ID: <39fc2fba-482e-45e9-89cf-9625038422c2@amd.com>
Date: Sat, 31 Oct 2026 19:23:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop
 16-by0xxx
Content-Language: en-US
To: Gianluca Balboni <gianluca.balboni06@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261031102136.24600-1-gianluca.balboni06@gmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261031102136.24600-1-gianluca.balboni06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::8) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 631c93cf-ac3b-4c9b-fcce-08df3755f43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261021121427099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	mhlwEsBiYtR8wKIbRtzjc3tB3w0kAk9vB/Idpzaa87b9cCDuAarQYB1atFmgG+ghnW+hTfMHgqkmkoGIqpvKbFefniUqz1W0mdjk17FiKaNdU3l5CzayX/5NyMH7h3qBCXTvgdTqA9N+aneChD5rYz1q9/YZ2rfIK/vAdqry7KOUSMku1G86YpgU93B0uW3/yy45dGXNwmF1YIX2jkafe1fUz8IM2jUj+xfId/Xlcn5AZjOdnrIO95kGpgx3RDwnAhvEQrEvD2+qt/YK5iwS1sj92k2Y17zS1Wl7aZd5Ibv3m83h3bBlP2GUZm8quLOTOouStCXaVPMYduwV3+NFYdhC+Rmpc0YPjLzH7xjyodCBQ8oqmnzRiwrlIrykgGidcYYxSIkosVQ381EYQ7wSHN5PUjBoaULGhXT37ueBFUta6vZfHE6Gtb30+7p84zRi7ZsyOIMbfN/2QA8z0JHf/tBXBWQWVnve3WG7KW4kqTdcCEPFQ/Yw1jFKF3nKD79oBJl1DDahBqidcrlCYjWWjunN0hO/Lpacq+kur+57JYCeWqopoylDmOpw2EHcq03/SIdot1OPsDCLZ4Mhszg8uEvrP6L2QnqrUaF2yyL4tmBvBXiwVvA5FlTyPYRnoCjUyVga5pj71aVHu/tMn8vKl24xuRq0/UZP8ZWcpZf5RPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHhKREwwQXV2NHBvYkdpT2lYTHJkMzNjOWhOWjM3cm9GVDdMN3JFcEpDVXN4?=
 =?utf-8?B?aGhSZ2F6OGpQV214UnJiMVJtc0JiUjJXVU1JT0hqaDFWcWdyVFBIR00xRVA2?=
 =?utf-8?B?a1R5RklnYXZYUk45bzViWTZOVlZSNkVNV2ZsY1RsOXNOZ3phQ001S3RQRFdF?=
 =?utf-8?B?djNPeGZ2ZTlwV0lmck1LZDRsTko5emZUWHV0OTlDUTlHYm0yNW9kV2V2WmFS?=
 =?utf-8?B?eHYvSFZ5V3g5cHJqWFhVaU1hc1N1Y2JSelg3RnU3MXE4d3NpakxFL1dzclFt?=
 =?utf-8?B?S2w1VHBMd3hpMDcyZlBCdEZKdDc3ZnByNGEvQjdPV1RmMEFBT1ZCV3lhQldK?=
 =?utf-8?B?bnEyWG1pSU1yR1pzd21Ua1JwbTVqdWJ6dEkzU0QwL1VxdXoxcHNmcWZEUDVo?=
 =?utf-8?B?RitwVkRFSW5laWxFc09QWjY5TUV5M3hIbVArRjU1aUpSLzExNTM0NlpoOUtt?=
 =?utf-8?B?Nk1uVVZUTmNSRnREcyt0K0xaNStoZVBBT3ZxNjV0eUNxNUFtc1ozT1BRS2RF?=
 =?utf-8?B?ekxMRzAxL09HMGM2THMyQS9uY3JzWGx1bWNKOE9GeXZuT0lmblhwdlJRY3ZQ?=
 =?utf-8?B?YU1YcnBIVy9vZEwzNXZwMEpNb1g5ZW53d243ODBjN3VodlJHZzJSWnUweDVD?=
 =?utf-8?B?Y1ZKY1JBZ3lyV2ZhYjFUTnRqeXdzelN5MEhXNHFjRDhLZElKRzhXQ09CVHQ2?=
 =?utf-8?B?dUE1TFFxNW5KNERmUUhTUEp6aXpOUmZGNVJ0T093ZmFnb2c0eUtSUkFuM1Fa?=
 =?utf-8?B?UWlTN0U4bDVqbE5LNFNNNkJtcG1WMHRnUFgrb01KL1BEVWpzTE5vMmhlYmJU?=
 =?utf-8?B?YSthcHlEZzR6bFRVaG5oK3RrdkRHbnBWY1lLd2phYStTVER3Y3FkV1RZNUJi?=
 =?utf-8?B?RTQwMU10TVQrdW1QYnVRODRjZjh3elErNE9tbjdVWlZOL2J0ZUVaT0tBeUQr?=
 =?utf-8?B?UEJYMnFkR2h1alcvbmNBcXlGY0k1VlRUOUE2bGE3S2pVQmJ6bU40VzgxeWx6?=
 =?utf-8?B?ai9jTHliTXN6RVFKWlRkVnhTZGR6ZzUyTGtnSHZlM0VWR0IwcXBxNUFKZDFv?=
 =?utf-8?B?OVFDMDV3RFRHbWU3Y24yUHRNVTZFdG5OdVB1bXZkSHRHOG04aDV1MUhXb25j?=
 =?utf-8?B?akFGR1dUKzhtK1QwQVVlRFQ2Z3QxbmF1aTFtb3lqby9yZDR5MTdodXQ3WTBI?=
 =?utf-8?B?dUpLeEEyQ1JyQWNFays4RXN4Q0ZJODBOS0hPWG5PVGU1aFdhb3pBNUNjYUZj?=
 =?utf-8?B?NHZNRW44eHhrK0llcDlvYUtvbXVOZ01HcmxDWk9FZFZOUmFYMzdSMFVRSU0r?=
 =?utf-8?B?NU9DUzQ2YXZMa1o5elBUWFgvaFFLcUVZbWZzT2FLa3hiOVRCOTJVUFl1ZmlD?=
 =?utf-8?B?QSthdHQxU2F5cjVSVkdwTlY2YU5ZNmdBYno4R2hSaUV3U25xTDYxVHYyNUw5?=
 =?utf-8?B?UFdERVFIM2hESzlSZVhlbkJHSlRzRTRrUUxUVmFwS2VWcEd4NDI1NDk0cEYz?=
 =?utf-8?B?NGRENFU1dzRpSnFjMUhPcTlTdVdtcjV6QnN3QXJHejFsUytEaWRHWFYvNEZq?=
 =?utf-8?B?ZlBZbW81a0N6elh3b2c0ZXRFOFMxVGZtTk1OM0xYVU85TnFkSkhPMzI2cDFE?=
 =?utf-8?B?dWtwNHFTQTBMSHZmc2lCSE41eXZidDV0b2I3RjZUWExBeWhqN3Q2YnljblQ1?=
 =?utf-8?B?QmtmYXRSSHZnR001OS8zVnZDQWlISHpqMFZFbGsvb0t2VExHaTBmOVdYRUhs?=
 =?utf-8?B?clBMUE9rZzBVbGYyR3hMVDJOK3lGSnk1Q09Fcks3djJra0FrM0I5aHFVbVRy?=
 =?utf-8?B?NDJ3RjNIcmJmMCtxZVBJclkxc01zdEgxWVQxY0dNRmtMNW5vSHU2aW1IMFBU?=
 =?utf-8?B?Zmx6SUxrZXBZalF0dzJHdmhFcjAreWVsczE0d2RYRVNVMHZtem9zMGlYbm5I?=
 =?utf-8?B?VDRWajkvSjVGV0JQSElHMlEwRTlseEx2U2hiQ0YwMDY5VzdEcmI4NnVtcTQ5?=
 =?utf-8?B?cXJ3dUdPd2tnTm5ZQ1VkOWpSV3BVT3A1VEh1dFZYNC9XWWVzVzI2MHlKaWFG?=
 =?utf-8?B?YmFHQjc2eVhOcXJTRXpFa2g4b25xK1laZXNZWU5Hd1U5VlZCMWlUWFhDb0JY?=
 =?utf-8?B?ZXhYNXJoQTdjSVBSSWpuM0pCcUFRenZzNFExSW9wZUZHc3ZyNGNURFNoMUpi?=
 =?utf-8?B?NGZySUtiYkdlTHRoeEQwVUFESEZ2VnRCcEt2MzhEUTNtc3FNZXI3R2I2UnBQ?=
 =?utf-8?B?ejVrVGZ3ZXljUEdPb2hOL1hKcjFUUkE5alJXSjFDUDErSzBKelJRN0dkalpk?=
 =?utf-8?B?TmgzT2VmWkNFTFAxbEhYbHRoMjZTeUszTDZUbUk2M3liTmhNY0hRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631c93cf-ac3b-4c9b-fcce-08df3755f43c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 13:50:42.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDVdlFE1AAVA3UE2/gFtn0Ezx7U781+IYZDIN6juvDhmX2WFQlpGBYkWppoTcpHMAqDJIXjZqlG9S/yX0V5/bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163

On 31/10/26 15:51, Gianluca Balboni wrote:
> [You don't often get email from gianluca.balboni06@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The HP OmniBook 3 Laptop 16-by0xxx (board ID 8EE3) has an internal DMIC
> connected to the AMD ACP6x audio coprocessor. The BIOS does not set the
> AcpDmicConnected _DSD property or the _WOV method, and the board is missing
> from yc_acp_quirk_table[], so acp6x_probe() returns -ENODEV and no DMIC
> capture device is registered.
>
> Add a DMI quirk entry for this model to enable ACP DMIC support.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Gianluca Balboni <gianluca.balboni06@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index a7fa0e8c460d..7a629b35e076 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -762,6 +762,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>         {
>                 .driver_data = &acp6x_card,
>                 .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "8EE3"),
> +               }
> +       },
> +       {
> +               .driver_data = &acp6x_card,
> +               .matches = {
>                         DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
>                         DMI_MATCH(DMI_BOARD_NAME, "8EE4"),
>                 }
> --
> 2.56.0

