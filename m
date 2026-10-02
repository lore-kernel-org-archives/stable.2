Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE55038F7
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963235; cv=none; b=qDgI405Sb4BnrieVGLNyDfrAzVaEpoYcYQaK+h19o9SvFaBuqChYAjoHHk7CuLBjkmAT2MwU/x2zTd0TKRhOic87zNEzgAaGipSt7Y0ku819FfK/ds+G0esy5iR2SBdWs392739sZQFdRXYAMUUFOUeclwHleJAuhXXvVu4QfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963235; c=relaxed/simple;
	bh=xxNJVbT1iqRNDSvY0nvBp+rCwbmFa+0St+CgZWTupuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNX+Xj/LzIQj7+ocV4EHVY1XFCneKlnsN6Vm4xaOIMs2F6owhKQftSbQLHxuOEuuH2pmKgclFtiLiECI24yN/oy4a6o0dygzva5mGR6t62V6R/T6Fxa+GcsdUlXO2YlSjkQ1vlmQL9SnyD0bKNGgNyWXrquANMm0o5UftI7QmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbE7SiVV; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbE7SiVV"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14c96a4b7c7so622456c88.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790963226; x=1791568026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g53brFVDHK/eddG4o/pP2HzcEikLFKuJtsivlkV0FO4=;
        b=IbE7SiVVLABRZLj+e+0EMIXkq0ZXnDtUFvGSaQ0GriI1KGwdirH7GDgetYs9Zbg+R+
         9NvHT0q4qjBvs4sZc3w5B6c54r2DRYMn8Yw/CNCXe7+gKZ8rKxHfN8qrnW5wYghIcH9k
         +kgrxcI13I43ktq8N9jUMZIecCT1oAygcfXrmmHPJGwI1aDSgoFooAhHNRN2a+JbDzmH
         caFRNrxQAmJqP1hrU8KSS5v7sJtX+V+F3n2ea2m3rAHV/QQIgQn4Taa6YcvcbWTkie2d
         3SLCTVgUUP5wiGwNFn4VISELuTJ1RQg8rBWNcOGmIY3wqg9nhJ5+qJgVrPn2VECu7gVt
         53kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790963226; x=1791568026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g53brFVDHK/eddG4o/pP2HzcEikLFKuJtsivlkV0FO4=;
        b=Zb3s9fScLm1zPygGqyT+tar8hsn3WqX1hiz4h/pBOi6obl3xUel6ZIh61eHkNzxg+Q
         1+8+w76tBrfasiRYRzQNzAIkiZWb/ydlGiaGoXP9sv8cox0PaPh79xhkmNB8kvaOHiwr
         NucM9vRefHHBkeurACj89Bb+iwc5D4KRyAic6Ykv38yAnPor+sZuKb4nbooQJd4o8p3O
         8k+V2cKObfNSiau5Edn3+p+YIj+lzsf4s0vOFmK/3cqjMuLy0cKsdiqZVwdxOQmBj97s
         vjScjQgzp6FgbzdmlVdCVxNG/nPMphyDmgMJ8F/LEE0/VEVGul/nPdsvZ+GNddsys8EE
         p6jQ==
X-Forwarded-Encrypted: i=1; AKwUvBzb/2QvRWQfBUyJAYr1OgozmLYX/Qb8cRuB6828IepKlEXLw5yfu/OEoEgmYGfjCtSID1PE76k=@vger.kernel.org
X-Gm-Message-State: AFuF++l3T9MvexWphUbrJGcaJMWWxtLzkIiMiyonZEH5DASoiVvUOR0j
	nkjD2mqNGiQjSmtBCquocxlbkWdrGxIYHAQTW6ltzrUFrKicYPtg9uy+
X-Gm-Gg: AYBFou06wl/OApNczH7HtYKzP4ExqZFJfpVDW/NExlXzI3tJnXwPygnBXKK0r339k14
	DvXe0baaGjldm/FHbGOQE6YQW2xbYP0Ihr9F//66KXLoflLqen0Bg7vt3YKO47uLg/LFrXHv5io
	CWqooQqbei6hXDm21opBxp2Z4PdjwUzefqBqibl/AkOnWHjvnXoA3lGXoI/VsMAsSQW1cJAlPts
	waBnmzM891f+kyJjVShEU2eR+64uqKCQ7ugbbFEK02v70RueGrorPjEWQ4whmHncDPya/6BSDc7
	Px4qnXb0kw64rzUNvaodQRya76F0jRTlyQaxMB9yavXhGPWDW9dfGVKzGcZiGUY0I51bNtv77mW
	XQR8gaQWINO1Ra7U+ft2bCC5mo4NlOZ+YBtvEfyw+WRDyZ77hvHPP2JC+sYccOrwaMFGmC1rZ2x
	GaNeSiu82ljb8S1bDtQS0aMW0qkHIy7ynQ4ml2Ktdbj4wHsVPjKczrvGNHiyZcTBL65VmedmsEj
	wjSVPRBOUsmOzVOgcS6Bef77AVc0mgMaa0oU6NhyGJM66OWbRRfGOS7al37kAGj+qT6gQ==
