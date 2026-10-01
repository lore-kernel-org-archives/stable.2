Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AD51DAEE;
	Thu,  1 Oct 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866307; cv=fail; b=uYirs8/VkOeBBd9N7cdpzTlmXHF4Mb70u2yXlLy8nv72PTYyS+etjy1KQPiLtlbGoN+w1bX1Z6FGFQsUcvjV/KZ7o/urlPH43UAzonPgh8UaizRpoJK1whrWpyQIqkQnEa+Z1W7lzBY+3GSTRwG/CG7kIOFO/Vg2Xf3+MljcaN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866307; c=relaxed/simple;
	bh=dU3I1frWa6GdSKQZ2FLb/qnGYWs0epBH8+83LEIgbW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DABQBx1wztoQho7pGWOHRvLeBPaZO5nXgMPMDJR6MLFtX0h7xsv0GOnhf0rxmA35WnrDqGct3rZHJ9Q7WhAFlzcn3UAuykc9eERm/Rjy/TSz98y3RORniFvXCMbqKl491Sm8DBaerCu9pEWmdD7S9JeeZaTBrMw/5biG+/mXC5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pkd3DKoe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W6Kwu7QR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pkd3DKoe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W6Kwu7QR"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMULZ622799;
	Thu, 1 Oct 2026 14:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JpZVTqKMj3ulw2FM9NomKk4QUnLYr81GF2q/OvqnsS8=; b=
	Pkd3DKoec04zz4bVAtpK8w3tjevSJpcgq26Iw05r100yf/AsY/u36OC1iHn6rWBN
	nfdm5IYHgCWgRaijuwnLh+vUITuWj/mMwSRB0wNzVKWjkblUe4jn8Pe4yPR9y+iW
	KjNNnPATl3DzW3LoSW2lPqBEQc/qy42KxK6lnzEroG7ebJBXxhVma9NJ/+SBLYhB
	srVmw899faqU3PLvbIbZ1ozLhpd0BiXPUEaG2seLgj6ozsepl06wJAWW1ZL4x0Ih
	JyTerY/q2/K7ZDGYnZ09QTEdhPn/t0sh01CjVKWfwNORzEku8UqbgSZNk93Yw4Lk
	kJQIPYSoqAmOFXaEUsx+cQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4u2h09r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoS8q027813;
	Thu, 1 Oct 2026 14:51:38 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsntbn-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb2MQcniXv39BggchBxO/Y4cJSl7dFypbzcnZIBfWjYC+8TmmWq3PLDybIxVBVcESrivBRQLV/xkAsm/q3qRMbBJlB0LrHfpiCZtBuUdDThIRQLqjX83kdevjnukDTZlbT1QTg07atDLzHLPuy/lA2istOWfSF2wytMvXYhECnuzbamdE3K3c1wVAmndk6hQVYez3UI5EiOgeD/fKNpnWWCMtA5qRDjBvnIzhmYwzaYFc0M2tSaVy+eUcTkrp1BbeBYv6YwBaU1h2oxsNm7seKv4IQvkU6iwnlBY6HZvmK2TbAbJ6GoYogHuHWzrxKJyPez1CidXOOgJ3OyGrN33+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpZVTqKMj3ulw2FM9NomKk4QUnLYr81GF2q/OvqnsS8=;
 b=C7QrO2NiIHFR5Q/Q8CQ7mBz3zilgVpKfktjMqRlLBb89QZ8c/HPnFHCWQYvPfeqI291JVi6sDw4pid+4+nmnsmZr3uC1XJEmy7wbKjuKBkCIi4pwWbewCL8pojBEBjE4OoS+PR46BpnnXFc0aezU84RnYlkYj9p60kNXVfEsS8JQ6NvhrjU/SfqH+RkyGjs4+KOYx8fjbBh5W/2OBQJDJRfdIhL+/fort57gRWpN2knYw3BlWw3D85rRexyc0OCIwGfA34/5bhUO4EqpyvbhxgkXFPCIm/N3ZM16dcpb4WL+M4RuijJJlcwPol/JE2n3QK1r8pgSaKNHKrtF0SVhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpZVTqKMj3ulw2FM9NomKk4QUnLYr81GF2q/OvqnsS8=;
 b=W6Kwu7QRTW1eExMKPxidkYfOAJhxOPLP8jh8mbPalx+/Re143RinNrywUoPPpDIat6GGSxLHrTC/OnlFEaTkGaualUOls33w9i8AktJLw8z7He3ZRQNxa9tWwk0c6IIUaTWgzPpiel8vrzGABzWtqkmj8HYurkihYa5s6nD9LMU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:35 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:35 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.1 2/6] xfs: catch stale AGF/AGF metadata
