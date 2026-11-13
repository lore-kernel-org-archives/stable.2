Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587464;
	b=gehc+uzbni2XCUd+4l2ik72YfsNPVCRErwh6dWY6ERao9dV56iiGAOOXpwftFdSl7pQq
	 cciuMRg1N2viZhHjlj96lGCVX3ovYv9w6Z5weriKqVeKWBlIoZCd55tGag4moBi+RlTXq
	 o8+ON7nuWpQp9Q3ilNMt8t6Lgr+6tlYRuzB+Xgkeka7XkFvZQrFmfpOvthTzxQRPaedKX
	 T0T5XRj+qM9Diya7Sqwnp/P3L03L0SDf+2nEHmmAqeIBnSXL4288BIg1UBzKFjreVT33V
	 j81aeJkCUWqe5ivKuqbaD9B37UvXPZmVtgi7zjYG8SqThUYBU4MIe5U/VSFEyuF76pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587464;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-MS-Reactions:X-ClientProxiedBy:
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
	bh=C+eP2p/jFbt3q2vin6cDUhpTo/5vGHuwvOSP6Yln2Y0=;
	b=H3y/gNyCZOMuXcbiSDK5jsh+UkWsg/FekkvhNrodUVs8QSJcRklM2UeyvukEAyk0kAku
	 wqla3vrfj+8lRTH/jkmzHVjfLlsA/5D8fxsEMiBp+jxUePCI2bXBAi2ViKnwvXM4Y7Hys
	 38KNeMswye8Sjj3hVMRcHqGRVXGZcHi/QtIJFuoK55Vo5uddrfAPgT+o8MQetdY6xgByP
	 mQN66XvfG9E87B49hThwyMam2pYjYoDc23/w9jDOjclTIsUKTT9Nh+pYSIr/r/D7/Sk+X
	 QuH6irgskvN8kwFoZFT2IoAmoEgY1NWZ7Zd8x+PpOv4024Y/7qGp74s2sTCx4A43e/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="S/PN8Jpw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.42
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C9606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A37C9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S/PN8Jpw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmVmovLSS0w7TMXFK4Meuf/WnhjlKUqSg6TG6H4IGsdRkr8bEDZzoghOmvEDirNEoUvgYVTy+BpcapabQBU6bY2/gnhsHXAQ3l4QdA9Mg9X9tzvcN0ZpBqYdE9J8B6QU45kpVFNZiQBc3GWyPqYt0ag3POoivx7bmbyVN+1Rm2DLSIMLPorg71fwPq95RLQThfxS2Ci2DES3EaKm5a2T/wCVLLOqmpx+tzDvPapDiwuDBhHZxK9C1AP2jSrgZp8G8bobrvZZBbq1WVwfvhFoxzeyjpeeEJBz4HfCocazWnIQbjc734qu+47GDEl9+Bjc0QiYr7aXwuimgXl0p+CXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+eP2p/jFbt3q2vin6cDUhpTo/5vGHuwvOSP6Yln2Y0=;
 b=lbLsTlGPFQtpHztrvBv6q5BdP3/X4XoF016cpg+XXhsQNU9D3sXNMKSqbGD2pNxe3v1BZtL1Z6P0SOoJt8WHPbXov+2QmXiInJH/dVNjnYLpCE0/FlYy/CMhjQyHCDvMfgvTjGMdWVn5XV91Q+eYEXaENmEwSwlG5zHaa6MwQeQpsNBcB+WzUU0mN4+aaL0hSi62mTRLaF4drSC61lh8yb9lO4HtZvjYgQuvFkhPU4JrXjeci7Juyl5MY0zg1Fr2uCDIxW+we+Q/2IwnsfiT233jsnO3uWaAfWdr6Hf5jRlcAm/q9chJMvLacKJ8E3uCnoJFfkXPin6oV6SDFSmtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+eP2p/jFbt3q2vin6cDUhpTo/5vGHuwvOSP6Yln2Y0=;
 b=S/PN8JpwVWf0b73Vwql3DKegvml/QdFc3yxivAcfaBKqYfgJsLnZ/iS0/GuIW1OlsxLw/FpydoluxXXwbKo1AoLOnuQgG/a0Tpq7Bx5a+Q5wdv9RRZwvEDIvJubUK6vGYAlG7DHC0aX+DO9ELnp0Quyn5DogtNj3vQbZOq9v+v6SRq4ZDmeg6bkgcfLNIqWJM/NgCZtQC4LiuJxBzDPwWR0Wi+AIH6+hBqd6K0I6JZoj1uaHn0eZ/k3BKY5DO0C6i49BFFmFleABoxo67uNOHDWPfcxvCklrLyQyQZFvhGdd93UbePc4WG+kYuBj9eAj75FJdjJxRBrdQTDUL2+Trg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 16:27:53 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 16:27:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
 syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com,
 Pedro Falcato <pfalcato@suse.de>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 6.12.y] khugepaged: fix readahead lock inversion in
 collapse_file()
