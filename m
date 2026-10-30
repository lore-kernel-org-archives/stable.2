Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793364785;
	b=rEAIm4nS9gEj53jX7L/Ke7Vl038d0JlEXkoyeKdaEgZkV5yK5WHuMXHjuwd0lsrgQmEW
	 8lCEDKFSlFHzKmps83zys6TO6n+kVlp3RebN3h7jnCuJheAZlZMC+spU9rgjj8gZ2GcBT
	 IzPHc56LnSzV1WlQTNhm5SIK637uZ7kvXMTNqJu+3GQxcRWC/uUBOxn58J3HbZQi8ERlv
	 saSIXSDVqXp8XDBXf9qPdUh7DAGLoVhTOkxQGfEqHdXTFKk1ev/6DjOPUaBl3lyIiq2hC
	 1eaeq4CBCeXqzEjQfa3FoPwbdrsxLKCovWXrpUC8KuJYWyxYDgvGokTUqnNgN35IoBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364785;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=yDqVut/BJRXU1gELxGIxLY4RZ4C6Xa8UK9PdTi7fHdk=;
	b=Iqa2lzaK2yPzYqkgxtNKa4F46Pejn4k3wDMS5NlReGX81EMMF+D1GIlVph2TYCk0kREL
	 Z6OfvinxRjHJnZunml2d1ZIqVewWkFmwlE8BfSeKcFWCc7WEZ2CrTe8dGqnKDWrcHlQFw
	 CG6z9baMqY07sOudHQNCR7j90ow5fYMxoiiKBn5X/zLtFRmAz3cqdlpmnLtkXvDtb6y36
	 9HENKfZJX1OBgq/OV7u+7xmEWYTy72EB8JSg9LGkdyJglAYOv5rexL0vqkcf/A1HVhC4P
	 8oL+5/1NYzhttODgruy5AkyAp/aIkge8SI02lLRllYKL+K0m2waya+5eoqMJtTdX9Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tcSfZcub;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.52
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96521606A31A;
	Fri, 30 Oct 2026 12:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96521606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tcSfZcub
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLJpsXcfQatQB/s2AWy8BI0n6oqwM7ccWpKy3pshkyPTpXsoGnWPKaa23Hn7hOs6Go0V3wokUpEaOgVT2cYH8HEqaQRAlUYfMywj9XIy+f+euMw21iUoBWDuLSYw5WDD6eqyR9SY2+AXeM3SeDOUVxaaDNrW9K5sI0O7WocayAw04VXXeVL36HgXSu6hLHWinNNsm6i6ahl+cSDKPp/+YaNL+TxsD1PPJpcLT8+jZbea1ZFbEmZ1NO658cUeGDI30upZTJhosScjg1MSqmwMIrrp2Vvft35G/TSH+1WyEHzkmwrP1TGNmcAI5FsGYewJFmF2gt046gTcAeHFsGILlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDqVut/BJRXU1gELxGIxLY4RZ4C6Xa8UK9PdTi7fHdk=;
 b=OuSOCO7OL0PAmI0ikakhfYTr9xn+1w48tu9j3W3cn6ixnBQrZ/tJFDSyCZn7usRCBLasCZ0zx552V+TMc+UoGjF1TLjKTwUKQQuxbC8Jiigjsir22AwWoGxyF38S8oYDUDM2pV6D7B+1YV+LnZSfRuzmVqaU/H0U8d2vKy2zGvzwbsY4JBCD1NalPNCqqK/ejgpfFbHP3mqYMJnqwQNOx06F4f9wo2WOI0sVgICcADZfc3JeSYDf/eLxur78xObDkq863ALUjR1kH93XGVjfWu3QrFeluW+jqert1m1kQBHDiM4VSDWrAjFIYRwpenq1D2Uw2ySwQTvUFaxeaxlCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDqVut/BJRXU1gELxGIxLY4RZ4C6Xa8UK9PdTi7fHdk=;
 b=tcSfZcubF3CIEy7FJSRLpgxsLvp96omNMTY8qsp3AXn4qCxKNPuhEb2ORol2M5rT6V6TUw62EeNv3Nre+KaxNDSqPTdvpZiKxyfaEYkMdI/x2FtDLAzUgeQvDaxeodKxGHODtvd02SB3oSAvomxDo+KOxHD2CVLEY3gn2OSaew4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:53:01 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:53:00 +0000