Date: Thu,  1 Oct 2026 20:21:17 +0530
Message-ID: <cd932466a311b33b1bf911e338f35cd2c91cad15.1790864538.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864538.git.siddh.raman.pant@oracle.com>
References: <cover.1790864538.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 263d4e34-ec71-4b52-c519-08df1fcb7d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	1DCbx4tkwJHnog2JattzdKSjL8Y9GsftWUX+5IthQ6RNO1eZEPrbNm6/qcF6fogaPe9XV9qT9L6ezSxRsN359xly5ddt7sO///3ShtptOBiAjrklzJO8NVpLBDpn4SD4bK/1e/3tgWciIJxFbap3EppN4s31fa6m+Wrp0I65D7AP8ymQB4S+H5VZ9XhDBhyMNxQimKNIYwOWuM4GvYnjQ3yTkPFM//pviefVTgqeDWsvBGoHvihvqRvbjQhTbkYSQPV2Fr1+lSBX25zIoMsmxNEQw7/3Cjf/tr9eq6X9o0K4nNnXBJv0fU9GAHcdkwl38Dr8P/yozlQJW4GCrxgmx57JPEPVc8kVzYfNp7ukHg3qqJ3T34R8EUpbkIFQrn6/bwwb24aZDKOccABkCOGJhooGQFmn9FQOsC0RZ9kmEcf/8N5voLMMimF8HAuvzMgLLnUo/hSMg7V38L8Fgj+YGQ5Vp1k82GvqsbuNigMj6E/m14v6JO+ATO3mnEWpx5tcyRKyezMicxQJgZIxRhve6H+FiDS11ukgdCo6BqB6JChwsj4zUyIQIRlEZMS9PCquH5zr30Ke0F9OfvHVgbxHqrsWsiGSfj8nW8TlJXnnTLGkNGbziIVXk8WvTEe1fR7wdfwDH1t638iH+N8OSAIzvSTXZZIUwrXcEOuBMRwTn1g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ph2jGNyVR8LKs/S8WbNeNoQuYtgBOCGJIOE7SYnoy8dpnGfO13CxmTFxMMO9?=
 =?us-ascii?Q?McQruh0GX4j1kduDSV5gmeJ9e559Lr1DTnc2M7h3QlA740CfVFft/FziMX9J?=
 =?us-ascii?Q?0OUptl8q5Ov2Yw2ghYcEmJx8WP81dAHYJ/YairkIQLETYt6jXwT403HxVM0g?=
 =?us-ascii?Q?vySqHK2YoH8gSUQDzz6COV04B5s0jq+qArLz+I450a1vC6ZLnt95V5DMiy47?=
 =?us-ascii?Q?jvh7rXld9vejsPZQucC6YrrAFIXr73gYhlbX9YRWl/9T3/LyefTeZp0EsKch?=
 =?us-ascii?Q?0H3El8FkPCnnQy5WFXXVVD0/DTDEFPsBzc/k167mQTx9g0GdolYMQHmtAcSR?=
 =?us-ascii?Q?XCXZq/YHsQxNSz9sZ/BeWfgUyCj2GP0IRSYWVB5FwEAqZSfLzfkHhEpdhWXp?=
 =?us-ascii?Q?KLEv+Q4b98HUgAFH/ACMSQEFLduIvkcY3p1nBWJlo4jU7opK0A2yXbeukogk?=
 =?us-ascii?Q?VRt75T3SM8nMpJx02MNoQPDPsWngi0q/vUhXrJVmhGy+Bq+ifCoP00le8kja?=
 =?us-ascii?Q?OViLkRTmGvxURUOt2wKFRE/oC1UXYQo5JYXdAoQsQ4qPqF/sW+BGDcMNE7vt?=
 =?us-ascii?Q?Du0b/3KGscFy5zTHD4LH/9KoDRpg7vQHfmYVw37mjv/tJYVQZ14Im1CxZ7mH?=
 =?us-ascii?Q?h90LK7BazFvnFN5alyZrRfdwVxXcEPb2i3nGY4/QFV1GGcnfp8SSKBAzlywI?=
 =?us-ascii?Q?5t2jYqqh5USiZ6R3Z9kzQ0A526fjL+D/NfSUvxqBO7FRe9jxXpjhItOkEGiT?=
 =?us-ascii?Q?iINSzcUCl+LnT62YNf3LNUO6/g9LzOlq/Gbz/5+AxK1AdrD9qbG8M09LxB2b?=
 =?us-ascii?Q?4pxEmn0ATHGnce2mrLSuCCPTGsMTVMWQTjHGWRdjKGJqBbNdQuCfasC/tniM?=
 =?us-ascii?Q?eSzWfr9otETrGXYEnx6g/kj1kG1s5GDVa+SMpMtw9m/hTODTeQjTbWWCfPxK?=
 =?us-ascii?Q?EedpcV0DauR5JMTiyWTz+L4WQ502gCeKlBSvX9ip0uIMw2LnXDHrStcSNqqi?=
 =?us-ascii?Q?Po5FuRStfg3dV9kpnmTlOjNkV2xoYebZwdHKyF5UqwiyfU7lFUCU+k127Ycz?=
 =?us-ascii?Q?ySQ9sNo4NtK35s6khJQPxjGFdfHP9wfqhiKxx9AHlmpRvgNY8EBrt5RUlqQL?=
 =?us-ascii?Q?kP0xQI9LOf8UTLi/5WXJxjYIoeTFhtdsxmnASR6H57b7tFUHmhCfcAlg4PR0?=
 =?us-ascii?Q?vzgpv7IcYauweYKe0FWVD4uWIDbprHZBWjFpsgJgZFPHrRbLKnvpghZcIMgH?=
 =?us-ascii?Q?7cYUHTGfBUYyzgGpSek1PFZZ/WaclcqlJiY3tFYMif7thaXQBmJOqScb5ArW?=
 =?us-ascii?Q?PDiS9zIQkVHQobE1q+fgGehbQapFAwplVgo6J8Cfzts9o3/KhEf3eV0saWn0?=
 =?us-ascii?Q?5VWOozl/CzaBJEWqbeL/C1ASABJSZMBO7Z6xQv/961NvxQLG6PeGTExH9hbL?=
 =?us-ascii?Q?LLrgXXdkHaRRdrjd3gvTmFkz7Mtx44fEAqU0S9JNGvZH1DhoaFeDjhoFutgC?=
 =?us-ascii?Q?xX9jAi8hOIBL7/ajUOP2A1z5axrjmr7yTkg6IZCR9p2THIektPtq7cF13BE4?=
 =?us-ascii?Q?XmtgkAQbU8V/iwAv2RlxKIWeL6ZWDFENBruFE7gNUKAQAJnxNsF64jklxhpO?=
 =?us-ascii?Q?qyNQqovlCXl0vHirSiWS2soyO9itv84pii57Lf7CkKYSZWT5vqsZ9IAWrAxd?=
 =?us-ascii?Q?02A5HK3bzcvawUsGWouRMQMjvrHAHPGyXsG8FL8P4NkHURiQnnN3bfmVv5WV?=
 =?us-ascii?Q?yTcklnY9B08zSjFClGc873De9NHMd2V0ReIrNz1dhfHzBqM5N0JyquMGK9V6?=
