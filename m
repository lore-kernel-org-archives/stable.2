Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76145275AB;
	Thu,  1 Oct 2026 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866318; cv=fail; b=L6IIoGyebpk2MKBCMd6mimDRMSwLkog5ooAAti6fH88o3/PPp0FyE9E8WuP9LYK+ylcDi1KTXfkmOqm1anaUKDaGEsIv8WfR+9INr3f0i1iuJr+xWgE2Fv722KF7CjwGBtbBWItvQfhOfmBU6LLZcoqwPp7XHFdHXHr6XNY5UYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866318; c=relaxed/simple;
	bh=VqxaSm2VFaeSU2dNFHngVKDU/q07baNrml85EnSILJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6F1OI7i4YoOyTgCWVwZclKb/4xSICa+Dr3hpXYJ68z77MzlYj6S6MXsHAsoNCradcUxltQ/s0dbo8ObM7m+JK9ZN5B+FsMbGiZghvgzkmatwzv5WHfjas/Qs5KmJWaspLXfmD+8cWcY4VllPQ3C1CMbt1amxgGKsUj1hGktIuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jAv+GMM2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WYJzIALp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jAv+GMM2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WYJzIALp"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMgju2256997;
	Thu, 1 Oct 2026 14:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qn7zcobtri6qAiO4LvQUOwGTEr7bY/rzpPDHwo0owNI=; b=
	jAv+GMM2VJ0jYeIqrAu7ufiWYm/JtKU8TBm80jhTXN+WYs3XZBuvwLWq6wS/XY4j
	E0wD+0Zk6UoQ1q464XEfkYVocARNQ/YjvfRL7Np/i859PulLA4Z9Vle4dtNGBbl9
	g+/qfoymVmSUI1m/yhdV9K3HCol7oBduMxGQCCklXvv4LYqszyGJcBudgwbyMwVA
	bwxJLyxMDd9d/VvZu7pEpGhXr7QcKgVILUA/OF8mW9tVcHlT3QYmg+9DRUfErifA
	V2o/eyl/4OAdFM1a6gLsorJNWeoIRPcAAsSN8HtXCvMg8lpll2Cq4FJzGP01AuLj
	lI0pPlxzAEYHwREZcG6FnQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoQnO031659;
	Thu, 1 Oct 2026 14:51:46 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd32t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMV4NHi9MBxGt4GjYA9q1SBrDNXEiCyC3LTRLdAiJYdFFw6GCRQQdRji9Tk3r7DD2a9u095duPfZiXJJTiVJEot7MInqNb6uGbmnCqNxeGImKdCTbMoyxgMKeRVRjPFQEYmu5cWlbYGRNrTObkYfIdJ6h5zfxn+wfy0YFeIu81YmSlYTrmBeOG9GNesQ8bcaxjc/B6CQRlofzRAPc8i8HhDNWscqdDQXLRgfcOMQE81q+x86OfaTfmqOCa30b1BAu9MGiYBSpEm3MFAUcDc9u90xyZBuDaqdVOIYZq2CXhtsc8HTTnMgZPyA11YBIWKIVYI9jWbizQrBg90WIV0fCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn7zcobtri6qAiO4LvQUOwGTEr7bY/rzpPDHwo0owNI=;
 b=LPM5UNfr9qmsYvU6JQ8kupxEvobgHHxLGheOWI9sCJnvhEoh+PquptHvSh9MFNrbhNauNCAGKcZz8/gN1Il8xDMCVZjb2y+ijdkf1z39nZci89LDI2e8ZokT2mELE+m46WAsBig4zfBHeGN9K6m6I8QqZJEroicxiStlxPPp6VrkhnzubnGZnpAUW9HgR5fmk9lKVjh1e0CWpPUl7rBgjbnOnSKqmsivGOB4mKEq9ro4DkR1x3nAFd+ctadEjKHEmpZ56exZudt+pEvpehpMlmDlu7YWd3Zfu9bfkTVRrMXHEHSPO2K9i2g0/vUAeXQwUQ6rh92pZ1p11e00vKCSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn7zcobtri6qAiO4LvQUOwGTEr7bY/rzpPDHwo0owNI=;
 b=WYJzIALplIVgLt1zVsNEtb3VtUAAUdYSZfkpjDOn4E2XWB8+GONIxkA7qNZ+FiQjN/6LgI6ABT18FhqtcHPMfgfsCSds8+oRE8o3aNcjFMuiAA0kkkm+DAzxsm1UvYwHqsfgqo7/KxFJqLUT1rVysPcMAY3P2V/IdH7Z8H8L7yg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:51:40 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:40 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.1 3/6] xfs: avoid dquot buffer pin deadlock
