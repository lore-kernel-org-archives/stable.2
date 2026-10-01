Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DA52CCD6;
	Thu,  1 Oct 2026 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866597; cv=fail; b=mEhL8jfFhhMy9jqNQ3KljJzKP7uU3iQV3SMC1Thrx6RR/WZAG1lvfM+UKLtt5wvWnjNYQqLQpr4lFcQiB6ORFRY/UHfsjssa+SLG1KJZoYLMDIwjieLF6husLWity9xOR9QaNwuN0rd3NOHvGMbTQcd9QmREFBqRbpE0du1Jb04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866597; c=relaxed/simple;
	bh=FnouRMAkVnBnDo2kJE0FjhqCypjNM9XHCNKQYbUUxp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lVj5j2Yqgk/RksRITx/Me1XFjZdWhxhe/PqYhg2JhvAAaT/jOQgu6xkBpO1E9L8Z3Tv8fRusSTsCXGzfkc8qTgyJ1B88b8CWPhHHfrLbSeyN5bqNAB//rmIx5TAf7ySbVKxpCwz5B6iYKYPzqXrR+g00LrBKjhh10oyMwMm2utY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SnMadZ/4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HSpfwRyY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SnMadZ/4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HSpfwRyY"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMqkw3078427;
	Thu, 1 Oct 2026 14:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=J8gKUyY0ydZtG3hCg51+mMkIOD3Yw8nsubLLmF47ho0=; b=
	SnMadZ/40MLG1yGOidvDH5TGP4iN1f9FivVWS7pQdT847KVopFHFVgot2U/BQXyl
	Pp/7xoe9OB/Eav6Gzpilz0N2mutT8U8ezr61tLtchCt3cQ+TOk9MrUjeQAlyK+E8
	xSBtXC5dT1wbBXnGOf7C6yk/BsWv6ifXhGHOT70k1kpesWj6YmHYIwCdGctY71jo
	i3kR/fdQi/cTEraZ/Iu73F4Q18bkVMNHcNWsW/6qOWjigVwUMVfp9fureRtR00lW
	0/3v5XX95yXJORbIo3AK/FPRc0qVAaxslIcoDmO6j6nCCP5XpLmQ07L2bvCzZFSE
	8TcUQ0dWEJQ2vMNfyKlATA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4myh8fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:56:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Enq2u017301;
	Thu, 1 Oct 2026 14:56:22 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey578-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:56:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Na9Olh5fux8oZyfbQ20GOudC0x6VxrQl20mI9aPFI6bssdeWhRC/0OJ5i3DGgwXBOsGIF50kUt/5B2nNOMnugf+Xb1wjHesugrfn67wuBtt1TiJri3BfD8x7D2Tn1F1HJLcOiQZVRAaxUxGRCNIryuohPAQ9YE2bd57GlVOYU70QLoYua4sBnf0mfLpMZbI7PuLm2+OW3F7FpQgYON3lnJ9nq6y3c7Q9Dk1GMJOgZdtEQGs5ORMgC6y9yqtc4Hbv7CPk/vduw+hl41k+bWixZj+OlUjX26EeHlzMmocrj6OSMzhS+IrbQrZ2BWTcXZcNxwJd1peUOf5SGT7zkseLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8gKUyY0ydZtG3hCg51+mMkIOD3Yw8nsubLLmF47ho0=;
 b=k4IAy82192xZ+yb9diu3vsvNGc0wMnrsMBk3ntodpN2s0Uyn27iqfYp2BrG2zGY5y/j8zYX0Osgpuv4GAw8b0U2g/XHdnJhbm/1q4hK8Ju9KAQ4lmG95LBR42p9S65MDUwjCc/3X6odpsq59jqoDVQ9pBDyJnC7N70zx0PTSqdz01yoIedPr30MwOKSD19/xuIbwydh1LE6LwW+YSbFBhaPWkh067l2u264VJHZFZ4C77VtE6tjtncuOZxDzyl88rxx8A1pe3+4hf33rv2nn0YMrC+Uu+gw2rvAdIU11pkUtlaRBzPIqMRXaG14S0lPT6r+i+8MnDJ9TdNfI0YXOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8gKUyY0ydZtG3hCg51+mMkIOD3Yw8nsubLLmF47ho0=;
 b=HSpfwRyYrlA1iZLBYee1ZvBtbiNh031BavX9GDkcql+yWcXDTrfy1x5kLcFB4LskuDCockWPO55AC9TgqTnl818f5WeRD9DTFxjYh1W/SB4MzDaX0MzQwzESz2dBVfYjUW8ua2tzhj8y3T8QOwpFMv6O84peAaKuMRJkpELWoto=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 MW5PR10MB5763.namprd10.prod.outlook.com (2603:10b6:303:19c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 1 Oct 2026 14:56:17 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:56:17 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 21/21] xfs: fix unmount hang with unflushable inodes stuck in the AIL
