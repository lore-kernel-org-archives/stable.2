Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8D42901E
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578925; cv=none; b=nG8M++57tz8+xu9+axkVxSxyxMcw25V4UVN2DYXFNyoX762t7U+QkKD+jwfzdRphmEdQQRoazxhtEOJaGVi7cVthiGLXWS/bD6ZVF5YMtlNwZCsmrmlZ2oPk0D3TgNOVITfTDxEX0nV1tbuEsBFjuNNE0KOoTe1LsnXJnZwUxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578925; c=relaxed/simple;
	bh=QNTgSv4oUj9i7JPoycjxBwORgav9yt5QXBM2I2vopYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iv9Q89uOUfiLoQWv6ZKMac+edVsgIcRJ4hwDEORm5lQTjG54Tsi+u0y6z33hFRkLioP0+alnQ4tmvY2lR3nXj+Kjr1vJ5FE1sAHMcadi0WqNDVasznHTUemct+V9CI/5JIMLUJeqlSaISj48VOxFsGi1zeHDUc2Q2uM2p3dx63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khiPgzmF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khiPgzmF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d590f4c291so5574095ad.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787578921; x=1788183721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UaBuBeYaxfd9PPlk6XiS/UiYnB296xXij9UzJSbQ8Z8=;
        b=khiPgzmF1RdzSgMJhdWj7exx9WzadC1P35E+9/8Dy9VMX9phjQCBPqxrEiYtrerg/h
         yj7yMmEm9u+NoP9hL2ti3A34mnUpbQXjOKNIwCz/V+0VyRQw+2nU3lso7szBrs9u3ahu
         BisxdOaKksmzJX2PpLM496z7jvLykfikcyuIYwH+u5z5we9FJNfsWEXYU9jQyLbTiUn3
         qrdVlp5YCocIDMUntA/UQrMXxqeXTSaImsVNqY3awjpqmDml6OCw2twXWW7s4WhtPzen
         vAXovQXUYCm4R7cgBsE0gKnOuDbN9d5DgRi2WtqUFPDPB1aZ3Y35hdDxkatUq+wfNv63
         Ms5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787578921; x=1788183721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UaBuBeYaxfd9PPlk6XiS/UiYnB296xXij9UzJSbQ8Z8=;
        b=Qu1Y2lGefBx61q4gF6zRSIucXMtFml0YnDl/lfY+wXAZw1dbAII/kpIf+5FypZcZBC
         z5D13LC9R0f5ddsCgRBP6I6QUjBFyesEJsgj2J4Gv9XKj2ENtrTULVTzbv/1gtQHBHAF
         N0E6GqEdPeFKzMkbazoQML5Dfp741QxgPvz2VikHJX/6jTDEswLLiF5DPfoMS1JIdgxT
         PpjSbFucKuvOIhPqFLB1aq8y3/cPUxaL2Bu92LNUFpir5hOC0iy/WB0zAkDmCp80mazR
         arp0ckonRll2Ru1ihV1S045EjMNaeJZMtrSmSGWGC+DnRYeBkKWNtxcydVOklBC4zcEB
         adUw==
X-Forwarded-Encrypted: i=1; AHgh+RoLGz/sZNGmhu2hFLEJ2MOIeH76l9g9ptuws22/a2ZXcFUAa1b+XFvel7VUb8BLzz9MjY38oxo=@vger.kernel.org
X-Gm-Message-State: AFuF++lffpBa0LbjDxo0jvsCF/MSFbveM/z07AT8sC00L3b9JO8ZOEXb
	C+3KQmhdm75xhb5wevRanVC2TTdnmKuV3iSx9zziqoMv1nauDi5TLJFY/bFgn1jLLiTJiQ==
