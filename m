Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C25293EE;
	Thu,  1 Oct 2026 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866592; cv=fail; b=uLYHYkbmCYeZbBmApS8ua4Z5BL54S7Vd6qzRXiD7c6Iv3D/GV88NsUti3jQfV3ZH5FGmO1FwXhXK5+P5yEa8iGGPU7QkCCvgUW58W8nwgsPsu4ObjesXMCE6QfOsrbdWzhcVoIO8v6HLtFPIBsC6tmBb0t+4Z60Z/OwuLOoSFTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866592; c=relaxed/simple;
	bh=Q9BcH+qLvD6l1v8Tzu2IqAY/RpeohfUbzYXihfgunjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhAoqzaddX/Qu0PjlDhYIjIJcASvztPQWrcvI3mVu46FaHfV5D4jwIxR9REgMXq5zvPHSY0JKkKa3db0P5AChHmEArRHrXMovRzTrmW5NA9afepoNTYxjFCLCFBPDMjYtxHQMCqnZXK9kQZFmR/cwX4XdOYixLFedksqfthPMrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bire+3hR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ne9f3BAs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bire+3hR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ne9f3BAs"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMWKF3077742;
	Thu, 1 Oct 2026 14:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kLMEKWI7ZCcjicBNTZb1ZNUhbdbGoXSNRLNaz7N3PWU=; b=
	Bire+3hRcUKFMd5HlNm9AhI4d/diYQOIWwLtZAI+HqepQDE8P73s7u7A2Uib4nUp
	tXyAbr1bxzAJga1nR/YSgYMmEKvsvUxdx9qPZJmpJniVAz7qmjHBK/YT3bT1Seyo
	Uon9neDPzsLJERd6THir8UzxYb1IIwSG2erC3i9/5yWPdbCr072h4ICDo9gkAECg
	kdaThnU1G/6wbbnznt4x/x9DQx/oD/aW6T0mcrNJiSvh0GbxLUF8x84gLlSwmBxG
	JH9XJJtz73FvbV10IstTaiVY0pKMvr7OmHMi1vKwAVnFZl9Q86gTGHhIchmM0OVa
	a2ALgZfUt3bs/MEyMuijHw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4myh8dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:56:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnngL011445;
	Thu, 1 Oct 2026 14:56:18 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gepq8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:56:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itRJbjQ3gmMNRrl5e3UAWRVZgtDatONGqZ3EH+6OWhZ/7RO4D1BQszHG8nFXwDNo0DDrzTF51D2eZ1T7hCO6dKNpXjyNmqvs9a7YHIROwPCxb+KYhlZmHl84dnZdIr93EJ+6L61jtQCYqUBBr6vIPJYh+qn6w28pwAx1qResvFGUVlD45ZmxloDFJFTV6En/zN8L+PeGa3YWm9Tf38rOa7oH08REtkXXVbT98CFT8Z2ZRQxiXX/BSbZed7qOKl/jOd0+nYxQuxyTbf/07Nl40HFlsQHKmgK2iid64LftVyh722AJHJByMLvcCsvuYw9QNGA2hXWLyfPVzamoY9Cf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLMEKWI7ZCcjicBNTZb1ZNUhbdbGoXSNRLNaz7N3PWU=;
 b=X+6KVQC6ccBLn1JzFEDasftKxq9WZLrhmqnu2CptarKglnQ5csCTVmtJmRK2I3NSOjdrfYkT2NyrybKQqwfgLtbHy28OlFpNlFI2qtNsWGRppt4YC6uzCxRrZF+ycHGhPURQ5UWFcdiF3zkw4HpjvW6xS5khE3JOQnnI1za61shPHnLD7RSZ4M5YfjF/xuaropTMq91IVfVuUbwqu9gge5cSJyxXDjI5lTWTvZVVeUa6p7hp1Vh20XU9EYuONPVm0kzf4417Bz4RansBABIsqIY01SkO2ZiSSIOrMIsdhVtteMj+tNv8DpglPoLzRv1BoZT9ouf4vUAZR61VtJ21hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLMEKWI7ZCcjicBNTZb1ZNUhbdbGoXSNRLNaz7N3PWU=;
 b=Ne9f3BAs8mG7TrGOH+L9WL2gcLnphj1nZqIsNFBZwGNOBOe1y9sUD59rSoSDFSQFApdQAD/0pmIh9EFo5GzraWiFMbQ3fS3tPy7fFVDi72BMS3sBh8waT6k8j1m2C8syxwDP9GOejY8obChU9swxlC+pqHv62kgcEHffIK52G/A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 MW5PR10MB5763.namprd10.prod.outlook.com (2603:10b6:303:19c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 1 Oct 2026 14:56:07 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:56:07 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 19/21] xfs: rearrange code in xfs_buf_item.c
