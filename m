Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC6471264;
	Tue,  1 Sep 2026 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254512; cv=fail; b=rp50ZrECbEmpqN1ivrdkVyxbM7XOU3nktKf6hDCll4ef+DM091LIjt04uQ4oAbK0InpSnDGZf8IlQS+KU5qIUSgnHNys3QRvddYuYdnLniPdiOCOWlrZSEXtAIOe2qqzZ0Ir7aNdkoY/UT7MQA7SnqVAAi2VdbLWE3nnRZF99Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254512; c=relaxed/simple;
	bh=TZECGMQRySISOlZBd/l5BaMJtxHko2rIPn+LxCk79sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R/cxO5fwsI6apquy0x3XwlF29Czu6eBjwfTbAUsYpm2a7XoyGfNvAYsMsxJB0A719snr2r4zyPIB8e1tNljual64I+1YQVyZo/3pyHE/uJHFmuzuwCXw/a0EqtWCcvMJAttJd2W7bEymUm6wPgsMvDPzBJhcQ+kejX5Kl6ao0As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gx2dvydl; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gx2dvydl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g14uikmOjqLpxoxldG52l0pp6jvXtUffgIvoex4r0bo1kzwRmjk4+dhb/PX2D+z+RqtnRyq6FRrA00syVKKfNOjatspVTHxArYJgK2SH3ci+TA5hro8pTgJ8Li5w57KTRuBmO61oHzQ1n911OeEA08cV+qFYLH8phlCwvusJW3ZbaobwsggiSesnMpv60lqLcIh7X2DPndvfY/bGcqiBtV630OlHnMogC5YuxaH35knXHY4xAi2NYJlZFWtrxve8XWdBsGGdVZbbaD/ou8jRX2o3mYkpWAjK2V0xw0uvVRyjA5JHA80Pxb9P8UWOgVkynxC5b81GtAlsY1bbJDkIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuUXvecxpcCKnI/PeZC5xhPvFEvBCEw1o1VZxcvxdrQ=;
 b=HfJbHpNbrfUKidqSrbor2qSAmCd2nmsrBTS+7kvTEedmoksnXHfg0xMu6QZk6yKJHQaPxoGGNEeB47m86oTbXHsBif20dgl9eFzxn6rcLdxSB/Cik7HDMPj3poCPjWZaJYX1L08AdtmLPsYnnpPRw2+yGhw+PBwCg/3vvcykkuKqTZW0lXjwfCHbOe0kqRkQpz9zHykusoBhLlNq0Sit61uGt3vuVE/bBxQbKW/d/22+pIaaHRMeP7hHlNJm9wlBFqolpBGelyGalNUVTdI9fGBuGH/vef73QhtUOT6V2VxSEJKLLPD+iD+f4CJ4ao004vWwZGOhElEhgPLrHRKs5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuUXvecxpcCKnI/PeZC5xhPvFEvBCEw1o1VZxcvxdrQ=;
 b=Gx2dvydltr9K1IquPITan4ZnGu8oflE5xKl2A8lCuKFHnF85uZw/Gdrrmgk47k8bsgrHZosxb82HCnJSoX3UMURkp3AG2NdgRk0BF374ZUPmZpeefDVtXhe+jaHSzKXH01waQ6qm6BskSGaXIOMksoaUPa35wCj7FpcUe2L0DjVVjSYF1XFRjyOlJx477UfdA4H0DCMKCHvpT9rcCTsyLcMypB7GWz4COxpnLZ4izCH1HVThTDOOvS1PR0K+QKfhOOqkkS0GKBSHU2UM6ktMqWafg5XHiPDP0m0Fw93prIH7Pd4JSUlRGFZSkMngmIAKFI6woMzktwucIbRIhbkBmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:21:44 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:21:44 +0000
