Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD061F8691;
	Thu,  1 Oct 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866422; cv=fail; b=s7/R+mDi96fwoJc91f3599FcF2TU7+qsDlvssvTD7qLGsBRTu3Lj0dYBU9lMqX8GH/I1XyFOtkPWzMtbSL7BIHZIyaug+BefkE6QjnwsdFaL/wfhHAlSp1e0Fb7PvXCpXX5c+fSZCK9kfIeig9Vu0xe+bbAH+0m/WbFswOi0LDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866422; c=relaxed/simple;
	bh=/ABxByly2xahCvxnnNK5zTV/rUW/CU2fb118Q//KZfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9bTBimZeaJHP+bJpLevsHkQAY+HNtZKFoLeYIBUBqL5i0nXAOEWmer3XLXqblzIhfp/dT9ITsP0u3rjgpdSQVRzdNAFArz7ulJf/cWOpjfmvXnUGtqz2nP/HjgIyC/tmExXt5Mc30WRbK2Vn/CK0hSvUdszAa80f6owut0nIf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hgPwfLME; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QHk5NZHo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hgPwfLME";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QHk5NZHo"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DNAc52257464;
	Thu, 1 Oct 2026 14:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1Z4IUJsZqIou8LEfjiV+wwFxe0ODmmEk4MjnBWvadgw=; b=
	hgPwfLMEjoQbDCTjESXZTh6McFs6FMNT1Lb8R83YMHHffOvIvmUAEDAH2zsgQLUP
	YIh9kDTK9xpYMGbB/5A+Gw/gNnCkwLEIqDX6lGbAnetoj9wv587YB0OHPM0U+jJy
	jd2y0lLgzt+jh2PjJtzHusDgf9+YJDvZNAa5+3/R5oqpNyZdEqKCWRnrAG+RDGW3
	qzfvwmlRrBKDgIsN5DycRwErCzyMeFk/fhmObUEF9O11MC+T0AYHadvqKkqO+jS4
	M/rkkdcWWMjAnuZtdaK38/ra2NG7Zftzci3U4CpSUF5aMFS+eq2bFDvnOrG4f742
	v5KrHTn7lmKu/RV1cdQFsg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:53:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Enqxd017289;
	Thu, 1 Oct 2026 14:53:35 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey1mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:53:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StzALiA5ol5o9PciZabakf3C+5fpV0Jp1/qFVBSd50g+ZqYwTqAQ8COQvxkc5+hZZVVzmEOu2w57rqlVoVxrk7iJ06SFQu2sdRG3rj7+ky45dOvpk5WDlAq10TYN+fM7JvYXJAVSSrK1Ac6IC8o7GM7OGNWguupTl6pIFrrGIfAb04qe+H8mzp4XwigF7yrdDCmSW4yZZ1gCEi0OzQxSO4OzZ1VcDdvNR+RiJXH/bJmhLLkOFn4CgFthuMgEQ6P1zZ3R4SG4rYKob5nuWfzEGI5dDg1QR6pMKw9kI2AYXWvFcVTF9ESKMb4SW7bNHla6qqCsMCMjGxV42lxaqD2m6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z4IUJsZqIou8LEfjiV+wwFxe0ODmmEk4MjnBWvadgw=;
 b=Ch89jRBz1hgJebCTzYtWVN5CN+1u0Go0GIyA7cZxsORL9i6qMge3RBn0gsX0LIKLPEVi4Muy6GprugpB3Wkik1CJrq0iDuHSHjlUyFhTtzbFoqWatgGx8K3gotomq53IdTjVm4dtDxQgzEFcm8YA6rfFim8wl1uf3wae1wQVSuluIGslNGCp36KBZIdQI2632oJrx825zQM1XqVTo7zFQcz8Q//ByQxjxSe4L1gY2X7gbQpplXw3A/Uv0dh0MqzFP7l2GPDHrWTSvPFbRZmhtWRp1n3X8nDRQCcFxvlLkMGs51tBotye6/LSwwgKJx2yGnctzyoczdoOPlq4FWvhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z4IUJsZqIou8LEfjiV+wwFxe0ODmmEk4MjnBWvadgw=;
 b=QHk5NZHofU0HDHi6hW2yN7uHOjMMRyfJNwpBFdw/lzthPxo2o2lUD0mgq76bbvDBBAU8OkKjc+CXolBpR5xSAnpQ1M4gMXwwiK2qdMK0GREXBACY1WRgN7BhbAhM/zbcbyny99HHZQ7RC43M1QqV2u+orOcRbL/YlwKULZ4CQ+0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:53:29 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:53:29 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 17/21] xfs: catch stale AGF/AGF metadata
