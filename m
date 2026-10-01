Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C2528433;
	Thu,  1 Oct 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866386; cv=fail; b=lcMGXKLXOUWXJRy+zGdHev50SvQKJbULz7CEiom8u4L/YpGudtmQCRhx9vwlvbReLt3OP6na3wwj7OHVHTWNiMY22hOonG7SaepytuqQ+osYdrdN2PRTk1er+OAglr9WMvUkWV0lMC26tqe3kfGDvbR1rjvlF7CLEdUyC7h3vjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866386; c=relaxed/simple;
	bh=emW44mA64NMaqCYDzQ5QAos4YIRnffdly9YBdTsf2zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sW0I0FZzB0CxTSehtnrOeq1XvaM8RlDyqhgyjqI8AuBKz2dWRVP3Abo17WJ2B0kNeceR+cC61ETONNgy73/fgGN8LjL6lOWcH/qo2vMx/BoidF+p5UMTVTTK0YZcRgYPjcnThHe/35wGYMLufC7vO/AlenXCvksQxZ9stRXi2jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQs3peiw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i0OzSHhZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQs3peiw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i0OzSHhZ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMcfQ539266;
	Thu, 1 Oct 2026 14:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CFftGCHDvDnERBZoHEXtjsYPNy8xUirCR0ggbbh47y8=; b=
	cQs3peiwVZzas6Zpzfc0U4CVhZUDxVVvVW4DUy6VIMrXX6RAo/34P7Ui5ZEnj4Ve
	Cne7+/i4Wv25rsP4mTuR2GDHkw1OjIT38AVCAwvFCULoCwi8tgtLaotpfo7oFfP3
	2/CLYTZU9nX41S5Ye6+fxlIBtN+PLTSWRL3E4RkyA1HxWlF3qa4LSZrUnKS4UhTi
	AY6rhvevUEWhbD2toITM3kbfC2tKLTUzSg7SIIul01mRpYCHsOu3R7lZEJwYp6et
	oe36Q0FOrHORRP0XFoQBMupK8nkvfDzJbzIyyX1mQ3PiceRa6Ci00D3BqaKGdVzF
	LdcT1VvBRU/Qv550UI7K0A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgyq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoUTN031897;
	Thu, 1 Oct 2026 14:52:57 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd45m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+X3A/OrI6q3XDLzuXuIZV/oNuk4S+5w+pws/WKLmtvcKTIOUwibZpxYqaaMniPEnVDu8WjApDS6au9C8T2AGux6i25IGKJxnVBuGuLMjKq/MzFbUczUUEQURwSfZjFkofSrZ2SxzW4iPcX/M9NAXnx6D93WMJE757Bz2JeRJRPwO+xQmHRnOPVD9KtpTO+x9ZxGK1QMhi4P9sY89Y7R6/URw5VKLZjRpkduNG61PXWjJYr06M0Bpe4jSThHPGAAWB1z0RaIOIKDanVDDvXcav5qpaUBmQCEUY/1Bh5E1/vjxg434AskZPob8E/mnqBuE7W3ndQ/K4Gwrx2q+OVxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFftGCHDvDnERBZoHEXtjsYPNy8xUirCR0ggbbh47y8=;
 b=zM/BEIJJ6QteTpnzGb6fS88H+OamH+3hLF7IxT90k1VzBzEGxJPSLrPuaqabwdC+5DeOAo39isOa1QZs47X9qPXmxetl9j+SyafAvImDq0E0illWRwoG2qVaqBU0JrbJNgPL0sHaCEaz0/oHL2B1FcxtIndCWR/60jFNBuQmhIp+eZbtBXQ4Tto9Jmluut7xsp1woJD9IkY2ZXHmiHnWSwAVOV5ojQjrXy3OlTvbF7GS6qPfKUCG4snVw0vsCQRPmRHOg4iXfVfXge//wv4gZIHYed8vlkICJcKxmfKZr4Gl6D53B0EoXdiKQC7T4Tt3lGfJF0Q+A/+fGmHNNRkXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFftGCHDvDnERBZoHEXtjsYPNy8xUirCR0ggbbh47y8=;
 b=i0OzSHhZXudMnB1r6xx1A6EmKwpK9ayGRt2vjUuYHvjouYrGwcgZmUYadIGNI/4zJLC8gG1EKKbxikekWIBjyZqjIk+7GijWnXR2HrH0i0hTl8Bi2FBwifdEXQlcbJ3aczYTbW0+xfBhqcgZJu0qQc71Q0gDcbbv3/bggj1QdY8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:52:54 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:54 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 11/21] xfs: remove xfs_buf_t typedef
