Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C2527592;
	Thu,  1 Oct 2026 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866482; cv=fail; b=qvawhp2PUyaUF5z+T70pmQqMSaIlwrzOgd2amnqL7P1sqvM4n+Y5dvxUc37ijDu1vJtXUK3decU/jDI4OpTQCEPcvw7PnQPf7IooPsHeDLLJ6wYoNiRwZI0aT6v7c0nPLNJS3jOCUSxWSVCNufj/zixsFSg2IAQ1P6ZT2e8rQgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866482; c=relaxed/simple;
	bh=29swZixfftRJostdosDsXpVS9RhmuYhEU6ZqjEr1NJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCx9hQdgR+aTrhuhLyX42F/AMHUrRgJcK2Lxt9zlZ7Ht3iYa7XqGQNQuzr/ogno/4mE1HwBRGmjnBWcuBTDbA7sw9Ja7qD5hrseTrrlaV7iu/aE+8U1jja3r932BGFh2/MVZqcfnRShz/xB4ObxXv7QhLWBHonnCRmvPvaTySqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fZFO0Fy1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R+6BMIlz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fZFO0Fy1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R+6BMIlz"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMoix2257015;
	Thu, 1 Oct 2026 14:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SBO3RBFf5TaUeQpd6PAI07JjhiUsuapRMSIY4ZmIT+U=; b=
	fZFO0Fy1yyzQwQLDnrysQnq0IZu97Jbz4QPc6c/rR04soGiv2alxJPcrcXYvt0YF
	ZJKr4pTz1MSDado8PEWewGgCfe8oYMLN0F5XDKdPXcEs4IgCS7AahVoZRdmKc7Ek
	NRgVoYQEidd0dYEKozyGMwN07ndxu+mbuGfoVdgcQ2O1dx1GC9wcUCQRKE8XoxYb
	H3DppIgK4ru885BB3VtYPxDDe5BlE0MfO8r8FXQm79rYKQemhWFZPYw2UjAab5Xc
	ZfmIYdEMzfTyJPyaDBGuA9k9wlPCpUIwiIOaGTecUalgYXPfpS+JrGq+ds6azSXo
	Aj5meX7d7iIPEfNbFsgfAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:54:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo7GN011900;
	Thu, 1 Oct 2026 14:54:35 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxuvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:54:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mehpH48rnY6IiBXg6OTHYy+UQEEfJmVlPkCrp2+TPc6BAXHooAkHqHbfn5niSN+Htw73xh9pB8LlBLj7YkXyJm2yy5LKVsgd5/7gUp392r4GV80DIrIjCxD0WDMlmWGVWWuumxbzCWBr7nYZE4EYXeTbgFLpc4h6KrcYkvv9blLBU/5AQs6GLWg+hzcrFd6Y30vXnaA1R7kgwHT8Az+YMSAeZZRBDkTegx6j9oU7CH8/fqqtmz43Mr+WnoBMRDJYigsXJvjReqm6iCnZUAAx6/vvnllIOhp6USZMFSLDk+r5AiQy3jswVwuVY0BJ5xPiBK2qfcUA0qGebrGLPJUrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBO3RBFf5TaUeQpd6PAI07JjhiUsuapRMSIY4ZmIT+U=;
 b=ZESWTuLuKMXfD1aD5Rro0ltS5IWwcQaI3cp6kH/QrcqxYyRJ/lQRoUWX7FgGijK1osQQkXewy0thcGsDv8UWfFZcxNRyS2WrV3hm4Hr40Uf0caZNKICdrEqoY/ICtQaADUp41HQB9vVhrDnG83bvqE0VVUpD3vBNfxOcsRkMTAoye9Z96lpph60eo6sY+14I3AtxNGaBeJUFZ2xTD79gHLmiOrEuJiKJgsIi0bMThRP3pjLYVcgMC/zAwLuyhF3HNumVTbl/Ju6QHb/fLVkY74qt9HFPlD3Ll9Jg18gFRyW8daDWtebs2VHuoFDXza3RWAmNTgwR6DYvJRKvTx0f5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBO3RBFf5TaUeQpd6PAI07JjhiUsuapRMSIY4ZmIT+U=;
 b=R+6BMIlzXmOBwtJtPWV4M0MXrSvyENS8XQ+gHRu3pVZW8XV52JRfMqNeoUyEhY6MlM+2vRu/+rjdfSLwMiy8jZ9c9iws+snlwxB9Sht0CCxYD/WGEcU17b+bKmKi1o1vSLDtoPrcJnNaY76fHUbQoYCm3gioZUemYxz7H6OvKnk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:54:31 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:54:31 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 09/11] xfs: rearrange code in xfs_buf_item.c
