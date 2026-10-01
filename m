Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E452B1E3;
	Thu,  1 Oct 2026 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866590; cv=fail; b=jxh2sIip1fy8TQRw/xCF5FVtTqJoWWfWw5fjaz1/WSR5rAzOPYqunsDU/FYXBIVkNzPuNptfNxSqFBWAl6ShwcsnMIKAkyQGc5aXRwuhO3zElhlYp1c4QTOtLtWIHogSFAcuCPrhZmmieYQrbS0Yc1vKzj1tyN+etMMPaJEFYTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866590; c=relaxed/simple;
	bh=LN0nw2crQ+D8JJi/UCZnuHwipzxinx1cryPTyTg/cqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUFQoVV2qHQVnUPdaYt3SIXqYIn6cFPIn6b/goOeFbYACFaG8lozMeS2fvYoFFDqUk9XrCmqeinJNLcpB8VmI4CRdiNeNS8aM8vUo/MWiUKhn96hx7KghumfWO550PzV0n2W2SDRRnxC6jGBEXDdxwekCCoCXDhlaUsXV/yzDsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nGVmxXoq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hYIj/5cJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nGVmxXoq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hYIj/5cJ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMZuT3077797;
	Thu, 1 Oct 2026 14:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wPEH2IB6gT8FiPRiKZaECPdNBDpkGj4idebrfQC+K6o=; b=
	nGVmxXoqqKeCC0Uc1eB/mu3P+8rcvDqT3w18mgP/169ogAqdUGTlyidu2OysM1aa
	HFfqfQZpvsgkOHg1aoFbhqQu6pNTe7rCANiGmQgp/c6V5SkttI+ZyX2eDJQ9wp41
	Wx0Fco0/J6FElk4Z12uNUtZt4d0fmeMbp9FI2wu0e+iUpU3X9EGTWd9d4w9td6bi
	3nXVtO0lxkhO/PKkwYOhSLorLnhtaXDNwd9+UGqOnkJ0SyUQx7lFK6omXlEHvxvs
	P3jNSPh22i/e7yJ6tkv88O9phehr6fxtb7hoRw9C+/1aDZWeeDJ0XwbC00N1nIML
	JtPMhBF0eYrOgrvugI7kTw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4myh8dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:56:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo9ml012040;
	Thu, 1 Oct 2026 14:56:18 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxx5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:56:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ettnwEbyWvWuFKRCGFAQrw0VZ6oCqYR5iFQkmBXNHwB6jXFbdzKIqB+ZIm0UoFk+IWWS1221dEi5wJRJxJpdhnqD3ybyixzR0UqJCdaKnvHRy0k0Ij42Rv/xqxauk0+1s5TSSn+sLbPbPy3Rpy5pt5KGrEv+H1h580Q+bUEOvwkcqZyNgIuyDntAkffdvi8cZjg77kK3/QHvE9w5XZ3F1gkNcp37q8bohl1V9iLmISQ6C8aVBJ+q8gQ2wWn2VPx1uuewTc+8TfkwjplpGo8V5ulRKwlDsYFrHuTFoC7z0ZwoET+xItNGzZF9u5wx7sOBRQeF9C0aMP1RTvs/bNUQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPEH2IB6gT8FiPRiKZaECPdNBDpkGj4idebrfQC+K6o=;
 b=TJqSu2zJQG5c9hVkWVz8oJzEXa3NWr6Wht1gkGewnIY1N1Q3Nngw2kObDU4559+/KmOCkLnCQhHzIJ3A2FK5gw3MjbicpxpPv7JIxrkZ+h4AXH+w0Zu4Yk8Y8Br92Z/McFKrxxNz/l1OPKRRnOR6j/BIGhenYCISAvwZNZrr49E01LysRX+E1oc0Xh+/Eu4trXqOQT3trpK4AFJtWJiNtZ60oqfGkHBTSN1x1ABEt6imvTI4cI7mmLDf2UnbrM5CALQAzj2QM1fWOUpOammXkP1KEz4IMs1MfL+dd4UJ/yPrN3z+8EtqbQCbX+EvbowVEq3MpSxhteNqj/MIvjuC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPEH2IB6gT8FiPRiKZaECPdNBDpkGj4idebrfQC+K6o=;
 b=hYIj/5cJZRl11gySByPlaw7TI5zuZ4Rh7LCyJ7fSgAdMT97Hv2JCQaeAHYsJSF7dt5dJbq71STzsi5ChRIv68RC6xtjhnUsj1/Zm06lEMvPqzdabMsCJo4PIgXu8QiCFB4PUo7JJhnn0gkjXjRsseCYS/OR/BlJ09YvMU5zuzj4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH0PR10MB4583.namprd10.prod.outlook.com (2603:10b6:510:43::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:56:13 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:56:12 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 20/21] xfs: factor out stale buffer item completion
