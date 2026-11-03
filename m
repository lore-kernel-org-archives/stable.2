Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723645;
	b=EwEDGJZwn8l8FRyBDuwnOSCSg1pLBVcVME5DgLJ2ugc0+6Wtg+rz6MnWshoVrMqQFvVD
	 /lU0kZCCLdyxeIRXYVG9LZ8Hcr5MDNVh4B7xzgy/ncFwLhY+o0MOLXlgtipN+8pV5SV98
	 ooaT3ZTHwPkGi5+TTHwEYUVsL/8XXEV6xzrR93DPSXKTyEkhalIKKNVFX2ytnvq8AC7Hw
	 aRvy9eMg1Fs0xYkYNILXJRyjA2i8lU3aqAkp+Mj4xctub1WzKLY5gxeTiPujX2x+F0V4J
	 DMKMes5quWO1Mp/983X5t+/wMBzdYfmzbZ9Rb2vXVPFN5AsiNcsrZmBNBFLx680/3rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CkDq4ip3eZVdM6Aw+l6DwI7pxq1Ld8m1+Ex9I/WSbNY=;
	b=V8XVTIv2weZSt5r+7QSyxp8b1mIoxxvaNgO/+R1jrmnfpzxSB1NH/2MAbDu03bZtCOzo
	 H4xe9wQcmSsqjxraM6f+TcGd42k6qOa+URCPajggHK2wbywUyvftqiXZnmiS8wpC5kwf5
	 Do+drieJlxJ5+r5uSCch18W4VcEJPWGEw8BmNfJk9DA+8kPrkLfejLcEElPbIrGdHRWDv
	 uwLMjwa28R2MMgkIKjeiXy2xZf+wMILRhSSiEUarBSMbtTjYjhrjS2vnHMIfrKE9KN3bp
	 Gx05s2Nv3OiVAZl5/vZGdicR8J4PAiCbZzZ5gGzO1uiqHcZm8zHTvrwOZl7qv3LfYag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ELKYDKWm;
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE37606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CE37606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ELKYDKWm
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-1379d32d309so155205c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793723644; x=1794328444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CkDq4ip3eZVdM6Aw+l6DwI7pxq1Ld8m1+Ex9I/WSbNY=;
        b=ELKYDKWm4LdG2EhVvslNZk9V8TvbHaeOVXpGX1ObE3UTSold8qYQJn3+6FXC4fjCJp
         k8/WLF4gyEF0TwM/z+HX85X9p+zMLms/MBT3bT7max+bkYM/QegLIy8J3BQAUCG0fH6p
         nm8SjbwnQJwrrBwBl4ulfGyrcFiuTEY+flMTAVhyjB5hv2925W5LG6opfEaQEuk8EC9C
         MwlJg+MZLoQEira/BYFAwHbAPFD3w05tzUhUT0RojA3sfntKg+9iUZw8H54esg2Wa/ic
         yxumBvEN7dy15Mc3oGigMnAeceuxaQ+WgffZNZ0rr5UJ65j2E4kkyVjWNKO8pn9E31+8
         eSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723644; x=1794328444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CkDq4ip3eZVdM6Aw+l6DwI7pxq1Ld8m1+Ex9I/WSbNY=;
        b=WzNc+0ExCNnSOmvq73frZghRXabmgPgebHu15Ui4I16v3MDxHhnZFqD8OQ5uRW/1yX
         mjH7bch+mDqfWeRtD4hCm/ffca7uYc669yRG953JQrcdPUmtXurMm5LSlOspuVakD4Wj
         69P9UOWr5+IXqphaGKp8/9r00f3EtXqI2WIIR1oXSU3geUKeyQMyf7sQxzMIjzZoQU5J
         rrsiKSERG0kCMBFfSyl/C5AkAut0wlMLu7cZiVDeNU9pnpYVh7lISYnsGQvAOY55CPlM
         M0RAdWsQSyKSebg5d7BH6Z/R153GTyl0CFeMBX3OUx62QpzUCS1WgS1hDLZL9r2X6pav
         jH+w==
