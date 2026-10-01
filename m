Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292226F289;
	Thu,  1 Oct 2026 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866317; cv=fail; b=mAbCg52K3KeM1qwneNI22i9HPQ2072+90ws2pxyeDfD0eZlMrztDpxcvktIs6eTe/3cTJuigqnWUht8rzxmJx55x/IRASlQ2l69Upg2RdpIai2pYcZWkv65ak4brsX0hgtox2WsEWoZ6vmBOorhLJ+bsfleTJQWc0/gEVvhOcZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866317; c=relaxed/simple;
	bh=scx2TssWNmfmpjMlk6BVjpq9palO2hko48tkN5tFVIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIQqugE2fnxw96xkjN0BaW/qspGrVr2hMLeR+JPuMthxoVUL0qA7MlpIj/v8NUYguixVGBqVawjhxhQ921ulC4BWrRQ5rnVrnjByjQub+hQ+JEPzBj9PLvakCbNsdCcYm3viXgP9rwMOrUE7eCuGFJ/1IB+bQKY/OsWqgMPmDpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HUm1cPwb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jXhY62gu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUm1cPwb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jXhY62gu"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMnP3539371;
	Thu, 1 Oct 2026 14:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=30ksEri+vxVXD7Tr1SG1s3yhRWt9kWWAl2h4wpOBGXg=; b=
	HUm1cPwbOUH7xuEGVB3+7eupqHOmP+Ob2ePUIR0MyVOJ5MMpUP9Mliz6KxayqcJX
	m0ypVo/z4ZnFo0RPatnklgYpKDzzAHFlmRWobC7hAs31BQ4+6GFX05+35tGFf6OW
	02yczIWrJLngyd/33MSERh/HHvdmaAK77bOptNvREZDwSx2t9Ch7yYlxUT55GqQg
	a7jzJENZZrvNgFVw/Ls7HhwuTLMwME0ul8DxShqeUyfFXcAiF4WEQskhzmEWRUsp
	Skc0QyVKvBrKo/XiVEXpHUV8Lsf1OS8I+xwzFPY7H+9jrTrU8zrPPrCNQ1lEh9o2
	rsrnQPVJS40USX1S9n566g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgykn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Enqbn017299;
	Thu, 1 Oct 2026 14:51:46 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gexysn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsGJX2Xifu1UbK8Ckp7xkaciCtO1BUU5l5SmlQZSIVd/kda7+XIfR9hwn0gDZoAtpR2nmuP1o26oLCZVghLLzYeGKehqlTY6g7eeKeSMzIkQmUdlbAY9NK61HQF7Tmp9oVExODLwR4Ldjjxq+rwPpMB62/e7TRpUM367PTLfwrnYf7RGn4XFgAnT2qdIXab96OdL4IqQxB5+cEye0RBLdqRoI5HxAqQILoOn1xeFD7MI9yDf/0VZZkVxxZZELwgRdtshn+QE3p3akmDq2OwXxs6M8s4bP3GqN6jj1NzRJOnIIu/Fv+fMOi/imjLhhz/AaRs3+ITOQ0jE+TdFP7dpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30ksEri+vxVXD7Tr1SG1s3yhRWt9kWWAl2h4wpOBGXg=;
 b=Qp/2Dp+cmUszbu63htHbT1SbLP8od5P6rzEYyoFLFVbq2A0kbfEXlhFNDiM5waRppBKMKyKGRPTsA2pyWEZvaWd1Hm+r1Pta/GkXsZLmo5YmBsojHMfyCvbcW1eUYkIxi/RTdMbaZMVFtuSMff8ya/efAd6zBNBttVq7E0sByIDRchPjqSMZuIWqxBy2pKe0z0OK3BSsbh5pzInGq6z5fanCq5EXJQt9w2Srs1JGIjsRIO1HaXOTrQhYp8HA3nh/6VTuO2aCp5kKWjjEVuV6CWqL51vblufcFJ15B8mFmU+J9GBZyfb1I6sVarIOk/p//97dtQXQ255om0LXyZuTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30ksEri+vxVXD7Tr1SG1s3yhRWt9kWWAl2h4wpOBGXg=;
 b=jXhY62gufh2euXOEp0Arqqn3QcYJ+0K4mEPM1K0W3J09VfBNP1odwyKOjYmQz4cq6UbX/MQZBBxGo/Zw5w7iuMieWjHWMtLCxqBABde0ngzFNP39jZrIksigWa9FXRjDeOc2eKy+uYGW2yU/lsr6c8YhXTeEhUugz+ZQk8gJQAM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 IA6PR10MB997632.namprd10.prod.outlook.com (2603:10b6:208:5e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:43 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:42 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 02/11] xfs: aborting inodes on shutdown may need buffer lock
