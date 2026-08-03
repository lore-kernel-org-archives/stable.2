Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14832C957
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786744; cv=fail; b=cK/88Q2pMj81M75ZAf1oYEnBODmGhg1hbICCTzUxjPs4wtFcpimzaZUCUHcxFScIsOZNLmdR4X3lvA0V5FyunQnH0RE5f7qr02GCZMcpKj7GqiHssPb/B5gCNJIcM7mTNK16IRm61ZWYn71oWJ/kmVEoaNGM35y+i5rj8F7oLNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786744; c=relaxed/simple;
	bh=ZU1wEfY5ueZ/BDuFJg/WJP1PnNS2dmFuTaN6tVMSWfg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ac2Aunqb6jEMrVDxUfKSykRxuu9hfefF1u1aMGschQf7Qf1ZCtp9pjV8cMYMfunDWWVrIyv8gpu3f9qagwQPMjiERrpTm6JZIqA8H6Z9gQ+33FWBVnHxA09w/RFAu25qiQWK11ZIbke7EQ88BX/8cosHffveamUufnot5qGWs8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GIMK2qv7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dKRsgzN8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GIMK2qv7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dKRsgzN8"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CEdmM3099055;
	Mon, 3 Aug 2026 19:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ZO+eW1LPmdz9/wVZ
	4/Sx0m39o/OX7vhDcV9t181I+Vs=; b=GIMK2qv7Fl2H8jWm1smMRiTkEnlMOuII
	jqDVqKoxnzGsTuUwIaLgGWG2P6ll+wiIMHeFM/cygL6g3DfQHiWDON9eTYfI798a
	uyDEXIFGW2x9utV3mefdTReC2/5VgD6PQE1h0IVF+T4xWhU0A1eFKgFbCasEKnQZ
	vSU5B8gi4G0y2yi+71brb3m+4FRWQWpsR2doEcEOzzpsuPkUjU3pOZK6wPLNRmw3
	L1WxEyg4baPZzExMFpRJO4ekMonnArNWzevmRr8H18mm8kcM/5jfpfvzWMRqFjmL
	DOaNeYFadW7lAtxZIMxHJ2GbJaQYQH//XKscYf5GWu2JYdgIwMIxkw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7qa4su6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Aug 2026 19:52:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 673JpggM011655;
	Mon, 3 Aug 2026 19:52:00 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78s6h47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 03 Aug 2026 19:52:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vviVGdu1ManfTjcC9fIcaxFy3hp7w+cjyOP8Styfq7XkongyilGpKMxux8mk2DeL5BxsHCV3g5Kn8PXACdvGbHlrkL9RZEd8CeiiwDJOjXq5hZbAOPuf+4Rc9i6ugTA82rqaE+5i7YE7XvPHUxPlqRd6kdLXY2cGr9/BSdmsGcG6y8NFywNsURQ4WN+MsgSsrkMoj5fiIBDIoqCVuSMbUWjLkk0uJZO78ZRvjtxVctBfkq0frPgvl8mvcw6s0MLFXMGhhPatgVX0qRz9Sjk4C4a7PycpbAjH44hO3dzNR+1fwVlTsCi8E7zo7mbLwvsF5E4Du0DZ/Qo61fLGR6QtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO+eW1LPmdz9/wVZ4/Sx0m39o/OX7vhDcV9t181I+Vs=;
 b=cVdo7XE3H1NLVChgGK0wMztA6gwyNKJkYt2/ZaR/IUbYgS0ZYaOBBgoOyzD8agxv3eqm9UrrHrQvDzY/LTp7aoNwlFydQKmPmmUwHBUQ4OWMOMXpdVL9v3v3kX92vIHA99my35GhDXkRWC99RkONqN5wKoCvIl0y5yjUC839EMeADk9Q3WqJxjnG70zcmLKk/X407VOZQ/gUPYQ+Z2rUUNwe6cLd/yH6PpvJnpmncYOBw9wqoIomfJRtW6uKw1qPmY4LbLR34BT9V4eck9e3LDmkHbGxJKXfqD6tGfcK6/zjBoHNg0CqiYTDmPHLRX9Wh53pZDRsXcT5F92A+yAeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO+eW1LPmdz9/wVZ4/Sx0m39o/OX7vhDcV9t181I+Vs=;
 b=dKRsgzN8xkDmVz7PVnjmZIS/o/x9X52EXwXRgR/xGj/UMEuT/q+c2iubQVxMoyJhLMG0XwXmceTHhZfXk4/5XOaWWFOtLULfkLIvm3hjJEyeLuzp0uzujZTEQHPqMCkZZlrkJbHQWvO9Ccs1T7J9IM2iJ/5L735EZab77k4A71s=