Date: Thu,  1 Oct 2026 20:21:30 +0530
Message-ID: <b11672a1833e4454da1cc967efffca8564fe919c.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ba::7) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: e9115707-fbc9-4591-8363-08df1fcbc124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7sWHAOUiBoF8o6k8yZDFfYyMts8qnad3l2aqyIP0qMCUeGPKcaGztAA69P0Nf/C8F8zBncn5NHrmEyNOplhtvXPk/03EOlQ084nxIiqtrTg/fKXCYeLio3/OaHL4tGVH1RTgpmEStmw23NKYUBk6rEEvYKGHFqFk/xcMip5z6+6+syykAFjoHR5kMt2FQdiBn0yCX8aVkaUxQH27NBAx4CBtf/+7IbEuoxuf1XuFl+3Sm9KvHnwrXIt8rXSk0o7yYWlIHe19c4smcXaa4lRjNthx0GI4vlYq2ehYym7pQ/BGd0qvTLrDH0So42a/ur2iL+OsKTgADHBzz51L9wQYdCWpOpyFRqaDNgdGLDkKFzloZNSEBD+LpIR9Bcx0VatQnBjiA8Wk/DeoNJv32D9rBHO2rQQTBR7isCuoQ+OH+OjuygDcYeWTjftDazIwxJ/CN5wmbR9I3uBl70YHIptU+sjAD5I/rckyflgqV0p9JG8BmxJQuBqwIBrRaqU65cOSy9d/eg0EQQHi2Y9Q/WH0qAli4EY/o4K6yIAXYyRvCU+SPzYlcYB809b13MEgMNC2KGId6MGbKL1sxYPu4+RBA8yLa9zoWRbMnowBMj6ddmQQWjPtW57alXsFSlh0d/ej/bPYdtbUE4dNFneweKH0DmXb3cJHFhAy3zELskADs7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ua7ONsKOwkpoM8DJ12s8/oSZsmLfL9fNqJRcODhTCNnrF+sqkDNU+uRYVoN?=
 =?us-ascii?Q?90UfpWHf9tDOIvSi1I7yCKVAP5iW0XwZR9MO0orCi1ylq+66TN3XgjwwqC9w?=
 =?us-ascii?Q?rqlTMSFdY8TgRqAU+O7N3JgeKmbas5On2jaLlGWIKlZdXXy1SN8qAE48SMN5?=
 =?us-ascii?Q?gHVYdFRiD/+ktxrS8g+Gc4KvTt214SVmKiTDuGvly6ML6sWVXCUSktr3Xv+L?=
 =?us-ascii?Q?Fhg5n1hyfeuO9omhGYAUuO1sy8Szv+NmiDGLWO/0V+yb5MYRKiFgzBn7lxD3?=
 =?us-ascii?Q?Ei8i4bGBksfsufNoykzASbUq9ZiMzjFoVtpYabFSCHQEzlYVRUCfngxdjZwh?=
 =?us-ascii?Q?WjP26Xlf2eTIejGisA04ZSHNIrxl8z6H5MZRuvykLObCFKpO4kZhq+WId3yX?=
 =?us-ascii?Q?6xFnJH0wasBZc1FrEXKKMeb8MZrBmdOWQsNOD1kY4b0lDAjmWPD7rldqgSID?=
 =?us-ascii?Q?yibUGYrWVfoBLdJHkUsBrhMdD87zFfKQAcgooWfh7aV/ahsf00sIndoNjfeJ?=
 =?us-ascii?Q?s8hiafYhOavSH+OoGJekkFO1hLdX7teXL4cBkVCQODiMAjuoOuO7sRsVMWWT?=
 =?us-ascii?Q?M1bY9b73vAiTyul1NfrD5j4HK6iX7JZAT8GZpU1jKArljLOmJb+NpjYQcIT2?=
 =?us-ascii?Q?V/rwVuD1RFyvMXyhC2b7RjtIeMB6GfO+MOntfKLMm9iBUYqdCqzr0gxcdog0?=
 =?us-ascii?Q?FuDjSIMgHRF2EsJnmU07h0TKzw6J5DXMTGW/YSjdtGeLG6IzlaMZ1417xeZf?=
 =?us-ascii?Q?jhsls/EG67B24VgMZto2fnfDsgm1EnTrU3RFvVt2K31yqPx6uB7qBNLWDyCp?=
 =?us-ascii?Q?QE/GjARF6pjmqnpMpG2021ELAkLE3Gx8xoMF9XUqmYagWT5xRYv1XmAcTjgB?=
 =?us-ascii?Q?xOh8Ty/mpSzTsIeHjHqToUIuoqeoOE1Xf+GVp2mB2uE3/TreX8lX+ec9lhrI?=
 =?us-ascii?Q?xL4toekpwsH4Qvf8QaT0ctlTtsCnXEmYMPSvZXCLW2yBtdALumoJVDqG1+Ru?=
 =?us-ascii?Q?IA2Wr1m8GKUQKqPNnDYNoQpNqf7magYbuBdPhyCnvvn5+oSNzeaHmhwqu9v+?=
 =?us-ascii?Q?6/RNJfX6bNtFGnUp6r6Peb+jLYRw/oTwfO6m9q+JBH5fTJqTAkR4O3WrE3Um?=
 =?us-ascii?Q?WtJKJv6g06qT8Zr0RbaOuCd67G8xAi9JhQptwWILYWMgfHtIlCODDQ5K7jRI?=
 =?us-ascii?Q?46vrW6oePbt1RZXvjaQ8y0acZAvpsfufkI/XZDtIfl8LN4+2s41sr+UxDL7J?=
 =?us-ascii?Q?ycjVF04DVsURXOlWCgOsIFs+0QjaJvPjCSP0xf4/YCSjZwzXOTKOXNsa2lgF?=
 =?us-ascii?Q?TeDKENSKmgXhZTGvTQoagcEjoq7ixb/THBmBxatu7xKSRmqjpashq4MVzfPO?=
 =?us-ascii?Q?KmFT8c0g+DHMpyX8yWkCX94MEs6TmQgauFSq+ynzsGAWC0KSEsAU92C1touI?=
 =?us-ascii?Q?DE2dZ2aGKdLyLMbOOQLCCBcXYoFzskJt0tG5ELQEZAO83WpUOLXYR6zUekEk?=
 =?us-ascii?Q?RMUAYo1WWaeqrapo6i7cAjrCiz0fUHRzTK+I2ozOnZ9ho7d4lajipDPe72KY?=
 =?us-ascii?Q?HpUGVIUjzB+Tiy1kFizfcGPhoa8lpQB/BHFNDBgqKWfJHoS0Klc4NyvRVF0G?=
 =?us-ascii?Q?cf5VzipQeg/gIFMO1qxWAD8RTGK9CTn9YNKyh0Bjsmiajjx0CIbLp7DiE/q/?=
 =?us-ascii?Q?U/Kh++KvWNgpNnReNz/LVsB55xyenEBHSls992xKZe19smmYOpPbRjv847kx?=
 =?us-ascii?Q?87vzeuP9IAJRm4Sow8L2gYBLXwqvIo+wyngpdV9xbPNcq4XrtNe8StruL08e?=