Date: Thu,  1 Oct 2026 20:21:32 +0530
Message-ID: <0548a805579d609f57d1ecf08620e124b4c43d83.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::16) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|MW5PR10MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: e55e2587-d151-4852-04de-08df1fcc1f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|376014|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jLbflXErLSJqOUP7N6It6qPZ5Pm4t5JBUa6VmyzqXeuor5/UlH84dDxMTlq1irNG6qcrcVcHTQPxczKX6i68MX+Onen3st+Az1WFk/q9PUwJOPqpaGW1XXK7xQURuBM86oSahxC2z2swRmmQgj7IOEHgNlEece0zpvGoEEEsuN20bFu3KUy6+lHClBfLh5mPrC7/zOLrWzCi88FfCk8H+8cIV/6xfWuIix3z6vMYX9KaI88wODFtcsbD7zGiaW1BxkGjyxryvtONwIR4/iWcnSZ301VZCba9m2RjXS3lOtKrXzL0f1zau+efIjcpVtY+bUNWZV1wS6k3bqd1Gi/aYvaEZGoV7OUUySnspnmx0VfjtnHGt8axXO4n3UxfQk1HGFPzc8PUNahU4+VJzLjInQLJQr1EY8hITNuO92TZTUr4j7iQnZxtSjKGGoZW0PKwrrZ/zCPvc/vvUMUkJTSwS3aqBlOTirLyZomPj4qT/NP5Qv3RJrGibvR+ZI2FvlWuEaimQH7QIml+vgeNuD70F4owlIYgVXVMiGlUH5DSyE9hoX6lVsMQmtTu4dsa+De+y124jdBOrqROkOqs1vMWhw0zHTeKPe1OdGKrfI2ZLlqZ+xisQjkHa3T4WyjudMBxN08QZ5Kev9HQKb8nEEjoLXBQ8JKfGyip0nu2uk0hm/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s99kAEzZI7ICwMopspcwfqLqlMRRpUv168yC7fE29A6FgI1jwMehwSUvfIlX?=
 =?us-ascii?Q?6jmcqQVryfz4fErGu7YSfDVIvincTaq2yR8aI8PuBthvbsCTtkc/7FyBrxbm?=
 =?us-ascii?Q?RTq+I2+SQZpGHLivv25qLyNs8nfZf5kRlEieNNaixR9QWt2/kWUKOlRLpO2A?=
 =?us-ascii?Q?3MRTJ0scz3sZQ+YEViqV6IPF155palFmVb7OpVy8+sHOa0TMaaaK6xnlCgsA?=
 =?us-ascii?Q?9ONi2sqeUaiHsn3pIP1Vzp8KDhmQmh5OCaCAxuTB76F3TneG/6Cbflgvb3dJ?=
 =?us-ascii?Q?kHODcriwV8pDQJtaw5YRSv5C6t0dRyxER5oR8SfKlHmlTgzsMkO9HWQR0PZE?=
 =?us-ascii?Q?sf88Shz6EjLoFlKN/+O4cIkI06zQKn9TCrY6WwI7ujTQ6DDr+Yt6iqASzBUz?=
 =?us-ascii?Q?4sgo+W/oQwsWK5L0iXAw2wPn6i69QhWkiz/WQ7nUxsYXaHf6EE4yd20HPIUa?=
 =?us-ascii?Q?Me7dcdL2uuM3qVqrNkWsoM5/gDUnCNV1Xz3/fwuoAcGT2Etnh4ofvNN7IG9i?=
 =?us-ascii?Q?3Z15YghW1JerICcRGNYk8gMnofxDAgtjkDuZC584qo21pZRv02GO/s8+No/k?=
 =?us-ascii?Q?cp6ccNHlitIyfImFzb6E3ENywxGOHiktCoXd53U6MY4+YsOQ/qEG6Xc21IyF?=
 =?us-ascii?Q?CY9/Q3krL7KLdFFok9E2eRIWwI5pESW5m4JnNqad2rP2Ej88nvMFQ/pgytOD?=
 =?us-ascii?Q?zBrA33F2FlAJtkmdqX50FDGJkpTjT0Pe13rvE1Ls73N+59QKNV8j18pgPTcR?=
 =?us-ascii?Q?PG5iKhHr2OUyS8yNuHG8fXoXcWXLe+O6xXDoSmw/V13mwoBRmxscg8U7R0Fh?=
 =?us-ascii?Q?UX/L2J/WAaX7VWdK3OfQET57v3m197ogt6TmeCqen9gOUscxfsyeFCIpTnSq?=
 =?us-ascii?Q?NKRgAeeDmQQBqMijOxEWgK6UNqb52JuycTf12JWfYufbskRMVfH1XNgRtgG/?=
 =?us-ascii?Q?6X+RjVVhucihsQmBLPKNRiqMPWGiqJst2wJ3lks2X/PP7JV8jPfQpEZqp4ZH?=
 =?us-ascii?Q?Sa1+Rs3mkTJIcYO4bKgq8MZf/E7k2xIcgxeX3rp06Ypnlbl4PzURSPMqF//y?=
 =?us-ascii?Q?u5t5YvzomA94RqpSgcqJoRRju7fwakuXlYYqt9Jcu+6bvvCU87EVRXgZlE1U?=
 =?us-ascii?Q?SVETZO/YB6Es1le3RDLrOWCbBPRqS1a4dZL4N6CqClHDS2FfFSxavTEO0AJQ?=
 =?us-ascii?Q?TerMEnXbaO+vG0ZkKaV0DFlA47tdGKfLVe/ft9pwVX2W5ucELSmOdAwSS0zn?=
 =?us-ascii?Q?F2sWvJJTflorNyHq6ueuveVB8MY2TEhsxDifAQYJIsvl/H9g4OIYrMQ0GQ8P?=
 =?us-ascii?Q?O33xjY2eQKW5tJfeNUpshT88kK7YAXZTyiCrf6DU30F4okHcI6kUXl3QUmgw?=
 =?us-ascii?Q?BZfG/Lgz6RLDRUBlfztqnzuFaq6YchTqb7o5n9SPQVi9Nm8XI/WkqVSuOJMv?=
 =?us-ascii?Q?YD5ZBUfSipB03aLhtTNyoSuESRMo6bj/bKyN1kw2XS4iyfpwYateAZh2Dk97?=
 =?us-ascii?Q?leo7pTYEimNGIdRX0gLvUtoIDclve0DqSZuT4L4Y8d1cEXwIxt96o0ZtjPYm?=
 =?us-ascii?Q?Rn9/hLZhuXso7UzGJSCcMEnkrFhvy0Y+5ams+cWzqPOH/VhqgN2rqLXIvdAl?=
 =?us-ascii?Q?MUXjzYj0Hv0o4bJqaw6OnJNwQeNgL77SlP+z2WPY2WhITg2OlxM2vkIw8Znq?=
 =?us-ascii?Q?LL/Enn1fUOMDC6IUssUMcIOCBfIIg4R1v+6F95UoebPYBWE++SEHgPlCsTzM?=
 =?us-ascii?Q?1PEU3aHA91oWpHiusLYbQLjtL84mu9jjCMNgs+/wDPu+enEKAzeKR5kdEpfd?=
