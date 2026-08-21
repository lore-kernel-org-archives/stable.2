Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E2036B937
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333089; cv=none; b=dc1+0+v3VLDlaelubbB6dpqsOgBVHvACgqbZvtLtv/E8k/39smzzIyLVQ2Z/8HdNBeogsZqM6TfIGi5b3cf7e0c5sDNZ19C7yFEW5OT5iV1CNpFPu7RKvCIHQb2wDmQR0IP1LLERDqcC9RmFAUK95nA47S+8OyODVWPytrZUYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333089; c=relaxed/simple;
	bh=cuzTwUl7Crskva12oIyR5/CvxI1vVSPxwkFiQ/z9rqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lg0u3XTI8ImNZRqPw4P73C3iY27zdpCbMWc1W/phvgp/BdhXbfTwIUzCrzoF1h0fMWvri8fGK3ZrEhATLR+bAPEQ0v/xzxH4cRn/2KmNoN5kbc5Yo7/xjwy27MyMKqaOxN3Mig2DGUPk8aJ4p7H+HwXyGZQffNth5/0H4SKGxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOEy9ine; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOEy9ine"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9d290216d0so95110a12.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787333088; x=1787937888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XXI/kEF6MADFGYFv3I7kfDrbWVqsu29jfcGWcE3Uy/Y=;
        b=JOEy9ineWoQe/nw3tFvrJIRrYogM2bcbq4MO87++ayDolvvgunXiKFaHFzs4omN2cl
         4phErc+Fv4BSOHqD67RAc1g6Z2lK2bxnrmNsNehwz19BQyabqvczaRjkCp1ZSjvdWdeH
         7zFk18pQuZfmEyWv2rjZC5s3xkxFfae/ngIemL/+JKX3N871xbb6b18pJzdeUiw8+j3q
         KGs52r6xMcK3t1MkoW4bgwQnWzIPEzQDsYgqADuaG6LtZyRO0obeKWXjdGJM7wR+x0oH
         rxfOQ9XKknJOyv8/Kxii+N1p1cifooFw5CErGQG3cnfFvWfcRW7pxBwQhDvH5pMvgZdQ
         d/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787333088; x=1787937888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXI/kEF6MADFGYFv3I7kfDrbWVqsu29jfcGWcE3Uy/Y=;
        b=NmJerjiCnH/LDTXA4xlyCU8eVEWNb5xOy0eOrrXzj23S3pto/kqnmjYxu0ycpYfcFJ
         ibMYg8aySlU4QbHf2JpKDunkTkIWt06fZtjgY3CCI2+LjbM0oMTZvb/W6pqCcSG7fGBR
         klwR/ZnIjWoeu5gmgxCdIg2yyh8QnX8gmw9JXh4DmUbgBMFStXqpR6vMGfG5FzoSmdfM
         KFTJ2sSG5ZAY7dg0Fi3qb8ycxjhc6A5WK38fjnF9MM0mRVyTyyWwlRT09cFzPpr7EmdC
         4mDiTnIBldn1J63S5prm9kUOji4SFAzQJEOnDHbzylFLfzTT6braJVGitTqODF9w5/Ud
         uVxA==
X-Forwarded-Encrypted: i=1; AHgh+RqWVqGFLqDvXUMq7XEsAyTkebvpE7LKF+1cSDQ9qLswdyiLVGZ7ceK8KQydiaR6oKdCR7k6LZc=@vger.kernel.org
X-Gm-Message-State: AFuF++l8VMXn+N+AvOV3fgThSRGUYEuQuPsI9fhzMut7I8+y0Xzqp9xw
	EIk4WclE/DVlAvOKneL/aT6yjcUqnfbIOjcUtJFy5lulyoLuyhgrC0hE
X-Gm-Gg: AR+sD12TwNcItFucyvwOgCjps9KYxBgjDxcZVH/51njNCo1jsDjGRThqbeWAYWdXj67
	ETPqYlnPTHBsGxwzvPrb5Xoszjw4ob1s8ZbnawRRoYB+ytPN4HfgfSzGHm4BdZz4f1rBaYwBhet
	6jsdikOiGmNFdYLnJZeGC3hUn7JnLgltj0jRjfrvvCuDBq0w8BtmaY84pk2a3Iu+PyURBQ9Zhpn
	s/GpvhWwDKxna+Bsd/xa9YZceBnLg5kuCgHEtTZs+Wm9QpZnbbPMNpRhzDkPTDTAdKLxIwBRdD1
	VrF324xyGNXL8Jc20nWArITS2jMuOj+7XMX/vit2n3RfTA8rKPW0qcwP3GLa6GfbTVkjF6ENJ81
	Mn+9TaTeosnmM8rldeBRIEWbzxd59uaRRWDAugFOz/w43GLrt5KuX50KW/FcmT8cn5qoCEfyVUN
	BLRqRYmNdKcRX7H5bF/UzHM81TMrc2R2EdVfsFOsspd6IX9nlt90RRNb41aGkB531F970WtxI59
	Dhi+GopVQzHhtq2jDuwri+o9GJSglBrCqLdKHdf4yM9zEJlQK0D8fc=
X-Received: by 2002:a17:902:e945:b0:2d5:cbd3:8eb1 with SMTP id d9443c01a7336-2d64b162c6dmr72150635ad.3.1787333087419;
        Fri, 21 Aug 2026 10:24:47 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c3fc6675sm41390287eec.13.2026.08.21.10.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:24:46 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v4] Bluetooth: hci_sync: wait for directed advertising completion
