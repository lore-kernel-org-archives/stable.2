Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361488;
	b=u+3O1WIxfSfBeKsn+yGpFWytTlzWhbhAyrm+uKLdlXBNGKhZO3QZFgCfkX41hCTa2K9W
	 X+dToBY/JBC9dC9KPVM8f8uBoytQD40P5++oPqXxynYuvJ7PtP4tGyHiSwoRvrX5eZ5uC
	 +bqAlop6hN0Fwx793iTBhjpOWYyyuwe61fX1zxQ1HeNYGGFAn/wFIQpsUU0W3OkiE8XOO
	 04j181kXxZDYsRGw7uwPUcGRD3rFdE6zSloWF9OzrkMnzw5mWOOc1ymJ3vyge/XfCqPC3
	 lK3iM5XWW94mwIUlm4iUq7x9Q7x2QP6UqVKT8hi0kN1FbYX3MY/eSf8IogPUeW9Jflw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361488;
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
	bh=WzQAFx7x7Jx3ZnEm16BcJAd/CNJAmM1mh7mCWc8K820=;
	b=cBsC0z3LQ/vZVzPiEOZ/parja/J5a4JeLx8XWZ///63YHjiBWtahhRMjdASo+6Vu5WEn
	 53mzhjTbVxogjHfSZDZ2FZPpvksY4Xz2/UXGfN4OJMmGlI/Ud/obTbFW7BmPAyGgppzFu
	 9uR09WK+8c/JyF5lkeOmbiVVA6ihrER+X5qQpMNUsExSE2VE4TXq8tHj+GMYCCYZ4c52B
	 78DDrFco5rUfMXKviwtYrBhkZW91IUqNW2Joa/O+qM0mtodgQhI7O5QqD49xhkGieeB2n
	 a8EK4OeoDHKvvStR31xtQIe7/EemlYxQIpKeJDf27bMm54STKoeSQowB/JJ9ZEVI3QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tvEDazSQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.25
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A5F606A31C;
	Fri, 30 Oct 2026 11:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tvEDazSQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBe/XFY3XssG12kD3xIAhWYMTC9dGJbURNdCN0GBBWhcYAkAx4+v2aiKLX5+vHMj+lMvaYBEXGLpNdEpnMIdGTS0udJMw+LdngT446OKgiGs04BpY16qLjhhZ7DOKx9tAJn047VHEbmaMcdd7l1FOXxVeIz8RO2Rfb2JWUa7IYoxwnSth8Lp0I7AhtXxrLgThkQ/eejdUa1iPnxxGNSFgxguytZlR2zXGNqVnVHcNPPgHBV2UQcJ9Ux0HRJGizcwhrqqkxzHwqfSzcZJHi4zQb3Md/K+y4qmPmRx4IobWmeccFIG6PPwRJUNmEmsoMRB1/MgUL70X063wIb1KXJ8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzQAFx7x7Jx3ZnEm16BcJAd/CNJAmM1mh7mCWc8K820=;
 b=Y87xQpGPNg91pdVvR4Qzxlj6z3FpjD/Hq/uJFf+5/SRZjdZ1905/DnPj613vdFobodAuCoVrwxhUApI1oomrNVXUspPIUDxB4k8TtIbhUAFG8KSStUPN0Ol/I1ix08CNcIdc5e5wFfifEp2F0U0BX2nIxpmdFG0gYRwUrcKolCI7FLLFZF+gBPt/QwYVyYxJd430eFv3TvevgXDkmdsZSTiX+31XQfAcSTXhCryhWj3iZlhLk7awby2mJ04Yb8wGrFlrdrRJKQYprP+g2IrE5GrWkqId7FplC9sw8KxX7eJNeMYsO7Z1/aCnF8KQFrMZervhK1cTKGk/G6Cx+T5fLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzQAFx7x7Jx3ZnEm16BcJAd/CNJAmM1mh7mCWc8K820=;
 b=tvEDazSQg1AzYI3+Id36z6y1HDsXPWvMdjMrkcsDozSKVIcYFej8eMoqTXfXQUkmVCoThg+1gGU0tdFGNB2Be9UpDrZPT3d/BtSVfulxWh4/FFRGQPJL7EsNw7PrAab4+RJ1ypfPEkt7lxplCPj/M7/FVrTLCaLlgVqailpEEII=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:58:05 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:58:04 +0000
