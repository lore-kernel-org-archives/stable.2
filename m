Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4A4A23;
	Sun,  6 Sep 2026 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788653814; cv=fail; b=tu9OK+P7O88rJtD2y5FK7WENw4zviARiXJwGJLYmvEEkb+mzIroyqjX6joUSdnOVCbklCA5xGZnzIv/M1a4uJQwZJ20/sG0DsUkaCa/AXw829pKII3gsE0TkWsontP6OPvPI//ri7KS0pZ3OjLEqfL0heeNvUTTN/7GNPpvmjZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788653814; c=relaxed/simple;
	bh=Jk3GowhIvAEVolVpec1jgCNboMSLbmoQfFbHid/t2Po=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=t4NeDyEPJVzg2spvFbqYrW6DeVF4UwaWNM3eYqjFAfS+9hRGlnSo0FssdAnhHsM0HpUGwdelbcvlh1hVXaz1QHiKbIW9npsi36A/HyxQ8rdBTpCbaO6vJH7PFIhHLumLKbgvAWV5IblB74Uo927/Q71N1/UlRbRi8MKr9/vacgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kP5R37wR; arc=fail smtp.client-ip=52.101.85.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kP5R37wR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euhi2YMeC11y6Wn+yAq0wwl3KbT5rbVTd/zB4FCepy2Kd9jAe+WmHqhQYDgEqtFD/sjWp6dQHSjjRvPvTkIVr0PZYZGxtH+XVKH2+cXKtYWrjdglmCr1gXJnOxrivdwCSZjIOBtLYdNbnkGFI7SwvXLT+6Lt7kSJhNvrfjx/hhcAKGptKbDDv6K9URSloZa63Xi+xCW/Liq9shhMWhVya7tENjZanVwiYggfOGP4uru8dgs2L9fM+Y2OqappNaV7e7B/I6y1d/FZn6hBRkROzRbNE2+hlcozsIYHYxk5eDFegoysjjQb5aRQcZ/rJRxUWI2QAFEA+XgVZ+Eu9sDRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk3GowhIvAEVolVpec1jgCNboMSLbmoQfFbHid/t2Po=;
 b=sOr4OCfxFGl7zL+mMeZXQHiCAenPIihKjnBaKQXs3NfejISwa+1rw09PIGAKC6TcoEy4KGaRYr08KF0Pe5PI2uEMxDcjlbJaPg6KC1rolljZlxHipq4X8Pz5APpOZ2BkYTX+MSi7AtxdGCt8OgWY6OdJoj+MZI323agy1V61gGwU7S2z95VimOOXcKf38u5oimdjFDJVfkM9rIzPnEgAGJuCtwkWm3wJm7CuSTcMDIEEtCp8IThGkGqIgAUD18DrKHrjkKEgCWPQFMXwLSRmX3dSxFkPtfW42Fad/pa67xakQVwKcqQxVdj+iQN4sRn20YCC9k2hq6Md3qaEsb/ijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk3GowhIvAEVolVpec1jgCNboMSLbmoQfFbHid/t2Po=;
 b=kP5R37wR/khoFInsbdtg1q/WpscZvDP+hyf+m0ueGNP7DQK45fkU3IooCdbjxMBh0BHy39aLHxLl2f+6Ns3m7XAa5NhcmCs6onL5IdGqQEAsRttjKPZx4mDtFgyxVBXVXNUUYqjXt5nosAv0UFHcH3AL5ZA2m7/vMQxSP+oU+QjInuQG5M1ZtwUIUQuIU/0s///aEPAge6yYLgQucDAiCyQAdo6TnOun7l8XeEaFrO9tiG75rJkKYLeQhTfdab6iMVT65hHXlPOOTr6mummMZAgkAm7HK+HzDHmRsHVyuBFLMHe/Op2hPZe3KOrMhdQJUTOF7hxk5eXcQTXoSrKvjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sun, 6 Sep
 2026 00:16:47 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 00:16:47 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 09:16:44 +0900
