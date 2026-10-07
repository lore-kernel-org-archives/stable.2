Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021107.outbound.protection.outlook.com [40.107.42.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE53783C6;
	Wed,  7 Oct 2026 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338418; cv=fail; b=bGitdkYR8yXvDz75Enn+0Ex08YFmqUWuBM6XaWWNKZ5XE8Rf0XydnocnqHYe/h6L0Zpb4R8MJcJ3UaCLzoKeJILqH6KSMhmLlaxHkBEolX2RAQe4JZR4cNevrSoSdRhldhfLA8MvVHVPs0Wq7bOtbi75uuvZX/BcDu5v+eMoG5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338418; c=relaxed/simple;
	bh=BACWiA9jHEA+7OTwjIJsOJZME8dbBRB00iMO1wS3DoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/qBuDjeQGdtiL641oMXh6++/Ewoun+jqqWwTTLE8G5J1QYZ74tHvsz029s7NcJBpiTJZs/ntd95ZZB8ofOg6Ai8Yzhilpz6V+OKnmmM5ql6+Es9xrgIgGEUTCF2XX/RzkJ0YikSiqHIfFk/y/bYboFBw715HXKZZwDbPHo5XfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=mateMQh7; arc=fail smtp.client-ip=40.107.42.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="mateMQh7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0NFSCp6rKI4M9uCD8fVghrpCJZLyZ4zsWHCR40t/30q0sL693g0MOgQXPQfoJDl8rrPyDZm6vTFXHMABw93ylg6dHKxgYN2rmOb5ITTPOcn3cqpIx/Vk8DO/sqr73Ps7QJ3WSS9yQwDYoSBq7K2yBpeZ7sfhV5Cgg+gu9a27XRyij9y+8C+CgMSWuPVt3EqmUJ+vHiSz2IgIKQv/gIXakg2JiAwVt9a5rhkPvgNqtmc4Sx/r8eTL2grv6UBxWcdyrvVfQxE/uHeMsvOBY1DhrCu1Mq0iZUUn2n4PutVF+YGZIYry39Tg8k8HKTmCPQp6uU7lvVTwontTZG+/okRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU5lKL1LH0r0MCeEgykoslDnsnyL8b8mRV4261uz/Ag=;
 b=V/JCoe1ylM2DCvSway8Eq8oWD/vy7Fq/Pot0Y0XrmfatOZqc8I/sxoW9hiQ21KGYLl3xWZPAqLi5aVyk3roZJiP04WBQa0aZPpFnQL8xsvW3/enxYErL/wBXCIgYNdeQg+FQxvZYoP4lOEfUTVVtd7+glqUG9PEagN//nhlXlV4XI0b4ohH+/gtD/7AeH5Iks0JQzg9eFkzMuYV9n14+77rxEinKwlm2KWZ8tNSWu/DTmPBI4QA7q+6dXgRqP2GzBDBI48QT1eFrjhuMSE0ZEox0F+j1t4pupi4VLRHn/SOudnlv7rqO9dQpjXIaTtd9H1T0DqHO+I03NTZXflTynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU5lKL1LH0r0MCeEgykoslDnsnyL8b8mRV4261uz/Ag=;
 b=mateMQh7HE2bkwJ0sxToZm2KIQ8d3R1ghJ1s8CahgRaNdyLZHdmtGcqzw+IE+SsYF2pU4qfEI9gA8u3TsKCtN0J1ST5VHQm3bb66LQepSg7gv7l8jSdwpfzJwWxW2nsWZ3MMmvhIw5bSiY5lNzkbsZNh1oM7Z72uqf00C8lVWN/NXc+JpdQ1rHQKg4PGSGT4J62oNght5NWZOXsCJcnpEq6+0bDFRyEnQ43iJgvRJYRcUTIRVvdCVqVWN4bgDuiPU5YlDFWWBUJMfVVQwH2vZV4nAtuqgIpOmpTHhEqQG2zsty19JLz8GIm0QmfRdb44cohqpHD/IGuuxapKKObD6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
 by SE5P216MB118462.KORP216.PROD.OUTLOOK.COM (2603:1096:101:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 02:00:04 +0000
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f]) by PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 02:00:03 +0000
From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas.dufresne@collabora.com,
	bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	stable@vger.kernel.org