Message-ID: <bb7e2262-af12-4891-9070-74058812d5ba@amd.com>
Date: Fri, 30 Oct 2026 17:27:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] soundwire: amd: Avoid static port offset leak in
 amd_sdw_compute_params()
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-16-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-16-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To CY5PR12MB6252.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ebd79c-c1b6-4948-6ab4-08df367d0e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|921020|11063799006|56012099006|4143699003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|10067099003|261021135927099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	ldPjVSDo0NFBdE92kX29gEhGUBwHfLxOF6vzvXcXzpdv01JZ1UbcZNW3JauqPeqir55kYTarU5fK28XHsbINQt70MYzIvFnLcGWo5Y2a+AGK1sr+fBjDmwQRJUe328ZOvx9vArg/1jD4G0Rj8WdKnFKc9zptZ2KcbNUf8c+naN6wm8KswfoYHd+mZa/wpDdRGAXSb7wSHARqz4h6JJ3mi0t4nxNHXXEI8XEciviqy4crfumryCmswG6WYYG1KZ38r0cxm5sQilfGK9dka3oHrqyX4PL8tGPjrZNLRcQ+YPmaZcmEpi17gX2tmkowbBDD9DuCon8Miu6SOaPVmGKJ9qcMkeVZb9ZOKW3WU1JvvxFT2M1JbAr7hhaEXcSyBeO9zSpZdQz5c7/wjq3/54Q12VGMVdK0v6dd7pitu4ifoDM6W1PizpGQcMyLNIymX130LqobNPAgbd9YuVaUl5LrXS9H6GX9bgJ0IAIiSN0J+sFUu24tQqM1b30xHokHGmyhFCBEaGnRA/Fy/lkaG/se/FriGgOnd9L54Bpn3Cjjvufikym4+PAbKmo+2K6gYFTG61B0o1PoIdlbmCBDjxw9EPz+7LXxpH5yKtFyKgqRgfrc/fRqfUnT3hDRuavEplcGpxGH6p3fLG1ir6rQ44cznA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(56012099006)(4143699003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(261021135927099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnBpM2lTVFNWTHVQckMyNnJHb2xFZUZvS29CbFpNclpEZGJmOVA2RjB4RDUz?=
 =?utf-8?B?MjlRa1M5TjZWdzhFLzRLRm9tQURRRjIwM2FoRHJScG9RanlJU1JFUk1VNVdt?=
 =?utf-8?B?aGZFUmFpUlFzd2VRTXRzaURrY3hPWW9JdFBPTDRYYU1kaXlVVitrYXNBMG4v?=
 =?utf-8?B?ZTg1Q01jWFhiTTBOWFdaVXB3ZVBZR1FWdXcyemZmVi93ZHY4a0pmekZZRDVE?=
 =?utf-8?B?M3FnbmJUejZOQmFDemRDWHA0MzlVdUFCWWdXaytxcHkvVE56RDYzNmhDbm5C?=
 =?utf-8?B?d1RUYmZxdEJ6d1BKaFVRM3NPV3oyQ1hzSkE2TDY0allUY3VONThFWEdtcU0z?=
 =?utf-8?B?aXg0Tm4yT2tjcEVYMHpNaGVuVDZRTlk2c2hyTGM0d2ZvMkRBWTdHZWw3eUg2?=
 =?utf-8?B?a1YwVElCbnJzYldsdys3RHlQRnBibnVYN3NxNnBlbFZ0czNPWUk2RkhxZFRS?=
 =?utf-8?B?UCtLY3ZtV1duTG83VE9iL0VDL3N1Q0JrTVVCa0IxVjkwYk11R2xyTm4xOU5C?=
 =?utf-8?B?Z292SmZkNlBQQkZWd2RxWTl4WWxHMEpZaXBMMWtsdTJjNEJCSGRqVUNFRWs0?=
 =?utf-8?B?TkRSS2lSbmwvSVQvWkY3OEY0cCtnVi9qV0FEdTJWcmljeE90TFNiNE9yNFJ2?=
 =?utf-8?B?MlQxbkd5OHVuWmZTRWdhKzZnTVROd0lKY2lpbUxyWlFiKy9JYjE3TlllU25Q?=
 =?utf-8?B?SEdtbkQyd0JoVGFOZ1NyL3R3Z29ZUmhmWDJkZ0grRktLbmZ5NlVZTCtHMHdw?=
 =?utf-8?B?MG0yMzJGcXBPUmNKUTdMSlovSTlyajdTZkpGTm1WdHRmN3RKMVVDeERvMXJx?=
 =?utf-8?B?d01UNTVVL2lvV0t4OFIzWC9JRTkxejgyK0tWenQxYSt2ZFQvaWlMY3B4UEs5?=
 =?utf-8?B?bjVLTld2UmFzNUdkTGFXSWNEQzZicHFXeVdmSVY2M2ZkVXRzR0M0cGVwUEFW?=
 =?utf-8?B?WG5uMEtlRFV1QUkyZU9kdGhYWnJvZmdFUU9pM0VCaVNnNVBqWWYrNk0zMWF2?=
 =?utf-8?B?cHA5dHFjVlowOGluTFl5UU44dmlrK0ZqS1lkdXA3NVlhWEU5c0lFejMva2NU?=
 =?utf-8?B?eExkL2Z5UlBYZjVmRExHa21HQlI2c01SRjJmdEsyeks3cDZkUVNLNUU0MTlX?=
 =?utf-8?B?R1pncnVrMHBDbDlJOUwvYWJkVDV1SnVBc1N3NFp6Z3l5VXh2T3kvN1hWZWFG?=
 =?utf-8?B?RGRJL09GdWJHbS9uN2ZsV2Z4UEkwV3N6UTdhU1FaZ05VWnA1UzRqQjlzUmhY?=
 =?utf-8?B?ZFNSdmdOMlU3OVBQdS81bHdBV3RSS1pLNmFrN0dIbUhqZmR3T05DMDZuNU14?=
 =?utf-8?B?ZXZNbzZWVmxiVThJY0ttdUJ0aGw2TEZ1cThJcFI0b1JpRHlnRTA5d1R3UjJ6?=
 =?utf-8?B?NEkzeFFmS3I5NmFkZFJNVTVxY01wcnIrek90RWZUSU9FdWxFa0p3eFdKY2Fr?=
 =?utf-8?B?dDFjRXpNNWpFdG5SeEZZMW9waGZFeWZiVExEMkFodHp1MisxVmlTMVVpOEFI?=
 =?utf-8?B?b0diOGFYRHlOdnNObjU4NElVZkhiMEJJMjlvQ2E5azFtVmhrbzNRM2tSNlBW?=
 =?utf-8?B?cEM1KzlPNkxTTFFGU1pKV0grNkJ4bWxXUHQvTW9mRi9INlYxRUNDMXQ1bGEx?=
 =?utf-8?B?V3ZqTndTQitIbnhRZWIwUjdZeVJsWWVkeWo4SVRaYWlFcnNydUIyMFB3OHJK?=
 =?utf-8?B?RWZjUE4ycXBYTVZYRzRRejFudTF5TnhtMGNaZjZLOEtPOVQwd1dHNllFc1B3?=
 =?utf-8?B?TFFmT0xVSWpGajUxQUlhNlNvZ0tGRXBENWRtb0Uxam85WGVwbGgvdDlncXRD?=
 =?utf-8?B?aUZJcGdyaGV3bDJ3RjVOa2NYOXlUa1MwS1NORzZ3cGVQbURuTndoT2JDSkRa?=
 =?utf-8?B?bjFTSFowTFgvMDRLQTl1QVBybFNsYW5ocnlUSTh6WEl3aFIzNThFN3pSRHF1?=
 =?utf-8?B?YTU1R2w3V1c3aVRWbWxYSkVwWEVUUjdjVnNweGZRQ0VXcTNtelpjeVNSaWJI?=
 =?utf-8?B?SUoyNzh3c1NHM2h1N3MwbytuN3BLOXBrbFZmdWsvZmlmOFE1OUxsYlRNMUJE?=
 =?utf-8?B?dmNKWExacjBDYzQzMXpQS1ZTRjEva2MxQ3owUERaOUZRS2FnMEdmMWthMWt3?=
 =?utf-8?B?VlB5bk14bWp6V0NyL1FGbzRTNXVVbEJ5Sk5MZjBBcGJxMzhobVROcWljbC8r?=
 =?utf-8?B?c0xnVkdIWDJHaEZLdzZzcFlRQkVWeFAxbXlQcFREQS9QbTZ4SDRKd1RrdHd0?=
 =?utf-8?B?UVlrZURYWFlPZFc4TjVGWnVjVkttT3M0SElMVXpuRnhHNThEeGVIcmxLbm9R?=
 =?utf-8?B?R0JacE41STJ3bEpOWTlrM3NBQ1l1NklxMnR3NUViSkovTHpEK0pHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ebd79c-c1b6-4948-6ab4-08df367d0e11
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:58:04.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dY3l1Z2UjriMLSsl17aBZK36ZqGD/GTwa+Mq0q7hoLictPRP9Gfz6Fs1dmvX4NW02pKRfrXx7F/m4yFp5ebGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379



On 10/30/26 16:16, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> amd_sdw_compute_params() tracks the next dynamic port block offset in a
> static next_offset[] array initialised with {1} (which also leaves
> instance 1 initialised to 0).  Because next_offset[] is static and
> never reset when streams are freed or when the driver is unbound and
> rebound, the offset grows monotonically across stream lifecycles until
> it exceeds max_slots - 1 and permanently fails with -ENOMEM.
>
> Compute next_offset locally in amd_sdw_compute_params() from the active
> ports on the bus and clear port_offset_map[dai->id] in
> amd_sdw_hw_free().

This is not a bug for ACP6.3/7.0/7.1/7.2 platforms. These variants
do not have banked registers for data port programming. Instead, a
fixed port mapping per DAI ID is used by design: each use case (e.g.
headset playback, headphone capture) always maps to the same DAI ID
and port number across stream lifecycles.

The guard at line 402:

     if (!amd_manager->port_offset_map[p_rt->num])

ensures that port_offset_map[] is populated exactly once per port
at first use and never reassigned. Since the DAI-to-port mapping is
fixed, next_offset[] advancing after initial assignment has no effect
on subsequent stream open/close cycles.

Furthermore, the hw_free change introduced by this patch:

     amd_manager->port_offset_map[dai->id] = 0;

would be a regression. Clearing the map entry on stream teardown
causes the port to be reassigned a new block offset on the next
stream open, at which point next_offset[] has already advanced past
the original value. This breaks the fixed mapping invariant that the
driver relies on.

The number of concurrent streams per instance is known and bounded,
so -ENOMEM from slot exhaustion cannot occur in practice.
Please drop this patch.
>
> Fixes: 27ab4f1e4909 ("soundwire: amd: refactor bandwidth calculation logic")
> Closes: https://sashiko.dev/#/bug/linux-a0378066-b3cf-426c-bc88-e4d5208965b9
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 48 +++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 9dfcdde3f2f0..98b09d81f3b8 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -469,6 +469,41 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
>          return slave_stat;
>   }
>
> +static unsigned int amd_sdw_find_free_port_offset(struct sdw_bus *bus,
> +                                                 unsigned int slot_size)
> +{
> +       struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> +       struct sdw_master_runtime *m_rt;
> +       struct sdw_port_runtime *p_rt;
> +       unsigned int next_offset = 1;
> +       bool overlap;
> +
> +       do {
> +               overlap = false;
> +               list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> +                       unsigned int other_size = m_rt->stream->params.bps *
> +                                                 m_rt->stream->params.ch_count;
> +
> +                       list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
> +                               unsigned int other_bo;
> +
> +                               if (p_rt->num >= amd_manager->max_ports)
> +                                       continue;
> +                               other_bo = amd_manager->port_offset_map[p_rt->num];
> +                               if (!other_bo)
> +                                       continue;
> +                               if (next_offset < other_bo + other_size &&
> +                                   other_bo < next_offset + slot_size) {
> +                                       next_offset = other_bo + other_size;
> +                                       overlap = true;
> +                               }
> +                       }
> +               }
> +       } while (overlap);
> +
> +       return next_offset;
> +}
> +
>   static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
>   {
>          struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> @@ -479,8 +514,7 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
>          int port_bo, hstart, hstop, sample_int;
>          unsigned int rate, bps, channels;
>          unsigned int stream_slot_size, max_slots;
> -       static unsigned int next_offset[AMD_SDW_MAX_MANAGER_COUNT] = {1};
> -       unsigned int inst_id = amd_manager->instance;
> +       unsigned int next_offset;
>
>          port_bo = 0;
>          hstart = 1;
> @@ -511,11 +545,13 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
>                                   */
>                                  if (bus->params.curr_dr_freq == 12000000) {
>                                          max_slots = bus->params.row * (bus->params.col - 1);
> -                                       if (next_offset[inst_id] + stream_slot_size <=
> +                                       next_offset =
> +                                               amd_sdw_find_free_port_offset(bus,
> +                                                                             stream_slot_size);
> +                                       if (next_offset + stream_slot_size <=
>                                              (max_slots - 1)) {
>                                                  amd_manager->port_offset_map[p_rt->num] =
> -                                                                       next_offset[inst_id];
> -                                               next_offset[inst_id] += stream_slot_size;
> +                                                                       next_offset;
>                                          } else {
>                                                  dev_err(bus->dev,
>                                                          "No space for port %d\n", p_rt->num);
> @@ -824,6 +860,8 @@ static int amd_sdw_hw_free(struct snd_pcm_substream *substream, struct snd_soc_d
>          if (ret < 0)
>                  dev_err(dai->dev, "remove manager from stream %s failed: %d\n",
>                          dai_runtime->stream->name, ret);
> +       if (dai->id >= 0 && dai->id < amd_manager->max_ports)
> +               amd_manager->port_offset_map[dai->id] = 0;
>          return ret;
>   }
>
> --
> 2.56.0.317.g454f8302e1-goog

