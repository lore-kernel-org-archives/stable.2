Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D052FE43;
	Thu,  1 Oct 2026 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866336; cv=fail; b=caFWITQYs/9DKbd4Kts39WYa4y5rSyJcdsbs/vo567j8/0BJIBb6xSStXV+lFdyj7jctFC+2cJTTIo9ouqdA8woDceVmlk0Zk6oRBoUi+/SZch+6QvlWZp0NLO7aiO/h3ACfn8rojnKZKBAbftNnVJ8Z1HtTKOyI1BXDoTXYP18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866336; c=relaxed/simple;
	bh=neV5s8/EEE57Zfh0A9h+HcClqKGAaL2RN8QL5HjC3Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XrQQJB5N/L+dKdhZdTWp3vshho23MX3DnqkzI+xaYRieWdUhr89MvXPoWAQ5+JqziuzTRJuBfHUAN9PqVSrB7yfoBSOCAGmtfsqcgRqyrAEOm1Z9U8Ra6PVKvvmX7+IjhZY6qVqIs6+b0fRb5vbYUaE4WWS4Q8M0itifnw2G0ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IWmC9dkv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qgd2h3QH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IWmC9dkv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qgd2h3QH"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMnPC539371;
	Thu, 1 Oct 2026 14:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5k2K9VS7zuQ/UTlCAJld5uxak5XJgLgnhv4R/bikwio=; b=
	IWmC9dkvUq+5UD8puAqfUlegWHhC7fHSQ3nbrBi2m2AFnj/3N3U8uOQVhzImrYBz
	ypwTUR2ZndgnhcIFVyiRuIX+RX506vDE7oy7Ku90xpyQ42V/WR0AbDTK1dN+WO6e
	IEvHi80yPzHbDReNa3sC9pl6rUnZ0WXmor74ICpUS5dsmirNLsltz80oTGx9gKWz
	8oQoJ5GkpsSiT93UcsPj/QIjZGjQ25VTlNXtO+MCthfKVvLcvSJBbjMw8iUz1+Ms
	U3YZaMdWccKyRIbo6hRv/Mls0wDfgfjYnZKoqGKJho2SojwrNkossg8F6uD+619L
	nyN0U9rIovFCs7KKOaGa7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgyn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoQ1t031637;
	Thu, 1 Oct 2026 14:52:08 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd3g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNAi6DNjc/wFWgY/PW7RLgg9basGnQMMT2WodPJZz7rFlo4IvyBEBTMJzO0Xc8J44EyXHeAyMp8FR8JJVDkrbvv2HkYaBbIpQtADhAkplyCU6frVsUOKlLfkYS5WGnh3x1hVQ5eEfp0NcihGMBl1tz69QllbIP/9E/bwLSULbCUOSlCzQ2jZqiqTs2VvpXQ485TtLEOoVKoyRwkeiWyGM3TuA2whXClxKfMSV2f/iFV/Dj1o8EEEqI7nszQKr1Hzr0qgvhK0xGF0LldEfBYStlXI6IyE5fpvVBWiX1B2tAmLh9Ws8EeshdYQGfAUR1sJbj6Ewa0tXuWUsLJtrW2+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k2K9VS7zuQ/UTlCAJld5uxak5XJgLgnhv4R/bikwio=;
 b=a3wnwF/UlvXv6YSJcpRTyXsJLQNZCglZbuTLv+r2pFTBaSXP+kRdbw+xvdcwgHTuhcaPmx2g/DfteEUbZTqHhtiryY6Vsm4sOia57wo5/6HAQj4W3zUir4h0nNDrZ2J9nauu9qj97og81Ykrmbryw3Ei0I5b6Y/cL2forGY28plwiS/NR1TkfP0TANcAmdOGEweurZHLMr0HMBHb4A5xcnSpKPeXqYJnf4CJlvBgWgrsTrZs9Px1B6DRdMjFE3Vcz+EY1OJhYOrPN6ESC6wHZDp0MPSSmr4zO8RuobxqU3Sau5Ymwnq3iLKowNF3h9yHHG6EO3bhtspKXbmuUP671Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k2K9VS7zuQ/UTlCAJld5uxak5XJgLgnhv4R/bikwio=;
 b=qgd2h3QHZZjbMTjcBSjkWAcxqNYfn1dy+z3svuZZpqmwouvSYZ9GOmKLjFgzBeKvpiuTcUy8PSoix88/swweWruXeSmdfMzCqJ/BgE3zd15QSca2BNZR6NhdisUv7ewHs2jb6EXBZjrJavY0XR5Xoxi98jAp78Dvk0oaagdXl7w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CO1PR10MB4417.namprd10.prod.outlook.com (2603:10b6:303:93::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:52:05 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:04 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 05/11] xfs: buffer pins need to hold a buffer reference
