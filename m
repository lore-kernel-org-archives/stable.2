Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE1526A90;
	Thu,  1 Oct 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866315; cv=fail; b=p7kdfEWM47wfIlF/KRGiHCIXKi0vr12HqaA6OY2+Qr65ryb0ZWBxpcdFu7+eeM+LZR1yGr4CecqOkya/kMrSTkH4G6F/ZQm+8A7qHkjtnPCdRf+5lUWrCT8lPyxfAG2Eg4k/tLsJhu4WecIXCcMb3+KqneL/Sl+Ufe1gtsm058E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866315; c=relaxed/simple;
	bh=DIaCO8pDH1t1mCpKWoWzYFl3/Cr6ehKGYJLOV4pmrVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WINGMhH94NYupLRcD5JqpagXRgerihbLgnGS/OLTdN4iGEL3p3IEULBM6hHa3YyyC+456dLx/YoUskrycJppqQcvFW1pvMmqBvtLHnfo/gmTM8xx4fW68VXmftvGWGBDT3aiZvv3s6vXyyhIIHIRNMf+MsmJwwN7QKTZWm7ZMks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DAGo6n6m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XLPCWKUE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DAGo6n6m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XLPCWKUE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMgrV539355;
	Thu, 1 Oct 2026 14:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vu+jL9Le6Hqz2uyn0IN7wqWDEuwddl1A6y0rDIhKmuk=; b=
	DAGo6n6mMqFd1h2QMDWXpmyUs4orpHAEjFFO3D7XiU/ST4DKsiGuIo3R1uO4Z/j4
	iaMQSw17tjAP2YdhME9h7bIPKwap5XKkayx0RblVoQbTvsrjq52gAIni1ya9UIuk
	2h//PctXMByV2DZo0WoNnas6RAzIKa1wUrDfOt9NpfauUyXFDELQDbYnWtnb2XnE
	5ypapEPm3WXY73qPHO8Xx5SRCOMNTti1EetqgnEEeRLXStOCXn/gpIC3sxamPMEj
	5wm3YTs36Y/drwar9qEwVSMaxLOFOPEMU4X5gXW0H/mGTwnUcaa/MYcyXh+jhmaE
	tZBOq1DSPRn5CTv4w5z5pA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgykc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnqAZ017329;
	Thu, 1 Oct 2026 14:51:43 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gexyra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBWzYVUlf3fKMUcJQUItHgIloS46WXpXv6JJHKdochKaYapMRcW+uqwn2jCn4snxU3a4qRM6XCs1cf8jPHcBjZUrbkcoeWi8xfv3yYQOmLWVILQ8VeeNFC+tf3VSpBSjkNKBGiMu5wJ3nC8fO0HwEnVMUpRz4HECtFzh6yNzh9tkQDGPYfAAq4lSXcjfIzCxI1zHf6ZrvmDXLu5T19sTWukQ/MaqnIZnSY3ndIPRZtHfAnxw6ExWqFUfP0a1688XeTunUgK/ore21YdiF59gb/kUi0El8wHebcKHEhDIZh7S6GTsJ+iNmwAo4WAwJbZpq74BFW1Pw/+ua2g8JUxh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu+jL9Le6Hqz2uyn0IN7wqWDEuwddl1A6y0rDIhKmuk=;
 b=GSa8u3oGcnsAwigTTljw58oOnJPJY5dAMZzYzcRCovbAlnj6Hzhih5+1C2La07L7BBirBN2mM5/BZPyGZS66OCTazsGiPWxShgStv3y14btFRWXh4cwylHy3sUZLq9eBBDwEq+1Tu3nsRiJComfMA76fBUE7JieB1mTZNsxLzRhhvvvr2WR60e3AbpPn/Y5IWEjOOah4SUs+axpKqASUztxWBQb7j0fDXNL1ZuWypAzzMaFWBNRuA4bw0agNBet2wck/9J0nRI5ZPBEIVKUQGFVKOTI1qWdw/SLJxEoHJSuSpZP1ADerHM/ryyD7nJv98KZ/Jiwv7u5RLlBRumXx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu+jL9Le6Hqz2uyn0IN7wqWDEuwddl1A6y0rDIhKmuk=;
 b=XLPCWKUEim9DLGozwKreFVUtDZ3NgIEnQrOAfV76sh6Coc7WAdPCLY+etDQdolP6NqrPflh3rrnqiG1+LqpdGWgjVTQqEPEypn/Glln+enZjZg38dkbrZEQOWNUS9KwEOCcrmsCEECsafNPVtswPB1KhQrpVwIYV6Q3UHZCn/Z8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CYXPR10MB7922.namprd10.prod.outlook.com (2603:10b6:930:de::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.9; Thu, 1 Oct 2026 14:51:38 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:37 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 01/11] xfs: log items should have a xlog pointer, not a mount
