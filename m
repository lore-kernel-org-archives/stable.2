Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971845293EE;
	Thu,  1 Oct 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866371; cv=fail; b=YDhYpqEH97yE8u23KBznUQOk0lVUtzxCeRBwA5ZG9UGZibbzO3lMex0ghzwNBki5FSoUjtBeujNMzd6fym6aVKBec1MkreJAq2Y4hnDH/55CWFVtaiN/IV1sirNvGMRAr6PF55d1flfQFVzDAH5WOe9UcQM6J0emZZHo49ukeko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866371; c=relaxed/simple;
	bh=bXS4Nlm9NjAOfYO7EPPOme6CYeLp5GKbnPrIiobDUEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sED4BNMyXRrqLiPIhgixHQBlOkNUqD/7LEhxa7aIePkGbaHVkb3+Zf5w8ncI9bRfcnCyKNTsbOfHvLCdIcYyi18fDapSVJMIqgBrdk9peQaDnV2w7tfrrC6feOxXJ7NRSvE8FaUXeEM67OjMO9ZeAGDXHIdoHfDj1JcP7XOsNaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HSn/D3VF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g/CQmLCP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HSn/D3VF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g/CQmLCP"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMwEb490601;
	Thu, 1 Oct 2026 14:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Sip0nQy0U3JnT5OTbSTSKF7mc/9kh6CySPYgRcfpTwc=; b=
	HSn/D3VF4NVbtnLjh1F77Y+vDQc7U/YKktnkdwBUgO9MfWx/hTc7+Nwrq+TAUm70
	0GWCpzjBNA+1V6YCN6F8+urDCfe4WVYfprjns8W9Wr8xG4/4K5yVDEb7z5ey8Chj
	Q+JD1r/bpHVlT+Q5qhEgzTvJYx1i3ywt2ZQ94dIRmYY+JVxiuKMRHoMrgzsMFtFe
	5TN0hWJ2axbctZ1snLlI6plP5LYwQTjmMyiEjhwt536szjVGuKtmS0g5tUjaMWRe
	Opb7bfBhr1wChjooYLGhLIWMU8DtgQgH+a86VmnVNUojYMR9Bt66voJMX5JU88hS
	pAbnuUtuP7QLx7I+48SCFw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx6ks944k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoSlN013209;
	Thu, 1 Oct 2026 14:52:41 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsvpuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kajMlNd/aIFGnf6+zpdGDBbxobKTPage+8zm0C87tneXiyLDfJC5c672mnhZAzfmse4eiHwhmuV0g+dYIT39vDHNkqH548QiHx6UX744Sj8bUfNGNUCwfw9JB/ixUZmWmhTBV2MsqrgtPFA18rC6/4S+a89VQ49PZrmFibEcc0IICY9zk3lAKACsHpX7jUmjy4cDterhzvVObrM7Db0hyOHqcW7TwlgDdAGoAVIUQ/3+YvaitdoiiMYMlCIOEP5zFpLtF4IwCFzTbIEVAVJovFs372OphRmKZAjD1aTtS3K4PKPYoNKAQxxFyonkXwfiLaDRJDCha+MlJXKi2bdZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sip0nQy0U3JnT5OTbSTSKF7mc/9kh6CySPYgRcfpTwc=;
 b=gb2PBwJjLZnJSwKnZVdOy58xLm/i5kSCr+rqDz8trZiTJM4L3Z1WkYbIbPYWyNM5GFf0GeKMZWX1zWrYGzCWRPRWXrmI77ukQ0HknR3TJpM2E2MKsFqzzcugXnzeR6OynwXDQFqtmT1+Mu30RYYRHePsDgilbdZW12jnL0SR7jIOsfeO9s3IVuZ9fvvC5ghgLz43hQ6cDdZKsEphEoITYxd1KQVL7UAOCaR1atH+/MPZYxwqXv5I7OywyQF/Xd/3FWuCA6ZZLmgIXzuIbdCMYGpWQohVYgbJE4QFCL5lK9gPYlwHQZVIb+p6DmkKvjkz1RqItN2w1WRBkS+GPSoP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sip0nQy0U3JnT5OTbSTSKF7mc/9kh6CySPYgRcfpTwc=;
 b=g/CQmLCPxfccTDbOrHXDZimXV1OKINc6E+HsOV+Scf9z0zM1/OV/DrxXvuvQmEn9Pg5pjw47o8AmGgTUCECiOCsZAal7FU73WdAMG+5jUlKcprNfaV5XOWq+8CEaZwCT67+QLteVALr5ob1A+GMTe6OdpiDJ+kEb/inDspDcyMY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:52:36 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:36 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 07/11] xfs: catch stale AGF/AGF metadata