Date: Thu,  1 Oct 2026 20:21:20 +0530
Message-ID: <52d75db14333422e1a891ce6ec240987658f16a5.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CO1PR10MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: d51ccc30-f628-4652-317d-08df1fcb8892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|23010399003|1800799024|10067099003|56012099006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	72ztfUuq+tidXYX2IxYTABQ9JkbOtl9gAvTJf7X2EXNahRHh5sqFA1p9APAm6GDbDeBKspvEczvqzK1OeeXWMWD2lwOEnE3PzMn6zmEvmj1WX8mR1MGpVRbtnyHRTPgG3yGK3V5hTAFzu9N4WP7FMeT88Att3y8PEWhey7VMz15UfPdZK9Jk7lVeo1hT2xQ9kNqbRkOF0hlbAm7D52Luir4Q/ajdpDKBPSPmRv3HTDFKL4VhWo1OymLCStXTRJfOFk0s5i4orCvYLN06xLL86hXmXfFXBZjYwgH5OUqgRwfZr1tMdvhNEShHGWoPcOqA3mKlCtApt68jE6lVbYwr5uxTgCKE4xEgNm8/767dFYxEsjyhsTUYdICfRfhpcIq7lGpflcRCxABnQOHy8rNd2dkTroesGlSG0u4tDn148Nf8qt90QmoRlUhNJ1Fo2fFX/qgUzQiqmQdt6Ydni6p9teGIzqDhpV1mWdbPU7o4jizW9I6b+t4lDoxvc4WGgpfLXEISc0fIpinMqhl6OW0DftYAPAJr/EhhtR9VI0Xz5YpzGG+0fh1md1XUezFh6dvVQzBN4gu2O8N1gQUVFoh1SdR3G19ToLh7eegilOqo8T5gaP3NO3wtRcxbnkzFWh1lHWZKg5ROsHtFShRk+cj3pp6eTpbXqVvQUbsYfWigLIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SXvg8gCQFBS3ByaZhjfaCpGo/WV2yNu/UPG+r5YR7lqrcrIrDzB5uRNaL3Av?=
 =?us-ascii?Q?i4JkNY2E/k5VOTRFjF9dsQ742nczhcZOVFCC60+fIKhupG11KSZCuHkIb4pQ?=
 =?us-ascii?Q?9A9/JsynScGnwM47/pdx1uL6B99Wt2a8kAoFuSn8gypahVHJCOTs9FHuUCEx?=
 =?us-ascii?Q?j9O8sC2fUgp6+wOjDk7pk1jBo7Ud9iLmPggXPtUEvf/x6jnBeuMwISdvxyjU?=
 =?us-ascii?Q?93aeJ+bpDuiFV73PvRwfFvXSVUEGSDOYzN2QzgAzBodx+xfUOSe8IklynLQ7?=
 =?us-ascii?Q?SFnb5UPB5DEtw2ZTGuf6QbSD6g3b1FRpWJumKSvz4CN0CCjjFSMkikE+Eht7?=
 =?us-ascii?Q?gQwnggDD21aiVKISU3WBKEvoA4GrEUzlzot73hMhQBwOkFDnnrbHFg9yt0XP?=
 =?us-ascii?Q?mieT56luvaYX/ydXoV0NaTMjjLF0b0vXYO+TaLN3i/TSh5+K2hBdkI0lPBxQ?=
 =?us-ascii?Q?L1+CJvJOuFQz+1jud5lQKbymxwFzWRJLHURNzZNjbmKDHL5j8xd7w1uv2Mws?=
 =?us-ascii?Q?03gu4UudoDKXyYUARzEKZFXXtp+83sY9ItaBkzEsiqp/uSzHYee3YDtdZBDJ?=
 =?us-ascii?Q?fIvUDhzvDgDrb7Q8uLPyuXXMnURYshQ8IFIp1SBZuvPSGSNoXIgarTnq0cEz?=
 =?us-ascii?Q?GhZKu1SBHeffpztrNnVLsSWh8Q0DizaP11hklnTtWdptIQkTH7GDj7Enre1z?=
 =?us-ascii?Q?c+g+3mc0rmzwdnc0rVLlKnKDK6MXOPL7l8CwgEFrCeG8elxJ7vF9w9w4gZst?=
 =?us-ascii?Q?D6H29qPOvcUWm1imhDrdS+DxOIEtYCQPGVfYoBit++PAyZG95elU7J5STU7V?=
 =?us-ascii?Q?oaOrQgL6n1NyXMmpyvofZ0MQfHvyIk8E5r/bxuVHqV4it3jrd6n2JSDKQAzz?=
 =?us-ascii?Q?x0FFB891Vs01v07O0MQSUBw5ks5ElwvOWL1A7FywCmzcUDyIcsf8rukRaThO?=
 =?us-ascii?Q?iLPmDGTHT/5JhbGe1aVx8XFpk1LaOJf1Ey/urpfI9CqMw3iRyLPZNHkmFFdp?=
 =?us-ascii?Q?o4TIlRuNPfcJ3Oo9pnCO3fEd1CDvX2BICGBqmUVNJ5y9XrViXVDlW0Qn4J8F?=
 =?us-ascii?Q?eGZX0Ib1YqPj123nOUvKYDGOGAEQ8R25RvGEf9GDFgUvQtt5sElfapGudOi1?=
 =?us-ascii?Q?BSqy/CdmPkpEeKlyxbv3AP2OZC/JXZ0qjvtFefSnA0t1tLrd4c1OxFduE3At?=
 =?us-ascii?Q?VydBFHVlz32+hgWNWXzgT2TFyB32pUtpJ5fbBYQ6Dcq43asLbXY8fFeWzGI1?=
 =?us-ascii?Q?Yg6tnK2zd2+fC0CKUIOJx3tBh4ecAm6f0RyTOdynadGgmHrgvqta6KHmONfl?=
 =?us-ascii?Q?2ISKWsRwRv2RdOrM7gnGoPxiDcZeQHkcQfMgHiCG4yhvHBpPQT0bYPAIXJ1x?=
 =?us-ascii?Q?c5aI9UHxtUzZ2r36bB2QK/zW0/ZFEwZ/5knzfXZ4YPY4jp0HzoXeHyLWHWh8?=
 =?us-ascii?Q?TAHqrECrhm3nrZA6h0V467si+9TCz0+Wzk5EFG11RK4X90p9m+gnL8eKxlaB?=
 =?us-ascii?Q?6o38fUXWsYXfgb301uls5xg9UpYwTpWEvEvAvdhzPYh9VdLmZsnOco58g0EJ?=
 =?us-ascii?Q?T1ZufedRDccf6AxIwwtkEW8gLMZ9KKKRJX/EUA22417cAL1y/byCwqjHduLQ?=
 =?us-ascii?Q?fhjfpfpzLW6TIcFA7BwanaYA10met7rLNgqDik4P90GNyBkIswTX24WslirX?=
 =?us-ascii?Q?8dl/4BjMpQ8At4+DR7ljehfMvTKSGI/JOvFpg+9IFjvhShmIwCVT967Fw0U0?=
 =?us-ascii?Q?+NtHulJxouBGfEGOTlZillhWIsamN7GumdMJLwJQ2hR2V6df42B+bJLcH5fu?=
