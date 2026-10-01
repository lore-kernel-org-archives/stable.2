Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2D522F1D;
	Thu,  1 Oct 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866373; cv=fail; b=iiFoKddac0phBI3BVCjaTgADj21MSd8Riwca1b0YnNpn0Pw4v5j1BtkOGdTUVT0VlrZmJybl/bxUhaGK9eHRPxpLhun5quusSOTQj0i4eLxb/0ZTAS//4wzj4BOHJ6gcsteOti3LbI858uvbayxrs83mIzkFqt0R73cKogcLiJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866373; c=relaxed/simple;
	bh=GfkLJvfi+TKr/BxVPd0m413Btu4HSQO1BLpkeuBr2kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nazuxp3qeTydG/IycSx5EwGrRzzKiLDl5dWLsgKeqO2JxjaGAnILqVXmFLq19H7MU2Ypb42VUTbTXLHchbXcbdRImKItUncHKzkCkoZiJymvfNVHZILVUkjryaxHp2fylni4GHcNOtn+/64Dl+RgwrdOLcyoKsGuNpNYAsV0cl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oRwmIDpf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WUb+xZtj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oRwmIDpf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WUb+xZtj"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMULh622799;
	Thu, 1 Oct 2026 14:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aF9MFOI+diNExF1Xy4CKPzklCCLFnhJLtJtZ2EXKSOI=; b=
	oRwmIDpfGFRRg/jFVw8sKgw6ze9hfOPRlVs39pD5eARzU4pAXdsLKjE/mJ7BAULa
	ek0nT8T11S//7lajOUAShtjL5wvek/MyCkgUgggD2d4HWjxSssIQ8G74OFkhD5yQ
	IrTh7g1bQ1dzAZynK8mIEK3lk1x8y8aJYd3mpFKdIC1YLNH6MAZ1UUTFIzO6TmVv
	3E1mW1Ec6ou2RFNswCGjZVWdM+205aiNguEKDI6mGDWvB6EEUnr62j3m2wB45lBm
	K0TFY6EMno0pCfkvNMEjAHYMy0p4fuLvwHhHu0oy3ZJcCY1klpFKh6sYWLLuHIAk
	tW0ZTlbu8xH00KHO/4/ZbA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4u2h0d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpY3017265;
	Thu, 1 Oct 2026 14:52:43 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey0qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucfaRr9uO1flBivpRAqocNAbVdP1HCvhs00wKZbYwAUNhwQvazEDEWetF66nXM52AObysjeFK38E7uyZQspVVLQFkmIchKAcS19Px3V3RxAknfllb27BFeuXKDbYxMYxoXXU4lWo/hjoG7ajs4GE9s7zlMiAY2t4c99wjcdSbbqwynPEAxmeNliRpcLGNcFHglvfFQTLGMvd/IiYroEOJq+HtaYhpNiUcbs8w1zvlXS/6BunWaFS92TFRUh2CSaZdP5xJOxalmMZsqXojifvT3wD1ltQMAhfMnsN87t2Tdr5t74STjbFXx6xJ/ZcvOjM0P9r5tLk9uF/JlGt4+1SMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF9MFOI+diNExF1Xy4CKPzklCCLFnhJLtJtZ2EXKSOI=;
 b=nxksAXy1hR66n5VFEZtXQYo27jzkl5NNlqd8u8RnvNvX5RWfghWX+98dbgVOmlB12KNe0cqNobeOAujyI3klHJVQHdyo2bX+bHZGgXyCQtRVdDPscQYedKtZss8xG+Uy32cgojWqYqgCdtcwkkujWYMPoLzATG3BKxK41JeiOeQdkf1iG58Tz+EG9fvsxeKfK40z5jY7QtOjrXybJglkBpo5/zi/uGe42TjE7WTAUXG0A/VniwV62kBE/5iTFx4S/QXKARx42BBDCRM/gJ80EGrPmNRHkygaExn8Sl6IH1amYIhQY1tc47IcA1bYB75F7DxS1+O8ctpf7MVmBbUgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF9MFOI+diNExF1Xy4CKPzklCCLFnhJLtJtZ2EXKSOI=;
 b=WUb+xZtj5siYWnk47dIZPNPBY7Su+OZG7LNBJRBDqfjxChMtt/fxFM8YEJ3OVGWEVqSbxtXzTm1+Nq2VdaUV6XZNtWEpFAKqNCXJyqRxV/HYYwYlZ6KUqUCRBvsqpuO5130GOuut2WTTWIzAR24i5fn1SAd59wGZRZNs5TUaeGw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:52:39 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:38 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 04/21] xfs: improve the code that checks recovered rmap intent items
