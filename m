Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7B52B1D7;
	Thu,  1 Oct 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866375; cv=fail; b=PJNJDsMqcf8ftV/RenHWDg0d7FSwSH0G1YJuwu5ZGTcP+tF2rgTn0jYYsvZt8s/oPLLZgmW8F/6M+57vacPkxXd1doADZ64Dtol59JQlJ1d7+LCz0aU4908TfHZnw0gHGz9faKLGuAamVcUm5m2D6eIiab3Zk5XkqbUoG+Vtb4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866375; c=relaxed/simple;
	bh=rUbJ53z8Udoaq9ctCnM7otGaGvYjIBzjOeBQHLC0YRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lKyJxAFN9JrokVp/e75OFJvdp7h9gPlC9pI7xeXeEgnMwjY09Xzep1vKcKKyX55gaq//FZ+WTKCkyoXqnBmVV0x7iIEoIFV38BGC8clhFGfsd8WVCKSoZ5UXJoYqReghQd2ZpdCxU8nQ1a26V+eFm57z2TctoI0qrdbXm/j1adw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WNuwxn/X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u0QAB3ew; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNuwxn/X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u0QAB3ew"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMc0c624353;
	Thu, 1 Oct 2026 14:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FsdTNh3wyQ6OA8DFrfSDd4s5dz5wajzOn141+cOVxbY=; b=
	WNuwxn/X+gbXVmiUyPX/KgM8uxYGIM+8u1uOrzvGVQlvklZ88Qi13DwncXLL8fvr
	op6vzhmZIJvkJLfsVYgl33P72C3Trkb/NXjcyLTWsgFFkW2zgtfxywsG72I+x1GJ
	HjSjcrIR3JHLTWBjrVXpaHXpFpe++RXeSt0u0gqTvXkclIRNEplOvzCeUyMGIm2G
	1ekkhtEOJjsR2Za6RfF0dsRQDX5XAksNcigEC5wBbPEUtLBIZydn/ErzbRVvdtb6
	uLbsQK7mUhbJZdfNOm3Mlmy4OERygZ8UVIBPZ8p3eZb4MiVPQPiJBv+2QYNAKQ0T
	q2P+0y5e2Stk12eFQwXChw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns1071-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnqcG017299;
	Thu, 1 Oct 2026 14:52:47 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey0s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjIPdGCE9t3JzoioJ69bcLVbNHmn0wJcFiBVoWTSSPSilmJasqLjb1yP3rTTw4V2V1sq8eNGOoeYKhDKCZAEjf7tFT3sJWOnQZiJ1QXvklPnAhKAQnfcg2CtHjqBUyT/wdaAliOgNl1rUmt4OWgEn2DPs3LwGBTtJnrtXouAZkj2P+6K37b3Yr5hZACbkmLB37jy1LV0I5nnaJFwpIHKs9GkZEgI/mJfKDEoTKo/ZK/rCXALIJWY6oCS/lOKpCVpG3YkX9twz//BRXsYoQ53e+FlpfmQduZsKEJY37FgdTcKdK4bCEtyFOJYRTgnPZKhumwbspe1UvYrJHsIMkoInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsdTNh3wyQ6OA8DFrfSDd4s5dz5wajzOn141+cOVxbY=;
 b=vFk+3U9ZWrTMCUOuvUwHPt5RjSBz2355V1DvOyRAypWpHolKRL9ppEqogFuVHUaG+7H2jEQ+//+169cSuAZzcUndA0pbdoIVY7j6KubUjuo9Oyt7sFFyzPdb9XF5WDsdsuj0n3r+FsdQ4ezxViq3WsJCTuJemnddNaI/FwudcF5XZcqjL/+ppz64K8XuT/WpK1j0NqZVvGq5XLM/2ap7CAk08queI/pqLQ+DKfTgvRFroqcOLffffU9Ekbv7/TRkU5DGjiW4vDHqwwBTzS0m1q5c3Yf9iaCZB1y0TLhe75qtM0BMhBpYvPyflYlHhjplX1VJA7E1lpRL4KSzj2h1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsdTNh3wyQ6OA8DFrfSDd4s5dz5wajzOn141+cOVxbY=;
 b=u0QAB3ewQas90d+jvFxRrZjTp+iJM4DNwI213m2P+XUIdFwHOE9IsXv0ApwivBeu7QId4qDf8FLvw6i5+wEtl8yr4MzqOv+MrixKHFv3/MuNIIF74nVWdpHTZXh3pv+bp6XXr9DkePm33awoDJ9Hgy2RhdwMsPr3y3tXvpMFk6o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:52:44 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:44 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 09/21] xfs: log items should have a xlog pointer, not a mount