X-MS-Exchange-AntiSpam-MessageData-1: 8BOu4aWigWgDW3TpuuOoLU+m0MX/KXm+Vgo=
X-Exchange-RoutingPolicyChecked:
	1Pd8pJ5Nlw681yzKIKPKl8QdeLer9Wk4HYmeW9H+Ug4ovI5DDjWPRP6vLyEh7sw1YcmX7xfiSKuilkHTOlTp3oSgrihrupJ1Rwio5oX8naoIlvn255tiTp4pYAfH4tmdQ3n8P+ktrxLSDU/GUEGLmW0VnP1gnv1hENGEMz6tDXN1DoYzd4e2POo96Wjm+D5vcQsT3Opc4p5Eluee/OUNUGAGFijALXspGFivI47eZO7xPFTuGmPma3aHf3ZWrCaHjHNrrNzQP76eKq64NT1egT55BFcfxy3tAN7FeGXXWTUYOrk0ZBWi4xvFCV5EtxBHE65ny7NPYp+QjyPFCLAVeg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uhvR7wL91nlQJvHMwL1GK+LU4uHTCJeeYRJqBOVGMeUSDwdqr168W43gbe7PBec4olN91rBXbJILoCmU6ZNxelO/P4e7T7ypUUiUNmyGcu8GXzkQ+rIErHcj3j6Ymts6k53WWNsniSU4WBK6Q+AIK4Eqch0mg7r82kZfLIu0WLzZJ70IDanvX/utEPAHeRCmBaDN1XzRoPkAAVfJXFEG9tMuSXnQZR7S/mCyE5BHbDwmIxbbt5OhtzfoJ83eG62KtkEmLRYKHuvezNy3sdbV6A5Gq+GAMNIIaDV4gu+T2BwFl67KfRjGb+acEDnuSM49tO8687Z9wi9As3Vg10M/RF04iAhLNjMMqTJ6LMmBbvmKNWzekdp0Uuqw54+KtIlbT6CWK1D4WvCDgh7A874RU4LzthBy5xDYDRy1msburGFyWP22K4p/n9uMq+96zaAO9mYsvyFNPnu9FpVo+fPb5+BwCpUS+O8ZN7dLi+fi/lJcCIr4t1xGW5zzPey2+w4xrZwqpDssChU8HxDTG7NMcqwLyc3vdzGD7VDf6ppa1TokedNhI3gWHA8sxk880d8uHEvNo9bASUF63QPbJW/6fxT79WjpJDeyS8s/IMvoBUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9115707-fbc9-4591-8363-08df1fcbc124
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:53:29.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxmSJAKV6W0rHR0npNkaffZf+7bC085MX/AlmD12UldcvKLlm6RreQPjrJirh1QKcoiAPHMGwyTF+BIb3Edf9WVfkflfW4zhA0XcdxUaAlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6Myb0f5OFwOw
 GbPVW+EqmEzMsyNpnvsCZpqjBl3F4t/4UXXkjk47y0LGW/JCiprUFdm8uaZfY9jwkaAKboANxbU
 0BOStx71nsofdqV7tWy5bh8YN2smgHCyClDZmUrpoFKprLA1zxuq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6sdhhtpovvX5
 BzRWlCiXGL86OKV7CmaU8Ecpota4uJhqkDit2rfpRyO9Nh6wLzhX7kd7oKIe55QQKyqaAESxRUg
 /7kn15SViWtWQWnFGWAjqka81uBBiNOIu1fJdPjeuHa6yAgHEbCeUI1eiePOq+4VqYceO66SMAZ
 NjXjFa6HPxgBi1nvUpzB+PZ6f3eH4B3HXxOii9cuEbkIw6e/Dg/0kdJ2KIGRoinM3zkK4H2jOVo
 Gmnhp/MkCkFfds++3GQn3WnuUxPn4ozN7M5v5Me6LWzPmxUpLz099rC1NZRKkn2Enj/AB3uSbuE
 4DHgHDgSG79+2i+HcwNi/+4JRoigwSZYxEUr59pgCRRAhAZoy8PMlpo7/aYeDja5pS7xYM1S8x8
 6lNihKADjVBrMHFQ4FRY9tyZFftsPDLlLLCWd85RTo7H8+UIQhsxWqXAqA+qoDauLx2eeiaoR26
 D4DciD38552/++il9gg==
