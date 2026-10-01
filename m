Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7A51D50F;
	Thu,  1 Oct 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866566; cv=fail; b=iHcP+m6C6Wyjg00sWAlMW7jQgZKUA0K7mEMkf1qcgRo20ljJYxTYzOL5eZWH3dCmHPVYcJZzcCd1FxI8dzaenc1YED7nUnsWjm2LAIDXUBNOCvswcYd/ymAiniUDu6n8xkK78r+rg0j7cns5dq+i6Fvh24Hkphbx5RGGkgWvpZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866566; c=relaxed/simple;
	bh=aEQ2RTCQEZa7kc82jInMU8X4rND9dUZqIzxFbm5DlNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OMxLHYM/oEtguox4AQIxbUI5cppKhO5PE0Ilh7ANyDo6RQhenf8tCmpMQI7003lC7upoUoqd4BL1LH6glg2REyazUx+HxF4erK8r4WyMikEPkRRaxBLIunO2ANqIAVaDxuVNvYU+JRSIQHvGNEXZdB4S6dyNgPC87JgOiXgDPgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BuJTh8pH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wVa3wS+E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BuJTh8pH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wVa3wS+E"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMe1a1410765;
	Thu, 1 Oct 2026 14:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iETb8kk5/QmWs53Qostq6ViJcJLOxdrWjuBySdApSA0=; b=
	BuJTh8pHlmfiF9Ld2jmZtVwRVYu2aOFRxPO29ZnmhzLEHL/tpowFNSg0OxN0U2i+
	ls5xpdL9ahdaqUoibsVaKQkmpmU/j9iT9Jh/BQL+1fquFSVza6+BxuE49OdZ5I6g
	cDxfVnc3DPW1baDVAWjTg/aomUXGbjCyRtS8sjI065azs3UxlzPJO/dAOUjk2aly
	YHWIU5ZJEHE8KCJxP5Q11tWokHEmfWPzAjgXhferNsknIACI9xvlVIsM7UC0iltS
	AxK1wlQONavWmEDoV1lW1nIKKIPSHtnAzpz1nisiop/x2LNCjC+hpkG2ckZ+cB9U
	EJQM2hLiCs/54LPo03BWAw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4y9h6dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:55:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnmE7011396;
	Thu, 1 Oct 2026 14:55:50 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gepph5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:55:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah8+jvcPrLCHhXTeBlePfOqFHxsciPlO8SiS9SaL3GPfSwqrbzMBi2dk/uSBGIfPFxcm+/0ZHhG/wR72vxqDbjv9aepaL7jufy0UwmS9U774L390RT02fEl7jXl5dBZHMq4a07Uc+SZjGKJW7cDOf7Sv7vuWAiYf55Q9gQk8kCxc1Fbw9fpDo556UvQjzOfMqHYFMonsBxIGJwgnJoVkcouynNo0aYwhB5gFKcCFQCCyMObmDTF0JzY+1hJZo1r2umfgXw9/nK0RB5siAjP6QikjfgFX20I/0bhNjdUxf3RX6Z/tASrU6PE+MMWO3PHY/MPIGKHjEhJF15rBaM/jYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iETb8kk5/QmWs53Qostq6ViJcJLOxdrWjuBySdApSA0=;
 b=inxwmn1lAJDezWtsd0YrM/Q5uBz9RjxM0V5TXWEtz1bEcYnhe8WUSVRgkUT/kDO7+A3qydY3HmVISAM+Pb182+kGqu3Uk+bOuFI0vXHaWGDTsSq5imuIHELJakNJMsIUJrgxvWfSs2J0xx2NRwx/OJJyrWGq1rslYo40gJeASb3qKoPMyQ0mF93SwRaOEGHUBEWpXeqe/Dq6jE47Y7Osc9RL7QdYBvhxJkktOE67q/YGFTtRqW6QX+dCb4t6v4kxfPaLJQUDpJCK6z/e63fod7HA1110HB/dTlCEyDkvyGUlOh4pgk0YtcTG6NlUtcBrh+Eu32wb/ZxBvFHAVpxeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iETb8kk5/QmWs53Qostq6ViJcJLOxdrWjuBySdApSA0=;
 b=wVa3wS+E63WK117Ja4ApcfWhETNq6pC8oXR8vQcc/qeL3BUaXxijfVPFDFnNevqPrJtKvPR8GHBW68azqprebW7keKZM69miqZKQQEp1Zr5/7uBgm2oeu8sxXLML/oc1c2iLDQld9kWEJImzGnJZx+592IVoUETgkVWEpmfLeK0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:55:47 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:55:47 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 18/21] xfs: avoid dquot buffer pin deadlock