Date: Thu,  1 Oct 2026 20:21:22 +0530
Message-ID: <6d179cc626e45c91cf6276cbc13c438a1cfa968c.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25b::15) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 187fbbd2-9bc0-4995-982e-08df1fcba65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dUOLbEyJH/Mh43yLQpYqbLWU3scD7vzldaKgtM5T1wFcQVu5O7Fg9U+Yb8T2tju0p9g8MTpojlmYYLUzu7+yaM0FaiQH3X67/Z7kC4QKpqoqYRUVQfPg2eYk5r8eEGjKbtrexXvv3OvFMNDuwztgMafYQBRMtwiBmo2IF9YbBQRCR5ZFeuISUA+VkGFAQKyocyDdRvkvsQ16pOQQ2TSZbAZQb9J6UPqUQTSuNt97gd5zTKjgIUgkn5SrZbQYIsmdCtv2LZituwN1uVnaLx4dKDH695Q4+5HA2oAq1NSKzWGkV5UVjZF6ydSXdqmP0rsdAQ9YXrYxEwzOoXZW9BWckQX2xSHVbUV2JU+FN3WBox2CPRYIbDPhO+KHGgqH19a1hLYl8Bk9o/rEzXs4sAqacy21invYJwN9LyVLqIHPf8D92ytyy1Wp26aPzByKb84X2R9TM8h4pQ1I8Kupf0ZMR4dTCN17fKhcVZXVyuqSwD4h/UMZdFirE26SK22aPMNJSyKUP8yGTjU98gx2SdwXmVeCiDfgygD3u4dBa409Cw0iAcgIuL4SnfrGMBvN7ZcfcprMjb2of/QgagWuawJHC5O74GC5rk8HVfxZxtWSBVUoKYutsyCp8DhAuiUTN6gN4W1BK5Taxj3Az8WUADU62gZlxIvIdb/106QUZG6vOMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXx+xmLy+fwSZWGdEh6kmqmgGCTt8W+pdYkEWp1UAajmxqY1sVJxCNUlkexS?=
 =?us-ascii?Q?+l6DA83pS0vJnfaxJ2S8RLZm8siza5DG4McTQKJnwkgELsNyzSQmF5soJ8FO?=
 =?us-ascii?Q?EJuymn+kEhulZ029HQRP7aq0Vz7ZvHAmT2/tx8eoqSqlFybQmY4NZs0Msgub?=
 =?us-ascii?Q?sXTC4b2muLtgXCnNqe2nDyQepIjOzMNFDtqMl8LHTpUS6dLwz1/D8h82+WJ1?=
 =?us-ascii?Q?FWvut366TZeAIGNqksoB8aCWU1/ZlaBfNBctvrVrgzvf1ixlHMDTgL0i0Z+r?=
 =?us-ascii?Q?ZVKxafPvdpSGlHPYVOOGGhGZ9olFCkVOUYEd+qXa1FE5g9gwDYB+JfA/M2B+?=
 =?us-ascii?Q?dRaFgPMc7po4MvnyxO9C3kz0+62Znn8BcoCFZ55+n27RkHZRwzOQQ8wPcnIV?=
 =?us-ascii?Q?OJk5vFO3VWpQsyrcN/4HQoV4U9pBEyjLWzF80CcsllD6P42VE92sEsVJAEyb?=
 =?us-ascii?Q?F0e+dmFt2NreQOsn+43AXsPqXK/GJkv6oj1oZ188+Gd/vAnqvEcQ8neKAy/X?=
 =?us-ascii?Q?tvHG0tXwO9t9lCrfRLiHCJK7g5VETiZrS3RVGMKRPF1foN06wVKKs2LUFtrQ?=
 =?us-ascii?Q?il++IMMCMDl2MWVLwjLNnxzetHQ/2Ru2yaENMPv/eA9jCXYheAJm/4JxK8m6?=
 =?us-ascii?Q?jmWkeOw/sXa8JGnTte22YESrJRhUBeMyQsESAZDgvo0ztyWfdN0tgdq/GKZ1?=
 =?us-ascii?Q?n05xoQPnt3GXdurgCaHIMqWPzjHAbY9VmTCloONnoBx8LiSlhfHrVYrEYwUS?=
 =?us-ascii?Q?6Xn3CZjKXFqh7pQtIHNZqc8RH9TbX8wdVQsRX82/BZhJvQjAH1M/GwTRzdJD?=
 =?us-ascii?Q?U9SJOeRFcs9v60NxyMuS5oCFydxyEoCzU+PSybHulQe13AiFI4sOT0fSuv0v?=
 =?us-ascii?Q?6GhCcc3fq74jxYKA/t5c0rplnn1C1F7VQZ+OwFzXeogiaPvCuQpOsUw7JDdH?=
 =?us-ascii?Q?wJCewW0h74H9Fz3DmSmdlovAglGE7WaVVr2mP3aPSydQk9JzAs/HIbZUmSZ4?=
 =?us-ascii?Q?A0bNoorKLXOUKcSSA3FufTa7ieY9WaWejGtwznrUrtOFiD88g4Rg6K6cNC7o?=
 =?us-ascii?Q?wN2KIRzXiP8Gz/8vnMbulwBJQkTgdtojHUfwNk8Br3PZ9RAel3ZYnYYpXSq7?=
 =?us-ascii?Q?vFGkt28aiQQlvAOW4ykgktKASWelOGPcy3imIA9Tzzg7K8DiDxOH8xAjZO0Y?=
 =?us-ascii?Q?Zemf2X1ESrcBZkSEprz0qVCZdTfKSoxiQRcwihFMAbXta3UDd1mp+555Kmhw?=
 =?us-ascii?Q?++oJULkpTiGm9+k9DeeBDngkDSH9TYMVjO9s9NKsgExelLAaY4b3fBGi1e9V?=
 =?us-ascii?Q?mQU5kwijklQKkdQ+YPB9lMolDBcVJVOdwTf1ucn/Y4/+AGU84zKYJLPtgMCN?=
 =?us-ascii?Q?l4DLJpuEk0OhO6zoPMNRpY5e+pWmOwfLObqm0/mqddXVrPW5BaQcox6BWN7Q?=
 =?us-ascii?Q?aXhVAkdcnoY0+/LPJFxOS31hfyRzFvexc/8EhxGwpURMMJD1W7/FlLTyOsI/?=
 =?us-ascii?Q?EVnaQIfnqI3GxP21oJlr6g5R/VwibiR7B4nmSijmEYwdUbVI3wwL1tC5+bZ5?=
 =?us-ascii?Q?qYD+WtUWu1nH4VdiTq8TkSp6ltbfaA+sJJEK5JTuZ71duA6irpQQeyhIhs6D?=
 =?us-ascii?Q?ld5Q2NkbDbwkvumRZ+gC0q3zk1cY2MroBBLNPpRS5YdfzhLf8icAqXeGszFR?=
 =?us-ascii?Q?TuIzpkA3rp70Ji8C/YaUqbQIkQfFzoX/w86RbleVwApkbBjthJ8fcPnNZ51I?=
 =?us-ascii?Q?OloMbC64dDw70kcWGVD0vPi3riFbL4f7QK+du4xe+qlCdJmstcJwRTREdCDD?=
