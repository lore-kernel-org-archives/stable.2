Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC92530DE1;
	Thu,  1 Oct 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866339; cv=fail; b=Gn6aNHSsH+yFAHZTrWnqAppwJHNAq3d1J56nf340OKEEHO1jKl1bZ0DnQ+4/Mz8OXFqTRdaMzbjL4y4owbG+1okUoMStsuiTq4D7hhVVJV9oYo71sRj1ZnT6fcAlSVTDUBlJwpCm+mSJDhHlvWn2ZNaO41Ate03qzLppkIYTxaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866339; c=relaxed/simple;
	bh=lg6kEcdZKNj/HWraPlhCziENBz4zkzVYNCXwzE2Y6ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wr/qJWEY5dENfwFweswMKW2Gb92L5W5KY37IALqysF47Bo7gy+Jf6FJz/u5v6ZfqFdtH4o/zrDPsMywulQSieO4uXYF35hxbwX6Vd25MdU7kwLggNnZyndQgvlgiobnGtl23fTKZ6EymvXCdE3AuQms3qNWVxwZwOEYzVL8/P6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oMAwPUYc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uMlfQNfd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oMAwPUYc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uMlfQNfd"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMgk92256997;
	Thu, 1 Oct 2026 14:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zZZVKidDYZ9xlmE8tInEPSsvizjjRLPcnnFu/qmhFls=; b=
	oMAwPUYcBxw3E4uYjkLmJ94dONDK/6lmQmxnReiLHzhbEGkCJsq9dlangQ7pvsqu
	CGOOV2O67CRTlUV6JB6of5VdtaekWtGBEoUsfdr2yRN7JHaawoRbSUOyZ327NuGl
	+iBY8Zy770fenl7jsG5CDK9UzwEh0ATPQnsDG8Ed3g1f4FnRj8B4EzzmjIMnZPD8
	3sV6tytdeVLwDT3QPtChQzYPNr4Z8L2e32BcqwWKdxjgOPWwLlG1175tzgQrqazW
	XP/mrtVSwR1FsssnoDOTOhKPsKo4XMrrEUtHDtITqBFu2pIcG+e9JRH0QGFPQk3R
	/wCgse6WQXDCUxxWEO5vag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo66a011860;
	Thu, 1 Oct 2026 14:52:11 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxsne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA2p1WkB0gLzTW8YBSkMerXWkRc5Qxvwv8OPT1G8DpHSrVfpPi+WBfNl03P3+5zwxzQT1jT5k78rN8YXUmM/zv+RLbpRQOmlEmL+BqUbkl5ftadSGdDEel0budV/5AAwSxPxxqm8+dZN63J8f1TpKSpAF2mLwGFFyUZLykzQ548sITAcJFSMNV4hg7CtWsDD0o4EMmI8RX3gWW647WLAtCwPbf6f72B301uxZDZ2gV995W9IMEi/R86pVNVCGeJdDaCWRbHC5OPMES9kMQ9+nyPqshq96m2yVSW96FQ2CrpV2TfQSINBsWTmGGt9s/rt1+FZrLqV0fp4keCncaIa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZZVKidDYZ9xlmE8tInEPSsvizjjRLPcnnFu/qmhFls=;
 b=FLZ1HWxIYhkNsDGF3+TpkRbpx7vx8RaJUJ20K7bheAU2I9T2hzk5p/FIDOVRMw4HPl1ULnrvtIUM/Bck9Np3vNzGpCqdE6WACEe3VJ/bIDcn8yRT4whhUOo00AecLMn8kuwU0pYE1AulXjQktWu9PnWQQX5PBTgxwZgvNJvS2UGu3/qUdoaz6qlBx5jor/e2bhmn/Td3MpdH5r9+xz7YxhcIeEv49KBaOUTczETW34eelkhPSnE3cqUK6ln05fVcjxFazwrrugi193a+Q0/4EPGYUlLiCrN4jz7TVMZ6R+AZs7CTWB0YZz4yHsDZ50Vx+G80MUJ3O5GLKk3Y2uRnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZZVKidDYZ9xlmE8tInEPSsvizjjRLPcnnFu/qmhFls=;
 b=uMlfQNfd1uXaCf2Vu/R5BqvZoyud6ixSR1bw9rVk9Zfi/rKYg4/p8tCiQYfeUoM9fYb+112muoDpP+e/aiajVvGvztK7H2+GULI0FQ2RGq6PqPDVl4ELmAwo4CDJTGnMUHgZlOCnfmEwRMhxAYWmqPDbQZsQDCSHBDIj20dm56c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB5145.namprd10.prod.outlook.com (2603:10b6:610:db::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14; Thu, 1 Oct 2026 14:52:05 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:05 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 06/11] xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
