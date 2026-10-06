Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804423D9DBC;
	Tue,  6 Oct 2026 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320960; cv=fail; b=MkljnTj/oZnUZZQb9RO/ElRINIp3baKlT+8r39GehfrBqVj5Nnr5gtETHxj7W8lbWDjzq1WbUZsm6d09sSa0tkhqHZmYLlkEPXDgfGeh0PQgBS/QpuGgJcvSSjvp3R5hM00RtjAqPe4aLeaB7QyzD6P2DvvEbgSrjBNMc4nPxOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320960; c=relaxed/simple;
	bh=PwwV/xRhS6qrCUcrzM2/qAqHHOwSgBI7P6D1Xl5YaxU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VE49/5QfI48vFcwKy8d2BlaE19J+uOhb+zEdP66SJv2IaKfoOB+aLtC6Vv8bS1EEScyklyKLfmYplVatf1S4JHjARa3fY+hFytRHbDOBpKvcJgZZlp97kogkUPOqzR2vZPwjBJBQPJADNLg3sfYTzmQXlfFw/wEHba6IeIB5NuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=r6hnaXV1; arc=fail smtp.client-ip=52.101.95.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="r6hnaXV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy9143K0MMLZKl4LS6e3tZ1vlwPCdqca6Re+UrP5cCm7D/ctWQ3ioiGJNfbjsAz9k6qDW43SwyjuPwapL8/m7BphY1j0ig5QSEEBlBCMbbjv7vDPOEOCJgH0Zfb7gJ5d0KVwpS4X9lypZuNHeeSJ7ssULGZGpCRqMABByRoLhUe/hN1KBRzRUe8EQ5uhnrx0xyF+MTYII5ftE5aSDdXus1osORmVxxaoO3kVsTTISmgtc/k3EIfX5CTqAkD1EcPgQ5ke2DKKwlSLa35zxmwKEqAhOdRRJlTcobzaHFtlkd5RRRoQlTLT06h3o/DCGApVmpyu1kQ6UYqt/I5mHPy0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o1k326ywpR90hbjLz4kAduzocYsjvIp0ws5fBCDY28=;
 b=WtqeAuvVHB+6vEYifO8g8IKcBaP4IRdWA/NoEZ3z+G0/oL9iYVZgGzorOjf5nuJ2905N+xswVSIpRYSbgwgQDQXdvU6tprDfrkOsS5TrPysCoAiyDaMOA2r8gUqBkKs/ytttxMH5+vY56s125qSpYA4euX5DoQectgIEO4rCIOws/yM4eaL/jUEi0CXyXoGGuZ5NS7vjCTMxL0y/T4hOAJ4zdyE7Fr1qdoA7PhWrZhf9imNLRsfUho7lyxGkMtO9Ye/HqsCdfZJXJpYuvwTfkUztHyu7GbWKysQY+1B/mFeNgkIenQOATYLW0yMTg4KcLE4EuOggNQPiRe/2/y4mPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o1k326ywpR90hbjLz4kAduzocYsjvIp0ws5fBCDY28=;
 b=r6hnaXV1UqpFaQsuSfSwu/PMiWIeHhv+KytMjHlryHwZ38835nhbAXInF2604ivkytnKIh6bvdcoZE/uKJl/FYwhKyp5p20olFQPKdHQbGB+JZBfK6EqtS9oeEFAsQqi0203fFEhAXxwKA7wVAdChLV07jSr1p4BKxgK92g1oFo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB7232.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:344::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 21:09:13 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 21:09:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 23:09:09 +0200
Message-Id: <DLY2A3MDYYTH.2IXSHIKU7SJEH@garyguo.net>
Cc: <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "open list:RUST" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: fmt: drop the "0x" prefix from {:p} to match %p
From: "Gary Guo" <gary@garyguo.net>
To: "Carlos Llamas" <cmllamas@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Ke Sun"
 <sunke@kylinos.cn>, "Dirk Behme" <dirk.behme@de.bosch.com>
