Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D0530E04;
	Thu,  1 Oct 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866485; cv=fail; b=IjdfLcCvr+mlOrSW0AIZomgpG2rNwvjfsGDhCCAg/frrnkiOSzr0JqcU+WLkxlfn7yyXBXtwylnrKiadnpG3et/f33+ap4AnbKfRlm5bEtmtB8VdYzHT3KJbul8LKHsDHyeufdX/YNEt2l3a6hYB+9TUUJVDWexzGK/mYouaE4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866485; c=relaxed/simple;
	bh=4bcCJbvpvZPaxZ0gMwgStXkPW6LMHEg2yZRRBFhUNTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgXaAool1yf3VrhPt/CxU7No4fb1PNoORQl7Vq7S8xpcG/lCOM+OEMUsVrMoca9SFoGKvnPHFTUVyjg/3rpLoZhq3M82ciUaQ3nPmZfV0a5WeMGvQl8AM8sHh1cFydEVxmODt8OCTa31y3nABFIlhn5MiWPpNYErd512o9JFxvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YN1EQAKs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WhHoQAOu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YN1EQAKs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WhHoQAOu"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMauo539227;
	Thu, 1 Oct 2026 14:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WdcZt7f/5iX4KCBD6FumdUMBK5hiax7/g1aJeuo/zYw=; b=
	YN1EQAKseJqL6sKy5hQT+H8j8qJaQXYsHl0Nt89trxtAIZGITyGWQLY32aPsPgeb
	+odeMu0Nim9+9Qw/9HlfOLF/RMRnFQc0zhFFQ89jGKH75q1mniCIQkbjTzy3dILc
	dc6fLw0E4wba9RT/ssT4XQXJpBdP7qk/kNhsIlu3rnoKa+Mc3e9xmFmTYv45pZsp
	Pb9bMxvXJAI2gP0j0UQlxokloISclyLkPQYtjiSaHnFug02C9iRf4/8J+YdX6OHh
	Z2AyzhfNkdj51hmX9j91WDlU2s1hgqd0079tI6PwU9Axb07QAO+J0bk/MNa+uml/
	h2kjh89sfPs2P5f5ObvtNg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgys4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:54:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoTbg027901;
	Thu, 1 Oct 2026 14:54:39 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsnw55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:54:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLbDVHTqSZlOF78wFgQPFSyxXuVWKmarisUZ6myi7VVP02keeYMcKC+jSUVgTg78mNAAX2b7MhENq4Ri83UGWGJ4PJ4wfzyv6etck63JOLqGvWikVwfY80skBi2ccSkLM03px7cwCtIOARRdaiSKO5R1Hjm28VyGF65LPcRTVAtYslEARiOBhsSIsf/UkALjHyc8MILc9gb0gaNCYNeXudEOTlN21IdFEWgnvtW4Arf7wlbcqJnx0sx91R+X7RTf20C/3e0AwrvIjRdimm0zxRLQPCbDV3VRgYy73Tby1l44n8X/E90GSAhpCCxmGTrt7m2ScDS+uvoP9Ld7JzgUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdcZt7f/5iX4KCBD6FumdUMBK5hiax7/g1aJeuo/zYw=;
 b=SdcZu6pnrJD7c3Du38/jPa5ZWHJwrD8igIPDe8plZHQo/mAiXnkRpNLGgQZdkQ7pjVsaoEQcammnr90mLxoZkIua7iYfUOE7inBPhu3r9meDFk0Qs/19wEW5enEjf3ha+l4oyPlLuUGMZNHuuwzG+2lzXPR5Bh7lcukISo27Qn6FJn50uwRPbl4F5VoP1D2pVW2SlWH+hN6N/VkTYjDPxI6LnCqcEEiejtYLSJB8enrDec3kuKBo7UP9Vu8xnM0IjZYRHsoozk3vKPRTAS4A9FwjfseIQDmCwOX93rv0sbsr2CquxvBBITRgWlx6aZXDY3vpBMbGgg/+qtOq9XNJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdcZt7f/5iX4KCBD6FumdUMBK5hiax7/g1aJeuo/zYw=;
 b=WhHoQAOuny3JGPEBaW1OYHUgZ002zNyCezIkRKg+zF6GY6lFLodl9CyAdIlx92djMbiawBAP1wRUV8ckQJmPbHszlpbTtdkvEc3RrzVAPJ2kk8FQpYwWxG8qnSh93XCjAze66TeupT5uXCpt8w9FhdU+m+RC4fyWoZi4xWuuI0g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:54:36 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:54:36 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 10/11] xfs: factor out stale buffer item completion
