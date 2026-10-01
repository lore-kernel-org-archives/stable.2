Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB88518132;
	Thu,  1 Oct 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866303; cv=fail; b=NEOXne3qxTgCUFL2p4sKuRYKJbt0KGP66LJanhVzWR30OxW5MZY8YdtTFYZ6ndzSUDS9woVg133E8WgXtKh2r1Cx5Qx6wZebIwVEkpT94eoXEzz/kKT8XnZjoPaxNSKAefzd781kzO6ow5y0tq7C/SORQbcnGY5htaGd04qnhGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866303; c=relaxed/simple;
	bh=Ta9C8A3fQUG9IwyVp5h7oozBz0YUdeRc/0tkVZ85EkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5Q1Hj/y+eFyhjNdPuRN7sEzeuFBYTKLpLPXBqcPlF5sY6TVCe/822hAujXYz5PKVlL2JBIDtay5q6aTKKdhpUNmHhV0vy0tmXNVSWbWhe8Hb9a4S/hkjgXxqv66s+Ljis60UtMkfgzsCYx07OCZTZ6Qb65J32nUf6bxByDFhIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GtJsPaG9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cD0HhceY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GtJsPaG9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cD0HhceY"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMXMC539214;
	Thu, 1 Oct 2026 14:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=InXX9gEgY9Fe1b2FBhTvPxEhzHF52A2U98f2CloKp/E=; b=
	GtJsPaG9d83QmP938+KpFT/2spe5oDOjiAyeuvLNpYLwNs9NbNovxMfY1QTFjWTH
	WQQbl0irYjU92BWufV5dQHlPMYcMm3nlRWf5UnlIgdZwx1nDs3WhOuOiyLzatrZt
	6plTSUbwG8uEo7UCQDCNosLarD3oH1GTHkK+/IBFvsFzZPjuLrj1ltxA+3ImmsFa
	lwpAgERnH6SgCGyyj14cECXNAAjd5v0DAZbpJYXWX9T+izZQn9ADlk91VM2FcuwZ
	IQJzJBav4i8wdG96o0I8yzyU/YeisRrdoUr1C1KOzKkekyfcMw2cMo9w8/ho6p6Q
	qvzT1WNGIpO6en55FCZBSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgyjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoS8m027813;
	Thu, 1 Oct 2026 14:51:35 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsntbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvIzhTM3ttyuLgndy4mJxZ6Zdh9BGm7QCROzCBL3TvNFpkn+47jOnC6ucWK7jhoybtBhRIt+kKY7vJ7RydKHroMa8TMDhBwaLIwRXRZetdQ1EeyfwOneXuQoJLeXTuOU4e0DKtVUlm5fCnIakHRlW8uakHNva3lLGeihP3PD2ImQ5N+D9jlcBLfrwbVoq28U/OBptZRABf9YxNqj7BqBDf6LRvxjwkdSX6/S+S/KYFBegm+ylu4aXvxaIya3gd6CnRcFciarqVd84l0FbLyZ9pdjfsAZZ10Zn1K71z8MiV3d4RQ0eo0cwesuXslRlggIk7AcXXAp11LSKdgDL81w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InXX9gEgY9Fe1b2FBhTvPxEhzHF52A2U98f2CloKp/E=;
 b=yd5376IDGkdAenTsL6BNz0NJDc7Ek+9lLWwyAyTs2E5oQ6vNu1GGx3TPoKa4hgCyUhcggjQlkcRN+ly5V65/gGYFwKGIF4CvD4f0KykGBq1ytSWH6jgjJQURwfmliadW3B8uLt8jK3YmQ5TmX7FZ0+/g3V1+bWI8dvqtltb/yNY11z8Wvi/jglmyfzPVSsO/QljTH0EU/0hJmeR+0x/sSda+jqleYz5lVPD7A4xoMkpHqZUD/RMIXYeOMFl2XuXv6Uj7kL2C31M6YqFMxbfp3bUG1JTUFsNs8X8CdAS3OmGcRSE8SeLf2C33o/dFwo3otD0ew0J3w1m31qdeQXqSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InXX9gEgY9Fe1b2FBhTvPxEhzHF52A2U98f2CloKp/E=;
 b=cD0HhceYY7BMYg2sSQ9KUjDsj3qiFG+zy48R5ZBgtBgTQklARXMAY/PTEnUuQFvAeEEMeOpB6XB1KFprWXWre0aiuCsewKuIp5L5r/A+WD9oCVjwO/K/VWdJDld1Ftrs7f7jxyDTitySrmJwdFG6xjrtX9ZewQRSSLqzctqYDmc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:31 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:31 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.6 2/6] xfs: catch stale AGF/AGF metadata
