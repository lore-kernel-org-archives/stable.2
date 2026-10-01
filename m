Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B7530DEE;
	Thu,  1 Oct 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866339; cv=fail; b=KQzQ8FfKxX/4LXv0oBJNjMVazRPSJwuif1lAKhhEQJD666VueOD9Ec+xaeQbtN1ArjxHjW14Rb5O94qtqB1AdKm7D+YpFWuHujOFoLJfSPJ+7jBaiSyTVT6gLY3vuyd2gYZx+0GnlpgXZM7K6UAve6iHu3xBXSp9vbRbzYXYkVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866339; c=relaxed/simple;
	bh=UQBwldZF4J+Hu0HklMFVlHdEYOiHhNSQo3acNI1ba+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOs6+lpFVsGWGKZ8bbhni1uB6BnzshYlT6QNAt2g3AtQ+nAVomUscDh+UimLv0tZohq/1Iy4OZHlEBfLl4lVMyCoN5wq1bFQKYQJgv6YNUj6dXzKIC8pADl3WxhcCGYDh6toNz3+lTKaoKGuhMnh2PMmHEGOwfogNQpB0a6au+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mvszx2TZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LKa2SVOw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mvszx2TZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LKa2SVOw"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMoim2257015;
	Thu, 1 Oct 2026 14:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jmGk17dKi10wRgkth825iTibFUERug1dl3uknvUru7A=; b=
	mvszx2TZDHFfzS2G0Ld89T7smHjmcWkl8zbNdFK1lib9D5eZ19ads7/MXDD+9XGU
	GvYInYdBvlLiDsGNYjKSkE+jtnGbmq/ZO3Wkd0/OPhjI8S7TyKuMZXBbMbggSqyY
	A1MThns60SVjEctxgoUiI7HAr8AOstdMlHLdtyzY0D+3XTXImy0HIkY1ThhyKjOY
	tdCNKk/zI6z6uXzOLbOqFt1b0XBziuAAmnVMVHEXrqeYvf1Dl1saHQfxnDJXtbSn
	qUF8ResnWvha88mTSGNfZ+Tqzax7Jm7e0+s/6okvl231Egy5fN1pNYkNCTYNpJpZ
	bRzUMLb+5quklW9tmXdWew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoSJm027846;
	Thu, 1 Oct 2026 14:52:11 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsnty9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5MQdkiSq8RzI9E4qoZgwoFnyfJ48R9FOey/KjSbPjyS8JQU9yek/n6IASWnVBvf3qKLKiiUusSiS9MIN0fHfx8Xbu2X+HQCT0vZQVMLx3SeUD5a3hf1/G6VGrecUVB3hYY9xfjXCscW6iPUh7DttPfSwVfscqdbZAC6bOXrBj//+onx/m0czu8CGPOpBqbVnLmP4q4HqbkPF+olkrMadRzlXM28abvWaQOUNYmIiHR9lK2sTUsFhjtgSfQCXyYY4ZBmGJVS+8f750IT9QDUTlEN4dBuOfH4HyXdgpfzlzIT7N/JIFQT49mrA4IpyznJH0Vhr32Yy+Me5PZ2Aqzv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmGk17dKi10wRgkth825iTibFUERug1dl3uknvUru7A=;
 b=In+GJfzANZK5qDsOYIIZsljwr+bBoND2q9XgTbA7hCC/BOcCfIwYZvbTi3wxpeZPdJjWx5UJbrqiRQ0qyBA/KXEHxYotMUgkjACVHxtlfq5amSdTYt1ECIX1zjyKVcg1nWijPoODy6uVCNGFV1EXknsq3MdOOnZysYn5kotisKUuxJdY+gaZA015xqE+QdC2PuhsDpfHjse//yejYVWoT6+GWi384yDoTxmeLlD1G+kMH9OzUr9axtZ8PGVsj+TBhTs7lz+Eu3dRP0+6pWa42I1Ym8wL4Z5JolzjBCo0l5mxoFOqzngYgVgZ4odXl/yA6buIZSxerRK93OglKwhP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmGk17dKi10wRgkth825iTibFUERug1dl3uknvUru7A=;
 b=LKa2SVOwyy92r7FrgKeu+clSwgifbGNrClNJb39sFymvWYXqQTgqzGO08bFZKCl5uQbuNWP9jN6LG3IFBKqcauOdOchAmEQ0PkBFPGj+vPOuzULbrWKuUzu/w0jBTxMAdL1tYOC20HAPKUnw8RnRv4wzjKPEG8NjxSarHxP9DV4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH0PR10MB5730.namprd10.prod.outlook.com (2603:10b6:510:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Thu, 1 Oct
 2026 14:52:02 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:01 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.1 6/6] xfs: fix unmount hang with unflushable inodes stuck in the AIL
