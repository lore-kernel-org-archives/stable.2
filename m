Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6E498935
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791634245; cv=none; b=PQmysnFKu4Igx6lixIEHW0911VN8My9tHWnSyJBBJyTHC7++lZEP7mdokrYw954ZXYMiPfrStq6wk0pah2hLF1lHjbAkb6LZQMM7DHJBkVoTj9VxJrFwq2c9yWyU3M075ScQgzWGALCNDxEnIewY02dooVczlSZGOA5697U2XZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791634245; c=relaxed/simple;
	bh=idsWFdaV18owxyQKTWuesq8tc8fj4wX0xUezUBnU3bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPbYBiBwecl6LC029KOaKoZfQihkaBla539q3u0zdKhs5ny844s8CnhLkbeBzsFRu4fu8cEoyWCbv9sDioseBZJuUm/cYxzmAfpYOu8CjkFmXl9qnaGW4uzDUuCZLIMIC9E41oOD6r8r9NPmzAutUvMf764ULBygsH3RYurmwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etik.com; spf=pass smtp.mailfrom=etik.com; dkim=pass (1024-bit key) header.d=etik.com header.i=@etik.com header.b=TTGzBhhw; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=etik.com header.i=@etik.com header.b="TTGzBhhw"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j22cQ3JfgzYcn;
	Sat, 10 Oct 2026 14:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etik.com;
	s=20210927; t=1791634230;
	bh=J+48iWCghkVYJEQ+wIRDbVEk4gxMDcsHQqzQKdyIdV8=;
	h=From:To:Cc:Subject:Date:From;
	b=TTGzBhhwmZYgpjfK0GxLzpl4ZmKIDdxU2rUldumMnuMx5kttjIO3GeBLz1v2cKD6v
	 EKY9w8amMrsvvG9LbM+38bRfRUZCyWjD2j0AzeViZAS47nBgm/RluEF6mAABgqSdIa
	 F/KinuzGMS4VZ2+XmH10AZOaRRzHHgHmPCSI//jg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j22cP2y5Jzw49;
	Sat, 10 Oct 2026 14:10:29 +0200 (CEST)
From: David Vornholt <dv@etik.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	abhilash.k.v@intel.com,
	David Vornholt <david@vornholt.online>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Stop a power level change notification storm
Date: Sat, 10 Oct 2026 14:10:26 +0200
Message-ID: <20261010121026.84844-1-dv@etik.com>
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
or the RDO changed, which the workaround for Dell's firmware relies on.
Once the PPM has signaled it ten times in a row with the same PD
contract, each within a second of the previous one, disable the
notification with SET_NOTIFICATION_ENABLE and log it once. This PPM
still reports the bit in the connector status change field, so a later
contract change is handled with the next connector change it does
signal. The notification stays disabled while the driver is bound,
because resume and the reset path resend ucsi->ntfy.

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
    Claude Code, an AI coding assistant, found the cause while I was looking
    into why irq/9-acpi kept a CPU busy, and wrote this patch and its
    description.
    
    Tested: a port of this patch to v7.2.9 on the X1 Carbon Gen 13 with the
    HP E273m. The ucsi trace events show ten connector changes about 100 ms
    apart, one SET_NOTIFICATION_ENABLE and the warning, and no connector
    changes after that. GPE 0x6E went from about 680/s to 0/s.
    
    This version against usb-linus is only compile-tested (x86_64 defconfig
    with TYPEC_UCSI=m and UCSI_ACPI=m, W=1) and passes checkpatch --strict.
    
    Not tested: other PPMs, in particular Dell's that rely on a0d4618788f2;
    other partners on this laptop; suspend and resume with the notification
    disabled; sparse (the version available to me was too old).
    
    The patch applies as-is from v6.13 on, after 226ff2e681d0 ("usb: typec:
    ucsi: Convert connector specific commands to bitmaps"). Older stable
    trees need a backport.

 drivers/usb/typec/ucsi/ucsi.c | 51 ++++++++++++++++++++++++++++++++++-
 drivers/usb/typec/ucsi/ucsi.h |  2 ++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index c1450639c..f2677875a 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1254,6 +1254,51 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 	}
 }
 
+/*
+ * Some PPMs keep signaling a Negotiated Power Level Change although the power
+ * contract stays the same, and signal it again as soon as it has been
+ * acknowledged, so the PPM and the driver keep each other busy for as long as
+ * the partner stays connected. Stop listening to the notification once the
+ * PPM has signaled it this many times in a row, each within a second of the
+ * previous one, without a new contract.
+ */
+#define UCSI_PWR_LEVEL_UNCHANGED_MAX	10
+
+static void ucsi_pwr_level_change(struct ucsi_connector *con)
+{
+	struct ucsi *ucsi = con->ucsi;
+	u64 ntfy;
+
+	if (UCSI_CONSTAT(con, PWR_OPMODE) != UCSI_CONSTAT_PWR_OPMODE_PD ||
+	    UCSI_CONSTAT(con, RDO) != con->rdo) {
+		con->pwr_level_unchanged = 0;
+		ucsi_pwr_opmode_change(con);
+		return;
+	}
+
+	/* Queued before the notification was disabled */
+	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE))
+		return;
+
+	if (time_after(jiffies, con->pwr_level_change_time + HZ))
+		con->pwr_level_unchanged = 0;
+	con->pwr_level_change_time = jiffies;
+
+	if (++con->pwr_level_unchanged < UCSI_PWR_LEVEL_UNCHANGED_MAX) {
+		ucsi_pwr_opmode_change(con);
+		return;
+	}
+
+	ntfy = ucsi->ntfy & ~UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE;
+	if (ucsi_send_command(ucsi, UCSI_SET_NOTIFICATION_ENABLE | ntfy, NULL, 0) < 0)
+		return;
+
+	ucsi->ntfy = ntfy;
+	dev_warn(ucsi->dev,
+		 "con%d: Firmware bug: power level changes without a new contract, disabling the notification\n",
+		 con->num);
+}
+
 static int ucsi_register_partner(struct ucsi_connector *con)
 {
 	u8 pwr_opmode = UCSI_CONSTAT(con, PWR_OPMODE);
@@ -1324,6 +1369,8 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
 	typec_unregister_partner(con->partner);
 	memset(&con->partner_identity, 0, sizeof(con->partner_identity));
 	con->partner = NULL;
+	con->rdo = 0;
+	con->pwr_level_unchanged = 0;
 }
 
 static void ucsi_partner_change(struct ucsi_connector *con)
@@ -1514,8 +1561,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		}
 	}
 
-	if (change & (UCSI_CONSTAT_POWER_OPMODE_CHANGE | UCSI_CONSTAT_POWER_LEVEL_CHANGE))
+	if (change & UCSI_CONSTAT_POWER_OPMODE_CHANGE)
 		ucsi_pwr_opmode_change(con);
+	else if (change & UCSI_CONSTAT_POWER_LEVEL_CHANGE)
+		ucsi_pwr_level_change(con);
 
 	if (con->partner && (change & UCSI_CONSTAT_PARTNER_CHANGE)) {
 		ucsi_partner_change(con);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index dc594388d..0202788fe 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -554,6 +554,8 @@ struct ucsi_connector {
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	u32 rdo;
+	unsigned long pwr_level_change_time;
+	unsigned int pwr_level_unchanged;
 	u32 src_pdos[PDO_MAX_OBJECTS];
 	int num_pdos;
 

base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.54.0

