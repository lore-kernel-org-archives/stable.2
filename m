Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B4526A8D;
	Thu,  1 Oct 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866317; cv=fail; b=maVGALRwBkfjfqU7n6Gj1faZiHavX5vSeAJpQv9Cm9r9Cdxe95JWU3rffqr0lQ1l/hV0lMY7MtsYF3UhJwIJhSw+pUH9DrMaKFNoHUz0ycSy8Ieg1WX9LJH1hEoXNySDc/R0jrJvrF+2RYprGO4j+TpTacAE0Pp6WXnuVgv7Dz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866317; c=relaxed/simple;
	bh=M4p/mKtxHBtVT416PBO9psaq0LHLp9bVIfl4cLGA6pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4gWTNisPuSPw4tR4/rLsOlngqLkH/VgDM+RJzgqdMc0gFDWQNLYa8FAEcm/0EHmUxv7ZF/Ua7pJKFE8EycpJ8p1uALRfXOVGbEBC9WqigSbtTeTH4pnJlRTeHuBWjnDpHGSFEXj8Q49RnqsU0b6I7PK3zNkQ+m2GikrNAuYrtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I6ocVzxv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pysl2grp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I6ocVzxv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pysl2grp"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMlvN623028;
	Thu, 1 Oct 2026 14:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sqdzNmqXG1syod/aU9hhKzmkr1KEBQhrbg7nhGMweKQ=; b=
	I6ocVzxv/1DYM0SpBZibAhQeAuse38GbG4PlmlJt1vhsOgduiT5NkmzXk+ZRi0o8
	rFqPsbLhseA9q2rf+uZFSuf1NVYN976G7dnQHHB6gtD3LQ4GHEMhilP/UsY3C9NI
	XwKDfa5L0Bg04V39scdk1H1F6Wp2zAqcrtrNj+YRSOUAK+H+CzqIZWYz8qxAanXq
	9YcjPyHQDsFLg/EvuFjzt80L+eBETWtTDjC3uB9r83XE/64rEJkJlSgicwJOaFqB
	vL0SwetPew+YlhxrZMxMVQCtd6KP1iI8QS45U8tKoxWIiUSTuSQhkFsKT4Goyxp2
	eEsfcRQxnIZgylUuMjPdsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4u2h0a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo6En011861;
	Thu, 1 Oct 2026 14:51:44 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxs3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuECVuNctfUsHByPO+W2nRJswVIePGVq8KFo5ZodqYuhqeX2p5z8JcSeDJ/B3ixmv4bMkGDukM9r0ZeHinsM/yq3mSFK4iLo0uIT4UBPkQFGTuVQMaoWFxrdl5L3FdZBSMcS/P8oOB8NH98xRQJs5OML7u7H5/ASZEK2Pg9BRVtAfvabFJ7DXK83mjpeg0LF//VreOtRmDYm5TDEVfBCeglmP1XydxJul1iamN3E8EWIGWHII2wacD/INdtfDlL1550qzy3p5FY33WcmCgao/yLSb55tIaCHJBginqCmly9DxxStuzxWBiif7uwEJnXD0stSzJm06NW3eHPDIDK1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqdzNmqXG1syod/aU9hhKzmkr1KEBQhrbg7nhGMweKQ=;
 b=jUSmWVJSoskTExdNAIy5T+1CJjoPYDAl75qgdTt2hgnLmRkSenRa42K1broWHIzR7889UWSxNJAhBUaRT+qy/neKdTuCHLf75u60II8bmnrIhKKiV88DzqMZ9/SRmSjBlNr32Lt90KBs8Vy1fGkQyozfLvvtE8gE0/qbf6IZBSL/5bm8/bVIvKum4F/3X3k8vb+FAJ2xSzDkmJ027kkrclGdRg/b7ThWY/EB1DVsgpgPyh8+aGaP/6yu+mwrX3w87mY6joVVKN99OHEAZMEOw1nSsfNSb+QISL2zzCx6yjTb3caHBZeX5JBtv6LQ8aKUagak2TUVLieogIiDTCCyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqdzNmqXG1syod/aU9hhKzmkr1KEBQhrbg7nhGMweKQ=;
 b=Pysl2grpgBkxiNBgvwJ7J3D60oP88ikHkRgzwpM7HY3oXDkZmcFfLIzpCwb/vsWBxshGyI4pm1xUGvq7/bNjZekfdQLI+1CTktsDKPjthaG2G2QV+UqXW5Gu/jfz6O0gEmxZD9eV2AVwMo4/q3ZZ03gVJ2ggnIkV6AIkoBUqsEc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:51:37 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:35 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.6 3/6] xfs: avoid dquot buffer pin deadlock