Date: Thu,  1 Oct 2026 20:21:17 +0530
Message-ID: <90d07e299e303da3abad46989d91717820450817.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|IA6PR10MB997632:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6afbe1-e7ad-4999-375a-08df1fcb80a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10070799003|10067099003|56012099006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YixIwoG6U0xrmHMbAwBcpQvOTtVMA9OGECG4BGypUqmJN5Vomztw67u9Cp7klUvGrwEPyNuJqyov1QLSz6F168zTfdCXVWPwTihb691Uqh6xQI5un5N9enRE8IDP847MjUjPUq5Bem7YW+MExwS1fjqdZO0Z2Tch4iiQgHfvUUK/XGbk7mEeA9rIdfB+6I6EGCBo4c+6Dp1FvcnhVSX5ZRmwFfF4I3iJ9t0zOkr1OD3Gxew/reB1E/G1lYyJy8ayfZuI+z7H2v3JbsdqjhfO+awWFwuFUuuSrFa5vxqB4UU19OvlnVJ7dcnoU8X7+V52lB2Oe/oZ5HsNBQYn67IncoTomC+aPonUYl7swT6eaeBUVsKhlRqkN5nzbgSCnhFXUPEaICu/Vd3r54QJ1bbDRk/xlEMcgJrIXo3XaFBL/0k15MsyiUmuf2B+bWZZ61BKynk0p2cCFwY5pA1jPIMWW8sb7BuJIEgKwNlgKMxX54SDkneqqDNpTvmzf5UQJ/+66WVB9Kml/8OaHkuD3hW9GuslXrwMu+NfoK79wmAtVIVyBsGCbu4hCtL+5ZKJpoutN266QMMYX0QLWb5ytMHpuSZmKqGO8+jzvmX06Wtjv1BYTDXX3UvLYOpSUKhcPifaI/bKRs11DGXfHyYs4UBEMoIsjTgKDb4Lv8tV2iXStiU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10070799003)(10067099003)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErYqitzHv+J+O+qCJfVQCzI1xr6tV2KJlbzRGv+fk9DdnOrL62aQ46cF2CHR?=
 =?us-ascii?Q?kzZvpLe8jqKmV3MCM9Ya1Vj2XA5YuUUQuB3V93PWCrO0uMaz1WFC7J5P19R5?=
 =?us-ascii?Q?Jp8kpHSpFK1ZXmyb+94owk5Dg80MUqnquL/cZD81XxiqJHFfNE85+XwqsDdM?=
 =?us-ascii?Q?nL2UrzL25g8kD8W4CQQ61Dy1eU1jADJveJPWlgFGdtsORLx2hN3v2uvav29g?=
 =?us-ascii?Q?t3xC5EEjuw2lAZS8QmrESSKLnDtaqlvayMUCjFOYQIaiCkGKpXXVZ/r79D67?=
 =?us-ascii?Q?KSS/DY2zod3SXUqSjeyvTIVpbWBWOHyOtJkkpNiM99iOwzxExalfH/wTAWVc?=
 =?us-ascii?Q?QLr0kuyWdUKnD+RRtbUqmKkQzQpcUO3LTG45IrcPBdkVebDsc3YhXU//crNb?=
 =?us-ascii?Q?ixpRUHZ/cGh1jmU3Fcs2XRwTRgBnQSxuFW25qp+1eQl4gCU93QKJbJ9bYrwR?=
 =?us-ascii?Q?S2iZedhZi6HL4XV8nbsw35L1VDrs3gvVe7cMZeUguE/HwfrNVaiC88qE0J2U?=
 =?us-ascii?Q?okhFE/qBQ9SggPat34K///uS05RoBAxT+lUGN0pVn5OcZqaOPCaqisdFhL/X?=
 =?us-ascii?Q?wONhYj9gWdhJXfQycqh64EFQ5KXSXn328IdMMyLG9lBO3Zf/10RK7Fl9UcI/?=
 =?us-ascii?Q?OawYqNY02qBqJ6ABm5REFoHSgnIfKznXRDIGRLvIgNhdEIuAnJjzX3F3FlyA?=
 =?us-ascii?Q?bQw7e20Apfg+mmRgoDVV+RNzS1E7aJk+HhL98h48REln2//Cvazaj9NMOmCi?=
 =?us-ascii?Q?qLFzm8jjVmT9sjeqWZlNGxYLoKSmznji6mS+xqcAzzGdUU10yTrVk3bv0ruQ?=
 =?us-ascii?Q?EJ8fVLO8MDkgQz6zexiH8R4TTCJHx5TX0a+BAleTddQzAqV/GyTnv7LwINx4?=
 =?us-ascii?Q?CdJbYCc2mZ2CltjlnmcXzf0K4d98oACjn8Yl71nAbuPB0BulhGkUBdiusjtA?=
 =?us-ascii?Q?z6rJqGS3Ho3wTocjLsk3gFTyYaqD5MPYdh2yHRf7eMQz0Em8N2PXrIpkXroq?=
 =?us-ascii?Q?iucU4CAtaH81cXKVr1jm/EdA2IAiNRD2d10Msax+05q4sBVOeYiZM9lTdXJ1?=
 =?us-ascii?Q?L2n4CeIta48i5M4TkfovneH2tnSaRbA8A5txA2eFgXIrIO91ARMWkrrkB5D/?=
 =?us-ascii?Q?bXWyPjoMprI/SQGiS37WVx9b0Ouf0ZHxe9yBQVkFt+XQrwZzArI3t5tjdoiQ?=
 =?us-ascii?Q?mO+zdmBqKki5ftM5nqwX113HQfwV5ALKfP1WBgNeJb0QkJZ+60BxWu0G7x+r?=
 =?us-ascii?Q?wYS22m2z+v8dSDiMviInYb9SX9brUmD55F3YVol6Y3hDsoAgP4kntLJ/PKvH?=
 =?us-ascii?Q?+5oY77UNYBeEdA8jIQBc4C9vXD0LvVm45Q7CHtWLlLvwIU8zgzGjMqoMaaP3?=
 =?us-ascii?Q?8tyzXddfomXM5sMN4jwRgdWH0700THodv6TF8ZZRBTiKPvU0zmUsYfjnW0Ia?=
 =?us-ascii?Q?zOPOhue3IRLNJC8pp+Rg0TvlrfAcVid4OCe2X56zB+SuWye9uqVNdIV4RSNF?=
 =?us-ascii?Q?ONoJELY1eBKkhIFMkJ7J/i+6CH1P0I//JkTXhwkgYo4IBHYUeTlr8PYa8f98?=
 =?us-ascii?Q?ZBINdu12tBTovoTbxwNp40prr17z1WUNlKXDOky2YwCCMGopJdKn0SUlgF3+?=
 =?us-ascii?Q?0lcWeuDKukdnnDRLTbZ7G/hhzaoCAhOAUs1tPWeks9fcPMbhXfY9ymwKgEvz?=
 =?us-ascii?Q?Xh7qdwJHZHQP38Jt3GXJ5uPaOUINjvurRiYb78GSfJ58LmCdKsVDyLiEQKvq?=
 =?us-ascii?Q?AXCRTXuv6JgJ8pp/lgqeUPQ4/Woo/7IVHMxuV2dpuF/IKI18PAn1UcLBzAQ6?=