Date: Thu,  1 Oct 2026 20:21:16 +0530
Message-ID: <0324c0f546183036a85e77d96860aed8166d40fa.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CYXPR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d444df3-4384-40ea-6e49-08df1fcb7db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nXNjA3XG4GSvlH1REOSolXxgdJJjPYKBlyg7sjLcKKM3j9VkJMLA6GX2RxpEDrSmEkXHYNZzeKcyPg/eiEIyvk+uDZZ531qMDcyo3+QctQ/HjOqPEOnvGh9BG7Klvby6750yRlWz7l1XnYQ+Hx5kfVoTP7e3iNvdY8ScJzuCTmPbJGNDZBQopf9SyuwAskhM4tYhVbX8xvQFygWF2jLNt4yrr/tNjWqCCoxYcid1EzrYhxQDfMx7m+WNCAlGYFCPncuBUBwzEIlVQZddW+VW98B3CdYDM3xQyEQmEhXG/C7ZxMhrfk58sd6BbPnH1y1B0QYe9ZV163OkHMAVp29HWbCmFYtrMXzENh95IYPCn1WDy4q2MDfx2YFi2uVQ1pCzEQgXEHyF2U6MHBsnqmGTa7gZGhGwGe09Kv/l8qGciCyX1N+VOHtlw/UenDYZO2VYVnJigIBPmN4ga83r6Eq3KFmjfRVKnJanwoT5cb7KuM9CSGxLlS+i4tXgY47MPVOCaRq4l8LM7AQHimHjG1/v4QHWAwKGgBSfnQHBoGKe6lpQI98k3P5QnahiddT9ajjyg+b1Gkq6GHMuyVzVPwkhaEiPoxHka+Lt1l0fwKsL07z9YD+EwH0TJb5xUPn+cp4JpNw5O+UpxZ/K1wKmJFFj71PxOygcCYRgQD2C7rnK1cg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D2nB5jg0/C26AZfMXVFEvoRAR+8rNzND2vKdK80eJ1tA14/qXTxqeG33nb8B?=
 =?us-ascii?Q?ErvjV8qOg02tWrzdZCwXLNgNGNudn28wfIyp8Sv7cHEmGrSw7YpTFynkKLn4?=
 =?us-ascii?Q?yrodREtOs5L3mvMDt0qi1bcp8UpCAZ/9VeDEWlnlu4HO6VsOQ6vZDJoGL5ZN?=
 =?us-ascii?Q?MgAlLSRz+DBSgBn+pANKNaXwUJFqLiGahnxB22UP2cA6ks/PXdJdQCLGiIPl?=
 =?us-ascii?Q?OjiOwduHs/x1dlo+AxcK0pjJKASK4kLFtBT+ViVSEptAPr26AsMtzzMYjJ46?=
 =?us-ascii?Q?z0FEOOeSJcF/OwSUqNK2B7N1xkheQKQWVjOob3b3pMZed1XjQSPplh6aw7DB?=
 =?us-ascii?Q?QlpyOqT8hAQKzRKgXGigbpbpQO6+mZixC53j8VUr58jzxfclI1bONk8X1n3R?=
 =?us-ascii?Q?R6OiW2kaCjFAZBuENkrpLY5uX9k8+UCTJZ9ii6UcvxZwKxw9roKH/5HrFHQ2?=
 =?us-ascii?Q?/9inHINVScuTJSmq3E8dLiS+RnHcm02o1M7Bdbe0qP/Q1xcq0K2nRLJcI5KP?=
 =?us-ascii?Q?3YVhbazGtj1cVafkeSdbCEt86dO1Xd7eeoPzYqxHKe5HIu6n7VE1VYvNG+a6?=
 =?us-ascii?Q?aI6LloAHouVtMAi/DFvAqwA9tMNXpPBk+SRTTBejIxa6+fYFSwIPL8RIYVyw?=
 =?us-ascii?Q?AcpP+EWQC6NGSA5YlF8wnlaYK/COmLNmX7/W1ozsX2u5LK6jLtkAoxBU4Dvt?=
 =?us-ascii?Q?jo7uDRPQN7UGLIH0B1Lf+4jk5l5LnZeO5clXTFpItOkrUAyw6PVtKHsXS8ls?=
 =?us-ascii?Q?Z6UjeFbLYPFL58JkGKAcvrvq0rdfg7uv1VVzTeOVd6mIM3jiQJATaa8fQy/L?=
 =?us-ascii?Q?WNe0Wpt7hVjJYp3m94+bdXth4Zg8AcHrIXKwvb8n/8MtI9F+No26fWHOhV/x?=
 =?us-ascii?Q?l6PL4/WiwTDSW38JdOosVLqEovS4BQJZLMFY7hTOZksJzJucgG9KexwPZXyf?=
 =?us-ascii?Q?NuOjs8CWBWv7XkmlWH5kaI2aVJ9A1o5anCRDibSBtqgLd+5pt0NDny1qF1Z5?=
 =?us-ascii?Q?Wnm13e4xFFPW19EtosT0RjOk2gDv7fz2NUQg142awtmgTXPPRlZeTXok3OLs?=
 =?us-ascii?Q?O7HpMEldBtB8WPxDXToSAEbtu0Eo5nWjpZXk0pQ/rllSCkVAoNrYidOCW8Lx?=
 =?us-ascii?Q?T08w6B4itsv+n5tiZYs89iPvYCykauSn4qaoNaCzVCOgLp49/BVnVr7gVeQj?=
 =?us-ascii?Q?Vv+yoamOXYauRUmbIrQi7iNwlPs2JBY0hVg57bve1VhXxWPH7pyCWPg7IwlJ?=
 =?us-ascii?Q?35pwMP9ZHUnNdE8h0oDlsD3rZAd4a85aF7PtGzeESxHPENtwo5j5SW61n7j4?=
 =?us-ascii?Q?++syUaFejXyZc44X73nL+Phv6wTShkwaCx/znpvoCdF0i9zToVGeyELDQhxr?=
 =?us-ascii?Q?18SOWOIzdPO75/+c5nzPuIgYTf8XnnRcbI7034ASndBu9qpP1qzfKOVtQQkF?=
 =?us-ascii?Q?ON1wEyHpClPC4arhExCGKBjxqUxmuc5p1+KOdiVtEYC8ALpGlMjwHR99yDQf?=
 =?us-ascii?Q?kVuHGIbQy2sCJejjsOj20EFFfremB6MXYeLq5c4YLGbRe6jGq4xy0Bk3Cjhs?=
 =?us-ascii?Q?6vzbzsfX2TzR/b596ykAeEx3Pl7GUoBVCO8JvHmOFGKv1fcCsV4ZugKuJrQI?=
 =?us-ascii?Q?MPNzoTZrUnfWqlGWautLliSgX3ORMVS9kT/5whTC2Aprshv2H8WJ6ccedP5R?=
 =?us-ascii?Q?8k7G+qoZ1NcGg9dhcHM24EVwUqLeepOMRWTABVMWbA9upqWQ6Ub/Hd0LZsAR?=
 =?us-ascii?Q?43SCDnFMnVRWBrcDqhc9ZZlXx99P2mCu3WNaM/Qq6SFdUaU7xQvtP4a1XYfE?=
