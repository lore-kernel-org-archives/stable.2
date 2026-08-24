Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5F3AA9F4;
	Mon, 24 Aug 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561700; cv=fail; b=GvR74fKY3gxU5fV4K2zo93drWFWHpFdxOhaiJx9PkuAUNiF4x8+MKI9S0DVDvq2G8YfHKG5d+YRS2DAN0zcNG/pK962JlaMlifSiENwc0+plxof5HOgY32SjLjEcJ2xs4Q5ZD0cUdJXd3KrIsGxb/iRgrhUq2OSylDKvho+/uaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561700; c=relaxed/simple;
	bh=p5qwGAih8gV9DgRfLu5zTvJV1WmhQMhDxZiIPyzTi28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=APinulvVbC0epTT7p7RHrCvH7bRzqa3nDzilRyxWWi6y25Z9JE9m9OGD2jzbe7YnRnlfPWlsYDO2CxMemtmd+JfGuI4/wGD2iGFOZFRMAoDCb2+eI01N3QHc01m0pswjQbBoLrbtdQx199Q9BkEcH4yItK0QaU9zQgsYqYbcK/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uKVng4av; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uKVng4av"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF1nAFpiD4VD13rpMkccTf9m3skHFBxXfolkbQCxdSXRNPomJeE2SNCx80qHtVQOc3TtCRFPW8Kr7Oa8edbSaiV2YlqY0FCM182+Io99YsCUi8xoivyJcnUx7M6czpODz2Pyiw2jfZX8GfIdW5m+UB85/hwSBCK/+4zulS936YK1yhHKFIv+E7rFlQdpeawV93LxWOE3e4AJX3J9OB29xoQf4mPUIZ12VtuWwPY4NIQcK0iobD6bXeBKxnjp/tvug1qtihVO9W5dLDUBuUnY89M/NLv+PeN9lBMtYPQfdY0bBtjEDs7YoRMrPpVHY9sEmN4gXz2HGwBeoGXkAdwKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ikq9pICt57PLaCUK8RxlkAdC+dZZ1GwGFh5aj36puRs=;
 b=Er63nKJK+xziQ27tDeHIAkKrTHqYdHCmo4pkfp4MQWQsoM3+PElSjbuKpQRdDozEF9Gpx2zC3DOPL/WJekXrRuHoxaDOd0km2f7zM0yKiAZKajOro1ex4EOQZRYpaFdISuI3t6FuMECz9WOoSuGXMNChzv3A3sbRm1JH9CQmp1098Pw9vtdDAqYWYLTVSzsfDdBuB7h/X1+NCIunvDJzLzegH9BH4/vqnBJ8jyTG9+IK5Xdzu8UetZppg6iaYApFFnEskAKEXZ14m03JJyJiUj6Y/FqsrVCrpxURvSu8aCALbwVP67szrHiCStHHY9oB3JK1gmyM7diteLV56GfMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikq9pICt57PLaCUK8RxlkAdC+dZZ1GwGFh5aj36puRs=;
 b=uKVng4avT94G2lELWvpK+BoUwSQOgvvDVTNjinj1lkHsbl2MsOZWN78OuCHy9CM5Aom7ShfrmAFrAfO/ApNzCTQDoj3bRmue20YF1YX5rYp26x87kELuaZ71tPgYnYbfct17hhEwwbVfN39f9oedSuQSUiThadye6fN/DGSEpUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 08:54:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 08:54:57 +0000
Message-ID: <3a1f539c-7abb-4683-95f3-85869e6bdb37@amd.com>
Date: Mon, 24 Aug 2026 10:54:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/userq: hold the doorbell xa lock during
 hang reset