Date: Thu,  1 Oct 2026 20:21:22 +0530
Message-ID: <bd5e7ccd834f4d414d7816bb0a9ffda7f0ae1daa.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b31b060-e4c2-4694-7375-08df1fcb8e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	P/Oiydu1WqTvz6epLf494eb8BTY1IwsCGOQ+k7vd+6YX4FK7Rn04gzaDHEpd3tMqijTDrbw1ixDhVqWUahHLiH//BDOvH2hZ7XWCs9IhR5XZulHHqSDHBMexJvvRs+wWIFRlNdV6wUH8+Ejsx5mduaKoR9gwcUhHJ0fAW7hYOxF8eSmR0WYrCmTp5GOlUewqj0QuuXoaqbQlXkYX03ksG/O78c9R2G84RJEouJe1sT2q5sgLmzhKYxPk7srwsV8YpSBcUARoWfg5c4LVEXRsM3y56vf93hKGdKbzLUBgWhxHPeM0oiTZXeGdZMSHOawLbenLA1LNuSs1zD6UiaIZ9DlAC/G/D8UzgvrDFVYnFCdwy2H5WUdGjkvjaOcLlxDyTw+hui2ZvyazhhI128NwVHr0EgkqVZTyc6ZJG2G038SshdyfVLSyOSGs37XZJMCN119pGLLeUnSBaOSMaT7eAkHixUC9X9FP3m8wM86YY7rWt6z2SEb4m7E8buBY28Niwt2xcdNzucByGWv4k1d20cYHc7ZM15uxSVOLYW8JCvT8c8rz61/FFMTGBsXksUSSXWEIx7jXh3Goo4yMbM1QM/2WENxTrfPHuusmzm7RGrzFiC6oosYfmA4Ese/W67cAAo2fdIq2Qs7HeFsdUcIT1TM1zMTnaKrPFUUsGDJg7s4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9HCbcWJR0vDqNjKrz3DKwVl0uFF8uKct1ZctcAmMWcFUtC76Sw4QfheF6ie7?=
 =?us-ascii?Q?MeAalqBByrlSDvNhiFG/c8IZdpfmodYQqiUG3GXehkjtmEsclNycK4jfI6Iw?=
 =?us-ascii?Q?PPEdyeuakPn/l02nMZ1IZ4zws1YpSx91Ib5r+YfsvDC94mnZnQJlWOPLenzy?=
 =?us-ascii?Q?Pm/XHf0ZgJpQMCuYcrfiTaCAuXEwWksOWh/hYUikc4NHWrh0F/VKsUtriPHh?=
 =?us-ascii?Q?L3kUaUdzMJPNWFBcoHpqEkPtDsDIJy87krTr4Nz2Qg4mKhwUGf3ivuFUSzLr?=
 =?us-ascii?Q?Y+7AxktwvNRRSvX6Nj3OTcgNiJeiZ1qnBV7czwrSEfRAFSB/GeZEyKbOdyEj?=
 =?us-ascii?Q?+HuE++tS0qjmIGJ0+D58zG/nyVAlFzIbfZyddZkhUU3XZM53dpzx7gJ3HT7v?=
 =?us-ascii?Q?OXnGWVRkjTp6zeRSVHACkzHxtNxrUfY/IHsM4JZvYCuhQHWKgQ2UKrJnRuyo?=
 =?us-ascii?Q?/2gOfbJNTzxZqX//JtwG+ksW3hfSxIcy98upPETysUhMX9dHor9Pz+Luxqgz?=
 =?us-ascii?Q?AqyWJvAg4BQTsiiUFG3vnN0ZqI32afEwHCPu9zoaYqtu2IIrQva901uqoQpW?=
 =?us-ascii?Q?CRX7Vo5W6Hf63wcGNW8oQLSMrQpHdD07aFpni3k2VwmRkQZJALtcSIdsvT1S?=
 =?us-ascii?Q?CKb5wTo7IiD6zmeR72bL6Ks6+MX2RiS71ca1irV1TCasXI4iDpupyCmN9ERz?=
 =?us-ascii?Q?WYKk6jBqP/9icwjwILFEbDSuOQHF/NEqfFRuvVOkAeSFphA45r8J2w4/cNmj?=
 =?us-ascii?Q?tEMaokiD2o4E0TXoIzTZjpotfpQNXB24jnrnRV/PDDXzAAJZld/33vAZI66p?=
 =?us-ascii?Q?jC44IQFUclPnJ9wtu5aodDwLlPqUOF9qtGalYt5cqorxU/6MfXL92mWrpj8i?=
 =?us-ascii?Q?h1qREeFtuT7tTVMjoEo9rN0gOIBBTwPHyCmKOkVE9daAEaJqqPmqguuMcrdi?=
 =?us-ascii?Q?2+NpWsp62dBbLAUZNkd6x8zKCIEI4fkQNdgoI/ArzYlUTFRHFnZGDAdGtCdG?=
 =?us-ascii?Q?1S0a+WuPwdkeSCm45sHQivWYRyBDlaQ8uAWLo4HvFjgrOJ4Q4foPkxOfLZR+?=
 =?us-ascii?Q?66BxtK5tGMSA4CWuA7UtfiU94YUnQXLCVAfsqCYKpZ2c43PTo3RwmfUDRfjv?=
 =?us-ascii?Q?S6TzpEMAO7UBtaIAY2uUASlvieVGtuC8iW3VglvZutHDdzzy2KjFjP8x7REY?=
 =?us-ascii?Q?fbIRr2WYdRTlLezyIixECigvAHC8fQU8gzVh/gAN0GNC2vlr9hwZuP3sP6tP?=
 =?us-ascii?Q?GBFclb+kQ4TzfvjPtnHUOc7k6pMAzN8mZ72exlasS43NCjwZAMPrOx9ye1ib?=
 =?us-ascii?Q?ZTW32GvfBsVetJZktOYz4bFED1MN7n3omAtCsB50WIg+PnsqWRfVxZUgjjfT?=
 =?us-ascii?Q?RuUXYdNayEVj4JTyKOqmeKtvFfZ5q7WwznCp1mLNonAiLjnd7WgUVUthoP0w?=
 =?us-ascii?Q?aAvuqE5n/UHvFnmU8L0qeq+zZMeh36k32Ez5ZjN9+H+7I66vh74E+IhIfTlu?=
 =?us-ascii?Q?vkCQTigRbBYEwoO84/fgZ433AbI9fNzjiBOLfVVyBPkY6o3sNFYoZbFv8i6x?=
 =?us-ascii?Q?k9bOuqxmZkKsJpxxGrCWeGn43Tpj3Kmwu7UYh7BzoaPRi+b19tvRYk/GCndS?=
 =?us-ascii?Q?d/0atN4q6Dhox0vKB3uPj5cx+TdCeaRKcXNlc9QaB1WDmFcaDfnz1H9X0LyJ?=
 =?us-ascii?Q?xiTq2XvuC9zorhclF7b3nZuqfb2+vKK45m8tZYMu65wzV6Bw6fe9iKkPSjgn?=
 =?us-ascii?Q?jIXRL0t7tWME1Y5L7KRbnTdpehiC5hJUrm+VihCyrnSPxOyAxP6aCDU5oXeP?=
