Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498352F277;
	Thu,  1 Oct 2026 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866335; cv=fail; b=g2YRbrrHxTCC3bOSHVAZNXMDmm872jGvFZW7YW4XUONyEwvWrYoJ00tW4nNQyuMCp4yLWGt7HhhqrjW4aHnQHw7UBevHianO1929vroNOAbD3mX3R6Bpqe+eI5t46Jgmo1dENfztQa1Gawats9yZncxXpgFpyLIUqm7j/li4vHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866335; c=relaxed/simple;
	bh=qGOVKQk8/3EbtkqcbI3Qj2e+dq5U4JJvqvYjdUVtuJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ikUq2arS6PfEYic97Bc4nXw9qVCP+s8CzBxhtNUV/LTOA51vaflv/jmGqCVEuN2ZwTdQeTpbF3Bd2XNnjEPttVpQKg9spj/xLSpISLO2gvKTiiCuY7XsJdbA+CmDCrEuDPY3MHVjiJiM7f1L/X+ZeNA//rhJr99yPlDkGuPS5Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sb3Cj92V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PGcn9Y6c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sb3Cj92V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PGcn9Y6c"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DNAbv2257464;
	Thu, 1 Oct 2026 14:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wH1sNtSfkQBExCP3V6cpGCj+33hedt0q4U67iweKDJM=; b=
	sb3Cj92VXNsq1t3rXiPOtpw0AcadpwYryYJ2yvQ8jcJzE1xwkRDw4M72JpYHeQeq
	D9xiZT50MrvDSWz1BmfFMzvM+08SH7ifTq5fJuz4+BEZmpwJ/Z5gSAOFWTAYBDrB
	2eQHDTjbmN2Y4wIHvMxRUdqxVdfoCYCp/llocJ5Wsr8G1C6oMHQNLGfuSLkPmAVA
	tQUorJIQyXU13PGbmfsiFwNid6nrHI+sjMRC2JjhjyvA4o0VnPdwD1vHPPAzCwWx
	lh+HwN/wFWqVTxlBn8WOBjvfiCSkeI1sjDy+zUEsTZnctAycjhblPpFtMaBsv8CK
	rnZyDIbShPRe2Sl+8bVg1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo4jA011796;
	Thu, 1 Oct 2026 14:52:08 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxsm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKlm6YCyYT2G5ar3lWRsWMaOPKlQFxiW24wb9K3q/SVOwOb61cKByLUfft8YNtVhb2D/TsI0UgROw1JRHZABjFfoiVukNr9MKQKvMOyyjoz1D3hBeANbJxGaZalWWMyaA2uXQDc8ChYD7YMt+cBoUgvPGcpy0v7u/m/5L3xzc2/1Muh2uXayUZcQK+BNNXynwrcRImOfD9hgkJDsowGSpVXoC8+lCw72V9rrkRL5zh1rC94el71gxZ5KC80hAOnvNwGfykS1VLWPAdxmnJfp+7wOJ3f1sQQu5XfhhydRJzRqNWHOw/Th66JbTXdRg249xXf/35mIAXIFBALgIJYIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH1sNtSfkQBExCP3V6cpGCj+33hedt0q4U67iweKDJM=;
 b=CLneoU5pjm1NANuyP24JdArQxnse8DFT0BsE/NUg7Gndl7bWD/tTujRfvrgh0mYp536LMKjHPgP8Uqggb1hAGl4EwuJ5QJ4QtgqVz65mTQ0JU1kOegpfbcSa9Zq7ZslzbOvRXgRKimLTt5Md99j4d7T5Qa4Ae+bY0XBjP74csW+ERvzNuG4DZIHT0TGq8L8V3uXNztO5M6iCKlj+XORm0KJfjjcZv6p5dO12gLDUjDmBEiUaF23UhbePDIaICYLGpr5XYNBApInS/HnlWopDarjQyBRsEBuY6+HgF+jdMxY3j3Bpye7dAiHsyxH8ZtCNIE7LTMEocA+GBO2M1G04Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH1sNtSfkQBExCP3V6cpGCj+33hedt0q4U67iweKDJM=;
 b=PGcn9Y6ca6njioxDLUGb21u9CaF0X5TMPSpnma7dSeTD3lrhOciepnEwuvOj7XzLJrRNn1Hh3u4yOsgSJlaBMxTNjY77hRuMQz5yf4oFN8i0cMqWkn61BAKFYOAZOog78rPCgrFBtkUme4Ed3F6nDNSQSXMnlk2f1eV4ZlxjoJo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CY8PR10MB6876.namprd10.prod.outlook.com (2603:10b6:930:87::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14; Thu, 1 Oct 2026 14:51:58 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:55 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.1 5/6] xfs: factor out stale buffer item completion