Date: Thu,  1 Oct 2026 20:21:24 +0530
Message-ID: <d2c868cfa7750e23665d7e2fe1b341caf33713f6.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25f::15) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 34551841-4102-4555-0513-08df1fcbe61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|23010399003|22082099003|18002099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lLzbN0t/YSvKNK001ZzMRT+a4tREq/lUAtHbxVe2Lh6HfKCh1qczFYqXIicIuxiraGi08gKaj52j5+EYJ2qgvcaci7iBqvulM1f4I1grM3i5x+Obr8WS981Jqxl2BrOaDu5NYzbMMFeUfxQIWvL56N1jYLknrVZdyfrZQZwO0IsF57Pg9ArfhHAodZC09dL96zxEkwRXYCpdMwVG14mSFkyYhzZJVrv/VHXMzxatdNgdTdzdbRJrV1kLMJ6oWyjOnanOa9lvYoGFT0xMKrygrYj3cIkcoZi8DNQsh4dv6Rc1NoBoppdqP2yHyJCtTbkxrPft/FblSn4DwNnOFIr6PgtwQAl39HeB3OY75oTVbEsUUVpFvHq4Cs66AbCmVptIjNMiRBI8u/1T8spr1YtruNBS3L9OeS+0PBPNcticpQ3Ym/q2F9n2TDM2GDuI7XjDS3Z7WI6PQr3CUv86UVIsGgJO4XTeUQUSJEpKUJjNVSJ3+tjFTAjZKyu5ApPQ/1v7e+e8EFDTLR0wKJ67FE9CfEk6x638gvdpOa0B00/EQ94vxpPij06FMYEg7Ywrk7zbdX/x2Uzo3XBtn5kHsffRPkA6zJbVocXVBZZBxb1Jjb0whN2XMTrduZXBG4MZXMyFVsWN7VZHwvpD4QjDlO+Z/uCEVdpfbh5Me9aswGdrOdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CcSGdA9QzK6TSWomFJvyZljtKpSwFCqf4eA480rUm3KuB9VXjUSI1EYMQVQW?=
 =?us-ascii?Q?uXVHi/+aWJGINzQusY7uaywFrH2pwM64cR71mWbrniyZzEBvIFcIXIx6qmjZ?=
 =?us-ascii?Q?F1ZmyGOcKfEJFw6my349O/Jp+z4eSwHzj5BzAhvAYjJiFxRyVBP1yHaUM8XY?=
 =?us-ascii?Q?p+XmYmeVWDc+sNMw+xnwVZ/Zzu4WLH7+5u9qYSIMcihrzT7smifaYjpZYk+n?=
 =?us-ascii?Q?BZQ7F08oXY/M8T1Wm5HU2D+uC1dCaCBQ2QRezmJJXOFFYaG57IgQ/easQOD9?=
 =?us-ascii?Q?ouBHcU1e8AZGvuA7KhuBSxDlZBZUymMk6nvBks7NZ9esdq//uGUAUlGHu+at?=
 =?us-ascii?Q?+QNBLSe9eshxEdJuQM9CJk6wn/SMx3dexgFIpvk4IDIclOIhA3sk0tRJ73i5?=
 =?us-ascii?Q?PT4mc9jdjARi15ceVCbvU+WrBu4YNCahWg0loyAWJCJDR1676WAu1Sjq5J4m?=
 =?us-ascii?Q?QPSVGoFDyRSAbT09+mk5nPzF67ZnQIYTke6YPQSaz7tenrpmtP66WgV05yfx?=
 =?us-ascii?Q?v7qQZM7gIc6J1hx2w+bkL38PnlCsbk4gP58TNdIUkLdJg+OwWtAclWSjSURO?=
 =?us-ascii?Q?COPoTI85lgv7coHgQU9hb89b3xHA9MzIUo6Whm522EcZanr5KBYzoOc5PnKU?=
 =?us-ascii?Q?Hd75PuMCtBBNUHFhqxXeoO68BGRoQp9V41CuswvdxZxz4LczZlzLGuhvGcca?=
 =?us-ascii?Q?V/jxNwgcDxWjOKCO5ml0C8dNniXSYJPMm5kFKrdMXEvN7otmLdPZyENTptw2?=
 =?us-ascii?Q?fl4CusCArSvs6IONQ4vx4XsA5bvxjbuGrLE+gebeRn/RiSLf5Pu0CRn8nmrY?=
 =?us-ascii?Q?Mx0hmtASRIQDN+Y23V0SBhZf+NdvJhEWH48YNOAgCm0ESa2sfs4k8/2fga6S?=
 =?us-ascii?Q?MqL3T59OOzXDuQuoAZUJAOBsvTGqJ2Cjoo6QLtDjNlB1SZJhxENMfc1PN2EE?=
 =?us-ascii?Q?qEdBtcyNyWhwaG6AJvAmOwgNYjZUmeyb2rlCcgCfq/h0lG+krc+qhnNK5CkT?=
 =?us-ascii?Q?HrUACXQ/Y0sMC0oq06lmrGGvf12AgN7XW9bz8dxvHOkY67ydBZCTyZASIO0Q?=
 =?us-ascii?Q?T7mfyigg2d6osFV5rFrATERE+Oozawm5IeW9lzFSfXlez2XHUeTdqXNhutrM?=
 =?us-ascii?Q?TbRa5PbrKnS2mQeXY3LEyTtdVMjaTEnhzRJaHzD4pwSOjr4hyFShRvkAozeN?=
 =?us-ascii?Q?2j6DXAaHlHThpPgPQ6so8ucjoCosPRmGhSMA0W5KYg0dG3iI6NV15qkgKF75?=
 =?us-ascii?Q?MX1Hy7tq4sVgpwx5ncp2S4WDdTYBjLooU7K0OoXcINMXeKKAjMbGygJ4ECVR?=
 =?us-ascii?Q?JtG0aAp2a6Zot7wTtLrENjpL7LUWc59978+3YmfaPvQJTBzHcBwIkONuPvlq?=
 =?us-ascii?Q?GrG35itFmP4w2ARuqzJVWWZ/t3cKoZ6j4IDqKhrVjWcCjunYwYN4tK6ZZ+Ht?=
 =?us-ascii?Q?RcCjHISIaMw54zNJO288/NleW6qJxMDjiQnP/MoeInwzEBIZdOfIOcHXEDNT?=
 =?us-ascii?Q?1La5mEoI2g3YOeBN2Npg873EZDQw/dH+aANasKcbs+U3C7QrslCHQ//3vHCr?=
 =?us-ascii?Q?XNa9YcQArmLTHZErw7jwaVLz9jJuyqKVzL+S+JU3XYP5TBvH5xutgEHO77RH?=
 =?us-ascii?Q?OsBJB5Qxq+h1z+IDXbcAyBNv++ZXciIEuTfrCCACifl61aSuGXhXCHFDEdYZ?=
 =?us-ascii?Q?skm9IEUG2YxNk123ACwdwky+JPUg7uk2qCr1ZzH9f1XX6/gAd1vM+QWWMiIp?=
 =?us-ascii?Q?rhcERrrKSuzwGpXULHoMmcZOfiBv73WZ813tc6nD0u7T0gj99ZclsUU4va1f?=