Date: Thu,  1 Oct 2026 20:21:25 +0530
Message-ID: <7eca0c2135f4c016796461b676a2a296e3202b1a.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 804d97ef-7bce-4ba9-9fd0-08df1fcbe93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wZvEI4WY40aCTm5z4MqD0c6T4ZU6gda37ATcv/YVxi/kQmC9k4FnmwBE9RVkpDxClHAOhSojiBYVbKu47vXy8jq2Rb630ZztwfZ+esjwrGVrlgARL4RK5M3AaFNkCb6QDE4y0eEfmkJDqSQ7zNxQd7th8HPOSbkAGlNoFddOSh7o9U07RPoRrhrWLVoST5e967r7j9UXlYwqnAXqme42wij47JdYc9bGh2pz/FJwNy/Cy2KdVRh9d0ltG793b1/WZ2SSIH5+GLNBZbo6NNCx85DZixGbBANuqdQi7htKOwkkDWwQ1BqceYaSQdOf+L0BNVb50AIeSQABI1xlGi+cugWZrAXciQeNUOii4YDeO6fceG+IiKMAGGySm8u6ZNdN6g1P9klWtAi4CaJsppdfeFf2l3ovhq7MM5RTZCEaI5iNAoff/KRwAJX7YS335Sov4ytJCmMotf+gc/chB2+Bqrg7+xnC0Udj5dgpNig/Gn5tbkJgYf8S6XB3WMJ2lBrEXr1NHyT5suWXeJEa2kp9Tto2GFRBEnCtB+EHZVIaPjtTOXRb1GFRPMdkoA6pTxq5TWNzaoSG6APfvx8WxbV+VgY94ho/Lit7hRO0hMLQiqV0+Qsc7RgMW2rTLgb9V0hNUyoZsuP7XZK1VcPUoncWezV0xXGQFH/7UA2AZ/lIVr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TabmwgD3I2u+yyyjzaavnLLkJlWr0R7YcDIqxcRMqOkXokcGKMo2JvKg7NlD?=
 =?us-ascii?Q?DTgs2SW9FKfKDCpDmnjh2IfH3O4D27Ph4HVnhwCfXdpYUMZz6lE7E7k1NM/J?=
 =?us-ascii?Q?u46lMWdTRjsNCozO3CyCDaRCGZrb7FokaeDJ6F3rXTsYhe0uqcCTaRJMHST8?=
 =?us-ascii?Q?l9soKNEzacImpzRGiWov5IuZpgWLOYqsbUd4bCVlQDjD5vVZunj7ovrTKbYG?=
 =?us-ascii?Q?oKsgrS6jXD9U0hMXebO8feiOXgY3MLxDe9/T6JH2wMDrkZ708dcrq4P81p+E?=
 =?us-ascii?Q?Igm6C2gniO9QKyJNxOOTouB2w2AhHSC4vO7r2kmPeI+GRgk9nYsRS9Q4/voE?=
 =?us-ascii?Q?sj6P3B1pryBcHDtcBdoW6Raw/VuV8fA9JLg55cAbOOBx4xvZCQ55dfLC8PvS?=
 =?us-ascii?Q?fcp/MUVXsJhTrbbuzwB6CF62XRytK6fzQ83LzG499spFfKEsaG1D04ShQLiE?=
 =?us-ascii?Q?iu/e9AxmLQt36xHldJ3iaVBFDwK76PpfVTVIGKtIXAbcrHDKcQfA16zDdJUO?=
 =?us-ascii?Q?S7EvYujgHixxTdxBjgjc0xG+tGuoun3Ecql3u0szU7eua+HEiklG6MlCnzfC?=
 =?us-ascii?Q?su2QCmZXIu/tl9LTECcIgkiFZpSMK6s5IlsiGLKZtRdKEVzmPXi4DRSiJdIf?=
 =?us-ascii?Q?MqwHUXQwAImPcaHfXHLSiHsCMiUHDAkcFgSD23E2pLikJCqNn451QGzm3MKb?=
 =?us-ascii?Q?VateOo4ayonjfB7/fvV8+rkgrms6OlFyOZRUwPR0xuJK5Db6KS2ouWWCR1vy?=
 =?us-ascii?Q?4wbMbkLKgmafHbaHuFF21z/obrwhGgBNqn7MpqlGkWFkPzEVNzoDTkwIl7Wq?=
 =?us-ascii?Q?HqhZtAN4PtReA433ILidcAR3H+NVRB/w6PqbzMoQ41sQULQ3c/2eZNHzjA86?=
 =?us-ascii?Q?xgmq3Zg1zevByUaAnA9dXk+prEQU63WIXV9rqktw7dmTpIyUd9GogLkcq5a6?=
 =?us-ascii?Q?TFaaLo9tF6n+J8ADP7CPe8pqO6tpM9EuE/VVTzgi45RVyrPfr98AWkNuZbFP?=
 =?us-ascii?Q?EAjYAcIP2sAdp9A7pIbJhxZILgjQlCX0A3+FicD94eIRDF3siO+pSODoXGNv?=
 =?us-ascii?Q?4Y85Ebn1gj8H8g1MqzdMbVZUM6LI/8NmFuAhxVLdm4PBk1AUfTwycYE6a13Z?=
 =?us-ascii?Q?b+htnJZDDUqLYBxV/urZVAzIPjhfSUwJuwMqQ8KH3+Qc8z3tfRa336d6DFOt?=
 =?us-ascii?Q?uq2hWM7oTJXzO3gumMNNEgSmxW6OS31CT6Z4npWv1drQNudKD+/rsF15HB4y?=
 =?us-ascii?Q?ChwtPxKqWEtCOL7ctOovRTDqv8OdRYNqBstk6OSSndxTsYE7idBu38E6wdCb?=
 =?us-ascii?Q?I+NMKiSb1Lbb8uAY8GBN73WweRi9Yx4AkI0S3b61CsP1fZift4QLoep4YM/W?=
 =?us-ascii?Q?kRkoqHdHkIhZpPHlCHMj9G7OeRdcd6qHT5JwWY83qzkhFH7RjevP6TGkQUJy?=
 =?us-ascii?Q?aQ2zgUEnObijKI2tokn+xcQjjNk3NyT9yDSRhHX6VVzKhpY870HF4yc9KDaF?=
 =?us-ascii?Q?0qS7JJmp0tbq+MRnWSdV6Sor2giv9mI2QLP7pAwPbnKnmnERm5KIQma8k2c5?=
 =?us-ascii?Q?GU05rTqanODPZK695ZhuBU4xlp/sjTFO1dWAA9BByjlfkd6KXuUTxjpZsPFI?=
 =?us-ascii?Q?7teuIjxxKgIazZzhlV0SCR7uWVw0N4eOcHvhtoBNqoFdcVPKstIh/+DDjI0I?=
 =?us-ascii?Q?SxnXWE09peG7PxPMcw/VLZqIMh5jgQXAZ8/acjWFDOdC45NoOzO2mN0p/9AB?=
 =?us-ascii?Q?t7eO7O7YXQ8SN5eQ5n5nQoHAKLzyl7ae56cpUQP6cANbEAgRS/B+q6xsQg/S?=