X-MS-Exchange-AntiSpam-MessageData-1: jm/pp5OOdtxh273mVZv27ykdbgMCHv9O+Yo=
X-Exchange-RoutingPolicyChecked:
	rTGRxQrbIil7XOvEi258W22lH98BM/A+NYF/37G27L4F+4W+qdQ9zwyN4sTsc6tQVSF83u5bZyZ34euLvlbOS+zmuyDYUkcWmgd9+VRXpufoa6e7ah2g2ECCXWT+LP8QLxIyenluWVnQA06MS6GxKCHggYCKAl6ECVfAQLP0aIMzlbqH3VYVZ/WW2vb0UQJD8Uxth11CFe5MH/2vsfwnqqKXaRyUQz7A9JaitdeyFC3+y4Q4NqdI9evqm038MBnhJLmwKbFEUgMj1IHNRpeob8eFDrD4RyckLRibghT/ozfjHeS3w14ylKjSmDX7CnUuF7V/0F6XiUVnlqV3PGgAfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E5EU14Fqn+OzCC68db6jA7BNbG2/Kz7X84NVvT7c1NN+EDpQWSfw+21kCLcYYKRCe2irWuoH1SfO7cNwe8A914ssVChnLvSXZnl+d0YkpY3j1qay86yYOolNI3pVQd5hvJ0u026JjDGT65NBIJEXcnRDaZb1zNwCDzmUd92xgMIeU7hgGVUvcZYQHTUswWspfsZ349AR+bD9NMWV4g1q2mYIc7lkr0sRw0LZzs3OVhKADmyiVk8bS3mz/BtRwi0geDrSM5ihIzS9VkrH/+ezat6b5+DxV396k41xXRH7ZpcncullQojq7Wy2QTuk3PsFmFGk3evi20EF2hNdB3U9O/AuMlV5XZrFW18+TGt5dt6lajtRVALYyctt8RaUBkA5ObfpQNNbCQHqoz/g2L8fjtxKzrBbveOhOwSV6Sgk098XaqWbogj08hEYjFVbD7tb536xfb9hxQ3D5vNvUcvskwYNbgkapu4rwnNaTv2wBS+u7ahBhe5SRjj+CFQ595mpuJRVeCe6T+zX0YhTtJ/w1xXjd8We3vl7kp6tL7AqB+iJjKg2HjZRtj8LRR1HZ2zgXv4QatIRqyhKnPryln0V4couem89sYwgH/hIXt5oxe4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51ccc30-f628-4652-317d-08df1fcb8892
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:54.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVe7G8SAdw0NwQUdzDW645MPLnjy+TH9PC5Iud30nggqQ0BztffjNo0O2w1cBXTi+VVj0VXm/G0ajm77I43p8KTWvQJqqsouYvoDyqOSjo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: gMh-P5dTy4yzwkWKQlNN463SlBc_FmMt
X-Proofpoint-GUID: gMh-P5dTy4yzwkWKQlNN463SlBc_FmMt
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe7399 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
 a=7-415B0cAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8
 a=t0Y7tUnTQisWX057riYA:9 a=biEYGPWJfzWAr4FL6Ov7:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX/HZcm339k6XW
 hlT/T+dpyvZ10ua705HdJZ2m+BNcnYhYWoq2atXMtDVMPJzhLhdnU7Az5Yy5Pr5FXhHzn2xpr9C
 Ejz2kUmykL+pOzJtv6Vrb28mq869uWtUSIAnaYKZQowbHca3ryuD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX8p+c1a1J7nTA
 R/KDKHV48/SJpQSksSlb+NSiaOufNG0uY79mv6aDo8YTcOmdZqQp96K3bQ8UctycmKBBb14XQo1
 nkQN6uwj1TAw0D19IEK8Kc2Xp+fGcWVh0wCcZMY0ndn95PyqVoEqn/gQRSrm8DR/0XfvgRfX50W
 mH3Zjd/LE103+BM2u47R6zxf0z+kUz7FduwQrHT3APSDGt6Qg0P01F0fbFh0+eoS7m6g8+s27PG
 mPqmdZONALfan9FEd15KfU/lns990thVpFR2mHONLmOB7bbukVFMhwhZ03PsycSaSNuwpf7Vpq9
 RkdvrD545aS9pEU/f1pCH41zRLWQt5tkhMymSs5bo3aswko5LEFf2T0mHMOPyaP1SdPdc7avh5o
 igadF+qugYanTRi3LMf0bLg5EhoNG0x3Pv3I+FqNm8G7NgubnYFw4xBQiAvAtTdbEcA676GWU/C
 xHasSpiv9L9rSfJlqoEVGmr/XQwHw9JgnKOgFh0I=

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 89a4bf0dc3857569a77061d3d5ea2ac85f7e13c6 ]