X-MS-Exchange-AntiSpam-MessageData-1: asj57hJaH9yEGgm83bgYpsLFYh18DzMtHPE=
X-Exchange-RoutingPolicyChecked:
	eJ0Hg5q5pgBNxbGB+vMXMjm76pPCnj60X6910lCQx9jZTJhoDjeKBLhrD3/gKvQBZkfPGFr6oEsJ+4MsrBo7BUW9S7JDdBF3iC+a6shjtJ/U8IHVyN0vLXZxddEjwQQDtTzjD5FBkuqWVGnTD/lAJ4nejBWtrmMRZU9G6KgSLFEIIaJ12HUhltcJdRcfMjRxVa1UXBf39xGpXN+5btFlkFX4zIyig1Pli5AGtY3tIaREkjXRihG68hfx9ANldyeL+6gnwKn7oRQKSZ2Nd50fV3FdV+e9v/nuQfKRrZJo4ZlSfmwTILAFF/JrZ8Ma16O1qAEvuYF5M1tKJeuZbJa4RQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oy8sdu1iOHnZE/J7A5vxnpCPteS/M494SJE+C85YRy6WcTOCmvGHBLujJNlWhAkw9gvgfkaFsDIsey3GRwGDqWv1f9ncpb0kDbMRZngza8crFJbFaDqaIDoLZ7rG+39bHFaZa254bRy46/R5rGOrSopeHBdzY5bV/O8ngBrA8Pm/mbJw4if+CiHCu0OxYMN6blF06ZSgPdArUVKaSOdU0z04yXQSvBRxbeBb8KaO3MosH1/qC9RPazfs3j5mvtFldLwYK+pLVdHxG9uv60Ya1IfavjJPcY3WXJd9ZFySsigHdP9YYiVt7BwMHtFEzPUcpo1pvvPwevbQX0Y9yLxlG5J9ixblulSeMBjGn87tDq3oz5UU9RABzZVyGxOWHsRbSbKcMmkd3eomFwmJgl5daeNQGEWNIQKKSwZ5TNd2wZNbOaUVpCcdqgpHtredHebyE6WJ8lbhmamAl7Xrb0g74PGV7pDOpNo76rqza2PyB4qaFaswd2y9EfB8jQz+HqEyKNuUj69QaAOGYfewQlE7iSVFjFJTZKp8N1JDxOq+1Gxo2i8eClQ2c5cq/vB99xE4i1POfWqO5qrik95qFT2qNGg8B+COaOLHy152vRWDT18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d444df3-4384-40ea-6e49-08df1fcb7db2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:36.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSauQoAKMLIQuweMRCboBjxJ0zrlRZ1M3vZCzHj0fZ97+In4xa1wHk9p4isSoDdbR0p+AeZ1GPIBzrIIQ5zo4Lgf3lsAcCbK8dQHNzQemPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: vmzT4q_FeLFxbnkS1Hrf3BCdHKpOocKU