X-Gm-Gg: AR+sD13N6jQxBeLNHCUI5NjonhUq7L6q4ktFTIS9ZfZT+W9KYcNm/+21T11kRpJ4rAU
	J546ccQbehwnzHnCc8wuR4MiBe0lZKaZfnR0wPvyTFigCklCFAwlRiLc2NC54hfeDL6SfFKCeGC
	qtQgTt3D6CmMRo71T4Elm14RPeUNe8pDjtWmWwKxsTbOKQ8DUEDEb9klh7/mpntj9hEKZzeMTdc
	e+UbQSAFK/Mvnc72Vu0bDKcTV4Q1XPiJGLDadXbYJyklvQf4Mis05SXOBP8dgu5VwFjbFKur8TH
	Lh4DxWt8XRGrtAk4TPDcV/mQPDzS+BHP4BILuxodZ/JHNO0M/Ms5wAfPrxQO38MSmMEqmLfPrmT
	CvZiZ7yjGd1dF1OD9/fHsmeL163DPzqdaU51pWNW151hc07x8H7FBCVPGnfm0USobrgYMFO+/Np
	OCLEbgdJoxwrMViUw/1BMlwIvoxGoFgACctNaFr3BlJHSj9TukMO9CAZc5Aw2zaEUOEu4cMc61Z
	0jR/eGq0gP9ZoRs0bKdIpzRc8lzQ3F4TQMR57ybTLcdssXPtG0QLFw=
X-Received: by 2002:a17:903:4685:b0:2cf:9e90:8be with SMTP id d9443c01a7336-2d64b0b66e5mr219524965ad.4.1787578920868;
        Mon, 24 Aug 2026 06:42:00 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f922ac7bsm26007748eec.25.2026.08.24.06.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:42:00 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v5] Bluetooth: hci_sync: wait for directed advertising completion
Date: Mon, 24 Aug 2026 21:41:49 +0800
Message-ID: <20260824134149.212607-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

le_conn_timeout is embedded in struct hci_conn, but queuing the work does
not hold a reference to the connection.  hci_conn_del() uses
cancel_delayed_work() because synchronous cancellation would deadlock when
le_conn_timeout() itself calls hci_conn_del() while holding hdev->lock.

This leaves the following interleaving possible:

  CPU 0                               CPU 1
  le_conn_timeout()
                                      hci_conn_del()
                                        cancel_delayed_work() = false
                                        hci_conn_cleanup()
                                          put_device()
                                            kfree(conn)
  hci_conn_failed(conn, ...)

The callback then dereferences the released connection.  KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_conn_failed+0x232/0x250
  Read of size 8 at addr ffff8881180e8e20 by task kworker/u33:1/111
  Workqueue: hci0 le_conn_timeout
  Call Trace:
   hci_conn_failed+0x232/0x250
   le_conn_timeout+0x23e/0x2c0
   process_one_work+0x61b/0xf50
   worker_thread+0x45b/0xd10

Remove le_conn_timeout instead of adding another connection reference.
Have the directed-advertising enable commands complete normally, then wait
for the appropriate LE Connection Complete event with HCI_OP_NOP, matching
other Command Complete then later-event sequences such as PAST.  The
command-sync entry already holds a connection reference until its
completion callback returns.

LE Set Advertising Enable and LE Set Extended Advertising Enable return
Command Complete rather than Command Status, so the later event cannot be
attached to the enable command itself without changing generic command
completion.  Waiting with HCI_OP_NOP keeps that completion path unchanged.

Mark directed advertising as an in-flight connection attempt so teardown
can cancel the wait.  Disable advertising synchronously when that wait
fails, and preserve HCI_ERROR_ADVERTISING_TIMEOUT for a software timeout.
Clear the instance-0 extended advertising state when advertising is stopped
or a connection completes so resuming paused advertising does not restart
the directed advertising instance.

There is then no delayed callback that can race with connection deletion.

Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v5:
- Drop the generic hci_cmd_complete_evt() change from v3/v4. Keeping a
  request pending on successful Command Complete when a later event was
  requested broke BlueZ CI PAST, Read Exp Feature, and Mesh Send cancel.
- Wait for directed advertising completion with HCI_OP_NOP after the
  enable command completes, matching PAST, instead of changing generic
  command-complete semantics.

