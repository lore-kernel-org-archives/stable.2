Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13373429CC6;
	Sat, 12 Sep 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230606; cv=fail; b=gaswzp4duMX+UlDF+vYjsmMyOfCJARB8fHZwSVQqDcONuUs5ZK0pfdM262xsk1koPZ1JfDYWkjYuP1Roao0gZrPq0UjwlUfHJdZsiFRDU7wfwH9w6tK66CsMq0h1Oj2sPd4xrUrFKOk+2UC/jJSjNzGpDy1R5q6jgd9DW1Qk3yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230606; c=relaxed/simple;
	bh=oDDHURki/VMQrZdkuw6milAY0aB5dhN8cMtwqsOQHp4=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=IM+nszCSszWL/csbmNCyzze2bydMuPeIuTbRh5Wfwq090da1xabU1/Vq2TWWa2I+F9WeWLjXW3b6uXmnJtcEcxmsXZH8/t/as1gXWzaKgLNHFBPo5EoYHARDaYD1rb5oxTjghKFmLHhA5sCC/d149hgbOuxo1apg4wA5xZ2NXx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=VYojUTna; arc=fail smtp.client-ip=52.101.100.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="VYojUTna"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYf+x+zcti62YBI5ldCdV3KXLgzDoBxqMx0FM5jGNKqLJlPTiNZfmy4p6OTimde/+rA/TWJkZXQ8Dt7cw8AE01m+PvCnd58ZEjVw7IXnkh7wcNQpD7Xa8WPg1MOaFlBwj8Pw6ceOaKdHrZp8vQ+usY55ZRPPlgArzEVZiqP3IsrkBPPx021fAm2cg9unnLwEExK6in+Cc+OEajVxy0RNGoGMrflh5MGFeYjemOvltcwzfmqVxd1okd902Oy9u3mPrjOXXA+7KK+InjMTfB6m3590NVxdCAqc71ACcnVrA5TaCI6C+XJel53/BhdIBr76TuoK75K7MWxNv5B3cVs+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc3HNi2OLVxs28CGnwu51BdEmgHzutbKPHFIjNRJYFE=;
 b=UdIVPLDjt424Ww4tx87KydQpv9iWVfyrk4ZDOvAGTUPoGHX2ofyU5C1RIuVuJagZmClHH/caLDxjOepdMyxVcJABfl5SHf4jeYKm+DsAEOyefjvEnbLx6zYotJxFqnyKqmBlsvpZhut4AQbVs2NHkHm/dEkuLfvl11H/EQj7/lP2EQnOZQ7Ttiwz82wt/J/VhdSFWV11LcUi3q+eDDyPIbehuSzafdwkrW2xjbGyZ3Jprx8AkBDnPodeClUVCmizRTIkxrTkCP/x0EOxGfGJw3xaUa9d3sZVcAqgLQ25Hsnnf1QDn2iOMG5/bIjX1j9hPdKSKBIrKbRXyJ71QUyP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc3HNi2OLVxs28CGnwu51BdEmgHzutbKPHFIjNRJYFE=;
 b=VYojUTnaAmss0UkSHNlWKGTOvZN+xj8pMFnvlBotPB5Y5kjkFdTKi2vEhDr8JIP5WcyyfIwZlNpNnrgQFMFVqQf/UpjvewRwN6HHYUZc5SFeU5QjjUGagVil9qaqUhAMv16mTqSi5bXggrH3uzOjsklMnpM9SvXT3emhNn4Mirw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB3547.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Sat, 12 Sep
 2026 16:29:58 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 16:29:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 17:29:57 +0100
