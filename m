Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795091774;
	b=Ed2XyALsz8o7Ta7/f4a0rj40mPXqLFKcSxim7bm/fGOoDeTAmWkRkqk8/AVLMZE/s2Yy
	 C0lGnWHw5pUlNC6f632GAKH9bJb2SasmBeigYwIC8zxB5w0tdnW263+P0KT+v296HwfPB
	 jsHzakniLR462iyOE6wJ5kUJEXZwr7Gq84TSeDUZF0r6dq3OzQmHy8KBuPm2zaM2n7pbu
	 jZog8Vl9tbv7DRwx9mSulJSrsnHuOhZmSinUilZuKD5J+iEN2f3Xw/1NGwdr+R8mQ3eas
	 vofZwgCa1T5urrKCJo/6I0rPpUmQ4Qhn0Eit7NetRwBumwfu71EbctFJ/PYrBOEPHmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091774;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8PEMJDqyfwdasYhluJvoTbf39T0vi8xWK/99B5cGvTU=;
	b=YwdR3r6kxJky4AnFyV4V0buipzaKrysYjVNvFksvMhCeyw3KMDzKalf+eUF2B3W6KiIf
	 NoBpEeOswVaL/o3bMVaparKoDboFjTcljm/i6LW0KlwoMA3vVqP36TwNM4OcxizeNsgUn
	 AD2CzxKncOi0b/z9J0gyYkggVQfKSLazwFEOIC8hS6s+Z9HLh/p52Cm1+km5rBpy9kDj2
	 Dw1hpuFQxasf4RDC47S4sOtJZQIlF5fiX9qsaRiz8Py4HcniSmc8OjESdiySc8roqs7Gr
	 RPmAZY4j43m2To5utmLLir3FkS0DtZGXPJ/MQCbK63X/vXCYqAj8ozzPCWY5ySTgP8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=IrToMVhW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C36606A320;
	Thu, 19 Nov 2026 12:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C36606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=IrToMVhW
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBi5HW1981418;
	Thu, 19 Nov 2026 04:35:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=8PEMJDqyf
	wdasYhluJvoTbf39T0vi8xWK/99B5cGvTU=; b=IrToMVhWwdOLvZY8yRN3zQkR2
	foauK4RNKqq80dDAIw8xMLwCRqayveRTDRGLD4SlyU5hNfb4N0BazO9qgE7galuo
	wo8xbBTPBr5fyaMtMH1a53hRL6b6EWp6a7RHftcddvqiMIlToIUZWt2r3/KnILk2
	zJ88OaCUkSvARul3//KcfPMI8pFOfy0NSsqO//UU3hMbuGD6dqdUNAjsIPk/VKax
	NsJg6/nIgWe806B+299xDB2VIKi4b+rkA78EMZGYU19UThFEsS6sBdbrEazvVkQ0
	cSWSvdQEMfJ/1pInYL3i3zPulV1tN2kNYthxOBJJ+dtD/6asL2wGYAZ6WFQWA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022128.outbound.protection.outlook.com [52.101.53.128])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvge44c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 04:35:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S95RHRps8xqv69nbrp7IWo08fj8JMgY+GQDKWq4qH5LYTYAdmcnsLsFA01xo2ipefBraaxBgG5rMpRz0TgS9zYT6LJXcLGBwTtjo2Ha/q5s5hyF+8LawMErv1N1c1Y+JCUHCORcYWL5QLkxDZA2gs6D0wQd72G8xPJhwYlkSnWvYxdAxXLQOpyFuMAdsYkYMplMCDORunvXCmVWVSfnTTUfGPTKbkFYWUkPOzcw/PmjBBJXrrsW30jQwQ2kCQqmTZKx6dMu1NsCYMIQUqnJPTnAz6h0c9LPQv3wrpXghRmmjxYzJFzHik8pdfMYIptpZhJYmDSN79FPQsVNlh1Jtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PEMJDqyfwdasYhluJvoTbf39T0vi8xWK/99B5cGvTU=;
 b=KD9+6xjoS2vGjF5KZiBhMCFAvy8gPAlqy/dxK/vnO1x8AUubhcJLYCmLtdoexMY6jz6EJ9S7hJKprWgjplpHyN4qJhlNOvY9LR+w0+EQk6xy/HrAfkVMyKYsvzMr4VKSScTasm50puHatoSvMXA8QDBCSyGg5iBzm1w86JmVIYDuUHvJ11MKYTQzXYIeK/QStRUpyJg3+T/51+UuyMa7eOQVajygFXi+FGGvxw2b8jrNWXdq5pjZRo4/aWTHC0LQLrDWx3Pxq2cLLcfL9vw+iVsRVz0l+0ZxSgV3D2QAN6f0idsfBLADhX09BG6caZ8prUoK/zgAMLHgGSXWmdAxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DSWPR11MB9848.namprd11.prod.outlook.com (2603:10b6:8:4e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 12:35:29 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 12:35:29 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>, lukas@wunner.de,
        sebott@linux.ibm.com, schnelle@linux.ibm.com, bblock@linux.ibm.com,
        linux@roeck-us.net, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 0/1] PCI: Fix lspci hang when a reset waits for a vfio-held device
