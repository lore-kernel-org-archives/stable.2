Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054FB522EFB;
	Thu,  1 Oct 2026 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866349; cv=fail; b=JWlPzKYQDsMmAaMPLALQJLIcGVvJxI6vb6DIMt+9D5EA0b3cK4gJA3HlRF3fSQvyh9QxwNDyQQp54sH5oonR5Sv7WCgywQoTCHMkaFX0wBEji7n/RU6mCCvX5CiLnpvGZKDalU76UxBub/6JmiM2jYkLkN52HaDbrc1foTFfDaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866349; c=relaxed/simple;
	bh=Zb+I8QJTNpeIlLVciD5I8dfeFJ5F2eCY4/UOCufXetg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NT/MqRV01uTNbT8ZdjrNGw+22hJtm7gkA8cU92NmLqYhCH7YQX9DI5I+MfENVRJFGfTgebs3mphWrjAj89YRah5Yh25Ncs78olTItpoWmRJD7L/EeXa75tZquuXIpK7JccN6VjFqlmf8uCuV3SWf0U/DDkkB88s/oyHXlNclUkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dyxgcPfu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BoLPJ6Ru; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dyxgcPfu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BoLPJ6Ru"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMZT42256852;
	Thu, 1 Oct 2026 14:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zneNpJYmZjeie/vbEbCauOSZEK0UMSvZsU1kj4iHnm8=; b=
	dyxgcPfunhN2pj9QqKf9uS4FkGeFKh3MKh5+MtOlpGpBG6fCmNclSok+ozPBr8mw
	oHWO3T/li0gRny8IP3C3FPMpFYHIAxXf5GWAd1zuy31bvbj2PWrjDP6cEflamSng
	/yOluFU5c+IJi6ivaW8rooz+2Qwv57UadHauZXmVBIuKx9mDoVjNjxrP9br+WYth
	+6+Af1VRIqFWIoPNtmZXnM/J+O+k3CUoWYBdZrGT15KUNJJSfIr2Z6lniG0LBrVQ
	fwmJFiWVQoKRxs5YZbarGZ1X8GmChNU2SbM4/jyLVeQ3D9t6IkICPCtx3q/C2/NC
	WLq3JumckT/RH4NJlnRb8w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpSq017279;
	Thu, 1 Oct 2026 14:52:22 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey0e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMQkp35STdHc6tojYaJIRwvPCvj6sp51CPxmYntZGVTSHooYGlJapqJqOsWPXAINwGWh8Eil6PntChnPlZLag2NHzFbCdjm3X94zjXgdcjx2Foqg7Bel9vtf3zODPIqt5wY8h9KVa3MEg0+Whf+JFkTxF4k+ih1omLJH79hkIlr9rUi8E40fNpWdni6wNTK2qZeuJRclQkkTpkQZ1C2/YOJ6BXEtzKHomxdwNQwvrl20+hmadaH7vcFpgn1psaRUccZxCSb2Gf507O6oX4Ok5dJFlTA2qYr7oVr+t1i6gqCSXf4nPg6bCxp5Env1IAMwY/GSkiZJAE/hs5Ekub/Hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zneNpJYmZjeie/vbEbCauOSZEK0UMSvZsU1kj4iHnm8=;
 b=ARxyj+xIHv3fOuJt1g33Kggakq5Pq1LT3B2wTlk6WEtkAV8qGemf+xnK4WQmpTLdjH3VgBlzncaTO+9RwslPbKfKizNDHLskIQOR9F/wh1i+gc3uQ+jvJ8BSAKu76JRhG02jfSRL2zvm4OcRk8c2IdltsWcWU2g3qMJSLMWSZpWpzGFcbw7BGBw7Ihj9EueXHzi6gwk8+dijWtXk6sEK1424GqLwoelMCWxNzOQ4sJxKjMerTZjqvqYyTnNmgDKfD3ijkGeSuuZ0qddVEQ1UDD703ag1hYxT1ZCpJU57PgvZP8G9Draz4JzdQgmUoU+d59ajt5I6fObujWcqM8HQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zneNpJYmZjeie/vbEbCauOSZEK0UMSvZsU1kj4iHnm8=;
 b=BoLPJ6RuTQXMgkgbXTAvgxewiW9xsLFJkC0nMYEk9hRuU7MTNZsT7FRZkhxRW1nbNspbr3g8FBsy6egKk1fm0DatyrBBp/wc0hNUaiSNHp3lR07dcwM+5YKickVOV7qrM6mOXaMzsvkyDJ7Jt+qik0PbpHqIQEHmYSKp+ROayHo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6987.namprd10.prod.outlook.com (2603:10b6:510:27b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 14:51:45 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:45 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.1 4/6] xfs: rearrange code in xfs_buf_item.c
