Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1F52F29A;
	Thu,  1 Oct 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866334; cv=fail; b=RDDKdlKABRNmKpgLN6781R9745GDvTB7E4RE0ZnfNVmoBMnRlP9p/ET1bvWe9dChkmQn1CEjUfJs5dxWGRz8lXlqZ1dGG1SQNgCrjD8LrPYPoUxw9s6fivxuXqmO93E1vnrhmfdiwxf1/onVmBBKLQ4xI3C1HEAFru9f5daTjys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866334; c=relaxed/simple;
	bh=nXnaWiMhrm3ZxgcvIq9cijtpK2BcssziuPFx2OQqc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o46PKtqzDInIZtQHw9VKd2zBVd8NPHDUXrNy4pWSoncCqzQ0V4YaR5JD7csJ85r/HP2Dbvi2pSJ6Eallt6nUajqHhqR+c0dT8vNjEP/j2BAqb0OmnsZpK5vWmfgHesk2gX/7kj45KqhL46jmRtZ1jisq6h3p/fDR0f3h6jkxHaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oL2MIUYS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DvZCeSyv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oL2MIUYS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DvZCeSyv"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMc0U624353;
	Thu, 1 Oct 2026 14:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zQiAUrjCanqx/q3uMtAg8xUAwEeSX3fhwvrC/aSGxFI=; b=
	oL2MIUYS4xnPYTpjU/tFtbjGM1jHq1bEVRw5krfAA6SORAMDoMf4BuSY/ycr4UQh
	fc+D1t17D+NlNUbss07LPeByR3YSGucnuMntX0GaoBJsulK4M9lahdVKhkeXk/3h
	uC6oO83RyMJV5ubKwMWYT/WJ3MYxMIi1BRHQbXYlEtRQSICg34+l47GW/nbabpW8
	QPqG18/0rFoxSQRxdICqsQmLgVP1RkVxE01qaU9k/cHhm0JIOcACW+paGDbLm8DV
	/4gFygox5PwCk+K3DZAiG3Jg/IchPBEoQgKSJ222q9VB9cbJXHF/W0FXyBatb4kD
	f+xxrI5a+iRNOuAiRfmEgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns105e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpDL017287;
	Thu, 1 Oct 2026 14:52:06 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey05h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1CjimRVzZfzvvS1ZhSZiv82hkTYRziPiiZta6zUVHfBN+tMwM0MsZSJ63zjk7wezHnrV8vSCQVsem3G8Uvi6PzaZgTHRt5l1DilEXWvVJkkqfCDUt+8vnKp6o5GcV/vOFM5feQLxauLyoeZ5DfLPtH3Sp45C5xevelmjuiYLLcRdfQlFnDGxwSwavVVMltxxuHwbaXC9PEARSIy7g7wl16FD149HHEWnxW743cw7y22LCOGJPCCrU3KrwO5wZ8K+juMCfnD5stMqS98IP/YT00rinCB31iN4i8xvaTV8jr9YCiMoEH7ddX3xosSMxPH2MXLwC8dTfQCXreegvRr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQiAUrjCanqx/q3uMtAg8xUAwEeSX3fhwvrC/aSGxFI=;
 b=bpyPBBRPr6L+5+kxuoMdGxJSVYUeZz097l3K07BoqXISxN31x6xIwCQ8Sf3WLoxA692n4EGgJRf8YBthduux5c2TiulbJ1VaZGNPvJ2OXZlanq2eAB7Kh8qiPSCmWWyiKX92DtPGz+3uSC+rp6Ov3BL2jDHPfoIxKkwC4PAGFQfDV2LqUzmqH8NjMLxC0H8ouiEq//aBszxes38AeTSWGqpUXufEqDVLw4QTgPpFVK1+n2F++o6k8i7cfC77QJ5talyzgQALSJpdSYSQnkC5ZptRJyBtq4od14+rHH/5eh6Ssj+9upExHB7gDNINIZBCmOjVaPhcg0MbF/oohEWkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQiAUrjCanqx/q3uMtAg8xUAwEeSX3fhwvrC/aSGxFI=;
 b=DvZCeSyvUiZmls9TRV/6eIzq2f1nLgfVnpp+SJQwIBA7sRoKWzJ+3ZJ54PJsX0dl6VdFerzBL3/Kv38z4G4GxraLWcJqSoJICjoM59iDB0ljM7jqWTyYtixlgQhNWsSzxmEqVR/jaee7WY6iPP8ON5wNsCgf4SczCN8MBt9GiuU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB5145.namprd10.prod.outlook.com (2603:10b6:610:db::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14; Thu, 1 Oct 2026 14:52:01 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:01 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 02/21] xfs: improve the code that checks recovered bmap intent items