Date: Thu,  1 Oct 2026 20:20:59 +0530
Message-ID: <2a0cbcdbce34dc035d043f777cb0bef4fda9540d.1790864521.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864521.git.siddh.raman.pant@oracle.com>
References: <cover.1790864521.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:295::10) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: e7db5d8b-a492-41f8-f2fa-08df1fcb7abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	FLmM540XaqVzy3vOlWRBZDdr+uFN50AtRtaedaFiSUGPFmbgDsOLclodWXHU8BZ3nSy79rK5qnInHNwI88cp7nWcZ1Yv3YpE6cVtXRkBMkZ1dkNKkc/8pTbrmCARTnLIzw9ShP4Vm46UrdtW+6LlAdbC2HGVcTsntXZzTbThk/Wt97We0PukNmI3GgG9Na8U4CT4Gilnvp1l89bVFhlm2Rg2vp96lc1uwcRF0wtZGIqhZEHPBU2POyMOpsayuELWNvCpSLobk3utcLwTxuYqdQN9oCaFD2TJWkHEpL5Fa1FUkbGo0EhV0sr3eXvGVvyqRF/VfVR2Fot3HOaEeBQuuDV9fwtc0KKSM2JJXJKef2ejJgzShpTmxIQ3k94iJJVudFuwf4o0abCWlhrsz85h9A/CwtUyfMzvTkjcfybt7QE3h9+YrnaJFCpC8IbHjvrUcedIjZvVhpyrfbYVLQKTJ/DbEgAIgk87QOPTNmNubIDUorncE3p08Yv5+X/Bkgf+W60tldp9Y2H+RUtNsj24AcmXJjmvGLbirFA5q7lirt1hZjkt9ajnE/PRlvxWyJxDQThzZLyhxbIQBJIOTEdLILg9fDDpcM47Zm4VG6Jw7tTiuGAYRs6Tg/6j8mVAOLsP6ILZVA43jrpv3MJLdvHn+vb4U4nh+oLHc4EqSRp5y04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fGzyDVe+RUTH8ohvcdXkDDRRhnxLSsDRyRX26mvh4f8GfmvlkGFCZwFTRXAX?=
 =?us-ascii?Q?eqtmu2uMR74doGrcl7pyoE1iLke+4ozETlOMA4BXC0n3kUOPuPDoCIsX1aCu?=
 =?us-ascii?Q?VR38tHEiYOnszry02DDD22F/HYi7NSJJf9b/1N0Y/K1dFeGqnOtMZ8dbZHRp?=
 =?us-ascii?Q?kSBhKX9IlDmP/+W/PxqZhBwCHeAX70L/wco9hYGCo7pS/nLlV2mj4BpxQG8+?=
 =?us-ascii?Q?IPbDOZ5pa/ZgHaAsQp+QjCBwl827grNIg0LuwqucOL3yxTraMCwkuSNLt5dk?=
 =?us-ascii?Q?qXk5+rCWMxu+oZ8qlUM2vwusw0pUTAV2rTw6Rr3gg5rcdefJBwODNB2U6Mwv?=
 =?us-ascii?Q?pMov8D25xS7zZYn0rjXPbkjeIa3SbUaUVfBPiaRvVDsf/p82xCxP9He7/bv/?=
 =?us-ascii?Q?8SwM4yRBmB3EjihGp0D9Y0pYnCHTNXozCSoNdjxB9WkQ8+13eZ45rsgVSg7M?=
 =?us-ascii?Q?XqTagwfKJ5jRMSigIZcC5ZxAKcvWGXd1cCiN6XKk8wx4P2ftiOssGBRqULGl?=
 =?us-ascii?Q?EElWVZz/OZEWyVEg1O5uYj+kxv8XUGY+/mTzTgyoccEOVi5uOL0grQ7IZwLR?=
 =?us-ascii?Q?S0hK11MWkaNihhznHqQ1pq5CZeAEbxtmS4ajQnYIOSLq3xRAp2PzaUKwLogP?=
 =?us-ascii?Q?3KUSESchjX7zXCJj5Pg2UEsD+bbCcXv/H8xlG43seEnCnL2Sf21+GQEqQ7rL?=
 =?us-ascii?Q?KJ8VAe6m3y1AZXvYafHnc1KjxywpwMdoMFnFWQSoMlFhW14MAhNkaeDLL3qP?=
 =?us-ascii?Q?fq/hSZnRG1J3E99SIHzI/pUEml+6DoMK48v95pY2mmZVkAYpjv81rvkhy+/B?=
 =?us-ascii?Q?DervZVu0R2GGzO7ayqZUNEQ1ziCymxenFumdkTJRPWBcHC4P8/MeGFGbkQRk?=
 =?us-ascii?Q?S8ksnLkMSHdSAqFHFjmJ3vdkTHke8p6+BlPuoqPyNG9LOPTDRYXqTZlEPuvG?=
 =?us-ascii?Q?kcv/nojtC/PmXJ7OL22faVYEQIS+di6kgskYK0Tk20YSQ/yQg8PAdn2c5xjD?=
 =?us-ascii?Q?M8NSbd3TLHdZSIZyErjYtZ9qH2Z2dK/CfwJ3VZgvv751b2VmcF74kTS0ieQE?=
 =?us-ascii?Q?WY+nld3h0DWfBzX94202E+Eu6ZlW7IUGfPewm5HyEpMitMSTPoeM49yiW9uu?=
 =?us-ascii?Q?9nut7k7t3+0cSi/QK0GiU7rVDod/ja+F3ClX/1/7mb0VIimFopnWUc26zIX+?=
 =?us-ascii?Q?hvtnja9xBVQoA8PAlhR+h/nIJmkIiu/VAWvgDkcw2ZCO6mZS172pNzPvpJol?=
 =?us-ascii?Q?aO+atU0USfcmt61RWDXTaWUzZXeBxC+j5hfWwsjptI+j+UX3JlzsHCNtZ+tk?=
 =?us-ascii?Q?WCd6IzdtCLsfygLlAkqZNFFbhv8haKIoGowhHhdVGbXXM5BgPv21cNdLlG3a?=
 =?us-ascii?Q?sBy8Rd3rW4N/fz56PSElqxaabYEzPrg4BEZZbXxR+6b5x/eT/tB/bpFzp7/r?=
 =?us-ascii?Q?slk1hXPxjvPX3/gWnpGeTN1LT3qBWwF4w2TFFWo8YX0a9HuaRkq2BBG/1g2z?=
 =?us-ascii?Q?JYFISQMIJJueo+RyaJWrurLf4/X8riVD0NzQQYdvtZ1AZC4BQedbk7rhGVZR?=
 =?us-ascii?Q?YQaQApIDOKsw7E9YVOCkQTaQgRkKNB0Jak74/Z79ncC3COkeQEhhV2whnONc?=
 =?us-ascii?Q?qv+EGZmxb7lW5xc0wkPY607jKwT3ZDt8Jgs4ufDT/S6UVGPC2kS1nVejGh3M?=
 =?us-ascii?Q?+cruhUEQjE/m2yWP/Z7fa2v3OfrOLgeDpFfg7KJ8lHnRHfaTNSVt8r+7vh7V?=
 =?us-ascii?Q?KeOK7l/6G30xVB+LFJcLahYSB8+EPanGij/Mf+RYxdvID3ahRMS77yVVqcHl?=