Date: Thu,  1 Oct 2026 20:21:20 +0530
Message-ID: <4141a1b28b0583fc989db2a909335f37a6b60a1c.1790864538.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864538.git.siddh.raman.pant@oracle.com>
References: <cover.1790864538.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CY8PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a8b147-d3c8-4268-f980-08df1fcb85c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A0RTvFaQxX+t0VE6Idi4SWnMXGeHKa0BO3CKNiUC7qapTVEY80pcYP1W1zoeNxI62uiubChhwQE/wIpdKTd0WLfRDN0SnaA2l4xFiv4Hl2mTPmDQGwdDZY7T/n/pi2ajVIEgFkB7sjOBGmjEeWt562BeiRUFZKeY/7C9vD6MI/sgk2+0Kf0eKIlP8f18ZlvytdC+jHGtYGC9dDTHh2uf/h1hKsSl74HolzJrE27lBjGL2XU0GtzUW0lZj0lByNfoCK8/yIm2kQf5AVw6TrJ3D+sMBDlGSP4Djd17HM8MuSJ7NawWpmp10TDrx5q0KfCUQqlaepDiuj2FSsP1kQ18eg3Pm6mk9XXxSeKDtowRzFSAIutyHI7aZXDYv8Nvt8q+jjV578mbCIzUOqW/d4pt22qOvVgbY04SnZRTB1NGoxenfcCyTf4SEIwupTOx/zv2dYEpB0IrNdDrVzb1ZpGkZ6prH7gHdNnTI+UMAGkQn4qFqiwSy3J7QbwLY0MUWLJ49WLmW9hyjbufW+M2Yc2oWPQWFqQvOq3icsBGgJ+TMLjy49gc4YN+pYFCK7xVlPnjxkZhAWlgjIeDzrGVGw6Bz0f1HVG18b/GEqeL5tfiasIzwA2QeKbJqzdAagnJP6Rt6NsG8XqDL/s/qfaaqc2N8JLzy1o74DlVfwudPno6P10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+tdyHL5PS5B3a7CNlWZvBLOpwIM/mRr1FnsXd4I1UpG78fpc4Rn+xUEJYMsJ?=
 =?us-ascii?Q?Si2WCiDtcRi97t/CAXR30KX1CnABDyGrDEAV+0aAaPoU3FVOdZnzoOZUXDfC?=
 =?us-ascii?Q?S7pgX2ptabm0HPZ6ZBkpnCQS1VwbcaFmzcvm5XGLpLINkTZpYjhkEEn4+rEM?=
 =?us-ascii?Q?MmU2XZB2nNARMRnoe6ANWY+bPpk+memgAAWNYF3VEa6jy74R8qFTvUh8aP7O?=
 =?us-ascii?Q?EigoOLEXXP/SxW083xYFqEdmIEumVCdLKr3N1nmrZUimAnvRXWPMBvoerzBw?=
 =?us-ascii?Q?vX6UY7jgXMWjCOnrpEHFxC41766b4Yuy5rwr5DaBpjYQpg2Oeumqq0pSFRhD?=
 =?us-ascii?Q?X392mZ0F/dnlInztyHW/knKBWbTbJ7Tb+3uFz/+j90WzbfqjH58B9WSoZ747?=
 =?us-ascii?Q?CLoZt96HgufBzVhLiw5FL4vo1JSWqNq4tGi/35oRTR9Oet7sR5v78740AFcZ?=
 =?us-ascii?Q?0AmMCLKJtGX9NUbYJ8R73xv6V+SugJ2Q4a8kX5NnLmKVJ5yC3j1P69EAzaXg?=
 =?us-ascii?Q?cryMr5s/JsAsab5Yvd40MZqJ+kGBqefBhq44WQBQUm3Hfpz2j9hSwdD2ryE0?=
 =?us-ascii?Q?zAAwXk5YckuGhcO7EgLHZe+68RdATNeqyta+lSfulP4nMC2hav+DtwoflhRJ?=
 =?us-ascii?Q?94srUUCzmdxQVGxhwv2VcsQBDt9P7mN83jICSvy7t5hvDVrZ7PjhjRKpkbw1?=
 =?us-ascii?Q?NDY3lnA3kcRQk3ZjSd82K/YkflFbPboidmiSQoygIHru1vECpg9VUQlZ+e77?=
 =?us-ascii?Q?/VTsUUUPnztmOq4av75N3RZev6iTf4/evPlKzS9zSjPinGQZC59kRaMFhZFm?=
 =?us-ascii?Q?W7OJ7+BvMuJ6X2hoHhxTVSfKBQysZqHSecIUZGYUuZV3EYaXdjpBh8RBzM+m?=
 =?us-ascii?Q?uC1EaOohVhAyBm+ZlLj0zfLBf5S9uOzmvH7D9r20eyHFxyBWWKHR5I1O3Q9V?=
 =?us-ascii?Q?vQj8anvWjz9bsAEOmqpJWEZj9PBI47vMX7rZZQO9EovMiRSNfSG53dGxmZNM?=
 =?us-ascii?Q?DwkKB8zTVsBG28B+SP8uW7YBW4l7gxfYMnH5nMk0XVk5BiYaERykqt1wHoxD?=
 =?us-ascii?Q?hsyj0ZPsD4QXFVfsjXpeA1F9b1OAnMaZxPQnyrRqkg8WopTaS/MBl7JYvpq8?=
 =?us-ascii?Q?0N4cTnv3AskeFSQrVBh17tQgYQbDdUBqxP/m6kQWnSO++BvVJECjwBnbNxtj?=
 =?us-ascii?Q?iw4CnF0VSlaCVFixA4yiIPhYHaYoMwHJv07jWOQOL7Z+pDvWR0lNcNoa7bbp?=
 =?us-ascii?Q?W4pd4ta5CHHOMqxS3Frsl2jC2xvPrRV+8BJx7W9NOs+hTz6DcnLntccs+9Ce?=
 =?us-ascii?Q?fWcqcdDqC+ixcaImRCH5cBzSmJFsqPzOSPTiusZpOR11C+ntyhoCoXB/6oGl?=
 =?us-ascii?Q?Yc4vubtniDkKwwEdS94Q9mzyJGoqjGEXWpPPYZaHkk/lBIlbFcA2jp+ogjFw?=
 =?us-ascii?Q?rxweKTHh99wloR6osQuZIg/JLtUy4VBNuT31hED1taR1BgZNAKTAKZSfLmay?=
 =?us-ascii?Q?J8nhEI0inBLR4FoYVRhb2IQU+Q/dlCoG+14w0Hj3jT3v3Aa36JQVZIsHhHM0?=
 =?us-ascii?Q?vMiQjvip1CGj3vheqlhfuXaf+y0K5xAwOwf1Vr3SgIodPAkY2P8BA7iIxNwC?=
 =?us-ascii?Q?75l/94rT0Iw6QxYNTGIbr9Pso0C8N3KDZR0Xh7pspCN9KM004Vqu2F6nYjeI?=
 =?us-ascii?Q?N/8swM+MTlFbmbF6AfHIwNWmrDJbUV9aUJNyap2QGYWWYM8Hn7Qb+80dFsmJ?=
 =?us-ascii?Q?HdiZGHZT16oduIKFQjlpam3+w9E0IibCxFlf3R7gkRzodge8dRS1j0UV1JgC?=