Date: Thu,  1 Oct 2026 20:21:18 +0530
Message-ID: <e7f26cee6e45c84893c5f5d93c7331afd7fb5e80.1790864538.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864538.git.siddh.raman.pant@oracle.com>
References: <cover.1790864538.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SJ0PR10MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9f6940-4114-4a81-3ef0-08df1fcb800d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|23010399003|10067099003|56012099006|260925021911599003|260925022911599003|260925021311599003|6133799003|3023799007|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZQVz9e0pqhfKoXb4aNwJcE3cbgbOXF/9bA5bppJ+zkEWsZyzphn4B3k0xzogDKrOwrp1ds4r1NcRXVu723pRg88Kjl+gq7LP5DyL5vZtMpb/5dSeptAWCRl00FFRvPUrcKHnSP1h57py9tMWGaBN+Q0QjKzdcN5crnCi10BLwlb0+nrDMeiHGVvAAuNdatH8Ymdzux9jxe1vQ/zRMlmbtytY/c/RZGiD8RaSAqcMhw0iwpot9BVIMZX66MiJ2rAdh5EKLCUOVbqE7BN6uoWkyr8yBnr+4Yv5q2TiLRQyJmWYBI+01KJB8vvlZbg8ggqzVw8ADrLBbsO0WctXfvGAGvHSMXM8aIy6396RQmezaSE715tLr4K+FBXqgsZ9PhNLLE+Tq1zhy5SwWaPqgbzUHKy2+C27UZbPODPG7lygi5MskxbrjMetI1zjDpWth7GMu4imRtR4GcnXkEZ1jBFdi+lkkD8YuJJ+vl1x1p/s9eNIP9A11Naz7X1J1gx26F6E0Um45IsIDDlKgxb1uo98ZljayJ2l7LJ+NBaI2rjJjYADwUxuMBsDRsTF4n7bMVliMDRQtBWpQ8AZ9Ujs4qsAEJ0XQmFQWbFfjgiEhEYImekQVTJ3hXTSB8hHSb8t9HiNihOIGPJ+/NELdo6GWul9Y7QFlznZOrxRob6mFuOaMKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(6133799003)(3023799007)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?goIJP8cST/ShNBa87OSYTyx/T+1IX++piRM2CnYMUWhmiLJFnjIVVkEOwPQg?=
 =?us-ascii?Q?kgo/I3N+bOK8dwsTuFKpozHMk1FAGFkcsgmtLxwmD/8HGmZaOVkjFr+YLLPz?=
 =?us-ascii?Q?tcpTQjpUvjAwMZOqhHzk7VCGlAmX8STBqXvJKTvzWUS4uk+pUXzlsJueIDji?=
 =?us-ascii?Q?5wV4XfCzspJA0r6hpJTAKIiXSet7w3FYcCmAsVzsQVsFvLflqHCIVVDPgjVz?=
 =?us-ascii?Q?eXZU55w+fzICOQ/2jjEpJ5p4gZeBIOpCC9J7GoVnAhrSPwlS4V82H+0UafwI?=
 =?us-ascii?Q?1BpAzT1Ew++k9mUFCcrUVqQugP3KKDjwbJnvQYBDjmmNQnG3VwmMYz2gHFsS?=
 =?us-ascii?Q?Uq5VYDI1uIfSIj3ujGINl1Vcg09GEIwBxzG0W1ziIUJa6XVwO0vmn05huyOC?=
 =?us-ascii?Q?fcivIUDHr2tJOXTqYrnR4AQehEQVw+y1jWXFQXZHxhHxuXdnBEeYD9BS5yGM?=
 =?us-ascii?Q?V0sA9bjA4DYId8qmrYSwDNE2Iesx8wtok4VLToiKMp78SixZGs9hUOYOOn2f?=
 =?us-ascii?Q?aeQ3UYkfaGtB5MikPadXZWvzcu6ELej2o3OWy0wBOc7JwWLxZ87J5U/NvSVD?=
 =?us-ascii?Q?BSZXcun3+tSB199QhuTXMS0xi+smEgqJesDlaemfPoTeTJ4JaI+phkHjTkgB?=
 =?us-ascii?Q?yEF44IwhbKub1Lp0Mtbk+lWSoLVzAvlzrEQYs4w5fk1f8djdfM4lSKewBV3W?=
 =?us-ascii?Q?Vh8zqk9uSWVlUO0HJyd6Cqrqo/wsduhjryDbiEOgr2X7bnxJuc/1+7NLH44j?=
 =?us-ascii?Q?pv/ehqK5xWFOJP7aFFmjH5hqfv8JnmKkxR0fVyFBQjaD+3anHrkx5Iq0X73/?=
 =?us-ascii?Q?HK8rSUs1qQO+ISPAK6x54x2amiHh/dAyI9Q3wGOBgg8dIrTpb4z18o0Re+4b?=
 =?us-ascii?Q?OsZYtUmICyP+XL9loI/ttePyE89Q+m2maUFbvOXjaF4UjoVSOQTe69roLCxz?=
 =?us-ascii?Q?GfHwXkxCd5FgHSTtsV3Trt/RCmShRp50Fjgpcy33+ZVP817ZO/lQBNaWo/2j?=
 =?us-ascii?Q?0nR2fnRjUDo8qChjFmGWiyNxJWwc6UyrRE7qHegmVmDYHb/Ih14oEKnpp6yJ?=
 =?us-ascii?Q?D0aa46OtwClTirLuqmiCpmLv+Uslssh7GcuWJfxH1hJtXFaxSuIg5gLaqcYA?=
 =?us-ascii?Q?0G87H9YsAdt5MixYXEVq2d8zwP/rHaE6nPJ/uSDgyKGdp5knSb4L0GnNxZS1?=
 =?us-ascii?Q?QfD2uTnltsXmnlMQCToFamCMvfkPxz3DVzvkOunykiZgtIJemPMbAB9CQixC?=
 =?us-ascii?Q?5t+UXcVvJVJpDgUCjk8EM2wzpPXPo55NLgvsybxur3tWBohfd6URNN1QoykR?=
 =?us-ascii?Q?TeRhlYxvmeK4MAPgTQtUi4yWjQcTa7WDS3jBkKGDQb3pfcvvG6uPf9PZTusa?=
 =?us-ascii?Q?cEZh0TqWQizB9fubNzwoW/hSu2EAhKQCEfjIP56GGBTC5HfslQUyqNRsM9qp?=
 =?us-ascii?Q?jtGBNSV2UTuaRlUasfGIVki/UU57JXf2RgIXZ90GVodA/YsLKNY68uKl938+?=
 =?us-ascii?Q?CiVK/fTlpPOZo34vDRfdJZK3JfnfH6/INjZu/CjQCEf9d2cvZkuhFCMozOFl?=
 =?us-ascii?Q?UrfCRutmJXVhc/mC6sAIfriPueaTDmY1sxaD5VLnO10bXrUJ4ctKbqcZG3ZZ?=
 =?us-ascii?Q?6AsQc0tZqqLcdwbJ1bke0JVVHUhHd4/l9Nd65MYJx0EdWEv9/fbmYd8cFay9?=
 =?us-ascii?Q?2bsTkPH6UuNLK5mVwz39laHgKg5JNBdXb1ejvwJTAi+c3f/zgyJW9wdkK8V3?=
 =?us-ascii?Q?cSTa9KMCVfNNYpgPm0zGQXEn3bHFKunv8kIEtF37/c6CT/VUU6IRfpTMzHvY?=
