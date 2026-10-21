Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792548299;
	b=fRQtq6+eG8TizMcyAXbB9FzIlxzgUgVcIBkotXuAg0lf6VJf9vvdHl4jlpew1bXSA5p3
	 bGafB4JbTYVjXrRntPm02OTC1e1bAv3NtazEIPWGUlr00y8U5Bz4uxKd74jQ7A95KV/1n
	 YW+2lBn5DDiv1ZdSYzNtJZAmex59MRASf9pcWLIiGMzsnCEtZURxDT4SuuWnn1xowjK/W
	 o5Ua13hlDsCSMUQqgwWkRkYHv2/cNMxr+QMhVFwq3gH1GJgG/3isQRanS/5Y3wZK1YFxm
	 ToNsOA2LIIh5y/0f0hgzn32VwjQ0A9b0Jissekq2CNnAEAYEV481/Qq7zoXtadegW6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548299;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lB+jvg6oIqL9bfq+1Ij+kEFBGzuhIR5vwUL/6kM2glo=;
	b=pvgRmH/TdLP+tc8LZn4DuUXFjAaV0LTWXFG12yWgJLILxou18/8CAmZCu3x8J6Sw/v4G
	 e8NV9tdkgjMeIM2WuIVdLvxuCNlXe/JhY7gl7BqVn8LQ33819IuUzZLxtXsCB8yqKznvz
	 8o0E9DiffY8nayxxjCAzj3h3aS5RrFEehdtxsw+AK1T/TzNs1EGzffNVVwYAKYV5rdS5D
	 wyQ0s80yBuxD8ttZHMtSFpU8yvA5U/J4EmSPuu/SOQBtquq1K+dZf9gmczqH/CLQmN0XX
	 Hg5wxWvPmSExItVii57wgTD+JY/2uE57fYSskUTqiIGypFwm4D7M/dtdL3DowHGnVZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dDo1YRCU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.40
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C2606A31B;
	Wed, 21 Oct 2026 02:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 043C2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dDo1YRCU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0yTr5FpvhYvb5k4YF5xqkgRnNK+fauunADGat3HV3uXHmzBFl+3ZcVAp8ptYhIKQblA7UONJdYycAxszUIN+Gz2hhGdYd14PB6l1ssM6SpQeAjKwdHOiX00k/xfj86CfEMgCvDZEzn+WH/JCJpD+f3Vk0AVfeSNrFMDEF8rwj02KUVl3aLWdQQr/DFKEWX7Mr/9X9v9AYKkkN1veBnUa+oed7bZ1Rnv+Teygmo4E/27jmiCCInoQePjGJwK6dwh3y6x2hyFcRfZPs2Cj22vlEYXzfNXYvd87CgwO/Lk6wI4W8dNLqAzpbP7KhDTj62jpbk94YwTg+SyKfaF9yCPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB+jvg6oIqL9bfq+1Ij+kEFBGzuhIR5vwUL/6kM2glo=;
 b=ur/6lkiwh9f0LiAn8rac28Jktlt80LRdxX5vZZlw7E7hvff6dZu10IzN+q5VdEfgt9+ICqe8ii7gRtehucOv9h7/d2Up+Ls9GJGDuYg5EupL6S8CvC8XhnLcJwTIf++SvnnGFFXtHGyJvdeHABMJAI5fTCYC2jrK6GganweKrgbaz41fvnHqreWg85R9vwV9wgA6b87ipVEdl/oexxRIxzZRiCQshSAhP8N6c66kafr6i1EMNZAxXdU0urBIg979FZzfC4PrLjc0KC44OG9BeftY7r0WbEBnfPyAAKlPZKavtbvHxlDMFKRV2zPeYG7kwcXOxlN4ToL2C2joQ1tALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB+jvg6oIqL9bfq+1Ij+kEFBGzuhIR5vwUL/6kM2glo=;
 b=dDo1YRCUzUkJVzAaHioud81642Yt+aUbHf/Db1oRRJ12p/zuiT/wBAAS4Q72qZsB0aYZYk4U+DVlwf5tDLBnoVYRT6dJYFGdZbabuOWS1qOAxDAlnDLbkeK8OjPbUmcOwaGaSva6HDvjTrf1CmhFTShYSOqwKx10sNi9dA+MiIft+1AInl2xrc2YXY//ME1lvZcfZDGVF9fT2h/fDwF01ra+Kaflq8CSF3Kg7knkExIX0GTAQKVJjmw0aaW6Wj0rs3zHTyw+7et0rsQnLLFcurWPLnY5+Hqd9bJdcX7FdADl9GHTtReFjVRbHLt5LVzv9dfLhTfb/t8P3zGfgkBuJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:04:54 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:04:54 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Svyatoslav Ryhel <clamor95@gmail.com>,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH] thermal/drivers/tegra/soctherm: Program throttrip with hot trip
 temperature