Date: Thu,  1 Oct 2026 20:21:15 +0530
Message-ID: <80730d200b1c72a3f272c029c648bd49526a5e51.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f2f2c9-22db-4b58-c0af-08df1fcb8895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CnR1Cp2m7O/kHIG2cgB11WFEUEVWI4uEvXLIGIPEbnxUnoHYdlfyMmenROliCTxDED6Fq2mD1axoP9rjfWPhhsQBtMjpVA/CTwBx1sJtpNBbezGu72H4CM7hqxu6kVyQC7TvzfxxTFprbQtloLh4V4O3fW8AA2h705HCJZEUz9QeirIzCCM4lsQoHlJHaab7iE3iq/TRbaA0O5SBt5NxicJb/L1arwgj1S7hEh4kS2QqLGP/rNkctOSC2Krr5G3zWHHh7hChBynyz1diPBRTbKaLwAHUCmvLmW4hFAB0Ckbwq/7Jsdd1+hf5XHsg6nd7O24AefULOhvIEMDJLb2YDgRrfBLpthw0qH+ZQ28QybRDVmpt0mSkjO6BigIOabFsicpRo2uvWIJNNxCx3jqbQaRdKnZqb46q6bNWwVA/3M8iZqdkutOrk8KZkX67bi69yDkpv129DEVI4EKE098c2djiwAlUGkTCUrzUJJjQqY+591vV5PSmLJh7Xo/fnwfShR+LQ7jo1hs3Y+hH/IvhKW+QhOwAB5o1KDM2GDcanJjdQXVcW3jDsWU/atpOxo2I1ymzI4ozf697ADOInIIIvlPDMQHEuwUkNXApc2Ibjia+OdxL1u018iEZuHQwlR54RdA8005YftGfvxzBT9VwsBg/gxGNdITpDbHn1gylezM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?13KUt7yXR/XdSNNViHtPsq0Q0ovimsfpkEt0niAySEkiKLJMdVzxrZNLpdx1?=
 =?us-ascii?Q?lgNXRd5mwWzsz7blngQ6nVbhwHhup9bx+asQAOdG2geOBln/WNTsVfkncbWB?=
 =?us-ascii?Q?DuRjH6o3m+1loS7FMNaLhONzmq0EIKyOZLlVpGbCNPSvT/umGkYLXv4JlnJ2?=
 =?us-ascii?Q?58FAuVdRLIp9j7NN4ru33VNnngjKI8CuXsmgjOSBvz1Da/DBknWmIBZofudX?=
 =?us-ascii?Q?urGXxJfUxGt0oumlr/5LAk3nMBlBGuo2hQTWlowTkmQE3P5iNoZYEX2/YBEF?=
 =?us-ascii?Q?a15/5rDcRj+J2R0pRC9DyIodKyfJbdh1GHYkoBHMH5Og9t2swAkefVoIR7nA?=
 =?us-ascii?Q?oMX1E5wvp1CnqGMGI0kZn+ZZPzioyDymqF9+z4eXK4YiNhTdMtz5DCJYK7l4?=
 =?us-ascii?Q?ZJYb009xPV1/KII8Q17scU6c3m+QKoP/PVP8T7A8SgGfzXeoMalBteVmFQf5?=
 =?us-ascii?Q?SqP947BMT9TFBZBAOf8RHA6HdVWKsvZvPlliGNHtOKacJlrPWND5lLiGGbQ9?=
 =?us-ascii?Q?LfD7Izkt2GgOoXMPGEyeRjOhE5YBs8mxHdBwdhvzT6eqoJynLd1ofSywGO6/?=
 =?us-ascii?Q?iF88Nhktd77Z3K6BbrzhpfWIcqtZBc5oCE9d/LMX2NCHEaBqt575IGqaC2or?=
 =?us-ascii?Q?TH38Vj+YGu1KoRXKas0NKxFDW9I7VqEQ9OQqRh1inzSzWiip6GABpV13cTly?=
 =?us-ascii?Q?EY1BdT7UJGMF525bfSwwoWt1+ESJDRmaRy9uGafzkNhxFDlxbkYqBGpdynxi?=
 =?us-ascii?Q?G2DYwTR0wLQBfYcDh5wrbMwGyQr6YHC2qBSUCphly5jvZ6xEu2e8OW2Kw/vn?=
 =?us-ascii?Q?iwn1FwDCOWAj6ChaT+ncIUPrMmrWwDZS/8IC51COrDE8n0x05jnyYbJMlx9H?=
 =?us-ascii?Q?O8D1LduWlqx741VbajROXDWA5BY8xFCLvIWnvEMciYB6amacVepD3vun07ys?=
 =?us-ascii?Q?XsUxR8GwzlFqISX4xtEWwsHT0dT7rBt6jKDDgjAr67fF7c5pDgmYGg7ChWqL?=
 =?us-ascii?Q?qg9mxDepw7FAqP0W5tPsv0Xc/Q/xuaVdK9/K+H85u3/+/jdbIBRGs3BWRLuQ?=
 =?us-ascii?Q?sI13jVyTN3MsXnj0S8DsBMvVJpAfLd2GYNcrVaTAtdhyXEjh31BW+gVDIfsm?=
 =?us-ascii?Q?Ink0jIDUkGGXb3AYKFpMzO2L8Ui2TUm7dmfcYq6GirF4LC2TbYSqN65+1JAu?=
 =?us-ascii?Q?DH3vJHc4ofQyf4FJnCYc9tyehL+dRSHkYwzJgrCR4Q/GhhKFo/Yw68wshwKQ?=
 =?us-ascii?Q?o/eAfSKf0OWkRaGH4VKHfqqgHdPrQe+KhkJ/GLWKTrKTtvP+XtEd5pWtKzaa?=
 =?us-ascii?Q?F0r0rv+HpoO1HgyUwI8vm5ChnoTCiLDeGXpTIkbkWFOM5D7UkLd+As02b4pH?=
 =?us-ascii?Q?41rCDJOK/CTC2XvTG0LhfWkjL9GtoTAXRMYSIVPhvk6v2SIN3oAR4l0Q6qxm?=
 =?us-ascii?Q?L6caHJ+3yUJX9yaBPKcNIXmUCG21nDTcuQTzOxr1dmFk3rb2O2PyKZ1CRMwB?=
 =?us-ascii?Q?Sg7SnHg9OxuhSNOu3KW418og0veH6+Z39sqOsz9R9w1HQNgOuGU5l85iqc2z?=
 =?us-ascii?Q?51R1t3Of87O9QWnF7ZJvznv3BtX1KS5CtDdD+cp3vRgbtB1imiXvJLZt1kY8?=
 =?us-ascii?Q?Rv4P8nGkeNLNlhoWgkzA9uVW2FpFv2Ebx4mYJpaF58x/RPGcm/+/L2BwiRg9?=
 =?us-ascii?Q?WU6NrImUvthfmxqBYcne0OzKa+WpwwaPsWAPuSHgbSLHEHC+ekAnShY54v9f?=
 =?us-ascii?Q?5Z5wZqmyR0EwoNqxNfayO7eiDuqPVZ7t3fomPryrG6WUFNJfHLByE+Fqooqt?=