X-MS-Exchange-AntiSpam-MessageData-1: 7woEhvUYmiTpcdvVH53/C2dMQWmDZ+2kP/c=
X-Exchange-RoutingPolicyChecked:
	bfsW+CLFcQxI7e/r82ja9glRO+5i3LCfWHvB9lRjicFmG0VksMIMAWDqfXulhk8r7/pqN1UrHUD51EcIQExkQmSE9smF08lyV+lcKnR82w2TBbYrXZOvOuN0w/kFUFxSGoxsviP04heuLv0LMyhRcRridlqgnOaeLq2tOrQdN2mXssuxLdSp6M24bgHfd5aLJDqauysTgArnO//aqiua0wU0pzLVSReMYG3haGgpjmweDoZku25a6xSoVjADwNz7y+r+6gZHvhObw9ange7QhxLkBxlHiLEN4EhJVjg2rN9zaEif9bboR+c+ATxlJH3xpHeGijjYD4M6EX5vfBvaQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RtcI4oNSxxThgMZjuijB7tSj0OAUH3BU73f+5snimbtHBT9/BNwIMHQ+o3qh59vHRNw2ifMXagA2aHaYsZHfEyTwv1UDAZqSagB/f9kNsa6kD65VfAyjJzklQsH2oorZ100hPNxcxJdgwqLyt5AKkZeVzJVZcaBQIkV7LiJI35tK0O4u5kUKUKeRl89gXeh60VPscL3Mt/77nduXswm1emkXBMy0F5DD48XbsoJCNFpSaOmxCYmWSpdG1JCz3Q/iInvflFlSX4DzOPnV74tt5NwbjmLFns6Sy77uys9lS9RkpFsMaRURK5Ac+H1Nn2jHNqb4sTrgWe5wYeEt47/WaYSFgcLkYiaP5VOI/KlUfyBcnaDDhhIpD34yp+AruDJRWqYft0hNjJ/oxATmnCSJjwNztJRgw5SnEJiW9c4IALWwnRs+EgzbcTiHb8fgnRiCy6dX21Z4ITqYRRS3Fkxy9Q0/X+kqpUmA4CelTwwWOPpTTL3czCT0Wf4Qpem1uOCTErMB1QSU/ye/P1jdf/s1ZseMN3y/YUwXFpG2FdHNiLrHh1sQehJ3zM46wpH5Eb6NKpaAFNOi/Wr26fpeJGn3h8kdi39a+IVi6aBJ2gVvmtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6afbe1-e7ad-4999-375a-08df1fcb80a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:40.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4TkYccnbiFKGm+RKf2QPIEy5AlpvNfu7IYm5oe61aiQnUgwgc9iCABu5erElyjf2vl7v70yfzDcL4h2qqr3keIaMjrJjNpVtsk/9P8xJ4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: QRUrTe2h3KOQj8QGLGmosmhaotAN4qAH
