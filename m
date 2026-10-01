Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41385293E4;
	Thu,  1 Oct 2026 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866329; cv=fail; b=uqQtsy2wmTTDy4bHc09fsAzaL7AK/nv6e7nEfJ6XoK1FfyfuksGxxPXz6Y8+c9RU1FZUsOi+nvF1togXCDpqe5/MOhA+kNpL8HaBmZSWMjTqoh2MP+4Gj5QdbwGdHGkO8c4uF9wlm9Q0D7c5XU3huGageCQJIX978HMWhtXw9bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866329; c=relaxed/simple;
	bh=LRko4OWZ8NE4F5QjowLD9QKF7pQifMVCpc+nRbx+7XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hu5yP5KIcR+JBnr6G4qPxLLMsnBX/GihxXtkNdj/vlyKhGofcWV4QuUcwX4PtS6fX61b5aq6xwNuLphkjyLiB7RHzc3/ivDZgIJjPwWwdTMZFGMe9r+pGdCulSseBPYV5j/EirbNT7EnCl6CBFH3r9PgoPcG0ZitcOV3BSwQLN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b/2QMjS4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J7vCQJU3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/2QMjS4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J7vCQJU3"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMgmI622986;
	Thu, 1 Oct 2026 14:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FK/UDjPzV2uVYRf7HkvSA+vIcF9eZazdQv6on16HSqU=; b=
	b/2QMjS4u9K6TXmKnASSyapaqmVFu1kpTMI/rjKDm7ZPwiahECdEP3/v5XWApnUi
	SgclfKkbdLda7CRMGaFOkRM5+gDCJkF+OOHHLlC9NLljiyKBeFr0EWLxEbasOL8k
	jCW6acaGlG/MT9iut/8OS0hHxSUJRo9Vrch7mRhgpkfue31wIIwiW1we0T9Gi5AT
	TfQHdfYDBeOvPsT2D4aHpHsRlcZWNK+Qn+7sX99b+buIw/oEHAXpemPjF3QEx2aa
	JzfrDghFI3zbRD97ZzMWD9xsluLc86uuXuU5dq/ImYSQA8iH1HwnprB0miBJFDzP
	F11S9fgivNvPtKQn+We12Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4u2h0b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoMlN013018;
	Thu, 1 Oct 2026 14:52:00 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsvp7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1qoKXI83e6ew8oDJ5i2kadY03nLIj3DVmE/bsR+roxDmjXj1MDhH53rtyTBw57GyyuOsX8sN6S56wiryW5XdGv/C/F15Cciz437TJMevpCaAMFZ1W5bx+Q8WSN2GljLIAfyK+EYBGNf3vrjcDHJoBobi3I0bInXzrn93/E8yD++eEoFYT8lsPGI59zZIcc4j5Tk6pNI6c3MeWKh5w0KF42Of/ggTr4X1FzyX89iwewNY1upVE1MX9ayLy9Zbup8/zxy8zLp26vEd46K6Yk5CpQshL0NtZWhkwaIikfMbLjDbweZTfV6/nPB0uWaKSh4IJTfAVG0AmSNzuuPCTi6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK/UDjPzV2uVYRf7HkvSA+vIcF9eZazdQv6on16HSqU=;
 b=PE64yJsymSbBSv/FppYKCZmOiSpGLqul59WKBsHZpuq9N/GYSUy30y3skXtFrvYoWdKKDCeKaPWruCeJ/jYlR7ROn2buoAIcW9xUjfL7pm9+a+EkJYfuUweG2vaw0C456m61YkZBc8oaNLlT3qbUWJzr8vJDZXZaSOYr4PSQ9wJRTy7k7CRty4lVu2T3CvD8cniKhsryEtCJrFVlVyETpTsf7a5b7NcptLCo+Hjk8zss96eEmzxjm2ntJN6AP4juDSKfvDy/4mU+Ok481ge+KR2lCKuNS5WClUIeRzWE56llJzfAqiH3yDC4iy1RfG5FmsPpChGL61OioJ2mLeDsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK/UDjPzV2uVYRf7HkvSA+vIcF9eZazdQv6on16HSqU=;
 b=J7vCQJU3YtbP1lNfuwuUCH23k6YI3wu136k2t1F96GGOpHeM/kAT4AliIzS0la+7ZCZ0/MFKku+mVz/J2o/rES95w8slvR1rA0TO6RWFj/UeMRFrh6c7NNThQDvp/ymLNB4LRhArpa0eOAQSwRw5bRJUdNBXDatS9hgwZ9Y54hI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 IA0PR10MB6793.namprd10.prod.outlook.com (2603:10b6:208:43b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 14:51:55 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:54 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 01/21] xfs: hoist recovered bmap intent checks out of xfs_bui_item_recover
