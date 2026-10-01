Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871952E06C;
	Thu,  1 Oct 2026 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866398; cv=fail; b=pNvK2ZbupfTrBjW0LHlyvrbqDoY+i3OA1PgLMKulofWvMbCPIqGeBdxHYQZIWwAckFA1ZOddyY138eHu/aMus7xr4qZBcLLyjma2XwAXkayxBkYgECxJzaoSkb4xBFpb/hzIkdC1mOQGV5whkoSuzJiG1G798Cnnp3LiOoo0W5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866398; c=relaxed/simple;
	bh=E6NyunGdp+JmM5+9G+WKCdOoys9lyiMVhDOYbrosLl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FuEn3G0hVSE60x0NiORko3f+4S1hnH4FXgkkAOZlGuFfyStyM2BZ4mutkbUAygvnViQYUSrpCwSWS74wDMUxBH9oxR96Zdqc7/hVx/v0oIz/ATDvzKjlfbbFWsn6ZNo3j6aFXDdbR+kYzUi/Nh/ACBh6MOSgeW0fOtO8QBSoTdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TMec+o3e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NbI3w8Ln; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TMec+o3e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NbI3w8Ln"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMiRb782877;
	Thu, 1 Oct 2026 14:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=N8BnqocoPPpmRYVigoeQop5V91JAdz9mqyX6FDNedj0=; b=
	TMec+o3ee70/iPbjGbBahl3plxhlwi88XFh2ResB9gUezuEy9ECgszgnFP+PRhPh
	4tnp8D81Xe3Qrt+V3lriV86p3aEeEJ5zp3tPe2nZ0cQ0zEkyhnMxtxrUGkdxr8QC
	tZ4XZQwTcpRQO8VnHDc3DD8zxXO93WGCxecpWLPVeZZu8NUB9zOhOVr+fxK5h/MX
	AwLbv+97NNfmqiKuHbSZPccTuSvntv0xkfT6Ph8+XLjSszmCzISEzncmTYOyl56d
	ev0k85J2C0W1zKFtVdnqEyDF4VyT8kgohGY+t1jE2vH1LHtU8zbmPyWu4rnlxdEu
	9PPP5C0u5ymIryJdL3VLQg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5x7924f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:53:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoWlK028028;
	Thu, 1 Oct 2026 14:53:11 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012063.outbound.protection.outlook.com [40.107.200.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsnusp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:53:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t83LA98GKKrm0Api9hL7KyGWbMJS1mk5gUYcfDzEK9pUyOvHKNWXXgkSyry3q3vqAOmh+iHKebevRMyNO/1D4QJVYvVkf2vxV7dM3TVL2QKiD1nBnu4B4hHiCMRBZ1LvVxW6Jj9qTKFoYwybVG7j1WLHVjv4XtipsQ4mcTcLit3SFU8BEUnnHzrvpiLUUyLMurgLjLCC5gFNwAlFU4+SIFyC15roam/Yt+9fhUUEKmrl9KHV9ESCU6WW3ix6OrM8q2UmiVOndx01E7hjqVfgb/2u8zVJYxcpSo7U5y9n86SV5aNsRSzvJf+ynxamtvCDd7lQ+IOw4FL+fIkTl4yPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8BnqocoPPpmRYVigoeQop5V91JAdz9mqyX6FDNedj0=;
 b=kMvPEvP6tVUDrj4Ag/AR4y1gfvC3MAJaHQSxQn59bzwULO1Ah9lBVKumvlR/9I0vPpzDWmpAz4lFXSrsS7Buzp90NO2oQRCD6WIZKtXuRSgWZmJHUP12q8tL4aUQe1iCqbNh62jt3BQGLiI54PFtaIhX5vjcPmD13zryWOnG0IekBs2f7fiqT05iPPg53LKVtzRqW2038Ktgfozz578mWB4y29YVHUKHWSXCQT3mdcf7GPl3STk6V5v33YLxE5Mj/7GPxbpdSsAnkDk15nogInIqexiCem8Wu6GiWegwNDp4tXFqXXIk8jfwvVQwOEAjy5es2EO0BP7owIgrl5jMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8BnqocoPPpmRYVigoeQop5V91JAdz9mqyX6FDNedj0=;
 b=NbI3w8LnP4RXwkDgTqI8kmmLf4s/TevRZZ0VkQHEov5CIaO2rQUcRTCx83AdHC5bayxgNRBSevnJ34pzIUZ9l+8tX/NuUIRCVZG9M+v3Esh3zDNa5LVTLRVlz1T0bWIMOfpIwEjT+VRL3kHE3ytYxiACKwhSELZlXTM6+Q72faI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:53:04 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:53:03 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 13/21] xfs: fix intermittent hang during quotacheck