Date: Thu,  1 Oct 2026 20:21:19 +0530
Message-ID: <4aa98122ef3f0bab1cf46ee76ad05002f6ec16e6.1790864538.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864538.git.siddh.raman.pant@oracle.com>
References: <cover.1790864538.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:295::15) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f6cbd6-e635-4eff-4788-08df1fcb82f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rsOmx3f0HQLbL+loi0sIUkLEHESJxR545SeLfBkF1qYWkdjlIBSRWwYj1iGXcQEgtIthuzb0brk7lqVahl90YqZJf6whItpKE1GqzNxWY7EnOKW3c3axSA5eCgEDSn/mQBZaBp/UHd1APtEKQy8kknkWLp5aKc3l0MLoAXbyBeaqQe5Bdv7paTR5UGRWeT86ysGfi16bt5iucqDz+oTbmwo4nCtIn2FsxhyXT9V8Ehtr3jCGakx5/Vohl5DGx2HPLLyJ/kKnHj3k7GEqmvYbT5DLZ+Nv13/IaD3yUJXLzI2EdZBbiMljyPPUvrUYqYIhf8owfcyT44hok4TZYZJHC+eieAABfPxPMC1mf+vWC4ZX58EXKHrt3jiNjAehOknYUb0CcTk/VkbbOwM6eL5Ya7Cc61xdVnkMZeiwbXVB2owkwHXxBxu3JaiBUqE7j5YMFqWNFJjoXf9nyCvDffpsdz6ZAQtMwAutKs2WK8E0jonjz+JMBK1bboe87APsQ5wj4V+UkdUqaIw/wc3wTK+kzMp3Ol/eMlSN9tJBrOWvZ32h0c6OHr/zvCLbqbz0EsPJVCzgCc7AgFImiqVbT99DAm70C3ZuUzGZ1B9TdlFwWGYOrCBhQuUwroPvDoooVNZIpjk3rlo+YCK5R4VVtGVSoPJowDot9FGXn5S4l+mn9rE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQpqlwDdlckugYfmyxBlbWYaWu7RkEsvCxSNBKlCLIlZ8lCX9Pm4PWSzr7iF?=
 =?us-ascii?Q?2hc9PdrYNkVRAhZkQuSIpDLxQmg5XzRkTBrJD1jSWHH+6nH/InlheUMsbI4i?=
 =?us-ascii?Q?ezS/uVPIo4gXczzoItN2momyDIBL3WFB1WqFBiJsmGpotmFkB+K2lmjvdySb?=
 =?us-ascii?Q?Ohhu92ofsdyrJ1/LGupOb9GgRbc57x7F/axHm0wOGAVxTWSr+sCOxiKTXauV?=
 =?us-ascii?Q?sb6BpW2BQfN0XQoMIqSBhU3LTfykloYcebQ/N3+0gJYxhtWlUNgSV3gJVg9M?=
 =?us-ascii?Q?KZyzR3QaTygWu5HChBI4JxpG7Ax4wY/buXYjZUnTYuCRwnhZcGQGC+RLHTSH?=
 =?us-ascii?Q?K8GbZZmDwZ2liNMbTjR8Aexf8rVv6hBqhBp9POWT26A7o1sznNf18cmds+OQ?=
 =?us-ascii?Q?13Y+7UlxMKlZFwdwyNPxcaAa91TZ6ar5PzjQbmH8YGOzdDafGkTDCay1jOob?=
 =?us-ascii?Q?gw3Zf4HvPW2gWf6LrNQZFoj/4ot5xcJt+O6w5v+L5zb/j3ZCqggOmPfZXILO?=
 =?us-ascii?Q?NgKpRu1Agd/agfVHM0Vsq1s+5+J9656TjYPMDLWpd43ndwMn08n42jY6kUxU?=
 =?us-ascii?Q?a0TY70wQn//7Ap9weYRUxjWGRYCgWNw1L+oOu94Xz4uyCbLAciCk7OyS2MJP?=
 =?us-ascii?Q?Ca1cAKMpeDLZU+zGPO4r82pG8KwzY74HsIu1WbWOj4oZQsKeYuBi1FfKiFAd?=
 =?us-ascii?Q?RnU3HcfDmysV/G6NLqq48AhwvHg4QTLBgftnnSJHPluYMgkg4m1o/jqgNDHV?=
 =?us-ascii?Q?9IP05fHxO4u6m3YL4t0ZclQSJx3m1YjQ8ved7EHO8BAh4qAHxuHbpcKobSrF?=
 =?us-ascii?Q?v7MNJ3A6qFh6WX+tLYPtRKX854iHGWaDxUx7XPL7YtGvr0+6tpZQjLPufflo?=
 =?us-ascii?Q?PMpzHFsz/5ywdaRbel+5BH8usp95O+oKCVmooNf3cvuc00eVyrH0N9Hxk24+?=
 =?us-ascii?Q?y/QpzknLHtnpdQ2XrYqOGH0LM2MbIuXw6uv+AEaT12KcVPwcKhGVSBOJyP6J?=
 =?us-ascii?Q?d/cEUSxBcufEGybjAMfndW9Aq3ZXT31DrTdhdgTZL3utymNqsMw3C6EMjWQg?=
 =?us-ascii?Q?95y2swGDybRjp10Db1j2ABb8WE0xOrRd7eXKw0O7ovKmfGb+TIQ8o+4OqUw+?=
 =?us-ascii?Q?vIWbcQjfiVlTJnBxPyYN0Z182CH7wwXZAzWKvu/yCBmU3M8qs0TSimLMmya9?=
 =?us-ascii?Q?cWeDKo8/fSZ7J7sUXShO/uUaHE6SBixGf+E+Vfcvj7KTJpT/PpkoamX993Vz?=
 =?us-ascii?Q?0lskrS+Dp+pbuGYFbsA/mB2vTADwHUQiAmS6rPPSIDftdAK99g6T5l3X6vCx?=
 =?us-ascii?Q?p26zOx7GNnnSpTtrujP6fXfyEue4zeVVkXu5xZLSY6tzfWtpoWEM09SRqIXX?=
 =?us-ascii?Q?itw7OvK3+SiVY9E4aBxaUbxO1ypKjXBDsjzPQCTPCWDyZnAH7aLWPq2h5+9J?=
 =?us-ascii?Q?fnoPCnaOJ/6/+icazUHKdX5+9hbPeRalp0nygh0HhIVbR7wCuRnKRVUDxuPf?=
 =?us-ascii?Q?nwarB5ctSNBT6Zlu9MM+yJcMo2LVOZKhdrkQ6cgZT7Ji3c8bYDoZPIuExx+T?=
 =?us-ascii?Q?d4HVmz+3lLkEO2lTfDIxS2i16iitjt83QQMNRP1MnF+fuHEHTmZrSnKwOU9/?=
 =?us-ascii?Q?t2yxolRMhOhMYcvo/aKpKG+VpwN+vaXFnsSm3o6IP3SXDz4pMqyfGdbK45CX?=
 =?us-ascii?Q?NcpIJCxQ0h4jid2TagwDaMR+SiNxGOrtvqCKs6Aq/WYbEGN1yg/MtZJNpbYR?=
 =?us-ascii?Q?e7s5YE91KWZdI57tlA3IE9GYu6gjTV3rU5tRElEPP8xPykfVolbkRpo5pIgA?=
