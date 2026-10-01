Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07D524B00;
	Thu,  1 Oct 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866306; cv=fail; b=BQReUFuwgH26KOcLQEnoWRVyl7ANVBNaV40KMBZSlxAj8E1kSmMW5wkBxTZ+Z+o2bLTan+Fhx1yAu+tTtJEzeqYeoDtIyYf6XknkT0UJ/abglnkS0DV7qhSXAcaAZd8delrEspZj2wt5GQJaXUiFwWh/dd1dNeqjndRMLDNqmO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866306; c=relaxed/simple;
	bh=YLsDzitQefeC/0orD1ScpepUSkPilqgP4sd5u5kiX80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBnqNdIwC0Z2w9h0I9E2dydcIJnlIRl5r5JPPNAQPaWCsTIXYbhq3UAYrhT+64wfp693E7wlutpF2MUhgoAU2v0j0BOGAPCVVaC8oZ3TTdd07Ywbp4rr7OETYMfDDRDeUZiLPjGqsLKQP57qJ26OtEiMJW4ULMbS//H/m3FHR50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iHPseVr7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ogFZziHG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iHPseVr7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ogFZziHG"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DNAbl2257464;
	Thu, 1 Oct 2026 14:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OI3MJJMEfAUrmdHmqL+vEVJLJj1wNcJT3OAQvg3GyIo=; b=
	iHPseVr7GVv/PoJC1R3seY0fSNGKRqyl/fw2HvDG9pYNDdAdWHXYFF2P74VbAp+c
	3axq+xiry8BsG7V3SKegaSR8xV+6DsyepmlKClkBlPtQMxIRDIbaMqdTac/BM6vR
	maf31SH5FotNrFK7BvJRcPcdavirHWyRGHmzkMjbwX51MIg6LSbrQLIKsjhvX4UA
	plqopu2+xIU7c1bYM8caADUqWTri3S8RL/Qu0SGVM8Kstz3O+RZF4BBBGZFKaXwW
	WXMc9SWqEtsaBDOZhAxdqJO8CUJTDQQLMLpfBYg7fw+LYX4PASYLtYT+QMpr/rRz
	3eklPyP5SUdTMfJiW28Fzg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo4qo011777;
	Thu, 1 Oct 2026 14:51:26 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxrqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+SHvRcPqhpSy7TY4c73yDoVO4K4uTDxY4/uhjMus2uW8tD2DPja5uLPd6FCAwvH3N64HqXf5PwxjxQmKu+D3TO5/cVqU21lZ7JHIVLLoVpJXYcgpJnJAiI1XQE6j4clmav+IfRMfKEZjs6vP0B4foZ2NJLM0Lr3QXxFaqR/bzcD9jSPJ/XTzFbZjaUhti4VvS69aWkbwOGyVbtUgjqVCSzb6QwAdG8Oi/cLqeiQGdQan4cgbJbTmSUZjRELVhdqloI5d940BHGeiYfN9VkR1Kgak1JSRr6wcKa6xnfeWtwF7jGb1Yw0qrsV0y0lDG9vpR/TmE45VGH9u6lCJNC+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI3MJJMEfAUrmdHmqL+vEVJLJj1wNcJT3OAQvg3GyIo=;
 b=uwjsu3wuuBE5ES8shJvepdSQr7aeBLWoNUm+l2tuZXLOpVJnxyxizYhdaKzSM6WUPShozYX2opxG24L22M7rKTiE9TAOFlgijGNX5cNJ70wJ6/dNkrj4bUf8bB31tLyipqlV4hLJC+p+viFdptDu009BLJl1VLPKJWGkwwLxBEZP2I9gGRmkptlCFTrigrnuleh/JcxwpJ/i+axdevT6AkUc+UhpNxwYDbLBEi0qKculhMy+7adJY4NLKIFunBBk6eC57nKyoy17FZ/TtoAwgdUk0PhrzoNY8JJEn8S9PON+9/M6W8uPOCgeSCXf10aWVoYh0btPuHzsfuQsN9XQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI3MJJMEfAUrmdHmqL+vEVJLJj1wNcJT3OAQvg3GyIo=;
 b=ogFZziHGLCq46tD3o6CNylvd5Uu2+h/MU1KZNAmdZPqVWF4bKvDodKnRcFerifo4w/k/VurnOPFflBoYd4uYYH/qieC57uWKsGkFnJsZzoYPWuk0OCT4gCov/CWqe+wapZt2Grj5ny+PiWTyHcV+A0BTfhuugQly/PHtvilNBZo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:22 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:22 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.6 0/6] Backport of XFS umount hang fixes