Date: Thu, 19 Nov 2026 14:35:03 +0200
Message-ID: <20261119123504.25906-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0297.eurprd07.prod.outlook.com
 (2603:10a6:800:130::25) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DSWPR11MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0ce93c-8734-4ec7-3e19-08df46399855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FVvoyYxHSbKQJhJPzA8HH5/tiBVfSLoV+hLeomFfRUKJagKSQb7Acpk6jeRkd1/k6F/utAyxtuy3pdaplfJSl+dNGXqMEqOI84okxciJy1c13p40BDpGPizjvEfyD4eNAC/pbvXiPFhwb1mZPmfmnxVeuHP2FckNEqXvcpGuoTX0y7/f9uvUUkz3BFZO2JkjAccqjZo7NAQm0rqkMGfn6ZR4eM9OkFBr1pJZfg2LKFJoAhKyoxPp/fZ/Uxla5JAhoV+gh/iejL3MfYTeRcZx/hmgoQrk+iKUMAbqlnYvkbtK2b8OwosDui93KlLOKa0Fy3Sip2ppzL9QzyQ7/chENSSg8OsReu8442Fw40mxCaRz1EdMYYjbgw5GZGMLNz5lBTiDNe39nEr7f42uYJD/M4eD8EBz7/UauuSxJNkbE/BFpQLm6NKIzVziK9s7AAp3NshVUsbong5r2USfEylxCI4UnvRsZb1/Pwuf1qErInQgDEhJ/o9E3Gp5oflFiYf2qmsPyDE/aDwDxpl62ifSmmnIURIP7l2kYpW83wXT1lQAqbNlApd5aXWV+4sxDHmrYijvQ751K6WypB+FceJvZAKle9nvPZ1WQat0fCXWkngIYazwQbYTYQ0rNcSbh1h81ppbQxtFuG3HH21Exc3gl43wx1YP385UMWeVAZ24IZNxKdzZ90TPnBF/wWuXdI2eeZSbxKvEvUSaDrUOSXKEojEX223dkPsO/VdEupTR8K4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+x5bEMuQb9Kl3iCKeR07F3b9TN1Cz40HaBcBmjfS8kFxDmJZ0tdaJefaV5H8?=
 =?us-ascii?Q?zz4PJxkfVeaEU5XjkneBfl61DYxTXwtRZLuMUOwlI2mUd4IckpFmd4Ec74sO?=
 =?us-ascii?Q?6ySJpEYiEeVlKDCV+its6doTexvEAABx3NybUgEVGFFvjaWNtkZWWgM1R/w8?=
 =?us-ascii?Q?+tVtG5iZX9lQm9u42augADibCm5QyMM6wJPJSfvSXDSJFdgRuGnOnov96IdQ?=
 =?us-ascii?Q?29bR+G+K1dHDzUFfRCWWSgyc3O8pV78Ksobvzyd+1zC0mGrzxOtHVmufK8cm?=
 =?us-ascii?Q?cPhNjjUdj7KtizKo6PGKyNP5583tliFUTKWEvzAhyIbxBN+NJzj75YNI88Na?=
 =?us-ascii?Q?X/oP2505Q28JmRNR1l4K8tHX1oisPvlhoYipoD1p1rYmktWNrBBbaWu0/pRj?=
 =?us-ascii?Q?hv4cK/qBe0JPO1Hmhd/mdi2hVaaetFqaSf9pB34nW9rCkUai6GXvqnAdoB8h?=
 =?us-ascii?Q?It6zI5AWcPHUMHQb+6vckvqJk5PdeuEhxTugtOHEnSwLsgIq1Zo9gkqRhCQX?=
 =?us-ascii?Q?kaTxorYptieK84H7bBMjGRahyrbj1FlE4pAH4fkSpY8cZOHWgLF3LCcEjTiO?=
 =?us-ascii?Q?fP35wJgC0+vhmLSxiPp6Xfi51qeoTAh5J0J8+bQyXxT/BpRGD1HlbjZqkeKW?=
 =?us-ascii?Q?M5LBow/WRruSlOBrLFEZJTv8361kEQkl3bWFcutU0Jl5PWfzSfeOgRWTKIkF?=
 =?us-ascii?Q?/7g/ZFJtsi63RYCLQXmErZapRk/gpg+u93BvTX0toUUafl9vFWVXldiT3g5a?=
 =?us-ascii?Q?Yj10yTD0UnLwH8YKuEfybDVXX6S8cRMzw5lzPerKNTGcXHrpUT3jf2v79Px/?=
 =?us-ascii?Q?vAEq5xiVIXglIRIojMi63kJBsym3tiTHFr38b2ShGkxLWE1Aalkw9CRO5PKK?=
 =?us-ascii?Q?oyhkeVmqBZKoB/umsMnL5BTBSi9qO50bvSGowq5Ra8EZBxsYJ1SBbzuDUYz0?=
 =?us-ascii?Q?4MBaYHhbcLl2YQZuhbCGOhwVBEh6TvqfoO0uqwNvAkycghGi1oMwSFknV7uB?=
 =?us-ascii?Q?BW0xWrGcdaoC4+MAg/mN3OBQm7yo6J0SGpR88rdoEp2ce/ZIpLFh8MIGSAVg?=
 =?us-ascii?Q?ndX9RiacnwV6+jqazmdwfv3JNZYGCUyoC1yH1bDU7zX+JfFGiMCCY936mnHC?=
 =?us-ascii?Q?n1U/DHBG3WgZ+M+LjUwmVyZBfyFA8CjCTppDCQkm6iEctEzYfZvGifmSuh5H?=
 =?us-ascii?Q?rnknLRQJcBk9B/woFNM57oy5qsRgBtu27/IyMVNWJ/g6xcIOAx2QpPGeyzQl?=
 =?us-ascii?Q?0BrictDqUCC90DpDlxU/6yt2Z+OrcPv0L64yCnnbIJ56Au6bEz44PPMPD9rP?=
 =?us-ascii?Q?5HybQUQ1w4y8rTSIs838mylChyEuieBnc81ZRgRhYaPJ0vstVrbVxNqSKrbU?=
 =?us-ascii?Q?yE9+CKzfroj8ccgUsxE+tQEsdIPJT2mu9VKMzVMPf4giLcAx2QaUfYV19+yV?=
 =?us-ascii?Q?cDG/X2/W1sUkcHFnUGzHR23YouHAIqoLhmxIcDBy3HiKeRbjHADIBdseyw0/?=
 =?us-ascii?Q?luTDCW0VlXXQ/G3+cWw0PVOmmP4/SkmrJxR0IKKmkVL2joWDJHDUHWXp1yu3?=
 =?us-ascii?Q?pv8dQUCnfQjnvw1K2wBv9ud326Df/8YnduGhvZCWPYlImgSFr2kzHVcFSOWD?=
 =?us-ascii?Q?0kSD5kT/MBIxH7R31oqRfeSELCSLbr6LmTHIT8Az/ako4p7Ns4zfLYsyHnvB?=
 =?us-ascii?Q?lu+h4e7v5eq/NWGchM3/XHKdqUqykGh8+9YOBaJiCUHERqDgQVr3W+i0V3DP?=
 =?us-ascii?Q?tyE6xVF/eqxuZjC9kEBbn37/FJuPo+c=3D?=
