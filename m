Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557B48F847;
	Fri, 21 Aug 2026 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313777; cv=fail; b=Od5vFXZ9e6d+15hTEeAXQuWMLNckGAuP76tbuBR+qxNqak3gkEF+5KKGNE6x2JSZGKC5u/zGdcuFfa4JWb8aKDZ7fy4szYXYsK+3+5gxedG4B4dIS7OvsxXj4q/TZRqdELRFMRvSpjVgU4XOsDyiQHxQmTyEuRxzLod8KNcISN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313777; c=relaxed/simple;
	bh=Zqwr2cPu7P3ZIb7duEoDyhO2068dmT3Y/cWpZjTT/Nw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=u+lvISQEOsf+lVPzXrXNukChVrbAaI+E9Awoz9nluoiZ2zHzTCDmbMB9llp/7Gg941IbquCDZI6q+SyFMl7b6ohI45J4WNfBtMV9sgaKykc9n9SMsRd4H2OWput0r0T7BQRJkAbfiWa90z4Gk2XBWOr6L4v2Y4i0yS+vCaMYUJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N3hgQcHk; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N3hgQcHk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcuAo1Rl+kLTqoS2HxSWgpyOamzcBbQ9N4J9Jl1e9OoPZmy8SCcdaclF3nHHv4KX1fMx0NqYRkTRg4Jfbh0p1iwOQUR09zD5iSAiXCuUOY3/UdXRXYjdIdhwd+VlKsZVdI0gg6ovp/oHx5yq94wyO1PQt87oy3NsmpWMoymjHYH40OpgptTRfSzWDphtHyOmczUuFqcA9+gnK0zyVsX3jWyeJFCCyYOcKOdjz1B4VQ0TPhE+735L7uaXQwxkym3dcQ3wW5ZMSF04VneqAQpAjFK39qi7OaiPUaXF8Jz8gL9bl4EhNORHN34edCfYPBBJd66SdX3rFPoJO42n1+6V0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv6w0DSGzxhUaxP2iLlSR8zZnU6CnGi3NvQufHULswg=;
 b=p4Chm21C6GeiqyDeY5AkzSa6+KMf2QfJaTpX+NHpiwhrqx1RYKFSdqWtOuvBsZcIq3Eb9ubzZ72jfYSEIfNqE8KBnMBM8ak0XVuciEb+Iger5Kdm+N2KrmNVDmPlbSm2ftuP2GwCawAGXx8mrM2h6kHNpPNDZv2Fj5ZBP/Im+aADzX0asWPvIizPRn89dUPkf8WZu05MdLIi4DEZWZP7W+JcCjFi+b1M8pLf3wawmR2NJNkVkMrSoZxXuSd1hZlb+VhhhhdyD4L/3GiIeT+0+M9GZPSlKRoIKD4UOVLE3yQuKAaGI9cRlRex27hGLTosFMW64ZZVJbLEvk8SWgnD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv6w0DSGzxhUaxP2iLlSR8zZnU6CnGi3NvQufHULswg=;
 b=N3hgQcHkvQJzlVbYbDLj61kwhgRimABcSrfRYBETVRA7fBj3bWNaxDU+a0wrARhcmE6PipC3gmM+LP6n8uaJEtH55VPll3sr2c2XmRfrGrQzU13LykZW5TCWDPJ72IF1R98sYq265eVa1bD/omeO+9pWBa9f1NdhB7H+p8JyfUfm9dQJrZaxeR2Sio6vhbVXS5UZKNu1bEz+z1OfTROUp+NGV7Q8xTxcItwY1o5hJYIVB4SlHAV7DFegbJeOIH08pLvdB+AsQk56oRoz13lckcBOeCX1cPAnDWG19Nba8MnNwcIBn9PxlL4PJ3ZUBb4MeB23fxExQMmNth4+s10iRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 12:02:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 12:02:49 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 21:02:45 +0900
