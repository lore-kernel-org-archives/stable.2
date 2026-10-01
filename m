Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BDA5226B0;
	Thu,  1 Oct 2026 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866299; cv=fail; b=DKip7J4meJj80viFS8Bzc68H00bGEBS8CEyJUyKA98RgTxAIMt4criDgBNc7SKz0QS4BDe9jQVBC831GEUB2ngIDccOeU20ANhloErB+D4j6TBQL21D4v2OAJ4O5cKEM/tJjNLXKLQ2KshWAmLvdXeTePZf5d8F7piuqZ2NQJWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866299; c=relaxed/simple;
	bh=UANzrX/gy9JdrSEgXfluubIem6DHilWEg4W/Vh6Xsno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GKM8xlNOoD3YoK8Z14JijKgSFtZ4m8QX+TSa3d1ZQDGvdOYdMBt8noQOlvV4p4Y1syFpfe78E55lc8o/4fImjgRf6LbVSgd+3xcNdastDjGUtGaC8uGEw3MRNXst7XCBCZ6cLlfG3joaWXMkT7HjWhaOzrkOmW5Xk5WtVO6yTPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AC+YNVRA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UI6phPCp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AC+YNVRA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UI6phPCp"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMcfB539266;
	Thu, 1 Oct 2026 14:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mielG+IphW+ROA1c80kHzWVdWyntKLbEJBSGbE1bywE=; b=
	AC+YNVRA2YU76jWbqpD+7V7v39T0NS9enaax1NNjudmoZgELnH08pwFX/Lparkw5
	vg0ukVGkpTMhGbv1GP1YWHIqpZcdrmWY8rFklGU8XAs4wxWAEuv3cFNWTGnGHfn5
	Bw+XQb39TDGCWHR83xJlPCfNynoyBA+rt00vRSV4IfVgs542JentFUDDUitgf7Sr
	jINzBL+CF6Z8N6b8Jb3cfLyKn5cGPTyFnR11FSPCfqhaXOgyc0lEWoOsmgaeMeH+
	It1d5Tsic/rOYvQ1cZWHiiFeeGpOgg6v1tIWlG14mZwwDiJ1GobsGqpfs/K6y1tf
	hv6zOj7XiG6I9V3No5mPIQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgyjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoOnr031610;
	Thu, 1 Oct 2026 14:51:31 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd2tg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QihMP1603erqAjBw83XaeKzn1ExCTP2Gv6PPTrf+iinBUfzDX1J062GKBaB3AvQQuz6mtnS+GDh7WxdRtvOW1IEOVReuv8kQj7c8dUviqPOYGOv7tfAdkR2CdEByl+TuhmU0CTrISiRbQYy3RU90qpeJb1TZP+8RFgkYoaggoGUyuXvdX6roEBZrQ6wHnVm2/KVgwABXOAUq3oILNDPmozvj921DeP8Hlca6+qsW6btoY3Z6UCERJczN7aPqZAslzZWs3zgKr5JvrhdR91dLYrbSlg8RWUNxn1WIb8S5VvFx/uDtVZn0XGybnnRIjntV+s1cbCHq/uINVQzKqZ/Pbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mielG+IphW+ROA1c80kHzWVdWyntKLbEJBSGbE1bywE=;
 b=aIJCXGzyZpdoxx5Ht9vdvBBNAaeYtsqOEoDH7T6vvxq23+JPeFixhTSDVa0Z5Wlc9pmUzNJjR2taKwCMTcih2F/VC0ZqQjFHu46sdOdP7KYjt7Tas1Jp/ysWnIjrGA/d9LaqNdIhuEcBb2y/pSQq83cjm9taavYU33Wl6qsIaZECI+kVIRFoUUdXlc9iQeZAnjZ+FPd9tjQg4jTde3NNkXuIUMs5W7WkyBYZ4hUuODaJglqnlPwtpfDPCr4yPV6VoFCqKmAuNMQMmRfhKwso4cCPcfTORBqq7rTUBK5C9RanVJRZ6nAXSVnhB9YnJ80X8MikisGV7z9rHsRvAysa4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mielG+IphW+ROA1c80kHzWVdWyntKLbEJBSGbE1bywE=;
 b=UI6phPCpROhfAz3sy4B1MHQq/XhJB2OWndYsOM1VQucdu8PrVLe4gQ7jbe9hx7QIIE3x8rAV329NhRoKzdV3pCK1XHsEbRuQBHDPDejpn7ISGufqxPYm52/ypKdf2lZjKhC1gG8gdZ4lqTfL355wTgFxavUBNi43pNMvfTAXYjg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:28 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:28 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.12 6/6] xfs: fix unmount hang with unflushable inodes stuck in the AIL