X-Exchange-RoutingPolicyChecked:
	Bse5wtXS8AZz9Fh8GudHYc0em1A7a01jZfMQx1IVWvPy3TxyWnPl5z6NBgoBHfh75LXhsSMuwk9on6945DSaIHZ8DehAtUy7brvDpYIF6zdaOyOxaB4O7V8fNcsChRFlGmFE22F0L9h/tKwQjjtdLyyvcFVgbJTG/TORZer+awYvxCV0QimFfWzY+ZcrvYikNck9qOqWen1PBX4dyDBwd3NZxeGtg2HnQDFYuBMr4y6VKC5Hlr6716SHJbm0vG+V4YhHeFagMfXXRGNw0MkicnVfkKzoZrtZWuboJUN3I34cq5Oz/PwqtaC8C6SQbt7O3XsnQ9F39Fle+XfyUYPzaA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0ce93c-8734-4ec7-3e19-08df46399855
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:35:29.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T95lw5T+ge1Ej+cP/qHWdmF2y+RZ2SQmJvIStfAV64B/4IiOZU+ftx+mKx742DMSXImSsdJqkSpLE7v71g2nPpm92/jlyeHTtnpr3Tms8y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9848
X-Authority-Analysis: v=2.4 cv=EudHPicA c=1 sm=1 tr=0 ts=6afeed15 cx=c_pps
 a=wiAqGZatgNl135eAsGeZeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=sP9LwdI1GJ2134apGR4A:9 a=O8hF6Hzn-FEA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX5WqP8FZPhCWz
 KdsIHdravve+07d8yExojzoyuO34zAdOeBWHgVaUzu9mcPgaIDuSqBKIArgKo8+LtsHq2G/SBUv
 gt7yTpbfpHFlx5EvKaywUdK2qqsyvXui7bEDkRiWwq8bl7gvCk78o4lQcAovDge2aNrXWgA9wyA
 4Uu9b91W+pF7H8kRwa5a5TukncWAyTkQWBouXIhNUq1fTkeEfSAF7wJi1R2ZGn0mNrW3bE5/PeQ
 OJSHQuyzL1V9I6VMG/FO9Nr+KBzywv/v7Iaoej8uR/WpQSqjf0p/Rbsd5ZMg36n+l4EuP4S5Gv5
 f/qDP1vTPNtcY620v6G2gu64D7f2ocX6CWirs+2XgDNTGl5bqrUY5Xr2ofHTs1pzS5qupmbQh94
 bTmSD36ftKyu8hx5UaAUhDaiEClnI53cb+TIaUledNfvZxkRLvxuKMY9ZcUIIwRZP9RqE8P4FMQ
 mlKZuOpL6JkZzgIBmrg==
