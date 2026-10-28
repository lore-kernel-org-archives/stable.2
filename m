Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793182021;
	b=ynfXvNZw18LEUAB3KLlrOLbLg+20IXaC7idr+v6nnNOUFeNLolRAL03lQXX21GxKWtiL
	 94/ew6ejOPE6VCxFnDGvj2O5M6qDyts1Zq8iLWqakWwbSoUR/SFQ7kJAjml3WNxmc+SHY
	 +WPUxCclMXxZ53aNDo+slA+jzYiP73AOupFvfqDxizVCpenMYv9SxNbZSSS+vZzZmKA9I
	 H4FkBfG7Y4Ijb2Rk/y0iiAF08YghjoIcDkk1Lsrl7ke7kdB2OOgIPzwzHnzJgQHnAYH/A
	 +F9pZ36HULSRnIvA8tgqUGMnU6IVl81cFALI3gG2Y27uhLVPimdHjqreERURZBCJT/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182021;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wbeNLxd6hM3TZZyVzhpmbvFjbEaztIRZCkU/fJZxW/4=;
	b=38ihSxXqIjGjZUcwrngGZ2aR47A8MMdoG1BaEmDGpdlUGaR4kOjLnbFTw6augGQkRHO0
	 AeB0IZaXRZY7VTqk2TSIPqLOQISVrIqeSIU2WV8gjvMTkqPKfDUTaao+kYzclCP2BG/5U
	 hqttA+I0+6KbBsKIXw4k0KdBahlxDn5K1wQ/cYKyIBGuFJxpvnihu6NOUnfrpq/dXq4T1
	 xPGGe9AK8kS43PyO+KCebtB9kJ2/UZOATCHIJbwgFY5M75bPsAv2WAyPavA+iuqLAvoWq
	 RecLlEdXkOdr+p0+6EWi1w45hM8axM4s/FFYmMUbUlIRoihGv0UEiZM62z9IXgY95Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GbQkng0k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.65
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08106606A31D;
	Wed, 28 Oct 2026 10:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08106606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GbQkng0k
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXfcIxouMJUNmiMKGn42PjoomX/9UBPY22l6ehSvxi3tFvxNzVqgKHf5xGt9Ih1sdOSoWKC4pH3NNkUQs2uCSghAKh23SmT5qfcNXuiWZQjs5kURoIHEKTV/nN7ozAMFXtfQzFOPKu0S09VvEGoKSCiqBiou3aauJUvEzrARKSaaYgXSbEkxyObxzUEgNSFaHpZ5YckxISHmcAAaVZUp4EPBb4cdV6M7Rpdf2FJj61IR62PNJmw7moGxKq91JvpA4DRDnZNURQSR1p5cdAgsunIE2E0QeQcWXIG4ZDULqMS17Mr/OL9ViPuqH8a02zaX0swKDBHpInJ2NPKTTedZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbeNLxd6hM3TZZyVzhpmbvFjbEaztIRZCkU/fJZxW/4=;
 b=eiAKZ1/YNi7ukYi0sFIMgZfPhEQonLjZSHgF27V4eoMmUOHFIAKuSIcUwdxVnNJ0mdzrxZrmbWrxvYpYlIUS0WH7eEhUW2dnEso3T8dTidCQ0jecDOwiJX+l1sDdQRaRqLf0Vb81+L/bOqE98vqZ4sJb8CxViJldMkY/CrE5cwBA7cnEfqLlOBuF85m4ejeVzfPkJuJSuIrDPU4Zds12ppaAtCn8FaIqmkaxHtINNYFTRmu3nHBZKjD4aBAO+Pzx5pIC8tKPkwpyH0ZgJGFkRMwSBluZH9mSbWwJz7CsIIYSADv8YzBdIOwSIfZhrY490XGqxxS98lg0JrhnC9VOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbeNLxd6hM3TZZyVzhpmbvFjbEaztIRZCkU/fJZxW/4=;
 b=GbQkng0k5UqOfeDEVJiQ7VsSfRMYpWI5zdnnAi18+HvOvVKd9XZ/5RH5JiB6bLABA8NG6TIxn9JJSjaqcevjzQOKIBHea5XmMDAUbsm1154y86+i1wTJBNXfbKQZBFuuNjoTUeELRKafyqF6FYdb66AQWiZ3WYRlYfV4+M1UPlxfmZIOWCUDngXWB7HFYwkOPv1FB2sXiy/2Em0bcybtukUsPNgngKNxszB8kprFzqXbjLlFMqOqp4X4JrQzfe6kFdQP/nBQ7GtXy6xiTEU7YzaNVWUNYS96kT7HDtPWQg+Vr9kj1XiDEe9ChN+cdJVzabsU1HIkNGchN93KDJS8mA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 10:06:54 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 10:06:54 +0000