X-MS-Exchange-AntiSpam-MessageData-1: XI3SaRWf4dYK7jo6sABEBFeYcXrhVkwTJZA=
X-Exchange-RoutingPolicyChecked:
	X0HxASVTIyBSzZjTmyOuA9cgZ52dusENZJ/jSyI6kwWFL0f4YUXnVx9gtvtf86LmyU9cWbyzYe5Kb+wwKgfZgEkAmj14q+3oPX1joHwx8AFGxkRDX0zdl/N17tldzbfv8SVXdJ1S/gVrNkQ9qd0agK44a6BPdDcXghbEZ61B4grsh9uaxzJLX23TvtPMV5X1noQQ4RHufMgECgDHnAAngvOJprkNpPrUBtVsJrhNlVD6l64nZSF2PKKnNhL1CpMb03NffGalYHwE7AzHDu4KLB3eOJONQ9+VtKVjjmlnarryNPuHr4hq4ZAoroVUo1v55ZQCch0vdIxrFSlTvEXvlQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w+X9cuPm/ORfdBd40OidvkXs/4eMHJG0wfEWtXDuhwoAmdGqRethbTEOgva59sYB1Up/jaSbp7iJ9VPbLGTLssG1xkQwom+nmbSY3MggHJCNXHdpAZ0Tfv8PykbHO4km4eCSET1AleALH+byn6ca40KKi9yndIXsnPQklCuTyZjxrerP7O1jsKEHx6x49NFxQgGv4cjMVN9k1vSpl43wKfS6+4wY2F6Gwg8Sn6nErczXTAyom5wXwryxkuSQMTX91cICtTIhf4h7qhWuoqHNe8n9UQwHvszXnXGLFeMd3wVYlFrgOUGVJU6xR9oyCglwglVkkhkaumhuWT9dbNNPKUx0cByFhD7K0Dn9f8UEWJpBiwFzLY5++IJMnixemok8Zx6iP4jfszw7Vg3KPkOIn8snMfSwg3zoXf7xa7aaEewIItP08Ou66BjDdBAYWFzNZvFmPz1ILZqwiQx6spfs10n0EZQK1v4zLB368rnQNCe57dgQvmEfstGlVIAn9r/i/k9lnj/7uZRwjxSKJ+M/f/0fbL9VMSksSbGOq9s8NpOFV9sRcn0SmNRF1RTrtwL1Z9KOCvXK38z2CzexcOj2yeFPyAqFr/662X94QkUojfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b31b060-e4c2-4694-7375-08df1fcb8e3a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:03.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONRq2DGppTGa3wGR8VOWsv0fSQRlCl9WyDJjwavGL3RPvnEGISoo5CxGI+Koly9LLAUuw/+/WLa7ogtfG27crQ2L3fxAs3+UiMY0PHBw6As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-GUID: N23-clH28y_zzfRZc3H1a-i7gp9Cm5ou