Date: Sat, 22 Aug 2026 01:24:40 +0800
Message-ID: <20260821172441.3020751-1-nicoyip.dev@gmail.com>
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
Have the legacy and extended directed-advertising enable commands wait for
the appropriate LE Connection Complete event in hci_le_create_conn_sync().
The command-sync entry already holds a connection reference until its
completion callback returns.

Command Status already keeps a command-sync request pending when the
command succeeds and a later event was requested.  Do the same for
Command Complete so controllers that complete LE Set Advertising Enable
with Command Complete do not bypass the requested LE Connection Complete
wait.

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

Link: https://lore.kernel.org/linux-bluetooth/20260821164512.2842464-1-nicoyip.dev@gmail.com/ [v3]
Link: https://lore.kernel.org/linux-bluetooth/20260801145430.3560911-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-nicoyip.dev@gmail.com/ [v1]
Link: https://sashiko.dev/#/patchset/20260801145430.3560911-1-nicoyip.dev%40gmail.com

 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 45 ------------------------------
 net/bluetooth/hci_event.c        | 47 +++++++++++---------------------
 net/bluetooth/hci_sync.c         | 42 ++++++++++++++++++++--------
 4 files changed, 46 insertions(+), 89 deletions(-)

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
index 2f5e21ff9752..1d0a5e9cf275 100644
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
 
@@ -1642,8 +1630,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 		adv = hci_find_adv_instance(hdev, set->handle);
 
 	if (cp->enable) {
-		struct hci_conn *conn;
-
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
 		if (adv)
@@ -1651,11 +1637,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 		else if (!set->handle)
 			hci_dev_set_flag(hdev, HCI_LE_ADV_0);
 
-		conn = hci_lookup_le_connect(hdev);
-		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
 	} else {
 		if (cp->num_of_sets) {
 			if (adv)
@@ -1676,6 +1657,7 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 			list_for_each_entry_safe(adv, n, &hdev->adv_instances,
 						 list)
 				adv->enabled = false;
+			hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
 		}
 
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
@@ -4337,13 +4319,16 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 
 	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
 
-	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
-			     req_complete_skb);
+	if (*status || !hdev->req_skb || !hci_skb_event(hdev->req_skb)) {
+		hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
+				     req_complete_skb);
 
-	if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
-		bt_dev_err(hdev,
-			   "unexpected event for opcode 0x%4.4x", *opcode);
-		return;
+		if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
+			bt_dev_err(hdev,
+				   "unexpected event for opcode 0x%4.4x",
+				   *opcode);
+			return;
+		}
 	}
 
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
@@ -5764,10 +5749,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
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
@@ -5814,8 +5801,6 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 							  &conn->init_addr_type);
 			}
 		}
-	} else {
-		cancel_delayed_work(&conn->le_conn_timeout);
 	}
 
 	/* The HCI_LE_Connection_Complete event is only sent once per connection.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7150037a864b..9fee30063821 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1630,7 +1630,9 @@ int hci_update_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	return __hci_set_scan_rsp_data_sync(hdev, instance);
 }
 
-int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
+static int hci_enable_ext_advertising_sync_ev(struct hci_dev *hdev,
+					      u8 instance, u8 event,
+					      u32 timeout)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
 	struct hci_cp_ext_adv_set *set;
@@ -1670,10 +1672,16 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 		set->duration = cpu_to_le16(duration / 10);
 	}
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
-				     sizeof(*cp) +
-				     sizeof(*set) * cp->num_of_sets,
-				     data, HCI_CMD_TIMEOUT);
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+					sizeof(*cp) +
+					sizeof(*set) * cp->num_of_sets,
+					data, event, timeout, NULL);
+}
+
+int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
+{
+	return hci_enable_ext_advertising_sync_ev(hdev, instance, 0,
+						  HCI_CMD_TIMEOUT);
 }
 
 int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
@@ -6704,7 +6712,11 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 			return err;
 	}
 
-	return hci_enable_ext_advertising_sync(hdev, 0x00);
+	return hci_enable_ext_advertising_sync_ev(hdev, 0x00,
+				use_enhanced_conn_complete(hdev) ?
+				HCI_EV_LE_ENHANCED_CONN_COMPLETE :
+				HCI_EV_LE_CONN_COMPLETE,
+				conn->conn_timeout);
 }
 
 static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
@@ -6755,8 +6767,12 @@ static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
 
 	enable = 0x01;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
-				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+					sizeof(enable), &enable,
+					use_enhanced_conn_complete(hdev) ?
+					HCI_EV_LE_ENHANCED_CONN_COMPLETE :
+					HCI_EV_LE_CONN_COMPLETE,
+					conn->conn_timeout, NULL);
 }
 
 static void set_ext_conn_params(struct hci_conn *conn,
@@ -6860,6 +6876,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		/* Pause advertising while doing directed advertising. */
 		hci_pause_advertising_sync(hdev);
 
+		set_bit(HCI_CONN_CREATE, &conn->flags);
 		err = hci_le_directed_advertising_sync(hdev, conn);
 		goto done;
 	}
@@ -6946,7 +6963,9 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 done:
 	clear_bit(HCI_CONN_CREATE, &conn->flags);
 
-	if (err == -ETIMEDOUT)
+	if (err && conn->role == HCI_ROLE_SLAVE)
+		hci_disable_advertising_sync(hdev);
+	else if (err == -ETIMEDOUT)
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
@@ -7283,9 +7302,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
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