X-MS-Exchange-AntiSpam-MessageData-1: P8eDFHnzMemAbFkGegyLRRdfwU+ngHLSt/c=
X-Exchange-RoutingPolicyChecked:
	NnPxG9PukDGUKoHyqzRdj9EJc1VFCc+b1btjqhTB4klhzAnSGAp+eOGG4I4M1mBKQL04lXyPKkKL/UOaLdvrhcPAtekAvDdhoaYMwI5iFGKN0HrHTngRIC8FWYJmZPN2zkrxk758rPUaX7+10udiMa6R/O/4fMVRncBdTFEKyL7oFcJDs/kCgAZzNP97ivf8m8M4FieCtKWZiMPpyaRcFNOO8mmoCgrmiPp7zIjnjTooMT72xfhXc7kl4NANhs9g25BLP0rpxhor5PDB5atnY1C8LgMvTWX9qm1lVeEDhjTP9bE/DCWCAYlCzjA6PtupxKY3YaodVCFwKaEXAibfaA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MPCok0HW2WVbiQL9eKj5UZ0atfLG8HgwHgkcMeJQkILrAiSXvs6JXA7+VP079JEiJLvKCMN+5r5pQFk02KGl7rH3DitpegaqqhfFNH7I9lC2TqVRLkNaVUybKj/lQa51FHLBRWDJthdq02JSPIVVZSm3nNXKBeU1lakmiQtyOwliXoT4Q/KlsMz0Fv48MMK83Y58qBvPnnJ9qv74VYF2+WfAHiijMoRMsnCtLqp+txgtFd9kfH9UMml4vss1SqkabfF6hSQIbJB42D60PkQwqltdfj3ig0fVcdEf/uBq6Fy6mTzpZqs8s62M+I1c8U8DODPV3SIIst4cE/WtPAv1LB55Qn18N7ZrmN5eHJUa6JvGjFhhhhWjDF1TrL6zZsaBBX+rg3USRQ/bC/3ML+WrmtUPc3rYDO9ZUsW3/TdlpgZsqlZk15QogrknDmmSgU+nOXsRh/BkkA83dO4+wGYn6nXLRmu4iP8B0Xo+uxvzmr3VA4GM5Y9UJ/SjUg/KZB9ZVz2l6X4qVs0hsAz12X8XXm7+Zbsss1uQRv6vdXJx4eqLoVSBz9EI80caxRZMNYCYky30NJ1646aRAftxxx1I/YOBBFobMetnATEx82sTzkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9f6940-4114-4a81-3ef0-08df1fcb800d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:39.9531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+yINHi1TgA7IqcJqyD/k0yKgih3NeXaMUegv6Ymc176X86MswO0Z8onTNRL5OWZzpR4w2h9/+S3MIS3kZkvdcHcAnSbYNkGoAnU/G4WyVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4WiIAAHfBDI+
 MK2y1R+y80uXiGAdeiRJL0ehAfdgJTqfs1kcudwdY362qpfSVU94N4yUBFdorxryQGKZPtA3tsV
 B0nYT24zuyrursJnarTe4Z+vICJSQLvlQdTAatKZUPBXgYlEHF6b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4V6VbL8CeENk
 oBW7zG8Bi31uKStuz5BJLvk/Y3XcYw5Kr+YjfWWWqABq5rdghDIDZez55hXlF8EYxxq7jcsEHWd
 /cp4HD5AuohVEF2q7KQLtDUdaKeYEKfJ+WTf2KA/eJ9aTU1ShquW/Nq9i6FxxqLwWZQ93BZCOhd
 h8073PYyf1lnjVYDFXS7XnUz9vz2RmdUF3WdFloCZhFNUxxwtJsl0LIJ8vG2GrBKBYGUbYtn0ij
 AEaE2U+OmULa8OTn13wXp5OWg2i9DyoJAiWunK17NoYDl8dYyAZA/CYsrbJuomBAHkBEhBhJBHn
 HqJsfnBree3rMiLDi71B7JkntL7cZz0Cpc393dk+xGuerI33vvCxmtoQLlyxePue8eeXuRQlcd8
 x1IcSPqY6OtrDmnVRR24dz/o8cjtX3yQb/kaS69T38JsWFUpeKvg3Q2z+ashvp/yKk1ww5k7l1Z
 hUlmuV8o6tda03DOpUF5q6yiG9ef6l4kXqUhPl98=
