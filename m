Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13347526AA5;
	Thu,  1 Oct 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866494; cv=fail; b=o+39+aC2ACHAweWVvZaM71djJv7cIK3c1PFtCt2HtkncJi8KTxK0X030EZrzudyQ7fz6U1GwY4jT0oAuELQF2ojFtFD9n18zvg3MfsXuk2veR6EZXam0Ea9/tfUnYInVlU1mgnrcd+2RJDkQtyArb1Zbcfr5/NSRu4xY+3eSUXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866494; c=relaxed/simple;
	bh=pbFMtB64KobQEbYWZAKhMrE0JtJy9tdk7tFScpXSDpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=peVFaUCWYIIhBISbw+4CSRtKnBDAYdoDRsNuuYh1XYbs14iNQE+cVVhTVldxZCXXSeLoCMtUtbUzmEifymvyGQv+X00iwTXuFtpSfyEerx+vPLSI1AjqjASTfEZ/rBWfrXFpSCglcuUC/dhwFrgX0ia3Gw7Sc6z+qLdEPEcUOJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ShXeKebZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hAU5Ck9w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ShXeKebZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hAU5Ck9w"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMW88624303;
	Thu, 1 Oct 2026 14:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sLuPoJojYXcLLNbDS/YDBRuyCf46kxo28+6Rmjasoa4=; b=
	ShXeKebZNDxu7FdEr1ut2emLAeF0VIK4crjjbzMxfPIZ/sJtYwDKK1ZQhH167yAq
	lAHldtnzNyT7pcYcR5xKOgAfEVbDlf43I0o5csZyIQrEk7wiBIw1eu7GIH2p2M+2
	FIYHULiBGruehu+N9NwZY4dd1KEpCDySx7CgyA7xoZEv7Xs64a01IzYTeZdLCXra
	Sw286N9qv7g1GL8/KxXHpqOuutQto1cnzi9+DIex+5DTTIYmABnZ8fjc2y6wB5KZ
	zRZuJz1NAMDv25FLJIXovkvceapj/m/HLXpTKBfh9UcBmbVApK1zTjx1ojYvclhd
	Kr1qvnbvaFlV8RuHaAd5mw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns109u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:54:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpYw017265;
	Thu, 1 Oct 2026 14:54:46 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey2tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:54:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcFPQrYPz6jkdD8RMTPy7Q6552qJdkdeAnTPJHTBopV7ko8hcGNl/+2eFnOG9T0AqQehjLNlS0yj06Aw5ryhyr1XfaBTRPoeRyGVWy2lFjPFdjE2kahbu+/w1UgGPWhKr8hfqkjHVUfyIIpvMyMoRTv4UPk1l359/BUFIqubu7ajaXmYJFCW9PNOvES3zuzp2A6uhYLglpPZ7KaaVYga4WYpiANXdC/s2alS7V8UwsMZEcpkQy6FGdbdRpYdQVkN0aNntu3I5jJrYq5iZcZVZte1m/ZJ/v/79Y7rOlwWWdjk0lMtWcx80sG6Lz5ffChHf66lq2N8aZOxVJ2yIqncjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLuPoJojYXcLLNbDS/YDBRuyCf46kxo28+6Rmjasoa4=;
 b=VVtkLPdwnUJiI6b3XkoyiLCz/mSSc1zhqzlQeWGQ/kdXDTBrbzlTnDqkoUtGlK+Bg+pAy7YHXk3/MqUZe8NuchhECH7054NTtDqtW6Z6fXmsOjWu5z9nFDPcndt78DvmLHadRypXTsDoUZRm/gGVd5+cVvRwZfzzKIbTPUpXr6feSSZBFjhv0GthwayFLR/3ylHr9jS7upg0tlB+eAyzzOFM6GycI+q1ovhVfhsCOExBJtXFbrtpuoRSdLBOxaEqY6B2zA5/fbPIA3VGg45mg7PpXQxJtFt80qNqCSIfaFIWeiJd+g76Gm4qQyR0er2yGWiQ5KqamkMtjGc6u7qcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLuPoJojYXcLLNbDS/YDBRuyCf46kxo28+6Rmjasoa4=;
 b=hAU5Ck9wUXfe4Z5fE68tkqFEBsMW4JcmXtPPJLbtqakDCz4vevqrNISvnW8hqLz4p2A33bnFe9ru2oDtGFxGojfgh5Heyv6wrUpKG+kAVrrduVNLx4uKDPe97GDPXC+sKZlgC0m6Q0rsFVc/yT2HXqLJJDxlAVX0LpoepzxHhVA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:54:40 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:54:40 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 11/11] xfs: fix unmount hang with unflushable inodes stuck in the AIL
