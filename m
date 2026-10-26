Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793041719;
	b=kcQu9gBkW5foh3BA1lX9soX5TcozTS8LSxODITh5e7Pu6f7NDl1RZ6gnYfb7gxFM+PSQ
	 CRJUMH6JZE0ZjF/HQ5ClqAjcmobZK6hj/4GbxsyOo9RCEzxwt0rtIfW4Gz6kDFvhE3Xw5
	 w8tc/BNMRNZtE3+yZYTS44piKdo8M+1tkbCOeeUI3G4UKrEGaF4LtTN4+ckyiePxZTFve
	 aHnk/ArsBCQQRqnQTZLxw3U+dgmvq0pG7yM57JimJ4sYjXxTNyOdi+pJlWgLOXHG7HhHI
	 OW5qpyjaR/l9hY9caaRWBdqETN93WC7rBDtDKM4Z4EnnD22pCl3gTVv3cXPxgFYHXvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041719;
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
	bh=Tsk4dTanj5TSHJ9iLUUMmb2ZTOUw1JbpYIxC9YGu0bs=;
	b=ew+p4PqpG+sxuGzKq+LW+cnVsfDSdJ2axyInUmPoPLuQlQsT5/+tKe5b/Aw6um9trYs8
	 wOmB0IPJPfULbPP6ug4gupiXIxPemofWnsnkaltu/V/uha9tDI6QVc1v45VmBxAyVyKJE
	 BOcgSXf4mhy3/Nmmon/HaGm3zegVezwZXMrtq9QuSMF9Ie4sOYDaXJyv1B39AZz19C2OK
	 5IFDd6kFMk+fZPRrCQ6ynAGFG/PtKZS7D8bvE7O3mjjdl/qq+hEZ4KryQsNQhGY7Afv0Y
	 jGAWqnnPBqx+vK98WvVkCmKZkck/Fj3o6zh1uRa6Z2yIXL/SYNA0oMd3wxTZA3Ul0HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="L/Vn0wlM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.7
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDF606A31E;
	Mon, 26 Oct 2026 19:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92DDF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L/Vn0wlM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky+ma8B1MXWfs5QTfPJcqpqIzHObtETODJooS5MVyU+qCNs60HzV3CaKF0HSOV4e1l0CK8+ftlfBVki9Kf7tsEELuJDq7P7wo3tfARgMwguCA1+00HGZwW0cYyG6Iq354c81hY4SJSS3DHzl6KrvYleDBj6kDS1oeWcgxh4fOPEbV8tFrBMq64XXJkKrz2Kdq5zoZzJV2iY1P3GZK2xgipMQpuQWs+QPaomGmYbpwRL7g6mBXfljbt6a5AR7VTsJS5FQZWXqxAhoKEoSGQ+mGzAqaOc4K/UgnMhxAyOF1RcY94XaFT5S4PEzYnPcC9lgA/Y/jcJsLda3yuSML3m8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsk4dTanj5TSHJ9iLUUMmb2ZTOUw1JbpYIxC9YGu0bs=;
 b=p6lpD9jxx3CXqqUWCD9vVXg8VnAnpqquXREsLNdlevzPIkvrS/zeH8hDuIr80jbwyBybivsrqgpBf+apE/67L+60Zk2YdzwtxDzcee92Qx4w4vNmWjaKryZ2eIoPqH+z0GQkmXCXvwXYt98Vv5iG/yo8OZ4souvG7iDqlYSO71mf/Un4oirEFITUKYQkRuKXk+9Tf6GM99m3dyJe1b+2uPsLG3zyMSKtjWOc8ceOHM8b+yO3wyPnnF9tena8ymYphmJScuhPHbh0h0YW3o4jNqUftbS5IBCER87ERa94jfOu/XS0VLRCfDDDNb2Nd/6/D6KOaiAXeuj7GSfhc/tc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsk4dTanj5TSHJ9iLUUMmb2ZTOUw1JbpYIxC9YGu0bs=;
 b=L/Vn0wlMFjV/DuRSzxqmO+X5Jxfk/WN47sN2m7Mtc9dPc8R83NDZcr8D6FcEI9iDCndR0HIqCI92GeGGSYhvOnL5A91f1nqTOIT4+NaWUxfaFbQmj3nJsNGdDuX6Qdx9S7HFbYySqSHR/Dg43znq01G6EVSb4HY1j7fHCVY6uaP9ijDMrWlVFlc2uhI+hjmoowXhJ+h2ECfGqgkn7DExH1sVIZKYnLzbM2ir10dADj928+zhRd09SPKQAvc9YKmrIqdr5MKhbUzBq/0MIwoTCZid8D6N9tgjDZT4rVy0LoHGJvl62EumkR5FOYnQLjxAsK/1GIlLVGKBnHmcuT1B9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SAAPR12MB676730.namprd12.prod.outlook.com (2603:10b6:802:301::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 19:08:35 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 19:08:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 05/16] hugetlbfs: enforce F_SEAL_EXEC in setattr
