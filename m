Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445585372C2;
	Thu,  1 Oct 2026 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866391; cv=fail; b=UiMPVKgVVm91pV7/45Mwl7E5oqFyGcaybvcD9mS/cqk8WB0s3coJzHeeD9zb/59bqMjCDKh1RGGkhlzm964VjSp28wlYVcQ/vezJRfNXC0alqtqNyGO8zuWq/DnDclLceIo7n7fR28+OUzmIOINxTaOgW7gWnnDaprrRcUwFxyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866391; c=relaxed/simple;
	bh=SppN22fDh0kPZgpBHiDaDUp90wDhO9cno1gesPR9zWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ci1uX7AlawdM1vDNxufZmxJ2gOvDcljyFSDxk+3LOo8XP1qAESjki/qJmlRsFWfVJVDtYRyjvUYJzPP+/XWRUzfFZOwgigmRen318XGZPms2KoUb+abjdQqzUv3T1r1BDGyYCnXSid5H02pe8Fc4msDRsl96b+cCXiSwzEAOLBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZZR0UzRs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X1M5EFny; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZR0UzRs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X1M5EFny"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMwWU490636;
	Thu, 1 Oct 2026 14:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0/tXizU+1Y2jeTo7M87SSS+bAdXFfjUhRoctztKVTks=; b=
	ZZR0UzRs7Cf1/iCGZGcA/dBcN8ao1PBjB0uhB704tGBq09nqOdQtA7j9JeIint2Y
	pyJwF3aB9q6rEcXc/yyvaJB72ZDe1A5s899OZOM7Bmf3MGBuTsIVZJ6ZokUOlSyh
	3SWehdHKGCeVfrVYuhfQn0QJCWYzjGCTmMJpdBPV14JtIxO2ntU5HML+ty7KDRA7
	9qzBwzMJvRKkWOfj/YBLE4bDZaijpOsqojDNAtCvl78xZV+izozMKV23kA0Sfm78
	11BoBi5c+/qfW0rsAoBn/WJ8a0WodToFJOvtQGZ4ipRg+Il4JOl2xaCst9FcdFT+
	vGkJGB4hMMh+68WjSWzuVw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx6ks945k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:53:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoSIQ031727;
	Thu, 1 Oct 2026 14:53:03 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd499-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:53:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Righ4k4HZPL3qnBJvgg0DAIaLkXHiR+egUiG8q2OoyQS0AXesLfuQS90yDv8bju5GUWWqkIS8LPq8iFBGJRCV69UBe8mYoSbSoxDXjBBRheg80j58bmy49JZCCcC8XE0VDgUar7fWgeMSYmVIzMzLVASk59A2ahwnhlQXGWGD2Q/MnLW9u1R5U6nWgx7plGY8Mx2NzDsBppBwSe1NA3kuS6MSCaSNeKQNDOuLjzZCGyLkCsdafjeufwfgCFCSSHxv7BT7EhzspmemMD20pbvguIgKjPVn0yH6Op0ys9V72+MxKYWcFCncRug/Ie8hrIxpE+F3+jjqbsqjHL3wP3Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/tXizU+1Y2jeTo7M87SSS+bAdXFfjUhRoctztKVTks=;
 b=xVyEcc4Oy6fZqdC5Rb+E9FJHzqHK7NolJugqt1tg7tcur3Ulw+IloRR07UqgF3eqlVVdc2pECDDDk6TgpwLxkYpWht+cUHCqE0FM6huU5iQUXQnUsJUU5dimUIOg/SwnPeYdScqbxDFanMO8CB7bbsW2vfnSUiWVxcxFE/17GeHFDx5ZmmB12b7IQ6Vh4ZgrJv8Mor8Ggo1x2ThICwhie2B0Rdsn9LDgdFqMNrpmPYQMuZZsdUreTLsh9/c61be+TETv+5+n88Z9oodvNNMrvrWMWcnnpvarYe8TYRa/Su/FHCMXngpu0hNp089ZJgsQJuTMzIFMK4RJAiflBEAOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/tXizU+1Y2jeTo7M87SSS+bAdXFfjUhRoctztKVTks=;
 b=X1M5EFnyhPQ6JTBgSFJsUTQTJGODzmJ11NyGG1d2f0LSmAkE2IP6cPZ2wXkQP6O1u/FMiw3oSWts3HwVo9VB/dKaoDw7Aq3Gy5OmmootcGSnJ3oyNMiu7HfENie8FF9YzeL8VsCburHUgzHxqoP3B0iQYcoRZM1kyS6ArCVLddI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:52:59 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:59 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 12/21] xfs: fix super block buf log item UAF during force shutdown