Date: Thu,  1 Oct 2026 20:21:26 +0530
Message-ID: <76dbb4cc8d9ae27ff674e653f6ddc29377b09f11.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::20) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cc51c0-3a92-47d7-0a4d-08df1fcbb209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|260925021911599003|260925022911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	d3X9RgEWn3/OJLNiBAd3MDUnd34BZcPz0hQhQGQTBWQUhdZbFS2cf+WuCDrcb+XtsV/6r3Ny7sl8v3hsNFtJV0TQ0m8SoFXhDABLVxDUXlMQGs8oYXkv/F3GZnDFh3+lSbKJlll3ChRs0j/rqbCs2hWaa0XLg2e77RaYXIw8sUl1iu109yA03BR9X3rgHTSFFSC2Bav1uKMV4lykNjTbcW7Zwqp82NGFD9eSIWENnlvtPzFCyT24HA6NFVnL9ugz4AMU4dOHyudQRSabYb4W4NJZ7p+ozZXfQqaF7gNwPaSgnFX6E4/d/pJf7aNC8t/PndnZM3TSVuHdqgom2QK4vH9UW5/+clfnlIwFuDmVkgsK5cOOIzmEag/KjYbFUj925I7nYYJTVkuwb+46I9tfR47Lor2Jzc4UgNaoOFXVQxfl2jeLdFfKqjS6YA4GbbElgDpJCrUC44ri9oDDa7OQNODc8yMteJjOtww8qnUJY3h/hQoDGEWB1nwgmacmNcPbo0G/W90cpSILDZchKI7s/ezgYk/lWFCaSmDposHTl25iT40eztmfmXSBNvbjXwdwva+y2hiDJ25nGO47UvlG7Q162BrgFyrdBgFyQqNfozT35pU5FQ2MRNubl2qwJIdZ37JUJgelvU5J3TUYwqbkDDH8XWy6S8ZLsExrKLru/NM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWZ2ZByFwOIFP0FxsDRr02KoR1j+vqLqHAbbEuTLTDZN9vR6q6JBuOi8307P?=
 =?us-ascii?Q?uINKQ8bclif6HKjt1q47ptBuWcYmmLfoZxjaGcRS6HsBZ57ZivffuGYz7jJx?=
 =?us-ascii?Q?52BgegDtFcFaQlv9+DdtQTJIknYx2yKSvpLSQe+Rj4AGVaCuUJiluUCDb3DG?=
 =?us-ascii?Q?QZ562DDH37dI4ZHw/UU5b4bKLPAbiy3NUulFi6DNrSyGwlv7rscobyMheoDz?=
 =?us-ascii?Q?8ohP/zZZgqJsW/JyYEgYCTfJcV+JFr+hHWNSiAH3OGbqtSf6NxHO8T5wDt2Y?=
 =?us-ascii?Q?EEwGFcZHgrsoKs/Pl0HaWkuw9Jt1AprFDCa3MZ+d+hH9n3VETSY8tjtTlYh5?=
 =?us-ascii?Q?93KIZ/MUgvrDfDRWNyN3wJOsZEQXCcXWPIIfrq6spVTXfbcQQr6VATvklAaf?=
 =?us-ascii?Q?CLJHb1skIeyMHWcHVDZauh0PuBpMx1WkAITOdsgaIX+uulnyOpcRnX+Eg3w9?=
 =?us-ascii?Q?Af7nbsJgqA4NQ4ceKiFlvOKCaJTJZT28n8KpSUwm9lyoKphlJ6DUyMSoL+Tt?=
 =?us-ascii?Q?SkEL3XZtKz0XVfkZkB1Nvyt475pIi/cUG9UYHFutbhBSvfim0kBGyz3LuTsL?=
 =?us-ascii?Q?RDpaGhybrbz7Qch7DRvzvV4WOE2pFe3jbi7oTVzTYxuAPwOkdfscsBcs6Lvf?=
 =?us-ascii?Q?6fpOeb1U3Ac2/Yw2lwmAbaOh344tgoBeKidV5gyLUDyDfIQznLb63IGaJ734?=
 =?us-ascii?Q?X3+/qhrnqKO+3RzYacVir29fdarChVas5nFzVPVTVQzWQJ6rlN3l0IjpSVfW?=
 =?us-ascii?Q?+cCAVWkipMFw7X/XSea5MevYthOE7bhL52uPYkn0sYs7PhG7INF+gXaPcLVH?=
 =?us-ascii?Q?kcnNaW4WW2O/195OyOQtCt5nfKySexkR+4oyutqM32B/Bw7QRhMTjdsxaXEo?=
 =?us-ascii?Q?MRrG+tUx+z3eyWoube5boLtcN2qFsGzt7QOGSibcP3u4jdGrhWF+9VKLNdmI?=
 =?us-ascii?Q?+ePxC5hjZAMd1BlgiiBdN5PsfkYij1GH9/60D9X1GxPsuoRKTEGVaaT7Ds8L?=
 =?us-ascii?Q?L3oLA1jcYa+0kQx8ekyB9WR0uTOY8Oe57YRqgeU+Wbys7Hkxzht0j/xwarQ3?=
 =?us-ascii?Q?gwgE6hLymNarQh6azbByl7Dny2vuMJEVKqsu005eYC7dwwrXsr47EbTA7E31?=
 =?us-ascii?Q?B2CTN2mq2j/dKzHa/RhG+NYVTAr8r3sNtAzKyJLfhe29zHyrWYQrU8fjLjYU?=
 =?us-ascii?Q?Hfn1S5PCRsm7ZIRNINbi4oM5qf7EBL51T1qafxZDN9+DFEviaAjwWf9TjGO2?=
 =?us-ascii?Q?7QUYz0TZ9dBH2FvOX4LEAm90uq64cDI4v6XS2fNgm74hdE572kDHwuaAH8nq?=
 =?us-ascii?Q?k9++m754L4Rt4LLWFIYGAOwSnZHKO9Uv5munuOX8HfIP6kWmUOtZeWX/oMXh?=
 =?us-ascii?Q?NlW9NF8qJv0c/jSUhiA+45K8QpST2hEksUbDJySAiU557m2cGcYoObzNR2ed?=
 =?us-ascii?Q?Ckoc3aaZkfmc/6400bXeyhGIhHqEzER7TGSVXITgfw5TF0hgdfHfmvqLhfS5?=
 =?us-ascii?Q?5tyW06Y8yW8kaTuwVNKYJ9CqPm0Fa+xhwGK49bUccshH7eotnUZdMz0H8lHi?=
 =?us-ascii?Q?jSihmRWMY72ZzJHafZDH4GnTg1C7TVLFykchBwNeFZx25MoRk7Tgq9kTe8tc?=
 =?us-ascii?Q?dYNGCH09kRIJGLlPEKV2mhy/ii7DEfA70wgY2YMu+ymhFZJ1jxsDFNh2Bbp/?=
 =?us-ascii?Q?+0FnripyBIFITg0PyunKmZpEAYU3NViohzDaY+34yNH0pDWwVDatMiQmEc+y?=
 =?us-ascii?Q?+tCTDOkCRqfxTelYyIiIyMWMU0F8Ew0u1LAKo84OQLa/gELuixbIcJeT5gk1?=