Date: Thu,  1 Oct 2026 20:21:33 +0530
Message-ID: <6fe6606b2a72f5a3dff4e97f6974b6fe8249d614.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b7::11) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH0PR10MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 5585b16e-e103-4548-7ba5-08df1fcc223c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10070799003|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CwdghfpFnuNLeA/SzSIzbwgmKsDv8+dYIiiE7i1jjFNYspmeJ4bFItOAIMhvuA0XFm9vVZRbAeLmzkiUWd+rwj4yposf6lNghfB4PGX2a3tDmynbXyTAVASGjnHxfS4jwZA5W9H43swKDPq7UQFDM7ybHpLRVFK7hiWc8+BIC44aWN1stZWStKcvGb2aZRwk6jdpNpiswQN5D6n8fpTqG7bVxzwmFIe90UTNaz7HntL+lXymoHy8VMssN2jUs/vfLXdILHpodBYq4V4iQWgQHuh9obzRwYmfrrmaIDnQo/WfCLNcjcGrjBVVvmMQktKwUB5tbw29gCCUrFsXFtiVVPe2WPS2QQTCiHfXmL5+7ldOW8uJLmwynoaUvfoWztyvXrTCqlxTYaqq7LXzhrAY+DfR8cXrx94lErBuL6ncZr7aLrUfKPb3k0Zv0Ul3ka90k3XS//5+4dZO4ss4uHpmCz7wf9y6UNAOZdmkDZ7YWZ/bw2quMdx2bfnXQS7mlpjlfdshP7hxQO5dQ67WmlE/mb3lyq+MgECOqONb0ZCvCxenXHgvAaW63jfM9rwsMIOpQ0gQo4Mp1exQVwCv2u3YbQSyCZNXfzQYJE5iWGbU2PqiGBa+etI+1FyRm3AjRoNdnaJy0DSHDMv5mD9XUKTEQqteZzKgOrzHpMM5e5IwWCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MsNWhlso4JuTloVfwS0wnqx/Ra84ukMVGrn5GJ50RK/4IUjNxZ0VgekZopPG?=
 =?us-ascii?Q?pwFhmx5vjH6lPnEU2lWdwlCbaFJYwudbbhtESXp7bmfcVldNPMYMI7c0ms2h?=
 =?us-ascii?Q?f7RUGzNzq1t8Pr3RpwkOv+yjUettZfDKX7So+oPPZrz5Jwz+t9NC11dqWXD+?=
 =?us-ascii?Q?3t8pRQOPFhPtXU0H5AVPBwSy2kII+t0bdZuT5ydf/s305eDHrX+o+8uYARhs?=
 =?us-ascii?Q?LuXv1Wbb3GmzV/U87dpNERADhWGEeyRuq7zEhclPkjZJl3LCgidTM2fYxJC5?=
 =?us-ascii?Q?cOX0drdBSMDzVmWmyvI4MAQYlSzmWtZnL+PJvOjoZOwQdaHUmEhsLEl1AFLa?=
 =?us-ascii?Q?DZTwXW4wAfpg/LSSRGGeWxzKe+MosSOpbK1ytXALa6uJrdjCwiBNYGPVWdUk?=
 =?us-ascii?Q?EYDL8lHyxAZEPUuROwVqt8F18sXpR39QnWBkjv9dwLjKgpxQC0vujcBxDrxq?=
 =?us-ascii?Q?eiUZqM3ywDmwf2P4NFGVnRpmUjxrQeF5O8JMRUrcvka0NvcOOXyLOF5h7G6c?=
 =?us-ascii?Q?rMXe4R0olX5apwpKe5S08zC3Y/GlDqN1VGeKnPZvJOzPcS9a1D/8fongGMNV?=
 =?us-ascii?Q?TyP8JDSB5SkYgg2ndyeOHHOMC6ZISCVxidrPX2F63zjLSmy8Py/a3qvynEbB?=
 =?us-ascii?Q?SGFI7Djo99zsdKRQUSsyzOckvo1Oj/VWBvYZStxFjJqjaXNblq6s35LJI5ku?=
 =?us-ascii?Q?dOo4ESruz8l4rSG9BMRHubENH4RA0bPihXDrzE4xU90BsF7/w7ZqxSyIldM7?=
 =?us-ascii?Q?h8R0xG4j4UmUWsCEadSq1dY/oGaC4fnqsDd0jaPxH5UOwQzWduAwwpBrYMTa?=
 =?us-ascii?Q?XlilCyh+8qwguD++sl5O4+ofXY+vc8MWpjrAdsHFynbO8+diesqO2Df/CU3h?=
 =?us-ascii?Q?sDcl3N4t6+oOFCznfEq6SBb+FR7mxdfCm8Q3Or43aYo2qAjp14muVJy+M6Ya?=
 =?us-ascii?Q?N725hBXiJWa3ResHMsLvCPTj3cRc4rPmlwSz+GCyYrFy4wi8ZxXJ7hQauG7+?=
 =?us-ascii?Q?kERbYBAkyuNlic4l7Dpvgd8qLcx8bAUnV0PUBltuIXB3semJry9boAAQrEo3?=
 =?us-ascii?Q?5S7Es1wZyRS/YXaAkPPL1wSlHEjylSekp7V8MBX49nvyR+cXTw6IuSWraMay?=
 =?us-ascii?Q?AEKjsaLBhoxUnWmupYoLBWcinZ0i0BRiBFqB/06EDRMuPIufy/rK+hwdYXsa?=
 =?us-ascii?Q?toGTM8AtXQa3uyWKa7lC6gczjkP1eQJHwhQUXrYf8b71GYAp9rLl+YmaRYWA?=
 =?us-ascii?Q?1J/Q2UdJEcMdYWuXTlpu+O0RjDRIZtqXOrPGMRRVweTGcZiyzGiE943cHLSS?=
 =?us-ascii?Q?7WtGdeE5CSb3lINyYxPbkFAMoO//Vagc0S38wX0ATuCJasdePruEbwKdijaY?=
 =?us-ascii?Q?RHW2nEGXHzbDX8TH1nrU50D6OGH1Ddb/LSQ2pfvIEdrw9icOZ+wJfFrmbEYT?=
 =?us-ascii?Q?8VFp6JvHXpeloKYN82Hahd+8APa+qTMBKGKnRaoxfkZkXKxELaS6SfIjl5YR?=
 =?us-ascii?Q?iKhEjQ7secZW1NGcLDVqb/WqdQ5SCue6x3mAqwaMaX83IBqyBhVI4DByB8gD?=
 =?us-ascii?Q?uBXqJT79bowCdjSaZxrE2mGPlmbSwImvIT7HfBLd4LEkA3kycwHDUT3tquZE?=
 =?us-ascii?Q?1X1XZlAzlM7URzyyYlJae90wAkRVNidR7xNeFI+QBo74Ip6zHorJLwy4hoBi?=
 =?us-ascii?Q?ykS+3zifKwJShqrj9/MnHDSSuBnF7cEkt3Rnt+onrjOTR7T80KZs0WwNWlUj?=
 =?us-ascii?Q?2M/I9uFGUKrq0enX0fOwhzxSxqF3GwcT+XGV9ePm8C1pWqMGrG9F2K+BmkaV?=