Message-Id: <DKULUOXLCWCH.6RUE2BRSAOCT@nvidia.com>
To: "Younes Akhouayri via B4 Relay" <devnull+git.younes.io@kernel.org>
Cc: <git@younes.io>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] rust: num: restrict bool conversion to unsigned
 Bounded
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260815-fix-rust-bounded-from-bool-submit-v3-1-fdca23008397@younes.io>
In-Reply-To: <20260815-fix-rust-bounded-from-bool-submit-v3-1-fdca23008397@younes.io>
X-ClientProxiedBy: TY4PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c435449-e65d-4d20-4c0d-08deff7c1ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hrexfpC3zrP4ZlFtF9v2U+/8Hn+wcY3Hqh5SEZ1V41GGf9vzd3XHSGb4Eso4L2okWY1uFzDPYn+1sZ70r67REo7k2rWZZyiYJwtoP8h2n4T6JCG0KRDvYfRfDMnVFn4NIF34g4GtqA7GBRB8834fsw/HvLQ7irzI+LwOUMK5hc9zLTpycFL8R73ixPlPuRKnS2jHPwhBeOVdI5/wn2X8huGCpP9RhQZcFiNfbLR9jEm8yHcZtVgELd9q3mdjSKT5o5errFCf3ngBYd8OAbklMrIGMdTVxdkXQGjUdaZ0I9NGkVlSyBbXbNI7hyg9a7ws1jAMHTcSf9YlgUqs7L5hh7WbiVQbyXRUo+cB1IDHS+lhkz3OLHtVBIGy5FRACxD+A69teDCSFQXf118H5wEkNmXCvrrE5B+WA1rhqWpCO3LRbMm5QLfftG4499Oas1GbvZbvtdbJQ5UOhD0iuUBhF0llyH2HWJgKQKmEgE/u4jubmZqnvpIAzRFwkBJ/bBJ3Aus6siiQ9+T0vlrMyw97Wk8A8K10s6GJCJs0U7BEGZPYObunW/eLueEJliUxFGl2bKKdtWMfjzgN4vCZA/JNZ01dNKvtRhIVUSHefXIyUs/hDv4tOGxxX7h6Nnx7KoYOVxDdCn1FbV0Vn1hfy7Ihnbq8unJ2OHi1xKhPy5D2K9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejluWVFJUDl2RUhJd3M2UWdSL3owa0pJaC8wUjQrVHhKbThiQVo1VFphNS9F?=
 =?utf-8?B?VlYwZmZ5RU1aRFVLQ2pIWVNFM0FmMHpvaHZTTzdPUGZkcEFSaXFHUndZbi9B?=
 =?utf-8?B?Y3RJNUJuZ0hoV2FoMEt0Tmdielc2RUNYeDRBZnpocFZ4ckl2Tm9YNG00SjFL?=
 =?utf-8?B?bGIxcnNzUG1xVzVsb3J1TDVEM3MvbFJTOE42bDBTN2ozZXYxVTlsZU1CNHgr?=
 =?utf-8?B?Y1h0S2t0WlJNajVpMUtBQ2htZFIvSUV6RGNRNnpvNUU1VDVZODJ4bUgzU05S?=
 =?utf-8?B?NUZYQ0Y5bDA0NWdYcnZKT2prRk93RldBTkNzWHBQNXd1VHdFdmg5UmtXZ1RO?=
 =?utf-8?B?M1lwUGtrN0VnZzU4RTN2L2pCcDlHNXRiNTdiTis3dVpNSGFCUGM5aDJOaUtm?=
 =?utf-8?B?WEdrZ3Uwc2RqNkNqUDZPekwrS2dWM0grSUtBanhad1FRbHAyaXJOTGhDbnpo?=
 =?utf-8?B?bU00OHRsenU3bjFmcUNtN0hkNXpzcC9xcjI1SXNmMVhXTkt4YzJWeHlNQ1Fp?=
 =?utf-8?B?d1lVWVQ5R28wcUdjNzlGY2pzSnlLMzJnd3pjOXNBTWZwSDJVNFMvTU1rZnEy?=
 =?utf-8?B?aDI0SHpwemYyblYzNlBKL2ZNdDJabDd4d2s5ZHcvOWExcHhPT1RIeE5kQkd0?=
 =?utf-8?B?MEFnbmdMZDdJem9IUGg1NVg0T0FpWXVLdnhHNGVXakFjQjJvOTZnUUZZZ1M3?=
 =?utf-8?B?TFZoWVg0aW10RWRsVnEzcnNHTHFQWEROSGFseVVOYXFVbTlmTHZzQ25wY0hG?=
 =?utf-8?B?VnhwYW1Xdk1tUHN1RVNVdEltSkRlMUkzZ3M4RUZEOFVxaWlMNmphRXgwNGdW?=
 =?utf-8?B?MVFicmZkUlF0Wm93L2xUZnpOWkpUY1hzczBCMk5pNk9XM05Qc1dQWnQrSmFh?=
 =?utf-8?B?R2Z6aHVrV09XMmZYV05IV2N4aURWVi9PRUxlYjU2bC9xOGpyS2p3ZFFkV296?=
 =?utf-8?B?VkNZUkFGQXZqQnBSK1hRYWxnZUpwek9lUmpFcHNWQURweVh6NTlDd3hHL0kz?=
 =?utf-8?B?MEFEYTFZOHpXWmFFZEtmMitoR29ObVNCc0IrdldUQ2lZRXh6eFRtZDkxYjhk?=
 =?utf-8?B?aGo4KzEvZFYxWThpTlFDd1preHVqdGFYRDZ1MU44UTl3Q1RNeDQ3Z3p5VlpG?=
 =?utf-8?B?LytaTlZzcHp0QUl1aW12aG1vbkViMkZONWdoa0N3QVZXR09nVHZ4QkJoR0lq?=
 =?utf-8?B?MTIzbWZGQkUzTU4zZTgvV0JRUkdsVUhqT0JQM0FGbE5HVGtVRWtxNTluUHNi?=
 =?utf-8?B?KzBQMFNUR04rMk1ZVU41UW5zODBnMnMyYW82bVpaU1RlTUFhcnpmVVFLRXhw?=
 =?utf-8?B?d3QxNWM3eFBlMjl3ZU5sZjRVcGthSUtDN29JUlMxZHN0VDluK1QwYlkzbXRm?=
 =?utf-8?B?R2psVkhsSzIydG1kdndVUXFQeklocGRTd25yR2ZqaVhIQ3BzYmplQkdId0dM?=
 =?utf-8?B?MmFJdGE1cnpvdHF2TCs4UDloVGlINGE2VCs4bHdyMVVBSnBEcHovVFdrRTlW?=
 =?utf-8?B?ZzE3Qk1sSUlOVTMzWVZmRXEvZkZVeDloSkMxT09TNjFoc2p4eUVSUmpGdmY1?=
 =?utf-8?B?cytBZnIwS0oyTEdObVR1Vzh4RjBubSs1OUlzRFg3WTRuK3lzM0lPa1VhNlpW?=
 =?utf-8?B?b3M3RkFNQWNqQ3cyYmk2QWhaK1NuU1VIb2Z5Q3FFN2ZPdlZHd2x4K0tRU3o5?=
 =?utf-8?B?SncvY3FKUStTN0picVREYTBGNWRMOTZJNzY0d01TM3lzMTdSOEJwVVhqcitm?=
 =?utf-8?B?YUNyTmtLWWRXYUJoOWxwY1VMRG80OUswTWFmMFZrNWtqQmQwNmhsS25waTQx?=
 =?utf-8?B?cUpHUlUrU2lIMExXbG9DMDlqUmNQd21WNjlYL00xUGdDK2ErTnhQTC84R1RY?=
 =?utf-8?B?cGprK1c2a09VZUNBMHRDeHZoc1ZSRkducy80eEw4RkhweUpqVjFKWEtVQ3ZO?=
 =?utf-8?B?bFNEMjQyb0tyNWNxVU96c25PMllOTE1OUGFFRUdJYlgwUndKWkNibnFDVTJa?=
 =?utf-8?B?d2FZdW8ra3ZNYTJ1OFR2ZUVuTDB4aWRQOG5UQkY1WU9lSEhXbHR3NS9mYXhZ?=
 =?utf-8?B?VkVIeXJ5QzM2WnRQWjV5VzMwSGJmdWxjd0FhdHFqNXBXZjkvM0lscHNJWS9a?=
 =?utf-8?B?UHdPd21uR05teS82MWRBSmJLbkdiYTE4L3ZES3N5NTBpNCt1bWEvbmNwMElv?=
 =?utf-8?B?UEwxQVorN3VRZmZLd1ZWa01oZjFjMWhjOEdLODZwc2o2VjRwZExObEdibG0x?=
 =?utf-8?B?OGRNSFFpZ0cvMnRWanRGUGR4dmJBQ050RTZySlNxalRnd095dmljZzBCNW9X?=
 =?utf-8?B?czBsZ0xNckw5SWNJdXJuZ1FsWHRUY0Z5dHBGNzBsVnYwYkY1ckd2MWd5dEhT?=
 =?utf-8?Q?HHVYYKMQ4oF/nA8kMcd8S2L1x+9/Cu+rM5cG4HiPhB3xZ?=