Date: Wed, 21 Oct 2026 11:04:50 +0900
Message-ID: <5z1T3MJbRUWQUClLWuCCnw@nvidia.com>
In-Reply-To:
 <20261020-upstream-soctherm-throttrip-v1-1-c67f8a02ec3b@tsv-stahl-riesa.de>
References:
 <20261020-upstream-soctherm-throttrip-v1-1-c67f8a02ec3b@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a805ed6-71e9-4ba7-3597-08df2f17b299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|23010399003|7416014|1800799024|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XzyKF+zl5RVwMiQu7WJHEx64zlA3hmqECqDNdbaqp3MGAPGcc4pZuJiArbm6+xykDx4W2bnh3F7Qds1KZlupWbb2+0hfUcQat87azwMmfCLDUEuGQKRyyw0FYoC1KUUMlOCsJlRRkUacPId3AdUi12DlnTSDw2v7iy9o1B9LJO2YwUzBhL163d/zW/s8d8D+ZHJuynCQwGp/fPIlAxvmAxvZJ+QJSLYt+lvKEdkyVE7reJ8Ky3OmZEqwhPsvMjuxIDGMWEvncrwgtStOeg8oCoxQrBGCS3jDdXxDQw2t9084BWJT8ga/FAnxyBSGgvik01L6MmzlG7ymMIwq8Fca3cX4K5ZrD68f2AkoMqoIkEODqNUmZB0mRopPwyRE6XU3EdIdVDULvuU90q5M83+52uhafgphScwuXDW5yBqrpP/ZNHznippofasBKQ1vnH+crpme/9oRwUbDeAQAs8YSWg4ZaTdP3xWLYXeSA6h7kFXNnSTEN9OFTbpA7YKl6jKqMlzMrF0BdkYKO3DTrK8zHkA/5ygU7Aef1ZS8EO+qrbCSumB8EQDtAkifTZ3mjOs7ZQMl5gsxS6ucKvlmozafk5KPTidCJN17QfcvuyWTrsETLPJKPY2QpCdCGkzdmYRs15U+bDmUNgsp633BKS+fkM7eHU13bkPLCalr7XKiicQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(7416014)(1800799024)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDdIdHJ4b25LVFRXWVV2ZW5zSVJsWFg3QXphTnI2b2YzYVptME1sRlJ5c3Rz?=
 =?utf-8?B?blRBWVdCL3g1eGlsOVR5YmNHbHFtV1V2UUtYbE1iTUJzSWNWazlQSjlyTjRB?=
 =?utf-8?B?Qm1iQ3NsWWVSQjB6Z1A0WDBkbThPSHVxWFlLVHNRWFUrK3MvelR0ZjNCQ1dK?=
 =?utf-8?B?bUhCYldFRkgwS0xtN0gya0FNODJaUG1HVmZ0TEM4UE5aZXRucXpGbzBDQVZM?=
 =?utf-8?B?bEUyZDg2MHR6eG5DTG5HZGo2SnQybDBNYjF6WmthQ08vMmxockRHN3hhMjlU?=
 =?utf-8?B?VjY4RVVyTUNKdnpFY2J0SS84Qk5QaTFIblZkY2hmTFI1MllIcDR6bjBGMG1s?=
 =?utf-8?B?ZitydWc3UUpMTnY0b041Z2tZWXlnU1ZKTFhnSkc5QzdnNGZJbStITmxFTDBx?=
 =?utf-8?B?eGpTcU9lRTBaaGhXWFI1KzNFVGpYR2ZHQjNSNHh6TEoxV2lPZ2l1d2VZMGdl?=
 =?utf-8?B?cjFqRVRaNjQvajg2VTJqNFZEZ2xKL1pKNnB0LzFkNVNvYWlYbU5pRHBUaXNl?=
 =?utf-8?B?Q1d6WndGUVVuckFrL01YZ3pKTXhmVDQ2dGlIRGI3aTdPNFV0RW84b2hTUVgy?=
 =?utf-8?B?V0dGQWhPNzBBM05ZU2szQ3VINGkrUFNkVEhQdDEzWGxWaFNuekJFdjgySWp5?=
 =?utf-8?B?NUhCcTRlangrc3lqQTlqWStxZHV6U0NOR0dCV01KRCtDVGJoN01NbjFpZ2Ex?=
 =?utf-8?B?UDRrcmIxM2ZibnVBOXR5Q3FtKzlsVTBoTWY3c2ZrV2dkaTR4L1RuUld5SFRT?=
 =?utf-8?B?a0c3cVZxamw2ZS9nbjRjU252WFlLc0cvZFhDdTRWZjFxSFFjNlZtZmJRTFoz?=
 =?utf-8?B?b2hoWklMSU9XZlA5MnE4bnNhaUNlZ3JucVJBMXNpRHNRcE5mRkp5V3NMandR?=
 =?utf-8?B?M0EwRkJMdFl2WXE1eDJMcmQ1OGtyRWxRQ3RtQytESmFWVEU3Nm9ySm02am9J?=
 =?utf-8?B?VW41NEVUZDU5SlBHSWpnT1E3MG9Ra1R2SmVxK0lDckhQRWhlcGRDREpFZG8z?=
 =?utf-8?B?dGFXRnZXZUo5bGxBVFRqZWMyZlNLaUhXeDRFTTFvblVMRHpUZHVRb0pKRm5v?=
 =?utf-8?B?MEI3MUdmN0FGeFJmNkloTExsVUNONlEvMS9ZSHMrTjBIUEpGaEpCV3lKRTIx?=
 =?utf-8?B?K1lZdzJ4cVY3MTBPNTdacG9mdDVaWDFLQVdOWHViMTduK3l3K3dMaVJQL3JG?=
 =?utf-8?B?RjN5b1YwZnNoekpQYjZWdkE0c0VjR1V0dnQ3ZG95dHFobWpmeHBIVWRxVFhD?=
 =?utf-8?B?R25RM3VjTmZmc2RrOVprQnRlTHpkZU5kOW92TncyR2dUeTF5dXcwb0wvd1VP?=
 =?utf-8?B?ZzhFOVhwT0ZieXpLUEJEWnhiS3hxMG9KdmtyUEQ5OTlDNUZkbTA5YlhSVUpi?=
 =?utf-8?B?K0hYaFRjRjBMU0lBU0VSS0tBbG1INUZnV3NaKzU4K1d3SXorZnZXY1AvTk96?=
 =?utf-8?B?dy9XZStYQnNpS1BjZk9IUkJIK2FOVThpRzN3RUJyNWFHdEYvYjZ6dUFSWkZu?=
 =?utf-8?B?Uy9ZckdXd2tOcEFOelJucmNGeFpDRkx1QVhHVVFtaUFyWEJkWkJjRkxJM3hB?=
 =?utf-8?B?OWl0dSt5MWxWVVVHWUh6UGZWcE5YKzdrNk5mK0p4TUI3WWxqRlgrdmFPenM4?=
 =?utf-8?B?OHdsbzhGSU9NRVppVWd5dGFvVVFlUDlFNXM3RFMxOXF6REpCRzlOVHA2bStt?=
 =?utf-8?B?bXJCTlJDU1BJVTlJL2ZoaFRLdFNJZGEvVUpaYVAzZGE2ekhFejY1RWdvbEFK?=
 =?utf-8?B?dVdGWE5oUHNxcUx5ell5UmgrTWpSZkVsMWduZTVPbXJJYWRXZS9Gc29CelpC?=
 =?utf-8?B?cjBxd2cvZVdNZG5UaHBDdmh2d2RhSWFFZTg0TTdYVWN3ZWdIaWIrRmxWR2k3?=
 =?utf-8?B?QWZKM1J3SmRwb1JlMTFHN0xkUlBOUkxPck5oL0U5QVpOMWlOZk5keXR1M1Y3?=
 =?utf-8?B?UUp3S2s5MWszWWJCMk92d3BDMVZ5Z0htMUgrWUlnQzF1Y2lEd0NJWjlSaVpJ?=
 =?utf-8?B?RWJCOUhjblpGUkNHaWZFYkd5R2gzWDVhelI5ZzM1NkI1WHJnY1FBaEZkVm15?=
 =?utf-8?B?MURXVEJEK3orZkVEMUJnK1F2NmhRTDU3dVd0TGhqQ3JURHptSmlwSW9mc0Mz?=
 =?utf-8?B?Vm5qK2t1eC9qa1JvR1MzTkpjYVZUTkswelVzdHBVZ2M5enN0WjEySVdNN2hU?=
 =?utf-8?B?U3BIQ1llZlRhRW9Kc2dsZG1Ua1hOWkczSXNYZlJlTnluMmFybzlUQkQ0TEtS?=
 =?utf-8?B?K0lKeFFZTCtrbkRiR1lUczh6YjdhdXcwWWljZnRaR09xamgwUjV2TDdyR2lY?=
 =?utf-8?B?dWc2OFFHbllnKzQxcERtM3c0Wi92cm5ROVVmZjU5RHdRZTRwNUVzZ3ppbk8w?=
 =?utf-8?Q?oPNTLqAtTIk5EuE2WPycAvxBoQydpHBfmmWc4b5VKGHvB?=