Date: Thu,  1 Oct 2026 20:21:00 +0530
Message-ID: <39a2842588837bd2f476b4b7575cf2decc62e8cc.1790864521.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864521.git.siddh.raman.pant@oracle.com>
References: <cover.1790864521.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS7PR10MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 841ca945-1ac0-4b11-a2c3-08df1fcb7d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|23010399003|10067099003|56012099006|260925021911599003|260925022911599003|260925021311599003|6133799003|3023799007|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yoseekX4pOrmb6muIFRIWA5mErCvCTlMRNomfgdoDTe6Qm3OUPDnB1EWPZPvyTT4/cQFZpztuHBM8sInMH99yeq2Vej85yxY8gDVnOvY9u7QLgxA9iWKzQZNv7tePrRhrvdr8QX7uNUDiorE4xs3RP9UqM8npTyg9RPuu4AqMRPF0HKGVFsiINPX61U0HIJqlN74njTFKy3IM4XeuYNnxc9b/L9RFDgcGXj3nUU8bQzHMIlmcPCoEzCYRjuko3/WABoHoHDlGl6LBXvohsO8F3N60lXK+C++t2MODMq747bdz37mLVHluxDXfHQH8Y5vXdDZelJKZxlmvp0mFJ6s7lvo9aBGKZPZG1+GHkumgF675Z2Io1ENeJRDIwBWg+C2n80ikw3Gk0GIKSujb4pSvYXFe/USW11VpbKAKNL6wHTOfimZ783JYlwSvA9mIb9XIc4v7Pl6wvqf1/Yt6EhYUjRizu381tyAjNV4SWSAtsvjya+vb6NQTXgVquaUe3ssPRl4LrzazJjHQ5HD3y+Bq9JvW0EEKHNUhibRMRSx7Evvw5rsbrrnhWnD0ejit9XjXRoKN5CpzSLtj8Cnj9HCf3UNvUEq3+Rg6c3fMHTIi+KC/WgTaK3fICD43UzTuYX+od5FzXvMACq1b/BNINzH5c5uylyBtjg9tccGplRcrs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(6133799003)(3023799007)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQbd1Fx61fuvs05dIKPsIMwHnCfFbIW57+XBxLLu3Lv8edWmKIFqmLupIWDM?=
 =?us-ascii?Q?KZP6aQYwQJY/jv9afnKvnntcNp1t8l3jcecxp/ffvsRQ6uSg2FVEoVaKPftF?=
 =?us-ascii?Q?F5dQz0pkjFTo0SAKcdyk6oiRosjBIiuSsvFJcMBpPB/DZ0jR4H38vq37t6FK?=
 =?us-ascii?Q?8j0FCzS9s16dmt3OnAwDCd6EyfS/EBNw/26+AHEnxEPdEN/07JVj2lGyrG5z?=
 =?us-ascii?Q?fl94cPXYcnMB6p+l9GCVqUyZlkl9RPIk0+byXjmnThdQsmx3ydBXOiwvdJ5o?=
 =?us-ascii?Q?xxswkJpnW0YSaRFNPFz4XwNOSXeGPSL6K+/yHFzgFyXZZtMf1lwiJ0jJawor?=
 =?us-ascii?Q?UGsrKBz0e9cmElLnlNlPnp7mlXpXm6ygmGnjPBiha60pwnGqA+iRutp3ISi2?=
 =?us-ascii?Q?kTsfsGdpuDHUmwynTq/fvY8b1FPVzckzhr6hZWAiicM9U9oIo97xWgCaYfHO?=
 =?us-ascii?Q?EnqPduvOPK7Jw08tB+kTqZTfe/fa2eYYaAdZhi7osfhNDdXWer1AkgMl9PfS?=
 =?us-ascii?Q?UeZ+h7lWBEz1XXh3fjB3t/EGHyMnVtfqqt3P4z2JOv+aKSoYuQ7fFCXxbSV6?=
 =?us-ascii?Q?7iojbeOy/5OpGB50FtJcGCaksih/wFvOSn4nmvp398RYXpQ4kLCtsnazwFGS?=
 =?us-ascii?Q?TgzqvnQhVQZklsTV/b/dYCrwZPgXeXmZ6sZGTZbzLqJ4WOR7q5wTEXF9IBJX?=
 =?us-ascii?Q?GyxcVQEfUBOyohdKUoSh04Nys7QArHjPJtBnQO6JnhjAj7vIcQraenI5mGQA?=
 =?us-ascii?Q?/9tJBghvvV7GfW4ZUVZeUj+y0o+6OMaUhiw3eGW9/pWJygjDptNtJkNJ4sGZ?=
 =?us-ascii?Q?4mN7Oblnvgy1eWTGl2hYm5GgcGti+KMqvU+TNTYSFJ7q6HHfk139IkM+1KXj?=
 =?us-ascii?Q?rVtD2PkvQEF5It4ZJZ9+lZF+YBGs0eWw0G473FKrScn4DZ1sYJDbdjc5/Lt6?=
 =?us-ascii?Q?nT3nP1aGyoAKy8dX7MTfc6hk2pAFy1+l814OY03xco4388HPzaLVANjeAkSU?=
 =?us-ascii?Q?nz77fD+qbBY8DiEmihep/imFvj1F+aCOAfHAm5ijjihzvYBTp/Ik/AMWKZ7A?=
 =?us-ascii?Q?TpMJn7INObH3BzXZKRSoDtvLqC21wtV/2Hi1f4P/gn2AkWCi9ttGizSSfPzh?=
 =?us-ascii?Q?iQCvKRl2TBzcS0/q9AFhpH0LDGbS8tdDDj84xA7hzl9/zzSSbXBVIL/Czn4B?=
 =?us-ascii?Q?H4irIwfpOE5D0QRg8fpFAJT7Wp5WV7VW3DIEJPHu3wVU3HBoIV3AVnaHHUF8?=
 =?us-ascii?Q?MxAbJMOvPhYwS9kKt//gUYJ8bEn+pUqcwqZXHGapgjbaf3feAC1CppKE/zwe?=
 =?us-ascii?Q?JY1b5In0ypUMcdoLx+D1qyNNIbjPM4ky0/d4mqS3GOLye+KvYM6Wn7wW3c+e?=
 =?us-ascii?Q?f1KAzA50+3Ld9U8CWijYBR1xy3wSNpLxzGEkAkrj7e+LfH7/TDbn1qDK6BYK?=
 =?us-ascii?Q?zQXufKbYzkplsKdI24b8CfqCCkdFJjK8En3bg1gAiaowZZuIcm9NKYDXfzT/?=
 =?us-ascii?Q?Dm1TYtqLNlaIYAD0LTBPEQRy2A7UCn284rXKNG5rY+GShQ12erMcIaW+GEIP?=
 =?us-ascii?Q?bwDCva9REBoDkVdBjxEWYwSyDN+UMHGsmkBPGVJ9mitU0kGHnvIzyDdMPID3?=
 =?us-ascii?Q?LZg96gJAyRDyqcs+Din5p9SP8XZuBEkNLpSmwoCoX1pt6UTlHXCn1BoZXWsH?=
 =?us-ascii?Q?h1yhPc5OP0abL4Jyt8w3xePan7Unr+Rvg+FvFDZUw7bQGC7i0opVE+mUU+BT?=
 =?us-ascii?Q?laqyX2UmnHS/UXcLaUHBbZmYRkeENp+zyiPmNNRBuLot7aQjQr9MGLv7uiD6?=
