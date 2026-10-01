Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08089526A90;
	Thu,  1 Oct 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866331; cv=fail; b=MZNZmJgQJd1LRzQqhG207eLF9ZFAsVHpkfRToIbwGQlLFbYhxUbPzCl0twna1mgpfUFMMYJh9dTLlhFQL7VPVFdBLGxW9SNJFWmT724GfByCaxzoAhrhfqwr+Wu1gJfsWrAi69xd1F1SraLLSHA+WEqt7ztk1Xr2EBnhKNj8gig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866331; c=relaxed/simple;
	bh=sVWmkQpnSamFICjzTHirFzWX2GL+xyGN0QUorn0pI8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VfWuM/hl1BCmxR1nxQ/yc8Cr/8Pq1n4oILCOHSUi9jC5UMNUaFnIxJ+3sFURUWPJkegEbl7+EW+FIe7ejwrnyimieFkI81mlbXG9v7P0MT/buI8v22ge+fmpwJ2KtglGkZcSEkLEMoQDxIB0sl1j7OrfYftsqZXWW4hwi2RRdAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mj+viY4y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TKZb5KyR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mj+viY4y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TKZb5KyR"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMWdc2256758;
	Thu, 1 Oct 2026 14:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zkJdVjjSPYeTLy9oRrfoDJaIKRF7Cj8+A1/T9Qpcz7c=; b=
	Mj+viY4yxrmAuOaVtk8LbKBWZAozfkmoiuTFlOHyOG+lFz+la+7GUp3oMQubXCwU
	+5oBi0N6EoKvV1eW1qPzN/guoi4pvU20U8ftJpACKx5/sHlcuMjWMssgcj7lLXgo
	AkvBQxSNnHx0WACQ5cpppKFzirY+neGxBJ94gm8+FU5LTKbTbMgHvfcDCY//pn7r
	l3FOMkaqRFHV/OGD1xoy1m1DJKR9pIofiYMW2/5mXpsViqBefKksIq3lcemTh+A+
	5sjEpVDfljqcLm+h2pfzyOvp0W9UlvXtEuxfxu6E+A9cpvzrYiMzqVVZE+E3QztN
	71xNzKUICUaTYGDOI6xm4w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpSc017280;
	Thu, 1 Oct 2026 14:52:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey04e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfhzYbMwfRaoKG30LwfjMiLL1GBMPgMeI9se0/T5Gskp1fIQJCbbaVw5kqHXY5dsRX6Ggajt6KIL7bVZRH0HJVrh5Eqs4bJbsKFZfVebbELSAe15JHxsknod6qenhrDMN1BYZRIi4c6ffNrvHtGZNGCXmtpnuhh2yy1GBI0IcX1eEka8cmjOezhQXKwG6bAwsG8el+gv1RuTUho0fcGSqaLOjUVvFuuFB9SWMPcy6QCf1j2naLT/TppIC53MYGlZqs5llxcQB/I4qUXh2h/5aWddtqbq8qfBFJysY812G4h1HlYiMH1auYzZMJfd2ND/vUwSd52vUn3oxYB18bdEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkJdVjjSPYeTLy9oRrfoDJaIKRF7Cj8+A1/T9Qpcz7c=;
 b=PRRKIMzQ39BqnLb3l4DSibAtp/exhAiD5s6XlqgZYFDU8bGMj29HxOH6HfYwCfKqw1Uz2fpVJL54/9vhc6LBq7DvNY5dwZ7H6obfYFfEfK8UPyFYrl2Pd4oFV7nDhqkAyMNRXeCbjqBWuwyYkgAdaXxW6uQif1Pc3XEZZyLS7yNS+FVxoU+xv00Rof5VOQOaiwP6l/ATA3t4K1W7yg3sQ/K0+4CsI30ku6Y0asuwX5cjr4HGs9scRwF8GzzjSI8RUtjc+HpQDQ6HFMAAYhzNuoXJLFH8xe6unSmYI6+Br5q9depLEG9J6Vcigk9CdyudD1Q21JJcR8M7Wqvyb3nFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkJdVjjSPYeTLy9oRrfoDJaIKRF7Cj8+A1/T9Qpcz7c=;
 b=TKZb5KyRH2ChRJyPXjBTGPq8n+VQ6XXF2ksthzWYJYj9UVQZf5YoYBhL2PgsSy3+q/rbEdeRKVQfTlon0CpdHlbEXSbbvZhR/4RswfSqvseafoj9/Xex6jG6DTE3i9QTqz9jA4gRELwpAMM1rFo6MfaIHC5o0e1DBkiCCJv/v+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SJ5PPF2BC420A1B.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::797) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 14:52:00 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:00 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 04/11] xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING
Date: Thu,  1 Oct 2026 20:21:19 +0530
Message-ID: <534a5483e567673b67f2de37764b36066a293b99.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SJ5PPF2BC420A1B:EE_
X-MS-Office365-Filtering-Correlation-Id: b46be7e2-da3c-461e-95ad-08df1fcb85fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Us5izgy3nGzbdPqKJdbgakUuqBUNXnTTZTWYPfqtdEodiTSFOVL9w/bOgCL4w7kAsjvq8IUJl0SqDTjlroRVW9DJdgtiOdCiex4LGBAqlkMXlFDl17kFkWfuItSUo+q/VctuFCVyeDWHiZ+4ALEohlrtP6Jmp9eVJISQGsKpBHaY5Y1KYwIAJTcfUnk6SF/qT/dlVVqL7bH255xtP3TWsIDL1nivegbsU2StJI1D1KpCGXvmJ1McfWyBDwuGkoMcsI9WLanas9nX3U+78nCH9WuvWBtn0wluiJN1yljWNoaisE5icDoB9hyZA+ypIGBgM8yXLt7Vlq1PfInQEumHrbFW/PuordDF3ARCCH62oT7GLduMnc/TnUIX6M/4swDizd2lz56TLkJe98Q3Lz8Au6GFEwy7U0ov7mjc9Xy6lUcPzvlwbA/ilIaraIEfW67J7fH8iBS9U+fotJ9EYvDJFa76lqQttkGsmmeJROO2cdXfKNe39RSns+4NZfgh0fmCNiSWgirjhmCHpX8litnTPosn8IZ33gAwgjNFCNcz1S1u2S1120i6OUxigCQ5Iew4wqkZoXhlgsPedqFX9+4YWpw7b7hI0M9WcvvxWndMMkV28AZisM50rG66RBuUk6PNiaXSjm73jaQQu41nm/AgMXqId/FeoPjw9/WY3GR+wvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QdXN101MBwIwCNyAEyMDK3pyz6zQo1iYllUAMV9NPWr3NrL+KNPH6luPITgr?=
 =?us-ascii?Q?+3E56ZFhkSQ8NRXJbHaGLEjWtS17sblUErQmogn6qZWooYCexXuSLFgLtWtx?=
 =?us-ascii?Q?jxr2CaehmH9wqN3OXG/n9je5CSR8glo1LzR2THB6gNVMvcGIp5zxasvN8n1V?=
 =?us-ascii?Q?uarCXeT3v2iu7y+WqL/Y9nR1hqM8MHVKgp2cL9ue8p/B2GwY6yBjCqtsNWdY?=
 =?us-ascii?Q?u8L2ibvAz1wEA/J2XKZub3bGNprRJQrnDkff6BNQVxEhBXKIJCTixbUYJBqi?=
 =?us-ascii?Q?qOFUIWxG9EbpP5foXdgE0mppZLMDk0l5xOvVIJdA1x3h2HSTQWz7wHldmmuZ?=
 =?us-ascii?Q?D0/N5SH0DlKyObYOCou05fAkqgi4+17JD+RhIDppdy3O//4HbrOFOQqr6ao8?=
 =?us-ascii?Q?yOvsEYS4TygfZh/K/qaKgoW+SyvFqmH03h61B61z1W0rEbzqX1/JhQfUDi9h?=
 =?us-ascii?Q?7FvJTam5sDKYyLWCifkWxc74dTPuwaAV6XDR36vgiiDSara6ZsJ3qgxu9COW?=
 =?us-ascii?Q?6lPf4cRF7bXcZ1+h78u+3LAy6OoMFLDXmrbJuFfzuv19yb0CA57ijaDOIiZW?=
 =?us-ascii?Q?gVQ6uspyX8y83LOo20Hk3/rEyGIa0ZesFzkAuhl99CP//pLsy8fqTusRfIhB?=
 =?us-ascii?Q?s0TJ26478o6qGtAgrrUPsqsqWn7llTFejHcrQ16yY4HGHnQWKaDgH/XRXVaw?=
 =?us-ascii?Q?9ofKHEYswfdqBmkHnoAF+npURowN95QRao45a9QaKfdElO+nyu8jG6vuB8HW?=
 =?us-ascii?Q?cIMkwdtWdIrcG7cSqV5RHQYT3ZyvvyfVZCSdVG14V7SEGH54lV0HdDJSAVt5?=
 =?us-ascii?Q?lSLvGpMEFn/WBeONrat9HhaP54/7WTVgFEdWvZ4M9sRV7UWtVZOe5JN6UoRz?=
 =?us-ascii?Q?j78ibXZbmBOn1J6kEYd1eGrkptlCQUxm8yF5Gv1dAenkf868Amyeo8IygDkA?=
 =?us-ascii?Q?0oovIHqPNysHFTze6yfPdxcR0Lb/ilf9zigNk33V1Enk/+mAhMFRm9kia6J2?=
 =?us-ascii?Q?2+FL+iak5Qxvw531DBTpanQ3b4UC619uB+osaH1XxvfRXEnHhs1KqL/JkETe?=
 =?us-ascii?Q?4/vJAE44R9FlouMJ2Q4vaO2io/D/xbps05wzzh4kXXNBW3S35iY3KF58xXbv?=
 =?us-ascii?Q?RmUKIAovR7AvNoGX0+G2ssOZOGf8qduv9EnFyUnuZuB2R/wzeeCQahpfYpp+?=
 =?us-ascii?Q?bK9qEp7cmrVfN33UnLVwmdP8Okx/UN4SQgQ/S1TGFIY4vbuVR3sNTPirTf05?=
 =?us-ascii?Q?iMZ6YE2EDuOBds9+Dv+tSaTzY05U1FneSLEi1czVsHrZLJlHhDKsOpz/RGmb?=
 =?us-ascii?Q?9ayqnAqt1PkmQcmmTJC3VT1yvnURrIqN40RgTlrLL7KHq0jjccWHYAQRmVXm?=
 =?us-ascii?Q?wwfQ/iIj1Birbr8NYPBiuSnFK6oj60Y5QU2yedYsf8ymnyO0qw2GbbQFhsqW?=
 =?us-ascii?Q?DKMXojQ2eXrXUjOO0RXH4iZjdBpsRW9QMTmUPEbO50iRFA0ZEEnIzFIgXcFl?=
 =?us-ascii?Q?T0Dm9G6yQ2oRd4V/lTkxthuCJAK+aC0gU1Gjndk9V1SHaxxvlv7kE+w7Q8yJ?=
 =?us-ascii?Q?Aswto4pRt3RHLmQEg4JZnYWn4jKhW3tidy/J5uXNTcNA/AGxwy8kxxT6nppQ?=
 =?us-ascii?Q?37FWF22rzYlQz7UYkkvR8DC5DpbEUb33YIleM80IoTkWL7gUyc7U5tTgJpud?=
 =?us-ascii?Q?N1Nsre4ORPqdo2Uk3+cjHi7145nVJuecNzsfylrDCuckFNXa8eH3N2Nj18KN?=
 =?us-ascii?Q?B1YyCyIfOLhxmdRYvQ4JbYfUhXABhWkzOIPgAU8gUOI+4Y2pfWPzRoCbpjxi?=