X-MS-Exchange-AntiSpam-MessageData-1: nVoXAOydoG21Zjmu1n7rmOq+fnaF7b92SK0=
X-Exchange-RoutingPolicyChecked:
	1+p+/BOZIsx6/tPmd/hhXpPnfM9h49RuvheEV5KPaVTGehqojUoJ/wL6UIMUfa4V/qJKbLDoc3VLx/tiL0JCvGBaKXMx8ckGcBO2qzsgvKShc3OZRNKLJwE+NaRtGRCzhkfb4yEFzcq3k15OB8hdeJDOZEYhrqFRV+vIZksm7z8YoGr4WKcZxawGaSPdKYd6H0bw+kab5l+1R0C0BYTGKUuOlcF72KZ/mwOVBWAKc8hASal13gx3YHgip0oqck1YCzsa2I8QRsQ8BGBbefSd3gNZfPmhZTgnyiHOtjZAzBZakobGI2nkYBQ36j16dDZeZx5Ky/L55DUApv3Mgc4vDw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wvTosBbd3tIhEC4mx7qpOVKXqzHJYgOGt/mUT+IMWJwWWrhfAaJ9eZkMjcNSldS7mvFyneoZMp5YNo0j5zo55+M1Qt/mjLtD15Q6dxgXDBQOQ6KyR3YeDYidON/SwB6YbgLCb3x1Jqs0MpPk2ZwKvvOy8kxt7xrAPOZ4gC9Yc8AVbcOP8WqTscbO85Oy5B3OhyLrpmuQr1OZhT5R537DB+AiwWWJb038GQUSfxR4jq4Jw6R8ORVn6nLTYnuZutloj6N/Qo8LSxjE2X4bvDVDMv3F39JTjeBFIkvK+sBezFYrYeeKyviNkfkf+P8jH897CIW7O951PFhv56jXq64JK2kBy4P+fiy6CMbeAjBdJpbQJOYekMaRCoIg3rUxSLhRm8C8dnXQ6Tdu9vWuUH2xuP5cY4dw4I1HWI03gUrsOT6rZy3xBIjSLN3NfQRcZaKVFIXtkDPIWyBLgwkUBrpmNT3MKg2QvLCrRY71T4ZKIhXNiexwPlbTvoGWgeJmg7j7U8ZTQrKF48aYg/qnheYt/7Yed3RvNjDwxpnpzVFjd/lJ52LQJwiPrjSV0cNQwQTH0X7eP76Az7Avz8MXJQKHLBjD2f3TYPFAG8MjUS6p9LE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7db5d8b-a492-41f8-f2fa-08df1fcb7abe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:31.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyMSyulXmyZKjkeMc7oYlQq+1eO/utyqjZDWYW2UCpGvC6sg5DPgDakbxDcOjmirwDXcw7yvS5hxmuPm76UHZ4Id+gGkevlEr4MWbOJ4fjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: zyTvI_Q_UeKj6Z1lA9nyiwnvTDPpk9aC