Date: Thu,  1 Oct 2026 20:20:52 +0530
Message-ID: <866d244467ec698343e4109343a9dff4d1b2e620.1790864403.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864403.git.siddh.raman.pant@oracle.com>
References: <cover.1790864403.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb176f4-9608-4374-ac09-08df1fcb786f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	fEM7a6ciZeRQ865HuvcOQkm1AT9TQUaTKfatUtdfnvfJLjdQiVU0gh/oVfw4/GXKZtZkXewZ74eU/SEQ+cNd3wpXFFbiacLEeVux5BfayDfRMrqaGqmbekNVr3Ll79z6+sxQNWXzqE4NveG84giFsT6K1p5nw3sbwXuu4+AqPps2kjsEzsEVWd7bjR6P38L925b6zPrA8m6OR9OG5GWu3rrK5ea4CyFskd+2oNkck+g9Mg77HJf2puvcq5GEGdC7PRvdOhiuJ/zQ7qba0fNBHWZLEl9CyXc5nmDLAAH0xJ7lFJkH/k5TuY00grfsnZTMIOqz/k9a1g8eHl+ho/Ga15LpPkFTGSbFjYL7RPSq9j6yEkagA47xxQdj5cK6NEamX6HPcmQ/CpQNzKk8ppgVgaDS3Yn4wzxsf9TypIARpMxR4phYZ0jNfSSPDnSfIM9zlfng6dyULvwHTXn+GkJOJUHDqyC6S3y6HPxenFsv+ZBs9wURQASiHVfWGwCKO5Mi4sPQMvfBmd9szwd/z5kIs88A6Mk4jfkF2UYWOFQ3lY9ThmrL4+hlnvwbdMlJBH708fcjaZrPjOJDkp2VA8XwOmXA2ZFrU7TFcyDnWLmf2XLbBfvhQt/vhN/wwDLqbsou0rAb1Ni4FZPlMtTuXGRRu7piK3P6WiBdowgIqIPXLTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BnZSlaeXDVDmcmn4Q9noQkH+TERsEZduvBL4u0nt0s4Yi5Ds0y5W0XLlvVsb?=
 =?us-ascii?Q?RPSEFv3aZwrKWZPz0jB+xLllX1GMny7TU6w+Dc/UKu7BfuqL+bZX98lq50d4?=
 =?us-ascii?Q?3M1PeL4Wfzg4SkVJh61r17MRkv/TASYph9l8jR9BlpGnOewYxXsYcWJQp7ZX?=
 =?us-ascii?Q?HcHjHt8sOP/LeIWVTqsPFh6ZlYgJovbV2bW5mbJ73hbVOG1VzlJXN+FxsDsH?=
 =?us-ascii?Q?La747syf25E+cAb0+J5L2T3dUCRWoyw2l7qD5r756iRFtiX4phEfZ2GEhDyo?=
 =?us-ascii?Q?G8E71QFuM+NEnBWUogYcNeCJjhjYUuqX/0/fu0VsoCIiDrg3Y7S18S4BP4nH?=
 =?us-ascii?Q?D0Gi53SOuBPDHYjrxYNJPhh8C05MlT2i+o3i1FoZojrV+WOOVASOBI1LreQn?=
 =?us-ascii?Q?M9OQez2Su1MQEEL33nW0BUf8fTs4ZBy/tSHFd7qhKgJ98A5DK4xjTWsB+FoA?=
 =?us-ascii?Q?Ir4T1xk9sQqoU/h2+AhH9NknlGO1yZqVWKnBN6tFNmHKfLDdypUxBf3adcCE?=
 =?us-ascii?Q?sIaCpWCzFoV+VAMFVAUQ4sGZ1frv0cMuFrdYWrl34WiQIr1wKRGHnJm6pGJs?=
 =?us-ascii?Q?rWZMEaQHiqIZKInSr3sCV4Us/zLT+VDQDTmMEXZhOYZTOr1nVfmabf6QntPM?=
 =?us-ascii?Q?RKJ/8wnt+OY4TPX8rkOesSl+YLcjapOiKA4M6FN/CVx6M0VWKgm4AH/nvZDr?=
 =?us-ascii?Q?Wat1oEsJ0PKdQEYLEVz4biDheXYRx4rABNeZXvZwgVKqxog0wpBSLWJA+rGb?=
 =?us-ascii?Q?ABCQme5WFsgCjzCGXf5MItyZ4QBLhhoougdUO5nge4njSNPTf2ZpUKYwTzId?=
 =?us-ascii?Q?fDYV0Ao/ptZRZr0uv5zYF6IFHvfnoSfr0nhOhasxlkN8wdhxi1bVR/MyIxMZ?=
 =?us-ascii?Q?HAYSq6/pXC/pZOddRd2A4pN6nf9cZluvvFblnlq4N9x5HzT4ptKmWs0HTTqS?=
 =?us-ascii?Q?86/aCKIISp7f7rNxH2nap+p2uMLPdbYBfKl3rIlLifYgRqZ/W7syh4K2aT/R?=
 =?us-ascii?Q?bppeT/h6WoTx0OWuH+IJLNHk2Q4pXPcnyZrrUbmqIT5CvwhQQRRhthy+I4B3?=
 =?us-ascii?Q?J9G4fdiKJOC76/sZjIIL7oQ/88SRhK/eKDmh1QbwfI0s3W1HLKEusRJMQ+9Z?=
 =?us-ascii?Q?GE8tFRYU6kiAZEOk5uhyAeEpYo71eYn4McrESWSsaMwId0PdfrcjjksjkoGt?=
 =?us-ascii?Q?rzxC3NGod8Cs4tf33dWm5EQMIrniZJwkHjvFXYkv2tPouVXnMTDDFsSjW/VE?=
 =?us-ascii?Q?9O4RwMNK9GEBCIHnuspRxT5spqT9dgRo2a4VXTBowZzgfrwEPxlJakYxvmTi?=
 =?us-ascii?Q?ba+2p7A/5QVvemC0mLVLMLD67N6QZ5AYMBWzfObNAChVpDjGfZ5bn67496TR?=
 =?us-ascii?Q?XifZ5NJGF6BjwapYyl2m1CePHs3s7sQh13YlcQeg4ScWr/vpqI+rQ0VkkLFE?=
 =?us-ascii?Q?9risBbmmrpHgEOlO25+w1Q5MCD31Xs0pu9D1Y+zIeWdZU6LsN/WYAaj3sHbW?=
 =?us-ascii?Q?UfRWwNkAuyRBWmPx1kK9yXHyntSIum0rw6LpfClBrV8QQN0W7kK1Z9c9aCEC?=
 =?us-ascii?Q?B6S9TJUhm9hBIXe38s0a7ch67MTz0dsQbibLabpZ92NYaRKuXu9OkATT2uWe?=
 =?us-ascii?Q?m3sMKRB1Bf+tyapjpoLHmAniiRYGg7PaVU5unTx/9E469HPUWJ/brA+zr5Vi?=
 =?us-ascii?Q?e0uCbllTn7C3x6g6s0+g5qDx2Rn3yAVNPZa4AdoEvurnXMA+YGekt6VwKQM/?=
 =?us-ascii?Q?VgAPsRRZNAydjbg26tzAnRSNBYUrmuHSL3a+3wG3WjZGcp5LkJiLJVtW9lrp?=