Date: Thu,  1 Oct 2026 20:20:57 +0530
Message-ID: <cover.1790864521.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090954-revisit-dowry-37ee@gregkh>
References: <2026090954-revisit-dowry-37ee@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea23bff-bb61-4885-dde1-08df1fcb755f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Uxz79sUbtYkKeU113Z1Qfq/eT9Xc7nIpip2Kj1fo3zmMlKBbN3YnQI8yflFFPaVl3KktpsY6hjHWPv9DKwErG2xpdh7jOd0jzPDDOl5SlVCn+1wZ3r59akspAKY3EdyIVVEOwZw0SQ/6HswS0d8FafCSrTXd4C74+Lmb8vtd7yKxyLt8ilNlTVsQ+9ucoWNgnJ1bMfbUirqjIxJfwCMJ+nkkmpCujJBs0iqXh9L1VVeNleRAZ2DIHw7PSwT3hsiaMNu1bQXMltaDkO/9zHQm3PG4Dz0x+dhZaJM5aRNnQquniXE6U/w2IZZw4KCGfU3Q9DF/EvQUh+D3+Q48rP51zW2LNRmEVhURVpvyNLhIAcchxgoFdO6seV6O0i4BxU75ULiyQxsGLvjXuENWn3xw3f7kp7TIQJzVI5hWl3M4a1zX63aVNrfF1eA0/KB6TFYB88CeP+8SMa4BjpjUmfSn70jipeJacMY4auLp4ub+tlrUktpTrCC7IBd/OZqvML+K+Ysu39sSQvtRhSqgzf6D2W55MlNejz2+fgErMICkLWGHmBPARzzMtfzoe7LqyoaWBBXcTo/mOQ9QD6fTZiDkx/TBBlaK627/KZrT70sotj0DgmHWwxKRQXgXOznGZ4OkueJ8lgwcdzP4mwdC1dMZONvWvUKEKN3jiHpu8kN66qo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uk4NmhZFCZpNrvN5dKdZ1Hes4xAfFsleJ51JBcZM4CipBwstcHUDuoAX/M/0?=
 =?us-ascii?Q?j9yCa+SyJh7oz3R4orMTVBXs20Ft5EI49/cZww24GHhSMTiBQdIsuTXpt3Xx?=
 =?us-ascii?Q?SSwj0WXs/UeOEQ43sjTmUDCVkMM76x1vjZVSquRKYZazbsCqCApMoWnK1oxH?=
 =?us-ascii?Q?nSu3Vgclk888lf31KaGYb8YIanrlVc2HIc5U0aHUBxvRCxsArF+2SS0K/7Tw?=
 =?us-ascii?Q?P1NGrf1X8WV6mUPvXdEWKpKkYItCqwAwT/iaubmzuUIYmTy5EG78QvndGCvd?=
 =?us-ascii?Q?UgiE//eZUdYDvO4Dfym3ubcXYMcyGhLxlJ5gk/0GYVFbrsXnTNdJ7+exl5Yr?=
 =?us-ascii?Q?pg+GEb8qJwSrNFVvIorqkWtvZ0zhBWvVaWYdIm1rxB+PUDAszn6Z5qgLgMVF?=
 =?us-ascii?Q?GNQ4HScVxdToBUMyzl7nOpcBx0n9sl+t/ONAg/3lLMppTU+xV5qilx1E5xrF?=
 =?us-ascii?Q?3jiRhSjxBo2TbUNkHDJhu5IKuhjL9/PeFDTYcQYp4zzzPp8Z7mpLz5t8PMYb?=
 =?us-ascii?Q?4b7+cVigS46PaIX/o0eOzI/EbqwUw4nTms0zBCZM7tPUXpvjxKppCixDL3MX?=
 =?us-ascii?Q?FR9wTh/cW4l75DN0tK2Zac2A1IUGWDpPyAigfgrvE/47SmmGBIkG/hekZibW?=
 =?us-ascii?Q?zSHdjhByWr5CxlZZgZDLch4XJuVaYMSlSW/V637Dpwlpl1Elsaw8B7VCV64M?=
 =?us-ascii?Q?L0oorWGpkwrAKQA61Uwohul3pRfdhYGUAOSwmJs2mATYWpovUIbeIemeL/d/?=
 =?us-ascii?Q?HdT4uvFAXA3SMo9ndKje4DZSFHGcFeVkZPtcDBKYHpWhBQSdu6EFCnNSlwX+?=
 =?us-ascii?Q?nIYHnCxjc8/IOGDPeW6WcbbQA9rLXhRywr69Mnm61EgkBHFAzf673WBEgYtd?=
 =?us-ascii?Q?i4ZsmtMdZL7T63mkgxlSpD/qxlE/W7MHSD8vATSJEVvlnir0aG8TkTthLKIN?=
 =?us-ascii?Q?ICe1M1FsAxkat3VG6eJmL5fwmdA5QFiLKpj+ivMVXPdGcZo185OPNWs5bEmX?=
 =?us-ascii?Q?effiTZstkBLGoiXl4FOOAU9AWKnJcc5YSjrPInjF2mkUBA/Ll56rKIz+NBbQ?=
 =?us-ascii?Q?67Rx8ChMNyfpexRppQb2dFrDthe4EZsLCQB1HSEzzwMc6aKC+Sv7c7enIswo?=
 =?us-ascii?Q?lfRSKlS4UOTrnNmR1vbkZkKKOyBWOC7tB+pGWIBKgx8OsdzAK1Q+NNgMkfu7?=
 =?us-ascii?Q?z9zpAEWe9dhtQ5O6yuPziTwSdMdb9HQzoYx36G03e2jhfVGRROOpuQYduUGR?=
 =?us-ascii?Q?fi/0Ocg6yccwTbDDC9aBFNg4vSNKdNV7N71YmXAPd8jmdp8700Kf6kG+NkMJ?=
 =?us-ascii?Q?UOe/SkvrruIe3y/fgtX93UFKyw7BvFFwSx/rL2+TxWRR7i1JQAICtd8Qdafg?=
 =?us-ascii?Q?9Wcn/UBujBeWwjRiMNsDUVDds/riYqGTSHFWlbyYz9ldrF5wr28suFL9BSKH?=
 =?us-ascii?Q?D2niAxHGrPEJsPsBRGOFk38/tlWnA8ldr72TNkiBsSprCMR1FK+OBzgFo0o3?=
 =?us-ascii?Q?Scm1J5fZIksq22JesBJJu+mFeuozJYfDS7FFgLZq0EmsKHcCKOXMypK9WlVE?=
 =?us-ascii?Q?BrkMQbFeaAzPiMZ8k8wwl15lYmva6V1NJabT4r9qEW18bE8KgWd53VTiWM+9?=
 =?us-ascii?Q?yLZ3ycDm6zPJSXBGREfun5Otaf36JU3TEhx+VWcmsNP233Uc4puj2nZQC1fS?=
 =?us-ascii?Q?AsDnMZOz8RP9x4pulwYxjiTMBPGPOs9esZ/CBF4re2bjTPNZ4iYr3ZCUh7Ec?=
 =?us-ascii?Q?f2E0DAK4Yotg/ty5A0G5bTKN87YS7r2Wh1n/YAJ6vqKdy5PEC0s62JPONW7h?=
