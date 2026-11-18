Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795013884;
	b=4m5TyyiMkTKpkMDVJS0HZOkG/gkS1TjR/jwN5rM+m6tgrXKnAZ2+Z0qh/Tp2kR8klgQm
	 cNHA7WE5AD7G53NWUAyTkr7PVY6Zazj0uY5lsi3xNJ2AVks47GaU592cJ71fQ9zvyJHae
	 4wqRqGBtiPDJd2jETbUJ98M0HsPKkRjlcQ7NhvKSJrGP/L+TOsy8qT0P+Gc3eAd9Gbekg
	 CS87zcSjKF6wevCAGou229rZImHrmlCCYCIes3nKiJB3+jQdCe7c2hNUSnEbWE9RO5JPm
	 p9C2a8a10c+TXrTNkiyNqKqcQn8iscqjYyZkZ3G8pPIhDKtyOILEGkLgmovX3f07URg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013884;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xH8hT6hmvPsuXwPKjN4ZsGx2tmhK8Ptd4za7nl+bCmg=;
	b=nk1xAWDZHdLiisWeHR/sgUwK+L+RIRA6hA9lbGLnZuF1ED1korLNAuMThHZUv49xjJR6
	 AnriFJe+dikIn8AyIOzgmh3/BCsTMakXvw+zCdlsIMU2m4xGf6tXy8ROHPkoI0mg1meUD
	 5v3dlXU2+fbSlgTT2wp9uJTlFocUZhtEXqg7KfgN/q80Z/fXRGvmACy5NsCIFVsMwaKKZ
	 WwcsompddAd9GZSfL71vbNjmeMP5hgrTu/Bj+ESDbH1iXDoCflYsdPxfYj7BAYRfZlsAQ
	 yRPhc1I+LUcXN9CemdL8hi+iEJoWDBdpmpmzDDJzACC/uk050qcWyxryJGn8lyuVAwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=0FiD0M1s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.74
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022074.outbound.protection.outlook.com [52.101.101.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66C606A31C;
	Wed, 18 Nov 2026 14:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC66C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=0FiD0M1s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjZ1I0O3plup44tpbOoF/DQ4xf7uN/uohI+kd24Qg31sdf+Jc4WyHoWjBUqK8nDzgiu8jCUrtYxUM76tDobuimF4anYDIURpZNtfi/80IQfFXE2xAKjrLo2xkaLbhee8PobTr2CHLbI3Be0eu8y9SQ7I+QJ0YZ9ZxdBhGcYTzesK8sluOmh4jsAnSgnGa+9s7/wfFOCaYNLgXXrP63M4Ua4YzKNu3lXli4XZ73gm4ZxkD47sq9Nnk7rUyELbm5c2S8mHOeYiwewA0T6jORJQxOkIianlyaAm6eTI0xFmvOa2otMDUo/wKcoO0RF22gGwVIGpmKx0wkmuuqD2qwKsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH8hT6hmvPsuXwPKjN4ZsGx2tmhK8Ptd4za7nl+bCmg=;
 b=NU2uT0R6h8jicussAx007RtfELgMxnr0l41qhMJmnpe41D76NDHW40JG76d2+9p/JN1mRs+t08jR4OIE0wrpq+BiPraECYsdRabfecIiasi4/vxVoSRgnDNejx7+aIMMpLE9GAJhgTHrgdIXuYJh/MXcfkH4A9HyaJ2MUD5c/CO9Oc3PArXID3jRF2TNVxufSh38zKhJEdYfj2GFTn1tOWRJauXi7kDMz/E2zR+0L59CFfICG5Syc9apYFT6qClLuxsfSAgRkxx99HtCw10+Yoo7+pCX4cP0eK38x+CZSmkV22zJow5EsoHCmj6ayrfGGBHwCqiVadW0mUxgXfi+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH8hT6hmvPsuXwPKjN4ZsGx2tmhK8Ptd4za7nl+bCmg=;
 b=0FiD0M1sh3l0kMahy1ai1pJxfdXFQxtGLVto2P3In0hRcmbUxRr4Zgcme3Y8RxHtK0lTOzaJgGtsEHqVPWXxhg6tsbJlk7rlkBweZKFjn3Tj+CUco3zsAALcFp8Mav1U+RHrKQ7kJac2jtkVdaPt1yfzvPGKgBtwm1cCZxU1wjA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB5653.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:58:00 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:58:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 14:57:59 +0000
Message-Id: <DMYFBCGHELDM.6TVK7VJBOGAZ@garyguo.net>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Georgios
 Androutsopoulos" <georgeandrout13@gmail.com>
Subject: Re: [PATCH v2 1/2] rust: str: tie Formatter to its backing buffer
From: "Gary Guo" <gary@garyguo.net>
To: <peder.bergan@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com>
 <20261117-formatter-lifetime-v2-1-e216d86ffb57@gmail.com>
In-Reply-To: <20261117-formatter-lifetime-v2-1-e216d86ffb57@gmail.com>
X-ClientProxiedBy: LO4P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::18) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: cb41abb8-b128-482b-e3a8-08df458456d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|261009223027099003|4143699003|56012099006|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	78wqxAuQP6dat6xlK/d3RO5F28ISVoN3PkI1Rx1yQEWhvIOGqN9TTQ2MrnYBDJNwyuM8T40rVGMxq7AieNgPQERe7NohbPkCuQMRhCQC7J5ZynX4FFCyZHvm9A69S2amzrQWVWXMdGHP/ZMaTrSdRc0z704ZYx044BZmvPjoRr9eKpgH81EaqIreQ5rycFQQ8S0ID/CSHl1L9osM8QtuPHcFN7t17A3fMiLjK7lWO5LaD/AhhqPtk+h3coaRFiYJtjD4Au1f8zWWXgTwHMP8LH/Lhmg/eBtbGNO57pmuxeSwHGXRG50FPzxoe50E9Ht+YHMQC9vo3mXqYf1qM1orvRgRbtDCcDyKbxbo0y4KJ+1atkCgpY4rflvS9apFtZohcP6Ip/jyaNuHgcFDiKUaQrO5Yrghj2iQyUCsVlVCeFDp1JuVQeJzWoG95vif6GDVIJ4jQN1R8/reNuMhyHHAsDNJYUYUkmcruNaqPCjcarR1jLxZ9aYAhGKNlZ4RHUXiDY9Vjd2/v8GkwqGUj2CklLMw3KfGHk2Ne3R7Ev0e6le1955krCVETobWZDwZC+XjtHUOGe/zNAwUDUCCpjD9GdbuycNkvIqV+nSXv7dy6Gf3o/9+F9YW5ORBq8zw2Tlgl0vn2gUAD3q3DWibvR0gIawTy56lPOAmcz55tS8CCGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Smx3QURmbW8yN21FNkNUZTNZVHZpNVJFdU9VVnIwWU5JcTJKYXF0QkZYVnp0?=
 =?utf-8?B?Y0FnRldrK0dZeWdYaFpoQkEzU0NKSWxYQXkrZUZIRzdsTkJQdXM1VC9IVVFw?=
 =?utf-8?B?MGpOQWVWZDRpM2V2VzZteFdQNjZFWDdkYlkvcEt3YmRzcXRRT05TaVV0S0lw?=
 =?utf-8?B?Z0E3WWNMcnl4dzdTek5ncDJZMGpTbjhBSkFwdmsrQkN1aGJIQzNxQWZraFM4?=
 =?utf-8?B?RFQ3d0hjdmJhTWQ4WTZEbS83Q0pXYUxMV3lFa1lCV1U0MzZBc285d3EzeVBs?=
 =?utf-8?B?emUzdDFrUEhHQUNCUWU5V1VWOFovT3ppdW5XeFd0dGRxNVdpdmQ0MEE3YUtv?=
 =?utf-8?B?Z01ralJYU2t1Z251N2lEaXJ6cTFPOVhVNkY2dkgvYlY1N3ZNS1RmS2pWMTNy?=
 =?utf-8?B?QVc4Z3pkenYwUU4vbjhYYXBDd2hDOUtENmNkTEI0c3dKdjR3a0psZ3EzWU9Z?=
 =?utf-8?B?azFxV2sveHV2b3BwZ0IwZURUR0tGNVUvcUQrcWRoeisrcjM0Z2FzQ2J3NFVh?=
 =?utf-8?B?ZjVHREIvSzJJdUJib3lsRkhkR2YyQjcrMk80M2NTSHJacTF1b0JqQ1hoNU94?=
 =?utf-8?B?L0NhakUzcDY0dXVZcUs3RkJqalBINlhhbDM4bUtYQlVnakVtRXo4S04wVE9v?=
 =?utf-8?B?L3FGMUI4WnMyNGdFWWh5VHBkWWg3eTFQcUxrQ3ZFanhzaU91QXMwZUptUTc2?=
 =?utf-8?B?TVArcm1qQ0hZaFNmR0pLK3gveXMveHduTXN1bEpoN2hhcCtkT0MzeSttMWlY?=
 =?utf-8?B?Vzl6QXdUei9paVFwR3hCcFBEMUxWYWlidHBKS3BjSFdoWEYwR1NDbFk1TkhM?=
 =?utf-8?B?Rk4yVlA0Rm9hU1J0N3oxT3VkNEw4aUpEY3lHK1RmeG1JelFpNWJGbmtNMnVS?=
 =?utf-8?B?b2VscU1zcUY2a1pGVHJwbncwRzBqVERnV3MxS3UvbHpGVHRTZ3Z5YWtBcGF1?=
 =?utf-8?B?cTRoVlhETjh1TUNPaDJIYTc0WXBGaWFudGdYNkMxVDdSdW1PNzZrbEpMVUUv?=
 =?utf-8?B?UVN4d1VZaDRwbTlBNmw0bTZhaFQydjIzOFlTNTlURWkvSHBlMWcvWVlTSDVW?=
 =?utf-8?B?WWhEalRXR0RBR1dkZEN6cEFHKzUrZWVtcE1BZkxoNC90WjZ0eitDVGZYNkVo?=
 =?utf-8?B?b0tTZHM5NjlSWGdKelk3MlV3SENZRTRpTXhRRVNRWGUrSlZCbnI5dzlkbllS?=
 =?utf-8?B?NUcvYy9rU0E2V3dmeWprZzR0a3RBajZRMVl0K28weHdOTE9wTTMxMzFwVUln?=
 =?utf-8?B?Y05id1FrZjRFQ1dNZ3pIS2VQc0RUSnJJMkdycFhtNkZZVFZaUFVxN3B2R0xR?=
 =?utf-8?B?UENjY3E1ZDBjM0JZQVhpTVY2cUtkSDlkaGJzTk42TXJzdlV3UlBnYWNjNTgw?=
 =?utf-8?B?NHI2TitRaTlKRS9sekhlZldWM0JKSVRuaXlncTlVQS9paE0rZGd3aTh3WS9H?=
 =?utf-8?B?Smc4VnF0YWNlSDZKcnFOOFBPTFBQT096dlJJdnpPeVRiL0NEUjZEUXVGK1RE?=
 =?utf-8?B?MWdOLzFHeVFuQVlUME1FQkhjZHVnd0FabnIxeU9qVmp1QjBGSUFDek5LN0lk?=
 =?utf-8?B?OVBrNFFOUVdva1lwaWRPdXZYZkFCZ1FhR2gzTU8rNys5R3RzbHF4RnFsWW1h?=
 =?utf-8?B?b2p2N29FTzJxci9JeEtDeWZUT2VKaExsaXRzUnZqQnl3L1Z3NnR6aUNxQ3Zn?=
 =?utf-8?B?bGFoS05LQUltY1E3dXc1YSsydDdYSE1Mbm9GTlFnOW40aFVoRUk2dlRhQXlH?=
 =?utf-8?B?dzhBK0hLbWlxU2V5YU9mQWFlU2Ivd1YvcmJiSUtiS25jWG9kN3h6NEVGTnoy?=
 =?utf-8?B?dGl6ZHE4NnRORlhPN3JnMk9ta3Q4TUZXSndqT1cvWWU0djRoT3c0SlJoZnJy?=
 =?utf-8?B?ZlZkalcyZ29jOTNaZ1FzblhXaFV5TjdDL3pyR0lBUEo3NzhDVm9WWG54QlVn?=
 =?utf-8?B?bkc1Q2RpVUY2aU9RQ3Z3dXpuSVVpOTRqZzF3RkljT2NERkZxZVdyVWppNzZx?=
 =?utf-8?B?YVB2Ylh2V1ZSNFN3ellQUGpXYm44WTRuTlZOakhBMXBkZFNSRTJxR3lCaHV6?=
 =?utf-8?B?WEsyTWxTcFFyNkwvaE5oaGtZMjlQZDBTUlVEVDFPVXBaN2ZBclFxcVpYNkEx?=
 =?utf-8?B?SHI5RmZ2N0F2UWlWYStMVUh0MlJiVWdsUHNONHJWc1l3QXl1ZXN1WDNYcUpR?=
 =?utf-8?B?SjdvOUNyd0c1citvR2pmYlBNQmpZRGUwNEg2dzhWeXgwVHlud1VwTy8vanpR?=
 =?utf-8?B?d241ZUc2TnBZVHlxaGRBNXpTT2lBN3JhdU11aVpNTWNqR2p2M1BpUkVqT25i?=
 =?utf-8?B?bDhqdkRlc1d6OE5xR0pvRk5hR3BiN3l1YnQ5aW9Na2p6MzJKdGx6QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cb41abb8-b128-482b-e3a8-08df458456d2
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:58:00.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3y0Rk36cRyY9J/+QLVzT+tSOkmMxD7GLRmGE6iMik18urulFWS0tjoOS+1q8Q4q6ixEh2RcsCfFq1kOWh5/Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5653

On Tue Nov 17, 2026 at 5:57 PM GMT, Peder Bergan via B4 Relay wrote:
> From: Peder Bergan <peder.bergan@gmail.com>
>=20
> Formatter::new() returns a Formatter whose lifetime is independent of the
> borrow of its backing buffer. Safe code can therefore drop the buffer and
> then write through the formatter, causing a use-after-free.
>=20
> Tie the buffer borrow to the formatter's lifetime so that the borrow
> checker rejects such callers and prevents overlapping mutable access.
>=20
> Fixes: 87482d6d9104 ("rust: str: allow `str::Formatter` to format into `&=
mut [u8]`.")
> Cc: stable@vger.kernel.org
> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1261
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/str.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