X-MS-Exchange-AntiSpam-MessageData-1: xBbu5aEBahyjOw+mY9q0nFRblvGLLJP5hXE=
X-Exchange-RoutingPolicyChecked:
	cM9rR1a4OrYX+PWAGKtTlf5vuaM+JGrLTBINEOLYYYP7Jy/SVtm455+7O/dHezvBH4Xd8QfewVhpMoVc0R0Ah0KDFi30NhwzHyY+dxGPvSqW/RI9HChcsdhYZxsHYvYZP5B0qFM52Z/DLAAfWIo6XijM6uQALdUO6BtHN5LtZmhbA3Qyi0l86WDpFs8tIB+9/KOptlNc36kbVwPEDX87R0SU+3sB/xoEPNKwXoOyM98zQRAlDHEysybTfILYLnYCX0y6xxyvte61kJYgN8VXIJB722FlepBo25SNYg2l0YnCY5mI3XCDDwZIUtKDWxXyZ3MLW0+r8QBGCcaCJsQObg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JBJbHnyc6aiLHi+bQsmBVdGO/8V3sZ+9yVaRNo9SLBd+l+pQ3YftuHlxErWT+gm09BwEiJ00Gpj0QFPJ4VHkolN+Jth984lmlmSety5hj5rUiA8FiHpDA3RR6hIJCnUwlyuPoGEG/eQ8oHokUj26BhaAK1V8xS0/dZADiNZRlQ16JinbU7mMsqSXETwrF49p/6z8zKDUtJMICGaJpP26Hq76f5glE81gexA2uuqBxrS0saoDyLlOb0ALSYnBtdWOsj7HEpuA9QVPxHZKEQr3m30XRwU7aeRehdLPizu8ifeW0jwkadY2dBAzCTRJf/dou4IU6i5FjHbmacunx+hsgv/fCL3ZV+2dPNgpsaxvfPenHOmUs0ELCPXPhKqy21fUgjlxyaIxdDrkeOL2sMxa0rn+O7EBmnaQ+fHToxJVOJzQ2suVJ9kyqmXN8mdZU2+5Mlg+cxGOXqyLVxcn63EMzIZPRyeAhshSKs24gl32O49SpQKcW8BSWsFU2JAuCw1+veSR4qio8G/hTG9AVJyuJb7S9hhPHF7275jTvk2Lu9LhaQfg28kdpKxIIYfUUObtIoQUsKmj8HCcYXg9oF8tQacntLUG0keZcMDahILH9c0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55e2587-d151-4852-04de-08df1fcc1f6d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:56:07.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaeEixn0+qc8+/05i4k4wpxgBMPTeNSykX1bLxRnSfQNdZbJYEejp2AQL9iNyc7XJWl8h9wLEUyIRKJIN3ve7gEUiev5EkwJBysB9Icy3+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX0DZlKljUdwID
 PoEwxnvSdNPQ3pB2+PmrgQUE3T7QxIjKymxDRpE0qMKLTzxyI7l+QyYb7wPMc25iTYLb4CkQIcI
 EOGNvfjTstID6bNxRQvVuBsLRv6JIHvpNvsj5Vw1lC5U11AsbAvi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX9CmOV6ypXprb
 tM3zmYLjkTqx3SvFNGTnzJWy97VbTHmR3srflCmzCmgSkicZIAWrKsSDfXy8ih/3614X5pM8BDZ
 XpZ6F/n6AvSShfKJfe56HjKxeh6RuICMl4jaZVlneHON7MH3IhRrCdexiE2IkT9Y77bS9Z4Txzr
 K04SxHbX4cm/ctubVD7AK5Kl8ATfi9ShIYrKRgruzRF/lztua09jFV1mzFebZM72DZ1yiKnbLOW
 aWg7ao0LlXcjikNChb64C0v5pZlwRZIYl/2/ztix0CHN5VtiV1xCgbehZjzxTKvSEFEZrrzxiXk
 ZjLgLjDEpmmPmsdmx6dbI9IITJINAN7fCXOPIwO2GQyfWp2lai89bOmCUtOiAUcuLiw4N9rdyZo
 icgIINtLe2ZghZRhkfxIhP3suSrTTjhsAPF7ZRqv2fXXC1jJXERW/2x2PaB5AcvUXLRveLZOQK3
 Ks/1Wg/4GWSgR1TA8aQ==
