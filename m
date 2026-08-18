Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011012.outbound.protection.outlook.com [52.103.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CD2D9484;
	Tue, 18 Aug 2026 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024943; cv=fail; b=YwWOBizN8knz1Ur97R5cIAwIAJETqjxVVmOC1xt2nFl9/I0OwE6x3qqwOGXX0vzszu6Pw+/LeJS2M6iYdgQVuj4w+snAWGhULL0uAqVjUZcL74ZlERY7eOkKLQaqKNEHiaJrY3q8UgihBYsp3hiViyqoEUre/nPrt6EA6S+Tito=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024943; c=relaxed/simple;
	bh=Y7cwZ5MnyPVweW9s8EpCvqMldu8lxFI6rOCF0ScOo8o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T7YHpbbIMy6fw2L44Vy8mpTWWRi1DStIyH2sFpEZk/A+jpoMgmWqtUcM3Ax4bIf5ymynhNwe5mITpRqYkpoIE51weK5ZY3A4vZX99awe5F5dVNSh1p75nUodOnb91p7e2xOKSd3kzcD8ExrkerwPeO+ckL+CIjGnAEKr0ER5xMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.kr; spf=pass smtp.mailfrom=outlook.kr; dkim=pass (2048-bit key) header.d=OUTLOOK.KR header.i=@OUTLOOK.KR header.b=TEiXkfrL; arc=fail smtp.client-ip=52.103.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.KR header.i=@OUTLOOK.KR header.b="TEiXkfrL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAh197ELlKQJ+oqrVqstPamuVs5WOcZrAZqqncHf6KMNHTXiKxYaofnUyUHg8z4A84d4UWMzJ0PeytOyjcLciDcSWrHrfunQ5tnaHi2tOL39nLeCqdsqDXJxlEOl5BLl6tKnIizzMuH7GQJeEb9lCCzPr8hiJe05FtEX1ZgmAs3IqX/jQhe8DJZvjvhqtfRNeyOTXNXTmCbFu6MVbXatwCg72rUa9k5Q91LAmxuyJoXHvLQsiZTETHZ7ppzhCwFANWZnlJ98QgZX3mZY2QZFMEPgbHx6HXwkDH7P/08iZKqbW3XQ1nq4/YJd7hoRhj+L/vc6QGt+HvjBsMFKVPlZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/etWbgqmrS+shIWLs4+gT0c+CPTxj5XNQzV+Cy/Xfo0=;
 b=hvcmQstmhOHGjSxPsK+LeUcomnVvB5P1U/ddGLBx04sXUaMrl+ZJS5ziJ1JxHacEPs/uj+I9xBhl7pyHlUDL+LpQ0Z7bd4kOzFU1Yh6qbXSqTFArWvCZgNMnyMsBAhaCeh8LPD0449euLjvMQndSmYCE3Fu75BdMP3ZYUVtsE24W3C7/e4qGg+HwX38+lFru9Fk2IruTDrTKzyNUYWzNxYOcSPGFevt/7M2q07RXoKU1TZgAq2lhh5nVHKGQlB5dOe01Br9+UJoWIvQvv/8ocoe1Um0NPaKiXvrj1iICgXr60APVQYbuZqj01QvGxP2zhA8mXN0Z2q12wTSUQgyOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.KR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/etWbgqmrS+shIWLs4+gT0c+CPTxj5XNQzV+Cy/Xfo0=;
 b=TEiXkfrLXXcYtSy66vfjy8bgzPYN+YfQypRjHA3zA0khwFbcp+f/CvHWo4rIJHKzyTati5xf5q6SFcSoOvYwDSAYQYNty5qY+a3FdS/blTV8hN236RbF8XVi/xQMusfF25yjoRVg3ibBUf+xvKI/q1G3+xWK8XOgkO3E0TH/Pr+pzxt9MUZ5RksrRRmS/eTTltcuJ6it+1HRjJHFM4REkyisfWaDeeYfmU0lpBs+SAu5xcnXvKC0ZF0pleEDnXRTaFQvyR0N1YV4NUkOYmT0r9emZzNUq2giStMx0Toz45a/1GVe2D9NuFEVV/nxHny+lE2c9GLIS1mdGNqjBMNwlw==
Received: from OS7PR01MB13914.jpnprd01.prod.outlook.com
 (2603:1096:604:36b::13) by OS3PR01MB8333.jpnprd01.prod.outlook.com
 (2603:1096:604:1a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:48:55 +0000
Received: from OS7PR01MB13914.jpnprd01.prod.outlook.com
 ([fe80::641e:83cf:743b:85bc]) by OS7PR01MB13914.jpnprd01.prod.outlook.com
 ([fe80::641e:83cf:743b:85bc%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 03:48:55 +0000
From: Eric Kim <seohyun.kim@outlook.kr>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mgorman@suse.de,
	Eric Kim <seohyun.kim@outlook.kr>,
	Binwon Song <qlsdnjs236@chungbuk.ac.kr>
Subject: [PATCH v3] sched/fair: Reset NUMA fault locality after scan period update
Date: Tue, 18 Aug 2026 12:48:29 +0900
Message-ID:
 <OS7PR01MB13914CB69D682A599970F258C96A62@OS7PR01MB13914.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0128.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::15) To OS7PR01MB13914.jpnprd01.prod.outlook.com
 (2603:1096:604:36b::13)
X-Microsoft-Original-Message-ID:
 <20260818034829.8103-1-seohyun.kim@outlook.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13914:EE_|OS3PR01MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: a943cda8-b634-4911-3a43-08defcdba027
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|21061999006|8060799015|19110799012|5062599005|25010399006|41001999006|51005399006|4140399003|5072599009|25031999004|24021099003|23021999003|15080799012|12121999013|4302099013|440099028|3412199025|1602099012|40105399003|10035399007|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?exJApYT6nQeI2MZA0rBKsmtbu/aZCqY05q7zPKwxDf4IsYzvMa2VwZzUlZio?=
 =?us-ascii?Q?MDZhXXo8Mx+gVbxJeIlyOPI7RGfoqqcX6zwt2l0QXT876CztQqx9sFU0NCrD?=
 =?us-ascii?Q?qexKrUpCghHDA/5MnjF8wp0NJJ26Rww6vcGMTMY05G40EbqQa0rF2p504RHU?=
 =?us-ascii?Q?Pm1GueDgsLZyAx4XdEAG478ebsRsYpfY8f9nPUxolntbiK5Imf/oBgbiICwR?=
 =?us-ascii?Q?HUep1VBoj+5A9RPrwGGGua+ar1JgSAl8Qkx6UOurWryQMKJy8W4ihIuGXqDq?=
 =?us-ascii?Q?wrfzMjbq+mLxmrZnvTnQ3pz3huHAdYFUxuPWXVvw6IJWmKYYKyoyH4GuU361?=
 =?us-ascii?Q?Yb0DZGmqYSzud24zk8hRT49c8/CW23vcZIFld7Tzcog3VwIU8gwxW7sSMykC?=
 =?us-ascii?Q?aLDKl4kcekQZBDmmZN7AXKM04K3Aic1umWVOBMiZEdvRQpdACdicA3sc03gb?=
 =?us-ascii?Q?oTfFbls2+HQUHZbPA+nRHqW0m7DcqNSV4jzBonqqERvefsHp2XVwfNR34fNZ?=
 =?us-ascii?Q?THwPxq3vw07w8+ctPXcDb7GX4hWwo35t3atWznemGVn4TzMSwop0mk2idKHu?=
 =?us-ascii?Q?Pic6gB5/8GvJrNDJnk3b8Vhpqpg1fuKYm20O+61XOXWLnJmDvzVlwiTnQZOt?=
 =?us-ascii?Q?j4dUU7YSEuEwKnskpcOpmfF9UXRIfjiJz43wVRycPEfgybz8rccB8uuNP2vZ?=
 =?us-ascii?Q?i1Sf+qScwk3hQ/OCrTblBOV8wZB5ft5KABtRfGzPwu1scHJ0sJDQn1tF+djo?=
 =?us-ascii?Q?Wjiw/LSz2iD3Oebx/AHUU0MQsIZXMV/xbdQtnvRdpyZvqZkYu83b/o3FEfN5?=
 =?us-ascii?Q?DzpCHJqSGDQc9W7ka+C7Ol3kh59uBVpSD1hxyyuskWXrBITG8iAyaz6SQDZp?=
 =?us-ascii?Q?72bjpK4vaf3N8jYoldjnm1bjCW5UGcxg3eeL5QauRnAVLezwtZe+r5wXh3mO?=
 =?us-ascii?Q?6H3OmRCMpqRamBxT+u3Jzz0BBlloG1gTQxNMdEK2ZBlwYsbm9ASwNOp6sori?=
 =?us-ascii?Q?3vonm216jBUJreroAgs5NQz1F0KGHgASf9V/PHu1OHPfGUtfq2jnRSYSi8ZH?=
 =?us-ascii?Q?ijcGCweEHSiL6hWQMGd7l0wNual0He2gxKxQ9MbfZ8Q9DLdhM8xA9OoWWbKu?=
 =?us-ascii?Q?52Z/wDv5qY6D7YQffOQblcJE0kJAY7IKLVeqRsQokQe2+E/ESNmar8+EbeEF?=
 =?us-ascii?Q?nlaxebJB0iqKPMFL6vbH7wxyJ0wOgT6/X9ZQbQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f4kiwqVNZB4lZMmcc94TuAsq7bUKgq9o5mA1+dTy2NiHGEo5aA8NVdrSFq5z?=
 =?us-ascii?Q?cxz5F03lo+ELtKjKAshA/3cWmJ4q7sr/O2dtUCqF7ITHouPJd//pGk3yQwvl?=
 =?us-ascii?Q?j59xklquK3tX83vCcN38u6MalQa05gqmbZ+aTDafT7IXF/HnyzYTSwF5cZbo?=
 =?us-ascii?Q?id0XC7geDmyFD6c/xQHnFw0r0nJIOj5ez1lfJJEt9m1gGth9EbJspfIRtrpN?=
 =?us-ascii?Q?PNTpBaLLRQC2tLRES7vBQNRDcEAirB/k7HTQxlrOD1hfN96zvYwleZbf5kj+?=
 =?us-ascii?Q?zIpTEkPbADxAvxjf+IcClHfvZSv8j6QU9uaNjLC1JaPpOig8MV+r0FkQGP5o?=
 =?us-ascii?Q?tg+UuqyJMgyBAZIPtIqTdxEQE1N1ypUBwr3x7ApIhbN7iDDGRqoY3nIhh1Xn?=
 =?us-ascii?Q?FjalZ+JayjVxv+YH8SGqmQxVRdUhJr5pUmwEGm8HkLPu5aSsnNKbJiu7P1YY?=
 =?us-ascii?Q?xT4UuTYwK8XxVNrZI2bxSyDkg13Pn3O0zkF1cCoAiQTLnmVJG2qreeE7yP0v?=
 =?us-ascii?Q?RvUjA4uISwZSdAD6X1P1J2JqupqTQb3yIm1sPmjr696Hqnv1jduazT0olGBN?=
 =?us-ascii?Q?hRK7dZANrV103Lq1E1R5FXwlmXwzyXS72B35PEpIpDdP/gA3ypLKn2/DpstO?=
 =?us-ascii?Q?oVxws5lpAHHcrJo6UvPI+R4+cK6/XLhJM2LL5JLTlvMYG9Ifbs1ml/vsRgLD?=
 =?us-ascii?Q?lXOafAPXarar+6skUCfZTa97le6Gm7x57vnZBS/zZYkCMsvsA7fPemvDDZyc?=
 =?us-ascii?Q?x16R2PfCOF+gQMRHblGr4DBQGWVufZdeSDrRZSQW6+oa24I5TkibnS2bIndp?=
 =?us-ascii?Q?QOt+4dI3HFpvmZjuVxyk6Hzyt0P1N8Prjbl94d9TbC63DsPellkMM8Bo1gbR?=
 =?us-ascii?Q?0GO17sr1FwE/ZBQagXlehtAKRlCSd+OzcNeW6wze2bL6/9qxHzsXan3whGO9?=
 =?us-ascii?Q?w7YSFH8PdSbzchVZvQPG/GuhmR9Qtm3ViYoz+mvlvMo6wUjcbF2i3YncDFYC?=
 =?us-ascii?Q?m+my3FmW2+XVdmcHHashcVRtNeANF9sFbf/MXRJJf/eYGWKNNmYMhLoBi0A1?=
 =?us-ascii?Q?QfH0RjVcW5ktFnyv325DiF5AlsE9cuGHPueZb9tr03Qry3LcjhOzGgyyX4o7?=
 =?us-ascii?Q?ki6Y/0Z8JkIEz/Ti/EZpfik7k2I+KZSEEwMMEu+9tNXdnu8P4xm0Q/oNsSLM?=
 =?us-ascii?Q?vB01OPFaYhCKiyYT1jvMUiSrkgtgRKuyz7pcSdkioKxAZUl/Mz1jAnLJuzfF?=
 =?us-ascii?Q?iuoQpsp5UY7oabh/Pr/VWSmKW12f6BTMqTKsru9tqrqXBbgy+tJiuuIpFG+H?=
 =?us-ascii?Q?Rz80Z39X9OqaQXoBEjEJ02JtJKH0tJdlNnB/UHCH347KMNjxE9GG8heAMW6v?=
 =?us-ascii?Q?a2shpUW9wUiFrz4CagRI9Ms8c5cW?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a943cda8-b634-4911-3a43-08defcdba027
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:48:55.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8333

When updating the task scan period for NUMA locality checks,
update_task_scan_period() checks whether there were no faults or failed
migration on the last scan window, at which it prolongs the scan period.

However, p->numa_faults_locality, which is used to check for migration
failure and number of faults at the previous scan window is not cleared
after changing the scan period, which unintentionally increases
numa_scan_period up to numa_scan_period_max even when there were no
migration failures or no faults at previous scan.

Fix this by jumping to the out label on early exit at this case to
ensure p->numa_faults_locality is always cleared before returning.

Reported-by: Binwon Song <qlsdnjs236@chungbuk.ac.kr>
Closes: https://lore.kernel.org/all/20250404095354.311156-1-qlsdnjs236@chungbuk.ac.kr/
Signed-off-by: Eric Kim <seohyun.kim@outlook.kr>
---
v3:
- Polished commit message for clarity and updated subsystem prefix to
  sched/fair.
v2:
- Share numa_faults_locality reset path with the tail of
  update_task_scan_period.(Peter zijlstra)
- Link: https://lore.kernel.org/all/OS7PR01MB139144C7E07C97B3F3B47016796D52@OS7PR01MB13914.jpnprd01.prod.outlook.com/
v1:
- Link: https://lore.kernel.org/all/OS7PR01MB13914DA08AC588DE5544B03E796D62@OS7PR01MB13914.jpnprd01.prod.outlook.com/

kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f15f5764818e..b067f6bcd941 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3469,7 +3469,7 @@ static void update_task_scan_period(struct task_struct *p,
 		p->mm->numa_next_scan = jiffies +
 			msecs_to_jiffies(p->numa_scan_period);
 
-		return;
+		goto out;
 	}
 
 	/*
@@ -3513,7 +3513,10 @@ static void update_task_scan_period(struct task_struct *p,
 
 	p->numa_scan_period = clamp(p->numa_scan_period + diff,
 			task_scan_min(p), task_scan_max(p));
-	memset(p->numa_faults_locality, 0, sizeof(p->numa_faults_locality));
+
+out:
+	memset(p->numa_faults_locality, 0,
+	       sizeof(p->numa_faults_locality));
 }
 
 /*
-- 
2.55.0

