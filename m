Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B15226AD;
	Thu,  1 Oct 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866385; cv=fail; b=areslz/YE9oAw70IZX9hwN71DR33tF3MgxaE+/X6AZCTWOxwzFAvk1y3YfITARUkwKY0Fp9bL2I5c5kingMVLIW3eyG7J1m+ts5aqXecxmOf1Cu3wUmLuCnSixRgSKTTH3JDWMoh+YHxYeySyfpE6XPDNLdnUlpxDPUTUUJx7wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866385; c=relaxed/simple;
	bh=uK68y3WbSihIenZDO5MoNl58gN1eu9hQHl2gTWI15U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/fo1hiCnEuwqiMutbrlfTfnfE6jP4sIcuOgRWDZIL5uW/TFSjFchHtCYI2RS8nAkIbxYxr3W0t7GA6dUC9BXU4wyArn51n/eLUEbjl5zXZ806BsMDMVhWvAO02u14TSXqfPHHmQyJ2oL4IPD9HYLyYwSCGjOsreEFBQqYwSCFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gOjJ4xKq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vft1Iprf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gOjJ4xKq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vft1Iprf"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMe0w1410765;
	Thu, 1 Oct 2026 14:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oYd5fPN0G8cgRUtX85ZaIeXIUJTcYalEibM9PQcAjTg=; b=
	gOjJ4xKqzai2aPNvYTzLpBc4WzF193FH2JDo01M1mEsD7hK8IznNyVVQJdq6ZMgZ
	scYdgoKm2KOjYzS6jqaB04Lg86X9baoQK43qkBiAZEe7+kVMpPB+Iy7pkFaRcFYB
	zxNcTQLtwxrRt1upWhcx+19P4aYy5y3sMTzTX1Saxtb2BVTfj5MQZw2dJb6PQODY
	El1puhmUH1lEK13CfNU6elvPJT7qwscuTFjOLkGD61TgzqolEkiWqpfPZ4j3+cO/
	h2J7Fnu2TRX4dk+8IAOSnz/VzmBwYGFiQNDBwbja5cjpbs2O+tYhoX7F/AHbyl+e
	9BljM46f5BGb/5fEidlRBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4y9h625-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoUTM031897;
	Thu, 1 Oct 2026 14:52:57 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd45m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2ttw6whX54oj3uzLbEtXYxUzir9JfElz1PPDpx1+QlYQQDxhp5LI1acVGF16/tOD+3rHIjzVp1BLzQ+/ycshY3jbJHOVns6114W2vbCow3pJ5IDM+9eCLemyqS9lRNkrxORc6/JolpnyNRaVsLQpr0m5aEJjJ5xzpsoa2vCKnFNkAsw5J9LEopzcH54ke0WwbkEGcr735eXg6oIqHQotdRMkNJHunHIjNdiIv9IOtioUBU0RwwkJIW+efJJ2344vXwDDeHRoaMFkhBAsTEqtiYX4Y9M7D6h1O/h/wgt1EpdNrabUOTlvsQKRWKjUSOeYcT47bsaGdXvj4eb767MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYd5fPN0G8cgRUtX85ZaIeXIUJTcYalEibM9PQcAjTg=;
 b=BpOgD6bwmBawjXuG4j765QOYBIe7edu+EjkxaYqnnMeS5oj6WuOvUYwaVMTFzPp/YZEVXao29E4U5R63LPkPwmveFpPhhl4iKlDr1xfpYtko1hW0H66311HUHmZpB1r94foQJhfvUt4BX82ekkSqJRelIfDtmmkHDLcZ5UqKo8kYtHMs+2EcOpwr7Q7n4dMNGyixqH++o7gqqhmyEHzRJPS96xfm1L9+C36TYv6kkQnZL2sI7RPQUwEiSv5Teyb2ZJkMPX3XbJte1yp2Mk1s5hnmOY5tW58Pwq2jcsn4SP7f8P+PRER0VIQ24uQzuIphdm6kUSfDiVGccEatLBuXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYd5fPN0G8cgRUtX85ZaIeXIUJTcYalEibM9PQcAjTg=;
 b=Vft1IprffzAB4lr0PBLUwuQ26a05HOsjVIqu3+AKSNNiPR1DIbG+Y8z6luLBvHtQPqM0J9iXfobwLpnhWmqZ9dxwe/K893S9LJwkONJ3FpESxkd6fgctG/z0RzMPFPHmjoYTgY5miUnohk1dgwlRis6YQ/OMae4jRzi8SIsLEAw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:52:51 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:49 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 10/21] xfs: aborting inodes on shutdown may need buffer lock