X-MS-Exchange-AntiSpam-MessageData-1: nFHDzqDXp25vvdXvr2S0uN32iSyrwNrEriY=
X-Exchange-RoutingPolicyChecked:
	BKQDg8edFnNXPDJFB0iW1SPDNpsLNfun/TBR9Z25B+XFgfoVwqafJwA61BVpg/RGwjEmW99CWjgR3vWwbQdqKh79+m8dEprNuQXkRqn9qOto9TrNxVakIpiTASfaZs09brNF4K9zPn62SVIE3vbuuqQjxjvwWN/k5zQnU1/9BcEaZa3V5u/0ddeNjsOkdZT/kwjrN1xpWdiCouapCi5kk7yqqd24HXhxOJOfeOe8Yil2469d/hlIBuY+Hu7XZF1HYctLT9TSpZF3seiDNHg8EH5lS8p7HygtAgfaZ3Gswn+wLj6odmZuiHcsJdsVhr57+NaiFBM3teIFWZL0kz2WJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w+bbqsvKCcMqM+HDxluBuuooVONAIlIvzPUCbo/bD2eYquFpbIf9yZMVnkJQFTjyfJVTrVTMg3en6K41qdp9iEgU3K8hWp+1iOEgBVrV+373i00BHXCBvOeIfMUolpOfHHesEZw6EgMnaajKp97suQdl7nQP8/rDLFg6VE0jDnHNdDQo055b2rkWADvOlutUdeC9Jf8qz7HIL1gtu/DtKTZ9DbFwIdc3dlJDvMo+YW666O2oSfmwq06vvECNBQsiOOS3262vEKxcPhgV2I+HQydrpTCxZHGB8s96pkWMdRRqlw5M8kJE94asnI2pxCUXy6ThU692vdPJcLqGJBYeMx+wTQpVwVr2QlW/CE4WO+CIGUTpD4hWcPxruemXji3OBXZlDvAiUyYDvS0c9xr2gF55qrL81nio+eN1FEdKoYm2Qnghgaa+cx7t/fceNjem/8Pr5OnqD5/aSD4UhB8dDlQaVQXcVi45pNKTgpAbiiFhLfw0HAzLbgh3y+wZoA23TQ315ycuuuk3zIMtBUeJvlx3VgQ4gNxIC0W34FVaQVMT9B4b5LMYVbt4gfT9GBcpvBm/VbCpPvvyyCtM8dN7aeoyxboWasxmoJU3IPQAjjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34551841-4102-4555-0513-08df1fcbe61e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:54:31.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3YNOGpodGjPSQtofupdCOfV46OIQ+h/+ToiWv1ahCNY+0EN/za0vccP71P7w3qXVE68eQyQQ84EH61lzTG4a+z1onPnOgqkLIPGQ0II7o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX5evP52H0kQP3
 iUqNpSWlo/h5oSZdc8PN5KOCPHEa2nyx0ggQo9C0Gx50rraXiOenfw1s7bf8lX4FU28kyxQmJws
 IecKQE88C2M+CcNWnXGJlGAdgytyrsKeW2dIZAVI+qTVyG8H0RCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX/8p0ksSycD9O
 bYB5zvKGw1EuwT0/eoi/NMDQJy3eMR7oQKksoGbTK4U/+y2kS2IJi6r3lT7alHC9vmSKU1y0+aw
 cSYPK2acdEzscANa59zsm6mBS8gh19a8beZ6ORMg5bgJvLCrJM+EDyLBHIvwZ2rM+/ib9nQ0nZ2
 TtWQQ6dmmERm4GkXi2IcDHLb4OhQKt/+c1jg7VZ2YTPA6J1PVRvFDcDYe7pTWcNnKdXlJvWp9l5
 MrvlyuF9966cxmM07A1dLAe8M+BvObL0i/XcrqejmKo9J8pJ7O9zKYJf4nFKOmBaaXB/+VZqJH/
 XR6tPcNNOdWdvZVUJw0CGxpiZGgEdWkp1+LsYNDpC2cXX7CEo+S1M0kwm6RcwBaM+TvG6sBHvXI
 NPPgbIWm/uLK8+xdKkKmodYYQlTXpoj/PtDpKKAdyYLazFWni+hPJcBLg5+dptZmfEE5m4SRJ6U
 WtDKJaHbawc6wp0guxg==
