Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89EC3E834D;
	Tue,  2 Jun 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406938; cv=none; b=B6gQo4oc1WkXX1upsqFMihX2fIj0CmWMHbeQwXDAzcqIupiGU8+9OI046pUdoaQZ0vtipyNbLPTP5wk/1NlTu/SdP+zf6DiZYMWJW4kyUqqdqDplIyE9NCinL4Y0W65LcBmELFg9sYOrN5DGUb6Pil5C3thT+06oeZREG6N9QPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406938; c=relaxed/simple;
	bh=8SjuhPrv3uabNPKI6MGxfl/0UPfL1oNjBVyA8yOzaow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl+RQBI+yrJonSyYbbDHXbGo3Cj3LiV53EOchCfLJaQo/+hewmm4PEn7krNyJNg0RMuEoYXJmWDui6SFb1DXP7xEyfKtL2CfW+wxgyGvjiOVU8naVirgqlCkotq7Uv5CpijbkoqaK0koQvtcTyCSbcsuua8rx7mig9EyRbsldNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djnFz0XS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djnFz0XS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296061F00893;
	Tue,  2 Jun 2026 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406936;
	bh=ce6d448Crr+TTQaxq3i+6pbkRz+e4tsfgiKlchCYn5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=djnFz0XSIoV+rS5SKfgIiOxrRnONNwsmlTYRXAUsGLo58IRbKzd4QP/BhMM/7CGC5
	 nGMWaT1mGSFyAsZDlj4pO5lWMIs1Duab+YCjB9jTmIgq9Q1dM0eTgL5Vmg3y6jkVd/
	 q9JidZnJqVR3BafwBHnnlqiiTqniDkpO0hj+TqQmuGvIcffxC9vSplL3Qfvk/fpcyk
	 U0subqqoLzJ+LMs3LG6oY8Cqf79oeX69eruR7RntnU+keGgQ8CVSVgGNYhDKc37ptk
	 VcNneqtC8CQN1xe98QjJJvVSjGeCB6kzXh2RDZPE5HyLGaS6E25FWTIblEcno3m8Sz
	 KMfbjtiUSzZew==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 06/17] i3c: renesas: Perform Dynamic Address Assignment on resume
Date: Tue,  2 Jun 2026 16:28:13 +0300
Message-ID: <20260602132824.3541151-7-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
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

To cover the case where the controller had already attached all the
i3c->maxdevs devices before a suspend/resume cycle and i3c->free_pos is
zero, struct renesas_i3c::resuming flag was introduced.

The flag is set in renesas_i3c_resume() before calling
i3c_master_do_daa_ext() and checked in renesas_i3c_daa(). In case it is
set the previous saved DATBAS register values are used for the slots
already occupied before suspend. This allows keeping alive the connection
to the I3C devices when all the supported slots are occupied before
suspend.

When resuming from suspend, renesas_i3c_daa() re-runs DAA for al
slots except those used by I2C devices. I2C devices are attached during
probe, at bus initialization time, and always occupy the first positions in
i3c->free_pos. In addition, there are no DATBAS register settings
associated with them.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- adjusted the code to still work in case the full bus was occupied before
  a suspend/resume cycle; for that:
-- introduced struct renesas_i3c_addr
-- preserved i3c->DATBASn[] which is saved in suspend and used in resume,
   in renesas_i3c_daa()
- updated the patch description to reflect the new updates

 drivers/i3c/master/renesas-i3c.c | 103 ++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 28 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 7ef317b2ba39..695aae6ac263 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -252,6 +252,11 @@ struct renesas_i3c_xferqueue {
 	spinlock_t lock;
 };
 