X-Authority-Analysis: v=2.4 cv=U/gHnuru c=1 sm=1 tr=0 ts=6abe73ba b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pCazNFhamJdtUKLgDfYA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1weRQ9sjlKLg
 Y5PysQ3MrGrL/uuAzmfiX5b5GJuuuG0O86WQ1QnpkgLNeEbtMLEeMJ4vxY4k58sDyvs7KtutdWk
 tNuTuCIk1qWFaNuhQdOTRnOQIzt/VUho3yFkk8ZvpSBWc4CyRlc7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX24+twfYTjhNz
 B83het9RzkLvIAMzw5rUhujWFHP/TbyyIVCkaFJm2SVhlikSQHoPtJZEUQqrpQXETbWsDlOUBnP
 9g9hA77/8l4htorc2FDoO7JQyJ7Xk7shLltD3QNaagBSBPVtFZkc6dE7ebpsnzCC8KZyCTd7cLF
 Byu+6q5Idy6mjKdNdTMPPbU/NQFfyXBryImQ6SjxpIpp62/1xWXhMDXqPnpDDGhYs1TPIi3/XVS
 ahoXSFfdeumHloECd7gyRhLg7bebDigEpg+wu6ebLxwJtP3rnqp76WEP+U6TGFVcjc4Za1nEA0+
 t0750ev4m7vDxqiPDVwDH8rguYkL0WlW3mKymTyQyRsQq5u3uondcCRKSUGnrkdbzLtIpNBy9Hz
 1HVRgNMQtgUonRuAKmdxVLNQkqNTohPPeDTtRF0AmdqnB+r1VP64fbPUeB6qvZ04+yfLDCTE9jq
 1GXNf5P/zkWFNL8wQ7mvlzd8doZuJoc5YJeuHvaI=