X-MS-Exchange-AntiSpam-MessageData-1: P0rVC51S1OXNAM+b4HQ2jybcmLFexflTwj4=
X-Exchange-RoutingPolicyChecked:
	Wmb8dgkqCQr06BYwRhSc8MuxtV6K3QaEcOXZbhVsBUA62d/5Ix7owoMDvhOzhGCKm+TRoWr1B//gtCio31KFOU++47uZciyxonajCFvp86RwueespDLcCNByCvhAmoC8+ldPjjyXntG1D5T5hwMFFL8pbBSj0wrhK3+3qrKS0cbEfw6l/fGuP0NTWs9t7RNOY1yitz3N9I9dZYx0lmbTGEdFYTSoPu2HQ271zqlqJwlI7XhG4Gy6KSaf7MdzRocQj0oXHolszEf681s+AHfwzCpTyfKpd7VZjGd9BI92zcnh9sQ3/u4qGCyYqdar1ieRLgFEDbkNC9GeNdhcJmS4jw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wo61peuiPEDkAFgAeAFpd/weRXOOilQCDaOS5hHzU9fGe/d/LcN9J5RFbN3mKmBetz4wYGiG/am6FP6/uO2jan0Erx1XOSRzmV7DwbvA16WOJ5gUo8BoL4gJPhJ7n4kyZtsanrHXdNFkDUZzyQ29SFePe6+/S/XrP3IH3pLFlfStEx8N2eiy7u5pPeao8E9DAEqSQMnBsFRVRqFX2hpK2z1KCc4ef+2Qgcbj92GHr81CxKAE+0DrP8iI37utMHIlZ+uirUKtpGm7FV/WtIWlcS6dTFaz+a3eEw2DH3kP6UZntBYTp9jMkVH+rl/BSykmGWqELBbEUr8TbW281K92bixuxK6M/HvoVEsS8+wJQGoW+D9cmcSsHatVgIyhlX9Yj5LKv5Fply1MEYtAcKp2bT7w6LA6kVSqo9OWUJPsSUuwqvCYU/gvrTmmz+eAS427ETNoe8It0B475t7x0JL4crb8LufA5kYY21UJQWxYyO+jPxudOTJk9FOCVpXmF3jon7WuIjrRVXT5YvGTbucl1wR9IvkPpGzRt3c1js7zbpwWnWwTY/dmUR6IhFnI3qTHyrfYk/BJ+j8suT5+ee5lp6zLhJSL/p+xfcOsWQvhu6w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb176f4-9608-4374-ac09-08df1fcb786f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:27.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja5eVjAUtxYUcsJiJtAS6snewXvm4aYTi3BxHzJVQ7k8jD6Gq5eZ5J3A94slyfoaOhaJk+/nLFIvZn3VAu8R5/tLi7RWeXpymniRFBVxqPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: aBkvwbDO71S1rKBZs6UyXOig2ZwN3uOy