X-MS-Exchange-AntiSpam-MessageData-1: UxeOlmhLF5uQI1Ybs8s93hOO4n7U9HnooD0=
X-Exchange-RoutingPolicyChecked:
	TFObqTBROaLFCBHPJh1vrUXb+60EOm8ZV9QmSlSGZAnm8YUtqrktEi6o62vdO8fP3QTd5cZBtKjW50UsaQrGzz+SxVm+7asHdwxK2Z6n2bHAQI+/af3NbSNOiyGn219d12Fq8Tn35zmN8qPlM57JYjdVfbdcZF6nzooNJmkNb7r14/J89nrk6bbsiSkhNIqqvGswkhUWhEFAQIpTa3DVM0id7E6tiKEwYLtF9shl42dVx3tlpebFSFQ7b6om/gxWhyOk9jO/DnRtGRjkrc9NbXZcVEmkyqjFVbQr78qE8rbh1keC77PCPDJ5QeMgnbNJaBoSLqufd1BhlUnU8aCkyg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dUKey8YCu5wMDO5PvA4S5b7LUUsAqiTD3Aa4vdWwJbMrWv3u0k20CcEbfyCJRFccSCgjM0om8kFl5IV7H9Lb10QxcaZYeeLQL41xfitV+yzDvFjeK8xPsReDRXPJqbIALf/G4vm4C1ZrZO0i0oJfvKvM3vqbfMbRdKnpfewZ4Cy5T3iEouJLw9nKvROS4oi2M/lLLM73NUAMxa0b7iCcnPMoNA6bC8sM1h2oToxF39cCDDDsJ3dh3/yP5F2OMoL9d1thWL4Ru5SptfAIHFBMhaJupNpYeRjemN172W7n9XkjP4g56fp3cPOuobmudWvjD/I1JeMeEdBsDE9M3R6GzxB0DdISAVOIBA09Tb4+t+wzbA+72fGv2PaCbHIkpf+o9S2ASlUa8aKjvYYCsJeS3T6ZCIWUPDypQ8anXZBatmg1066Cg0qZTi8ABPa1J3md+i8/4QPJX7bFYy5wFUVp/5p5PPvZbRQ63+i8v4SiNbxIvUrAGYy1E+EoFClWRAyHRH4srbweAFR9yEg09zIIsHGbzTRcIN7HGDyb2DWVjnxFpRMonL894Bqh6eDV9ny5NL8xpFG96POMBFnA9H5eDMh/YVR6wK2GpDPyFtUD+Cc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187fbbd2-9bc0-4995-982e-08df1fcba65a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:44.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9peiAAL/UZAs68MFOmovwqkXCLNX/omsBNDNwFlpSmfIa5GEgvrdifnfCq8L6kOwrXMhG4+29Xj0J5wJm4copu99K+QCjF+BuGGyvF0kDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX5PRAQpsQakc6
 rPJ6Fs97w69pL5qE0wJrB+qwinLOlWNOSL9qxOuB+JKAIVYro73BJBUymAc/CbV5Jw9Ac8T0NwR
 IJ4oRs2JOD6z/q905C6VwyLXxhZFi4DpKs5UawgUT9MIbaUYXzpb8ScQMAc0kndAF1HDy/w0Uyw
 nZ6sQsQLsicqIBXFPtQh8+qWgbFbHKJoAd27A+rZgP0czGtV+Hjfc4fgkr30DZ3ktpooc3NMnEn
 arh7RHx6G9grm2ZCRlh43+TxzBCtTgkPDHR2x1PtpPBLi0spqHUsKl8NQkGarUPt1cdJH5MH40s
 nq7r8D4JvxuaWhI678gRitCX59C6I5N0vO/2rgHfWaBD5G8oScdFJOQNb2olHopzkqs+G3sdleu
 AY8YRCI8zDkLWkesNSuiL49A/yDphBF4FJuaaJjl7nSjH7NhEHXHfWWLmb0Rrs0Y16YHMJW1ghE
 WkeuUCSjWs+yVLdLZSg==