Date: Thu,  1 Oct 2026 20:21:26 +0530
Message-ID: <4ade20822d804bf7ea8ca1ea2943a1c1a07ede1a.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 0850ba6d-255b-4874-10b1-08df1fcbebd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|23010399003|22082099003|18002099003|6133799003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	lIDtxRzENvpXCnq+GWrXQHpg+5+o0r/NHy/cMcxY7/iOIaRoyKmWx3OQbObWZPgGr9/RbUN0otouHm2RTxet2IPWkjKN5yvtOD5iWZLeyW5A3VD+SjIgqSIwGLepyy3pxd66wApU4PEfo9LMnqzMvE8C1DoWKoxmPx9MrP7j8B/G8ENlE2076nRGaOZOssV/F5pEn/Is8g50UcWPLzJswEUohZZ8Wggi9Q5e3Q58RQLqGLzJU0DePASv+a9gSwAukgSRie/bJGW6SqLiHx9l3noXJDYhTkg0EgTjkOLftOF/SUE47SU0xP5x/OeI/ZRghS1Nt4DkfpZHFmCXBrSfMHcm9C5xrHXrSmOajXVDjDXw62nmI+MJxHQDH0DHsvN780GdkiO1ZDV632ELxjFbQpYL6fqN5wmIaAZ9HWbc/L/nRfFuuZUNo2kEeKOIgOA0jZEkb7CXH58lxlUWusr7k6Spn+vSx2jyG8Q9UDrx1l9B5EQcNbnq8pbbrFqRcHgxXoGyAziDh745Ks6SBFrsC0PGlFHrZ8q9OdiDNCBY/bjpipBbYLdpsdsn8G2L3ByACxqeWDV3dRTOqmA4i40nscLRizQGakn4qsCFf+uH0e41AHSvsjYBRGQyjhtOCl3eF0WzJRse0M52y56u9Ye0g5m/0TcKSGmyISt5XTDpzhc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Y/H0PUNctEimlzGlMW6wBZKo09rpACJZOsFU3Ky20md9BN5H7AZYuBez3Ec?=
 =?us-ascii?Q?u5ctmUkXuMxmDpQNVNI4wz4z0whhxU25Y5ZxWqS+R1LV75eYX8yFUGxJ+z9I?=
 =?us-ascii?Q?PVyz2RE/T2AsmeC2UD5/wK15WUaWB286RGbvBs8JHKIcAM8JUhnAirvEiQKI?=
 =?us-ascii?Q?BkuTjONwuleZb50Wy9tL3GvwRcuWqKCOAvdt/Rm2ZSE68oJ3mnJ4+ByrO2iK?=
 =?us-ascii?Q?ny4gxvbSrlbU8Kab4MLrF4l2V1OIJ0XXMBK89Yq9CP/o94xBbiaSiwAXKJG6?=
 =?us-ascii?Q?WWay4Cntg2Yzd0w0lZfdKULrl1pm1ouQ86rPYD6O/nWJu6J4fyA39/S/tJKS?=
 =?us-ascii?Q?W4RJZAyimY7yaYu/KrRd2LLdOUnaA44ihOUoBaJ4UGeImgLE2R7MrAOZ/NEF?=
 =?us-ascii?Q?LuPf+nx6WZQpr80n/rfgHs7lzSzLkoODe982Gtr4tc+Y/nGNO5P7XdKgB2l8?=
 =?us-ascii?Q?ZHKdYksC91/9Kqk4OjGPEjUp9nqTGbOB9Sq4n9lZ9l83s9i0Ua6++LwYSBte?=
 =?us-ascii?Q?boZ8oxODzOSbOVXYv3TVUDAtDwGeSHbWmmRs8UqWNlvykhTMkSsRQ1cT7bS0?=
 =?us-ascii?Q?V2XHYY+MqyGVTRkfYLg72DaKr++/0Y36tqjVb31o/tKV4lNoKFg4nbYCs1f2?=
 =?us-ascii?Q?pFz3pTvRnmSOO2iLO0vjtuElyi+9+P+rc96MSWMLbaRTU8Kn20w0thxmmcDv?=
 =?us-ascii?Q?PiV6Sjdc3AxGd/GTMFwpFqM1EJfEhIZAKDS6UHxKavqwP1E4Pqfy2KL78jdm?=
 =?us-ascii?Q?1E4KT/8Fqirh9oUfQ8l3nd6KmsrxxmtFKDdaNqo50PFu0Y+e7Q9xZNGoqvG6?=
 =?us-ascii?Q?MtKdcjHMSed254GZtLmtf5Ild4iutiZQlcT1sgj7DxeW34+xXUdvoRUC3f0r?=
 =?us-ascii?Q?4Da0nsPU3bCO3SsINC4ui5dtrPvNrElhXeK3s+u8C5EKbmtAVEd/j9pIK7pE?=
 =?us-ascii?Q?Z/ZZD0vZTQbckyp1cgfOlR0ff5YqmA8RtlbhIu9Ci9wzfpqqIvSssc8IPzh7?=
 =?us-ascii?Q?Q+g4i+NT6UQFwPWEBr28meBhTLWlXyUy3L7/uzkhr02qYFwNqUj4Z1Q+QOP5?=
 =?us-ascii?Q?MS9eDayUUUR+1PD6JBGT5zEx/7wVDKZ1n6LzfDsE2K2JflfLXvU6IGZ8vBER?=
 =?us-ascii?Q?K17vctS7SLKjU55aMc6/HUF5kS0cuwVMngFO8S0pm1r5vzkSbN/zc5+AreGr?=
 =?us-ascii?Q?+mSV8B13vcHpeMeJYnqEVwqNSWFpP+Oexf3BW8mHU9ct8vrZet3reIW4+dVS?=
 =?us-ascii?Q?4ZS/mSuqCy535XUhYgf4SUMRipdhvTy45xSPlrVMRgO74blAmEGo9RJH19HS?=
 =?us-ascii?Q?AjfQkIksB9UP5FSYjhJ4cAmKbBUrA5q8IJ5KdaASHEaKjeUk86XuBN86mU3v?=
 =?us-ascii?Q?VgiyBgvVin6H1lSfAWpAYtfxOOBAfDPSubycXikwhFCwoEgsqY24abnZbdMF?=
 =?us-ascii?Q?JZsBuy1aevGVaaJd6AVFHXynueX6cq+MqJLXnYPJiR/DeFVJHvB/Cq0jn9IA?=
 =?us-ascii?Q?n9csSlqSTSm1eaKXlpFHWFKYGu+dtCuiMVC9H77qplvpIS7wRrrwE++YGJGc?=
 =?us-ascii?Q?vG8/ih0zcQSHuErVzD2lQgfC7Sn89AuyBl+cYPRb4Jt8hLZMSUOl2Wd+HANb?=
 =?us-ascii?Q?kXLpP0bBpvXXpfAuWRAUiPrs147l5SaSFYI76TJqHoxHlvLZyHzJNSnibYVX?=
 =?us-ascii?Q?U1hZK3sLz6xPWJ2UPBQGIkjio8SJQyzR9k4F6d1Tc9F9AkHZKRQW5nEeQS+Z?=
 =?us-ascii?Q?yxA/vEJzWu+Q8/vR9vca9lmolz4vCfBxvEuxrpiSSJDIaICImayF+OU/Ezi2?=