X-Proofpoint-ORIG-GUID: 49NyigJe443al2ht_XLQkKi32yH3D3tv
X-Proofpoint-GUID: 49NyigJe443al2ht_XLQkKi32yH3D3tv
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe7383 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=s_x9I6ZcpGuAll3zZK4A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537

From: Dave Chinner <dchinner@redhat.com>

On shutdown when quotas are enabled, the shutdown can deadlock
trying to unpin the dquot buffer buf_log_item like so:

[ 3319.483590] task:kworker/20:0H   state:D stack:14360 pid:1962230 tgid:1962230 ppid:2      task_flags:0x4208060 flags:0x00004000
[ 3319.493966] Workqueue: xfs-log/dm-6 xlog_ioend_work
[ 3319.498458] Call Trace:
[ 3319.500800]  <TASK>
[ 3319.502809]  __schedule+0x699/0xb70
[ 3319.512672]  schedule+0x64/0xd0
[ 3319.515573]  schedule_timeout+0x30/0xf0
[ 3319.528125]  __down_common+0xc3/0x200
[ 3319.531488]  __down+0x1d/0x30
[ 3319.534186]  down+0x48/0x50
[ 3319.540501]  xfs_buf_lock+0x3d/0xe0
[ 3319.543609]  xfs_buf_item_unpin+0x85/0x1b0
[ 3319.547248]  xlog_cil_committed+0x289/0x570
[ 3319.571411]  xlog_cil_process_committed+0x6d/0x90
[ 3319.575590]  xlog_state_shutdown_callbacks+0x52/0x110
[ 3319.580017]  xlog_force_shutdown+0x169/0x1a0
[ 3319.583780]  xlog_ioend_work+0x7c/0xb0
[ 3319.587049]  process_scheduled_works+0x1d6/0x400
[ 3319.591127]  worker_thread+0x202/0x2e0
[ 3319.594452]  kthread+0x20c/0x240

