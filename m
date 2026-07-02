Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686F3EAC90;
	Thu,  2 Jul 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990633; cv=fail; b=KHaHJy2HmP0ZLfLFYc/YyYLcHUXbo4yQsDz1nbtQ7hRfjS/fA60JsoeZKfP5LfQBK8aXtrl+nHPSYWFw6qrnJz3OWsVf7qsPBe7O7R0DWa/R/koz/2nx2pLBkBJC7QDmV9S0B69KjATMnLbyVPnJ9QpvYXTsV37EEOaJOHWGWG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990633; c=relaxed/simple;
	bh=fkmBYozkdFJCcLjGHetw5mgp66AuaEDiD6B9o4uIS6o=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ZXrbJknsbdlck4ORSqtsrX+hkK4skaVtlzkA9zQ2n8GX/4LV5AvlBu60Ywozx/TB+Hr7NyEYENsPS9MMy68FzgD1E7ji2YjX2I9Fw5zCjnLG9guHsFz54Fj2G8qxhvySjK2F0C1Lis8xqtVbGofMkIHwMyz7JSlWvliqbG8TIVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Pp+riOYK; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Pp+riOYK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnBFyStrEnUP7XveKJjX64Uk73sgy1Ls7WNdg9Q1XGoZie5vG+WFs5MfB3HfH8Awm7uzNxPW8S9HU2r3Tj71NbdBSi2Ya+ShcgVz4zQsRlDOcTkvuNmrBEmdDOXrlPjKu0/BUHmS8ygBtoAg/xqaEQieLCnDwjIjsR2hRhc4DYxlMfDxgfQjMOCs02CS6oR4JlLcE3E+v45Z9kmxL4I91Gz9Z+qDEgom9yXvZ6IV6iVjQ04wD8mhBJCDuM3BcRwzkRO+LIgu2GBaLI2VEIXT7m1SB3qns2UPtBulyW9yPeZFEEBaJEjkBw7Oype2JP/7O5P92+8qAsv6jmseLWIeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9rbPYOjbMLuEPrnm4W6iBlzm/6jsiZp2wIQv+oOnQQ=;
 b=AEgfUgpfPpufudH8yzeARBLccPfkSJv98EywKzGtBYLyrrQHjKA5X5j/Awjwf9PDryeGRdv/Ay6IcAFuKmdqSn1Kpxbn0+zYo1Few5lrCYzLUrTv2CmdwQoilqirv9x1TbfiUOleGHOmLyGwThV5/2u8PCXWZT77tKjVPsVrj/5JCp/c6MYItx8QG/W3v5KczWpo0ldEGSUddLKPeBv1/R7CJ206fNYxtacM71QXb/aRo5hrtHLwPt/yNIdV0MpWlSInYvC1ptQmr8XvYW4+y7tGI3EdxngCLSuRYJgWNZabz+AFKICq23dvKSEENG2Q/2446hLBhKVjX7f8l5G0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9rbPYOjbMLuEPrnm4W6iBlzm/6jsiZp2wIQv+oOnQQ=;
 b=Pp+riOYKE+/vEIlbUFcAPZ/TIsFycUcsjjhcEUesk4bsgoWjA/VYcndaQGh9wB25ve1gTlYzaqS6Fvm5ngz7ue2q1LjWM1H2DRluyUKAq8iYhabbexEvM2f70xNX8vYhXButSNSQtS7tdACIqfnqBfeRmsagDYREI0ho1kP717I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6288.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:186::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 11:10:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 11:10:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 12:10:28 +0100
Message-Id: <DJO1FEVJZA12.2T0RH6GL8JR44@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: devres: ensure revocation is complete before
 device finishes unbinding
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <lyude@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260628174451.2275679-1-dakr@kernel.org>
 <20260628200304.2365598-1-dakr@kernel.org>
