Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020091.outbound.protection.outlook.com [52.101.195.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5B2EF64F;
	Sat, 30 May 2026 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139066; cv=fail; b=q1ASbW17CX1nWZE8Q/sWx17NgLUkCypjIsq6PAH4Tu0YTMrGnZLxD1tj0iHTduFYPBNhvWqRHjGt2vnvwZjvlTiZp6YIdcf20kCsX1wfx4E1xRh/Iz2+ssB/AxmFX8LbQCCVQ9BSPcv8shPB2NEIcC9W0ykDAHuiunYPNw0T49k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139066; c=relaxed/simple;
	bh=QUELZK6vg0HVa3jjBcWwjL1knUWjcbXhgOE+Jh4TpfU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=kSc7WP8RBb5CtgZgNrxZybd5INuSFHh+7HNkVirZhqq0gbeR7Fn+R1I9ND9ksOyROoYiZGHTo7BM+LzKIMdzZsa8XXhqbTUdiHAz5fCo7p8v9TWveroaQSsd/ziQZqxnkWAOnOSrLfT74/swH2eTVTNpEeJT1a9MO0pTYRhlc3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IrrALZSo; arc=fail smtp.client-ip=52.101.195.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IrrALZSo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUcaMS9TKwsaalm2Uo58x8/NyzXHq6PLkEVaCYYAsf2GNFAfmOOoEeBO/jV3WcoBJ6UQfGXcuzr1xle2GioVZbgQ0XQc50OZiTBx2F5T0dr+qBzBp9FTDqr93ab+nCsWHfum6/ShulRcl28co76YHQjgaN7SclsQJtH9ZIHI5T1WHfOwFlXav8xHC8hp5Y8FhE4EmIMa0e04uZN3fLvZEHjmw46i0umSKzVhoC72U4sle8MDAQlPXFevD0zx4QlvpqIBlyiCFij4qUqZA5UnNXeqbf3jMlnDs1UTk+aWTNRUcs4um33JJSLeqCuLOJRjVXHrf4H+tJEVPJWnz34WJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVWZNnUHX/WxEnOKFtE2j/e+qHtodGduYRfQNTYE2aE=;
 b=gbAg6UUCyZ+iJ20FW+gcqFHv87/NL7OVCb7lJr+/JISLUN2ZWRluqoIGHIAD7MuKHitUDLEomZxEqjovrskOx1E3QI3w4HJfGEfdchujpCGetgKDQxCiTQrKOgFfJ5JEjDDhR86M98SBGZTEKn7nBOuZku+3bShJ5TjVC8Iux+YEmQRIAq/M+9fhV2WVfqioVuCS0Mw4FuErt6nGOuQtMZUFjrVPbb9IdfiUgbpw8yooi2bl62iDskqD6XVWip4BpiaGiZtlwynfIHKmPAGSy/ABCJIoY4g6zpyJkWvy2U4Xj4DfUdWUHWoO8ZOAIyWQuMH954t1HBVjTN+pYv2D1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVWZNnUHX/WxEnOKFtE2j/e+qHtodGduYRfQNTYE2aE=;
 b=IrrALZSow5OGy3VCardbLQDt2e0eUZeuZKGoHAd92NOA41d9v8bxmwlmgw/HCUT1O48SAnk+iZ1Wqh/dbdhgOhePNQOF35cLXYSm6wDB+TvbG/xSx3lquYpyRKwSfIbE9ImPgO1eXvsmfmLSb6eWbKOW4DXGOi6ou7imVT1EisQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7926.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sat, 30 May
 2026 11:04:21 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.015; Sat, 30 May 2026
 11:04:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 12:04:20 +0100
Message-Id: <DIVYMQP1WAU0.1V6OFY4Y7K244@garyguo.net>
Cc: <linux-pm@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260530095809.213611-1-ojeda@kernel.org>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
X-ClientProxiedBy: LO4P265CA0220.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 95650987-e05b-4345-60b8-08debe3b3367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RQZV3A9/yJwBZE32zETnUulOyrUdixVmCc8T8RrkCJeoXaVmamwh7mnWiLeZbryMYd0Nl51AvEUdKehxBHo9sXhuwWhYD1KWacus8Era62fnUfWWlUKfrTLIaZ3t/wzWxMT8x3/TFPzOxWQ0TuqZ3MRl7Hj4yQetRu/1sy0jyR38XdJeh68J5z1ST39WtHUAzdBW0ShxlivnibHHvdGD4YTwAmaIBsCO8RT8DMTTmk1qoARX6kXEg6WhvqHzLZwzMHPKERRkcZQLYzmAcs+++LYHwZS6p0TkJLB6Nq7F6wmsBaoHL4wE8CFOzWTQ9mxNNtz20a7UFD0Zitf+H8CylQ6wLV683Ct1qyYH4Glnt1wi4yu8qjJ4t9yHi9F+ygqCIb5NdsstOn0hDQjz54/Puctolgo4lslfxgveA1J+UgFJFY7i0QT5pJTmDhels3l+MUobslRriNQBQQccePc5kkz51tnEpQgGxx6theFYRWTpAg0OTap4vLdcUvBW/ieVuufYKRaDDJ5GTtKErPavD3aUZBzNmvYcvWSzhIJVXIYaoIM2v2+U0gnriFKlzUxKPPEDHx5sRUoncdoCH6WRWMCbQtyfNPWgi9hDuY0aBmsvpCwws9ULcIXpp2op4nYCI2/6LtdrhH/OP1YDdJdegw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RThwRUxhbXlzYWh1bmk2UVdlU0RrcXhvWWo0TUZwOTJjTlFxZ2J3RGkrSDFY?=
 =?utf-8?B?Z1ZETU1MTlloR25VeHkyZXhSejRhcDJBV2crbTBodnJyZXNMOE1ZZFRjZjRD?=
 =?utf-8?B?QmtNNnEwVGVWZUpiNk84Zm5GZVozYlB0cWdjL0VoZlVBWTBNVmNpalQ0RTBv?=
 =?utf-8?B?WWJIa1JwM3ZhK3l2bXpVUWErRkFIQXVxMTRmcmg2OUdLRUFtcEo1bkpIZkN0?=
 =?utf-8?B?cW52OUVsc1VsRmN1dkV4L1JWWDNvK2hoVjI4YnR3VzF4NVlCZ3crQmswSEta?=
 =?utf-8?B?RHExMTd1QXM4czZqZTlaY3Q4UXU1ajJoazg3YXE1Sm9pZUFQRGh5Y3FNaGlY?=
 =?utf-8?B?ZEZ2aVNWUXdlWGN6ZXVGUnJwZGZhWFhJSndxRHBlamxqcFFsd3JjdVZOK3V2?=
 =?utf-8?B?Q3crdG01LzJaMGIzc3ljdDRkUXViMnhlNnNxaXZsTmxSQmNjY3duYkhlTW1r?=
 =?utf-8?B?RlRCMXFodXp0VkhNNHAvZVovOC9FUHN2RmNhY3JuSUZZWEIwRjIzNXY4ODd5?=
 =?utf-8?B?Uk55aFpWME03aXl4VWxuai9JZkwvTUo3MlFKZzNLanZZV0VxQ2l5eGw0YUJl?=
 =?utf-8?B?MzZtOHpsYTk2U0pHVTZKWEVlK3ZyWlZNWmhDd24zNC9XSG1FcFZTTERwQWky?=
 =?utf-8?B?MTlmSEhCYm1ETkdzbmF4bFl0T0hsU1VlcjB1M1F2MS95THVXNk01Tm1OcTE1?=
 =?utf-8?B?S2dGaGhBOE01QVRvekVueGp4OHVwOFdSZWhIdXd6SHV5eE9uUHNRYmVmemd6?=
 =?utf-8?B?YVprVzRlSkRZTHU2bVpvWDFxZHZZd2l3MnpTUGU4VFFPMFpkd2pFK2NhdzBr?=
 =?utf-8?B?Lzg0QmtoUzZNQ1gwR1QwL2VYM0RlUlAyNEJJZzJ5amNjbkNFTzk3end6VTZa?=
 =?utf-8?B?ZUhmbjMyMGMraUlVVWFCQjloTXRnSk91TXY3R3U5WllFM0loSHk2V21hOG1F?=
 =?utf-8?B?V3RGeWdOaXplZ3VVb0czU3RjK2tuUCtZbUpxZU1LaVVIdENqQWR6dHhSRm9j?=
 =?utf-8?B?M2dldXNmdHRSUjJBcmZUNjRQQjlNWS9Pd1JGeVZnSkxLT1Ayck02elNQRkRy?=
 =?utf-8?B?Y1QvYlJCYld6QU5NN204RmRYYjh1NE93V3FPNi85aFkxS2JaanpxV2craHM5?=
 =?utf-8?B?eDViL3Z6SGtGQXMvc1JVM0RKdkQrd3BNblNUL3pKanJQa24yaHl2eTlSSU1R?=
 =?utf-8?B?QlRvQ0ZKMHVxM0E4QTQxNHBYdGJRaC95M3VsdUpPdEJaMWUxdTJZRkYxNXpP?=
 =?utf-8?B?NkVXZ1dGWjcwVGlvbDBvd1djZHAwcmIxbjRsbmJVYndCNHBzTjU0TERpLzE5?=
 =?utf-8?B?T1ZoLzQzRlZ6N1MyR3JRdVZBY0FhRjhSNzJWUzZnbitlQTJ4L3NHcHFMSVp4?=
 =?utf-8?B?UGp1NUs3dlJjSWVEWFlVTWszSU02LzlIaDVlY2REdUduN1Q1cGVia294U3ZN?=
 =?utf-8?B?cGJ4Rm9RZWs1M0hBNkFBMkZCUS9IazhxWnlGaStrVjVYQ1JmeXZzZUxNUFRa?=
 =?utf-8?B?ZFo0bGg4WlFGV3VFMW9NZXFDbVptSlRFVjBGMTdCTkxYcVRTZHdQRVJrN2tm?=
 =?utf-8?B?bUxleXhERmN6cUI1a3NoaXpzUEhZRHB0Q1J4ZTB3MDBZMndHdVFyQkYwOXFz?=
 =?utf-8?B?QjArSit1TkF1aldxTE9FVmVuZFRhUXBvWDVoOTlKVUx5NkJFNWIyajNSdjhU?=
 =?utf-8?B?NVhmN0h3RFlVd05uZGlHVE41TVFTYW50L3RkZzBQbVYyVTdmOGU3YkRNMnY2?=
 =?utf-8?B?VFZVUXMrUFNSYUNzRXZpQjY1ZGFtNnpOYjdrKzVSdkpyYzZ1UWFDck01SklW?=
 =?utf-8?B?cGNQT214TDd4NWsyUFpMaitrZWM3bHlsdEhhcm1WMjFxWkZCYmhyd2NWUnhm?=
 =?utf-8?B?dUtBNUlkcXA5dFJJQ20zS2pEWXFkNm1uc2pUeEQwUjFlUlFIMzNxaHp3SHZQ?=
 =?utf-8?B?RlZMaVdZRWFaWDI4Vk1KSUFFU3JJRldxMGU1ZkFPQVp3STBjSVV3SFZWMVJY?=
 =?utf-8?B?Q1doTDhsWkpydElrSHhuTUVyNXlMbUhja1AzeVIxVFcySDFqZlRHU3RhYTFh?=
 =?utf-8?B?aUlYNW5uS2loRHhHNUJobzBEMWRRQUwrOEZaYUdKN0tRMHk1dURGTHNZMVlG?=
 =?utf-8?B?RnRTYjJiOGt6dDBYMW1PSjhwZHEyQmdCcUZockNMWmVEbEt2am1pVmZIMGlF?=
 =?utf-8?B?R2hodHI5THJmSFErMVlpeERpRHl3S3g3ai9iL1haaTVlOEhxcU10d0EvR05X?=
 =?utf-8?B?YmNaM0l3YlhTT1FvSS94ak9EbTZoaFFKc3RROWpoZ3gxM3h0MWlUb0F1U0tW?=
 =?utf-8?B?R3dHZzlmZlVHdXRBaUd1TjZEVjJ6dmU3OG9JQkR5MVkvMlJ6WE9DZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 95650987-e05b-4345-60b8-08debe3b3367
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 11:04:20.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOD0tp1MwwSiGKgdH8EwTCo/rhaxdsgFfF/v4KAcoM02EN/6jzvzguZTT103kWQ5sprm5Fvik7UGWY091+o5WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7926

On Sat May 30, 2026 at 10:58 AM BST, Miguel Ojeda wrote:
> Starting with Rust 1.98.0 (expected 2026-08-20), Clippy is likely
> introducing a new lint `clippy::map_or_identity` [1][2], which currently
> triggers in a single case:
>=20
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
>=20
> The suggestion is valid, thus clean it up.
>=20
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust-clippy/issues/15801 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16052 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