X-Proofpoint-ORIG-GUID: TFH7c19k071Q9Nav-oJ8Lyug0AMC7F12
X-Proofpoint-GUID: TFH7c19k071Q9Nav-oJ8Lyug0AMC7F12
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe73f0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pCazNFhamJdtUKLgDfYA:9

From: Dave Chinner <dchinner@redhat.com>

There is a race condition that can trigger in dmflakey fstests that
can result in asserts in xfs_ialloc_read_agi() and
xfs_alloc_read_agf() firing. The asserts look like this:

 XFS: Assertion failed: pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks), file: fs/xfs/libxfs/xfs_alloc.c, line: 3440
.....
 Call Trace:
  <TASK>
  xfs_alloc_read_agf+0x2ad/0x3a0
  xfs_alloc_fix_freelist+0x280/0x720
  xfs_alloc_vextent_prepare_ag+0x42/0x120
  xfs_alloc_vextent_iterate_ags+0x67/0x260
  xfs_alloc_vextent_start_ag+0xe4/0x1c0
  xfs_bmapi_allocate+0x6fe/0xc90
  xfs_bmapi_convert_delalloc+0x338/0x560
  xfs_map_blocks+0x354/0x580
  iomap_writepages+0x52b/0xa70
  xfs_vm_writepages+0xd7/0x100
  do_writepages+0xe1/0x2c0
  __writeback_single_inode+0x44/0x340
  writeback_sb_inodes+0x2d0/0x570
  __writeback_inodes_wb+0x9c/0xf0
  wb_writeback+0x139/0x2d0
  wb_workfn+0x23e/0x4c0
  process_scheduled_works+0x1d4/0x400
  worker_thread+0x234/0x2e0
  kthread+0x147/0x170
  ret_from_fork+0x3e/0x50
  ret_from_fork_asm+0x1a/0x30