X-MS-Exchange-AntiSpam-MessageData-1: XC1bq0t1wyGPslwHJfiOl5dy6wEXxbjz6zg=
X-Exchange-RoutingPolicyChecked:
	LTGlvCviMV3E6Z+YZvs2fp6m1m5ivCgej4hyw7yew+FKcNg1zqLJbwhHoXxULfjeYK30sgSnmN3IdhaH1k5uQkgZymj9STAGj3j/pE7G0442u7uzWUsdir2YpNQsvzRB7lkw3snHnkzIfbnxC9dJuAFXdtINmUrxPSBJqaZi4KUcp7SzYZrJOqr+4ktQUTs8liR0w8667VMbp4CziZVWuLcuVGv5SgKcJ+jI18IJPqzW3OsyPqMTmQPzuuJo8kAteBkNAynQn7Bld8Jte3czEV5RaNgQavxeV/eFuuJ6Vp2huhsdIGjeS/1iVuMGQ+cQBgUxtDqYQd0wodv6iDwPYg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KeFA79bRPd8SdHsVL/KjLrxZhUnnVNyLH9XlgpRcZLg4FHBUmR/hIZfg+UpeoplBj+TOQjzfkYNb7W+Ia0VcwOyHr7ujpRtrvpWSFalflsoYov87IY8cYq6okqI/tXxWmcgAm5KL8mgTlivk+ebqvvhWpUNdHEHPW9alQIUHJIy9l7QQs0EkfBSL3h/+p8JhMBHU+CvIlZRnJ5eExK4GFJRG1rikzgxZiG+GmDN4trAJWP8gm3tj450C2GbloF7hFS3fvbd9+4xf8TiGLJsz6tzZRtCW6HNTtg/ijCf3ApvBeU+RODk56r7Egk/CwoOcixQyrzqLx/dMfvRu7wETpgt6waJKFiAoDD/WFqRK12CCMHdr1ofKumL29Nqd6kmSXWAUIBapwF4u2AAtLkduE6rtGIkr4Gg0FCDXxua5OZEW6uQSHCM4bTnvAWxi+verk4QO0JS9VsQGFcM4jzjFKJCKK5TqKj8KGanA12Pswo2WuoljCHXv/9MwR4ivJw3pva7ELzKXmRrqf9TbfgB6vq98p8hP+CkYaAK8UHGiyX1Juj23KBaikKCgNUkdegXsxPOBCQIXgnH71kRvCEjBPiuuiq1xO/+H0YT02FLrlMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea23bff-bb61-4885-dde1-08df1fcb755f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:21.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDlyBteWxztsvm2W/e6QfnfvqILx8bE6ojG55PMFUGqMCEe8X8Bo8Lis1EYugensKJAHU+ijQM0IZSi0HFAsGquPqwq7XeLmV9OKx3HaqEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=777 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6qD8x6eGVBP7
 WjbD9lPe0HPWQOIB+OxsudgsxZ9PYk+M4G0dYv2QoQCUuZd+SJimSxZwjxVZyKO3a/vuDVZpVbL
 SPAfsXnSwx/ayK2+0YWH369P3fdevNb4YA5xQcVMFlZCZBWWIzlN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXyP55fJDLdP5C
 yO5cx1JixSHmHMpBPyexrF4tFokuoHv/lNQ46P4kvVnxbu91uxom3iIu434gPHK6/MkiTm+fCap
 9U432Ol6inFI8NKo9pS0WENa5RiWc2GWmC0sibFbNo/Oc8lTg1ew8Ygm0N1L5M8G2cGfr41e2Qd
 X/3ZIPkOfGy7lXYcItsyphOREf1g0HqlgYhV/qezG5q/woehCmx51fbevoeG7g8JwDSC978t4qE
 hQM21mDdhSk8ALc94FAki4uKJ54tR320xUbWD+eAKSV/ciTavojdCU0VGWXQlQB+Y7AGnQtITfm
 I+PNLcmUJUwkoful3eSPI+SfbLyqrPVUKQDXpzUy0Zy0anF7gE+I14uR7eiY0CZCti7uUzLIsPa
 SxPW+/h5MBKkQAjR1QOnSTL7sdVnObBSWCodvxIUCygitFGdr19+bTQovyqBUejhlL713btWvH1
 5p86JLVNEV2wJ6XAXxA==
