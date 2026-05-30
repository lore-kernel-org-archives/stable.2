Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4A30567E;
	Sat, 30 May 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780136990; cv=fail; b=ZLjTOU8sCgxjZCRjgeAE7mOwUYwk4eYti654lMqi/IAm/L1lQQpZDUSZLbKGxpiCZj1PUk3LP2uHuZE5xqUEL488n5Ap70SsOMBLVyDVzEHu4yDPcTh8zOxKy2xws+ybZX/0H52rBfM+655W4ZYyCMHaR3YGbjaqUGUiwACtNiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780136990; c=relaxed/simple;
	bh=p4in3ry2D1GAyDFSvxFmo6b2Q4Z3hKSMKR6il3Z0ySE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ocJxudWC+JhRigBIjYIpYCc+dZd2yL3jaB/NWbvgQFQmwWUCJg6wadk+nmJ9yqiFHzxZOzE4YkxSrRXEsd4sP/oLegSdnpoJlrLVC5PGVA/5RPdQVhzWZ7lcyqeSxnkBsd5UjVAY+Qm/ROhImbV2a5htXaHc2SWTz/dM5aOMOR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RkQdl0vm; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RkQdl0vm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRIPaduER+cYxGLPzvEEGWjTd05m2KVYwJItcNR+0SmHBCPfU8XNjMJYVQ2+YMkWRkgFHXZyfHEn2gE10dXH28Pt13F0ME78CVy9/rI0N+8nLJTomS7j6hqq9TQpd4b2M8e/lyCXHGlwYIWPXjCOEEiOS1PXaXcIPO+QcUExVdaI5HyL9qcBx4OnG9wGETwmuv/m7U7fLkiH7kaWn8LuT1DUIXlPmS7Cv1lA1HKFU326WkQ49XMvTiAX6Ajgwc1RXnnUJJ9OhEG7mRb686kVxWciwfKEMh67lXNd9bLf60MamEMgicATxeM672k8I5bb5vrSzfxhOjbMGogDi+hOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcvavAJNbvkXhFdbgRSlpmFS+KVeWTpC0pM7QyM0Q+g=;
 b=tUcI+6WkH5fZgLBOPbdboJdzmCmxx3uXAt+Oja3SspL0++qdHpmDIzuHPK07MGvRj0R5X4mwXt19Rz9USpLgiPerbDBuHv2nWEzHWmrEcrKhTVVdFXjuJjxVZWVfCzlTx0Nl7r9xtKs2f443ePdcSI9F14EOxBl01LubcFGIoLtgwkjeM4IoDrvzk876IEIuGp59lQ7OujRDlNhNe9Vz2vZ7ug67rUI9pDqzz/0Q3k1S99dRw48lOQeVWzbqkvhA6uIVTECMucL2xTC4sa2w58G/OEOJFxcAd0fVKANYjjRvWJZLw+PZtT8vlM4Jjk0anw7HUiNgon8fjok7XjPZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcvavAJNbvkXhFdbgRSlpmFS+KVeWTpC0pM7QyM0Q+g=;
 b=RkQdl0vmh7Gk82Ri0jhFbteK3ikvw+ju0tkzB4xPfrPI2Y2qbgdSmgEWzRyaHyWmMiugCiSjCVrXicf6wtH7nUR8JPtDkIFYJEtXz4uEuTxs3JLPvQdKP/jXHIfuKJKFBICR2w/h12mufJHkVcxmDwqYV45xoI8g84ljb4ke135rfU5eZdC6VTW54wjogymkezUiEdIW7uHV0FaOITIWor+rc+AE2AtwsKc3L6ln+cPuf1bweMEmiHa+eSX12ONAPL0MCipE/nSPpVcJbo25UX7TX54al92yangXSoZSvLIJcUgI7LQBHedB7KnNbpG0SKqLd1nGNO8hFO1yV6jwMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sat, 30 May
 2026 10:29:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.011; Sat, 30 May 2026
 10:29:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 19:29:38 +0900