Date: Thu,  1 Oct 2026 20:21:34 +0530
Message-ID: <4123a24e8a0f5b450d7bce4a9c5736e042a97f08.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b7::8) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|MW5PR10MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: d71b107e-4085-4332-ad62-08df1fcc2561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|376014|1800799024|5023799004|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hT5VGBfW6kF5vFCAJDfUzcvIKWI3z7URikZvqKDQ3uiF+QJY+P0sFNRkKuXSz3FFzJGxGUl5OTYhXl8AhF5OBe9A5y8HYPICzCoKO9lmkDQdL8K+NDY25Pr0wEEWCJZrivtMB6Lk0/Ln/r7Hf/0lIIb7hXCNCMhkgly4SrlZa5ffUm3zWm2sHQkpPE0ivasxcPyCyJrh33h6QtLJaDlsU1vCekhYcTgm/XZkHES40bSA0GkxLpmsbIoEbmP5S7UTjsXm0Erq8Z6Iwwu8hWJmpkVbowyb9p5fkrIABqBNTWzCVRfx+iCw07LTRMG0z/r57bnCeNYs75e4QD/S5enWU5+oPMMTb8R4nEHbQgtzD+VOYMVw8B+5iELWLykfw71UonCbNbZdpYNGbkNMP6NmFYxTmtLSnz0pOBph0vNvpTsQ56ePgrX1Km7ijHfkeem/R8mhiINTMWSX41O/yMDfB/SIBkP8GyNoytUe2r2+6e5Ir4B/nX8khmY8drn7cdRrUCKVNu8oPyC6d9YHU8hgzLJsRH6uAJ4t63f7YzdjOjP0M/xudllNVm+zYFFobTA54957ZJoLkcemf2kQp4Pis+tMRgq4NBd5oU894CkblwsoCFw6ik2XpSmZ1j3L6XYDe9h2OcWOIi9Qpz5JH111iQlp1+qkp+ieT2Cvq5O39FE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jw+/vWeYama+iukwpSqrZ5lGLaX71lgHxVGnCsl4+9KYQzmxx/4FnlZXZAOE?=
 =?us-ascii?Q?Mvn6d0/mL/wnneV+b/NI6SbHls5FUGi9DNk0tE2NpR+l3wuTtk0lIrZBKmMn?=
 =?us-ascii?Q?kzqVn9/RPnuOftzb/3oNQW8tICdIYTPyK+AqTPOTdX4QcgBwXWK61vnUvWn/?=
 =?us-ascii?Q?cKC7NuE1M9yZ7XQZS8FGJddgbKGI7bUEMLocBe6bcmGcr4yCU231IT+XV+gT?=
 =?us-ascii?Q?/ZZESK/guIa36bAIjeHx1S5fk4kRSo6/ab8d07jMA/qR3VV25DLzte4FMsC5?=
 =?us-ascii?Q?yUqkHWnvo8kkKxpg1HAeYt9+F5pILxvtdo15vukJ/5CnU4nKSkXIifjgtIhF?=
 =?us-ascii?Q?VfQoFsQSEI/zUNHghHijGnb1LmRxbZKY3FsxzNRC5J9+f73jOkk+ivh+mauZ?=
 =?us-ascii?Q?4W2ptNyQ1kUGRiwDPg75Npx0bHVatMt7c4743p4z5uePYvTPFoJdKvM4dqPr?=
 =?us-ascii?Q?8KQo8zqlaJAWapYSHG83/8x0jVcO7ZqSGxSX5tfjOPxqUk9nxX0P9Yhcy0gx?=
 =?us-ascii?Q?Xe2ICzqPajFYUbedl+yStnSbu13+kHyzfThd86NtmbXcda7BJGimQEx/kbk2?=
 =?us-ascii?Q?y4MVzTtbYgM5N5YKMlnI4SwqYjBsep1tIJCKJFXuF/YuwEcpv38+koKZuHpa?=
 =?us-ascii?Q?oSp+kSLvY707mSxkEnCuyUvlLY3E7i1f25e1Q8GV53vy0ZXeKIjqZPbuu9Is?=
 =?us-ascii?Q?b9RES9BJ9oboUyXLzRB4QYiSzW0qq2ChU2DtyvkaVoEB0Z96HoLK1vbh9zpT?=
 =?us-ascii?Q?vQEtqgD19JZGuDHW+p3IYbCSs0pCs+539nQPeM1NmHgVpMY7nwJB4tuOcWXS?=
 =?us-ascii?Q?z71bMwgYfgitG1qo8SFZH6d3pexK7sYM8J7Kqglad3ylFKGmS4gQhX8dCfc0?=
 =?us-ascii?Q?xT/S7zjSUj6LhbBVvP14LgqCl9/rhqHHoFAK4K7rGELfs567uwiUahn09iuq?=
 =?us-ascii?Q?X7je9hOL0b6AAwkBxaVpmuF84ds0nHV4DW+4VRDCLshZPLKw354XtWiy4Xjm?=
 =?us-ascii?Q?385fUcONF707/SCcWcUsoFU9MKp1JmTTeMhHkJnjsin6rJgqL+uncEWoqdYe?=
 =?us-ascii?Q?MRmSwmg/1SIIk/MoDEjF2+9+uFPZOF/ylWz3RxQ+u6m/nxCNhLM8rek4JZly?=
 =?us-ascii?Q?/OTvZ9ZobXsJEMosPgImwwkcPOkOluSltjUWQOS5XttMTlmLVaCh13ucro1d?=
 =?us-ascii?Q?fmGTBwX9VvwfUjsIHzOssP/uBLDKkDMjK+uUiom9WqvLMcjZEv4vcJyKgiO3?=
 =?us-ascii?Q?TBKEdpWivxy0dSKI/hpIx4PWKBYGvTvS4htTddwfRluwSXoWo1KhUxdm4f8O?=
 =?us-ascii?Q?HnnUOwULEefa5Y+fDVQ5FEbWAI4uWA7ArUbyiDZ3H8d8hGt0n9EBpL/OB+/d?=
 =?us-ascii?Q?hzqykFeG+fuElR9OPObpQa/gB+Dd2H+tjRIG1WTKAFmQvecsOTcZ0fBY/l7S?=
 =?us-ascii?Q?Gj7jL2HF1K9Mm6zsbcrwk9LjcLtUNSeEaadc/l9mj4SdSwIOgrAuzsxq0MCJ?=
 =?us-ascii?Q?ckGc6+W8e6sbeFoz4djSXsHUZdWJ/tQnvSLc8+lGuMYCWueXpzjxRJ4+Vafh?=
 =?us-ascii?Q?zZVvu7DoeWJVjgqvDoPHoPMnKzKT3UdPSwgBJxj53i0SHzj6bpRN/pboRkTV?=
 =?us-ascii?Q?Accsc0GNADpiTz61O+Wm3XwSOGlSzWCb1L6j8/tLIQW0Acxl8M1UJsy2cSGf?=
 =?us-ascii?Q?96X+BQDIquuZZdNao9PHoLlKR2jlqYNpuJhCIAIHRsbBOMTfP3YVmBtBR1mU?=
 =?us-ascii?Q?W9VBO3Lvrfz1ik+QD5jsgQ4+w3o7VqMRwX1r6aSJu1CMcMQSAFM2G+p6N0Gg?=
