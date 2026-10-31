Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.46.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793410401;
	b=wzmUhxDgFfdfFKPUp2ZV4jd0g7fma+9dsLUZOOmkHYDbJ1UQgFN6bvb63pf0pQj6BNFR
	 1fEg6vpxvwvnByezffFNJZ+Gvu5YOXNsMqx2MeffFUIUo1recK1gWnEfyHozLThvGkYVH
	 Kpxls+ImBGB7WK2UGGXv51qMDPV1Z0s6JbdgivKIkyNaF0qOzqfwTPBuo/ovms7V7760Q
	 n0fuU2gP48sopKse91WMG19ILLpGiyUm5KkVcY06cJcve3Ee4oCLTIh8qtYOg6UVWHt9b
	 HYnhMU/2tQJBgeCqvD+Y+Ewb16TKrxKGSqS7+4i/hHj51Lro1ep8yha8VxP3FmK1wVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793410401;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=685QK07If3Oqid6ffzxzhornPQoDnxE4gCjMTKpDYyI=;
	b=3XotnSa1/Adom8TAjoxfBd6a0AekmaEKHQETjNT+HWQpZEWXvDX3TiU0sAdmEhvkMUJb
	 DQdVtlPKyx07bItLZTGcuMMzQiL13LOp3ufLln3K3z0Pa+4YLgLZ6V5ZYqQvnyfX7Y/y5
	 vC4M3g+OgLSnKPkGcboRHm5Tv5aZqB0my3mP01KoNl8okK4gQtaBf04klrItojch9aMIz
	 LAHbNZvk6o+ISeYRY1gvgyNXn+2JKqM5UQ0Rx5zg7lHmMnBGuVedOYk2WHnF5ZrV+dBQj
	 66DEM1iU0QtBnFvg9Spop0tOh1ZMHtejqGNpdGlKD6sMMmDH6FMmo/1Vy9sSDzMQvlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.co.uk;
	spf=pass smtp.mailfrom=hotmail.co.uk;
	dkim=pass header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=ih1mT1Ym;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.46.75
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013075.outbound.protection.outlook.com [52.103.46.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864B606A31C;
	Sat, 31 Oct 2026 01:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A864B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=ih1mT1Ym
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv0UDeyi63dt3B63zw8Cw3gu/qp551UeucidpNiKDMIMoGMZInAkj2dZ6zv2VEWVC7mlTJki/GUOczUgiC+zaqRCCwEmL5mRbNGjR765GP66LerTAM4yKOMggf+G7+ovdzIWcm8oYcM83CQYEOGqDHgMNZdfpqJ5AeNCpIVq8omY5qm3+Kju7sDgLPQzFe5o6HGAcPujv7dmpMd1EdvUThe4HQ1+sqE/gbX5nnLOrULr6dWwwdx/fgfcM6kfW4IaljViqslbsfpBJYnQJWWdkyYwFIP05oZGg6cTS1BOtPwlBLGBMIRjnPQSYsfCi5T9OVG1TFNNSTUR2tm2ZXL3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=685QK07If3Oqid6ffzxzhornPQoDnxE4gCjMTKpDYyI=;
 b=I3eE0SSI2YOnab+yp8HRloMFMBXKIIj9P/HrijIOdBejU0YUoc8VMkH6+PYdMBf6vySzYs87Rk3tTdcV/QJDN2BrDaXZoQ/IeLQnRjTlhOFXSDaiSTVhqtZN5A+Ycm3alJof+H3lmR9hq0pWcurww2yLfwdNsbxhy0zTphjeQ8fITX38//e11/r4sEBiGKPMn9Os6wKUtEdTuKt7+4rRUwy+AU0z7tIbSpaMrx2SnPpjye6NknoXAIdAlq+RYe/iL+R22se4YfOakafZyji7km/eEOzw+2t/lukaVu6GTVLHdnwwdwvMIyu37Swq8AYWBcbIkywCrlbyPmC5MU2yFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=685QK07If3Oqid6ffzxzhornPQoDnxE4gCjMTKpDYyI=;
 b=ih1mT1YmhDzB7YybjoaZcIWKjcMYTEnRm3pLqbdbK5qYQk6IRuGgdf4RJZn4auvEMKp57hUgdqBIQ3i8Ki/G1PR9dm/YLDtEOob/Hrdr8HpIqQNAmtQjZGdzS7GPyZzkpkFycF3ZpxZWAvGOX3CYmU+ahxxs0B8xdLoD7klN30S6KVgVNHnBSI3YRb6VscCS+nXAPau7Z4sySKzszvWGQsCul7YhVGgpAeJtWYI3reX4RdmMm5xPZckuqjMbEnkjC46aFMGJ5elu1b82drYdsqmUYo2du7PXdXHhenjy8I3d2EjXQQK7VspzLO1wwrZsAgocRTZv2YKWdhJyQucOUg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DU7PPF563096915.EURP251.PROD.OUTLOOK.COM (2603:10a6:18:3::b96) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 01:33:18 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 01:33:17 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop
Date: Sat, 31 Oct 2026 01:33:13 +0000
Message-ID:
 <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0279.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::14) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20261031013313.55954-1-elb12345@hotmail.co.uk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DU7PPF563096915:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbb345c-ebf4-4fa2-f12e-08df36eef086
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25010399006|4140399003|260925184616899003|8060799015|19110799012|37011999003|23021999003|25031999004|5062599005|15080799012|24021099003|55001999006|41001999006|52005399003|40105399003|26104999009|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJi040LwEhSonbgJQedY2WRjYO0FkMF6a7gOvGAWdBERWT1mqGV75ESUgRhI?=
 =?us-ascii?Q?uBjuzM9gVE5oLVDmqccx5AXnUhxYho5EntnBhXB+QLAwKgXKcXNPWkOHkn+d?=
 =?us-ascii?Q?0QDN8cMx8uL36uAvd9Xcf9r9frGicOQM1VIzQC4qAUP61ZJL8HQsE60OmU59?=
 =?us-ascii?Q?dlLoyaAmzVreLm9gkSgVrL5Mtg77WZLjQJnpNVAjkZN8biUujsnFthpvj5xR?=
 =?us-ascii?Q?rlNmvtmg0UYl6kNa3yiEzGhEkec5F7vavJhBMIjtvy+VzzA0o2MBFIIYxr2l?=
 =?us-ascii?Q?TbOS5SRNdn37FQ9B0Elt5VsRymsJm64ZhrnnGm75Y4fRPM3OlTAhYmnyZqW2?=
 =?us-ascii?Q?VNMtpd6e9rEut7geTyn7gXcH2JPi8L6D06DMjctP7URBse1Q9PnQSnaTWAZN?=
 =?us-ascii?Q?v9Qnqd7wG1v3Y2O2+B4jZlhO1cKavhd415yclC/32+LiEaAWM7ZTGatxxZ0W?=
 =?us-ascii?Q?Mwa3PGawYQ7ff0+eSengRhxiyW1kU7kM9drlvPwgpLK+n8PRP5sI1BDnLl5G?=
 =?us-ascii?Q?35koRs7DPzyHpXz20LH5z+b2EBG77E4mfp5OFYLdt/ZMpg9hKP61BldO1dIU?=
 =?us-ascii?Q?TEpvjUqePnedcXqJbB/CU6br/MYLX9Tv10VmW1Jh1Vg9MNystQ8abiH3dDUA?=
 =?us-ascii?Q?VfxCi4cLuXheuwso2IrnGeqTdY8Y+6x31X4tl+FMKWlmufulamVCv82AsMRo?=
 =?us-ascii?Q?ti+caqf44ZacoC4D+jo4VIFxMr5pCGeCIpQvt2iDovp/rY90S5oZWZGAecqK?=
 =?us-ascii?Q?7beJpNL6dIL5bZPfmEayodafUGhrnnsA62rTV+Ct2Co+uD7+MflqNgO00S7O?=
 =?us-ascii?Q?ZPUFNltqYvEjVGCMt/OShTHL935y5E1kXlQBtyanbOedn0RVgZuwe0CYsppJ?=
 =?us-ascii?Q?YlrFp50hQxdwxLKVbTJMAcjuZfFA+E74LXJWzJkpg7xjt59aHYgBGR3w4C5u?=
 =?us-ascii?Q?ixu8ZRjA11KEBsIp1a92T7inplfWaK6MFATQ97kVMa8TcQH/Ia86k6pXZYGj?=
 =?us-ascii?Q?Cbl1Ov7Jh/pNy4VtXixlimf5D+tZQn6pS4SCUW8LHSWfCqWKfgQ7MMlQaFxw?=
 =?us-ascii?Q?Jc3qtZnHJkeHcL7J0YOsg3lfHr4EXy9L9SvqTF/sva3hyJU39dxP0xOWeSeL?=
 =?us-ascii?Q?7sRgSRiZNFgW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b7kN7GPuwUAfc/S47U2YU07p82m4LRZroo6Te3OaTu2FdEydKzFzVAwz5hIU?=
 =?us-ascii?Q?3uVmKrdsUfHJ9t1Z9jEtvh5tJcNlNcRrCvLAHt9KM7QjWL6cSM9+v6QsEkNj?=
 =?us-ascii?Q?V+H0o4byHVG3YqXvw8TkwFbL54DXnaEKIuXxU0pu5lCI9k1+lYx3NOkeMIyn?=
 =?us-ascii?Q?bTjndkl8H0TiRMOQ6XH0Tj8zmP0sgZXLtLCRCx+MrADaag/pnrGWdEK9HQd/?=
 =?us-ascii?Q?7iCBhfhCYiVQdda7gvD25/WVNalsKiYc2isGTqweoIFwMuuuUd5icuUOWq9I?=
 =?us-ascii?Q?BKbkGm0ZTcbWvTUcNpo7nIo61iwukxGJJ2tysLF65HrEbyJHiht9H6RPj32X?=
 =?us-ascii?Q?vnK3bTg/j4dK9TwEmhHbZkc11POfCpZ4/a+uyloclxZY9cEZTCNlLOvbEO16?=
 =?us-ascii?Q?y1x6cozijG2WWvG55DuwOCyHXe6206O1Okc+zngfh1wCXz8KeRMKlf7GuEYY?=
 =?us-ascii?Q?jn7bDDCx78Y5aR1Q8ddTwZumffWvYkYkL4SBxwsHnwQISkwI+HbYZ1SbRto0?=
 =?us-ascii?Q?uwQFVoA5AlsVoPvnmfFAJwkjsuCvmemD3VACoW3DmDzq3zTKXo6RELYhigrq?=
 =?us-ascii?Q?GK9FDseE1DyCefqfQwkgewGynws0u0EAZFucQXaYTQzQknNCJ7P5xSfyexPb?=
 =?us-ascii?Q?fJ+tMfJ68Nl7t49txBX1mzbZ983fC5dAiRg2QcTd+YcM/Et1Y/Azzts5HHlR?=
 =?us-ascii?Q?QjDfj4K7C3Cxf1ftHb9HiNr/rImT8S7m6BD2y+BdXu9FOzBQvubTyBciZjC7?=
 =?us-ascii?Q?jV6d2djR0fTZXVFs0+2FQDFy/eLWHiWvFbMzChCPGeyYCQFPlaHA/jp5LSWa?=
 =?us-ascii?Q?22ln4knxpMWa71hk6Oyve9UMb8NcgufxzUtNg1CSelAz1mpLaqkdFkwWeWGa?=
 =?us-ascii?Q?tGSOiHmzn35wS8lPR5B2a8WFPb0/FF7D893sYMBH3PNn8tbOTDXrBPMijKHu?=
 =?us-ascii?Q?+Aq2gxW1ugdVp2E1B2ksG7+PcIg4r13pisBCmVLwxWjdwT+rHWH/uadPaQPH?=
 =?us-ascii?Q?9lyqyZob5WgTf4a0VG+by+BveOaExsuVcfmKX9we3BBWI0MYReSuz5vdigR4?=
 =?us-ascii?Q?wJzviMwipLSdyd9mL06VMUDbOxKw4l2iUcLjR8dL4z28COMG6WwBbBxpKgF5?=
 =?us-ascii?Q?X8383q7zqxb88knSiv+aEtJ63MEku9hJab9/lvHcvsIbcmGICnlROtXmwjga?=
 =?us-ascii?Q?+Go4/TzpJPYz6/bCbuYUiEau8fC6VZF60ae5CMdEp2OvIUs+XyMc1o6sEWso?=
 =?us-ascii?Q?PHL9eLsMhBwvil/fyVsN0Vknu5uXLt097irw/zZMPeeg5psYWoAdq5GX1Adq?=
 =?us-ascii?Q?rzDw8ipKsLv4JUOpxCj8Lw5kukYQzUxehUXFvrSUVSl+Nsh91pLnjO++YKm7?=
 =?us-ascii?Q?Ll0u6LhRB0kvNuj22G8+ROKXofkBUWWKouBbC6KeSxpFS73Ol9uK/vDkJFP4?=
 =?us-ascii?Q?nSrqM7OYTx1nG/DfR9i4s7j1MErCPc3l?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbb345c-ebf4-4fa2-f12e-08df36eef086
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 01:33:17.9359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF563096915