X-Received: by 2002:a05:7300:4f1c:b0:34b:101f:cdaf with SMTP id 5a478bee46e88-34f1501d239mr5209550eec.1.1790963225879;
        Fri, 02 Oct 2026 10:47:05 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd9698sm8241673eec.23.2026.10.02.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:47:05 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: johan.hedberg@intel.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6] Bluetooth: hci_conn: hold a reference for LE connection timeout
Date: Sat,  3 Oct 2026 01:46:58 +0800
Message-ID: <20261002174658.3596771-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

le_conn_timeout is embedded in struct hci_conn, but queued timeout work
does not hold a connection reference. hci_conn_del() uses
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

The callback then dereferences the released connection. KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_conn_failed+0x232/0x250
  Read of size 8 at addr ffff8881180e8e20 by task kworker/u33:1/111
  Workqueue: hci0 le_conn_timeout
  Call Trace:
   hci_conn_failed+0x232/0x250
   le_conn_timeout+0x23e/0x2c0
   process_one_work+0x61b/0xf50
   worker_thread+0x45b/0xd10

  Allocated by task 115:
   __hci_conn_add+0x1758/0x1b90
   hci_connect_le+0x523/0x780
   l2cap_chan_connect+0xfca/0x1bd0
   l2cap_sock_connect+0x310/0x530

  Freed by task 110:
   kfree+0x149/0x330
   device_release+0xc8/0x240
   kobject_put+0x14d/0x280
   hci_conn_del+0x561/0xe70
   hci_abort_conn_sync+0x3e3/0x800

Take a connection reference before queueing le_conn_timeout. Drop it when
queueing fails or cancellation removes a pending instance. An executing
callback defers its put to the system workqueue. The final reference can
release the controller and destroy hdev->workqueue. Flush the previous
deferred put before reusing its embedded work item.

Keep the timeout on hdev->workqueue so it remains ordered with received HCI
events. It can also enqueue chained controller work while that workqueue is
being drained. Under hdev->lock, act only while the connection is still
registered and in BT_CONNECT.

Release hdev->lock around the existing timeout flush in a failed connection
completion. Revalidate the connection after reacquiring it. This allows the
timeout's locked state check to finish without deadlocking its flusher.

Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v6:
- Replace v5's command-sync wait and advertising-state changes with a
  lifetime-only fix after validation found regressions in those paths.
- Hold a connection reference for queued timeout work and defer the final
  put to the system workqueue, avoiding destruction of hdev->workqueue from
  one of its own workers.
- Keep the timeout ordered with received HCI events on hdev->workqueue.
  Serialize its state check with hdev->lock and revalidate the connection
  after flushing the timeout without that lock.
- Validate the lifetime and ordering cases with focused tests, the normal
  Bluetooth test suites, a full kernel build and Sashiko with zero findings.

Link: https://lore.kernel.org/all/20260824134149.212607-1-nicoyip.dev@gmail.com/ [v5]
Link: https://lore.kernel.org/all/20260821172441.3020751-1-nicoyip.dev@gmail.com/ [v4]
Link: https://lore.kernel.org/all/20260821164512.2842464-1-nicoyip.dev@gmail.com/ [v3]
Link: https://lore.kernel.org/all/20260801145430.3560911-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/all/20260730104103.2080325-1-nicoyip.dev@gmail.com/ [v1]

 include/net/bluetooth/hci_core.h |  3 ++
 net/bluetooth/hci_conn.c         | 51 ++++++++++++++++++++++++++------
 net/bluetooth/hci_event.c        | 10 ++-----
 net/bluetooth/hci_sync.c         |  6 ++++
 4 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 788d6600f500..f1e85bfe6366 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -773,6 +773,7 @@ struct hci_conn {
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
 	struct delayed_work le_conn_timeout;
+	struct work_struct le_conn_timeout_put;
 
 	struct device	dev;
 	struct dentry	*debugfs;
@@ -1641,6 +1642,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 				    bdaddr_t *dst, u8 dst_type, u8 role);
 void hci_conn_del(struct hci_conn *conn);