Changes in v4:
- Rebase onto bluetooth-next/master so the patch applies to current
  Bluetooth CI HEAD.

Changes in v3:
- Keep command-sync requests pending on successful Command Complete when
  the caller requested a later event, matching the existing Command Status
  behavior and fixing the first Sashiko/Luiz report.
- Clear HCI_LE_ADV_0 when all extended advertising instances are disabled
  and when LE connection complete implicitly stops advertising, fixing the
  second Sashiko report about resuming stale directed advertising.

Changes in v2:
- Remove le_conn_timeout instead of adding references around delayed work.
- Wait for LE Connection Complete from both directed-advertising enable paths.
- Make the wait cancellable and disable advertising after a failed wait.

Link: https://lore.kernel.org/linux-bluetooth/20260821172441.3020751-1-nicoyip.dev@gmail.com/ [v4]
Link: https://lore.kernel.org/linux-bluetooth/20260821164512.2842464-1-nicoyip.dev@gmail.com/ [v3]
Link: https://lore.kernel.org/linux-bluetooth/20260801145430.3560911-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-nicoyip.dev@gmail.com/ [v1]
Link: https://sashiko.dev/#/patchset/20260801145430.3560911-1-nicoyip.dev%40gmail.com

 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 45 --------------------------------
 net/bluetooth/hci_event.c        | 33 +++++------------------
 net/bluetooth/hci_sync.c         | 38 ++++++++++++++++++++++-----
 4 files changed, 38 insertions(+), 79 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c12cd6873f65..d7a2df82ff38 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -769,7 +769,6 @@ struct hci_conn {
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
-	struct delayed_work le_conn_timeout;
 
 	struct device	dev;
 	struct dentry	*debugfs;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8de98af2fb58..cfcc5d055d5a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -697,48 +697,6 @@ static void hci_conn_auto_accept(struct work_struct *work)
 		     &conn->dst);
 }
 
