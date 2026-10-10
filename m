Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCF3E1680
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657571; cv=none; b=O3p9CbtM6ii4KY8MYjRBWEaAw7BXTu1JF46bFrUcC8MZCfYq67V+KlTsCBdZXisxbUReOJbBsseOX0ip+bT5VG41rHeC7XWT/6RvaFg/0d2yRj4nGn2UexS4phZ30r/9SdX7Nnt6UDh3mVwPaQ70NCWNenSYT2SUcx6RtisJl1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657571; c=relaxed/simple;
	bh=dZaTTC0Wk2r7oZ6PlUitiW2bVp+S29iRReXZiAX5ssY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kuTnBSgpxFbfxmFbXpmVcx7BC6Ql9dr2Svkp+tAXFDX9CMzlaQ6En3jHrk92LDt8ER4IPEfuyEw6VYRNkFhaqwzkSEmKsyB29qHXqO0qYJTG1e1+lFwFxSRMk/m75NKIut6uNaTsKSkb2M2FSS0kbNFQHItxuYq945Y6KPPdcpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etik.com; spf=pass smtp.mailfrom=etik.com; dkim=pass (1024-bit key) header.d=etik.com header.i=@etik.com header.b=0AA6BNeu; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=etik.com header.i=@etik.com header.b="0AA6BNeu"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j2CF409nzzJty;
	Sat, 10 Oct 2026 20:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etik.com;
	s=20210927; t=1791657559;
	bh=hpbKyiAs4ixgRkML8x+XI2Azl1HE8ScDj9HG6iBmjh4=;
	h=From:To:Cc:Subject:Date:From;
	b=0AA6BNeuWApkacD0soa/WxX91B465qvN1aq7zUxxExQVDWlGbtxl6xjznKc4AgKCg
	 YwzwYhxgFixKt96N8fU8GbtypJJLTI6gLSyG1Of0c2tQF3gqLnCcde+7G0G8KvD1/l
	 htu7tgj37rS2s/5drEYM+nBqSmN9BwvzKjM758Mg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j2CF308pJznhk;
	Sat, 10 Oct 2026 20:39:18 +0200 (CEST)
From: David Vornholt <dv@etik.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Vornholt <david@vornholt.online>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: Stop a power level change notification storm
Date: Sat, 10 Oct 2026 20:39:17 +0200
Message-ID: <20261010183917.146821-1-dv@etik.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: :8e558a56fdab348:ham:123049f310c9d1d
X-Infomaniak-Routing: alpha

From: David Vornholt <david@vornholt.online>

On a Lenovo ThinkPad X1 Carbon Gen 13 (BIOS N4BET78W 1.48, EC N4BHT61W
1.41, UCSI 1.0) with an HP E273m monitor connected, the PPM keeps
signaling a Negotiated Power Level Change although the power contract
stays the same, and signals it again right after it has been
acknowledged:

  ucsi_connector_change: port1 status: change=0040, opmode=3,
    connected=1, sourcing=0, partner_flags=2, partner_type=4,
    request_data_obj=1304b12c, BC status=2