X-Proofpoint-ORIG-GUID: pmWfEdEog9_xxUmAb8HEl_lSF_S1qdt1
X-Proofpoint-GUID: pmWfEdEog9_xxUmAb8HEl_lSF_S1qdt1
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe736f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
 a=_lStUm-aLo99ZRpnu3QA:9 a=WmVTiCyuxqgg3mnwYu6p:22 a=biEYGPWJfzWAr4FL6Ov7:22

Backport of this series:
https://lore.kernel.org/all/20250625224957.1436116-1-david@fromorbit.com/

Along with appropriate pre-requisite commits.

Previous stable backport was used for doing this backport.

I have added information in commit message upon conflict resolutions.

Dave Chinner (6):
  xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
  xfs: catch stale AGF/AGF metadata
  xfs: avoid dquot buffer pin deadlock
  xfs: rearrange code in xfs_buf_item.c
  xfs: factor out stale buffer item completion
  xfs: fix unmount hang with unflushable inodes stuck in the AIL

 fs/xfs/libxfs/xfs_alloc.c  |  46 ++++--
 fs/xfs/libxfs/xfs_ialloc.c |  32 +++-
 fs/xfs/xfs_buf.c           |  55 -------
 fs/xfs/xfs_buf.h           |   1 -
 fs/xfs/xfs_buf_item.c      | 295 ++++++++++++++++++++++---------------
 fs/xfs/xfs_buf_item.h      |   3 +-
 fs/xfs/xfs_dquot.c         |   3 +-
 fs/xfs/xfs_icache.c        |   8 +
 fs/xfs/xfs_inode.c         |   2 +-
 fs/xfs/xfs_qm.c            |  76 +++-------
 fs/xfs/xfs_trace.h         |   1 -
 11 files changed, 273 insertions(+), 249 deletions(-)

-- 
2.53.0

