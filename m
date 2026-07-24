Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12E3AFAE1;
	Fri, 24 Jul 2026 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924306; cv=fail; b=Y8dBqsc7MLIctfD3pOqYM0/FBOCBgFcjalN4j/yFB/ZDhhNm7uMEG4tWB5nUm34pLI3TIC1j+M+uNiHPjA9PsJ+fggP4RVHOwdfDuTgRxhm340us9eGv84TCxQ/FK24RXnMCnRCaWsPTKfy7NBW2jPtfcUthBmFRyvrfRyY3W/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924306; c=relaxed/simple;
	bh=33LCtK345jgZT/bmKi9yCS9bXZXjGxl+yntC99lQ/yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJxX9Yf2dX5buE3rbUwMKxXVrXMRMaG6rFXuVGyZA082S188upnxC6YFQAZ7icz70vBmAA2ZswcxHhwp0sYKQPH91RcEouAKP2rL4UEONAL/mDCZ77OU3t+ZMd2SpY17R7JTIXLJI8i5jNmIxKuUoaaM5ttlTkUxbxIGybDRUjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m5IcDtLi; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m5IcDtLi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC5llrqpRdWF5yM9iZmIEZvp16CstYBGl0r0VjannUmXLtkfHsd0guCjQARWCPGNEjqewjSWJXc2QuCbxiriNfPu2MB4LYDEsLTvKd+nEZDxChswmXoqunPWRkYgoX8z0Jio2UQK9FzH9A4chEnRInOtJvO28RqPWF6RaE7p4+Xhq5BwmhfkI5kr8Xsigjgzdk/i+ESPE4vtHXgsYzgdlpgqs9r27ZfqUaEdzmTCJenk5kLjMEZILTFQ+7dVcoHozJbot+nzaw73TW8+6T53AFtApfV/RbzPipILSv4B8Urz6O6WPW91fr2cFNJDjVZ2YA7Hm4JwACMk/7jlHLl1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISh1R4q0pOPmLijfzpS1RoODQuWGKhC4iBya/CTSUh0=;
 b=BLKvj4tzkROROuCDVp8pJJc+HmdHbVGinFwfO60J5N9Awc6cljphSSlgViK9bizmWhW1APkF9NFpUtYvBnl9uNPgPO3gRfZgcXXhoUe2K7IjPRp8lE69B9lujqBgNKvvHcpZ7UXRqevFvjPWxfprMEi2gN79qcxosktvPcTxlu1gxpG8EhUOe8KcTN7aMHajTWB+eDKTjabGBPnm1WPh+LOGLe6jHFYElmrSNFEkorfdqp0/dXHk1hfyk37iM2GKPbRI2fJX8ONTmsJPEPUKZvrEBl8oElbsoNQ/PI1Oo5MrZPFYD0H11ZE6vjAv4QcrQWMUEccsqliPGMGHJzbT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISh1R4q0pOPmLijfzpS1RoODQuWGKhC4iBya/CTSUh0=;
 b=m5IcDtLipv3SkrptY++gmyhsmA7V1kxib299gOPz99kqrQvyGdtqWNKkaG3DtDyU3LEk7kh0vTnLLYqJhaEuDCg+jeBRp6/CJp1XrdzpfnJ/Ye9IIgr1vgmB6YLecWyV9okYFdpYruQb8YCFQ1YEs2Sll1dqoPxVAi80TxyLaZf0SSWveUOhqGjtU8CIofjXcEVqN4aLx4WMEFVqEbtN+cYcXmvcO2la9i1zEpCQL/jMkCg2NANcs0rqpz77TB8fnFpqfxiQjX4vAJOZe/kg+zSomrBe1hLYnaeNJuhT7m+eCrVS4AfRut7yz43b8/ZwrelkicrAZ1oLTHiA4KR/rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 20:18:18 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 20:18:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Kairui Song <ryncsn@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>,
 syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com,
 stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] mm/huge_memory: Initialise workingset state before folio
 split