Date: Thu,  1 Oct 2026 20:21:25 +0530
Message-ID: <fe2f35d57b5e66b57ba6ca024590681e6b2d1091.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::28) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdc86ee-4476-402d-2a7f-08df1fcbaf1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|260925021911599003|260925022911599003|260925021311599003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Kmg3k6HToVK/W69UPbpDIvmkEpi2OcMfcdVSnz0EzDlSd20vtrj3wQf5Dv3OZ4t8GvFBHnN6PD2CtwUUXrkV8eNXzd1jmcrRTZvliQWckvfUQl1PKKO5TDP7/rstvSUfSaHiE5EG4Jv0txDKkkaGBisViCiVqDLZVjjn42rbwTm20e3jvX0suxdzULewSbedzSmdUySk1hgcTz6E7C9vMk4yvBh9clRKzbYeMb46yUAqkWISlBUA8zpBAzZtpXEbO8mIrxC7YuuEyjgUiGs1D+TGyxn+2+Q5iBn3kaa0+4ca4enOBqHzjrA1Xd5H1XkI0Ylo9Jb4iLPXqUPhG1e4BAL3c4PFq/el8XCByr+BblU1g0gmwVtnEguw9JE4am4rKvOb/kJQp/WIFv1qzfqQTUbH37cSo4nsw3vWMJ0SnmbyTPtG+E7Q2XqJXKvO+rBDoxTCuPb9OmfyWLJgSM71F1rZxIS3h+N42jQwSBGmw7Uiqsq1UgXSuMIlUg5vbnCiBKiaw39dCn3mkWVPPImNpNM90Pf9xzaL7RAX+jY69IJOG8sMMzsfckNWEe1FH4ZfWDfnV4pXVbR5NQxmTmcIXQ4LC/3YqKyTEkU+5AX4yJWr2UEeYY93zUYKWWK+tHUPMoERJWB18IRPvTp9Z/Yhk3fHLWBADzqFa8lKiUzu7Tw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?scjMslf3zJ2nmpNvmvfHHmUHxUOUOqK1Y+Si/jZ4juTMDnGd41IDNNASFjTK?=
 =?us-ascii?Q?WNDKZnHk7bGKAL5OA8RM/n+7zGwpNlSbtWsjuFaD/LezQjLwqeuVosh21J4v?=
 =?us-ascii?Q?Dc0hEDa2hUHXLhSdybiziHY3eAYkdyG4lisZkM5P5erGD3a5npAcW6EO/SIK?=
 =?us-ascii?Q?PAKTALUr2g3Tpwl/qIQOFggweRRr6iGZ7CaZeLGy8BWF3FlgJ+QZ4mtWQbX0?=
 =?us-ascii?Q?8K/ZPj+pHds7IMZB+yS4uw1kMXq59E5D46DEM+U0sfFNtq+xBZZmgO6GU+uz?=
 =?us-ascii?Q?8YkYv5xAZb+S7slGGLYIHo4jWtFKgOGWUJUcfD4VRW4RSmRaDd0DwMsuvhDo?=
 =?us-ascii?Q?V+YGLW6OmnIPHzhrpqyaIp3yiNOYCWO3OfyReVc16yvM7rw1WcnDlpFJ+fhH?=
 =?us-ascii?Q?35ieDFKpcZvWLsI63UhqSuUAcBZTbGUtlh97JTpt+GSdPPy6yvGp9gsPpURP?=
 =?us-ascii?Q?F2dpZtM1a2rvuAnUWyMzlR/X/iKBM43dCVYZxtT2tLt1FcwgD5SFNwUaAwzO?=
 =?us-ascii?Q?wHYZhPxOrB2KkwHQIb3hFRDGpBHfpGiSusw+y/jjpBUf5ibGtxAWRuonhrIu?=
 =?us-ascii?Q?LYykAPzgwDMoQxKmfytxQ/CadKL6Oq7KVWfuldDol5ybN5bixg80xtFPeViY?=
 =?us-ascii?Q?oMcKhx23ELWyufCgz76X0DfOx/jTTTZKyysFcyUmhp0qAuE7WHqfadmEbT8d?=
 =?us-ascii?Q?HLNrRqPX7fIICVkjsxT29MnQjoKeG/EwoLinbXNviYheNW0zgFozkGDvCyXk?=
 =?us-ascii?Q?eReIon9mIjQFtEbrgbOs73clMifTJTivOkarirSEw8PIxDCRsj0uZD/pGW54?=
 =?us-ascii?Q?cm+1n/q8WU4Tg4FuigeEFi7RwqXE3h1OVk0+XM7yO1meKEdJdHf6Ch+fwJqW?=
 =?us-ascii?Q?Fdxj5guyxetjiI4cQkbgAqN83ChADQTNcVY0rBgi945IolPGk3msB/0YI7Qz?=
 =?us-ascii?Q?McfzwKrQVTUV/Fl5XMksKblAtG38ykRO+hVOSU3f6DDFlVPO5DzMaKOYgl6J?=
 =?us-ascii?Q?43A9c/g5tcOQYc6CEoT5NK4EVg/vcQSiicEoxgKrXjpfXgqEAUglE6SJvB8+?=
 =?us-ascii?Q?Tn0mNa/UCSPVEsddqaoEvZnVZptS8wlPCKt6t2W9+9+QVeu4xWq41W7oFtI7?=
 =?us-ascii?Q?AIkuHbqbA1YcIyIY8an0Y/F+/e6Yl/Tf3Z2ckDaIFCzIKNZ+BOqDT3Rt5YEq?=
 =?us-ascii?Q?9XfYwxCCWTupp1p7ojMFwLBPe2XfYQiAM1QGQPxt8Hb3YbZL5LATNukcX3Nx?=
 =?us-ascii?Q?VuKRzDnu9N26EU6EJeF7aNrS4iPkcZLyKiuw7emc9yhoKeNsPD00LYsFZbh2?=
 =?us-ascii?Q?8kGEc8bUrSbDIuNbS1d42RYpPQKKtT45Jx9BjCz6fMhfdbC/3MPFSq0EJbkZ?=
 =?us-ascii?Q?InGirXYKkziuvc4voRJk0clVBDlWFpWW+9dUyMguWFu8LlVqOeMl3uOqW4gW?=
 =?us-ascii?Q?6F9UgL2edRMDCHse6F3YMbCba+DKRL4lZxa0LWigw578QLqnPuorSnGPSKt7?=
 =?us-ascii?Q?xaGq95N3ZXnlP1k3HdXqipR5rLsGsBXF8sdGa01Q+oN5WHPJJaMhgzMY4naV?=
 =?us-ascii?Q?9v1NX4skOO8DjH/ed9KdLIum9L+JLqaF4wd+qeRuN2MAYBQ/Kxi0RbM+OYWp?=
 =?us-ascii?Q?Gsq6GRb4VJ77xwuIPo1ZJYwh9ZnVNeCVjo5VUOMPnYLRxBdxClT6jG8bvKEt?=
 =?us-ascii?Q?LLvXDw7PPt+InhTZQ2U72nExv53YHG/dgGqqsMmYomslygTG4rdHlcUmavuG?=
 =?us-ascii?Q?sEpptuOlnQ2FB6aghLlGoEk6jl75kPv2N8VMFBQLdPNW7k/LTCjWj/6I7cZ7?=