X-Proofpoint-GUID: QRUrTe2h3KOQj8QGLGmosmhaotAN4qAH
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe7383 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=45b4cX4q9fnkLCOmiR8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4rvmRkuUY+RF
 buyh/l3LuOsrUMYytD7/INiXlnjdn5aQPPnXdfCuIovHOfUdi9vJkK8llyUI4la3Ps9y7q7xBJI
 bD5QRB7A+g9ZgjNoDfe3Jdl5Mt8YCeIGRlSGuSdO0uNUx1nboxdu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3GAaxiyIgmyR
 S9GoXcNjPgPuhGTBbvqfVuxO/+DJY1deSimX/mkMR7nG/ySJTw9tGfXqCsyO2RtXNBVvPHVfMVx
 cAlkCdkJbMINx75Mm+cp6nKE1oa4OZlu1yanMHV9hd2suV5VkXcw7TLmJYwsWT2KIahd0OacZOk
 stL2s8Ym80zK89+4OwP6NSnMrrH4LKuUu8ILdHslyj2akzIhZQJ8n1QOednDk67V5m+sd6Azclj
 mpV7L5IEjNJgcWiL5JBbEkJzP0d+8dOwEFr9BywsHKGy5zi63oYG9pzxI8FfLPceqA+LZyY61+M
 jRehJJF3gjkBfBELWW0ngQ6P5zlKUharl/b0+VNRSiL0D582qpDTZwVhtSR0JvoviDiHYu6IQve
 ieYntJmq48BUWmgGFpgdkstDmSeaL9sr4fKoB7kvyOEjB8oK/tJ/btykUaJtQh89EQxGUEqUfzo
 wEVQRXpemxawqOYaI4g==

