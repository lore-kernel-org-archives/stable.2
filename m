Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043D291864
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569915; cv=none; b=I9rPY4DZRL+0xIDVi7anA0fmq/2IX404c/qLkeLqep0rKwKT3+vy/sj664++euh+8UiycdwXehjs+5b1JfjKC2W3tAkdfvdFZlLDAYwsziVrKvETvIaEXfH7PnHadt2+CT6xgXGiTyFCWeMgKQRaQ6lbKA/BTHkYb/tD9DjLmdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569915; c=relaxed/simple;
	bh=fvTNyi2+CY3PEX1c3C+KdP3qMQb2AgWrMT4+LYrtPQ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VywjY+QYVH4veQZhBy4hljULlwn+doM9PmU4VfbP9Z/HOTmhXJassM5nSL1fDAVJZVJtPuIlxDxmPe0vpkUl26iDOblXiMfOKjFnMs0HjAqPfeSuyKYjPkbUpZYCQa1b5eaIJ8wkTteEJWbiIQteiVZPUIzX2dUjBm60++jdMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SRwVwsg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SRwVwsg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201801F00898;
	Thu,  4 Jun 2026 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569913;
	bh=QLAvCE2GWSJFGtL24I6QTFUkbKqZLQUzCRsqdIuaTfI=;
	h=Subject:To:Cc:From:Date;
	b=SRwVwsg+gGjLTZTKBUraX8hpuVDbzfSWwd4nDIMS+Y9MnCACn4jV79YwRWGldgnNp
	 pdg7eP6PDiOZ4bInDO0GFcN4Wd+9UKHLlNjO0cvOqRm+802pwG+S1KaL73pnqHgTgk
	 k6pY6pHQ4ypL1qPT3PX8M4klySZ4wU2zSkDAmAFs=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Check if power role change actually" failed to apply to 6.12-stable tree
To: myrrhperiwinkle@qtmlabs.xyz,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,senozhatsky@chromium.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:44:16 +0200
Message-ID: <2026060416-womanless-occupy-e037@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b80e7d34c7ea6a564525119d6138fbb577a23dba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060416-womanless-occupy-e037@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b80e7d34c7ea6a564525119d6138fbb577a23dba Mon Sep 17 00:00:00 2001
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Date: Tue, 19 May 2026 18:41:39 +0700
Subject: [PATCH] usb: typec: ucsi: Check if power role change actually
 happened before handling

The CrOS EC may send a connector status change event with the power
direction changed flag set even if the power direction hasn't actually
changed after initiating a SET_PDR command internally [1]. In practice
this happens on every system suspend due to other changes performed by
the EC [2][3][4], causing suspend to fail.

Fix this by checking if the power role change actually happened before
handling it.

[1]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=1689;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[2]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=3923;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[3]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=5094;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[4]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=2229;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794

Cc: stable <stable@kernel.org>
Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 539dc706798d..53c101bd48e2 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1277,7 +1277,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 						  work);
 	struct ucsi *ucsi = con->ucsi;
 	u8 curr_scale, volt_scale;
-	enum typec_role role;
+	enum typec_role role, prev_role;
 	u16 change;
 	int ret;
 	u32 val;
@@ -1288,6 +1288,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
 			     __func__);
 
+	prev_role = UCSI_CONSTAT(con, PWR_DIR);
+
 	ret = ucsi_get_connector_status(con, true);
 	if (ret) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
@@ -1304,7 +1306,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	change = UCSI_CONSTAT(con, CHANGE);
 	role = UCSI_CONSTAT(con, PWR_DIR);
 
-	if (change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
+	if ((change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
 		typec_set_pwr_role(con->port, role);
 		ucsi_port_psy_changed(con);
 