Message-Id: <DL7SUU81HOAP.3CEKLJ6B6WBXV@nvidia.com>
Cc: <git@younes.io>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] rust: num: seal Integer
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Younes Akhouayri via B4 Relay" <devnull+git.younes.io@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260905-feature-rust-num-seal-integer-v2-1-f1311ffbe6e7@younes.io>
In-Reply-To: <20260905-feature-rust-num-seal-integer-v2-1-f1311ffbe6e7@younes.io>
X-ClientProxiedBy: TYCP286CA0210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 258b3bdb-e577-4696-fe8e-08df0bac23c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|10070799003|23010399003|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Th3NQ1500fr0j00PDHroGuljllAqktLGsMKMo4b8sKJvLSa/saq25iQdDGLCr9JTTxUFFKKRayfVFLIrKI3vwObsWY9Dn9Gq77Waz1vo5X9Vk4Cg8ziTlMdIMfP97iALYDhtwAUlQyBg+mNX9U9PGx6V5K6yWDccwxdOV6XAPWfNHLVQVP32vgNJPZ8hZaGg/nQL0reGXyZQa0FRwbZWRFdBUQY5eIYGdblpBtGNEnlCy2unbjGiRY3Hpl+LwOzmMCPues38Ko3jx9ieMhs/yrxoc3FtieyEYjhZeOUSLOSeBgK8oHqQejpQTYP1NQmknURQix4ctORB+7m5oM6sf7HDJ1WRsrA+qmM9TrY0+gmRa8Bq0IVzHk4zBTUibLziPR6IQ4q2qgJWI8HOgtSPiSyznvRTwmnAVAj+NN22/CL7BFmSzeRLbh8CATv8rkOSgu7dkYxQNBXmPf+cj2Jf9fGQz2IcokQ3oM9+3EQok5XQHg7LksP6SXOUWKbCAiLoENEYadHft5QvHVNXnTjAweSgEf+iEmwr1M61838YRJfI7/CdI/I3nfinykBsaUyz2lXGXEvfCIjUKlNGM4BDypESjUm7xcDS7SdzELhh331lPtiK/NaEtDqyAi3HXvh3oJdJ87PEjcmVHsUYkZe/ya+wAXbZSvkDa8nuH4zZ1Kw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlWNVZDNVVQN1Z3SGJseHNsdHpBcW54MFg4SE8wTllyYUFMM3UzYzZFdnpP?=
 =?utf-8?B?c1V1aktNZ0FXT0pUZzBIMTI0ajRORytoUzBpUWlhbk1EMHBtaWxOdWozUHVM?=
 =?utf-8?B?TWY5dDNLMHZzL0NLamM3RlMvVVJ3Y0lyUE1uQlBydmhUU2Q4ekJUWGJXWFlH?=
 =?utf-8?B?MXhPVTBYT3NXS0RkS09vZ01qUENJTXQ1S2QwanNkL083NVZoakJlU0VnUUtB?=
 =?utf-8?B?UjNTcDBVZTZvZzJHeGEwemRQR1d0T3lVRWQ0c3FYQXB0QVNXd1FaOHIzekN6?=
 =?utf-8?B?d01zN3BOdkFwWG1hNkh5dU5NWUZvWHgxR2w2OUFPSkRKQ0FlTUY5NEpwQmlS?=
 =?utf-8?B?SEZhZ1dSWjh4azBYbEdkb2k0M291TjFpaWZKNTZ0ejdzc0VTdlZOeE10Yy9H?=
 =?utf-8?B?d21RbDhYdzZ6bjVLNnZ5UitlQXp3YmRScUZQeDFYMGpMSFptQlgydFZrUzJJ?=
 =?utf-8?B?QVlkTVg5aWVEcHQ3cnliVWNWMEpBdThJVy94RStQNWcyTjRQaDFwbG1IYnZM?=
 =?utf-8?B?RFVrYm9OZ0t0OUFkWWlpYVVFcmIvMzVHWTJBd0pFRVFiM2ZFaUs5TkFLd09s?=
 =?utf-8?B?N1BnQmlzTjJ4QUZGdkRHWWlVM3pzeWlSRkQxSGN1V08zTG50Q2xvUkVKcTBi?=
 =?utf-8?B?NGEzTmxSNHRHVkhZYWVIdms5SWpDV2VadEhQekNZSVdaSkxSbVVOKzJUUGN6?=
 =?utf-8?B?dll1RElYZ3lza1VIQnk5MUVwREdtVWkwNTdXd2pZSHJDcXdSTHJBTFlqNEVa?=
 =?utf-8?B?bHREWDg2djZ0dVZKcXNsZE5MalVra1FQZVVUVWxZcUhnOU11Zzk2MGs2OW9E?=
 =?utf-8?B?cVVHVzdlS1lvZjBvSmJTUlEyOS9yOWc0dHA1SGFXY29PRGk2OHUwZG1pcTJz?=
 =?utf-8?B?TngweW5UZTBERmFHdVcxOHpTVXBmb2IxZDZPRVRZeTM0aFlOaWdad1RnaVl5?=
 =?utf-8?B?Tk5mTWxDWlluNVNCQWg4OVNXK0s4cWpkY1BrUDZNV3NxV1l1K1YwYnBXMG55?=
 =?utf-8?B?R3ZRQlFySTZjRG5MOWsxMTB6VGN2cGVJeHhuU3dqc2ZXZ2JrYUZ5VC9XSWMy?=
 =?utf-8?B?K2pCbHlZMTIwMFQ3Y0h2QVpTVEtUYitDZ0R5bDM1US9TUFNWS0xweExVU3o0?=
 =?utf-8?B?eHl1cVFRUkUxSCtiVUM2dWEwQnFqTTBiNVEyZlVEcjlwVVFBd1YzdzExbTgv?=
 =?utf-8?B?UmdhanFLWTYwdlp5N09kTFNVSG8vNzVYVFE2OURjOVFITkpKT1pTM1FiNWhn?=
 =?utf-8?B?bytHM25lZDNnU2ZRb2lWbFpjdXBQaGFzOURKMC9HNDNoWklkWGZxcDYwMjJ0?=
 =?utf-8?B?bUdKUkFDSzJUeThJUUJEUXlkSXJoZ2ZrTUltWE9SMTE1RldJbmRSdVNuMUtW?=
 =?utf-8?B?RU5CVmlSYWV0VjlDRmtpaUZlaGVXOTQyWjZpSUtPZElLVVpuOXRoSWhWdHFj?=
 =?utf-8?B?QzV0dmZ1UlZwVngzaDVMS05ZRWcxRTh2eXhxVHpCdHZUTldYbTcwWXFmdWF2?=
 =?utf-8?B?RTlpaEpyQVRvTnBKZlRDUSs0UzlCSEpTUFNYM2s0eTJva2FKQjJhQlBVYWs0?=
 =?utf-8?B?d3B3Rzl0eWxsQ1R0eUtKMWxyZmNtQ3hFT3poUi9xdnk3YXVsTXFEbXBvU3BC?=
 =?utf-8?B?RUJEU1dYSjJ1SzdjL1RYcnBqSkhaWW1JOTRaN0k4djBDMFltZ2JySnNWYTJ3?=
 =?utf-8?B?Qlgwb3FhZ2pWUVVmNU16VG8yY0hlN21QQVUwZlV0cVRzYkpiYVNtQmMxSE94?=
 =?utf-8?B?cUJGaDBoYzJYNy9EQXR2M01kN0dlS1ByWGp6MFY5bDVPWC9ScGlSS29rUW5W?=
 =?utf-8?B?TFhhNzlUQXlzS3BWTWJucXd2V3FXYmZEaitmRWNxekVVVHNXd2tTZHVVNmR4?=
 =?utf-8?B?UWlwaDNtWVhHdVRYbmJ5WDJUVGd6Mmp6RjFhNmdFcUMvOFhUOGU0NlZXU1Ev?=
 =?utf-8?B?dm5oZ1pSS25tZHdqbzI1RHpOV0Vrd0ZLTkp3ci9IU05Hbk1ON0NWMGNmY1dI?=
 =?utf-8?B?SWc5a0Fia0tpSVpDRFh5Tm80QjluZTR5c0Nuc0FaanV5STNKUnQvUnIxYmN5?=
 =?utf-8?B?cElFZ2N0ZG9oZm5mY2pnT1RwOG54WmNsbldTcXdyK3h0TXpvSnlINjZneEZr?=
 =?utf-8?B?MWhKY2FITG83MGVkRlpkbXM1b3VFV2JZQitpR1dFeHpuclUwZmxyRlV6YnEx?=
 =?utf-8?B?WW83d3d4YTV0K0tqZkRFUGRFamM0YWZoK09kbEVjTjk3L3U0VDlkYklodDZL?=
 =?utf-8?B?bUhvSzhadU1QUVpxZTR0YUxlNmw1bXNuR1ZtZDU2VC9wdDBrTzVvUEg4bUlx?=
 =?utf-8?B?bXNnVUpXdEZKVCtJcEY5L3FacjlPMnU2RDEvQXpxTTNZTGlJR3BwK2pLTlpu?=
 =?utf-8?Q?JD3ND9CXkp0PLtncHSM+Q8wuLB5ayvsRR3kZjicn+lxSR?=