X-MS-Exchange-AntiSpam-MessageData-1: u9t0M9igF/1+U+AHHP0VNvC23qLRNZQZdBs=
X-Exchange-RoutingPolicyChecked:
	xEnqhrlfKyAplQxZktxD+aOL9AdMzklkfzI+tVWd674hYn1nlXgDmdxYMrEt/fY/vCYAUHf+rBNVMff6j+jhDh6fxefhwru2CoNTtvtz/8CbyPE3VdkdaKA72fL3oPoAiOOogryndh8X36INrlNIWR4+0CaxiR8HKM3HgQgQqJO1/QzzAa/X7RfxD8aZ306xAkKmIUqEK/VYVFvwbslwvTpVXyF26s0t9WrbkBTtngcoti4I2YiTGeZOeCpYzKIq0pzFNI0YEhpyLpQgnBoHMESdb7+wNxu2nTpOdr4VnD8K5ygz7sAs0zPIQKQmvY6AH7+lRgC8ioVRro8yQe7Vyw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/AJo3SzITwFe07wCAxxLQFAgE8j/bbA/COo/fPkCGsm6+Nn3Agb1MceWwALDd+f4G7Oeyw2iRhJm0jIbYGsR90hVniqBYJuGNxkLeMJ+nhlPcBGYMzzezie/onnNqbqxx+yo++LxfahnEOP2jEzpu9S08Nz2ajlJ+CkTfXrxP5fFTHS7huD89CvQMkNhUMTL/lszVsMyWTvBIWgDc6ZxEUYnBZGzlhEGf72ybBu1IBxOVWy+XrHd3ra/cxntnzoyknsb4Tix9MmScjXjzj9ElXzRsVZ07yxKzDDMUlRmdB+c0hDS0gJvpucAUOSHSW00yW8SSRUAPHBg1QtQeNv6JReSpjxe30y1XZt2lVuAJm5wDe4pAC4+BzW25rU4mROoGWLZVz3wsrtgShump/6zZqNgn75J15nsM3fhqdBUNjyaI2WA66E+cjXAAaljpKfpdsUSHAOJ/iT58rxJpplqn/7sGS3vGtmXthGqWJwac7aciLRLowg9U8TBCBauF64DPe6C4W1gKuWlm797fap7gpbgUw1xVSvkrwgLA979V2lCFmLG1gRC/pYHrObjXiIWV75k+oo7+sqJAsmBydY4NzCGBkaWH6dBl8bimnFTZJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdc86ee-4476-402d-2a7f-08df1fcbaf1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:59.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUhNxZITVPafdPuoj2fAjAFMZU6sqYoWI1gu4hvJcqP8mdTktk5TJmtwdZFaucQL2opIngNe98hT/W1az8oDzKNRD1Pbvf47Yin0gicFBeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-GUID: t_qHc_X4PmvLRGn0mxQJOQHm_C-sfU8O