Message-Id: <DIVXW64SM8W7.1OF6PBA6R71NP@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <ojeda@kernel.org>
References: <20260530095809.213611-1-ojeda@kernel.org>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f063fc-6eaf-4148-2cf5-08debe365c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fz3ZDQf6/43Qh9fU1TyDGliWDRnyQ1pFmBJsiwDCSdVd9Ywr1j9bPQQqZa0yKi1lGKbFrN86njkc/e21kqq+iXPTNUGL7K8rF21F6FohRERb3PAYGwg4xYL8JcQ9P+7/OVTl3IriqZN+5rZ/GZhvUdV3MRZsBRX+WKoqLYgO7TA5NYNSsQ6U08RTr89X3DlTUGhAE2ADLa4p/tTTaCCHO5SpX6DGo9ei1fl0QUyuaBzqtvlCkxkxqjOrlvBRhTItehXlR7vNTlLb++h9rI8ogJ4/qppV/vkauB/13bjFl4pqIEvpHI+NOQUHkfMN8iUddchJ3Wo6ZV24+xrySr1P4ZnaJNPAvsBs9WLhVC94xPb8SEN4Rxfqq0IonjzSVTi0NZxa9Oko7iMoteRn4vBtnUcRNfpCcYL82wM38KyV6sUf7O8k/vgWaIxI5gzXNlmY0F20Vd4DxFPHGfwe2B8T+7wzQWt8v4ujYp6HubAmvVJOen2Xix7znkXXGtIVeGJgvCzsY9546O3JVguqPm6m2PwXClYMvsU5oAvM3JCwqU5s0uQ2Rfu/zFZvqF//T72W36dyN9jYGpkBd9DxbM1FUlTXkbb3x2cbyB3I0sgmPm1cWV0tc4AZNQUbO8EV/0+cYWBAqxrrfACd6KBrbOAfXbbSKoUdnjtDyhE0PAm9mnpw2cFy9K1vrcAAy8cyXMrXo6pUQwvVmUi9SW6+Fzbw8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2k5VVBHQkZsWTdCZHJQN1M4NWRJUmVtUUM5elhPOWxvYnVvRHYzbU9QVzc4?=
 =?utf-8?B?K1dRK1c3OGRnSHFTcTJDbXFoa3FFVldXZHk0a29kdVRGczVlWWVJOGlZL3V4?=
 =?utf-8?B?SUt0VHVvS3JUSXd3ZlhtYmVPRXRXODlHZXJjcVZTVmg0ZVM5QUc2MlV5dnJS?=
 =?utf-8?B?NnJNWVB3Nmo3SVFOQmoxOUhxRkkzOFhNTVc2dE5BTmx5NXpqcE1BTDV2bnNa?=
 =?utf-8?B?eE5WSEhtV0ZtcnBndnpUUWxLY1gwSHhlcUlEc1VHQzFXTjdWalo4N24ydUdW?=
 =?utf-8?B?YnFyN1czYmN4b0Mwd2ZkTFlCWG1GOU1ESjBVc1JmQjlhcUhuZTQ2b2wwaTZN?=
 =?utf-8?B?Mk4waGdyVzVaVFVQa0RDY0FtSlJWK2NjSXJJdGFwYm1RbWY1T0hyZGNWNXE4?=
 =?utf-8?B?VkFhcUw5dm82TU9Pa0tIdEk2alNXMjlFN3VmRVVXMHR1elB4TndndEs1cjY2?=
 =?utf-8?B?dXBFK3J5Mm90R2EyZkFkZll4QWJsMVp5eGVwcVpTLzFsZXcwT0I4T3hPRjhL?=
 =?utf-8?B?Uy9WNy9QZmFYQytyUmpPUHJRQ1BtZVZ6b1IrVGlQY3FqL2RCc21ObmI1L2Rl?=
 =?utf-8?B?ZnRWTEN4c3ZoWlN4Q3ROTitQR3NwWUZCN2oyc0xtdk4vMERSSjFTM014QWd3?=
 =?utf-8?B?bVEzY3JINVYvOVRUekFRTS9uekVWOFhueDMrUHhsaWRleTZxaXc0L3NDRHlm?=
 =?utf-8?B?UmhMbXdMYWNYWlRIZmZZMWVFUXdRN3NRaVgvUnJWeHRLNmZ3YUNCdWhzQSsz?=
 =?utf-8?B?TmtHVkhOTEJrTUFZdEM1RGxOOXNsRS9sbHVSaUJHRUs2MzVFZGZmOWtxaFNW?=
 =?utf-8?B?NlJ6TnFzbG9DUkpBNThQbE4rNzhkd29WK1l2Qm9Mc1h4aURIMlpxQnpQNE52?=
 =?utf-8?B?QVR5ZmZueXhNSW1KQXA0U2pBdi9neW1Fbmd3QzRnRHFWYWtvZ1hFSW1jaDFG?=
 =?utf-8?B?NlJROHN5eUJtbnNFUll6VDE3RlAxWVJ2dWdBRVZ2YmhYUnl2OEdpZUNpZk1a?=
 =?utf-8?B?T1VZOUlPdkg2eTlYZThmU2psWExHMGozalVML3h2Q2RRUk9NK2t6TDl6dDF5?=
 =?utf-8?B?MDQ2YmdrOVpQZFNRbEk2VEhiSEZqQ01BdmN0eEs3UjhxSUt1Mk5vM3JqTGk2?=
 =?utf-8?B?dERnSXdyd0ZNcHNwQWJSNnNkVU1HeHdNc2xnSDhQNmJkTnIvaVlPL3dRQmp6?=
 =?utf-8?B?ZHJUY0xBbVBqR3NubTJPRFlSNXdXVU40emFtRUNkUnBwMmpXRU51NXF0cXda?=
 =?utf-8?B?dWl6bXY3Z3ZkMm81VGZDSGs5dEs2bEhKdkc4MTdNa3BEMlBmd29jbzc4ckJR?=
 =?utf-8?B?T3d5QVIzWFZTUzFNeUtISDIrN0dvVk0rM0s3SE9QSXZJK2ZhUi9aZWViNXBh?=
 =?utf-8?B?RUdNN05RRkFQb3hKd3ZuUnhUMk44Q05LNkkwK0x2WFVXNzFrcUMwK2wxUitZ?=
 =?utf-8?B?WVZnb0J1dmY1enZ3NlNHbytHOE9PblFQQkVxWDRjakdWcytkSWZ0WGFrdmFs?=
 =?utf-8?B?T1VFWTBRZTEyUEFPL0praFRpc2R6NVFGQ0ZFNmFqdVR2VWV5Y3UwbW94SFpI?=
 =?utf-8?B?WVkyWEhQL2x5REdWeGRuaHIyVmFyQmcwdHhLTlExT3V1WnFuR2doTlBYYVl2?=
 =?utf-8?B?K3l5d3hhREpSelBNeHdqK1dJTHFrRmVFOFkxRUNRN2s5cWRiREhIUnkrMFN5?=
 =?utf-8?B?RnRMblc4R1NVMHVFYU1KdUJZWmJnUmFwaVVSMXhkTFNPL0xBYUh3TGNiLzQr?=
 =?utf-8?B?YmQ1T2RvRk9WYWtoWlUvNWtCemkzTUoyVmJoTDU3MlcwcUFHRGxaUktsbjBw?=
 =?utf-8?B?NlVoRm0vWk9DUE5KSmdYZkFLRHUzdXN5aUk0cXhxSUlpNmpXMDE0MVpEVGNK?=
 =?utf-8?B?QU1hNURadU1JcVNxKzBzUTV1K01NaStVc1AycTkva2l1Q0U3SzNieStjMlU1?=
 =?utf-8?B?SU13OUdDMjJWSkRtRHpsdWhmY1plRWh1NlBVRzR3ZVFnRm9BL3BmQ3hVZFlG?=
 =?utf-8?B?UVV1dWZkbmpYbldKaFlRY2hwWEhacHIwVm1wZ1d6NHVuYjFSRnFiWEpjZU84?=
 =?utf-8?B?T3A3OC9yTnc3M0RiQVo4RWdjclRwa1pLdXNaZ3FlMW1wRkF6dzZ1TW9Ebndz?=
 =?utf-8?B?NGRaclV1dXEwL05yR3R4V1R3YVBqODFjMFV6eHlyVjdhbkdSK0xVbEgyMG1E?=
 =?utf-8?B?UUpIdm5KcTgzVU9LeUNXYlRaZTB4enQxUlllRDVrcUlqemU1dVgyU3lsWnBt?=
 =?utf-8?B?cHV0ZExNT3pMcnlGM1Z0LzIyMGEvdHdUdnJtdlJ0Rlg5aDFyMEU1eXVXdVFE?=
 =?utf-8?B?VGpabGNXUWg2S285YkZCQS9tODVXcEJpaXlYdDBQTU03dEZLR0xRM3FkOFF4?=
 =?utf-8?Q?yQZ6WU3xnBucj+xuuGGLNupmltPUJkq9z6W23WXKUR4YU?=