X-Proofpoint-ORIG-GUID: ZUm3VRYufyk5ktMatGvG8aiMIQkTP4x5
X-Proofpoint-GUID: ZUm3VRYufyk5ktMatGvG8aiMIQkTP4x5
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe742c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9 a=WmVTiCyuxqgg3mnwYu6p:22

From: Dave Chinner <dchinner@redhat.com>

The code to initialise, release and free items is all the way down
the bottom of the file. Upcoming fixes need to these functions
earlier in the file, so move them to the top.

There is one code change in this move - the parameter to
xfs_buf_item_relse() is changed from the xfs_buf to the
xfs_buf_log_item - the thing that the function is releasing.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d2fe5c4c8d25999862d615f616aea7befdd62799)

6.6:

Fixed conflict due to the following missing commits:
	[Continuous range: 10634530f7ba^..d4c75a1b40cd]
	d4c75a1b40cd ("xfs: convert remaining kmem_free() to kfree()")
	49292576136f ("xfs: convert kmem_free() for kvmalloc users to kvfree()")
	afdc115559c5 ("xfs: move kmem_to_page()")
	f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
	10634530f7ba ("xfs: convert kmem_zalloc() to kzalloc()")

5.15:

Fixed conflict due to the following missing commit:
	182696fb021f ("xfs: rename _zone variables to _cache")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 116 +++++++++++++++++++++---------------------
 fs/xfs/xfs_buf_item.h |   1 -
 2 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index e0c75aa3cca8..1c8e7f99d8b6 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -31,6 +31,61 @@ static inline struct xfs_buf_log_item *BUF_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_buf_log_item, bli_item);
 }
 