The CIL push has seen the deadlock, so it has aborted the push and
is running CIL checkpoint completion to abort all the items in the
checkpoint. This calls ->iop_unpin(remove = true) to clean up the
log items in the checkpoint.

When a buffer log item is unpined like this, it needs to lock the
buffer to run io completion to correctly fail the buffer and run all
the required completions to fail attached log items as well. In this
case, the attempt to lock the buffer on unpin is hanging because the
buffer is already locked.

I suspected a leaked XFS_BLI_HOLD state because of XFS_BLI_STALE
handling changes I was testing, so I went looking for
pin events on HOLD buffers and unpin events on locked buffer. That
isolated this one buffer with these two events:

xfs_buf_item_pin:     dev 251:6 daddr 0xa910 bbcount 0x2 hold 2 pincount 0 lock 0 flags DONE|KMEM recur 0 refcount 1 bliflags HOLD|DIRTY|LOGGED liflags DIRTY
....
xfs_buf_item_unpin:   dev 251:6 daddr 0xa910 bbcount 0x2 hold 4 pincount 1 lock 0 flags DONE|KMEM recur 0 refcount 1 bliflags DIRTY liflags ABORTED

Firstly, bbcount = 0x2, which means it is not a single sector
structure. That rules out every xfs_trans_bhold() case except one:
dquot buffers.

Then hung task dumping gave this trace:

[ 3197.312078] task:fsync-tester    state:D stack:12080 pid:2051125 tgid:2051125 ppid:1643233 task_flags:0x400000 flags:0x00004002
[ 3197.323007] Call Trace:
[ 3197.325581]  <TASK>
[ 3197.327727]  __schedule+0x699/0xb70
[ 3197.334582]  schedule+0x64/0xd0
[ 3197.337672]  schedule_timeout+0x30/0xf0
[ 3197.350139]  wait_for_completion+0xbd/0x180
[ 3197.354235]  __flush_workqueue+0xef/0x4e0
[ 3197.362229]  xlog_cil_force_seq+0xa0/0x300
[ 3197.374447]  xfs_log_force+0x77/0x230
[ 3197.378015]  xfs_qm_dqunpin_wait+0x49/0xf0
[ 3197.382010]  xfs_qm_dqflush+0x55/0x460
[ 3197.385663]  xfs_qm_dquot_isolate+0x29e/0x4d0
[ 3197.389977]  __list_lru_walk_one+0x141/0x220
[ 3197.398867]  list_lru_walk_one+0x10/0x20
[ 3197.402713]  xfs_qm_shrink_scan+0x6a/0x100
[ 3197.406699]  do_shrink_slab+0x18a/0x350
[ 3197.410512]  shrink_slab+0xf7/0x430
[ 3197.413967]  drop_slab+0x97/0xf0
[ 3197.417121]  drop_caches_sysctl_handler+0x59/0xc0
[ 3197.421654]  proc_sys_call_handler+0x18b/0x280
[ 3197.426050]  proc_sys_write+0x13/0x20
[ 3197.429750]  vfs_write+0x2b8/0x3e0
[ 3197.438532]  ksys_write+0x7e/0xf0
[ 3197.441742]  __x64_sys_write+0x1b/0x30
[ 3197.445363]  x64_sys_call+0x2c72/0x2f60
[ 3197.449044]  do_syscall_64+0x6c/0x140
[ 3197.456341]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Yup, another test run by check-parallel is running drop_caches
concurrently and the dquot shrinker for the hung filesystem is
running. That's trying to flush a dirty dquot from reclaim context,
and it waiting on a log force to complete. xfs_qm_dqflush is called
with the dquot buffer held locked, and so we've called
xfs_log_force() with that buffer locked.