This repeats about seven times a second for as long as the monitor stays
connected. Since commit a0d4618788f2 ("usb: typec: ucsi: Workaround for
missed op_mode change"), every Negotiated Power Level Change is handled
like a power operation mode change, so the driver reads the source PDOs
again, checks the alternate modes and the connector capability, and
registers the partner's PDOs again each time. Every UCSI command takes
about 50 ms of EC transactions on this machine. The EC GPE fires about
680 times a second, and irq/9-acpi and the kworkers keep a CPU busy.
Skipping that work for an unchanged contract only brings the rate down
to about 360 a second, because the PPM still signals every change and
the driver still reads the connector status and acknowledges it.

Keep handling the notification as before when the power operation mode
or the RDO changed, which the workaround for Dell's firmware relies on,
or when the source PDOs changed with it. Once the PPM has signaled it
ten times in a row with the same PD contract, each within a second of
the previous one and without a power operation mode change, disable the
notification with SET_NOTIFICATION_ENABLE and log it, and enable it
again when the partner on that connector is gone. The mask applies to
all connectors, so until then a contract change on another connector is
only handled with the next connector change that it does signal. This
PPM still reports the bit in the connector status change field. If the
PPM signals the notification while it is disabled, ignore it for an
unchanged contract, and send the mask again after another ten.

Resume and the reset after a timed-out role swap send ucsi->ntfy to the
PPM too. Update ucsi->ntfy and send it in one helper that holds
ppm_lock, so that none of them can send an outdated mask after another
one has changed it. Keep the new mask, and enable the notification again
later, even if the command fails, as the PPM may have applied it anyway.
Once ucsi_unregister() has disabled the notifications, don't send a mask
anymore.

Also forget the RDO when the partner goes away, so that the first
contract with the next partner counts as a new one.

With this, the PPM signals ten changes after the monitor is connected,
the driver disables the notification and the GPE rate drops to zero.
The ports, the partner and its 5 V/3 A power supply stay registered.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: stable@vger.kernel.org
Signed-off-by: David Vornholt <david@vornholt.online>
---

Notes:
    Changes in v2:
    - Enable the notification again when the partner on the connector that
      it was disabled for goes away, instead of leaving it disabled until
      the driver is unbound (Sashiko review).
    - Update ucsi->ntfy and send it to the PPM in one helper that holds
      ppm_lock, and use it on resume and in the reset path of
      ucsi_role_cmd() too, so that they can't send an outdated mask
      (Sashiko review).
    - No longer decide from ucsi->ntfy whether to ignore the notification.
      While it is disabled, ignore it for an unchanged contract, and send
      the mask again after another ten.
    - Keep the new mask, and enable the notification again later, even if
      SET_NOTIFICATION_ENABLE fails, and don't send a mask anymore once
      ucsi_unregister() has disabled the notifications (Codex review).
    - Start counting again after a power operation mode change, and don't
      count a power level change that comes with a source PDO change
      (Codex review).
    - v1: https://lore.kernel.org/r/20261010121026.84844-1-dv@etik.com
    
    Claude Code, an AI coding assistant, found the cause while I was looking
    into why irq/9-acpi kept a CPU busy, and wrote this patch and its
    description. Codex with GPT-6 Astra reviewed v2 before I sent it, and
    this version addresses its findings.
    
    Tested: v1 ported to v7.2.9 on the X1 Carbon Gen 13 with the HP E273m.
    The ucsi trace events show ten connector changes about 100 ms apart,
    one SET_NOTIFICATION_ENABLE and the warning, and no connector changes
    after that. GPE 0x6E went from about 680/s to 0/s.
    
    This version, ported to v7.2.9 on the same machine, with the monitor on
    the other port (con1): after the monitor is plugged in, the PPM signals
    the power level change about every 5 s, which doesn't count, and after
    about 50 s every 110 ms. After ten of those, the warning appears and
    SET_NOTIFICATION_ENABLE is sent once. The PPM still signals a power
    level change about every 5 to 15 s for another 45 s, which the driver
    ignores (no GET_PDOS), and then stops. GPE 0x6E goes to about 1/s.
    Unplugging the monitor sends SET_NOTIFICATION_ENABLE again, and after
    plugging it back in, the next storm is caught the same way. I did that
    twice.
    
    Against usb-linus, this version is only compile-tested (x86_64 defconfig
    with TYPEC_UCSI=m and UCSI_ACPI=m, W=1) and passes checkpatch --strict.
    
    Not tested: this version on con2; other PPMs, in particular Dell's that
    rely on a0d4618788f2; other partners on this laptop; suspend and resume
    with the notification disabled; the reset path of ucsi_role_cmd(); a
    failing SET_NOTIFICATION_ENABLE; unbinding while connector work runs;
    sparse (the version available to me was too old).
    
    If enabling the notification again fails, it's only retried when the
    next partner on that connector goes away, or sent again on resume.
    
    The patch applies as-is from v7.2 on. Older stable trees need a
    backport, in particular for the ucsi_run_command() call in
    ucsi_update_notifications().

 drivers/usb/typec/ucsi/ucsi.c | 119 +++++++++++++++++++++++++++++++---
 drivers/usb/typec/ucsi/ucsi.h |   5 ++
 2 files changed, 115 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index c1450639c..0d543f777 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -274,6 +274,37 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 }
 EXPORT_SYMBOL_GPL(ucsi_send_command);
 