X-MS-Exchange-AntiSpam-MessageData-1: 8Av3OJCiqrGk/A0pT9/cJvyKuD+XxPkzFUk=
X-Exchange-RoutingPolicyChecked:
	ILVW9/Ey0eOBsYvg64DA+cqdHt1853q1WDgsciniUTENk8QG6EJfREwDNG0mKZNj1siSnqd1JAWiEIhEKHOF+p6iIPR/qAkg1+LLVLdhuEbR7GMlnEZjfAUNKb87TSlMpdE5KpoqDJQ5QG1s1XfJicvkUKrTv71/lJolUjEwRKlPY4P8rVsI4baCp6/o4+5E6KpJWPoX8PtzI3eUPCOVL/u2xjymnsTwh2od3C5FXy57G1R5AhD8SUjN/+WNYnnBTMoVgSdhIaTsbuT2MAvBVPWsEbCDDiDkXosAzDHE1Jux8QNBLU1w1ihHYQrO6EIAtDuktOQSOJBB4jS3bUn2bA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BTwk1lRlc9MygHLekWGYeL746cz0frgQ8No7Vw3bMiiWy4XWGsdTkAt/dkaRjyGE2uTXpOiQ0XXdhqCjZE7tkSHIZR+RSHqySsOzUZtkLNk+SH4n9ouxMKNvBUAYgFXNnVWX/SXFDAdvzaO/f9bxZEIuSzoe2KTA9axGyL7QuwvFgg8zN15RrS2M+WWLRImZugg3qvNFRuJy+1yfXxoS3t75Ag59tOrvZQ3tQn6yeZrYoGGO9AJv7xjWIVaOPw0ZsWVJoHQHeJVrS3ZTbtbDUfCGuYoA7aPKJ71W2WWmnuUbwVKiKUpKMSFNSucyPo1M4bzeZi+mueJfN+9OnfA+jWLT3jV5GTwuTZ9t6AAtEM4KroZMbET7xn0gAZXnTVI0z8ulJs/Ws18a/I2xUnIWslzx0CHL/jfOQshgYDRorOtN0tma3s0Tcu/nTKf/d03YZLKU7WlRuttKvw5qKoZHfaiyNQCS+mnZvj0Bb0Iid8Rc9bLVW2Kj9yNsY6fpDmM5rvWPh+aTscfOezXRUIvCGGtvR2SXu9wkv67hU2/ZG7p5NSB7ixFJD7cMHIJGKiNLlarvVESBVkyG3/myKj+xrzNao7uGxEeUVTe1ViUjxpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a8b147-d3c8-4268-f980-08df1fcb85c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:49.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMJulNxfTO4ht4abmU2UAeUb8iIK4HDnxiwVzUb5kWsio3DnGVa86pKwm1Lq48fPAYbtpJizAOlA1jlc7higAZyUHkFTcm3zs1Hfyd6UKJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXxDQOrCHXuxmB
 eKKsmHLYu/Gn+5VxMfEwNtrQnsl+e9PdRnC4XTELDT7UmKkrSMbC6fEZgBVIj+uApu+VyCW9m8q
 Vu34vkBlUfMKiAyJfrxSLOOFSLvRttIrobNQDb5EUHRK0UTl8ZFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX7tjt7CuE/xw3
 DVZtfWiBhJknuxjip5uKj4LuAw5xYURIR7MKV6AZj2fR/g+5LSGG3/5Q93ZglPfMx/43F/97piJ
 fOIlv+8FFeylyoDlInj6n2AMQ/0VVMU72NVCIgSjpy2MFodTY1Lk4penY5K1P49R2rm/rIWjo6b
 cRRSZDvpZ0w4vfAPMLPykl1RZrIQhGKJNubj50BJ8Cazlg2WNP/4rKR30WTecg5OMqaJybZxgop
 rXiC5N4lApz3WXxwOCZb2gDSxBBqsG5Z1rWotrROEGIMJDqwGDvw5AkCF7MCRHZHf89cq6abIQG
 e2DlAPNNkkk+hcT0ec1DBQng72/Yi0rmbmIwkxQiT+KxXasNc7tDoAOx8FTQa+I4FQ7wRfqWsPd
 8/yyyWcoKgZRvs2uuKOH0L6VMCl326zneNsTX1QNt1fmCDB/gKk7b7PaiBcwRKBuqKOuBdym2TP
 JL/TbAp09lSbQPMYjUw==
X-Proofpoint-ORIG-GUID: 6eNhHnxTJAazm6H6y7sIGHskqs6Q0U3Z
X-Proofpoint-GUID: 6eNhHnxTJAazm6H6y7sIGHskqs6Q0U3Z
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe7399 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=HRhzHcoIBzGTXiVGymcA:9 a=WmVTiCyuxqgg3mnwYu6p:22

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
index 033ec1e2f2df..f13df8adcf4a 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -539,6 +539,42 @@ xfs_buf_item_pin(
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
@@ -588,13 +624,6 @@ xfs_buf_item_unpin(
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
@@ -605,22 +634,7 @@ xfs_buf_item_unpin(
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