Date: Thu,  1 Oct 2026 20:21:23 +0530
Message-ID: <265fb33360a20bbeb9bc22bbfbb119966b05fa29.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::15) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4c51b4-cff9-4aae-b51f-08df1fcba93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	jeyG+UsBWg6JUMYlD/ZE/0orTrh3zUhm4IxFSWgYNp8CO2B7t6weN3ZKSh+VyQVhcgz4ZCiDVf7hTcLDTBbFIYX5Y+pm8l5mALl4o/oAukGo/HCRrP2CzX9gRQV1BZzj6Lgglh3BMHlEURVQ3f08OjhmkpzCr1RncT+z4ardAI27+eLrlgtxbGjgSvLC5hcaqAAN6ItYaIeLYv8k9/j1u4/nkR5HiUPdW866pXQPxWMK6M1Qd38qVs/R1+Fjgkp7JJrvXJoYwc7UPt5LRrSKZFghhU9SRY/DQ2bBWjJqeFBQZgT0qt5G78+hJ/L2RuTmHZcqFstD5hVytxsN/6+Dc/x7G+hUqU228rgHT3cL/15OnC32y20Qz7+lnV/fAergUJ5NZpnEvV6tf7lHkDeGG3fpxGkg7w3dOvsUk9j759lm5bk2DwYh8kHK3A+elIsCrIv2ukVCt6YFVVtSNRZdaLT2iMxYaskMZjsA6R2hE7k3SjAoX6QDlfs82eaIsbPzLRboAK2LmnrYceAt/65TuazZSPv0Ap4biREzy+48I7uNdNOftT8+f0ya40Mkj2NySwgW9cqgP8ufkbjUvY/biKxUW1RaZWWLs3O679c0BHVgTp2nAhpEIPjcVdjTj2/4q64VJnag0Wo8krVe3XTN1dDSXNNzJffM6ivlMAh1m6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q6kihMXjHOo+tcc5YCgn2f55GEn4wT1JicfOKSlMcmvjmzf+LXM1bQ7PMO0O?=
 =?us-ascii?Q?N9nw/eiTnsbJHY92bSCG0luRCOrmUGrEa8lE+jzCPA3LJWsoRmyTd5KsPu2I?=
 =?us-ascii?Q?p6ZCXKi/clufcwFwlu5D2nE6KYMlyqfE9iCkLrYtmCVPdjruZJRi1llffo81?=
 =?us-ascii?Q?rgVJcdDcL9pLtwFzLsdyccrf/ULwAMYLP9mOCGdwJCN/bmsGDqBs0SRMnOzM?=
 =?us-ascii?Q?b7nF6/Ph3sZE2gM9ew8ZuxR/9CdVbXtOu2RE0ZRDXMZN5qaozIf7Bclju2Ob?=
 =?us-ascii?Q?BoYfkb2DtXo7fjl/fLnfc+qKMqM/49t8DGIz56hY7rtZB7P3Tqhr1UqmU+cz?=
 =?us-ascii?Q?1Tbj3R24/nCdnWxEdSZlTgxSnUVZKvqLaxenKkI08lNd4pIkwTBJs/+ZVYY5?=
 =?us-ascii?Q?MyySy4473xVYbNUHEad7RFAy5mTpQ7AWtVY7fD1rSJINW6S+c45lNYxD030D?=
 =?us-ascii?Q?mfbeRXRxuYopj31FWLp7Nv+DhtS4rGlUrZY4Rbbg+S57GOo+SmUyjQUvgYaO?=
 =?us-ascii?Q?Bvudi+aWMOGoKKmw9zzsODA7cqVg+Tzr5tH+3T/3JnCCa0mAKCGHErdRNZlu?=
 =?us-ascii?Q?8YwWJDuZgsPZZQtlmatPhy0lJwHK4TJwn3ezQ5ed7+Gyd3z/XBJL3w1Tba74?=
 =?us-ascii?Q?IMbNnifRp4pZYecPJse16BhGJdx1YhudAYZPoFLU2U13e8FIg3pBQDcoBkoL?=
 =?us-ascii?Q?0m9swFWEuUWmCyJ0LrGDyEroRROK5WLgz9eY6t8k5B0Bta4OwVgl0pHxOpNI?=
 =?us-ascii?Q?rHINrAzJ1M0huzjzl5L1+RwC1nUOw4LbIrpyZJckvIqa4HaKTKQPxsN5r/YK?=
 =?us-ascii?Q?uSZTVdCxL/u44DVyTa6oAGK72q141Fq810JIOq+f7nPPdCPahDTlqijmHzFM?=
 =?us-ascii?Q?6/J5uxxLqnWpsD/ff/NmNb1X9UgSeSFeP1wDN5b/0AGtjN1LN9mhkJLPKcqa?=
 =?us-ascii?Q?rC6qQmTktS10OyfsklfFbAkFYx37ABc7LkZXBJjpnCd54GuN8Yb6ngk4gd4D?=
 =?us-ascii?Q?+hURQqCdiGfFjeVJxLe24MGtsQEY2cDOr9UisHc6vsp+xn9zAAUB4L0HQQpr?=
 =?us-ascii?Q?xzGYZLrwwi6gW2Cob67Le/AS5IVfKhJFNfv3JNeDlDMTaLbxpOm1XDFL7Gpj?=
 =?us-ascii?Q?15mnlnvFMNYhNLbPAhySpQfXYopNl+Aj8gFotFTYAzTrmWEssi0nlX3QAEeT?=
 =?us-ascii?Q?4Y2gdId19Pwffr+L3v42LRjOky+y90SRFV3EbLRw0aAWyC7P/qSTkcNc18NS?=
 =?us-ascii?Q?q3X9veD/3bE22/1I16nzMcwGILOMytAAIbTj0dKdMw3DEpqL1iNFqO4Vnnit?=
 =?us-ascii?Q?AKLoyACWa8vYPbl4xmUTLzgUWZv/L6I48UUrumgilxm7W1IbaNItajlfZNlR?=
 =?us-ascii?Q?G/fjlVw8WmP2yyfJ5EOLQsclt/ZaQsINOp6/6xrS3uD7lDk4FRaDK5Z1zrGh?=
 =?us-ascii?Q?Siz3vwFrqzX6IBIjxbuqUAA0UMIFeY9tj7ayCTR/T2wHBl/v29Jq40+9jdWp?=
 =?us-ascii?Q?be9UjOwoA7fp/Kq8kHBMaf7BVuXC7eLKjEN8MRuPeUyZU02sm+nc64zEvooc?=
 =?us-ascii?Q?YQ8i0djfZA4mu13pbI9uqnpXv4FdQnVWDx4xjx7WMsiYa8r9aK4NN/hvS9nq?=
 =?us-ascii?Q?icMJ0+pzrmNB5rgIHFV5VqiaxhpwTLeMveafPO9bxCEj5hRIf73E/IRZj/V0?=
 =?us-ascii?Q?m+YOzewprsnRDBPqYE8+obeqdCCo3m/4HXSo5HqEtl8P2dNOLtDo0yfuT23v?=
 =?us-ascii?Q?InlaZvhGR+XCVHZ/gEm4c3Yny9yE23b3TpN7PQucc3ER7dqsr9y3TtUrAW6j?=
