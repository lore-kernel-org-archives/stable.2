Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198B4189D9
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947963; cv=none; b=f5zpckJh0EBXQYI7ec6GkTaN3pqYIiqcKpF+ybqfoCQQgYTrcEFmSE/fKamcvTsxbdFOeXX2fBF+X1+5Fgr75GpwL/z0qpTAc3hwnWInow48LMGBlF3umNoY0OrVfEiGo/4VMgQsiN5nP33IUCQpgV/q0o/bP/TnVj7MxgB+2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947963; c=relaxed/simple;
	bh=rUKg2lEbEKF1/6fRaBq+MRXhYFcsSMiVFbDM59i1uYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQXTVhCiCAv8unc+9gAftqayikNRgfZMqcn4d9hbaxvXdbePdC7n1G6qKGiUGMi5upbqIddBYHfvXz8/VLH+H5Sty6CIhiEwpsEkVbxwN03JJQz1I7qe/Vgj0AlcYwadKGGJ9nV8VIuZMmHxtrXr/HTPs8cAKHw6O9BHz2xeDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PJcM4ZK2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PJcM4ZK2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso983515f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1783947960; x=1784552760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7c25tAQuKLxSupdY9CktEZj3cba9VcnGd28lC32imf8=;
        b=PJcM4ZK2GkgcJ+n4l3XjEVtzBHZ/BdJcmbHGJFSRaGcJ//D2WMEU2AWM/ZxKV9DYoS
         qw+EaSNgIhz+Y9xkKYCQjMElzkd0DTOOAxtbvouqZ6ZUXSlVwZVEYguXhK3X2VsqefVu
         mHTJoowLfZnlbuoGG5bXn0bO+D4o6zZNcIyy5q/vGRHxyMUCUOVd0pH3vUbjbxoikRQt
         qLkCbBftTgZ0GZhgMxrmKwQh591K9pEleFfSosS/KDbiaKHY9S+SxHrQk3tnspn9Vb1p
         u+6Q6EckJlIKcVR46jhJvdAg9XdXCsxtpxKi4SNJzCe3xGWGzhlipCbJ3ljbW3fUg0sn
         drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947960; x=1784552760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7c25tAQuKLxSupdY9CktEZj3cba9VcnGd28lC32imf8=;
        b=FPSWXItX73FgT6W3WN4f6NgBQaw6RaJOgrPENf39V4qqvEjOcDothrIczlnRTxbwzc
         68G0qoRp2FKDxgJSzC3G6/+fwmYyjlskFxH8QcPJ9AbiAgLXcCmyfAD9JKvLVX17lrA9
         ykCMDV2AkxCqKlwq/t97qz2der64N52y08IOm/yWN/d04O4dnnSKgQH0bjIyJY5re1q8
         WPweuL7vfrDO4PjwEOJ5ywfgQ+Jv69LPO+kG87W3Q03laADeYREJmG9gShfhu3OTbOx0
         n9ciId367fvQjiUH5hXMC0XPHSeRuhzJCnItrCjj4MGLoE7RK5vqSLAo8LhdbtODw3/M
         NCbw==
X-Forwarded-Encrypted: i=1; AHgh+RpVDIP73483PSCadV9JejLvb5lQuLQ0RTrH6nr6ot95YDq/jgxsazJez1QeMgdlq9ClcADfSkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KiZ7Xx4ffzSGtUcB13HZHf2qeb7afDbTYGgp35FmJYoVp5Zu
	7xJa/SGamY9JEVSdQ4+GpuLns9uKOUKGHWA3BBv/Pb1YHue9FMPnfchZAyr+I5Vh0vI=
X-Gm-Gg: AfdE7cnrZw3BAF84u5kO8wCArUIOWPgmjqxyYUipi9FfTNEhqDWY9CNN7uLOU48OkCN
	emtNP9LPxAGHqVmLSjoTQcd3wri3HwM0CaxTF0uGb2h5V0v8yT1z5XOAYlhiYIAyHKtKk25ILez
	EFOH2nt7h/gb2i9uRoG3/QQR8Ro8uKzN8ktaIF6goi3hJEKetWgrH1Fc/7GD4u9juPaxvjzB6zx
	FnjjIt6YxNEjAhUV/q3nroQo+DngbEBtbZxt068k+UochTeid8b1/tiHRFNkXHcsxvE9HCJpaUr
	sy3tgKxmARvuJ83PRnFB/J3Cj437Z7+Az6NWHrp3tW1w+CPUNu3ngcGMv6el6vjJQbsmYt/YrmZ
	qi9/mv2ingf9rio/rFF5xpQuoMFSJYBCsGW9lTNlhK6sE0NCROqfknIV8Pp6eYbPSM6HpXmfx3X
	Mv7h6Tj8oW89EHBTybDn9BY7rr8K1axyrYdka+QjtjdggtrlYzDUD/fsawnj0hzsm9cwiUpzeNw
	O/uw4D2MA==
X-Received: by 2002:a05:6000:4283:b0:473:8f65:c978 with SMTP id ffacd0b85a97d-47f2dc8cd9bmr10407081f8f.1.1783947959860;
        Mon, 13 Jul 2026 06:05:59 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6402:500:e91e:fe5e:857b:d0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm25321609f8f.3.2026.07.13.06.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:05:59 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 06/17] i3c: renesas: Perform Dynamic Address Assignment on resume
Date: Mon, 13 Jul 2026 16:05:34 +0300
Message-ID: <20260713130545.568657-7-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC supports a power saving mode where power to most
SoC components, including I3C, is turned off.

