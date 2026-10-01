Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F45226A5;
	Thu,  1 Oct 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866335; cv=fail; b=cH1HmDRXaYN6Ojh32//Ju7lVj1W0zEPyar8vHH3fTGxCQOcmv7kGNorgguZsq58qyDI1bgXG5wlxIOcEM8fQ99DHtDZK8P+UultPX7LljsgEz9Tg46+xShVLdnfLLJWAUqiFdZt9dyDqH38hA7Wq9v8RzhzSu81va3hfDN07wQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866335; c=relaxed/simple;
	bh=z8aHxSDwEttOXWdAdjD3gOnEhrAj36zTNfGkn60B3qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lk7nWZgh0Lgzu4CVNUduSloNgoubXqDyTTr/Dc7xsv8Y9Ae3iedKiz4jRB1cmWa3keoCekRaR5/TG+UwDCJvIPUZmPY0s1pplsBxtQnne2Aff7dbhhzp61rDzAcDLgQZFFMziXHuTuGgwvRflxQSPfN47V/JWAF0GP2ruwykJyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lplwBYpZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eVhI8T7L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lplwBYpZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eVhI8T7L"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMZT12256852;
	Thu, 1 Oct 2026 14:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=A8jiv1xOvTlKjZs3CWsewBp8jIWBfcptJshjU8eO40I=; b=
	lplwBYpZ+7ERNsaH2bKMlMjp5ZLWdk4AmERe2ilnGEDgidAM9Mbijaeq0TH0b1SE
	itEl1ekxqrgzJFwpRxGT/pntGwZDqscWzPWNwLuYnOy5TIac5zPXP/Dhpba+c6v0
	98BDYQZMWw2aS4LKcwDc63CMW01KvIuzL9WfBqIHl72X3lgQa8kBZ7m8+fcPKuos
	P/fDrlmKHpN32580ho38kRlMjqiA2R26C9uuD0H60l9iUCcVFS39DzIJ4+OfNHh3
	WO+4+5P/2ITyUlnKju+KQR+MObrH/GLYF8q4+ZZmBK7H4XZjxXh7W6UBGuu0+kyj
	WB4wSRQyrcPXjWriQ4FfRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnnMq011490;
	Thu, 1 Oct 2026 14:52:07 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gepjpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUW0lC0USd9iTZEte29OUUuP8gzng3Fqlyug2c7t1NNw1tlfHeeQPTd+3eRCAdC/TnwEXjELADqf/dCFEUCep729238AyNyqIxo/YSde3JHlR/0N3pK9nRLskfWUZe2EdCokrB7Pv0CnX8WDoCamYJQBqd1146y8eK3KhUYfBkYQ6KfLNhymI78t0aNKwYjl/jJ2XcZ0IN8HIY5aPEA+iby/wLLikdGk7vI0Mfj9DgvJ2XstyWBZDXDu9vibInNxLwYlOLdsZHwj1mg9bkbrqSg4hITB1apojp5hREhlvUrJ+2M4Yctc9Lm05bk2ohUKa2mbqz5YgMptoZSDMRQlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8jiv1xOvTlKjZs3CWsewBp8jIWBfcptJshjU8eO40I=;
 b=cniOFOW/0GQpelM14c9Vuv9+3r0WyRh0Rr3GBTXUV98IaXHT7O22PTEi8mKPInnqxLYCOWsjSjijOocRQSLy5TI2767RqXcEM/rv6AkThGJElgwvaI/BGB/qg6pzecLolsRiCtsmqGoGwAWXyLPPs6SeRJSlg6hMWt/5pMqqGOtxPHh+3ZmPWOQTi+n512fJeywZS5Io+aKnwDeiKUAS5CvsolyyUwWc536QcZsoACmBMVD4ZvNOO6lwIXhtlh+7uVQuSHHVe2A2wDO0jEwRMZY51HSMSt1DufkXIYuhxbsKMDq0hvBNzbKh+36Zd6CWrN2/A2oGPB3qo3B8ZUmu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8jiv1xOvTlKjZs3CWsewBp8jIWBfcptJshjU8eO40I=;
 b=eVhI8T7Lh4PWw1SwhOf6KDYkEf+xttFpTfxwc3HsEYfDyOj/oSTHyRNrtUg5/uVni3BArvcRBrgTUfX6AM+JnFKlhDGZ19LEBIFLPhTz1UArrZzSdKDASJNRiymEBKzqGzXec8r07q4SGxanDSuG4JlDusV/zZjsLnAFrw5J+AM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:52:05 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:05 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 03/21] xfs: hoist recovered rmap intent checks out of xfs_rui_item_recover
