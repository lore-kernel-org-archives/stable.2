Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC95218AE;
	Thu,  1 Oct 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866297; cv=fail; b=MDIOM76Um5U3mwSt2JDTkLgT3giSJ7FRkcc6WzRoSleTedD0tKPL0ur/J4LA8eTutEBINbLVMVZoIX46HDU6g3y2fMMuUBiP2rulcu8wchgJwuvCIfcrfGIBHJXCXeRUNKTMYvEllAqNnKikfaweTjMtVz2HvuxouZ0e1vQYJUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866297; c=relaxed/simple;
	bh=RwfxJuA9vgvNv1KkzOKTApnP3rqElAOBSPcpf758Jg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A3bncTQXKomZApIq1wu/nWIm27Pbt8faaHBc5XSW3ljg6i0AJNfPp91BDEq4Qge1z9j3n8YPr8l0zvkyFiLdcMl2dSvW/ZhOIlq/FzheDAU8326m/rJpJi9kFJ7y55NFBmH6qK1LbiEWOODGQ12pGMGAYN/KWIEWANIRFBTqEhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E2TsTj1V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VNxS6A/L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E2TsTj1V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VNxS6A/L"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMroH624564;
	Thu, 1 Oct 2026 14:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O6/wmx96sQpd4V+L33rp+LowzKIJGzAnL3PwrQQ5fCo=; b=
	E2TsTj1VNORziWZ16bKciuIFzlAVsTeGyClaox1H9mGhsrzdKGtQX0UU4Zap2Wo+
	4sYTZWxQmn+lNCNYwOZJSJ5dsiTxF9Zj8qogqXoy/K8bCvEcotrXBf9PLbHveLOU
	f5WJyAWm+HyU8tZfKmTlVH9yjHg0IX7ST+sp04PGJ6+XgvDxK4jhyelkYBLFkSQb
	ssaBM9Rxm51P0DpeyWuCzdJERZlZ4YdhENBnlFbOLwfXqCv41LMls3q01YQ1ZIx8
	zAlaHqh0vKZv8+sUBrcz2Bh2mjG/9k6LBH8fDsl7CTI3QR+SQ6nE8PqPjoGAs9m2
	3iA4Ea/lS8XBxysDD5/p5w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns102v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoOnq031610;
	Thu, 1 Oct 2026 14:51:31 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd2tg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t67rqK/dAZ+4zXRYJIA0A8pQVLo1mpaHx2cUtOjZZi2ocnKxfTPdBVDxsgM6RbkM+zH8EseHLBfQq2dVNEerdFskjX9UMSK6nqdF9LdqQddkVYTQtEScYXGfhQjsOZWz5RlAe7FKYfXQSFl0vZZOlfEK4kMhZhSEZF8/BTtey/axp18Kd7TwsF4UOJzuEXEn6911wKHHov2+CskstCuywL3okPpkUYYqc+y40077QNZlDAVuHvtxQnTSOlqkG7OIdIO+DklLNYatHuaPsRGpbH1dPm7/9M513Tm2acFhdq5zj+Vs18ty7VTScaEl75k5xnF0ScXP25TSaaTPtZVanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6/wmx96sQpd4V+L33rp+LowzKIJGzAnL3PwrQQ5fCo=;
 b=msSwSftR2QE5WByJHXrrA6oQEIVmWquGzVp+kM1H2C/53UTuY4TFCNNEymosjWcaAohj5R3uH42qNj6SERjAKV6xkMId8Ik4QOjwnxZumMgm2hviNHL/coLSGw4DgCYKKG0YKj/lCQB8To285/ngVCBJ/OgxO0TQTMYUiJVoe+nVlOjOhv6fwBKgQR8OJv3HZ1EbCxoEEYDnuxE5cB7fXL4A7tF59oaiPmc0cwo/EUNVQeo9+RhIwn49N0jQJmMPAfGZ8ijPKHrpytlU0B+5rz0+DuGgg1DSXsI3TVb+89n5vr4nWlobUvWAtZ2qI+YsXNR4L3yfSyQJpbApCBswKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6/wmx96sQpd4V+L33rp+LowzKIJGzAnL3PwrQQ5fCo=;
 b=VNxS6A/LNl00rtHXV9wnhpLMVRTULH0RK4o1jEFMuLItPnJk8MZYK/vsc19eQRcS08xV2mt+qoEkDmf4btegj7ub7bp1DSbeF+sOrohuz3/Z6bcTsTMvqy14GtBTZY4FDkaGxukQlX8sb2qU4EDKJ0/7SUoz5IaW39qk5LVBRBo=
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
Subject: [PATCH 6.6 1/6] xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
Date: Thu,  1 Oct 2026 20:20:58 +0530
Message-ID: <89d2208c0e186c8ab7b814d4de4e1cfc9a74d37d.1790864521.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864521.git.siddh.raman.pant@oracle.com>
References: <cover.1790864521.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 0978cfdc-8c2f-49c3-989f-08df1fcb7805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|3023799007|260925022911599003|260925021311599003|260925021911599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XFYTrXV4vCBbAkHhKExqToyLgWPk98v2mSHvbDuHvrMKu2rtxZF1HO7IMzCA2ioGiG+U6Gx7D8KA5w/NJ9yWoHKtoNzloyUQlk8rrtemZfTZGuDPs+u1BCcTuwQa3HPMFcb3ZnsTm94rP8Vs58zy8M/H29ExzplcbVS/sYjNbO3TJNmxRs78hufiJ0bCePVTRS891vGEqVqSbsV+awxgyW8jaoZQPLr0HR7A0mrEgsOfrg/rOxXb3CP2DXJrOFrCywsFd71zMUhUYnjauJqgD6BxQb8eXMfbiMe21t8UZEv7pZsLlvbBN3iZZ2xnVbodO9hr18Qzvq2Vb4XJ4beJMRe7h6ryuEUvF71nT5NdxM0+7LSQfhYygJHBKdUgd/lseANN11zl3RZAZNyMcONZhvK+isUH0jMY/iVUpscJvEnUz0PaK7yCri22YXJetBkBnlLN16JZlh3Rz7+3BLkjCRfTAyavAHZTaKj+lPF1kk35qv49N02t6tgASAcuBhYHO8WQb61h1r2oszqSvY97WjPhSIkJBfLUcz4TTPCnI3QfANnLiyKzjzdY82VtHNEetOQ92qOkRKsBVZuLN3HHWx/Zoz67KBQM95hzl6sCowLMRRFolEfvuSu2AJ5880w+U/CVcEouSDoHMFkO5cqkyLz+URkbza82bL9zh5XedEE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hbTFdR2ty7Gyij2uCJicXxFrtp1/QywFxCZbCoT4ZN2CgGkd3ifXd0Ulin7?=
 =?us-ascii?Q?uNv4nf3ofze2Ooz+IAc2h/92ctK0dnH7yPhpIeTCgc9PZ64DmG8BqY6Uym80?=
 =?us-ascii?Q?CbYqRrav2yaqFwzYMiBUs4JayhYmANA6lzfBy0HKNv0EJ73q0vXA8QJyQYyA?=
 =?us-ascii?Q?Si9VSvsU2Zx3aEW8ejtCbVYKcfv0Ke57EvwLY1bEI4lijv+sC26MGDTL57ip?=
 =?us-ascii?Q?KVSDgXSQyZro4pjvM+N3IzsNNcuIYAjob2/g2vEbSiVoOtbXv1D19R4hgm5I?=
 =?us-ascii?Q?RZCXHD45HqiFCbD3Ma59h9azELacykqvejnh8PHbqoYxyLbF4n56h1YZqYcU?=
 =?us-ascii?Q?+vRp8azOlRdc9qGS13cu9d39R5Wj2NnC2+/NYGiRZXFp7G0b0qaWHRHuaHid?=
 =?us-ascii?Q?PKI9ZjGVsucBS1HRl7wNMJz4Kr7B3z3gA1WGgWArqWrzrMG7rY4uuvV7ppUF?=
 =?us-ascii?Q?QuQor6cv+rzawcKpDNTENqNAd0rpaOPnZnsN3x1eJXz9bJaIffnfZODk9+9W?=
 =?us-ascii?Q?3vLNefh/y1DqBlZR33up+R+krUzIFK3ozlwPCKlZKS9WfbFMtzaO89vZO586?=
 =?us-ascii?Q?3wJ+MTg5n7dA4B1TmhKLVvfyuiRkp+S/s+0uP165E7Yel+8rOR6fcCDg69SK?=
 =?us-ascii?Q?eyoRRhk92ZzXa5A4oiZtk6srhwWVRcwE4AljHqVuzBSWzBFp/D4oAMfYydeh?=
 =?us-ascii?Q?cMl4wMJX7ntOOAbx4HRJZbdYaMXz1QhVigH5UZeDmNXjrQY97AkIDWe0iBnv?=
 =?us-ascii?Q?u9NcSdW4XH5++VTlyJe6KO05ScvVNDi3qg3ZB6M5NagCsux5HI0y5ILOsD6R?=
 =?us-ascii?Q?R+mQdCauphlqd9q5oHzsSL233ts23B5gg+vDmobPLLpMJ/iX/Ym30PziEQAw?=
 =?us-ascii?Q?snkQ/WBaHe/DoMOMSWqmSu7Fy1O4amCUUlcTQIBrvOoZvAYtqBUgThRkPRKJ?=
 =?us-ascii?Q?WObDn9yYCvgvDUqGDmcQSzTTBUxlfhTCT2dGndhJjt+AP/SZKLZ16HGfP9E+?=
 =?us-ascii?Q?qXvipN3nhJZY8XjNPP5S7zVC4YMHqTUzrrmcDZjQBt52mXdBsQWUxp9tDZXd?=
 =?us-ascii?Q?jYLAqzGVVGZGVoxNRpll4KpXYk3VqftH/up9xou+kuPeGWuotj/6wTCo1g/U?=
 =?us-ascii?Q?uzOJcj2xyncibgGwwYslMiQqE1PTlwX7PdaC7+YjFK1QTcIpyInt4+ZW7sIg?=
 =?us-ascii?Q?0DYU66aVnTiMMK2uliWEubNJc8KcJ6Jj6dKOwiEgFmuQi92SdRbJ3v/+fH15?=
 =?us-ascii?Q?R0CKkSWeQm5mWFdzMDXeAIVo2Uc0C+VC+uj7gKLggCQpMXWqcxzUXU1sdENN?=
 =?us-ascii?Q?fBxLk8bqUCgIqbe6qPr1Mw84veXdd0t4DEuKqFuDxgPyJ7E5kmeQWMviPXfQ?=
 =?us-ascii?Q?oeT3WmKg5aoNqYgqmIGpX8jGOGLCDNb2KledP+qskc0x5IsG2YDBEfraX28t?=
 =?us-ascii?Q?f5wNZMJoZTikLgiyAFpVtfhQ4ZOBsTe8QknHxaCKJE5qD6e4ND9+4sdvXxV3?=
 =?us-ascii?Q?6PDulAq6txonhnBZTxe3a2r7j6O8/WZ/nihCGi/+LGjrtOpP7wBh0CX14Nj2?=
 =?us-ascii?Q?F0FTC2nWqr44TRWFP29DcLDktGCWEIc1/NXTmF9mbWctZk4Gsqy5f0WNS4n8?=
 =?us-ascii?Q?iEa1OoHoR0oAuFLi97fOsiow8XqEg8PdrI0vBQ8c1w2AGlt2ojcY2gCH1NY/?=
 =?us-ascii?Q?ano0lykaKW5la3e2GHte+NGXa9B6uRfc0jt200FN4koopkH4vEjKDW4VysTo?=
 =?us-ascii?Q?7JOX1GaABucBRNLzILXPrrqhbCHOjP/qXiSH+4v4tlaI4q5c+yrYJxJLL2r6?=