X-Proofpoint-GUID: aBkvwbDO71S1rKBZs6UyXOig2ZwN3uOy
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe7374 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=kGPDooFuvBrjL3bSUbYA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXw4lLc+95DGM0
 ScW7ZlTFC5AvJhpei7dUU4FXTOl/1wu3Eu2cKIsaL+Dsl6rl82XPqXZQpVNFQAHhrBnRIHL+8L4
 7/ygSlJrN5hRmedEQQFX6oK4M9d8i+B/GO0n1+zj/cf1N8wEXtfQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXzD3M5I4nNOrU
 FJS8ga3c3fOU5NkEi4o8tH+3teugqvu9X17znXQHZvUK935hRmqXgwBqZbTn2RSdN7VZX6JCXfn
 S4UtPcgsPAm8+K3L4WisQXtsCWsSErthVdAzJA4UWhJBEjWF6qx2fB2cQVaQQJ5knuahXOB+PXz
 o/6JwwVTs9O+ZdO2vtiCbs0OFYNlCfQ/hgSlS7DfssHDz9mQRnpJkfq4hASW2bbO96B9r6kNkHW
 c66T/HQtd+ouceksvd7IQQOnl3lkQud0lOn8IrhsWjZPKMsWhyMzB2OpwujdR47sKvx9Yj0vER7
 1S60I/kl38nAfEK0RqIR3DVtFgY09sN9LfJdiKPmhR1DqI8iC6BhaCNwWrpnScs0dMxuEs5OJaT
 gtQ3ZeZaZo88FvlIzCI62YKH+mrFiqY2QTRljSoMjXdG5HCyBXp5o8NndwBrRD7ohPCEQVda7GL
 5LrFweqwdq333FbzgpcZ1s3z1v1+J0MZJimBCs7Y=

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
index 9e6a68367ca9..aa1108e81c22 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -707,43 +707,42 @@ xfs_buf_item_push(
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
@@ -764,6 +763,15 @@ xfs_buf_item_put(
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
@@ -771,18 +779,19 @@ xfs_buf_item_release(
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
@@ -798,16 +807,56 @@ xfs_buf_item_release(
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
index 8a8a46e698be..141c3780a36b 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -49,7 +49,7 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-bool	xfs_buf_item_put(struct xfs_buf_log_item *);
+void	xfs_buf_item_put(struct xfs_buf_log_item *bip);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
 void	xfs_buf_inode_iodone(struct xfs_buf *);
-- 
2.53.0