Message-ID: <55ccb8c9-9d11-4c22-b17d-a31746ea4031@amd.com>
Date: Fri, 30 Oct 2026 18:21:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] soundwire: amd: Check clock resume timeout in
 amd_resume_runtime()
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-21-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-21-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0068.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::14) To CY5PR12MB6252.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e2cb89-ea08-4e22-0300-08df3684ba72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|921020|56012099006|11063799006|261022105027099003|10067099003|261021123027099003|261021121427099003|4143699003|261009223027099003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	UHzXWbhtXfyygfRDPAPX2knEEINi24xwdmRKS12SYDRSQgXN5rrLFLEwnrV9KxZtOstpmoiC7xbf1lNMALbVfIfkqTLk6WFX+RszrykyjFltqI2w2KTCDw9fOXolLf7UsSfnHiRl5R9xMTl+IWqrZv2qobfOhiOX8LUNFpqVMN9DU206uFQ3LZHxDsL5Rhko3Mo7SPlcKWOnl21qookMaI9vVxvkQoYXPnhVhy4IsB/UFQ4ThkNYKxbjciLCQZFWl5OKztW1pOzairsdOKT3+n8Py8bPoPG0SMRBYgydj8JUg6wQIH5IyHf9YK4MlFP3BQ0LcP7Jb7N65N36OmLK581cav8LpOdBiKqbrfwABHOP6iORp1t+6CE/SP2mJBroFOoEvYfwb6fUjRiGmxZX4o4xrnLaQiFDSY3R38uNFOXLRLl5vfHjfF75+L/XusSbptbn61rGGfQ2fIz+yUd6oISOT0R+ilndSi1wTZEKRfLuquWWgEolhiLPWtVfzmEvREU1lIbQO/ahmpkHxHqcV674m5uDagyrX+r+G980YboVK6enBCuMq7TMvsXIx1FZC2eukTPZ8x2irZhtHJAGMlQm1yfuzxoR/4D93W/TCxfTbApyeh6sBF86o/u9aEC5dQVJoqEwbLWnOvg9d0nKEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261022105027099003)(10067099003)(261021123027099003)(261021121427099003)(4143699003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWtOS1RteTh6aHljaU11Z2Z4L2pkL0k0M2Y4QWl1UEFlMFVNZmxYbHlybVNQ?=
 =?utf-8?B?clZXc2lMM2RmcWMxN3VWT09LZkVHekpIaExJTXpKMGI3TXM2OXVIcUxTQk5G?=
 =?utf-8?B?N3ZKWVdsK0hydU5saHBablNmNHNVRnhST1B1NjFFTXV1Mk52d1hvN2xSSTZE?=
 =?utf-8?B?RkllWGh6MGczd3R4ay9tKzU1WDFoRnRjL0U4Vmd5Z0ErYlRoZmxXdWVNYU4z?=
 =?utf-8?B?SU9xL2hRMHA4bmF6V0kwU0YzUjYzZ1gxTlNrV3o1VzRXRzl5V2Z1VEJYQ3k5?=
 =?utf-8?B?eGNJc0M2eWVtWDZjV0RWajZUUjFweEkwaHNGRk4zTHV4M3RIRE53NUViQVEr?=
 =?utf-8?B?ZUpSNnRQZjNtQ3l4Q2t6eEEybmttdmpBak1CU2c5eURZazhaSlZzNjVsYWNp?=
 =?utf-8?B?dFdDK211bklaa2prOXJMY2ZGaVNFWENTdkFva3oxRFA5Q1hkWFVRWUpuNnZk?=
 =?utf-8?B?ZS9rZ3pPaWF4OFFNQnE2WUdwNlNGSXNSalc3bkZsb1Jtb3JRNHdFbTNlaEZI?=
 =?utf-8?B?c3ZkZ0QwVHZoOFBiUHplTkNwMmtkTmJrOVVQU1VieEV6MU9qNWl5ZDFJeTVm?=
 =?utf-8?B?K096czZBVkJCb0dYVE5SQXQyd3ZmVnB2V3BhZjdpeEk0QXl6emVSWDJQK2JK?=
 =?utf-8?B?UllGZEtTRzBXRlBLUlNyUWhPTWUwZE1IZllMQjNoRU1TYUlmVUlTbnV1S3ps?=
 =?utf-8?B?LzhHTnNFcXk4ZXhSdUlRMVc3Si80ejh2R2t1UTkzcFkzUWc4clczdjlEbkhu?=
 =?utf-8?B?YnNLT2hrSVhianFyUXNhUDBWWWlxM2pTZ2gzV1AzY2c1NStCd2dLNE5mcytT?=
 =?utf-8?B?Z1ZKdlpsNytXcDB3dUdMcE94M1E5N0NaVno4SGlCNFVveW1vRFlReENYZTV5?=
 =?utf-8?B?SHVBamlFSzVKeWhaVEY5dTkzQ0pBUnBSUUNMeWRHelJ6WWlsV1ZJVDJraU1I?=
 =?utf-8?B?UUdTU3ZXazkxRjZ5QUloNWpHdEV0MDAvVDN2THRKWkpyZGd6U2JEejdDOExM?=
 =?utf-8?B?TWhlckxhZWRodytXSUt4V2N1Ym1FalFtNXVNb1pOTUNNKzZhdlUzNWd3MUFK?=
 =?utf-8?B?bnVpLzJZbzF3WFI1aDBmc25LZ3QzMEFiSTZIT29QMjBraFVrN3BJazE4YUJm?=
 =?utf-8?B?KzJpSWpSc2JncFg2MUxhMDhyd0I2dE50Nkp3S0pzekY0aHFEa0Z3ZDJid256?=
 =?utf-8?B?cmx4V3NvNU1BbDAvVnRwYnFWQjZCeDFxeWk2bEdPOUxRY0VxcWJLLzFPajVW?=
 =?utf-8?B?anRKRXM5a1UrbnhXblQ4YW9OOVhENThLNU1BQkxzaUpYQXFkVDgyZE52WTRQ?=
 =?utf-8?B?L1ZpRmlKUC9BWFpTTmhHV1RXVHlncmlHbXJFc0loN1ltaTFEY3d5MThadE9v?=
 =?utf-8?B?Ulpzb3FoVVhZR1c3K0tRNG9VWlN3MkFyb3FqM21NSGNTamlEdjA3WVZaWFdQ?=
 =?utf-8?B?Z2hWd2YyQlFOTmlGbmxjaVV3dEV6SnVKT3ZjS09TTzNkTzFVdG94NXhGNEhB?=
 =?utf-8?B?bzJ0S1hRaUhrRFJZb2dyME0yZXBwNFU4bit1aUtlUnJpNHZLSkpmSTEwRjR3?=
 =?utf-8?B?bXFScHVkS2VzeEo1N3RhQXlvZFlTTXhTT0R3amRNMm0vN05HNnYxWE1jeFNG?=
 =?utf-8?B?dFJ2R1M0QXpCeHhhOGNlU1FZUkRUVXRoT29Rd1hHRHhnK1o1ekZQY1ZMTFVK?=
 =?utf-8?B?Nm91dWVmTUx5UUtrckpmdDJaWUdDeVZiM2xGOWJ5MFBnL0NlTTVTdkwrOEZG?=
 =?utf-8?B?a2plRHorUjQwTlpWNjJmb0IvUWhTaCszcWVHeXQ4c3hBWU9tOW0zTGl2aWZT?=
 =?utf-8?B?NDNYUUt6V3BZUjhNTmlNVm0zYy9lWlZrbE9Jc2d3UjZuWC9HWUNURmZlZ0Q1?=
 =?utf-8?B?TVlVNlN0Q05qc24vb2lyLzY3a2pMUmFNNVd3OVIrcFlnZnArcGoyMFJjNkxG?=
 =?utf-8?B?WGZhN3BPSjlUVTlRa2FxaHNXM1ZISytMaEVNL3Z0L0hUT2lybmJrMHdiekN5?=
 =?utf-8?B?RFZWMHovMFM4a0d6dWlvWWVVbnVQQk1lcDUyTWUrTFNiMHNZMHFyNGU3c3ZZ?=
 =?utf-8?B?YmlTM0dOTTlEcjdmL0l6RDVHUEJTdmJlMG1WQ3h6aTNseHJBRER3NHpGWUd6?=
 =?utf-8?B?VjBRd3ZMRE5NQmZ5Yi9pZzdxbGQ4elVCNll0YmFhZS9YNTh0SFhTcFhTNWM0?=
 =?utf-8?B?cVF3czY5ck1TZGZIMDBDc3l4SFZVZS9TS2NKc0NlYmI0d1JlVU4ydEs2ZzUr?=
 =?utf-8?B?RUs3SUhzdGdacC9tdENIbVVDRmpCaEh5eEdPT0JCM3ErL2ZvUHo2ajhNZGxh?=
 =?utf-8?B?R2luL2M2b0J0SzJwelM5VjVJMVhHRW5SY1h2ck96ZS82cHVLdFE3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e2cb89-ea08-4e22-0300-08df3684ba72
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:53:00.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRl6ks9KNozKiic5oyiGUQfH4EdweIBYl2+g4xSHJp/Fgj3JFuGGsPBVrSXdCIu/xFcyWEPCfTrCCD+0hLleFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957



On 10/30/26 16:16, Lee Jones wrote:
> When resuming from AMD_SDW_POWER_OFF_MODE in amd_resume_runtime(), the
> return value of readl_poll_timeout() when polling for
> AMD_SDW_CLK_RESUME_DONE is stored in ret but never checked, allowing
> resume to proceed even when clock resume times out.
>
> Return ret if polling for AMD_SDW_CLK_RESUME_DONE fails.
>
> Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
> Closes: https://sashiko.dev/#/bug/linux-c6360b30-11b9-40a1-ab04-528462af313c
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index ba8e6d42c467..faff3e9eefad 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -1494,10 +1494,10 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
>   			ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
>   						 (val & AMD_SDW_CLK_RESUME_DONE), ACP_DELAY_US,
>   						 AMD_SDW_TIMEOUT);
> -			if (val & AMD_SDW_CLK_RESUME_DONE) {
> -				writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> -				amd_manager->clk_stopped = false;
> -			}
> +			if (ret)
> +				return ret;
> +			writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
> +			amd_manager->clk_stopped = false;
++

The bug is valid. On clock resume timeout the code falls through to
sdw_clear_slave_status() and full bus re-init without the clock
being active, which is incorrect.

However, we have identified additional issues in this code path that
need to be addressed together:

1. writel(0, ACP_SW_CLK_RESUME_CTRL) is incorrect — this register
    is not a plain zero-clear register. Only the Clk_Resume_Req bit
    should be cleared using a read-modify-write on the success path.

2. The same unchecked ret pattern exists in
    amd_acp63_sdw_clock_stop_exit() and needs to be fixed together.

We are planning to address all of these as part of our upcoming v4
patch series which will be posted shortly. Could you please hold
this patch until v4 is on-list to avoid conflicts?
>   		}
>   		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
>   		ret = amd_sdw_clk_init_ctrl(amd_manager);

