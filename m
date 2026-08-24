Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A20367F2F;
	Mon, 24 Aug 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585273; cv=fail; b=rhUh1du6r+5ZwblEsdRrJpgCSSGOUQEeqT5gl1axM7TAGOJon1/KbKm5xTeTTyXJzg1Oegsg1svyZ2jDbMcFaPywypdCHZYrsCAXfBqLlPTCLVkODUucperPLD6K22xZy8Hr3/kC44RFnbrZVn9Ac5tlVbYHQxDN1uMC0V+re1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585273; c=relaxed/simple;
	bh=IY1pPr3g9hILywVeOKx0c6TDeXbepLSgZg8epOCOmS0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=H8WRDLT5VOdP5Y/cJKF648J9s6OsHaklQNThUUEwsP6gfXzNZ0zCgTz3oMDgVVrghAVHDyfTPDk8HmXCzAFOegWIShgi2iPLCtVAYM4N2d0DX1xdrFXfi1S1SLNMMxkMreMnKBioU8rFcGdbvQ+BKp8lNGaSHVS/kV4hv9V4N0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8YT1381; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8YT1381"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VycQOgM0+KxcwwDlxf8mGo9HJlJV66mu18OD+Rdiiz98OPKxiRToKjpU0sQyMRopS0HTMews+Uvxp7cKnR+U2WGSPoQpwwUW8lEvJl/ItsBMXcFE3/Fz0F52XlUrF77TFVhj/KynKx4U61c7nUGHQttffNxGaxMvWX9ZYRyy+L9ZrmrEa3t6QVwN34FNpfDNek/U+B2d+rcRrW0pbKMv3nDPpWRxtKHx0CMWkxsg9jstc7GaA4kziWM5MP+p7A94174aw1QbrjZz4WE4cdHtpj9isZYA7i7jKuXj4QwmwVc0qojz8HU9axHgHsYl5EHMDhFVF7LyLEZGn8RjxMyZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY1pPr3g9hILywVeOKx0c6TDeXbepLSgZg8epOCOmS0=;
 b=yjF4baQJ61AwhaxMj/TozFZynUYeSVRFoXkVY1JSiy+R5lMWVv0BlGu/+In09HpSk+Ninf02+5sYvxiIr9mxgzQiXg8IRCQsSXIwh3hCUM8j9pRKzFxBaiEObGHrmteNOc0PS4ZeWz8Sru/IemcmWeihplnPITuLxpA+DXWi8fnjHRvCz5o8cnzr+UwozyOI9E3YvSCte8rZ7NGxAGO4zupYSKJa2Fk6jSGctWpos8lx+o2k78fPWCPZvUW2KsMLKoYhwWqOa+u42Ly0+8f5i8SDv+Ydns35ntTsmUt6L7HcpoP99T43M8zKeh3IYj3iNdBHjHTQkaQ6wH1/CHYAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY1pPr3g9hILywVeOKx0c6TDeXbepLSgZg8epOCOmS0=;
 b=V8YT1381MQC1yZHJJqmr1K/z4koxiOMOEdaoxt+mf08Zk+o9JTHx1cvMts/K01iOisP55i9aT9ewOJAi4ByhvBjucb1kTuNwSsoWnfxSK7mAS7U+e9ui5R2H67rfTTYRHYheB9Dap1cFbEiMmcfE9CJUc7sTZa/9hPVVUW64ON49GC1e3mGmQnaM/xVhidBZ2H7nOMyc22GO36ua0KDrm+gdmj/TMJ2LtnrQtfiKSJJyrPvkayIANoyy2buzsLiasA3UOadM89Bb3FVWFFZ0aHQud2fVaBD9l4mKbN23ODsUEG5aFUq3EWX+dln1/Bag7kfRglFy61kiTM5p3cxUqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:27:47 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Mon, 24 Aug 2026
 15:27:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 00:27:44 +0900
