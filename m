Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC93955C3
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596082; cv=none; b=JOajOXFBePs8BxJeptD4qRESecYlN+mdkgzEvgleYRjgyrRym2FuEZ78ZDc5p1/nX9rI+rKFT54EzcNm9besvUUPQCyx0VViaUFn8JwrkmaBd6YEyKN7uSC8fHD9qe5K/D4mBt9S/KbI5hmioavuOq8bn52CXYkNIktMPed2wcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596082; c=relaxed/simple;
	bh=11NBSjg42+2drECD1whaM/XOV84FQjRFPCasLSN7J3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krtuiUQyUn0g5eVavLF9+p1DMg1v/koa3oIn+8ZpvvJLBM+/cM6fcX6enikgtZyhm4cklaOC6KE+qzYbfko3dvoiDmb9hFQq/TM12/JtaFqRJHPf32RhyIUxwE3LKr6C0NKcP9xSmq2vPeCmkza3gsFCuagueHt16a6mAmf2lx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwTIUWWN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwTIUWWN"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84eb53344afso265010b3a.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785596080; x=1786200880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JJWPlhmOjv/505wIwonl2BZfI0kiebiBlhqn470lSEw=;
        b=lwTIUWWNv/NjhnFPLn120mTK7XZNPPvx+aiGlBemAP1HB6CknLTuWg4NMtWH1wy4YI
         PwKviMrCKglTuZgpuit6wrdt8G9jXThAIrB0MoBUORvn7v4p7PxYkcDTfYAzEUX0JzaA
         apv6hA4Agp58Xc9dX3NO0a5gdDXVpeWy2M3ZF2xfIsp6LFenC047y8/ItOJkwX45oI4M
         js9howMFG79mXybGm/3aaXPg1K4YKkhvU6fHGORn+Tdjz5FUGTRcwzGPDdx0kpf9t9dW
         Hkq/oFJMmcy1UvCI6RqDg+X3TWkvvk9kbTkbVzjs9xN6M8vxf9/9jdGU/oG1BmFE8Aik
         nX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785596080; x=1786200880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JJWPlhmOjv/505wIwonl2BZfI0kiebiBlhqn470lSEw=;
        b=Xqcn+u525whsG6cDXgvPtfKEmc/qUL7/buVQbuwgbGtI1EB2xCB81eALBGrmW05DX0
         Web+uTvSk1m20Rq84L/brnq6/yAVp+R8n3XEjaeQVgQsodPtjPPZHoPkchvyigKM3G5Q
         q3BHdoHZaxEka0vkNG9KkxpFeks0/fbytqwNn7Us742JV0IkfZerZqkE5hnylUixKWxX
         huZoqMXwSzwryCoFAn3Rf9/4WQ3DgM5AA/xIkRB1Uu/+LTPW6gtccIOHRsa0io1IfATZ
         /L5ttqV8kk065ArcalSr6WhGsHSOFWSAOUyV98GHDf/4TCX2WHQzr8or6zMGP07AmKcJ
         L5yA==
X-Forwarded-Encrypted: i=1; AHgh+RqSBSi9uNz5ASsSNdxU/3k91y64JbKYvhOWzsissaK24fZjkp7S4HitGxelzlzsvfxzMvaUc2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02iPlzpc0U1Ic8UY0c6t4gsYcyBGsm3R5Ue/1YYQHgoXPIehH
	u365Om9g9uHPLz7TgUkO9s+iE0mWHxUojjI9tc5BxgEop3sKifETAAKF
X-Gm-Gg: AR+sD12kvIXpV/ddav0Vvx5QT5NOnlRhfHEjLQDyHay6WbLRs4Kl2pPl8bxbzT+Hu8o
	FxoC4Y5D3LaT5QkfvBOBQaLl+NArrCQ5CkEeqVGX1qoct0tDqHWyyOtcHSWoypiDg9XZXzCJeJm
	3/TtaFgAbKdUv1DFQuh9BiR4hijigR7SqpThYLeomKUTeQpbkvbxzWgQojtuezS2rHJbBPkFr5r
	yxboQYg7HEyQ3IPfq5sQvM8WGWHQJ7HknOD4uiCbKX2WqC96QXxrPv/TnJIsmwGB4ZrijjQjTXL
	CKPOXeL7TsoXt2zpBNrTLUG3i2hybAAFz5ICQRneiwQAFDPPZqMkeKriSR/XcaE4+bohvzxCBWK
	CoeNo4LjcNljSkcXZh5aU92ZzIti+iDxoYQcFPdF3ZEFpQGcE0My8XOA+lQCURK2SBWka+REPWu
	jPHc6IZIEqgfPpCA0LAyqnbzks16PNh2u3CZRJJuPN6jvDaOwxTLxdhyrppsXe/E2iaJC0EUCGv
	YdlTyt/2EJN8u7OHDZS81XTfIVOhB2SprIjqRui9gpSn0AYmw++jA8=
