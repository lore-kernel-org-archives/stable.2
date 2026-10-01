Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE552CCC6;
	Thu,  1 Oct 2026 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866328; cv=fail; b=MWwNB37aWt+XwYJsagnUeHzt1QS9pkBcdvyhJGiwbiKLjxA8vMPWQOZ3VdgOgXcVBl0ESLX/B9Vgu+x0+JfdvKOsZ+OqDwlHKNFq4cH4DAIKcuIjK8DeDr2obyND8XvDtCJEuPzpar7FZxKKTrT8K0IDBNKpzQ+SDWOETcmJUew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866328; c=relaxed/simple;
	bh=cgCLEnL+WmgQyXi8XZx1/Qs7yfjcZxr3JO6rTPmt+Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/ANNfBzJvIOZyx3Wwh13DXza5P8f/vsSyrwrSY4m+KitPFzf2HXRb1Of5v6dVGuU6lJFCiDBvAgfzIJ3bpezZzTNLxq3oLP/u7l9+bVWseI+3MH0EwDR38PSxSiTrPnph85mgAKdHIEb3fqsHoUXP7iYQQPAxKmG8JS4lG68E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dkJtRE+L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AKrk1sts; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkJtRE+L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AKrk1sts"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMaU9624350;
	Thu, 1 Oct 2026 14:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7HbwMLJQmB4ZVegqluQgLTHPltUqbZKMXAttcPmp85c=; b=
	dkJtRE+LHRMqE2D4i1IBHZ0CVmiL5eX0HJOYn68YtT9qykc7GlvX3v8PVwqO7eaM
	XJOH+bKXol9jj+2cZ6HhgnAz3TPAdZ6O1ISBXHDFNvh/gOGA+xrbX8eYPvKyDUrJ
	st1mX8fBI1q+bDYoJbl+mQ2fVuSo1sDrD5QyJ1F/8INmlCrORABPipB1yjxMH2qq
	QElxXi6CCSNTEni9OrYGEiW99tI1pSY3A4fM6Kj8aji+WlV+5koww1h7eMEy7YJL
	4HDhVaDgIGTSZ5+OV6oymkD0WyDFbpAzP2hx/w2dMF8npBeBi9grQsOaPbRKBgbn
	WaF9XpfO3SdvBNxzQEfqXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns104t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoS2i031740;
	Thu, 1 Oct 2026 14:51:59 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd3au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2y7XjNsdz08cycyyaTfKeregink+IftRC7QEZDllkwn8fCcK/fvBJXsOxMT9Q5T1rOoL3nMoIRTHdS3iDewyqvf62WeHn2pWC/kEEFmCpFmg9YHdo4npwRjdJDcV6VVWn3EcMEB6ZGKFNIccwQEKpmFDQEcj9rNj5416WhfkEwWXtygSQoFEqT4mPj9g0dP/ah1BbNfQ5PlYbe9fMaOwCdSfxylmyXKTj4V00/qoC8M54kDU908mMkTqiZQNTBdpfcZ5UCt3LpLRtK4pNsgADDrbnk97r63yhEqJca8u+o1CGi5vZF1bvgpX1FAeQ4SETcAGPE6VYiSDKvXnsn6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HbwMLJQmB4ZVegqluQgLTHPltUqbZKMXAttcPmp85c=;
 b=JGRTN0wNFiUuYySK1WWfzv0c3nH0X1zWJyKqGJjf5etu2P/798bUsk5tgMVm7pYyMX497lKYz20DVn+WRzpeZB91mFWKJg2LiG3TH1LRTq91+lEf7kzV48BvN1lO9HnpKMBF//iw53Uktz8/4hmYvmG8nrALyDgI4UUDMAAzd291zLNxO6oFL8oo0nU1+I8r9CKPu0yrq7CzDxhLnh8AZ2p/DO3XDs2zo4VjWhVWgKFATtKuhV5iRAV91XMP994TWG64Geb7lU4ucQKXlmc4rhJAofEdknOVDsAhrIT05hV1ikTJpRvOP3pWE5sg0bsPbv2d3KNLSAA0H3cstsG4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HbwMLJQmB4ZVegqluQgLTHPltUqbZKMXAttcPmp85c=;
 b=AKrk1stsswntuZ1RHNvVCQXIFI/rE5bjBYjEVSlJpnEH9eujN/5pDI4u9/tfPsoajjlWHfz4lb+3bHEQorGPnyFnMZOSGJ0+tU3NVwbMiJ32KIS1FTwqJMMISuef8vlQiXgTCBKxNfakfsErbqGdEbqAdcz90mzhkDo6JOFo03E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS0PR10MB6104.namprd10.prod.outlook.com (2603:10b6:8:c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Thu, 1 Oct 2026 14:51:53 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:53 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 03/11] xfs: fix super block buf log item UAF during force shutdown