X-MS-Exchange-AntiSpam-MessageData-1: I7S7eF05kkbODUEHx590JQIgNbY46BZw5ok=
X-Exchange-RoutingPolicyChecked:
	ssCEIGw+f3eRU/jGEcEYnVvMeF00ot2fPwkTZCga12kN+beMCXCVPZ5K0xD5Zfx109svm2bmsSPrZY+VKHkjnWJOfKEOZNzzYB3kjDG1ymonrLEFr+RzH48IvVoIh4yRaNCAgVyQTA5zgveS7rfr4b65mZ0qdrvRKxcQ8tYr6eZv7E9QknpuMLzWN9X894/9LkXm2HEHKQZOHTFRqUEO3pLJTkCwKI+hZx6IxFWe+De9ldEBcXNY5jMPV5NLtyjetaoaMplDyqd/zP6gYGGGPUww2fv++7CYtYD4VZqO+xnojiNTCLs1D2z1I4lNgl8To8oLqRJuWv6SIXpZu4ni7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p5QT7tV4IrNLkPDvq2bfDgSN6R+TrXJh9bjDpv6z/SdKui4NrqBCgAZNC6olpeG0x2njXIXuOc1Cbw9vnZA48d6K5XCx2rxqA8gTFLLRbbTC4F7NpGk3VdfHshYUf2axMjofF/5QvI9hSodu0xPYGTq5N/Gd4KPUo5cuznslRPRV/8pqV/b/sc9SOW1eMk75EZzrSlx6nFuDdcCcWC/AWATEUtY96w0uIucjOQvzB+AMb/9qvdYVcatE0Ycxe5CmDy3lU4/+mwnZw1m59ORweSukghNNyZHq5Rg8mXu42S+hGJBq29uMaSTwonnjQD3WRfoRoufZ9gn3J1mLDs6qzmsNWgp2yEa3Gj1UhUQ8bWFzuSTh5Pf1KhJXVF+oe5NMSIwmE8dF9eQaXbKCx7cyGirPaqx2bd/SaFzT5s/7dSAg21klqIlwebpNLdp19o0tP9wapyOMbBfqeBNLOybSgbSawlW1hvMq6Z+n3pB+H9FlUPtfRgcHZd2fiwWHUexaV3Sqj5IGG+CsvkNt8Yom7xE+10RA1LUbdKuAqEhi4NoXuULPmxK+cYLtrt+6IouAawf3CD+9Oc1AwstIJRf94EKF+cpXTGuoPPtXnV6wG3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804d97ef-7bce-4ba9-9fd0-08df1fcbe93a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:54:36.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsL3CydlgFADAQH8PsmaYymlUlqv/NjdjJs0FZCSI1vmz5dhIyxgoBzr9dVhfVc4XZoJ3OpuyOUxPOv3F15GHLY3qkX+n3UwJ/lCipW7BM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: U4tKRZWYhnunkQD__stLyorBAQmsEeZM
