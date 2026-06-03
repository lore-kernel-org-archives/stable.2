Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55725339708
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480251; cv=fail; b=a/y7d3+8IY70SIAdKTMe7rUXHluDL2PFIKDyiTTHHoQPBcfmLDBj323XC5QmeYXPkn3R2fHW0cVekzJF+DukgMdbw0V+W/+5x/vOBAff1iByhbb9JxmlfjhzHsDjtvSQrk6kDiEYmm95Y2bhtgKB46gvha9gx830ChgwIsNtyEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480251; c=relaxed/simple;
	bh=V/oOFqjTa002n9w9RcDiG6fnglQ3Jxca0t+Pi8hAdf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJ7+WMcDXEzJAnHjDS09F+QZJS9aEu4FHycAEqBKyG8l+CdWa63pt4tZ2r5eoW8Xs5++y83Cf0qRyte+dhALUCC3wR8ioLtk/2B7nhB/ILNuiSHig34H8i1PW5l4i16ylXSLvA+0tYDumXNJXth7sw1jTpXcBQFXHgeZ0exrR5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=a6QF8zgQ; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="a6QF8zgQ"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537J1iP3578627;
	Wed, 3 Jun 2026 02:50:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=tSXRzWTsAk1jaTupGHo81LyqNSVQdeDOVQEap4X/2Q4=; b=
	a6QF8zgQYr/jwXxuPpcYk3xljFK49Al9Rf44fUx/9k7QQVvmup9LP0wThUo4AojB
	rsjEVBqCOcRXlpvoXhXaXp2MO17UDNt3lw3Mit9UiXmvlJz66mymwUAJbNllOcW4
	VCceax2YlMKefx+nvttRIkzIvyFYpe1Ffd7Ofy5hvSwXIDIrv5Ex9ajnA/Ft1FSd
	MwVW8Lh0hi6NRp6+2/KDOFZsQmAaBhxNDuHEvTMnGacxdNGF6tVKJuWDUnEoQU3Z
	bKo+2YRaQJxQs/rFHrkoL/2LMRrpJbMHjCuSbBeewPxyDjfXFug+JRzI84sm3kdj
	iqIbvG78uTrNAbq4uqAVbw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efu61xatd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 02:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+EakKWdBhZ5OerXnYqqjSbq5I51xdBEH+TG5h5F7uPX9FGVsVbtuoPX1RgmGMN3+lS3+lt/aw9EuhwA1WNIkIIvW+lm1xuQFvvXWsSReVsfu0RVp8ZDSjaQuoQoK6YwLLIq2FY9FMI6GWdf+rR1s7E+ft45r8azi28hqfUrvt4co3RRx4T87zwdlubjo2yfyiBOxQUmvZb3r1aCWcEcPtEHNM/9EuUnE7C2HSMEyNwBn5ZxENx4+4RXlDRiMtlSBq8GtHPfDjDYlolWdMAvZoholwnjB4IkDk2RZu8rqTYtNS+xM3a6sz1F7rhSGX/Cy4dUYWECXhHNH9+HlsuJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSXRzWTsAk1jaTupGHo81LyqNSVQdeDOVQEap4X/2Q4=;
 b=gQHTBjL0b4xMqcAxcDt/m75L+hDF/qjCe6JtWZtTiT8GAZP4mZjJnr5s1xJDKoPf2DboMO8tfJ1yxxGKfzlGHySd8zzy+uD0M6A9CR+5Wfa+3HQIPP1n5BRQZ5QPhu4UO8+HKoFiImw/xSm8J7CkjfPbXAj/qX/WTKNkE/DmyOow6JnmkdDGuDgPLpK16OXuwHHE56TAhkdmyJ+KVfZP0l37ievaaQ9MFCkViW5vG7H8gyAfM1uS5VomsuL7EcD0O32cnQSYQLIOTyTIm8gKA0l84t7CdLXV/opbm34lHxocdDAl07PvUFg1arsUNUUeUrebSUen5p4uUcQ6OaPdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by CO1PR11MB4771.namprd11.prod.outlook.com
 (2603:10b6:303:9f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 09:50:38 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 09:50:38 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: catalin.marinas@arm.com, will@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] arm64: io: Extract user memory type in ioremap_prot()