X-Proofpoint-GUID: 4yFbVOLIz5QGYYK1jsZxONmOa7bAlMI9
X-Authority-Analysis: v=2.4 cv=DZmCOftW c=1 sm=1 tr=0 ts=6abe7493 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9
X-Proofpoint-ORIG-GUID: 4yFbVOLIz5QGYYK1jsZxONmOa7bAlMI9

From: Dave Chinner <dchinner@redhat.com>

The code to initialise, release and free items is all the way down
the bottom of the file. Upcoming fixes need to these functions
earlier in the file, so move them to the top.

There is one code change in this move - the parameter to
xfs_buf_item_relse() is changed from the xfs_buf to the
xfs_buf_log_item - the thing that the function is releasing.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d2fe5c4c8d25999862d615f616aea7befdd62799)

6.6:

Fixed conflict due to the following missing commits:
	[Continuous range: 10634530f7ba^..d4c75a1b40cd]
	d4c75a1b40cd ("xfs: convert remaining kmem_free() to kfree()")
	49292576136f ("xfs: convert kmem_free() for kvmalloc users to kvfree()")
	afdc115559c5 ("xfs: move kmem_to_page()")
	f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
	10634530f7ba ("xfs: convert kmem_zalloc() to kzalloc()")

5.15:

Fixed conflict due to the following missing commit:
	182696fb021f ("xfs: rename _zone variables to _cache")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 116 +++++++++++++++++++++---------------------
 fs/xfs/xfs_buf_item.h |   1 -
 2 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index f864e0b8a805..6c29b00c0e80 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -31,6 +31,61 @@ static inline struct xfs_buf_log_item *BUF_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_buf_log_item, bli_item);
 }
 