X-MS-Exchange-AntiSpam-MessageData-1: F11nNro0fuVhEDGMvOXKGpLMfqxwgyBcT00=
X-Exchange-RoutingPolicyChecked:
	L2WelF/+wFHs2C7FrcHeIjQa3LbmVApIRgeoRkMwVxt5R6mb10QHUAw/lrqACncuRjN/T751hUYjHPS4QjF3KQoM5w1kPEgs6Diz2FSMRl4MJeZ5Topo4crh/L9aSSz8Tu342xwdsjUKrHYZX7xkO6H2kPf1i+U/aZCTE3QcRAmU8t/IlE6Qo5wYDGkx5ckPqFrsk0mMvCsb9C+qH9uCW0hDiUqLNUSJGd73i3VB16y7aiNDjezuMwBHYovRt+Pwp0kMAV2ksWHXK3pYkewPD4mcpPr8gC/cfGP2EWA8nV5xXT5YYf2oGFdZzv2+efrLkCWhXhf3Dy9XbWbRwYP/3Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+ll0iT4bocuSCzYJ+HaP7jOpcx12aC3vO0z0o2Tf7Y+SGOnI5KCtMy8+K1K6g0HH+ADcZWubE/gOQI++UAhH46ADMP20DB1LRhybmeqpncSbuNTjdt8v9A7frcVGnnBOa5ZACqLE6IX2kXSMnWHFVI/X66df9OyiYYhc6fYe1kGVo99K26lqKdvjkR2BntjoAjrY2tlP1KdDrLoM+U+QAZ3iftpB953juivfYLMMXYFPtNWY4cNQnikMnnfrP5QC9fMONVUHn5hvvU7V+9jW84yAnTqvayJ2f15Stt5ZtmicM0/aDQIJUNN5B+31YwsJQ9VBhaJOWkFpVfS6z7K/yr6Bp4qH/Ec1I9isGI1/eQmGeZPHfi2Rfbpt5qRCnkZyU9NlBOPDOtVh4dMhD9q7nVKvwN/AkQsB0mM6xUR6/pNRBLt6CR5KFXSS3CILwyz6gkKOvxoxtMIyZGP209lGkKyB/k5LsR/lwDUV4rLHWdLFkbwtaLlXZVJJ6u3697UJLm7Hzj6IU5eisw9YER/8mclV7Oa0IlH9QqwwImuDmjsqUZCqzfvD3lUgyy+GCTOLGkq2YIU8hXPn9h3qolfCph3+9BUDPLNhItFWyCaMjtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46be7e2-da3c-461e-95ad-08df1fcb85fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:49.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLo14vUmTb3YxMO6IKpibZ+jikKT7AiPYj/8q+jh3rOCyJA1a1jmk7VsiQamHtD/Fk9YGHOEpkKYdkPFAJsMz/Nbcs6EkguMjCtyiMu+GA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BC420A1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX+7pcQZ+fE+4H
 f5FRD9B2sr9E0hOSIiLgHYlBhTiGSw1Zt96rU+Nkz4xA7FNTYimn4UbyzSWHZuSJ3lfTSPrspOv
 8vUr/XWeP1QFew96MgI16O+OYkExXpvzAqSxFbtNIO/wcZljS3Ua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6F8QCggEFlvB
 yL+ZcML6u20E6OUmqnb2rf0Ip+q6UGE9s00hOe7h2Kr74wrq+lKy3CcMjmBxAYB/OAYGGteCOpP
 +IrYofabTq3tHNArh7PIR/Mq/HFTszr3x+7v3y+ncfAZnywQHxulYDyKNSdVmE8woVW344yWuNW
 kGls0YldFivVk2sKWjU5IHKwu6FMh0zX89tI31yAN5ees54I7AdPy2Sk0qCK+yYH5X7IUtyo8nM
 7EJY/jylRjx1Y1bddyCZwmKVeQnYygdjuVNhZhPzC4x/wjDQVch/Tc0EgOJy6F76UqWT7DB36rE
 DgE1g0+gETXRvV8XKkUI6CoFR0JhjPia8WIh1u1qS5fQ6KWdxQqRoqJJKA2b0QeOw8O5aETW8pE
 5TYNCsolHPx3bMggUD0k8OIIB/nI1NZmkecAolMQ4o2OOfzPBDAxAhjvTmuWIUvEAQttJIjQAM/
 TcmRJX6EFsMwKnEuwLA==