X-Proofpoint-GUID: zyTvI_Q_UeKj6Z1lA9nyiwnvTDPpk9aC
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe7378 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=2l8DqRWQ2dbnbHYYE4MA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX0mdFnpEL5jxD
 lLD9j9qRwMMFhNFcQo9LzvF4tZah2QlmC6FJuMbbjPt0gPrYIPeKMOPO6R+8hxUdocqJFhpNCxi
 hXUxuO7fh+gQ1TlDaprdtXs0VS7yg5n1NtMXNIyjktdDQMfY/EKP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX2WQWUmwVSpXo
 NFNGTsbVZdmHfN5PhB87g48YC+zmmEQ2t8P7OyKGeKb+QRIIbSmEQS3fhhWLnNBQX5OXy04BYKT
 7RsL5k1u0H0odyDnByc3kE2ZLY2rnaynpqXaBOmCkCdc+v5VZhbJiI+mmjt/fRB64GNoqYL32fj
 RGGccqhTtTWcJMZylsSKdnF0hL7OF4BYmJaGa5MP+7uQJZZAlxQos61AlMzTug07qQFN2yIM4Me
 heCHyhQJwWbaNv3H4XOdOAyMoPkiCgoNdC9GMTAllHz+B1r2U1UtFIJfgCCocVagV5j8VRie+7+
 scVBno2ws1FNIczPytDuGYTlgcSaYiGjXZ88zRRuRlFZD6sL9waIOuSc/ClX6f1yhzeNf9gZdIR
 pGm3sV2Q39mid4IoyAuaL1E/kbNS9Fsshm7buEaZG03P4I8aI/YkuQGAia5vyY4dryh3q5t0pQp
 tWQmS1F3kc/dhxMYYHHO7/Ue+MKNZjZw8VzQygMY=

From: Dave Chinner <dchinner@redhat.com>

There is a race condition that can trigger in dmflakey fstests that
can result in asserts in xfs_ialloc_read_agi() and
xfs_alloc_read_agf() firing. The asserts look like this:

 XFS: Assertion failed: pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks), file: fs/xfs/libxfs/xfs_alloc.c, line: 3440
.....
 Call Trace:
  <TASK>
  xfs_alloc_read_agf+0x2ad/0x3a0
  xfs_alloc_fix_freelist+0x280/0x720
  xfs_alloc_vextent_prepare_ag+0x42/0x120
  xfs_alloc_vextent_iterate_ags+0x67/0x260
  xfs_alloc_vextent_start_ag+0xe4/0x1c0
  xfs_bmapi_allocate+0x6fe/0xc90
  xfs_bmapi_convert_delalloc+0x338/0x560
  xfs_map_blocks+0x354/0x580
  iomap_writepages+0x52b/0xa70
  xfs_vm_writepages+0xd7/0x100
  do_writepages+0xe1/0x2c0
  __writeback_single_inode+0x44/0x340
  writeback_sb_inodes+0x2d0/0x570
  __writeback_inodes_wb+0x9c/0xf0
  wb_writeback+0x139/0x2d0
  wb_workfn+0x23e/0x4c0
  process_scheduled_works+0x1d4/0x400
  worker_thread+0x234/0x2e0
  kthread+0x147/0x170
  ret_from_fork+0x3e/0x50
  ret_from_fork_asm+0x1a/0x30