+struct renesas_i3c_addr {
+	bool is_i2c;
+	u8 addr;
+};
+
 struct renesas_i3c {
 	struct i3c_master_controller base;
 	enum i3c_internal_state internal_state;
@@ -262,13 +267,14 @@ struct renesas_i3c {
 	u32 i3c_STDBR;
 	u32 extbr;
 	unsigned long rate;
-	u8 addrs[RENESAS_I3C_MAX_DEVS];
+	struct renesas_i3c_addr addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
 	u32 *DATBASn;
 	struct clk_bulk_data *clks;
 	struct reset_control *presetn;
 	struct reset_control *tresetn;
+	bool resuming;
 	u8 num_clks;
 	u8 refclk_div;
 };
@@ -335,7 +341,7 @@ static int renesas_i3c_get_addr_pos(struct renesas_i3c *i3c, u8 addr)
 	int pos;
 
 	for (pos = 0; pos < i3c->maxdevs; pos++) {
-		if (addr == i3c->addrs[pos])
+		if (addr == i3c->addrs[pos].addr)
 			return pos;
 	}
 
@@ -480,8 +486,8 @@ static int renesas_i3c_reset(struct renesas_i3c *i3c)
 	renesas_writel(i3c->regs, BCTL, 0);
 	renesas_set_bit(i3c->regs, RSTCTL, RSTCTL_RI3CRST);
 
-	return read_poll_timeout_atomic(renesas_readl, val, !(val & RSTCTL_RI3CRST),
-					0, 1000, false, i3c->regs, RSTCTL);
+	return read_poll_timeout(renesas_readl, val, !(val & RSTCTL_RI3CRST),
+				 0, 1000, false, i3c->regs, RSTCTL);
 }
 
 static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