X-MS-Exchange-AntiSpam-MessageData-1: 9te/FMOiFU0n3BjymS3l676eB9Uqni0nga0=
X-Exchange-RoutingPolicyChecked:
	Sh3+356C2Gg4wzhf+rjrxBrFKcMzfjsTf2MG58sHMWRJs013MxDtZTAsgXTnYOqxw00SKNVjb7uIoI9RLE4sCCH79+nevfQJy0YHeP/yfanuj4ZFcb3M0z/C1M4LWbqNtRAF1qeTNJLBiOm+HftjkhaUNTivdsw4AH/vwwEmyP0MFejDbC9Glt3w3TPlDk37rcFby683cdvlk/KCK20nkbg348/sqHVhAq7gJmQCJa1t99OqC0za5lbf1IKM4CMiwPTX14dmcs9lHijux1ORucZLuRZ3h5PG+ruC6BnkzknA2UQ0wEm2hEk84gAZXG9zs5/jFDvx1txNM+/Q1USxTA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jf0OSqdRdaF/zrbnw0a2hmIVv5LJgaaUa5sZIq1Urz0Y7mFZ8nvmvF95eHotnMTXNEgw804spttzpgYjp5rJGR9Fthf6jg+QfluJed7DymAJyUOEfKJ1RbvLHuEIp8lEABkKkXTxt7dYSgBLgojtQcQMxkgG3ONK9fJZy0Y1QTOj972gPltQmNkBTINm3HljVYNgpHUAKDLzQAj+xZcrwrV15+RY7+9U0D5f+e58j2WfCoP3uXmYFntHhmc2e+ktooLrhCGYu4nMlYdhgfg7HVjvbYl0lMQlf+mcw8ZKGkHdryzBuGELsMt8pGYSzwsU7kwNeHYttyMc/78ubpn09V0VoLv0v6Uqoqq6/LQwsUo7E2GjDv3jC/Q6cn1BRcdFFWPIZzmvEV3b1LclrwPdngAX30MF6KFGH/LdB8U9DrYbKmw9uLWFsKfQjcp2FATJcdA1CFpmzM+ZKm6Tke+dMJglYCE7ZTErmu4o2lb5+zw52fQsGRHCXXong80QUkxxFCBfgYekpj0lbmpiQplp5jYb99FJPJuxH6YpdP14rzxgN3NUuc/izQEm57qrcMXOKts3ycj1wQBnGRbSQHuRV/fVSmy9LoNu74xPrYgXXXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71b107e-4085-4332-ad62-08df1fcc2561
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:56:17.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu2VSYJ8bvWwXk6DZruZZtACRfWYWfL+4Z9qgZqfxh7k1XxnX0M7ZP2F0VE6wy/s510+87GIcOJnakV58tH2RdUiVMed/xuxHTx/yvYDC1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX72Apv1Urq1hV
 xf5yFfYuywhMOP3+MxZLgam1Tcgqmj1Z+R/S3WE0yMqYdRGpAAXQ0kxguTqLBban0TRIxEXkFiJ
 tFEbdCi/83spbpEIRGRWRr/zZvx4eoKCA81eiINeqQMat9JnOXpA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXwrdzE/EfUu0f
 aHawx1s6R49F8m46bhvKYxx0yrQM/lITYJIRd9d+2Tn23WGuRz0Xcasap0kSS0PbM8W2vxl6XwJ
 axxG5TE0FCY9J9N98nIAYL1nSZkgsvbjs1xmfaKBaoeAW4QOp/6Ip3n2LsbcDVTMXQHWbhLI2vt
 w+QR+lFMd/huuQIbJWd3EXl4oM/lqMtT3H00eWXQxYOfqhcSlO4iva4T+quZQLDM6v/SGxykb+2
 ts4805UxKK+RV/Rbkv7KQvgDt1n9Y6kUThJImHuKBRcqd0vgcv7h/3iqQwQ1VgE8CQtJ+WKvYt3
 lMYTE4Qb/Ass6PKVAlwy0GkrZaMB6YCmWdEx/z/c53YmsGmxZ5XfJKCAEQcg0kiirT/chYL3twd
 pQPTn88JvyAKEzGayysUFiXNiH6kEYOL+2GeMqrE9lC9KGWbsTe1qC32CkUXM4bErG/xvgp3Orx
 UFEmMjpRSV5fW1nsyGw==