X-Proofpoint-GUID: U4tKRZWYhnunkQD__stLyorBAQmsEeZM
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe7430 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=HRhzHcoIBzGTXiVGymcA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX62UuLvIRJy6h
 GP4OcqGmKcOGaIAgnIbvQygflN3+GrAx2oaZJgt34SK4iciZTJI4MrlSawxfo3aoMS0I8+7BGcz
 6KhdrPEUxH3U3KIJAydUk/abDuJe20PP+vvZOOWxNd7h8iggyrPb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX2iyT8Ffs6mDy
 MFGTR5rfNinP5VrC5v48ud2KPt8lPCEsHH4lfT3f/PEeEQZtQsiqJbFkPxYTjpJAhXkFe9MXWS3
 UTNFwWt/KrwoeKZ/vk6s9LtX7ZR5KdlBC/Weoo3X8EccecAz8RxexS8VPPI3HJNBBxPA/Zkt/pK
 Ymg8wNDBARBxFfZ251VwyNTZklA2WMLrpgt2AYT6WzkFOQiZVHiL3hjXCbNigyldqvZ8c6mktpj
 YVXjGBBYKKNE5of6ZAmzcetnbh6mI7LX6aHjYGKzK7nORqNwZHp7jeACY9H53H/jKuYSqsPl+kz
 UFVnzms8um/YR6w8m3CIWybihVdPhFNgDybXb2QsiuOPJnz4LYrFx+iP0biNVn0QLKBkt7o+PZk
 YBIRe94VlYUPLTt2p5tLfa0jiXCaRLS0HyzKT34zizUesSXtlQXV2Z5PT3D+b4svdsinHnB0Qzk
 H4OlRE6VLzjy4cfOVvvxLvl21qk4iH5RnaujzND0=

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
index 1c8e7f99d8b6..cc667d4e173d 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -538,6 +538,42 @@ xfs_buf_item_pin(
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
@@ -587,13 +623,6 @@ xfs_buf_item_unpin(
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
@@ -604,22 +633,7 @@ xfs_buf_item_unpin(
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