Message-Id: <DLDHB99HCXCB.S9V6QLDVSW3N@garyguo.net>
To: "John Hubbard" <jhubbard@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: allow `unknown_lints` in the generated bindings
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260911195209.442715-1-jhubbard@nvidia.com>
In-Reply-To: <20260911195209.442715-1-jhubbard@nvidia.com>
X-ClientProxiedBy: LO4P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB3547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdfe745-16cb-48c1-a0cd-08df10eb1617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10070799003|6133799003|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qMU3rWd9NCXBiHWxX4VzDlHmpC1DRUuRft28t1CiqIkgGgHifHp+XXN1aXOIFaUxxtxIvtnZoGbgPvr6gOwoYpcMCIJN4aF8jXHNUdB7ZnNaUnYZIviCkhF7pedftf0fwMGhsd9xgscTmVFVd0xA9gJcuuSowj2y60z7aS+23KqzUlT3IAXJB48BwdIj3p0x8rCT3i40lGMZBgioLv4LgaytLEecCx5MO5SOttovA+hyGdS6GOabRrvlc+CTs/kM56PvU/EIaibRRGkx19UTL5eVesLDEyiuwbf9FlB/RF8SMY+T4rTo9ws2Rv7ieDDYtn+NQte73V8bdeF/L5okykcNt4Gp2K9ZRfRVOjuSUxufegZ9wTd2d1XsF8MqEXqMeA3OtftwylSYGrONHF3aBhfGwiF85VJ9i0xZU3ldibKv7jbnmzn9yjrE3wr9nC+etXWvk/JKwA0CKlzdNtMnQB/NZlDFkc2OhluusR3x4gxtmug8ediVH85a5WLby6VmFICeaoG/S0DyORbdcQILYYqmmJQ+6BznYYIK31T86lk4b5vYXtto9gO4K44dbkU6Vef6HpNo+VmakPvETUXp9IqZdJ0RXP9KI3hORBauiW+G4WSSW7e78rIZDERteEv6t7It/FcYwef5pXvLgvTbOmu4gowRs7ZdmSXWrFCy9jg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10070799003)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amh3aTg3MTJNWkdDMmM4bTU2UnhjN3hMa24zdGNTYm9ybW1RWGRXaGtreGxx?=
 =?utf-8?B?TUMvRXN6b1FEUysycFB1emRDYzJWZGRmampLVEZSZVUzK0hNVFBMNWhlWERF?=
 =?utf-8?B?Z3lpR2g5bEFIUlh0UFJpTTEvc0Z1M3ZLZDZVSk90bU5PR2VLTWl2TjBmTmhC?=
 =?utf-8?B?M1VtY29YZVhnSWJpSUM5OGd2Rmh6S2M0UnVIc3l0WWpoSXJaOFMrN21CTkVt?=
 =?utf-8?B?VFllRUNmK1ZqODZ5QjJ2YmtCdysyamdnY3dBSkFQenBLUEN5eDFubm5zU1Fi?=
 =?utf-8?B?VDJUMjlzeVlSOXU2U1BDSmlLMFhMaTk5UnA4QUdPZ2dta0pLT3FldUJXZ0hI?=
 =?utf-8?B?NDIvRU9Panp4bmg5MHpHU2lTQWcvT3hUU2VoYzdBc2phY0RibkxUaGthL0xo?=
 =?utf-8?B?NU5mSm1ZMklLYkRsZGRGQi9aSlpMV1VLK3RuRU0yY3RsV3JRSWdhK1ZRTDRm?=
 =?utf-8?B?QmR3a29taUhEVWlUblVnMGNVYXk5SjhUbzNhSU5TWlNTTnl0Mld4aHcvTWRK?=
 =?utf-8?B?M04rSHhCMjg2Qnl0eEtXaEdmQWNWRFFQVDJKZmdzWjFhTUFwM3NRYzU1YU5X?=
 =?utf-8?B?ZWRPc09JaHNzeFQwQUVmZkNJL2NLZnVDUGp3TXowWUtkZno2UFJ1TmZnUXcz?=
 =?utf-8?B?VGxWSG16b1h4czVlczJ5WHByR3dUS05walBBSVh6RGRuSFpUT0laODlBYzNy?=
 =?utf-8?B?dEpqbTUxMXA3TDRCSUEybFpEZ1orbXN5VzIvbFFEajFtMm42VkpXNERHdnpV?=
 =?utf-8?B?R3REb1RYb1lEa3dKVnBieE05ajVMQzBWT29sUHd1SnBCdWZaM3RqR051czZX?=
 =?utf-8?B?TTBTTFZnb3Y4K0dZT2lQbnBwbGRjVWtpMXhpRDlmcWYrUFF5c1hmdVBQOEYw?=
 =?utf-8?B?bExBSjhrYmFJZitIMlRwSjVscXJVbTJTYUZhYlVDOVhoL0E2NEcyMDdLRnhj?=
 =?utf-8?B?WVJsaDA2S2dQZHNpejB2UmFtczM0QVFpalk0TkYvZDZwUWJKR0J3SFVDMXI0?=
 =?utf-8?B?UmJJMUFUZkVYY3BjZS9xRS9VNWlQVzNZdFRrdHJhb3J5OUhQQ0ZYUTU3YTdu?=
 =?utf-8?B?MkpmeE14eXE0cDlWNGtEM1FlUUtCME5iNWNKaDd2ekZ2WGUvRjloblNYdnl6?=
 =?utf-8?B?ZmFydXJRck1Ob2tENnQzN0RJNEI1STJQVExwUlU2TmUrdjVyTlYxdjNyTnBm?=
 =?utf-8?B?alIxUUZ0NUYvdVVjWE5XRzJVaHhPWVRMWUcrYTFiQSt4MXN3SmoySjJQMVRk?=
 =?utf-8?B?Zmcyei9VTXlYaUx5QnVDUGkyd1ZScTFuZTMxMjIyYWw3Yy9ybUhhaDAzb1VS?=
 =?utf-8?B?WmtqbmZxUUFLTU9pR200ZjhxU3pYaDdlZENUU29ZeVRpa1kwVDMzZXcyMWc1?=
 =?utf-8?B?alpqMktZdUVBWDBzYVBlU25YWDIvTWo0VkhSclQ5MTNRbDBtMG96L2ZodFBh?=
 =?utf-8?B?ZUhKd2tKdjFDSzQxUmUwTi9LNVJRYklxTk1aOU9sdFY4RXFHRWRMRU9FTHl1?=
 =?utf-8?B?SlBFSHQzamdweTVPdWZBbVpDSUlpOUppV0xicmtwUlVnVTBwVnppeXRmVXh2?=
 =?utf-8?B?NWRvR3hic0RsaG5sVGpsVXZRc1JvcUxpTEc0MjdNOHQ2QXVtM3U2SVlwSEp5?=
 =?utf-8?B?cGt4ZVQwUG5LVklNTjJPU3hVbU95NHFwdkhBYjZxRDFNYm9SUnpwUzJlWkRR?=
 =?utf-8?B?YjR4WkFRckxUcXQwRFl6NWl2L3ZjV0lRN2grc25yQnJDQ251MEovc0dIdjVR?=
 =?utf-8?B?ODhzeDBlY1U3VFdWRjUvanc5R0tUZzE5R3laUW81MnViNll0SFdOQXJ4bGZH?=
 =?utf-8?B?TG1vd3dtRnRzem1QTlhqendLaWJSeW5lQlVuZHREMUNvTklWaFF5Ukxzb20r?=
 =?utf-8?B?QStZTmlXMXpad05BYXZuOGlvb2JtTmorWEZHWU4xVVZjWjU3N0FXVEhKVzBC?=
 =?utf-8?B?Ny9UVUgrdnlVVXFhY200WEZEbCtKYkVmUHQrT0lGRnFPbUJoSzJmNEwzOWto?=
 =?utf-8?B?cUtUQXNKakM0UExhZFFRQ2hZa3dOTktXa1hxSlY1UE9mQWJsNDBpRkEwSHVs?=
 =?utf-8?B?MGxXM3ZGcEFTL1J2L01FZTJoZVhhWithUHZLc2t2RUsycmt4UEVDRk5pT2Q3?=
 =?utf-8?B?bEhJV2YwckNrOUpMOStYVUQ1eUt4T3pHTVhRMHFmQUFBYm82RE9LV1kvWW0y?=
 =?utf-8?B?bm5UWHp1eFIrWVNWYk1GUVZUYkV4VDlIRzRXZ2dyZHQxTW14cWdiTXM1UTZJ?=
 =?utf-8?B?QTRvY0hXWVd0R0lFUDFYWENxQzQ5NU44bTZMbCt6SjRTSGZvYmdSOE1yR2Y3?=
 =?utf-8?B?UVZOUXZ0WDhZR2dkaVJyalRxcFhoSWk5cm8zNU9uUWRBOG5raWZYUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdfe745-16cb-48c1-a0cd-08df10eb1617
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 16:29:58.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lk+huLhCbBjeWcUJ7XfRKfv2Rj+FmUUIGvP4AEChRvg1v8BpGwplNjfkbMmy5wp4Ro6Ygk2Y2Ay3JLsUxNVCqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3547