+static void
+xfs_buf_item_get_format(
+	struct xfs_buf_log_item	*bip,
+	int			count)
+{
+	ASSERT(bip->bli_formats == NULL);
+	bip->bli_format_count = count;
+
+	if (count == 1) {
+		bip->bli_formats = &bip->__bli_format;
+		return;
+	}
+
+	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
+				0);
+}
+
+static void
+xfs_buf_item_free_format(
+	struct xfs_buf_log_item	*bip)
+{
+	if (bip->bli_formats != &bip->__bli_format) {
+		kmem_free(bip->bli_formats);
+		bip->bli_formats = NULL;
+	}
+}
+
+static void
+xfs_buf_item_free(
+	struct xfs_buf_log_item	*bip)
+{
+	xfs_buf_item_free_format(bip);
+	kmem_free(bip->bli_item.li_lv_shadow);
+	kmem_cache_free(xfs_buf_item_zone, bip);
+}
+
+/*
+ * xfs_buf_item_relse() is called when the buf log item is no longer needed.
+ */
+static void
+xfs_buf_item_relse(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+
+	trace_xfs_buf_item_relse(bp, _RET_IP_);
+
+	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
+	ASSERT(atomic_read(&bip->bli_refcount) == 0);
+
+	bp->b_log_item = NULL;
+	xfs_buf_rele(bp);
+	xfs_buf_item_free(bip);
+}
+
 /* Is this log iovec plausibly large enough to contain the buffer log format? */
 bool
 xfs_buf_log_check_iovec(
@@ -481,7 +536,7 @@ xfs_buf_item_unpin(
 			ASSERT(list_empty(&bp->b_li_list));
 		} else {
 			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bp);
+			xfs_buf_item_relse(bip);
 			ASSERT(bp->b_log_item == NULL);
 		}
 		xfs_buf_relse(bp);
@@ -591,7 +646,7 @@ xfs_buf_item_put(
 	 */
 	if (aborted)
 		xfs_trans_ail_delete(lip, 0);
-	xfs_buf_item_relse(bip->bli_buf);
+	xfs_buf_item_relse(bip);
 	return true;
 }
 
@@ -711,33 +766,6 @@ static const struct xfs_item_ops xfs_buf_item_ops = {
 	.iop_push	= xfs_buf_item_push,
 };
 
-STATIC void
-xfs_buf_item_get_format(
-	struct xfs_buf_log_item	*bip,
-	int			count)
-{
-	ASSERT(bip->bli_formats == NULL);
-	bip->bli_format_count = count;
-
-	if (count == 1) {
-		bip->bli_formats = &bip->__bli_format;
-		return;
-	}
-
-	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
-				0);
-}
-
-STATIC void
-xfs_buf_item_free_format(
-	struct xfs_buf_log_item	*bip)
-{
-	if (bip->bli_formats != &bip->__bli_format) {
-		kmem_free(bip->bli_formats);
-		bip->bli_formats = NULL;
-	}
-}
-
 /*
  * Allocate a new buf log item to go with the given buffer.
  * Set the buffer's b_log_item field to point to the new
@@ -959,34 +987,6 @@ xfs_buf_item_dirty_format(
 	return false;
 }
 
-STATIC void
-xfs_buf_item_free(
-	struct xfs_buf_log_item	*bip)
-{
-	xfs_buf_item_free_format(bip);
-	kmem_free(bip->bli_item.li_lv_shadow);
-	kmem_cache_free(xfs_buf_item_zone, bip);
-}
-
-/*
- * xfs_buf_item_relse() is called when the buf log item is no longer needed.
- */
-void
-xfs_buf_item_relse(
-	struct xfs_buf	*bp)
-{
-	struct xfs_buf_log_item	*bip = bp->b_log_item;
-
-	trace_xfs_buf_item_relse(bp, _RET_IP_);
-	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
-
-	if (atomic_read(&bip->bli_refcount))
-		return;
-	bp->b_log_item = NULL;
-	xfs_buf_rele(bp);
-	xfs_buf_item_free(bip);
-}
-
 void
 xfs_buf_item_done(
 	struct xfs_buf		*bp)
@@ -1006,5 +1006,5 @@ xfs_buf_item_done(
 	xfs_trans_ail_delete(&bp->b_log_item->bli_item,
 			     (bp->b_flags & _XBF_LOGRECOVERY) ? 0 :
 			     SHUTDOWN_CORRUPT_INCORE);
-	xfs_buf_item_relse(bp);
+	xfs_buf_item_relse(bp->b_log_item);
 }
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 50aa0f5ef959..e3ccbf3ca801 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -51,7 +51,6 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-void	xfs_buf_item_relse(struct xfs_buf *);
 bool	xfs_buf_item_put(struct xfs_buf_log_item *);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
-- 
2.53.0