I've seen the AGI variant from scrub running on the filesysetm
after unmount failed due to systemd interference:

 XFS: Assertion failed: pag->pagi_freecount == be32_to_cpu(agi->agi_freecount) || xfs_is_shutdown(pag->pag_mount), file: fs/xfs/libxfs/xfs_ialloc.c, line: 2804
.....
 Call Trace:
  <TASK>
  xfs_ialloc_read_agi+0xee/0x150
  xchk_perag_drain_and_lock+0x7d/0x240
  xchk_ag_init+0x34/0x90
  xchk_inode_xref+0x7b/0x220
  xchk_inode+0x14d/0x180
  xfs_scrub_metadata+0x2e2/0x510
  xfs_ioc_scrub_metadata+0x62/0xb0
  xfs_file_ioctl+0x446/0xbf0
  __se_sys_ioctl+0x6f/0xc0
  __x64_sys_ioctl+0x1d/0x30
  x64_sys_call+0x1879/0x2ee0
  do_syscall_64+0x68/0x130
  ? exc_page_fault+0x62/0xc0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Essentially, it is the same problem. When _flakey_drop_and_remount()
loads the drop-writes table, it makes all writes silently fail. Writes
are reported to the fs as completed successfully, but they are not
issued to the backing store. The filesystem sees the successful
write completion and marks the metadata buffer clean and removes it
from the AIL.

If this happens at the same time as memory pressure is occuring,
the now-clean AGF and/or AGI buffers can be reclaimed from memory.

Shortly afterwards, but before _flakey_drop_and_remount() runs
unmount, background writeback is kicked and it tries to allocate
blocks for the dirty pages in memory. This then tries to access the
AGF buffer we just turfed out of memory. It's not found, so it gets
read in from disk.

This is all fine, except for the fact that the last writeback of the
AGF did not actually reach disk. The AGF on disk is stale compared
to the in-memory state held by the perag, and so they don't match
and the assert fires.

Then other operations on that inode hang because the task was killed
whilst holding inode locks. e.g:

 Workqueue: xfs-conv/dm-12 xfs_end_io
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_preempt_disabled+0x15/0x30
  rwsem_down_write_slowpath+0x31a/0x5f0
  down_write+0x43/0x60
  xfs_ilock+0x1a8/0x210
  xfs_trans_alloc_inode+0x9c/0x240
  xfs_iomap_write_unwritten+0xe3/0x300
  xfs_end_ioend+0x90/0x130
  xfs_end_io+0xce/0x100
  process_scheduled_works+0x1d4/0x400
  worker_thread+0x234/0x2e0
  kthread+0x147/0x170
  ret_from_fork+0x3e/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>

and it's all down hill from there.

Memory pressure is one way to trigger this, another is to run "echo
3 > /proc/sys/vm/drop_caches" randomly while tests are running.

Regardless of how it is triggered, this effectively takes down the
system once umount hangs because it's holding a sb->s_umount lock
exclusive and now every sync(1) call gets stuck on it.

Fix this by replacing the asserts with a corruption detection check
and a shutdown.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit db6a2274162de615ff74b927d38942fe3134d298)

6.12:

Fixed conflict due to the following missing commit:
	e9c4d8bfb26c ("xfs: factor out a generic xfs_group structure")

6.6:

Fixed conflict due to the following missing commit:
	e45ea3645178 ("xfs: split the agf_roots and agf_levels arrays")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  | 46 +++++++++++++++++++++++++++++---------
 fs/xfs/libxfs/xfs_ialloc.c | 32 ++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index ad2fa3c26f8a..0383216e39dc 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -26,6 +26,7 @@
 #include "xfs_ag.h"
 #include "xfs_ag_resv.h"
 #include "xfs_bmap.h"
+#include "xfs_health.h"
 
 struct kmem_cache	*xfs_extfree_item_cache;
 
@@ -3240,18 +3241,43 @@ xfs_alloc_read_agf(
 
 		set_bit(XFS_AGSTATE_AGF_INIT, &pag->pag_opstate);
 	}
+
 #ifdef DEBUG