X-MS-Exchange-AntiSpam-MessageData-1: T2Lo7PggUV3BEcGGE7Nyqt57eU05u9nAB+4=
X-Exchange-RoutingPolicyChecked:
	EieaNZa/XLljZ8k0Rv6+82nNlJnESL2Eg+CrGmkCtXwrDiSjSlZ77Zh2HIOKcbct4FgHDY0t3W3i/yJbS/R9C3ir3rAJoiO2/LPxhFAQJAYSoQ02CdGSq0Bt5P0CqhY8BLeOnsPzZZMby7PyADeuhZjGpYUkjHhW0e1aAl4A3PJ1srQ2FnJmX7ft6cvqyfllitrR+KEEKSuaqS2BtKM4mTv9DuB54ufiM2q1T2e4XbphVa1Ou77sIDA5zTZfxvcqnrE7Zg+G8igk0kRZqLHKzqvZiXT44hgSSjU20PvGOa6nboKHxN1XD+Sr5vG6eFHl9gBYj2ZaiLz6pbLHttok3A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hdAXPhkYFcHxslxqDW94AFT1sY5ndCjjAWqiTHkO3J1szx/I7nBux6yL5c0WSaXSlQY/qDpYg50x1FULSp8JM9V87iUypK8IVHavjHJjgYpZT7xbUnLiEGsOpf2jZ1r7EdflFD2z8cVz5Y6X3aTJn7nawolWobLqWQEu3fbz5yhPiCLB8NyUVBT16NZRnrpfn9vxuhwDj7eB8gYiAoXeQXi+qJ1Lh5Ai/+/1lqBcZovN/bukj+G4H6qeOBL9NAg5NDAPCoBkz2t0VlyQeqky9y7z0SkTTlfRq/ZtZNh3A2LWidxnKsBDeJf9I5lF72+IzJr4c4sJLqmkpC5lO8wUku/pmFJ44iIn28/KOLzXnErNQB5gYREnPpqNSqeKnKrSuQZR2+zxeChwYn8iNO5KpoArfCJ63SW7754sSZNO2k+5GuWSdb7SpnGp6YUSVpZ2qJZ6lPcHEAf5HjGuRZuxXh2WeLB1yruseoRpR7kwpo9lFlGCCh4Vqe3TOHFNOKkbU7qtcJ/nhi+vsih0GtQiXEpVqoZypIWM4Pn4ZRKtve39tdh37EMptPRKxjvqKQYLDg8QwEkx1WgoC8iJRXoXLx1cHM5f4Le5enrKq+yGkco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0978cfdc-8c2f-49c3-989f-08df1fcb7805
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:26.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdAhQtMeGHt1vHWHBqv7YM61sXl/0pvhhW3VWJSzmtmV9EObXdpztEv7Z8JXqg7JmvffawQ8HFayBG4cESwrDa6JFq1QEZ/seATa2LoYWGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX0iVY89QRoOfS
 /bpaDi34N3mAoidznS7vMctPDaYUZjYD3ZdGibWKWFkpqrIOXiv/mZteT5WQvrAUKNn0TxjYJTd
 sMFJ7FRIqBlD4hwUKMI35+jo+Du0ZQl4r8GdZZLdoBWt+2epnmV10VG6du1R8jOVJfUwrqwKgWN
 lbz7+Bam5BqI19Kno78vxSsXFyZkk7ZM0Tofn9zk8lx6sgNWjWvlEwPhtpcL+cvqIvt+M4cUoTA
 q4A7FiFpYxbV99kzAXGXCVFO4oWv0zJVLaEHxDh1vbmEl1iBQD9bmK8iH4ZzHEgIskJ3I9r+fxx
 QA7JomUwXYMmxVSAaaLYQeX+4uqrJIeUJ2t7+vtQ11V4qaWhln8MajGRrHfQcszkzbOY2mBJQza
 HJNFZY1ISavnQ0rNEOKUaSMf7K13nPZlvOn7r0Gz/ZXnuuB2Crv95Os/Qbqkol+WuR7B246MB4N
 PWmfzyw1MI3WRIjy8LsGngAjqbsYIL98uKSG4jRU=