X-MS-Exchange-AntiSpam-MessageData-1: 9Wb6INsBfn1ieVpYOT4NipfSGlDOPa1cv6I=
X-Exchange-RoutingPolicyChecked:
	1qOAFuO4Hq3C3r/j5KKlQ0Qd+dQM8YMUyFoMZU7NTgqX4aKCL2sg+X7KtLHR3Ls85xiiWSV6y6Mnp1qcZoAH79uXHWkMjOqp7MfuE9Kw2EpNcVKM3UyBSAHsP/6Paci1nr7pjYs2fnt80aecBRMkf/rPX48Ca4rkm2PRQBfbYJLUtZrq3bdEMoXTvB6fwuvoSBT3LtHTMuBvP7+pSMVVrxaV6lZ18Y+XDi01KNorbbeM2oZg+i2Ym0E/1YmnUGqF1vgc0CZ48UqKBIVj4zlz92ryDYSYpJlmasJtVZev/ATCqRkFi6tZ88qYyy/vxGi9V0rgRPCvkPq+/Wsku6maNA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B6HvqUYZb6uUfF9YsKZlzlk+mNqT+EiGRUMmQoCmuH1t/mQUi1ZV3UZp0w2Cl3V5BOoBU0LYJ04K6v+mXlue3w8ZSrNO6UHYBCNeLyGBBjxxQlxrF/GsQmuX4ckoOHULuyafHHA/d9aibZB2IRowg1HcEp/wYSvAoAc5yNTLl2C7XUuApYZfVCdgVpyepDomf9Blx3ptQqXSpgAjdZ+OL+iNVZpmdcWWn0BYSRtbPQ4XuNVC4iV5GJ2Y0R3Up5IabWGJvCfylVhXVGvOi0qb/XB6aS5Alxbgrn8DYAFZLIbZw1wjfz6TaFaVT3tmtx5XoEabioSr4Mc2UNcjmT4mO15UngjO1F93nbR/G+Crng/DwIx75oLe+76HB39xF0lGGTFk6WuQxnImaQRm0kRZYVvmUWnyIRU5l5tfgEce9XqmYlbTC+PlEqB8x7YZCda1/sSfdg1YBy5NxObGZ4fDLzooCTTQJD1LMFdKGj5eSPqw9b3kP7m2j1QPfOeBygvDCBRi4N1XZXpx41HfJwPk58Uj40Xa6Rs5JjPDCUU1/682cX64bhVQoQPV0oPGe/DLV7CuvproTt+aa/s450DR23SEmKsUh+u0SQGwSIOISac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4c51b4-cff9-4aae-b51f-08df1fcba93b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:49.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQLpK7ZgSQVZt4L81i24gR3gAMZ+P1X9ZEv4+kxwjoC0SNVnrxnvU1mklDElPUwKdbn6sbpfZH+HzLWslgv548+cjIk+zUyxYVpT41WFXjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX7+eqNGkofXeG
 +PEueHHEhvcENCAyyBqvtH2A5U3FL7nyuuDgP6+Xg3WH3sR6lGB6ce61n+7wv1XobV11oUwwvwN
 yhLJ4D8z++eTRJfEqqdQ3ITgyIblTIS3vZG76B9MlaT10gVsloHIqiy1uSW8EG7FLdU6hMdqzjz
 IXeeTPcX3/Yt2VMEhbArcV2pvZh2ZAfwUpCiWshGxxJ1s2hT7iPF8R9lQxBPJUHBnwvOT2H43Ak
 KD1jPcAmg7FuoynC+RDMenRmpoZuV3oW1Ujo6QhNY+wqLH5iH1Bs/E6aDvtGQNjb+PIexm0jH+L
 13QCYMYk1I/5Yggd7eVslrgzDdeDTpvwhz/RvVZzcC+rWhz9xhVYE7fe+bgw+4BAdMBlg9uUT3J
 A16lS0vtOoIxTcNfL18e+H19AKGYcOgjEKvTmMyocA6RXpfupFe0WzUmrim9/0fdLbNVW4D15pr
 YqDHpFkpJcu3lVDfC907X8pYa9G8oEZY9c/Qwe+8=