X-MS-Exchange-AntiSpam-MessageData-1: +BEzPh3ryjef9Hjq3Dmy1cdIYcnl0zKoJRM=
X-Exchange-RoutingPolicyChecked:
	YKsr1KacuhlRx0yFQXwDyQsLg2tT2Jwp0bEPfR0XlewQGG0vNNAoKdLgLD0fH1mVTJx5JVS/cqwUQU0jXs7czaXA00z9XDircBzXaEKG3LIFR6c6vFaloLAKQ7xVHeXx8M3hQZP+zzLXYiHjkXP30/VR27rkBVwyCYiqTKFR5PAtEaoYJCqYKOZbNAF5LyYiLAVFC+0UPUFs87udprXLjeOnbMbzEhLhQK+BoJkipc0Ia8CbPzja7YEzsKaeFt5FeeJuEwjD2sIPjWpRK/7gpmge8+g9bdIinOzH7nbVPfwqL0SbuYIW9B14Y9d4+3vRw2GPkNbjYbXOjn1calffmQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G+BFxe1UvcM1Ifwm8dPw/bnOtz0TDDnjyf8i21pvgIvYcE5njPfkqHiRojQWHMZ9/p3sr2dyc5fFg8uH5lRNzJkwAAUwZDWZxWrPFdAVdO7sI+mAjTAWMTL9Xmcv/g+8gpATKLrY9A8XvSX9IygrzmaPqEbsgpkL9ZPNnOn1xUvpjEI10PiiUfA297sDrwe93pTXInAAD8ZoQ32/J05vRqkhfs+H4KeRW7wXn7OiEqsNvl8rUKloYq+MygvPUEiuLG364z2RdCAOTgB8yTPPf9llp598q6ie064p0mrHGbUji6UWEHaCiaeH2iWWAP+zj5mFwYwFczs00Or4R1bvN039VYhccyaDhGBRi80Q4ONNP3+XybBLv6eOIxrSSfue4OozVKTz+xCkQSeh54exDIKfbgIly4MdTUZ43ILXuL5nusK7kAMkjnDsz7QDuqWdAShhmcUOjLRWmbsxsq58YgkR/lszp3m/8lYpANN02mnUxIYlc+tc6w9qrzv3qxiuSalTLVm1dv/UTHo3N/2AxxZw5wy+kCxr1NXWjuMLU6m+ARbZPWE74EkMqeOtUUzSsDVxqDYpry5nVBg+b1+wf146AM74HXUAvmbHca18ZSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0850ba6d-255b-4874-10b1-08df1fcbebd0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:54:40.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tjioDija2OhssxCV0Opd4VPjfyqrF0h8DHHVuTLjhx8YGE33sWSDzVIKoHsc9l5zMTiyNvm/nywnppMMeNtAf4wx7n6dwSoPp3bp1komT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1cYhu+Vg5tJ1
 E1Mckg4zUfT7GpOfA7i4PYGAMWYPDr7mXs/IBthceuV3KRrFWZGXZZCECPklOlydhf6yeJ/HSRZ
 H+F1wc2F53zhKY1x+HK2z3xHEztUX23+kdFJZMUugWnfFBrn8LzTU9qloCZBCk+8mVhqVuqxMmi
 3BIz5fRtnrI5AjgW2E0z4ip5qHw0UpIhdrCOHxMuydyLYrlbxVJv6powBhzzyQVtuJqNtc4eBdW
 kVzuaYvvmCOuGcO7oEkjsJ2bmmkekcPTTt9a5mvnzKbdIqnbj8pvXbDE+5DCqlvu87uM100iuIh
 EBMM6MPAs4GTTQdKLnJTH5QwsK+bzfNE7ZI/bnJckSe/lYeQcvWiTfDZ9ZXtpwYed80AorXqIkY
 QP3PrrnUg+/Lhlgq84hTIIAH6HOmKFZthxXKoBsT8M5pWmJwn6V+UTCdvx07gpou2EzQXddJvCy
 4FYc6NWNiqxgkKxEG7Q==