X-Authority-Analysis: v=2.4 cv=U/gHnuru c=1 sm=1 tr=0 ts=6abe73d0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=X1hi7w48wxXEZvHpCekA:9
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX54F1yqaQb3E3
 cIjmieFTDFdVgOYGwE3i1wy1gn6xnezhqNQ0f17arS1I5kTXmPwgfRIicySpDZjlMA7O9I53MU+
 8W/FrslVkvdBxPVuECIkP4PJgtzU6qgPfB3af1UF7M1LPvK/fO/8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXzedcFQxyiEOl
 Mj4O7nPx/zEORRiGiItZWxTGmO2n2NDZQj1rFUXl4GC+wLevfPJXmYF1AD0qfRmirzrx3e6oRgw
 H3QVfk/PLiZUB1mn01Y8L2+WXAy7NCO5eJPEhLcOdVNgxfkDRVUib33deu21LUNR2Yj9fCIm1yo
 M+kvDcDC7YXZT811iQCf2rK0GVrgRIvepGKj8v6rPd9o6ONQiDvWhUMbsU5EvN8JRrTS6QxIAVL
 f62FR6DpmV6BPgetzWa5J3KOtA3I97fAuCqaQFxHV9hrZBFFtVfKFr3ywvDX7hL3I0wBDGDb6Yc
 XBosJ7d1bG/Deyj+M4OiDKKH+ocoJruCyDyjCMp+HPAXk9A9lWEnVl4C6omaFXFJUKXvavyYi47
 lYHNfF38HV+frscVMTObA+9+YHlTbdXR/Ri2qa1VLybYkwr2wTNSxOdV/XGtLz2lt5gvyVfIIUn
 ChwqDMc276eVpZNCkmmv92J2qabaVAz9DC1pbDfA=
X-Proofpoint-ORIG-GUID: t_qHc_X4PmvLRGn0mxQJOQHm_C-sfU8O

From: Guo Xuenan <guoxuenan@huawei.com>

[ Upstream commit 575689fc0ffa6c4bb4e72fd18e31a6525a6124e0 ]

xfs log io error will trigger xlog shut down, and end_io worker call
xlog_state_shutdown_callbacks to unpin and release the buf log item.
The race condition is that when there are some thread doing transaction
commit and happened not to be intercepted by xlog_is_shutdown, then,
these log item will be insert into CIL, when unpin and release these
buf log item, UAF will occur. BTW, add delay before `xlog_cil_commit`
can increase recurrence probability.