X-Proofpoint-GUID: 9Nz5cWdIM6NznrYkFKOJ4QCy-_oAuzgd
X-Proofpoint-ORIG-GUID: 9Nz5cWdIM6NznrYkFKOJ4QCy-_oAuzgd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX0hItT6mF06TS
 iH23jq/j4M3g8rHVIQdypFDnvCeS/pJd8zW5Ye/ZCzVNkGHJ2Csx2udSixc9BMwXyZDBDY9Ourp
 Zj2dyC5CIRLZVVPol0oSXlw6ju0RIFcDaFf4KBB/Xyo+UhlL/Dda
X-Authority-Analysis: v=2.4 cv=IuyL47/g c=1 sm=1 tr=0 ts=6abe73ca b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=45b4cX4q9fnkLCOmiR8A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537

From: Dave Chinner <dchinner@redhat.com>

Most buffer io list operations are run with the bp->b_lock held, but
xfs_iflush_abort() can be called without the buffer lock being held
resulting in inodes being removed from the buffer list while other
list operations are occurring. This causes problems with corrupted
bp->b_io_list inode lists during filesystem shutdown, leading to
traversals that never end, double removals from the AIL, etc.

Fix this by passing the buffer to xfs_iflush_abort() if we have
it locked. If the inode is attached to the buffer, we're going to
have to remove it from the buffer list and we'd have to get the
buffer off the inode log item to do that anyway.