X-MS-Exchange-AntiSpam-MessageData-1: ZxLKPMVBLfn8LS+tWXe3l0OYJ4lxIpjp8L0=
X-Exchange-RoutingPolicyChecked:
	gwvXbVrDqAb0LUOrtYdssMdKpqot7N4fWkW1lH/oRZMCV0w1u1a9amR1X8Iv2tpzGBS6rMLmBrxK+bHoQvG7KxkuSLXTfZsNShxkeInM+G8SRtyvkwP0D4CzroHRuK7SONwPliq5CKkg2ssdc96CjDmM6aFitFsDUV03te0qeXXbWCb/dekzp/3DA13r7DMoh4Qjw34YduAiowON4ccz7bkGFmx/9PhSNr1qL0ZARM9UBl/n/7m9+gLnpfJn0OGCKts0vJSZM43CSlPWQkqmB0eS9f9ebx2M4DbZ1S+ZJul+9yn8WShAEroqTh0Sa9q9CteGrlFai10uDTH8Chffvw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XjGyiwf4sdTr88ZIvfSHhrE/pmsS0CVuNsyVNR1Rt84Jo3908+pOGUFCpCp1ff2CdUMRGEXtdSFA0ruKe3U67CkbTlrrVuNsl5BXQiw7RHztevwJvX7bgJVBg5zo7LEwLA9gmBlPNB5Fo8T7+BfAaaO6FupBwutUM0uoBNfKsIjmdhgmmmzD3pcurYRzja70rrzNF1I5XurXjqddzrc7qKJgjYsn3nq37cvukG1ofbFgeIHvt/hoeGrk8ljrRilcrf2ihHNuqADVKvcMV9s26JXJY/aU+bz1z18o3Ix7QqAVj+TkqiAoPRZyxwC87F95jDsQ9J8o4hhXbffouLnnjrs8O/ytttZWJI/vuz9IaJkBAuMu8dbHt6knJ+4BiK1IciRQXQ06E6/Sc32ZsHY8T8hOQVZqxkvGqJMwUrw8W4uTjDQJLuzHVpmPkpEfH4kaQ6vUsudUaVRv8YSYVR6RkpOhw5z6pEzFeL56Ih5cC9Tfrncrndr1SKvAxKq/dtQWXD6SByacsutnAOIgRbq+uRP3s9j63P/moLCzhVTfPKk7TdZdUcXjeQT9UunzOQyGIoejpL1wQfB85v/sknWRgGi/TgFLWOq41kIk09LczXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cc51c0-3a92-47d7-0a4d-08df1fcbb209
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:53:03.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bY/HIfhV59uLH/PTPTPSwPHLTg2SOasnuVDXr5iVjB2a618azffUsplFGvvRw66j738dgGv6mzy8v/Ie/ZIMP4tf0ePYokz5Spqk+K2b5zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: xmflk2TvEDp_5u_BcqoeEq2iRWTWe7Kj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX/cZLrGcYoQo1
 ZK2lSiB68+Cnna7+WvpBMX6932pxBMYhkSt3uhO2TGOg48cXPbMQ5cJL8/p4Ea6jdb0vwMsj76L
 arZnPbcujtK524OQzRzkdUZFxMzY/+9nziDS4Vx/mty6PdZbIe4r