+/*
+ * Update the notification enable mask and send it to the PPM. Holding ppm_lock
+ * across both keeps ucsi->ntfy the mask that the PPM was sent last. Keep it
+ * even if the command fails, as the PPM may have applied the mask anyway.
+ */
+static int ucsi_update_notifications(struct ucsi *ucsi, u64 clear, u64 set)
+{
+	u64 command;
+	u32 cci;
+	int ret;
+
+	mutex_lock(&ucsi->ppm_lock);
+
+	if (ucsi->unregistering) {
+		ret = -ESHUTDOWN;
+		goto out_unlock;
+	}
+
+	ucsi->ntfy = (ucsi->ntfy & ~clear) | set;
+	command = UCSI_SET_NOTIFICATION_ENABLE | ucsi->ntfy;
+	ret = ucsi_run_command(ucsi, command, &cci, NULL, 0, NULL, 0, false);
+	if (cci & UCSI_CCI_ERROR)
+		ret = ucsi_read_error(ucsi, 0);
+
+	trace_ucsi_run_command(command, ret);
+
+out_unlock:
+	mutex_unlock(&ucsi->ppm_lock);
+	return ret;
+}
+
 int ucsi_write_message_out_command(struct ucsi *ucsi, u64 command,
 				   void *data, size_t size, void *msg_out,
 				   size_t msg_out_size)
@@ -1254,6 +1285,68 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 	}
 }
 
+/*
+ * Some PPMs keep signaling a Negotiated Power Level Change although the power
+ * contract stays the same, and signal it again as soon as it has been
+ * acknowledged, so the PPM and the driver keep each other busy for as long as
+ * the partner stays connected. Disable the notification once the PPM has
+ * signaled it this many times in a row, each within a second of the previous
+ * one, without a new contract, and enable it again when the partner is gone.
+ * The notification can only be disabled for all connectors at once. A change
+ * of the source PDOs can come with an unchanged RDO, so it doesn't count.
+ */
+#define UCSI_PWR_LEVEL_UNCHANGED_MAX	10
+
+static void ucsi_pwr_level_change(struct ucsi_connector *con)
+{
+	struct ucsi *ucsi = con->ucsi;
+
+	if (UCSI_CONSTAT(con, PWR_OPMODE) != UCSI_CONSTAT_PWR_OPMODE_PD ||
+	    UCSI_CONSTAT(con, RDO) != con->rdo ||
+	    (UCSI_CONSTAT(con, CHANGE) & UCSI_CONSTAT_PDOS_CHANGE)) {
+		con->pwr_level_unchanged = 0;
+		ucsi_pwr_opmode_change(con);
+		return;
+	}
+
+	if (time_after(jiffies, con->pwr_level_change_time + HZ))
+		con->pwr_level_unchanged = 0;
+	con->pwr_level_change_time = jiffies;
+
+	if (++con->pwr_level_unchanged < UCSI_PWR_LEVEL_UNCHANGED_MAX) {
+		/* Signaled before the notification was disabled, or despite it */
+		if (!con->pwr_level_ntfy_disabled)
+			ucsi_pwr_opmode_change(con);
+		return;
+	}
+
+	/*
+	 * Enable it again when the partner is gone even if the command fails,
+	 * as the PPM may have disabled it anyway.
+	 */
+	if (!con->pwr_level_ntfy_disabled) {
+		con->pwr_level_ntfy_disabled = true;
+		dev_warn(ucsi->dev,
+			 "con%d: Firmware bug: power level changes without a new contract, disabling the notification\n",
+			 con->num);
+	}
+
+	if (ucsi_update_notifications(ucsi, UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE, 0) >= 0)
+		con->pwr_level_unchanged = 0;
+}
+
+/* The partner that the notification was disabled for is gone */
+static void ucsi_pwr_level_ntfy_restore(struct ucsi_connector *con)
+{
+	if (!con->pwr_level_ntfy_disabled)
+		return;
+
+	if (ucsi_update_notifications(con->ucsi, 0, UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE) < 0)
+		return;
+
+	con->pwr_level_ntfy_disabled = false;
+}
+
 static int ucsi_register_partner(struct ucsi_connector *con)
 {
 	u8 pwr_opmode = UCSI_CONSTAT(con, PWR_OPMODE);
@@ -1324,6 +1417,8 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	typec_unregister_partner(con->partner);
 	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
 	con->partner = NULL;
+	con->rdo = 0;
+	con->pwr_level_unchanged = 0;
 }
 
 static void ucsi_partner_change(struct ucsi_connector *con)