-	else if (!xfs_is_shutdown(pag->pag_mount)) {
-		ASSERT(pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks));
-		ASSERT(pag->pagf_btreeblks == be32_to_cpu(agf->agf_btreeblks));
-		ASSERT(pag->pagf_flcount == be32_to_cpu(agf->agf_flcount));
-		ASSERT(pag->pagf_longest == be32_to_cpu(agf->agf_longest));
-		ASSERT(pag->pagf_levels[XFS_BTNUM_BNOi] ==
-		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_BNOi]));
-		ASSERT(pag->pagf_levels[XFS_BTNUM_CNTi] ==
-		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_CNTi]));
+	/*
+	 * It's possible for the AGF to be out of sync if the block device is
+	 * silently dropping writes. This can happen in fstests with dmflakey
+	 * enabled, which allows the buffer to be cleaned and reclaimed by
+	 * memory pressure and then re-read from disk here. We will get a
+	 * stale version of the AGF from disk, and nothing good can happen from
+	 * here. Hence if we detect this situation, immediately shut down the
+	 * filesystem.
+	 *
+	 * This can also happen if we are already in the middle of a forced
+	 * shutdown, so don't bother checking if we are already shut down.
+	 */
+	if (!xfs_is_shutdown(pag->pag_mount)) {
+		bool	ok = true;
+
+		ok &= pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks);
+		ok &= pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks);
+		ok &= pag->pagf_btreeblks == be32_to_cpu(agf->agf_btreeblks);
+		ok &= pag->pagf_flcount == be32_to_cpu(agf->agf_flcount);
+		ok &= pag->pagf_longest == be32_to_cpu(agf->agf_longest);
+		ok &= pag->pagf_levels[XFS_BTNUM_BNOi] ==
+		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_BNOi]);
+		ok &= pag->pagf_levels[XFS_BTNUM_CNTi] ==
+		       be32_to_cpu(agf->agf_levels[XFS_BTNUM_CNTi]);
+
+		if (XFS_IS_CORRUPT(pag->pag_mount, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGF);
+			xfs_trans_brelse(tp, agfbp);
+			xfs_force_shutdown(pag->pag_mount,
+					SHUTDOWN_CORRUPT_ONDISK);
+			return -EFSCORRUPTED;
+		}
 	}
-#endif
+#endif /* DEBUG */
+
 	if (agfbpp)
 		*agfbpp = agfbp;
 	else
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index b83e54c70906..dee46010702d 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -27,6 +27,7 @@
 #include "xfs_log.h"
 #include "xfs_rmap.h"
 #include "xfs_ag.h"
+#include "xfs_health.h"
 
 /*
  * Lookup a record by ino in the btree given by cur.
@@ -2634,12 +2635,35 @@ xfs_ialloc_read_agi(
 		set_bit(XFS_AGSTATE_AGI_INIT, &pag->pag_opstate);
 	}
 
+#ifdef DEBUG
 	/*
-	 * It's possible for these to be out of sync if
-	 * we are in the middle of a forced shutdown.
+	 * It's possible for the AGF to be out of sync if the block device is
+	 * silently dropping writes. This can happen in fstests with dmflakey
+	 * enabled, which allows the buffer to be cleaned and reclaimed by
+	 * memory pressure and then re-read from disk here. We will get a
+	 * stale version of the AGF from disk, and nothing good can happen from
+	 * here. Hence if we detect this situation, immediately shut down the
+	 * filesystem.
+	 *
+	 * This can also happen if we are already in the middle of a forced
+	 * shutdown, so don't bother checking if we are already shut down.
 	 */
-	ASSERT(pag->pagi_freecount == be32_to_cpu(agi->agi_freecount) ||
-		xfs_is_shutdown(pag->pag_mount));
+	if (!xfs_is_shutdown(pag->pag_mount)) {
+		bool	ok = true;
+
+		ok &= pag->pagi_freecount == be32_to_cpu(agi->agi_freecount);
+		ok &= pag->pagi_count == be32_to_cpu(agi->agi_count);
+
+		if (XFS_IS_CORRUPT(pag->pag_mount, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGI);
+			xfs_trans_brelse(tp, agibp);
+			xfs_force_shutdown(pag->pag_mount,
+					SHUTDOWN_CORRUPT_ONDISK);
+			return -EFSCORRUPTED;
+		}
+	}
+#endif /* DEBUG */
+
 	if (agibpp)
 		*agibpp = agibp;
 	else
-- 
2.53.0