Date: Thu,  1 Oct 2026 20:21:31 +0530
Message-ID: <783a52a578570ff85b9a4521131a9350048aa089.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 17839ad6-e53f-4f6f-8b3c-08df1fcc13d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|23010399003|22082099003|18002099003|6133799003|10067099003|3023799007|260925021311599003|260925022911599003|260925021911599003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	huKES3j17wALnR7lJnjM7JSw5T8Gi3GgIZqvij/2taeSUvD4nadtps4FMID3nYPUHvypDBaKACzuUII2WBNAVCwg1NiC1HUKPVJQg2WSvJC0MPnv4vO4UTSQ1dtlPt8JoYmvCYWp7aUIhKVsPGNQSKg9qb3aDWcLCfF24vAVfXZ8DXm+NYn+OcggQU5Xk6NURi9OvkESO8+caqQV7ue45akYY0ozx2CjnJvYjHv/xtQ317dqBJmZPKZytXf3B+dxrxAdmH5AsM1ymLpze4x5DDn3VfON9ASHPWZaZT8L0YoSZXV0+usiVOLdW5QKrpEE8VUkDogpfGxbVj3CfYBV8ZLAjwduL2bsSjDEHtYGYnBcduuCw8sMyEf08fbYhuUYiyizCQr4QxGR8upYbMymFKuNpQ8blTaH6bmXM8kVhsXRMz8rkBXfilK1ALX/GfP9lrXdq2zV1253bnElm3HOupXRD4zeU1VZlWCFd5lAMLwWkX/ZPHLiMuf0mOxlsLrci3YDoX9y1L4B2eFCPsZugWzBTZxwKLKyaBvOyOCfVuXWcpKLcXqVQjxRALSzBFjdb6Zr9OVhZOrojMaALhsHjRY1iUfwfbj4Pp3gkvY200LJE3oySnNcIZoiQEa/AGwaQatHKCQjnyu1onMvm6PeLPpNl1+8tx9PVRT+iD94j7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8WAfIGd5APOUZ6bAHmGZZP0zVK3yBwimcxUizSVjzMA8ze0s0ei51r6iCTKU?=
 =?us-ascii?Q?+PeG5Vg4byZSCfSwXsvAZVDE/sM6adnzHag05chmgNI3ew9wuG9Gy8hkO0d4?=
 =?us-ascii?Q?W7JFyKvGtJY/G/g8qA5v5XbMNZYWSXgKzQk4JoNMO74k7ZQIF4yE1Gg6s6R2?=
 =?us-ascii?Q?24vYlNdiZzidiHM5Z8N8FcErUjJYLs8afdCKLx1faETwu92pcP8KH2Ep0GKV?=
 =?us-ascii?Q?PAtsUnVjUIH5hp0JZBk0OW6Hp/f8xOpQurIob8BsnZGdAwGznYDRghinR3fa?=
 =?us-ascii?Q?PbhbAVrxsNI36KGkvTY/gRJT60fPdM7jFy54rLpZd2hxkfPteoUSTwLMasBY?=
 =?us-ascii?Q?AyCSiyPo00ci3SWCre1Yl6AdCR3NzDN7PdvEBs0Ia8QDRPcHpdLCaqAMDcK7?=
 =?us-ascii?Q?KoELxhzsTxHLot5SGJNDy9PYItcpkGwdDW4U71cjLZsTSenSW81eYhgAgIxE?=
 =?us-ascii?Q?RR958LNxNSY49E4OlRzBqbsRwKwJAlpcqW6QqEOmLMjZkJwc3qC7qvlK5TU+?=
 =?us-ascii?Q?kL6lA53YGQ1cLUIV1h56a8FMYbz1s9b/ObskjT3LgqyvfjxOjp7azyvC8vEy?=
 =?us-ascii?Q?vA6L9izNNonH6rSIBhR0u8LilfWxLB6R6yD14VYjzFhErf6N09DQ+oHZykeb?=
 =?us-ascii?Q?ac4+Uq65gPWyRfGS9j3G1RpM6Rk4A5FlQLXFGNJToDB1E+8fu/Sgjjr+7Yeb?=
 =?us-ascii?Q?+rnkDAdpI/C+g8LCF2pPUCml/CE6H9qZwOl6pIDn42/c3DICMkDlYJ1M4Rsi?=
 =?us-ascii?Q?/TVrFp47xbdMBIt44XyZjbA0BStgE5OMr8ID17MWhb/8UzJoLQrfry5HbJQs?=
 =?us-ascii?Q?Wr43f+jGt4c2A5R3Okmu6Zr0T1x6A1Ne6suvDaGDeGEAxyyxSJCPLM6SF+3V?=
 =?us-ascii?Q?ftxzyc7UdLhV+l3MX/227ncKkjqs/Wukh6psxWqYx28HDo0a85fsCPP66mt5?=
 =?us-ascii?Q?yrUPXl0nJ8ktyzITBvqxA4UovM2OVl9JeEmJ6Z864UT4C2QUlmHQx8212Dx6?=
 =?us-ascii?Q?rdhMmApaJLjgcxcnbYK75POTE8kpopZEoCFjX0D3swefsdSJ9s0SFKmAfqGh?=
 =?us-ascii?Q?lWqxmm0vaLi3RItu+5PgrUNksy4aeD2q3j63NsR5a9BrWYT6POfvUqvvUNs6?=
 =?us-ascii?Q?dJwlu6e5RofC2eZduYlFHBvb+oqf+40gesdRMGUMFu41dQByC0jIAwan3Pdh?=
 =?us-ascii?Q?SpRLYBp+OHGfG1KFdLX0N1DMNc6TZZ8Nz3HvRSsBz+K2VgJ4LA7jUqeICz1Q?=
 =?us-ascii?Q?/H5voOctUlmd8rwP577rdsCKGy9bwpGU7V+aPvdqI71/Yi/34v36Ye9AANiB?=
 =?us-ascii?Q?ltu9qHqMAT7u15dk1rqXjUrnxVI80MPoPMfBfLfHTw360uqybBNy0GBv9sAn?=
 =?us-ascii?Q?9wBszI4KZJNCkFjkqSSlfncIi9BbvYXSC0Gk2P11wFx/Sqhz7j5Ei1qkGXFK?=
 =?us-ascii?Q?17G9wEYg5TY5AXYBaOBRW4XBgJyf4rpvEVTMRp3DFIqzPpXTNsywT5USby0d?=
 =?us-ascii?Q?8BrYgaVYr8BfLIdgodqMZjzlx5Ya6TE7+kn00n3+BJkxHE9dCojdI2bP9890?=
 =?us-ascii?Q?gcKNLkcB/SO3xqxAAzUsphWPkYqtFElZ2UFEuf6LMmNxD+PgErDyJdjnYaiU?=
 =?us-ascii?Q?GAADnbLgNj/+Lc5WTgwNG9YKUv33svP1VotuINVHjwXOWy6Ec+PqzmyDGSBq?=
 =?us-ascii?Q?7mL5aFFPiYeW9/7cqpoCMxGw2mdvtYNuY5RQJqxuhoT6Jv8nJ6fh8KhHdOT/?=
 =?us-ascii?Q?kVcEbyyLvBORLcz9bCRLytRiQApsgTFwve+xPNkBk9he87XvVZKYA/FkaAdK?=