Date: Fri, 24 Jul 2026 16:18:16 -0400
X-Mailer: MailMate (3.0r7024)
Message-ID: <6449A238-AA0D-4EB0-8B78-2A669532AEE8@nvidia.com>
In-Reply-To: <20260724195244.3715130-1-matt@readmodwrite.com>
References: <20260724195244.3715130-1-matt@readmodwrite.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b2d60d-ac2d-4eb0-a36b-08dee9c0b34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eXMVcAUePOhSgm3OBzorJ5t/rWijhq5O3uofmr/HF0uQZThDa0nt1teoq8cXvl+cHA9q+ab017PJqDv1+ujAhzywIIIK/BrwZDoUGiGJ40WQvqusbkw4BX5p1Swwj7I2XFzp76QGHZL0wXRGWPYgpBUoMhrsJjeaxp1TPb2s48EsQ1cOyuqmkTbCN80mvJc6DXxinuMbANW+CO6tQuX1KEfKF0wzyGaNCUvgwIDiJaQNr+Sv+zhMR26TIYBWliJB4TsAJ8BzjndXsxMJ4xpG7OGR2ilx8L6n581uzEEkYozjLm/Rkjyx6TxfmgQGiTm9Oq6fUkbtxe9xPjzds6jfXaXM6aRIKtpr2LBc6nsw0D3ZGgM532BiGhImkAjHTZbNo05+IuV6QeQNTqJwOWzwkq21iGsr7aJm1HI5YUwe0HSg7DVRZZMNybHeeIrlV73sBe4v7Li5k+IR95/159sTW8w/XrBjyC8TNFf7EOJl8+OAZAerqeSSLOC3gYn+RaPvGov8HsoHMzRD0rrzunP/gLrLMjziNm1yUt7vgVSyNQGpCpMBQKTwNV0frcdbWB1NgrZUJMw/fndAQZJ+7AObm7Mj85fUPUHPlziZGqWZS7MD3sliiD8XvBkECCV7z8r7nauhEtESBJExo57ocdKJOD3s/SrVIkSy5TNcHTLw5Zw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cvMiXNpdMGOPkQdFIqCeRQAs0vCbwugUYfBvEFkc1YcdQ3AhTfjGJgDw2LKD?=
 =?us-ascii?Q?Lu3AeMt58TitK/JPADlTCYyCiVcq3a4LkisSRMIzlJhFB6ubB3m5q2+bSAI2?=
 =?us-ascii?Q?geXVNHFkGXktRoN43VyvkaqFhyrSA6TPBTXss6jKxkBXjn6HRNBXViNbELbo?=
 =?us-ascii?Q?gPWkibt7ifnvr3GvnuvggjpCK2MPk0ishiwCf7bN+pTZiCVhhqkq1g2dJKCb?=
 =?us-ascii?Q?1Vzn7vABWwMcRF56k4gtBblnwRMQomr8Cmff8YBgH5CVi+3jlXd8a3xGmCpX?=
 =?us-ascii?Q?USVBxFoLn3Q8SepsC9RuIXLZNe8sgGN1e9cyS00cuLJH/yayjOyfBL+4ovNs?=
 =?us-ascii?Q?ojdsnxdWa17dJZrY2JepuXKauZiVaFi4oli1ACw6cQE6qoGBL4K7datOxqur?=
 =?us-ascii?Q?JWwkqZ4393yUXsPkqSNS9G+oNh0+TKKm+ErJ6Szlba9z4AtfUfUfu1f3LaZo?=
 =?us-ascii?Q?Q20uxdVwRRCMaIYrl1QaPJdEWob+JpPjRuT9LdABC83EAnuNAod44T2tbHnJ?=
 =?us-ascii?Q?/OpOW8u1onBYNeUPpZPihmbl9u83SppGKEOB1fBTJ6zPxpLzK017hNTeb67d?=
 =?us-ascii?Q?EEdVdRsLv5JPx2kU2j/y1XIcDmDYE3echlxuITxtjzywrCOqnSPEBnCy/0VX?=
 =?us-ascii?Q?MnMQ+0IGzCsqdhvM/WYA9XkdeYuEyrIDi8z5gM9Y9XM5gHoEL6iIkQXnXkE5?=
 =?us-ascii?Q?2YnYpbaVh0XJJbPctH1/HHilVqS0AD7JbSNkuKQ2TdvGepMJlN2veJrQ+xnH?=
 =?us-ascii?Q?IyG0x/ZrzUwlNbAfuxDRcvnaHZY86TI4c4HJ0vkUuwmc2BQuSnHP2RM7fxt5?=
 =?us-ascii?Q?jBYnSLyVkvqvJz11GXwuMI7+B51iL8YWrcPViLMEYnOyjwYsAhS2Uo7XL/2m?=
 =?us-ascii?Q?AAjP/guH9oVgK07zjyCS0ylcsRKK2br6BTh0CluriLWqRIrjVa3SyxMy9hng?=
 =?us-ascii?Q?ufaN0zt0XsISPL0eVOQqAWLGXxyym4c8j4KlFrEwfkdfT3VX4BGa4LBLhNbc?=
 =?us-ascii?Q?AtMKfaMaCcuaqk1BR63SlPJg2MEoCy3NNs8nc88IcLoyiApsoCLRvSXrMW7v?=
 =?us-ascii?Q?ieg6HStgnhsQNtscB2Q2Ljn6lNY2vVDlJnV3uOEt6KBanT6CyBSdM7WJWdED?=
 =?us-ascii?Q?r3vB1cxFLt3d4HosVsCaQuJWWpsYvpw/GjWCQ4GowT2vwtn4s93YFoksXmkN?=
 =?us-ascii?Q?A/onMpKwbcc1NomK0HSKB4XeTTUaTrPxyshzxT4/2doaRMIlhkhNrelp0QuF?=
 =?us-ascii?Q?Es/SlAiWQwmTJEk41x4CsfVBhzx/y1VNMpAV7SbHHJWtpQ6pQ0DvI0kpGO0+?=
 =?us-ascii?Q?2czuhhXelJOr2IL/VB7g1RvAsUWvF9vqLxjz2qbabg3OQrxmhRbhIqLomyyU?=
 =?us-ascii?Q?9Ji16yCPeK4WLZwo3eNt20dn43V3521K61z6JVE3tmxM5/ebnyam497nDNjw?=
 =?us-ascii?Q?rfzdHDfU7eD4DSDVGulQ3bVzMCXQxYajUcXA17en3n7wsZ48jURb9aDAAF30?=
 =?us-ascii?Q?irU2Ab8kR6PCg3MjS196FO7QxlZqH98f/qVz++gqgJSieihvMcb2Isw/0Ax7?=
 =?us-ascii?Q?7DaErrRT+8NzEDSbqrtN5B3vT6x2D0bS/z5tow1/3Z0pIkkcNVphPl1ii+aL?=
 =?us-ascii?Q?wIn1GFnBLA5HR8RLEcYhDDUw9BjhOkTdU2c8YwDNMuoZodKwiNQ1yrL2VpPf?=
 =?us-ascii?Q?Ud9IqKacKjsGtMWvKgEHt6yVkq8v30sf8NYSWNrqSXChmyXT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b2d60d-ac2d-4eb0-a36b-08dee9c0b34e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:18:18.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxDVXjhujhDiIHhhiEaU8P2F5Q/ga2l6NWJPDSpcOijn84N5bucsjRxCt3Zt45kR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