Subject: [PATCH v1 9/9] media: chips-media: wave5: Stop FrameBuf Reset During Seek
Date: Wed,  7 Oct 2026 10:59:46 +0900
Message-Id: <20261007015946.53-10-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007015946.53-1-jackson.lee@chipsnmedia.com>
References: <20261007015946.53-1-jackson.lee@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0127.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::6)
 To PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PU4P216MB1149:EE_|SE5P216MB118462:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c93a68-8eaf-4ad1-cab6-08df2416b3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	xzjzMUTvmXn5v1NHn1YwN/9+JUccKctrxwWhN35T+7FhFsNaCe37Ys7mcXh5BjgvH1WSgMCVlFzT3s0Pr1EeegO8Q/8g3nM1aFPnctQPwLfZ8U4Rk1Sn69Q46t5+OF4h+aBxzYYSiWH6yPGcVg8Ns1LcxOIQgm+CX+R8X4Z+xKvbwATc0CXgGax9QjctTfj32AcaXAloHjdnleqgbDsM5gKdtpDwdJxW/HOMx7eapqG14VAV4fee8u6vltBnRC3hz3es4EmsQ12sgoumV6LmdKP15498UWomx8SZPV8z5apg5LCHzMK58pFEvGtioqbcP/upkHQEG+SMN+jPdRayNkKR++mqMMPXvq8tQ4qLBHtQv5ZueKett45PsVYm9vY/8D6Siu/n7BZ2zUA9ARoyV+HTU1hP/CxSuWrOsOw9qMGmOhE/qKeFSydV2JgjWj3d9xfIVBCv2Yd2zJyc+f8NBJcHZPRCXMWB+fs1LCRrmrFfAHr2J0kW1oRbMMd1S1hyMeXIlxocUEfLDs+j9sWJE+SehUK4u1bGo5jsVMCkPRa+xI1tUjzLRPMlhr2UMlqbKPAg4uRZOWeSslBqF2rqcO8SScLBa8Z8MY5ZJIAFL9H4DWx11uUp63wMDX2V9EU/8dJalfKxk/s86ZjJytjTIBF6Zfoo7uU0s5E6F0e5IOnBC1YWLNoI9KzGnUpheryiCtni64nHFfDZx8+j5bed/rLWNVEeuewD+pqjok2GL44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(6133799003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQFHQEN15g/TQxCSLcvXxElwLnMIORiJL1pokqtUxrCf/gfGMevoU7jIRMs5?=
 =?us-ascii?Q?1QkmrotCcIbv43sGmxwx+J1fRG2wfxqchRM6qBQk62F4SVzLPzAFbhWELbr5?=
 =?us-ascii?Q?4nSW1qdsIMbAJfEAT4T6qCQpTX39wpV+jXEwTQK1hBG8eQjGN1Wd79ZPIfu/?=
 =?us-ascii?Q?dP9Cr+Rl2HnCnSoWUley+/Lll71Y2IxQHRQ8gFZjTLAmbEA5IhG1+l4zGE1v?=
 =?us-ascii?Q?Asayt2nKaQPzMVFzohOCI0a+s3DGAQPkB/mDiaKAO3GDm7MmrLEj6ki/3VgS?=
 =?us-ascii?Q?31mbZR3dkDiCRqwA1qWNwgc8bRymYv+mZ6Huv2E3xMCGNthl7GeJmrFDQ1Mq?=
 =?us-ascii?Q?LpilL2EQaS+lD5rG+QxR/Ngr+2eLhV6a1aghEkNyxhxd4rU68fVSXmmxfK7z?=
 =?us-ascii?Q?LBwTZ2zrYFwZt0KXhWNsuY3vvQ8H0Z3F/+x3lfvBDRs9dNxBEnWLioFSlbVo?=
 =?us-ascii?Q?16F1lrejpqEugerF/7x+S7dIgMYoIsXzwOko77Es/sdTNRIQGNynw4Bz1fCM?=
 =?us-ascii?Q?WrkqxqgUE658pTWOXt+Q9375D15cEvcBGc6Z1KG3mJqGCn0PEuvaaiQgqSp9?=
 =?us-ascii?Q?IZkoV/Ah1U5bBWSyJQ2UjtA3q8weI/a1sZ1ouRlPNUmbkB0EjVgOhRHJGwXW?=
 =?us-ascii?Q?WCcUKwzP1XgarGeBGjP1T0vs00i7NjRXtSnIFsFs87KEuckVu7iorN/pDOOZ?=
 =?us-ascii?Q?GMxQZWKuagjv0RX4KOib4D6A/NctNRu27EuzFoBa8qVXwgl97l/VE4e2fH8B?=
 =?us-ascii?Q?RCgkbWEXw+5ujmwevSQBi5PqyhqaofhyUb24TtzwqgahOaThMh3kZQetJ8Bl?=
 =?us-ascii?Q?f/tYNQiuyCrEQre4gWbL4SMwE6XD4rDMx4v6bk/cc2tr+Ldyb4B69aBWtal1?=
 =?us-ascii?Q?cvlO0XB/1KJAizb98ZaQA0eQ9q+X1zgCFCT7HaRyFt/aZ5KiDIyYTiWBlnvM?=
 =?us-ascii?Q?Bgq1QXyGGviWkDC3DpPtkOK5JZ0r+DcfVOEaMwaGRQA5LVw3B6RlFBGY0Jm6?=
 =?us-ascii?Q?QoWAbh5H9nuvNWUMt2Q8wO06jINGMyQVh2BIhnGJEwmNnixmmCC5ed+z+kZm?=
 =?us-ascii?Q?rj/1aeGhMkbdIZ8BQAntQ/UkLU9AhkAHOildwvpsmm700XXWpyiXAn38qYEo?=
 =?us-ascii?Q?WzjqPng+lQFjgzQ1DmVuROykwOKKcYgr2njKELEXBs70yqsVXHZpgYUgiEHV?=
 =?us-ascii?Q?c/Tt+R5EdPUu/Wjekr2lhysXiR+pPxbeWOXmLB4nNiBTC7bO4wyw4IwuaL8/?=
 =?us-ascii?Q?WHZXqNAdElpfU6y5nCMHyYhEIFwq7qgi/WL6PQnrUEOhGI3CCIF660yVBY09?=
 =?us-ascii?Q?YIjvTmLZZfDTvCHk/UWk0yM2ctbvAi+HuFCrDpYz+B998k2A5EZoeDWhBSLF?=
 =?us-ascii?Q?pUOolgP/24sq7ObGq0oDiFoCtgixVx0p9XsZe6o8wBNUilE6II3UiQ3g2YH9?=
 =?us-ascii?Q?sfh8WWNMJ4Na6sL0iwnuTsFbkkIXNHNAQplDPVwWkC+uHsdssi0YNXyXNKbY?=
 =?us-ascii?Q?qH6oKq1MMHeuZrBuq+2c5k29dp7f5SYt6l9uobLUpnjk22KRyU6Uld/IAsP3?=
 =?us-ascii?Q?YvZovCDorFDFPXhGY45kvAf1NijBZBdq8AZC+lbpmEJgwtmeERtosP2w/qkK?=
 =?us-ascii?Q?EEOJOd1N4m48ir+M5wq6L3bqCAlMuwJnEuEpWilyJ0L62JRlRkVPn021N2Rl?=
 =?us-ascii?Q?DuhgP6My3WePLyOwxqzTYtSyCz3NP1zIXWRQDpXz0V/U50EFtWsxsUlFUGB2?=
 =?us-ascii?Q?MtG4IBnAQKnF3jgh/8wqO5muKUWtXzs=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c93a68-8eaf-4ad1-cab6-08df2416b3c5
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 02:00:03.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdpZWXfHrBiZIla+05TOZ1zajB3Y1AV4KU5Q4HEPCXuu9PY0m0bLv+xtllnSsoo9KZF477QQbB6YmkypLiVPgUW+g6/Lcw8lDwI2Kfp8F3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Brandon Brnich <b-brnich@ti.com>

A seek drains the capture queue via stop_streaming without stopping the
m2m_ctx. streamoff_capture checks needs_reallocation which will always
be true after the first sequence initialization. This will trigger a
DEC_RESET_FRAMEBUF_INFO which will go through and deallocate all of the
frame and auxiliary buffers.

Video output can have corruption if the firmware is still referencing the
buffers that just got reset. Clear needs_reallocation in wave5_prepare_fb
once the new buffers are registered.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index e52853e89931..5b63f4f90c7b 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1251,6 +1251,8 @@ static int wave5_prepare_fb(struct vpu_instance *inst)
 		return ret;
 	}
 
+	inst->needs_reallocation = false;
+
 	/*
 	 * Mark all frame buffers as out of display, to avoid using them before
 	 * the application have them queued.
-- 
2.43.0