X-MS-Exchange-AntiSpam-MessageData-1: qV1Kyx56pwdUjnzHHdjnhMxs9eMxC2rb2kE=
X-Exchange-RoutingPolicyChecked:
	ZJD6RD3ILYZpgLF9EgPQpGOidm9FPf5BugRWuCPy/gPfBT8qCwaTHG3L9vAfIZqyAqP/KJmpXvQ6jzM3u3qzeouZWBDRHIlXVi3/Q+ZbZLvXyFNAi4FaiZsSN/M1fic6nGPLpdZXy8/tdDpzptOqYwN15HEfqbICkPRLLi5dWBpn0Red5VhZD3Ef7koLDOhiAaOxclTeruicP0B18At3UYQrZYvErxBihRhuSQkKeBMN5fOoyuEJVdappv1GQCulB6xsscMHNipMjeRhXcF3H3c9P8fddA84FOwVuUew9qu/ycRBGB2kX5gJsWwy+B203Hrl54wodj1qx828pPl0rg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z0oTNKDxXDicNp9/N1QYIIfGCOKvNICcOdkgb3wjakwtSs+y1bnD6kvuBX118LnCAWUpZOJwZzJonkr0ca4DuoWSQM30c61pqRj+or7VagaQp+iPgsrPzFgJpzzPX03g8FUggkVaGZFe9lCkode6acjzFMdXLrCnnysqu6mXBpIZ5l8yrOJJk3/Yc1y8QYZvdYoLO3+i0cmD/NETtftJ4LDZdYZfE5cHf33HbtfxcR2t31w0RiFn5XzRsqfjodmnenD55iLu7jmEgWDfxLB2Mm38mA/8yr5X/fDbgsVVw+8MwdhUAP3n52TxOsM7dbaoyciYhTwQj+qGcEoLfrYgPG1DFGz4+EFbVrUV3XxM8hZua/qQ0TkSUoL9ZBErewGzpbtiRTrqNqcSUeAq4Cp6P3m2Jzfl6kWIxDjCxCHrWQ8j/clVe0QY413NOZtMHkrFatkUOSdj5ZYgdEKfBi0qLPGqJ67Vr6T7noZEz1GRMMFKQu4YtpRD3dDcFGTsOYYwuj6E1/wXbtZmwd6QHkjqdB4Or3FTDaPhyLuA5+RmkqqZE1vLZe38gYWTtOcGngcAkwAdwRX86blRGMbgf/oYmwWAuYROvDOJwCiT9u48gOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17839ad6-e53f-4f6f-8b3c-08df1fcc13d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:55:47.7799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdrxHXhLv03Z4EMwwMatPdmLoN4mZqoNRKadlU2DRj8MGKk0iAkd3nTIAX3HKFOy6kuFHkSfgXYDlK8BqjZ0d7ir961rEvppjQ68Wa4kn5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX8xb3Sq6dUnc1
 mzb+IuWDmehWh6muBubebZ/GEDStT6a1ucymAuVei900G3NXnleKeWK6lrw/fBR3pGab2PNxJJn
 N5Yq0g+MJmgUzSmvVxDb+UfgBbQ6rmNtCfjANE1c72scieeimudlSo4jN6+IvcoTfCT4Mm2lwh3
 QR4nTihgb/X/kBfYZhs9bL06Pbj3BBtdxS4TGNTNCkFeNy+laJJKIa5nEyDDCWF133hz4h28DS7
 F16KCsMy7u1lYS4ec8Hgj2ziwCUYxtBqMeQpmU+7cHGlgFZp35GHo/DRsiespOrXPu70XfMftZQ
 K/hCWyFNZY/VGQTUOz4a3Z3Cf5EnJDKzP7hQRY6xC9tBF3l+WGbP95fNpHXE7guZJWKWbGaNAnV
 SqXefQCcPJBklADuUGRns62kfPoaVLFiVhF/tdgZj33kmBS5mLQnL9JIG85+X0YOT3IigLMOozk
 OVlXUIYEDJZb6Z16PpA==
