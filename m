Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793921072;
	b=hx9BOk7AzsKWxArQB9FpS3lMgN2iF73/aqjiKT19nQNia4x8w6rZD35c/98FrV70icH/
	 SySDLovkfHN+CgKycZeN/URnsBFUy9wcz+NUmmwPO8/ctqGtMcVx1MU0dZFZkpIayNREJ
	 drsW2PcvzCKyUvpv4AaRQWFRSBVEH/i6kkB7mJBF0GFQixDGxg66LJpjWWr2pKflxgUpE
	 O7zr904gRmJfmij6gEJJlU8he6ra8l/kfkZa8+gY0lsMP7ywOAb00P8YPGegCbpsJhv6g
	 +JWmCcMfDImxoNzO8GIK4LDQppSU1pUPnH+QugoWvQ6tUqnPcYtwBpugP8/g433wb0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=eCRZ+5HlCRRZXnwLKhNQafXgjPoh8K1OacmCzvFDby8=;
	b=NtzSTAHYialhZCmUBwOp1gov2t3Z0dtj7yM57a7ObX83AfO1MobbZYkI7LCP46lz6Dou
	 u4NwswNAZySRU4A4YoM8jNc/3hJIJ3UnOAOy3+I7QvPKq2PJCjYB/Cn1VKLJIC1OQMCOW
	 I6t+GkO/VM4NQx81gPD2pTZmr7j3drETdcs0ECz04jQG0VOkIT5DtuECHG4TVXJzrVuyd
	 X53yi4elKI5wES41UVdgu17jfUe2P5iYu0BrhqS8zsFGuVQsW0UUgBajhmPBy7Ue1m5AS
	 CHjzSxl3eDOhN4/OSplLv0nVmmPE76NhJ1cNUVtTss9owJlfbo8o0qdtT5X0XoQAecA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=BpcIXnXw;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=jg4oLDL9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD0606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8AD0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=BpcIXnXw;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=jg4oLDL9
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5KropU1084272;
	Thu, 5 Nov 2026 23:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eCRZ+5HlCRRZXnwLKhNQafXgjPoh8K1OacmCzvFDby8=; b=
	BpcIXnXwSWVEk5GN69cLw2vkCeHrE8JEpN4nHqdnnieobdtllixuxplHfaFdAF96
	rbZy7otj1k2ZKYTLyLIOQjYV0vA7iW47wFoVL8m9PuP00gO09ZNGu24OwoUIE6XC
	X3WrdptSOq9E9OV8n38oEgnUjjyge07ELNSFpd/H5W6kMVbqv6QJtA5kz5pnhuWg
	dKIwfcy6oRPrZGvmsNMI9Kzcsqzp0Ul4zaY2wTDFj9JjWnevS4XDqhuvqaCTCa3s
	aiS4xZ+dZaxMYF/eY1YMvdn01f+Oy8S9RUcKt9l4aN09g++SB1wZc6gUpJ0Fxn9n
	g3Ts0/WNVh+nceVB9H1lCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn7xssfsk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 05 Nov 2026 23:24:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5NL6xs3699035;
	Thu, 5 Nov 2026 23:24:11 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hs25r2f20-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 05 Nov 2026 23:24:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unV7ZJVNpoZHM/opCmm1G+KkAjT4/IgQIqZ7oHibgwmAiOMT2QPww6W5eQfcdSWhA4Ybgu8Mo2vgJV7YL9vcPjmDOhV3AvPl9iMz0ouaz1N8VvbgW3pgxji/89epBbazYBAsaNMapmuJ6Z2tzcytLEeTRiKubKrr44cILBTrDHtwMjSiv7N9SOaTYGb1XE+UoX99koe8E8fr0NJcGrwUtLFCSEyxfPAIHz11c6ljwvxHdZw/Ejt590CFPuMCSHr36jI/enLjcFBnFloJ0d4W+F/WBrTAGZiOpsUoUs4jRNbS4/djnEChAytPjknxbbGyjPMhc9jEvXOstQiIZh77QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCRZ+5HlCRRZXnwLKhNQafXgjPoh8K1OacmCzvFDby8=;
 b=HuTUKYFr8e5VKr9kQNiQDp/UuWTrbW4CKumKNaHh0l+IiufP3WomP5NLRKqIYmExtbM4JV/Q87XZV5bVqaYbwsQLX4+zou/JInG9op2NxXAiS7liKnkYOva3XSAIrs0fBs9eanhEDBOfIj8j9eymW970XGH36AT+5T8EFIrQjRKnGH+Jnx9je/QRLnHUayjWOkE9VJAY1Pz9svdNeJ91HMAkmcDVz3ajoAdl9KRCAq7XpRhdpSkBQ6xbCk5aa7qlvEp4w79SSbybTUmBwAzeOcUvs3NdC4+v2ClKZhhSFoH0Q+7DLdnPX5Bg79j4MsHWwYxOV40rWMhAoszHra2qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCRZ+5HlCRRZXnwLKhNQafXgjPoh8K1OacmCzvFDby8=;
 b=jg4oLDL9lrz54A9TS+EL9Qb81HqRfkCdi3d+8exZHBxRxX8qWGj0a1x+dMu9N/fc2Apv9RZ0x3aofp/9Ex+8hUFgjMnXVEYgnQDXAtxERA5TSfnudhG9Ee4ycJN/K3Yc8NlUrmLXXcnPyypWHcDF4veyet3Pfwo4xJ/aAEEQaT4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2557.namprd10.prod.outlook.com (2603:10b6:805:3f::22)
 by DS4PPF715E13019.namprd10.prod.outlook.com (2603:10b6:f:fc00::d28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 23:24:04 +0000
Received: from SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73]) by SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 23:24:04 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: Sasha Levin <sashal@kernel.org>, Gaurav Batra <gbatra@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 6.6.y 1/1] powerpc/pseries/iommu: Restore CONFIG_IOMMU_API dependency
Date: Thu,  5 Nov 2026 15:24:01 -0800
Message-ID: <20261105232402.4033385-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261105232402.4033385-1-stephen.s.brennan@oracle.com>
References: <20261105232402.4033385-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::14) To SN6PR10MB2557.namprd10.prod.outlook.com
 (2603:10b6:805:3f::22)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2557:EE_|DS4PPF715E13019:EE_