Date: Thu,  1 Oct 2026 20:21:16 +0530
Message-ID: <10a13160aa09457acebca9676e7b08a142fe1f4d.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 05440384-c62c-4c05-f6af-08df1fcb8b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YQXp/lWlIIAkveM57neb2baUY5c3+qk9WQ3Z/1MpgEDjGETfyKDAEiTJMAtri44x5fzEkUGbIWGZyalxycdTFsz7+4aaZ5s0pCtolYKVpsp/VIA3wkcnJvHuyaf6deeDUAh2RWrOmu26aFoNJHi5oZ7ZjUypdEcb6G9l2kEdnjoaZHerL0QKiIpGjFicfjBqxAvhKJk78BCArQ86d5z6Sd5KJCexam8dwZmA4KRXrV5ZPxDZziGQrm2z+Ua1mzWKDjAUIOmoB0N2+QuZBrsJXUA1Dlrj4yvgFeYS5y9qtAG7iwPkRGrf50QivFmbHqkL/44dBHIJiirGaMUbPtdNxHPnB/o7BzySfiSJLtbTizUSo6D5gVujUlXSOiOgpZhYzofA7KBHeuVF5eTPVl3qnGPkYAamN3gyFC3KQ1Gj+2v6oKf6MntJYKZ6jvaQJ5s8+OrE+shhU7ebI7tAx/JnPQs6LFCOxM64i5ilXhWwh4ieA1KCm+QeHAFCK7r4UOXx55J3gq6KykG2Xpttp7GYj8ztcsCc2NBhU6FvV+E+Anclxzr4mZwDMjsIlFZvN6bDkobXZz3MchB9TOTBRG/CYNf+FP+wXjPfMogYERP4FkuX+a2lAJj8S03RKAWMxQEy9rf6YOc9NkixtAiaA/x5vQcxpbfVRyDxse7e8IQZcfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3sAMr2oDDQgWfAL3j8wVD9BRSbN/yllRKp+vr2P4B3ALh8thGBlwW/1ifhL7?=
 =?us-ascii?Q?w9rTl6kV0zjcB9SFJ4A8+yvNyQgVCgmk7gUFL3SG6DqlfNMMub5VHzwthj2+?=
 =?us-ascii?Q?iIYp3c3NSF2jSpPO44RkLILx5nu+d1lXgwxzYzSBGwNyjoGhjiE9J25Ct+py?=
 =?us-ascii?Q?G0VIRP+KdB9IXZPHguJj28ZbL/QtQxWsrTc3/ODjKdNEpGzf80e/0pOEw0PT?=
 =?us-ascii?Q?rL8wLT26h3Zu0Af2IFhm425HSB/kLDN7MvnbNi7ehf1X93TtVwRapcncYM9t?=
 =?us-ascii?Q?BHavgSv2+2r9/uMQ4eUkSNXDsteGn1fRnWBDrEYqEvaXXRHKRiPV1rNL88pI?=
 =?us-ascii?Q?n2sZn64QOnntzSjIOswZY08biQzRW7C9imioGdcUiwFMnbq04vfp7rFyM9Jh?=
 =?us-ascii?Q?GLhtbiLk2wVhUz8YHypEMaTVjqhTELTm8sL1Y+Diy0tVlQTk2x3XY6sp16Gv?=
 =?us-ascii?Q?6+pNq1lMZ+yF4aUKIcVXLCKwJAGjpfqUafJ7vy+GdFIQJTSwu2ouoZevY/XU?=
 =?us-ascii?Q?7XuK2H7aLFn82bguWvC6wbT+6VwScr+Wcl/5ErMFvQQn3HaHFel07iTdaKgl?=
 =?us-ascii?Q?Ak89OMYOXgTAgsFAEqWhD4j5eFfuJZmAcMrSgusOBeUG7HM57P+NVqwJ7Cre?=
 =?us-ascii?Q?uVrS8wYZC2pw6QO01PsoO4d/ZoiFSd5qXgMCdYJcy0KvIRoiDZvVtJx9Ww86?=
 =?us-ascii?Q?7thRCNRezwmRn/ole5BZy4HA0dpIj6UwEaTvLdSBsprMQDSAQmu2H5W02/K4?=
 =?us-ascii?Q?Ogya7QxdXJlopvtDNdMnycLD3Mz2jfBuFdK3ylRryXLSybwnhwHyB1k+h5/0?=
 =?us-ascii?Q?jMztB/7sxT31a85+N7ctVYGtciwXLyN6aFE8v7SGBaja24TRXLYwRB4Ya1kn?=
 =?us-ascii?Q?nlMwc/nkFyFPLgSOjxOH0Y1I2oWY/jvGQVZPVEaF3J78enX01kAetImgt3xr?=
 =?us-ascii?Q?7pfNZanav+CNu1NfJbKRhhxNMhOSARXP5AYeKFAKWgn8zYvPjWIi3C04NHn7?=
 =?us-ascii?Q?WQnOEtkAVt/OKDFNcuyWLNqBxs11BWzxaPVfjQRbbSIhc4Z+L4CgC7QGUxWn?=
 =?us-ascii?Q?FGyvEuEQ5rSf/O2aSDA5BiAKht4i09+qI1RHLlwYLNCkNOV9vz64SRrQfZ2S?=
 =?us-ascii?Q?1dWi/2Hp5IrRGQ4Lkt05RljnbsA7pv12mfn59zJi67uVKHz19pXt7YXiLQX2?=
 =?us-ascii?Q?sdqndjBFQcBbioEvt+soajbkGzCLFCTq7tk1mBJbMaf5/+Zi3GL43FG8cC4V?=
 =?us-ascii?Q?A4NMmI15O3cxpEyXTWvUPlYWDEVZvmXeS4KkH+TIG2M8lvFQMQEyh9TDsBqv?=
 =?us-ascii?Q?HvgckPPjIq5eK9LEZZReunK2rtv/iXjw3tozI0jamjUAonj30FjF7i7NAspn?=
 =?us-ascii?Q?2SXNljMnHr8n8anJ1CvBGAOwv6R1IssUmU3SfldilCKa8zLDFsQXvuhNaozj?=
 =?us-ascii?Q?+/+5zqRp8MU5kA3tj9AIzJtgY6pmIhSwtYU6DZQYsSnMiMQmFrjSL8yVMhda?=
 =?us-ascii?Q?/b2mfbdpx+HTmpJTvw2drSZBnIJ4wOEZm3Z3uCOqKZr5Yl9dNZbLPANa7hh1?=
 =?us-ascii?Q?9ghFgOhINs2WpUtu6o6wEQ3OvxA600Z6pvyd6Ml029MbGToZFafGFcfO6GGi?=
 =?us-ascii?Q?XneUGTMrbe/M0xu82VrPlZbWil9UUxpTBgW6GK/zguBTiFF5GQNA2Bn0BGrF?=
 =?us-ascii?Q?Br1qBzyubcS+r6/fEL7KwCzVZybP+Qr5WbnNzeYy+NCT0nsFjNwDb2hABXSe?=
 =?us-ascii?Q?lgp9z9j79jNg95MktgEHx/trEtyran+zltR0lg70jUXLjCnnJ8hH5uztzFmU?=
