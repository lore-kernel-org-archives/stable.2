Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022101.outbound.protection.outlook.com [52.101.101.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE83B0ACB;
	Sun, 16 Aug 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786889109; cv=fail; b=c90IslgRShQa0ruwASWJ8vDqKK09D9BY+Ssva41SxGe4yKTkZdhyawmB8JKRC8zzIk4XUaMTKS5YCZN6PoJxQ9mSxc4vPCiQEabvBbkiPgCsCID8c6BxOLisVoT+z3W10YH0QVt/sFub8UuqBltWn4+J3bp4DMwQGom0b+UIazk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786889109; c=relaxed/simple;
	bh=aKuVt+6OftjqHHeNF+XxksYJM3UY3I+BUNU11jJcXw0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=YWEcJd9QYkMfOwpaI6SwDfw4+pUcvEeBAx+UlAfVfOIWwmh3GZHxM6u55S6DytOtVxWoy4stejQKb8OWkk5Qp8uDvMHq1yZQNownhQkFbT2NDAqq6ry1HpFEM9mhoqUFc1OfNkUDaCbRmhYtTxZiDEWk5rAyJMHv/0OpmN4WGak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KsGkbVuS; arc=fail smtp.client-ip=52.101.101.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KsGkbVuS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTKnXI6rLnfgCRR0FHRS2UGsMUIs84tddXGHsBE26A15ggm2N15smpe26UgKt7FVoUKLpND8UkltM9+C5pVswaynl4PZSQZbMIaeW6K2FT3IV8zjdkpXyCAS8KdrGV1MYjPps80MADBC/Le6b8qwN3+OnmygCYhyLpnRvjBoJ6OMf7RKTY0RDyPXLJk3fftPqLgoKHpsdyaG0rVkfcOn/gmRdgPb1BHoAT2PVSGPd7iQNCIiSBxiSjY2ro2hSiUxkwN3U72jtjKxv55n0347FTsoKbsCxADBIYVkgxkB5qi9v9mPgtW483gIEywRTh76I6ba2u6wWV7fIHnXZyMGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmBS/Xsk8Yk+KhVfcSjYULsidATJy+fvx3untB7uZvM=;
 b=X7uxVp2ZDsl+BMFayUaC47SuSSKTP5PyDaaEdU60j7QGkG7IqxN/27gfJn3cxCgErmQhrQkDVrK65KRxhJyrHAADA+u0Pl+gmpnLZF5onU0q7pKW1dZpAOqFqArN1QT4uDHNkuqphFvUEzpY6+w0wmczCZtFBgkg9Bby5GhnaoIXIuIgNIdEVLKctEaF0K8jphNVKJu9JDMH4xR0lxMM36+VNBmxZuohZ6oYzEc71Yvp5S9AK7DbhkB+OxPwgWS6TsVdSgb06xJK69SuoMSTDRLkwfpgy8JzBPyRJpeT/3wBvO1A2fQdiX/fvmX7m7l43kKcgMMybiFUM8+ob2s1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmBS/Xsk8Yk+KhVfcSjYULsidATJy+fvx3untB7uZvM=;
 b=KsGkbVuST8NpsrbNvywJa4qzsj7QTF3Ema+vx7cV+Ao7A1cVOvSavs7RZvgM/KnG3/bIimFeXMjuLBXAOb1u6NC6vRiN9avBgEAy/Vy8cz0b5taLWVL+s1p5u45cOh8LPnuKq96c0L6bVeYKTJERlHfeUP+RomJKvZoJhodDs+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO8P265MB7753.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 14:05:06 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 14:05:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Aug 2026 15:05:05 +0100
Message-Id: <DKQFBMI8BAWN.JB20KE3YNAFA@garyguo.net>
Cc: <linux-kbuild@vger.kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] kbuild: rust: keep Rust objects out of Clang LTO
 with inline helpers
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Matthew Maurer"
 <mmaurer@google.com>, "Alice Ryhl" <aliceryhl@google.com>, "Josh Poimboeuf"
 <jpoimboe@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>
X-Mailer: aerc 0.22.0
References: <20260816133233.197500-1-ojeda@kernel.org>
 <20260816133233.197500-2-ojeda@kernel.org>