X-MS-Exchange-AntiSpam-MessageData-1: +oBsnsSn7lIKbQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a805ed6-71e9-4ba7-3597-08df2f17b299
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:04:53.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zD2xs5iTuR25LOT3pOC9Q1b2ozoNQJj/f34SurBokaC1wmHzuVvmCRjWu0vcVYtlA+KHHXhFW9t7MNm0XoWbZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

On Wednesday, October 21, 2026 4:18=E2=80=AFAM Patrick Fischer via B4 Relay=
 wrote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> tegra_soctherm_set_hwtrips() is supposed to program the hardware
> throttle trip (throttrip) with the temperature of the thermal zone's
> hot trip point. Since commit 735a968d2fea ("thermal/drivers/tegra: Use
> generic thermal_zone_get_trip() function"), get_hot_temp() only looks
> up the hot trip and no longer stores its temperature, and the later
> conversion to get_hot_trip() kept that behaviour. throttrip_program()
> is therefore called with the value still left in 'temperature', which
> is the thermtrip or critical temperature that was just used for
> thermtrip_program().
>=20
> As a result, hardware throttling only starts at the shutdown
> temperature instead of at the hot trip. On the NVIDIA Tegra Note 7
> (P1640, Tegra114), where tegra114.dtsi defines the hot trips at 100 C
> and the critical trips at 102 C, soctherm reports:
>=20
>   throttrip: will throttle when cpu reaches 102000 mC
>=20
> instead of 100000 mC. Svyatoslav Ryhel observed the same on the ASUS
> Transformer Pad TF701T (Tegra114) and the Xiaomi Mi Pad (Tegra124).
> All boards using soctherm with a hot trip bound to a throttle cooling
> device are affected.
>=20
> Use the temperature of the hot trip for throttrip_program() again.
>=20
> Fixes: 735a968d2fea ("thermal/drivers/tegra: Use generic thermal_zone_get=
_trip() function")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/thermal/tegra/soctherm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index f74acf13b24d..903215502606 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -765,6 +765,8 @@ static int tegra_soctherm_set_hwtrips(struct device *=
dev,
>  		return 0;
>  	}
> =20
> +	temperature =3D hot_trip->temperature;
> +
>  	for (i =3D 0; i < THROTTLE_OC1; i++) {
>  		struct thermal_cooling_device *cdev;
> =20
>=20
> ---
> base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
> change-id: 20261020-upstream-soctherm-throttrip-ad6965977b6c
>=20
> Best regards,
> -- =20
> Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