X-MS-Office365-Filtering-Correlation-Id: 834fe5e7-3236-4044-c0c4-08df3b93e188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|10067099003|22082099003|18002099003|6133799003|56012099006|261022105027099003|261026121527099003|261028144727099003|261102123227099003|261026140227099003|261021121427099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	BPAtdGtB9xUEJGEAu19J16bWsZBw29h93fF/PErn7RSBZHeO34DyeuJZni9ablf8unvqH6zf4gw95IXnDds0CMIvc9oAjDPTLUEblnFCCa4H6G+ainQ/z0B3bIvbHzeg74z/rFbr/iIDgyf7ULJlishBMjY+IlgCTHR0nEnOKtAnPifbf5BaeiczTUfcsP44DKKv4QPAdBX2oVDb3Ns3bW5WUBBcgLHV3jNE1kQtrdga8ObcCswVfc6pNGRe4PIjczOi3h9kLx1EC1SpLaJzfLiuB5pK8CZhbO5E1wZLFMM3ZhMaU8iNegduV4KnfZ/T7iTjzOKHir/l4/11VKVhNDRq77n7A7odpbE0j6BKPXtrF/mLIB/xfkTTaHUZhpusrbEUqbSkItfyqbakdSL9lSoK1L+xHETXdagtt6Bm6VRE8M0tnrLIXfVEU/X7JqiccK2uH9MRyEqLjBUsDVs/LBjC+oWAuUMqoZP3tTrK4chCaYo9d/MI7zgQozXgfaKNKLi6o/W28zmqNI0mP6ZzmBtjp1+y8DRkh50Tw/E7jDOKjclYN54kX+fBA1dx6WzyQ7y/6vSWgDNvFCgGJlkIEWU7tkWHFrDcsEV3i4whyey2QFvgIthDFodvRKySrCYDl/HoMePlrVCVNlvbm3O4zynEWtOxb04vabwrxbavwD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2557.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(6133799003)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021121427099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zjyotGSUO9UfW8uPvmc7gRgWHDN5Kv3cMIklPJCGlZNDMA93MqAWslZKbind?=
 =?us-ascii?Q?vkFV40IksEjrwWn4wV1MTLuz1g6LdQ7sQM6BRHoyE95mpEqGDd1YVQa9K2Pl?=
 =?us-ascii?Q?NYNGnt+HIBolH4flCuApAaXaHnRox5YZfqut10T/PYgiLx08oasN7ontpqGE?=
 =?us-ascii?Q?XZduANAJPtzlS3cSdbEIg5T6SQYmoMcdDVJWZha9hvxZPsxV7zHO4YEDcbgY?=
 =?us-ascii?Q?1DrU7coWTnGvW49mnvnK3rCROJdTIri7okaleo4dlySPMNlbl8gy76ArjzZp?=
 =?us-ascii?Q?/I8hZluXBXtovPqxZWo+xFsgFTYQ3DVwg6L46YMcSaNqOvPYc1JDvog3wPc8?=
 =?us-ascii?Q?yc6sjlxsbkjsW8+lg4eVrZCi4QG39r4l/+4TytiaIHZMNo6vQEwA4c7gt9df?=
 =?us-ascii?Q?e19+eu+hh7GjwxIMKGKdVhOH9A/jpKEWOCdpPfg2QinL21ZCf4IXVlWCCY3g?=
 =?us-ascii?Q?bUce9dEb2Q8Iu/54GjSJfFhw7bKVocBIQo3aB9NmVyO9Dh8KhSE0Y/WYeTQc?=
 =?us-ascii?Q?rDWDV7tlfNuVOI5LNQvvoMFVceeMgyfjJMGtiGt20V7NFHLRY4PBdZFTLOi6?=
 =?us-ascii?Q?/EOiRMdITDWYgCzempfHVyHpXseGaY7KZ7x8qf3VpUrqGFyaj24ZDT/JKfZ0?=
 =?us-ascii?Q?SmONEUqx8FvKS80QJCs7jI6yPW71sLUOvgdoCzf0dF/6RBFMZEl9EhSaYC/1?=
 =?us-ascii?Q?9lc/TTYcMcv01se3T9PucJ8WC7lpFjiLQODeKjoPX6EdqYrm6UeQGSRx+wvx?=
 =?us-ascii?Q?f/V2pR4BwdOC4pNOMdBbu8u4qfkTjarYEMSDuuQ9BbAMbOB0q+m1PI6L/h8n?=
 =?us-ascii?Q?/0sueK5/LEERyL3h1CdqOcr0p2fWIMRz2/vYFF33ZrlcKGngA5KdduBDi5yX?=
 =?us-ascii?Q?8sGvu/LnVsCmmA1NoBmUM3y82+U3oWptzBUaDdImuGpjaWFM12HE7CjvNO3X?=
 =?us-ascii?Q?7CfBal7bSXAZJR54Go2Xe+BT2/Dmm7jWl6xesdeb1ZekjTshySukpixHIrJY?=
 =?us-ascii?Q?H1H5fhSAUDenLXTNoR45/ZZlzt3j9a8xMYbKdRvLUFVIHijcnKd1ORi5qpdQ?=
 =?us-ascii?Q?KzQPxXw3N3B/xlAvhRb+z5IkaNl1NTHZsaBhZTEOBAceD79fEbF4A7UxE8wU?=
 =?us-ascii?Q?xEvhpjPHWXDx0EbTTKizyoPPJuZ+IetGF0zOT04YLEVadPazTkobxUlaRNt2?=
 =?us-ascii?Q?b5bQjWXgt2nboOmaMo/avLQoi77mBl2irFtipOOxGq9XpngI35JlaJduFWj7?=
 =?us-ascii?Q?hShoM+Njvix2RSB83WAeWcd18HcKq1Ix1Se5VtjgfJkmWBDR8skwnC6lgWwc?=
 =?us-ascii?Q?ROW9Y0tO5slL/aNB7eonWGM8HjEbkcgXgWHeYEEFK213YjNwBg3pbhonpq1C?=
 =?us-ascii?Q?xxaxOMgm+SHS0I4/S0BAPQ9hji3h5sCfA2gKDKA6210wTWjGKiFMvDYO57x7?=
 =?us-ascii?Q?kmwQp7/lZqlFTPzUOVo2LKyflosUu+KYaAcgTXozFx3JzViEPCJ1/dY7kyDs?=
 =?us-ascii?Q?KjzOSpOdD3wsw+i83wc/SkcrLO6/kpyJRHFPO+wdKNyS89tQTYHRDy4E0cby?=
 =?us-ascii?Q?FhnjdF1eAP0ak9jNPHXMdpix3MAmUHSd7KczcQLgbXQ17Ra1zIgrbLPBwYqX?=
 =?us-ascii?Q?x24B0wqxn1iwuQzIytGM7e9cWpLBPoCKXd5BiKVVo9YLgcCZ5yAqyGnv+mym?=
 =?us-ascii?Q?KrC5/Q2d1zH3J7HADhiranBO+2yb5ufkzvwvgK/r/MJdHamnoM7t02c2mCH2?=
 =?us-ascii?Q?sz3KPM7BfrEZb/7OWn6+Smuu5nRC9TM=3D?=