X-MS-Exchange-AntiSpam-MessageData-1: /Et8wbjIfuyd4g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f063fc-6eaf-4148-2cf5-08debe365c0e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 10:29:41.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /s+KuV/hcT7iC7P9XkjyE37OqRaeEJNn2ehQk1rAo5zPztTp8E1pCFEBFbqTyECJvez/oqxOTfxtOxmNJCF8vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

On Sat May 30, 2026 at 6:58 PM JST, Miguel Ojeda wrote:
> Starting with Rust 1.98.0 (expected 2026-08-20), Clippy is likely
> introducing a new lint `clippy::map_or_identity` [1][2], which currently
> triggers in a single case:
>
>     warning: expression can be simplified using `Result::unwrap_or()`
>         --> rust/kernel/cpufreq.rs:1326:60
>          |
>     1326 |         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).map_or(0, |f| f))
>          |                                                            ^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          |
>          =3D help: for further information visit https://rust-lang.github=
.io/rust-clippy/master/index.html#map_or_identity
>          =3D note: `-W clippy::map-or-identity` implied by `-W clippy::al=
l`
>          =3D help: to override `-W clippy::all` add `#[allow(clippy::map_=
or_identity)]`
>     help: consider using `unwrap_or`
>          |
>     1326 -         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).map_or(0, |f| f))
>     1326 +         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).unwrap_or(0))
>          |
>
> The suggestion is valid, thus clean it up.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust-clippy/issues/15801 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16052 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