X-Proofpoint-GUID: HMp7xakvjaKAbV6YQ4MLWuvLjpOogCna
X-Proofpoint-ORIG-GUID: HMp7xakvjaKAbV6YQ4MLWuvLjpOogCna
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXyb/U5QSOBsFj
 5jFdROjBQTJwzyyEadi1bT1p0pXRhoeFWpryXi2V1DGF+S+rwhOjhKQwexaIoyqH3atY7Ss+9fU
 qXwlFHm2tb/5PbhrsqlmAibL/FPW/bXfIWjbd7fPr4CtF7h+Njb0
X-Authority-Analysis: v=2.4 cv=IuyL47/g c=1 sm=1 tr=0 ts=6abe7478 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=s_x9I6ZcpGuAll3zZK4A:9

From: Dave Chinner <dchinner@redhat.com>

On shutdown when quotas are enabled, the shutdown can deadlock
trying to unpin the dquot buffer buf_log_item like so:

[ 3319.483590] task:kworker/20:0H   state:D stack:14360 pid:1962230 tgid:1962230 ppid:2      task_flags:0x4208060 flags:0x00004000
[ 3319.493966] Workqueue: xfs-log/dm-6 xlog_ioend_work
[ 3319.498458] Call Trace:
[ 3319.500800]  <TASK>
[ 3319.502809]  __schedule+0x699/0xb70
[ 3319.512672]  schedule+0x64/0xd0
[ 3319.515573]  schedule_timeout+0x30/0xf0
[ 3319.528125]  __down_common+0xc3/0x200
[ 3319.531488]  __down+0x1d/0x30
[ 3319.534186]  down+0x48/0x50
[ 3319.540501]  xfs_buf_lock+0x3d/0xe0
[ 3319.543609]  xfs_buf_item_unpin+0x85/0x1b0
[ 3319.547248]  xlog_cil_committed+0x289/0x570
[ 3319.571411]  xlog_cil_process_committed+0x6d/0x90
[ 3319.575590]  xlog_state_shutdown_callbacks+0x52/0x110
[ 3319.580017]  xlog_force_shutdown+0x169/0x1a0
[ 3319.583780]  xlog_ioend_work+0x7c/0xb0
[ 3319.587049]  process_scheduled_works+0x1d6/0x400
[ 3319.591127]  worker_thread+0x202/0x2e0
[ 3319.594452]  kthread+0x20c/0x240