+void hci_conn_queue_le_timeout(struct hci_conn *conn);
+void hci_conn_cancel_le_timeout(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 96195d2fd10f..78c6e0bfa184 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -714,6 +714,14 @@ static void le_disable_advertising(struct hci_dev *hdev)
 	}
 }
 
+static void le_conn_timeout_put(struct work_struct *work)
+{
+	struct hci_conn *conn = container_of(work, struct hci_conn,
+					     le_conn_timeout_put);
+
+	hci_conn_put(conn);
+}
+
 static void le_conn_timeout(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
@@ -722,21 +730,45 @@ static void le_conn_timeout(struct work_struct *work)
 
 	BT_DBG("");
 
+	/* A queued instance owns one reference. Wait for an earlier instance
+	 * to release its reference before reusing the put work.
+	 */
+	flush_work(&conn->le_conn_timeout_put);
+
 	/* We could end up here due to having done directed advertising,
 	 * so clean up the state if necessary. This should however only
 	 * happen with broken hardware or if low duty cycle was used
 	 * (which doesn't have a timeout of its own).
 	 */
-	if (conn->role == HCI_ROLE_SLAVE) {
-		/* Disable LE Advertising */
-		le_disable_advertising(hdev);
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
-		hci_dev_unlock(hdev);
-		return;
+	hci_dev_lock(hdev);
+	if (hci_conn_valid(hdev, conn) && conn->state == BT_CONNECT) {
+		if (conn->role == HCI_ROLE_SLAVE) {
+			/* Disable LE Advertising */
+			le_disable_advertising(hdev);
+			hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
+		} else {
+			hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+		}
 	}
+	hci_dev_unlock(hdev);
+
+	/* The final put can release hdev and destroy its workqueue. */
+	schedule_work(&conn->le_conn_timeout_put);
+}
 
-	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+void hci_conn_queue_le_timeout(struct hci_conn *conn)
+{
+	/* Keep the connection alive until the work runs or is canceled. */
+	hci_conn_get(conn);
+	if (!queue_delayed_work(conn->hdev->workqueue,
+				&conn->le_conn_timeout, conn->conn_timeout))
+		hci_conn_put(conn);
+}
+
+void hci_conn_cancel_le_timeout(struct hci_conn *conn)
+{
+	if (cancel_delayed_work(&conn->le_conn_timeout))
+		hci_conn_put(conn);
 }
 
 struct iso_list_data {
@@ -1145,6 +1177,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
+	INIT_WORK(&conn->le_conn_timeout_put, le_conn_timeout_put);
 
 	spin_lock_init(&conn->proto_lock);
 
@@ -1292,7 +1325,7 @@ void hci_conn_del(struct hci_conn *conn)
 			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
-		cancel_delayed_work(&conn->le_conn_timeout);
+		hci_conn_cancel_le_timeout(conn);
 
 		if (hdev->le_pkts) {
 			if (!hci_conn_num(hdev, LE_LINK) ||
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5ac2357e92c9..d34c70f51ae7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1593,9 +1593,7 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev *hdev, void *data,
 
 		conn = hci_lookup_le_connect(hdev);
 		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
+			hci_conn_queue_le_timeout(conn);
 	} else {
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 	}
@@ -1641,9 +1639,7 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 
 		conn = hci_lookup_le_connect(hdev);
 		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
+			hci_conn_queue_le_timeout(conn);
 	} else {
 		if (cp->num_of_sets) {
 			if (adv)
@@ -5801,7 +5797,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 			}
 		}
 	} else {
-		cancel_delayed_work(&conn->le_conn_timeout);
+		hci_conn_cancel_le_timeout(conn);
 	}
 
 	/* The HCI_LE_Connection_Complete event is only sent once per connection.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 00be55cf60ac..6c4f93f55a4d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7308,7 +7308,13 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 		goto unlock;
 
 	/* Flush to make sure we send create conn cancel command if needed */
+	hci_dev_unlock(hdev);
 	flush_delayed_work(&conn->le_conn_timeout);
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn) || conn->state != BT_CONNECT)
+		goto unlock;
+
 	hci_conn_failed(conn, bt_status(err));
 
 unlock:
-- 
2.43.0