X-MS-Exchange-AntiSpam-MessageData-1: icsmkcsEfqokqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c435449-e65d-4d20-4c0d-08deff7c1ee7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 12:02:49.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nAiOAYOyRcxSETfC+wpdFO18REyJCwZO+fpDExbgeTATeCOW+ZI5VGAsvPBGYmugiFXW+UpauclvmohF2J2ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

On Sun Aug 16, 2026 at 5:12 AM JST, Younes Akhouayri via B4 Relay wrote:
> From: Younes Akhouayri <git@younes.io>
>
> From<bool> turns true into 1. A signed Bounded with N =3D 1 can hold
> only -1 and 0. The current implementation can therefore create a value
> that breaks Bounded's invariant. Deref relies on that invariant and
> calls unreachable_unchecked() when it is broken, so safe Rust can reach
> undefined behavior.
>
> The other primitive conversions require the source and destination to
> have the same signedness. Treat bool as an unsigned one-bit value and
> allow this conversion only for unsigned Bounded types.
>
> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
> Closes: https://lore.kernel.org/rust-for-linux/OzuVxu0--J-9@younes.io/
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Younes Akhouayri <git@younes.io>

Thanks, I think this looks good and limiting the conversion to unsigneds
is reasonable. If a signed Bounded is needed, the caller can always
perform another conversion step.

