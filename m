Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CC38D688;
	Tue,  4 Aug 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851405; cv=fail; b=RNVvTTDcycUOufnjafbAAvFh5QiVFqfGgEJL0xoIaGz71UNU8QxDGP5ro432LWpZJjMzE5O0xJmSjkc9NEBSqlAB5HcJqcaZL2G/10xqsuNYfGxJCXZuzXKaRKAWfxbCZQAoy74DDe89vOGRQR4txnXbu6zhLyqW8euOf9gkwhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851405; c=relaxed/simple;
	bh=0FMRhoFpdhxL3blb5iPLjYPMtf7WWgslVAH0TPSm3EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XnspGQFq6mxJJWDLEczgLJ76XQ92oujxzoGP8F74maIeppqVZIjF9FcHE3qd9BYi2msNpYQOgg6U02nSY++pmKx5B7A7NBCnN3Z3P2UlVSZ8LvZ8OqhsEUG0OwHyHX6HjAmZKXFzXW+P8Zi4slm/oojkjeMxRHwSUeYCb1a0Km0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UtjIFzF8; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UtjIFzF8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUTsJ2Pe2MCg5YgJtO2lVA2L5hzTIVOMCFJHp2XDrOPTucC3Y2X6o1s+5M3i/6n71ldO5t2vCEfHEQokoOGNhyFfN/8O3ppvWsyJg3TF77L+5B6CKC/1rpQPEGfjAC3o0YTiqmnHRDcNzOT/s3ctVtNI0CAhCn2RG8wkE/jj2K9d6sWMUnK8VUTGXarwF2oPNJElGr+xqlDlDJ41DeY2tlnfQsZWJc2JztPGkzD9VFC70HJNL7g/nep6beMyA3OmvOCfGw4K7S1KK4DHmAvtf5WEiA8AHMrRgeVyPDG/K17Ywotl9i3lvzDPNggvnqIurRrqWLRusXZPeNiR2cXr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v40kviPLowqwJ0mhL2yxSzbtGIli3XEoFphcWLR/T4=;
 b=wVngUofuOFW3wiA1x076ToyJrJwK05iN2bPQjr+adef7RFRewp1m8l4zkbmudiehHhcVdCh+7Sw6ocbyINUOct8xTy2ViExOBTqvH+A5c29NSmOFYNXzWPTy4nX8wEt00wHW5DnnH+E09T4IE63DpGj9mNVC8GBzCSw00JOnSXgkXNIxd/LWpw1uFvqYHx7IN8K55gFiLJnk+r9H/h3s/dOyNgJWq+Mm50Rdpjapi/bxYi9t1rUixMP+wYw0E40mmC4i+9a7+lyiazQlCej42N/YZs3eMlG4OA8AmNKzp2gVDH488XTEFUeapEWrlysrInh9gibdzs7MJzob2UFaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v40kviPLowqwJ0mhL2yxSzbtGIli3XEoFphcWLR/T4=;
 b=UtjIFzF8nQ6I1D4NKolaGY9dxoNC+v3CXKFcTeLOb+1L5Xi/fHbs+Vb5VoisB151KvsokAEyhtEd/dZUSLIZ0Fqg9YDs8GUpBLBZgSW1bgq3ZS9AkBAzPSamD/xX6nq3GWFeT08xw3OWtuuTV1lbkWlp0DfKIhQdbqWaditLj7hKCIhi7ZC4MX7jDA0U8CUCTAUZpD/l36JFpL9sm79mrZmYLIJPhhnHDyZXemyts/4qZVPU0JDj5gfpZPgsn+BK0rc+tTCiVrjGOS4xoaGlYbiHFZqLmct6lu8MGMWl1nAh8H1KiMZQzm+smTMT4SOQHpNI8oErWXODQzRvnkHrDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 13:49:54 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 13:49:54 +0000
Date: Tue, 4 Aug 2026 16:49:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Lee <david.lee@trailofbits.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>, horms@kernel.org,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: prevent in6_dev_get() from resurrecting
 inet6_dev