X-Forwarded-Encrypted: i=1; AKwUvBy+1rlQpIyZpBDv/PyMZQPO8NbpXJYyrqWkn8pG+OjkR5JmKOpJDXfERxSNUOxvC6/IQfgJxR4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cxgxG/z9Ony6CFE3k9Uutx/6a6Ytr0Pk+gm0novtO1ofxoQs0
	RMkxmeoK2zoO4DWZLRiZrb+1kPwH1o1Kl/kq5lbhDV117TV0huQNVNc3
X-Gm-Gg: AYBFou2w7pSMbtifvJLn3rwOBA/S4bqsgcmqGeaQQpQmZ8su5vh71V9ifWlOUJUIT50
	rBRM2mGQqtrv53I/OsmRD1yPVB2f7Dff05dh3DVJS5U6NHG0CQ6u45eMiDkMWkfRKh+q2/4DfB1
	3nX11X23SVX6EA5utxsAJgK+LAYtI1shtUV/c9G0ilR3m/eT6mk1lMiZG2mCz6Fg8n15tIZQeHF
	2m/M1UX/+DyDlYExwavIZ5p2rz/K96zQmgCD9lze0NTJ5mDssg+y2TtB3L/9+AkmWMooERtA4f4
	6HrtMNaoliiRLB3uLB/hxkLTQOHDs2e0SaKWKt0YCFqKry+ASZntzkIGUacQQHbMwqMt3qfjxiW
	TaFsNjByTZtqFtDGojlG/hMjAtRQTzc60s3QAdwJ8LkVGErArzGGHv1/nlUVNMovR36xeQev2j/
	ngnKxXo45N+YtCsN5XbBzhrvmjLUvXCqRK0ODZL0MYz6ax5N2O7H6hh1feHWHvsNqsxXDPjoDot
	AaiSYzc3Anwurf/co80szGRhEC8m7JV3dMEmplMLUBTQgiXiHZxcNnx0vbjr6Rxk6zoUPVXq0bg
	/1zI55oJIrzRs7u6HPbrxCAe8KcnpqBP59WwYWDkC2rXPfUU6r09QleVvmKUiCE=
X-Received: by 2002:a05:701b:2710:b0:146:ffa9:2117 with SMTP id a92af1059eb24-1ac58e573b8mr29438821c88.1.1793723643278;
        Tue, 03 Nov 2026 08:34:03 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b8822fsm156057c88.2.2026.11.03.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:34:02 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: koby.elbaz@intel.com,
	konstantin.sinyuk@intel.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] accel/habanalabs: disable pending-reset work in hl_device_fini()
Date: Wed,  4 Nov 2026 00:33:54 +0800
Message-Id: <20261103163354.1599176-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hl_device_fini() sets device_fini_pending and flush_delayed_work()s the
pending-reset work, but flush only waits for a running callback - it
does not prevent the callback from re-arming.
device_hard_reset_pending() re-arms itself via queue_delayed_work() when
hl_device_reset() fails with -EBUSY and the (unlocked)
device_fini_pending check still reads 0, so a callback that passed that
check before fini set it re-arms during the flush, and the fresh timer
survives: destroy_workqueue(hdev->reset_wq) cannot see a delayed work
pending on the timer wheel, so the work fires later, queues onto a
destroyed workqueue and runs with a freed hdev.  Use-after-free.

On a busy device (live compute contexts make hl_device_reset() keep
failing with -EBUSY) this work sits in a per-second retry loop and the
callback body is a real reset attempt, so hitting the window on device
removal/FLR is observable in practice, and retries are free.

Use disable_delayed_work_sync(), which waits for a running callback to
finish and leaves the work item disabled, so the callback's
queue_delayed_work() re-arm has no effect.

Found by static analysis.  The race was reproduced on a KASAN build
with a small module exercising this exact flush/re-arm/free pattern
(no Gaudi hardware available); PoC and splat are below.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---