Date: Thu,  1 Oct 2026 20:21:14 +0530
Message-ID: <feeddf89debe273a2c9c0ca88980a65af0cc0053.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|IA0PR10MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d818e1-b48f-4d84-958c-08df1fcb85d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|23010399003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bvu0g4Us7HRWGBfGd2dnGdQ9Y7cMiLkc154Bz6FGSxdQuujipMOIg8QypAczwSKLfBA6w9LqzAEX5WZnGY3E1XS7EHkX3NW52SeOHh4KqVZIcy7N/ZwaVnQ+fz9Il3mMbwOGHjcY8j8CuhsuJV4e+x3uYwgd8YbSky2YeIWZKUresNhGqv0NDTLRgW/f4aG/EfOkILq71/PLgE3nGw8LOl3jfAI3NyiUI1p9Y6FlnXURuhVIqUbw4r9EchFh/Ay9Ljj2IRuX0auA0YsPDQqGvbGwiSBbHP/yHyZZhdBSeUcEy89Otzup/Mxcj9ct3PPMfasIPAVoIgN/+7ZmMQReHtZxSpYvATeztmLy497fPC67lMfem8xGpO250dTETIWLmYs3zdLBJC4Ayzl4XATBikOPlCjxOG/mZBs6jgQj6wOPcgqTvAeGjRHtAIW6euTxjRMI4W6cYQL0aUbrIlT8CK3SFhI50MEMxelAa53r3uyECKQ4bWHCioEID50kwutVehTuJSyiaQNJepitYBynIiFv4i71Jmntv3CNJ1Lk2gnfP/+5DghMCcYLKW0nl81T1v4Gfmzj+eDI3P/CNcK5T2RSygh+3McDouerb3fLh4oqglxUQnbjdZ5My4WoZp4F2UjTTvnTPKm+er3Hg2Y7cK3Q6kYUucO6GKHjhfE/eK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?514/gVqmn8tR5fm4nTbHYjR9eUZkDAfRQMzw5XrIfOQG3mplFvV90+cvoUp5?=
 =?us-ascii?Q?ps+/f5df02KfQdLHwsErVbPcJGwAJSkZpp1f2HVMKgmL2qI/R0wC/i3wmwhz?=
 =?us-ascii?Q?njhaAcvx7AFw4WugIGlbtoJMJb+LZ7OFdZyXQhA7otyhtyol319MgAIEtfwU?=
 =?us-ascii?Q?6t4fEQ0pkA/BEHF6rUgDrAo21gtVVYWlR3MRFNyVNnD994NktXhcl92iXz0Y?=
 =?us-ascii?Q?QgkY7AwrqnJGsu+VHPBNTNLlc2f0hO0Eacs/51U1UmiSwZh3Bf0PydE/eGMO?=
 =?us-ascii?Q?GybfNcbgUb9UPXd3s0cSWyaJxRMg6qmiUMkBcmI0TtitFfNkcM1Pod1oPD7p?=
 =?us-ascii?Q?wNXCgmzzBQvXtYVQBy8ZZ2DPb044VSe0twBmctzHlkOHhs/qeGj/dDTo1uva?=
 =?us-ascii?Q?AqQEYTYHqxeDy3u9XeBjLo7x+yLwNI2XH708kVNxBMILcjGdVW6PqrCmnthB?=
 =?us-ascii?Q?6mjqSuy4sKLL81w1eIWwjZzbY45lEnaBCjxXzFOG7wfKW06weoUWHuaTBtCL?=
 =?us-ascii?Q?8x1Nr0wZH1FNutJZ2TwL2FPxqnfV1V44e1nKU72CY8q+j1jOX3QTFnZejDGb?=
 =?us-ascii?Q?bzvsL56G6fVjNa4wI2CfUq6IBIqqQ92tG38/FWGo87EkPUWa8BGoVxd96ILY?=
 =?us-ascii?Q?FXNg06ssKZeobSAxgElcW4ZSPhooFzUdZl612JF6V2XfslvXziSytT+yYY+b?=
 =?us-ascii?Q?X775E5apU+P/DkhH/VgKvjucgSiKcafNK04rat7+iTHTqkCj2ppbl4I/OAZv?=
 =?us-ascii?Q?ldSyeqWaoREE44/4ZRJnYesjZtMS0MB5n4Vfvq77wqg62di5INSkV5VAWpPM?=
 =?us-ascii?Q?en0uTYoBqOf6Malarj6qd0iqoxDfzb0ob+epNcY0eiiqKYwh5eVri380TvRs?=
 =?us-ascii?Q?HKxeTRtxKoZRsXvV1qy4gMnekdZx6mJaDSVx1h7uLNMOsUMysJFhuypAjVX1?=
 =?us-ascii?Q?8axloL4A+3FhnnS7HGKh8Tucuiiz/ws7vjeOPk9U3oY9ImCO6NcTru3Q7OKf?=
 =?us-ascii?Q?CRL4kiL3LddBohzdaukaHy13SBzM1NEUfrTjP6K0Q2c23nS4Q3zYj4UK7VDO?=
 =?us-ascii?Q?WwLJE7lzFjipA7ioE6PNlwNXp+WkhRxF4W2o5xWnPA4e+N/1kns3J+wUVFGq?=
 =?us-ascii?Q?/XFbpZVWhDLOeH8JgiqgKQG9mUZU1jp0grKDaezRU8wfTCDnfjQ7loDz9eoh?=
 =?us-ascii?Q?xnRLAuuC2Q+Vt4IHEC1K0AU9Ra2HQa3X23Vz703aUYo6kjjuUpU85rEASLCX?=
 =?us-ascii?Q?8mSchHVUuzZT0vvmXi+K2Jo6isPd6bncjrdJOKzKjEuPc69EaXArb0122BcQ?=
 =?us-ascii?Q?qkQmPWymD5QDK5tBSRLvfAndH68c1H3b8B5S+zbbuldarsFqeqziCH0ndJqE?=
 =?us-ascii?Q?dt50MktFqez4gC4mfmc4pIWDQXUsLKxRHsrFAImYV8YR3YGuzk8kNLaVFeBq?=
 =?us-ascii?Q?Be89lgmf5lLo7JNrCUjgGOcaEdehfqJPcJuuM5b38ffLZcrRcGdDn8CX0Ef7?=
 =?us-ascii?Q?qjLRLWhnTjZ50MvvKLrS6mLmLBygqzpUNNtKdP3dRqPmQx7iS0rMzaHwPgjF?=
 =?us-ascii?Q?2FXSTZqUZOuBW99odBS2kziyJi9YdI8PYei3SD9T1RpaRgkRQVxmoaQ5DZra?=
 =?us-ascii?Q?U/9DkxoJEKCN/i5wHmcOSxqKRsFotYE4ngQeXuvEEiqCnsIS0XtrHtz8onRi?=
 =?us-ascii?Q?ofbnxQ7cOjTvDqDFSITZtU9U683TWpo4fTwDhzwOOOEqaJOBeY8uu4vOogdd?=
 =?us-ascii?Q?yeliVYR49wEwJaZE4bUGGMUD987/oPe8uC5ikIhgKrtVtysVdm4D9oiMx8l8?=