X-MS-Exchange-AntiSpam-MessageData-1: kjNKqLnyCXEclR9WYeLypNIICO5naDT9XJk=
X-Exchange-RoutingPolicyChecked:
	eYGU+iOAh75ucPNobCmAjGHqyF9hT09lHw/M7YXt3ixhO8m0ILY0RdC6qD/avvYKb9iUbx3pB36d+I9fOi4r8/TnhkEkyflr9+RBc6YtXF9oADz8hlRE5IFT9P2w5CeR7tqyPCEAOC+gSUiZfzqwVIHdnnf3DSyy4qKWm4z3+HehNb2P5rfqX52g2J0B6Nit5W5sGuMVv/+Sf//C1yOpHpcDINuRgF1mJMMXBF4SNP0Msn5nClmmSHtD9MjbQe7FQ28ETmRIPWMlSHc7Jgfkc9lt3xLdzPOkgh9fOZROqFnlvOKELsu2NoN74pwj8WoNzoZWqFek23O4Rt1TEyw5kg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hdcmTw7MvCYkm6YWDHGyuSHl04VySRtR/aldnVK9nlOOdoQ0HIa/My9h+9svahQPWpBwFTXM/jxGgw9ShlbC5t7f9RGtxgt/1BNWf4ip1ci2aa/+Z+MxE/BOarvVNZKphKw2xNi+U+Xjvq0vP01VPgvpcKSRMQtqhREsz4xOb56FXtEzuK97QFnAo/Pr8ePLNeOzsGLTieFj/hx5NE2UY+Vq/mz8KMqCPFdE3SjDITQdzo6qOAzTOo+Zs4EK3Jx3Xe6YWzmaaKcJ/YIp4OvwM696+RnRoYFPItk6hNddNAIxp1knlc3+uZwaXVVtCS8iIghupdsfjueGoyMbUN8fOCsaUK83pHqNxBuiQU/VhxqVbsfvAHpnp61tzjcXQS9eendjj3SDtQcPxkuudX7RbgkxQDCuCpwM5Kv/eBc+bJ4V+n9Y91S2RkxELNXwFRVr5mCFgkKms6qHXGJr9zzwjxX6omEXyIgHh724HO6dhFWgWAzg/5PlMPTfCrNUePPCTzr294LFLb2uXJmrEPazWkPtRZ0X4tkC2fKfCIoNP5TBy1s5GzBX+gsAPhgDrVCP65/Iei7k2of7BK+BfSXNssoMnJI1sdIgbBFCQ8YGG4w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f2f2c9-22db-4b58-c0af-08df1fcb8895
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:54.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0S3blqOxpgu3sOHAIF7JyXIj0aha/c7mqFN7ebNm07J56OLir+m3VNTgKdiVFPHM2quFYvyvKqFHMwTcYeQ12/44Ee5SNgsh9mi3Pp5rz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6QrW/qyKWfre
 FLK19Gf6aHkfdrAd2p6ZS2RBPzJY9Syeu9wWgCgTfsRbHDCLsI8sAOhaQtchmkQW+1wInUXKNWd
 Dvx2bLs1aHqzw08L1uX8USyVgUEEyXcWlF50TtQhFyARSJvbZ29gwARciFFVh6VH/tSe7elUnJz
 9RjDu+Vr45pkIug/4omVucLaCdqMtQwzPLmOh002nzwvooBjO2tVQn8Q7ALCR4H8VxipP9nwH3+
 keoAjo/dvxFkFNS3uDsqgp+JbFjFruQaRqlvPQLLebhtZeGw4APgRJIDOHy4M45KhO1yqhrzxu1
 h7Ec1iEkph9QfWaJEtKZoo+4SurUhzpEoLhtHQ5t4exgo0DT4ByNEUmpGpBYkRqJ1wt/jCEsHrw
 ltYGodJhP9zaaESLraWokH810OmkK2AOgUPA9jmydVDNuqjjTS1UbnMmmJCup/vgz0FA6S37RjX
 jcqVjQsPbxdB5guNq2A==