Date: Wed,  3 Jun 2026 17:50:25 +0800
Message-Id: <20260603095025.4121308-2-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603095025.4121308-1-xiangyu.chen@windriver.com>
References: <20260603095025.4121308-1-xiangyu.chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::16) To DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF641CF4859:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 7332f051-7d96-4f2c-46ed-08dec155913d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|18002099003|22082099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	u1exHcZ3cw6dfVmwAOw9QO93lEMnpedw4jIUpJpHo5kpgTAHJfK3Pos/4MWAqSD0QtEJrkU8TIba16NZE0bjzvv25+iKb4v8ncGoa9oFJCzCT3CoVP045FRddq6xZECqPoQH/ePHlT+4O3lfxiF+1u8jAtjfbBgJWIh2BEfsDeC7uf7IZRYkC4W0+Lj765LcHWUmXvgktaXkG0NVxfYa0SbKDl5G2vWzn7bFl872N4aaRde0ABmNOC/jPyei7fuNbP9los5zN0CqA4topm8iPQYiA9spnXW6t/FVJ7IfNQv+WjKcFggbcsBoTEmmR1uujYdSZXd2aVusDoWttf00+x7D7rhIiqeY+vyU2E/2ma/zAUsFi8SuoXsv/sGZS2ZIBZUde84CufQffTY2jxI1dxDZibpKeNqaHUsvG/ejzJnvJU2nBDfXMPFNfYN+fTXddkMPj2Qaacuys7OcR2pYFEQJ7kjifO5l4cU60EYoRu0HZA/4Jf3LxSheWmir/I36YRv73IcCbxczj9HUF8BeCHHQITKxSN9p5/qWc5crcN7cGY6iz4muhoOymKlaHF2Pk8BKD4Gx/eSrddpcpGH/L2Jk3MAKDHT/ahteAxKFr0yEjoNJpwaSW72MF3XPUGE5aB954j02ckBGUlUIlwBPvRfd0AYYKOrS61ngR9B4s6pzXh0iCV2vpRnJoLz6gG6bXnNzguXMbJn7MTu3MUeUqaUlhFACifIlAUnwBdFhY6doH2HVznc7Ycbrzfprsezm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZfXKYUcOXCzZBOdKDUHWDwKE1FZfFmwoogNsds9iekuBd80GXDDRy0dhqfm?=
 =?us-ascii?Q?EiC0SP0xTWZAiN8QC25cErJmIv/TD9Ah6Ki6fX+FUCJr0+jCw9xmI9Ra2+3u?=
 =?us-ascii?Q?fwPYlk5YQKE7mtwYb2KzhG3u6oFSg6rlTBgoINWFF3jqhD6sx/ifF2chxPDE?=
 =?us-ascii?Q?OeTx3vyE2NfrWAbLnSPEDIDE1a812NpRP9+Yq/1ZhOSG8vbMgk/0TJffSBxg?=
 =?us-ascii?Q?N1fQ6As6zpdGL6N1YHN7sG8vfh4DXS0PKoUxq34BevC9I2N5VgIE5luAVSBs?=
 =?us-ascii?Q?obWPwAMgaiUsPD8sMmckivS7cRbI+VL0ePRlVUcjmqSQDAKk51bKQRS9CeHH?=
 =?us-ascii?Q?A89zm2Y46BOzMwVTG5dHcoviC6z8dP4f2BR1UQwLMbvEsHDvVlfTrhyq2FcH?=
 =?us-ascii?Q?pMp7llg5ka3a+loR41fqGdJWIJisk/MP/wx/GGub24LmHEXOobX2UPXtXVFa?=
 =?us-ascii?Q?MRkvejIMkgLjeFmH7U8m0TPIIJxXoSr0V3Y2BMEMv4l4Lza2oRPOn4bSPFep?=
 =?us-ascii?Q?j3mWTN9BHxA0sgD/rltDwB7JLrzPVdAc2jg/uN5e0HSmt43VVTJHsL4cMpzX?=
 =?us-ascii?Q?Wz8xdzx5XFtg69IXE43xBRpl1awlNr01cU3bHVBKtKu5Xp+loGWDctB1CeBO?=
 =?us-ascii?Q?CFPy23qW0wPTxVO0VOq0LXX0NKhxkH7dFVUQIqsW+ncNXrfYUT3lcvZ1Opc5?=
 =?us-ascii?Q?AnCvTIS0GgSOHHrBdTr5sGPoVFQjEXpskLsXGdCDgcMickxIVveQFyBlRFc8?=
 =?us-ascii?Q?YW7hbSMMrsK2PcgP2anWO94oNMiUyHeGvDqVsLhRD/BirNOseloWdpDirF2a?=
 =?us-ascii?Q?9jQ4UJ413ttGhQxooFCjvXb/NZtv4yV4AuFrKB+FvKmnbRTMl3IvGJuX8n2h?=
 =?us-ascii?Q?iQIIhxSXalEJRWbiEFijXer+Gc7eJJ/pJ7Lo8NIEojAOU8tvzX7p4MNA0ZNU?=
 =?us-ascii?Q?1LIEMGYjBU6dHxMftvg3MFbi6CfgvI4lPVcGCHpFwc/yvQVJogtnvikssTzL?=
 =?us-ascii?Q?nzY+KkFTGyxvBAUKyKjQQvt3lBHmcysS2egsHCWl2TPMzbYLK+R0zxhCxSZb?=
 =?us-ascii?Q?6mbqFhy5e4OnnwfKybe4L92UEF/golGYJ/faCmfCMr/mXkruTBwD67YR0Gsr?=
 =?us-ascii?Q?yLGNKoRJLanJCfpQMUTvYDHD+cHJyp9sDienfKXEGpNCPMQjfI/fMoMg7w5Y?=
 =?us-ascii?Q?fNb3z4oKClNsTB1415uTN/kKBtXCHDSmUQkS6q7fS5t0Zb5t5rL7ao18trjw?=
 =?us-ascii?Q?qeV/dSDDW2jaWvjgjGQx9H4EaZT+TykGBVBPYW1k5DZ04DMAhR97aXNcnG6x?=
 =?us-ascii?Q?j6fnimVywUC76f6lHv4LtrppQ66iQjY1VCgs+GV2wixGSvzEZrp9KT6Sxbha?=
 =?us-ascii?Q?mH+lYBYzxjVBeiOjCNUKDDLFFPz1uTL08NjAQC9wKYRxqpErzn+nzN8tYrkp?=
 =?us-ascii?Q?snZ8AQngdxxw87O5uIzPKwSEAic5dRKt+7+synbrwsKJNnz4tgXuDMGyFqLf?=
 =?us-ascii?Q?XBkvYjOLa+R4lU9zqmQ0SPwf0qQXAllaxqs8YYvFKakWHrWrK/HGRQ4MTOqg?=
 =?us-ascii?Q?MfDni4Zs/V+/upKbYS0KDGZ+5LgjYGsAE20/YUFDLxUJPnqZ2jBz5EG8RYeQ?=
 =?us-ascii?Q?uuQIM2UySjRRlB89eYIoZBpbpuZwoaeLYKst5f0xeI8dL4gwnBl+6qYxA/F3?=
 =?us-ascii?Q?fy4VaQjnjGSQIJLlk2PB7Nbk6EREBiuootJhxLlEwfe5uwrDRlI56vT97JMF?=
 =?us-ascii?Q?cgyJQaWBb52DtNu4ooZpyxw7dOT2Q+g=3D?=