To: Junrui Luo <moonafterrain@outlook.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 Yuhao Jiang <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
 <20260817-amdgpu-fixes-v1-2-36d5298da646@outlook.com>
 <88BAF3AF-0334-41CF-9954-66AD5E0DA823@outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <88BAF3AF-0334-41CF-9954-66AD5E0DA823@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3652d795-d5cb-4780-cb32-08df01bd5f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lZAi1qBIhNHv3d0lwI5qnJVVB3/+V6mWi4LBJJfhGGF6r3b0401EqTfpgRnLhuk+h0DHn9ejFP1iCZlJpUhas5LRFyzFyUwslTKI2Jp4pk1aBW0aJ/L1thoR94JXsJWzNv1Tn79ApZil1T4YiBbHohnzdXMRqAEvbPRBsj2/qnCPDhTxAUzzu98P/EBMscYIsY7fLl+Wh1RpY2pQgqhXQo4Mz+ytBAqbJVuvlCOpJna8J7O7fVjsVAxFRB5lwxDq0PuJYmV7qoDCIjt5Gvo6qd+2jgUSEIjBKjB1ModaEap5FPpxVbt/9ZX+5lS09AeWBGVqu5C2YLwKcr9hzw9XwshZG0aN4HABJ3EWrVU9hCR9UFjA4aLLPQgDdKzy//FB8mUSbpTxPmDAJ1kgePEwIJehbYZKgdZD1Z0JgcAS4OmZZh7LnUIRjHjGP72jNvziMej27qkSiG9LSoFm3x2sw9mYvlDuSmP20uGwpY7kG+/P9TYf9T44rSMEt168Xog7c2MNbw5IxGICFSu9FdeHfEYzdLQncYlsH5Lgd9paaLIlUjOtpKt32PNn6089gHeWm4tPwXIS+/+HCDkYPJ4eB5hgcNO3RQodSPIVzD4bEB88dhD7Eooxc8odKnkh1VhQLW5p4HCZrRYG6CL2g6k4fpBB2DXqjv44dQhJ6lf18ao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE1BaUU1SFBBSC9tN0t6Vm5YTmhDYmJydGxYMUdaTUhEZjlKQWpiSXFiYi9E?=
 =?utf-8?B?YnA2eDBCamZhQ0E1TktVUnVIMzhSMktiZ0lJUnBHQ2k5Z0c1Ym5NL2h2YTN6?=
 =?utf-8?B?RWIzSlFlcVpCOTJySWJXV0luNjFYaVpQNjFFa0hnWFlRQ3kwTGMzNVZ2U1ZV?=
 =?utf-8?B?NHQyTDlZVVVPQXNjTUpEcVBYa2NlR3VOZUF3djNmVktkVVdLY2F4UFhpU0Za?=
 =?utf-8?B?Q2wrbmRERWtpRHIrYm1ISmJDK1poOHBtTjdMRGhTdGc1bXZYMTRlQjEzb1Uw?=
 =?utf-8?B?YmJMM1JWZmlCWFVpYU5KVEFJRFVFanE1Y3BHWGRwVGxta1ZhSGZ3ayticlFQ?=
 =?utf-8?B?K2ZQMWovU0dVdG9pbjAxNzQ0THVPU2VTOU8wVWc1RUE0ZXZKRG1DbjdzdzFL?=
 =?utf-8?B?K21lNXk4cEtHcytpc2xOLytlblJxeGNIOEw1N1F1WHgvS1pKQWZJV0RQYmtX?=
 =?utf-8?B?YVRWS2FEZTg3Tm1GdEg2YzVJemtMSVF4MTBIZWR3WnJXOUloTFEzT05FaXFI?=
 =?utf-8?B?bjhhNkJrbU5Pd1hmLzZpOFlMQ1lrL0N2U3FBcGl5ZnVpVkVCQldDY1pQYTls?=
 =?utf-8?B?cGdwakVlVytqR3E2Ym1KRStweHVLYWxhWHBxVHZvekVyK2pGY0RqeXBWSlgy?=
 =?utf-8?B?WjVVOFJuaEMzamdQUXlMc25jd0FMQTZ4Rk1YdWRDbmtrT01DcFJnVytVR1cr?=
 =?utf-8?B?OXlVNWd5TUhBelFxUVJRd3hoOWxOY2g4eEtHOHd3VXhzWjBKSXlpSGNUaGIw?=
 =?utf-8?B?NURLaVdrR20zdnVSWmNDelZCMDhOQ2ZwS1N1UTNUOHZzTmdKNkZuc0ttM1Jn?=
 =?utf-8?B?ZGhFaHh2MS9uTVh5UmNhK0orSXNGS0pCOUU3cGdWS0xjNmJncUMwMU9wV2Jq?=
 =?utf-8?B?eHVEZm1CNzVNSmdBbFp5bW0yWVNvY0xrdEVPSjhUVElwRCtFdlFhRU5vQ0RS?=
 =?utf-8?B?cTQ1UDRBU3d3b285cFF2Tmd3K28rcjk2V1B3ZEZST3hZaURSbDFXUEsxdTBl?=
 =?utf-8?B?N2o4ZTBLejFBdmRiSjAvaWZDaG9HTzVhL2pySXFGeFpnNmJmN2dvM0loZFl1?=
 =?utf-8?B?emRveVB3d25FeVB0azl3aHZaQ3VNbHlvTDFQZUN3VnNldFFUK0tzMkhHUllD?=
 =?utf-8?B?eVRCQTF2dFZueStLUEk1Zk9ZbzFOUVhnbjBSYWIvSC9aRHFQbG1aUlhpa3Za?=
 =?utf-8?B?TlhrSk0vQjNkZ1VvaUgySitJS2ZKSDFKY3Fod29yQUVLaUtCN1hCME44b1dY?=
 =?utf-8?B?Nkh6MTJKU2tINTMvQ0drY0lsZTltTDJzSUFqRVowNUtwZHdkQWJkN1BIQTdS?=
 =?utf-8?B?SEF2T05KYUs0VXNIdnE3QUQ2R0lMeGJOdWhQUjB0aVp1MzNmNC82UkxKZjRQ?=
 =?utf-8?B?bFJXaTZyQWNsNXVnWm9vbU8wOVRneENQeVNuR0FYVENkN2VNZkkvd0VVVkJF?=
 =?utf-8?B?aUNUVG54bDVNajE2ZUtNZzJlVnZrei9GOTJ1NVVhRFdCUFpPbUhTYWJqR05D?=
 =?utf-8?B?SUJqTytNY3FsWGN6MXo1V3FSdmpqaXJXazZYdTdOVktPNDZiRUo1U1kxclZ0?=
 =?utf-8?B?dk1ISGVKOU9yRGwza0NUd2hKSGkxTENBRzVDU1FHRUVKTG4vZVFMNTJpeEZV?=
 =?utf-8?B?U3BDQzlTRXRMQ0FmbnBBdEY2R2NuRXRWbG1PbFdKS3FVUGJ2NEpZbmVwUWFs?=
 =?utf-8?B?MnlCY3NjejEyNmMrcitzak1ESStScmtLc1MzLzI5OFRMMDVIUFhwbkt5dm1F?=
 =?utf-8?B?MXNGNzVaNmtnbXVkRkkvaGZ4NzdVRzFnVUZjVUlaR2tyQ3BRL0FCSXN6ZFVR?=
 =?utf-8?B?VGRxWEpTcUhmT0FKL2dkeGMxRTNFR0N0VDF3cktlQytBaGxFbVBpNlppTVNL?=
 =?utf-8?B?R1BROS9tMjliOTRESitPdlEyQmN1L3A5dHBVZ0NKL05NM1ZENWFlMkJsa2ds?=
 =?utf-8?B?RE50QUc4QkZjNTZsYVZ2bTRub1ZsVHhPdkk5dG12d1JsVWkvRTlUdjFxRjYz?=
 =?utf-8?B?SHVLajUvaER0TEd6c2Z3VHdCSmcySVMrRC9MaWtwUUoxNGdKWlA1TlFicWt6?=
 =?utf-8?B?enlzVVRTanArZFo5N2h4ZGg4YW5uOWFLcXFoeVE5cGlDalRXbElJQjZqTE5s?=
 =?utf-8?B?amJwUGNjbFVGUUlhSWVaajFVeDlIaDE1NHhraUhZVnlYYmZsZDlLcnRjTm5I?=
 =?utf-8?B?Q0pLT0xUSmpQZERXbEJPdTEyUERXWlFMd2ZyWE9MZzl5ckRRVHUyZFN2dHkv?=
 =?utf-8?B?UDZ1Ti83cGxxVUJkUGkwdkJnbGV3OWtaUVpVMmN3Vkd4YkpuQUIybjFnWFFY?=
 =?utf-8?Q?G4K0lY3+CVvvFBEzaW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3652d795-d5cb-4780-cb32-08df01bd5f2e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:54:56.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F87iTs2A6nSUVjHiFacmEntv/sPp/vCFoe3BRx/rdorC/LVAdiQK2tIxv92WtWMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774

Hi,

On 8/23/26 08:02, Junrui Luo wrote:
> Hi Christian, Alex,
> 
> Sorry for the ping.  No need to look at the patch itself.
> 
> I would just be grateful for a quick word on whether the issue it describes
> is a real one.  If not, I will drop it; if it is, should I send a v2?

as far as I can see it is completely nonsense what you try to do here.

The fence_drv references an amdgpu_userq object holds are the ones which the queue potentially waits on.

When the queue is freed up those references must be dropped, but that shouldn't affect fence_drv->fences in any way possible.

What exactly is the leak you are seeing?

Regards,
Christian.

> 
> Thanks for your time,
> Junrui Luo