I've seen the AGI variant from scrub running on the filesysetm
after unmount failed due to systemd interference:

 XFS: Assertion failed: pag->pagi_freecount == be32_to_cpu(agi->agi_freecount) || xfs_is_shutdown(pag->pag_mount), file: fs/xfs/libxfs/xfs_ialloc.c, line: 2804
.....
 Call Trace:
  <TASK>
  xfs_ialloc_read_agi+0xee/0x150
  xchk_perag_drain_and_lock+0x7d/0x240
  xchk_ag_init+0x34/0x90
  xchk_inode_xref+0x7b/0x220
  xchk_inode+0x14d/0x180
  xfs_scrub_metadata+0x2e2/0x510
  xfs_ioc_scrub_metadata+0x62/0xb0
  xfs_file_ioctl+0x446/0xbf0
  __se_sys_ioctl+0x6f/0xc0
  __x64_sys_ioctl+0x1d/0x30
  x64_sys_call+0x1879/0x2ee0
  do_syscall_64+0x68/0x130
  ? exc_page_fault+0x62/0xc0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Essentially, it is the same problem. When _flakey_drop_and_remount()
loads the drop-writes table, it makes all writes silently fail. Writes
are reported to the fs as completed successfully, but they are not
issued to the backing store. The filesystem sees the successful
write completion and marks the metadata buffer clean and removes it
from the AIL.

If this happens at the same time as memory pressure is occuring,
the now-clean AGF and/or AGI buffers can be reclaimed from memory.

Shortly afterwards, but before _flakey_drop_and_remount() runs
unmount, background writeback is kicked and it tries to allocate
blocks for the dirty pages in memory. This then tries to access the
AGF buffer we just turfed out of memory. It's not found, so it gets
read in from disk.

