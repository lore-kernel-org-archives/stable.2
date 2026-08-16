Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022109.outbound.protection.outlook.com [52.101.96.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415A3B0AC3;
	Sun, 16 Aug 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786889099; cv=fail; b=YwcPruHNXqGHNwxV3o/cJeM+NpEFhyCRG4Qrn+WyCO3ePQSzpGtZTbWdpHFijIv9PpB00C1buzCn489jAYkzc2amwVGgbMQnp0RboawTUr7n/keOtqxd2W2Xl/AbGlLPhRBEJhZSER/QSvVb9KenEy2z6m++qfUN51F0XqfcioM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786889099; c=relaxed/simple;
	bh=ASpChqGZKEkyq4DgfhUp2qIzr7yX8+YHOIgyXlnCfBc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=eKMUvup+qemxGa91cOzeY4RB6dUq1otcvbisKuffFd8MbEDE/PLK2XWA/fH7/VpsxLJueAWoIMvCxN5g+22HQC6DuI8Fv0utai6kxBsckUp5yR+qTvktZ3i12kqNXQqZF7bXNe3jx/Pvl7+VCO0cx9jJ7hGTK5W+ai9xdomv2r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ooDncBv5; arc=fail smtp.client-ip=52.101.96.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ooDncBv5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXyvsOQ0aNd1JT+/C580BoarpqC1hEQM03L5OcHVHFK8FoU9kPBhWDvKmZ5czpkfpph9KKE5GxMrX1a4pPlSfSPfRryP4UDOPQT3k4u8daeFEt7ve9RPsUG63cDRhe8t33EZolz0sIEQ+pDqoul4wOt4PWRnEIdOJlOZl8gEJGGAkjYhw+RSQpS/qNyDG9hcWgehs/p86w03GkjLrdiF+KS0SOBiaClV4/AE4GZ/7bHA6aNVYPM5+8iY3AmAzDnfxo5XnbOpBayyJV5zE4owP5Zyr/Vnbwo72aKgdYNb9BUYuRVjQlG3x6cAf6Rp7W8EX+tUr4Yiu1q6xYMinSKEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNllM5HnKDbKc+80mDehXLMChunEHXfyDFrY016we4Q=;
 b=BSvYX5nRn/lCn8Ls/OolMIHmXb3+krrH6OUmpCEyQ6tpUFOm0M2/3OJBk9EUd3cRxXePjWoVy9g4UmWIX6Ie/jXVTaGXZMma3d9XzySJii0L8+38fSDMUDHwN4ellCrqqxpJwb1mapjH2d56APx8bpW/wylfzc2+QLpd7g75qdyOcYidWBgAGFRbb7+rux/dj25tQmWgY7N/rFFLxcX5Kk+WkWsjM0Jl3+TN1Ru3z3Qe+eWyPVkV1lK9/iy6IUlHYCyU5h2ZJ0IvKrqo4NX3wNTUGBnOz8sQiVrIoPjuzOPt7EhIg14oLnugEZsmt7pFG1BdT2PTLR8mGF0g1m09YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNllM5HnKDbKc+80mDehXLMChunEHXfyDFrY016we4Q=;
 b=ooDncBv51fwAMNQIPojj9/yQlemnCRfXDSiPSpctNEMj7QXRsso6BuW3D3A58orBztvDkXR9Z0H0EhO3Ic1lw7SsrfpyaoO7E0aMD/RxF2RqqWImgqlXLqpz2lUjZlHULarY+X7lPt9F4994ypNkN90KoaLgjK/eVdtEoMAyHkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO8P265MB7753.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 14:04:53 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 14:04:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Aug 2026 15:04:52 +0100
Message-Id: <DKQFBGRSYTJI.XNE79AAQ7ES5@garyguo.net>
Cc: <linux-kbuild@vger.kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] kbuild: rust: preserve unreachable traps with
 inline helpers
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Matthew Maurer"
 <mmaurer@google.com>, "Alice Ryhl" <aliceryhl@google.com>, "Josh Poimboeuf"
 <jpoimboe@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>