Date: Wed, 28 Oct 2026 21:06:49 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vladimir Davydov <vdavydov.dev@gmail.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lukas Czerner <lczerner@redhat.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Stevens <stevensd@chromium.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	William Kucharski <william.kucharski@oracle.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"Pratyush Yadav (Google)" <pratyush@kernel.org>
Subject: Re: [PATCH v3 04/15] mm/shmem: honour F_SEAL_EXEC when an ACL is set
Message-ID: <auHJOSkggc-V9dVi@parvat>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
 <20261028-fixes_shmem-v3-4-4ce3baf2db4b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-fixes_shmem-v3-4-4ce3baf2db4b@kernel.org>
X-ClientProxiedBy: MEWP282CA0039.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1dc::20) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0a381c-0aee-4d47-0c0d-08df34db319f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|261022115727099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|11063799006|261026140227099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	p/8LXgXI6GiTT3YeAEbhgWQH6QmSXsFeoVyti5UUEqrfET5qC1w3OcuN9JTKDeFRdMwIwzYxe8jjJNRNLW4Jb6xT8xqq5/R49jOVE1cyn7bR7kR5Suw8Kiq8bV2YHj3fd2GjW8FJZ0uIfPfnfcrc5xoPCJRmAvyT9LApeFG1CGVlDhBBVY67lJawpOsXZDWK36+u0FQ6scMfZPywMFWu4p5+1iKW6Xs+037lTsWo0KN0tXULTJUpnV7k+oQM7kK38MG2thonP0NgxAHzQaxQIpiKQXre7rnp95CmHahyguYkNlF+dagLyQ4/gghJFY+5rfbCCrF0xfNcBRdZi2jLqzlEaFnAEFsy5Sq5JU1Ai1BoSHNzD43x3nP5X4yKaAexuBhtx5bcQXeRzfeUDvl+XhbfnXQxUGLn9QJFfC4p7ziECsOU5qJ1NpNHDgnwTqWchSSbPEo4w3u0F7cLmuxAVwrOG3YIbH7ORlG7mtsJUXan9F/gSSSeztu+XSag+0i2R9IHe9ki10iKAryQuSStZGLv0AAMOKgkO4Xs+RKmcdGsbxKWQiTxDKtIcUVN3594yiFMrDwbM1mWyL9we/FTeZn8Z1/E3HpfgE8zm9y6ehrePY4vSzAJiwKYm5wiYTyqiF2ZrF4/9WFOwPnbTEYhHbwqz3abD1n2qNF5VJOWzS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(261022115727099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(11063799006)(261026140227099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6V7H2AZ31X0DOZC0NalocoiudAxLK/XORTsl8Gpi8oe1ohvvic6ct2D3cYf?=
 =?us-ascii?Q?6Lar2vStMu9EjkOXJJEwFtHKNTVFsuzItEqekgrpvbwkK1OGy1lopZ4Tztl5?=
 =?us-ascii?Q?4nJcuuEuKTbhlPXeJkq4I1UxcDJJ/yKhOoYXyyBywvHKdkT+w3C5UCTjmcyc?=
 =?us-ascii?Q?ingnqT+XYsfzehluX9QAKnf6ACJNgtT7a9Ezd3hD30DPVrrHefh5akT2dVaE?=
 =?us-ascii?Q?SwuMk5HW/MFTWiLNQsHnLk58hrUSgskfx4yoU2FESVpGxHR7p0QqNePu/Yek?=
 =?us-ascii?Q?Ro/01uvEEynX5rXyo0Yn//CODsGr5VgGFWCemldGL7+idiDWWRvHHq/x+KTu?=
 =?us-ascii?Q?9Wxy5/VZk1QF4bv6tcodWPEdzDr7IcVIGOAyh4hY9x6kfR4NRM5/IMwkRQmD?=
 =?us-ascii?Q?mZ63rLYBrZjp67zsoly0ROcaUzLKz3/qg6dLAcrZEWoDHUn3fj0Kpg1LkqRu?=
 =?us-ascii?Q?W8iNTmMBwNWNrd6aD8Fh08rrMjXHrTt7YekXl5hiVi0WOooYq8epKe1hjnpM?=
 =?us-ascii?Q?XVNS3/POGPzLbGBhZGJLohwbN0PUavhwieZ72eqbQQri6hUI8YiUTrGCMkRN?=
 =?us-ascii?Q?P1rq8YoN4merYC4dAZBHfBqTFHy0kivLVZbBp425XXJEUuse60eAArtv0YNZ?=
 =?us-ascii?Q?/WOIAL3kr48QvQpa/dkb6WMQEvgg0JBwLkojb+wU4wgehkjAyaVQlhqKShZ4?=
 =?us-ascii?Q?BP9oBNz5N+ohpF1YW4nwycwoorsT1oKq242JbKqMc/kwga/+JWt0dxwta/eA?=
 =?us-ascii?Q?oUdW22zStNpZ8UttyVylqXGmZlH9YReax/T/M0AIxr7D21s2Xcyo+2wo0w4H?=
 =?us-ascii?Q?6Hu5b4DHAx+dU5uPHUmYjVRVXvlql/YLOC2TY1PB1cMHKnGGlaFxG5dJ2pkr?=
 =?us-ascii?Q?ilGPIP098T8SQnxc6g+aJDjsbWJHCNqHfBmQLCByT1b4BwWtgwUz7DBvDs6n?=
 =?us-ascii?Q?9+Uqe7OhY18oVHcBULK1Ixp2xRX6/YImk0RInA62GBfzqLQPaMQ6wsKg1swL?=
 =?us-ascii?Q?1UY2VTFI3lyOantfYnO2+SpCKEdcX3k8cFFNQ+SBGCChNwk6/xO+z17HLzRV?=
 =?us-ascii?Q?9zPRL4bKQ+CYNUYpyCpOjokUS8aV9Hki9XczHRk6jHwjJi1UE+O7FqUYZ91z?=
 =?us-ascii?Q?8o5XJBgjvY5dkwHSC03kKIt5wEpjZ7x6zfPLX5Nl9e/iULTe+zqiXs644Jhj?=
 =?us-ascii?Q?KZ9SDBn2LrjzLHLIeZRjNMXMaYOhjfEKioYXNaUyA/9tUyoXRnZgo7DJDQkf?=
 =?us-ascii?Q?h+izdG0Gjzm6DkJQIXt0BKSrDUrFF9x3EjgOzwsxZsca49c4JJpeLItEMyi6?=
 =?us-ascii?Q?If7k6Bu/Cm99v1tdZpvEHvYSEmsY4Pq8DJRsFSYdZ3gH8LamVjNAshkhOMFO?=
 =?us-ascii?Q?bgAewi/wf8rmxdO0uUxMfxOoYG5cPxdVeis/Wmqfe42WKwODPgc15+cjmDYU?=
 =?us-ascii?Q?gJ7I8HMfD+Sxuk3dbY16t/OciwSUa772oVksbBjHfhxc4AkGEpJqvSHDSqDv?=
 =?us-ascii?Q?NCbFZoyEiUpP6mo3Pog1gvm3Jr2rezF7gnROdw7A/VflQiElAVnYNHZP5dln?=
 =?us-ascii?Q?yw8pf0DN4cMryp0CG47K4PMX+fiRaLtVN+UqhkggRocZ7rZAWJCdy6VCw1T3?=
 =?us-ascii?Q?ycidxmuGXG5uTN1ph0cUpC12HAym/SKJYY0IW60WTf+Rb77/giDXKEFG4opQ?=
 =?us-ascii?Q?xmMJjLsmOL7B0Bom4M0MX/5WqziXK5KcNOKn9sYRoPIMj1hkw1auDyqZLCsS?=
 =?us-ascii?Q?t4pOsVGfeQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0a381c-0aee-4d47-0c0d-08df34db319f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:06:54.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FoH2Il40ZGpAYflG9/G5jSn5dfhSCAozTXUnkvNBcPhXjKFqi/xbWCrOaZqCyfo1V1xs1bh1Qfe2laGdlAw2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

On Wed, Oct 28, 2026 at 10:55:02AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> The owner of a memfd sealed with F_SEAL_EXEC can still change its
> execute bits by setting a POSIX access ACL. With CONFIG_TMPFS_POSIX_ACL,
> this lets an unprivileged owner make a non-executable memfd executable,
> bypassing vm.memfd_noexec=2.
> 
> simple_set_acl() updates i_mode directly, bypassing the seal check in
> shmem_setattr(). Add shmem_set_acl() to check the resulting mode. Share
> the F_SEAL_EXEC check with shmem_setattr() using memfd_check_seals_mode()
> in include/linux/memfd.h.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Acked-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> [ david: use common helper; simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/linux/memfd.h |  9 +++++++++
>  mm/shmem.c            | 35 ++++++++++++++++++++++++++++++-----
>  2 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index c159e40e3f34..272479317cf1 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -2,10 +2,19 @@
>  #ifndef __LINUX_MEMFD_H
>  #define __LINUX_MEMFD_H
>  
> +#include <linux/fcntl.h>
>  #include <linux/file.h>
>  
>  #define MEMFD_ANON_NAME "[memfd]"
>  
> +static inline int memfd_check_seals_mode(unsigned int seals, umode_t old_mode,
> +		umode_t new_mode)
> +{
> +	if ((seals & F_SEAL_EXEC) && ((old_mode ^ new_mode) & 0111))
> +		return -EPERM;
> +	return 0;
> +}
> +
>  #ifdef CONFIG_MEMFD_CREATE
>  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
>  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index af21a89abb0f..e3e4bbbe1d80 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -77,6 +77,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
>  #include <linux/magic.h>
>  #include <linux/syscalls.h>
>  #include <linux/fcntl.h>
> +#include <linux/memfd.h>
>  #include <uapi/linux/memfd.h>
>  #include <linux/rmap.h>
>  #include <linux/uuid.h>
> @@ -1546,10 +1547,11 @@ static int shmem_setattr(const struct mnt_idmap *idmap,
>  	if (error)
>  		return error;
>  
> -	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
> -		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
> -			return -EPERM;
> -		}
> +	if (attr->ia_valid & ATTR_MODE) {
> +		error = memfd_check_seals_mode(info->seals, inode->i_mode,
> +					       attr->ia_mode);
> +		if (error)
> +			return error;
>  	}
>  
>  	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
> @@ -5404,12 +5406,35 @@ static const struct file_operations shmem_file_operations = {
>  #endif
>  };
>  
> +#ifdef CONFIG_TMPFS_POSIX_ACL
> +static int shmem_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
> +		struct posix_acl *acl, int type)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	umode_t mode = inode->i_mode;
> +	int error;
> +
> +	if (type == ACL_TYPE_ACCESS) {
> +		error = posix_acl_equiv_mode(acl, &mode);
> +		if (error < 0)
> +			return error;
> +		error = memfd_check_seals_mode(SHMEM_I(inode)->seals,
> +					       inode->i_mode, mode);
> +		if (error)
> +			return error;
> +	}
> +	return simple_set_acl(idmap, dentry, acl, type);
> +}
> +#else
> +#define shmem_set_acl NULL
> +#endif
> +
>  static const struct inode_operations shmem_inode_operations = {
>  	.getattr	= shmem_getattr,
>  	.setattr	= shmem_setattr,
>  #ifdef CONFIG_TMPFS_XATTR
>  	.listxattr	= shmem_listxattr,
> -	.set_acl	= simple_set_acl,
> +	.set_acl	= shmem_set_acl,

If CONFIG_TMPFS_POSIX_ACL is not defined, do we want to set the set_acl
callback to NULL? Earlier it was simple_set_acl

>  	.fileattr_get	= shmem_fileattr_get,
>  	.fileattr_set	= shmem_fileattr_set,
>  #endif
> 
> -- 
> 2.43.0
> 
> 