Reproducer notes (PoC source below; a module parameter selects the
shape): mode=0 (flush_delayed_work + lockless guard, this bug's shape) produces

    [    2.22] BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x807/0x900

after the teardown frees the container; mode=1
(cancel_delayed_work_sync, i.e. this fix) stays clean.

---------------------------- reproducer: pm_flush_poc.c ----------------------------
// SPDX-License-Identifier: GPL-2.0
/*
 * pm_teardown_poc - mechanism PoC for the drv-teardown-sync C/D variants
 * (F-026 ipoib / F-028 epf-ntb / F-029 habanalabs).
 *
 * Modes (module parameter):
 *   0  F-029 vuln shape:  flush_delayed_work + lockless guard
 *   1  control:           cancel_delayed_work_sync (>=6.9 swallows re-arm)
 *   2  F-028 vuln shape:  cancel_delayed_work (non-sync) + unconditional re-arm
 *   3  F-026 vuln shape:  cancel_delayed_work (non-sync) + guard check/queue
 *                         race window (test passes, teardown slips in before
 *                         the queue_delayed_work)
 *
 * Every vuln mode must produce KASAN slab-use-after-free when the orphaned
 * work fires after kfree; the control mode must stay clean.
 */
#include <linux/module.h>
#include <linux/workqueue.h>
#include <linux/slab.h>
#include <linux/delay.h>

static int mode;
module_param(mode, int, 0444);
MODULE_PARM_DESC(mode, "0=flush(F-029) 1=cancel_sync(ctrl) 2=cancel_nosync(F-028) 3=cancel_nosync+guard-race(F-026)");

struct pm_td_ctx {
	bool			fini_pending;
	struct delayed_work	work;
};

static struct pm_td_ctx *ctx;

static void pm_td_cb(struct work_struct *w)
{
	struct pm_td_ctx *c = container_of(to_delayed_work(w),
					   struct pm_td_ctx, work);

	pr_info("PM-POC: cb running, fini_pending=%d\n", c->fini_pending);

	switch (mode) {
	case 0:		/* F-029: lockless guard then long body then re-arm */
		if (c->fini_pending)
			return;
		msleep(300);
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed (flush shape)\n");
		break;
	case 2:		/* F-028: unconditional re-arm, cancel must catch running cb */
		msleep(300);	/* long body so cancel lands mid-run */
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed (no guard)\n");
		break;
	case 3:		/* F-026: guard check passes, THEN teardown slips in */
		if (c->fini_pending)
			return;
		/* widen the check->queue race window like ipoib's 724->725 */
		msleep(300);
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed past guard (test-queue race)\n");
		break;
	default:
		break;
	}
}

static int __init pm_poc_init(void)
{
	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
	if (!ctx)
		return -ENOMEM;
	ctx->fini_pending = false;
	INIT_DELAYED_WORK(&ctx->work, pm_td_cb);

	pr_info("PM-POC: arming, mode=%d\n", mode);
	schedule_delayed_work(&ctx->work, 0);

	msleep(50);	/* callback is mid-run now */

	/* teardown sequence for the selected variant */
	ctx->fini_pending = true;
	switch (mode) {
	case 1:
		cancel_delayed_work_sync(&ctx->work);
		break;
	case 0:
		flush_delayed_work(&ctx->work);
		break;
	default:
		cancel_delayed_work(&ctx->work);	/* non-sync: C variants */
		break;
	}

	pr_info("PM-POC: teardown done, freeing ctx\n");
	kfree(ctx);

	msleep(600);
	pr_info("PM-POC: SURVIVED (no KASAN splat)\n");
	return 0;
}

static void __exit pm_poc_exit(void) { }

module_init(pm_poc_init);
module_exit(pm_poc_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("drv-teardown-sync C/D variant mechanism PoC (F-026/028/029)");

 drivers/accel/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 09b27bac3a..4635dc8572 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2487,7 +2487,7 @@ void hl_device_fini(struct hl_device *hdev)
 	dev_info(hdev->dev, "Removing device %s\n", dev_name(&(hdev)->pdev->dev));
 
 	hdev->device_fini_pending = 1;
-	flush_delayed_work(&hdev->device_reset_work.reset_work);
+	disable_delayed_work_sync(&hdev->device_reset_work.reset_work);
 
 	if (hdev->pldm)
 		reset_sec = HL_PLDM_HARD_RESET_MAX_TIMEOUT;
-- 
2.25.1