On systems where the I3C devices also loses power during suspend (e.g. NXP
P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
resume.

Running DAA in the controller resume path restores communication. However,
DAA relies on interrupts for TX/RX, which are not available in the noirq
suspend/resume phase (unless they are wakeup interrupts). For this, the
suspend/resume callbacks were moved out of the noirq phase. Currently,
there is no identified use case on either the Renesas RZ/G3S or Renesas
RZ/G3E SoCs that requires the controller suspend/resume hooks to be part of
the noirq suspend/resume phase.

Since renesas_i3c_reset() is not called anymore in atomic context
update it to use read_poll_timeout().

Along with this, struct renesas_i3c::DATBASn and its usage were removed,
as they are no longer needed.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- restore it to the level of v1; the other scenarios updated by
  sashiko were already present w/ and w/o this patch and could be
  addressed incrementally
- updated the patch description

Changes in v4:
- used directly i3c_dev instead of i3c_dev->dev->desc
- fixed the swap in renesas_i3c_group_devs_in_slots() for i3c->addr[]

Changes in v3:
- added renesas_i3c_group_devs_in_slots(); along with it, the
  struct renesas_i3c_addr was updated with i3c_dev and i3c_dev
  and the attach/detach/re-attach APIs were adjusted accordingly
- dropped DATBASn member of struct renesas_i3c
- used i3c_master_reattach_i3c_dev_locked() to re-attach devices
  on a fully occupied bus
- in resume, moved i2c_mark_adapter_resumed() after i3c_master_do_daa_ext()
  since it can update the internal driver data structure i2c specific

Changes in v2:
- adjusted the code to still work in case the full bus was occupied before
  a suspend/resume cycle; for that:
-- introduced struct renesas_i3c_addr
-- preserved i3c->DATBASn[] which is saved in suspend and used in resume,
   in renesas_i3c_daa()
- updated the patch description to reflect the new updates

 drivers/i3c/master/renesas-i3c.c | 38 +++++++++++++-------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 6590da962592..acc30ed615ab 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -265,7 +265,6 @@ struct renesas_i3c {
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
-	u32 *DATBASn;
 	struct clk_bulk_data *clks;
 	struct reset_control *presetn;
 	struct reset_control *tresetn;
@@ -495,8 +494,8 @@ static int renesas_i3c_reset(struct renesas_i3c *i3c)
 	renesas_writel(i3c->regs, BCTL, 0);
 	renesas_set_bit(i3c->regs, RSTCTL, RSTCTL_RI3CRST);
 
-	return read_poll_timeout_atomic(renesas_readl, val, !(val & RSTCTL_RI3CRST),
-					0, 1000, false, i3c->regs, RSTCTL);
+	return read_poll_timeout(renesas_readl, val, !(val & RSTCTL_RI3CRST),
+				 0, 1000, false, i3c->regs, RSTCTL);
 }
 
 static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
@@ -1419,12 +1418,6 @@ static int renesas_i3c_probe(struct platform_device *pdev)
 	i3c->maxdevs = RENESAS_I3C_MAX_DEVS;
 	i3c->free_pos = GENMASK(i3c->maxdevs - 1, 0);
 
-	/* Allocate dynamic Device Address Table backup. */
-	i3c->DATBASn = devm_kzalloc(&pdev->dev, sizeof(u32) * i3c->maxdevs,
-				    GFP_KERNEL);
-	if (!i3c->DATBASn)
-		return -ENOMEM;
-
 	return i3c_master_register(&i3c->base, &pdev->dev, &renesas_i3c_ops, false);
 }
 
@@ -1435,17 +1428,13 @@ static void renesas_i3c_remove(struct platform_device *pdev)
 	i3c_master_unregister(&i3c->base);
 }
 
-static int renesas_i3c_suspend_noirq(struct device *dev)
+static int renesas_i3c_suspend(struct device *dev)
 {
 	struct renesas_i3c *i3c = dev_get_drvdata(dev);
-	int i, ret;
+	int ret;
 
 	i2c_mark_adapter_suspended(&i3c->base.i2c);
 
-	/* Store Device Address Table values. */
-	for (i = 0; i < i3c->maxdevs; i++)
-		i3c->DATBASn[i] = renesas_readl(i3c->regs, DATBAS(i));
-
 	ret = reset_control_assert(i3c->presetn);
 	if (ret)
 		goto err_mark_resumed;
@@ -1466,10 +1455,10 @@ static int renesas_i3c_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int renesas_i3c_resume_noirq(struct device *dev)
+static int renesas_i3c_resume(struct device *dev)
 {
 	struct renesas_i3c *i3c = dev_get_drvdata(dev);
-	int i, ret;
+	int ret;
 
 	ret = reset_control_deassert(i3c->tresetn);
 	if (ret)
@@ -1495,15 +1484,19 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYADV |
 		       MSDVAD_MDYAD(i3c->dyn_addr));
 
-	/* Restore Device Address Table values. */
-	for (i = 0; i < i3c->maxdevs; i++)
-		renesas_writel(i3c->regs, DATBAS(i), i3c->DATBASn[i]);
-
 	/* I3C hw init. */
 	renesas_i3c_hw_init(i3c);
 
+	ret = i3c_master_do_daa_ext(&i3c->base, true);
+	if (ret)
+		dev_err(dev, "DAA failed on resume, ret=%d", ret);
+
 	i2c_mark_adapter_resumed(&i3c->base.i2c);
 
+	/*
+	 * I3C devices may have retained their dynamic address anyway. Do not
+	 * fail the resume because of DAA error.
+	 */
 	return 0;
 
 err_clks_disable:
@@ -1516,8 +1509,7 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops renesas_i3c_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(renesas_i3c_suspend_noirq,
-				  renesas_i3c_resume_noirq)
+	SYSTEM_SLEEP_PM_OPS(renesas_i3c_suspend, renesas_i3c_resume)
 };
 
 static const struct of_device_id renesas_i3c_of_ids[] = {
-- 
2.43.0