The CIL push has seen the deadlock, so it has aborted the push and
is running CIL checkpoint completion to abort all the items in the
checkpoint. This calls ->iop_unpin(remove = true) to clean up the
log items in the checkpoint.

When a buffer log item is unpined like this, it needs to lock the
buffer to run io completion to correctly fail the buffer and run all
the required completions to fail attached log items as well. In this
case, the attempt to lock the buffer on unpin is hanging because the
buffer is already locked.

I suspected a leaked XFS_BLI_HOLD state because of XFS_BLI_STALE
handling changes I was testing, so I went looking for
pin events on HOLD buffers and unpin events on locked buffer. That
isolated this one buffer with these two events:

xfs_buf_item_pin:     dev 251:6 daddr 0xa910 bbcount 0x2 hold 2 pincount 0 lock 0 flags DONE|KMEM recur 0 refcount 1 bliflags HOLD|DIRTY|LOGGED liflags DIRTY
....
xfs_buf_item_unpin:   dev 251:6 daddr 0xa910 bbcount 0x2 hold 4 pincount 1 lock 0 flags DONE|KMEM recur 0 refcount 1 bliflags DIRTY liflags ABORTED

Firstly, bbcount = 0x2, which means it is not a single sector
structure. That rules out every xfs_trans_bhold() case except one:
dquot buffers.

Then hung task dumping gave this trace:

[ 3197.312078] task:fsync-tester    state:D stack:12080 pid:2051125 tgid:2051125 ppid:1643233 task_flags:0x400000 flags:0x00004002
[ 3197.323007] Call Trace:
[ 3197.325581]  <TASK>
[ 3197.327727]  __schedule+0x699/0xb70
[ 3197.334582]  schedule+0x64/0xd0
[ 3197.337672]  schedule_timeout+0x30/0xf0
[ 3197.350139]  wait_for_completion+0xbd/0x180
[ 3197.354235]  __flush_workqueue+0xef/0x4e0
[ 3197.362229]  xlog_cil_force_seq+0xa0/0x300
[ 3197.374447]  xfs_log_force+0x77/0x230
[ 3197.378015]  xfs_qm_dqunpin_wait+0x49/0xf0
[ 3197.382010]  xfs_qm_dqflush+0x55/0x460
[ 3197.385663]  xfs_qm_dquot_isolate+0x29e/0x4d0
[ 3197.389977]  __list_lru_walk_one+0x141/0x220
[ 3197.398867]  list_lru_walk_one+0x10/0x20
[ 3197.402713]  xfs_qm_shrink_scan+0x6a/0x100
[ 3197.406699]  do_shrink_slab+0x18a/0x350
[ 3197.410512]  shrink_slab+0xf7/0x430
[ 3197.413967]  drop_slab+0x97/0xf0
[ 3197.417121]  drop_caches_sysctl_handler+0x59/0xc0
[ 3197.421654]  proc_sys_call_handler+0x18b/0x280
[ 3197.426050]  proc_sys_write+0x13/0x20
[ 3197.429750]  vfs_write+0x2b8/0x3e0
[ 3197.438532]  ksys_write+0x7e/0xf0
[ 3197.441742]  __x64_sys_write+0x1b/0x30
[ 3197.445363]  x64_sys_call+0x2c72/0x2f60
[ 3197.449044]  do_syscall_64+0x6c/0x140
[ 3197.456341]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Yup, another test run by check-parallel is running drop_caches
concurrently and the dquot shrinker for the hung filesystem is
running. That's trying to flush a dirty dquot from reclaim context,
and it waiting on a log force to complete. xfs_qm_dqflush is called
with the dquot buffer held locked, and so we've called
xfs_log_force() with that buffer locked.

