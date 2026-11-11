Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493320;
	b=fXOQCyRGesLXhfLvVryke/yPI/2GgS+oZnbIebiRWHWJfjzZK11kqvk9+rkjvwFlMamQ
	 j2Kd6mLlRjzqjNhX/4/EzDsocM6prDQhMRQBD4BXYsX0R/3Qiuw5md6CoZwM7HdDkZaZe
	 D6S322W0+qmPxc+rouVYKI1fuzyqGLtdjvQV3DNZin2pRr/DJO2cyT+MKg4+3w/vGOxWI
	 b4NuVgrcIhSiIgQq4To78ZypfO+oqZ7yhTm6UpWmJJKKDfxXAqvE47Q4uYlnFxKMBn435
	 sj765mnGGuOfDZyPewZK+TLQY2I52mEj1CIKXlDEdARRPG3FibCWpssDbsN0EbF9Cdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493320;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=qMXLak3/e8ONgPzK6NDuk2NwGSz9RpB7BhNGZqEv0NE=;
	b=Va+4DOenbS+aNKPCRkW5Xj+6zZVI4z8utS+skA36zwJp5HAJ+ykD3wrKEOxHw1COraua
	 gCL/I66Usl6eQ804eBVN+optVpOSjRaLnuusLdYlut0ACk4PFakAdf8UfN760R/6KoBuK
	 FmjVR1rEoFXZMKfxN57qrluznUZJa9wLdPxoD3KdCHXkizQGKabhPthGJssYuW+0IxHpf
	 vbqr5d377eg84w1plblCBfpATBvi+5UVTXS5h4vEgVt4v9ChdEIsYQR66tjDNBRFnuqCd
	 q2I2kGlXltmN5pRmqrTQ7Ta8ntls6BkKyU2ixYEphmVEyJ1ELGjvmWA8rsgB/Hnzw7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ApmIf5pn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB9606B83E;
	Thu, 12 Nov 2026 14:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EBB9606B83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ApmIf5pn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRtgnRT3pLLxA+sH+yqwuIvAUr56fsjoPmcjcJfTFEp4CMrAP+tS4kDltK6N9NTzJ4lr7eVlL5HfxEHQrKD2TFwjqDzS1cf9bNzpYKbZ9JDhQdHd91/B4ZlVek0n+0Nr3ggKqJXDP8G2IKKAoOFcwLhzBtteGYgQhU9z7xMdrtqtYBeZwketvaTMm61a54/wFrJU0vhe3W9xSUbbbQmlsadU60+kkQYHMVMZfY2NBnPcWgDywJew4ktfPF5kvjpTIPVMvZsUsMyC+3xe8illKjjvwIbkZpQOkj4oZuy+3U0+AayKV0m8JMj3r5jJdIoXxqrDv/hLM39TR8sgOYCGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMXLak3/e8ONgPzK6NDuk2NwGSz9RpB7BhNGZqEv0NE=;
 b=PGlkI6bepEJHRJGqjnM4coJxF1GjYyssSiMzOhhKLwdoBhbMxZ5JxlniwEyLOrql6OGrxo3uhlaE9wr2cFfbKFucXrUY+UPwcuxjFug7chuupeZEsWsxpJLLuHiXzcwvkd6NbI0zhj50KLfvxCPXE5Ux6RRvuSzbo2olWsF8Axx5A48VkTYg03h26fR0A+obDyPdsFSCMK8ayZ/QL3vlZdCjHZFqdZr9uQTxsBuRAdgqlyNnvPnQIEfZ/cHiY9Dt/4I52PNzQigNlM6dAK09nc6KQ5w4spmRTiERBTj53bG2i6wh7WDT27glBh5EOGXsIF/fH2Cpzls3hnt4KN8/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMXLak3/e8ONgPzK6NDuk2NwGSz9RpB7BhNGZqEv0NE=;
 b=ApmIf5pnQfvUxlWNGUyd4RR0vGD0cCwAeEmxtf0/2RV8zTN7TUsMk4kI3fRfHAN/7OYnb3j/opf2puyg7T8esit9ciV0Fek4bDazWbraGocdOEGpAFYrQeLvcpiPjlVwHDU6lQU3gglwfJr9l1bF5VT3OuAcSNRZuKC432QTaROVPJpoVoKVXm4yq2v+xa8vXoeXlvhXFzsgM0CB7SIKYjW4cIkgR+hhfJXjLFmu3gEU+hXDvdlYWKGzOMjRODLqcbnH3/5zrYs+CT5wBnvo9tQdUl1Lp2A1aCCJbXetoQaB7R/QpdtqIRQvDhtcbbjALNEXhXFIyGRzthO+T7AlLQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH9PR12MB731475.namprd12.prod.outlook.com
 (2603:10b6:510:414::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:21:57 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 14:21:57 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: jgg@ziepe.ca, kevin.tian@intel.com, 
 Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: nicolinc@nvidia.com, praan@google.com, stable@vger.kernel.org, 
 joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <09A8E000F2353E67+20261106122832.88995-1-peiyang_he@smail.nju.edu.cn>
References: <09A8E000F2353E67+20261106122832.88995-1-peiyang_he@smail.nju.edu.cn>
Subject: Re: [PATCH] iommufd/selftest: Fix wrong slot cleared on mock HW
 queue destroy
Message-Id: <179435827945.1896047.12678566630085540625.b4-ty@b4>
Date: Tue, 10 Nov 2026 20:51:19 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4P288CA0080.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::15) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH9PR12MB731475:EE_
X-MS-Office365-Filtering-Correlation-Id: b600d9cd-c60b-4e02-37ef-08df40c84f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jTlmTd+4g4O4Z7NZJzy+V6Y4icM4sG2jWQwWzQtNhm5JF0qBr8O3lu5EmsIxvl4hVcR58iB+9VAaUOBxtFYRUhh2NymAsxkP5/qsJ2Iz7dUIcYx+DsM4zXZAKjOE7JQ4P5s5thMY/75fFGB84YRaCa8+EhZSqralDDXbznvnhseLDtMoA0Bcs4vvgiZejigE240PU5KkJxI48JAauE/gXJ4yYA2mEAQWFIxgy3i0NoRspacnii4UJ+4kDC9WO4tJ/sH2b8AXj67mn1BgmRfBImOcE4DCewfl83WkW0XQepjnXOe8o44W5fUTAMw9Va8zXtKDQZeiIqMJttZ53DfH98GJEDAJNg/Er60GG1oxv1K0XoPWd89txOsCXQJvVfhn1VpxkfTilY03hQ4x6QpsqifHHndxmEfnbtqf7W3A/aLsAIPuQQznIF5empehJSAfmwYuIOd1tvSZmNiCueklwgQjZubB2mxDZ5Siai6orKApnWbRCpy5+XtZC8E7t/qhjazmRe7DU0DyIjA9dEVAFj4C4mchqzgy3E/6ncbIy1zRxPKPELN3gWx1u57uWIp2YLidVs7lRR9dunb+3c94i9sjAPAXFwlGtygW+j8ZdnYwoR0FGl9LyGKh4LBP13YZ12g+yzqNSpIz8GGj2Twt3i0yoEilZl4zfl/MSt1nNHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3RhSkRGOVcxbkJWVG43Z002aDdWZVErYjhBNXdkbTVhRVNoUUZJK2NZTWVT?=
 =?utf-8?B?TGRsRzNuVWV4UnVBNVNtVW5ZSlZNaENPQ01kRFA4aVloaVNGQVBacEdYK0t5?=
 =?utf-8?B?MkdmcW9ZcGlQRjRkL0pIS2lMWXRtKzJuRS9xVVFKYlNrNy94U1JzdmxaUU0w?=
 =?utf-8?B?czZMU3NKdExEQVJWY3hXWkJOV2UzZVJ6c2lFbGJqVUdleC9OTXVXbngrWkVK?=
 =?utf-8?B?SVJYRVVDOXU0NXN4SFZiTThBbTRXMzdqMXVMa0V0TkVOZFJ4b2k2WnBCcWx3?=
 =?utf-8?B?Tlc0enNTS0IvWGhGYnhLZGpjTXpUQkhYTDRiNlpscVh3QUZNMzBKNlIrbExS?=
 =?utf-8?B?amVqbUlieSs2NWRDWnphSGVmamRSazQxazlYa1MzQWJoSEZkNlFmd3dGaUx4?=
 =?utf-8?B?Y3c4c0tRd0JTQzlrV1ZnTGdSellWN1c2dkQ2SGJqY0RyNVpBQ2k0TUpWYVpV?=
 =?utf-8?B?OFozeHNJVUpiZjFGTWYrdU0yaVM2aHVWcEFRd2N3T01mL21ydDR2YTV5eGtW?=
 =?utf-8?B?cHl5OTkxOHJWSHBEMFQ2SGRLMXZSV21zREpmWUJ6VitwVTNtaVc3N0NlRTRh?=
 =?utf-8?B?Uyt3NzdvODRrWmVJdXQ5YzFCOHZSeFNZQWN0RU8yNENyWnpIQjZMRXZoTTJO?=
 =?utf-8?B?TncxL2l1QWJwc0hZVGc5Vkh3ZEVlWjNkbHZ1emEvczZmSlZ2MFUrRTVzWHJF?=
 =?utf-8?B?bFZNQlI1U0pCU0p0S2R0UTdDbnQ0U05YUk93L2tGUG1TYW1aZ3dDVjJ5V2ZX?=
 =?utf-8?B?ay80b284Ulc1Yms3VndPQVZQeG5Wc2dyV001SXNaWEk2N3FPdFVvOURKbUd1?=
 =?utf-8?B?LytNWXFEdmVuZVBSYnQ5WHlKaDJVOGNSd1FDN2Uxb0l2NkFDancxU2UrYktK?=
 =?utf-8?B?NllDRStJU1FhT3RDMUJqdDBNUTB5bENBVktLUmVkN3Byb3JocnowLzljNDBW?=
 =?utf-8?B?YmlHc1hRRW82TlZnaStZR09ubU9BTGJabDJLRWZRNmNpY01xUFRMNVREVk8x?=
 =?utf-8?B?RHhwWjB0MlRaai9lMC9hMktkSGdVaWI5UENtTFVtZlZ3NGt2clFUa0VBN2cx?=
 =?utf-8?B?QWYrY1dWQ3IvenRaQU56ckQrNXdOeC9kZ0VteG1PN2s2UU5wWmlYZXdUVWhB?=
 =?utf-8?B?QUNjczF0K2ZuNDJObkI4dDFrQXpFczd3T0xHVGg4T1UwWjRiV3pQTldWd1gy?=
 =?utf-8?B?cHc1eU1zOXl0ai9td2ljRjg5QTd0NVNRam1zN1hFTTI4QUthVDgzK1N3cWFx?=
 =?utf-8?B?bWk0S04xTllaaEgyUkJoNFRZK2IxS094aTZyc2JoZkgzVnBQZ1FzOWJJNFRI?=
 =?utf-8?B?U3ZkODF1UVY2bWtHRWY1R0xvTmdNaU5lSEdCUUYvam9maWpVY2ZpZ1BHVVl5?=
 =?utf-8?B?SStwRmV1MFExY1RaUldnSm5DaExDNm1qNlpTNUtBVGg0bGxkTGIrTUJYenc4?=
 =?utf-8?B?RmdXbVRBY1lvMjV1SDliempHU3RpOWt1d2ZpdFFmZHd6aTEvZkZHaXhpOXE3?=
 =?utf-8?B?SmxOR2xnUngzcjk1K1AxdmtwcHFnZU92aXlwWU1XcVBBeUdnTWNzeE5OUU9R?=
 =?utf-8?B?ZkFEMmg3OUg0V01aY1FMZ1NYTE9zV1hEaURzZG5Db0kvVzI2WUlSWFFIWDBY?=
 =?utf-8?B?SVVUOEJYWW1QT09RbjNZSnJ1YnJBY1VKTFpMc3RXOWhDNlRCN3Izd3pCR0Rv?=
 =?utf-8?B?MGV1NHBwQlNHaXMvRlBINDJISXJRaXM2V3liZTl5ZHF4SCtZSkdSOVl3ZWxa?=
 =?utf-8?B?dXZqNFM5RzRYYU5TdnRTQlNONDg5b1VLby8xVzVEckJUemN4QUVXTkJUVmhR?=
 =?utf-8?B?L3FrUlVjVXJKTm9UL2dlbzk1VWgvWGJKUVd2cVovbkZHTGxMSmxESEFENC9S?=
 =?utf-8?B?VldPTE9TWHVoNEVKU0paODVTQnMvOFRSU2pCU2tuSGFVdk14YjhRMDYzazZv?=
 =?utf-8?B?a2xHWGd6czlremU4ZDFYVERUQTVuRXh0K1crMmEyUFBLdjdUNXRhNURmVXk2?=
 =?utf-8?B?cU0rYnpEbjErd3ZtRHZHbExxcWIxT1VyRElERk5TZzBhL2FneGttdG0rSVJ4?=
 =?utf-8?B?L1ZVTFdYbGFrVjA5bjVLS1ZmMXdIZkVGSE5wOXZlWndjZ1Nsd2I2WlQrZThK?=
 =?utf-8?B?bVkrakZaQWlDZ1FVQWdXYnVJVGVSRVd0bDdLR01vNWcxclU5ZXFlNHJ5STdJ?=
 =?utf-8?B?MXQ5VDFzMnRzU00vTW5sMjlDeS9uTzE1dFQyc0hCUmttOWlHcHphc3Y0amUw?=
 =?utf-8?B?QXBJbjE4eW1qczZ5NGl5allXYVU2V1oxZGNKV0l0NmRzZkhFajVYYUtueWM3?=
 =?utf-8?Q?aS3vbm5yG2ac1kZRyR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b600d9cd-c60b-4e02-37ef-08df40c84f10
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:21:57.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAunu7Eyxv4A9Tr0FwoRzEYhqkFy8ndvolZ/lNL0MheLWZ0x2DR6I1n+/JODX/Uh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB731475


On Fri, 06 Nov 2026 20:28:32 +0800, Peiyang He wrote:
> iommufd/selftest: Fix wrong slot cleared on mock HW queue destroy

Applied, thanks!

[1/1] iommufd/selftest: Fix wrong slot cleared on mock HW queue destroy
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=231e471ac4d0579bba3a800fc46519f8a04894d9

Best regards,
-- 
Jason