X-Exchange-RoutingPolicyChecked:
	be52RA5bBblgZUl/T7khcVZNrkLmxOukvYZ/bnH31zCeIuZp3eWs0dxOXhrdQeqdwvVmMaTukZPyC/l311hzyhMIDIzL/bEtkxlUpPmNaDxC8d7Z5vnT1DkA9ieNprDWidv9EA/Dyr8unNZNwG6ROu4PGe01ZCI8ugz96qvc2dq3OeN7XK4OW0MExksOpR/1J1uYEluzft2nehaAwjoN4dqYQDkeZbibh3B9GNIg8tS/WC2Ww3I3AaLw3kCTfY+cY+ak4Zy0YU4mdle4i8735q8pEa8XFjvPjxcUD9NH+hB++cawDNFZnwb6ALo6eaRzuWaZDxnImRSGAwzR7m4HgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v86gltVaFEDfSlDAVY7OOLYQPyS8YnEUtcsEbDtI2AqdwoWYTOZ5OpYJ7l2070ACPSXyUCgrRRmXchTTcDDeut2w3InD51YArWJbCJlBCA0pGqmHS0/OWHE0Q/XpFWrpg4QBh+tzRvOekplA5L8QB2e4HddOmU4HA1tz6WHfShtV+QFTn9NJOJFQFHPic4zazx+5fm8IT6Qq/qkIsROr0Ewy6Ftg/5N5RaxC2QqjgjqnfvIJppaVtyzz1zn4JNx2WqrQMUVNG+Qefhf1ScBWnodiqYNKzd16q+KjxPeGqFa8tFnLCFXcMdm3XZfF+goRepov48f70IYdwySO/c77xBfBWHmih3VBKmJN/m88HzXYlHHl4XzEk/gbYLz21VfmS1+Tl53T028e6zITDJVB6kRtH0aXefvuR54MWJj/DFHlY6DmGcyfZJIpTXMwrI3TCuZv5cb4RKamv/DutxrCYZssRduBHb3oxuxxsxvQUXEOa5tLQDIK/l0mupCvpOOmwse4gO4ycnspMCp6GKFVL3HqNIxVOZS/hhvZNEp9bTyP5ydIXMbVpoHzARvgcf2Zw3dTWkcpJi5ErMz4VG216FjuwS79Lm6dOaxsVNOyXzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834fe5e7-3236-4044-c0c4-08df3b93e188
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2557.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 23:24:04.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+vCnKjyrhs585gI4+feNSoBSS4VLcq8sj9fQW4ybuZX44PH9IUO/fcf8U6a6+8x1AquIgY3P7IKjLSErZvZXyPDkQowX0DsvjgG+EYLH0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF715E13019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611050093
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA5MyBTYWx0ZWRfX04qTr9xPSdMe
 6f9nnmMouUaFkis2TM7XXFdmOGD2x9UixrGsKETgCKeMRtzXzWP89Zi76tsilGESF6jdeuA4sgb
 z6llmfXynQ0u+ISMfQCZUHXp6h0B4UmvV692veHFycdXKt7oXQT+