Now the log force is waiting for a workqueue flush to complete, and
that workqueue flush is waiting of CIL checkpoint processing to
finish.

The CIL checkpoint processing is aborting all the log items it has,
and that requires locking aborted buffers to cancel them.

Now, normally this isn't a problem if we are issuing a log force
to unpin an object, because the ->iop_unpin() method wakes pin
waiters first. That results in the pin waiter finishing off whatever
it was doing, dropping the lock and then xfs_buf_item_unpin() can
lock the buffer and fail it.

However, xfs_qm_dqflush() is waiting on the -dquot- unpin event, not
the dquot buffer unpin event, and so it never gets woken and so does
not drop the buffer lock.

Inodes do not have this problem, as they can only be written from
one spot (->iop_push) whilst dquots can be written from multiple
places (memory reclaim, ->iop_push, xfs_dq_dqpurge, and quotacheck).

The reason that the dquot buffer has an attached buffer log item is
that it has been recently allocated. Initialisation of the dquot
buffer logs the buffer directly, thereby pinning it in memory. We
then modify the dquot in a separate operation, and have memory
reclaim racing with a shutdown and we trigger this deadlock.

check-parallel reproduces this reliably on 1kB FSB filesystems with
quota enabled because it does all of these things concurrently
without having to explicitly write tests to exercise these corner
case conditions.

xfs_qm_dquot_logitem_push() doesn't have this deadlock because it
checks if the dquot is pinned before locking the dquot buffer and
skipping it if it is pinned. This means the xfs_qm_dqunpin_wait()
log force in xfs_qm_dqflush() never triggers and we unlock the
buffer safely allowing a concurrent shutdown to fail the buffer
appropriately.

xfs_qm_dqpurge() could have this problem as it is called from
quotacheck and we might have allocated dquot buffers when recording
the quota updates. This can be fixed by calling
xfs_qm_dqunpin_wait() before we lock the dquot buffer. Because we
hold the dquot locked, nothing will be able to add to the pin count
between the unpin_wait and the dqflush callout, so this now makes
xfs_qm_dqpurge() safe against this race.

xfs_qm_dquot_isolate() can also be fixed this same way but, quite
frankly, we shouldn't be doing IO in memory reclaim context. If the
dquot is pinned or dirty, simply rotate it and let memory reclaim
come back to it later, same as we do for inodes.

This then gets rid of the nasty issue in xfs_qm_flush_one() where
quotacheck writeback races with memory reclaim flushing the dquots.
We can lift xfs_qm_dqunpin_wait() up into this code, then get rid of
the "can't get the dqflush lock" buffer write to cycle the dqlfush
lock and enable it to be flushed again.  checking if the dquot is
pinned and returning -EAGAIN so that the dquot walk will revisit the
dquot again later.

Finally, with xfs_qm_dqunpin_wait() lifted into all the callers,
we can remove it from the xfs_qm_dqflush() code.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d62016b1a2df24c8608fe83cd3ae8090412881b3)

6.12:

Fix conflicts due to following missing commits:

fs/xfs/xfs_buf.c:
	eb43b0b5cab8 ("xfs: simplify xfs_buf_delwri_pushbuf")

fs/xfs/xfs_qm.c:
	da0c02516c50 ("mm/list_lru: simplify the list_lru walk callback function")
	fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")

We delete the code so we don't really need to add them.

6.6:

Fix conflicts similarly due to following missing commit:

fs/xfs/xfs_dquot.c, fs/xfs/xfs_qm.c:
	08c7027e43a2 ("xfs: separate dquot buffer reads from xfs_dqflush")

5.15:

Fix conflicts similarly due to following missing commits:

fs/xfs/xfs_buf.c:
	231f91ab504e ("xfs: xfs_buf cache destroy isn't RCU safe")

fs/xfs/xfs_qm.c:
	85c73bf726e4 ("xfs: rework xfs_buf_incore() API")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf.c   | 55 --------------------------------
 fs/xfs/xfs_buf.h   |  1 -
 fs/xfs/xfs_dquot.c |  3 +-
 fs/xfs/xfs_qm.c    | 79 +++++++++++-----------------------------------
 fs/xfs/xfs_trace.h |  1 -
 5 files changed, 20 insertions(+), 119 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 78f6f5bce3e0..989d53aa3c2f 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2257,61 +2257,6 @@ xfs_buf_delwri_submit(
 	return error;
 }
 
