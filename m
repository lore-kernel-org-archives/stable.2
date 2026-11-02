Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608268;
	b=DTAJpdEo3oNoKMpLSFY48xB9UY3aDR6r+eUmF3BfMQLvf/gE5EUWnrAtSK1guAJWf/6D
	 Q8KYoCj4qB4jFyzZbXOxZwf1NI36gxgzGnqb3DEytikfsTQCKRbBVst+4//2XkHaISXxn
	 WORThAaeEPyzPLAul5QNwGraW3+1qPgGmPkOKlU3gTt3M1pq1617yUmLQk+SWaIE0ZgNE
	 74RQjFgLEaRLbpLTy5Wlk/H4Zeh0Qv0hvM4IkiE/HGBetgF4n5tKcW+SgSa5oruO/RTDq
	 AYvZ2pjpustbNSS6fpnb2nlmoBi9dDML6bXexkS+YJi1vZfheEn7Se3cNsYxf6kWaLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608268;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Jm9Cyqe6nUxWEur6UD/SSMblCTYK8JlCXoq18P2B2qk=;
	b=i/emmMqZZeyw+WyWxMYFRFUP0oilGpULjzFieNncM/+kFY0It3pEkzqhs3+j0v3Ll7mP
	 ioVHbpL1Ha2XUp8IVYvvLZWP+djg/NL/XmCqRhKtO/R0plcVzJidDuGw0Ln6cJm4leuPu
	 DhOFtPoQDXyenP6ZBABFP8bgic6P+MjsPRQ+VFRjgzYddlApc6dYBAhT2l7asw2lrgrXo
	 YAj6VM1lrDppicV3k/lIJ2CxHRwTluss+xeejh/Od+GosrKdWw1SqkY3fqoL9BcDmAVdl
	 7Dj+m+Q2lf8AGZmH+3T91b2Qt04YnO9j8RmP4SpzOnljbnfbSK23AOn+6w3C7XA9ETw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gfRtIBaB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.51
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E0606A324;
	Mon,  2 Nov 2026 08:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB7E0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gfRtIBaB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAEj1qH9OubmrBcszNfZ57EIc5x+KyD8879rixdxqK/Mc/q17onlpuqiHbiXNQ5/IJ12SDdxIVOBpjr5zO7nNP8s9DxM22dOZxKa2QEufnqTKSwRfb+2/0QRUs+XtpauJHyFPkduGrflEmtG4ZpZ51iNEmvV8oOIa3L9vvfNsnnTUa4+UFt2t5Bjxrz4D4Yc3vUAQrVpEdAXueoE3NLqfREy+ojXyegixHzk7UaN9eycNxzJV9b3X97igLJ9NsBonolXo2NF/jdI604bnihnjzaOPm7Lb06Q12qmfidcIFuhvW43E5SgSkN5Nol/x9yVl1c3rwMdU4u0ciNXvz+9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jm9Cyqe6nUxWEur6UD/SSMblCTYK8JlCXoq18P2B2qk=;
 b=CDxgHM2ThaLvM6Un7XKz+/5sTa1iBQDw9IO5EbyPcan7dNaqStXhQGvHuwkKYo6eP8Hzzl15Ze21ZVCwqN1X8NXe/fAPldMMr7NiicQAWR+rJAi+5cDZht+vrAobrvUTEi/9vI5k/7qgZJKfxex5JSJ5OlVKs1Ss3MU/Tj/Qu5da6jnSBwlTUWAYOB/CidEz695XcxDpYVdEcq5TK74PGO/gm9Sh+MeQvrlDnH9MtxxPuQYLD7XoLtQFgPWbqic2ISONHfr6G/Bxxveh/aQdugLG5dknnSqMNFXq4UyMNaXfEGKO5jdzyeJBXhcLko5ZCNCIde/L9cdJTnMXUxbbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm9Cyqe6nUxWEur6UD/SSMblCTYK8JlCXoq18P2B2qk=;
 b=gfRtIBaBAc7LU+a8hNO6lK8TYVsEQB+C4VzM8qTHNe4Gw/X1RXaGuPI9bm46OyjJjhen0UMK5O9oOe4BtBzrA9+36pPOn6To2pzeBMkhrmDEXk9A3k1m4HzeJk+0GeUTM79MA3RJqTRbbzK7nX/80zjYU0Vw/nDYJJM0bGGhaHHZwFzlVwwk4MjGOT3UigXjqKm8+liHdWVvY9SGFDM9JaIWJjXjHHIeXaOhumj6HOubueXRHQWnfAt4ABR6DNqyGuh64DRpJdDuDrkrR1Q3ZYvgYCuCgCG8UsgJF/5dLuOuQFD2kRgHwvlhibS69VIyZio/RspzWqXpqF95yuaNag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by LVUPR12MB999160.namprd12.prod.outlook.com (2603:10b6:408:3a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:31:02 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 08:31:00 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH 3/3] clk: tegra: dfll: Get the voltage step of range-based
 regulators