Date: Thu,  1 Oct 2026 20:21:17 +0530
Message-ID: <667713abf92e2ac35ad29270875ebd5ba8e2d294.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 84235b57-3e12-4201-6012-08df1fcb8e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cxJ1ypIn7+zJ22L69JtdwgCv15acXQXZfeZXbmmuw7kGtbWriLlf7qJ8QItE3brB3ZRZk9Zp1TK3MDxPkr5Xu2EwCN9/h2YQQfHOviDsqiIae2JbrxcQ/E96EgsgARedF2lFcrLglOYtFE8uoLvITWXro7PGpMGMu12+67j71gmoG71eF2o5zbXiFNhnbdTm9RgMAhQbpY4/HTj2u7wSohfuHfkquBtfI7IuQDqp/4ZfveZvVHuzePo5MBToOukToWcxk15zH4wniOM3YfktjX7aEHulDdV503Kb7UVGluFSaFbjYU+VASUn2vYgfljIS9rFT1o85rlC8pVkgTYJ+wv0QKAMejNk7xBKkiEy2ubDBfQO0fzliWO1fTw64jAvOMUfP00yNlYDknJ7X8qJWcadxQferAbnX63axwC5h1X/NJE2RNQl/lsGBLbkYK/nsWBQrWwVftOy/pl95PqccLGz6cBRhfhQPeudXMqqvzWTM10rdVHTgLLhU8nmf5b9ZMLUkbFi16Gv7cnSHNhKJ+v/2stsEJRenp/iZBqwYTloPPjj0qdk6Cs7EaSXR+ehoZprwGfIIDXWQq+VJxLLK/NC69NDl12IGVh6EQUc7tzvj6U/nweN6PPKMurgUlPPEBRw66oMLXHAR5IxH09TXBmpl1dPRE2+MwF9zVjti3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1zvVBAURVhsKGDIR5Nv5XUIQm0mGvCWZeyLnH6MZ0Tx9VEjRB7f4lJlQsFg?=
 =?us-ascii?Q?2rb+cf5vktapwCeDzGdemlCWn0UWMyNk+j8bo+7w38RuP2sqEl9yo3JjxoFa?=
 =?us-ascii?Q?nxdXuLfPjH1Zx//BWgInv+z+l/sAj0Cv4gSbh+4jdRu0qcPkmvV8rQI4BvTK?=
 =?us-ascii?Q?tely35uqGXML6VRHmlRtLwF8xEKdFlDwJ9T+FGa2IvAs6HuvuPcb7ChTmnwN?=
 =?us-ascii?Q?A533RYQ5ceY2u91sEdyb/vI2S1hYsgK3krGBNLcu7GCU3uY/TGhB1KudYrP9?=
 =?us-ascii?Q?cjgZnf4kUTtolfZkFV09EHBVbophUDhaOZn/nIjrtLXPsDHx68tjURqvb10U?=
 =?us-ascii?Q?EXVh6snJRZb3mp1Oq+AnIXeU72PWekRvPaYh0vHuhtiM+6/XcWQjoXLz6URw?=
 =?us-ascii?Q?EkVzqTlF8AGEMinaIQmBhdkn6YSVMuqOKQKlEE0+9XCu8kxGrgAR7QEwdzHv?=
 =?us-ascii?Q?1TbLPzykIBxD86Hgtbd52hsvOdoE3BkDcpEacRPYur7RFp6BhTgy6lhbgyEO?=
 =?us-ascii?Q?SKRuGc37KQbWQajlCDP8KM4qyvo5xvc3ubXJrRoKcWgSbGLLLrvIFgwg8TMr?=
 =?us-ascii?Q?OgR1w5Lnk3W2T9ScvS7Cmufqc2LqorNhSW0/PEWxXCoqMB6QKy2EGZYWD4yX?=
 =?us-ascii?Q?FMPGbuXGw4kz0J5r36htIAM6tVMJsX8T+2j2Yc7Jt3O/L7OZuHmnH04K8u1e?=
 =?us-ascii?Q?kwnnHC9FHed758YK8dSSX+lzAPZ62VSSmfykxBh0V4M5s00cSUAwvh1BejMU?=
 =?us-ascii?Q?yjaDYtiWfeeZxPT5OdHmtrOVodXmC2k8a8Jl8S15hj7vT5LTluzTXwFkWjIt?=
 =?us-ascii?Q?AjTcxvQP5SxjWNqoWAYz++66fhdTy/XlEZWx4a4QdykU4PdgcODqill9U85e?=
 =?us-ascii?Q?RvwzNX53lf0Plje2gk/eknnJS3TwJGhuhyDCOcP9+qhjy/0R0OHTFVB2Eh6i?=
 =?us-ascii?Q?TG21V85DHwel8KE6TVOCUMbLg1og6WTP3EL3JwyiiedifyyIJkkmwzC6cnml?=
 =?us-ascii?Q?poiE+6wqpGmn69keWGq56d0k4bGTdmKUdzfDjA8iWnpdZg9I/TaFxJnNwsfJ?=
 =?us-ascii?Q?HwJ1dIEu+NvB+TBBbkQZkKkP2lKQMAKWmtEnk6Ei9uvRhVuXhjLn2cbQxy0h?=
 =?us-ascii?Q?34SuVzZJyIhdSSShGSnmyZtN+FpEtupvszWnDGr4oPMyU/jZRJxhL7nBEfZI?=
 =?us-ascii?Q?wh2FOa8Q6KOnjTSIdXgbCM9V8r9Qj7Nn6XdrpvtRGV19cw/IK8dTjMP2KesV?=
 =?us-ascii?Q?9y7aJsuF2HtOaLcXBgGFw9GoKyki8vsn1l/i/ee2gLbRjajXvAvr/b1BxlpW?=
 =?us-ascii?Q?96ieqXn6FPdnzS6agTCbX0SPqE5J932sV4K7EKN66kEFIMB4tBMu8vn7Mdd3?=
 =?us-ascii?Q?P2jfsyV6VHuWEsjRFm3aMbcqeB3n6RD2gkq5QMbNRX0DiTCMXi4QgFObVsWT?=
 =?us-ascii?Q?M0YNX/PXQWD9jYxJC6tmGcbMI7lAmPqIyu5Ic+XwjDtuQU9mdrHiXi1DLsRV?=
 =?us-ascii?Q?d59PLCxHU9XgZoGz7TO5qECFkITQOeEgGT3p/khFudl6EEIdYwp5WJVTFafi?=
 =?us-ascii?Q?sKWMBa4aljdy90iv6peiBlZt4uAgb3SgGuOZ5T30U1pDOJIPt9FroI65/adR?=
 =?us-ascii?Q?wcWJlhnKWVg5Pto8UYrR6E+muMhfqgghs0iunYpE+5NQABxiXEzySru9KyX5?=
 =?us-ascii?Q?jSCitbYAeJ/2II7NJ4op8+rofVRPz6cchajuzQ2kgEfd0V1kl3+HqeGb0TK3?=
 =?us-ascii?Q?PzwUd82i3aREiDfIUuAQGSZbBGUBfKQVkREWhlu2gpblqx2H7mw5ac4VCqtn?=
