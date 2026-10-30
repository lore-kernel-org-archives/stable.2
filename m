Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793365180;
	b=Id3v4GVq9lD/pMtymkvGN6CF4FaiwF3hzoQFsc39TAQqFCO2m2J0T7gvjd+iMXRHm1iF
	 8L6Lv2zknVov+ClwF46RUYu+epc49hFi8gMY7DoZcT52EqlUgb5xksGMz3BepbZvRR9mU
	 vVpAHCGvcKAT3QzqFkHWuTgVIQfCp6Cj4JkfUe0ztztUlUsrrPmiDQry1sBFz+zV1qAAS
	 hbmGlZMGF2pQ3KzJevzg/ROq8u2bACr9y6A/Kw0jMeWaMdnKs/naT/z11jiIAb/4R46Op
	 vVqyT5OGqIAAKPW20sbhxd09PhsaUr/qdIukHo6NjVQrqFWHWIO0yYMlnE3WCsZRmoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365180;
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
	bh=BSrbTYR96F5BmhGdHItS0iV4DwSNI6PC70HOnWMlLsM=;
	b=cSDjOzqQ24vtqnIpoVDmc3sSNz1qVOa6676SfoqEv1QgqXbWZRDF7e22TDnWAYzyJUKj
	 cgYsG/cgpnxhGYLHQHxP0i/TmS9JkbVsJ30CRCwNLGYBV/2jtfqa9AND6239pEyIKaeOZ
	 K9sOze/6FfSVCQRiKOBuRLep7htgC3065r9HNuc9PC0pNQYCci1T/rtY+xDu7knBBGP4E
	 URUW/grkDtxuVtrk4u+HzWK8x5JkrbzHJLGlyE2xf2nTqMYJrRV+3SmS2FbVHdcw/5KnH
	 gSXSCkacDRtkw1X2+85GhiifBgAbqaxlHuMToO6DrysPD9XjF85bWmsul0r3LQnCquw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T1KoNi0J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.5
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763B606A32A;
	Fri, 30 Oct 2026 12:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B763B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T1KoNi0J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyiRhLfELFjAROu/ff1aCdWxH47uT1GOmE3BvxQilgG6yZSIDryZJk/kO1476qRoHloBmjmqQpirSUhcUPo+PhGFSnHlOkZp+MuP1aecHMhWlLr96AGDdjVePNImXFBL9uFRcG6H/IckE0li27WhscSnFJAWhGGnx4nBeB1XEzUeCKa8z69btiryI6wMHSTl2/9AHPr3ks3P009ZeUB8eOQZX/kl8MlaE3r3VuUK9eK4FwVHXsFDIZi5eWJN/9xpeIEcaLHPDgwKBgRjFcHgyh3oqlU128sFK/5Q+xBysZT+/K+fVeYwI7Ymsw/ScJ5q8QGVtUSPCfximk1NToGtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSrbTYR96F5BmhGdHItS0iV4DwSNI6PC70HOnWMlLsM=;
 b=uPbLZMXa+kcrDO/3bpl6OA0donRfBSwwDEF16EgEJgGGFO6AQ+0svIdXHgl/qiwbdwqP6h0XptTxobnSqwJNlwCsdFy1YYLNH+CTwW+8pM+2mWZwqsdy8KALny0OdJmP3xyOVDvOIUI5yD0KX7xjlpliGgSFMRDOcChV8t67ebZE6nri/dL7zver5rO8As9w4m5EiCdXZT6IkvhnYQUzFy/5TXgvueJMw0WotTLHQxV9QEoMUhmnnIO6c0aGAdbCbjXCx2/VagCifCJCFbqf091Q6FcC0QGkiO1YIdgk2UvrtG/O5DTETF0dGzWhrrMPzYFHD8NBURrRBRL3mT0irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSrbTYR96F5BmhGdHItS0iV4DwSNI6PC70HOnWMlLsM=;
 b=T1KoNi0Jn6VHi8db0/GuzVTYrtqoL4PgyXKrJJoTB0Dnygq/LNi9k+PkJnuuy0EnVx3BsG41d78I9V+LWYpVlAQwSP1v4ktaKaYdAvAihOo8RKyoortTGIYvpq2MttmBfQi1xzwRIJk8Iqb1b4sgg/lilLgjKb5xG3dnDURNosc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 12:59:34 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:59:34 +0000