Date: Thu,  1 Oct 2026 20:21:24 +0530
Message-ID: <e6db2355d9b08513fd9da1fd5452e6002ab462c8.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25b::7) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: bdca7abc-b698-4317-3c42-08df1fcbac0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|260925021911599003|260925022911599003|260925021311599003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	7RwCQHlp+SvyBvGjdZ1yXvna3hKENeOchuoryB77UWJMw3sEkw8ZfHWokRMUbfhwBn9c7SgiUSiFSEUPiFnvOvjjhI13Bt7chEtfD+IeRvbiXA3u4O+CR23cCG5kxxoeb3+b8c9CfzKg00SEXxblRd+S4aPXoKZnp7hgp+xMSPjPtlt4x2/9KtaWYPmgz/Rp+H5MhHrJikLITf8vjy9uU5bT5xwxlchAp53WHrWxdIMybBlChFiokLvD2zcQH/mOMEITFIvphPfSAv7zZO9WcaLDa1KKA8+tn/kAGVoJVMbO0dzQyixZaYjVLDOtOCk1wVPp4xxhRe1qwnD7WY9YtV9+Z9uVftaI268p5Jhin3foEFML9LtpUfHQOzzKjSBmqcm5IXF77wdGgt8sHW6d7dEHLce/cYoMq96y5+6efYw9cEz4Cn+8f6XpZtuGLP2o58WxmylTlWaIZrW84UjKO2nYjFdm0y+EANoKbEBUXG9zkGfB/aW+a0QgP5/b3f8+VD7dtCCPRUukjW7xvw0gGO5xOLJz6tameajQFWRH9+1t9YlyfR4At3LyRxkTfVDBGTWEqhrHlLtaFBO+9qHUyc6fFe3tZWQpf1adANvmNgi3BHl8IuElJqzK+bUyldoAmCaAxvzfUJK1FbYW8m+kBxHoKbgyZ6PxUBlxikM92Qw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tHx5Z5BytXC21eyRvAKBe1yzNbeUbexAe6FLIbdm1KMwTwqortEFoBgzKZ6o?=
 =?us-ascii?Q?c8FnDtXTIttN3ysyR/JkCzRChA3iiVVawS3zRll7RmTuzg4aGY48243dMnbY?=
 =?us-ascii?Q?5Bozgvt21TYAZrlS/oBPCy89cDBZ34CxNyFUvGVEdEwwprXkqDSEGwFuRobD?=
 =?us-ascii?Q?LC2fwxwmtk/8frSXJrgnF3GVNvcksMMfjKxU7STpYxNylJN5icJ4yq5K0l6F?=
 =?us-ascii?Q?d4LbdD5eg5MkFNQ+TandZ+VfM8iqp8iTkAKErSyG92ODHldfH55zG81dGGnF?=
 =?us-ascii?Q?7DIPgXuS2UJUjtUiZFoGh4fInDDkFX8Oo/ChMBQMAzk7VEgm6aFRwgJVZz0H?=
 =?us-ascii?Q?3Z+ue7mBwdzu9uFp3c43peu9GVIDys5pwcMV04SDPlxkBF2320HiLeJwpsRu?=
 =?us-ascii?Q?calFaF0zpLGvmr4nTFTtFOqjAlQsj1W0J5x1zY0Zl+pqKJu12vufhRMSl+99?=
 =?us-ascii?Q?K7Frdin39JGqH9qfsRKY4w9xE58egtztxf0kL3LhtpVbfNezXUibvIhFHfoT?=
 =?us-ascii?Q?k1vuC/ikTSSSDcLAZ78vP0h6I/IUN+JwWz9dKe2dwpqm4we+Jab3+mzSUBBe?=
 =?us-ascii?Q?TGYfiZcKoKrh1mgrA1hBFhfqU9AN8bQ12XkXcnIiStijV1xwoGjYKyoNfS6Z?=
 =?us-ascii?Q?bCiguGdFfG5Nins3UMPNWsz/uA2mK4OE8DN6OjOQ7Z06iKNNfCDH4f1naW0i?=
 =?us-ascii?Q?Wh3pjctlcPQItYGkLM1HxI1GIgEcAnLmZNEPCUw/dI/v5WIeXuoK5j5VR/n+?=
 =?us-ascii?Q?tnTVzWTDTcVAoVE//rCZdmRwV2fPGw1ETED7OMfYzV0r8OdkenZfayzyTeNH?=
 =?us-ascii?Q?Z7hrB8dEUGtE5i1hM2gnFtDcXrJm43LzyeqFfpV6y/brROXZdAPY6RXpcujL?=
 =?us-ascii?Q?DRi/oBPII1wuNUED3Y7XdtxMYKbgsUS+jAqNbH1ZUwWqPN9tFnCAB1BkaCI/?=
 =?us-ascii?Q?kwOPJvoaVWpAcr3Qlqc9eJoyvu5zulrRaF/XX1DxKMdGlMalP5lJt22YTR2R?=
 =?us-ascii?Q?ZOHSAhnJey4FXGKGVpZxv7P4Yfj5sx6FfzsNPqRLPd3IrhFL60A58wwDljC+?=
 =?us-ascii?Q?QEUBjjvs80XKE7q3pLzMpZjIvJiTDer6WcKlMYUQhP0JKr8ipL++e/LRjRdw?=
 =?us-ascii?Q?4BwZezXfcnk3QZaMIl4FP1Db86sca2M2DnSBvy0A182cRowasd7GulNISnbL?=
 =?us-ascii?Q?3Q3MHFue42x5yPWsoQemBsTWuLQm84W9pUKr0ZCXst6yOtuzLL1RyFy2tHyG?=
 =?us-ascii?Q?pnLy4WL2UiPR8kImvS7pbN7OOOYHrau2FQ8vu+crJHl/ymRbsSAhrFJyyqZV?=
 =?us-ascii?Q?9ItAYff8oJR9qGVkDz2A8eVhZv4KTu0CoOog5oO/LmajXjuwt9+5nfSP0CgL?=
 =?us-ascii?Q?XJznKR+DHfhCboe2sj19OC8xkmaWDIa6zEgGqM3LRotSIDjw7Tj1bgJwS1vT?=
 =?us-ascii?Q?WNhIdKHJ1rLF2meFs8jWpIIEEy05Xo7wtu7CI2TlLhUjnwShB+THvkQQ9X1A?=
 =?us-ascii?Q?KgacmDWF/j11YtD9V3z5YoAiEaLofzPXOs/nzSNPGqnc3zop6LDb4cTooktL?=
 =?us-ascii?Q?La9WtB/BlmfqQx6TcqEKumrrFhNE9rmlfdH1QYt3pKwKEsgehr3aTUr4MPyR?=
 =?us-ascii?Q?wpVjEwMPQv7OOeuE3CPRSjhjAW8DDxm13qq6TOcaYI54YZA/ygK96IfAzI+L?=
 =?us-ascii?Q?+nht1RUu35RudY8zg81pcT4/SMyOcK+NTbqt5ENuxaRs6qvepv4/ymHQ8sOT?=
 =?us-ascii?Q?himaytNTMosdiL8UfJ23/L59ooI4mzpsd7qzgwM7sAV4sYfcavXiuewEA1TL?=