In-Reply-To: <20260628200304.2365598-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 70604345-656a-4806-f202-08ded82a8643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|10070799003|376014|22082099003|18002099003|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	d07JvvYSFc7KLLiFCHCQjvmFsevaqRTa1kQvhNTX5hnyenEfeQg3vCNUCXHbOTqusfl6DCG32t28x77MpO+ZnJlYwB5P9eVgnOFLnkfC+YRogDjr0dxTTQSC6KRO8NzprzZ8zT2+lOHb6vUOMGNbVO0XmIwewFsKDqXfWwvXcDWDTVjtu8N8qH2MozTTTT1f/Z4yWacq5IIJb+mEjaXLzhG6fdLjsHq6MIqE6XOLDoN/NLk2Km8TW/5EClGU+G4vV8iHIpNyzrOADNv/qpik19PmGQSJAjN1dAa1xpC1sxOHKjx+fE2hdc7bUuU1PhP1sVreZ1MycKsgkuEZidcmlnYDULHeTDXzdkA0Y5PEWH9YpvL260g0iXGRzUl+0YHgH45mwdVN6pu1KwUG/kthsP3HRLdAQhjV/EDjPYzDoucRyghCSOrHxvtS/zfzlfsj69p+JYhuydVgs02ahkHSWur0nclWVgu+bemazH9Lc91kzD6ilLWr5f041IxbTiSzfBs5JBk8zmn0Xb4fZsvB5JBOrwsYK5HaeVKwWhq1wfInjIycjoAt4sCazfs4qNEbIpI2NhuSfVAiD3OMXT4ai+/5jSo7nNBVzWn1J/O2MnJ9f47DMRANC+W1IyYz+ngE+rQ6t/Ue5aW9oFpqcq0yvZleW6UJp4vHQcm5kVJCdx1Ux9ZvNk6tM8PiJ9F0xDEq24cpVBK9MSJMoOm7OSb/fQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(10070799003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTNKdGg3aE9rN1VhaDZKRmtGTFRIZVlFSVBQeXZJNmxLT3FGb21vMy9qaEd0?=
 =?utf-8?B?NTl4OE1FbE1uYnRpZzFEcGg4SlB2N3ltQWpadHpvS3UybUVoL0tpNmJNNFZD?=
 =?utf-8?B?SEQ5ZjBtNWpDUG9TWE1xZDB1UFNFNXlGOXQzdERGKytpdVRCeDFMcFNpWjZx?=
 =?utf-8?B?SkdScXl2ajdXWDYxYnpqbndmZ0p5T3VvaEw2TC9OdEsvYkR3bThaalNDRGx6?=
 =?utf-8?B?T1gwY1dnemN6TXZEMU93emphaHZacWpmRlR0WStYMW0wd1NoUDRRaDZLalZZ?=
 =?utf-8?B?U0N0akJyM3FXQUVLdGYwdzlydDZvSjlFUkJTN01adDBQdHRMUGw5aDZUOW9w?=
 =?utf-8?B?c3dNbm1uTmRVNTV2ZEh1bW9CNGJIbklIa0xkajcrM2QzWmx1RmZzUDR1NVFS?=
 =?utf-8?B?TXVraUxoZjJ6SWtVUWxWaEFReG1tWTAvR2htSW1sNVFQdnNXd1JXUGdzQ0l0?=
 =?utf-8?B?RGVCZmU0U2FCVWYyTmdSdkpKUkV0WjBCVTVkRXJzMVdvVlhHTlNlcnNXRzY3?=
 =?utf-8?B?ZDhwb3R2dGZqSmVHZEJoTlI2dmtvZUs5bUdSOG5CbVJURldDY0lOa0dNeWJQ?=
 =?utf-8?B?YXBjaE9zaFFPYkovTUdjNWdOU0FrS2k4bEllWFErQ1R3dHBSYmZubzVBR3A2?=
 =?utf-8?B?ZDJKM0htSUNKSjlyTnpJNFdQZDVBTzhISTlIUk9jdnNLaS9vN2xHNWZuRTJP?=
 =?utf-8?B?VGRNWVM2NmhBVzRQaVdHY21CZ3BMQ0xHcUlPNi9HTi85alpUcXovbDZDcCtB?=
 =?utf-8?B?RFMraVNudGxTSmVudVJOR1BqRkxsWERCcEFCSTZaY2ZzREV3V1kxdGVTWkIw?=
 =?utf-8?B?YjNyUm52VjVKclNPNXErOFdBaXdLbkpneXRGTnF6QlhraVh4Qy83RW9pVnIx?=
 =?utf-8?B?aHh4QjRBbWxiWjA3OC81dXg3YUlNNHd5Q1h4Rmp6REpzTmZzMXZKN1g3UlpF?=
 =?utf-8?B?K3UxUzRjSjBjWG1mQm1QOXhRQ2FHOGxINjc3bmd1Q1NkRHZYbXB1VjR5NHl6?=
 =?utf-8?B?OTRES1lSRVFRN2RnS1FGM0srNERHTjZTRzQxcUNBaGR6TzFvKzdmQURRS084?=
 =?utf-8?B?eE5EU1VFTy9wZHFrS0hzc1NSU3RRRG4vNnVtak5ZTUxsajI0U3BMSFNJR3ox?=
 =?utf-8?B?MStZVUFNRzV2aGQrWUNvbGxvWk1yVktMMUFhcWJKNkhobWMxSGhhT1VrcEND?=
 =?utf-8?B?K1BCRndPaUliKy9MRzNCL1lrSUNvOUoxd1ZPZFdMd1U1aHRzTmlnYTNxaFlQ?=
 =?utf-8?B?b3FObXVCY1ZKV21FLzI0eDF1NjA4L0Y5RkhQSDRXT3FUUW82SlJYRXlOdUVJ?=
 =?utf-8?B?VkxMWHRMOWV4UTljSFE4cXpaZ1V1ZTlYblNUaGlVd0RSa291Nk0xVnVEdWIz?=
 =?utf-8?B?R3F0UWZFYXVrSTZEbnV1cWJ6Q0JoVUdWVkJMenhpMVBwaFI2Z3J2Q0M1Uy9j?=
 =?utf-8?B?UWMzQXlIL01Lc204d3NzcTU3SysxdWdzdHRxMk8zMXhxV0hRd2dLWGNYR3B6?=
 =?utf-8?B?cVo2T3hDcWU0amxYTWY5SkFrZjV1TGhsWmJFOG41amZVMFR5ZXptYU83TFVi?=
 =?utf-8?B?MUgvdWlmNmJXRmMrY2p1VTBldDYvZ2FaRysrd0FlV3crMWJPRGNvVjZiMGZW?=
 =?utf-8?B?Y2J6NHQzVlJzSld5WHo0N3gxendSdS9wOXJIN1d4SnFDa2ltb0NJYnFaa2xQ?=
 =?utf-8?B?aHZrYlhqRmZpZU5hN09iSFZGNW5OMENVTEticlJ6NzBnN2ZaeVZsN0xsWmZC?=
 =?utf-8?B?ZUdncnNDWnR4TVVlZXNwNDBXa3RzQ1VyUktBY3dsZTRyMXp5SnBEeUgwS2gv?=
 =?utf-8?B?L3ljOWI2VTdkZ01zanhXM0xlUnhTTEg1cUV0ejRLckVNMDZHWk1QYTZucG5U?=
 =?utf-8?B?SDRPRHU4c20wM3c4S0JvUkJObGE3aUVyTzV4ajFiaDFwRXV6YmVtM0xOeUFW?=
 =?utf-8?B?cnoydmJzRzZWOTB4OVhjZ1NrTlNlT2luRDlEZFBqY2hwL1ptREhmYkhpT2g5?=
 =?utf-8?B?b3BQS0ZNQzRVRDdNRCtySjg4cG4xM0FSeFpRbUozOUs1SzY4VEtlcnpvbXFC?=
 =?utf-8?B?V1JlbHFveXdPa1E1ZVB0aG9ibnNMTzV0SWM4MzljRGxiUlFUUmszVUlabWtV?=
 =?utf-8?B?THBIeXBDT1pBM09Oem1TS0E3Z1V5dGFzSlBGbXNBSks4SlBxN2l1NUYwRmxq?=
 =?utf-8?B?cGxJQ1hBY2k3RFRDR2dKVEtURE9aRHNtQTZiRHFnZjZjWmE1bVE4RXBCSWFN?=
 =?utf-8?B?bnZPSWdsOEVVKy8yTGk4STJwWkpLNTU4YTBDUFU2cGNrcEFrZDR6UytxbXcv?=
 =?utf-8?B?NnBoRkZhVlJ0aTFYNDIxaHhDUThmY0pRK2l0WVh6SHZFcVJZM3dBZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 70604345-656a-4806-f202-08ded82a8643
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:10:28.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LJOrZkmxcs1ABRbDbBIhavCnIeh21NUSsSl2OrLiAuue0Xp/OZoMJIuTINWh5Mq2BoXarNI/ri8c+nM9gsmVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6288

On Sun Jun 28, 2026 at 9:02 PM BST, Danilo Krummrich wrote:
> Now that the revocation Completion is in place, also address the
> symmetric case. When Devres::drop() wins the is_available swap and the
> devres callback loses, the callback returns to devres_release_all()
> without waiting. This means device unbinding can complete while
> Devres::drop() is still executing drop_in_place() on another CPU, which
> is a problem if T's destructor accesses device state.
>=20
> Make the synchronization bidirectional. Whichever side performs
> drop_in_place() signals the Completion, and the other side waits.
>=20
> This does not reintroduce the nested Devres deadlock fixed by commit
> ba268514ea14 ("rust: devres: fix race condition due to nesting"),
> because that deadlock was caused by drop waiting for the release
> callback to return (the old 'devm' Completion). Here, both sides only
> wait for drop_in_place() to finish, which completes within the current
> call chain. The Arc<Inner<T>> keeps the Inner allocation alive
> independently.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ba268514ea14 ("rust: devres: fix race condition due to nesting")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/devres.rs | 7 +++++++
>  1 file changed, 7 insertions(+)