X-Proofpoint-ORIG-GUID: N23-clH28y_zzfRZc3H1a-i7gp9Cm5ou

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

5.15:

Fixed conflict due to the following missing commits:
	6f643c57d57c ("xfs: implement ->notify_failure() for XFS")
	[Continuous range: a95fee40e3d4^..08d3e84feeb8]
	08d3e84feeb8 ("xfs: pass perag to xfs_alloc_read_agf()")
	76b47e528e3a ("xfs: kill xfs_alloc_pagf_init()")
	99b13c7f0bd3 ("xfs: pass perag to xfs_ialloc_read_agi()")
	a95fee40e3d4 ("xfs: kill xfs_ialloc_pagi_init()")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  | 45 +++++++++++++++++++++++++++++---------
 fs/xfs/libxfs/xfs_ialloc.c | 32 +++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 95157f5a5a6c..c4d1c7d436ef 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -26,6 +26,7 @@
 #include "xfs_ag.h"
 #include "xfs_ag_resv.h"
 #include "xfs_bmap.h"
+#include "xfs_health.h"
 
 extern kmem_zone_t	*xfs_bmap_free_item_zone;
 
@@ -3078,18 +3079,42 @@ xfs_alloc_read_agf(
 		if (allocbt_blks > 0)
 			atomic64_add(allocbt_blks, &mp->m_allocbt_blks);
 	}
+
 #ifdef DEBUG
-	else if (!xfs_is_shutdown(mp)) {
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
+	if (!xfs_is_shutdown(mp)) {
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
+		if (XFS_IS_CORRUPT(mp, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGF);
+			xfs_trans_brelse(tp, *bpp);
+			*bpp = NULL;
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			return -EFSCORRUPTED;
+		}
 	}
-#endif
+#endif /* DEBUG */
 	return 0;
 }
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 31dc8e5d8725..9b14a6e4e48c 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -27,6 +27,7 @@
 #include "xfs_log.h"
 #include "xfs_rmap.h"
 #include "xfs_ag.h"
+#include "xfs_health.h"
 
 /*
  * Lookup a record by ino in the btree given by cur.
@@ -2619,12 +2620,35 @@ xfs_ialloc_read_agi(
 		pag->pagi_init = 1;
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
-		xfs_is_shutdown(mp));
+	if (!xfs_is_shutdown(mp)) {
+		bool	ok = true;
+
+		ok &= pag->pagi_freecount == be32_to_cpu(agi->agi_freecount);
+		ok &= pag->pagi_count == be32_to_cpu(agi->agi_count);
+
+		if (XFS_IS_CORRUPT(mp, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGI);
+			xfs_trans_brelse(tp, *bpp);
+			*bpp = NULL;
+			xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
+			return -EFSCORRUPTED;
+		}
+	}
+#endif /* DEBUG */
+
 	return 0;
 }
 
-- 
2.53.0