X-Authority-Analysis: v=2.4 cv=CP+/zhrD c=1 sm=1 tr=0 ts=6abe73d8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=85p-hYGmfu7TsMeR7eEA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-GUID: xmflk2TvEDp_5u_BcqoeEq2iRWTWe7Kj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXxWxB/nyKZRvL
 nfzaW45W2U+cCz0NfYcNz+Dymg+Z6evLQiPF1c/ESdl6gMonOdkyeAv1r8bHVbh5tn0sT8NCF75
 QpI6qpSzxUjWAEHUFPwmq3CPIMrhkRILof7q8i2AgtccXAy0Hg9LNLbMEd3D7hDepCPFXHkOKyJ
 BTsfD5WkHYNlxWzdBa02H2OYk8yQeq2MmgOJ9aKW2juI3cOTjYpKV9amCAqi3wH3Ho8wGkbXl59
 3BzvJs/ZB4Wt952WnZjIUEO0UmvY/GtN/8zPdC7vDk2Z/My5KdtMbz8y9LbAuSBMW54u8UQfdWX
 RT1Z7nZO+Bu59F4BHqpM5nx3LUaDa99hLHkzQ205B6woHVyARuopim3snBcdKPkHuRqP3b2o5LQ
 Zhgsy3QoeQrUKNIeB8yI3boUg2xEyIO1oaReDDPAx/Qyc65hZQu4yYBGC1NgFC2cfLjfjSXXjy7
 +TWvLa6ebG/getWmg+ZBCqmfA0qwqkj3uA1eB7U4=

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit f0c2d7d2abca24d19831c99edea458704fac8087 ]

Every now and then, I see the following hang during mount time
quotacheck when running fstests.  Turning on KASAN seems to make it
happen somewhat more frequently.  I've edited the backtrace for brevity.