X-Mailer: aerc 0.22.0
References: <20260816133233.197500-1-ojeda@kernel.org>
In-Reply-To: <20260816133233.197500-1-ojeda@kernel.org>
X-ClientProxiedBy: LO4P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO8P265MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 656b7469-e06a-4140-4dc1-08defb9f5869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FO+RfKZNQE0LEj9HPUS6m0Nxq3FmLUenF1sTcIn8HChni1SxbFOaadELNBlduk3VBkI3CvbOeOmr8SECaxkbreHUb1Wb8ezaus3DY1P8Oc8NgHEa8jXLPEUJX+BOIddwvsHVYIPUJckdZFAuuXEJ5ngOxgg9Um8rHzRRCNIeK4RgCoHlUeuD+1S2N88s6Jp4zx8QTnQecYvd31RNDNlehHf09T2Jzx6tMxPAI/rzHkXXuir6gTJJlPFSHEM3vrHvAhLX698vOO+WdRcfxwbpe/YnXAiNHHW9R7fWGCBwy5i0H/m5ri6smUvWn6KtLMArmKTK17nPV4Rlp/h6Eb8jZgbumJoAW1AWgmU0kMpwlQuf/IsOh0XunRCiBYRHLjaiKbdIba1ZG1hl/g9FMsBrP2Yu4inZegtuvgotImKdC6vCRPKwahc7HwrDmp1BrOHWwTbyDOejIVemer3Q1RG5yzazzUgqoCpghUVwU37e2yyvqWBQt3qi22JEShgzFHokCHRhIKj82QcAd3ABwx4l8Pq9M5EvPWDm8puqtp6NN1L/RR+MtpizSbk4DbpLJuknBND/lioL8LeIl0OaLRn86bdWraC1bBiHtiFOXEXTGCrnqBSJyk26BhgGALKD0Aa4Wgd/JXmp66ET+Lc0K0UawRdeUxaM+ghkYB7p/Odw2mo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk8vSVlrYUJQZ2I1ZndQbnJMOVZqQVhPRU1SbHhOcU5vKzlsQlBWREZINzlE?=
 =?utf-8?B?QTg0SnBISEVNMFZiajFVd2k5WXNNOXlEeXZWa0RCcWp3UlpsY0FpQXdwdEtD?=
 =?utf-8?B?b0MwQWFLWko4UGFOeVlVaEVnbTFsVUZ3KzA2UEVRdFFuK3pCQW9EODRmdXBB?=
 =?utf-8?B?bEx1cDZUZ2VRNGRGUkkvK25sdEtRLzVIbUNGTHpHbThTUkZNLzd1V3FPQlVC?=
 =?utf-8?B?M0NvNU9LSjhvMS8zSGdXYkZNaTZjUFNVUFM4UWtSNDBUZGdsQ0V2ZlFGOWQz?=
 =?utf-8?B?Q3pWQnplMUp5cldQNXZ5L3o5bWljSVhaVEZzNnc3K2wzTVo0bWs1c1dPd0pz?=
 =?utf-8?B?QlZidi9wVTZnZzlKRUt2QStWNmhKUlNvSG9WL2o3UEdsQ0VCQnZ6VXRBUDVI?=
 =?utf-8?B?cWlxQXVJdFJFZUNiTUtsZ0xFWFJCWWZKY1BGLzVZdGJkbXd4NDBJcDNDdjkr?=
 =?utf-8?B?TnIySm82a0h1QlIwbnQwUXpqZHF2ZGNwemsxT3U3Nit2bWFWaVNiNi9MSEx1?=
 =?utf-8?B?aGY0NGkyakxFbnNqZE1Sa1lMMW9sTXZ2SEZvbmNvcVhwbjVsS0xOVDJhK1c3?=
 =?utf-8?B?SHNlSG9FV3NjaVRmRTJGSlp2VU82cklJaTl4WU1Hek5jU3JGS3ljWTFUTjBC?=
 =?utf-8?B?TXZ5eEh6ZW5tTmVqMjF1UE1XY3IrUzdyWWdEVnorVW9rVVplc2Fla3lQNnVH?=
 =?utf-8?B?UjZmdWpkVFdSc09iUllsUGhZU3BWaWZUUE5PSnRvcDNIa25CaEIzN21VQWlK?=
 =?utf-8?B?NUxseFMyOHdKQUlBK0lnOFNwRzVrT0FpWFBYTG1QTXVDbFV4Vlp0SkJpLzF2?=
 =?utf-8?B?RWN5bWlHLzBsSXZ3YjlqMXVKaWZjWEVYMEZmTXJkbnpFMFM3OGZOajJtWUdi?=
 =?utf-8?B?Vm5iY0Fzekh1dHRrcHJBMG1ZMFBkSXJIcExFRTRTTW96U2Z6Q0VsSkwzNFFX?=
 =?utf-8?B?SWVZSTVQUUgwYVFadzdUWjJXaG1LU1NWRlRab2YzdVZ6UWROeUlTVE10NzJv?=
 =?utf-8?B?WGpyS3d4TTRIdmEwR2VoOS9FMlV0YVhUbXpqM2tHNHZzbksxUmJ1WE1IZmlk?=
 =?utf-8?B?K0NsWGxWWmtzWEF4cGhpbDZrc09HOVV4eUN3TGsvTDBra1l0TVhRdXp0bGJ5?=
 =?utf-8?B?SG4rN3VYcDIycFpGTFlPLzdUcUJDN2s5UUFyaWp3ZzJQRzM1TEN0cEZWUlo5?=
 =?utf-8?B?UmY5NnN2Q2RYZVJ4TnA0N0hMNFJ4K0ZJUWJaRFptZ082YkVkTnc3SEZ0aEVL?=
 =?utf-8?B?UE9TN2I5S3ZBVFRSWjk2R2FXUzNZTUJlaWtGTU8wSlc1aUdwL3NsUGlDVjNt?=
 =?utf-8?B?dWRITk9oYXNkTkJkTzExNGpFUmtCbUJGOGVOMzlBNkhtMDNVTm04c0NDMk8z?=
 =?utf-8?B?dlhlSXh3MDNJZ0RSTk02Uk5ZeWZ1VG02UXIzeWt6Q256Wk95VnpMOXVHaXc1?=
 =?utf-8?B?VTJselJMYnB5SXNabW0wTGo3cVVlNmJNQkZBUXV0bTN0RTZPZDdYRll2aDNY?=
 =?utf-8?B?ZmN3Y2QybHB3Q0dVOTZqNXZkQjdER2ptY3dlSUNOdlJtUUtCNE1udFhMNUk2?=
 =?utf-8?B?UkloTk9IRkxvTFYwRnVwajltc2hLZ2hjY0hzWXloczV5OWp3QW9VeVVNM0dX?=
 =?utf-8?B?ZUxnYm1wa3RPOW83WWFhc1VwcVVXTlAvYUpld2RWOVZ0RFpucGZSTjUvMy94?=
 =?utf-8?B?QnNZR0JEWnVidktYaXFQVGp1YUR0MUVXeDhLS0NoanIvU3kyRitXQVJHZ1k3?=
 =?utf-8?B?dWpVSjB6eU5zTGRDVDNDS1NVRVMxR2ZDclNRQi9KcjVaQXBnNmFLZUhLRVdt?=
 =?utf-8?B?SWVoYXJwYW5HZlluYWRpSnpET1g5UDVVSmU4a0FaNklRTGVJL0hIK2p6NDVV?=
 =?utf-8?B?c09qOVV0T0NMRFN6c3dxYW0rUjg1ZXlxdmR0T1JhRXp2Q1pXb2FiV21PWERj?=
 =?utf-8?B?OUR3N0tNZy9PTC9jaTNTTjg5NVNPcmliakYwU1AveEwxb2VVUTZvSzJYTnBt?=
 =?utf-8?B?L1dNd0FpenpjVk83Yit5TWdySXpjMGtpSE4xM2k5WEV4NHFUekVUQVVpSEdk?=
 =?utf-8?B?N2tkVHZSQjlkVXpCaVloZ1YvSWtZQUdCblpFY3I1U0NEaUxDZHFUVTZPdGpM?=
 =?utf-8?B?ZkVMblZydktjTm9MTGZWNitEMkJoMFdjaVp0RzBJK05mcXorM3FkQzBETERq?=
 =?utf-8?B?dEpQYTgraCtTdGZtOThsUnprSDVLVHRLOHF6NWNVTjZSeWlya0gzZVJhcW11?=
 =?utf-8?B?cHpHNUF4cUptYkFYbW1TeEg2L0hvY1F1NVRCUU5LdnNHZkJaS2ZwWWFXZEVp?=
 =?utf-8?B?M2RkdDRrdGdjWXRxdHdwR2JUckJBRndMVmVuSWJyUDlzaldCR2p6QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 656b7469-e06a-4140-4dc1-08defb9f5869
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 14:04:53.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPy6qAh6cIYNyyDqqdZX87Bap/OP/FBSG8/fYBD+F6eHbJvsjWC2XlvNn0JwXVPUTzPH42g2bdMAkAdrgiNd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7753