X-MS-Exchange-AntiSpam-MessageData-1: EZVmX+u/qwRse0GsOl5sNKREh+/wKlLvMwo=
X-Exchange-RoutingPolicyChecked:
	cbPerU7WisHO6RuqqOxkIGjtuZqLOHD0BykfKcC5R4b4//8LP8d4t19qCU253guEwTW84A5t2HWpfWucQ3JE2E2Ve7BIKtm+PAJa9Rhe+UpG7tk7Ub0ac2y9t7HxI/B0Xm0lz8IVxN/0syV0a/dnLLVhp6a2vx3vzJOJl9sjZGfR5UHKiN260FtuKDAisLJ/1MMazIIoHS8dj51BAVuM3/bOWodTJ0wqzpVxCAzI0QvCpuzt+qlZtgipRLVA2HBGLhj7OXLcuGUD2cALCV7K51fqkg+lhukpm8JbSp2fyc5ZS/Ogu/FwfuI10EsecrzSiHAA0xfVu3BK0l/2Out5Hg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TGkU4jkUh0AznithX3Cw4CJ8HGNsHeUMSvDBXOjJK3twX5tC8sGWp5RBrtFxbtWtN3MZIJdFsizZ/zStJYKGSjEHmo9Jus5+kl2UUnRrFIT5xu/ZHWrLRG6MVL3FHiLz9tyE7XvM7kIOx2iZB9LCfcAoJbbCTtHipHXC9FrU9ul9l8D+lYH/EK6DdXdpJ7GnVSb9r6175YvgQwQ0YYobpGMsPnDCqE2XVk8RLsEbP1dGNMGpqNXKMA14CrvsEV339GbyN/aj9Qi9aRO+i5aAJeYgLSwDzebaGk2MS+4Uoq+972FOHUa1S/3YffbmDjQyPjxSrrYQLsumqmXcyYiLLroA2nrKq5Vq0DEfydHtZ9CitNmMfyoWGYclXbW6yX/LatppzbWK11VixZDmg/55D9I656Fw/BUZBECX5lHIuvbZBMstIHyXnwLcBm7S6iroTkX0xwrJ46GtdrvN1y8/VWPXYow/qsKiD7ew+AO99VezDXrK5TZoKtTEAFB5LnTTs64A4IZU67AoLC33VnKbwoP7tWD7KsCQ8QfSqsYNjxxewlqA7jR1TmPlzBZYnz53ystVeoROnAa7+I7QhmRGgjs+o52IwqzrqYRJ9sipvEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841ca945-1ac0-4b11-a2c3-08df1fcb7d7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:35.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozli37VdTB2WYpPmkN4l5eLnTcmpSOmI4b9lGJGqPwWhsk5wS0TF83XlE4bm8ty55XkSzUQOVZMfW9wiHuMP/ux/0yzY3M52amsrSO68Jsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4Pezf5MgGsjv
 qyuC1pvNsxgoN42YpHp4+SWhZ34BrWwhFycYSkxQLoNqWmbboTXlv3l9dWq2q+QwsHzXueyzryv
 yM2zYO7FewKRBoc49QL6v0KY+RQpB4HTPfo6VuBucx/7/YD/oeEd