Date: Thu,  1 Oct 2026 20:21:21 +0530
Message-ID: <e3b42966ac89325a2ef2add95d9e50a2eb456369.1790864538.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864538.git.siddh.raman.pant@oracle.com>
References: <cover.1790864538.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH0PR10MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fe9ee9-7a20-4e1c-5600-08df1fcb8882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	Cim/Z7jXVK2IzT6XjONifXLS9+lJy+0MT3ezdAZ89yg+pF/rSK1JfXxZ1hpRhLr8u9n8UH7g4jIEr7ZK/v5JQQKgd5tczElObtsLKTw/R7tX6FMDjPAqP5MgaLbkhpEIpkPzgRAbLgGPfRRrhWn3SeDHt+wFCbFjqb6z2sGcQmVIUeLBcHkP6cOYr31y0RGFxBFT2JU7hFBMZPWqPMcJBZUqN0kIQDnwY6kBgL/AOGDIFpV/zxwvYAswLIO7RVU8fgs/G75Paiaxia8yr7D8UmCuT5aFhYfy4sorBbEBe+EMJddQhlo+U3yOMemiUcz2+04lBZDNuFyNj3PgZR1artbui8Uat/RFYxCa9uyIPI4O7wZ3/W61HJqjTYZtjyf+XiqR2xSVcb5hnlfqwZ69GHwskWZ7WZaa1bc/vc4DkN0yV8Pf/R73qzjvOf2tCChzEMrM21SzfB8rZfz6JZZQ/YXeO/85KtKkShy+hRvq65WVL5K6AA8dvvp4lUUtz8M8qVfIsjvRzzgQLRN/wZbdK3z3TccU0WQID4qsJV0fVed1AZWQ62OLi5cOv81SvJOVEDixhRY2H01VMXJoJ8wWNAW8+atRFRfY4NjDOwP2h7b3QUTVIIvfKsjI3gVjFUS/P7pTZO+XVxEY5baT55CY0hl/UO+M8uR80IXSMH0f2IQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+jXvNjjQGUCEkQwHR2UCOg8hDJvY2DP6WNZzy0WcuOzXz+jXbWxoAJm3QaH4?=
 =?us-ascii?Q?ETJIejUPGCCxn2KTsAGRDtoqE8cxXP65WfV6X6odtbAAhzZZndDxX2NvCazs?=
 =?us-ascii?Q?Uv+TuEpWx/edkT+jNW+LcbaLjpJZ/T8nvjkwOyiyQBir5BjQbPs4RLYcCYer?=
 =?us-ascii?Q?/5c/4CuyMNDlLhmCN3gBC+jMzUtd0yQ8DVq9B8RfbhThALRPSoeXrKkiM0Kl?=
 =?us-ascii?Q?oh2L+RbNmx+YbxsHOOHsjpEeHJoQPLnv1DC6FkdFB1npEaVi7UV4Iq5UuYeA?=
 =?us-ascii?Q?m8hitY3M1D0Hgcz8iulZnE23+0fYnfpz78ZCB4DBj7s4TzdkCBB6Jc0jUGec?=
 =?us-ascii?Q?ob7V7xOUyZyHPJCeBXuual898ZMwpprrgRyRtHRiWs7mcZXRkS+lgKmyJHPk?=
 =?us-ascii?Q?M8sjMjSctOMP5CJ5NKJui+K4mltInMBEEPNO2mDOt5UKcwXAYQoAhAoOUDQP?=
 =?us-ascii?Q?ANtj9ZHwEUV3/eT0oaGJeoA7VoZ2yMWbLwyRRaKNWhufVKUBGVlRmmWUZB+b?=
 =?us-ascii?Q?f3I/OR6GDo9sMy0g4mde6mOUyLmNU32LRLXYGkEdIQ2aL8IsxVoIMMWmAvNg?=
 =?us-ascii?Q?13YRAY3cYeigVcac1+VmkwywiJTh4UTz2lsMoTa/dgLWt9H1b3Fw1U5CJE7v?=
 =?us-ascii?Q?pc4822IHQICUR6mmZTPxedEgIfEr5sZ+IJWAsgHJmcuhyKyf7rLPae6duMkB?=
 =?us-ascii?Q?eu8xz3nVMPC4BhzII80ANZ+K1qSY33oMP2IYiwuKB8J1m8wn/umbSZgWEadW?=
 =?us-ascii?Q?OaZlwr9izjShPQ2CmbbhWBd6ScGjNEFi1iC63OVIIjkI/+oGoFcAxUqg0zFt?=
 =?us-ascii?Q?n29FLasOAo1WlinwDVPIzgiqr3GKCpZYhk0VAbBxfaoY1dav+2vo24+2ZAMI?=
 =?us-ascii?Q?e0aPMux+C2FYhodVtK426eweTy34cvWc0gmHx1tbelS0KzhQsMUPCzWsFGWQ?=
 =?us-ascii?Q?aNzQwXFXVizFs7NQJZ1FiH6Ro6TDHEks27DgDkv8UfFOw3fWk7FUbqSyXXYh?=
 =?us-ascii?Q?AMSI3ZLMtLc4/Tw4GlUep2bIKjAn76WUPgzIe6hLn1oibO336PbNNZfdWhtJ?=
 =?us-ascii?Q?r0rOftw2w17c7rWCeXmHQD+aiBkQYqAAezMIh4RB32GTDNZ6dPL33/TSt07A?=
 =?us-ascii?Q?lPI5ex+cODrkz3T8CNi5iQNY5rWawseULyghSb6pxmqdAi6eIrAdTglPx6FJ?=
 =?us-ascii?Q?dfh9av97aUssHBEsGXXLftUkvGYoUDGQ9rCbgVKQHfZE0w69Cw04/yXacKz6?=
 =?us-ascii?Q?aWrW7TKQtCqI/Qi0AX9H8tvMkTNxN0pBqL4OV/Z6ta+RPY/Kl+pCjsxkNYtC?=
 =?us-ascii?Q?IYMROIZx4FxVJbld2zFQf7BoGPUPlvVd2GtaEm1S+ZJmicgxgZn5p56lidTi?=
 =?us-ascii?Q?vahnWgjmmiar3Ti1bjpgk7dDL6rvwZNODyvLN0Tx4xJSND7+Sk8oGQQw7p3L?=
 =?us-ascii?Q?wlkn+aif60PVoqYablKfFgnM18tN/0sX/0Jh+YNgXIuZWRtaQ6CkMnuw3Rvi?=
 =?us-ascii?Q?K2p9MxWubqku+cN8J2NkWuXWriUcCILEGbU0Ac4gkx7GvKVaUFxyOOxbE0op?=
 =?us-ascii?Q?OqGDj//DGoHOAFW6UoxI+Lq1b05CDRGYxgbPzJQrg6htOlLG7bladoEKuucG?=
 =?us-ascii?Q?nMiiOSfaK9+AKCJ0MrkjX01GrnWFkKOwkMe8buxfEB8vjPsjvg2mV9kbsBAy?=
 =?us-ascii?Q?TMWxvsY9k7PUOIJS1mlC4jClrRZ8DRu8JI8PJDYCO9MepSdrsRvuqX233HNb?=
 =?us-ascii?Q?/Gosxf4pQezH+ISsOm4GPHPPKKTb3cWRyfKCt6QNyJLMVxRwyPpQg25I1NXz?=