XFS (sdd): Quotacheck needed: Please wait.
XFS: Assertion failed: bp->b_flags & _XBF_DELWRI_Q, file: fs/xfs/xfs_buf.c, line: 2411
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1831409 at fs/xfs/xfs_message.c:104 assfail+0x46/0x4a [xfs]
CPU: 0 PID: 1831409 Comm: mount Tainted: G        W         5.19.0-rc6-xfsx #rc6 09911566947b9f737b036b4af85e399e4b9aef64
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
RIP: 0010:assfail+0x46/0x4a [xfs]
Code: a0 8f 41 a0 e8 45 fe ff ff 8a 1d 2c 36 10 00 80 fb 01 76 0f 0f b6 f3 48 c7 c7 c0 f0 4f a0 e8 10 f0 02 e1 80 e3 01 74 02 0f 0b <0f> 0b 5b c3 48 8d 45 10 48 89 e2 4c 89 e6 48 89 1c 24 48 89 44 24
RSP: 0018:ffffc900078c7b30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880099ac000 RCX: 000000007fffffff
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa0418fa0
RBP: ffff8880197bc1c0 R08: 0000000000000000 R09: 000000000000000a
R10: 000000000000000a R11: f000000000000000 R12: ffffc900078c7d20
R13: 00000000fffffff5 R14: ffffc900078c7d20 R15: 0000000000000000
FS:  00007f0449903800(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005610ada631f0 CR3: 0000000014dd8002 CR4: 00000000001706f0
Call Trace:
 <TASK>
 xfs_buf_delwri_pushbuf+0x150/0x160 [xfs 4561f5b32c9bfb874ec98d58d0719464e1f87368]
 xfs_qm_flush_one+0xd6/0x130 [xfs 4561f5b32c9bfb874ec98d58d0719464e1f87368]
 xfs_qm_dquot_walk.isra.0+0x109/0x1e0 [xfs 4561f5b32c9bfb874ec98d58d0719464e1f87368]
 xfs_qm_quotacheck+0x319/0x490 [xfs 4561f5b32c9bfb874ec98d58d0719464e1f87368]
 xfs_qm_mount_quotas+0x65/0x2c0 [xfs 4561f5b32c9bfb874ec98d58d0719464e1f87368]
 xfs_mountfs+0x6b5/0xab0 [xfs 4561f5b32c9bfb874ec98d58d0719464e1f87368]
 xfs_fs_fill_super+0x781/0x990 [xfs 4561f5b32c9bfb874ec98d58d0719464e1f87368]
 get_tree_bdev+0x175/0x280
 vfs_get_tree+0x1a/0x80
 path_mount+0x6f5/0xaa0
 __x64_sys_mount+0x103/0x140
 do_syscall_64+0x2b/0x80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

I /think/ this can happen if xfs_qm_flush_one is racing with
xfs_qm_dquot_isolate (i.e. dquot reclaim) when the second function has
taken the dquot flush lock but xfs_qm_dqflush hasn't yet locked the
dquot buffer, let alone queued it to the delwri list.  In this case,
flush_one will fail to get the dquot flush lock, but it can lock the
incore buffer, but xfs_buf_delwri_pushbuf will then trip over this
ASSERT, which checks that the buffer isn't on a delwri list.  The hang
results because the _delwri_submit_buffers ignores non DELWRI_Q buffers,
which means that xfs_buf_iowait waits forever for an IO that has not yet
been scheduled.

AFAICT, a reasonable solution here is to detect a dquot buffer that is
not on a DELWRI list, drop it, and return -EAGAIN to try the flush
again.  It's not /that/ big of a deal if quotacheck writes the dquot
buffer repeatedly before we even set QUOTA_CHKD.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 8d0baec78e8a7abe03b449820507c9777dae7f7b)
Stable-dep-of: d62016b1a2df ("xfs: avoid dquot buffer pin deadlock")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_qm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 3c17e0c0f816..907819e7873e 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -1245,6 +1245,13 @@ xfs_qm_flush_one(
 			error = -EINVAL;
 			goto out_unlock;
 		}
+
+		if (!(bp->b_flags & _XBF_DELWRI_Q)) {
+			error = -EAGAIN;
+			xfs_buf_relse(bp);
+			goto out_unlock;
+		}
+
 		xfs_buf_unlock(bp);
 
 		xfs_buf_delwri_pushbuf(bp, buffer_list);
-- 
2.53.0

