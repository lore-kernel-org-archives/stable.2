Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.39.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703288;
	b=ntsY6EtsrieJ3AQYZ4MUEdUGxIPFhekqiUtIDbGRAptNOcke8hhyq8y59b0gkewHH/3+
	 9sRRiXYlEBVGom/sSB9P4kh6/wIzBdZqd/3b79FbM+eSS0R4i8rXFZyKIkVoB+XeAj3Rp
	 Va4yAR5q4dn+dxaTJy5iY836a9IsCSKbgGmhgvhIGEb43K4i576J4N48jceQNHa7skR2P
	 cvOOxkwne0quT56PLVOberINGofDXngLp7Sxm49ZIkG9NDMRuHgQ+s3gOrXmwcrFmWHuk
	 L/EnOSyUrB9V+2lJQhJvoVc3qWOnJB5hSGAl9rAA95oBO4c3a6JDaZdva4jQ46e9CCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703288;
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
	bh=HxnYJdkI/LkidTPK0wZKlrXpcgyWDOY5sDKRwEUsxcQ=;
	b=XBqdaUJcTNfJrbaFPkUA+ELLWo0ff/CKZg0tXZm/0DwNiRvcqYA97lh23mORJZpKcsBu
	 0+V7M8GaF+yEoiU5DIHdJHYJPObVExBCPpTgGRnlIXm1v0nB3OxWwMZ85cNh4BMEk7kHk
	 r6gvC2CSrLtqMvrggpBy8n4w41YHCRt5p28mK17ZRQZ2lrRHjfGqM4eipoO+qD423cIei
	 qrT6tWwtJPGwZKg/ymH3DZr2EQ+suyAjSWb5RQi9apdq8UWoM8ds+xosTjaiQVwFx2SVM
	 voFOHw4kkdJxhhfAGgTo8DBx/V7+ekDcEJoAU/lR9tHkWvKNDDmCmXMo5EmffCZaukQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.co.uk;
	spf=pass smtp.mailfrom=hotmail.co.uk;
	dkim=pass header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=rL6nr1EU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.39.30
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011030.outbound.protection.outlook.com [52.103.39.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD198606D811;
	Tue,  3 Nov 2026 10:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD198606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=rL6nr1EU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMxVKpgmuLg75CQgn8Z6CeC236T+4wsX8+TwAVKNPX63Kz+KmHi3gM1ZjXDVI8AS4Pw1SjS6+YYDzF9BTSqiFowID9/UosaBXvlwJV9f1OcbvAI6BkGiGXKiemc4fcKchbVLsL74/0c6ANn0YRST50pJYYVzlm4p3Dr+uk4YZEBVCJHvNrC1RBzEDo64ADsZ7jMvpkNW3PkYYuG1KKQt9MEiHM+z/COpjJIoFVuHAH3Tq4MPc3zgLfkdULoAlgK/GNUuRGUfZlGeDvKjJQu3wN/zO3BqWlBNcncuV48aq07rML/KttQVdXZfyWQgMOmQ38nRJxjOXb3jNwJLxxZJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxnYJdkI/LkidTPK0wZKlrXpcgyWDOY5sDKRwEUsxcQ=;
 b=rWiynT1gYOeR1ZfBpxlRShZWUCGBFWwX5ZAsvdWgQZcO1RwCt0fnEAt1HYFP0M37FJhz08Lg8N4EZHzV5m70F8kW3FDWVzxOECEJIxXusu1Y/fmdAglBNdZjrTAEwRUlWxdMhHOCM8qLRl4JQzAHYAqnONPs1q5tYruT3W+4ZqtM/TyomarTILnFans4G9G5wtfSB+0HhiG7zXeWlRB92FdWIIh4wBqlN1flB7H9MnPV3xyJ5UTXTl2X+wyiSEn5JDQgi5s8H2GOMjvRwT4OJrB7tT6HT4aOeabvsb0eFIO6EHu7i1K/c84QKUtKWKKkkr/568DdFJUfx+/iWAa8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxnYJdkI/LkidTPK0wZKlrXpcgyWDOY5sDKRwEUsxcQ=;
 b=rL6nr1EUnZex/JoatO9Ln9cVYVMZZ4fu73ZYrZzQOxJ39PQ61pAowoYsGgntt65/CPgR5ydlhOhDpsjd2g9QsqwTwScvQmJH5Lu3nmJyfR1m/VoYOWltEhjIeDPJU5YM4hboyC3QKXlUZmgyrarckC4KRbpYpeD/AAehfbug6JskImnsNqB+nb/NVs5z1ZaCSrR2T7VlGW/1bSrieveVls7FNkUXEfZ6XFAP0RQA8qR5eLbXgAthWsTHe6B4d4Aryj9nuy4bBoBzM/KqQQIrO1g1TRfxvjMumEkIkz0jWgVxcPnemYcPOxRnlYUbN0OFnKsldSykozdbBNvdz4OJyQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by MIWP251MB810810.EURP251.PROD.OUTLOOK.COM (2603:10a6:290:aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:54:42 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 10:54:42 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: shakeel.butt@linux.dev,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	vschneid@redhat.com,
	ziqianlu@bytedance.com,
	peterz@infradead.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop
Date: Tue,  3 Nov 2026 10:54:40 +0000
Message-ID:
 <AS8P251MB0001F1EACBED6E7A2AFA8A96C8692@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0412.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::21) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20261103105440.43028-1-elb12345@hotmail.co.uk>
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
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|MIWP251MB810810:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a396da-cb30-467f-a13e-08df3998dd3d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|25010399006|260925184616899003|19110799012|15080799012|5072599009|25031999004|37011999003|5062599005|23021999003|24021099003|55001999006|51005399006|41001999006|1602099012|10035399007|40105399003|26104999009|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXFWINgzTSl3xsIAyY2z79kWIy+BUtBPO2dbOGDevjR1rAEHQUzvAC2RV8f+?=
 =?us-ascii?Q?CSB6XyZZu9M/VEucxulgbZgAhVCLyZ4iz+OTwYUrNeEMhNzh4RHcq9vaoAKM?=
 =?us-ascii?Q?9IK8Qd/MUJLvF+kJ6MYN+br2WHi0hqk78hjlfdo++dyjEiEen3NEkEe2wm5I?=
 =?us-ascii?Q?d9CwOVXu70PilTFdopFVwpxms+EWLP8gLk+VFvk+E1X+nfWfglGKVXpCmful?=
 =?us-ascii?Q?r29y6Uw+qIj2pCHoS9N++/ZV9ndG5uGkw8sopYANPY4WEtMzkasN/hfAV43y?=
 =?us-ascii?Q?ILaWQzuvdUAPkX5MkW3QF/wa4xHsMQwn4i4aa1DAc+G6Ze5g2VfMSOIuidIO?=
 =?us-ascii?Q?B6W2jnofso5BCpAGkqjkmF9yPZDc2EAbt4sC4M8XhTCB3QjrXfdPpVKtrE6w?=
 =?us-ascii?Q?+ndpfMiB53UkpA7mQ9Q7xk5FV1yM+SX6S70G+9QjK71/6yQa/9DEC+18r2k2?=
 =?us-ascii?Q?6QDfhh5L1iJ+ka365WlGa+IQ6GZwBbl1waE5SJS3x3QjgY2lYkNj2PDXrrgx?=
 =?us-ascii?Q?lmvokv7bz4EhExLTTMTqJZBEzl2+0/jAGa4kQ67WGFR23cixS5apApO8T4bm?=
 =?us-ascii?Q?jEluxgSh2ARXBHWiie/jgfPyxHnqaCisfv/kvoinZYBz8OOrLpWct0EUfvWe?=
 =?us-ascii?Q?yHwtkBAWJINY7DV6k4y3Od9EMCfCpL9K3oWxYshAKK5+Z/3U4OvfWbrD/lnt?=
 =?us-ascii?Q?u9WCw42vabDCdb6l/pjFq2iVoC0FRuJj9ZAGbwqbF5IUxUa2sb+Mq7843JX3?=
 =?us-ascii?Q?gG5UEim7+IhdtDgtemoc6HzfY10xC43Yn0fYYXXv9aME/OVnWVmlp6RvlZFW?=
 =?us-ascii?Q?VeVWT9m9m5hhXyhH1PDTw2Mzpes1Bpqopm58SN9p13ZzxlbgZ22wpJd+g9p2?=
 =?us-ascii?Q?D022HMAS6qRacUDuII5PPKrIEHVYYeFxtkJtgsCEn8BwWMbkLD4G9BC81fXm?=
 =?us-ascii?Q?wDPEHdAQsKJrNxWf/KmS8cOdmg0VPQlpzG5UAnNpjJrbZfDvzwCeiSFXVTcN?=
 =?us-ascii?Q?/dGVAdNjv3kDDDxmS9I/6WAT0oloc5xD+qgkRfZ72LsW3TOgUUQKbOJPSuF6?=
 =?us-ascii?Q?sByH2m6nXJ8Z9wQ/BXIFAW0Dtccx7U3gTR9HodQX5V5DjjXFByG3dmgP/JDW?=
 =?us-ascii?Q?aHzgbrG9DSLo?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?He3TDZgL6sdYTEgDMLVT1FL+FK+ck9MlGJcMjYUHfzgSSIMKX695yw/bvr78?=
 =?us-ascii?Q?mJ0n6ExWZkVqVigY6vhRseYpf7Qs7tCMYCqFf3or0yN7i4wD+oiMi2PB73bi?=
 =?us-ascii?Q?f0CkMSSHFD4rWByBhHHJi9jChIRIdoo/susTUImv4H7Rts/6ahfClnKyHb6a?=
 =?us-ascii?Q?4o+ST34qeJO+wMOw4ReGwJCZSJ4XK7cp4rFOdGn8s3c4cJ6yr2VP0voT8Z9q?=
 =?us-ascii?Q?UWqrycu5hTyPqo0pHCgs/xdXaJtOdzZw7+4JedaII/im9FdgiKBT/rlJtt/t?=
 =?us-ascii?Q?0z7gm/vkgtqTjd/SLDXEAYUvAYDoxeAhs42GBJUV6MlPz0VDqEJQauzJJzwN?=
 =?us-ascii?Q?qTiQ7O9GBAVuuwJaKsON4AmM9bXk+n4V4qttfeIgQlIU2l2MM3Ge2k6/dsX4?=
 =?us-ascii?Q?++GYx9wspnZ21oRv60aTH/aAiEgidLr7EnCoUQnPCEGThiGcNbrHeVGcpBV7?=
 =?us-ascii?Q?vT9x5oHMvPOK4pEUri7ZQmV7Dvtpx2GAqrbRxz1p7lfh3iYafzhXTW1bp9/u?=
 =?us-ascii?Q?cZOgHoxkf/zy4MhRbva7NkFjdd3ziQqkSe7jsQck21wzOkF5DDWsFSDfyjeK?=
 =?us-ascii?Q?71rgfY/tE12J28KYrx8RJcevM7fxYCTtm40jrHMzBHdq83izva8oD88mcv5H?=
 =?us-ascii?Q?q2CSZRjfosBltRX9Wl5R0fowUnTFHnffcavuS1M5A24Be2Q80O0HTWj7/iEa?=
 =?us-ascii?Q?PG9N7+BwmT0p4DX9hQ/Rf6kO6v2Y3bgcUUk4OUicP4adfXJs9c2MqKPGCU3e?=
 =?us-ascii?Q?vh8I15lPBYdPYTx8p0UxyxdF9cTx68ci6bhhzkubu0cFJqtHyI/jiN9Kkfk9?=
 =?us-ascii?Q?0XMdq6j4SxwE4WYqOCFywCX0ftDguiXsu6G7LRvCM+lqs/hwzUerbHOi0Uz2?=
 =?us-ascii?Q?fZdPx1iOgNeEfYa8LD9cqLruQ1dLu8gU7P+Dk/SAhEyo9b8r62Ovh9bpOho8?=
 =?us-ascii?Q?CTdlNOVnhs4wiOxAsif4H4Vco+TqM0/euIVa9c3e/JH+0OL+a74CwRlNTKWn?=
 =?us-ascii?Q?mv7iWQy3gfjT/ybZpcGKroDp7mIPUaTMhj7F8+VhOmg+eB0qztkCZzXkL8iK?=
 =?us-ascii?Q?9+LjSE/umdFmm0I7wYYeZuso96vOqGBkSiilJfliL8sujEpmXz46QT9D05wU?=
 =?us-ascii?Q?gKdCP738HAaPJijIOhHesTCHqT2WjDe+hMRn68GzlXyFOXwd04A5oI0gxXED?=
 =?us-ascii?Q?LltmZj8eBjrGTKYA1QpKOacvuEl39bstXuUe+qkU0dptDmDvlTM4UDUwKpov?=
 =?us-ascii?Q?0ZyyefNYjVqkKC//HLBlOegVeZdSPf2B20STu+RBlHaKhvjvXhNaRdkfgd5e?=
 =?us-ascii?Q?DIdsmB5Xbg7E71/ASistye+AZJNJr8QotCdICA285GmG2v2U/mItfuMf0FtC?=
 =?us-ascii?Q?P3ey6w7TfdD0E3OU6a9IuNrlkkQFr88e/CEEmsfK3Di9/Dwe/8IJbjltnbbX?=
 =?us-ascii?Q?jerZ1QrqFKKqoVd8D0f4MRaKAax1At0o?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a396da-cb30-467f-a13e-08df3998dd3d
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:54:42.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWP251MB810810

Since commit e1fad12dcb66 ("sched/fair: Switch to task based throttle
model"), a throttled task is only dequeued when TWA_RESUME task_work
runs on its way back to user mode.

vhost workers never return to user mode, and vhost_task_fn() only runs
task_work via get_signal() when a signal is pending. A busy vhost worker
therefore ignores its cgroup's cpu.max, while its runtime is still
charged to the group, throttling the group's other tasks (typically the
VM's vCPUs) harder.

This also fixes memory.high and block cgroup throttling for vhost
workers, which are handled in resume_user_mode_work() as well.

Run pending notify-resume work at the top of the worker loop, as io-wq
does in io_run_task_work(). Commit 12013e3d4695 ("KVM: powerpc: Use
generic xfer to guest work function") fixed the same problem for KVM.

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Cc: stable@vger.kernel.org # 6.18+
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: Shakeel Butt <shakeel.butt@linux.dev>
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
v2:
- Also describe the memory.high and block cgroup throttling fixes
  (Shakeel)
- Add Shakeel's Reviewed-by and Tested-by
- Update the code comment to match
- v1: https://lore.kernel.org/AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM

Tested on x86_64 with a vhost_task-based reproducer: in a 0.2-CPU cgroup
a busy worker drops from 100% to 19% of a CPU. Reproducer available on
request.

 kernel/vhost_task.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 3717885a599..f63ac005214 100644
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
+		 * We never return to user mode, so TWA_RESUME task_work and
+		 * memory.high/blkcg throttling would otherwise never run. Run
+		 * them here, where no locks are held, like io-wq workers do.
+		 */
+		if (test_thread_flag(TIF_NOTIFY_RESUME))
+			resume_user_mode_work(NULL);
+
 		if (signal_pending(current)) {
 			struct ksignal ksig;
 

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.55.0