X-Exchange-RoutingPolicyChecked:
	nKqSao/+Fi7kpu49qSdrqI3LboCfdgvXesEQVtJHi8YSWizrlrZbsZ9hD7MEldL4dmy8T23WW5nLzWW4avGnbwVnFmHt8GIunj9dBa85Pwl1pJB7dBVBLFLT62lxcLdDkumqM6qEGutkPpkEg0VDgKfZ0l7tmLe+p5VfMgqUv2bEP4WQ0xqBSt25ZxIZccfdvkVBaWcaE67NJHWkyF9k0ZfnpjGphAI/w2DxYuCC1dhGInOXwYZAWPHPUcRkLEpycayMI5ovbTT5pPympMd6F1Vym/kSFVoZtrPh44p8GzdsxjJidUfEY+Ta2Wi8ucyawnaUrQ9dgYNGjQydYVPmrA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7332f051-7d96-4f2c-46ed-08dec155913d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 09:50:38.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsv83iy99AN1vPA9fyr57WBJaU9aWVFVghSL3gYP6MpPreWGuuFY/GOq1NXkeiiszXWaT8AM200GlCgHIRv6ZOqzkJXdp9324S2l/BbCS4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-Proofpoint-ORIG-GUID: fcXi8_9qKNJ51ozEu4lJXWWSgTzEQXl2
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a1ff8f1 cx=c_pps
 a=pvbKGUK/Si0pumwNLfsG/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=7CQSdrXTAAAA:8 a=t7CeM3EgAAAA:8 a=u_DS_tmnzrvZF8H0Rx8A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: fcXi8_9qKNJ51ozEu4lJXWWSgTzEQXl2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5MyBTYWx0ZWRfX2GYSXSoDALL/
 mZM1X/xX7gjlo8+826gvNrrLs+ilgemncfm2f3CxKOKg4E7eC4DSztvFhv2NOB+RfGqSo6QVsn/
 sEO8FUJazLepF11k5vjeatf3EbluXPI8wQI7LRgJ/JWCLzBIosp7QZqEbcg56Gq1YGo3hLmgak1
 MZUAme8uuHgaYwYreJZoMGysC9rj9gWTUR4qWoDZIa+eG1Fq5tpqLMYDlwAo/b1r+37MeaeSjf1
 X2THVp+pLhHa86qj4wA7Rqlf69mlUDaagCLr5rtYUciSi5+gBwkgVxvG5OdrWm/Hv81mZIe+H4R
 B6+y5WMcTAJJdyRooaV83ZgkRy5mASdBZCCM3GaZtdH57coNk1QwRoKAt3wb3CvhzlDGCwYSz7K
 UZuSF7k0UydON3xcvr7wo9aXgIDuF3cA3VZ4cTf72NNfnOWJmNYVDcvTBKXNd6U6EymuBoWdlqS
 RcluesQ4BpyQzRLxBHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030093