Date: Thu,  1 Oct 2026 20:21:18 +0530
Message-ID: <a4f3c7d18946beec712034136dbd156c41da74c7.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS0PR10MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: aea25995-4ff2-4d1e-4702-08df1fcb8350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|23010399003|22082099003|18002099003|6133799003|260925022911599003|10067099003|260925021911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ERceK9zMnz2d5oBCIHa3CFCCUa7cpmGsyRZGlmLDpHme2FQvpmR5FD/FcW7yDjqCjvOfHcsZBgFnnjN7DGQXBMFqWETuaclFZxMVnds24PTt+lZ5LDaHcEDN0N1m5+30JRzTdwUUkv6MYdnOuvOIi21u+c5eBJ6PWcz00vKL+XdRbHHMpCM+KMeYFZCEl762E8Kd4ez4oxnMYjwyUNXbqndvrtL8Hba7QE/DXRr/PK5Jv4czWhlK510+bcgK6UQ8LE4eVJETvzQWIKILNWeVDoA8O9FLWn3bxkNhzbkSrdCz3LVKYBFjm6RR6nQorw/hOs2TOwwNNeTRTB7vmRlaReAeelc/CHWUm0O906W0q74bUFkw8Tad90240Kf+CyhDdNuXdMZ25xu4boMuklmryHBexFnY955CR+4GcMILD5q9dwFOLWkEF/795hvM5bcpKK8HF9ZBrVYdn2N5o1BWcqAXDzjISwVO+nVAZK3dPra5xY5jvOUI6eJnxwVPub9jpcDkdTG48iSXO7M4K+lTjVrmMv6DNC+cznahP7fYHKCeMSn9Izt7J0nv+ycd7ehUZ0aLli1GOi8eGW9WRXfondHBkqGvkuOOeFMZy7lWoV7RFnmPFhvZpSUVaBzq7HPkc22loiZzyyj6KCLdgKHDOIH1xT+ebfKWBdJxNTMJWRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(22082099003)(18002099003)(6133799003)(260925022911599003)(10067099003)(260925021911599003)(260925021311599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQw+T1568aeX3A102BpBrHbPghOalV316A+uwczn7Osh4bFxLf5hvA70AfSa?=
 =?us-ascii?Q?2wrmrAccHNq2k2YFaNRgHoWX0dx5DACj52JgVMLT2PxtlJXEraWm1aQ3yz7w?=
 =?us-ascii?Q?ACHZBQC0P5byWBOn30ok7N+F9JI1c9xTtE2EBOc+vP1ZP5+/nTds4GLgeesL?=
 =?us-ascii?Q?upRSmGZ9RQqjF6oibl5xiIi6HRKPgbbAuM8MVshEPRRm1C4UvXFJcla8Y4Fd?=
 =?us-ascii?Q?6RLqBCA0q+ASCV9n+/H2swLJI2rxRPGFGfRXyWfnxswyTbIIFgf9k83pYwXS?=
 =?us-ascii?Q?WqP0A2wH90vVS0uHh1w3+lEiiovGgjEPxk/tvsXigaT41KBd52R0brBVbtZ1?=
 =?us-ascii?Q?s29Vp0tmMRRF0ZR5+stxYUuvkUpQxAB8msh/qHbhhLR+ox+9GRxISn0TNbni?=
 =?us-ascii?Q?tm/HtgX3uJzyZUYjWQg+pHMJ3TxVPaq/B1+LjWHptcgTkxDkrzSe130W4EXJ?=
 =?us-ascii?Q?6hIkKv7mp+kDm14VOsdthAXFppljfq8Tl3/m36GZvGtzTjrMEWsQMU0AN1UP?=
 =?us-ascii?Q?9iEEbR5W9QJAVro7kIS6qyaqOTAdkBErn1SNfnbAuklwQlzPpETly+NMmDv5?=
 =?us-ascii?Q?KEWqCTUWua5YuMrFK2LD0y/1xLyaEax+4Xp0eYM1bG1HaADEaSrtmfYH7O3w?=
 =?us-ascii?Q?+1997aecxi7VH7i4uKtSH2yXIe1RUtVbMdATh/L1LFu7kGrtxbMCix8HFPE4?=
 =?us-ascii?Q?YHxzQ9SeT/j1KwfrHQPjv3YCGh94NaSOoTO+mSs1n1LU5NdwU9mPZEAA8LY4?=
 =?us-ascii?Q?+1aRBgkEKl5YoVyexY3rhUYLhi9ABkf0lX3chVEoiw2ViHiACyXkgE3JsDZX?=
 =?us-ascii?Q?XJdOJWJcEfj0hzt93seBYFg0R4YHXwPVJbS/igpuMgs/nxxZBs4IQc8GT/zr?=
 =?us-ascii?Q?4Ip0S2lIeE/VSaqIFd7Xv1ahQ//P7Jefcdp0Rg+OjuEmqLGud1MlN8qo006a?=
 =?us-ascii?Q?1cjdGVGMMdKoCiaBR2MDgnQlgusuZIkwXJH8lAqQ9L38MLV6stFfX9EkFVRE?=
 =?us-ascii?Q?y9LHx+2AHp77MUu1CdIL6lfG+Y+mfji5S11tNHXhhDBi5kGljzwApNFn6x4/?=
 =?us-ascii?Q?Kpl3Wej7E/V1jObMhnfahRnwORz3y1gyIRSvsAOObTrIfq/tjB1IyPFHfAzN?=
 =?us-ascii?Q?5bs/Ikl+hV8K8qLSmCJ9EPGaNtHKs9ApykJbyXcfXQBG3QixEp93aYheuOzN?=
 =?us-ascii?Q?bPv/jO1scmnIg0s9PmgntHQPaWBEqBBtuSd4dv3eVyq6Ag0T4akw05a9I8av?=
 =?us-ascii?Q?kHtA+gW+L7IFiUotKpJPqt5Jzwu1wsjqdpjesMVTFXUwiOIQF7ZJg0ziBM5S?=
 =?us-ascii?Q?DlwuUhbdvcFZaGpHiISwImLnN2qVKOSspT1vyJt1bDzqir+GszH4WPSSxwwd?=
 =?us-ascii?Q?AmzfjmcGQwh2uzmVxcMPEHp070k3Tf7R8XMPLubjuXQU9YlnjdNJqR9UbhAr?=
 =?us-ascii?Q?lKfEKrsrZSWcO2uhszjHJqcdl5huUeyVh0I1JSvNvMKBVqXdzjoGjiG2jG+x?=
 =?us-ascii?Q?jD00eAGeomSfDVUMRsRvIZqbUn8kx7y9GLw9HZjL1OHQwzp3TagKWqIqwinF?=
 =?us-ascii?Q?+r4HwCsWN7mulfOxdTR2AQ+DXm1qwyouZGfsyGg22PBQGj3B9fNB6pXqWaog?=
 =?us-ascii?Q?vX5TYSUVC2DWbTZGV92l90gK/5724fqAB6FcmxZRR/4Ah0Te4fvdcULXLwhU?=
 =?us-ascii?Q?pePdcCEM7rP3VzUqOEOhRbcdRKjmC2WAw1lEQzuXKn9yItpqEnk2Py+GL910?=
 =?us-ascii?Q?5qjgX4htxZwCtqYEhCWbkSidfd2xi1xGMVKwL4MYmdmJRwwxEHjlqrpaWmOP?=
X-MS-Exchange-AntiSpam-MessageData-1: brVme2OFfQFlCsDPXfSLfwbElpUUm2CYTd8=
X-Exchange-RoutingPolicyChecked:
	sHt3GKU+AelQ422haMF5hxwttMvgqm+Me93ECihVtu5xo36DEFmdBomEEvuTycayx+MiAP8j9dCQ4Aaw0mfV2OMjznIQJi7mjriIp9j6r+q/Jv5D6G+kf+CyoG3RFnHwYWTWdsaakqx2tK8IbfvhKeyC/o/GTycT2RMolqOCW6tGZcszOg34Itwm0Nn6TNol1JsmGkuEOx+vGiVssoYMuP3u6bDWInDdShkKlx/pQal31WhGcINUSupMLJxBJfLvj/jKmyO/0/ZKa6V+65OmzOtY4xPFDJ7L9yhBAlFxW52DSt/obaMGK1oXlooK8z+1jqwz0B6j+lHQEtr2uSR3aA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NX5LbDuUvSbRowEz+FTacCK4iHFGOQiPdi2JpWVcpfu7dMaG32oVpHbgh40UTXYr3p7kUdwYUh+35DorUmjNO/ajgbCG4V9jXbO+YydKkEHn20uReSugWJiZw3RaG1U5bH0CNF1Ar0/kBrsky3QSsufUhuX1YsJtspVvRP8l921WKinAEH/Czn8WUrGqt2SkzyxFp6NKg0H7ZVycy/2sNctOmRhFG5JbCcj8axoHzCtrP4tGxzgA5Y6PUT7ZTBbtzdp/kqglOxbo2sNPiZp5XFu7bRdFD4Hx0K0X7GGicDkJ9tODq0d2mzhAFfXvmyp4K5LJcCKCNBUR2LfvphwG2v4CcX3bpGzaE2gTAoAXsV6E6eug+oZXsK0+C8Fn7dcLXL88i4tKHLJuc1ENHEJRtdB+c3UdK4zgAXvnEVjBfSuOrzGQYEQOkCiZ7hWK9/Yx1sLaYdk1Q8HAFfSb4dKRtMCuA0b7NbP091xbNeNteySKY4e2f68Y22nnYNmK3f7rq7nCJSpw0nhhE/w5wM0MTfALJ4venSymme1u3Blkrw+K9sVq2p69es16fXwYWgwmffVOyD5WuKA75Tlc76GyOpRuCuBcMXXfi2gQ5nBLYbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea25995-4ff2-4d1e-4702-08df1fcb8350
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:45.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJE4U9P7ld/7TK4WyPGZtva09bjBqHjIWKNOXKo0a5VC/kVC4NKovPZFMAtDJ90VNn9UqnJ2PROn2URfrm83DXzmxdqwhlxLvQXX9rZ/T/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6104
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6WN7LHLH5JSu
 V+xPjSGrSU7uIVwaDbStXuBCvi1HuwQY+7WXEJdk9I8v8zY7be6RKLtR2f3EYTUGZq0DzAIdhYX
 IuADNs0x4GCP+L6Ps4AMzXy1Ot3FhOlA2E5CfAcq+x9KfpXMBGXZPkZr7VaM6s+sFz9IeoymvV3
 aLdpTpu8QFn1IUy+WqfTWjHUDHgQNtQE6WLBYeSAbwu4lxt+V2IAWqSG3tCDABP7wtxUKjB4yZL
 X+Gpf8mdEYxax+9fvY9d05o5uFsTVFCLhFy5n+VG1yjv0VJTib8QXdQCNw9juqtQ7AB9LGhrJ5f
 +W5uTwRjUbtd7cPax1n+0y68GOa4s4fLJvMHzpe8LAkWfldkxvpdvweYv4R8McvxnlGkytU7Tzj
 isdgr7B+fKv61NnKJgTAFm+ZssFO9fe/GQtHt7ooPMXteCGmRByM/DOY2x7/xxxZ3ajQovbM17c
 BRqqUFQR2qyDvS4tff5LBAUuemR5H1K5YLrYMaWs=
X-Proofpoint-GUID: DID8ceGBy1IXdMzNGyi5fqtZbOaEpg0o
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe738f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=X1hi7w48wxXEZvHpCekA:9
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX/r7LjjLQXSWw
 wZn2c/ud4rGrV0jHg+ICSacTXR6ABccdG9YYl+ASvPcfhSn0ZiZ4FVGq2yqJNp0jD91fgiSliAw
 EdNlvpxMpm9xdql3DgLdD/07TnnyQnlF4bQKPg/kM2OYr29adsCp
X-Proofpoint-ORIG-GUID: DID8ceGBy1IXdMzNGyi5fqtZbOaEpg0o

From: Guo Xuenan <guoxuenan@huawei.com>

[ Upstream commit 575689fc0ffa6c4bb4e72fd18e31a6525a6124e0 ]

xfs log io error will trigger xlog shut down, and end_io worker call
xlog_state_shutdown_callbacks to unpin and release the buf log item.
The race condition is that when there are some thread doing transaction
commit and happened not to be intercepted by xlog_is_shutdown, then,
these log item will be insert into CIL, when unpin and release these
buf log item, UAF will occur. BTW, add delay before `xlog_cil_commit`
can increase recurrence probability.

The following call graph actually encountered this bad situation.
fsstress                    io end worker kworker/0:1H-216
                            xlog_ioend_work
                              ->xlog_force_shutdown
                                ->xlog_state_shutdown_callbacks
                                  ->xlog_cil_process_committed
                                    ->xlog_cil_committed
                                      ->xfs_trans_committed_bulk
->xfs_trans_apply_sb_deltas             ->li_ops->iop_unpin(lip, 1);
  ->xfs_trans_getsb
    ->_xfs_trans_bjoin
      ->xfs_buf_item_init
        ->if (bip) { return 0;} //relog
->xlog_cil_commit
  ->xlog_cil_insert_items //insert into CIL
                                           ->xfs_buf_ioend_fail(bp);
                                             ->xfs_buf_ioend
                                               ->xfs_buf_item_done
                                                 ->xfs_buf_item_relse
                                                   ->xfs_buf_item_free

when cil push worker gather percpu cil and insert super block buf log item
into ctx->log_items then uaf occurs.

==================================================================
BUG: KASAN: use-after-free in xlog_cil_push_work+0x1c8f/0x22f0
Write of size 8 at addr ffff88801800f3f0 by task kworker/u4:4/105

CPU: 0 PID: 105 Comm: kworker/u4:4 Tainted: G W
6.1.0-rc1-00001-g274115149b42 #136
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: xfs-cil/sda xlog_cil_push_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x4d/0x66
 print_report+0x171/0x4a6
 kasan_report+0xb3/0x130
 xlog_cil_push_work+0x1c8f/0x22f0
 process_one_work+0x6f9/0xf70
 worker_thread+0x578/0xf30
 kthread+0x28c/0x330
 ret_from_fork+0x1f/0x30
 </TASK>

Allocated by task 2145:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 __kasan_slab_alloc+0x54/0x60
 kmem_cache_alloc+0x14a/0x510
 xfs_buf_item_init+0x160/0x6d0
 _xfs_trans_bjoin+0x7f/0x2e0
 xfs_trans_getsb+0xb6/0x3f0
 xfs_trans_apply_sb_deltas+0x1f/0x8c0
 __xfs_trans_commit+0xa25/0xe10
 xfs_symlink+0xe23/0x1660
 xfs_vn_symlink+0x157/0x280
 vfs_symlink+0x491/0x790
 do_symlinkat+0x128/0x220
 __x64_sys_symlink+0x7a/0x90
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 216:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x2a/0x40
 __kasan_slab_free+0x105/0x1a0
 kmem_cache_free+0xb6/0x460
 xfs_buf_ioend+0x1e9/0x11f0
 xfs_buf_item_unpin+0x3d6/0x840
 xfs_trans_committed_bulk+0x4c2/0x7c0
 xlog_cil_committed+0xab6/0xfb0
 xlog_cil_process_committed+0x117/0x1e0
 xlog_state_shutdown_callbacks+0x208/0x440
 xlog_force_shutdown+0x1b3/0x3a0
 xlog_ioend_work+0xef/0x1d0
 process_one_work+0x6f9/0xf70
 worker_thread+0x578/0xf30
 kthread+0x28c/0x330
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff88801800f388
 which belongs to the cache xfs_buf_item of size 272
The buggy address is located 104 bytes inside of
 272-byte region [ffff88801800f388, ffff88801800f498)

The buggy address belongs to the physical page:
page:ffffea0000600380 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff88801800f208 pfn:0x1800e
head:ffffea0000600380 order:1 compound_mapcount:0 compound_pincount:0
flags: 0x1fffff80010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
raw: 001fffff80010200 ffffea0000699788 ffff88801319db50 ffff88800fb50640
raw: ffff88801800f208 000000000015000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88801800f280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801800f300: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801800f380: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88801800f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801800f480: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Disabling lock debugging due to kernel taint

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 0d889ae85fcf0cf9bc6e998fca2ec760e08e0b46)
Stable-dep-of: d2fe5c4c8d25 ("xfs: rearrange code in xfs_buf_item.c")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 5eb6d787ed4e..065bbf03c7b0 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -1019,6 +1019,8 @@ xfs_buf_item_relse(
 	trace_xfs_buf_item_relse(bp, _RET_IP_);
 	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
 
+	if (atomic_read(&bip->bli_refcount))
+		return;
 	bp->b_log_item = NULL;
 	xfs_buf_rele(bp);
 	xfs_buf_item_free(bip);
-- 
2.53.0