X-MS-Exchange-AntiSpam-MessageData-1: uOTiUTjvu91i190/x7II/oKLO9cTXVAagt0=
X-Exchange-RoutingPolicyChecked:
	4ro0dwIQrKJO0Y4BuQDpeN48wZ78iKmUBqaUMNqRg7IYR3zavuUsefUGWnq2Z38XQf5+jQuMTqKYPzlkMgWoE8PUwvKiVQ6sPYGHTbQssAmtciYX2sed7c2yFW8JPsRzNzsR70ycRZC818eFmTei0MaE6DIXI8hZI1OaCJ/JnvUbvXvq/3aKc3GFkU8mRRz/P9tCAtpQ9KVIzsQ0xWiO+xSDwV41Y8kXGmYEQ60ODNT1efnNLb0LQzx5DzG7tI8q6fA8u7jZ5wcVXyqa5tCLF8HX5kO6EwSyrdoG19WRPFO/EHOxb3CmE6GMGRxnuirPhbZnDP47mZsryYWFjr4FPg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J6Ekg/tynTN5r75APdwTfUmA4KoIsOVA2eI15R96wvSJClBpYcpSIl7zePAhexrvruCSfy/yURsqf32EO+OkhuiT2YCnxknNb64tWCeVjEjbZkSNHWWh1K4KKH6QHzqHb2BvVbQ5JuPgp2WksB9XFpZEogbLkzu1dKlT6lCKOSmv8X/ZvyWyE8L9sIdql0P77U6nVDYdolTIof/srydV88JmtJJClb4R296IEDW7HHM4syWdg6snadIOiicL82F3UZnAJBeVJ2tzgu3tuVh/WFG+BApzrLibHVOo08rXWKNb8Rbuyxb1tXax2D+lNulZUNG9KNJVK/ydNXpurYLYky+wr+gO1QMbfM9DI+0wTa+cfhNzot8b/agvVCMOBcel9YVTtHvy4Oh+erx+Q8IlUAMDbHGBbVlM27cgBHnbaezaanSEM2aoQUVwg07GDa99kn60v1KfeowbypHi8DOVOZ94sV24NTA7/gY8lgZwq+ne2TdrUi6j7adezzdoRC6wvFdIWkoww5zSuYiee5hP9DaVhVrhl5rIVV+ppsnwKUdd6WWcV4pEZr6YOwJ4Fra+ycktVFX/4xLHNnHhU44cp8CTA2IpRdd4V54rj2/4EiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05440384-c62c-4c05-f6af-08df1fcb8b18
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:58.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h08M20HivhU5yrf2bEomUZ2deWAe/fgsVy//RRsCGu/GvUlQE6S0vMPBck0UrfTUQvmL7QkE+BeOiS9ub7BgiBa4wBmITQ51WJ+/RqUYvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3g4hEjJzB8xv
 KKGp5jI/Db36eCFNYbYecxFifgzQb6WbsZJbYNp1VTWW+M4Gwt+L09PBBrBn56TlKnG3SE3PkF4
 ftyw9uWkaHzgJkSl0PO6DVsw0piTgFj2yZBVPNWKAv+oIMHIXxqg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3Vaitqr70GwE
 DfcgKwqnlDlAvIHQLOh/HaOZ9Y86S5GhZhk7JH1/RH0muV9TH9cKlb9qcWrpf/O1a+mXLGZ/MC2
 MdHlvvxAz3ciWiUKyXePUu1Ig5liiG07BySccZPkefV9aSEL1CpBRreiW4GUYKBzDFp6I68yNu4
 Rd7QUZxABM8hwGKEvsivI0sekNUrWK6SCb6y4mDa0/Ow7e/4LJBEAav9LHF1GnRByxMWdwN/wku
 IzIqCuHNToNV+2vyj1HQUphH9hsO+Tf5HFxeuB0yyaLymLHZJRUAY2p8llRXOCHEbFVq61iH1mP
 Rp8+Y2+oEaObEb7+PHws7r9sYrGBIkX7YQBjhZfY4RuSQNnhSIC/19RjDfGy4RqYgJxEq685sVC
 u7DbHp8NwUlt7A+bFz7nV26D5OdlbsypfCb9tUrqPvArr5ANRdh54QM2VZStb2Rpv/7ReO+cfyj
 IJNovsg2PFk1RtIIJoA==