Date: Fri, 13 Nov 2026 11:27:51 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <59D0C605-0343-4CA6-8529-C399AE8BBA9F@nvidia.com>
In-Reply-To: <20261111132605.88959-1-lance.yang@linux.dev>
References: <20261109200933-failed-6.12-eadce52a9ef6@kernel.org>
 <20261111132605.88959-1-lance.yang@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: MN2PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:208:23b::19) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa700ae-15b4-47b3-5aa0-08df41a310e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|261009223027099003|18002099003|261022075727099003|261021121427099003|56012099006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|10067099003|261022105027099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	I4Wtj/5eORHqB+SQEiTe0UcHtNOz62Po0cnzfBiie5/T/ECzNApxoSXHmM3dKtzUKcObImY0ytQsrR08n5voLKnJkdoyWj4GPzMZNhD97aEtKR7mQZMTf9hEC+GRmf/ctBlZzrze9QbWz0G9V4erGKZslJMUlu+rkLJme/NeTbI5Hf+9xT+hAqCLZVv60uAzjy9HYddDR6mg1N9jKUAjb+VnSRV6nNT3Lhc421hfrhjBnHIBnRxagLJgw0ybtPdVtIlDOrNUvFN8M8+0RTRvOB0NXPW4GsHQdBD0Y5MuI/kVrEMRUqbX/eYUL2f0jmZErtF6TotGFh4HTB0VtBNgQK0NWxlZJwR/qbKAJPNKWbiEpcT2MF+EtYf0/t5AEx3CesEqHwrr+LpL4/n/OX+Y5bG93AH0SYJ6zZFE0rtj3eE5SIHGF7D1SdRSQyGXLnjJh6M9h0C9W4HX+g+esp5p7vwM2ZADv7XIJMjYvx9OX1LklssZhQZIj0H5NFoEwSTN0LwGj3sDeXyexbZ0bRQuS4SAbbhRW3tAKbmiJMqHJGQB5CCPKPKkCduRGRvhqfYXzRcxDvvByZpfsoAAwFh/SeTtRd/VA2hWHdJHy70/Cja1Hi5kpZ7gtjNHhaQNmrI/sFgBi1vgOegZrE0iLmwpjyoDvnfLGH1P18Adq0tEw2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022075727099003)(261021121427099003)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(10067099003)(261022105027099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yxCTPG6ptplfCFmeGpRfv6M2FkorBlaQ/Xcb7NjAIOR7lS3wbOwr0Cx8jggY?=
 =?us-ascii?Q?k5eQeubA3lGLumQBH6i/aN0Ex3d2f8GS1sy7DDg81n3IvF0YMFxqUsmY7bDH?=
 =?us-ascii?Q?Xi+O6yxMjhlm0kJdYc7PGwFwIq0IQggXggd/xGv+JfDtPWEInYd3h/83xFd3?=
 =?us-ascii?Q?fW9CG/LJnZsUCaxGolxoIqvWeVR1Y4c1Pld2pD1mHuPhHLeyFQ0Skd/e3lmD?=
 =?us-ascii?Q?AOfNZiq+EJ3GJ952B9DNZJziawLbO/6/FOGOCYVusszuh3RI1deWHJ0NRHCj?=
 =?us-ascii?Q?58bk0hmf3LRS7VzFdMQW+72XgoC+VZrStBZy68WNAV3RtnZHEfyw8OvvWIhE?=
 =?us-ascii?Q?ZMHMgXXoomc3OrpS4/jkHeg8JxTzMMlAOUdw3pwiHr8VSj6zyb0RannMje3Q?=
 =?us-ascii?Q?3QqhJn3BAfK02WqoeOzPWwzrPmlqlANQkvvxBe1ftZgKgVxjCikRVZfwDEff?=
 =?us-ascii?Q?yEw5AvnZY1nQBhXr79ebBVo1qRpvrxBSmKRsE6H9keh/RsMUH2JkEg3jfRez?=
 =?us-ascii?Q?X+SKpH36lO5Wo9SlAnMjsCADtYgg8p3M1eNVurpuQCZp15Xeo08GNuVFyfmN?=
 =?us-ascii?Q?vrZoi+0zZaewWchAp18qzf1C8L+KhCbYIO7SW9XJZWPo3gj0rAzxcHDZqBZI?=
 =?us-ascii?Q?wyNgHkGmOHEsEfj/VJ8hOFJSngwyJrT20aqS3/BJK8hrtKNcIrnE2RJS6yHt?=
 =?us-ascii?Q?/8UPUoLc3K0q9s1r+edP7e5qHG08Zc3J/WAe8K6RR2rDPT7fdTO/WN23Kj2Z?=
 =?us-ascii?Q?I6OM80inF6AtED5Esg0nGzsf1C2RQbA9PJsPiu6u22CFuQJvq9PnGzOV+PUV?=
 =?us-ascii?Q?ph1vVI77mPy7cewboAuKslzKN0XX52UnEc6ySX4uksF3QFY/lgagp50tjU3B?=
 =?us-ascii?Q?8FoAQ05nc5W1QgrdVsLQIGUvVf5DCIL9+S9GsxUbi2plLnYOh+Cy+LgRN4vB?=
 =?us-ascii?Q?flLOH4vT4WHkqY0XTbHqBmolFoVmqrxzR9byBq7cu2rM1veQbwpMmYzkwwQW?=
 =?us-ascii?Q?cMrNRSIEaUub4IpL8LTiievCYM9I/LU76c+4G00rmgjrX7E1I4AJul/fmCkQ?=
 =?us-ascii?Q?5io/u333qQt8LywDmAbmRmbH5gdDT/+e9mryiTAMdpK30aBkffousvD1yYR4?=
 =?us-ascii?Q?HjjMFfal7VHEwTEB+/4JYgTbvDFHC1zpwU4D617asieg4k5Bx5i/hys/URI0?=
 =?us-ascii?Q?ENbEvCz+E4yQHr6lpcE2ghhcKhwFvnAyT8vpbPcVCLTv2k1pNxGxiFw4mBfi?=
 =?us-ascii?Q?BYyMLK1yMbcllgsnKFMIbAI+XEgqvvRqJDY839qSQbfX12kDdC8Sk26ul800?=
 =?us-ascii?Q?5B9gYhq8qnJ0rK/htzMVqYu2wqQYhyjknP1g5w+M28gNBUkHJIFezDY4vVSV?=
 =?us-ascii?Q?I6yulu32jhGwc1WNuv9qII7hDo5xG9mDJn+WjKxtNBkLecNAN+VlcAClOKE9?=
 =?us-ascii?Q?yW7bvuSZM4ymmqawbty7iK84B5eo9jYxSlzIFRRaNX5sVZ9zddSdpWG1fpBR?=
 =?us-ascii?Q?LXv9eiPpxVpCSm4NNg2hE0/uhH9sn6Jd008xnk3o1rHuOP7/oSg0nfStN0kl?=
 =?us-ascii?Q?NNR9JqMatJ51F+sONXnvL65dLNxkh9KAMI8HOGuGFdc7StP0qMBL1CMKCWRk?=
 =?us-ascii?Q?ByS6hL3LbcJbVpVyLSs59fJuQfHxFTj6FRRVw/jGpmZm3+YdDMb3llOq9g0H?=
 =?us-ascii?Q?jBJg85I+D2OqJJc6CosV2Cp3MtoIy4rAVSrBQ6/napnoVwww?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa700ae-15b4-47b3-5aa0-08df41a310e1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:27:53.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keY/g/3Kgv/Js7QodauqnMXmApcNcpM6750xL/cbI6r19Q+HWBn//H0LnLJv4xHh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243

On 11 Nov 2026, at 8:26, Lance Yang wrote:

> collapse_file() can call page_cache_sync_readahead() while still holdin=
g
> source folios locked. If truncate holds mapping->invalidate_lock
> exclusively and waits for one of those folios, readahead waits for
> invalidate_lock and neither side can make progress.
>
> We need to release those folio locks before starting readahead. On a pa=
ge
> cache miss, roll back first, populate the collapse range, and retry onc=
e.
> Doing readahead after rollback avoids an extra pass when all folios are=

> already present. If another miss occurs on retry, give up rather than k=
eep
> retrying while truncate or reclaim removes folios.
>
> Keep page_cache_sync_readahead() and wait for read I/O with
> filemap_lock_folio(), releasing each folio before moving to the next. T=
he
> existing uptodate check during collapse still handles read errors.
>
> Shmem uses shmem_get_folio() for swapin and fallocated folios without
> taking mapping->invalidate_lock, so it is unaffected.
>
> Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D16bf7cd0ebeb1de93aa5
> Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache=
 with invalidate_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Link: https://patch.msgid.link/20261026152013.10511-1-lance.yang@linux.=
dev
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> (cherry picked from commit eadce52a9ef657d561b3e76c9b5f178bd99735f5)
> ---
> Backport to 6.12:
> - 6.12 still takes invalidate_lock in collapse_file() after locking the=

>   source folios. Use filemap_invalidate_trylock_shared() and roll back
>   on contention, otherwise the same deadlock is possible even after
>   moving readahead.
>
>  mm/khugepaged.c | 49 +++++++++++++++++++++++++++++++++++++------------=

>  1 file changed, 37 insertions(+), 12 deletions(-)
>
<snip>

> @@ -2040,7 +2038,10 @@ static int collapse_file(struct mm_struct *mm, u=
nsigned long addr,
>  		 * in do_dentry_open() truncating the page cache. This is
>  		 * particularly important if there are dirty folios in transit.
>  		 */
> -		filemap_invalidate_lock_shared(mapping);
> +		if (!filemap_invalidate_trylock_shared(mapping)) {
> +			result =3D SCAN_FAIL;
> +			goto rollback;
> +		}
>  		filemap_nr_thps_inc(mapping);
>  		/*
>  		 * Paired with the fence in do_dentry_open() -> get_write_access()

This additional change to address the same deadlock makes sense to me.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