X-MS-Exchange-AntiSpam-MessageData-1: jw4m3xsmwgapdRS48yve2b/udKSvjcgbpF8=
X-Exchange-RoutingPolicyChecked:
	AZSf4yNfmPPOQg0JNhcKLU3A1VVsELQtU/kIp0bVAZlNnd1im1tv1L9nnFYp6QYKQdGFVRwdHuhid079NI8h2V8IwrXs/R1NzMiekLdu4ddzQVVexBYffWkQ1Sf45W3lt0cBHmaC68zCGPr+paY2hmTQvGE/GBqXsG2agT9r6yXgh8UnT5AIzYiEktvcZOFC78s2804bNdIcnq0z5ojgLDTBlbBW5X+eQyzGtZG1dPdKt0rm1UuBphoTjcRSGSBFePJWlE1jY8O/CvGYWewGn1XrFvYRC2j2pu49D1m1Va0hUb2KYUbj0UAYEaSmokJ8MHTL15d/9J4OZagUiT/FFw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c6fwI1EsOt7v5QGZWMPt2wiEMX/epHWnbMs+aPwPzvwgFn3XVWtrlyS00ON9pJ7Cv+Zx5AEkOmiMwL0Qo7EsbZVFTMgnt/3LRxahLKuY8zEzgkXe+1wmJbs5JNVq3ANH4EGIJJ32Xy7CjAetXzHb6PdeTPSeab0q2OFOlcb89HpiUGYIRtr5U8ybY2LcgOXl2rroxPGNMbLwH/HurOryvS/y+C0btl/SWESSrUXN05re1f4fmEam2n5nQ8jPvo2iI/LcpFYNNSRaT555RlcPsiRNtEnLn+7pRItHH/n268wfGnibbHiXv/KUZVkjG5YgMGp3pI7e8fp+ZueClvmkrQ7fcFMGNk+IYxu6tEXRqha0OAGlnLq1ki1BHyWkXiU8sBPRlRVBgy3Y98UXvko+sxV44jjeQjJUZLqfCTfgnJy9z5/JII2J+j2s5+MnxKqrViHArjO3t2PNZGUu25ohGa4KQk1S0VQ7tBjIVInRjGMBni8uqSJC1PioD0ihN/FdcUOf4t0P1CkokRuxU8tq48bh1CXsYEI5tor83t1iAq51AZJHrsbyPyprndjYlLQ0ZCgVCG6vKevKlHJX20NvDiEDNfmgCuepp98urB9IHiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d818e1-b48f-4d84-958c-08df1fcb85d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:49.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1d8Mszex0Chrvqp/ZLjfWxnB+euolUWA+kh0NaENj6CRHsWHvpmDGY9c/W/blzG1qJcMbAuR1aJZijJGEXW8QcVqseaHLriGqOm6g5MyTso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX9515zeiSode/
 d2oXdc3L8qeCeSXjRxOsKx8MflohjLpb3yojjtjOnywUTJqegxM9LSTlbX+GPefdIshCWGcisZU
 VhZePWwSzR4oKi9oWqNr3yTJYvu6AWB84hWn9KsfNVbjrf5JszXg
