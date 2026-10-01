Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50251EE10;
	Thu,  1 Oct 2026 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866280; cv=fail; b=PH9yyMYFB3yERdgvMMlwpWwVxmutJPbYlAjXRj20eCwHNwx0gdsrizBvxMQ8bnTFeBrWBc0Nk68iWYj0w6egLs93QzmUx9hVQQ3IYQxdDIjw1bVHCnaxV9gaHVZlvHpsEvKG5nJdTL3lVt0uWoQHbyS3s715UrnPXsqKlEiueh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866280; c=relaxed/simple;
	bh=v2gaA/nmcFkyKoRGATkxEMl6GCwSnOtjSchQRyc0aNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7eN5tiOkUpi+9Ql3tUDddaRe32ONgoUiydEjawfQyK+fH3tUtCdAZR5EURhsUWN1F8wU0EHMmcc56W66mWsLthJtHmIQUSvF5buHeOA3At5HWEp79ZH0L0yPUfYZDc8WtC4h/5jdCPYd6EgQ5rQ9zcB6lR5VRAn5VyhvaasZWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DzX367vz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CkFKIv2i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DzX367vz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CkFKIv2i"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMc0K624353;
	Thu, 1 Oct 2026 14:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5IhiBSH0mqjgVGuvity4z+XAf62pmU94n3AB1FgisjQ=; b=
	DzX367vzSLQcNHtg0nuGe5GBCaA+GmlhO6ainRSb29Fbqg8sjfxKdA4mY8aTcF4m
	+IGMp/bg/iC/Dvn4kLoeNU2/6/5SX6lbKNiBltRP+iH7II3hyS7zYg/9w0drQ2zS
	PrAKgCOgQE+gsa51KmlDjg0VzqGnYNHIAI365Oa/8kAM6Dq3nekkJN0qG/y6Xadp
	+e6E66Y0wR4q7pE8J53tFOolpOZDoIpT8BaUNbCLYX53vBY7hRqXAi86bHnt4ChF
	G+len8PHIPbbaTFYJNl20zkXoONTKd/Ynw0m6UyM4/UaejYkonEDbMI9LDauit0v
	BVL5mcc+M8lnnu0DHjCdgQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns1020-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoTCM031792;
	Thu, 1 Oct 2026 14:51:12 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd2c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4dC++j8kDifqZnbTPV3cYF+4XumNSEL05iQiYTo/VdbZGGffpG16S6CyVf/8X2ef2WNTLjpCMndbTHCcOJEbTGyUsUjiQcub7xgVujZKKOgm9z9tkcS1xi9980Lerk4Cx6/PuimSqu8WazFcuEhO4UH3uWekGqNsJ6CKBps38AJtTpZhAR8r8JBi41MAdTbyLthdU4PXDt24VxQajIjAX2DdEBWelSx21oBUQoJhQLQZhPTYwKj4DOcwqjZZMRhRY2XERmLlf7gr5+TT98ObS9mpScTCmzYHVmxghr4G23k0oNx1l6RyDGgjef7+HYrWqIP3hYY6yMEy5HYYXYndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IhiBSH0mqjgVGuvity4z+XAf62pmU94n3AB1FgisjQ=;
 b=we/55asnZtZ0/vgmANwW5Bec+Wc5QDla5WlocpEYtzGiyqnxnOVRLUohwmrx2PtV8S5Vf453n8uBwDdJdiOTb8AZn7Vcgz0iL833ByYfOQYRuV0F64bUQDH2mQUdJBHCpocaif2Te3NS/sMpVJv5qnNC4WjM5C5cs2HPY8ROeGmU6Cekgnq/3pXGQlqB6uwubhxRscdWWtPBr4GoDdmgmsAi21WCXCZvE3i4ZLRMyW+Rv2E354WVb+9p4pgMXX9W6qAgGCqeMZXbFh+jD9zqbfj9WcjLFL4W1a3hTcHkRK8h3fgQ814CeWV9Vit0R35t7KmZIxNyB+InEvCSFQIkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IhiBSH0mqjgVGuvity4z+XAf62pmU94n3AB1FgisjQ=;
 b=CkFKIv2i85FrzWxqjtxK4GKEbYI0oEOFsywPpz2dZRx28ZcxM61kW0fJSXs7p8jQXXamZaLifxiCx6nd3B60B58cWIVKYJGhXzCokxULrUt+0J7XQnuN9N7utlImCOQR2fPmfoL2F9bLUxx7xEOnXlM12B0vmW72zHBNP60vni0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:09 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:09 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.12 2/6] xfs: catch stale AGF/AGF metadata