Message-Id: <DKXA39O66KKG.2PPLT14FCZNRS@nvidia.com>
Cc: <git@younes.io>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: num: restrict bool conversion to unsigned
 Bounded
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
References: <20260822-fix-rust-bounded-from-bool-submit-v4-1-aa780bfe7f30@younes.io> <CANiq72mOfR33s4y+Ueivd5NrC5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com>
In-Reply-To: <CANiq72mOfR33s4y+Ueivd5NrC5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com>
X-ClientProxiedBy: TY4P286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ5PPFB332093D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c77d0d7-e9fe-48c3-512e-08df01f4402b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yJ3hQMJX+asvrdNvv5dAoXIYeNKnKDFSeIa2T2IJ2Oi09huo5+Xnuljh36br9iAFR1jYdZ3mBAUupUddeAXs0YN1wUg/p6GAbooUToV0bcNMYsXvIKTVswM28U6rsUrM473jGTlX3efmIX5Xc1mSBIYhlWkZRKTlflSudb3Gn7jwE2ADmXRn3Q+DugK4+D3OdOl4d9pst9PvhIMfXlCQe8kMg+794dMFRiaGns6heAIpnxkLRar/u6R+LTI+O+eImmCne98nkrDsnltGrTtjXAMwMT/2pI4RC5NA3LFswKTPpSFoLWpOSDA48e05hMcpKWWI+di9Rz4m3uJ6nNFdNK+yRBj7yA22HlYDqW4MRBYGmz4aX/6L+I+Mkj4kfWJSh5qBz0u5CIY1zPtk56jGrcJSPOHsFkZz4AmO1EJCu273iN6mGfcOegdGzcIgtV0tdqSv57Z8OtWVLxMUsNi0xneewcFT1gSifffW4jocLae5FC2ngToo0bK2wIwAL126zCUHD9p4WtDhMQIt/dHHZ7DUlSJPdBhFjGGnKQ6oAMOdjqAYo2DjrQJF3gylt1QmvyYz22mg04l4P0rM28E6z0wqxKr/anYNGOgxM4x+OXuIAU0W1IMPq82bedLLkSbJL0yHquMLmxvMrcKZ8JadC01WCUKpr8F1+/Y6QYevBDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0IzakVqQ2hKUUFkYnZ0bml3WjBUcjlieDNnVTFxL1lETFRiVVRjQjRZNWNO?=
 =?utf-8?B?cTBIQXQ2QXhwM2RyckRML3JuZXlFZnJXZGd4MzAxWmlwbkRBdkZ1U2NsNFZC?=
 =?utf-8?B?U0hzNGlhaWFEN2J4MVllWmJlRktqYUZvOGJzWk1qS3RBdERqYzg1a2FoMDZI?=
 =?utf-8?B?VTZGSXlZV2J0cWRGcWdSejMvM0I3YStDMGN6N2JCUThjajJ2TlRzRlNObW5l?=
 =?utf-8?B?REdPU0FtR3QwK3p4ZEwxeFQzRHlPZGVIaWVpd25iYXVHZTBxdURoWjRoUmV1?=
 =?utf-8?B?M3hGdzcrM3d5ZTdVb1NveDVVT0M0bmxCY05oYi9EQU1tRHovYUVoaUlwOXpM?=
 =?utf-8?B?bmwxdlBsZG5CUTZlZ3Y5NnpENmtzZm9nWmpLUUtDZjdEKzhPWXhJY3k4VnlD?=
 =?utf-8?B?SHBiRHRVeWVmaFFzNnpDS1IyM2Zpa2QwNGIrTDVsWHJYMnFpRDI2ZnIxU2tW?=
 =?utf-8?B?MCtPWG9Ba0hPaER0aDh2Q1BiMFdkK0F3NWxxTjFqQmtBQmx6bHhDMTFUU0VZ?=
 =?utf-8?B?RkU3OWVTV2FlaExjbDhQV2tacVZIOVRhZno5K3h1N2laUFZrY0lmTnVKY0Vs?=
 =?utf-8?B?VHZFSjd3SURJOUkxaWZFamY3UEJVNSsrUDc4WmNVYnBQamN0ajhyajZJV2lV?=
 =?utf-8?B?UVNTZllyTFBxUDhKeFlTZ3NyUmgxd1FVYUMzWGJOa3ZBK3BvU3hvSU5HMDJS?=
 =?utf-8?B?NjVIdUdKYks3ZTBxQzhqNHNQN1pyQi9GNmFRdVZ5bGR5V0ZWaGNsYUdXL0FS?=
 =?utf-8?B?ZmdFNWorbzk2cERZWDRISW14ajh5bWRnNEViN290dHVHSmJzVVBRek1DbHRr?=
 =?utf-8?B?QnhSZlVsSmIySUZSVVQvT28vb2J5VFRXZ1E2dnkwbXdmVE5pNFFPaDl1R0dV?=
 =?utf-8?B?MVM2KzJGWU9Nd2hWMy9pN3R4amZ2SmZkMjQvdHBjamo5NmJ5WlJ0eCtiOVFM?=
 =?utf-8?B?aWl3S09VQVFtS29ZRWIrTzBDN085Tys1MUcrNFdJam1seHRNaGo0blYzY2pD?=
 =?utf-8?B?MHVoeE1CbmpTQmRaeUJHT1lXRE1XYjk3SzJjaUtnYlZRcHczUmVtR1ZCVVR3?=
 =?utf-8?B?V2ZabzBkS1JUcUp0NllObTA2Umg3WVdiVVdoZUVBQnRjVzlUZHdnc1pGOWZP?=
 =?utf-8?B?TWpmRGR0b2FjbnY2ZytDVFZyQUtEeHVVYmNuZ2NuRnI3S0NYbXhZNXNmWFlJ?=
 =?utf-8?B?UWtzQzBWbllXWjNndzl5UWNvZzZJR09DTkg1UlpEMUpMVFc0cFRwd29GbXg2?=
 =?utf-8?B?OTE4cko2dFkybkN1RktnVnpBTDNJQnkxeWJNU2E2TzFETkNBR214VGV5clpk?=
 =?utf-8?B?SzFTb2VMcExuRUp0OUU5RmR2Y3p4NEY0ek9tNk9nYVc0Q2JUNzVRdVErMzk4?=
 =?utf-8?B?TDU5RmpGR0RxSElxbktjOFF2ZVRYTlJQRTk5SW1odm9EQTBTdmptQkNLSkR3?=
 =?utf-8?B?bTgxUWE2Sk05blU0dm4rQ1psSVlTV3NGSTFBQ1JTVEZwZHMzVEpNNzQrS3l2?=
 =?utf-8?B?c09wNjRCOGU1d2wwQmt3bUh1eUs0Z2R2T3JNTkg2L0hwQld0VjZkOHVJSHlJ?=
 =?utf-8?B?elovTEpqc3E5UlJWNHZwSGRORTFZSllVcTFFamNUN0hySENvVHU5c0FUUWVC?=
 =?utf-8?B?VkgwTUVsUFIvNTdrSTlTa0QyYStMeWRGSVE2OGlGR1hrTXlTWXdyNjNRY21T?=
 =?utf-8?B?ZTRPTm9WS1RxdDdYZENra1RicWUxUUk3YzVxbTdHSzdKT0pDdDgzVlZlYXFl?=
 =?utf-8?B?cTZpWmhrbjdPNkxQcnhTREhIUjA2UFJkL0NHaEhlUVJGSGtSdCs3Qk9VSWJE?=
 =?utf-8?B?NmQ3Mzc4aC95WUNnaEIzQi9McGMrblZMY2FYVW1EM0pzT3VHTWo3WjAweFd3?=
 =?utf-8?B?SlZ0c0NmendVTlV0ZXBRZ3FyWk5OZ1FVaFZlMFFOdXMwbUJjQXBmRk5Fa0p4?=
 =?utf-8?B?cnJlODFxZldOWnB6bUV0SHdKY2Zva2pETzIvTkVJVmJFcWw1eTRxT29udkI5?=
 =?utf-8?B?YmF5WjZUdFFFNERTTTdocFJ1U3JYeUQxdFZlcnNRZ0g3THBTQ1VpWXVEekRT?=
 =?utf-8?B?ZXVtcDBPU3hjQVFrSnlVNHBmWk1PbDdRN0Z5RDhJd3cxdDZ3bHE1RkVHV3pW?=
 =?utf-8?B?QnRGbnp1MGIvdlNIUUxaQjduSUJsY1Ixckl1SHZtQ0gyQTVsMWhQdHVoRDNp?=
 =?utf-8?B?a2FSbEtlMzJhTVNJb2xBcXNndXdqMitDVmwvN2k2NFJ5U1p1UEcwZUxnRTZO?=
 =?utf-8?B?bmMvdVE5cjVEcUlUYm9kQUN4ejA5d0EvS2hBUXV1ZjRndm5kUE9tazc1SXlo?=
 =?utf-8?B?cGd2SVZlVGZ2Y2phM0ZKNUhSL3cwUXlubjc3ci9wQjk4VlJ4b1ljOUZxcDF0?=
 =?utf-8?Q?KqLwBH0zw6Oc9W+u3fn6Wf0aMl/4o9Szmi6RAffyuEre5?=
