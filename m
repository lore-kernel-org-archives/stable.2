Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202154;
	b=KHg1VQ2rgoksScIMRMoRgzxh5Mutro5ZprlxKUFMOfHTiHJLOgR4tjOitZ0PDVUIJQNm
	 toag/jkLXQnJWx8zB51zHWwoRJKx1f1hldVxOo/ZC9BAz0Q9iAk4K9dMRGbkzdOqZgRX6
	 HYmXL3U3/aFw3zDkI5+R9DqZiQR8O3G7x1MkxWc1chKIv+fijkUe/kNGrS2MNkqahFtmp
	 4zu11b/CoXqOMEe7/e+1QeGucYRW0+bgorALRgIpIgyGLRxBa2Rf751MOOPyYT0+QFJu5
	 vdCvkd7ZGhiu0rH4eEPUNmsuHMa0yMOeBWLSs05rQO3D0DBwLLppldN/0irJSuOCiag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202154;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6uZ6qDkJ1fjpNJtFSum8RB430DpKX72/PPud6ui0ytk=;
	b=BaUJbJUTFALoLX52Rc29kZIk0xp8ph5KO5wVLIoOX/IcgDni8nZNacLZ/bCNmN3eQB1d
	 2iLnwsbDTj7MAz5F9fkf6KznOjYWIk8hUilGLl0F12TQW0uVUfnSBtkGEz0whz2z4DOD8
	 /Dqn618X2HQAFxrhAttigcPvIIx4Q8hTdJHKorNHeXamID5jSBwSqYlDyaW5ZRx80733O
	 K+a63QZzeXsd6B/f5i0zqItbK4j8S23rFrZNF4WDoFcP/qt7n4t2f4aAZoW/IpcEFtZV9
	 Z3eQw3a/mUs5aODVKEP2lWhUycdbnvj1vzeJUgDO0wpEXRoglZva2ujps/86jOTP87g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=iWx1Y3vZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE2606D836;
	Mon,  9 Nov 2026 05:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BFE2606D836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=iWx1Y3vZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=um/FeXs2K6ve2MPvx1P5cpJsfnz1mU+OL6SGJOlSu3Z4tP4PT31FJyafG0duo0AgfXdlo+vfChGxPHS9/wC3elUjtp+Mw+DjtPV/m9xjJ7Vwack56cC1zo2Wxa6i2gQzq2TrsAhOa1SI7LRYl4iETDAeyXIn+WsutKFgudn4cbjaMFJfkiee2nZstBkaksKbjXLExs1Vn2m4epdo1IcVk5uf4Vw8ch2tpjQRaD/85+A3ndJKb5XjOMA+WGEQTNafTqt1kE+PsPFwcxfLjgxqoH+zuphTRcvgAXlDYCcJWUNA9HDx0Dm9ZIoQblaLP9F0T98b6nOyr7vg385htG9QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uZ6qDkJ1fjpNJtFSum8RB430DpKX72/PPud6ui0ytk=;
 b=ugyWxl6acznbTARYHm6QXfwC4DDDkwU6sbib2kPupPiAEdXp1xgVUciduM+iPzO4yTxJVmgE5YQkMJXZMZEAb0wANNrUPTvddDZpA5VKgO7AR7JtARQr1RfTLqv6vrItc11r/D5e9jjJQTq2/GFqEQDwEnNWCU8GVfym/XYz1dIdZQcV5w5pB7etmKZ2c0Uc9lxc6hssVZ+kCKT9LfoccyXgTKlylPY0/7ujZ6mlNdpGekg8gZ9nKcrG8likiziAAcK/Ud9+drZMbF2YTQjGTAqpBy90KTlz1RELhWoR7GKgf4c9nzfiDplAR3G9ipRh/5aTEJpkuPKyFE3Jo1FIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uZ6qDkJ1fjpNJtFSum8RB430DpKX72/PPud6ui0ytk=;
 b=iWx1Y3vZFyWHjp+82vz9WZCmGVd6ux7y/kDOFA3mXf0lbZXstDiuQhIhb3hN2xIMGCsb4bpSr+mDo1nysO+AlGZgBROiPl9lyRj00BLw8DkkNI9y7Vs3XXr/suGT00FoyVhhZ/dQapTPcgcinfTDW30NpeAO8Nrz/UHxHBV4i4ArSi0xqqLeacz98LEzN6VWD3fxu1nyZ9881xvrGOqsOuLGqB7JX+wzHzqGnOhufA8R64BzKCXcRf6viR4BugiWMHFGRbpm5+Kt66SYFOSNmQwrhLlOlVzDavChSEse9z5laz3ijB9IECH/wclevFwZ9B3TXbA7zMCo6mC+8s/pvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 PUVP216MB596218.KORP216.PROD.OUTLOOK.COM (2603:1096:301:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:29:05 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 05:29:05 +0000
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
Subject: [PATCH v2 5/9] media: chips-media: wave5: finish a job only once
Date: Mon,  9 Nov 2026 14:28:49 +0900
Message-Id: <20261109052853.110-6-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0135.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::14) To SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:f::14)
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
X-MS-TrafficTypeDiagnostic: SLXP216MB1148:EE_|PUVP216MB596218:EE_
X-MS-Office365-Filtering-Correlation-Id: 6391eb99-f71c-49b9-fee1-08df3e225f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|5023799004|56012099006|261021123027099003|261021121427099003|261022105027099003|261022113327099003|261009221227099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261102125427099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	B2TcYHEs8UzJlZoq1dfadgf1podtabeiZ3RINZxC1bgdAbdlZBsb1J/4GTohg2F+YpiA1W0jOaGc1AKTqK1l5Rxn2QkOw1cX/Q0aBZvPjgNTHN9rlM4a7/fe0c9QaVx4OKvgCZpRKzcTWudAqgrVDE6oz1XSHk3UCxnPn9iqcniPkbR84mWJcOHtarttzVdAW1Lj3br4NlWXf1646kULAFllAABk/Xm75mfAxbnAUK0xkTfkYGH/EJyp3gBRMl6DZD3iE2odGnleBxoHTqwKFcCA4aNr0/NCbokkZK71vnIM6eizYxcLolMeRcRRAam9pkTHOD53CRxluw8gf366zPACpmu+Kq7fNIuiK6vTJDJv2rwsvpqX2XODftBN0bAziZ9e7t4Qk8zQRWnc4WIwI2ScPS6VzmB74/IoYJ/9TyISMKnFKDB4/uSbVt9bsjn4XE52XxGfSEg5BHMF/cSsReigjdhDTTScwK2Ag17BzFleWv4dN3bR7SSsGFN5BSXOLW5Su6H3aqgzFk+EPmNKuRciEtUwrNlhSbki84QWYfQUoKoDEZFb+y2O2lU+5kI/u5SLhkif/ad2Wg5TW2uunKnXFkejtCjBn8CUpdQxgIgLmxpXrpUAmd98phKEJ3HQkhdealKRrkQswsfpVqDOQ3BikBKlwsYp0RdB4yb7n8yuPaRgDhc/Er585knI4RV3UucqHg6fF3iumyNSgwRuBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022113327099003)(261009221227099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261102125427099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeVuE9FRsug2MT1T0l+Vbf1HcBL2FxL18zDs4BVF+Y/cRkeW9Tm8UfpXd33G?=
 =?us-ascii?Q?Wto6o1Zk05Zde2VMPr3sCJg4HfqV8S+nViS2/+IoYzzifzc2cFPMraCzxG0B?=
 =?us-ascii?Q?2SCrOGet6fZycEfxsuHWMu6Eizwax+Jd8DIukT5Ln7Sz0w/Zr02DeS4O4mUH?=
 =?us-ascii?Q?GlpRQ35j3oucYRUjE1bC19O8+jjS8flbwq6KDKWdmJbl424WwnGwxfJxjCPs?=
 =?us-ascii?Q?VzW/NXr0DwjJdjVi6Quvr8BKhsg4bNHqcuu97CzRU+22aEeqsnu+CUmJThO0?=
 =?us-ascii?Q?h8dMKncvef9j8DtEuws2wWy5aZ/kvCSNEHLiq6zuFJ0j8ctedB+LyFPRddE5?=
 =?us-ascii?Q?ERSwkJJj3LcyLLNk16NoCqkFp9vF34Y1p+8vf4UvAxvQ38kzcHjrW+hwi8OF?=
 =?us-ascii?Q?0brJVhJxRUEJQf/8RenCyNLH0acKo4N4h683uyP1fvoCh2j5Gh8+gkQGY1xa?=
 =?us-ascii?Q?Uez+PqFxxwNmgUDeQRl3neMVdQirDOXC7uby4g1RNvfJI5zzdZjdxp3l+N/4?=
 =?us-ascii?Q?DzbGovck/oP61Jqe2zcJRhsEiyJUTBDMgvP9alW6j1EGeYqKfrDR6GVS4wdz?=
 =?us-ascii?Q?Y7I2ESjQ777M721Ec+tCasmZR5lKAoXaUA6FraDTaOGd3SSyRBfqmO6utW3g?=
 =?us-ascii?Q?9tE9nnpxR8GNHeD88r3br8waYCMOEAbD9XSOHl2mqL2bk+AjTMb0JLGMoV+y?=
 =?us-ascii?Q?Xv7uNfIAIPgUg8SBsxWC6Cjkj83W6eLAe7rGf8Yuynm8Fk+wxQVqRjfwnLpp?=
 =?us-ascii?Q?tLRs5FCEozTW2Bu2Egy1uocwc7c+/wuMKlfTAxAo5IwWqDzFFP2D8WdNEfh5?=
 =?us-ascii?Q?Wb90+2fIgOiHyomjUZ7HCv7hSj9FcbWxtun3VWEWNuswZCopnsoq2n8P0Z/l?=
 =?us-ascii?Q?P1nK5kWrpVRuvkNqbKf+zN7W8eT2WiPjEWjJo4ZP9r5K+Dr+9B6Uy+L3Ajl3?=
 =?us-ascii?Q?A61C/vSApuVeqGbfGW3FG4XFk6WHw9RVHm0CYrIqsMpqEdK2vR3lO7r3t4pK?=
 =?us-ascii?Q?6DkQLBnExkk4RDQQJ+k+w28LzeofAbpVo9yS+Vjoeu2b96fwn0I/SfXKnX8i?=
 =?us-ascii?Q?uIL5JjFnwHHcvVBnKiekGoF7IPreQ6OqA7riYxmwHQoO0inUREbtiYhC10wZ?=
 =?us-ascii?Q?bpU3LU6N/SsEhOy5WtMDY8bC/9S395LaT0goNrdNY2dz/19+CN1dsrnET4/w?=
 =?us-ascii?Q?dmNteQ0cjdtIo4vI1VEgAu128QRp5eAo8wKW+1G4pjGTs+0/u8gjNSojwK7Z?=
 =?us-ascii?Q?C1sGohKAsIYtV+gxDl02a/D1JJeKQQVs8r18lVGZrb5kQmx+Yp7yubsMzKFB?=
 =?us-ascii?Q?G+la/zpqmdeVK4hyxuG78U+UofkLiTbLCw2B9A93pVz/mHboMjxRcJ3yvN3F?=
 =?us-ascii?Q?5gFsTUl/F4L3LsG0d+fU0tWfI62XxQXifu/gw0mYS+TJ/JpOUfeBf2VYQ5Ts?=
 =?us-ascii?Q?dHtjKFI5t7V5/CwjuTZuI73KhLfu064c1nTWSoDrzZCuJuvh4gAmKtn+yTQY?=
 =?us-ascii?Q?puz2QPQWNAxn3OmJNgWK5HpT3ZSLcJ/0pbksUJkZ30+wqbF/lE0CV6tsVbdn?=
 =?us-ascii?Q?0Atmw5dyATVyHozpHomXkObPPSwSwkkDtd810cqfB7ebIxJ5Z7VwgM+5sPvo?=
 =?us-ascii?Q?tjk892M/5jVXTebN16EJvBEpYjWtZOQVZM/18/Iqn0INrYSmfPpEc1XAi4SN?=
 =?us-ascii?Q?S/Lgj/bMaeaOtGW7lSmAF3XoV0DW5h7EdRkncZH/Z/GxvFnbbO+bWGdAG0KK?=
 =?us-ascii?Q?XkVJB+NuV5NpkSMuXtGMDVbLfW1GA3I=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6391eb99-f71c-49b9-fee1-08df3e225f13
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:05.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClH0lqRLnawuQWxKnAW5AUX9RXWbW+nl0iZVLYMGil7vLXsDWmfw+w5QkYkJ57hoKee0p7pio12ebxwRIiSmwsuiBZRQ1JMANwH3Af8Gpag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

From: Jackson Lee <jackson.lee@chipsnmedia.com>

v4l2_m2m_job_finish() checks that the context owns the current job, but
not which job it is, so a second finish from the same context clears
m2m_dev->curr_ctx all the same. v4l2_m2m_try_run() picks the next job
under job_spinlock, drops it, and only then reads curr_ctx again to hand
its priv to device_run(). A stray finish landing in that window makes
that read return NULL and the decoder oopses:

  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000358
  Workqueue: events v4l2_m2m_device_run_work [v4l2_mem2mem]
  pc : v4l2_m2m_try_run+0x78/0x140 [v4l2_mem2mem]

The decoder finishes jobs from seven places: device_run() itself, the
completion IRQ, and job_abort(). None of them tracked whether a job was
still outstanding, so the same job was finished twice whenever the IRQ
and device_run() both reached the end. Instrumenting the call sites over
150 s of a three-stream run counted 63 finishes with no job to finish,
two of them a plain double finish.

Take ownership of the slot once per device_run() and let only the winner
call in; whoever loses the race now returns without touching the shared
state. Also compare v4l2_m2m_get_curr_priv() against this instance rather
than testing it for NULL, which let one instance finish another's job.

job_abort() must not end a job that device_run() is still running or is
about to run. v4l2_m2m_try_run() sets TRANS_RUNNING before it calls
device_run(), so v4l2_m2m_cancel_job() can get there first, and a finish
from job_abort() then releases cancel_job()'s wait early: try_run()
reads a curr_ctx that is already NULL, or release() frees the instance
under device_run(). Hold a per-instance run_lock across device_run() and
take it in job_abort(), which then finishes through the same ownership
check. The only job left for it to end is one device_run() handed over
to the DEC_PIC completion after EOS; device_run() finishes every other
one itself. job_abort() no longer returns early on a failed state
switch, so that held job is still ended and streamoff cannot hang on it.

start_decode() no longer finishes the job when it fails: device_run()
does that on its way out, as for any run that queued no DEC_PIC.

Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 93 ++++++++++++++-----
 .../platform/chips-media/wave5/wave5-vpuapi.c |  1 +
 .../platform/chips-media/wave5/wave5-vpuapi.h |  3 +
 3 files changed, 73 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index a314813a6b4d..3ecf535f5622 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -102,6 +102,29 @@ static const struct vpu_format dec_fmt_list[FMT_TYPES][MAX_FMTS] = {
 	}
 };
 