Date: Tue, 1 Sep 2026 12:21:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Patrick McHardy <kaber@trash.net>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Subject: Re: [PATCH net v2 1/1] ipv4: fib: bound automatic table ID allocation
Message-ID: <20260901092135.GA3402711@shredder>
References: <cover.1788223735.git.zihanx@nebusec.ai>
 <7b6bd9bb1bf6bd43db18156f42b2d7f83789a673.1788223735.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b6bd9bb1bf6bd43db18156f42b2d7f83789a673.1788223735.git.zihanx@nebusec.ai>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4acda5-3100-443d-68dd-08df080a709c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pZieBCFp+J11eTpE35EFnWQMLjzYmQ0Jqz7Te9IPOMRJiYB3Z7sLaGDCGlX+WHd5BGRHN+JcQpx8yfqFmD1Kk+n+P7MQtxnycsckIQR6B55kPcBVXlp8YZSaeweBhrgfZBooX8et6Vjzo7LWa8Ft/KZ/kTPz8lGCNlW8mwtqTLTBDxV0DndCrWlAdE6Mfd0PfumVfr/wGwLY7UP3gVIeMol9VAJOe12ftgOebrTZiAU5m9xIZdViFY84yxAyqXwsnoBnQmIBijFtLFVgENnhFQPaCj9vnJUnPRqrwFKg9j9C0+qCCPPDw5G40ehFMqMPVSDB22siFxbfS7P6Mi8dHF+1WBt4tbRpy6CRKxrfhTIhQNGHeD6AuxBsfoKjEML0tInnIT6hEMHj/jo91ByTsSIf8NywxhkdxRtNQ8Ab/0WJZ1O/PQEVRsK0z3eEeyb8wrs7uy0ry+WQru9Ga0g+LU6p/MKjehpaqIKvwOAMH7LL7++lYD2VunIdLULOzsuK8aRfN+h+XQvrIoNmHnTpRPQYBSxQusqGW+LM7X4AxKdocm87GF4u402k75P9TQvAHPH1AA+cViBQIgwNBmTv2E+s8EJ3ckJgBTOLjLT0GTUcSqAye8skKT5/xrBG4uiFuCjrmkCP4YQg9meJ4Dj19WO5Isz8Az7OLNtVmna+LYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEy4LhAQ8TXb/MBhPM0jJU3hrqKSnolk+vx9uUKQm98irxm759ErVTEZRfFS?=
 =?us-ascii?Q?bVpxC5+mWCuZe7QXlS4QP7siGiH/FkJoYM+ZrANhqZcEOCc8elTKGEqqlJOM?=
 =?us-ascii?Q?QQEBm/xyQc/L/HtrBvFVP8iq/UFxtLagU9ADg9qpZcqlx1MOtB/klnFzxzXm?=
 =?us-ascii?Q?zC4L/vzKl/OD7MKS1ve+w3UyVBYc9pzauJAwsu3btiwSzF1duKf9B66s5ejg?=
 =?us-ascii?Q?QcYSzKlmSnMccXYPCyo2N2G+sFKsBjmaTIKINwe0+d9a3dGNQe18yU+vuLXI?=
 =?us-ascii?Q?uuLfNZfoRaw++5nrhIA0Gf+BaAf9LJisLBiemynfXHScddVPe2KGNjIdONHs?=
 =?us-ascii?Q?Td7MF1kxo9r6UpIT5pt84U3QF77QhMG7kE90BJGLj0Onq1x8NsEMYvQS5onA?=
 =?us-ascii?Q?fOR4zWqF7LggpJGkNar2w2ipyWLT7jQlD6iJWCdu3xOkKTD2DORRgVMZFvGw?=
 =?us-ascii?Q?5AvuflJx/RgaXEIZ1usmnv8UawaAKPpgnZwYaa14qysLZp5RnDmAxaTQBvlZ?=
 =?us-ascii?Q?aaWWXR7lfxYLq+HYYP4C3qKNLfQVF3GCp8gvs1u/X1DO9DYui0AM3saSGXhW?=
 =?us-ascii?Q?jGfIqa8LPtDYVaeaFyRY55isLhHcaAmR/XBreG3OtxOgFhA1+HlQ/eIJ1g/v?=
 =?us-ascii?Q?EiRRUuy9OgT12u0xjvROvEDjDL6oVJotSLLrLHkSeC8h53VImdJa4eDqUub6?=
 =?us-ascii?Q?zpUPo01lzJsXGiALQDyCYuxMK3lcJjbqULm3iefz1tJqSUfMU5RLdsm0gY2i?=
 =?us-ascii?Q?AGx7Cwjs3+mxErlU6FpM8JhMHgsgMXfnbBJzA8BI1HPNnApX1oX/vowbpM2W?=
 =?us-ascii?Q?7svMrZOksMQ2X6dOlgkOR3PKYFk/iBEnGBtD+Zr3OVp7bXqmWiUMTDtqDg1Y?=
 =?us-ascii?Q?I7gUa6m7A0ZnKeCkChRKlzbItQBvYNuaw55chnpMHosKJYgqsbLUzGHGn7Ax?=
 =?us-ascii?Q?30JmrnoZNp3b1fIZRA3HQpyrZIgIN7HMNeFTMtZlzmFUEGi3LQWlfZg4KYal?=
 =?us-ascii?Q?E6tp6/eNrHTaWRhagkq6MA3EyYFvsMM0f2o15Ywxr+6EgXc8x51scp1gHbOK?=
 =?us-ascii?Q?mDER1H+IenS9TwuVDIyQ+kTlomRSHQ5Q4wmlBJOQLFv8J/H4elnDpgVuFVaB?=
 =?us-ascii?Q?X8kaNXrMLc65/cTyHk/vURnl2t/ZwpCXeayK3KKuoubKKoUWMHcRqbvGGF7z?=
 =?us-ascii?Q?ayCo7Aznqs5ALCblpJEbkj5SfSPqUrzAZM1k8jMRkeHu1pfYcIb0ay1aoY1y?=
 =?us-ascii?Q?1+QnaCQAVTclyuRYCC6vka/I8AO61e+J0qn5E3NzvoEYO3Gv9z6id8RQ1oU0?=
 =?us-ascii?Q?RaKOPDoOvCtuerZpf18WjGbDA5bYRYA/1cT8NoeOEHqfF8RqY5KG20evgW68?=
 =?us-ascii?Q?Ue9bPK2FoS6UcadUO/mPYmpXFm1T+pBc3okwmaKPPJwrVg/qXHg+QtBu3PYt?=
 =?us-ascii?Q?0nU2C2kN7Q7fdZjxws6pFf8wGtISPZfw4/BdA1AMIJpKoXE5n5PDQAfpVr5N?=
 =?us-ascii?Q?JwtZiJTMb8727xF/M4tbL106o/Rd0YV0KguYeB7i7nx4fK5BCT1+XdyjA0SW?=
 =?us-ascii?Q?zGfPMc/+9Ag9zeUZLnCgLE7Oj0L3+gHMhq2sImNnFOafLT93DhRcZ9GynXbW?=
 =?us-ascii?Q?LsC+zCLoVq+XMBhdMJZtSyuoh8iRlORFJV45FNPRsshZPkCExdRQcrXXOvmj?=
 =?us-ascii?Q?OM13Rp7WnEDtOSAK8l8XaMjDOatLqhvSnuhvrU1ein+oZewdLXrmg4Lp6ukM?=
 =?us-ascii?Q?D4f811anVQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4acda5-3100-443d-68dd-08df080a709c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:21:44.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrpJVsw0mOK3M58BLMcfWljaNStcczwNSjU04PY4eT0VwG1DTJSRlzccMBZoKxS0NLRLmJwqvEAC5b1TYrRcyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335