@@ -641,8 +647,9 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 {
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 	struct renesas_i3c_cmd *cmd;
-	u32 olddevs, newdevs;
 	u8 last_addr = 0, pos;
+	int last_i2c_pos = -1;
+	u32 olddevs, newdevs;
 	int ret;
 
 	struct renesas_i3c_xfer *xfer __free(kfree) = renesas_i3c_alloc_xfer(i3c, 1);
@@ -657,14 +664,33 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 
 	/* Setting DATBASn registers for target devices. */
 	for (pos = 0; pos < i3c->maxdevs; pos++) {
-		if (olddevs & BIT(pos))
+		if (olddevs & BIT(pos)) {
+			/*
+			 * In case of resume, reassign DAs for all devices on the
+			 * bus to avoid failures when all i3c->maxdevs slots were
+			 * already occupied before suspend.
+			 *
+			 * Exclude I2C devices, as they are attached during probe,
+			 * at bus initialization time, and there are currently no
+			 * register updates associated with them.
+			 */
+			if (i3c->resuming) {
+				if (i3c->addrs[pos].is_i2c) {
+					last_i2c_pos = pos;
+				} else {
+					renesas_writel(i3c->regs, DATBAS(pos),
+						       i3c->DATBASn[pos]);
+				}
+			}
+
 			continue;
+		}
 
 		ret = i3c_master_get_free_addr(m, last_addr + 1);
 		if (ret < 0)
 			return -ENOSPC;
 
-		i3c->addrs[pos] = ret;
+		i3c->addrs[pos].addr = ret;
 		last_addr = ret;
 
 		renesas_writel(i3c->regs, DATBAS(pos), datbas_dvdyad_with_parity(ret));
@@ -674,9 +700,21 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 	cmd = xfer->cmds;
 	cmd->rx_count = 0;
 
-	ret = renesas_i3c_get_free_pos(i3c);
-	if (ret < 0)
-		return ret;
+	if (i3c->resuming) {
+		/* Nothing to do if all slots are ocupied by I2C devices. */
+		if (last_i2c_pos == i3c->maxdevs - 1)
+			return 0;
+
+		/*
+		 * Do DAA for all the devices on the bus, if resuming, except
+		 * the I2C ones.
+		 */
+		ret = last_i2c_pos < 0 ? 0 : last_i2c_pos + 1;
+	} else {
+		ret = renesas_i3c_get_free_pos(i3c);
+		if (ret < 0)
+			return ret;
+	}
 
 	/*
 	 * Setup the command descriptor to start the ENTDAA command
@@ -694,7 +732,7 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 
 	for (pos = 0; pos < i3c->maxdevs; pos++) {
 		if (newdevs & BIT(pos))
-			i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
+			i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos].addr);
 	}
 
 	return 0;
@@ -876,11 +914,11 @@ static int renesas_i3c_attach_i3c_dev(struct i3c_dev_desc *dev)
 		return -ENOMEM;
 
 	data->index = pos;
-	i3c->addrs[pos] = dev->info.dyn_addr ? : dev->info.static_addr;
+	i3c->addrs[pos].addr = dev->info.dyn_addr ? : dev->info.static_addr;
 	i3c->free_pos &= ~BIT(pos);
 
 	renesas_writel(i3c->regs, DATBAS(pos), DATBAS_DVSTAD(dev->info.static_addr) |
-				    datbas_dvdyad_with_parity(i3c->addrs[pos]));
+				    datbas_dvdyad_with_parity(i3c->addrs[pos].addr));
 	i3c_dev_set_master_data(dev, data);
 
 	return 0;
@@ -898,19 +936,19 @@ static int renesas_i3c_reattach_i3c_dev(struct i3c_dev_desc *dev,
 
 	if (data->index != pos && pos >= 0) {
 		renesas_writel(i3c->regs, DATBAS(data->index), 0);
-		i3c->addrs[data->index] = 0;
+		i3c->addrs[data->index].addr = 0;
 		i3c->free_pos |= BIT(data->index);
 
 		data->index = pos;
 		i3c->free_pos &= ~BIT(data->index);
 	}
 
-	i3c->addrs[data->index] = dev->info.dyn_addr ? dev->info.dyn_addr :
+	i3c->addrs[data->index].addr = dev->info.dyn_addr ? dev->info.dyn_addr :
 							dev->info.static_addr;
 
 	renesas_writel(i3c->regs, DATBAS(data->index),
 		       DATBAS_DVSTAD(dev->info.static_addr) |
-		       datbas_dvdyad_with_parity(i3c->addrs[data->index]));
+		       datbas_dvdyad_with_parity(i3c->addrs[data->index].addr));
 
 	return 0;
 }
@@ -922,7 +960,7 @@ static void renesas_i3c_detach_i3c_dev(struct i3c_dev_desc *dev)
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 
 	i3c_dev_set_master_data(dev, NULL);
-	i3c->addrs[data->index] = 0;
+	i3c->addrs[data->index].addr = 0;
 	i3c->free_pos |= BIT(data->index);
 	kfree(data);
 }
@@ -1002,7 +1040,8 @@ static int renesas_i3c_attach_i2c_dev(struct i2c_dev_desc *dev)
 		return -ENOMEM;
 
 	data->index = pos;
-	i3c->addrs[pos] = dev->addr;
+	i3c->addrs[pos].addr = dev->addr;
+	i3c->addrs[pos].is_i2c = true;
 	i3c->free_pos &= ~BIT(pos);
 	i2c_dev_set_master_data(dev, data);
 
@@ -1016,7 +1055,8 @@ static void renesas_i3c_detach_i2c_dev(struct i2c_dev_desc *dev)
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 
 	i2c_dev_set_master_data(dev, NULL);
-	i3c->addrs[data->index] = 0;
+	i3c->addrs[data->index].addr = 0;
+	i3c->addrs[data->index].is_i2c = false;
 	i3c->free_pos |= BIT(data->index);
 	kfree(data);
 }
@@ -1435,7 +1475,7 @@ static void renesas_i3c_remove(struct platform_device *pdev)
 	i3c_master_unregister(&i3c->base);
 }
 
-static int renesas_i3c_suspend_noirq(struct device *dev)
+static int renesas_i3c_suspend(struct device *dev)
 {
 	struct renesas_i3c *i3c = dev_get_drvdata(dev);
 	int i, ret;
@@ -1466,10 +1506,10 @@ static int renesas_i3c_suspend_noirq(struct device *dev)
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
@@ -1495,15 +1535,23 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 	renesas_writel(i3c->regs, MSDVAD, MSDVAD_MDYADV |
 		       MSDVAD_MDYAD(i3c->dyn_addr));
 
-	/* Restore Device Address Table values. */
-	for (i = 0; i < i3c->maxdevs; i++)
-		renesas_writel(i3c->regs, DATBAS(i), i3c->DATBASn[i]);
-
 	/* I3C hw init. */
 	renesas_i3c_hw_init(i3c);
 
 	i2c_mark_adapter_resumed(&i3c->base.i2c);
 
+	i3c->resuming = true;
+
+	ret = i3c_master_do_daa_ext(&i3c->base, true);
+	if (ret)
+		dev_err(dev, "DAA failed on resume, ret=%d", ret);
+
+	i3c->resuming = false;
+
+	/*
+	 * I3C devices may have retained their dynamic address anyway. Do not
+	 * fail the resume because of DAA error.
+	 */
 	return 0;
 
 err_clks_disable:
@@ -1516,8 +1564,7 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops renesas_i3c_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(renesas_i3c_suspend_noirq,
-				  renesas_i3c_resume_noirq)
+	SYSTEM_SLEEP_PM_OPS(renesas_i3c_suspend, renesas_i3c_resume)
 };
 
 static const struct of_device_id renesas_i3c_of_ids[] = {
-- 
2.43.0