Date: Thu,  1 Oct 2026 20:21:21 +0530
Message-ID: <c498fab23c8f1679c70c3c229171883340c205af.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc57b06-eea0-4c65-2254-08df1fcb8b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d67LnwNVJ/L/Ro0gyV4f72fhdZWT5+CeafG3+tl33rtv1mPQ+HSoBE8QkOmr5O3qwQIxmpijDCpYi3h8JwnvTWTLLdpoKk6CjO1nz7KBi4/gy/0zcoGeqyh1bs2mENPThe8GSFXBZ8o/6rWvvBRdkSOMbrPVcU16fvTgdX0XFh3DZGV69qApUZ/fgATsK90Zbx8LbYPFctu1Xc6XYNhztKwiH179q6V0WzvO5U9gePHs+lYl0isFPpRCnR7AJWggtaORWmQTG+deWZyiZAVirHjn45o7KdMIP7hl/81612p6fdP4K48FLBIYGJNZHt+m82jvVfVm/2ZrJTjvaQoEnwBmP+oT9yDC3vSfHQU1C3Qlqm/2/5F2jYit0/lrUXaNEFfbdL5kK0dxi4vijGAPAcDykNMw/HYSl6yVEaQ6PFm1MXoEh/03MdrDZHJ4fknZoHdJ2T63lN1E9pGl0UNan0/Dnff/mGm+HECLRRIbobxaVsI4ABdYpqY+p21XkEb3orS2Hpo5z6vMdpSqPW+Z8mPObT1KwAJW7vG2nXMrssftJf3IpVYDeEj6xDv+fnbj7HGu/KyBH8gfOPEdoTYYrAehqlOkT3MgdUPyJABdFgnVv6DlZz4W7MRGru1FxmOXpqfG3YLZSL7ylwzQSr46txl+jrj3MyWiUob0MheepLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b4bxv1c0jCT6Z3PYHywCM9wGKi1gOxBWYMbndDt8NfdHbqq7zBWwxgVSiwhO?=
 =?us-ascii?Q?yUmhCS74GmBJzVwS1KwB5U/0xaVs4qTWkHQBqgmrpaw1NHDxXBZ9/hpiYCgM?=
 =?us-ascii?Q?/YhNbcYbDnXQACI6oefit65beaxOncqaneOcgeOtHYM63eSxNb02l+x0UBwk?=
 =?us-ascii?Q?ZuJT2vjprUbMTD8F0ciHmv1jzCcmM7H9Td+6phjV5fIuFLj4Rw7ow8tHgMJf?=
 =?us-ascii?Q?U+fsiF/xxksVkleyde3SnMzrl4jIiQzH/Fjvv/AoLe8LDWU8M/a2MNG4WXTW?=
 =?us-ascii?Q?WT0tnmTU7g6l+LMvFHjzHV/U4zLaUMyxEQ/5aZK6DZXulgW+Njz74A7jh0Mn?=
 =?us-ascii?Q?fijJf/Vik73+atj/dAk0/1+XpzW1HL4IPbMvWswksaF/l8KhdsodMJ0KXEZ+?=
 =?us-ascii?Q?oda9NNuAil8SZC1/gtUlDrkTnzL/qPYZzQPDlt0RsG0LxGFy2d3txEXStx2i?=
 =?us-ascii?Q?+ftMf/MfU61XfR13EW5Wu4WTSvF5JAeuVfPmQ/dJnxXY93ObRpMjM4yscnmm?=
 =?us-ascii?Q?FJuJ7Mnv2lzRLk9fkRkDPLG9hbuhPGBkfob7ZB2NEeREWRYeeW/lnHQsVqiw?=
 =?us-ascii?Q?Y5klaO3YvNzYp/nEv67cBnHEwKRYkVYHcUWce3W0Gr2tk+meInYYt7acdNfZ?=
 =?us-ascii?Q?ZW03A2v55PApfUOolKJ/7eNU93RRjSrkUZLJ/dQjJEaoYeAluOyfJSIuOtUj?=
 =?us-ascii?Q?1UQFXodRLXiYCquT2PbKHGCvKhpAE670MJx2msuGbNb0IVfSVTTpFB52zvH8?=
 =?us-ascii?Q?4OjYTippojqPBNvfKHj2SZFPUagDnNljzwY0wEOzFqZm1/LrPd0q4vXzAqsj?=
 =?us-ascii?Q?3hJTSQTnjDGQuPD9Jngn06gpYYeAGKnZ1iBpMI2Byk0qJYwAEZMkOmLvnJ+j?=
 =?us-ascii?Q?V1LuRWaZx2d5XZOh0XmHfdp2A6pUnJpOsPPAZvVOiwFbXk8Ssyf+ifURj8hD?=
 =?us-ascii?Q?JSIN4uCh2yDFp/u04p4xb3s1wom5NU7Ka4RwFNFp8AdHg2pLFZTBK/ZJ/C80?=
 =?us-ascii?Q?8ODhEgUGpa6trz9DrRzNULTuDK8CQ0VP2fhwym1/LqWskNkCt+jnDPBtQTel?=
 =?us-ascii?Q?eG+BAwqNRBeOEkBSTuwrLQQTO8RRzAS9Z6EX7IcLpnzalcFIhjoJZPl0P+K1?=
 =?us-ascii?Q?cJ6JhOxvo5U80xoMgoKHyqtA55QBAgVweWTBCinZkHHbRynGbKpjt0pH0yqh?=
 =?us-ascii?Q?rkKwr/mjCql9wmTesvECTlURQg0Gb49Qu1pvHmld8+ElcO5KVihiWC89SNQr?=
 =?us-ascii?Q?ozQtYJJf/LOc7IpN6mJhddBB3yjoH0M5tqHG7PvkR8hp6qr7Gh1A/z+KTk/k?=
 =?us-ascii?Q?fda0K6+WdXS5CZAQ7BDLC4S4Z2ZynzDvJ9nXuHY+m/0TbbWqT9y466QiIYlP?=
 =?us-ascii?Q?tbuLMM2DV3Pf09UDoDwTN6vbPnpEDMpFt5jUNjkySaT6U4ITkJ/jQX4gT/e4?=
 =?us-ascii?Q?PLpcIlEGL5fFCzpaKgg8wSdg/zuCu/gJWBZJcXoaSXM2aov7PV+pWuoIoZYX?=
 =?us-ascii?Q?vJlc3EXz7EVSKJuY278zbX+eAe4oRtmrEqY5rvVviqiu8tNowhXTA0S3sDcX?=
 =?us-ascii?Q?18jPTD5/Zf7zDdlff36lw3rAcUqD/rsMAtnIQsE1JD6Jbq9XnqZuU5c6DNUb?=
 =?us-ascii?Q?0uP7EvrvjP3hMnNNWYVkufezdKnQTldulG5SYaYwtiOJkXhiMoTM3UemPXZJ?=
 =?us-ascii?Q?2Fo3eJr0GO+fRkR1zSapuibneHdx8huWVXZt5oyi+QWQ+rtQUTH328AtZ0HL?=
 =?us-ascii?Q?YlF27s0SODxWVInPNOEcAQpq7un8rO4yFvDR8lUI0f4qUFWFZ5rv9dAMArhc?=