Message-ID: <48141b99-f1da-4582-b784-864148072d82@amd.com>
Date: Fri, 30 Oct 2026 18:28:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] soundwire: amd: Disable interrupts if enabling
 manager fails
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>, "N, Poojitha"
 <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-22-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-22-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::34) To CY5PR12MB6252.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: e58f9522-7ecf-4ce5-fb88-08df3685a506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|921020|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	LRU64goSMvkQnlHJpxMq8rXyNA8gUGphgYuZCTNJOUz6j0EpHm3Gz7/Kulb1XAR8YzuTxHuj0TXQBa5RYUjQP01It36/fNSM2nISsnjDgPqAxhhGC+RNp3/zD3AeU2O3mOuSvHL3fo7oWvkwB+wkyDXcoZu+FFtbzyWPxT/P2rMcdIgAJmxyZBU5LT2JPAlt50PV0Qgz1kDA9L46xEUPFevjVbjQvP4pbo+iSh3PhL4eoqN8o6kORvceM2PF3IREWF9zUhJaRxIXqavo9xQ+GoZqFHyIOMOJS2wEwODkbipj5i6JeXyqxeiUq/U+Gdf5GJ/8mAJ4w70/HvCvH5yLwvYWDuju0Z4hUpQSZal3q5WvUyGqbF+v15c9IiVJk0PYwn4Li6VwKkPpWB4sFbyER8aT+LCOZoiy2BKriXD/X5Nng9euoxMeHm3WrF6gdS6b4lZQmtetqcud6P1l8YbWqpYQrGnnvKFJThtfwyHHW0lcjnhg+fYXoR1yr3i2SpsjA/H0o2surjxJoJqlWqxYMBFCgKVJsAKejXFsjNnfJNoEczLD68lRTHHrCLq/O5lM41p8bsZHNQXep5REdMFJP9vTFdartAOOjUqGrJDTRwcffZLUR9egiYzd3fubFOt2BLcWnnI6eEDepO2NqXF80A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWRGVHpOa3RKR3NWTldZOHVldVRFejcyRXNVcWtlSU1tYjJZUy94SjUxK2px?=
 =?utf-8?B?SFJTOFd3SUVHWWtWMVJtZXdXdUxqTGoxZEk5OGExMlh1dlh4TUNla3J0Smsx?=
 =?utf-8?B?RTlWNGNvUEZpQ0lpT0Y0ckZsSXUrRVVRMWFMYUwwbk1ZK0wzMFRhZW5PdlVU?=
 =?utf-8?B?bmxkTmdSbzhsR3BmaUNyRURUaWJ5WnMvVlpKOTR0WjM3Vjl0NllLa0xYeHYv?=
 =?utf-8?B?ZEJPRG9WYi9OckFYdWZNdTBYenI2b2g0VWZvQnNzelU1emhNNE12SUxyYmpr?=
 =?utf-8?B?ZTdpclpNRzB4SUc4aWJqUlg0YWUvWUZVMHJ1RHZ6K2lpRW0rWE5BeWh1b2Np?=
 =?utf-8?B?WnpGclU5eFJEZDRQcG9oZVhBZFYrVHEzL2hLbEJBdHRmMHBZOEVXUUdETE00?=
 =?utf-8?B?ZDVRb2ZGS3o5RTkwaWlsVk5UdjNzOEpsclYzS0lwUlhmRi9GNjFnL2Y3alN3?=
 =?utf-8?B?ZWJOak9hQ3NqcyttakhhUm50a1RrajIxMThVbG5xbkZTOWpQUERWR0F5TE9v?=
 =?utf-8?B?Y243YjhuTldTYUxkVUx1UlV2Y01aYWY5QkE1V284OTdwbkZFcjNyQnVNWnlY?=
 =?utf-8?B?WWNheUdKRUxJNHo4NzMwczdUWCtIZzFjOThvc1FtRGRRcCt0ZkQ4VXl6MkpV?=
 =?utf-8?B?bjZleWdVZVVXOEh3UThtNDE4c0dsYjExOEYxRHZEU3NhL2dBa0o2ZFI1OHNh?=
 =?utf-8?B?MEdRUGRCMjRqV0RGQ3N1MytCTzI2MTVST1FsRVZHeHNSbTFoeXdLOXhHTFVL?=
 =?utf-8?B?OStqNmNlNFRYVUE2MmZXWnZBeXppYmZ3cFprTW9zUVhvUzVabXR4eXBCNW0y?=
 =?utf-8?B?K2RzMUVTVllMM2l5UDE1U0Erb2VxTkoyZW9mNVg2NVlvSW9LOE00T2k1SkZo?=
 =?utf-8?B?Nmw3amRUc3ZvbVdnM0VIRHhxSXVENXNwK0g2Y05QNXZsOTJ3OFM3UXlEWU41?=
 =?utf-8?B?TmltOExWVWFaUzZvSEpKbUpzTG5TVEZMS1Y0MHZ2L0VMdTYzNHRUZHJsVFRj?=
 =?utf-8?B?ZkZIOHJIdzJXaDhxZTY1Q204NCtQcGVQN045Nk1pM2ZiaTIvcVcrNDZEYnR3?=
 =?utf-8?B?dWVyamFmTGxWNlVsNXEyMnRDMjI4SElQaUIxZm8ydkpPd2NoNzNBVXZFMW9B?=
 =?utf-8?B?c1NDSW1oVWErNlc0RnliSDhJdU9ISHF6Z3d1N3Y5dDE0Q25zbEd0U3VQM2Vu?=
 =?utf-8?B?WWFBeGdyalBzM2xYSSt4SFNVVnRIVS9xekFiSnJUWGVLWjJZWlpTTTJvN1VL?=
 =?utf-8?B?enlobFdDL09xdGtET2dRK3RKblpBRmlNZWgrMTZqTUtQSE1uUWtQcTZPQTd4?=
 =?utf-8?B?L3BGR0RvYUV6WGdTbGgzbnVIM0s3UThoa1U3ZExMNjEyVnVGcStEaTBkWWNx?=
 =?utf-8?B?VU9zMkJGNkdHVzRNcEhxa2hnb2RuQkpZWThCSCthcDdRbEt2cjRjZHhHdmQ5?=
 =?utf-8?B?R042VnpxcDN0ZHh5UjhZQWs2NDE5dUlyRGtjRGw0U0hKaHhQRDVjdzhsVXB6?=
 =?utf-8?B?dVo3U2RRUnlzSjQxdS9vYUN5b21MSWRiMmg4V0tuZXhKWnhrK3p5Tmt1ZkFU?=
 =?utf-8?B?bFgzTi9RQi9DeUhCSGFYT25aai9reUJtaVBxZ1VhT1J5elpSRm8vQ1MrejNU?=
 =?utf-8?B?dVZvc2NoS2xYNTVPMkRVeGJEN2JORTV3aUxrYjgzTC9mRmJOQzNvajFIL0NV?=
 =?utf-8?B?TzJ1STJMYUd5d21RYVFqRDIxa3ZTQm9WTU9wQWprcHdpWTA1NVdpT0ROZ0Vl?=
 =?utf-8?B?b1NrUDNUenZCcWd3U3N4M0dRTDBLZjVLTzFvUzRzRWZSRng4blpUeitZQk9V?=
 =?utf-8?B?dVFRNjl2Z0VZQmJkZzM4UTZzTHlseGZHRWdCL3RxbmhNRGgzdUNWNDB6dkNW?=
 =?utf-8?B?OWxQaEFncWRMQlVYQ2ZMN1RBS1NDck1YanozMkJvUU10SExhZzVHRjBMaWVj?=
 =?utf-8?B?K2V3MngrSnJqYVF1S2NMRThkN05Oa2xERmJIZVdNNkMwb2xLbWNubUt2d3lX?=
 =?utf-8?B?OGJKek91Mk5LRWFEQjZwbTdJZGtscnlKdDBZREt2eWYwYTJTU2NrVzZRcDNo?=
 =?utf-8?B?UVhVTkRjcitLekFQOUgzb0xxejMvUVlPK3lWNDNyaEU0NDgwbXdMNTQxbWlW?=
 =?utf-8?B?K0NYMWI2aVIzVTEvWlF2ZlN0K0FVQURYNnQwSmIzZE1rc1RCNFZIL3hZbnI4?=
 =?utf-8?B?SlNWU2hXRUNTSVgvc0xqWlBNV3J1aCsxUi9oZzVOc29WeEczNXUwdExMSXFK?=
 =?utf-8?B?U2ZjUlI0MGtUMDdkK1NVSzNJVUIxRFoxZW91ckx2MnRSdFMrRXVDUWc5NTNy?=
 =?utf-8?B?U2pOR2F4UFRZQWhTQUs5bUxDaU1EblZlbkNRTFQ4ek9ybXlxRXY1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58f9522-7ecf-4ce5-fb88-08df3685a506
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:59:34.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hnw1V5+iMrcBMT/BYi8/CUwaQhmoRUNOFaEnKdCk9R5MXcv+ZznD+uZhDasnNrB7IpOl8C5wpDN9cQ4u4MlLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028