X-Mailer: aerc 0.22.0
References: <20261006183857.396710-1-cmllamas@google.com>
In-Reply-To: <20261006183857.396710-1-cmllamas@google.com>
X-ClientProxiedBy: VIUP296CA0086.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 958b33d2-1090-46b4-9039-08df23ee12ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|6133799003|3023799007|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	m73Fx79Jbs70MxntPMFIRwkeG/aZIH5QeB7vL2JZI+K9nXSKDT7bx3i7L+CGmi6vmFV4FBqLngKPcKmEezLV2vCSLGVZOneG7KHQiyF4Uo4XzB9kaDp3/Ei667x0OBLo7/lfzrmi0tu3eDqzsHrcpLsmP8/WUzYGWxqy7jZN8d6LKe0VxYw8g0UVTjJDzofL7itpcPIAN4L8j6mZb74yNSQycrfyDUWDW+kh3TtHDx3OoxLpfn7XzmZNfoZZvqqSZ+efT6mugnEDzdoIltc79VZN2pZ/Nf6fkK1kHp5XgzKNKceKxWyMfg7HnvlU8ReZqOmwS1cyHeGYu+MAwmcTW/S1p4txdULVQauNShwFOeclfij/tbtG1D7D1k3bFwfTyxD+GDi/Jv+hB6iSzWfzAu65xHLLiyBbekGzYCcukYeguQKVEBbgcW+hSVOOIwU2JSj+uiYtb9tseQc7I5yq8zA3TSWtvs/FmHKFoaqKD0EW6Ec+jb453w2RBeXsPAb2bv7kNE6oENF9dt53OtEshYdwJjrG+lyBZnqG3hfyjRhbZh+qtpkdJassi7XsqhjcexLbQ9RPLKq2bVUu9B9+69ua1EGc352VNRLxfnumF3aVEKevJdFdwxc0nbF/kZ8qcTbgpeJsqL/RGGQrRIB871aXfLwoo6Ucb48VCeHSM6bnUDwMKJeBd8PHHpcEpiZI0MPijpzibzEG4F5TUTYn/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGR2Ykg4dTdnTmdGM2ZESmZBUm1hY0NzeU1Xa1BXS2lORGlUd2t2OW1QRlNY?=
 =?utf-8?B?bndBOVRDNCtyWDBNUU4vclBVa04wZTc1cm0veExyckF2UDUwSnQ3dy9pNk1I?=
 =?utf-8?B?NmhlVXFuNFh6TW1CeUhQNGovcjFkNmZnTzFjdTNtenFpT0J6aHRqYUlWck83?=
 =?utf-8?B?WE5yWE1yS1FKayttb3RKYVowZjhaMStTWEk4NjJpMGs2T0lJM1JSZVo5ODRE?=
 =?utf-8?B?UVFiNk1LVDl4WWtaNUNUR3l3NGRQMi9iam02Smx6bEM2V1d2TG9JM1NxT0Qr?=
 =?utf-8?B?UFljMk5PTm9UeDBUbyt5d3l4K0NlRGprbFNONmFJUm96SjFKQzVtV2tKaTZa?=
 =?utf-8?B?N2k3V3VPOVB1YmZsS0VIYWUvU212dWw2WGZIQ1Q3OHhJakJSbCtXeW5NejlF?=
 =?utf-8?B?Y3lVMzFHTVFrTy94NFUyTndDTHFnakt1NjFrMVVtcHIrNDFaNzVIcTZCeHVE?=
 =?utf-8?B?VkRISy9xVzArdXBKbE8xZnpTdFRmWlVZbldBcFZqd1N3TXMzQXltN2JCenIy?=
 =?utf-8?B?WThxczBLbTlFU1ZxaS8xY3E4eUN2S2lROGptRTNuUkZiL2NZSDFsWUQ3OWpx?=
 =?utf-8?B?UC9aOE9seTlpc0F3a3ozeXVaRHFHZXpaUU5XT2tQMWNHbmxTc2JKdXNtMTNS?=
 =?utf-8?B?a3grYzVvNnlIa0FRU1g4djhnb0JSQlZpWUM1UFFOTFgrd3czUjdUMmx1cC9C?=
 =?utf-8?B?VUhvb3dtVGNoMDBMRTdmc3Fnd3orZXB4S3RVUmFWSHFRd0taT1FWeHQrajR3?=
 =?utf-8?B?Uzh5Y0Y3ako0eWhUdjJBTGZwM1l5aUZzOWFkL24rUC91RmRvNldabjNHS21U?=
 =?utf-8?B?NEpKV0t6SHM1d1dWbjh2VThmNDNENjJ1UVM3MXNMWGkvWXVTekxuWkZIVkZE?=
 =?utf-8?B?YWZWSG93M0UzZVdzeDhGMDIzWUZma3QwL0Q4K3RMY0d3dmdJd0IvK0lqajhN?=
 =?utf-8?B?TGs2UE5qd2pzWlRRSVJqQ1dBN1N2S09oZ3hqT091eXFqZnlmcElCT28yVE1M?=
 =?utf-8?B?akU4aEF0bDBDYjJLZUdTN21NNDhsS1dFaTBJZE41NjRQWTVLOE8vaVhIZE5s?=
 =?utf-8?B?RlB0LzM0NjFqWjYwVkZUazN0ajNYb2liZ1RleURYWUZscnZUNHhxRDNYNmQw?=
 =?utf-8?B?MlpMbGUxaGVlaXl1Slh1ZUZiL2h4dDd3dlFKK0N4dVRhVndsdGxTWTB6RWpU?=
 =?utf-8?B?MlJlUVVTUjhVY295STRSY1dxMzFCRTUybXhWdUZEd01PWk5yRWxXVHFiNVpw?=
 =?utf-8?B?UVdBWXBZeE9BZlorMEt6Q2thWkRJR21iWUp1N1hRSUVGWkpXS2wvUCtqRFVv?=
 =?utf-8?B?L1BPV3d3UXJVVG9udE1PY3FPcG8vdVpSaDEzLzdFNkRrWTdadCtqb01Iajl2?=
 =?utf-8?B?V0dJWVZJZUVDOUYvTnExcmNzVy9qejRWL0xjbDYwWXYrdlYvL2h4Y3ExWWxP?=
 =?utf-8?B?MVRFdXhvK2J1WC90Uit2Y3hZak4zdldJbDl6dDNaNzhvblFvYmNFeFIvckVk?=
 =?utf-8?B?Skh6RDU0cXBoMWgvTHh3ajNCOWExWkNNMUJScU1jV1BtZnF4dHBpUXhjUFdw?=
 =?utf-8?B?V2tzZW4ySmpiSDVGOG9iVmRNK0pmNnNrMnZ6dlMxdzgzRmNzOUw4ZWI4ZDA2?=
 =?utf-8?B?SUVXV25BK0FwTTdXNHVKdXcxT0NjY29pV1RjS25xMVAvemFxN1FjK2dSUDV4?=
 =?utf-8?B?T3RCNUphVktJQ2NleVA5b3JwOXFuaFVHUHl3czB0UW1BdDIwUGJ2QXo3MnF2?=
 =?utf-8?B?cWkvVHJvZy9QcTVWWGpEMFZyUmFNTkU4NkRER2k0ZlBHRzlVLzdlbEV1UjhX?=
 =?utf-8?B?cjROaU11MllZaXl3UndvaFRsUklEZWRoNmRMZU9FYTBMRWZleUtFRXBKaWha?=
 =?utf-8?B?ZkR5V0JnMDNsUnBZM20rMytuN1VEakwvUjA2d09mUS9BOFFVTGx5R1lCWEVz?=
 =?utf-8?B?Nytma3dFZjdPY2FwSURqVStTajNUaGxrMUhqZnU0elBuZ3J4WWFRVDFkOUky?=
 =?utf-8?B?OGFCUVNtREJkc0k3K0VFYytOS3NucnBzRUtScXJhZHprMUFrUHpQK3V4MnVv?=
 =?utf-8?B?bWkyMFBWeERLU2prSlpiTXFucTVrRENRYk5iaGZmZ3dKNDY0bFNhQit0N0Jt?=
 =?utf-8?B?VWlkc0RsaTZFRWM5RUYyeXFBZjQ0M011c2JMN3RZWWxlMldYQ002N1F6Sm1k?=
 =?utf-8?B?MlhQQ215OTVpYUZieSs1dzBJZ1BPSVBUNmpFNkg1NThXSEdRTisyN1VOWjQ0?=
 =?utf-8?B?NkpLYmtDNVVyZG5Jbytrek5ZdXROeTQxZHdCaUdRZC9jRTAwVTBWVk5hYnRa?=
 =?utf-8?B?WE9GaDYyL2U1QTVWa3lpVDY2WWk5OUVMaGYrcmRtM0xWZVk1MCtUdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 958b33d2-1090-46b4-9039-08df23ee12ca
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:09:13.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh6CU7YC/k5r4TkuTTJF+RdRIVgqQQpZYRyOMceyoaV0z8HDBp71KstMq2IRQ8E1CUdk3vI5dxRI9DZFaSDNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7232