This is all fine, except for the fact that the last writeback of the
AGF did not actually reach disk. The AGF on disk is stale compared
to the in-memory state held by the perag, and so they don't match
and the assert fires.

Then other operations on that inode hang because the task was killed
whilst holding inode locks. e.g:

 Workqueue: xfs-conv/dm-12 xfs_end_io
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_preempt_disabled+0x15/0x30
  rwsem_down_write_slowpath+0x31a/0x5f0
  down_write+0x43/0x60
  xfs_ilock+0x1a8/0x210
  xfs_trans_alloc_inode+0x9c/0x240
  xfs_iomap_write_unwritten+0xe3/0x300
  xfs_end_ioend+0x90/0x130
  xfs_end_io+0xce/0x100
  process_scheduled_works+0x1d4/0x400
  worker_thread+0x234/0x2e0
  kthread+0x147/0x170
  ret_from_fork+0x3e/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>

and it's all down hill from there.

Memory pressure is one way to trigger this, another is to run "echo
3 > /proc/sys/vm/drop_caches" randomly while tests are running.

Regardless of how it is triggered, this effectively takes down the
system once umount hangs because it's holding a sb->s_umount lock
exclusive and now every sync(1) call gets stuck on it.

Fix this by replacing the asserts with a corruption detection check
and a shutdown.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit db6a2274162de615ff74b927d38942fe3134d298)

6.12:

Fixed conflict due to the following missing commit:
	e9c4d8bfb26c ("xfs: factor out a generic xfs_group structure")

6.6:

Fixed conflict due to the following missing commit:
	e45ea3645178 ("xfs: split the agf_roots and agf_levels arrays")

5.15:

Fixed conflict due to the following missing commits:
	6f643c57d57c ("xfs: implement ->notify_failure() for XFS")
	[Continuous range: a95fee40e3d4^..08d3e84feeb8]
	08d3e84feeb8 ("xfs: pass perag to xfs_alloc_read_agf()")
	76b47e528e3a ("xfs: kill xfs_alloc_pagf_init()")
	99b13c7f0bd3 ("xfs: pass perag to xfs_ialloc_read_agi()")
	a95fee40e3d4 ("xfs: kill xfs_ialloc_pagi_init()")

5.10:

Fixed conflicts due to the following missing commits:

fs/xfs/libxfs/xfs_alloc.c, fs/xfs/libxfs/xfs_ialloc.c:
        75c8c50fa16a ("xfs: replace XFS_FORCED_SHUTDOWN with xfs_is_shutdown")

fs/xfs/libxfs/xfs_ialloc.c:
        9bbafc71919a ("xfs: move xfs_perag_get/put to xfs_ag.[ch]")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  | 45 +++++++++++++++++++++++++++++---------
 fs/xfs/libxfs/xfs_ialloc.c | 34 +++++++++++++++++++++++-----
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 7cb9f064ac64..896cf97fa4a0 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -26,6 +26,7 @@
 #include "xfs_log.h"
 #include "xfs_ag_resv.h"
 #include "xfs_bmap.h"
+#include "xfs_health.h"
 
 extern kmem_zone_t	*xfs_bmap_free_item_zone;
 
@@ -3017,18 +3018,42 @@ xfs_alloc_read_agf(
 		pag->pagf_init = 1;
 		pag->pagf_agflreset = xfs_agfl_needs_reset(mp, agf);
 	}
+
 #ifdef DEBUG