X-Proofpoint-ORIG-GUID: Z_NSct6g3CMyjQYzGjbwB4IZCa9WVVef
X-Proofpoint-GUID: Z_NSct6g3CMyjQYzGjbwB4IZCa9WVVef
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe7398 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=XUHDQfcMxKEf4e_NL1gA:9

From: "Darrick J. Wong" <darrick.wong@oracle.com>

When we recover a rmap intent from the log, we need to validate its
contents before we try to replay them.  Hoist the checking code into a
separate function in preparation to refactor this code to use validation
helpers.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
(cherry picked from commit dda7ba65bf03b6f3a7502b9f85c2524a5ae5aa2e)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_rmap_item.c | 67 ++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 20905953fe76..31cfd734962f 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -460,6 +460,42 @@ const struct xfs_defer_op_type xfs_rmap_update_defer_type = {
 	.cancel_item	= xfs_rmap_update_cancel_item,
 };
 
+/* Is this recovered RUI ok? */
+static inline bool
+xfs_rui_validate_map(
+	struct xfs_mount		*mp,
+	struct xfs_map_extent		*rmap)
+{
+	xfs_fsblock_t			startblock_fsb;
+	bool				op_ok;
+
+	startblock_fsb = XFS_BB_TO_FSB(mp,
+			   XFS_FSB_TO_DADDR(mp, rmap->me_startblock));
+	switch (rmap->me_flags & XFS_RMAP_EXTENT_TYPE_MASK) {
+	case XFS_RMAP_EXTENT_MAP:
+	case XFS_RMAP_EXTENT_MAP_SHARED:
+	case XFS_RMAP_EXTENT_UNMAP:
+	case XFS_RMAP_EXTENT_UNMAP_SHARED:
+	case XFS_RMAP_EXTENT_CONVERT:
+	case XFS_RMAP_EXTENT_CONVERT_SHARED:
+	case XFS_RMAP_EXTENT_ALLOC:
+	case XFS_RMAP_EXTENT_FREE:
+		op_ok = true;
+		break;
+	default:
+		op_ok = false;
+		break;
+	}
+	if (!op_ok || startblock_fsb == 0 ||
+	    rmap->me_len == 0 ||
+	    startblock_fsb >= mp->m_sb.sb_dblocks ||
+	    rmap->me_len >= mp->m_sb.sb_agblocks ||
+	    (rmap->me_flags & ~XFS_RMAP_EXTENT_FLAGS))
+		return false;
+
+	return true;
+}
+
 /*
  * Process an rmap update intent item that was recovered from the log.
  * We need to update the rmapbt.
@@ -475,10 +511,8 @@ xfs_rui_item_recover(
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_mountp;
-	xfs_fsblock_t			startblock_fsb;
 	enum xfs_rmap_intent_type	type;
 	xfs_exntst_t			state;
-	bool				op_ok;
 	int				i;
 	int				whichfork;
 	int				error = 0;
@@ -489,30 +523,13 @@ xfs_rui_item_recover(
 	 * just toss the RUI.
 	 */
 	for (i = 0; i < ruip->rui_format.rui_nextents; i++) {
-		rmap = &ruip->rui_format.rui_extents[i];
-		startblock_fsb = XFS_BB_TO_FSB(mp,
-				   XFS_FSB_TO_DADDR(mp, rmap->me_startblock));
-		switch (rmap->me_flags & XFS_RMAP_EXTENT_TYPE_MASK) {
-		case XFS_RMAP_EXTENT_MAP:
-		case XFS_RMAP_EXTENT_MAP_SHARED:
-		case XFS_RMAP_EXTENT_UNMAP:
-		case XFS_RMAP_EXTENT_UNMAP_SHARED:
-		case XFS_RMAP_EXTENT_CONVERT:
-		case XFS_RMAP_EXTENT_CONVERT_SHARED:
-		case XFS_RMAP_EXTENT_ALLOC:
-		case XFS_RMAP_EXTENT_FREE:
-			op_ok = true;
-			break;
-		default:
-			op_ok = false;
-			break;
-		}
-		if (!op_ok || startblock_fsb == 0 ||
-		    rmap->me_len == 0 ||
-		    startblock_fsb >= mp->m_sb.sb_dblocks ||
-		    rmap->me_len >= mp->m_sb.sb_agblocks ||
-		    (rmap->me_flags & ~XFS_RMAP_EXTENT_FLAGS))
+		if (!xfs_rui_validate_map(mp,
+					&ruip->rui_format.rui_extents[i])) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					&ruip->rui_format,
+					sizeof(ruip->rui_format));
 			return -EFSCORRUPTED;
+		}
 	}
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
-- 
2.53.0