When a buffer is unpinned by xfs_buf_item_unpin(), we need to access
the buffer after we've dropped the buffer log item reference count.
This opens a window where we can have two racing unpins for the
buffer item (e.g. shutdown checkpoint context callback processing
racing with journal IO iclog completion processing) and both attempt
to access the buffer after dropping the BLI reference count.  If we
are unlucky, the "BLI freed" context wins the race and frees the
buffer before the "BLI still active" case checks the buffer pin
count.

This results in a use after free that can only be triggered
in active filesystem shutdown situations.

To fix this, we need to ensure that buffer existence extends beyond
the BLI reference count checks and until the unpin processing is
complete. This implies that a buffer pin operation must also take a
buffer reference to ensure that the buffer cannot be freed until the
buffer unpin processing is complete.

Reported-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 81274891036602355e72eabbb5184490f354b506)
Stable-dep-of: 816c330b605c ("xfs: factor out stale buffer item completion")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 88 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 065bbf03c7b0..e0c75aa3cca8 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -452,10 +452,18 @@ xfs_buf_item_format(
  * This is called to pin the buffer associated with the buf log item in memory
  * so it cannot be written out.
  *
- * We also always take a reference to the buffer log item here so that the bli
- * is held while the item is pinned in memory. This means that we can
- * unconditionally drop the reference count a transaction holds when the
- * transaction is completed.
+ * We take a reference to the buffer log item here so that the BLI life cycle
+ * extends at least until the buffer is unpinned via xfs_buf_item_unpin() and
+ * inserted into the AIL.
+ *
+ * We also need to take a reference to the buffer itself as the BLI unpin
+ * processing requires accessing the buffer after the BLI has dropped the final
+ * BLI reference. See xfs_buf_item_unpin() for an explanation.
+ * If unpins race to drop the final BLI reference and only the
+ * BLI owns a reference to the buffer, then the loser of the race can have the
+ * buffer fgreed from under it (e.g. on shutdown). Taking a buffer reference per
+ * pin count ensures the life cycle of the buffer extends for as
+ * long as we hold the buffer pin reference in xfs_buf_item_unpin().
  */
 STATIC void
 xfs_buf_item_pin(
@@ -470,13 +478,30 @@ xfs_buf_item_pin(
 
 	trace_xfs_buf_item_pin(bip);
 
+	xfs_buf_hold(bip->bli_buf);
 	atomic_inc(&bip->bli_refcount);
 	atomic_inc(&bip->bli_buf->b_pin_count);
 }
 
 /*
- * This is called to unpin the buffer associated with the buf log item which
- * was previously pinned with a call to xfs_buf_item_pin().
+ * This is called to unpin the buffer associated with the buf log item which was
+ * previously pinned with a call to xfs_buf_item_pin().  We enter this function
+ * with a buffer pin count, a buffer reference and a BLI reference.
+ *
+ * We must drop the BLI reference before we unpin the buffer because the AIL
+ * doesn't acquire a BLI reference whenever it accesses it. Therefore if the
+ * refcount drops to zero, the bli could still be AIL resident and the buffer
+ * submitted for I/O at any point before we return. This can result in IO
+ * completion freeing the buffer while we are still trying to access it here.
+ * This race condition can also occur in shutdown situations where we abort and
+ * unpin buffers from contexts other that journal IO completion.
+ *
+ * Hence we have to hold a buffer reference per pin count to ensure that the
+ * buffer cannot be freed until we have finished processing the unpin operation.
+ * The reference is taken in xfs_buf_item_pin(), and we must hold it until we
+ * are done processing the buffer state. In the case of an abort (remove =
+ * true) then we re-use the current pin reference as the IO reference we hand
+ * off to IO failure handling.
  */
 STATIC void
 xfs_buf_item_unpin(
@@ -493,24 +518,18 @@ xfs_buf_item_unpin(
 
 	trace_xfs_buf_item_unpin(bip);
 
-	/*
-	 * Drop the bli ref associated with the pin and grab the hold required
-	 * for the I/O simulation failure in the abort case. We have to do this
-	 * before the pin count drops because the AIL doesn't acquire a bli
-	 * reference. Therefore if the refcount drops to zero, the bli could
-	 * still be AIL resident and the buffer submitted for I/O (and freed on
-	 * completion) at any point before we return. This can be removed once
-	 * the AIL properly holds a reference on the bli.
-	 */
 	freed = atomic_dec_and_test(&bip->bli_refcount);
-	if (freed && !stale && remove)
-		xfs_buf_hold(bp);
 	if (atomic_dec_and_test(&bp->b_pin_count))
 		wake_up_all(&bp->b_waiters);
 
-	 /* nothing to do but drop the pin count if the bli is active */
-	if (!freed)
+	/*
+	 * Nothing to do but drop the buffer pin reference if the BLI is
+	 * still active.
+	 */
+	if (!freed) {
+		xfs_buf_rele(bp);
 		return;
+	}
 
 	if (stale) {
 		ASSERT(bip->bli_flags & XFS_BLI_STALE);
@@ -522,6 +541,15 @@ xfs_buf_item_unpin(
 
 		trace_xfs_buf_item_unpin_stale(bip);
 
+		/*
+		 * The buffer has been locked and referenced since it was marked
+		 * stale so we own both lock and reference exclusively here. We
+		 * do not need the pin reference any more, so drop it now so
+		 * that we only have one reference to drop once item completion
+		 * processing is complete.
+		 */
+		xfs_buf_rele(bp);
+
 		/*
 		 * If we get called here because of an IO error, we may or may
 		 * not have the item on the AIL. xfs_trans_ail_delete() will
@@ -538,16 +566,30 @@ xfs_buf_item_unpin(
 			ASSERT(bp->b_log_item == NULL);
 		}
 		xfs_buf_relse(bp);
-	} else if (remove) {
+		return;
+	}
+
+	if (remove) {
 		/*
-		 * The buffer must be locked and held by the caller to simulate
-		 * an async I/O failure. We acquired the hold for this case
-		 * before the buffer was unpinned.
+		 * We need to simulate an async IO failures here to ensure that
+		 * the correct error completion is run on this buffer. This
+		 * requires a reference to the buffer and for the buffer to be
+		 * locked. We can safely pass ownership of the pin reference to
+		 * the IO to ensure that nothing can free the buffer while we
+		 * wait for the lock and then run the IO failure completion.
 		 */
 		xfs_buf_lock(bp);
 		bp->b_flags |= XBF_ASYNC;
 		xfs_buf_ioend_fail(bp);
+		return;
 	}
+
+	/*
+	 * BLI has no more active references - it will be moved to the AIL to
+	 * manage the remaining BLI/buffer life cycle. There is nothing left for
+	 * us to do here so drop the pin reference to the buffer.
+	 */
+	xfs_buf_rele(bp);
 }
 
 STATIC uint
-- 
2.53.0