Date: Thu,  1 Oct 2026 20:20:48 +0530
Message-ID: <c593f3bc8556875eec3b7a849553c6e51514c488.1790864403.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864403.git.siddh.raman.pant@oracle.com>
References: <cover.1790864403.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eeb063b-1ac3-4b16-70cb-08df1fcb6dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	79+LA0pJ2rIRWdthOuXRR2vm6bzcqqy3bHQXBG5PoV0uaYpcL991WdWGn2S9QYgMA0nAK9jng+lo3TmTwLe+VlJuMzKQO1o46O1nmZ6MPLBm+yWgw6ysTzrbflCJ06nGKNV9yuY/r3FGWoZcPZh4mS3sBSn8PHqLnDW3+USHX76OXoNK0QsD5VkIxMS5357kE0sW+ancBkqz+2kYvNxJaWHLiwuxYe+2S4OQBfX/c1FGWq3uzL9evEyoi3ja1p23dIM9pnKTGYXfBrLYIu8OijSzVCcuVHyrkVGQ9mmnFF+CS8onBhXMiyR+IZY4esMMFNC13nGgtLtWWvJlJi0B1KFFt73iHswTdHAiQY3nimuJEiMF+7ZCHXQONVo9e3fdIOAnO4zKidg8Rt5gIExvwRAAyC4+waW+/tdnr2RaKxHGm1qPNRzWNsNJkFlPLScDYUqbo9zZEoLHg7rSNUXUlVgmKy6ePHH3tdRXofYGmc5ohyPj9faw79gbBHxiXr8RwJqN7/wAAic98cEjLqQ5J2gEJM7zJzK1bIuV/K6D3vSp1FaRV0DR27z91c6yeVBCRpW2zkmdWopizYlzWdKCa0uQaBLsXsZKUZ4j4hZ8s+eoDQHJGm0Z3FozH1oasW4I3KazzVpKQbOuOVQq7ZPCOWjRN2ykhQCT1xyuW9HEQbQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQpTMy09O935J+EzPzkMMVz9jeNGGQT3IQlWLxuNw4+/JEKsCUS60ltUEuLQ?=
 =?us-ascii?Q?ym68IgZwlG5Q/pxj4lrDvNLx1JlOzA3hNrgjE7YqpRYP0oBD8oF0ghFtwqIk?=
 =?us-ascii?Q?LzYMHqEYdcjxA0COpy9LOpM/IilO2lYSd8tM/n2kjbHdoB1aZSR2rWqSogrC?=
 =?us-ascii?Q?b4/v6lfe7FOQ1gqoAu9udTtaafMddCGqZQ5YUCw1ZY5RO1Lr4YGAyDQtcUsr?=
 =?us-ascii?Q?QszXvH3JxavJt2Yu6XUIrS7ZOgtRcYLpIQBkZiTTjPqTsRMQgazpcRJO3zDi?=
 =?us-ascii?Q?KYZQIZegPO3docBGF6OGKtqLiq+0Sc3Gg+KAnOBk+eiAhmSf6XoxrjaAwsjf?=
 =?us-ascii?Q?1Ge4dOT0m+oCZilH/oXP4wDJiGZPfVze9jEyUAq7kVWn/IXOgkss8Rfb6IL4?=
 =?us-ascii?Q?gjlhv8k3lV1x8X98q46i78c/E/Tm9sIOLjf1cGGDAtAOil8+VdrxeSTu3JD2?=
 =?us-ascii?Q?So2Mx8J4/JRNFKCYpB6+lDE8bbgqgfWRU5iwKo5WI0QdQvwHjgL37fKB56/F?=
 =?us-ascii?Q?hVO2SO9SqCNDi/OR1oNeppApnsUr2UeqIESLis6aa7pV7yJ4XrWVRfRi13fi?=
 =?us-ascii?Q?wA5KUM4yYt3+QhQOk2n/y7wS+njH3LoLFMheMPacj8mSxi3hv5q6bbbim4ZD?=
 =?us-ascii?Q?6VRhFikiC9+1i5xgkbWPBdh6BTVxkKIENy5EoXNeMWBdIrGfSHAmBpfR25lK?=
 =?us-ascii?Q?Y80PzqVRbWhUm2nDplN56xsPVENlrDYhCfLpOiEgYnxU2Odu1wHDZmvEaSrX?=
 =?us-ascii?Q?bDSqNpnVo6S8VbMcPAFbRLRcKawyqwunZt0FYS9lL0A8MujF7kmuLmhzv/p6?=
 =?us-ascii?Q?mqhVVQErKM4lseYwwPjNPMAjW03OySW+9zoGNQJRoRoBhPf+hKKgU+6jq9ke?=
 =?us-ascii?Q?tNUIQw8U9N9RrqRe9J3Wc/WNvD+xgenQLza4hsyrt6EOG/AuqU7ujfzYuCCO?=
 =?us-ascii?Q?17wPcK7TCRzNEtxQpUJNXBSSXtS8ohhGxsPhsVjObIifvrAAyilxgL6iUqLc?=
 =?us-ascii?Q?rnSKA9SGMXnBYxsJdKUeMBj0hNaY8GhCMLWH8Kswn9XkkT4PDhVvNH92euXl?=
 =?us-ascii?Q?PzRB8j6fVRJwFzv1NBGTqFkxtfNlEc7UzGMtL1UpXbF/+fina3eVPlXT1iW0?=
 =?us-ascii?Q?J74nPLiK4qkCLtjEfV7IRVCh1FJvmo8mcDrsAVKWCAlwMaBmzq4y6IucW1uw?=
 =?us-ascii?Q?MdrRBEEAEfaAHjWtkijXbtBn+7EBK2WKJvkarCeAtALJDTfCVrzirssY3Dr2?=
 =?us-ascii?Q?IOQD7cX5FDD6Z/ImLpYrp1WyL37Sxwq3IX+IG91tUTksJa+nT/MIXz2Rwwoa?=
 =?us-ascii?Q?nPdpadJdddcAJxqv3XdB6YpbUK10yaSbyAU46N7se5Q5U4l3BKavPjwhmKiA?=
 =?us-ascii?Q?+6/1H9v0RSy4FbtAnuHA9qQz7M7INmatbbl/xjuFLyJK1+BVOmowQDM4B7Sw?=
 =?us-ascii?Q?jRpiqwVC1C8x5/a/f9Tk1N/vgQv4FGEmUvQ2mE9UnPczCJVPzJ1hyTE+EKrv?=
 =?us-ascii?Q?sTfGEXQOqoB4z34eyYQwpoekIXHrFW338W6VvPhDwKBJjjCFEHZAVfGiRUFU?=
 =?us-ascii?Q?VdQLt2P74auKzh1RbSNO6C0fkqVi/Z3tAjPm6/Gs+jV6FESEaeUMl6nwvzfF?=
 =?us-ascii?Q?aDkquoB30wreY0wz1g0hSkH3sLA6diR/c1naJBbyYGi7x78HXTqYhc7aBppa?=
 =?us-ascii?Q?roDpfMAT3198qrG6+r5Jz4hOmKPBqDKHk4xVwtxeTSmJO/4UqzzuLnPfRV9d?=
 =?us-ascii?Q?eFtFesUlDhj1BkScnnjWXsZbz5YO9dbiGPPhI+prG+uwgaX+hc0oLqPcReZG?=