X-MS-Exchange-AntiSpam-MessageData-1: eEfHM9urR2vLNw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258b3bdb-e577-4696-fe8e-08df0bac23c3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 00:16:47.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARWl6LsiiQXMWLHTpTeffG2B8bCsIbOWLX2E/ZPkdnFqFhGXtKlF5L0Lo+6ZuM3URq13ybacp7Ac1+u8v1GnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

On Sun Sep 6, 2026 at 12:16 AM JST, Younes Akhouayri via B4 Relay wrote:
> From: Younes Akhouayri <git@younes.io>
>
> Bounded relies on Integer implementations to describe primitive integer
> semantics correctly. In particular, it uses Integer::BITS and Signedness
> to justify unchecked operations.
>
> Integer is currently safe and externally implementable, so an
> implementation can violate those assumptions and make safe Bounded
> operations reach undefined behavior.
>
> For example, an Integer implementation for a u8 wrapper can report
> BITS =3D 16. Safe code can then cast a Bounded<u16, 9> containing 256
> to that wrapper. Its TryFrom<u16> implementation returns Err, and
> Bounded::cast() calls unwrap_unchecked() on it, causing undefined
> behavior.
>
> Seal Integer so only the primitive implementations provided by the
> kernel crate can satisfy it.
>
> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/rust-for-linux/CANiq72mOfR33s4y+Ueivd5NrC=
5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Younes Akhouayri <git@younes.io>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks for taking care of this!