-/*
- * Push a single buffer on a delwri queue.
- *
- * The purpose of this function is to submit a single buffer of a delwri queue
- * and return with the buffer still on the original queue. The waiting delwri
- * buffer submission infrastructure guarantees transfer of the delwri queue
- * buffer reference to a temporary wait list. We reuse this infrastructure to
- * transfer the buffer back to the original queue.
- *
- * Note the buffer transitions from the queued state, to the submitted and wait
- * listed state and back to the queued state during this call. The buffer
- * locking and queue management logic between _delwri_pushbuf() and
- * _delwri_queue() guarantee that the buffer cannot be queued to another list
- * before returning.
- */
-int
-xfs_buf_delwri_pushbuf(
-	struct xfs_buf		*bp,
-	struct list_head	*buffer_list)
-{
-	LIST_HEAD		(submit_list);
-	int			error;
-
-	ASSERT(bp->b_flags & _XBF_DELWRI_Q);
-
-	trace_xfs_buf_delwri_pushbuf(bp, _RET_IP_);
-
-	/*
-	 * Isolate the buffer to a new local list so we can submit it for I/O
-	 * independently from the rest of the original list.
-	 */
-	xfs_buf_lock(bp);
-	list_move(&bp->b_list, &submit_list);
-	xfs_buf_unlock(bp);
-
-	/*
-	 * Delwri submission clears the DELWRI_Q buffer flag and returns with
-	 * the buffer on the wait list with the original reference. Rather than
-	 * bounce the buffer from a local wait list back to the original list
-	 * after I/O completion, reuse the original list as the wait list.
-	 */
-	xfs_buf_delwri_submit_buffers(&submit_list, buffer_list);
-
-	/*
-	 * The buffer is now locked, under I/O and wait listed on the original
-	 * delwri queue. Wait for I/O completion, restore the DELWRI_Q flag and
-	 * return with the buffer unlocked and on the original queue.
-	 */
-	error = xfs_buf_iowait(bp);
-	bp->b_flags |= _XBF_DELWRI_Q;
-	xfs_buf_unlock(bp);
-
-	return error;
-}
-
 int __init
 xfs_buf_init(void)
 {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 5d91a31298a4..477518dc03f6 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -289,7 +289,6 @@ extern void xfs_buf_delwri_cancel(struct list_head *);
 extern bool xfs_buf_delwri_queue(struct xfs_buf *, struct list_head *);
 extern int xfs_buf_delwri_submit(struct list_head *);
 extern int xfs_buf_delwri_submit_nowait(struct list_head *);
-extern int xfs_buf_delwri_pushbuf(struct xfs_buf *, struct list_head *);
 
 /* Buffer Daemon Setup Routines */
 extern int xfs_buf_init(void);
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index c2bd74263f78..e4d61c9301e2 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1250,13 +1250,12 @@ xfs_qm_dqflush(
 
 	ASSERT(XFS_DQ_IS_LOCKED(dqp));
 	ASSERT(!completion_done(&dqp->q_flush));
+	ASSERT(atomic_read(&dqp->q_pincount) == 0);
 
 	trace_xfs_dqflush(dqp);
 
 	*bpp = NULL;
 
-	xfs_qm_dqunpin_wait(dqp);
-
 	/*
 	 * Get the buffer containing the on-disk dquot
 	 */
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index a3d728883a10..6d243321f118 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -129,6 +129,7 @@ xfs_qm_dqpurge(
 
 	dqp->q_flags |= XFS_DQFLAG_FREEING;
 
+	xfs_qm_dqunpin_wait(dqp);
 	xfs_dqflock(dqp);
 
 	/*
@@ -422,6 +423,7 @@ xfs_qm_dquot_isolate(
 	struct xfs_dquot	*dqp = container_of(item,
 						struct xfs_dquot, q_lru);
 	struct xfs_qm_isolate	*isol = arg;
+	enum lru_status		ret = LRU_SKIP;
 
 	if (!xfs_dqlock_nowait(dqp))
 		goto out_miss_busy;
@@ -434,6 +436,16 @@ xfs_qm_dquot_isolate(
 	if (dqp->q_flags & XFS_DQFLAG_FREEING)
 		goto out_miss_unlock;
 
+	/*
+	 * If the dquot is pinned or dirty, rotate it to the end of the LRU to
+	 * give some time for it to be cleaned before we try to isolate it
+	 * again.
+	 */
+	ret = LRU_ROTATE;
+	if (XFS_DQ_IS_DIRTY(dqp) || atomic_read(&dqp->q_pincount) > 0) {
+		goto out_miss_unlock;
+	}
+
 	/*
 	 * This dquot has acquired a reference in the meantime remove it from
 	 * the freelist and try again.
@@ -449,30 +461,14 @@ xfs_qm_dquot_isolate(
 	}
 
 	/*
-	 * If the dquot is dirty, flush it. If it's already being flushed, just
-	 * skip it so there is time for the IO to complete before we try to
-	 * reclaim it again on the next LRU pass.
+	 * The dquot may still be under IO, in which case the flush lock will be
+	 * held. If we can't get the flush lock now, just skip over the dquot as
+	 * if it was dirty.
 	 */
 	if (!xfs_dqflock_nowait(dqp))
 		goto out_miss_unlock;
 
-	if (XFS_DQ_IS_DIRTY(dqp)) {
-		struct xfs_buf	*bp = NULL;
-		int		error;
-
-		trace_xfs_dqreclaim_dirty(dqp);
-
-		/* we have to drop the LRU lock to flush the dquot */
-		spin_unlock(lru_lock);
-
-		error = xfs_qm_dqflush(dqp, &bp);
-		if (error)
-			goto out_unlock_dirty;
-
-		xfs_buf_delwri_queue(bp, &isol->buffers);
-		xfs_buf_relse(bp);
-		goto out_unlock_dirty;
-	}
+	ASSERT(!XFS_DQ_IS_DIRTY(dqp));
 	xfs_dqfunlock(dqp);
 
 	/*
@@ -493,14 +489,7 @@ xfs_qm_dquot_isolate(
 out_miss_busy:
 	trace_xfs_dqreclaim_busy(dqp);
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-	return LRU_SKIP;
-
-out_unlock_dirty:
-	trace_xfs_dqreclaim_busy(dqp);
-	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-	xfs_dqunlock(dqp);
-	spin_lock(lru_lock);
-	return LRU_RETRY;
+	return ret;
 }
 
 static unsigned long
@@ -1226,7 +1215,6 @@ xfs_qm_flush_one(
 	struct xfs_dquot	*dqp,
 	void			*data)
 {
-	struct xfs_mount	*mp = dqp->q_mount;
 	struct list_head	*buffer_list = data;
 	struct xfs_buf		*bp = NULL;
 	int			error = 0;
@@ -1237,37 +1225,8 @@ xfs_qm_flush_one(
 	if (!XFS_DQ_IS_DIRTY(dqp))
 		goto out_unlock;
 
-	/*
-	 * The only way the dquot is already flush locked by the time quotacheck
-	 * gets here is if reclaim flushed it before the dqadjust walk dirtied
-	 * it for the final time. Quotacheck collects all dquot bufs in the
-	 * local delwri queue before dquots are dirtied, so reclaim can't have
-	 * possibly queued it for I/O. The only way out is to push the buffer to
-	 * cycle the flush lock.
-	 */
-	if (!xfs_dqflock_nowait(dqp)) {
-		/* buf is pinned in-core by delwri list */
-		bp = xfs_buf_incore(mp->m_ddev_targp, dqp->q_blkno,
-				mp->m_quotainfo->qi_dqchunklen, 0);
-		if (!bp) {
-			error = -EINVAL;
-			goto out_unlock;
-		}
-
-		if (!(bp->b_flags & _XBF_DELWRI_Q)) {
-			error = -EAGAIN;
-			xfs_buf_relse(bp);
-			goto out_unlock;
-		}
-
-		xfs_buf_unlock(bp);
-
-		xfs_buf_delwri_pushbuf(bp, buffer_list);
-		xfs_buf_rele(bp);
-
-		error = -EAGAIN;
-		goto out_unlock;
-	}
+	xfs_qm_dqunpin_wait(dqp);
+	xfs_dqflock(dqp);
 
 	error = xfs_qm_dqflush(dqp, &bp);
 	if (error)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 2b7e6322ec66..53b58f308f73 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -335,7 +335,6 @@ DEFINE_BUF_EVENT(xfs_buf_iowait_done);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queue);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queued);
 DEFINE_BUF_EVENT(xfs_buf_delwri_split);
-DEFINE_BUF_EVENT(xfs_buf_delwri_pushbuf);
 DEFINE_BUF_EVENT(xfs_buf_get_uncached);
 DEFINE_BUF_EVENT(xfs_buf_item_relse);
 DEFINE_BUF_EVENT(xfs_buf_iodone_async);
-- 
2.53.0