The following call graph actually encountered this bad situation.
fsstress                    io end worker kworker/0:1H-216
                            xlog_ioend_work
                              ->xlog_force_shutdown
                                ->xlog_state_shutdown_callbacks
                                  ->xlog_cil_process_committed
                                    ->xlog_cil_committed
                                      ->xfs_trans_committed_bulk
->xfs_trans_apply_sb_deltas             ->li_ops->iop_unpin(lip, 1);
  ->xfs_trans_getsb
    ->_xfs_trans_bjoin
      ->xfs_buf_item_init
        ->if (bip) { return 0;} //relog
->xlog_cil_commit
  ->xlog_cil_insert_items //insert into CIL
                                           ->xfs_buf_ioend_fail(bp);
                                             ->xfs_buf_ioend
                                               ->xfs_buf_item_done
                                                 ->xfs_buf_item_relse
                                                   ->xfs_buf_item_free

when cil push worker gather percpu cil and insert super block buf log item
into ctx->log_items then uaf occurs.

==================================================================
BUG: KASAN: use-after-free in xlog_cil_push_work+0x1c8f/0x22f0
Write of size 8 at addr ffff88801800f3f0 by task kworker/u4:4/105

CPU: 0 PID: 105 Comm: kworker/u4:4 Tainted: G W
6.1.0-rc1-00001-g274115149b42 #136
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: xfs-cil/sda xlog_cil_push_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x4d/0x66
 print_report+0x171/0x4a6
 kasan_report+0xb3/0x130
 xlog_cil_push_work+0x1c8f/0x22f0
 process_one_work+0x6f9/0xf70
 worker_thread+0x578/0xf30
 kthread+0x28c/0x330
 ret_from_fork+0x1f/0x30
 </TASK>

Allocated by task 2145:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 __kasan_slab_alloc+0x54/0x60
 kmem_cache_alloc+0x14a/0x510
 xfs_buf_item_init+0x160/0x6d0
 _xfs_trans_bjoin+0x7f/0x2e0
 xfs_trans_getsb+0xb6/0x3f0
 xfs_trans_apply_sb_deltas+0x1f/0x8c0
 __xfs_trans_commit+0xa25/0xe10
 xfs_symlink+0xe23/0x1660
 xfs_vn_symlink+0x157/0x280
 vfs_symlink+0x491/0x790
 do_symlinkat+0x128/0x220
 __x64_sys_symlink+0x7a/0x90
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 216:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x2a/0x40
 __kasan_slab_free+0x105/0x1a0
 kmem_cache_free+0xb6/0x460
 xfs_buf_ioend+0x1e9/0x11f0
 xfs_buf_item_unpin+0x3d6/0x840
 xfs_trans_committed_bulk+0x4c2/0x7c0
 xlog_cil_committed+0xab6/0xfb0
 xlog_cil_process_committed+0x117/0x1e0
 xlog_state_shutdown_callbacks+0x208/0x440
 xlog_force_shutdown+0x1b3/0x3a0
 xlog_ioend_work+0xef/0x1d0
 process_one_work+0x6f9/0xf70
 worker_thread+0x578/0xf30
 kthread+0x28c/0x330
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff88801800f388
 which belongs to the cache xfs_buf_item of size 272
The buggy address is located 104 bytes inside of
 272-byte region [ffff88801800f388, ffff88801800f498)

The buggy address belongs to the physical page:
page:ffffea0000600380 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff88801800f208 pfn:0x1800e
head:ffffea0000600380 order:1 compound_mapcount:0 compound_pincount:0
flags: 0x1fffff80010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
raw: 001fffff80010200 ffffea0000699788 ffff88801319db50 ffff88800fb50640
raw: ffff88801800f208 000000000015000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88801800f280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801800f300: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801800f380: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88801800f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801800f480: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Disabling lock debugging due to kernel taint

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 0d889ae85fcf0cf9bc6e998fca2ec760e08e0b46)
Stable-dep-of: d2fe5c4c8d25 ("xfs: rearrange code in xfs_buf_item.c")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 7794bd956861..73c548d5b593 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -938,6 +938,8 @@ xfs_buf_item_relse(
 	trace_xfs_buf_item_relse(bp, _RET_IP_);
 	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
 
+	if (atomic_read(&bip->bli_refcount))
+		return;
 	bp->b_log_item = NULL;
 	xfs_buf_rele(bp);
 	xfs_buf_item_free(bip);
-- 
2.53.0