+/* bit in vpu_instance.job_flags */
+#define WAVE5_JOB_RUNNING	0
+
+/*
+ * Hand the shared job slot back, exactly once per device_run().
+ *
+ * v4l2_m2m_job_finish() only checks that the *context* owns the current job,
+ * not which job it is, so a second finish from the same context clears
+ * m2m_dev->curr_ctx -- and it may do so for the job v4l2_m2m_try_run() has just
+ * put there and is about to hand to device_run(), which then dereferences NULL.
+ *
+ * device_run(), the completion IRQ and job_abort() all reach for this and any
+ * of them may get there first, so ownership is taken atomically and only the
+ * winner calls in.
+ */
+static void wave5_dec_finish_job(struct vpu_instance *inst)
+{
+	if (!test_and_clear_bit(WAVE5_JOB_RUNNING, &inst->job_flags))
+		return;
+
+	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
+}
+
 /*
  * Make sure that the state switch is allowed and add logging for debugging
  * purposes
@@ -245,8 +268,7 @@ static int start_decode(struct vpu_instance *inst, u32 *fail_res)
 		mutex_unlock(&inst->feed_lock);
 		set_instance_state(inst, VPU_INST_STATE_STOP);
 
-		dev_dbg(inst->dev->dev, "%s: pic run failed / finish job", __func__);
-		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		dev_dbg(inst->dev->dev, "%s: pic run failed", __func__);
 	}
 
 	return ret;
@@ -375,7 +397,7 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 	ret = wave5_vpu_dec_get_output_info(inst, &dec_info);
 	if (ret) {
 		dev_dbg(inst->dev->dev, "%s: could not get output info.", __func__);
-		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		wave5_dec_finish_job(inst);
 		return;
 	}
 
@@ -388,7 +410,7 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 
 	if (!vb2_is_streaming(dst_vq)) {
 		dev_dbg(inst->dev->dev, "%s: capture is not streaming..", __func__);
-		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		wave5_dec_finish_job(inst);
 		return;
 	}
 
@@ -469,13 +491,13 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 	}
 
 	if (inst->sent_eos &&
-	    v4l2_m2m_get_curr_priv(inst->v4l2_m2m_dev)) {
+	    v4l2_m2m_get_curr_priv(inst->v4l2_m2m_dev) == inst) {
 		struct queue_status_info q_status;
 
 		wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
 		if (q_status.report_queue_count == 0 &&
 		    q_status.instance_queue_count == 0)
-			v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+			wave5_dec_finish_job(inst);
 	}
 
 	if (inst->queuing_fail) {
@@ -1685,6 +1707,9 @@ static void wave5_vpu_dec_device_run(void *priv)
 	int ret = 0;
 	bool cmd_issued = false;
 
+	mutex_lock(&inst->run_lock);
+	set_bit(WAVE5_JOB_RUNNING, &inst->job_flags);
+
 	dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstream data", __func__);
 	pm_runtime_resume_and_get(inst->dev->dev);
 	if (!inst->retry) {
@@ -1809,36 +1834,55 @@ static void wave5_vpu_dec_device_run(void *priv)
 	 * stalling every instance sharing the VPU.
 	 */
 	if (!inst->sent_eos || !cmd_issued)