X-MS-Exchange-AntiSpam-MessageData-1: cf6TMv/8kzM3mwJ59B0nPhwzw7qfD47XRVw=
X-Exchange-RoutingPolicyChecked:
	r0JUUjguVzu5oYT1EeY5jAAHZ0uXEIkeV6NQVF6id0iNxJ2a8Q+efBfYXzNH2AWgIfbOG4vbcQa+v4yApnzUIRYfcnZcuWGgmdAlcP4NoFODyXAwkJUBo/hgXL50GARWO1KHh7lvxoc1p7WjZzRLlrIKsW2PLu6Xl3vTiJlPSuOQkZWWqoOu1otjGDW6Ii6sChroG7i3dmYrREnAv5nhJRFs82KdzkCWz8E/Q/WvQ7rGeuLf0eQMSJ9n2nL79hDtpMQAiSKD4GtFu39S4YZW4oLw3Bw8D15CqfX+1+R1IiTGhdp/aaeYfKlmZAvPluCV+02yiKAWwvXTITlQvC6HtA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ApBe82Ug2iVgv5FebFKfAi1Xf62mltDY6SkK+uarlO0avdPPFxEB6OoMhU7UVuaD5uhhZ8Ujn/0+21yAAck7y5FRD6CgrUawwthrADybSuItodXF/aXngbte63AkMs8Xb+oEVltjO8OT9DOJxD7Kd4r3oFiyqg2qqYIkJuLTKhryCM+S+H1rGXOMel3mS2GpqSIfSlY2IyGH6IcDjn4Z/dWDb3gDhCR4Bi2yAHr6Px9lf1mNTYMiAYW4omvNqnJl4M14gr4MpXDDSijBKv6+i24v7S0A36hgNrvD1rnawE4JvMU6IHjNqnlIvgk+hQpeu6U4bnKeaPFeUoABYkCOCygm1P607j+BQETxX2HdY4Ldfchr7la9Tl7OCt1OEbxGPflAn8CRpSW+gChQDWOlR8uts0ffH9Qtu374bJY9odZ54zqqOPhWIQMZPEgtQXKXWLjrxZuKjvzd8nJR0R47ogrhOthjzeyn5dxlCnblo9wDRI702hWozQZOmCO2V9e37HaxOvXdQcwgzFkaj6ueYTeunCbrNYtpiwmSx0u1F3v/GG+X9AydclKmD4KlmYk56v9lp5YAycrqBr1Y8K5uS8BaHjPeDjbi9pfeYP/wMkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdca7abc-b698-4317-3c42-08df1fcbac0e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:53.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRLKtEVH6YaoOH47ok1Ks20Xy2j3zEAAesCtxoPADLwBVyxbrDwxOMTJ2FrLa+Ya9Xxseo94vvYdUOAC5p3+NfgTHDvCLl3pq5Y+FbqMNTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: 9fQH1iZ5jOIVFEN7TxY2hZ9uzW0QQ_PL
X-Proofpoint-GUID: 9fQH1iZ5jOIVFEN7TxY2hZ9uzW0QQ_PL
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe73ca b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=rWiefVkh0gDNh2EwC_cA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX+m1g4CxNIwt0
 A8cWiNKRO5kkHnc4vzczTZBfgxO4ymuGEes3JTpSOleJYgLwGuptlj5U0CATjjsWVwD0+a4IvO3
 DbLtDKiDP+8kAaqBg+yHKDmswRMxVzrt20jdQm5su+9MOwNM/b/B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXyNdeGKEKDyQl
 fE2QpMBVcLQBt+TOqeGjiAQ++WTSsQEcmSvDil8iFP///Lk9e7LkMh/wKltVfAZOGOciCMJd/O/
 f5P3q3YkuXB/8xkdGo2dI7YJVDwqzjoVpX1SzAvKbjeW+cZ7lZixWA//nH9Fce34sD4SUYp5Ujf
 ZniU88SARgdtgTS6E4n76AGcaZ6t0HSRWb5cMMlhnGwvl7qzciFA/QU4AgF6PBk43D0Z6LNdGTD
 RL/JXgDH0yVetkS6FEB2oPCGssxr74+0LvkTEpxUtV2pvh1w1HyIOxO7hu2yLLFf2QVuS2F9vH5
 AiHXOJDO2b++nck2Tj+2yBKkxOyDVwSEDXIl8N6NiiwHgwl97y4E2X14T+C25ZzX8Jv1+OBvyf/
 Me1HG5xFl+/4hoaPxzBsBD9LLusDTLVrT8G8kt2VtgxPUXycV7cu4YWCDepGJqlrNGXY87r7m5d
 CJmonYfHLdzUybjmkvIVohDvzhkD1LJum4EPa2xA=

From: Dave Chinner <dchinner@redhat.com>

Prepare for kernel xfs_buf  alignment by getting rid of the
xfs_buf_t typedef from userspace.

[darrick: This patch is a port of a userspace patch removing the
xfs_buf_t typedef in preparation to make the userspace xfs_buf code
behave more like its kernel counterpart.]

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
(cherry picked from commit e82226138b20d4f638426413e83c6b5db532c6a2)
Stable-dep-of: d2fe5c4c8d25 ("xfs: rearrange code in xfs_buf_item.c")

5.10:

