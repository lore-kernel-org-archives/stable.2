Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831616;
	b=4rjTEGfsuJSgw3xVApgC3PiTTL8IbdxVWcqrQz7CIdxzVcPvTRwfY+0YGUQ9IsXkrtrR
	 ozeus8oPCHj/A8BvljMdIWzZ5KiSfRhfvoFvvfM6zZbeaJgPexA+8QKpAt/sgEuUffk/u
	 hCVuyxKhZtsuYefdSgTy+QrLnSwM+QInxZMamaIaHdsPZIP2dnSHvyoCQi6LHi9muTHeS
	 1RjzSD+P+ZbmjdimYjIuAkiBfc2PTYs0GUDRnCo1ClGgorKPkx7eO6xXUJ70Drh1WgJ0U
	 6DXyP5Q+PIpaOCv6wn8CtsjUb0Fv6T9F5ChfPBGELoQDf9tW+sTh+nsDz4sVtmG4S2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9l8aY4duwod5oh83bsEItxoT9PT8GG4ui0y9GtWOeCM=;
	b=C8U3BS9WEVjCLHEBV91MYgbGZ9lyCuYiqhExFUNjPGwL1kxoljFrZjNu4VCTkwlluqC1
	 lucQyUyoVduwHMIs9Q07iqhiaOsn55a3xRbzl3TfFZgfrnvS8xPPvQpbAjYsywptxY2vB
	 I0dD/ZEEFoiXEhqfhadVlUFGM2xTx/Xi+62XhdGjTU2Ds8vxJT4Lb9xJrghZowEDtxpMs
	 Oi9ex6f0RZk7mQ0ZdaZw8EutiArEv+2bzeRhyB8dSCdqCHr669kXSc0AvcouQXfdk6bQe
	 uOJNqsmtdWvPF3dxwnatpwFQiO8RwXgUiXmedb+2y90naJgUk77dxCB1CLLot6OC0Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lneGMFV+;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972F606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2972F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lneGMFV+
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ccca948203aso1477229a12.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 04:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794831615; x=1795436415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9l8aY4duwod5oh83bsEItxoT9PT8GG4ui0y9GtWOeCM=;
        b=lneGMFV+wKAhDHuklL7r7rmuDU1G+ohCB4sjR4HTq97HsrFQKSL142I0WnDGcBQ5Jz
         94EuFbYp2+s4LFmZACzhLbPYf+qukzpoCka8VjJgJt8m8HC2jnpWNEpO/X0GkgA6nSzM
         MyFWQKlhyLyJqaOlVooBax+FFG/fDHiwrfSESdWtwE6LbEZGRwHcBfep6TSro8LNuq/S
         hhK1t8VTuafpoaG/SDyUysnkeqF3hMhKckXdh3PczdZwskyhB4IYd7gyiMJV4UL481lC
         rPoOfeIRm9aj5jqgfambREQeMskvrfeHLlYf4g5yEhLuZZkJz1cuX27JSji/MJwyHQ/+
         a3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794831615; x=1795436415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9l8aY4duwod5oh83bsEItxoT9PT8GG4ui0y9GtWOeCM=;
        b=h+whTsRO9yvzkOhnS9h7G1y0njD+xvlT5W7v/Z7PO8YLaV4burS2clzCOeDKMNnEJ6
         jFRwcRELk0ZDmrR9ah+IVBhdKcoAeyjLpXUCyikjYqhaq9xhR7IMDxDX6S5yC4eZVZmk
         B02Qo/3qMSTgbtng/FG4vQn4WtWlpQg8YdD/jeq04GGAmFGUvThvjcXDKKIxO9KcfnyT
         ykeUCqvspDNMyvWhZn3gnLa2bcqiHsvT/Je2eQu7Yz+s2i+IYBy1ZD41pig0Qdn4ViH0
         W4ItOwC4Kc5vCWYrzw3nvkSaCam5qSaiwk8yKeikURs49QOSUpo7ez8KSJtwGXzNbmjz
         3YKg==
X-Forwarded-Encrypted: i=1; AL+hErFPr8WGKNVR9VcEhs30X1NLKXn6xhHvMZnd4WmcQeGaoxkv9ov9Q4C+AoqFA8oVYlWdHTCHUaI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cJ7KLXlSLC4pXbXYxSXjOVktkm4FgHkg713ReP6HjUQRm7Irp
	Kvau1HZ9KWLHhgna491WD1knrZbMU7t/6u/96aTHYSPBMSga9ONoPA4c
