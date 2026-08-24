Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04023002C8;
	Mon, 24 Aug 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787541379; cv=fail; b=Tj6br6I83wmFs9upAf4aKv13DjuvMRn6WrA9TKA/LA+fYrfvLjUO2s8HcSMMdNGYvYi54b4tPtXkCbWs5tt/bzAdUgLZD5Kt7rnkpp8copbFLZ+sUoaU21ZKT6ZjN+yYHEdS+fZZx3L3ALla1NE6TpZqyw/Aus1/QGXDImuLXe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787541379; c=relaxed/simple;
	bh=En2prekh/WRPPWKjGX+QmBKXStbKTMYE0rZnbTGLMMg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=ZTb0Ni4BBp5tya7Nydao3IqD0yhDocDxkRZHe5J2kUtmeq7Umx3skTyFI1QzCnAWcnP0JdF81Xw+Hezf499MOVdxgekx4IKKWgN8T9XXJK3Hs0DAUZQCwv6dHwqqB+fOS127AN9gYYZPcn4F58slEbfdT1I1VN7wcpJ9tlsyd2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FeoqPu7w; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FeoqPu7w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoWOtDgTXl3EuvzGSvclY62lfjmMIl6ht/mdH/sb/g+o7QFKSPVUV/S7hyCC8bD8u8u8oCGbdCgDWB5l7rVwp6IC0ANuhxQRw4SfdRvbxji/mvfwLwPfY5gOtsg2OUssrNeNGT7YAD9/E5PkOQ3Vce2iwBnwekovPTx3T0bYevOo5E5igRINlYPB9nug1vPJntlusVMjpeQa/uDfgKRX8FAM7uDuWX9d8DBNAmmr+vvaziqR3XQb/3MywmkfFXSPVblaZbLOyQoK7iQLMznNKZyFDhR5b9z9noQEAllTVPkB83fW3qa3orNWsi3XYmhtPEXu45KIAnaFXfl1mwUNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En2prekh/WRPPWKjGX+QmBKXStbKTMYE0rZnbTGLMMg=;
 b=HIwDpUqqenj1JuoR3LZhn7UnLUVNO/ZbS16mawGyS8XwQH/mWeR5wjhLDNXAReprR1oCzA1+aJU/VwUZFAX4v/xdPvUUM2WH5lEYaL/QUl/EEO+JJYJz4u9xuQ9y48I5VjtGaDeN1Q0+SNIwr2I20UO8KiW8HhajQWdHw8fRqp/xgegbIMrMINtR/bs1NZ/MjktYwJBLhMrhwcIqE7wfxH74hrsuv2VxXBZilAJft8BwqiNluY6y5rlLZ/A1/sht0RaWWNGgwyAoQ/0sGJltBobsqcjGJajD2eG8MC8tjTuGaamrqdd7ziKbcZkhYskRafdIRf9BaWxjI4MlgcHcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En2prekh/WRPPWKjGX+QmBKXStbKTMYE0rZnbTGLMMg=;
 b=FeoqPu7wZULQ6i+4mnhQ/lfnWLZiKSKihrI2V+S+h/v650Tb0ZJ8CkV5JltuHu3YPSArSw61CyuV7Wtidry5smDNURczhN2WnT3Y0/Kf6zmu7SM8kD8mQ+x62XNLNJVBPaAheMg3HmVaC7a9tryaRf8VXdpKpcZN00HqDkj/umbOkPhcgoLkkfRGGgGEQ2Q0J3fhSRw4Uw7z6fXTjHjmiVhKk7qjsbFdj0lOTBRGwBm17EtHuQ/bMnFlc59Ug7sryaWZYIiSvRsyZxsTsskxGKzFFxqxEWLvvET+ohGPp0o20u7sXltaS0PhNbSyIVA7ax39yRbie4D9GrNGnYfqVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:16:13 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Mon, 24 Aug 2026
 03:16:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 12:16:09 +0900