2 extra conversions in fs/xfs/xfs_inode.c due to missing:
	1abcf261016e ("xfs: move on-disk inode allocation out of xfs_ialloc()")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c    | 16 ++++++++--------
 fs/xfs/libxfs/xfs_bmap.c     |  6 +++---
 fs/xfs/libxfs/xfs_btree.c    | 10 +++++-----
 fs/xfs/libxfs/xfs_ialloc.c   |  4 ++--
 fs/xfs/libxfs/xfs_rtbitmap.c | 22 +++++++++++-----------
 fs/xfs/xfs_buf.c             | 24 ++++++++++++------------
 fs/xfs/xfs_buf.h             | 14 +++++++-------
 fs/xfs/xfs_buf_item.c        |  4 ++--
 fs/xfs/xfs_fsops.c           |  2 +-
 fs/xfs/xfs_inode.c           |  4 ++--
 fs/xfs/xfs_log_recover.c     |  8 ++++----
 fs/xfs/xfs_rtalloc.c         | 20 ++++++++++----------
 fs/xfs/xfs_rtalloc.h         |  4 ++--
 fs/xfs/xfs_symlink.c         |  4 ++--
 fs/xfs/xfs_trans.c           |  2 +-
 fs/xfs/xfs_trans_buf.c       | 16 ++++++++--------
 16 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 15640015be9d..7cb9f064ac64 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -690,9 +690,9 @@ xfs_alloc_read_agfl(
 	xfs_mount_t	*mp,		/* mount point structure */
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_agnumber_t	agno,		/* allocation group number */
-	xfs_buf_t	**bpp)		/* buffer for the ag free block array */
+	struct xfs_buf	**bpp)		/* buffer for the ag free block array */
 {
-	xfs_buf_t	*bp;		/* return value */
+	struct xfs_buf	*bp;		/* return value */
 	int		error;
 
 	ASSERT(agno != NULLAGNUMBER);
@@ -2647,12 +2647,12 @@ xfs_alloc_fix_freelist(
 int				/* error */
 xfs_alloc_get_freelist(
 	xfs_trans_t	*tp,	/* transaction pointer */
-	xfs_buf_t	*agbp,	/* buffer containing the agf structure */
+	struct xfs_buf	*agbp,	/* buffer containing the agf structure */
 	xfs_agblock_t	*bnop,	/* block address retrieved from freelist */
 	int		btreeblk) /* destination is a AGF btree */
 {
 	struct xfs_agf	*agf = agbp->b_addr;
-	xfs_buf_t	*agflbp;/* buffer for a.g. freelist structure */
+	struct xfs_buf	*agflbp;/* buffer for a.g. freelist structure */
 	xfs_agblock_t	bno;	/* block number returned */
 	__be32		*agfl_bno;
 	int		error;
@@ -2711,7 +2711,7 @@ xfs_alloc_get_freelist(
 void
 xfs_alloc_log_agf(
 	xfs_trans_t	*tp,	/* transaction pointer */
-	xfs_buf_t	*bp,	/* buffer for a.g. freelist header */
+	struct xfs_buf	*bp,	/* buffer for a.g. freelist header */
 	int		fields)	/* mask of fields to be logged (XFS_AGF_...) */
 {
 	int	first;		/* first byte offset */
@@ -2757,7 +2757,7 @@ xfs_alloc_pagf_init(
 	xfs_agnumber_t		agno,	/* allocation group number */
 	int			flags)	/* XFS_ALLOC_FLAGS_... */
 {
-	xfs_buf_t		*bp;
+	struct xfs_buf		*bp;
 	int			error;
 
 	error = xfs_alloc_read_agf(mp, tp, agno, flags, &bp);
@@ -2772,8 +2772,8 @@ xfs_alloc_pagf_init(
 int					/* error */
 xfs_alloc_put_freelist(
 	xfs_trans_t		*tp,	/* transaction pointer */
-	xfs_buf_t		*agbp,	/* buffer for a.g. freelist header */
-	xfs_buf_t		*agflbp,/* buffer for a.g. free block array */
+	struct xfs_buf		*agbp,	/* buffer for a.g. freelist header */
+	struct xfs_buf		*agflbp,/* buffer for a.g. free block array */
 	xfs_agblock_t		bno,	/* block being freed */
 	int			btreeblk) /* block came from a AGF btree */
 {
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index de9c27ef68d8..5483572512ed 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -321,7 +321,7 @@ xfs_bmap_check_leaf_extents(
 	struct xfs_ifork	*ifp = XFS_IFORK_PTR(ip, whichfork);
 	struct xfs_btree_block	*block;	/* current btree block */
 	xfs_fsblock_t		bno;	/* block # of "block" */
-	xfs_buf_t		*bp;	/* buffer for "block" */
+	struct xfs_buf		*bp;	/* buffer for "block" */
 	int			error;	/* error return value */
 	xfs_extnum_t		i=0, j;	/* index into the extents list */
 	int			level;	/* btree level, for checking */
@@ -592,7 +592,7 @@ xfs_bmap_btree_to_extents(
 	struct xfs_btree_block	*rblock = ifp->if_broot;
 	struct xfs_btree_block	*cblock;/* child btree block */
 	xfs_fsblock_t		cbno;	/* child block number */
-	xfs_buf_t		*cbp;	/* child block's buffer */
+	struct xfs_buf		*cbp;	/* child block's buffer */
 	int			error;	/* error return value */
 	__be64			*pp;	/* ptr to block address */
 	struct xfs_owner_info	oinfo;
@@ -830,7 +830,7 @@ xfs_bmap_local_to_extents(
 	int		flags;		/* logging flags returned */
 	struct xfs_ifork *ifp;		/* inode fork pointer */
 	xfs_alloc_arg_t	args;		/* allocation arguments */
-	xfs_buf_t	*bp;		/* buffer for extent block */
+	struct xfs_buf	*bp;		/* buffer for extent block */
 	struct xfs_bmbt_irec rec;
 	struct xfs_iext_cursor icur;
 
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 0926363179a7..aaa59daa77d0 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -394,7 +394,7 @@ xfs_btree_dup_cursor(
 	xfs_btree_cur_t	*cur,		/* input cursor */
 	xfs_btree_cur_t	**ncur)		/* output cursor */
 {
-	xfs_buf_t	*bp;		/* btree block's buffer pointer */
+	struct xfs_buf	*bp;		/* btree block's buffer pointer */
 	int		error;		/* error return value */
 	int		i;		/* level number of btree block */
 	xfs_mount_t	*mp;		/* mount structure for filesystem */
@@ -698,7 +698,7 @@ xfs_btree_firstrec(
 	int			level)	/* level to change */
 {
 	struct xfs_btree_block	*block;	/* generic btree block pointer */
-	xfs_buf_t		*bp;	/* buffer containing block */
+	struct xfs_buf		*bp;	/* buffer containing block */
 
 	/*
 	 * Get the block pointer for this level.
@@ -728,7 +728,7 @@ xfs_btree_lastrec(
 	int			level)	/* level to change */
 {
 	struct xfs_btree_block	*block;	/* generic btree block pointer */
-	xfs_buf_t		*bp;	/* buffer containing block */
+	struct xfs_buf		*bp;	/* buffer containing block */
 
 	/*
 	 * Get the block pointer for this level.
@@ -990,7 +990,7 @@ STATIC void
 xfs_btree_setbuf(
 	xfs_btree_cur_t		*cur,	/* btree cursor */
 	int			lev,	/* level in btree */
-	xfs_buf_t		*bp)	/* new buffer to set */
+	struct xfs_buf		*bp)	/* new buffer to set */
 {
 	struct xfs_btree_block	*b;	/* btree block */
 
@@ -1633,7 +1633,7 @@ xfs_btree_decrement(
 	int			*stat)		/* success/failure */
 {
 	struct xfs_btree_block	*block;
-	xfs_buf_t		*bp;
+	struct xfs_buf		*bp;
 	int			error;		/* error return value */
 	int			lev;
 	union xfs_btree_ptr	ptr;
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 7e8ba9698aba..8fcb5c6810e9 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -2454,7 +2454,7 @@ xfs_imap(
 void
 xfs_ialloc_log_agi(
 	xfs_trans_t	*tp,		/* transaction pointer */
-	xfs_buf_t	*bp,		/* allocation group header buffer */
+	struct xfs_buf	*bp,		/* allocation group header buffer */
 	int		fields)		/* bitmask of fields to log */
 {
 	int			first;		/* first byte number */
@@ -2675,7 +2675,7 @@ xfs_ialloc_pagi_init(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_agnumber_t	agno)		/* allocation group number */
 {
-	xfs_buf_t	*bp = NULL;
+	struct xfs_buf	*bp = NULL;
 	int		error;
 
 	error = xfs_ialloc_read_agi(mp, tp, agno, &bp);
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index 6c1aba16113c..fe3a49575ff3 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -56,9 +56,9 @@ xfs_rtbuf_get(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_rtblock_t	block,		/* block number in bitmap or summary */
 	int		issum,		/* is summary not bitmap */
-	xfs_buf_t	**bpp)		/* output: buffer for the block */
+	struct xfs_buf	**bpp)		/* output: buffer for the block */
 {
-	xfs_buf_t	*bp;		/* block buffer, result */
+	struct xfs_buf	*bp;		/* block buffer, result */
 	xfs_inode_t	*ip;		/* bitmap or summary inode */
 	xfs_bmbt_irec_t	map;
 	int		nmap = 1;
@@ -101,7 +101,7 @@ xfs_rtfind_back(
 	xfs_rtword_t	*b;		/* current word in buffer */
 	int		bit;		/* bit number in the word */
 	xfs_rtblock_t	block;		/* bitmap block number */
-	xfs_buf_t	*bp;		/* buf for the block */
+	struct xfs_buf	*bp;		/* buf for the block */
 	xfs_rtword_t	*bufp;		/* starting word in buffer */
 	int		error;		/* error value */
 	xfs_rtblock_t	firstbit;	/* first useful bit in the word */
@@ -276,7 +276,7 @@ xfs_rtfind_forw(
 	xfs_rtword_t	*b;		/* current word in buffer */
 	int		bit;		/* bit number in the word */
 	xfs_rtblock_t	block;		/* bitmap block number */
-	xfs_buf_t	*bp;		/* buf for the block */
+	struct xfs_buf	*bp;		/* buf for the block */
 	xfs_rtword_t	*bufp;		/* starting word in buffer */
 	int		error;		/* error value */
 	xfs_rtblock_t	i;		/* current bit number rel. to start */
@@ -447,11 +447,11 @@ xfs_rtmodify_summary_int(
 	int		log,		/* log2 of extent size */
 	xfs_rtblock_t	bbno,		/* bitmap block number */
 	int		delta,		/* change to make to summary info */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb,		/* in/out: summary block number */
 	xfs_suminfo_t	*sum)		/* out: summary info for this block */
 {
-	xfs_buf_t	*bp;		/* buffer for the summary block */
+	struct xfs_buf	*bp;		/* buffer for the summary block */
 	int		error;		/* error value */
 	xfs_fsblock_t	sb;		/* summary fsblock */
 	int		so;		/* index into the summary file */
@@ -517,7 +517,7 @@ xfs_rtmodify_summary(
 	int		log,		/* log2 of extent size */
 	xfs_rtblock_t	bbno,		/* bitmap block number */
 	int		delta,		/* change to make to summary info */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb)		/* in/out: summary block number */
 {
 	return xfs_rtmodify_summary_int(mp, tp, log, bbno,
@@ -539,7 +539,7 @@ xfs_rtmodify_range(
 	xfs_rtword_t	*b;		/* current word in buffer */
 	int		bit;		/* bit number in the word */
 	xfs_rtblock_t	block;		/* bitmap block number */
-	xfs_buf_t	*bp;		/* buf for the block */
+	struct xfs_buf	*bp;		/* buf for the block */
 	xfs_rtword_t	*bufp;		/* starting word in buffer */
 	int		error;		/* error value */
 	xfs_rtword_t	*first;		/* first used word in the buffer */
@@ -690,7 +690,7 @@ xfs_rtfree_range(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_rtblock_t	start,		/* starting block to free */
 	xfs_extlen_t	len,		/* length to free */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb)		/* in/out: summary block number */
 {
 	xfs_rtblock_t	end;		/* end of the freed extent */
@@ -773,7 +773,7 @@ xfs_rtcheck_range(
 	xfs_rtword_t	*b;		/* current word in buffer */
 	int		bit;		/* bit number in the word */
 	xfs_rtblock_t	block;		/* bitmap block number */
-	xfs_buf_t	*bp;		/* buf for the block */
+	struct xfs_buf	*bp;		/* buf for the block */
 	xfs_rtword_t	*bufp;		/* starting word in buffer */
 	int		error;		/* error value */
 	xfs_rtblock_t	i;		/* current bit number rel. to start */
@@ -969,7 +969,7 @@ xfs_rtfree_extent(
 	int		error;		/* error value */
 	xfs_mount_t	*mp;		/* file system mount structure */
 	xfs_fsblock_t	sb;		/* summary file block number */
-	xfs_buf_t	*sumbp = NULL;	/* summary file block buffer */
+	struct xfs_buf	*sumbp = NULL;	/* summary file block buffer */
 
 	mp = tp->t_mountp;
 
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 118819030dbb..78f6f5bce3e0 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -278,7 +278,7 @@ _xfs_buf_alloc(
  */
 STATIC int
 _xfs_buf_get_pages(
-	xfs_buf_t		*bp,
+	struct xfs_buf		*bp,
 	int			page_count)
 {
 	/* Make sure that we have a page list */
@@ -302,7 +302,7 @@ _xfs_buf_get_pages(
  */
 STATIC void
 _xfs_buf_free_pages(
-	xfs_buf_t	*bp)
+	struct xfs_buf	*bp)
 {
 	if (bp->b_pages != bp->b_page_array) {
 		kmem_free(bp->b_pages);
@@ -319,7 +319,7 @@ _xfs_buf_free_pages(
  */
 static void
 xfs_buf_free(
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	trace_xfs_buf_free(bp, _RET_IP_);
 
@@ -352,7 +352,7 @@ xfs_buf_free(
  */
 STATIC int
 xfs_buf_allocate_memory(
-	xfs_buf_t		*bp,
+	struct xfs_buf		*bp,
 	uint			flags)
 {
 	size_t			size;
@@ -463,7 +463,7 @@ xfs_buf_allocate_memory(
  */
 STATIC int
 _xfs_buf_map_pages(
-	xfs_buf_t		*bp,
+	struct xfs_buf		*bp,
 	uint			flags)
 {
 	ASSERT(bp->b_flags & _XBF_PAGES);
@@ -590,7 +590,7 @@ xfs_buf_find(
 	struct xfs_buf		**found_bp)
 {
 	struct xfs_perag	*pag;
-	xfs_buf_t		*bp;
+	struct xfs_buf		*bp;
 	struct xfs_buf_map	cmap = { .bm_bn = map[0].bm_bn };
 	xfs_daddr_t		eofs;
 	int			i;
@@ -762,7 +762,7 @@ xfs_buf_get_map(
 
 int
 _xfs_buf_read(
-	xfs_buf_t		*bp,
+	struct xfs_buf		*bp,
 	xfs_buf_flags_t		flags)
 {
 	ASSERT(!(flags & XBF_WRITE));
@@ -1005,7 +1005,7 @@ xfs_buf_get_uncached(
  */
 void
 xfs_buf_hold(
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	trace_xfs_buf_hold(bp, _RET_IP_);
 	atomic_inc(&bp->b_hold);
@@ -1017,7 +1017,7 @@ xfs_buf_hold(
  */
 void
 xfs_buf_rele(
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	struct xfs_perag	*pag = bp->b_pag;
 	bool			release;
@@ -1161,7 +1161,7 @@ xfs_buf_unlock(
 
 STATIC void
 xfs_buf_wait_unpin(
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	DECLARE_WAITQUEUE	(wait, current);
 
@@ -1373,7 +1373,7 @@ xfs_buf_ioend_work(
 	struct work_struct	*work)
 {
 	struct xfs_buf		*bp =
-		container_of(work, xfs_buf_t, b_ioend_work);
+		container_of(work, struct xfs_buf, b_ioend_work);
 
 	xfs_buf_ioend(bp);
 }
@@ -1388,7 +1388,7 @@ xfs_buf_ioend_async(
 
 void
 __xfs_buf_ioerror(
-	xfs_buf_t		*bp,
+	struct xfs_buf		*bp,
 	int			error,
 	xfs_failaddr_t		failaddr)
 {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index bfd2907e7bc4..5d91a31298a4 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,7 +124,7 @@ struct xfs_buf_ops {
 	xfs_failaddr_t (*verify_struct)(struct xfs_buf *bp);
 };
 
-typedef struct xfs_buf {
+struct xfs_buf {
 	/*
 	 * first cacheline holds all the fields needed for an uncontended cache
 	 * hit to be fully processed. The semaphore straddles the cacheline
@@ -190,7 +190,7 @@ typedef struct xfs_buf {
 	int			b_last_error;
 
 	const struct xfs_buf_ops	*b_ops;
-} xfs_buf_t;
+};
 
 /* Finding and Reading Buffers */
 struct xfs_buf *xfs_buf_incore(struct xfs_buftarg *target,
@@ -253,16 +253,16 @@ int _xfs_buf_read(struct xfs_buf *bp, xfs_buf_flags_t flags);
 void xfs_buf_hold(struct xfs_buf *bp);
 
 /* Releasing Buffers */
-extern void xfs_buf_rele(xfs_buf_t *);
+extern void xfs_buf_rele(struct xfs_buf *);
 
 /* Locking and Unlocking Buffers */
-extern int xfs_buf_trylock(xfs_buf_t *);
-extern void xfs_buf_lock(xfs_buf_t *);
-extern void xfs_buf_unlock(xfs_buf_t *);
+extern int xfs_buf_trylock(struct xfs_buf *);
+extern void xfs_buf_lock(struct xfs_buf *);
+extern void xfs_buf_unlock(struct xfs_buf *);
 #define xfs_buf_islocked(bp) \
 	((bp)->b_sema.count <= 0)
 
-static inline void xfs_buf_relse(xfs_buf_t *bp)
+static inline void xfs_buf_relse(struct xfs_buf *bp)
 {
 	xfs_buf_unlock(bp);
 	xfs_buf_rele(bp);
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 132acdf0aac0..7794bd956861 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -403,7 +403,7 @@ xfs_buf_item_unpin(
 	int			remove)
 {
 	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
-	xfs_buf_t		*bp = bip->bli_buf;
+	struct xfs_buf		*bp = bip->bli_buf;
 	int			stale = bip->bli_flags & XFS_BLI_STALE;
 	int			freed;
 
@@ -931,7 +931,7 @@ xfs_buf_item_free(
  */
 void
 xfs_buf_item_relse(
-	xfs_buf_t	*bp)
+	struct xfs_buf	*bp)
 {
 	struct xfs_buf_log_item	*bip = bp->b_log_item;
 
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 775f833146e3..cb3d54893fbe 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -28,7 +28,7 @@ xfs_growfs_data_private(
 	xfs_mount_t		*mp,		/* mount point for filesystem */
 	xfs_growfs_data_t	*in)		/* growfs data input struct */
 {
-	xfs_buf_t		*bp;
+	struct xfs_buf		*bp;
 	int			error;
 	xfs_agnumber_t		nagcount;
 	xfs_agnumber_t		nagimax = 0;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 2de204f46216..5c04c61964ce 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -799,7 +799,7 @@ xfs_ialloc(
 	xfs_nlink_t	nlink,
 	dev_t		rdev,
 	prid_t		prid,
-	xfs_buf_t	**ialloc_context,
+	struct xfs_buf	**ialloc_context,
 	xfs_inode_t	**ipp)
 {
 	struct inode	*dir = pip ? VFS_I(pip) : NULL;
@@ -956,7 +956,7 @@ xfs_dir_ialloc(
 {
 	xfs_trans_t	*tp;
 	xfs_inode_t	*ip;
-	xfs_buf_t	*ialloc_context = NULL;
+	struct xfs_buf	*ialloc_context = NULL;
 	int		code;
 	void		*dqinfo;
 	uint		tflags;
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 46b1213e8ff3..7cb7a0aa6c9a 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2633,7 +2633,7 @@ xlog_recover_clear_agi_bucket(
 {
 	xfs_trans_t	*tp;
 	xfs_agi_t	*agi;
-	xfs_buf_t	*agibp;
+	struct xfs_buf	*agibp;
 	int		offset;
 	int		error;
 
@@ -2751,7 +2751,7 @@ xlog_recover_process_iunlinks(
 	xfs_mount_t	*mp;
 	xfs_agnumber_t	agno;
 	xfs_agi_t	*agi;
-	xfs_buf_t	*agibp;
+	struct xfs_buf	*agibp;
 	xfs_agino_t	agino;
 	int		bucket;
 	int		error;
@@ -3502,8 +3502,8 @@ xlog_recover_check_summary(
 	struct xlog	*log)
 {
 	xfs_mount_t	*mp;
-	xfs_buf_t	*agfbp;
-	xfs_buf_t	*agibp;
+	struct xfs_buf	*agfbp;
+	struct xfs_buf	*agibp;
 	xfs_agnumber_t	agno;
 	uint64_t	freeblks;
 	uint64_t	itotal;
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 915bc2950d4a..d9ed4210fc98 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -32,7 +32,7 @@ xfs_rtget_summary(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	int		log,		/* log2 of extent size */
 	xfs_rtblock_t	bbno,		/* bitmap block number */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb,		/* in/out: summary block number */
 	xfs_suminfo_t	*sum)		/* out: summary info for this block */
 {
@@ -50,7 +50,7 @@ xfs_rtany_summary(
 	int		low,		/* low log2 extent size */
 	int		high,		/* high log2 extent size */
 	xfs_rtblock_t	bbno,		/* bitmap block number */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb,		/* in/out: summary block number */
 	int		*stat)		/* out: any good extents here? */
 {
@@ -104,7 +104,7 @@ xfs_rtcopy_summary(
 	xfs_trans_t	*tp)		/* transaction pointer */
 {
 	xfs_rtblock_t	bbno;		/* bitmap block number */
-	xfs_buf_t	*bp;		/* summary buffer */
+	struct xfs_buf	*bp;		/* summary buffer */
 	int		error;		/* error return value */
 	int		log;		/* summary level number (log length) */
 	xfs_suminfo_t	sum;		/* summary data */
@@ -144,7 +144,7 @@ xfs_rtallocate_range(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_rtblock_t	start,		/* start block to allocate */
 	xfs_extlen_t	len,		/* length to allocate */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb)		/* in/out: summary block number */
 {
 	xfs_rtblock_t	end;		/* end of the allocated extent */
@@ -226,7 +226,7 @@ xfs_rtallocate_extent_block(
 	xfs_extlen_t	maxlen,		/* maximum length to allocate */
 	xfs_extlen_t	*len,		/* out: actual length allocated */
 	xfs_rtblock_t	*nextp,		/* out: next block to try */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb,		/* in/out: summary block number */
 	xfs_extlen_t	prod,		/* extent product factor */
 	xfs_rtblock_t	*rtblock)	/* out: start block allocated */
@@ -345,7 +345,7 @@ xfs_rtallocate_extent_exact(
 	xfs_extlen_t	minlen,		/* minimum length to allocate */
 	xfs_extlen_t	maxlen,		/* maximum length to allocate */
 	xfs_extlen_t	*len,		/* out: actual length allocated */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb,		/* in/out: summary block number */
 	xfs_extlen_t	prod,		/* extent product factor */
 	xfs_rtblock_t	*rtblock)	/* out: start block allocated */
@@ -424,7 +424,7 @@ xfs_rtallocate_extent_near(
 	xfs_extlen_t	minlen,		/* minimum length to allocate */
 	xfs_extlen_t	maxlen,		/* maximum length to allocate */
 	xfs_extlen_t	*len,		/* out: actual length allocated */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb,		/* in/out: summary block number */
 	xfs_extlen_t	prod,		/* extent product factor */
 	xfs_rtblock_t	*rtblock)	/* out: start block allocated */
@@ -626,7 +626,7 @@ xfs_rtallocate_extent_size(
 	xfs_extlen_t	minlen,		/* minimum length to allocate */
 	xfs_extlen_t	maxlen,		/* maximum length to allocate */
 	xfs_extlen_t	*len,		/* out: actual length allocated */
-	xfs_buf_t	**rbpp,		/* in/out: summary block buffer */
+	struct xfs_buf	**rbpp,		/* in/out: summary block buffer */
 	xfs_fsblock_t	*rsb,		/* in/out: summary block number */
 	xfs_extlen_t	prod,		/* extent product factor */
 	xfs_rtblock_t	*rtblock)	/* out: start block allocated */
@@ -900,7 +900,7 @@ xfs_growfs_rt(
 	xfs_growfs_rt_t	*in)		/* growfs rt input struct */
 {
 	xfs_rtblock_t	bmbno;		/* bitmap block number */
-	xfs_buf_t	*bp;		/* temporary buffer */
+	struct xfs_buf	*bp;		/* temporary buffer */
 	int		error;		/* error return value */
 	xfs_mount_t	*nmp;		/* new (fake) mount structure */
 	xfs_rfsblock_t	nrblocks;	/* new number of realtime blocks */
@@ -1154,7 +1154,7 @@ xfs_rtallocate_extent(
 	int		error;		/* error value */
 	xfs_rtblock_t	r;		/* result allocated block */
 	xfs_fsblock_t	sb;		/* summary file block number */
-	xfs_buf_t	*sumbp;		/* summary file block buffer */
+	struct xfs_buf	*sumbp;		/* summary file block buffer */
 
 	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
 	ASSERT(minlen > 0 && minlen <= maxlen);
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 93e77b221355..ed885620589c 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -115,10 +115,10 @@ int xfs_rtmodify_range(struct xfs_mount *mp, struct xfs_trans *tp,
 		       xfs_rtblock_t start, xfs_extlen_t len, int val);
 int xfs_rtmodify_summary_int(struct xfs_mount *mp, struct xfs_trans *tp,
 			     int log, xfs_rtblock_t bbno, int delta,
-			     xfs_buf_t **rbpp, xfs_fsblock_t *rsb,
+			     struct xfs_buf **rbpp, xfs_fsblock_t *rsb,
 			     xfs_suminfo_t *sum);
 int xfs_rtmodify_summary(struct xfs_mount *mp, struct xfs_trans *tp, int log,
-			 xfs_rtblock_t bbno, int delta, xfs_buf_t **rbpp,
+			 xfs_rtblock_t bbno, int delta, struct xfs_buf **rbpp,
 			 xfs_fsblock_t *rsb);
 int xfs_rtfree_range(struct xfs_mount *mp, struct xfs_trans *tp,
 		     xfs_rtblock_t start, xfs_extlen_t len,
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 8d3abf06c54f..c835827ae389 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -154,7 +154,7 @@ xfs_symlink(
 	const char		*cur_chunk;
 	int			byte_cnt;
 	int			n;
-	xfs_buf_t		*bp;
+	struct xfs_buf		*bp;
 	prid_t			prid;
 	struct xfs_dquot	*udqp = NULL;
 	struct xfs_dquot	*gdqp = NULL;
@@ -366,7 +366,7 @@ STATIC int
 xfs_inactive_symlink_rmt(
 	struct xfs_inode *ip)
 {
-	xfs_buf_t	*bp;
+	struct xfs_buf	*bp;
 	int		done;
 	int		error;
 	int		i;
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 4e1400ea6a99..5cd296a75fbd 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -460,7 +460,7 @@ xfs_trans_apply_sb_deltas(
 	xfs_trans_t	*tp)
 {
 	xfs_dsb_t	*sbp;
-	xfs_buf_t	*bp;
+	struct xfs_buf	*bp;
 	int		whole = 0;
 
 	bp = xfs_trans_getsb(tp);
diff --git a/fs/xfs/xfs_trans_buf.c b/fs/xfs/xfs_trans_buf.c
index 42d63b830cb9..9aced0a00003 100644
--- a/fs/xfs/xfs_trans_buf.c
+++ b/fs/xfs/xfs_trans_buf.c
@@ -121,7 +121,7 @@ xfs_trans_get_buf_map(
 	xfs_buf_flags_t		flags,
 	struct xfs_buf		**bpp)
 {
-	xfs_buf_t		*bp;
+	struct xfs_buf		*bp;
 	struct xfs_buf_log_item	*bip;
 	int			error;
 
@@ -401,7 +401,7 @@ xfs_trans_brelse(
 void
 xfs_trans_bhold(
 	xfs_trans_t		*tp,
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	struct xfs_buf_log_item	*bip = bp->b_log_item;
 
@@ -422,7 +422,7 @@ xfs_trans_bhold(
 void
 xfs_trans_bhold_release(
 	xfs_trans_t		*tp,
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	struct xfs_buf_log_item	*bip = bp->b_log_item;
 
@@ -538,7 +538,7 @@ xfs_trans_log_buf(
 void
 xfs_trans_binval(
 	xfs_trans_t		*tp,
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	struct xfs_buf_log_item	*bip = bp->b_log_item;
 	int			i;
@@ -593,7 +593,7 @@ xfs_trans_binval(
 void
 xfs_trans_inode_buf(
 	xfs_trans_t		*tp,
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	struct xfs_buf_log_item	*bip = bp->b_log_item;
 
@@ -618,7 +618,7 @@ xfs_trans_inode_buf(
 void
 xfs_trans_stale_inode_buf(
 	xfs_trans_t		*tp,
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	struct xfs_buf_log_item	*bip = bp->b_log_item;
 
@@ -643,7 +643,7 @@ xfs_trans_stale_inode_buf(
 void
 xfs_trans_inode_alloc_buf(
 	xfs_trans_t		*tp,
-	xfs_buf_t		*bp)
+	struct xfs_buf		*bp)
 {
 	struct xfs_buf_log_item	*bip = bp->b_log_item;
 
@@ -737,7 +737,7 @@ xfs_trans_buf_copy_type(
 void
 xfs_trans_dquot_buf(
 	xfs_trans_t		*tp,
-	xfs_buf_t		*bp,
+	struct xfs_buf		*bp,
 	uint			type)
 {
 	struct xfs_buf_log_item	*bip = bp->b_log_item;
-- 
2.53.0