X-MS-Exchange-AntiSpam-MessageData-1: +Yuznc0KsJWy+ZTJDzkRXy97KcOX/XQfdW4=
X-Exchange-RoutingPolicyChecked:
	uRDOB0GXQWpSGgWRQgvT8uTL7UVxHoEM1ud3nn1tNAk60YKj5DZjmgY68JHh9LfqALHDkl8w4Kd+u+AI0qVrFnh1hNwjZtRivGe9E0oWpdbJZi8gX+tzeHK/RLvO2sPBMA7l8GDJNuBEZHnFVB+WbCPcFIS9Sqc/FAPatwdPAkG3GW2akfgq0fKMaPvqKuSsronoshW0dde1WZzYAXrHNSNJOkjJ1wlWiMhoywf62SUUMORZsfDl/e77hIzw/iiH1jG4ruGs03lfxNjyBv6RzQRMclNddbCCSawXhqKuGdKdVyNDxc97RCGPVdymsPYQpctyYge5h3T8I2Swz5QHVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4B+oFaVOylUSJQu3rqq1eBxpD1BEXK1e3nS9aR8TvU3ojvC+FWMDCnoV1kgAc6I5jxqlyuyzZxWI+Cjy6iyzAS3rC5ammsgf4G78HgfwIq3EH+wwPp7TzW2aXvCeA5x3DwAyGYfaGny7MtNk91U31Em9GGXdfqEIMAe4RZ0LUxWMUnwJ8xasWE444RnPVAOT0BgTueu7UWT5VmrKBWayG7L5gc7kWYa1T5DoXopG1KXVyEMLCMGRkx9PoAoYx+jJEZhoKbP/gTO3s9QjBVeosRN9Q5qE1PN2z6QPpGZVNN+/muMW/IerwWmA2NFf9CM5v1G9Xf+QvC6uQjAdE4gTF32Xh/5DJ2b9OdnOK1cd3JbjnQebmg6VTl7woF/DrQgn/ZyTbcap4BUwC5UmxIOTR2+kniC6Zx/rllyZ/pD3QMZV7pNWfwb3ANELU9rC2VfZBhv4f6PZOyKOYrAtQm3S1EffzBowQNdUnDOQj0KkU0d544XgK2CleJ3dJnp7f8cJLIJaMNtm/e/KnQZ+QKTAmqBVICUsnc3xfrXLNE2EalxmiFi5oN2uPge1vAK6Y8gzQL8YqYJ3/RpxCJ7QoxpKAyWlK1P+1Fq0xJt4xYKXp4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc57b06-eea0-4c65-2254-08df1fcb8b5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:58.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R05bSpTNAUsWd9M3C3WN94Tw8Ii05FGcOrx91ZlBKfdByR44s4BqDxZQRkpuJG9iGRea5LrO2yVwYHAUyWUx7i335NGTDDrKTVVaxOsgRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX48HEITViNHVH
 hWP5dwLBmyVKdveL/ORTSBEBr+hadgmdzjbNoPhUCL6aGv7d4m36N4Fy1zMAdJdoS5+PPCfhg+u
 JVTnLGl4sg38y8cYZ5+7xBQBUrZF9WCkAGagJzJMqNigajRujs/z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX5F3AX3uitsha
 OmbBMAwakqndL/pyVE4aIyY65wONxqF2Mzep55fl5LYaSLrnYcCy2zQqjETmk6xk+jQjclZCf6l
 OK/zhhiIq5l4Dw7H37aCF2f/gUMMJnYDTu1eM0gzuspGBYQ/eF0GOHID7dfcVZHZNCuLZ9CnXR7
 G/9zENN1FZiHA125F8AWKI/VG1novSqPHdnEYuXSZ7uOMN6QGKM2LYeB2Widl/kSHdLcPN8MLOb
 x3eyRBPHJE7x2PpGWbJu/OiGTwDp2eMoXi+2kh0A7cZ7RZJEmxVy+/1HNhV+GMTuXlVLvY/MgLT
 D2qPwEOINfhobKTf5PDSiPHPI0hvrRKmNzD0bgHVyK92mxKFRZgnZW3+aX6+GmSY9FehsV/nRQe
 H8SD1udtiH3WAfL3dSvShFM6DEFvx7eYVR+XOo+VJ5MUit+w7VUI/KO0piu1HTGQWy5Ga/uq095
 OJl18y7BMMSkrbc2KPw==
X-Proofpoint-ORIG-GUID: wxAOEHQmpm7DVg4FSxDMpPIBbKssYlK4
X-Proofpoint-GUID: wxAOEHQmpm7DVg4FSxDMpPIBbKssYlK4
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe739c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9 a=WmVTiCyuxqgg3mnwYu6p:22

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
index 1ab395516960..37a783d11592 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -898,7 +898,15 @@ xfs_reclaim_inode(
 
 	if (xfs_is_shutdown(ip->i_mount)) {
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
index 13a113ed666f..3f2cc6204153 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2492,7 +2492,7 @@ xfs_ifree_mark_inode_stale(
 	iip = ip->i_itemp;
 	if (__xfs_iflags_test(ip, XFS_IFLUSHING)) {
 		ASSERT(!list_empty(&iip->ili_item.li_bio_list));
-		ASSERT(iip->ili_last_fields);
+		ASSERT(iip->ili_last_fields || xlog_is_shutdown(mp->m_log));
 		goto out_iunlock;
 	}
 
-- 
2.53.0