X-MS-Exchange-AntiSpam-MessageData-1: FXfATozqDFhUFR9V1XMesccHZsO1ZXaCjjY=
X-Exchange-RoutingPolicyChecked:
	vJbgMNlGfKM3zWc6ZmR4w8sltqyIccZZoLOf6ov/C8FIraDLYNHyBVtJ3IS11lTbTlS+85UwTJ2XiuBuGci+QSgrZHIQ+7TXPOfBiUdN2fk91DctIlBWBORVLvZhCKRno3yUIcVDdIrTpdWiEMZVnUlJ8fcUOBmfmhzqLAFfsLNH0h3UdIUPzE8p82o4xrHKO5ZGpfJBiSzp9HLlsYDcwXkumQ4tQTpdLkxbmMptb6ot3JZPvvizped0ifAh5LvQ65dGWMzM6M0GXhnUeadPBhsi5Eh4TFy6Dc2sspyxXDRTXr3o6H9uemIVaa8mqzlk9WacdC00XRsVSzMXcHCJfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tx1dMywslNsD6hEMBCYUnjF1hblJ0cTogQ4I0oZ7kun4DnciJL7xDJPWSRntENGcLbCTCRafF77Do/sXXjssDTp6+YaPH5Qrqyyg/zzGt4azNrITBr2m5I0DvSLXHG+rhUyw5oeKgvUS6TJ9Wvj8nLUCrV2K4M3jxdJtP2nuEW1cpiNWI4XWuIjE9DzxQok+RDM8vW9TJ41FHEZCjLAUd9N3Q/o2FBP/SnM/y6HrA7jRGDYU+Nm0heD3FMxuMxal9OWY+lyVQDBcX8+f/JenCGlNJygSBTRyq+scxEsjouprIQDEjcQxIvbHWPO/n6AjhK0Lh2tox5VL37rJIdkFj7qcajmLdrzSBhq+INR5lm3k2LyiR8QPAnfahYC2H1kdwsK6Z2bE9BxlbxBZklYdtRAsv2o1NZfQseGaFj7fk5MYEg2UGDP5SGMOY2vVebone/ifuVsMdFWW7TYYPC3Ktcx/UukblYV3zWjHxFiNTv6JNDWki7VCE40BYDkO+CDj+2cNgE4SICsYqFrgqQw8y5qn5g6trouNHl0t4jIMzs7LwuJ7o4pS2lxIKknnZvy+vAuevT5L8DkBibqYHx6keIHJgxCSBK0/935a3NxxpC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fe9ee9-7a20-4e1c-5600-08df1fcb8882
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:54.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYSf49NjkKffKW6P8Q3M7Zb6Q21dolabNiGPgP/qiFjojLbisnpnoJD71WElInfenHoJMegWJ6lPj4ucQzvnmtpGvhcEpeStcorwxT7puW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3OZYuxWUDO+/
 K1g8mK1MKWyG+jQt6rpCfmM7220LTDKwV8JyMsJ9Rt9e3wxdpmHV9WlNu1zd3DFpi+QwUjQXYTU
 VJaTN0ER+CU3HjFwd1UKXaoJnJHWmm7kScozCtE1tb/O+YzV1g9c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX5vQvukL3uhua
 99wlBffwRK1BOzvX/xbAQU8U+4ys7/W4MgxTUXDjSDySwcE295PA70tKwzmpRxeCf+Zn4j6EcVa
 LNjeJ9QDlBeYw6JplmZ2scrpCszSCaPGniSALk9M1Us417ItcYUa6c78Z+vBXd86vUlVgC3fvWe
 hrFFiHh8X9eyZIUIvUT5cxyaSBj7IwfLNgRrc1KWJDoxmIQTKeM7aUON7LlqPsXS55eb/K5hiBl
 53Hh2j3bE3lrXSq8WoSiqiTFk9Pr1jeUjiWvYxcF+44kkRsJGDSnprra/SW1z0+O/tGOpeUV8xh
 2QxV1JaHZKaPPiYUJY8DYmK0YBxPaQiuz/+2+pQCuN6hU9wjD68EWeKIktEsdoFjhL0n4gj+HiC
 8Ogvv/I4w2t3zOmRB3WQjZjMTHGuxZlWtmJTrjAUHtCuZPKSdOJkr71JVCqaGyi768IB/sNq6fL
 E7GDFutKiL6LxmcG8vcfkVMfm3VVHrfIN//ewJps=
X-Proofpoint-ORIG-GUID: vHYv4PEG_GGphnj_pKt3mHYabpQiO8qo
X-Proofpoint-GUID: vHYv4PEG_GGphnj_pKt3mHYabpQiO8qo
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe739c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=6pTqLFfXKm7bnsEQBbsA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108

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
index f13df8adcf4a..af128e06e841 100644
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