From: Will Deacon <will@kernel.org>

[ Upstream commit 8f098037139b294050053123ab2bc0f819d08932 ]

The only caller of ioremap_prot() outside of the generic ioremap()
implementation is generic_access_phys(), which passes a 'pgprot_t' value
determined from the user mapping of the target 'pfn' being accessed by
the kernel. On arm64, the 'pgprot_t' contains all of the non-address
bits from the pte, including the permission controls, and so we end up
returning a new user mapping from ioremap_prot() which faults when
accessed from the kernel on systems with PAN:

  | Unable to handle kernel read from unreadable memory at virtual address ffff80008ea89000
  | ...
  | Call trace:
  |   __memcpy_fromio+0x80/0xf8
  |   generic_access_phys+0x20c/0x2b8
  |   __access_remote_vm+0x46c/0x5b8
  |   access_remote_vm+0x18/0x30
  |   environ_read+0x238/0x3e8
  |   vfs_read+0xe4/0x2b0
  |   ksys_read+0xcc/0x178
  |   __arm64_sys_read+0x4c/0x68

Extract only the memory type from the user 'pgprot_t' in ioremap_prot()
and assert that we're being passed a user mapping, to protect us against
any changes in future that may require additional handling. To avoid
falsely flagging users of ioremap(), provide our own ioremap() macro
which simply wraps __ioremap_prot().

Cc: Zeng Heng <zengheng4@huawei.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 893dea9ccd08 ("arm64: Add HAVE_IOREMAP_PROT support")
Reported-by: Jinjiang Tu <tujinjiang@huawei.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
[ Modified ioremap_prot() parameter, using "unsigned long user_prot" instead of
"pgprot_t user_prot" to fix conflict with generic header. ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 arch/arm64/include/asm/io.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 46d9f3f82908..8fae8746eb98 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -141,10 +141,23 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
 
 void __iomem *__ioremap_prot(phys_addr_t phys, size_t size, pgprot_t prot);
 
-#define ioremap_prot ioremap_prot
+static inline void __iomem *ioremap_prot(phys_addr_t phys, size_t size,
+					 unsigned long user_prot)
+{
+	pgprot_t prot;
+	pteval_t user_prot_val = pgprot_val(__pgprot(user_prot));
+
+	if (WARN_ON_ONCE(!(user_prot_val & PTE_USER)))
+		return NULL;
 
-#define _PAGE_IOREMAP PROT_DEVICE_nGnRE
+	prot = __pgprot_modify(PAGE_KERNEL, PTE_ATTRINDX_MASK,
+			       user_prot_val & PTE_ATTRINDX_MASK);
+	return __ioremap_prot(phys, size, prot);
+}
+#define ioremap_prot ioremap_prot
 
+#define ioremap(addr, size)	\
+	__ioremap_prot((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_wc(addr, size)	\
 	__ioremap_prot((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_np(addr, size)	\
-- 
2.34.1