Since commit e1fad12dcb66 ("sched/fair: Switch to task based throttle
model"), a throttled task is only dequeued when TWA_RESUME task_work
runs on its way back to user mode.

vhost workers never return to user mode, and vhost_task_fn() only runs
task_work via get_signal() when a signal is pending. A busy vhost worker
therefore ignores its cgroup's cpu.max, while its runtime is still
charged to the group, throttling the group's other tasks (typically the
VM's vCPUs) harder.

Run pending notify-resume work at the top of the worker loop, as io-wq
does in io_run_task_work(). Commit 12013e3d4695 ("KVM: powerpc: Use
generic xfer to guest work function") fixed the same problem for KVM.

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Cc: stable@vger.kernel.org # 6.18+
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Tested on x86_64 with a vhost_task-based reproducer: in a 0.2-CPU cgroup
a busy worker drops from 100% to 19% of a CPU. Reproducer available on
request.

 kernel/vhost_task.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 3717885a599..7fa96e1b85b 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -6,6 +6,7 @@
 #include <linux/completion.h>
 #include <linux/sched/task.h>
 #include <linux/sched/vhost_task.h>
+#include <linux/resume_user_mode.h>
 #include <linux/sched/signal.h>
 
 enum vhost_task_flags {
@@ -31,6 +32,14 @@ static int vhost_task_fn(void *data)
 	for (;;) {
 		bool did_work;
 
+		/*
+		 * We never return to user mode, so TWA_RESUME task_work (e.g. CFS
+		 * bandwidth throttling) would otherwise never run. Run it here,
+		 * where no locks are held, like io-wq workers do.
+		 */
+		if (test_thread_flag(TIF_NOTIFY_RESUME))
+			resume_user_mode_work(NULL);
+
 		if (signal_pending(current)) {
 			struct ksignal ksig;
 

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0