On 10/30/26 16:17, Lee Jones wrote:
> In amd_sdw_manager_start() and amd_resume_runtime(),
> amd_enable_sdw_interrupts() is called before amd_enable_sdw_manager().
> If amd_enable_sdw_manager() fails, both functions return immediately
> with SoundWire interrupts left unmasked.  In addition,
> amd_resume_runtime() ignores the return value of
> amd_init_sdw_manager().
>
> Check the return value of amd_init_sdw_manager() in
> amd_resume_runtime(), and disable interrupts if amd_enable_sdw_manager()
> fails in amd_sdw_manager_start() and amd_resume_runtime().
++
The unchecked return value of amd_init_sdw_manager() in
amd_resume_runtime() is already addressed in our v3 patch series:

https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#m7741edcedb1264764edc7f8559e39af8b23433fb

The missing amd_disable_sdw_interrupts() on amd_enable_sdw_manager()
failure is a valid observation and will be addressed in our upcoming
v4 patch series. Please hold this patch until v4 is on-list to
avoid conflicts.
>
> Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
> Closes: https://sashiko.dev/#/bug/linux-309820e5-f754-4d3d-80aa-7f70d59f3e8e
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index faff3e9eefad..f64e8fea7e16 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -1109,8 +1109,10 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
>   			return ret;
>   		amd_enable_sdw_interrupts(amd_manager);
>   		ret = amd_enable_sdw_manager(amd_manager);
> -		if (ret)
> +		if (ret) {
> +			amd_disable_sdw_interrupts(amd_manager);
>   			return ret;
> +		}
>   		amd_sdw_set_frameshape(amd_manager);
>   	}
>   	/* Enable runtime PM */
> @@ -1503,11 +1505,15 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
>   		ret = amd_sdw_clk_init_ctrl(amd_manager);
>   		if (ret)
>   			return ret;
> -		amd_init_sdw_manager(amd_manager);
> +		ret = amd_init_sdw_manager(amd_manager);
> +		if (ret)
> +			return ret;
>   		amd_enable_sdw_interrupts(amd_manager);
>   		ret = amd_enable_sdw_manager(amd_manager);
> -		if (ret)
> +		if (ret) {
> +			amd_disable_sdw_interrupts(amd_manager);
>   			return ret;
> +		}
>   		amd_sdw_set_frameshape(amd_manager);
>   	}
>   	if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {

