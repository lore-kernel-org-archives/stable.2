Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794632968;
	b=4db8VnOufpq9jWvE0Smot0owSXqsl6p9IBR3qg6ydirOU4mB5eM5Q6j0Gp80LV9SOMae
	 iWctII9cz6zFrsfG+MhWCQ21MoBjK/ytCx6XAz2VkN2PpI88iWVYBvg8dcZ/Fm9A//LLH
	 P0eGSQf5lLMHIQFXS2tJUJV+pFwmPD2AiICnLbLeRSJFmkmVnT9Ul/dWd7p3ID0HhB1Q3
	 vPLmN7WCoOheYpk8zlwKa7+0KDuwNSIVLNycULkfHH3hK/RStzTNpCPWYT53B5DXgjnOs
	 cmsDpNds7taWUQO8TL+Z355/h1GQvZKghjClY4VtBfVElyG4lfWrbOo03hBpAUjxx1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794632968;
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
	bh=kXU3btpdlVAqrk+XU3KVn0INEYxWt2dxRyJSuiFm0dk=;
	b=e691bo4GNvspBHajwNUnxP/ckhq/jpFCKd921j7X6iTurlrVIn0ZJHc/mz+Q3AsGrLWg
	 g02+PTzjTRXr+eX54GpPxXOEdiOCs7YoG9+BfdDVD+Y95V/gQ19SFnAEHkr+HjdUDBICc
	 iFsbakatzITI70UwLM0b0J/trpBDIDahtmOFsGtzAhREQQhveTelW/hepafiKnsZ2GPBI
	 ZjEKdXQtT8UOJeftKF0jdl+C0NK59hGueee2FFm5kOFsis5nrvg4HGlvymV8al4piSaDp
	 XyHzogTxEDK+8xKigvQVOepDjyZcZNfvMDyFeDs1vOP5ybmZhZ9h/GTbyQeNSBvSj1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="R/JRYwop";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.62
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532D606A327;
	Sat, 14 Nov 2026 05:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4532D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R/JRYwop
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpCw0YzB/E+rREVQVx4e8LdnAUoGwKBAH31nCpGgpMI/93EJ70hNrg4pSmSks7tvBd4obMj5HtbXVTnFhaVRuXkYQIZtaTpsraSRGLw1am2NnCYHwBElT++O7nQokv1bOs5QYwQiX0owyQPDfvTSI6hbMIW4Vn1MfflaI31wUVD5cpu5uh0fKzDR8TTP9uAVREOX2Dp2BfNf90IHoUkx/g7te/ir5sABTmUpE7svZty7cp2sygLlChoQ6cHaWXx6t6LZA+JFWlw3DnewauvhrvLk4W2TdKo8BTD93atR/p6nX17Z7f8H59fjuGV8jlG1/qQyeYaaRDVGWmcGDnft2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXU3btpdlVAqrk+XU3KVn0INEYxWt2dxRyJSuiFm0dk=;
 b=fk/58Nv4tYoeesKtPan7cbYjvbrR4+Cr77T5LqimQDTl2PwD+iSDmlPdRTSDOYPWG9euRHYxWFN7aoTaLgY/b/Et5nh4EMnWawyNSu2nhWm3LcAXrqD0p/aUL4YwTrjmXw5o6MJAMRkvOLNDTtEtYKvqtbhKsNMJSI436ng0MZ17LshTNKIdhXXq82PVkDf4noRqLPAD8zmpCTJ8TTOPmohqaO1YNrNcZTHlQOOpKCm/ubK2Ma7YHBFuZSPqFV8a34i2ZkfIE+nUrLU3/tW35XhfEMMeQZpZ0Ovkt5XOL53VskWXWhEvl0ji22pGlE5cZ6sfgWILyh30zkil+Yd1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXU3btpdlVAqrk+XU3KVn0INEYxWt2dxRyJSuiFm0dk=;
 b=R/JRYwopIrZAgYfPcSbkI/ZR/h949unlRwPrfWD/Bc4+pvG6OAnPglPrpagWUtREWzvdAypW89lLVms6+HSNfUAqGeebmSgHYBUgToNErE/9vMlAi+TaSF0HgLPX0tc8zjF+ewYEjZPPRleBaYddKLXd+JXpCJBJTMYQXMnf+xw0TwrtUc7atYuFpkOy9L0LHyvgG46dz1uxzvE1mTb9fDbPIJKsNJ7a3l8clXePL65CapoccoeXbuM0f5LXvfe0cj7vVy5ZKLctPwcgmOvpnnjGAZo7/OiRT+UUz9kZOm9uT2dYSWTsEUFRostbLFtu9ucauB0H8G/FrsVcGOoTfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 05:09:24 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 05:09:23 +0000
Date: Sat, 14 Nov 2026 16:09:17 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/13] mm/migrate_device: don't collect a range twice
Message-ID: <avfrWjzLQdDcmXO6@parvat>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
 <20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-5-50a2ed382b61@kernel.org>
X-ClientProxiedBy: ME0PR01CA0029.ausprd01.prod.outlook.com
 (2603:10c6:220:210::22) To CH3PR12MB9730.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bc9639-1977-4cc6-677d-08df420d72aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|18002099003|22082099003|6133799003|261009223027099003|11063799006|4143699003|56012099006|5023799004|261021121427099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261022105027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	k4LqaJn3vUsQWU2UtM/tgvFhtJtjuypayktnfbfE8gXdksVgA/K6XU1x6JrPiwFnpfAZuq0aionD6AkShKoNNQZpJdhB4RZcBy4JYdJcZgDjgUsbdxAA9w0u5xLUhFZp2tF7EU3YLOsSRhms42JkDPZXJ7764EYv+ry/RW7wzf4rdAG+HKdylenIWQTeYldZbzgTaGY15KBQCj2Qy1HIPSwZUYPC4jbwplJLxZUBJsvo6ZCpZJCAxD6XypDVY0z3a4aoDnfriIlhBPd6QRZnEiqRIDyOh3l0CbeJH57uJgU/k6Oq97PSm/loB91Du4Bm/Wfw05QEaWJBEkJTXfF39ARm2KpwZjmfcOpUD6PmSZyJ0O8XEfvEYJ00zRS2/jQJbz3Yxh9nzndnvYul0lsN3p83dc3CT5l4uEGVhbYPX9GWnX99w86HWLaGwu1pWpYr/nsIjwDCyHm4Tp0+1+Cb0wc88Im3ShRrLRmC+yf08CKaTojtBVlXhCpgzE3aWUA9sODchUUjNLl9FrsK8tOIZQWxTz43uBwLvxYyigs+BWR4/pC1G1YjQQ8ZdU7GnORjT7vjVwuCRpdMaIBqB2aJOnc2uzE2a7AtNmppWOJhTsQBF3SI0lfufdbB3Gn65e3EvmOlWKosXgSw+vWk/v0Z1WnOqJq8bXIqCmgr8c7apTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(4143699003)(56012099006)(5023799004)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261022105027099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQka+0aj3Ic5GbdcIY3v7fTIxTZIagJTgIp03kyxckuJuCV0jpgyaDQW/WDq?=
 =?us-ascii?Q?Q+O1Jm9sO7XfafLzXGAV+eg4wrnRjvYbBw1dDn+Q5t7Myx5+F1Y5SV16lrIV?=
 =?us-ascii?Q?6EnpqlKmjI7k4TjoJ1ITX1pMohllsygBlge64XuWmvIpuDybcjpMzytE8y+N?=
 =?us-ascii?Q?X2Ctt1PXvT6grlpITPhXuvmuN6hwWsRO/zdBnI9XTm11V5+DMtCwoAjn1Gjz?=
 =?us-ascii?Q?uJre/kqJeVzKZktPRP7a+CzFalbpcYACDJlpGi/ZuomABhslrZu2C+13Ib3p?=
 =?us-ascii?Q?6rP7aFfFr1CRGatg98n5BGLhLHR/vDSTK5GeNV4yKAor76Jn/rpG3FEnY2G3?=
 =?us-ascii?Q?MQxKWP/LWeGZsfY6ydSb3SoRikqa7ZuoAbzwr4mAfLp0Rlah9o7N2ZyPrYpW?=
 =?us-ascii?Q?HBZ31TgSoxHiLEXycVLfKmSzDBsImsxXBtTBy0qgIh3ddnwirfpqqBW3EVC/?=
 =?us-ascii?Q?qfnZLK4mXNx79MBdvkmy+no93nQxXle8ouNnpUDWJwwoDWQfOpoq0F0r6P6F?=
 =?us-ascii?Q?OlZTSbQXr4AkloUtUWYGQeqz2OSW86dl00FJ+WI7PLgz45aCIBJW2bLczEih?=
 =?us-ascii?Q?O2BwkIdkpN9e7lUTABUHBvyeCzQZ6B0GhKO7KBxJSR2PA6+0rs3lULq4LBPK?=
 =?us-ascii?Q?/4O2ftA2f1/EVJV08HNTa47SFUHnxQHhPGSkYpfC4P5Gi8vgbaA3p9zclicX?=
 =?us-ascii?Q?KZ89Vg59RuOdPxK19vml/PzIn3kWiEFXl4OLpHRj3blexeTx0v1/h0kY7GdC?=
 =?us-ascii?Q?gpnCffsWtow8dq9tKYnFk3UMkb9QKCg/xeoCvQneDiJkPHxuQBLcRsjFfid0?=
 =?us-ascii?Q?HzRoRjZQqKZH/+Wc+1OZsuuzQwE66dnVzgKpHni5ZYJYNC+d6wXFKeCssp61?=
 =?us-ascii?Q?NHjZllpC8aH6/82TtZoStGEc1qhV2x/Jm/reKrZ949KMCNb011hRIenSGvRA?=
 =?us-ascii?Q?CVC8RsyQsCvM8xyNtbHU0Uvgde1cjHDq2/IMpgnXigAYpUos4dHEi/nFvl1N?=
 =?us-ascii?Q?WcgWh0HkFQg3LQjsJAZx+p+vidfzME20/6UZTot6DunDXBDtANbNfVMG1M0Z?=
 =?us-ascii?Q?aGqfTvqJV9Gj8LbkGOhq9IZgpjpuhK9bHlSAz0+Qi3DcVBi1iTJOXF2FgUaI?=
 =?us-ascii?Q?fCNDua475jmz6HMKTMMlPGaTKBT2ee3Hn9sLoDjZKekGXx7F/UHJWpRjteo4?=
 =?us-ascii?Q?KPwW4bVBqqz8V07Oy1ktCI0ghdJBdnxZQ97UBcmHqsPncFWAhV1sHOneX3FM?=
 =?us-ascii?Q?304ayZWvkoid+aXIVC9fING8npuVyG7Q8Vx/O5rAQ8Sdll9ZytS+8sEPWFQv?=
 =?us-ascii?Q?yIQlLnNMz7SvCeZS+xbqM1ir+TRf77t7STauBZDUMTq+nxq+zENXZwxncFcy?=
 =?us-ascii?Q?+rJQVDPfvpNR/CLi4zN7uOyZEbNsfJPBW4dtqnJi/XscQAy3UzLBkcGccSUF?=
 =?us-ascii?Q?AbsDUysHCuClDT/Tp8cYqyPdxA4Qtunt3YES/byF/Yps+loxXlRI0GDY4puH?=
 =?us-ascii?Q?CAbyLORKGxEfNV0PmEDhpKOQ1mf9q3i95g+23H5ZkIqTPltQOwaxhxWh7DvY?=
 =?us-ascii?Q?JTXrYeuA4hClQaxDOy+aRJbsBEAxPLuMTjqaZNNKLFY8C+Bn3U6ZlB/ZKo4e?=
 =?us-ascii?Q?2EQu/LwCVAVumzFZEluzXAYbrzXjbBGwdux0c7J6w9EMiwk2YHSPdKDV9U8z?=
 =?us-ascii?Q?7d2Oq3JjIIU9DfE0ou3iJXzcsQOsnEzBVLnyBg05fg6b4TPjiLQw1T5HFw+8?=
 =?us-ascii?Q?X1giNUA4CQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bc9639-1977-4cc6-677d-08df420d72aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 05:09:23.8433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1mZt3ENoyHKpmXPbYiOm4BfQ/WKNIQ1mvo/w7EQh+Xk/7KwlDBC+eDH/IUjT4UwT9pgE6rzSovzTHueEpdEcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135