From: Dave Chinner <dchinner@redhat.com>

Most buffer io list operations are run with the bp->b_lock held, but
xfs_iflush_abort() can be called without the buffer lock being held
resulting in inodes being removed from the buffer list while other
list operations are occurring. This causes problems with corrupted
bp->b_io_list inode lists during filesystem shutdown, leading to
traversals that never end, double removals from the AIL, etc.

Fix this by passing the buffer to xfs_iflush_abort() if we have
it locked. If the inode is attached to the buffer, we're going to
have to remove it from the buffer list and we'd have to get the
buffer off the inode log item to do that anyway.

If we don't have a buffer passed in (e.g. from xfs_reclaim_inode())
then we can determine if the inode has a log item and if it is
attached to a buffer before we do anything else. If it does have an
attached buffer, we can lock it safely (because the inode has a
reference to it) and then perform the inode abort.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
(cherry picked from commit d2d7c0473586d2f22e85d615275f34cf19f94447)
Stable-dep-of: 09234a632be4 ("xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_icache.c     |   2 +-
 fs/xfs/xfs_inode.c      |   2 +-
 fs/xfs/xfs_inode_item.c | 162 +++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_inode_item.h |   1 +
 4 files changed, 136 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index eab98d76dbe1..1ab395516960 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -898,7 +898,7 @@ xfs_reclaim_inode(
 
 	if (xfs_is_shutdown(ip->i_mount)) {
 		xfs_iunpin_wait(ip);
-		xfs_iflush_abort(ip);
+		xfs_iflush_shutdown_abort(ip);
 		goto reclaim;
 	}
 	if (xfs_ipincount(ip))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 98955cd0de40..13a113ed666f 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3648,7 +3648,7 @@ xfs_iflush_cluster(
 
 	/*
 	 * We must use the safe variant here as on shutdown xfs_iflush_abort()
-	 * can remove itself from the list.
+	 * will remove itself from the list.
 	 */
 	list_for_each_entry_safe(lip, n, &bp->b_li_list, li_bio_list) {
 		iip = (struct xfs_inode_log_item *)lip;
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index cda71e0c70f6..1e9980a5f80e 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -544,10 +544,17 @@ xfs_inode_item_push(
 	uint			rval = XFS_ITEM_SUCCESS;
 	int			error;
 
-	ASSERT(iip->ili_item.li_buf);
+	if (!bp || (ip->i_flags & XFS_ISTALE)) {
+		/*
+		 * Inode item/buffer is being being aborted due to cluster
+		 * buffer deletion. Trigger a log force to have that operation
+		 * completed and items removed from the AIL before the next push
+		 * attempt.
+		 */
+		return XFS_ITEM_PINNED;
+	}
 
-	if (xfs_ipincount(ip) > 0 || xfs_buf_ispinned(bp) ||
-	    (ip->i_flags & XFS_ISTALE))
+	if (xfs_ipincount(ip) > 0 || xfs_buf_ispinned(bp))
 		return XFS_ITEM_PINNED;
 
 	if (xfs_iflags_test(ip, XFS_IFLUSHING))
@@ -827,46 +834,143 @@ xfs_buf_inode_io_fail(
 }
 
 /*
- * This is the inode flushing abort routine.  It is called when
- * the filesystem is shutting down to clean up the inode state.  It is
- * responsible for removing the inode item from the AIL if it has not been
- * re-logged and clearing the inode's flush state.
+ * Clear the inode logging fields so no more flushes are attempted.  If we are
+ * on a buffer list, it is now safe to remove it because the buffer is
+ * guaranteed to be locked. The caller will drop the reference to the buffer
+ * the log item held.
+ */
+static void
+xfs_iflush_abort_clean(
+	struct xfs_inode_log_item *iip)
+{
+	iip->ili_last_fields = 0;
+	iip->ili_fields = 0;
+	iip->ili_fsync_fields = 0;
+	iip->ili_flush_lsn = 0;
+	iip->ili_item.li_buf = NULL;
+	list_del_init(&iip->ili_item.li_bio_list);
+}
+
+/*
+ * Abort flushing the inode from a context holding the cluster buffer locked.
+ *
+ * This is the normal runtime method of aborting writeback of an inode that is
+ * attached to a cluster buffer. It occurs when the inode and the backing
+ * cluster buffer have been freed (i.e. inode is XFS_ISTALE), or when cluster
+ * flushing or buffer IO completion encounters a log shutdown situation.
+ *
+ * If we need to abort inode writeback and we don't already hold the buffer
+ * locked, call xfs_iflush_shutdown_abort() instead as this should only ever be
+ * necessary in a shutdown situation.
  */
 void
 xfs_iflush_abort(
 	struct xfs_inode	*ip)
 {
 	struct xfs_inode_log_item *iip = ip->i_itemp;
-	struct xfs_buf		*bp = NULL;
+	struct xfs_buf		*bp;
 
-	if (iip) {
-		/*
-		 * Clear the failed bit before removing the item from the AIL so
-		 * xfs_trans_ail_delete() doesn't try to clear and release the
-		 * buffer attached to the log item before we are done with it.
-		 */
-		clear_bit(XFS_LI_FAILED, &iip->ili_item.li_flags);
-		xfs_trans_ail_delete(&iip->ili_item, 0);
+	if (!iip) {
+		/* clean inode, nothing to do */
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		return;
+	}
+
+	/*
+	 * Remove the inode item from the AIL before we clear its internal
+	 * state. Whilst the inode is in the AIL, it should have a valid buffer
+	 * pointer for push operations to access - it is only safe to remove the
+	 * inode from the buffer once it has been removed from the AIL.
+	 *
+	 * We also clear the failed bit before removing the item from the AIL
+	 * as xfs_trans_ail_delete()->xfs_clear_li_failed() will release buffer
+	 * references the inode item owns and needs to hold until we've fully
+	 * aborted the inode log item and detached it from the buffer.
+	 */
+	clear_bit(XFS_LI_FAILED, &iip->ili_item.li_flags);
+	xfs_trans_ail_delete(&iip->ili_item, 0);
+
+	/*
+	 * Grab the inode buffer so can we release the reference the inode log
+	 * item holds on it.
+	 */
+	spin_lock(&iip->ili_lock);
+	bp = iip->ili_item.li_buf;
+	xfs_iflush_abort_clean(iip);
+	spin_unlock(&iip->ili_lock);
 
+	xfs_iflags_clear(ip, XFS_IFLUSHING);
+	if (bp)
+		xfs_buf_rele(bp);
+}
+
+/*
+ * Abort an inode flush in the case of a shutdown filesystem. This can be called
+ * from anywhere with just an inode reference and does not require holding the
+ * inode cluster buffer locked. If the inode is attached to a cluster buffer,
+ * it will grab and lock it safely, then abort the inode flush.
+ */
+void
+xfs_iflush_shutdown_abort(
+	struct xfs_inode	*ip)
+{
+	struct xfs_inode_log_item *iip = ip->i_itemp;
+	struct xfs_buf		*bp;
+
+	if (!iip) {
+		/* clean inode, nothing to do */
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		return;
+	}
+
+	spin_lock(&iip->ili_lock);
+	bp = iip->ili_item.li_buf;
+	if (!bp) {
+		spin_unlock(&iip->ili_lock);
+		xfs_iflush_abort(ip);
+		return;
+	}
+
+	/*
+	 * We have to take a reference to the buffer so that it doesn't get
+	 * freed when we drop the ili_lock and then wait to lock the buffer.
+	 * We'll clean up the extra reference after we pick up the ili_lock
+	 * again.
+	 */
+	xfs_buf_hold(bp);
+	spin_unlock(&iip->ili_lock);
+	xfs_buf_lock(bp);
+
+	spin_lock(&iip->ili_lock);
+	if (!iip->ili_item.li_buf) {
 		/*
-		 * Clear the inode logging fields so no more flushes are
-		 * attempted.
+		 * Raced with another removal, hold the only reference
+		 * to bp now. Inode should not be in the AIL now, so just clean
+		 * up and return;
 		 */
-		spin_lock(&iip->ili_lock);
-		iip->ili_last_fields = 0;
-		iip->ili_fields = 0;
-		iip->ili_fsync_fields = 0;
-		iip->ili_flush_lsn = 0;
-		bp = iip->ili_item.li_buf;
-		iip->ili_item.li_buf = NULL;
-		list_del_init(&iip->ili_item.li_bio_list);
+		ASSERT(list_empty(&iip->ili_item.li_bio_list));
+		ASSERT(!test_bit(XFS_LI_IN_AIL, &iip->ili_item.li_flags));
+		xfs_iflush_abort_clean(iip);
 		spin_unlock(&iip->ili_lock);
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		xfs_buf_relse(bp);
+		return;
 	}
-	xfs_iflags_clear(ip, XFS_IFLUSHING);
-	if (bp)
-		xfs_buf_rele(bp);
+
+	/*
+	 * Got two references to bp. The first will get dropped by
+	 * xfs_iflush_abort() when the item is removed from the buffer list, but
+	 * we can't drop our reference until _abort() returns because we have to
+	 * unlock the buffer as well. Hence we abort and then unlock and release
+	 * our reference to the buffer.
+	 */
+	ASSERT(iip->ili_item.li_buf == bp);
+	spin_unlock(&iip->ili_lock);
+	xfs_iflush_abort(ip);
+	xfs_buf_relse(bp);
 }
 
+
 /*
  * convert an xfs_inode_log_format struct from the old 32 bit version
  * (which can have different field alignments) to the native 64 bit version
diff --git a/fs/xfs/xfs_inode_item.h b/fs/xfs/xfs_inode_item.h
index 403b45ab9aa2..9c829cf5c839 100644
--- a/fs/xfs/xfs_inode_item.h
+++ b/fs/xfs/xfs_inode_item.h
@@ -44,6 +44,7 @@ static inline int xfs_inode_clean(struct xfs_inode *ip)
 extern void xfs_inode_item_init(struct xfs_inode *, struct xfs_mount *);
 extern void xfs_inode_item_destroy(struct xfs_inode *);
 extern void xfs_iflush_abort(struct xfs_inode *);
+extern void xfs_iflush_shutdown_abort(struct xfs_inode *);
 extern int xfs_inode_item_format_convert(xfs_log_iovec_t *,
 					 struct xfs_inode_log_format *);
 
-- 
2.53.0