X-Proofpoint-GUID: ruoS70szthjUSisH46Iy3h_FFqlfRb8d
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe7373 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3/XiqVhRsDJk
 ruBvhchljysmsDglOqg4aQmt3VuM2LxgtnbMSXUkNvbK3RK2TIZi8I84pPUTiabJ+RQrB7THwZM
 GvO+omEYkp8I1m1Su6h43X3wBn7peeSEyspvrg6QD72DcRGQRfBX
X-Proofpoint-ORIG-GUID: ruoS70szthjUSisH46Iy3h_FFqlfRb8d

From: Dave Chinner <dchinner@redhat.com>

Lock order of xfs_ifree_cluster() is cluster buffer -> try ILOCK
-> IFLUSHING, except for the last inode in the cluster that is
triggering the free. In that case, the lock order is ILOCK ->
cluster buffer -> IFLUSHING.

xfs_iflush_cluster() uses cluster buffer -> try ILOCK -> IFLUSHING,
so this can safely run concurrently with xfs_ifree_cluster().

xfs_inode_item_precommit() uses ILOCK -> cluster buffer, but this
cannot race with xfs_ifree_cluster() so being in a different order
will not trigger a deadlock.

xfs_reclaim_inode() during a filesystem shutdown uses ILOCK ->
IFLUSHING -> cluster buffer via xfs_iflush_shutdown_abort(), and
this deadlocks against xfs_ifree_cluster() like so:

 sysrq: Show Blocked State
 task:kworker/10:37   state:D stack:12560 pid:276182 tgid:276182 ppid:2      flags:0x00004000
 Workqueue: xfs-inodegc/dm-3 xfs_inodegc_worker
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_timeout+0x8b/0x180
  schedule_timeout_uninterruptible+0x1e/0x30
  xfs_ifree+0x326/0x730
  xfs_inactive_ifree+0xcb/0x230
  xfs_inactive+0x2c8/0x380
  xfs_inodegc_worker+0xaa/0x180
  process_scheduled_works+0x1d4/0x400
  worker_thread+0x234/0x2e0
  kthread+0x147/0x170
  ret_from_fork+0x3e/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 task:fsync-tester    state:D stack:12160 pid:2255943 tgid:2255943 ppid:3988702 flags:0x00004006
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_timeout+0x31/0x180
  __down_common+0xbe/0x1f0
  __down+0x1d/0x30
  down+0x48/0x50
  xfs_buf_lock+0x3d/0xe0
  xfs_iflush_shutdown_abort+0x51/0x1e0
  xfs_icwalk_ag+0x386/0x690
  xfs_reclaim_inodes_nr+0x114/0x160
  xfs_fs_free_cached_objects+0x19/0x20
  super_cache_scan+0x17b/0x1a0
  do_shrink_slab+0x180/0x350
  shrink_slab+0xf8/0x430
  drop_slab+0x97/0xf0
  drop_caches_sysctl_handler+0x59/0xc0
  proc_sys_call_handler+0x189/0x280
  proc_sys_write+0x13/0x20
  vfs_write+0x33d/0x3f0
  ksys_write+0x7c/0xf0
  __x64_sys_write+0x1b/0x30
  x64_sys_call+0x271d/0x2ee0
  do_syscall_64+0x68/0x130
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