Just one question below.

> ---
> Only allow From<bool> for unsigned Bounded types.
> ---
> Changes in v3:
> - Restrict From<bool> to unsigned Bounded types, matching the other
>   primitive conversions.
> - Remove the BoolFits helper and signed-width list.
> - Link to v2: https://lore.kernel.org/rust-for-linux/20260815-fix-rust-bo=
unded-from-bool-submit-v2-1-aa35bb2c22d1@younes.io/
>
> Changes in v2:
> - Use vertical formatting for the nested `num` import.
> - Link to v1: https://lore.kernel.org/rust-for-linux/20260815-fix-rust-bo=
unded-from-bool-submit-v1-1-882227bf40ba@younes.io/
> ---
>  rust/kernel/num/bounded.rs | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
> index d192610a687d..f2413dc7458b 100644
> --- a/rust/kernel/num/bounded.rs
> +++ b/rust/kernel/num/bounded.rs
> @@ -13,7 +13,10 @@
>  };
> =20
>  use kernel::{
> -    num::Integer,
> +    num::{
> +        Integer,
> +        Unsigned, //
> +    },
>      prelude::*, //
>  };
> =20
> @@ -174,13 +177,16 @@ fn fits_within<T: Integer>(value: T, num_bits: u32)=
 -> bool {
>  /// // `u8` (regardless of the passed value).
>  /// // let _ =3D Bounded::<u32, 6>::from(10u8);
>  ///
> -/// // Booleans can be converted into single-bit `Bounded`s.
> +/// // Booleans can be converted into unsigned `Bounded`s.
>  ///
>  /// let v =3D Bounded::<u64, 1>::from(false);
>  /// assert_eq!(v.get(), 0);
>  ///
>  /// let v =3D Bounded::<u64, 1>::from(true);
>  /// assert_eq!(v.get(), 1);
> +///
> +/// // This does not build because `i8` is signed.
> +/// // let _ =3D Bounded::<i8, 2>::from(true);
>  /// ```
>  ///
>  /// Infallible conversions from a [`Bounded`] to a primitive integer are=
 also supported, and
> @@ -1109,7 +1115,7 @@ fn from(value: Bounded<T, N>) -> $type {
>      i8 i16 i32 i64 isize
>  );
> =20
> -// Single-bit `Bounded`s can be converted from/to a boolean.
> +// Single-bit `Bounded`s can be converted to a boolean.

Since the `From` direction is now limited to unsigned `Bounded`s, maybe
this conversion should as well?
