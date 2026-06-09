Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020084.outbound.protection.outlook.com [52.101.195.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A690400E17;
	Tue,  9 Jun 2026 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005548; cv=fail; b=aOV7/pGYXXUbZkFccxh/W8Qi2NrP/jHc1xne575Xv/B55PJQwpx6vQ5UcBu0IjnGZB7kEbJz5GcwmFs059s6xnQ7i2QnIJJKbpwLyyFug7CwU/SJkLhzPQNC59gubDNmX8ANiz4Mv/fmVp3KWnOqdPj5od8mYRKFUUC0zmIiCdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005548; c=relaxed/simple;
	bh=f/5LRoB0VQ4gC6GL6XE4+suj0RUplv4rJMJoK/NRhr4=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=jkQxfkYfk13vyiN35LX0ftWAOorcvnUqAUgR/zN31mHr4uZhhbvM4B59Tm+2aegBGEpCVhevkWpP3RfL6akAK+9UwVZ+5vCNa+K7TgoiqJTnGlqeHGqucAeKvX23moAL72gsCRr3eEBpzaMB0c3wE/+sWyURNyIPxpw9vHgZQ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Nkclsw55; arc=fail smtp.client-ip=52.101.195.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Nkclsw55"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cONzNadgK1nXMMi+VOFfb4B7wUHMrHrQj8HJc3PcN+02QjaIBsY2FJxXXoAnBhK6EyiYYTq4NONyQolXsXKiLqrmWSEh4Rv2WBhTJp3ZibVe+Nc2s0mYTU8LcXAfoIaXx2U7VBCx4nxrFnLDusOQKeC85XC8Gf3966REBKH9F+WY1a6m8j9U7Zqs50SaTshhCs0IOieD9ds4B4UQgd6RDP2kF74izb4wHueZH99YmiB2zTirHYJDh18zE7r2g958JFiI02SIYmlHLJ7wUqtlKNswnkOgs2CD6JI13xK1hWRL5B35EUnSV+kYihSPgXBlVNUmMyiu0LRm/SqE7HLRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLrnW4s4s6EL7x7N8JXAl1p+CmUpNpXO1o5s0Ac9bzo=;
 b=bpkiNY89LEiOKWlZfq3mGHI/eCUmfSa4w7h1fnzAWO6zb/u5HXbq8lYy68JfYyChZi4xTTzKL0iNO/+elDUj758UTtZPusufmMR503n11M4ikoxVFQ4NA0BSqYmweIvOk8QYmML5m4rJj2HbDEO/mR9q6mNrPu8uxIrYUwJLWhHjP4e7MwClJ+UV/LUU4zYH4IuYuyXWBQgQgXLDd/v5a8cRSrA6BAX/QRyGbRzGQPai4AyqZXfuJjbPxdIhAYqc/3ktOt4QZACzy9EWWdzqrmHzdUCQKqo6lXobmC1dhisGexwKUIErJ9p9uodghjrKs+5B6fNm1dPq8UC45E8ChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLrnW4s4s6EL7x7N8JXAl1p+CmUpNpXO1o5s0Ac9bzo=;
 b=Nkclsw557OZnOTMZVsR9Ylzn9gxIK4hP1Jv7rruELp7Vw5bnLahsYGu3C4J/UuaBEcvdN+mYMQOau04lgKU5HlB6JdDeG5l89g4fFnEVrOIXxLQOdESdkkzghZBzcfuvv6pXzsRobmR5QArNFHr6wQtkdfH8Pt3g0Lnm0+YB0gQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2350.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Tue, 9 Jun 2026
 11:45:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 11:45:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 12:45:45 +0100
Message-Id: <DJ4HRWKV4CVT.ONAZ8OSNOUWO@garyguo.net>
Subject: Re: [PATCH 2/2] rust: str: clean unused import for Rust >= 1.98
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260609104152.261145-1-ojeda@kernel.org>
 <20260609104152.261145-2-ojeda@kernel.org>
In-Reply-To: <20260609104152.261145-2-ojeda@kernel.org>
X-ClientProxiedBy: LO4P265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2350:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b0c8fe-758d-4728-7613-08dec61ca4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|4143699003|22082099003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2iKlY/oYu7coqChnAzFSr1AruoR2yk6X5E1qbnadzQTNWI5R6lrf0AtYrWhbPjGnRYyDQSmt0biXNf/7Lspf2V+slypaUGmBudU4aQJHFcX64yNXutajSRO3ZiiQiT3iq23pwo3PqsgnMddH+UVjd5InkgJJvA3qeTdwNlbaliS6dGm05kgOOebZQwws4yHByV9n4syaG2ibyEtImaGhkDEAWOybIcOg9y+kkqGP1PnaEHMxqOlhHq6XkPcjkPWlAMMGQ7IcpgMShnEH2W795ykyQ76V9iX0TOIVvpq/Y4CA7kTTw+jIEzdQyjH8bKeOWgr9vn4pSDITC9kyF9Ct6wG9XaXHe08jIYGY2TTqxzorG0zayS9rGcvIjtYZGw8fCT6NEMoY+c2Y8VR5z6ROV1hGwCjBu397gk+UNXeF0Mz2ek21vyJt2nEejwq9wC9Ii+WWn8Y3/Jso26HNsqOdQWhbxeOXISKfYyy1uyNpiqfcL5YsJDNNZhl2cA4oBvcrPi2gd7z2GaGm6tdBOwMwf+ASIjpJzAUHK6BwE0RO4gZTxiWgLywsgONMwRIpwjHb9jkmfosUGo0ymqqOPrCRu0wWhEsyxmm9AM3r/abqkD+C1N+5D9yXR9IKgIGtbgpu8QlrAdfVvVpO4l2FQuFQybbUc/iy+MwC1o6alV8f7Lb7JBBXFQ9EYuuXLDBBR7qhD7/cx44izB+mPYt8lgUncQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(4143699003)(22082099003)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVl2cWtvejg3aEMyOVNrbXgxeHlVbldmUHRacTYxeXFXNnNYSVJDS0FyMU1Z?=
 =?utf-8?B?QnAxVS9PZHZySXlnSUZ5djRmLzlmTysvVjJtd3gwekVqL3hpVG9qWlpjRG04?=
 =?utf-8?B?eC9TYy9uTU8weHFVVzd2Z2dqT21ic2J6MzhLUzdraE9nSktKc1IyamxZQVRz?=
 =?utf-8?B?bjhhQXVxMDFvL0lwYWZUa3phUTRKajU2NFMrR0UrZ2I5MjQ0bkRQNUlHWm4r?=
 =?utf-8?B?UGltRk1vVXd5ZGs3Z1FlcVdrRVA0ZW1ZZ05UTmVPMjlLMDl5Y3ZSM3lIMW9H?=
 =?utf-8?B?NTJNanBJYUt2bW1UTVVRZGZhV3kyOGtvaW9PbFF1eFBFZEhWYkZFR0dKcVlR?=
 =?utf-8?B?czZPdVc1K0pNcVVwd1lmcDY2RTNYcWxIK1doRThjM2ZYeWRFRmpVRFdlRmhk?=
 =?utf-8?B?dDFpZGlyTnUxTmtaWG9BL2VvS2xUUWU4M0VySEJ3ZDhMUXR4U3gxeFVDL0g2?=
 =?utf-8?B?bjZFYWNwZHVXYUFReEJPa0NPQWV6UHliRnV5WW9TZGNFbyt6dDkraTIrT0hB?=
 =?utf-8?B?clU3ZTRoNWwycktoeHZhb3FZY3BRZmlMY3N4RlRIbEwrS1dwcjcxQWVWM2E0?=
 =?utf-8?B?NE4yMjY5a29wbExhRlIycUE4SGdXQVhkOEVSM1NGTFg5MWovSW5TYlJMUGZT?=
 =?utf-8?B?ZmRQSnVvWFg4MWY3Z0U4M1U2VnN5ZTNLYTV1NTVJTlBqbFJyS3Bub3JhZkRi?=
 =?utf-8?B?SFB1czJQOGdFZzhvaTRLUTIvRVNJb012SGRoN2szRHgrM1VjRUlMdVhBTVFx?=
 =?utf-8?B?RzVpMzAySGtTb0ZkTlRxVzVYLzRBM3FvbDBvSnZWNW9vcGxodFl6RGdhWmY5?=
 =?utf-8?B?MXVPRVNqVDdldzJXNlE5UWpSaGJhcWZ0UUV0NmZjOGxwRkNaZjRhR29pRllh?=
 =?utf-8?B?Z09JRDliYjZFYWVLN1hFcGRtQ2J3WnlnK2lubCtjVC9sRmFNckFqV3RPUERW?=
 =?utf-8?B?RkMxbEljWWlzRlVnNFhmNDFEdlE3Vk1rdzQvS21JMHZETWlObTQyTGlrUURj?=
 =?utf-8?B?SmZOMEhnaG03aTRhZm84RGc4ZEY5dlpFL2lTcEgrTldsYnVhelJSd29mVTR6?=
 =?utf-8?B?SDU2QktZUU1QSDdrSHgvSFNxcTM2dDRYc1NoT2EvUUNPa0J4aUR6OHArYUla?=
 =?utf-8?B?Z1BmdmRnbjh5cE1BWXY0MTRQRmhjeVA2VHErbUJXYmpTSVNjR3RFWVpTWGJa?=
 =?utf-8?B?S3orWWNCa0Z1c2p5SktZZld6bVNOM3BkVjdXK1hJKzNnZ2hOZHVmbnVQaWdh?=
 =?utf-8?B?Y3dqV1dMK0pOSXdZV3JhdlZKdUJ2VFJuT203cHMwRVZ4aDAxN2Flb1JIZUx0?=
 =?utf-8?B?cGJhdzZ2NDdYN1lTcUlCZlF0U2s0cGlEL3VCK0xuR2lYMHlzUDFuUHVwYkVi?=
 =?utf-8?B?RVpDbmFXM0JVSWRGbXRjVmh3K3U2ckpKTUhmMVlXTnFQUHBMZWdReTd6ZDAr?=
 =?utf-8?B?bGU4d040SmVYdFphMXVzb00rSCtWMEhOeURKUERXSFR6cEcwNkFaVjZWYy9D?=
 =?utf-8?B?b21zOWpncE55bDNLR1lvY0lSMGlONUhOd1FlWEtRemFBbG5ETGlONGlWMHpM?=
 =?utf-8?B?OEV3R0hPeHZvalNDYXIrY3dRVzY0TjdQU0hLZXR0ekV5dTZsWC9iSlJOcm1j?=
 =?utf-8?B?ODRGVUlmRCtZTVBheTg4by9JY2NqN212OEtZUjEyWVgzZ29pb25IWHJhU0Nw?=
 =?utf-8?B?UXdIYjBKRmR5STlwbm12c1kvOHEvZHp0bXF5Y1dlTjRpN1Z0WUtKMkJyY3No?=
 =?utf-8?B?cFV5dXlNdzRZWGprZEMzOHJQWC9ybjJISXQrdlJwd0dJRWJ3ci85TzV2aHJI?=
 =?utf-8?B?Ukd0WlM1SGNnZjRxZndtbmxRcDlPNWRBTnJIZHQ1MG9jVFlwa2gzbmJTNkxm?=
 =?utf-8?B?M2lQVVB0b1huMWs4dHdsWVBwNUJ3cCtIU1NKZ0YvQmNPWElqZVRHOEhBanN2?=
 =?utf-8?B?VXk0V1I1cXRuQlNSd0tUbEZsaUtMRFcvaE1qVSsrSlhSZVYzMGdxVldRaWtU?=
 =?utf-8?B?Q0szK01ZSE5CbFJkUlhLL2VTcklPaGVYS2VWTDRnejVBellmeTMrdElzTkpk?=
 =?utf-8?B?cW5GazM1aWRPc1UzSzZBbWI0a3VVcnUrU2hwUEVnU3ROMVhTZHNBaGxyb0pG?=
 =?utf-8?B?YlZjc2xDVVpwTXFXdlhwYXJZMS9yTXViVFdjQU82b2NQWGd0ZHdEVXlvN1Jo?=
 =?utf-8?B?QVQ1dFJEYWFpYkhrTmRvdWI3R0ltZy83ZHdHM09tcHRVa0pNM2lzRXJBdVEx?=
 =?utf-8?B?c1pGejE0OTlDRmZuQkVpWmF4eXFva1JEZWdpYkkyRnF4SlhlTnJyNjl0VUgy?=
 =?utf-8?B?K1prNks1NFhzc3RJUy96OUMxV3BvV0MwNlhLR0dzK2Irc3NYUzFTZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b0c8fe-758d-4728-7613-08dec61ca4e2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:45:46.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRutMc7UOUbE1D0wHJbKbryOr+Qhk4CUHmxMkfRyBWerY9mvTwGG8V6gAaQ/NudnsLT2O1otsZy18QxmMjmatQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2350

On Tue Jun 9, 2026 at 11:41 AM BST, Miguel Ojeda wrote:
> Starting with Rust 1.98.0 (expected 2026-08-20), the compiler has changed
> how the resolution algorithm works [1][2] in upstream commit c4d84db5f184
> ("Resolver: Batched import resolution."), and it now spots:
>=20
>     error: unused import: `flags::*`
>      --> rust/kernel/str.rs:7:9
>       |
>     7 |         flags::*,
>       |         ^^^^^^^^
>       |
>       =3D note: `-D unused-imports` implied by `-D warnings`
>       =3D help: to override `-D warnings` add `#[allow(unused_imports)]`
>=20
> It happens to not be needed because the `prelude::*` already provides
> the flags.
>=20
> Thus clean it up.
>=20
> Cc: stable@vger.kernel.org # Needed in 6.18.y and later (prelude added to=
 `str`).
> Link: https://github.com/rust-lang/rust/pull/145108 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/str.rs | 1 -
>  1 file changed, 1 deletion(-)