We can't change the lock order of xfs_ifree_cluster() - XFS_ISTALE
and XFS_IFLUSHING are serialised through to journal IO completion
by the cluster buffer lock being held.

There's quite a few asserts in the code that check that XFS_ISTALE
does not occur out of sync with buffer locking (e.g. in
xfs_iflush_cluster). There's also a dependency on the inode log item
being removed from the buffer before XFS_IFLUSHING is cleared, also
with asserts that trigger on this.

Further, we don't have a requirement for the inode to be locked when
completing or aborting inode flushing because all the inode state
updates are serialised by holding the cluster buffer lock across the
IO to completion.

We can't check for XFS_IRECLAIM in xfs_ifree_mark_inode_stale() and
skip the inode, because there is no guarantee that the inode will be
reclaimed. Hence it *must* be marked XFS_ISTALE regardless of
whether reclaim is preparing to free that inode. Similarly, we can't
check for IFLUSHING before locking the inode because that would
result in dirty inodes not being marked with ISTALE in the event of
racing with XFS_IRECLAIM.

Hence we have to address this issue from the xfs_reclaim_inode()
side. It is clear that we cannot hold the inode locked here when
calling xfs_iflush_shutdown_abort() because it is the inode->buffer
lock order that causes the deadlock against xfs_ifree_cluster().