On Tue Oct 6, 2026 at 8:38 PM CEST, Carlos Llamas wrote:
> Commit 643a7c306b8c ("rust: fmt: route {:p} through HashedPtr to prevent
> address leaks") made {:p} go through the kernel's %p so that pointers
> are hashed by default. However, it formats them with %#0*p, where the
> '#' flag prepends a '0x' prefix that the plain %p does not produce in C.
> Thus the same pointer is printed differently from C and from Rust:
>
>     C     %p      00000000e8efa736
>     Rust  {:p}  0x00000000e8efa736
>
> The prefix is a leftover from 'core::fmt::Pointer', which always adds
> one. However, doing so deviates from the %p format documented in
> Documentation/core-api/printk-formats.rst and makes it harder to
> correlate the same pointer across C and Rust messages.
>
> Format the pointer with '%0*p' instead and adjust the default field
> width accordingly, so that {:p} produces exactly the same output as
> plain %p which is zero-padded to the width of a pointer and without any
> prefix, both for hashed pointers and for real addresses under
> 'no_hash_pointers'. Update the KUnit test expectations to match.
>
> Note this patch focuses only on fixing the '{:p}' prefix to match %p.
> The '#' flag remains ignored as before, so the '{:#p}' equivalent to
> %#p should be sent as a follow up patch.
>
> Fixes: 643a7c306b8c ("rust: fmt: route {:p} through HashedPtr to prevent =
address leaks")

Rust libcore's `:p` also adds the 0x, so I don't consider this a fix.
This will be an intentional behaviour divergence from Rust format specifier=
, so
this fact need to be mentioned explicitly.

Best,
Gary

> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  rust/kernel/fmt.rs | 48 ++++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
>
> diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
> index 29582b053ab1..b35858a28d38 100644
> --- a/rust/kernel/fmt.rs
> +++ b/rust/kernel/fmt.rs
> @@ -64,6 +64,9 @@ pub trait Pointer {
>  /// By default, `%p` prints a hashed representation of the pointer addre=
ss to prevent kernel address
>  /// leaks. When the `no_hash_pointers` kernel command-line parameter is =
enabled, the real address is
>  /// printed instead (for debugging purposes).
> +///
> +/// The output matches that of `%p` in C: zero-padded to the width of a =
pointer and, unlike
> +/// [`core::fmt::Pointer`], without a `0x` prefix.
>  pub struct HashedPtr<T: ?Sized>(pub *const T);
> =20
>  impl<T: ?Sized> Pointer for HashedPtr<T> {
> @@ -72,33 +75,32 @@ fn fmt(&self, f: &mut Formatter<'_>) -> Result {
> =20
>          let mut buf =3D [0u8; 32];
> =20
> -        // Use `%#0*p` for the `0x` prefix and zero-padding; `+2` compen=
sates for
> -        // the prefix counting toward the field width.
> -        let default_width =3D (2 * size_of::<usize>() + 2) as c_int;
> +        // Like `%p`, zero-pad to the width of a pointer and do not add =
a `0x` prefix.
> +        let default_width =3D (2 * size_of::<usize>()) as c_int;
>          let width =3D match (f.sign_aware_zero_pad(), f.width()) {
>              (true, Some(w)) if w > 0 =3D> w.min(buf.len() - 1) as c_int,
>              _ =3D> default_width,
>          };
> =20
>          // SAFETY: `buf` is a valid, writable 32-byte buffer, sufficient=
 for
> -        // all architectures (max 19 bytes for 64-bit under the default =
width).
> +        // all architectures (max 17 bytes for 64-bit under the default =
width).
>          // The format string is null-terminated; `width` (c_int) and poi=
nter
>          // match the `%*` and `%p` specifiers.
>          let len =3D unsafe {
>              crate::bindings::scnprintf(
>                  buf.as_mut_ptr().cast(),
>                  buf.len(),
> -                c"%#0*p".as_char_ptr(),
> +                c"%0*p".as_char_ptr(),
>                  width,
>                  self.0.cast::<c_void>(),
>              )
>          };
> =20
> -        // SAFETY: `%#0*p` produces only ASCII, which is valid UTF-8.
> +        // SAFETY: `%0*p` produces only ASCII, which is valid UTF-8.
>          let s =3D unsafe { core::str::from_utf8_unchecked(&buf[..len as =
usize]) };
> =20
>          if f.sign_aware_zero_pad() {
> -            // `scnprintf` already applied the width and zero-padding vi=
a `%#0*p`.
> +            // `scnprintf` already applied the width and zero-padding vi=
a `%0*p`.
>              f.write_str(s)
>          } else {
>              f.pad(s)
> @@ -224,26 +226,26 @@ mod tests {
>      mod expected {
>          pub(super) const PTR_VALUE: usize =3D 0xffffffffdeadbeef;
>          pub(super) const PTR_VAL_NO_CRNG: &str =3D "(____ptrval____)";
> -        pub(super) const HASHED_PREFIX: &str =3D "0x00000000";
> -        pub(super) const RAW_POINTER: &str =3D "0xffffffffdeadbeef";
> -        pub(super) const PADDED_RIGHT: &str =3D "      0xffffffffdeadbee=
f";
> -        pub(super) const ZERO_PADDED: &str =3D "0x000000ffffffffdeadbeef=
";
> -        pub(super) const HASHED_PADDED_RIGHT_PREFIX: &str =3D "      ";
> -        pub(super) const HASHED_ZERO_PADDED_PREFIX: &str =3D "0x00000000=
000000";
> -        pub(super) const CLAMPED: &str =3D "0x0000000000000ffffffffdeadb=
eef";
> +        pub(super) const HASHED_PREFIX: &str =3D "00000000";
> +        pub(super) const RAW_POINTER: &str =3D "ffffffffdeadbeef";
> +        pub(super) const PADDED_RIGHT: &str =3D "        ffffffffdeadbee=
f";
> +        pub(super) const ZERO_PADDED: &str =3D "00000000ffffffffdeadbeef=
";
> +        pub(super) const HASHED_PADDED_RIGHT_PREFIX: &str =3D "        "=
;
> +        pub(super) const HASHED_ZERO_PADDED_PREFIX: &str =3D "0000000000=
000000";
> +        pub(super) const CLAMPED: &str =3D "000000000000000ffffffffdeadb=
eef";
>      }
> =20
>      #[cfg(not(CONFIG_64BIT))]
>      mod expected {
>          pub(super) const PTR_VALUE: usize =3D 0xdeadbeef;
>          pub(super) const PTR_VAL_NO_CRNG: &str =3D "(ptrval)";
> -        pub(super) const HASHED_PREFIX: &str =3D "0x";
> -        pub(super) const RAW_POINTER: &str =3D "0xdeadbeef";
> -        pub(super) const PADDED_RIGHT: &str =3D "              0xdeadbee=
f";
> -        pub(super) const ZERO_PADDED: &str =3D "0x00000000000000deadbeef=
";
> -        pub(super) const HASHED_PADDED_RIGHT_PREFIX: &str =3D "         =
     ";
> -        pub(super) const HASHED_ZERO_PADDED_PREFIX: &str =3D "0x00000000=
000000";
> -        pub(super) const CLAMPED: &str =3D "0x0000000000000000000000dead=
beef";
> +        pub(super) const HASHED_PREFIX: &str =3D "";
> +        pub(super) const RAW_POINTER: &str =3D "deadbeef";
> +        pub(super) const PADDED_RIGHT: &str =3D "                deadbee=
f";
> +        pub(super) const ZERO_PADDED: &str =3D "0000000000000000deadbeef=
";
> +        pub(super) const HASHED_PADDED_RIGHT_PREFIX: &str =3D "         =
       ";
> +        pub(super) const HASHED_ZERO_PADDED_PREFIX: &str =3D "0000000000=
000000";
> +        pub(super) const CLAMPED: &str =3D "00000000000000000000000deadb=
eef";
>      }
> =20
>      #[test]
> @@ -289,8 +291,8 @@ fn test_ptr_formatting() -> core::result::Result<(), =
crate::error::Error> {
> =20
>              let cstr =3D CString::try_from_fmt(fmt!("{:0100p}", ptr))?;
>              let output =3D cstr.to_str()?;
> -            assert!(output.starts_with("0x"));
> -            assert!(!output[2..].chars().all(|c| c =3D=3D '0'));
> +            assert_eq!(output.len(), expected::CLAMPED.len());
> +            assert!(!output.chars().all(|c| c =3D=3D '0'));
>          }
> =20
>          Ok(())