Received: from PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15)
 by CH3PR10MB6859.namprd10.prod.outlook.com (2603:10b6:610:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 19:51:51 +0000
Received: from PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::dac6:5e5:7de0:d399]) by PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::dac6:5e5:7de0:d399%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 19:51:51 +0000
From: Wengang Wang <wen.gang.wang@oracle.com>
To: stable@vger.kernel.org
Cc: wen.gang.wang@oracle.com, borisp@nvidia.com, john.fastabend@gmail.com,
        daniel@iogearbox.net, kuba@kernel.org, davem@davemloft.net
Subject: [PATCH 5.10.y] tls: separate no-async decryption request handling from async
Date: Mon,  3 Aug 2026 12:51:49 -0700
Message-ID: <20260803195149.7578-1-wen.gang.wang@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::22) To PH0PR10MB5795.namprd10.prod.outlook.com
 (2603:10b6:510:ff::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5795:EE_|CH3PR10MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ce4e47-53c2-477b-21cc-08def198a926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9fry1DWAN4eSKEBqT24w6M0yVKWdPzm7jBw3N8cRhYoO1I/XcVpCqzkgwcrjWnKoraq6zjLyBsleMHlA2C2rWv8kKwZ7LSWEu62BbQbGvPovVHOPc7Wo0kDdf+ZdMCLnGsfoAPsc2KBivtW1YHYqVB1jL3VHGhnXM0L+BI+dgDnzVczBWEK7x9RKvoK048H1gXg+BLkMsZGENoXL91TqHKsr3N/0zPnolp8iGddN5XHB42fqePGHrStMRN9mZKUKk+iCupLczjawuPXxTq6Mari4GTuLOo2MyzSISRIPhIonu8lYMnWUr0JsELsJ/h7YbqaGVTQeFYWkPxLhgoQmqtJfhwl3KL75NF5gqi0j3Oq1qpHWjXkcsvfqHiTfAyvAOcENumbkhVJ0X4HZL33HiHfRwtVXCXqCUlLFaqXiMvmwCmfGSL8yoeJ3ODIJpzGXsLPj4CXFYyEEcYjUDafRaOS03uL7VCoxF8g2kPFNP271zvYGZ9F9CYtDVJsVkm8MSsQ3A3f9ve3grZ9Ai2pAaqqWDLwteHsw6LnjLi+bn0dt4d+kiZdiMOOIVmTLtdGbWhcDap0oXRy1F64p+hB1aKmPGYZ5MP2xPW89IZvJUxAcJh0Hq7IGIeOnF2z/+iXSEU40LG2qNE8BAZbp7cZCWaQgYZ6wdT0YWnv/h24oFBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5795.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w9DeVEUdxX7GbGMTaudftXKu4TkObmUlUXopOjvfjn4fCSUJeyuQp6F51pLh?=
 =?us-ascii?Q?8hLISb/VTBS1t4CPEl7J+xK8nwTX0s3u3O8/5EDw5qE8LWxrUFiz+vSm5WfL?=
 =?us-ascii?Q?n6c98+wkcTz5l27ltDzCo5p7xZCWtPmPf0ErDzl9TQ1ZWhIj/t0/HHX3rx+r?=
 =?us-ascii?Q?09oXVIZ9ERIPdue+TSptIOx68mcRMCSJz34pOgRufMXCtW+6hSgz64Oj5Mlv?=
 =?us-ascii?Q?ll9Ilos0+zzPWgclz2yuQ9rgW9wgefmISFeoX4BlmAEUM1g3Zh0/Pf3Iar0h?=
 =?us-ascii?Q?WXzf8ZVKvkA6Npu7/ljjyd9IQaOb6cNReFZmpLk598jKaWkec3GLxPi2wY6m?=
 =?us-ascii?Q?+/NCGQ/ORt41e7rJ6wTazH56SuKcpjF4MkpsiS+dT5udrH/PLDjijY+hoItp?=
 =?us-ascii?Q?rV5ICfteQWQ4PaLhCK39CorB+dtxVJ606Mhs/wNmVUu+GqrksQlCpAYKVzpS?=
 =?us-ascii?Q?Jjl9Hq0AOxZp3DJOWiPSNScBvo6UzsaidD7o8Y35YJJt9J1te7vGJafhoyMd?=
 =?us-ascii?Q?GPIBytSpTrmVG3N1bqPwx94O8Nk0+RdloiKB0n/SkEGzTdsoKdNfV/O2Pl72?=
 =?us-ascii?Q?N6hXUDG79OsRuswhnRq7sdgemywcpW18YHM4T1aCw36nZUQAdx5YftpKdcc+?=
 =?us-ascii?Q?tVuGMnI4FNUqyErUk4lVWE7nrSzT6i2LW+t/QlbFrvzM4hB3ZKfWG3ooK/mf?=
 =?us-ascii?Q?5IY158JzS+RlgmTa2KV+VfeYky6WpxSLnj6BiPgH4yTxqIh5UjQ8AYoxP+I9?=
 =?us-ascii?Q?l0keq/OHFQS1hGzOsvVCRByEZeQSiMFpT2ww1uC34MdePs9lsw/slo+p4fmk?=
 =?us-ascii?Q?t63y0ksCAdDzyvKrFk49FoOYQLSHYjABj3mGpYJeKgoRLD/F1wkrmCdpF4EV?=
 =?us-ascii?Q?nE9cbcufJ8D0QefwVm80ILYu22CiXtusA0DGxUhtqe/LpCII+tT2gU6xjKPT?=
 =?us-ascii?Q?y7KVVMqSkQM0VNilJrRX5rOxXja7mPWFqLERB5LVFe47Xr96rUyvr/Xx5W3T?=
 =?us-ascii?Q?RvZlmNGSXh3gDI8mEKr4aOpxz+HXPImm/XZdjf6ybdUHSOjyPTOT/J0sVvPU?=
 =?us-ascii?Q?gMKRruHs435VuHulzij/3GybRZZdCYb7SbeBr1p+SrYYrLtZZi8Lyo2Ps4wd?=
 =?us-ascii?Q?58uk2oM4Sm99+liBjvEJNzFWOIPgPVwoIudr+pA86yv3WUEMOhfYrNsEwgrK?=
 =?us-ascii?Q?UitaI8UeQXbBjj+dNjlUBuMbB4t4KvPBFbkvDja531IrcNDOn2gnav7C0ZP0?=
 =?us-ascii?Q?v1ixHHIsFTJRz9oAIebBTTKzQYJRZr74Y48FatcUai/FTpFUOdkzomSPItSu?=
 =?us-ascii?Q?dtM0Wt1PdnuXHEe+j3CECywm+zmIEhO9P5U0ZAY8BkRciJvpgVNGWCWCwqhH?=
 =?us-ascii?Q?9rpsU0jLM4dr9W/OZJ0JL3gwRcQXjvioDYqQ57L4G2VRUm7OWjACP5pVlsod?=
 =?us-ascii?Q?MXYxUYx+K/H5ePuxKEOalfToUwm0VL36WBMCyFrwaJ7fe1PGLrseN7af3bPn?=
 =?us-ascii?Q?Wb7IKJNsNPKAECId1F4sjFDgQcw89tU7jMkUKKAEEfjSw/Vh3/dffc1H5bY9?=
 =?us-ascii?Q?BBq3nlpruuluRv1DT4Kuk2EofFz10rt50ZUatIpz0u4SJS93hgw/wkTN9lG9?=
 =?us-ascii?Q?LbI2kfr6tGehKX2pC2H+mjGwkEc6ri7uX/UDdMRVaHV2VLxRw+qJmUtPMLAd?=
 =?us-ascii?Q?aiTD5Uex3CyutKIlv10X7UKTS3HWnGKIwoRNBuhX3bXL3o9Dd5xvBkO//LqY?=
 =?us-ascii?Q?NqtmJp1UuL9bx+rgdncvQoi2cKievhU=3D?=
X-Exchange-RoutingPolicyChecked:
	M3xhjf9+P7ROCVjoCtZCsYfwHCIo3MpSO2jAsYTTmpHppCnuiGkSN9ySXOUs4Z4Pcjf5MTYok658LjdPVIB6yx8Ew/7HfWjFtmrQRYQThkEQJ/hFxmuoMpdRjyJQtWulHFXhC+QSG+/MqCzfkg5vlghqunXLnZ7/icLSwpzl4rJRuJoY4LrfdxeTIdWVv9KRgBAmzHTWJL1kroio/jTZcDIABWXKm2R1UjRPcJj4iXs9KeulzUWNHWUzbzRdx4Z2tF3CJvAptDUXwqUpb/kJAp9kOk7E1UN0DeacKgppb6IJAfK1oMP1BSoPXxzuRtHiQLe2O19vrpFkI0AYAAgzrQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2koUXJ92+yTwVKd+bsqGZlPPZ0MM79D67kR8McQov4L8PV/gDEIl44KY34efEmQzBxlphYOV5fXmMAf6KFeBJ946wrrRNEmdAJXGP+XzBBoLtGYqhssap7U3lL3XUS1d/yOws+0Wyf90LH73VlUv4j+Eji1RLxjn6Uk+64XvJp/vmCHQmQFrlLCmlx3FVVOxc2ZucekyfFIO+uJSkRZfxsvgpdSDg2kEKV9/tB4hsYreCIyWm3AnbplvOH3x4fdcC5BBJQkpFN+jKB1fM7uvlIH2HRqHvvuNdLA51LTTDo8u7400VxRJsqH1MaA1a4enXaVreinAeY35BcqwdpDM0M+M8VFxB26UvG9Q/gJ0FGkSM25Uuv3p3yTVOYG2Pr8r1SRNs/TlHyBOb0InLUoxUe42ZkPohxjaIy80Xftvh0YXRxVZDUGLUbCkFF1TgCX/IXLADJOwd+/aH53+WUCAfL0YzFtSQQqyFl25tXaiGAYf1HMIwcRVuFTnKQc+TtIx/6M0Xtk2sWXQPK/2Q8JAPKbaChmZOfa36LQXQFvGQUbQRbOgqx31mfS4DWgCYCvG8q+ZERLY9fN34W88iP73QChpg5MV0She928pUUCs7Pg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ce4e47-53c2-477b-21cc-08def198a926
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5795.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 19:51:51.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1kez5I/YiCCRRi9EIL2ms7F/7CVl92lWEAdLZ6EJknCDYzUA5hN8SVdEDbXmr/gxHISiRecMvv7aTvyJbBIfBOhv/cRwTgwkdc9roK+3qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608030175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE3NSBTYWx0ZWRfXxK5RMKbEKKhI
 xKzRWw1r6rPOQC974HMcuDvwMHZQVbFEPorwroyrXxwmhLKqxhpvgM871CeAE3zFoIYT8mf7zBL
 yrKsCVYJkwrdMeknf235wEMT/UxdfZjQ7f4J7ZJa78yMSIV4xAp/IpQX3h4h0OFZ3kByuEAdaPx
 Q1aRq9E/OWbywcNQTcMkq1hOAcTzph6VwcIDV7u5ULANGnRajo//JDyHxBnkSxEqFmcPO5eWd2+
 wSRx+QmT/1DUadI66H4G3ISrBdd3NwkULYqFvUi/1W3fnX3nuoIOYn8Dz9/xDY3xiIpESR/ZvhQ
 hgb+vSWaQjX9F2s8F9mvamUlm7NSAIh4VI0UeAPaHtvocc26ikaFcoB2JgGYPmxho7uK3G1jVhV
 tJPJkDmngKBOOemUca+3CJmDDgPRIJ61UFHKpw0RjolAEBanCraKlEbta+ZqYovetMt9kVTp6cA
 mxrjq9/53GNQPXcTqdHozOAyeDg3pn8rTUUlszy0=
X-Proofpoint-GUID: EsABkhMje3rvsWrG7FaPUo6EMscPbuB8
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a70f162 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=AeCkNC4mAAAA:8 a=yPCof4ZbAAAA:8
 a=gvVCcnFBXYXUeE-CmooA:9 a=3H0rhiSm_XezoJcgKFaR:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13510
X-Proofpoint-ORIG-GUID: EsABkhMje3rvsWrG7FaPUo6EMscPbuB8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE3NSBTYWx0ZWRfX/QD8ibj0fJ+M
 VkIqFOzJ0oBbsr4oICTAWjej9aNuSXByHV7CyAgLUk/QHLUcMUc+j0kqJWiXizmKV6dqdTEiwbW
 Zk8ssQMbHm3Pvcg7JqPvyjqQQWKshCGzEdXZNlbeJpfWGMuo/Zzz

From: Sabrina Dubroca <sd@queasysnail.net>

If we're not doing async, the handling is much simpler. There's no
reference counting, we just need to wait for the completion to wake us
up and return its result.

We should preferably also use a separate crypto_wait. I'm not seeing a
UAF as I did in the past, I think aec7961916f3 ("tls: fix race between
async notify and socket close") took care of it.

This will make the next fix easier.

CVE: CVE-2024-58240
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/47bde5f649707610eaef9f0d679519966fc31061.1709132643.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 41532b785e9d79636b3815a64ddf6a096647d011)
Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>

Conflicts:
	net/tls/tls_sw.c
---
 net/tls/tls_sw.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1732e3549a57..29650fa54666 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -257,18 +257,21 @@ static int tls_do_decryption(struct sock *sk,
 					  tls_decrypt_done, skb);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
+		DECLARE_CRYPTO_WAIT(wait);
+
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
-					  crypto_req_done, &ctx->async_wait);
+					  crypto_req_done, &wait);
+
+		ret = crypto_aead_decrypt(aead_req);
+		if (ret == -EINPROGRESS || ret == -EBUSY)
+			ret = crypto_wait_req(ret, &wait);
+		return ret;
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
-	if (ret == -EINPROGRESS) {
-		if (async)
-			return ret;
-
-		ret = crypto_wait_req(ret, &ctx->async_wait);
-	}
+	if (ret == -EINPROGRESS)
+		return ret;
 
 	if (async)
 		atomic_dec(&ctx->decrypt_pending);
-- 
2.50.1 (Apple Git-155)