X-MS-Exchange-AntiSpam-MessageData-1: rL/hUJPYcoYM9v8/EDards35u8lyc9wAm1Q=
X-Exchange-RoutingPolicyChecked:
	nJt+PzXoKViA+WHL5IlJ1k3+yRVudOfC4WgwJMcxm7eTIbOoiWgrSt2D6bzHK5hZEP1yxZfsZ43ncxYghRb0kuU7rXpIWgSWYJe7DVnR4QGsZyQCp9z2DdC8o1YXraqYnfPWbr5/gNecNJIPFVwHpe77rTCMsuPDAmk21qiEGB7f5dzbfutNhafACcW2kOd5wDDZRAyMdR4N4cI0TDnkMPYVNL0pLZD64bi3oGHb6J6GK4kyU/nbed41NHaW/orsMR7mkuMGJkYI7YX5o2vjM4pDDoxr0OIiRZm2wRk3FcQQIxHFvA3mU2KaGgafxj0w4HL6JjDF+j50WEaTOcU2tA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yxxOVSVNNUDhn4ZyNX1WEqdYA4xCVi5Wa6H3xQH3XyeKEJwuwy0PTRkQFSiEDjPSPblVbPYuIb2FjM5e0HYoFcUmPQ4Q6Oc//sbbSAvub2Aoi2b4Zlgw1+aP/ReRghUS6IX/cx8zYb1ITKmO4euTV1IsBvHLribYLoMDy8FpCYvgnXdh/wab4bqCKlHbISm8+19mMN3NAeGoGgl21NOAnYt7AxLVHBwDYwFPlTZFneWtSFEQj3kfdJmmPGPNgmEr4X7TB8vYBOHGB5RdTZ2woIR8CNUmnSldfpr2FgNfakUar26EDFw+EEgsfKOm5yflkQChIl3M/cKboqyjYjW6dInEq9OY5gl3AdY1pY6AxJBkGH21SZ4XS+2M+Y4KIXwMaEwSGpfOsevaEozXDenROW0b4sY9QeYRIFkTrW9E//99GwUGXNfKd6zm/t4+iWdcpka6eQBMqZcASR4+L44+HYz4U52qc6dSVzd9W8AvvnWHf/UY4KLYa4Ar+kMiVyV8XdxiSwJKgFErsjyoci1AkwdraI7eOvoG7ohR3EtnYmp34CC7p3oPPrJoSkQesoY6zw7VXDbBhx+iyc+8QeDNr6slzhH21U8QXxBftmKn/V4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f6cbd6-e635-4eff-4788-08df1fcb82f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:44.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2FQ/BBcg2ZuvXBkfUGQcZYMhBTnVucabYBAl5RXDtdNVzYw3st7p/vj4q/NndwWqdOpum5F5FfQ/jjWHowXdw+0fdPlMWxK87jXf0/BmbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4dKbUa2E/lWs
 YxT70S3EWju4WiaAHSBS60WjULOIS7mcDVfyyT71pxTpukyGzw9lg5fmtsoAAJgBcQlFPBMxl3b
 IDAGfz/ZO1nO0Un1x0kWj1FxvMrsCs+OI0wRGzxIZYZytF210lNp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1YteUujuwl6Y
 Pmo+9byDzI64YMgdLxwQ4vF2sYFcePIAlBmAkdlqNmNyafXiRVifq+tkxqh7ICDU4o9OAksHII9
 LZpbsnT12Jm8kLcTESEDWEujYDYvsTDcoDEVyXnLcpSBKrnkj9fNjPr4RXsJLKffmZsjjdigHwv
 ALXon+AuVhp9N894nRAdpC401LZW2ivXMdws3x4BuFsLKSdwCdcUTnL25zyALTgZyCrwopuOvsb
 C0qzXH/EFe0YzAHhNWjKkFXzEFoeafrDO6cf1qFrXoqvX/3vEqDstk6NvdGU/vsiK+aaXeJ0gA6
 AVoGiA1DOBRbX6qzc0Dqi+mB/bMbNAFIHYaRax8inc3Ooy6/yvI8Nlfz/6gwjenuaUzXclw7rO+
 WEKXO4O+y5ydOaBcIu5ms0VAMybWYOk9nsqI5iMTiHmte8MB4opebMX1uXaqe8k9S43M/3Ys8lG
 Fb1RboXeKcThyKq9d4A==