-		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		wave5_dec_finish_job(inst);
+	mutex_unlock(&inst->run_lock);
 }
 
 static void wave5_vpu_dec_job_abort(void *priv)
 {
 	struct vpu_instance *inst = priv;
-	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
 	int ret;
 
-	ret = set_instance_state(inst, VPU_INST_STATE_STOP);
-	if (ret)
-		return;
-
 	/*
-	 * job_abort() runs from the STREAMOFF path and may be called while the
-	 * device is runtime suspended. Setting the EOS flag talks to the
-	 * firmware (send_firmware_command() accesses VPU registers), so the
-	 * device must be resumed first; otherwise the register access faults
-	 * with an asynchronous SError.
+	 * v4l2_m2m_cancel_job() calls this while the context owns the running
+	 * job and then sleeps until a finish clears TRANS_RUNNING. Ending the
+	 * job from here while device_run() is still executing -- or is about
+	 * to be entered, v4l2_m2m_try_run() having set TRANS_RUNNING already --
+	 * releases that wait early: try_run() then reads a curr_ctx that is
+	 * already NULL, or release() frees the instance under device_run().
+	 * So wait for device_run() to return first.
 	 */
-	pm_runtime_resume_and_get(inst->dev->dev);
+	mutex_lock(&inst->run_lock);
 
-	ret = wave5_vpu_dec_set_eos_on_firmware(inst);
-	if (ret)
-		dev_warn(inst->dev->dev,
-			 "Setting EOS for the bitstream, fail: %d\n", ret);
+	ret = set_instance_state(inst, VPU_INST_STATE_STOP);
 
-	pm_runtime_put_autosuspend(inst->dev->dev);
+	if (!ret) {
+		/*
+		 * job_abort() runs from the STREAMOFF path and may be called while the
+		 * device is runtime suspended. Setting the EOS flag talks to the
+		 * firmware (send_firmware_command() accesses VPU registers), so the
+		 * device must be resumed first; otherwise the register access faults
+		 * with an asynchronous SError.
+		 */
+		pm_runtime_resume_and_get(inst->dev->dev);
 
-	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		ret = wave5_vpu_dec_set_eos_on_firmware(inst);
+		if (ret)
+			dev_warn(inst->dev->dev,
+				 "Setting EOS for the bitstream, fail: %d\n", ret);
+
+		pm_runtime_put_autosuspend(inst->dev->dev);
+	}
+
+	/*
+	 * With device_run() out of the way, the job is either already finished,
+	 * still to be run -- device_run() then finds the instance stopped,
+	 * issues nothing and finishes it itself -- or held for a DEC_PIC
+	 * completion after EOS. Only the last one is left for us: end it now
+	 * rather than leave streamoff or release() waiting on that IRQ.
+	 */
+	wave5_dec_finish_job(inst);
+	mutex_unlock(&inst->run_lock);
 }
 
 static int wave5_vpu_dec_job_ready(void *priv)