Message-Id: <DKWUJ4D1GOPO.BK9DSJBSWJPJ@nvidia.com>
Subject: Re: [PATCH v4] rust: num: restrict bool conversion to unsigned
 Bounded
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Younes Akhouayri via B4 Relay" <devnull+git.younes.io@kernel.org>
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
References: <20260822-fix-rust-bounded-from-bool-submit-v4-1-aa780bfe7f30@younes.io>
In-Reply-To: <20260822-fix-rust-bounded-from-bool-submit-v4-1-aa780bfe7f30@younes.io>
X-ClientProxiedBy: OS3P286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:201::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0991f9-d7c0-4d5f-e36c-08df018e0ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rDIA6ArJJ5myNOAbyEr3jga2FTWB2d/ja6YBd0GMAn8eI2zpYxUPrWaGl3ZSjVjFGV7+b9q/AvsDrjqxjd+6yPdltHqxKPyGEkQgII/KbvKle4TiTNz8vpWvjQUdR2YKVfYSAeNzLKdF2waNJTG9hNQfF4kkTmRUvXhFDCgE6Phn9bztpyU6XQmWjKDMJBrr8gRcSjmoeORTLOPDlIGvyrCNBSS16I/UrA8jwTAg0dWTvfN0tBs+WewPm60hGgHEGUSIGkJvWl6doY7iOJ0uXfsQTAuVfw/Y32wc0cV1ORBMXHNKzAG9TLv0B/UFssy6rfbpjRGWdWMuyWsfFT22IRzEd9AckUh1T+VOaGkKNyJ9q0tfEbAtA0hBmkQPGE4f/aCpZgXz1w4k+jKdfkDANfgauvCoalpb+yH4/RSNP9MogMhMYWNPZd8Z5SO8EsmdYllsjSgLtIu0OD8T4vCqUEYzr5VC2ZCUODhwh85HlARl+STuNfXpKzK0Uk87HyG0+IEy7TOPcLSksX7RrQB45huwXct2mLEiuvjA/HADczC5XlF82mU9FCFYM8Wz8pDE+Ut6SNU19//Vbin4AT0tXzqymWNtcm7S1kUGmBwRb5DDKTszEhWlODtJwYqKD7btH6xE6eqwVHGkweO6ilNvb8bze+a04fTdheLc6KPkv24=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkhNS05VVDh1akRsL1RTcStlVFY5R1pWNkY2SVhaSXlMcHBNaFh5YzF0K3Q2?=
 =?utf-8?B?bjF6K3Rxc3gyY1QwUm81MldyYmVjN2djVmp5eGJ3Q2lHM0Uyc04veENLQ1d3?=
 =?utf-8?B?WVlsczhleWhHWU1nbVZRckkzbXcxZVZScVREWkN2c0hHRkZOUmdpZVBzQzNF?=
 =?utf-8?B?b2J0N0wvUDk0OTVXZUpDejNKRjY3WFBCOWVPdkZ6eFAvUlE3bjNhQ01raFF4?=
 =?utf-8?B?Wlc3eWQwbFMwNzJLcXVScTVmU2VtdjNDOWtTaTRkTEFLRFhKbHd6T1RMazFP?=
 =?utf-8?B?U1VwdVpkWk1NUVZqbGFCbTY4cGUycVNtSHRDZzRDMllWMXNXRDlMdFFCV3FM?=
 =?utf-8?B?Y0M1TlEwUy9uQlVXRUhKdXFVNFNtenJnODA3cUJRYXlPNkJwZWZTcllBWHcr?=
 =?utf-8?B?SG05OVozM2t4R25FaTRGbjF3dTZuSGxtc0xDQ2M4bFl1WElQc1A1c0piczBy?=
 =?utf-8?B?QW9LQ1BGNU5oV2ZXRWNVVzAxaXdOZzFhR1dHZlA3ZlRhUnNPc3pNSm5IUmVl?=
 =?utf-8?B?ck1XQmhQNmJTcVFjNHlkMFY5U2c1bjJQOWI2VFFaOGVQTTVmTjl2VzVacWNT?=
 =?utf-8?B?Z3k4ZnpKRjFBclR4WmVsZE9keHJsL09yNVRTdDIzUmZLdlFsWUJPWFYyUkl2?=
 =?utf-8?B?YnZWMllQVmt0QU8zWUtYb1VqVjJPd0luZ2tialZiMWUrbTZibnZIcEVDU3hP?=
 =?utf-8?B?b0pNbGlLZmI3T3RKenBVL29MUWVDVWl1R2NDcGNjZllFaHZUT1VWd2pTOEJE?=
 =?utf-8?B?ZGdCKytpbVg3R0psQ01HbVFhTzB0L0ZCb24yQjV1MXBuR0pTNHJEU1JUc0F3?=
 =?utf-8?B?RlRqTE9mSjFnZmdYRmh6bmFIWjFzVGc4OUp4dmQ5TEFmNk9YaXVlTHRWMFpS?=
 =?utf-8?B?UWhDdWhwUkt6NVFLN0tJYlQ2ZHNxcVgyNEx3bTdScThTRzlITGdiOEdxSmp1?=
 =?utf-8?B?YWdwajdCZnFwL2lSUE1sMDQwZzZETGpmcU1aT3laNWRVdnFxTXJyckxYRkpP?=
 =?utf-8?B?WVlkSWFZTXk1eDJjb2tPYmFMbXJuUEpMMzlmSTUvQjdnVVE4b09VZFk5dEV5?=
 =?utf-8?B?dWtJVnY0K2FrNnc2V292NnFoR1Vvd2JOU1VBS3Jhai9lc2xmRVdXVFA5WDhU?=
 =?utf-8?B?L2o5dXo0dUtqd2txWUMzc3lNOE5oWFpWZFpTbVFuR3dvZDNUUlJ6WmVkazlV?=
 =?utf-8?B?NFFaMk5sc0FoQkJEeDRLSmZ1UjJCZjhZM04zSkZwakhNN1hTR2F1aXhWTkVs?=
 =?utf-8?B?MkRTVzg2aUYrbHc2L2M2ZWthcUJoQTR3eXg1OHF2TlNqNHpGSTkwMWVsejBM?=
 =?utf-8?B?WG5ZSGlvS1JkYUZWNDJ6ZUc5L2VPRmVNM2x5dTZWRHA3SHNiOUhRMENXSzAw?=
 =?utf-8?B?ZTlwK3FoZTJqcmhkK2dOa1F1WmphdUJwdGhpU2swWDdQSjNYaFA4MkxxLzkx?=
 =?utf-8?B?dzBlL2dxeTF1ejZxc1dEMHJURmdhNTdYeDkvSWI3emMrNTkzeXo2ZWFvR1VV?=
 =?utf-8?B?L1dwZWFrVjFueFQzM296VjZPMU5vWG5aSDJUWlFMSkVwd0ZQLzgzZmM0UTR6?=
 =?utf-8?B?ZVFFTzZXVXFscFJZZS9NOCt6TkI2ZThSVkRBZ3JDMG1RYjJuUG5NdEllUm01?=
 =?utf-8?B?WDZZZGZEcklYclNMTlRDenI3T05ucGtYZnUzTEJHdTVLc2xYdFhQbzdvL2li?=
 =?utf-8?B?VkNxODY1bGZZS3dCclZ0akxqUWRmQWlsS2JQdC85UEFzWUxIVWVOQ2RQN2gz?=
 =?utf-8?B?VWUrQVFnOTBkSHF2blVaMTA1empBbzEwcWVGMmJBeDVLNkFGZzZDY0gzU0tm?=
 =?utf-8?B?bkR5VERYY1p5bWJPRWRUV1QyRjNyZ2tGcGhLUDBNNWFjTS95ZTNNQ0xrdUoz?=
 =?utf-8?B?aThoTjNTSXlwUzFnOWVGUHkycHhQWW4xekFJejdYQkhNN1NFMUxaZFdXbFQw?=
 =?utf-8?B?UzlmbXduaTF5YzhGRThJU1h2N3ByZzR5SlBXckZpQnZCcDgvaEExdkp3cVpy?=
 =?utf-8?B?QzhPWHQ1em1IQzl1bG0wQWt1dDd5Q0x1UFhFZGZDOFoxZHRMZnFZc3FVc0N6?=
 =?utf-8?B?M2t2VFNXMmN4bm9lcmhVZURVUEN0ZXFnc1FOdWhIdGFLc1duWFBHRi8wMGo3?=
 =?utf-8?B?UkpZRnZhbVMxbTBKTFlRcTRvSCs0Y2VlMVRONkdtQzRIZ2UvcEw0aU9Uam9U?=
 =?utf-8?B?RjNIQXVvMlFmVzNWc2ZvWEtvUnZZZWtxU24vV1lGMW5DUHFHeVVTZm9wRGI4?=
 =?utf-8?B?TTQ4Uk4zYkRCREdYemxuNWtZQ3Zra2lmNDZBU3hDUldIYWNodGFlbytOWVE1?=
 =?utf-8?B?TVpmb3BGZTdYS2xKQmVJQVNmWXZJWEtjSzhFN21jTEJHZU1mN1BqSVJrazdp?=
 =?utf-8?Q?KSNRLi+5rPhLNzQiZ50r41dJrftya4BWOV4Gf+RdPbkfW?=