X-MS-Exchange-AntiSpam-MessageData-1: /hVJfN/m6ELEnN8qZRLcU9lceQopgXDFwSM=
X-Exchange-RoutingPolicyChecked:
	o7cFLJjysCx4EBqOUFAF6CpoIuO5oBWw3fIjz/obgNss28MXFmQFxZMaCYx+4KagbPVDAPv/NDJqCN8aq+GkG8AKsVlbuqLRZhulbdlajCtaJ6NzgtVq2UIhAm/5ELZ4lmDv4AnUlsINyMJCiKvSEf4uwqw3DO3ICWhO44y/rvB1bC9hdlf3SHPGtq81WUdu50G5k+/l1ymNlHow2U7tkrjpYoHIMpl6xPIVJDst0qxPuj0eBFfNp0Bq8VPonKvcnj5lT+3Fxqt2/Zj0bpJX3f+f/K8JN//0NrpJ/k9Tv922O7+hU42kynfPYvPdn51Mu2T2sSbIduVa/JWTUcMALw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bFFhh+vf/ZhHLGgK8oHVy6vzRx+yPfnLv8Pt1vsdJ1InzpGIngMMgm1GEIfYiazLHpo8rSkYc5ZJV7GZGPB0o99ofZKaBiE86ZVxDTaoI4ySDPUWGgiJCj9FsaxX5tuQYaz8B06flpj2TXO8E3j2IjD1ZgclhMO+WKsJaU/Piqh0tocmPvzrqHDDmZgPsIY1lzyMdRvriApVgwLHJalSt/eVdMB99DkEf7cwe369Wqeh0vv1F1RCb2mD59tmdcxxvt3E0YpYYz1YVc1RdYNcQBLVB8iww83vfNSpWjXGsFeMzwkRVqlu6lC1cYx3FWdg96YLqvEoOteHhlQXVHVZesqPcwKRBdiqQskzyFs5WqBuKzO+dM7yjHrBTspJ/Lpqc3hGHkqsn1CdC8J5WYL1QkS8HFNuKdOcGQIwHrPfQbOtt3S14gNQGpFPlMM8GsQqhsBvt/XU/SAXjkhyiDLGFXhG2fSQbaeIpQZYsfZ/V04nmsrC+2P1hUEt4EWk6MPh+g8yYRWZX+zAiezrH6qVxwm0LxBCFiAu4dYIzJRK9hQNxVxJdBZjR3AoG+f8Vd8YYy+lGX2cJzSbh6TqRbSTP6vLNxFcz3dtwMi7ut9jwl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263d4e34-ec71-4b52-c519-08df1fcb7d49
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:35.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQbrNYb/E5oGlOPlFKwgcFEI2aaxZFRWwSAq0EZTK9N4qn3WCR16lXcduZBNk8kDo6yYFRJVbyI5Xg9x4xqXctm16kkqwHhFB2qP8+FE1w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX06kHxKzlgLuN
 Rvo+0HxN6S2TQdeuNDtdSMkYieBWY8IZA4y1Zv40ivB641syhgxYRUjl+r4gmw3YpCBtru2lzIx
 NAGh8vWjnIP1F22pA4YL7gT9oDgkYRvVoaa2vSy8rMo3M5zaH4Sm