@@ -1920,6 +1964,7 @@ static int wave5_vpu_open_dec(struct file *filp)
 
 	spin_lock_init(&inst->state_spinlock);
 	mutex_init(&inst->feed_lock);
+	mutex_init(&inst->run_lock);
 	INIT_LIST_HEAD(&inst->avail_src_bufs);
 
 	inst->codec_info = kzalloc_obj(*inst->codec_info);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index 397da200a9ed..c7e61e2b78eb 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -286,6 +286,7 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
 
 	mutex_destroy(&inst->feed_lock);
+	mutex_destroy(&inst->run_lock);
 
 unlock_and_return:
 	mutex_unlock(&vpu_dev->hw_lock);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 7b08fef58217..2d515c9028a5 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -826,6 +826,9 @@ struct vpu_instance {
 	struct mutex feed_lock; /* lock for feeding bitstream buffers */
 	bool queuing_fail; /* if there is the queuing failure */
 	bool empty_queue;
+	unsigned long job_flags; /* bit 0: a device_run() job is ours to finish */
+	struct mutex run_lock; /* held across device_run(); job_abort() waits on it */
+	struct delayed_work unstall_work; /* releases a stale empty_queue park */
 	struct vpu_buf bitstream_vbuf;
 	dma_addr_t last_rd_ptr;
 	size_t remaining_consumed_bytes;
-- 
2.43.0

