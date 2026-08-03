Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387662BF3D7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785576; cv=fail; b=SmccPakJvRlcLqyC8/kS62gRl5/dC1fnDbHCJme1X1o5ptYOFv8QAh/dbZqkhMPxOtVP/1m5qEDWdwrcbEvmfWtfuujro3BD+Cnw2qWOOm+q3N7Eu1quo1eGstUL/D61xOqYfc9BxqfRjZKdlCBNUrnhCxWHLGoWIwy4AZSEt0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785576; c=relaxed/simple;
	bh=8niSpDRAUNrK5LeQAxShWD52jTTEXcAUdWo6psDVg4E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CXVLhN5Fp7GpQp2cXWpLEcxl/gRAPHkC8nTLLrlYOScIETpuH0UXDTA09M/vcUvb2qyuTNjzBrytdVE9DoVCbNRiALgl0JlnTfSY6U6LQ1lIO5HEvEdzHqjTPsIG/+J5tnE48MKAv49BHE2LhIFKG4ejIdZk5+ksUC7FePtKIXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SawlN89A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jAoKPXxK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SawlN89A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jAoKPXxK"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673C4Bjt2744518;
	Mon, 3 Aug 2026 19:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=jLPMG/aLoA0D1bEB
	T6n+cTn9DkoDgX4v2mM442sdWrE=; b=SawlN89AXvwcdSHdqajcnrbB6P8KAhht
	TMAz+hPJElXoeHcEI0oSFA9ZFMM0ATfwwTBReyqeNs1swq8xcN52+ZIUTkNRdw1u
	aZCQ4UAJ1VylvoqOKtOt8rP+uCHhFX5VF0mgrAQ3Frbcpt0Zb08U1hQs1nzb8T6t
	+SdZPb93nT0gBKcLi3toXiwkinCWhWqxSVSIReT6o2zSFQbr1GcXhLb6vUTTF09y
	JuHx1I9PwKPLqQNmGDIMi4FfczgLyryppT37plvmqtY8Zc0+8TztF1BPXkeEXA6L
	UElDRhYmpiWVDJP4f4yvkjK0Qa7XTD/m/g9QhoZzm4vgJLsRihKkPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7k3cj0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Aug 2026 19:32:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 673JUeGi004199;
	Mon, 3 Aug 2026 19:32:22 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78s9ugb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 03 Aug 2026 19:32:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2hVT33TalPgwbdd/glv5THRh5fuNHnaR+Zn6h3JNjYilHZ+Kp6hf+iaBF1VAlYACfp9t1J7xtK61M/Ib4lXLBuHS/FQhI0n2apMKbEQp6BHbGJl3y4NodPeo1aqaBAZ3onwtM7ze6xayvJtkKsE1bO9lHqazLJ5ILoh6wOyS5QM/IdOVppVC3lR6rnZbECIwAmu2qFwoExHEYFnBGEMK0Tv9FLZd6pw9o+WGPKi9Okb8fJAVWP1dudIecNQQ4qkt50zxp5LKmRWHOxi7tbli41FcnHBur7fUSjlu2PX2VWUFVjhDM+QfDhEfzy9FFYcNMfQ32i4aiRBynjEin8ipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLPMG/aLoA0D1bEBT6n+cTn9DkoDgX4v2mM442sdWrE=;
 b=SmaICDaylIWqZvWB0l3uL55CTDshLRywr7eqMpK3h4C5XbDB0qBjn9SpJgxVzyzHXDuX3W4vjLqGBlDnUbDODwsZRCIiqtZZLq7g4vmTtDpKdLPxhejrVWgwKcUEaFvVOfgYPQr/sPzUKyn1NMIZQwGcYymxJWg4tbx45jZW4lZImu9O/8U99tvsJlTl4d7eaL7RECxhKBi7RT8UGLk6P6ExRF8YM+4LVcLQFpnoR6Rp4s/VfTk+sLlq3+Jjay8tx8V7bBT6tBOSvd+EuNWh+UAJaV7hPalb20LQbB3ZLyeW/4n6jgxmMo142jAivPpKOYqYaFr/l/g6h41+M1w4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLPMG/aLoA0D1bEBT6n+cTn9DkoDgX4v2mM442sdWrE=;
 b=jAoKPXxKCUyX6PyzdkWZaI0WU8WyEzAqhhX+Z1m+h2YQnRZjoAu2bR1oLvYyjJQ/+2jieKx+kKezzrxzKsErzxocDopxkhfQcGzVJJXk3LUMAC3ICQkQy28ZlDmfbAmawRScV+tCzD4YmuqPExSQonkf9F11vEbEq+onJKj/V4c=
