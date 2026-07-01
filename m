Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19940E8FA;
	Wed,  1 Jul 2026 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905400; cv=fail; b=qSsdg2FO7nHjb74ym2X+Oc0B+A2DWZ9Q3cAieeB97+ceH90TEK437Zy9lj+Ri25vxYVtZmgObL5EShM2mewdfQ+1h7Cc4SUnERLmtA1Q/qoRDQp8teDrjAMg44q48+RqDSusbwM9UYeTwkwzto6qq3/l1sjb0QtGyOFMD3nsLxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905400; c=relaxed/simple;
	bh=bU8kvBxkXJjn/cWwWzCSFi08c1UA8SPQItU0PUcvGIg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=TW/K8gyvniDoSAJwrdifFzX9o6QdONyu+7iBibqwrQwL0bZRd3ShrYwGl+y2WpGyqXH+eLpn2Z6hWg7FJplOZHtOSqsWVH05k1odGIMTiWOZs+6huce1pTxe+OxWrybpxmNVB1AgBQMihZyEjlilbRm8RLfnJfJKF0tRG3nuQws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gbU9hQf4; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gbU9hQf4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNnicXmSz8XEE0a6jeRq+7RtrI1o8Kesd/O9LrrOFWaoXYChb4gE3aTyaVCs4l+9O8X30Agr6lleaYMjBztMCWbM5EGAVFO/8tF4SorHSTkALxUm16jCjQ5enPZIXzhV7d/rpCeLwpc/01pYsG1KA+sUVwz1RK/B6uQTJvaE+BFvAk+OYB4zyiU5tN9cxFrX5+u9DPg5422GPnUL/3sY9dK5VdrkRjWtGZMZLM8GRNBSsa+/5qjI2WtSfdb5LTp2UUPJYRLg9DmaDxAdUBQJziyFMqoUE2ewMzItaeZP2Ttg1B7zxHEro1KZye0GUhSJr9gxSrKQS+1sfaVblSmCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt0ccaqJydrBGTnD0CtwfxwUzUmJadiaQlJ/1R6TWrY=;
 b=jDssmdjefFkYuU9SNf+mJE8YSOJEJuS22mXrFw0IkQSwA4nmUKrOLwvRGMHdfMTujY56CBAMldUKvOJFI1q47MFCoV/UK1K0sdLjFDYpM8kApf6ajm9QtIu5yBdmD4KzDSmTUVbVOdto3VBdFkM9uZFF+UZvj0WFxc0Q9YeRF6XOwdyWB1SJigI040IHnKueyQ9SCUJLPJJIzylddoD0/EfeJ9M18PTkdrzE6CGVyy9FQQR5IwkjWCK7JZpAgsGKo/h4TX/79whefJATPjeUuqOVMiYfZdwZdICHRv1M9E26Kq0Z8F9WNgzZJEtmUroWoe2/lE+vrqfxMP8PBwEnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt0ccaqJydrBGTnD0CtwfxwUzUmJadiaQlJ/1R6TWrY=;
 b=gbU9hQf4kQitSIHmwM4GW5QqPs34czeof1YQ8Ohs3+RtFXNHDWbnI6Fc2Bsfmm8r0LX85C4bkBBBuRVuv07WugmlyfoIgt3MGhc6uv76cSp2UOwiTE74IIAToijZ/ZdXKjEibKN6ZNHMRAlAvITakpk8li++LoS4yoOx33Oc8ayJ+9UfrDKSxK5xMVpcTatz11I7uTJgpAFPDcC0AmIANJwSUw0g2XcgANtlXPYsXJLexX3SAPGOUNB0kOYZPWw5VzqaErJtUAgqfspj9wC+eiQAgd6u0nvgBNe0xzu7poLDAzPlyQOznZ74nPgWlRHpRluIwLGirfa68u6ZmZFmgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 11:29:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 11:29:49 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 20:29:45 +0900