X-Authority-Analysis: v=2.4 cv=W9itxhWk c=1 sm=1 tr=0 ts=6abe737b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=2l8DqRWQ2dbnbHYYE4MA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108
X-Proofpoint-GUID: NWZEYhltlOfJ5Z1ERYzfqhyWBCe0EVM3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXy304aJvfbJRU
 HXfN8xV3IKHx2CdUAFWpcoFBFGIn0SzxhA7u7FMLsjNxrbxFOQNLlbwafYwpi649H27q99g2hih
 n+v8yi2OYmvhKOhdh8e+OWfQpuPydU7bTg9gHZsLb9YmFG9LnY008LLKhdQ/4alZCGLh3n4ga4o
 KPgueFp+7P4hmszmglFlv90VLqHwqel3VvPlyCFMrCtMRAJ615C0CVJNipZPnXkz2ZrvdBZsdH+
 nuHs/VncU979zkqoYnLcHkyaAiEtT3R7lwVxLOQifdjUNss0iQxUy/ofP5sVd+11bDFO9Cuih9i
 hj0dBbZ49bdcCdcUuWSOxyXvMOvQ49vWt2Tgpn1cvlkBqQE2piJs5E6e1Y+a2obuBREBPaicfwn
 Zp2aj2sK3a0fFjzDiZi9P/vBvsOuXUkukIy4JOYDnnBlJopLUU5gzgetDpDnSUQtNju5m5AvbU0
 W48lodbEiq3yRw0rXjAVbA9bjsWbWdYyjXSkmTdA=
X-Proofpoint-ORIG-GUID: NWZEYhltlOfJ5Z1ERYzfqhyWBCe0EVM3

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

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  | 46 +++++++++++++++++++++++++++++---------
 fs/xfs/libxfs/xfs_ialloc.c | 32 ++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index cd5b197d7046..5bc37f984b00 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -26,6 +26,7 @@
 #include "xfs_ag.h"
 #include "xfs_ag_resv.h"
 #include "xfs_bmap.h"
+#include "xfs_health.h"
 
 struct kmem_cache	*xfs_extfree_item_cache;
 
@@ -3167,18 +3168,43 @@ xfs_alloc_read_agf(
 			atomic64_add(allocbt_blks,
 					&pag->pag_mount->m_allocbt_blks);
 	}
+
 #ifdef DEBUG
-	else if (!xfs_is_shutdown(pag->pag_mount)) {
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
+	if (!xfs_is_shutdown(pag->pag_mount)) {
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
index 4b2894c85cea..1d3c07506c59 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -27,6 +27,7 @@
 #include "xfs_log.h"
 #include "xfs_rmap.h"
 #include "xfs_ag.h"
+#include "xfs_health.h"
 
 /*
  * Lookup a record by ino in the btree given by cur.
@@ -2645,12 +2646,35 @@ xfs_ialloc_read_agi(
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