X-Proofpoint-ORIG-GUID: HdKn9yhDyi1NNVZQZ_G1UJ0Q1Jy-4Hof
X-Proofpoint-GUID: HdKn9yhDyi1NNVZQZ_G1UJ0Q1Jy-4Hof
X-Authority-Analysis: v=2.4 cv=U4sHnuru c=1 sm=1 tr=0 ts=6aed101c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=1sgtH17KOkIwHctj1UIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA5MyBTYWx0ZWRfX3VghcZpiEO89
 aXNRy5II5w+Qa8F1BEaORnviDLBsw/uZyZ1nD9Q3CgmiKN1ol7v5kzy99N/pX5OQZDC4KjNwwoI
 eFYNGaVOmyRJTm9xAYbSTce2HbwSZPjz06SK5u4hu7cpUAX7b7h/LcLa4sObENHC2RuNejvdFxS
 JyYADc8AaGWufav9v08qqpolKreb61zKsF42qyXnBGlOK5+9kkvQsVihMMlDVmCevYUSZqcRpN4
 ubifZvFp4taNrdbIILBtCg0y3wbr1/cWLuKG6eyLgC3GzwmHIn4M4hx9Zn0DtJdXjfBnnkAnoqU
 K1uMTtDMKPe1SCZ2sfLrLXWLH5iCc1ph7RQaTnIku+aPHtLzymfX+7AvaBX8nASE9Bwd56KuAO/
 SJ/cEgFrvyIIBDIrTLZUzRKAhe71frovGisSC6ISZ8t+yk4tZekEONA4I6pyHB5IkzAiT30ypaC
 FNigOrI26OfLaVSprFA==