X-Authority-Analysis: v=2.4 cv=W9itxhWk c=1 sm=1 tr=0 ts=6abe7391 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=enrBDRFgs7ZS5x2qv6kA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-GUID: WIKNye5y-DQfAo3msmX1t8n_8On_AS9a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX7dQyhniRjR16
 3WXT7T1GTNL4kOo1lhR531IO5aiDfAvgkUvjeH12kxQ3yurGD4QJd6UaOZOkCWZtKH4vZiRZ10v
 80aimcMDAQ5tK/0KG+JPDp7V257a8/nuVSuynzYH+h+mDm55nQWbi160xMHGof/BEyHezYe0mDy
 xmZTemyATv9+wa3DyiDapS44y6P2WF3Hy1ojP8Ee9qQ4tCs2W+L66XU3tGo6osDizcRcwiYeT+Q
 gzj0cMrWD6Y0Yq6mWpUJiPdMNvyvG+IArFBmBh8LX52cyu4EYnTnWC9nRDRVm8YWyTdd6GDAHgD
 WuzWrQ8iYp1/9Lhj3eJcpH/I6SYvjuXOb567BmWYZbWnETHltpYRn/+/pK9TLvKwe1c3GF+yb1K
 UOQ27ZEYjprCK8048p/UAIEt5uANgTOpERYv/a+xrUFNjJ+For+//dMSIG0uMOW0IYPZvR9csZp
 f+hRVrzFOhPyNsBnvOfvSb7DscvJ/6rzbUV+w35o=
X-Proofpoint-ORIG-GUID: WIKNye5y-DQfAo3msmX1t8n_8On_AS9a

From: "Darrick J. Wong" <darrick.wong@oracle.com>

When we recover a bmap intent from the log, we need to validate its
contents before we try to replay them.  Hoist the checking code into a
separate function in preparation to refactor this code to use validation
helpers.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
(cherry picked from commit bc525cf455dac810d28f9edd379805dc249bc5a9)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_bmap_item.c | 74 +++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index a3b350437db2..88d28a862f52 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -418,6 +418,49 @@ const struct xfs_defer_op_type xfs_bmap_update_defer_type = {
 	.cancel_item	= xfs_bmap_update_cancel_item,
 };
 