Hence we need to drop the ILOCK before aborting the inode in the
shutdown case. Once we've aborted the inode, we can grab the ILOCK
again and then immediately reclaim it as it is now guaranteed to be
clean.

Note that dropping the ILOCK in xfs_reclaim_inode() means that it
can now be locked by xfs_ifree_mark_inode_stale() and seen whilst in
this state. This is safe because we have left the XFS_IFLUSHING flag
on the inode and so xfs_ifree_mark_inode_stale() will simply set
XFS_ISTALE and move to the next inode. An ASSERT check in this path
needs to be tweaked to take into account this new shutdown
interaction.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 09234a632be42573d9743ac5ff6773622d233ad0)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_icache.c | 8 ++++++++
 fs/xfs/xfs_inode.c  | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index c54a7c60e063..5303702083ef 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -879,7 +879,15 @@ xfs_reclaim_inode(
 	 */
 	if (xlog_is_shutdown(ip->i_mount->m_log)) {
 		xfs_iunpin_wait(ip);
+		/*
+		 * Avoid a ABBA deadlock on the inode cluster buffer vs
+		 * concurrent xfs_ifree_cluster() trying to mark the inode
+		 * stale. We don't need the inode locked to run the flush abort
+		 * code, but the flush abort needs to lock the cluster buffer.
+		 */
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		xfs_iflush_shutdown_abort(ip);
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
 		goto reclaim;
 	}
 	if (xfs_ipincount(ip))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index e1adad91dba6..a9fa5b1fd208 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2235,7 +2235,7 @@ xfs_ifree_mark_inode_stale(
 	iip = ip->i_itemp;
 	if (__xfs_iflags_test(ip, XFS_IFLUSHING)) {
 		ASSERT(!list_empty(&iip->ili_item.li_bio_list));
-		ASSERT(iip->ili_last_fields);
+		ASSERT(iip->ili_last_fields || xlog_is_shutdown(mp->m_log));
 		goto out_iunlock;
 	}
 
-- 
2.53.0