In stable v6.6.161 there is a build error with ppc64 when
CONFIG_IOMMU_API is not enabled:

    arch/powerpc/platforms/pseries/iommu.c: In function 'iommu_take_ownership':
    arch/powerpc/platforms/pseries/iommu.c:69:25: error: 'struct iommu_table_ops' has no member named 'xchg_no_kill'
       69 |         if (!tbl->it_ops->xchg_no_kill)
    	  |                         ^~
      AS      arch/powerpc/lib/copy_mc_64.o
    arch/powerpc/platforms/pseries/iommu.c: At top level:
    arch/powerpc/platforms/pseries/iommu.c:1787:37: error: 'spapr_tce_table_group_ops' defined but not used [-Werror=unused-variable]
     1787 | static struct iommu_table_group_ops spapr_tce_table_group_ops = {
    	  |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors

This is due to stable v6.6.161 commit 1e9dfe15404d ("powerpc/iommu: Move
pSeries specific functions to pseries/iommu.c"). It was included as a
stable-dep-of commit 8f70caad82e9 ("powerpc/pseries/iommu: IOMMU
incorrectly marks MMIO range in DDW").

It was backported without its associated fix: commit af199e6ca29c
("powerpc/pseries/iommu: Define spapr_tce_table_group_ops only with
CONFIG_IOMMU_API").

The code was supposed to only build under CONFIG_IOMMU_API, but the new
location doesn't have this condition. Unfortunately, the fixing commit
comes after a fairly large refactor, and doesn't apply on v6.16.161.
Instead, apply the ifdefs where they would belong prior to the refactor.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6a45e3e86f79b..a79927e870a87 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -54,6 +54,7 @@ enum {
 	DDW_EXT_QUERY_OUT_SIZE = 2
 };
 
+#ifdef CONFIG_IOMMU_API
 static int iommu_take_ownership(struct iommu_table *tbl)
 {
 	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
@@ -104,6 +105,7 @@ static void iommu_release_ownership(struct iommu_table *tbl)
 		spin_unlock(&tbl->pools[i].lock);
 	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
 }
+#endif
 
 static struct iommu_table *iommu_pseries_alloc_table(int node)
 {
@@ -118,7 +120,9 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
 	return tbl;
 }
 
+#ifdef CONFIG_IOMMU_API
 static struct iommu_table_group_ops spapr_tce_table_group_ops;
+#endif
 
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
@@ -1702,6 +1706,7 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 	return false;
 }
 
+#ifdef CONFIG_IOMMU_API
 /*
  * A simple iommu_table_group_ops which only allows reusing the existing
  * iommu_table. This handles VFIO for POWER7 or the nested KVM.
@@ -1792,6 +1797,7 @@ static struct iommu_table_group_ops spapr_tce_table_group_ops = {
 	.take_ownership = spapr_tce_take_ownership,
 	.release_ownership = spapr_tce_release_ownership,
 };
+#endif
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 		void *data)
-- 
2.52.0

