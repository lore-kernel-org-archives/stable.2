Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020106.outbound.protection.outlook.com [52.101.195.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2263B6347;
	Tue,  8 Sep 2026 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900858; cv=fail; b=Sg7ZPkp7J6xs/rfRq9sAtRAxF1GKVv3hEFCQLTSd+RaEG46NoS78ZijVfxqDl0XqXjpRr+f9MK+PF36oRFD9P2IeczxpuhwDqtvmnz8rqtTt6JJtrJU2UkzmAyuVAMTTomnyNnhdWwD1kC0Wvdk/DaG04YtoAjHnsFY39e5MhYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900858; c=relaxed/simple;
	bh=zeloaV7mDFuyS5xk6FEwQMBMaGxW7TsTvtjhDjNtCp0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=WPwcBG0AiHB4fXHK8iBbiYq0unHW9gS2N3Kp9Alni0TQ4irrNDBaZKwe//b3pUoJonHyUGWy0beVwBFNr3vKQTCXU5vdjPecSgcU1aZGhoJyjPUMgSAJ1tyge/hf2LEaZuIwV8q8QB2JkylerL6DQsi6Z70Z3x1YulCHKeulDxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CMh6rO1b; arc=fail smtp.client-ip=52.101.195.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CMh6rO1b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeF45zA3Bc3H2+7QYBCKk4yHo4/ZUTIWb0NvNbaXZVgj+6M5SLh3qDzZg8PmtjMxv0zpBvthJAPpE/pq96B1B/nYVReDTGLCrDXrAZZwSP72LMlyfak9gEj7iosoTc0X1nahU66aeWkAbFrYELQUWTudqwH8GNkC5n5vJGjZDicroWXGMZSpJmTqQtwmQXyjUlXEIAJ+ibNAt0/7GHV2SsxZD1kbOGN33io85g7vmDkT9gvVX2XkEpNlYYdANXXL0okvUDwfh3b3FRrY+Yq77KtVW+mwG0SkdI+b6O8gT/kLXKgYrw4wXP4hf5XfK0rAQbdar10L0RCJr7HSD0Hq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiQ0ANC3i1Hg61e5gSaFpFcV+U5SVXE7NPbosieutsg=;
 b=ZwX+rL1axRmO0dv7Cjmh90oSgMcRUtxBnV0zwsFlXxhYf6MFYTlbfKlmj6YMWLOe/yPo15ovGXKLSCw/66oX+jQLpfPb9mjlfYzVmjMM3vBZGjMPlkChg+0v2NJjY9fnMrXpByMR1hJEx1PRAx//6jK4UZOF2Qd5u/eYUYc2gZMm6K5mLroNUFqgxs0fTmirXV/Qeh2lG8sQvgnr09irkxu9CwUp4hU0eo04RMN0JrQ4mm+Fgl0WBNMhhSuO3i1o3aB7khDdsEiSLB29QnsmgzA9Vkyx0mjkf8CMtoxewlMzec/IhJgUxyVQpCYL6rzORZHz+8cabMVdoRaAS7lk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiQ0ANC3i1Hg61e5gSaFpFcV+U5SVXE7NPbosieutsg=;
 b=CMh6rO1b5DpGlFxnmkAr9GvwNcs2oJl3a/SfAuVZZUDJ3yT8szU1j4yg3zvHJXkZUGKjZn8WsnNutFBvsh0u5/iQB1ba5gbVIwaKM7uiKbO0aFsoRsgG/u/Og7tX5bJ4HGWRucP2ApqZ/baPsfIywfIqXO/c9FgZK8pw+umbJDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5185.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:54:12 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 20:54:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 21:54:11 +0100
Message-Id: <DLA8FDX8R5V0.7L5PQVACRZ75@garyguo.net>
Subject: Re: [PATCH] rust: allow `unknown_lints` in generated bindings for
 Rust < 1.88
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <stable@vger.kernel.org>,
 =?utf-8?q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
X-Mailer: aerc 0.22.0
References: <20260908170539.345207-1-ojeda@kernel.org>
In-Reply-To: <20260908170539.345207-1-ojeda@kernel.org>
X-ClientProxiedBy: PAYP264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 49993475-b317-49c6-8ca6-08df0deb5639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|376014|7416014|18002099003|22082099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	T1SZURHtjRBZgT5yel6OXSrD1tQ5Eb4uJGkEmJ0Mwili76fYp4Q1OnXkzfIxtJbvgg5zoZgEAZWkDS+gwrdnyguwTh7aLDcKesESt/oF88LYjZYTrLZU5M1xAi78hPTeDdcehWTwY/kHfcbdcRonhlrl5+u9hiIRylYfyYahyDEEaTe73DwUIkcneka8YoCIvDi+o0MfE0vZpZrzLnylXQO322+OTtV6ISatJ2Lxd0lZmS9w/CiLocVucqBDwBlgONsRb34ENWXKl2+rEhmrVUEDPMZEyIqZa4IQgIrSs6U9qABHMoSIJ5vJtLqyQsgHtKqCKsV7/W2WEUqfdVoQHYCQ2d5K1cNetKaNS1tSalXjhLUzKKw/y9SuG09Es78G8AVU5WBzB98q+4Fmz+P3Opw6t7bLmTI51znTgWiJbpUi7iSvX9ACCyHzGhcy6wsQA9MBvKOQdWvbNlZ/IP2vuP/Vgpbd3oZFMwzEe3jtEPYnReX09pGF03EAFuOb8dF+ycP1LxDaf3qAzRcv2NzYZxK0jLQptdn6cJ5YluUMQVftLH8gsIFsNyk9QA2gxhG76UB/DD4E/Poktd4fLZRD/VJwvAgv33MUufIVqFyek9CQ4cV/m+ZHl/5kf6T4/Rt9y6BgYlbdNi7MSYgj4Nx44dPOPcvtMQKK00hE8HZcAA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(7416014)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVpRDV5bTVwR3J6OUNhUngxenBESDJYTVNUQ1g0Vk4xL3BEWWlicGJZMHFG?=
 =?utf-8?B?NUUzT0NZY3pOS29SV243T3FrbEZlcVZNd2o0Y3F5TExXeHlXT0JEL1dzWFAr?=
 =?utf-8?B?ZXZsS090VEhUNW1vbUlzVFV5aWtSNUlOOWhhQUNsQ0htVUhZWlB1cEtMZXgr?=
 =?utf-8?B?aXE4Y0ttazBCTzhtNytMTyszQXBjTmZlVXdKTUFiby9oWjBQS0hVZXB3dk56?=
 =?utf-8?B?RjRRSVNOc010eXJxdXJsSTNnN0pkaUttSnhiNGRjcDR0ekRnMVFobUNIQXFa?=
 =?utf-8?B?QmdhR2J4bmNTT3JrTWo5TWFRV1E1Z3l0MkkxWXJDd2ZHRG5JdmhkVUI0TFNS?=
 =?utf-8?B?NW93VG90dHRlRE9DdUtxWGIwZ25sNGRScVFVcnIzMmZ0VUNCYkVla1JWL0x0?=
 =?utf-8?B?K0N4RjhiVmZhYkFXKzRUeFphN2xBek43cVVwMGdTUkJkM2xrcDdUUytGZWc1?=
 =?utf-8?B?ZGs1RDQzeVByM1VVc1BLb0dENkk3RmJOWWpTMEVra3dMYkRDRlI3dk92VHBs?=
 =?utf-8?B?YXY3NFBjenJjbXVUTEdrVnVTTzZjNnNlZHNuYVVvSzJZMGlQMms0RWw3OUN4?=
 =?utf-8?B?TmZhcEdBbUp1am5WM0FJSHh1QnRua1I0ZFRmcW4yVVRHZ2tNeENOS3E2ZmFW?=
 =?utf-8?B?My9IcDd3TDU0amdZTTJBMjJIeHRscjBXWHphUWJJMi9EaFRhYnFlQThjOWFP?=
 =?utf-8?B?YTZkUHdma2taV1M1RTVDN1JYUzlNNWRMQlFNeEdITVdvUnpRS3BaV05vNHBT?=
 =?utf-8?B?SklackVVdi8vM2JHck1GYkNPYkRDRS96MHNsY3pQT2lUUGl6dTZ3SkU1TlAx?=
 =?utf-8?B?dEk1enZRRkVGeWxaQVFSeEJmeEc5NGFkRXBQQ2pvMjYycHBEZWl1TXBZY0dM?=
 =?utf-8?B?bWlzeXNqMG1YcFM1Y0R6V0d4dGtBZWpCclh4SVRSaS9xTlVZbmc1akhpZUx4?=
 =?utf-8?B?OFNIbkxrb0hmamN1SkJSRkVINVVGaWUwMVowUnY4RDRjWkVLeE5NUGFud05D?=
 =?utf-8?B?S1UxK3ZYbVI0V09aRFErSzF2T1V6R0hBT1NGZXNHM0sxM2dqTzZNQjdCN1Vr?=
 =?utf-8?B?aUkvQW1WMzlYanc3QkYxdkFjZyt1LzY4QW5tek1hU3hRdldMWkk4QnNQQ2ha?=
 =?utf-8?B?TW9rNHRmbUU5MWZkbGFJWVB0MTFjWHZkTUVXTnJMeFZxU0dYazdsazI5QjhU?=
 =?utf-8?B?dmkzWDdwS3dubmMweXB6cUc5WkUveklHYnZxTDBraWpaK1pIa2VVUlpxNm1U?=
 =?utf-8?B?TGlKQXRuSTlzOEM5d1RzU1hualoxZHZBNVpXZ3VvVWFjdjJkeWV2YmozcFBO?=
 =?utf-8?B?YW05K3RSN0NhMXBuTDg0eldVUVRFSVJOZ3k5WGlMK2dmbGpJTkcxbHhuVGk0?=
 =?utf-8?B?RFhJbWNkSklxRllwRTh0NDNKUjZjZFZmVEVwSzZsVGxVcjdmaTRicFU4QnBx?=
 =?utf-8?B?ZlIvNDNGSWswaisyek5Mb1R3L3JsVHFiRTgyUVduQ1AybWE5V29vamVhZEZT?=
 =?utf-8?B?UC9lbzVVVnZyUXN4Q2Raa0g3RXNEWFBHanJVZFZ3b3BWb25KR2xrSTNUeU1v?=
 =?utf-8?B?SStPbXZIVjZHcGEzazVrVmNFUDMyNEc1RDEzeFFoR0MxbFJoU0hYbzBSTUpO?=
 =?utf-8?B?dGh1YlBGL2EvL1kzbkY0cW9LVTdySnJZb1E1Z2o3bWo3dzBzcnMyZ2hRbmxh?=
 =?utf-8?B?SjNDamwvUkRmM0RDT1B5dW5KTHhvYlloT04vQXFEcXd6cmNoc1JsZmUvQytG?=
 =?utf-8?B?dEJ1YytEWGJqdzk1SjdOQyt2bkFFbE5ISHE3OHo1MXJvZ1VvalAzVE9PSjhq?=
 =?utf-8?B?a3hBT3NHRldIbXlrNVFsTi83ZTNwcTVFandMNmN0RzA1akVLcEZVc3UySS93?=
 =?utf-8?B?alRlbUQ0akF5UURKZDgzdkpoYjUxLzk1NXh1RWFXVkNTQ052Y1JTTmtabDVF?=
 =?utf-8?B?RzdvOG00NDN1T1hkMTJnaHQxSmFHNEhxOTVmb3lQdTFtOFF4RDF4MEh0VGxx?=
 =?utf-8?B?RjFKZktON1NZU3pBc0xDUktiSWhOanFPU2VrejJoOEdOUHdWSWRDTFMxNlFR?=
 =?utf-8?B?M2JSQTVEV3dNdTRJTll2azM3enNCVXM0Y2N1Q3JSNkNGNUxlOFRvcUJlUVVB?=
 =?utf-8?B?MVJZSWU1dWk0ZkY3MldiMTU0L2hUZEROdmhUK0F4YWdBVEs3VDd6NFBBT2V4?=
 =?utf-8?B?NVR3dnplblhvdWNlZk1oZG84WHJ1WUw3VHE0bjlmeG1nZ01VMTJ3RDFEV0tC?=
 =?utf-8?B?YXQxVm4wTmFYbU4yeE1lZXFSL2NkMUJOSkdGVHBLSGlkY2t6ZUVkbzFqZHQw?=
 =?utf-8?B?d3IvZ1EwQTU3ellqMVZjQ1VmeVJzZ1JnRkE4M1BFVEdmZk5VN1hGQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 49993475-b317-49c6-8ca6-08df0deb5639
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:54:12.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8e+EvyBJlHabIyhfInFVlRPXio79LhY/LnjQ3nxTBxNoqivW0YvdbA4XuB3QGPfTXSB3VYCS/4bwZJ6FtYcYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5185

On Tue Sep 8, 2026 at 6:05 PM BST, Miguel Ojeda wrote:
> Starting with bindgen 0.73.2 [1], `#[allow(unnecessary_transmutes)]`
> are used, even when `--rust-target 1.85` is passed.
>
> However, the lint was introduced in Rust 1.88.0. Thus building with
> older Rust versions warns like:
>
>     error: unknown lint: `unnecessary_transmutes`
>          --> rust/uapi/uapi_generated.rs:26294:13
>           |
>     26294 |     #[allow(unnecessary_transmutes)]
>           |             ^^^^^^^^^^^^^^^^^^^^^^
>           |
>           =3D note: `-D unknown-lints` implied by `-D warnings`
>           =3D help: to override `-D warnings` add `#[allow(unknown_lints)=
]`
>
> Thus allow `unknown_lints` in the generated bindings -- only when buildin=
g
> with older Rust versions.
>
> I have asked upstream if this is intentional [1], i.e. if we are supposed
> to always allow unknown lints in case `bindgen` uses such attributes,
> or whether it is an oversight.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Cc: Emilio Cobos =C3=81lvarez <emilio@crisal.io>
> Link: https://github.com/rust-lang/rust-bindgen/pull/3455 [1]
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/bindings/lib.rs | 1 +
>  rust/uapi/lib.rs     | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index ad24c920b919..9e2c9a8e7e6c 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -27,6 +27,7 @@
>  #[allow(clippy::ptr_as_ptr)]
>  #[allow(clippy::ref_as_ptr)]
>  #[allow(clippy::undocumented_unsafe_blocks)]
> +#[cfg_attr(not(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES), allow(unknown_l=
ints))]
>  #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_tr=
ansmutes))]

I think we can drop the cfg on the `allow(unnecessary_transmutes)`.

Best,
Gary

>  #[cfg_attr(
>      CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> index 2df0340e63d1..c1e27192ecce 100644
> --- a/rust/uapi/lib.rs
> +++ b/rust/uapi/lib.rs
> @@ -24,6 +24,7 @@
>      unreachable_pub,
>      unsafe_op_in_unsafe_fn
>  )]
> +#![cfg_attr(not(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES), allow(unknown_=
lints))]
>  #![cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_t=
ransmutes))]
>  #![cfg_attr(
>      CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
>
> base-commit: 2ac74c6db40adaa29c50cbb281ae9a6f63de18e1