X-MS-Exchange-AntiSpam-MessageData-1: pMXdS46Yd3UB6vgouQfmx5oGPiNybk6J7eU=
X-Exchange-RoutingPolicyChecked:
	1RV6kWC+NfXv2kwKVgD80JR+y2DJPYaoLdmU/KB2ilr2V1wbcGaRS5souJY2UNDagj5SPmvSkojPeK9rov1Xwf/luTz4ptSSvf32sDPzgVc7RqpNLbKTtcZg9D7JfKn9bwvm8HirGHGaCDpxqgeXdKWioERfeLvqESWyYTvV6vaQl9F5qoTHos2YAWuXr7bHdq1QJ+PNNS5pTMT9aF/+Wi1gax9o+x1DFWsUET1hpiQ4ASZ7RyfbCw7+GnvqQRQ6p1ZtEh9eppuiGc863dXJ0N79eDnv7lGc6lRdi+DFqGXut1cbggw0GBfMjZqeUBHFQ+M6m6NIi8PYzZrJASu1ZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i8kxzxbpBMu+sbWkCrh0Lv+rSF1t+4LpDuWNS0TY1658RK/6SgHaMhQ+aXJkcR99b13C0Gp42eh9GFO9pCUpcg86eAw6nqEFQIY2jY2XbdTASp2JviIvDt3qaKm65cY4rV5+TXfiwf3BHMTXxeF+4x96zugwCXluLXnAWh23bo0d2hWks0VWP0XT2m26wUhymCPbP8/iClDZpq6qy9cWJcv0sYFlZ9a6UUkW/prk8ATqQV4ZH+F00PfPnJ/T/vqSXwYXFOTxanDAIoYmtrCNS9tBOu4w7vSZGItez02eI7PyYfV7JBD52GXIUtuFOdDOy1HGZUPN4yIHEKtXU4Zh1gvjZjg8MwlU+wKmSNMgthwF/I50+32yQqzX+dldetBqvfhtYBIF5BWsYdQJshrquQsSOfO5BgpiKjh3TIWvrqpXZ4IWDKYdOYcv8Ok6VwmnNaJbDrtvfQkXpbte6Ve+m46oiraqXh4KigJHl0qoOge0Xi2LUPf5DXDXLsCiqGDTE8ttIMaHNTLCigjO/0ggOynEmdGFpIbpkmwJJs5Dke2dB1+THSFGnjSxzi734PPwAcLVjzSi37gqcDMN3l4PhEPMqitQT23/5WUhcokBLSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84235b57-3e12-4201-6012-08df1fcb8e59
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:03.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZrYLe40P0fdIUsi6Cs4KcHTTD3NszFm7aCYG0Pm8hKu4gKdBqVdkHwZPcp+GAcSpdAP2a/la2WeaQIn2YTLjU2wCOTFeAle7XixAF/Pi/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1/ltOi0LBj1I
 7sqzqPoARLyBA+uizp/sH+suvJ2DoSQ+zTauRkNTS6eCWxI+Q8mXuql0w0G6u0ZcwixCeA9Hq47
 nvptbRhIKFLQqjT0tNChKcAW+7rhgbpH8CM1fScnsCa3f3TfSdV3