X-MS-Exchange-AntiSpam-MessageData-1: 0c9jLOqzRBBDJrzT/q88wh3ktC45OSJQo8U=
X-Exchange-RoutingPolicyChecked:
	rrWzLuGy6CxpwMkUWaJ40nHFO4Foqx5KaAUGNQjNFG9KvsoKjH6hLfcaSrKHLK/y66gXbFMRQh15e652/DV58Etc3+WNY5j9AW74SB/8f5gXjZ8B/P9d1mgPrJ0SQqz0K683/iSyPL2pFTzzv17O2vXegrK7tNbVMdHospBjouoREfALa2z6okVcbhEDAgfrRxFL7HcsSZfY119j0wUgRcfMq/wWdf/4RgzWMiaSzCmiZvi7ZnP1oL2DENYFdtuEb9UINK3QPZBLqZk8H+3hh2wvhQiWTrbuyylUXxFeRdSh0pcUo8QgzSBBAHHJklL5Y5vr/NpEw++ZY/HDeimu/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z+9TwnRbF8pRIxcJR/3Z0mVigJrsUVYHXhOX/pX1G2HXqhY6PsBVWkOUX6qTJJrjK9PC3ti/6qY++9tGm/pJRNBKX+KzbMgCfDa+QBhw0+wtmLg72GX4UOK5cMr76d4EvFag77uwn1PeKilF7bdKRyzyOZ4GXT6qbuk6KtDvBw6wbOWgF/Ad8HmUoq3CI8Nu3h44NqhU6wmwrL74rKcY4wrviDNIU8xMkv0GXhaar1JQ21T9F9Z0BCxGqrK3qxSSqI4cToUKEK6HHepXWMU6PtwQi37H183NPopx/SQJ5mdv22jYI1N6XLXTPzfUJoK3vIqWOpeopS2tMR9hRNKaN8TYs3mFOKNyZY8bm9qJeCzWzm8lD6mX1QI7pP7X4VsPltBsPkuB2R83/N0JT09PAiPVcGFjIVRi7uc9wi3WIXJF4WXBCbHpD1yAVpMVYEIB8+7p/fs1xwIX/igfRV2Bsaz77sqwb/3XeAHEx+LrhLgiFGiLUk8oAZI4W76/BEvtT2C6Y+xyBYwOtshSfCttDdsRp57ElJKj5tIDWNSKqMjokTB5rm19EdAKUFoxDW2SWjQEo7k8kI+1GdKpvbMurPGlINLOJNGNmgelJVBbkO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5585b16e-e103-4548-7ba5-08df1fcc223c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:56:12.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjECFxvqWIEJ2V1DWraN8zUdRNHqJWsWWxFSObk5/ijLSa3xMuE+CxpNZVLg+rSfI8mb5e7O8H6bfG6w6EpxBkISw1uAN55xbvOHnjT0m74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3ismOcC4uzJe
 aUXjwN5/vsy++YW0wOxFjWF+AOIDUS4VHxbMj0G+4dQY4rpMMidFiZNiQONoP6A9I14ng4bKGyU
 7pSt0a6d7cllFu/b16FsrVpSKG4CN9Isw4Q0fXWPJLOvQI5X94xp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX5mp/4vG8PPWF
 NukBB3mSi4S9Jr4QJTQV+J3uh8SWYDq6kzGOAOyVappajFGRogsZqbHOQKFzbMYRU6Z+m4fYtR0
 5ucBvTFBUXiZ7fIz1FODRIDktRXg/1mVXBdUslFAWgIBiCBmzD+jBUxRM8jkF0KLlxqdTdgQ+VK
 RHZMjEXcdF3M9uq9qEmg8ZttbU1JSjI5WggY4Ho9qxqlRj/A/vPWVNkC9t1Igj/dzy8bOU9m5QZ
 pUyQU519nbxXwXZHyyo/I0yl/yLrnK7dNrHeQAoZdG2XX16y9RCn3PHHwdfwngghwB3bzWLtARY
 jY6/3E2HkG/xReXFFC40JH4OSDCZyEb8AzE2cBeILxus8lSDe3VcW+fuqdqOeB+1A/Agw902f4o
 44UGdFa8LcPrj6CixV5e9jaFILUnO6XYcXFLqEx5n3sR6OmLN03N10ByrvP1AQMUPbQL7AeqsT5
 /VsBDbYvjoWR48cTpEg==