X-Authority-Analysis: v=2.4 cv=W9itxhWk c=1 sm=1 tr=0 ts=6abe7381 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=s_x9I6ZcpGuAll3zZK4A:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: eCAsZDLnFCSP12m7r-NFkGPsMxf-2W3P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6cXg1K3B/WV3
 7Oi4O4F/OLKMrXRsbxPp5hauRtQzOt/Mj9mWVzg4kV3ZON7JG+GUOM0yEobBk9r4T6RbWQaqupo
 19zTpDKQK/0mW2iBHX9G6yRxvKm6O8x0N/CxtMHfzN7AbsGxvsjoLumSduYoqLDfyA+gWMAoYKA
 UHGLKFXIjfnSf/T1GaHtJbE59dzbWxlym3T7m1iHqvnv8rO3Mr53TaB4GxxYZ44tsd3A4Vb0N7Y
 b3+tTLswBg8+Y+XAgIXmB1I4zPOjlssgKJXI83UiXubVTCs6hi9uk2rafyfKrbMhKWDuiTjKt/O
 JWaSk3NdiHFpr4bSJh+RyN6jQLFv90MeDKqUDAuc86Fw6oeBbAYJ6TvYPwKyzA/R321JJKLyoLT
 zIqE7jzF+619ZgzN3DlWErKrQTQrH8JgP5zA74Jr44j02EXStXHkCpCcnG6zF7O1uC9JKFjkwBL
 lvCphjWbbvCana1pnRg==
X-Proofpoint-ORIG-GUID: eCAsZDLnFCSP12m7r-NFkGPsMxf-2W3P

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
index 1181108f8074..3775d265ebd7 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2307,61 +2307,6 @@ xfs_buf_delwri_submit(
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
index 5896b58c5f4d..b314cbe51ac6 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -321,7 +321,6 @@ extern bool xfs_buf_delwri_queue(struct xfs_buf *, struct list_head *);
 void xfs_buf_delwri_queue_here(struct xfs_buf *bp, struct list_head *bl);
 extern int xfs_buf_delwri_submit(struct list_head *);
 extern int xfs_buf_delwri_submit_nowait(struct list_head *);
-extern int xfs_buf_delwri_pushbuf(struct xfs_buf *, struct list_head *);
 
 static inline xfs_daddr_t xfs_buf_daddr(struct xfs_buf *bp)
 {
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 5fb8663b9093..ad3f0c3adaf6 100644
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
index 086e78a6143a..25248cf36b7a 100644
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
index 5c481d0df851..6f8a72a087df 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -475,7 +475,6 @@ DEFINE_BUF_EVENT(xfs_buf_iowait_done);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queue);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queued);
 DEFINE_BUF_EVENT(xfs_buf_delwri_split);
-DEFINE_BUF_EVENT(xfs_buf_delwri_pushbuf);
 DEFINE_BUF_EVENT(xfs_buf_get_uncached);
 DEFINE_BUF_EVENT(xfs_buf_item_relse);
 DEFINE_BUF_EVENT(xfs_buf_iodone_async);
-- 
2.53.0