X-Proofpoint-GUID: PUu8IYeEBEHkBnaE-1N4IgfO9mNUx8nP
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe7397 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Ye-bxb6B3qct8UqmZkUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX8AwCxozSMafE
 Qimse4Okx8kAwUaC9+FH6N5ojfrYJibBVS2Ao2mKXuVEN/10yjVEO5W6CXNFEDEnDXuFQYsvt8q
 NMBhQCZFuX3dmrvT7sHriGBWntzSyMgjHcKTME/8CVpSlF+Pqw7V
X-Proofpoint-ORIG-GUID: PUu8IYeEBEHkBnaE-1N4IgfO9mNUx8nP

From: "Darrick J. Wong" <darrick.wong@oracle.com>

The code that validates recovered bmap intent items is kind of a mess --
it doesn't use the standard xfs type validators, and it doesn't check
for things that it should.  Fix the validator function to use the
standard validation helpers and look for more types of obvious errors.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
(cherry picked from commit 67d8679bd3913d2c4ec5f32ade778881b93af766)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_bmap_item.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 88d28a862f52..5f1c2fda8e4e 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -425,18 +425,12 @@ xfs_bui_validate(
 	struct xfs_bui_log_item		*buip)
 {
 	struct xfs_map_extent		*bmap;
-	xfs_fsblock_t			startblock_fsb;
-	xfs_fsblock_t			inode_fsb;
 
 	/* Only one mapping operation per BUI... */
 	if (buip->bui_format.bui_nextents != XFS_BUI_MAX_FAST_EXTENTS)
 		return false;
 
 	bmap = &buip->bui_format.bui_extents[0];
-	startblock_fsb = XFS_BB_TO_FSB(mp,
-			XFS_FSB_TO_DADDR(mp, bmap->me_startblock));
-	inode_fsb = XFS_BB_TO_FSB(mp, XFS_FSB_TO_DADDR(mp,
-			XFS_INO_TO_FSB(mp, bmap->me_owner)));
 
 	if (bmap->me_flags & ~XFS_BMAP_EXTENT_FLAGS)
 		return false;
@@ -449,13 +443,19 @@ xfs_bui_validate(
 		return false;
 	}
 
-	if (startblock_fsb == 0 ||
-	    bmap->me_len == 0 ||
-	    inode_fsb == 0 ||
-	    startblock_fsb >= mp->m_sb.sb_dblocks ||
-	    bmap->me_len >= mp->m_sb.sb_agblocks ||
-	    inode_fsb >= mp->m_sb.sb_dblocks ||
-	    (bmap->me_flags & ~XFS_BMAP_EXTENT_FLAGS))
+	if (!xfs_verify_ino(mp, bmap->me_owner))
+		return false;
+
+	if (bmap->me_startoff + bmap->me_len <= bmap->me_startoff)
+		return false;
+
+	if (bmap->me_startblock + bmap->me_len <= bmap->me_startblock)
+		return false;
+
+	if (!xfs_verify_fsbno(mp, bmap->me_startblock))
+		return false;
+
+	if (!xfs_verify_fsbno(mp, bmap->me_startblock + bmap->me_len - 1))
 		return false;
 
 	return true;
-- 
2.53.0