X-MS-Exchange-AntiSpam-MessageData-1: MYTWXvEbAa/Sp/oHnQ/yca6wqcf4GhgxONQ=
X-Exchange-RoutingPolicyChecked:
	gOgPtPlTOHVyQfH+vUdPJD7nSSYzLHa34QjXgIqsyGcOCGLp/AAzF3wgcVLEihQ16VkUSG/c/edVfqMapbandf8Z5f7dp2g/i5BVAQPcmwG+OP1Cu/hlf4R5o82SkibmTz/vY/lKK+FPEQB0fyTZNfu6xK9V68ExaIrSjvYhIHDcx8u3zqKAr+kgAy8qkcLJTUnj4CnJAKS1f4Rgi2rvtFAGi19/Q7cJ08RZyeNnw2VGY5/++Z2N3Ci3j17S8GpGLpsUpAq0HW1wq0/PgttYPj5TyINXj0Z/+7MM9ZPTRGvaqKHNqe4Lhfwh3Txio63dmKUXlpIK+xbYqO/RRmUP9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MVuWa3KB0kUEcdEpFcMiU+ENwlG59X9D9i34B3Go6j94MFL12iMQPzBOzymSgZ5720m4A+uWwE+jr9DRduHAm5/3H24IHm/RYZaFpk/BJRfYYCGDZPREQ61WFccwYC9YooK2ynPjbhhzgiL+1rdqMqSM0LOebrtwsqGPGETfspkHQx8BfJTde7GsHarcxBTlhvEs4M1AB8jaZS3LKOBPS7Sbag4n/XUPtsSblkSRywTFfBV/kFWGK3UWrY8EowA3cIPpse4aStm501d+TrayGdO1ZaZoeUFbwc3oLw/NGPUFmbTahK/cxKEFDCBv9k6AXOP/mNmW40rN1VQ5cEgyb5/6rAoioj/HpkvvawiIMpX7DHePzshn4aYBWFx/jLn+lFEDnL27NETPeia9dI/wSU32zf6xwHkdwfF9HbJWm0MqUmVay8Z4JfmoibzCUi/H+s2xnym3I1mxTnsth3nbOsp3XlrrxrFGOEWKhwwZ8bHvR5QVrZGWsDPCW4Il0WiUgfZ/e1QB2NBx2gvIf1v4XJF4/0UCDPkrOxfZOjmatmu7IQVAeC0QUyGN3pMiMY5iBBxnOYND60o3yXZyBQpRhgf1eoVV0ERZHIk3QOcYu8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeb063b-1ac3-4b16-70cb-08df1fcb6dc5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:09.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jmgUoQdBzYYT6QAQ+qH5xxuZFrVAj0ydMy0CFeEYeBuon9rgSnaeZTS0Icer0NI09S4OBHwpm2LSVcbGxWZVxSe1uKgoHCqYOabyCo1oug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX2HCd+QNLyr2m
 OI8qLMwDSqjSFeuVM2X84oUgcdljjxkzMICkmJ49D4WmP59uMkMhZ9/pXcxqmlNjqMfCV822zQt
 BXPjvtCAM1P1pcL4+f6HC5xW3EVfUMnELVwOlsR3YgbC9zpgl4L096Mubmpc0ajkwxSgNFr6dea
 2U753b9s7XRx4+VhRd5Ej5UYBip1sZGBbahFvDYC5F/J/RzKTN1tMfcqdy6OXZlDqBVfPjj8CdZ
 7yT1BOsvp8S/zGhLdmFmZjcAP7fUIT6X+fsqtUewp5pczAHFBrAFIEQoH6zmiw+nMJNwSS2wS/n
 Od7ihlG1dt2TDTu6FQd5g4prJvrVa5vOoMer82rpA83kFnPqq032Yl1ZL70+AdaF/lDxoip3DMO
 4LXFyZlc1T8hogb+BXfNGtFCGL6hr+rDrhGXH0PZ3zzqOY8jYHFrimHj5GpF9e3QZJX61AdobQ+
 ATny5jdMgGb7TMAPK7d5wQmfze/Icg7H/5moOxJg=