On Tue, Sep 01, 2026 at 03:00:01AM +0000, Zihan Xi wrote:
> fib_empty_table() probes every table ID from 1 until it finds a
> free one.  IPv4 tables are stored in a 256-bucket hash table, so a
> dense set of IDs makes each probe walk a growing hash chain while
> RTNL is held.
> 
> Automatic table assignment ("ip rule ... table 0") is an IPv4-only
> legacy path.  Bound the automatically allocated ID to 4096 so the
> RTNL hold stays bounded, without changing lookups of explicitly
> specified table IDs.
> 
> Fixes: b801f54917b7 ("[NET]: Increate RT_TABLE_MAX to 2^32")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

The bots will likely complain about the change in behavior because the
commit message doesn't spell it out. I explained why I think it's safe
in [1]. In addition, I checked, and both NetworkManager [2] and systemd
[3][4] explicitly forbid "table 0".

[1] https://lore.kernel.org/all/20260831110647.GA3202627@shredder/
[2] https://github.com/NetworkManager/NetworkManager/blob/2e83a4082b223499c4f1bba156998d0171071967/src/libnm-core-impl/nm-setting-ip-config.c#L2747-L2758
[3] https://github.com/systemd/systemd/blob/9b62fd169e06d14cbab801c66f2f9c2006edb75c/src/network/networkd-route-util.c#L456-L457
[4] https://www.freedesktop.org/software/systemd/man/latest/systemd.network.html#Table=