Message-ID: <20260804134943.GA1121565@shredder>
References: <20260803122758.666112-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803122758.666112-1-david.lee@trailofbits.com>
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d10f472-c439-45f1-1fdb-08def22f4360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	n5eUWV/hEgg3dS+3tOkM7kqaGm7uf+ORDvtGsOoakmwWQri1swJjSsvylnGUwwcPyXtmnSJEP8AkgDUxKBFnt6rEMN78M1Ju8dc5CXiOTD2ZtvzolNkuuZyJGIY/8N6BZDmlz1/H0J3//jJ7Qf4cyEUVqPUsiq7HRBiXLY/kN3yqBQQy0vjowk5fuOpmz2jgqz/9uRleaDqrsXONtbwc2wKm/MEB7a1BMqiolzDffj/G1rNrPi+slZiZdcAvl7kFy2hIp6REixO5x0EHPdmH6aOku9IG8MGKfjcY7R37q0+28o/gjHx1DVSYq/R3FlQER6VHx/cgVexmWgzWsydf1TYcJqYS2XIyEG2ZKtOZRqVpFvedH8WrEvBcGTPA0i6RHBpZ4H49C1cQXQROvwdVBk+mO0S1bQKOXQ3T7Y8NAKS5TzKK0O2jwwleZNnFQWNGUxXH+XpzeBQp1bGciMnaZ1gP+ZpXhMaVIQVmvNceLSwnG1xVyMys+/EgFm8+O4hVkF/WfpldfJ/+rSe+6QxwY+NgcrQaLcx35fE9Tx2+16e92Awmq7PudODGqwlPZ9aY1K3uKUlCmWx+/TXXt4SI8pSabCMGX8JN4gtn2HPejjko4LLv1wYv5vCF42f3BL5dYkWBZcQpETq3NzjEHdDnKfr2bHBaWcGXxGfypV607kE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MTUAIUOz7iOFJpaak1uB0tzFiYfy4RjPumnBvHATWryb2GBW9ANjYOyrI3sf?=
 =?us-ascii?Q?3eQE5u7fdhkTEWNQr6QW4aTkHDBR9VZJ3DlcUXgZ2Kk7vrXfzDbIBqYa2hKO?=
 =?us-ascii?Q?8OVl+5GmT7Y50e87EO8IBltmMGca++R5MiViRQhhq6Dhe1VA0FS6jezqZNz/?=
 =?us-ascii?Q?9kti4ELYRyyE4RgJ07K56/UFGwyzNXXLHTef7L8Q1yL8RCjCDz0dmOQ0JaFH?=
 =?us-ascii?Q?QAxeWNuXLcyZszG93jUdT95X0CzgE2e7dOxbWQ6dehWkyNWP7dXEMUDHqaxe?=
 =?us-ascii?Q?QLPj942hM5E7wegj4hCbCuBxy/S7TSej5Dd1w3hSSP6izzadMuAaIy3nyJdE?=
 =?us-ascii?Q?nKITc8/ISAGdIvM0IdomMJN3xxveV900Te06AqVMfwBl4dtxR9U+MFNGf5Ny?=
 =?us-ascii?Q?/fu3J1M7Hs3ZHSbf3GBqUlEKrkk2LvtQNceTiX2Fuv2XV0dwfQ8xuT8giNE9?=
 =?us-ascii?Q?XUcC187S5PZSxvupRaEcX4Z+ls2z1hU3Pgya2Y1s7tL9S6donG/Wuia44TaP?=
 =?us-ascii?Q?97wlSAnNjg6VfOQjE8GqBmKr21COWSrBV92GJsBShbr7P6J/ifhTXFNl7UjX?=
 =?us-ascii?Q?4Fo8canTHOc+lZ5bs0NMTsx6IwS+SHS9nGK5g4a3G5qh4rayKEFjwdnKo6zm?=
 =?us-ascii?Q?BYTF9PldYwJye1ps7fH5tgQspkDAefg3NWCKPpI7E+YnJzYB0mTHaNO9ZK9/?=
 =?us-ascii?Q?6i1NWGTiqknEpoFAnuUGvr6du7dD/X0iMzcErgxCCpfjCBW/0x/GneQC7DjA?=
 =?us-ascii?Q?MfEDlv643TMLhNfRf4Xzr2U9+laqTMYP80ZP1sw3uLvhZtHw0MLEWAsOGhhk?=
 =?us-ascii?Q?JtKfL/91UpwnfpX14cXWAta3KSoIBXV/P/laaeQMnm/uNumnT4Hca0pD+uNt?=
 =?us-ascii?Q?mKrMVTMHJrrgbG0u7p7jT+a7FBVDB4hCz4YvqunJnCVjFxDZT1uaorfLsCi1?=
 =?us-ascii?Q?YolE9MtpY3Z6/R0vmCejdhz/TCskGZqCwSINvoHa/Rwt0/KGdMlJIDD7GCpP?=
 =?us-ascii?Q?aqs2WvF52HRMJ7xOt8XOOKjkQQrKjdrDrtQ0CSnByTMJ0bPuItFu7P3tPD0p?=
 =?us-ascii?Q?Q429nwc0IGeR37/IbBGL7UoYbk1NJVD4Z9C8xV6eWy/2av87JptTOh0DYxAp?=
 =?us-ascii?Q?h4Xb7USeO3ypod+AZj7bmGGe11E1NqP9bs2OZrRDaWvSIShSgWoksF+uR2/i?=
 =?us-ascii?Q?gF4WsccQ7uFv/fBWyMRMytuVHPr/km37qkquP0zu8s/iUwScy0/GEdPDwiOJ?=
 =?us-ascii?Q?3liIVooBL192UT0RAjEJsSW7mP88c/uuQ1MdRN0x/Aq8kzzqw5Kx1AP4lE97?=
 =?us-ascii?Q?OSW5sztvFxdV8MWS2fodRgz6WE+z9sAwtKqwC7VMIZIOdNQziF17afhvoQXz?=
 =?us-ascii?Q?Oix6LTIuUZ4lqdU/aXoU5+0HlTX9MI/PajAKrxuH48AI1/Dk0f0+mBU9HIRL?=
 =?us-ascii?Q?FF50y3iNBOaAkPQyjS2gxyXPiwc6cyc4v5gJNjgHvLQXEKcx9p7KcUpZOD/S?=
 =?us-ascii?Q?2MZCuUDNjntBwPLTwsi2FcxiDGDmcdQEF/ChCjgxQhhPx3uup7qNuXDFfkLr?=
 =?us-ascii?Q?lzQCOdF4uSij+yjmpEpyjTV8t30V/sGwD/YA4XZXUrsT/DJlbQaKEI/2sw1k?=
 =?us-ascii?Q?SvSw+ijKD9+9p0DSfb6jVoid4akEBe3IPRHA3hjQUat8RfwESfo4lvemV8IP?=
 =?us-ascii?Q?M4bvAzOYWtnDt5Z64B1DqdbQIBwVAiBKMJPkosnuCFah/nQg+TK1jgcZwXEH?=
 =?us-ascii?Q?thOhT66/HQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d10f472-c439-45f1-1fdb-08def22f4360
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:49:54.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7oBfs7yMkRO/oxx7rpXKBIcRYvWYCvY0ESakSu2ZfqEtp5nTVy+fwNCBj58DrQ+TyiYapiDfQdJrYRrdTQwhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122

On Mon, Aug 03, 2026 at 12:27:57PM +0000, David Lee wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> in6_dev_get() reads dev->ip6_ptr under RCU and then unconditionally
> increments its refcount. Device teardown can clear the pointer and drop
> the last reference between these operations. The increment then
> resurrects an object whose RCU free has already been queued, so callers
> can use it after it is freed.
> 
> Use refcount_inc_not_zero() and return NULL when the object has already
> reached zero. RCU keeps the memory accessible through the attempted
> reference acquisition, and a successful increment pins the object for
> the caller.
> 
> An independent run on the exact unpatched 6f5156d7a31a (v7.2-rc3)
> kernel reproduced the invalid reference acquisition as UID 1000:
> 
>   refcount_t: addition on 0; use-after-free.
>   ip6_mc_source+0xef4/0x17e0
> 
> It was followed by the corresponding reference underflow in
> ip6_mc_source(). The supplied trace from the same unpatched revision
> additionally shows the access after the RCU read-side section ends:
> 
>   BUG: KASAN: slab-use-after-free in mutex_lock+0x76/0xe0
>   Write of size 8 at addr ffff888015b50240 by task poc/1219
> 
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
> 
> Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