X-Proofpoint-GUID: NTa105H5zcdaSuoJ4vci44XE-UsbPnnP
X-Authority-Analysis: v=2.4 cv=DZmCOftW c=1 sm=1 tr=0 ts=6abe7497 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=kGPDooFuvBrjL3bSUbYA:9
X-Proofpoint-ORIG-GUID: NTa105H5zcdaSuoJ4vci44XE-UsbPnnP

From: Dave Chinner <dchinner@redhat.com>

Unmount of a shutdown filesystem can hang with stale inode cluster
buffers in the AIL like so:

[95964.140623] Call Trace:
[95964.144641]  __schedule+0x699/0xb70
[95964.154003]  schedule+0x64/0xd0
[95964.156851]  xfs_ail_push_all_sync+0x9b/0xf0
[95964.164816]  xfs_unmount_flush_inodes+0x41/0x70
[95964.168698]  xfs_unmountfs+0x7f/0x170
[95964.171846]  xfs_fs_put_super+0x3b/0x90
[95964.175216]  generic_shutdown_super+0x77/0x160
[95964.178060]  kill_block_super+0x1b/0x40
[95964.180553]  xfs_kill_sb+0x12/0x30
[95964.182796]  deactivate_locked_super+0x38/0x100
[95964.185735]  deactivate_super+0x41/0x50
[95964.188245]  cleanup_mnt+0x9f/0x160
[95964.190519]  __cleanup_mnt+0x12/0x20
[95964.192899]  task_work_run+0x89/0xb0
[95964.195221]  resume_user_mode_work+0x4f/0x60
[95964.197931]  syscall_exit_to_user_mode+0x76/0xb0
[95964.201003]  do_syscall_64+0x74/0x130