X-Proofpoint-GUID: a6S63fZcTM67N2KSJjuWblJcTI_8tjG9
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe7361 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=2l8DqRWQ2dbnbHYYE4MA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXyHZiH7w1oZ5Q
 /FRzwrl/G9SVCu5c31c6g5Z7QWxOpHJm/eBGQ3m6pRkb9yEpBkSiDi5cgiy21mmzWP/qvpKI8i8
 SMHp2/qdPCb1BdiQo7QoZmbFPXDg/Naxb2PYnoSDxLC4/JIj1+QW
X-Proofpoint-ORIG-GUID: a6S63fZcTM67N2KSJjuWblJcTI_8tjG9

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

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  | 41 ++++++++++++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_ialloc.c | 31 ++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 3633f4d28c3b..c9a211b7564b 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -3435,16 +3435,41 @@ xfs_alloc_read_agf(
 
 		set_bit(XFS_AGSTATE_AGF_INIT, &pag->pag_opstate);
 	}
+
 #ifdef DEBUG
-	else if (!xfs_is_shutdown(pag->pag_mount)) {
-		ASSERT(pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks));
-		ASSERT(pag->pagf_btreeblks == be32_to_cpu(agf->agf_btreeblks));
-		ASSERT(pag->pagf_flcount == be32_to_cpu(agf->agf_flcount));
-		ASSERT(pag->pagf_longest == be32_to_cpu(agf->agf_longest));
-		ASSERT(pag->pagf_bno_level == be32_to_cpu(agf->agf_bno_level));
-		ASSERT(pag->pagf_cnt_level == be32_to_cpu(agf->agf_cnt_level));
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
+	if (!xfs_is_shutdown(pag->pag_mount)) {
+		bool	ok = true;
+
+		ok &= pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks);
+		ok &= pag->pagf_freeblks == be32_to_cpu(agf->agf_freeblks);
+		ok &= pag->pagf_btreeblks == be32_to_cpu(agf->agf_btreeblks);
+		ok &= pag->pagf_flcount == be32_to_cpu(agf->agf_flcount);
+		ok &= pag->pagf_longest == be32_to_cpu(agf->agf_longest);
+		ok &= pag->pagf_bno_level == be32_to_cpu(agf->agf_bno_level);
+		ok &= pag->pagf_cnt_level == be32_to_cpu(agf->agf_cnt_level);
+
+		if (XFS_IS_CORRUPT(pag->pag_mount, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGF);
+			xfs_trans_brelse(tp, agfbp);
+			xfs_force_shutdown(pag->pag_mount,
+					SHUTDOWN_CORRUPT_ONDISK);
+			return -EFSCORRUPTED;
+		}
 	}
-#endif
+#endif /* DEBUG */
+
 	if (agfbpp)
 		*agfbpp = agfbp;
 	else
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 0fdb2a30e50d..482540a7e8e8 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -2785,12 +2785,35 @@ xfs_ialloc_read_agi(
 		set_bit(XFS_AGSTATE_AGI_INIT, &pag->pag_opstate);
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
-		xfs_is_shutdown(pag->pag_mount));
+	if (!xfs_is_shutdown(pag->pag_mount)) {
+		bool	ok = true;
+
+		ok &= pag->pagi_freecount == be32_to_cpu(agi->agi_freecount);
+		ok &= pag->pagi_count == be32_to_cpu(agi->agi_count);
+
+		if (XFS_IS_CORRUPT(pag->pag_mount, !ok)) {
+			xfs_ag_mark_sick(pag, XFS_SICK_AG_AGI);
+			xfs_trans_brelse(tp, agibp);
+			xfs_force_shutdown(pag->pag_mount,
+					SHUTDOWN_CORRUPT_ONDISK);
+			return -EFSCORRUPTED;
+		}
+	}
+#endif /* DEBUG */
+
 	if (agibpp)
 		*agibpp = agibp;
 	else
-- 
2.53.0