X-Proofpoint-GUID: C_9JYB2eyu8exz9FZUj8UHjqn29lQWnY
X-Proofpoint-ORIG-GUID: C_9JYB2eyu8exz9FZUj8UHjqn29lQWnY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX1YIvoLbRxuTg
 3QBF4+tKW4Zv0YGDvpYWA8MQbx01jVeMeNJp0+rMvSyT3G4Jmhv1+NoMu9RhbjJ8jBnq+ZzgawH
 f2YaHUfsFIgXcVwcJZ1JPj9kkvv22M5Uhjan8JT+uVIhctDPXU69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190049

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Bjorn,

When a function reset has to wait for the device lock of the function
being reset, pci_reset_function() keeps config access to the upstream
bridge blocked for the whole wait. If the device lock is held for a long
time, every config read of that bridge sleeps in pci_wait_cfg(), so
lspci, and any tool or agent that runs it, hangs in D state.

We hit this with vfio-pci: a userspace driver keeps a VF open, and a
driver unbind of that VF, a write to sriov_numvfs on the PF and a write
to the PF's "reset" attribute queue up behind each other on the device
locks. The reset is the one that leaves config access to the bridge
blocked. The patch takes both device locks before blocking config
access, so config access is only blocked while the reset itself runs.
The lock order is unchanged.

Testing:
- Reproduced on 6.18.59 (PREEMPT_RT) with an Intel FPGA PAC N3000, PF
  and VFs on vfio-pci, one VF held open by a minimal vfio user (opens
  the group and gets the device fd). After the unbind, sriov_numvfs=0
  and reset writes, a read of the bridge's config file and lspci hang
  in pci_wait_cfg() without the patch and complete with it. Killing
  the vfio user releases the blocked writes as before.
- Build-tested on pci/next and next-20261118, with and without
  PREEMPT_RT (W=1).

Not addressed here:
- __pci_bus_lock() (bus and slot reset) has the same pattern: it blocks
  config access to the bridge before taking the device locks below it.
  I kept this patch minimal; I can send a follow-up if the approach
  looks right.
- The sriov_numvfs write in the scenario above holds
  pci_rescan_remove_lock while it waits, so a PCI rescan or another
  sriov_numvfs write also waits until the VF is released. That is a
  separate issue and not changed by this patch.

Thanks,
Ionut

Ionut Nechita (1):
  PCI: Don't block bridge config access while waiting for the device
    lock

 drivers/pci/pci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.55.0