X-Proofpoint-ORIG-GUID: eA_d9iRDYEUtzeWVzgoiWhQh0A0d4t3l
X-Proofpoint-GUID: eA_d9iRDYEUtzeWVzgoiWhQh0A0d4t3l
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe7395 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=Y-dKFtfkpH2uyWHDAdsA:9
 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 52f31ed228212ba572c44e15e818a3a5c74122c0 ]

Resulting in a UAF if the shrinker races with some other dquot
freeing mechanism that sets XFS_DQFLAG_FREEING before the dquot is
removed from the LRU. This can occur if a dquot purge races with
drop_caches.

Reported-by: syzbot+912776840162c13db1a3@syzkaller.appspotmail.com
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit d2b4752119ca629b175d599d9a68b90ae010abfb)
Stable-dep-of: d62016b1a2df ("xfs: avoid dquot buffer pin deadlock")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_qm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 792736e29a37..ff563c544b61 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -422,6 +422,14 @@ xfs_qm_dquot_isolate(
 	if (!xfs_dqlock_nowait(dqp))
 		goto out_miss_busy;
 
+	/*
+	 * If something else is freeing this dquot and hasn't yet removed it
+	 * from the LRU, leave it for the freeing task to complete the freeing
+	 * process rather than risk it being free from under us here.
+	 */
+	if (dqp->q_flags & XFS_DQFLAG_FREEING)
+		goto out_miss_unlock;
+
 	/*
 	 * This dquot has acquired a reference in the meantime remove it from
 	 * the freelist and try again.
@@ -441,10 +449,8 @@ xfs_qm_dquot_isolate(
 	 * skip it so there is time for the IO to complete before we try to
 	 * reclaim it again on the next LRU pass.
 	 */
-	if (!xfs_dqflock_nowait(dqp)) {
-		xfs_dqunlock(dqp);
-		goto out_miss_busy;
-	}
+	if (!xfs_dqflock_nowait(dqp))
+		goto out_miss_unlock;
 
 	if (XFS_DQ_IS_DIRTY(dqp)) {
 		struct xfs_buf	*bp = NULL;
@@ -478,6 +484,8 @@ xfs_qm_dquot_isolate(
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaims);
 	return LRU_REMOVED;
 
+out_miss_unlock:
+	xfs_dqunlock(dqp);
 out_miss_busy:
 	trace_xfs_dqreclaim_busy(dqp);
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-- 
2.53.0