Message-Id: <DJN77N2ETPBC.1BUU6YDF3716V@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 01/19] rust: drm: ioctl: fix unbounded lifetimes in
 ioctl handler arguments
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-2-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-2-dakr@kernel.org>
X-ClientProxiedBy: OSTP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:227::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 546b8fe3-a149-4122-d213-08ded7640fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|7416014|376014|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sIv9kLtugdYUvLNH2lKh9M4LrJUwa9CNhPcyxZhu6z1N1JIj7y9iqAyCsUr1BA5kei6ltNiiKSInSAcdnzp1bTShSRgTzwM5ElwSlhe3Uvhxi/kucs9e9d9vDqZt2+pPVzoOW8fSrC1bVRbe3Rjxh+eM4ZoHcoEQOFM0EyGpcBmXIP06cIbKLTKe0DL7eZqCpbLYJIfHd2autGSDEj9+Ny7Q6qfyau58qIuDy9m5wnmk0Dxndt+iiHVKVOGqPmTuuvY/Js5DT3d53xVqzSsWeipK2tYyRgBGjt0CAkbXtBtc+XX5XKWSgpUnNFhGwO1nsDKcLxKMTlXPmt85EWNLYQsV81ZYOiTFe11NcOHuMnu13ELW52EH7V0+mwACMZ7Z3d8qrWKC+sOb1viy9p3wzrjAFSjCUpFM0aGRAYFhBh9lkxbgh+fLVn5amb1Tizv0XheKlC2nw6d9L8TxgSCd1o3pRd1YKIFs1tJJ+9HlMFW0p9WVFve3dZKsyvWJ+H41Stt0oOu0WyIoDC535naaCSfjvwaFdzMwQfZRnaXTL7XpTGXK82ZkgryIjZ/20Dlgyqullfz+TM8HwcABAk68jo1PXLPPR5RyW/Q0D06b/Htyfxf37SPlRUyCSyOaHWcrNOGcunoE9f6utdppfKhLWcGEfkHbFATmFaAGYWPY46I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(7416014)(376014)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0NuSlg2WmZNcWVPK1QvbGJYUFBFdmR2c05ib0g1L3hPMVRTRWFXVUNMWlMr?=
 =?utf-8?B?NUk0UTJrYytnUnhWWER1M28yclhYYWMwYXJ5bGVUYlk3ajVtaEZoSm5SbThi?=
 =?utf-8?B?MnljcFByYkRMWFdPY1drQW5OeE90MFBDc1hLeERUU0E1dldiNWdITGtoV1Nj?=
 =?utf-8?B?cmN1cnJhNWg2dzI0R0JZS3FQcGZ2SGVqcFNrNm9DR1h5bXNGK1FMVEdkY0Rw?=
 =?utf-8?B?WkJQOUh4SjZNQUJFWEZsTG1kMlVHSFFENHVFTnVWSzErclQ5VXQ2MTlnV0py?=
 =?utf-8?B?U2NTaTJNWU1oekNYYXpZMEVKVWV5ek1hYithSUNxSHBCNnM5Zjd3d0dtTU5h?=
 =?utf-8?B?d0V3ZGxZeXUwQVRRSWhRKzNiWm90bU9UaXF0azIxZEprTFlueElQN1JqTUZ2?=
 =?utf-8?B?WmxvMWg3UWliOEp2N3BXL0svOStscENtNmdFczUwaFJLTUxiZ2NNTWRJSmpR?=
 =?utf-8?B?NjBSblhaVDBoWW93Rm5pUU4rWFVnWU5RZGdReTE0TFpHUWFrSkR3ZG9MWWto?=
 =?utf-8?B?aUNsSUxYYTR2WjZtdHg4dlkzN01XTDJoTEkwMjBmdGNSaTVKZ252WDBzbytr?=
 =?utf-8?B?NFZEeENhcml5b1U1VG5TTE56WDFhN3d1STdDR2ZlS0NaQzZWUFR1TUlsQnpx?=
 =?utf-8?B?OS9IaERneUk0NVMzT05rYnhoZVBsajZxWkdNakNrWUllaDhqYkRxQUE2czA3?=
 =?utf-8?B?S2hnd1pUSkp4MDNBUy85YXdUOTVQQ3AwcjdFWlRUSHRFU2VGSG5VWFRJWXFw?=
 =?utf-8?B?ZXhiU3FTbi9oUVVKd2pLRHJrZUZ2V3FTUWlUL25memZpbVdGaWZ5cHNqM3JE?=
 =?utf-8?B?VktuUURiODB5TkRYbEwwZS8zY2hkNit5MmpsY0VyMnpZRkdkSm5QYkJjeWZi?=
 =?utf-8?B?VUw5a0NWalNSUndSVC9ocnhpWTVQUWViMnJualRvRHJ1LytPdW9RSjJzajR3?=
 =?utf-8?B?UGtUY1hzMVhVbUZlTlpqclY0SzZ2cDFEVk4xalM0R3lQRnpEdG9zTE9OWTlW?=
 =?utf-8?B?cWpSa2hVbFRZMkhIQjYzNHdCRUpuYmVKUFJZYXdHTHM3QnZKQk5raVJGenZX?=
 =?utf-8?B?bzR3bDZFMW5KS0F3NlNMWHBSa1YrcFB2eklETFRhZ25YNDBRWkFRdUZmVGI1?=
 =?utf-8?B?S1gwbEgrL0xDa1NOM3p2ZkxEejZOemEzeUF2M2V0L0pmVllyT0I3Z2ZRUUh2?=
 =?utf-8?B?Y2Q5ZUpyRVhxTHBUQ2F0MFJydWNFaVI3TUQ2Q1lMSFdYUlZoZFV1SVYrWk5q?=
 =?utf-8?B?Z1pCRk9yclc3OG4wcVhSYlpZM01TRThPV0tST3FOenFveFFMYVZtVk9XaTBV?=
 =?utf-8?B?ZHNEcGNTdVJvOGdQN09LTncxQUp0YTZBWktrTzFrYzZGQ3B5bHVGYkpVK2ts?=
 =?utf-8?B?NEZHZWdDaTZNcVNzd2dJTEJaaHZUNFZpQ0c2MUc5SHNJWm9ucTU1TnJGcE1t?=
 =?utf-8?B?SkMza1drSzhJeEJ6cWN6ZEVrRHZZeWFXYkFHZ3VGeGZhdUplTWZVTS8xeDI2?=
 =?utf-8?B?WXVzRUg4cDlGS0hIWGRkNlBHc2N6RFRvakVaTGJCS044aG0xaTk1bVZXUGNP?=
 =?utf-8?B?UkFGdzdDVGhRbVJhdXgwS045WnE1ZURBRVdSSHZDVjlZQ015djRwUyt2NDEv?=
 =?utf-8?B?YkRUdWxqNXg3eG56MitDVmw2QVVFN1l3cnRGcGxoU1o3ZkJGS1BickcraUtU?=
 =?utf-8?B?QmJjbWdMM2FvMlRQNVlicWc3bnh2ajhaZmI1Ri9sYW5QZ3VjUW5Ba3pWekor?=
 =?utf-8?B?Q2NBditsNXRuWWppU29NNlNjSHJqTXdYVzEvdlpFd0FnVHI1RzljVDF5NzNv?=
 =?utf-8?B?U1AwbHV6OW84Skt4b1prODdDN2gxVER6YVBmOFhMUHJZWWQzbVZENGpPMzZO?=
 =?utf-8?B?cEQ2RmNrNW5CaTI5YkJBK2xVQTRzN3NwSjFnUkZEWm9MbkNMNjVSZDhiYUky?=
 =?utf-8?B?NklUR1pvVmd1S2I5RkpiSnluUDBCd2EybnIwc0JpODNUUkFMT09DekNiZi9r?=
 =?utf-8?B?V21JaEdoL1hCQWZtcjRVSkJtMXBTYVRwUFNyL0RTYW9GL3AzaEZJek1reHlL?=
 =?utf-8?B?WFoxRnIyb3QvWjJqeVdPMTFTYSt4UWhZdVJmOGZtQUZKRjlHR2R3MU03RzVX?=
 =?utf-8?B?OFRtMjZUZTBSVGpJQXZCYkJiQVMyVzNqYkZ4Z3JIbGNiTUJUZlozZjlCNzht?=
 =?utf-8?B?OXkwQ1JrQmFsRlRoM3RJbE45d2R2TEpCVXVLV1FDMXZRTWxzL2tlcmwzVnA0?=
 =?utf-8?B?dWpPRmlMWm5HcGZsczFsb3liNEV3YTlCRVI5Qk5ldU1pbVhwS1lQU1VCcTFL?=
 =?utf-8?B?UWI4dDJySDA3akgrSXVsM3R0Y2NnMDRNc0MyQ3F4TFlsUTlYLzZyUkJFcHBJ?=
 =?utf-8?Q?jIf+4VrCKGkHCrCgaySxTZU2dmXhIu988EDMep6dZRk9L?=
X-MS-Exchange-AntiSpam-MessageData-1: Hkzs3n2rAwgQEg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546b8fe3-a149-4122-d213-08ded7640fbf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 11:29:49.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjcfQuzq3H8/tWwFKqQYa5U8z69zvviYBtIWVdXYNhq2II/Zy5C+eeb1y9DGHsdSZuq6Nc3uOnFYY5tcFL8HWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> References to dev, data, and file in the declare_drm_ioctls! macro are
> created via unsafe pointer dereferences, producing unbounded lifetimes.
> If an ioctl handler explicitly annotates its parameters with 'static,
> the compiler accepts this, allowing the handler to stash references that
> outlive the ioctl call.
>
> Fix this by adding a higher-ranked function pointer coercion that
> enforces the handler accepts universally quantified lifetimes:
>
>   let _: for<'a> fn(&'a _, &'a mut _, &'a _) -> _ =3D $func;
>
> Since the handler must be coercible to a function pointer accepting any
> lifetime 'a, it can no longer demand 'static on any parameter.
>
> Cc: stable@vger.kernel.org
> Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260620011346.A47D01F000E9@smtp.kern=
el.org/
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