If we don't have a buffer passed in (e.g. from xfs_reclaim_inode())
then we can determine if the inode has a log item and if it is
attached to a buffer before we do anything else. If it does have an
attached buffer, we can lock it safely (because the inode has a
reference to it) and then perform the inode abort.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
(cherry picked from commit d2d7c0473586d2f22e85d615275f34cf19f94447)
Stable-dep-of: 09234a632be4 ("xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_icache.c     |   2 +-
 fs/xfs/xfs_inode.c      |   2 +-
 fs/xfs/xfs_inode_item.c | 162 +++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_inode_item.h |   1 +
 4 files changed, 136 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index e69a08ed7de4..d973eca1a881 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1040,7 +1040,7 @@ xfs_reclaim_inode(
 
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
 		xfs_iunpin_wait(ip);
-		xfs_iflush_abort(ip);
+		xfs_iflush_shutdown_abort(ip);
 		goto reclaim;
 	}
 	if (xfs_ipincount(ip))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 19008838df76..2de204f46216 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3613,7 +3613,7 @@ xfs_iflush_cluster(
 
 	/*
 	 * We must use the safe variant here as on shutdown xfs_iflush_abort()
-	 * can remove itself from the list.
+	 * will remove itself from the list.
 	 */
 	list_for_each_entry_safe(lip, n, &bp->b_li_list, li_bio_list) {
 		iip = (struct xfs_inode_log_item *)lip;
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 38b59e8070ac..c9ef341d4ee3 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -518,10 +518,17 @@ xfs_inode_item_push(
 	uint			rval = XFS_ITEM_SUCCESS;
 	int			error;
 
-	ASSERT(iip->ili_item.li_buf);
+	if (!bp || (ip->i_flags & XFS_ISTALE)) {
+		/*
+		 * Inode item/buffer is being being aborted due to cluster
+		 * buffer deletion. Trigger a log force to have that operation
+		 * completed and items removed from the AIL before the next push
+		 * attempt.
+		 */
+		return XFS_ITEM_PINNED;
+	}
 
-	if (xfs_ipincount(ip) > 0 || xfs_buf_ispinned(bp) ||
-	    (ip->i_flags & XFS_ISTALE))
+	if (xfs_ipincount(ip) > 0 || xfs_buf_ispinned(bp))
 		return XFS_ITEM_PINNED;
 
 	if (xfs_iflags_test(ip, XFS_IFLUSHING))
@@ -801,46 +808,143 @@ xfs_buf_inode_io_fail(
 }
 
 /*
- * This is the inode flushing abort routine.  It is called when
- * the filesystem is shutting down to clean up the inode state.  It is
- * responsible for removing the inode item from the AIL if it has not been
- * re-logged and clearing the inode's flush state.
+ * Clear the inode logging fields so no more flushes are attempted.  If we are
+ * on a buffer list, it is now safe to remove it because the buffer is
+ * guaranteed to be locked. The caller will drop the reference to the buffer
+ * the log item held.
+ */
+static void
+xfs_iflush_abort_clean(
+	struct xfs_inode_log_item *iip)
+{
+	iip->ili_last_fields = 0;
+	iip->ili_fields = 0;
+	iip->ili_fsync_fields = 0;
+	iip->ili_flush_lsn = 0;
+	iip->ili_item.li_buf = NULL;
+	list_del_init(&iip->ili_item.li_bio_list);
+}
+
+/*
+ * Abort flushing the inode from a context holding the cluster buffer locked.
+ *
+ * This is the normal runtime method of aborting writeback of an inode that is
+ * attached to a cluster buffer. It occurs when the inode and the backing
+ * cluster buffer have been freed (i.e. inode is XFS_ISTALE), or when cluster
+ * flushing or buffer IO completion encounters a log shutdown situation.
+ *
+ * If we need to abort inode writeback and we don't already hold the buffer
+ * locked, call xfs_iflush_shutdown_abort() instead as this should only ever be
+ * necessary in a shutdown situation.
  */
 void
 xfs_iflush_abort(
 	struct xfs_inode	*ip)
 {
 	struct xfs_inode_log_item *iip = ip->i_itemp;
-	struct xfs_buf		*bp = NULL;
+	struct xfs_buf		*bp;
 
-	if (iip) {
-		/*
-		 * Clear the failed bit before removing the item from the AIL so
-		 * xfs_trans_ail_delete() doesn't try to clear and release the
-		 * buffer attached to the log item before we are done with it.
-		 */
-		clear_bit(XFS_LI_FAILED, &iip->ili_item.li_flags);
-		xfs_trans_ail_delete(&iip->ili_item, 0);
+	if (!iip) {
+		/* clean inode, nothing to do */
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		return;
+	}
+
+	/*
+	 * Remove the inode item from the AIL before we clear its internal
+	 * state. Whilst the inode is in the AIL, it should have a valid buffer
+	 * pointer for push operations to access - it is only safe to remove the
+	 * inode from the buffer once it has been removed from the AIL.
+	 *
+	 * We also clear the failed bit before removing the item from the AIL
+	 * as xfs_trans_ail_delete()->xfs_clear_li_failed() will release buffer
+	 * references the inode item owns and needs to hold until we've fully
+	 * aborted the inode log item and detached it from the buffer.
+	 */
+	clear_bit(XFS_LI_FAILED, &iip->ili_item.li_flags);
+	xfs_trans_ail_delete(&iip->ili_item, 0);
+
+	/*
+	 * Grab the inode buffer so can we release the reference the inode log
+	 * item holds on it.
+	 */
+	spin_lock(&iip->ili_lock);
+	bp = iip->ili_item.li_buf;
+	xfs_iflush_abort_clean(iip);
+	spin_unlock(&iip->ili_lock);
 
+	xfs_iflags_clear(ip, XFS_IFLUSHING);
+	if (bp)
+		xfs_buf_rele(bp);
+}
+
+/*
+ * Abort an inode flush in the case of a shutdown filesystem. This can be called
+ * from anywhere with just an inode reference and does not require holding the
+ * inode cluster buffer locked. If the inode is attached to a cluster buffer,
+ * it will grab and lock it safely, then abort the inode flush.
+ */
+void
+xfs_iflush_shutdown_abort(
+	struct xfs_inode	*ip)
+{
+	struct xfs_inode_log_item *iip = ip->i_itemp;
+	struct xfs_buf		*bp;
+
+	if (!iip) {
+		/* clean inode, nothing to do */
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		return;
+	}
+
+	spin_lock(&iip->ili_lock);
+	bp = iip->ili_item.li_buf;
+	if (!bp) {
+		spin_unlock(&iip->ili_lock);
+		xfs_iflush_abort(ip);
+		return;
+	}
+
+	/*
+	 * We have to take a reference to the buffer so that it doesn't get
+	 * freed when we drop the ili_lock and then wait to lock the buffer.
+	 * We'll clean up the extra reference after we pick up the ili_lock
+	 * again.
+	 */
+	xfs_buf_hold(bp);
+	spin_unlock(&iip->ili_lock);
+	xfs_buf_lock(bp);
+
+	spin_lock(&iip->ili_lock);
+	if (!iip->ili_item.li_buf) {
 		/*
-		 * Clear the inode logging fields so no more flushes are
-		 * attempted.
+		 * Raced with another removal, hold the only reference
+		 * to bp now. Inode should not be in the AIL now, so just clean
+		 * up and return;
 		 */
-		spin_lock(&iip->ili_lock);
-		iip->ili_last_fields = 0;
-		iip->ili_fields = 0;
-		iip->ili_fsync_fields = 0;
-		iip->ili_flush_lsn = 0;
-		bp = iip->ili_item.li_buf;
-		iip->ili_item.li_buf = NULL;
-		list_del_init(&iip->ili_item.li_bio_list);
+		ASSERT(list_empty(&iip->ili_item.li_bio_list));
+		ASSERT(!test_bit(XFS_LI_IN_AIL, &iip->ili_item.li_flags));
+		xfs_iflush_abort_clean(iip);
 		spin_unlock(&iip->ili_lock);
+		xfs_iflags_clear(ip, XFS_IFLUSHING);
+		xfs_buf_relse(bp);
+		return;
 	}
-	xfs_iflags_clear(ip, XFS_IFLUSHING);
-	if (bp)
-		xfs_buf_rele(bp);
+
+	/*
+	 * Got two references to bp. The first will get dropped by
+	 * xfs_iflush_abort() when the item is removed from the buffer list, but
+	 * we can't drop our reference until _abort() returns because we have to
+	 * unlock the buffer as well. Hence we abort and then unlock and release
+	 * our reference to the buffer.
+	 */
+	ASSERT(iip->ili_item.li_buf == bp);
+	spin_unlock(&iip->ili_lock);
+	xfs_iflush_abort(ip);
+	xfs_buf_relse(bp);
 }
 
+
 /*
  * convert an xfs_inode_log_format struct from the old 32 bit version
  * (which can have different field alignments) to the native 64 bit version
diff --git a/fs/xfs/xfs_inode_item.h b/fs/xfs/xfs_inode_item.h
index 403b45ab9aa2..9c829cf5c839 100644
--- a/fs/xfs/xfs_inode_item.h
+++ b/fs/xfs/xfs_inode_item.h
@@ -44,6 +44,7 @@ static inline int xfs_inode_clean(struct xfs_inode *ip)
 extern void xfs_inode_item_init(struct xfs_inode *, struct xfs_mount *);
 extern void xfs_inode_item_destroy(struct xfs_inode *);
 extern void xfs_iflush_abort(struct xfs_inode *);
+extern void xfs_iflush_shutdown_abort(struct xfs_inode *);
 extern int xfs_inode_item_format_convert(xfs_log_iovec_t *,
 					 struct xfs_inode_log_format *);
 
-- 
2.53.0