-	else if (!XFS_FORCED_SHUTDOWN(mp)) {
-		ASSERT(pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks));
-		ASSERT(pag->pagf_btreeblks == be32_to_cpu(agf->agf_btreeblks));
-		ASSERT(pag->pagf_flcount == be32_to_cpu(agf->agf_flcount));
-		ASSERT(pag->pagf_longest == be32_to_cpu(agf->agf_longest));
-		ASSERT(pag->pagf_levels[XFS_BTNUM_BNOi] ==
-		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_BNOi]));
-		ASSERT(pag->pagf_levels[XFS_BTNUM_CNTi] ==
-		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_CNTi]));
+	/*
+	 * It's possible for the AGF to be out of sync if the block device is
+	 * silently dropping writes. This can happen in fstests with dmflakey
+	 * enabled, which allows the buffer to be cleaned and reclaimed by
+	 * memory pressure and then re-read from disk here. We will get a
+	 * stale version of the AGF from disk, and nothing good can happen from
+	 * here. Hence if we detect this situation, immediately shut down the
+	 * filesystem.
+	 *
+	 * This can also happen if we are already in the middle of a forced
+	 * shutdown, so don't bother checking if we are already shut down.
+	 */
+	if (!XFS_FORCED_SHUTDOWN(mp)) {
+		bool	ok = true;
+
+		ok &= pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks);
+		ok &= pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks);
+		ok &= pag->pagf_btreeblks == be32_to_cpu(agf->agf_btreeblks);
+		ok &= pag->pagf_flcount == be32_to_cpu(agf->agf_flcount);
+		ok &= pag->pagf_longest == be32_to_cpu(agf->agf_longest);
+		ok &= pag->pagf_levels[XFS_BTNUM_BNOi] ==
+		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_BNOi]);
+		ok &= pag->pagf_levels[XFS_BTNUM_CNTi] ==
+		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_CNTi]);
+
+		if (XFS_IS_CORRUPT(mp, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGF);
+			xfs_trans_brelse(tp, *bpp);
+			*bpp = NULL;
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			return -EFSCORRUPTED;
+		}
 	}
-#endif
+#endif /* DEBUG */
 	return 0;
 }
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 8fcb5c6810e9..3f0cfb50f61e 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -27,6 +27,7 @@
 #include "xfs_trace.h"
 #include "xfs_log.h"
 #include "xfs_rmap.h"
+#include "xfs_health.h"
 
 /*
  * Lookup a record by ino in the btree given by cur.
@@ -2034,7 +2035,7 @@ xfs_difree_inobt(
 			goto error0;
 		}
 
-		/* 
+		/*
 		 * Change the inode free counts and log the ag/sb changes.
 		 */
 		be32_add_cpu(&agi->agi_freecount, 1);
@@ -2657,12 +2658,35 @@ xfs_ialloc_read_agi(
 		pag->pagi_init = 1;
 	}
 
+#ifdef DEBUG
 	/*
-	 * It's possible for these to be out of sync if
-	 * we are in the middle of a forced shutdown.
+	 * It's possible for the AGF to be out of sync if the block device is
+	 * silently dropping writes. This can happen in fstests with dmflakey
+	 * enabled, which allows the buffer to be cleaned and reclaimed by
+	 * memory pressure and then re-read from disk here. We will get a
+	 * stale version of the AGF from disk, and nothing good can happen from
+	 * here. Hence if we detect this situation, immediately shut down the
+	 * filesystem.
+	 *
+	 * This can also happen if we are already in the middle of a forced
+	 * shutdown, so don't bother checking if we are already shut down.
 	 */
-	ASSERT(pag->pagi_freecount == be32_to_cpu(agi->agi_freecount) ||
-		XFS_FORCED_SHUTDOWN(mp));
+	if (!XFS_FORCED_SHUTDOWN(mp)) {
+		bool	ok = true;
+
+		ok &= pag->pagi_freecount == be32_to_cpu(agi->agi_freecount);
+		ok &= pag->pagi_count == be32_to_cpu(agi->agi_count);
+
+		if (XFS_IS_CORRUPT(mp, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGI);
+			xfs_trans_brelse(tp, *bpp);
+			*bpp = NULL;
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			return -EFSCORRUPTED;
+		}
+	}
+#endif /* DEBUG */
+
 	return 0;
 }
 
-- 
2.53.0

