Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725633;
	b=aZ7flpMwryi4Ki/ygBMFhH2Y1DwCs2i9L3cRSclxiZODnUyerZcnbjU3eubyOiuTQFNt
	 eolC/S79EQwJsMpV0+l+5zvttsgjQdUSo3ek59pnYKzDWnjXCIU2LErcxGMS0e+5sGDsA
	 O2P3sVl71d+tBSaYfXqUtNqRn20wIEA7CQNH2f0L/AnNZ/mCxIHgBIJKCPjdKvIkAGUb+
	 B4tWAn8eQfVyIqHSr9MEE9rT5RiO7ltyKLcX6MChUogKRt7DCF1jA9u8tSJzMMZ0UY8tU
	 Kb/2GH3fUA45PN7d/TLvwWDg5ZQBR1vGWDhnt/DXMgZ6/yRQI38s3LYfhr69J7tpytA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U+uq6o7h5QCzlT0B6D4QGcxxj9excjN11FXi6rk4g1s=;
	b=TYuWNJuyTLIhYQsb9ADLNr0RHpWhb1yk6rHMAAulF8qaVlSbhbeGvesz4SrXGUVIosBw
	 ROxQYtKhoGNU/U7Z6mhCtK51DEmlj8DhLrH52sjldMcJqUJS0Bb4dn5FFymX6SQRjwnZP
	 Pmwk9tIdRSRwZWzxTdvD1B2VqSZB8+R65RyY80dyIkNS2tm4jU0JSbN6kvMOub+VJUWad
	 oWhtym5t/mGcquNQRK2sXTpegcWO2V0k2ys7Dcq1KVvhYhTewcRAhbL39yGJHTpmKJD7f
	 oJp7LYvj5eWt+brRq5v0ZOKkpFEgL6TEajFelurV6YKYBpTwF8cWveW2AbUU/aGNogA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGWyDvgf;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889B606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6889B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGWyDvgf
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-17e82de56ccso104263c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793725632; x=1794330432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+uq6o7h5QCzlT0B6D4QGcxxj9excjN11FXi6rk4g1s=;
        b=iGWyDvgfWA7BABkCv2yaRDP+Ci1wwzDKEsG2/WxT2q3MSsLyE3lSmy32j0dnvGTIiE
         G5iBtFTfje+3OwTTkO8OdTrFB7+DyS1zn8lDkvVtr8uh/gazstnu4y5yedxcqwvXkL9k
         45WcsTyH83pI4bphWwo5FHm2HBZ9Go3Sv2CP2HuZv/qD+IgTIGutraHmvob4MydjsFyS
         NIpaywLWw9Ckc+LoCPi3nBL5l3GOWA7ut4LBQd/QIIKPun0kpsJo5KptsWZVy2n4YY8V
         cvRQrKTVD8AhAQKbUEUCQXvbcReKRMhijrvPG849xYBKMVlS10FaUjb2kN+6+cFJy4my
         0R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725632; x=1794330432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+uq6o7h5QCzlT0B6D4QGcxxj9excjN11FXi6rk4g1s=;
        b=2ebrYr2WyWz9It8fahiMTObSw63BVok4gMcu4F97e0B+YkqGm+mFGtgdWfshY8Ec5Z
         CTsdzMmi3NqsTv4ow3sdP7ZOQ/Zkx2WyHlMbn4sk0W43DM3XOgqMVhXaHCGeciKU9ztV
         VjrWmXnAOzX7F4BpceYapW1x7T+yJnspAdlCJQxRLXT/5MDmkyt4pMenTF1HjOXHdAjU
         uNpyjQJbwIm5OblTNzVgLrvHDg2ONfruJw0R2XMOjk9H5VupWt2U8RB4CJOjRj0jaQ34
         +cRusD6f/qeheNyuOJ60jkGhH9w7G7pGDvWI7Xej6Gj1w3l1T/rEYP48klHkXRmvHc6X
         ZIVw==
X-Forwarded-Encrypted: i=1; AKwUvBxsLL2fPHUZmXt8XHo9E/ZSrzaaKaoTe3uKQHaeGoD/USnvgjJ5TdJSWZN5Dna/saRRo8+NalY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JY0W5isthqkc+GHaf//Pft41Tx9jrXhd1qKfht5gZw5yHZTus
	4PhXJ1XuW0aVVNgJw9iX8N2TVb404mmWxQheODN72PrkIMeaQdUdmayC