X-Proofpoint-ORIG-GUID: 03NauVSBwl3S71GUf9v4ByRHvQ7uY6cJ
X-Proofpoint-GUID: 03NauVSBwl3S71GUf9v4ByRHvQ7uY6cJ
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe73a7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9

From: Dave Chinner <dchinner@redhat.com>

The code to initialise, release and free items is all the way down
the bottom of the file. Upcoming fixes need to these functions
earlier in the file, so move them to the top.

There is one code change in this move - the parameter to
xfs_buf_item_relse() is changed from the xfs_buf to the
xfs_buf_log_item - the thing that the function is releasing.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d2fe5c4c8d25999862d615f616aea7befdd62799)

6.6:

Fixed conflict due to the following missing commits:
	[Continuous range: 10634530f7ba^..d4c75a1b40cd]
	d4c75a1b40cd ("xfs: convert remaining kmem_free() to kfree()")
	49292576136f ("xfs: convert kmem_free() for kvmalloc users to kvfree()")
	afdc115559c5 ("xfs: move kmem_to_page()")
	f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
	10634530f7ba ("xfs: convert kmem_zalloc() to kzalloc()")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 116 +++++++++++++++++++++---------------------
 fs/xfs/xfs_buf_item.h |   1 -
 2 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 72d6e2dd5ef5..033ec1e2f2df 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -32,6 +32,61 @@ static inline struct xfs_buf_log_item *BUF_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_buf_log_item, bli_item);
 }
 