@@ -1400,6 +1495,7 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 		ucsi_partner_change(con);
 		ucsi_port_psy_changed(con);
 		ucsi_unregister_partner(con);
+		ucsi_pwr_level_ntfy_restore(con);
 	}
 
 	return 0;
@@ -1511,11 +1607,16 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 			}
 		} else {
 			ucsi_unregister_partner(con);
+			ucsi_pwr_level_ntfy_restore(con);
 		}
 	}
 
-	if (change & (UCSI_CONSTAT_POWER_OPMODE_CHANGE | UCSI_CONSTAT_POWER_LEVEL_CHANGE))
+	if (change & UCSI_CONSTAT_POWER_OPMODE_CHANGE) {
+		con->pwr_level_unchanged = 0;
 		ucsi_pwr_opmode_change(con);
+	} else if (change & UCSI_CONSTAT_POWER_LEVEL_CHANGE) {
+		ucsi_pwr_level_change(con);
+	}
 
 	if (con->partner && (change & UCSI_CONSTAT_PARTNER_CHANGE)) {
 		ucsi_partner_change(con);
@@ -1685,13 +1786,10 @@ static int ucsi_role_cmd(struct ucsi_connector *con, u64 command)
 
 	ret = ucsi_send_command(con->ucsi, command, NULL, 0);
 	if (ret == -ETIMEDOUT) {
-		u64 c;
-
 		/* PPM most likely stopped responding. Resetting everything. */
 		ucsi_reset_ppm(con->ucsi);
 
-		c = UCSI_SET_NOTIFICATION_ENABLE | con->ucsi->ntfy;
-		ucsi_send_command(con->ucsi, c, NULL, 0);
+		ucsi_update_notifications(con->ucsi, 0, 0);
 
 		ucsi_reset_connector(con, true);
 	}
@@ -2171,12 +2269,10 @@ static void ucsi_resume_work(struct work_struct *work)
 {
 	struct ucsi *ucsi = container_of(work, struct ucsi, resume_work);
 	struct ucsi_connector *con;
-	u64 command;
 	int ret;
 
 	/* Restore UCSI notification enable mask after system resume */
-	command = UCSI_SET_NOTIFICATION_ENABLE | ucsi->ntfy;
-	ret = ucsi_send_command(ucsi, command, NULL, 0);
+	ret = ucsi_update_notifications(ucsi, 0, 0);
 	if (ret < 0) {
 		dev_err(ucsi->dev, "failed to re-enable notifications (%d)\n", ret);
 		return;
@@ -2347,6 +2443,8 @@ int ucsi_register(struct ucsi *ucsi)
 	if (!ucsi->version)
 		return -ENODEV;
 
+	ucsi->unregistering = false;
+
 	/*
 	 * Version format is JJ.M.N (JJ = Major version, M = Minor version,
 	 * N = sub-minor version).
@@ -2380,7 +2478,10 @@ void ucsi_unregister(struct ucsi *ucsi)
 
 	ucsi_debugfs_unregister(ucsi);
 
-	/* Disable notifications */
+	/* Disable notifications, and keep connector work from enabling them */
+	mutex_lock(&ucsi->ppm_lock);
+	ucsi->unregistering = true;
+	mutex_unlock(&ucsi->ppm_lock);
 	ucsi->ops->async_control(ucsi, cmd);
 
 	if (!ucsi->connector)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index dc594388d..137a83357 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -496,6 +496,8 @@ struct ucsi {
 
 	/* The latest "Notification Enable" bits (SET_NOTIFICATION_ENABLE) */
 	u64 ntfy;
+	/* Set by ucsi_unregister(), protected by ppm_lock */
+	bool unregistering;
 
 	/* PPM communication flags */
 	unsigned long flags;
@@ -554,6 +556,9 @@ struct ucsi_connector {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	u32 rdo;
+	unsigned long pwr_level_change_time;
+	unsigned int pwr_level_unchanged;
+	bool pwr_level_ntfy_disabled;
 	u32 src_pdos[PDO_MAX_OBJECTS];
 	int num_pdos;
 

base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.54.0