On 24 Jul 2026, at 15:52, Matt Fleming wrote:

> From: Matt Fleming <mfleming@cloudflare.com>
>
> xas_try_split() adds __GFP_ACCOUNT for page-cache xa_nodes, but
> __folio_split() leaves the xa_state's xa_lru unset. That lets a live,

But mapping_set_update() is not required for xas_split_alloc() and xas_sp=
lit(),
or at least nothing triggered for uniform split path. Why?

xas_split_alloc() uses
gfp =3D current_gfp_context(mapping_gfp_mask(mapping) & GFP_RECLAIM_MASK)=
,
whereas xas_try_split() starts with GFP_NOWAIT and follows xas_nomem()
by adding __GFP_ACCOUNT if XA_FLAGS_ACCOUNT is set.

Should xas_split_alloc() also take a gfp input and the caller gets
gfp the same way as xas_split_alloc()?

> memcg-charged xa_node exist without being linked into the mapping's
> shadow_nodes list_lru; when reclaim later walks the list_lru it trips
> VM_WARN_ON(!css_is_dying()).
>
> Use mapping_set_update() to install both the workingset update callback=

> and the shadow_nodes list_lru on the xa_state.
>
> Reported-by: syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc5b060ce82921a2fd500
> Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uni=
form) folio_split()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  mm/huge_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b5d1e9d4463d..12d0e0b14e83 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4033,7 +4033,8 @@ static int __folio_split(struct folio *folio, uns=
igned int new_order,
>  		gfp_t gfp;
>
>  		mapping =3D folio->mapping;
> -		min_order =3D mapping_min_folio_order(folio->mapping);
> +		mapping_set_update(&xas, mapping);
> +		min_order =3D mapping_min_folio_order(mapping);
>  		if (new_order < min_order) {
>  			ret =3D -EINVAL;
>  			goto out;
> -- =

> 2.43.0


Best Regards,
Yan, Zi