On Fri Sep 11, 2026 at 8:52 PM BST, John Hubbard wrote:
> A build with bindgen 0.73.2 and the minimum supported rustc, 1.85.0,
> emits about 12000 `unknown_lints` warnings, all of them in bindgen's
> generated output. CONFIG_WERROR or W=3De turns them into a failed build.
>
> Starting with 0.73.0, bindgen writes `#[allow(unnecessary_transmutes)]`
> onto every bitfield accessor and constructor it generates. It does so
> regardless of `--rust-target`, which rust/Makefile already sets to 1.85.
> That lint exists only since rustc 1.88.0.
>
> Commit 7129ea6e242b ("rust: clean Rust 1.88.0's `unnecessary_transmutes`
> lint") made the kernel's own attribute conditional, to keep
> `unknown_lints` enabled. That condition cannot be put on an attribute
> that bindgen writes.
>
> Allow `unknown_lints` in the bindings and uapi crates.

Already fixed: https://lore.kernel.org/rust-for-linux/CANiq72=3DfEYa1PygH-X=
JHONQKqf53dZFuGc-Z7wd4M7yeREq8Vw@mail.gmail.com/

Best,
Gary

>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Assisted-by: LLM
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/bindings/lib.rs | 2 ++
>  rust/uapi/lib.rs     | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 812f8e5a08d5..a3af57d7d137 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -26,6 +26,8 @@
>  #[allow(clippy::ptr_as_ptr)]
>  #[allow(clippy::ref_as_ptr)]
>  #[allow(clippy::undocumented_unsafe_blocks)]
> +// `bindgen` emits `#[allow(...)]` for lints newer than the minimum supp=
orted `rustc`.
> +#[allow(unknown_lints)]
>  #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_tr=
ansmutes))]
>  #[cfg_attr(
>      CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> index 797ead5b5626..361b490acc25 100644
> --- a/rust/uapi/lib.rs
> +++ b/rust/uapi/lib.rs
> @@ -23,6 +23,8 @@
>      unreachable_pub,
>      unsafe_op_in_unsafe_fn
>  )]
> +// `bindgen` emits `#[allow(...)]` for lints newer than the minimum supp=
orted `rustc`.
> +#![allow(unknown_lints)]
>  #![cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_t=
ransmutes))]
>  #![cfg_attr(
>      CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
>
> base-commit: 3026c6e4f223bdded6448fefe53ff85d9cbe51bd