Date: Mon, 02 Nov 2026 17:30:56 +0900
Message-ID: <KWZwcX_KQpm3Ikd-qCly3w@nvidia.com>
In-Reply-To:
 <20261029-upstream-speedo-t114-v1-3-81457cc9d94c@tsv-stahl-riesa.de>
References:
 <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
 <20261029-upstream-speedo-t114-v1-3-81457cc9d94c@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OSTP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|LVUPR12MB999160:EE_
X-MS-Office365-Filtering-Correlation-Id: 2912b723-db95-4ee8-5304-08df38bba017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ccLN5a5uFME99fSU9+Bs1+AY8sb/iRoqTKKKv+ShtLu20nqfdYpPnyH3WXitlen2XgGBlnccOOKl+ffPgcMhM00ABuGSwxe85rAYWT7YpBZmhCseDG479yOB0jKrZtkN75WqI1hSmq2pXyFQk0UtmGtjtsG2GvXOBSEibc3bHyPqZEMj3OnWGxIIUFeZzSxN6UL5SOMy5vSmfvdZe2hKT3+ajogsDkN7QzTw6FiqUfvc0ZDqPV2ICO66k6JosmESPLSUWTGHEHeopTxlYFqqIFwwP9Ub8SAOtkawN56KNn72FtGkhsqSUIntbNCKSJRm/AqT7OICjOvRi1Q086pl+vcwOjbxCpLXvU8GyXdgMsSrOmBijZIMZ7jkDxHp9+Yoc5j+SODct1vvh+fBwhhEqhl7QuUW/RZmArsEqbd087es0d98McF4UV3uWZRhG/YDPO2kT076Hjwava1jS2tkOvWFRktkgOvvt60diTytfA5oTA0XVZvzMaoCpuvv9UWpakWBu84fFxhXSkqTX8ACiMOT4FzXew/+ad4iFWBqri9TzMOEoah4A6Z3aFqvZM1Q3+BRsg5Q0IL+1H9GTahsJrXH+Ml+rKgaGl3I190n5jSfBAiojdPQoc/Vr7Oua4VOrbxrysLF6UCAEZvhzzz+H5LJeoIQUui84sedAEljBZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1dCN3NWdHI5TjhFQ0dhcm1pYlBUMkVVQWZxb1dFOHc0OU1lbGRlOHk0TEtZ?=
 =?utf-8?B?QTJXR093MWdzNThCV290Qk1nUnM3VzlsM0dqZFlxeGpkcFUrdVVqSmZBNEhN?=
 =?utf-8?B?U3BEaWdad2lvemM4em52UmNtRVhlY0JJdCtwck40RVpDbmZxaVRmVTlkVG1p?=
 =?utf-8?B?b1ZxbUhyRktvNzkrUThCdzdsMDZMMVhHSisvRVVmYkNSWkc5TUwySGNaK1pK?=
 =?utf-8?B?QlJzelNlWFdPcWloTlBrdExNS0U0SnNKNG4rUHA5dlhjMW8wQ2ZRUGIvdEtU?=
 =?utf-8?B?U1FEemtqR1lIZlZVTTJ0Q0Z3WG9LeWRWRnhBWFNGZU5LVTkxSHFsV1hQbFYv?=
 =?utf-8?B?OGl2bEppeGNyWXBBb3RZaGZkeHkwMjY5eE9MeDVDSlVJQjRKS3lrMEFaT2dQ?=
 =?utf-8?B?NW1WZlJyaGN4NXlMKzBNSXNmUzNVQW9GUjg0eUFtcldENTZjbkY3Qk12aVl1?=
 =?utf-8?B?R0pVdzZjeFozNFV1cTJKd0ZDbFl3alZCcDZjUlo5aFNWN1FFbzNaN205SEdY?=
 =?utf-8?B?ekFiUVBCVm1hWXFCOWg1cFEySUhEZjRBUWczdnlIcmgvZUxVaGsvNEw1OWFa?=
 =?utf-8?B?ODdEdTNiOEw1bHhJekhsb3dyS2dSazNaQ3Fib1gvdWduOFJNVHlqWCtNeFJ5?=
 =?utf-8?B?NDBkVU9JTVplSndqaDBQWDhGUzViQnZCMXNqVlVDem9mUUlTMDZXNDZyYjZk?=
 =?utf-8?B?MnFkVU9BT2NJNnlVbjFQMHRuWTZkaURzRms2c2d2K3lKZWhoSVoyVUJSUzFr?=
 =?utf-8?B?QWxpazdORE9xTHhnUDJFazB5cE5Ec3owcWxBYlhpS2Y2RGtlVURkRkRFOGZI?=
 =?utf-8?B?WjB1REJCY0VTZHB5U1ZzT1RHaVFXcldsR3FPZmpkT3F5aDJ4eFBDMnBIVnZG?=
 =?utf-8?B?b2NhZG9nUDkwRm1jbkU4NkxXbXJwSXpOQUthSHo3N1VJc05HVDd1cDhtajBu?=
 =?utf-8?B?OWIrYk12S0xwR3RtS040aUlidUNhTmUwQ3FMa0poNUVmTUpFaTJGU3FSZkNs?=
 =?utf-8?B?NlZyZUJlSUo3WDcxMEdEYkd4YTRoTVFyMDFNZFNyTzl5R05NWUcwdzRXajFz?=
 =?utf-8?B?a3dwZVdpMDB2UnI1cCtjd0dRcDMvY2xDb3RKeXY5MkpjaXZtUHVIV1hVUi83?=
 =?utf-8?B?Ti9Ub0o3aEs0ZHluL09ZSHBReW5mZ3hnNERHK1lrZWZXMVVEVHI3dEFuTGdS?=
 =?utf-8?B?aWpMSjExcmJ3QnViV09YTm8vQWJYbnhNK1V3N3N6WEozUnVlMG1scDNHeXhI?=
 =?utf-8?B?d1p1cUVseWlSZ28wZ1ArQXB5TWI2M2h3YTZ4bWJkNFprNlA1cVpTWldmNjg2?=
 =?utf-8?B?eXorQWRSZk1BckgxY0pCdjh0MzZkRFB6M0VlWlRnbnVwby9vR0ZtUytYeTYy?=
 =?utf-8?B?VzAwOHFua0ltc2NPbDhXUGc0RXBpN2pFZlFwYVptdkREUGtabzIreGl4Z1dx?=
 =?utf-8?B?M2xDM2ovTStZK2JTTVN3L2lldmtYWnNQMUVZR2paOGhISGtaZVh5SHVId1Ja?=
 =?utf-8?B?WElqY0dGRlR4OHh2VCtmY2pQQk5oMkN0UHowd3g1NGhKMks5bHh3elJxMzZO?=
 =?utf-8?B?VFpMbVp2R1l2bjN1MDUvUFdDbGdMZHlQQXI5d0piTVhDc0E1akRDK2JETFA0?=
 =?utf-8?B?N2dKMDZFMlRqUm4rWmhrNHp2YnFkSVNVdFE2MW9va1pGU09FY0NhMVRQSHlZ?=
 =?utf-8?B?K2tNVlVud0l6KzhoSUhxSFVPQkdEcnhqTURKU0NHSUlHRXc2bFZCZnFkUmFI?=
 =?utf-8?B?VWRsU3Nid1RYWjdWd1Z2a2MvMFFKSm5BbnppN25FUTROV2RrTHRCVy9xaGVn?=
 =?utf-8?B?NUVxQ2dqdWdWeTRtN1BTRnZwL3hZcE0zNmJ2d04zNW5kbnJXNDN6YTNiNE83?=
 =?utf-8?B?YlJMMU9VclI5RmYwaFoxZFN5RzZNSUl6M3FsbnprVUJYMi9kRmFOTGRvTGNx?=
 =?utf-8?B?Uk10QWJrODFYUjBtVTBlY1hOUUlLdFZpZWx6TDJ3ekxLMEFYU2JvbGU5dmFj?=
 =?utf-8?B?eTlmZE54U29nSWpvalN6eEJlaHRTTVJRM09OR2hCTk5YMmJwaDJ2UXVrblg2?=
 =?utf-8?B?c01GbG9xL2ZnZU1ZdGN2aUlmTEtHRFlYRDU4QmVRdnMrUG9ydi9FYXhMYWJY?=
 =?utf-8?B?SU9HcTlqZkUwSzloYUwwVitqSkYyU2RUamRwQkcxNk9FQS9MMEw2RU55ZHl6?=
 =?utf-8?B?ZXN4VjFNVEJZdzVsU0c2cjJTUTMvV3Z2MWgvb3E3NUExTVZMVVNSVjR4Qnlw?=
 =?utf-8?B?TEpNUUxKRTZqaDJnTnQ1azBlb1krUHlQUWVpQ0RZdCtva21oOGZtRU14d3pt?=
 =?utf-8?B?U2x3S3JnUnorQ3F4WjhyQXFTdDB6RTJ0azhLMFh2ekw3QkNyeXZGZzhvQ2kw?=
 =?utf-8?Q?Idf3PvlIXHzjKX8OnUI/7pzqwtfl32kf/6t08Lz+Okw3t?=