Now the log force is waiting for a workqueue flush to complete, and
that workqueue flush is waiting of CIL checkpoint processing to
finish.

The CIL checkpoint processing is aborting all the log items it has,
and that requires locking aborted buffers to cancel them.

Now, normally this isn't a problem if we are issuing a log force
to unpin an object, because the ->iop_unpin() method wakes pin
waiters first. That results in the pin waiter finishing off whatever
it was doing, dropping the lock and then xfs_buf_item_unpin() can
lock the buffer and fail it.

However, xfs_qm_dqflush() is waiting on the -dquot- unpin event, not
the dquot buffer unpin event, and so it never gets woken and so does
not drop the buffer lock.

Inodes do not have this problem, as they can only be written from
one spot (->iop_push) whilst dquots can be written from multiple
places (memory reclaim, ->iop_push, xfs_dq_dqpurge, and quotacheck).

The reason that the dquot buffer has an attached buffer log item is
that it has been recently allocated. Initialisation of the dquot
buffer logs the buffer directly, thereby pinning it in memory. We
then modify the dquot in a separate operation, and have memory
reclaim racing with a shutdown and we trigger this deadlock.

check-parallel reproduces this reliably on 1kB FSB filesystems with
quota enabled because it does all of these things concurrently
without having to explicitly write tests to exercise these corner
case conditions.

xfs_qm_dquot_logitem_push() doesn't have this deadlock because it
checks if the dquot is pinned before locking the dquot buffer and
skipping it if it is pinned. This means the xfs_qm_dqunpin_wait()
log force in xfs_qm_dqflush() never triggers and we unlock the
buffer safely allowing a concurrent shutdown to fail the buffer
appropriately.

xfs_qm_dqpurge() could have this problem as it is called from
quotacheck and we might have allocated dquot buffers when recording
the quota updates. This can be fixed by calling
xfs_qm_dqunpin_wait() before we lock the dquot buffer. Because we
hold the dquot locked, nothing will be able to add to the pin count
between the unpin_wait and the dqflush callout, so this now makes
xfs_qm_dqpurge() safe against this race.

xfs_qm_dquot_isolate() can also be fixed this same way but, quite
frankly, we shouldn't be doing IO in memory reclaim context. If the
dquot is pinned or dirty, simply rotate it and let memory reclaim
come back to it later, same as we do for inodes.

This then gets rid of the nasty issue in xfs_qm_flush_one() where
quotacheck writeback races with memory reclaim flushing the dquots.
We can lift xfs_qm_dqunpin_wait() up into this code, then get rid of
the "can't get the dqflush lock" buffer write to cycle the dqlfush
lock and enable it to be flushed again.  checking if the dquot is
pinned and returning -EAGAIN so that the dquot walk will revisit the
dquot again later.

Finally, with xfs_qm_dqunpin_wait() lifted into all the callers,
we can remove it from the xfs_qm_dqflush() code.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d62016b1a2df24c8608fe83cd3ae8090412881b3)

6.12:

Fix conflicts due to following missing commits:

fs/xfs/xfs_buf.c:
	eb43b0b5cab8 ("xfs: simplify xfs_buf_delwri_pushbuf")

fs/xfs/xfs_qm.c:
	da0c02516c50 ("mm/list_lru: simplify the list_lru walk callback function")
	fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")

We delete the code so we don't really need to add them.

6.6:

Fix conflicts similarly due to following missing commit:

fs/xfs/xfs_dquot.c, fs/xfs/xfs_qm.c:
	08c7027e43a2 ("xfs: separate dquot buffer reads from xfs_dqflush")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf.c   | 55 ---------------------------------
 fs/xfs/xfs_buf.h   |  1 -
 fs/xfs/xfs_dquot.c |  3 +-
 fs/xfs/xfs_qm.c    | 76 ++++++++++++----------------------------------
 fs/xfs/xfs_trace.h |  1 -
 5 files changed, 20 insertions(+), 116 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 34e476301342..be99a4107036 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2298,61 +2298,6 @@ xfs_buf_delwri_submit(
 	return error;
 }
 