X-Gm-Gg: AZFdTZcPXoarWNTeQMGoHGVFgIVkYhBwmzOuwenRAkmHJ2QVkI+vigtYLtujGLgkaoD
	okZLb4epWMxgql3eDxtvwrZShcDZaUpQZ75cAmOFgSQreehgpPFI6yF+f1byPTt5mNiZ6lCyuNy
	zgGFtJb/6T2zmDTBDY1QXODGE11VHmC5+AOa1UCPR9UoeN3zubDy+sPOD9VC594LPoSNDGqa2k/
	fmxlf4YShqBEaKM5gA8SqzSO4xMaqkPV0FRuukZby9zA1/BULjWwx0/5AalyPlMQn5WdtnaD/oA
	cz50iEJgHMOCcN0RIt2QdMpdOfx98/THBSLCB4Sv8TSqzXdWhJs3RUc9yO+cx+h3Elc9krq2kUc
	GDb1posPjt7t1075R9D+bvrhJBTWMCxjllkSpX6mMWhEYZY+2ZabviCH7Pxma6lJM7RSiZqWnyp
	crtV9bZ9GBSTmw2iuQunXvgfECveaGQ5yBDP1Dl0OdStJZLd2Je5Y9mvVdixiEm1we3PKXlJd3O
	APJZnQtUc4vgfdZ6BpBUu2x5sVo4YtjoMjN8GeZ43+PNFhDm/KGpFgMH2iZT6n2dqnr9MFlhoM7
	uHvRtVJ3fZNAWZ5nyu1s2j+olPnK2jnkRj6TBTDRYwV0c8FY
X-Received: by 2002:a17:90b:1d03:b0:3ab:c80:9365 with SMTP id 98e67ed59e1d1-3b1b0b4cdf7mr9314366a91.42.1794831615263;
        Mon, 16 Nov 2026 04:20:15 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm21783990a91.16.2026.11.16.04.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:20:14 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Rong Zhang <i@rong.moe>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v3] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: cancel work on teardown
Date: Mon, 16 Nov 2026 21:20:01 +0900
Message-ID: <20261116122001.3096223-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

fc->work is scheduled from the extcon notifier callback
yt2_1380_fc_extcon_evt() (and once from probe), but it is never cancelled.
The containing struct yt2_1380_fc and the extcon notifier are both
device-managed on the serdev device, and the serdev driver has no
->remove callback, so teardown happens entirely via devres unwinding
when yt2_1380_fc_pdev_remove() calls serdev_device_remove().

devm_extcon_register_notifier_all() unregistering on teardown only stops
future notifications; it does not drain a work item that the notifier has
already queued. A fast-charger extcon event that races device unbind can
therefore queue fc->work just before teardown; the work then runs after
devres has torn the device down. yt2_1380_fc_worker() dereferences not
only fc itself but also fc->pinctrl (pinctrl_select_state()) and the
serdev (serdev_device_write_buf()), so it must be drained before those
device-managed resources are released, not merely before fc is freed.

Initialize the work with devm_work_autocancel(), placed after the serdev
is opened and pinctrl is acquired but before
devm_extcon_register_notifier_all(). Because devres runs cleanup in
reverse order, teardown then unregisters the notifier first (so it can no
longer queue the work), next cancels the work while fc->pinctrl and the
serdev are still valid, and only then closes the serdev, releases pinctrl
and frees fc. This closes both the re-arm window and the use-after-free
of fc and of its sub-resources in the worker.

Found by static analysis / code review; compile-tested only, not
reproduced on hardware (requires the Lenovo Yoga Tablet 2 1380 charger).

Fixes: b2ed33e8d486 ("platform/x86: Add lenovo-yoga-tab2-pro-1380-fastcharger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v3:
 - Use devm_work_autocancel() instead of a hand-rolled
   devm_add_action_or_reset(cancel_work_sync) (suggested by Ilpo Jarvinen).
   It is placed at the same point in probe (after devm_serdev_device_open()/
   devm_pinctrl_get(), before devm_extcon_register_notifier_all()) so the
   reverse-order devres teardown still drains the work after the notifier is
   unregistered but while fc->pinctrl and the serdev are still live. Moving
   INIT_WORK() down into devm_work_autocancel() is safe: fc->work is only
   scheduled from the extcon notifier and from the probe-tail schedule_work(),
   both after this point.
 - Add Cc: stable (this is a use-after-free fix).
v2:
 - Move the work-cancel registration from right after INIT_WORK to after
   devm_serdev_device_open()/devm_pinctrl_get() and before the extcon
   notifier, so devres (LIFO) drains the work while fc->pinctrl / serdev are
   still valid rather than after they are released.
 .../x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 8551ab4d2c7d..c2fe919a3ce9 100644
--- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/extcon.h>
@@ -160,7 +161,6 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 
 	fc->dev = dev;
 	fc->nb.notifier_call = yt2_1380_fc_extcon_evt;
-	INIT_WORK(&fc->work, yt2_1380_fc_worker);
 
 	/*
 	 * Do this first since it may return -EPROBE_DEFER.
@@ -209,6 +209,18 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 	serdev_device_set_baudrate(serdev, 600);
 	serdev_device_set_flow_control(serdev, false);
 
+	/*
+	 * Initialize fc->work with automatic cancellation on teardown.  This is
+	 * registered after the serdev is opened and pinctrl is acquired, but
+	 * before the extcon notifier: devres unwinds in reverse, so teardown
+	 * unregisters the notifier first (no new work can be queued), then
+	 * cancels the work while fc->pinctrl and the serdev are still valid, and
+	 * only then closes the serdev and releases pinctrl.
+	 */
+	ret = devm_work_autocancel(dev, &fc->work, yt2_1380_fc_worker);
+	if (ret)
+		return ret;
+
 	ret = devm_extcon_register_notifier_all(dev, fc->extcon, &fc->nb);
 	if (ret)
 		return dev_err_probe(dev, ret, "registering extcon notifier\n");
-- 
2.43.0