X-Authority-Analysis: v=2.4 cv=W9itxhWk c=1 sm=1 tr=0 ts=6abe73bd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=vvjUwkIsEb8c9uUV7N8A:9
X-Proofpoint-GUID: VSlRsGlFPRtntJAJEOk01R6iE4TeDRe5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1kVej3//cidK
 koTVLko11KNoCLpKpOXVjZRmE8BecmGYm0fiVKeX/hU0knTXGJd84705geAl78EETTh+/h8oW5X
 YE//J0i47Lh0oIjqPGU0bgeNeIa8oOPrr74V41QVG4vMp3d2cW6d8sEgIql86qzqElWm6PA8OKo
 qKiUQUag9g+2zPVEjSFzCtsY+yH+g1zilYnZP+ck23L0MUJYQi+P3FuMLo97k0sJEPbefU3hy6n
 1IPwt5S41+DCJhjhoZw/SBM5z318EH77GUQBPthHQle41XVjc48yIlSVieRWQFzejgNY6rSnPr9
 nX9Fljdf3Fmvot5ey3QohBIaqvbnRTW4FHQHA9DKM4EDIpEDJ/C814tPKwUV5KtbQY2q0lhSx/n
 knUIdapLliupUZvmMXWwkF9KzqvTMWWAsZktWoFpeC6ImadTr063cP3PsiYm2OtIuCm0AZqUAdS
 WDf8IT0AqynXUNhwutg==
X-Proofpoint-ORIG-GUID: VSlRsGlFPRtntJAJEOk01R6iE4TeDRe5

From: "Darrick J. Wong" <darrick.wong@oracle.com>

The code that validates recovered rmap intent items is kind of a mess --
it doesn't use the standard xfs type validators, and it doesn't check
for things that it should.  Fix the validator function to use the
standard validation helpers and look for more types of obvious errors.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
(cherry picked from commit c447ad62dc906f4b5f788e8ff20c1768ab2eab2c)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_rmap_item.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 31cfd734962f..f248e2b0ab5d 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -466,11 +466,9 @@ xfs_rui_validate_map(
 	struct xfs_mount		*mp,
 	struct xfs_map_extent		*rmap)
 {
-	xfs_fsblock_t			startblock_fsb;
-	bool				op_ok;
+	if (rmap->me_flags & ~XFS_RMAP_EXTENT_FLAGS)
+		return false;
 
-	startblock_fsb = XFS_BB_TO_FSB(mp,
-			   XFS_FSB_TO_DADDR(mp, rmap->me_startblock));
 	switch (rmap->me_flags & XFS_RMAP_EXTENT_TYPE_MASK) {
 	case XFS_RMAP_EXTENT_MAP:
 	case XFS_RMAP_EXTENT_MAP_SHARED:
@@ -480,17 +478,25 @@ xfs_rui_validate_map(
 	case XFS_RMAP_EXTENT_CONVERT_SHARED:
 	case XFS_RMAP_EXTENT_ALLOC:
 	case XFS_RMAP_EXTENT_FREE:
-		op_ok = true;
 		break;
 	default:
-		op_ok = false;
-		break;
+		return false;
 	}
-	if (!op_ok || startblock_fsb == 0 ||
-	    rmap->me_len == 0 ||
-	    startblock_fsb >= mp->m_sb.sb_dblocks ||
-	    rmap->me_len >= mp->m_sb.sb_agblocks ||
-	    (rmap->me_flags & ~XFS_RMAP_EXTENT_FLAGS))
+
+	if (!XFS_RMAP_NON_INODE_OWNER(rmap->me_owner) &&
+	    !xfs_verify_ino(mp, rmap->me_owner))
+		return false;
+
+	if (rmap->me_startoff + rmap->me_len <= rmap->me_startoff)
+		return false;
+
+	if (rmap->me_startblock + rmap->me_len <= rmap->me_startblock)
+		return false;
+
+	if (!xfs_verify_fsbno(mp, rmap->me_startblock))
+		return false;
+
+	if (!xfs_verify_fsbno(mp, rmap->me_startblock + rmap->me_len - 1))
 		return false;
 
 	return true;
-- 
2.53.0