-/*
- * Push a single buffer on a delwri queue.
- *
- * The purpose of this function is to submit a single buffer of a delwri queue
- * and return with the buffer still on the original queue. The waiting delwri
- * buffer submission infrastructure guarantees transfer of the delwri queue
- * buffer reference to a temporary wait list. We reuse this infrastructure to
- * transfer the buffer back to the original queue.
- *
- * Note the buffer transitions from the queued state, to the submitted and wait
- * listed state and back to the queued state during this call. The buffer
- * locking and queue management logic between _delwri_pushbuf() and
- * _delwri_queue() guarantee that the buffer cannot be queued to another list
- * before returning.
- */
-int
-xfs_buf_delwri_pushbuf(
-	struct xfs_buf		*bp,
-	struct list_head	*buffer_list)
-{
-	LIST_HEAD		(submit_list);
-	int			error;
-
-	ASSERT(bp->b_flags & _XBF_DELWRI_Q);
-
-	trace_xfs_buf_delwri_pushbuf(bp, _RET_IP_);
-
-	/*
-	 * Isolate the buffer to a new local list so we can submit it for I/O
-	 * independently from the rest of the original list.
-	 */
-	xfs_buf_lock(bp);
-	list_move(&bp->b_list, &submit_list);
-	xfs_buf_unlock(bp);
-
-	/*
-	 * Delwri submission clears the DELWRI_Q buffer flag and returns with
-	 * the buffer on the wait list with the original reference. Rather than
-	 * bounce the buffer from a local wait list back to the original list
-	 * after I/O completion, reuse the original list as the wait list.
-	 */
-	xfs_buf_delwri_submit_buffers(&submit_list, buffer_list);
-
-	/*
-	 * The buffer is now locked, under I/O and wait listed on the original
-	 * delwri queue. Wait for I/O completion, restore the DELWRI_Q flag and
-	 * return with the buffer unlocked and on the original queue.
-	 */
-	error = xfs_buf_iowait(bp);
-	bp->b_flags |= _XBF_DELWRI_Q;
-	xfs_buf_unlock(bp);
-
-	return error;
-}
-
 void xfs_buf_set_ref(struct xfs_buf *bp, int lru_ref)
 {
 	/*
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 6cf0332ba62c..b9cb233f2685 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -308,7 +308,6 @@ extern bool xfs_buf_delwri_queue(struct xfs_buf *, struct list_head *);
 void xfs_buf_delwri_queue_here(struct xfs_buf *bp, struct list_head *bl);
 extern int xfs_buf_delwri_submit(struct list_head *);
 extern int xfs_buf_delwri_submit_nowait(struct list_head *);
-extern int xfs_buf_delwri_pushbuf(struct xfs_buf *, struct list_head *);
 
 static inline xfs_daddr_t xfs_buf_daddr(struct xfs_buf *bp)
 {
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 220634bee911..5697977c747a 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1223,13 +1223,12 @@ xfs_qm_dqflush(
 
 	ASSERT(XFS_DQ_IS_LOCKED(dqp));
 	ASSERT(!completion_done(&dqp->q_flush));
+	ASSERT(atomic_read(&dqp->q_pincount) == 0);
 
 	trace_xfs_dqflush(dqp);
 
 	*bpp = NULL;
 
-	xfs_qm_dqunpin_wait(dqp);
-
 	/*
 	 * Get the buffer containing the on-disk dquot
 	 */
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index bd907bbc389c..3e30fe269fee 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -131,6 +131,7 @@ xfs_qm_dqpurge(
 
 	dqp->q_flags |= XFS_DQFLAG_FREEING;
 
+	xfs_qm_dqunpin_wait(dqp);
 	xfs_dqflock(dqp);
 
 	/*
@@ -418,6 +419,7 @@ xfs_qm_dquot_isolate(
 	struct xfs_dquot	*dqp = container_of(item,
 						struct xfs_dquot, q_lru);
 	struct xfs_qm_isolate	*isol = arg;
+	enum lru_status		ret = LRU_SKIP;
 
 	if (!xfs_dqlock_nowait(dqp))
 		goto out_miss_busy;
@@ -430,6 +432,16 @@ xfs_qm_dquot_isolate(
 	if (dqp->q_flags & XFS_DQFLAG_FREEING)
 		goto out_miss_unlock;
 
+	/*
+	 * If the dquot is pinned or dirty, rotate it to the end of the LRU to
+	 * give some time for it to be cleaned before we try to isolate it
+	 * again.
+	 */
+	ret = LRU_ROTATE;
+	if (XFS_DQ_IS_DIRTY(dqp) || atomic_read(&dqp->q_pincount) > 0) {
+		goto out_miss_unlock;
+	}
+
 	/*
 	 * This dquot has acquired a reference in the meantime remove it from
 	 * the freelist and try again.
@@ -445,30 +457,14 @@ xfs_qm_dquot_isolate(
 	}
 
 	/*
-	 * If the dquot is dirty, flush it. If it's already being flushed, just
-	 * skip it so there is time for the IO to complete before we try to
-	 * reclaim it again on the next LRU pass.
+	 * The dquot may still be under IO, in which case the flush lock will be
+	 * held. If we can't get the flush lock now, just skip over the dquot as
+	 * if it was dirty.
 	 */
 	if (!xfs_dqflock_nowait(dqp))
 		goto out_miss_unlock;
 
-	if (XFS_DQ_IS_DIRTY(dqp)) {
-		struct xfs_buf	*bp = NULL;
-		int		error;
-
-		trace_xfs_dqreclaim_dirty(dqp);
-
-		/* we have to drop the LRU lock to flush the dquot */
-		spin_unlock(lru_lock);
-
-		error = xfs_qm_dqflush(dqp, &bp);
-		if (error)
-			goto out_unlock_dirty;
-
-		xfs_buf_delwri_queue(bp, &isol->buffers);
-		xfs_buf_relse(bp);
-		goto out_unlock_dirty;
-	}
+	ASSERT(!XFS_DQ_IS_DIRTY(dqp));
 	xfs_dqfunlock(dqp);
 
 	/*
@@ -489,14 +485,7 @@ xfs_qm_dquot_isolate(
 out_miss_busy:
 	trace_xfs_dqreclaim_busy(dqp);
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-	return LRU_SKIP;
-
-out_unlock_dirty:
-	trace_xfs_dqreclaim_busy(dqp);
-	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-	xfs_dqunlock(dqp);
-	spin_lock(lru_lock);
-	return LRU_RETRY;
+	return ret;
 }
 
 static unsigned long
@@ -1231,7 +1220,6 @@ xfs_qm_flush_one(
 	struct xfs_dquot	*dqp,
 	void			*data)
 {
-	struct xfs_mount	*mp = dqp->q_mount;
 	struct list_head	*buffer_list = data;
 	struct xfs_buf		*bp = NULL;
 	int			error = 0;
@@ -1242,34 +1230,8 @@ xfs_qm_flush_one(
 	if (!XFS_DQ_IS_DIRTY(dqp))
 		goto out_unlock;
 
-	/*
-	 * The only way the dquot is already flush locked by the time quotacheck
-	 * gets here is if reclaim flushed it before the dqadjust walk dirtied
-	 * it for the final time. Quotacheck collects all dquot bufs in the
-	 * local delwri queue before dquots are dirtied, so reclaim can't have
-	 * possibly queued it for I/O. The only way out is to push the buffer to
-	 * cycle the flush lock.
-	 */
-	if (!xfs_dqflock_nowait(dqp)) {
-		/* buf is pinned in-core by delwri list */
-		error = xfs_buf_incore(mp->m_ddev_targp, dqp->q_blkno,
-				mp->m_quotainfo->qi_dqchunklen, 0, &bp);
-		if (error)
-			goto out_unlock;
-
-		if (!(bp->b_flags & _XBF_DELWRI_Q)) {
-			error = -EAGAIN;
-			xfs_buf_relse(bp);
-			goto out_unlock;
-		}
-		xfs_buf_unlock(bp);
-
-		xfs_buf_delwri_pushbuf(bp, buffer_list);
-		xfs_buf_rele(bp);
-
-		error = -EAGAIN;
-		goto out_unlock;
-	}
+	xfs_qm_dqunpin_wait(dqp);
+	xfs_dqflock(dqp);
 
 	error = xfs_qm_dqflush(dqp, &bp);
 	if (error)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index a7245de495a5..92a7e30294e6 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -466,7 +466,6 @@ DEFINE_BUF_EVENT(xfs_buf_iowait_done);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queue);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queued);
 DEFINE_BUF_EVENT(xfs_buf_delwri_split);
-DEFINE_BUF_EVENT(xfs_buf_delwri_pushbuf);
 DEFINE_BUF_EVENT(xfs_buf_get_uncached);
 DEFINE_BUF_EVENT(xfs_buf_item_relse);
 DEFINE_BUF_EVENT(xfs_buf_iodone_async);
-- 
2.53.0