+static void
+xfs_buf_item_get_format(
+	struct xfs_buf_log_item	*bip,
+	int			count)
+{
+	ASSERT(bip->bli_formats == NULL);
+	bip->bli_format_count = count;
+
+	if (count == 1) {
+		bip->bli_formats = &bip->__bli_format;
+		return;
+	}
+
+	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
+				0);
+}
+
+static void
+xfs_buf_item_free_format(
+	struct xfs_buf_log_item	*bip)
+{
+	if (bip->bli_formats != &bip->__bli_format) {
+		kmem_free(bip->bli_formats);
+		bip->bli_formats = NULL;
+	}
+}
+
+static void
+xfs_buf_item_free(
+	struct xfs_buf_log_item	*bip)
+{
+	xfs_buf_item_free_format(bip);
+	kmem_free(bip->bli_item.li_lv_shadow);
+	kmem_cache_free(xfs_buf_item_cache, bip);
+}
+
+/*
+ * xfs_buf_item_relse() is called when the buf log item is no longer needed.
+ */
+static void
+xfs_buf_item_relse(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+
+	trace_xfs_buf_item_relse(bp, _RET_IP_);
+
+	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
+	ASSERT(atomic_read(&bip->bli_refcount) == 0);
+
+	bp->b_log_item = NULL;
+	xfs_buf_rele(bp);
+	xfs_buf_item_free(bip);
+}
+
 /* Is this log iovec plausibly large enough to contain the buffer log format? */
 bool
 xfs_buf_log_check_iovec(
@@ -563,7 +618,7 @@ xfs_buf_item_unpin(
 			ASSERT(list_empty(&bp->b_li_list));
 		} else {
 			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bp);
+			xfs_buf_item_relse(bip);
 			ASSERT(bp->b_log_item == NULL);
 		}
 		xfs_buf_relse(bp);
@@ -673,7 +728,7 @@ xfs_buf_item_put(
 	 */
 	if (aborted)
 		xfs_trans_ail_delete(lip, 0);
-	xfs_buf_item_relse(bip->bli_buf);
+	xfs_buf_item_relse(bip);
 	return true;
 }
 
@@ -824,33 +879,6 @@ static const struct xfs_item_ops xfs_buf_item_ops = {
 	.iop_push	= xfs_buf_item_push,
 };
 
-STATIC void
-xfs_buf_item_get_format(
-	struct xfs_buf_log_item	*bip,
-	int			count)
-{
-	ASSERT(bip->bli_formats == NULL);
-	bip->bli_format_count = count;
-
-	if (count == 1) {
-		bip->bli_formats = &bip->__bli_format;
-		return;
-	}
-
-	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
-				0);
-}
-
-STATIC void
-xfs_buf_item_free_format(
-	struct xfs_buf_log_item	*bip)
-{
-	if (bip->bli_formats != &bip->__bli_format) {
-		kmem_free(bip->bli_formats);
-		bip->bli_formats = NULL;
-	}
-}
-
 /*
  * Allocate a new buf log item to go with the given buffer.
  * Set the buffer's b_log_item field to point to the new
@@ -1072,34 +1100,6 @@ xfs_buf_item_dirty_format(
 	return false;
 }
 
-STATIC void
-xfs_buf_item_free(
-	struct xfs_buf_log_item	*bip)
-{
-	xfs_buf_item_free_format(bip);
-	kmem_free(bip->bli_item.li_lv_shadow);
-	kmem_cache_free(xfs_buf_item_cache, bip);
-}
-
-/*
- * xfs_buf_item_relse() is called when the buf log item is no longer needed.
- */
-void
-xfs_buf_item_relse(
-	struct xfs_buf	*bp)
-{
-	struct xfs_buf_log_item	*bip = bp->b_log_item;
-
-	trace_xfs_buf_item_relse(bp, _RET_IP_);
-	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
-
-	if (atomic_read(&bip->bli_refcount))
-		return;
-	bp->b_log_item = NULL;
-	xfs_buf_rele(bp);
-	xfs_buf_item_free(bip);
-}
-
 void
 xfs_buf_item_done(
 	struct xfs_buf		*bp)
@@ -1119,5 +1119,5 @@ xfs_buf_item_done(
 	xfs_trans_ail_delete(&bp->b_log_item->bli_item,
 			     (bp->b_flags & _XBF_LOGRECOVERY) ? 0 :
 			     SHUTDOWN_CORRUPT_INCORE);
-	xfs_buf_item_relse(bp);
+	xfs_buf_item_relse(bp->b_log_item);
 }
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 7ddda0aa9dac..8a8a46e698be 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -49,7 +49,6 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-void	xfs_buf_item_relse(struct xfs_buf *);
 bool	xfs_buf_item_put(struct xfs_buf_log_item *);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
-- 
2.53.0

