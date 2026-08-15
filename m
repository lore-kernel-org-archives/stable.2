Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020087.outbound.protection.outlook.com [52.101.196.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AF189B84;
	Sat, 15 Aug 2026 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786819827; cv=fail; b=IWj2lrXknSkbojDwymn8suq5w/vgIknErDK2rnrKhQRZjCIPMAch8MXZfMYbAbZ44HycE6Z4WwsMdZMDg/NDQA56yzzLXl9fy7ToPsaEtfMgZzSa2XbWQdl/hWCJyaLUrgoGjRlkLP4c/etY8s2Xy+JEKilqPaS3ginfF7lpNlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786819827; c=relaxed/simple;
	bh=hInF7LorgcP9qZYvTRbCR3FFaiOffBr7pSyOf7pjpAg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Z6MCnahBZm0y6M5R7vnWZt9d5TQYCQ9J5+EmSQuvqZ9rYASKTrwOWy0z6Nu9WWkJRHuiz2dSJLZBArIPeaLYWW2CG4NehsZsDsdWujTN7+oSuawf2RgtY35SvkuY2dJ2/XTPX39Si7PBdgmzGPDQHVZDdEomm8DpGfujjPJVJBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OHcxQFFK; arc=fail smtp.client-ip=52.101.196.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OHcxQFFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMvNkSPn9/lEzq63Q0mEUatbntoAnne6Py2qTEGALtq3lufE1mmsBMGbnxx5Qo1SZ4n3bmKv4FCOsjUe9WpesnBNlKCer2JFf94IP154qKkWDHneWcgYn0gJmlLt/uC1dxtwl4APYPfozOt+TeeW53w5rLIGTtqh/nzPFSwhtCU4ejE5qoISJpEovTiowpMTCTiIYvDGFdSAAK+C4i/p8e8O5hJslbquFuvJJLVtLI1l6aHOjwgr6jUzXJL851HK8sdJjUVUobhzJai8WSefkpAkUIquKE6b1oairtd03w5z+0LXR+Z/EChA54fZaUsgR1u33AhIRUUDdeQLH/6WdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hInF7LorgcP9qZYvTRbCR3FFaiOffBr7pSyOf7pjpAg=;
 b=vws74jUyfCB3tQcYFxxgLET7FpT+ae1R644g49DVnLSI4qmT8tH4I1uOX37jLifb36fAmL2F2UIVuNjL0xKmihn2yJTgXmQW5F/dg159L1d45tayLX/w87wj81xfQdq1dD0eRcqpdP2yrKzYUm8HzALTOS7d5oEE7KW31gJr7YTfOydJvhy9uukV/4aLSKr+KES1Rih9qz+iECGq5hytQsNgDrOfhfB84Rw9LyEyqDp+QY1yuD8fVXLsUz2Rv555kmvupjQj0vvKIEVVeTz72kzmQmk7KRoE5BsdLCj5+PZeDaGS1dLJfuOauUc5QQlsOEs7nyRunGNFKAn9H+prng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hInF7LorgcP9qZYvTRbCR3FFaiOffBr7pSyOf7pjpAg=;
 b=OHcxQFFKFOVNeX4TJT8Il/wqApdByX2ZDk9ZE++biH8/cSC7XM9wusOaoWopmAb5e8XZq/yCeq/OmXT9NytS9yWlGzrx3goBvSBWuFTuzJPtajwiH1bCy4cqZ0sNBJZ9uQsUPu2IR5MqwaTNs/c8L6msv6QOAbz/M8PYKs40yL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOYP265MB2397.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Sat, 15 Aug
 2026 18:50:21 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.016; Sat, 15 Aug 2026
 18:50:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Aug 2026 19:50:20 +0100
Message-Id: <DKPQRHQ3WKQF.39SZCXI1UNJDG@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: num: reject bool conversion to signed one-bit
 Bounded
From: "Gary Guo" <gary@garyguo.net>
To: <git@younes.io>, "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20260815-fix-rust-bounded-from-bool-submit-v1-1-882227bf40ba@younes.io>
In-Reply-To: <20260815-fix-rust-bounded-from-bool-submit-v1-1-882227bf40ba@younes.io>
X-ClientProxiedBy: LO4P123CA0194.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOYP265MB2397:EE_
X-MS-Office365-Filtering-Correlation-Id: 511b6467-d5e0-43d3-c935-08defafe0f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|23010399003|366016|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eKhw/6p2Tc4HuGQpwu5heBw1z5CDf9S1o8PV3jqxQg+kAf0CV7ev2MU3BNKSb7r2/krQ5h/twxoLFr3HGeG2gcFMB/qZ9tapo066XJ+dq8GU36O5GkRYNYU+/BnhX8USlxwOfkFzT4o8F/LNpS1R4EFDOuIcdVwhUJX7Uos13PyWQOjVw7dI1ojAqjtCQvfdwUHjMzM8uhcspXsA5w2AEIihyunVrrqH25A4mz9ITdFmadryMpoctKeT73nU5XSGmA8iDQ7GX5rYL9umKaNp5I9eF/pFerW/P7R46qDEi4SZb2IwQlbxvMJinasf12pDj9dpxDZBWE68IO12mn8f0oYDemlqGom6QblV5lI48Tm+Xx1QZ2JbMVSrg/XBuC0R5CheWIy2Cgfma0xZDRWfK2xmkypcvq56bwjM3s1xxKqqyFjnC6MwmwGoWAHcmhK+AKBdSUJm8kmLj/sjfvqhBtAZnMHNHhZXfwyPVd7BFxt+QjSajU62rXRS0za80DuAyk/7gFGlIu/Cc16Ua7xf1uRzA5IuHWmKFs604PV8RMBVfJUd1Y3x9CA1k4pGHDexoPTmZExYGFS8vpJMGG61o0w8uuA0Rclua0gTmun0Fev+sQNeAmewsJoswwlcoNrTkA+5qWQu5bSd7xF+i00mbYgiLO9fb1LnH9hN7D0E4zxBujywHVjNWF64Swmf8a5j55BCXqFyZAXLJzkza984Sw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(23010399003)(366016)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlBWUWVrTWQwOGZDRzNLOEtESUtJTlZSYklsMkR6ZzVXa3FWQnlheC85T2Q1?=
 =?utf-8?B?b2dhQ2hnQ2R4Mmc4V2tENUtJbjZmYjZRSzJLbnJpbjM1dVhNNlQrSW9oWUJh?=
 =?utf-8?B?SldHTjBPRXJhWXpBejJ1V2d4ZDQrMy90bk5oemhIVG9zQk8vbzRsSXZaSm1a?=
 =?utf-8?B?MWNnbkxmdVFmVm4xTFhNb0JBbFpwVnQ5WTVLYkpDVUpDYkQwQjFyd2s0ODB5?=
 =?utf-8?B?Y2hRbXl2RFFKdWt4dm5lSE41SlYyV3JaUlFrMFlVUlJUWjRMc1NHdmU5Q1I1?=
 =?utf-8?B?T2FFTmloT3ZjM2RmTVhadzZCYUpzYXo1TlJCeWl4dzRTd1BCSkYzNXk5VGZU?=
 =?utf-8?B?ekprTVRHY1c1dFdrRE1UMTVRM0JtVnJtRVNmS21XekFEZ2tiOStIZXpFUmtZ?=
 =?utf-8?B?VzNkQVpTaUU0aFZ3RmZZM2YvTWFNSEFoejl3VktIcEZ6OVlqY2NDVE8ycEFy?=
 =?utf-8?B?dlVYdXNnT1lkVVJVWHlsRkZGTkxmNVpaUytLNHU1V01SN1NEZUlOUC9vYUN6?=
 =?utf-8?B?WVY0Rmc5ZW10bFVTc01HMGVVQ3RvTFVSbGE1WnRLZXExa1JkU3RNNG91SGVW?=
 =?utf-8?B?TTVSdDdOVHRINWxLSEhjU0ZEQU92cXZIZ1pxd0hhV3FnaXo2SkJYSmFTRDg0?=
 =?utf-8?B?NVZ2UDE2S0t1d3dMUHFSS0cvK21zOVRFSllBYTFQMGRoQUlYOTB1RjRWc1dU?=
 =?utf-8?B?QjhHREJSNEUweXdFTDVyT2k4SkMvSG11ZTJuRFNIT2N1ZmIyZUY1V05Kd2tN?=
 =?utf-8?B?NUZ4U2NXaFp4MEtDT3pETkNOMC9sUmRmUlJzajN3eDNmRGFxYnpNeDhOemx0?=
 =?utf-8?B?d2FLOHVFazJZYlljdHZXMjR3QVhMYUZLa0JiU1pGVVpSSFRTSnhpWkVyWHNy?=
 =?utf-8?B?WEJFdzB3bnJhSHFIdUI2Z2FsZDg1NFZidjBTMUthejRxTEdvSTNpSGVpS0I1?=
 =?utf-8?B?QktZVUMxT3JVVi9yK0dJZWVzbys0S2VnRmpXL1ZjSXFRbE5jaVZzbmwxMmtx?=
 =?utf-8?B?NWViUzZtWTVmQWNSQlRlSFE5VnFaOGJKNlpxcktaYnFnL0xVdkVjTC85N3VX?=
 =?utf-8?B?Zk1SdWQ0elZ0blBUVlFJKzZTVnR5a3BhL2JmZzV0U2lrajZUUE1LZVZ1VUNW?=
 =?utf-8?B?Y3loaXdkU3BIVnJaRXVXZTVQK2M3NURvb3FrUHNPSGkzUFBjd0tlczM5MEE4?=
 =?utf-8?B?Sk1QZDhncFFnYVlZR21NYmw1TUVaZWpFMWwxdkRJTDlPSlpZK2g4dWNGMFlY?=
 =?utf-8?B?Q1dMR3VYN1JlUms4cEJBS0JwdTZLWng1R1hRMU03T1hQYTFQdXFmZ09XaTA4?=
 =?utf-8?B?V0ZaQ0ZZSGpjWkQvTjJ4cllPd3hyZVRoR0hhaC96Z2hxdlZYU3M4aEk2VHRN?=
 =?utf-8?B?UStFR2V0Ui9FTW56VURFeTB4eGVPMEoxek1Nd2k3OUdzd3o3WDlhRFBtS1Fh?=
 =?utf-8?B?RkxqaU1KT3pHOGJGL1dnWU9tRXR0Ly96VWZ1ZGZvU0YyV1dmdy94TW8yangw?=
 =?utf-8?B?S0tEQzg1VUNQSk92TytqcWFENVoxb3B1QmtCMHhkU21TSE1aaHlmSXhsQmF5?=
 =?utf-8?B?TngvVWM2VWVXd1M1bzJiNEcvYWVVMGkzb1VXWHZWU1hGQiszNHNWTHhsVUwr?=
 =?utf-8?B?aEFHQWZtOE53cHMrUTZ3TDdFbmRodDlDSUtlOWdJQzZaemFXRTY3VXpaQkx1?=
 =?utf-8?B?RUU5RkFDaWtiOHM4OWRndUNCSFdOa3FLbFVUWDMxN081UlJMdUljbTlMMjRT?=
 =?utf-8?B?YTNXUVI3Q010RVMxbXF3M1pUMGxJOW9OOW5BZkZ2dHowb05FbGJPeEc0K0lF?=
 =?utf-8?B?ZnBJajZXaTFpd24xME1DeG03ME81eFNoUlMzV2JFNkh0UWI3ODhaN05QNnUr?=
 =?utf-8?B?MkNaMXpsQ0Qzemg1UllKSGxJVi9ob2g2bGpyWXRRdFVCRmx6V1JmZFZublZR?=
 =?utf-8?B?VUZxeHZGZ1dJSGNoMHJVbGxrMUROYkRQUFhUeHNwYXBjYWlTckFLM1UvcUwx?=
 =?utf-8?B?ZnV6ZFRENk5HT1ZUQ3hYenVzVWlKcXVOM2x5WGlRZmdCNVF5NUlGVHJWRWds?=
 =?utf-8?B?MjJMQlFTUEN5d3hrV0R4QmgreExQOEZEWFlFZWNKazViSXFiYjNjY01WWHZC?=
 =?utf-8?B?SHBoZENyVmJRZ0J3bDV5MXJ4cVoxOFZpZk1FUnVjNTVKVmdzam9sRkxNWHZQ?=
 =?utf-8?B?R2E0ZVRQVGVueHRyMzVMTmpzMUNHSmxUd0RsOSt6Q2tmVmtEOVRDdzBsSDlZ?=
 =?utf-8?B?WEhLa3htNlEwY0NPKzROVk1nQ2J1WXpteTJXWkkwMzdMalRsSDVuMXgwbDVi?=
 =?utf-8?B?OWJ5M0hoMS82My9BUWRtNDZnZGRBeHgzNDFaOWFTSkc3Zm0rZ1FJQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 511b6467-d5e0-43d3-c935-08defafe0f21
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 18:50:21.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSR/ZYL0gVkDzDh3NnVFefeXbawfYe5cNKlK5eHqvMGoDyIDpq5yvm4IUHH05TwoApFBslOx3BLU3YvF0WCArg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2397

On Sat Aug 15, 2026 at 9:06 AM BST, Younes Akhouayri via B4 Relay wrote:
> From: Younes Akhouayri <git@younes.io>
>
> From<bool> turns true into 1. A signed Bounded with N =3D 1 can hold
> only -1 and 0. From<bool> therefore creates a value that the type does
> not allow. Deref assumes the value is valid and calls
> unreachable_unchecked() when it is not. Safe Rust can therefore reach
> undefined behavior.
>
> Rust cannot write N >=3D 2 directly in this From implementation. Add a
> private BoolFits trait. It accepts every valid unsigned width and signed
> widths from 2 through 128. The current Integer types do not use more
> than 128 bits, so this keeps every valid conversion.

Given that the existing `From<Bounded<T, N>> for uXX` implementation all
requires signedness match, I think this is being inconsistent (if we view b=
ool
as u1). I think restricting it to just unsigned integer is better.

Best,
Gary

>
> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
> Closes: https://lore.kernel.org/rust-for-linux/OzuVxu0--J-9@younes.io/
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Younes Akhouayri <git@younes.io>