X-MS-Exchange-AntiSpam-MessageData-1: pFQLDJRs1j1xKg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c77d0d7-e9fe-48c3-512e-08df01f4402b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:27:47.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Y7fFAmW+ikjItjzXQ88dFHiahcuknHZmxfm0q9ElY4wfshhkVYk8Vot60BtM+pzDUqpXY+C6zNOP5C/QIEjtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3

On Mon Aug 24, 2026 at 8:32 PM JST, Miguel Ojeda wrote:
> On Sat, Aug 22, 2026 at 10:45=E2=80=AFAM Younes Akhouayri via B4 Relay
> <devnull+git.younes.io@kernel.org> wrote:
>>
>> From: Younes Akhouayri <git@younes.io>
>>
>> From<bool> turns true into 1. A signed Bounded with N =3D 1 can hold
>> only -1 and 0. The current implementation can therefore create a value
>> that breaks Bounded's invariant. Deref relies on that invariant and
>> calls unreachable_unchecked() when it is broken, so safe Rust can reach
>> undefined behavior.
>>
>> The other primitive conversions require the source and destination to
>> have the same signedness. Treat bool as an unsigned one-bit value and
>> allow conversions between bool and Bounded only when the backing integer
>> type is unsigned.
>>
>> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
>> Closes: https://lore.kernel.org/rust-for-linux/OzuVxu0--J-9@younes.io/
>> Cc: stable@vger.kernel.org
>> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
>> Assisted-by: Codex:gpt-5.6-sol
>> Signed-off-by: Younes Akhouayri <git@younes.io>
>
> Applied to `rust-fixes` -- thanks everyone!
>
> Reviewing this with an LLM made me notice that we should probably seal
> `Integer` or make it `unsafe`, because currently someone can
> buggily/maliciously implement it to still trigger UB regardless of
> this fix.

Good idea indeed. I'll send a patch to seal it, thanks for mentioning it!