Received: from PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 19:32:19 +0000
Received: from PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::dac6:5e5:7de0:d399]) by PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::dac6:5e5:7de0:d399%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 19:32:18 +0000
From: Wengang Wang <wen.gang.wang@oracle.com>
To: stable@vger.kernel.org
Cc: wen.gang.wang@oracle.com, borisp@nvidia.com, john.fastabend@gmail.com,
        daniel@iogearbox.net, kuba@kernel.org, davem@davemloft.net
Subject: [PATCH 5.15.y] tls: separate no-async decryption request handling from async
Date: Mon,  3 Aug 2026 12:32:16 -0700
Message-ID: <20260803193216.98111-1-wen.gang.wang@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF00003850.namprd17.prod.outlook.com
 (2603:10b6:518:1::72) To PH0PR10MB5795.namprd10.prod.outlook.com
 (2603:10b6:510:ff::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5795:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: a946f121-9ddd-4dc0-4774-08def195ee60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I96ZOSxYMA+bUy8l7d3Nr2N/Kc2UtD676Vrc7l631v9xlncPYirdqnoFia+WVDu5IIecBCBdft2rngzXfcQYVpO51N2/ZhDzxczlIjP5+QfxuSuPJXQ4ohzJ/v0fZ9IHE9aaK+EXj1kJggVMsKxd7BtFAenXOJC4FOgyeQAhZsL0Rh8F/3eY6peZJpUfck9rOfp9e8zf00eLm27NXBWve2onjyzwIEiCDfqVlsvz3RQItfps2qe3JYpQ+6UDVHXZ99sOGcsHIcY0NnTz7K1WDzOmXzdIGnyMw9QztQjMysI8WcAxoRuIenK1Lwnt7u7CwDePH/9iMqOyxV1wAOmzwokxLspDqcr6UWiZ9Ci7iLYVpIMDhlM2Krz8xi6LhXWzkpAY36/TBC9fOSH+Rhtk2TIoq3d8YEuOy8jHvlQZ/mWm4sihMAEBfn6F2h9/HwejSE2c6WvAO/lr0iU25nfTjdcyiIY23Hgrm4zZkYwxwoyqSLTf68fScr/JiHuXvTkWUAGlBG1D+9BT/sbtxA31dzKr7YM/wszzlIaUeBCkLzMfDCRrIFkMFA658lFEabyt+V2jDGwOPZfj9Py4yQVR1x70O2CZOaEeb4bgqxczCLy2jTkaS1zPdR5k7RVrGuxDDPxtiYMKnctDDuu3H2NFGRw++H3zXC0QuwBhFP+5P9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5795.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/1Wbsaw2gM5NFzulmrSyi9oNHCW7vBUiBpp24hzJEpGOi4ZpgSSzh/ZSPZev?=
 =?us-ascii?Q?N1Sgwgv1Io5DF3buY4K3PzzTg9GQjLcOIKcTanR73DgiTuPJQz9rfLxtsYid?=
 =?us-ascii?Q?V+U0FkcDnIdnxC2PRtXJWFA/Qk1rEkEyPJbZLXlfMHw//AgFUyY+Cybeh9O3?=
 =?us-ascii?Q?g15uhtqVwDVfm+s2JdoqeV0+CoXCtu0nZm0lK/4wsACAKF0dnvoG2a9aWVYS?=
 =?us-ascii?Q?cW8LKQB14Z7SJZgqoDhW8bjO8teGO1hGLz+k0MHFLXKkbHfGdxeuKVP70CDD?=
 =?us-ascii?Q?2bo/2rw9t0T58PqFfL/PShwx1TnNIasLYmrweF+gS94yBB+L2AlbwG7C6SIC?=
 =?us-ascii?Q?GOfgJQX1zxFrSNnWJ0OOnh70jzi1KOGTpz8dUxaLFYpEd3vwjEc58Bi4ftBL?=
 =?us-ascii?Q?xOKWycUedS3wyLj+qQNAvdSG8kQ/5ow4OIuBkhsY4VF/YOHML9H7lCzvaQwE?=
 =?us-ascii?Q?2TrEQcdOqZgpfs2xXXaFYKGx66UJuUSa0nrEVUZjFGMuIfyZP7lzehaJAtSb?=
 =?us-ascii?Q?OlUHAjWSJIlvtRrGdeAZCJ7FQpyeH4VBOgYo5AOn7Y5FTIpesFbASflzX2Y0?=
 =?us-ascii?Q?BTQTnBrFZYYJhYNP8IMjdV/WKWWi8f6kUtFWHlpMZhK+8XKKbYg+ScLHk2cL?=
 =?us-ascii?Q?xo4IKPoGAeG71bm1gLinN2RDm55YtTIJLgEf6DTgF6BKDpM9s812rybDYYvp?=
 =?us-ascii?Q?7DVOZKkpM1MQ7yYCSuMMyPIIMzpPr3nvOBRtIDKvzT94FKwPE5Fya54WWGwz?=
 =?us-ascii?Q?lNNQzA3R4AZjDP0fJmBOd3fD79R/JBm6gFUQvonDHVLZtULbLFtqUOhWEcIY?=
 =?us-ascii?Q?2udE5GzSfwpfvlj8xK44Qpg8Dki0oanX8uQ5ZPurKABkGTL5RPuKHbc8VZ6o?=
 =?us-ascii?Q?9WzGx5HxIiogVDmhTpkQecH9wKO4M4bRP7btjnB69J0/UyVLfza1lKbeSdXE?=
 =?us-ascii?Q?NkOCewxKbZ5jCYUVCdL1V2Q8fIK17QGAs3pVPMxCh4v5+kUUNkze8q2AJ6FZ?=
 =?us-ascii?Q?Kvgs9j9zIIOt0LfvlNt2k56hqgLwX9IxGN53OBoRpj9vNAv7EwKWob67mjot?=
 =?us-ascii?Q?uArELouiPJH+2QmzFa8yWS8Hv14mQEMxW1H3M+dATQMAGe+HjVdYpgRbtC4T?=
 =?us-ascii?Q?CXRmSsndhCY1nfyiVTLiuVo1aXf9JMrG6NOav7nddH0ELF+49RNviAm6/sot?=
 =?us-ascii?Q?rwRrZomR1JnsM0zmBpIbu6O/yPRJymPFLhy5MBIpT7T5c7yYN9G23+OJeG2s?=
 =?us-ascii?Q?21gphLo1m8VjHVOJ4XmYwKcWp22eQHIB95if7MUcrlgCqNudQFKYnWfimvHG?=
 =?us-ascii?Q?lMu1mfs8Aesg04XDWPtsIbpX5y84v/m5E1hTuf8FeG02xJRgX68WNh3q7F2r?=
 =?us-ascii?Q?l/zHTIoJU/JIAWjiVDTbEJbnw26ze/xDZtzrPCDSE7/SSKrcORmdw7yhBE9+?=
 =?us-ascii?Q?hYBLUj2l4zJcZnsEaH6UK0DlDVh+4vclY8lil0xlhsSwIYooMuL18kATHrhC?=
 =?us-ascii?Q?n5HkYcXAf+GbN5pY2UzFR7qkQoUh/JpzJ/bh1xr5o7ZFJxMUFJGGvO8LsBFj?=
 =?us-ascii?Q?ag6Foih8YjTzErj7PV6IZrR3R/8lxnapnqzFwwjrJ0EUk5JxricjyLoILzPQ?=
 =?us-ascii?Q?v60iBCPD09ga3dPwN38IlQwAJy+6jesBPJmZv2qrrPQ62P6rcluFrv/kaw3i?=
 =?us-ascii?Q?cee3Q7EcrFwEAFtl1bUd5YzU2AmU+5b4dt0DBVfWjJ3Dw/Ure6ZU4zKK2BjW?=
 =?us-ascii?Q?nzUQuI/CA31Rt1FF1Ll7NvdIUglZpHo=3D?=
X-Exchange-RoutingPolicyChecked:
	qDDXWbSFPWdnMbGkauMctMU/J63uDdARVd6QGFmgciU9MY4SllD+QnhikNB+6RJAF8JuIEr4K6dX7EFO+s0kkU11IgdestdFg8Iayt2xEpuSuTsq59cnMeilTBINrWfqJQmSSDiT/sBGCGM9j5S+ATOZcPtOqwT+INhkSchaBGvURq4ZlXsO1DrM2JHa+U+ZSQYRm7o9Uxcwwcu1aEwUSAfoKTny4QaQmesvaBsKbOkfYBeOhmcic5c6GG5ubo0Fk5sY4wQMZdzsw6I1tf7YfcjwP8smbiQXHG1nwc6/xdSVf99OfCGnXpvwEHjdv0qdmK6NmxjVdKas+vXAyQEV7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KulUnugN7q93TOKfB9e40IMUQrG2WzC/Wpzhf0Nb+VVZutwFIxxY/3Iu3s3MzeYJgL0UJ/Bjkf/iwsF91sC/v/N97fw4nFvdBRA9JcLexcZA7B3uNMUAQbrRGBp3s28BCQDJRQOo5qlNIBrm5bDezAeWDy8K1+Onu/tEC1iWAYEqH4L/d8Xb/6nuoCbAWXdiQbEdYLt2WfU6bk6i0a/2nl7z4esyMjYEQDI+yUZyDmjh1piH+tI7+oiefDXfugUylqq+opv3yOkjfLlp7sgIN3zouFoN4vvjC6Zspq9UCCKYHP+yHlrCCZrDHxPZ/JAD3ahLa4sp+2vrrmhetL/t573tPt7V7k4lJhKs0WjHYTq30WAnDVAIpl9zQFZlQ3W8Qxq0D3X06EV/PZT5mQ1MmT9nRFlHWj5t0Z2DFHeptRuhSOdN1e/l5Sj09bp8L0GlcDSkbu95lNVR69EC5/awkAf3YFm+6JZ1nH6VqqmI/p0bZePRzLaJ2m4m00xthL16gULwtQ/+ggS3MwI/w+n7jp98ABENadeR9dRoIcyYiFdbDU7mhWkjK4OOHdwWYOxeKy4SUffsLdzI5YQRUXPAqBrhH3cubY0mGH1ZGPsPj/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a946f121-9ddd-4dc0-4774-08def195ee60
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5795.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 19:32:18.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKHbiBND3diAF8xtjhVqwmkgv9FrNDhkSJjfck2rzqQtJTKq/sTlFIuiuMoQmA5kg+x8kznZcB76BilZB3iqTxhN/rbcjRpi9j85wcdNf3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608030172
X-Proofpoint-GUID: KKMRNyW_bS78J0GI2a0T8ZoIeO7bEssF
X-Proofpoint-ORIG-GUID: KKMRNyW_bS78J0GI2a0T8ZoIeO7bEssF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE3MiBTYWx0ZWRfX5PkMp+N5ukis
 aUUWLMhMk7Muy/cZkvxYigzNVCEWNqcHvX+Zii17QZ6lzkdFgknAN5HUtGVkuurf9xJx40N6LCt
 01oKSz42ekoEtaoymGr/Miw/wp7O9di2wkv1Ch0BiaXOALufmUc8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE3MiBTYWx0ZWRfXwX4/qjGaykAk
 O4yo23OSr+8dbxUKfhdjs72iEHHSr1C5uF2tSswkkPLz2h5kZaYicxJQ4GxY4gWTcX25Sf42sTg
 EmtIWMZ7035rkq+oj60/YZGetfCgNt6eKRpZv9mQTMhtDw1NZEwtnlR33X7XNYVvxCa+u+pgyYg
 UxTl6e4RU59w26/0e2qoSJYgFNyg1H8tsJ3qAo86clF8Ha25oPlNqWSiOQWHBsKl/I4g65Q3d1a
 acObsSnYF0zWCeZwVE5IVGqht11/2Fqeg1o2znJV8ZHiAGOQrVDx8zsXQI6yeNVeCRsLlGFKb78
 XXXLhbNcxnRz+SwMoSHxtSkvwhz7PS5c6sFJ22alDtk32DFnnkeFvkhXyyojZbY0xEuj069i5R8
 KO7WEjDUkkQWSpnRRf7vk7IY9A7TiMqh9yMCjORGZad1f+XU9Tys7dRuP5/vSg+newm8PuMaMLv
 jML9CqCX170+t0mwde9Spc50I8uq46jVEcCLAd4A=
X-Authority-Analysis: v=2.4 cv=Iqcutr/g c=1 sm=1 tr=0 ts=6a70ecc7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=AeCkNC4mAAAA:8 a=yPCof4ZbAAAA:8
 a=gvVCcnFBXYXUeE-CmooA:9 a=3H0rhiSm_XezoJcgKFaR:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101

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
---
 net/tls/tls_sw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 389597bd7ae5..0cdc9131aff2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -278,9 +278,15 @@ static int tls_do_decryption(struct sock *sk,
 		BUILD_BUG_ON_INVALID(atomic_read(&ctx->decrypt_pending) < 1);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
+		DECLARE_CRYPTO_WAIT(wait);
+
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
-					  crypto_req_done, &ctx->async_wait);
+					  crypto_req_done, &wait);
+		ret = crypto_aead_decrypt(aead_req);
+		if (ret == -EINPROGRESS || ret == -EBUSY)
+			ret = crypto_wait_req(ret, &wait);
+		return ret;
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
@@ -289,10 +295,7 @@ static int tls_do_decryption(struct sock *sk,
 		ret = ret ?: -EINPROGRESS;
 	}
 	if (ret == -EINPROGRESS) {
-		if (darg->async)
-			return 0;
-
-		ret = crypto_wait_req(ret, &ctx->async_wait);
+		return 0;
 	} else if (darg->async) {
 		atomic_dec(&ctx->decrypt_pending);
 	}
-- 
2.50.1 (Apple Git-155)