X-Proofpoint-GUID: vmzT4q_FeLFxbnkS1Hrf3BCdHKpOocKU
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe7380 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=eK9uUbcZqazOid2N2AkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXxsykfbEZl4dS
 YgDqGDmpmVVQ9wwCvgB5CXkBKMCoRciIAdvmYjZX+7XsHhQ3cyyR+iIWEoWERhsGqaeV93tsjQu
 +p4QHBhE+U8dV8Jc3T1Akpm6mE3WW7fPQgE2aXqISfPPri7wwke7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXyaVS2IZbXQWq
 A3KM+PYHMQLBJScOrRV7nGc70wRYV9xsBsQPpTk0xAs+TZ8HCZrh3Xt4rjixxWlJDZEyjZyRg+G
 FEJViPwrFNjv1/79SKRelL6gHZvfU9cgkEBNz3zZlxOtkv7hdcp7GQa2Iyr63oa5Qosy++hOQcH
 4G7m6sTo79/ou7o7EgeSDZvZ8c2GnIkFxcSZIle4ZEbarvzcPsn8robd4SPGXame7yV7lk6SLlD
 AHI8PwibduSm/bF24exOmlTVjQy/cbdrKsgPdTo+TWJ9wLxLCJpuhKAWeGPnKe720zJOzWEpuX/
 zdv2MJckIiOhU/AmIoW2aTjt+7Oi277v70Ti5mi8NAYaWo6NiecRpeQfAz1rM4SqNcCOriMCWSu
 ZfHfsXB8toVnRkPAMNXxEawJpbyAfsivYH7t9+SQqjUUVK+2PMvywLZey7JqEKowfph0Vzoc0XY
 RDr73hWoF50kbGcHZ7A==