X-Proofpoint-GUID: ic9rrpIsTfxLo5wsfGWbxEWDdig-PW-r
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe7437 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=kGPDooFuvBrjL3bSUbYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX8JkUjwSOa4ZT
 o5JL9manv5+QQXhDCJWMYlA/XlNcKuDSica+mGBUQGVREFse3w3QYsqQO1sE9bUhuwCgt1uRnDi
 VtZsdMrJEHjUGM4cl9MRZhjfHmHVf1zcXCrSXtUNqeYNjVmwM40x
X-Proofpoint-ORIG-GUID: ic9rrpIsTfxLo5wsfGWbxEWDdig-PW-r

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
index cc667d4e173d..fde02c3a228c 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -706,43 +706,42 @@ xfs_buf_item_push(
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
@@ -763,6 +762,15 @@ xfs_buf_item_put(
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
@@ -770,18 +778,19 @@ xfs_buf_item_release(
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
@@ -797,16 +806,56 @@ xfs_buf_item_release(
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
index e3ccbf3ca801..c39202c0135a 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -51,7 +51,7 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-bool	xfs_buf_item_put(struct xfs_buf_log_item *);
+void	xfs_buf_item_put(struct xfs_buf_log_item *bip);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
 void	xfs_buf_inode_iodone(struct xfs_buf *);
-- 
2.53.0