X-Gm-Gg: AYBFou1eUgQ7O0WDmqz2owRY+ASw/2cAVfkmcddcPrtXKEpb4TKTg2f2pyPzWLxPKx/
	q2fKAGCylPdyLwOrA2R7jpQNrSmSFRnD9hdvqKtdE4m494rPVlzvYgM/Ta/IiG1pd+f+kyyak8v
	nXa6uICmfCJBnYPc2CgyfmaWpy/LlIB3MdqBWAY9UFVf20/nImZqSBAImHTzQJpuTWwB7al0xPN
	W4MFMs+BrCqrfxxeNWLuoIsH0TumSOQpRfLQpmDkPQAyP2iDpPxHASImzx9mtAjxrVbnq2JFXF0
	R9ImZyZJh1X0WH2rq0Q/5iJcqLW4jJRaZ/XquOHOGEtQNDXlcnAHrjLsaqaLtoe6vwX0SAYSHtC
	8UtvP660yQLs0XTJAnFxtVueI2afj2JRHaALkh7ms2eCefGMDJALzW+04odKQA8Ypw2MCYYe28U
	j3ynrF2Br0FGoluM9mN1ICgtwUC7Eoz50L6bZG526QtTvlUyVlmmOwzzIIwCCy6VvqOLK+DvVTS
	rXuDcMYH27D/MCormcJsI4Up4ogUZLW32Nlb9JU12swrQVcGG8PTNbIqf0BalJNw5/N8F8EkojA
	gC6Br5NgVo0ijZ2cOmSDzUVJ0MctcKY5Aea8cFlKeA==
X-Received: by 2002:a05:701b:2515:b0:17f:641e:7f6b with SMTP id a92af1059eb24-1ac5904ae73mr28989298c88.1.1793725632414;
        Tue, 03 Nov 2026 09:07:12 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b87c4asm305684c88.3.2026.11.03.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:07:12 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/ipoib: cancel the AH reaper work synchronously
Date: Wed,  4 Nov 2026 01:07:03 +0800
Message-Id: <20261103170703.1600310-1-lui2012qwq@gmail.com>
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

ipoib_stop_ah_reaper() uses cancel_delayed_work(), which cannot stop a
callback that is already running.  ipoib_reap_ah() re-arms itself after
an unlocked test_bit(IPOIB_STOP_REAPER) check, so a callback that has
passed the check but has not re-armed yet still queues the delayed work
after the "stop":

  CPU0 (reaper)                     CPU1 (stop/teardown)
  test_bit(STOP_REAPER) == 0
                                    set_bit(STOP_REAPER)
                                    cancel_delayed_work()  (no-op)
                                    ... destroy_workqueue(priv->wq)
  queue_delayed_work(priv->wq, ...)  <- delayed work sits on the timer

destroy_workqueue() cannot see a delayed work that is pending on the
timer wheel, so the re-armed work fires after the workqueue is
destroyed and priv is freed: both the queueing onto the dead queue and
the callback's container_of() on freed memory are use-after-free.

Use cancel_delayed_work_sync(), which waits for a running callback and
prevents its re-arm from taking effect.

The comment above claims ipoib_reap_dead_ahs() "ensures the work is
really stopped", but it never touches the work item - it only walks the
dead_ahs list under priv->lock.  The stop guarantee comes from the
cancel; fix the comment along with it.

Found by static analysis.  The race was reproduced on a KASAN build
with a small module exercising this exact guard/cancel/free pattern
(no Infiniband hardware available); PoC and splat are below.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---

Reproducer notes (PoC source below; a module parameter selects the
shape): mode=3 (cancel_delayed_work + lockless guard race, this bug's shape) produces

    [    2.05] BUG: KASAN: slab-use-after-free in queue_delayed_work_on+0x27/0x70
    [    2.05] Workqueue: events pm_td_cb [pm_flush_poc]

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

 drivers/infiniband/ulp/ipoib/ipoib_ib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 81bbb3f7c1..5ed4f709cb 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -736,11 +736,11 @@ static void ipoib_start_ah_reaper(struct ipoib_dev_priv *priv)
 static void ipoib_stop_ah_reaper(struct ipoib_dev_priv *priv)
 {
 	set_bit(IPOIB_STOP_REAPER, &priv->flags);
-	cancel_delayed_work(&priv->ah_reap_task);
+	cancel_delayed_work_sync(&priv->ah_reap_task);
 	/*
 	 * After ipoib_stop_ah_reaper() we always go through
-	 * ipoib_reap_dead_ahs() which ensures the work is really stopped and
-	 * does a final flush out of the dead_ah's list
+	 * ipoib_reap_dead_ahs() which does a final flush out of the
+	 * dead_ah's list
 	 */
 }
 
-- 
2.25.1