From: Dave Chinner <dchinner@redhat.com>

Log items belong to the log, not the xfs_mount. Convert the mount
pointer in the log item to a xlog pointer in preparation for
upcoming log centric changes to the log items.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Chandan Babu R <chandan.babu@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
(cherry picked from commit d86142dd7c4e10e50bdb3679b405d748214b2c28)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_bmap_item.c     | 2 +-
 fs/xfs/xfs_buf_item.c      | 5 +++--
 fs/xfs/xfs_extfree_item.c  | 2 +-
 fs/xfs/xfs_log.c           | 2 +-
 fs/xfs/xfs_log_cil.c       | 2 +-
 fs/xfs/xfs_refcount_item.c | 2 +-
 fs/xfs/xfs_rmap_item.c     | 2 +-
 fs/xfs/xfs_trace.h         | 4 ++--
 fs/xfs/xfs_trans.c         | 2 +-
 fs/xfs/xfs_trans.h         | 3 ++-
 10 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 51ffdec5e4fa..631dbf945310 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -465,7 +465,7 @@ xfs_bui_item_recover(
 	struct xfs_bui_log_item		*buip = BUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_inode		*ip = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_map_extent		*bmap;
 	struct xfs_bud_log_item		*budp;
 	xfs_filblks_t			count;
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 9f8225ed234e..5eb6d787ed4e 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -21,6 +21,7 @@
 #include "xfs_dquot.h"
 #include "xfs_trace.h"
 #include "xfs_log.h"
+#include "xfs_log_priv.h"
 
 
 kmem_zone_t	*xfs_buf_item_zone;
@@ -428,7 +429,7 @@ xfs_buf_item_format(
 	 * occurs during recovery.
 	 */
 	if (bip->bli_flags & XFS_BLI_INODE_BUF) {
-		if (xfs_has_v3inodes(lip->li_mountp) ||
+		if (xfs_has_v3inodes(lip->li_log->l_mp) ||
 		    !((bip->bli_flags & XFS_BLI_INODE_ALLOC_BUF) &&
 		      xfs_log_item_in_current_chkpt(lip)))
 			bip->__bli_format.blf_flags |= XFS_BLF_INODE_BUF;
@@ -616,7 +617,7 @@ xfs_buf_item_put(
 	 * that case, the bli is freed on buffer writeback completion.
 	 */
 	aborted = test_bit(XFS_LI_ABORTED, &lip->li_flags) ||
-		  xfs_is_shutdown(lip->li_mountp);
+			xlog_is_shutdown(lip->li_log);
 	dirty = bip->bli_flags & XFS_BLI_DIRTY;
 	if (dirty && !aborted)
 		return false;
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index a4b8caa2c601..8833b1590310 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -597,7 +597,7 @@ xfs_efi_item_recover(
 	struct list_head		*capture_list)
 {
 	struct xfs_efi_log_item		*efip = EFI_ITEM(lip);
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
 	struct xfs_extent		*extp;
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 68473e51593f..e65bbbde6e37 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1072,7 +1072,7 @@ xfs_log_item_init(
 	int			type,
 	const struct xfs_item_ops *ops)
 {
-	item->li_mountp = mp;
+	item->li_log = mp->m_log;
 	item->li_ailp = mp->m_ail;
 	item->li_type = type;
 	item->li_ops = ops;
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index eafe30843ff0..af91ea1025c0 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -1428,7 +1428,7 @@ bool
 xfs_log_item_in_current_chkpt(
 	struct xfs_log_item	*lip)
 {
-	struct xfs_cil		*cil = lip->li_mountp->m_log->l_cilp;
+	struct xfs_cil		*cil = lip->li_log->l_cilp;
 
 	if (list_empty(&lip->li_cil))
 		return false;
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 8ef842d17916..cc9bda6b6277 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -459,7 +459,7 @@ xfs_cui_item_recover(
 	struct xfs_cud_log_item		*cudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	xfs_fsblock_t			new_fsb;
 	xfs_extlen_t			new_len;
 	unsigned int			refc_type;
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 15e7b01740a7..06d86a6fa128 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -512,7 +512,7 @@ xfs_rui_item_recover(
 	struct xfs_rud_log_item		*rudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	enum xfs_rmap_intent_type	type;
 	xfs_exntst_t			state;
 	int				i;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index ebd17ddba024..3682dd11581a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1309,7 +1309,7 @@ DECLARE_EVENT_CLASS(xfs_log_item_class,
 		__field(xfs_lsn_t, lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = lip->li_mountp->m_super->s_dev;
+		__entry->dev = lip->li_log->l_mp->m_super->s_dev;
 		__entry->lip = lip;
 		__entry->type = lip->li_type;
 		__entry->flags = lip->li_flags;
@@ -1362,7 +1362,7 @@ DECLARE_EVENT_CLASS(xfs_ail_class,
 		__field(xfs_lsn_t, new_lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = lip->li_mountp->m_super->s_dev;
+		__entry->dev = lip->li_log->l_mp->m_super->s_dev;
 		__entry->lip = lip;
 		__entry->type = lip->li_type;
 		__entry->flags = lip->li_flags;
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 95c183072e7a..5eec011841b9 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -648,7 +648,7 @@ xfs_trans_add_item(
 	struct xfs_trans	*tp,
 	struct xfs_log_item	*lip)
 {
-	ASSERT(lip->li_mountp == tp->t_mountp);
+	ASSERT(lip->li_log == tp->t_mountp->m_log);
 	ASSERT(lip->li_ailp == tp->t_mountp->m_ail);
 	ASSERT(list_empty(&lip->li_trans));
 	ASSERT(!test_bit(XFS_LI_DIRTY, &lip->li_flags));
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index faba74d4c702..d655abb5c235 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -8,6 +8,7 @@
 
 /* kernel only transaction subsystem defines */
 
+struct xlog;
 struct xfs_buf;
 struct xfs_buftarg;
 struct xfs_efd_log_item;
@@ -31,7 +32,7 @@ struct xfs_log_item {
 	struct list_head		li_ail;		/* AIL pointers */
 	struct list_head		li_trans;	/* transaction list */
 	xfs_lsn_t			li_lsn;		/* last on-disk lsn */
-	struct xfs_mount		*li_mountp;	/* ptr to fs mount */
+	struct xlog			*li_log;
 	struct xfs_ail			*li_ailp;	/* ptr to AIL */
 	uint				li_type;	/* item type */
 	unsigned long			li_flags;	/* misc flags */
-- 
2.53.0