X-Received: by 2002:a17:90b:58c3:b0:38e:ab3f:2c99 with SMTP id 98e67ed59e1d1-38fbc4c673dmr4745415a91.2.1785596079966;
        Sat, 01 Aug 2026 07:54:39 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab1334cfsm15403536c88.1.2026.08.01.07.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 07:54:39 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_sync: wait for directed advertising completion
Date: Sat,  1 Aug 2026 22:54:30 +0800
Message-ID: <20260801145430.3560911-1-nicoyip.dev@gmail.com>
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

Mark directed advertising as an in-flight connection attempt so teardown
can cancel the wait.  Disable advertising synchronously when that wait
fails, and preserve HCI_ERROR_ADVERTISING_TIMEOUT for a software timeout.
There is then no delayed callback that can race with connection deletion.

Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-nicoyip.dev@gmail.com/
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Remove le_conn_timeout instead of adding references around delayed work.
- Wait for LE Connection Complete from both directed-advertising enable paths.
- Make the wait cancellable and disable advertising after a failed wait.

Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-nicoyip.dev@gmail.com/ [v1]

 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 45 --------------------------------
 net/bluetooth/hci_event.c        | 25 ++----------------
 net/bluetooth/hci_sync.c         | 42 ++++++++++++++++++++---------
 4 files changed, 32 insertions(+), 81 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3df59849dcbe..937c9ba1e6b7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -761,7 +761,6 @@ struct hci_conn {
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
-	struct delayed_work le_conn_timeout;
 
 	struct device	dev;
 	struct dentry	*debugfs;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b1f911fd4ad6..74bf0686f428 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -687,48 +687,6 @@ static void hci_conn_auto_accept(struct work_struct *work)
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
@@ -1121,7 +1079,6 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
-	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
 
 	spin_lock_init(&conn->proto_lock);
 
@@ -1269,8 +1226,6 @@ void hci_conn_del(struct hci_conn *conn)
 			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
-		cancel_delayed_work(&conn->le_conn_timeout);
-
 		if (hdev->le_pkts) {
 			if (!hci_conn_num(hdev, LE_LINK) ||
 			    hdev->le_cnt + conn->sent > hdev->le_pkts)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 741d658e9630..b6b279b5a103 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1557,22 +1557,10 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev *hdev, void *data,
 
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
 
@@ -1604,8 +1592,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 		adv = hci_find_adv_instance(hdev, set->handle);
 
 	if (cp->enable) {
-		struct hci_conn *conn;
-
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
 		if (adv)
@@ -1613,11 +1599,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
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
@@ -5770,8 +5751,6 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 							  &conn->init_addr_type);
 			}
 		}
-	} else {
-		cancel_delayed_work(&conn->le_conn_timeout);
 	}
 
 	/* The HCI_LE_Connection_Complete event is only sent once per connection.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c8d14128c363..714bb1d55926 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1616,7 +1616,9 @@ int hci_update_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	return __hci_set_scan_rsp_data_sync(hdev, instance);
 }
 
-int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
+static int hci_enable_ext_advertising_sync_ev(struct hci_dev *hdev,
+					      u8 instance, u8 event,
+					      u32 timeout)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
 	struct hci_cp_ext_adv_set *set;
@@ -1656,10 +1658,16 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
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
@@ -6605,7 +6613,11 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
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
@@ -6656,8 +6668,12 @@ static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
 
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
@@ -6761,6 +6777,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		/* Pause advertising while doing directed advertising. */
 		hci_pause_advertising_sync(hdev);
 
+		set_bit(HCI_CONN_CREATE, &conn->flags);
 		err = hci_le_directed_advertising_sync(hdev, conn);
 		goto done;
 	}
@@ -6847,7 +6864,9 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 done:
 	clear_bit(HCI_CONN_CREATE, &conn->flags);
 
-	if (err == -ETIMEDOUT)
+	if (err && conn->role == HCI_ROLE_SLAVE)
+		hci_disable_advertising_sync(hdev);
+	else if (err == -ETIMEDOUT)
 		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
@@ -7184,9 +7203,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
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