$ pstree -N mnt |grep umount
	     |-check-parallel---nsexec---run_test.sh---753---umount

It always seems to be generic/753 that triggers this, and repeating
a quick group test run triggers it every 10-15 iterations. Hence it
generally triggers once up every 30-40 minutes of test time. just
running generic/753 by itself or concurrently with a limited group
of tests doesn't reproduce this issue at all.

Tracing on a hung system shows the AIL repeating every 50ms a log
force followed by an attempt to push pinned, aborted inodes from the
AIL (trimmed for brevity):

 xfs_log_force:   lsn 0x1c caller xfsaild+0x18e
 xfs_log_force:   lsn 0x0 caller xlog_cil_flush+0xbd
 xfs_log_force:   lsn 0x1c caller xfs_log_force+0x77
 xfs_ail_pinned:  lip 0xffff88826014afa0 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff88814000a708 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff88810b850c80 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff88810b850af0 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff888165cf0a28 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff88810b850bb8 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 ....

The inode log items are marked as aborted, which means that either:

a) a transaction commit has occurred, seen an error or shutdown, and
called xfs_trans_free_items() to abort the items. This should happen
before any pinning of log items occurs.

or

b) a dirty transaction has been cancelled. This should also happen
before any pinning of log items occurs.

or

c) AIL insertion at journal IO completion is marked as aborted. In
this case, the log item is pinned by the CIL until journal IO
completes and hence needs to be unpinned. This is then done after
the ->iop_committed() callback is run, so the pin count should be
balanced correctly.

Yet none of these seemed to be occurring. Further tracing indicated
this:

d) Shutdown during CIL pushing resulting in log item completion
being called from checkpoint abort processing. Items are unpinned
and released without serialisation against each other, journal IO
completion or transaction commit completion.

In this case, we may still have a transaction commit in flight that
holds a reference to a xfs_buf_log_item (BLI) after CIL insertion.
e.g. a synchronous transaction will flush the CIL before the
transaction is torn down.  The concurrent CIL push then aborts
insertion it and drops the commit/AIL reference to the BLI. This can
leave the transaction commit context with the last reference to the
BLI which is dropped here:

xfs_trans_free_items()
  ->iop_release
    xfs_buf_item_release
      xfs_buf_item_put
        if (XFS_LI_ABORTED)
	  xfs_trans_ail_delete
	xfs_buf_item_relse()

Unlike the journal completion ->iop_unpin path, this path does not
run stale buffer completion process when it drops the last
reference, hence leaving the stale inodes attached to the buffer
sitting the AIL. There are no other references to those inodes, so
there is no other mechanism to remove them from the AIL. Hence
unmount hangs.

The buffer lock context for stale buffers is passed to the last BLI
reference. This is normally the last BLI unpin on journal IO
completion. The unpin then processes the stale buffer completion and
releases the buffer lock.  However, if the final unpin from journal
IO completion (or CIL push abort) does not hold the last reference
to the BLI, there -must- still be a transaction context that
references the BLI, and so that context must perform the stale
buffer completion processing before the buffer is unlocked and the
BLI torn down.