Date: Mon, 26 Oct 2026 15:08:32 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <D0209A61-A2CA-430E-A76E-0507BEB66728@nvidia.com>
In-Reply-To: <20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: MN2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:208:234::22) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SAAPR12MB676730:EE_
X-MS-Office365-Filtering-Correlation-Id: e541803c-d507-4aec-1401-08df33948863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|6133799003|10067099003|261026121527099003|22082099003|18002099003|56012099006|4143699003|11063799006|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	mRqjt63qpWSSWFKM7zvJ2b9/T6JkdHbbH+50IqtKjxQsmnZFydpFCtz7grlB0n7nAfYUEam2ce3//70EozUTzZVgvF+J9dkcQRS7L4j5EiRnFuQuF3rnqATche+nkvdX+MVi7E484UIbEoxe28at3FJ6sf0uM2Qs5SapRx5WhQZygRKt0ZfwXi5Vk31EgsPbLKH+gGuCbFRaPAxEOPBxzTtjrFbvTMneyQI/MzQnAbecBdcmHgzYR6dslxbb9TlY4Ep8WZ7KgRfxlzQro93/xps5tgDDZVlE1CK3DqB05/GuolMwl3H0Fb97aulyimwpQcVhTLgUNpMaLNsiO/xKSYkApAoU7AVN+s7CdmOMipWKr0jBvfOexgN+zie3PK8Gpqx73H9kNEYeXa7trCcK8spGiMN8+1d16Go3X2uWj8iDkLCQuKtX3skRCa3GnAJyWIVF4+suldXiVNokVMR0H3goP8gszOsM8/EmB4KdQXuzdVjF94WNCyNONM792z80K4QAtbb0sny+ZnzaIjPZ+UR67AVcUDictYFKeiueFG62++NOIXQw4CNVNgZ5hs7xp4W8nTDz2aDgSMQZuanabHqkyFwzKfVMvKezcU0SfpfxaheWb3mo0lWS0Hh8u2UPPm9Zms3h0rYzoQmM9r/QJ2s8ADiIzNqcMrNz8qq5E1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(6133799003)(10067099003)(261026121527099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F4MhOmd1xJZvTFTnqyApSb6ewnrT5GkOj72fDPHo7ah/Qpx+H/wdVKxgyPEu?=
 =?us-ascii?Q?kApW+VeosTYxZ+nj0KHgDkZlAHd4J4HD6VxiiG7KOM7Crhxv4uZuW6ND3Sr6?=
 =?us-ascii?Q?CkW4YlK5CDj3OTbbviOQy0c+z6XwMcvMMlbn+8jfxsixr8enMIPfiV5Pi1vC?=
 =?us-ascii?Q?BafK9mAm6BF94fZp/Y5vR0n3XDc0BdVDb46wV/oZYsmWKQcHoVnzjVN0Jem5?=
 =?us-ascii?Q?AM8SS3SlTy8syaT0s61WtgkAS4cd/gFtAhYxfn7wW2WfhVRi2DAjDVzdXo0c?=
 =?us-ascii?Q?7mWLaTSCCGbY1AeSfEDjFtiwAIc5vnWaZ0y941Mu396VTZNnZyxWfwc6oRpa?=
 =?us-ascii?Q?saXUCJhHWon4izCwCEnk+8fdCZhXk5ZBdCTTrcE2vGTO8puO0g0q/6D/OkXy?=
 =?us-ascii?Q?YdSnzWbCuLrtlAoVz8XlbsmGNAfkG6rMTmxN4O7n9YMPsHh90rBWbphkC4Ln?=
 =?us-ascii?Q?+cQ4USBzEdranl+mz0QwncFJSYNp1nvKKaOtDOFZYpv7hFa2sWvN7l0RSmHO?=
 =?us-ascii?Q?hkO1IYn4Ba3Czxo7ihfH78h/tVI/njGDrGo3vtAYwRK8BSHnS6EgMFDtiYEt?=
 =?us-ascii?Q?aFy8CPLYYQ7kmXkeW62A3wuwFZ2vRoEpo2EOKrylFO93Cex8G5OU4Dg7YCXk?=
 =?us-ascii?Q?TTZ+EkZejfBB/K5Gxcsxhk0j2r+6Sewqa9tPA4L8BonDtlE0Kjox8PbZ0MG8?=
 =?us-ascii?Q?TRiBtJNaefeDwOQY546BfZM6WrQEUysMHnJoTy2f89H3KlWZm5CEpiZJoN8l?=
 =?us-ascii?Q?FN6Wt5bxnOX5AXQ4Uk9nTn2QSCGMF7WguqqjF8Cj31iv1HGu3hjox1J+V4cQ?=
 =?us-ascii?Q?qnpdw5a4BQBq5iJNcs+vcOci+FqWhRwHahdz74ZFHikrqciDazX4ItMLpDou?=
 =?us-ascii?Q?+/SOIOJ8Uf5qlqo59wxQEY+khfc6rGsi6uBOSgIMLcecNkHYGXdPAylfegFQ?=
 =?us-ascii?Q?U6qCTbEAQbyHXIinqSKd5ITY0qFYZNHw4oPwbMzF1g60ZeSSLR4a/hSsBzLm?=
 =?us-ascii?Q?rHtdN/l0+Lm6NUZtcUtmB04pc9bWiElFd/t1McsX5t202PaIbJ7MJw6Lk5Ib?=
 =?us-ascii?Q?zkZXHbRr96n+uxmxTa1AY4I9JNZbFA6YVv+fRtXmNJXgDg2UatC0BKFUla4U?=
 =?us-ascii?Q?yASu3/fyrKku5y6REqY6zzvnUmnDity/QvtRCp5gJbreslKC4C5OqTKymyff?=
 =?us-ascii?Q?MnK01XPQph4oRPfRMkNfdxLCkYMVZa8i6YR0H7iaN2XyYuDy+22pGTCCoOZC?=
 =?us-ascii?Q?4L/SHDzgt0aZxfZG7NndqtQgCFbo7BDnpTasoB6KBkJlsU1Lay8UWfHsq0B+?=
 =?us-ascii?Q?5Ei8Fax4kyzqX1dMmJ5+eav8M3JVjM5JiqM0ZCyjbtkQSI2++4IyFhu6ZyMK?=
 =?us-ascii?Q?xpgf2YorGYnTHiyt5pT0TPXiEL4x0D9lVzBPiGqFMs4ShXHPXJdh7Py840Pj?=
 =?us-ascii?Q?ChJpJ3UCWJSrn4kP3LGuAc+QY48KaJZG9BYdbthuYYzkOjRtjmuh8ztuZVNR?=
 =?us-ascii?Q?3Jb1s9RpupocLe2HWxvt16G3zrNNiDwSn/12XaN+tqwOam8tB2uxe57TqpGZ?=
 =?us-ascii?Q?QhNICP8uohFplfwctDAud4L6v4Bso27h0ISd6siwHmVceTcF3/2ew1me4U4W?=
 =?us-ascii?Q?OSAB5J+m66YWtZLEz71hW2WM3UCXgpNtUl4Ah8YgoFpJ5rfZ5Y11EnvH+CN+?=
 =?us-ascii?Q?c7TVaRJ5AZK2FiDLu+6CiRPVeEt8RlAGLwTKSaOUwv0e9PgR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e541803c-d507-4aec-1401-08df33948863
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 19:08:34.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Y/Qcsru68Xeconjbur9LhnlK63b7jhd0SGK1qL+5OiDm5Ft86lDaGeRois15ock
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAAPR12MB676730

On 26 Oct 2026, at 5:40, David Hildenbrand (Arm) wrote:

> From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
>
> F_SEAL_EXEC is enforced by shmem_setattr(), but hugetlbfs_setattr() doe=
s
> not check it. As a result, fchmod() can change the execute bits of a
> sealed hugetlbfs memfd.
>
> Use memfd_check_seals_mode() in hugetlbfs_setattr() to reject changes
> to execute bits when F_SEAL_EXEC is set.
>
> This also fixes the memfd_test hugetlbfs SEAL-EXEC subtest, where
> fchmod() incorrectly succeeded after applying F_SEAL_EXEC.
>
> LLM assistance was used to reuse the helper and revise the description.=

>
> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@=
virtuozzo.com
> [ david: use common helper; fixup Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/hugetlbfs/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