+static void
+xfs_buf_item_get_format(
+	struct xfs_buf_log_item	*bip,
+	int			count)
+{
+	ASSERT(bip->bli_formats == NULL);
+	bip->bli_format_count = count;
+
+	if (count == 1) {
+		bip->bli_formats = &bip->__bli_format;
+		return;
+	}
+
+	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
+				0);
+}
+
+static void
+xfs_buf_item_free_format(
+	struct xfs_buf_log_item	*bip)
+{
+	if (bip->bli_formats != &bip->__bli_format) {
+		kmem_free(bip->bli_formats);
+		bip->bli_formats = NULL;
+	}
+}
+
+static void
+xfs_buf_item_free(
+	struct xfs_buf_log_item	*bip)
+{
+	xfs_buf_item_free_format(bip);
+	kmem_free(bip->bli_item.li_lv_shadow);
+	kmem_cache_free(xfs_buf_item_zone, bip);
+}
+
+/*
+ * xfs_buf_item_relse() is called when the buf log item is no longer needed.
+ */
+static void
+xfs_buf_item_relse(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+
+	trace_xfs_buf_item_relse(bp, _RET_IP_);
+
+	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
+	ASSERT(atomic_read(&bip->bli_refcount) == 0);
+
+	bp->b_log_item = NULL;
+	xfs_buf_rele(bp);
+	xfs_buf_item_free(bip);
+}
+
 /* Is this log iovec plausibly large enough to contain the buffer log format? */
 bool
 xfs_buf_log_check_iovec(
@@ -562,7 +617,7 @@ xfs_buf_item_unpin(
 			ASSERT(list_empty(&bp->b_li_list));
 		} else {
 			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bp);
+			xfs_buf_item_relse(bip);
 			ASSERT(bp->b_log_item == NULL);
 		}
 		xfs_buf_relse(bp);
@@ -672,7 +727,7 @@ xfs_buf_item_put(
 	 */
 	if (aborted)
 		xfs_trans_ail_delete(lip, 0);
-	xfs_buf_item_relse(bip->bli_buf);
+	xfs_buf_item_relse(bip);
 	return true;
 }
 
@@ -792,33 +847,6 @@ static const struct xfs_item_ops xfs_buf_item_ops = {
 	.iop_push	= xfs_buf_item_push,
 };
 
-STATIC void
-xfs_buf_item_get_format(
-	struct xfs_buf_log_item	*bip,
-	int			count)
-{
-	ASSERT(bip->bli_formats == NULL);
-	bip->bli_format_count = count;
-
-	if (count == 1) {
-		bip->bli_formats = &bip->__bli_format;
-		return;
-	}
-
-	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
-				0);
-}
-
-STATIC void
-xfs_buf_item_free_format(
-	struct xfs_buf_log_item	*bip)
-{
-	if (bip->bli_formats != &bip->__bli_format) {
-		kmem_free(bip->bli_formats);
-		bip->bli_formats = NULL;
-	}
-}
-
 /*
  * Allocate a new buf log item to go with the given buffer.
  * Set the buffer's b_log_item field to point to the new
@@ -1040,34 +1068,6 @@ xfs_buf_item_dirty_format(
 	return false;
 }
 
-STATIC void
-xfs_buf_item_free(
-	struct xfs_buf_log_item	*bip)
-{
-	xfs_buf_item_free_format(bip);
-	kmem_free(bip->bli_item.li_lv_shadow);
-	kmem_cache_free(xfs_buf_item_zone, bip);
-}
-
-/*
- * xfs_buf_item_relse() is called when the buf log item is no longer needed.
- */
-void
-xfs_buf_item_relse(
-	struct xfs_buf	*bp)
-{
-	struct xfs_buf_log_item	*bip = bp->b_log_item;
-
-	trace_xfs_buf_item_relse(bp, _RET_IP_);
-	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
-
-	if (atomic_read(&bip->bli_refcount))
-		return;
-	bp->b_log_item = NULL;
-	xfs_buf_rele(bp);
-	xfs_buf_item_free(bip);
-}
-
 void
 xfs_buf_item_done(
 	struct xfs_buf		*bp)
@@ -1087,5 +1087,5 @@ xfs_buf_item_done(
 	xfs_trans_ail_delete(&bp->b_log_item->bli_item,
 			     (bp->b_flags & _XBF_LOGRECOVERY) ? 0 :
 			     SHUTDOWN_CORRUPT_INCORE);
-	xfs_buf_item_relse(bp);
+	xfs_buf_item_relse(bp->b_log_item);
 }
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 50aa0f5ef959..e3ccbf3ca801 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -51,7 +51,6 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-void	xfs_buf_item_relse(struct xfs_buf *);
 bool	xfs_buf_item_put(struct xfs_buf_log_item *);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
-- 
2.53.0