The fix for this is to rework the xfs_buf_item_relse() path to run
stale buffer completion processing if it drops the last reference to
the BLI. We still hold the buffer locked, so the buffer owner and
lock context is the same as if we passed the BLI and buffer to the
->iop_unpin() context to finish stale process on journal commit.

However, we have to be careful here. In a shutdown state, we can be
freeing dirty BLIs from xfs_buf_item_put() via xfs_trans_brelse()
and xfs_trans_bdetach().  The existing code handles this case by
considering shutdown state as "aborted", but in doing so
largely masks the failure to clean up stale BLI state from the
xfs_buf_item_relse() path. i.e  regardless of the shutdown state and
whether the item is in the AIL, we must finish the stale buffer
cleanup if we are are dropping the last BLI reference from the
->iop_relse path in transaction commit context.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 7b5f775be14ac1532c049022feadcfe44769566d)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 121 +++++++++++++++++++++++++++++-------------
 fs/xfs/xfs_buf_item.h |   2 +-
 2 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 22a231ffde2d..166d81d80a0c 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -625,43 +625,42 @@ xfs_buf_item_push(
  * Drop the buffer log item refcount and take appropriate action. This helper
  * determines whether the bli must be freed or not, since a decrement to zero
  * does not necessarily mean the bli is unused.
- *
- * Return true if the bli is freed, false otherwise.
  */
-bool
+void
 xfs_buf_item_put(
 	struct xfs_buf_log_item	*bip)
 {
-	struct xfs_log_item	*lip = &bip->bli_item;
-	bool			aborted;
-	bool			dirty;
+
+	ASSERT(xfs_buf_islocked(bip->bli_buf));
 
 	/* drop the bli ref and return if it wasn't the last one */
 	if (!atomic_dec_and_test(&bip->bli_refcount))
-		return false;
+		return;
 
-	/*
-	 * We dropped the last ref and must free the item if clean or aborted.
-	 * If the bli is dirty and non-aborted, the buffer was clean in the
-	 * transaction but still awaiting writeback from previous changes. In
-	 * that case, the bli is freed on buffer writeback completion.
-	 */
-	aborted = test_bit(XFS_LI_ABORTED, &lip->li_flags) ||
-			xlog_is_shutdown(lip->li_log);
-	dirty = bip->bli_flags & XFS_BLI_DIRTY;
-	if (dirty && !aborted)
-		return false;
+	/* If the BLI is in the AIL, then it is still dirty and in use */
+	if (test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags)) {
+		ASSERT(bip->bli_flags & XFS_BLI_DIRTY);
+		return;
+	}
 
 	/*
-	 * The bli is aborted or clean. An aborted item may be in the AIL
-	 * regardless of dirty state.  For example, consider an aborted
-	 * transaction that invalidated a dirty bli and cleared the dirty
-	 * state.
+	 * In shutdown conditions, we can be asked to free a dirty BLI that
+	 * isn't in the AIL. This can occur due to a checkpoint aborting a BLI
+	 * instead of inserting it into the AIL at checkpoint IO completion. If
+	 * there's another bli reference (e.g. a btree cursor holds a clean
+	 * reference) and it is released via xfs_trans_brelse(), we can get here
+	 * with that aborted, dirty BLI. In this case, it is safe to free the
+	 * dirty BLI immediately, as it is not in the AIL and there are no
+	 * other references to it.
+	 *
+	 * We should never get here with a stale BLI via that path as
+	 * xfs_trans_brelse() specifically holds onto stale buffers rather than
+	 * releasing them.
 	 */
-	if (aborted)
-		xfs_trans_ail_delete(lip, 0);
+	ASSERT(!(bip->bli_flags & XFS_BLI_DIRTY) ||
+			test_bit(XFS_LI_ABORTED, &bip->bli_item.li_flags));
+	ASSERT(!(bip->bli_flags & XFS_BLI_STALE));
 	xfs_buf_item_relse(bip);
-	return true;
 }
 
 /*
@@ -682,6 +681,15 @@ xfs_buf_item_put(
  * if necessary but do not unlock the buffer.  This is for support of
  * xfs_trans_bhold(). Make sure the XFS_BLI_HOLD field is cleared if we don't
  * free the item.
+ *
+ * If the XFS_BLI_STALE flag is set, the last reference to the BLI *must*
+ * perform a completion abort of any objects attached to the buffer for IO
+ * tracking purposes. This generally only happens in shutdown situations,
+ * normally xfs_buf_item_unpin() will drop the last BLI reference and perform
+ * completion processing. However, because transaction completion can race with
+ * checkpoint completion during a shutdown, this release context may end up
+ * being the last active reference to the BLI and so needs to perform this
+ * cleanup.
  */
 STATIC void
 xfs_buf_item_release(
@@ -689,18 +697,19 @@ xfs_buf_item_release(
 {
 	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
 	struct xfs_buf		*bp = bip->bli_buf;
-	bool			released;
 	bool			hold = bip->bli_flags & XFS_BLI_HOLD;
 	bool			stale = bip->bli_flags & XFS_BLI_STALE;
-#if defined(DEBUG) || defined(XFS_WARN)
-	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
-	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
 	bool			aborted = test_bit(XFS_LI_ABORTED,
 						   &lip->li_flags);
+	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
+#if defined(DEBUG) || defined(XFS_WARN)
+	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
 #endif
 
 	trace_xfs_buf_item_release(bip);
 
+	ASSERT(xfs_buf_islocked(bp));
+
 	/*
 	 * The bli dirty state should match whether the blf has logged segments
 	 * except for ordered buffers, where only the bli should be dirty.
@@ -716,16 +725,56 @@ xfs_buf_item_release(
 	bp->b_transp = NULL;
 	bip->bli_flags &= ~(XFS_BLI_LOGGED | XFS_BLI_HOLD | XFS_BLI_ORDERED);
 
+	/* If there are other references, then we have nothing to do. */
+	if (!atomic_dec_and_test(&bip->bli_refcount))
+		goto out_release;
+
+	/*
+	 * Stale buffer completion frees the BLI, unlocks and releases the
+	 * buffer. Neither the BLI or buffer are safe to reference after this
+	 * call, so there's nothing more we need to do here.
+	 *
+	 * If we get here with a stale buffer and references to the BLI remain,
+	 * we must not unlock the buffer as the last BLI reference owns lock
+	 * context, not us.
+	 */
+	if (stale) {
+		xfs_buf_item_finish_stale(bip);
+		xfs_buf_relse(bp);
+		ASSERT(!hold);
+		return;
+	}
+
+	/*
+	 * Dirty or clean, aborted items are done and need to be removed from
+	 * the AIL and released. This frees the BLI, but leaves the buffer
+	 * locked and referenced.
+	 */
+	if (aborted || xlog_is_shutdown(lip->li_log)) {
+		ASSERT(list_empty(&bip->bli_buf->b_li_list));
+		xfs_buf_item_done(bp);
+		goto out_release;
+	}
+
+	/*
+	 * Clean, unreferenced BLIs can be immediately freed, leaving the buffer
+	 * locked and referenced.
+	 *
+	 * Dirty, unreferenced BLIs *must* be in the AIL awaiting writeback.
+	 */
+	if (!dirty)
+		xfs_buf_item_relse(bip);
+	else
+		ASSERT(test_bit(XFS_LI_IN_AIL, &lip->li_flags));
+
+	/* Not safe to reference the BLI from here */
+out_release:
 	/*
-	 * Unref the item and unlock the buffer unless held or stale. Stale
-	 * buffers remain locked until final unpin unless the bli is freed by
-	 * the unref call. The latter implies shutdown because buffer
-	 * invalidation dirties the bli and transaction.
+	 * If we get here with a stale buffer, we must not unlock the
+	 * buffer as the last BLI reference owns lock context, not us.
 	 */
-	released = xfs_buf_item_put(bip);
-	if (hold || (stale && !released))
+	if (stale || hold)
 		return;
-	ASSERT(!stale || aborted);
 	xfs_buf_relse(bp);
 }
 
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index e3ccbf3ca801..c39202c0135a 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -51,7 +51,7 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-bool	xfs_buf_item_put(struct xfs_buf_log_item *);
+void	xfs_buf_item_put(struct xfs_buf_log_item *bip);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
 void	xfs_buf_inode_iodone(struct xfs_buf *);
-- 
2.53.0