In-Reply-To: <20260816133233.197500-2-ojeda@kernel.org>
X-ClientProxiedBy: LO4P265CA0179.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::7) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO8P265MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: f80e2136-eb7d-4d02-7739-08defb9f5fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|18002099003|22082099003|56012099006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	tewCkhMfsGSmKLVoipsa9GkayeocymKnaay6DKAFEWaH5t0NwVtkcCOywwKDD6FUByERF5yLByT8Ok98bLfshEpgXfarqVuX/n+RqxQGOh+3nod9uzBQOa6th0kGXM/giwI+Nb6Am6Wme/ssUA4w6GTM9UPmPwGNII2k0r6SGLgK/R9fCU64MjeFBJaCM6dWM51DJUgDjUXsrCk4ZDXanL4BirfC/5Bi6TQtQ9P4MAaGXoXHLufDwv5Nv+7JUlVxKE0ARQGevBeMBCSTrUXgw1UNwNIJUxLomLoucd5iFpyD225r5EIIXaoFFlKky40mPxpqPaty1KQoeeW5etIxAhByaK9SwfQDCV9ZEfe16+8d/6jzNCmcjhTJkVykdNkSfTetSGQKL85snqO2IauzcbtvdspaOeMqJX37ot9rYzRBzq/UZE6tSV8fj3XINJuZk/QECofMMU/QkkGjJr50yMBlJXZ6ktJjygo5HI8K0UvXgxdFJiAzxLkTVeYgUe8ko0qatk//QFMy0pf9i2qDQufnTGGMLZQRrTsbcGFJd9Vo7NNVEzE28xfJOjcuVAyTr8/pBHfURI2LozW3SjF7Wr4Qjoid+9Yc2vv0QPfB+MmT9jByz1Jfk7jAoRbZQOCzL8HpecNojzm8SJTuAFfuSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mlg0aXFWS0RSaFJaWU8ycXJwZnQrVkorSzRCRytBU3YyZVJpNVhwVGN5ZGVk?=
 =?utf-8?B?MnNpTUJublVOUk5IeEFPeldBdnluTytaY3RiRnlGM1N5dVhCM1h5RmFQZnp5?=
 =?utf-8?B?R05HTzJQVFNmSWNJQlY2cGs0V1R4cFlyWnVmeE4xZUpJdVdiMzJFVi84OVRZ?=
 =?utf-8?B?dkFRL1d3VHdyZHFkOVA5NGo4YWlsVjRSQlR1V0NLc01RQ0p0ZTU3UWs3NjRw?=
 =?utf-8?B?VmF1UHZKNDB3OW9mYTNPZmFUZWd0NkRsR1FTTkxHWmp5aWZuSGN2QXlBZVlT?=
 =?utf-8?B?bDNHL2tMVy9OUEhSR2hrZDBtV2JGUGNUSkQ3ZmEyQVN6Q0FKVVVuUGt6L0R3?=
 =?utf-8?B?dTFXUitFL3hzYVFlMFZsMHlwMHdJNDFHUVl5L0k5aUVvUVBQbHEwTUlRcE5n?=
 =?utf-8?B?VG83VFg0M2IwdmRwNWd5a2Z6cVhCb1hBVWZqaENHOGpEUGY0VFd4cHpzN1l0?=
 =?utf-8?B?NHI0b3UrVUs4eEg2VFZyV0gwZllxOVo5QUdQaG1mUEhRMVhMbGc0eVJvZUNF?=
 =?utf-8?B?Ky94M1d0NnVZU3NZUW5JdUF6NHk1SDhYYzMxejBvZlRGTjdvZEl1ZHJvaktC?=
 =?utf-8?B?T0kzdlpQNWpJTzIrRUlJOW43VzFoOEpiMjgvSlNIY1ZyR3g0NUFLK2p6SVcv?=
 =?utf-8?B?ZTk2ZEIrVlFqMEEvOEdseGFwNlBPcGdzS2Z1U3kzMFpaandseWhGT0JFQldv?=
 =?utf-8?B?cjdEQ1hKQTJlZVpzS3ZvcU0xVVRTaS9Pd3lWOHM2VXg4d2hTWjNRL3dpa3BR?=
 =?utf-8?B?c3crRFdTQkY5WmptKzkxazZQVWpKUklkaHRzdVQzM0FyY0pWdmduWTFZMnEz?=
 =?utf-8?B?VDYyWk1saDNtYk04T2xqczJabXF1UTl6bW9wV2dmdVVBNDlLektmTllnVXFD?=
 =?utf-8?B?aWFDRVV2dU1IaktMUjJSQXZTYkdWUGVIS1VyZTlpTmVDaGhKU0Q3bk1EaHRU?=
 =?utf-8?B?aDgyWGFSU3R6dDlrTGQ1Wng4SEdPUk9hNWFzWmo5MDcrSklIVXNTOWlWcm1y?=
 =?utf-8?B?ZFBhZ0hiSjRTZTRGQUI1WURMbkJJcHZmQTR6QlZmaDQ2ckpwNUs0K2J2Y1o1?=
 =?utf-8?B?ZXg0OVQwYUtRZU9uZC9vUTd3c3pUbDU4T3NTYzdyQWNNTlVhZEVyKzVCTDRy?=
 =?utf-8?B?am1aeGtZSTZLZTRzN3d3Qm1lZG8wY0xTRDQrZ2pFVGxvLzByelJhVTNmczN5?=
 =?utf-8?B?WXltekVqSUJpbmlVMlhzcU14cVQxMUU3cFZhZTJKeHFZZldGRVZsdC9oRExS?=
 =?utf-8?B?UUY1ak4wVjNYR2F0eHAxdWlYcFZCMHZONU4rajJoZ01oN0sxeXRocWlpd2dm?=
 =?utf-8?B?OFpUSVVSM29sL3JKY3hPbUhSQmpWazBkUTRpOHZkZjVHTkp1cnZYQm15MVRx?=
 =?utf-8?B?bXpCZWRDa1haYytxMFNxYnV2ZTJIeFBySU1Wa3lhZjMwMTF1SzZzOFhuR0ZE?=
 =?utf-8?B?bFJ5M0VZaFQvWVd2dExVSFpkOUc5aHY2emZ3alNuRVhNUk9ZQzNPUlMyQktt?=
 =?utf-8?B?ZkFaRlp0am1vWmlqOWorZFhjUy8vU3FGdXczazhJVC9kY1dBMU9OaHBCMGRP?=
 =?utf-8?B?RWlZZlA0YW85UDh6MXNmNzlzd2ZRUGhFdHNoQzZaMEpKWE44WUZsaUNaNGpv?=
 =?utf-8?B?SmZpZTZMUHpjd1oweC9lZi9XZnUyektoRjB1UlJKZTRBdFhqd1NwKzlsOTlO?=
 =?utf-8?B?ZW9iamp2aGx5SnRkYk5NL3FsTTQwSW1sZTZ0VW1XNU5TTVBhT0h1VGg2Z0RI?=
 =?utf-8?B?YWdWMXBaNVZQNWFZV3JYOE00UXkzd0RFaUtXY0d0ejQ0Y2hkL2hubjZjQzg4?=
 =?utf-8?B?UGNwcDNkYWNCNkg5ZzkyWHZBNE5EN2JkZ0kwQTg1dk11eisvK0xybUFWQ1dl?=
 =?utf-8?B?NWhvS1Q5Mnk2bDBGUDFRVGduUEorVTdwRmVrOHU2NzRvUTJoQkJLeFk1RU5t?=
 =?utf-8?B?VWhRNGlVLzJoZXdweTcvQ3VJVG16WGxoTUlscCtJMWsxUDNJTXJwSXhFZkxF?=
 =?utf-8?B?VG1VWlNYWHpERXRyNEF4NkRDaE9lcGpxL0dZUnZKcXpibG5HK1BKMVFUT0wz?=
 =?utf-8?B?MXB2NEV1NE9LNFYxaHZJREROM1ZHc0UrYXJSSHVUVDlnZnRvTE9IcSt6bERq?=
 =?utf-8?B?R08vTEdld0dNckpLVEdXdFVveVFJb1NFeTNkS0dPN0ZlN0lCUExDTzNLSkE5?=
 =?utf-8?B?QTVVczhhdW1hZmk2R2UvSGh5WjVtenpEZm50MDBiSm5rclI1dWQ0b0hTUzBa?=
 =?utf-8?B?eEZjcGl0aHpLd2JkNnR4TFNBV0plK081dk4zK05jVmp2bFI3Z2FNSmpJNmNI?=
 =?utf-8?B?OXdDVVZDTkJNSWJiVVJVVm9HZGQweWN1TEhyQTlKOW44dnBuWDlwQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f80e2136-eb7d-4d02-7739-08defb9f5fdb
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 14:05:06.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovzW75cmTokVvs3f/1MNdyf2qPMJCJdMvKC7BoI9vHdz4wvAcvDgXFWO74FaablShqfyKRDjW4P7M2K7tC/ppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7753