On Sun Aug 16, 2026 at 2:32 PM BST, Miguel Ojeda wrote:
> When `CONFIG_RUST_INLINE_HELPERS` is enabled, it is possible to hit
> `objtool` warnings like:
>=20
>     vmlinux.o: warning: objtool: _R..._4cmdq12CommandToGsp4init()
>     falls through to next function _R..._4core5array4iter8IntoIterRShKj3_=
EEEBa_()
>=20
> `rustc` normally emits traps for unreachable paths. However, under
> `CONFIG_RUST_INLINE_HELPERS=3Dy`, `rustc` emits LLVM bitcode and Clang
> performs final code generation after the helper bitcode is linked,
> but Clang does not trap unreachable IR by default.
>=20
> In turn, this means `objtool` follows compiler-generated impossible Rust
> `enum` paths through alignment padding into the next function, resulting
> in fallthrough warnings.
>=20
> Thus pass the LLVM `trap-unreachable` option to the final Clang invocatio=
n
> and suppress traps immediately after `noreturn` calls, which `objtool`
> already recognizes as dead ends. The combination of both flags makes it
> match `rustc`'s behavior.
>=20
> Rust 1.85.0 (the minimum supported one) supports LLVM >=3D 18, and both
> flags are available in LLVM 18.
>=20
> Assisted-by: LLM
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Matthew Maurer <mmaurer@google.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: stable@vger.kernel.org
> Fixes: 3a2486cc1da5 ("kbuild: rust: provide an option to inline C helpers=
 into Rust")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  Makefile               | 10 ++++++++++
>  rust/Makefile          |  3 ++-
>  scripts/Makefile.build |  3 ++-
>  3 files changed, 14 insertions(+), 2 deletions(-)