-static void le_disable_advertising(struct hci_dev *hdev)
-{
-	if (ext_adv_capable(hdev)) {
-		struct hci_cp_le_set_ext_adv_enable cp;
-
-		cp.enable = 0x00;
-		cp.num_of_sets = 0x00;
-
-		hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(cp),
-			     &cp);
-	} else {
-		u8 enable = 0x00;
-		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
-			     &enable);
-	}
-}
-
-static void le_conn_timeout(struct work_struct *work)
-{
-	struct hci_conn *conn = container_of(work, struct hci_conn,
-					     le_conn_timeout.work);
-	struct hci_dev *hdev = conn->hdev;
-
-	BT_DBG("");
-
-	/* We could end up here due to having done directed advertising,
-	 * so clean up the state if necessary. This should however only
-	 * happen with broken hardware or if low duty cycle was used
-	 * (which doesn't have a timeout of its own).
-	 */
-	if (conn->role == HCI_ROLE_SLAVE) {
-		/* Disable LE Advertising */
-		le_disable_advertising(hdev);
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
-		hci_dev_unlock(hdev);
-		return;
-	}
-
-	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
-}
-
 struct iso_list_data {
 	union {
 		u8  cig;
@@ -1131,7 +1089,6 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
-	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
 
 	spin_lock_init(&conn->proto_lock);
 
@@ -1279,8 +1236,6 @@ void hci_conn_del(struct hci_conn *conn)
 			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
-		cancel_delayed_work(&conn->le_conn_timeout);
-
 		if (hdev->le_pkts) {
 			if (!hci_conn_num(hdev, LE_LINK) ||
 			    hdev->le_cnt + conn->sent > hdev->le_pkts)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2f5e21ff9752..b0af5635f831 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1595,22 +1595,10 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	/* If we're doing connection initiation as peripheral. Set a
-	 * timeout in case something goes wrong.
-	 */
-	if (*sent) {
-		struct hci_conn *conn;
-
+	if (*sent)
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
-
-		conn = hci_lookup_le_connect(hdev);
-		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
-	} else {
+	else
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
-	}
 
 	hci_dev_unlock(hdev);
 
@@ -1642,20 +1630,12 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 		adv = hci_find_adv_instance(hdev, set->handle);
 
 	if (cp->enable) {
-		struct hci_conn *conn;
-
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
 		if (adv)
 			adv->enabled = true;
 		else if (!set->handle)
 			hci_dev_set_flag(hdev, HCI_LE_ADV_0);
-
-		conn = hci_lookup_le_connect(hdev);
-		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
 	} else {
 		if (cp->num_of_sets) {
 			if (adv)
@@ -1676,6 +1656,7 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
 						 list)
 				adv->enabled = false;
+			hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
 		}
 
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
@@ -5764,10 +5745,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_store_wake_reason(hdev, bdaddr, bdaddr_type);
 
 	/* Advertising stops when a connection is created. On a failed
-	 * connection it keeps running, so leave the state bit alone.
+	 * connection it keeps running, so leave the state bits alone.
 	 */
-	if (!status)
+	if (!status) {
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
+		hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
+	}
 
 	/* Check for existing connection:
 	 *
@@ -5814,8 +5797,6 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 							  &conn->init_addr_type);
 			}
 		}
-	} else {
-		cancel_delayed_work(&conn->le_conn_timeout);
 	}
 
 	/* The HCI_LE_Connection_Complete event is only sent once per connection.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7150037a864b..7e092e827ab8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6639,6 +6639,19 @@ static bool conn_use_rpa(struct hci_conn *conn)
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
 }
 
+static int hci_le_wait_directed_adv_complete_sync(struct hci_dev *hdev,
+						  struct hci_conn *conn)
+{
+	/* LE Set (Extended) Advertising Enable returns a command complete
+	 * event, so it cannot wait for LE Connection Complete.
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					use_enhanced_conn_complete(hdev) ?
+					HCI_EV_LE_ENHANCED_CONN_COMPLETE :
+					HCI_EV_LE_CONN_COMPLETE,
+					conn->conn_timeout, NULL);
+}
+
 static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 						struct hci_conn *conn)
 {
@@ -6704,7 +6717,11 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 			return err;
 	}
 
-	return hci_enable_ext_advertising_sync(hdev, 0x00);
+	err = hci_enable_ext_advertising_sync(hdev, 0x00);
+	if (err)
+		return err;
+
+	return hci_le_wait_directed_adv_complete_sync(hdev, conn);
 }
 
 static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
@@ -6755,8 +6772,13 @@ static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
 
 	enable = 0x01;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
-				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
+	status = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				       sizeof(enable), &enable,
+				       HCI_CMD_TIMEOUT);
+	if (status)
+		return status;
+
+	return hci_le_wait_directed_adv_complete_sync(hdev, conn);
 }
 
 static void set_ext_conn_params(struct hci_conn *conn,
@@ -6860,6 +6882,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		/* Pause advertising while doing directed advertising. */
 		hci_pause_advertising_sync(hdev);
 
+		set_bit(HCI_CONN_CREATE, &conn->flags);
 		err = hci_le_directed_advertising_sync(hdev, conn);
 		goto done;
 	}
@@ -6946,7 +6969,9 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 done:
 	clear_bit(HCI_CONN_CREATE, &conn->flags);
 
-	if (err == -ETIMEDOUT)
+	if (err && conn->role == HCI_ROLE_SLAVE)
+		hci_disable_advertising_sync(hdev);
+	else if (err == -ETIMEDOUT)
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
@@ -7283,9 +7308,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (conn != hci_lookup_le_connect(hdev))
 		goto unlock;
 
-	/* Flush to make sure we send create conn cancel command if needed */
-	flush_delayed_work(&conn->le_conn_timeout);
-	hci_conn_failed(conn, bt_status(err));
+	hci_conn_failed(conn, conn->role == HCI_ROLE_SLAVE && err == -ETIMEDOUT ?
+			 HCI_ERROR_ADVERTISING_TIMEOUT : bt_status(err));
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.43.0