On Fri, Nov 13, 2026 at 09:45:23PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> migrate_vma_collect_pmd() drops the page table lock to split a large folio
> which it finds in the middle of a page table, and then starts over at the
> "again" label. The entries for [start, addr) are in migrate->src[] and
> migrate->dst[] by then.
> 
> While the page table lock is dropped the page table can go away, in which
> case the restarted walk invokes migrate_vma_collect_huge_pmd(). However
> this is passed start rather than addr, so [start, addr) is collected a
> second time.
> 
> This can result in migrate->npages exceeding the number of pages the
> caller asked for, and therefore in writes past the end of the
> migrate->src[] and migrate->dst[] arrays.
> 
> Fix this by only handing over what has not yet been collected,
> page-by-page, and flush the TLB for those entries which have been
> previously replaced, similar to the other returns in the function.
> 
> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: cleanup commit message ]
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/migrate_device.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 9e5dab8e1b77..28ed706109da 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -257,13 +257,17 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  	pte_t *ptep;
>  
>  again:
> +	/* [start, addr) is collected if we get here after splitting a folio */
>  	if (pmd_trans_huge(*pmdp) || !pmd_present(*pmdp)) {
> -		int ret = migrate_vma_collect_huge_pmd(pmdp, start, end, walk, fault_folio);
> +		int ret = migrate_vma_collect_huge_pmd(pmdp, addr, end, walk, fault_folio);
>  
>  		if (ret == -EAGAIN)
>  			goto again;
> -		if (ret == 0)
> +		if (ret == 0) {
> +			if (unmapped)
> +				flush_tlb_range(walk->vma, start, end);
>  			return 0;
> +		}
>  	}
>  
>  	ptep = pte_offset_map_lock(mm, pmdp, start, &ptl);
>

Is the intended race a concurrent MADV_DONTNEED reclaiming the PTE table while
PTL is dropped for the split? That would leave pmd_none() true on retry, entering
migrate_vma_collect_huge_pmd() through !pmd_present() and taking its hole path.

Thanks,
Balbir