X-Proofpoint-GUID: OaorIzVlutg9H_jDeq3XwxfAbbB9Bet-
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe73c0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=nZXUwzawmNCwDP6AOoAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXy6hQDLgVMQ/y
 GYlj2nNgsg8lZJmpGAPc3VcFbTMWveuOFUABFuQ1l4OZHZf2ceVnaDL63z5XpIqe2vxpZ0lENay
 vZI/I6DZCCotiPLyUZk5a4qrlTB5VosmIZ7QqAf7srvZl8EytjiU
X-Proofpoint-ORIG-GUID: OaorIzVlutg9H_jDeq3XwxfAbbB9Bet-

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

5.10:

Fixed conflicts due to the following missing commits:
        38c26bfd90e1 ("xfs: replace xfs_sb_version checks with feature flag checks")
        75c8c50fa16a ("xfs: replace XFS_FORCED_SHUTDOWN with xfs_is_shutdown")

Extra conversion in fs/xfs/xfs_dquot_item.c due to missing:
	40b52225e58c ("xfs: remove support for disabling quota accounting on a mounted file system")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_bmap_item.c     | 2 +-
 fs/xfs/xfs_buf_item.c      | 5 +++--
 fs/xfs/xfs_dquot_item.c    | 5 +++--
 fs/xfs/xfs_extfree_item.c  | 2 +-
 fs/xfs/xfs_log.c           | 2 +-
 fs/xfs/xfs_log_cil.c       | 2 +-
 fs/xfs/xfs_refcount_item.c | 2 +-
 fs/xfs/xfs_rmap_item.c     | 2 +-
 fs/xfs/xfs_trace.h         | 4 ++--
 fs/xfs/xfs_trans.c         | 2 +-
 fs/xfs/xfs_trans.h         | 3 ++-
 11 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 5f1c2fda8e4e..70849a2bda45 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -474,7 +474,7 @@ xfs_bui_item_recover(
 	struct xfs_bui_log_item		*buip = BUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_inode		*ip = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_map_extent		*bmap;
 	struct xfs_bud_log_item		*budp;
 	xfs_filblks_t			count;
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index deb69740d492..132acdf0aac0 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -21,6 +21,7 @@
 #include "xfs_dquot.h"
 #include "xfs_trace.h"
 #include "xfs_log.h"
+#include "xfs_log_priv.h"
 
 
 kmem_zone_t	*xfs_buf_item_zone;
@@ -347,7 +348,7 @@ xfs_buf_item_format(
 	 * occurs during recovery.
 	 */
 	if (bip->bli_flags & XFS_BLI_INODE_BUF) {
-		if (xfs_sb_version_has_v3inode(&lip->li_mountp->m_sb) ||
+		if (xfs_sb_version_has_v3inode(&lip->li_log->l_mp->m_sb) ||
 		    !((bip->bli_flags & XFS_BLI_INODE_ALLOC_BUF) &&
 		      xfs_log_item_in_current_chkpt(lip)))
 			bip->__bli_format.blf_flags |= XFS_BLF_INODE_BUF;
@@ -535,7 +536,7 @@ xfs_buf_item_put(
 	 * that case, the bli is freed on buffer writeback completion.
 	 */
 	aborted = test_bit(XFS_LI_ABORTED, &lip->li_flags) ||
-		  XFS_FORCED_SHUTDOWN(lip->li_mountp);
+			xlog_is_shutdown(lip->li_log);
 	dirty = bip->bli_flags & XFS_BLI_DIRTY;
 	if (dirty && !aborted)
 		return false;
diff --git a/fs/xfs/xfs_dquot_item.c b/fs/xfs/xfs_dquot_item.c
index f2cef1470373..12b265a630ba 100644
--- a/fs/xfs/xfs_dquot_item.c
+++ b/fs/xfs/xfs_dquot_item.c
@@ -17,6 +17,7 @@
 #include "xfs_trans_priv.h"
 #include "xfs_qm.h"
 #include "xfs_log.h"
+#include "xfs_log_priv.h"
 
 static inline struct xfs_dq_logitem *DQUOT_ITEM(struct xfs_log_item *lip)
 {
@@ -331,7 +332,7 @@ xfs_qm_qoff_logitem_relse(
 
 	ASSERT(test_bit(XFS_LI_IN_AIL, &lip->li_flags) ||
 	       test_bit(XFS_LI_ABORTED, &lip->li_flags) ||
-	       XFS_FORCED_SHUTDOWN(lip->li_mountp));
+	       xlog_is_shutdown(lip->li_log));
 	xfs_trans_ail_delete(lip, 0);
 	kmem_free(lip->li_lv_shadow);
 	kmem_free(qoff);
@@ -352,7 +353,7 @@ xfs_qm_qoff_logitem_init(
 
 	xfs_log_item_init(mp, &qf->qql_item, XFS_LI_QUOTAOFF, start ?
 			&xfs_qm_qoffend_logitem_ops : &xfs_qm_qoff_logitem_ops);
-	qf->qql_item.li_mountp = mp;
+	qf->qql_item.li_log = mp->m_log;
 	qf->qql_start_lip = start;
 	qf->qql_flags = flags;
 	return qf;
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 11474770d630..632747305463 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -588,7 +588,7 @@ xfs_efi_item_recover(
 	struct list_head		*capture_list)
 {
 	struct xfs_efi_log_item		*efip = EFI_ITEM(lip);
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
 	struct xfs_extent		*extp;
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index bb57a125eae5..dbe5c9ecbebe 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -991,7 +991,7 @@ xfs_log_item_init(
 	int			type,
 	const struct xfs_item_ops *ops)
 {
-	item->li_mountp = mp;
+	item->li_log = mp->m_log;
 	item->li_ailp = mp->m_ail;
 	item->li_type = type;
 	item->li_ops = ops;
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 407e80d06bec..f9c24bada01d 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -1181,7 +1181,7 @@ bool
 xfs_log_item_in_current_chkpt(
 	struct xfs_log_item	*lip)
 {
-	struct xfs_cil		*cil = lip->li_mountp->m_log->l_cilp;
+	struct xfs_cil		*cil = lip->li_log->l_cilp;
 
 	if (list_empty(&lip->li_cil))
 		return false;
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 2532a2a1cd59..459d04320c6a 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -463,7 +463,7 @@ xfs_cui_item_recover(
 	struct xfs_cud_log_item		*cudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	xfs_fsblock_t			new_fsb;
 	xfs_extlen_t			new_len;
 	unsigned int			refc_type;
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index f248e2b0ab5d..132976ae6888 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -516,7 +516,7 @@ xfs_rui_item_recover(
 	struct xfs_rud_log_item		*rudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
-	struct xfs_mount		*mp = lip->li_mountp;
+	struct xfs_mount		*mp = lip->li_log->l_mp;
 	enum xfs_rmap_intent_type	type;
 	xfs_exntst_t			state;
 	int				i;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 86951652d3ed..2b7e6322ec66 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1169,7 +1169,7 @@ DECLARE_EVENT_CLASS(xfs_log_item_class,
 		__field(xfs_lsn_t, lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = lip->li_mountp->m_super->s_dev;
+		__entry->dev = lip->li_log->l_mp->m_super->s_dev;
 		__entry->lip = lip;
 		__entry->type = lip->li_type;
 		__entry->flags = lip->li_flags;
@@ -1222,7 +1222,7 @@ DECLARE_EVENT_CLASS(xfs_ail_class,
 		__field(xfs_lsn_t, new_lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = lip->li_mountp->m_super->s_dev;
+		__entry->dev = lip->li_log->l_mp->m_super->s_dev;
 		__entry->lip = lip;
 		__entry->type = lip->li_type;
 		__entry->flags = lip->li_flags;
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index d334bb3ce643..4e1400ea6a99 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -644,7 +644,7 @@ xfs_trans_add_item(
 	struct xfs_trans	*tp,
 	struct xfs_log_item	*lip)
 {
-	ASSERT(lip->li_mountp == tp->t_mountp);
+	ASSERT(lip->li_log == tp->t_mountp->m_log);
 	ASSERT(lip->li_ailp == tp->t_mountp->m_ail);
 	ASSERT(list_empty(&lip->li_trans));
 	ASSERT(!test_bit(XFS_LI_DIRTY, &lip->li_flags));
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 97485559008b..f1805119a1ee 100644
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