X-Proofpoint-GUID: I-LA7kTCekOFlIY1dnGWQsqZsbCpRBQ2
X-Authority-Analysis: v=2.4 cv=DZmCOftW c=1 sm=1 tr=0 ts=6abe7492 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=HRhzHcoIBzGTXiVGymcA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: I-LA7kTCekOFlIY1dnGWQsqZsbCpRBQ2

From: Dave Chinner <dchinner@redhat.com>

The stale buffer item completion handling is currently only done
from BLI unpinning. We need to perform this function from where-ever
the last reference to the BLI is dropped, so first we need to
factor this code out into a helper.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 816c330b605c3f4813c0dc0ab5af5cce17ff06b3)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 60 ++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 6c29b00c0e80..22a231ffde2d 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -457,6 +457,42 @@ xfs_buf_item_pin(
 	atomic_inc(&bip->bli_buf->b_pin_count);
 }
 
+/*
+ * For a stale BLI, process all the necessary completions that must be
+ * performed when the final BLI reference goes away. The buffer will be
+ * referenced and locked here - we return to the caller with the buffer still
+ * referenced and locked for them to finalise processing of the buffer.
+ */
+static void
+xfs_buf_item_finish_stale(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+	struct xfs_log_item	*lip = &bip->bli_item;
+
+	ASSERT(bip->bli_flags & XFS_BLI_STALE);
+	ASSERT(xfs_buf_islocked(bp));
+	ASSERT(bp->b_flags & XBF_STALE);
+	ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
+	ASSERT(list_empty(&lip->li_trans));
+	ASSERT(!bp->b_transp);
+
+	if (bip->bli_flags & XFS_BLI_STALE_INODE) {
+		xfs_buf_item_done(bp);
+		xfs_buf_inode_iodone(bp);
+		ASSERT(list_empty(&bp->b_li_list));
+		return;
+	}
+
+	/*
+	 * We may or may not be on the AIL here, xfs_trans_ail_delete() will do
+	 * the right thing regardless of the situation in which we are called.
+	 */
+	xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
+	xfs_buf_item_relse(bip);
+	ASSERT(bp->b_log_item == NULL);
+}
+
 /*
  * This is called to unpin the buffer associated with the buf log item which was
  * previously pinned with a call to xfs_buf_item_pin().  We enter this function
@@ -506,13 +542,6 @@ xfs_buf_item_unpin(
 	}
 
 	if (stale) {
-		ASSERT(bip->bli_flags & XFS_BLI_STALE);
-		ASSERT(xfs_buf_islocked(bp));
-		ASSERT(bp->b_flags & XBF_STALE);
-		ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
-		ASSERT(list_empty(&lip->li_trans));
-		ASSERT(!bp->b_transp);
-
 		trace_xfs_buf_item_unpin_stale(bip);
 
 		/*
@@ -523,22 +552,7 @@ xfs_buf_item_unpin(
 		 * processing is complete.
 		 */
 		xfs_buf_rele(bp);
-
-		/*
-		 * If we get called here because of an IO error, we may or may
-		 * not have the item on the AIL. xfs_trans_ail_delete() will
-		 * take care of that situation. xfs_trans_ail_delete() drops
-		 * the AIL lock.
-		 */
-		if (bip->bli_flags & XFS_BLI_STALE_INODE) {
-			xfs_buf_item_done(bp);
-			xfs_buf_inode_iodone(bp);
-			ASSERT(list_empty(&bp->b_li_list));
-		} else {
-			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bip);
-			ASSERT(bp->b_log_item == NULL);
-		}
+		xfs_buf_item_finish_stale(bip);
 		xfs_buf_relse(bp);
 		return;
 	}
-- 
2.53.0