X-MS-Exchange-AntiSpam-MessageData-1: 4x8mkeEQkntXeQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0991f9-d7c0-4d5f-e36c-08df018e0ce5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:16:12.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEadOU5IhT6qh9hHuYIDJm3LieKyxuSEjsQKFfx24Oe0H0adwAv7KG/OKlYyOYWINrg6K8Rd5P9ZZdy0hjRzgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325

On Sat Aug 22, 2026 at 5:44 PM JST, Younes Akhouayri via B4 Relay wrote:
> From: Younes Akhouayri <git@younes.io>
>
> From<bool> turns true into 1. A signed Bounded with N =3D 1 can hold
> only -1 and 0. The current implementation can therefore create a value
> that breaks Bounded's invariant. Deref relies on that invariant and
> calls unreachable_unchecked() when it is broken, so safe Rust can reach
> undefined behavior.
>
> The other primitive conversions require the source and destination to
> have the same signedness. Treat bool as an unsigned one-bit value and
> allow conversions between bool and Bounded only when the backing integer
> type is unsigned.
>
> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
> Closes: https://lore.kernel.org/rust-for-linux/OzuVxu0--J-9@younes.io/
> Cc: stable@vger.kernel.org
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Younes Akhouayri <git@younes.io>

Thanks for this fix!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