+/* Is this recovered BUI ok? */
+static inline bool
+xfs_bui_validate(
+	struct xfs_mount		*mp,
+	struct xfs_bui_log_item		*buip)
+{
+	struct xfs_map_extent		*bmap;
+	xfs_fsblock_t			startblock_fsb;
+	xfs_fsblock_t			inode_fsb;
+
+	/* Only one mapping operation per BUI... */
+	if (buip->bui_format.bui_nextents != XFS_BUI_MAX_FAST_EXTENTS)
+		return false;
+
+	bmap = &buip->bui_format.bui_extents[0];
+	startblock_fsb = XFS_BB_TO_FSB(mp,
+			XFS_FSB_TO_DADDR(mp, bmap->me_startblock));
+	inode_fsb = XFS_BB_TO_FSB(mp, XFS_FSB_TO_DADDR(mp,
+			XFS_INO_TO_FSB(mp, bmap->me_owner)));
+
+	if (bmap->me_flags & ~XFS_BMAP_EXTENT_FLAGS)
+		return false;
+
+	switch (bmap->me_flags & XFS_BMAP_EXTENT_TYPE_MASK) {
+	case XFS_BMAP_MAP:
+	case XFS_BMAP_UNMAP:
+		break;
+	default:
+		return false;
+	}
+
+	if (startblock_fsb == 0 ||
+	    bmap->me_len == 0 ||
+	    inode_fsb == 0 ||
+	    startblock_fsb >= mp->m_sb.sb_dblocks ||
+	    bmap->me_len >= mp->m_sb.sb_agblocks ||
+	    inode_fsb >= mp->m_sb.sb_dblocks ||
+	    (bmap->me_flags & ~XFS_BMAP_EXTENT_FLAGS))
+		return false;
+
+	return true;
+}
+
 /*
  * Process a bmap update intent item that was recovered from the log.
  * We need to update some inode's bmbt.
@@ -434,47 +477,24 @@ xfs_bui_item_recover(
 	struct xfs_mount		*mp = lip->li_mountp;
 	struct xfs_map_extent		*bmap;
 	struct xfs_bud_log_item		*budp;
-	xfs_fsblock_t			startblock_fsb;
-	xfs_fsblock_t			inode_fsb;
 	xfs_filblks_t			count;
 	xfs_exntst_t			state;
 	unsigned int			bui_type;
 	int				whichfork;
 	int				error = 0;
 
-	/* Only one mapping operation per BUI... */
-	if (buip->bui_format.bui_nextents != XFS_BUI_MAX_FAST_EXTENTS)
+	if (!xfs_bui_validate(mp, buip)) {
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+				&buip->bui_format, sizeof(buip->bui_format));
 		return -EFSCORRUPTED;
+	}
 
-	/*
-	 * First check the validity of the extent described by the
-	 * BUI.  If anything is bad, then toss the BUI.
-	 */
 	bmap = &buip->bui_format.bui_extents[0];
-	startblock_fsb = XFS_BB_TO_FSB(mp,
-			   XFS_FSB_TO_DADDR(mp, bmap->me_startblock));
-	inode_fsb = XFS_BB_TO_FSB(mp, XFS_FSB_TO_DADDR(mp,
-			XFS_INO_TO_FSB(mp, bmap->me_owner)));
 	state = (bmap->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
 			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
 	whichfork = (bmap->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
 			XFS_ATTR_FORK : XFS_DATA_FORK;
 	bui_type = bmap->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
-	switch (bui_type) {
-	case XFS_BMAP_MAP:
-	case XFS_BMAP_UNMAP:
-		break;
-	default:
-		return -EFSCORRUPTED;
-	}
-	if (startblock_fsb == 0 ||
-	    bmap->me_len == 0 ||
-	    inode_fsb == 0 ||
-	    startblock_fsb >= mp->m_sb.sb_dblocks ||
-	    bmap->me_len >= mp->m_sb.sb_agblocks ||
-	    inode_fsb >= mp->m_sb.sb_dblocks ||
-	    (bmap->me_flags & ~XFS_BMAP_EXTENT_FLAGS))
-		return -EFSCORRUPTED;
 
 	/* Grab the inode. */
 	error = xfs_iget(mp, NULL, bmap->me_owner, 0, 0, &ip);
-- 
2.53.0