On Sun Aug 16, 2026 at 2:32 PM BST, Miguel Ojeda wrote:
> Under `CONFIG_LTO_CLANG` + `CONFIG_RUST_INLINE_HELPERS`, one may hit
> `objtool` errors such as:
>=20
>     vmlinux.o: error: objtool: _R..._3Gsp4boot+0xd6a:
>     can't find jump dest instruction at .text._R..._3Gsp4boot+0x1dfd
>=20
> The reason is that in such builds, the Clang invocation that compiles
> the combined Rust plus helpers bitcode emits LLVM bitcode (again) --
> the final code generation happens in the linker's LTO step, which the
> `-mllvm` trap options passed to Clang do not reach.
>=20
> This, in turn, means that unreachable traps are missing, and the
> impossible paths do not merely fallthrough to the next symbol, but past
> the end of their own section, since LTO builds place each function in
> its own section.
>=20
> Thus filter `CC_FLAGS_LTO` out of the Clang invocation, so that it always
> emits machine code directly, with the traps in place.
>=20
> Assisted-by: LLM
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Matthew Maurer <mmaurer@google.com>
> Cc: stable@vger.kernel.org
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Fixes: 3a2486cc1da5 ("kbuild: rust: provide an option to inline C helpers=
 into Rust")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/Makefile          | 2 +-
>  scripts/Makefile.build | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