X-MS-Exchange-AntiSpam-MessageData-1: MmhuwQR+EAc04Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2912b723-db95-4ee8-5304-08df38bba017
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:31:00.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51ecqSFUmXZe6rQVnFt6+GUBmFsmaA9pZssoT3k/tHoYHABGyBblDad1PWLXtJOT4ehsBHxyi15xW184esqQTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999160

On Thursday, October 29, 2026 6:33=E2=80=AFPM Patrick Fischer via B4 Relay =
wrote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> get_alignment_from_regulator() takes the voltage step from
> regulator_get_linear_step(), which returns desc->uV_step. Regulators
> described by linear ranges, such as the SMPS of the TI Palmas PMIC,
> leave uV_step at 0.
>=20
> With a step of 0, round_cvb_voltage() returns 0 for every OPP, which is
> then clamped to min_millivolts, so all CPU OPPs get the same voltage.
> The I2C LUT is broken as well: find_vdd_map_entry_exact() and
> find_vdd_map_entry_min() divide by the step, and on ARMv7 with hardware
> division the result is 0, so selector 0 matches every voltage. The LUT
> ends up with a single entry and the DFLL never changes vdd_cpu.
>=20
> This affects boards that run the DFLL in I2C mode with a Palmas SMPS as
> vdd_cpu. In mainline these are the Xiaomi Mi Pad (Tegra124, since v6.19)
> and the Asus Transformer Pad TF701T (Tegra114, DFLL enabled for v7.4).
> The AS3722 and MAX77621 used by the other DFLL boards report a linear
> step, and the PWM mode does not use the regulator.
>=20
> On a Tegra Note 7 (Tegra114, TPS65913) all 16 CPU OPPs are at 1000 mV
> and vdd_cpu stays at the 1.10 V left by the bootloader. The CPU runs at
> about 1.34 GHz whatever cpufreq requests. With this patch the OPPs range
> from 1000 mV to 1270 mV, the LUT holds the 1000 mV to 1270 mV selectors
> and the DFLL follows cpufreq up to 1708.5 MHz.
>=20
> If the regulator reports no linear step, use the smallest step between
> the voltages that are usable on the board. Fail the probe if there is
> none instead of running with a step of 0.
>=20
> Fixes: b3cf8d069505 ("clk: tegra: dfll: CVB calculation alignment with th=
e regulator")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 26 ++++++++++++++++++++++++=
++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/teg=
ra/clk-tegra124-dfll-fcpu.c
> index 457a77c5bb62..5bdea4775076 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -642,6 +642,7 @@ static int get_alignment_from_regulator(struct device=
 *dev,
>  					 struct rail_alignment *align)
>  {
>  	struct regulator *reg =3D regulator_get(dev, "vdd-cpu");
> +	int i, n_voltages, uv, prev_uv =3D 0;
> =20
>  	if (IS_ERR(reg))
>  		return PTR_ERR(reg);
> @@ -649,8 +650,33 @@ static int get_alignment_from_regulator(struct devic=
e *dev,
>  	align->offset_uv =3D regulator_list_voltage(reg, 0);
>  	align->step_uv =3D regulator_get_linear_step(reg);
> =20
> +	/*
> +	 * Regulators described by linear ranges (e.g. the Palmas SMPS) don't
> +	 * report a linear step. Use the smallest step between the voltages
> +	 * that are usable on this board instead.
> +	 */
> +	if (!align->step_uv) {
> +		n_voltages =3D regulator_count_voltages(reg);
> +		for (i =3D 0; i < n_voltages; i++) {
> +			uv =3D regulator_list_voltage(reg, i);
> +			if (uv <=3D 0)
> +				continue;
> +
> +			if (prev_uv && uv > prev_uv &&
> +			    (!align->step_uv || uv - prev_uv < align->step_uv))
> +				align->step_uv =3D uv - prev_uv;
> +
> +			prev_uv =3D uv;
> +		}
> +	}
> +

I think this is a bit of a kludge that happens to work on Palmas but not=20
necessarily every other regulator. However, all Tegra114 devices there=20
will ever be already exist, so it's probably fine.

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

>  	regulator_put(reg);
> =20
> +	if (!align->step_uv) {
> +		dev_err(dev, "failed to get vdd-cpu voltage step\n");
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
> =20
>=20
> --=20
> 2.56.0
>=20
>=20
>=20




