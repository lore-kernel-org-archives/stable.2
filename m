Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E01400987
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408083; cv=none; b=piJ6Csko6gK1tmk2O7iK0ijTopOSUpfYOXF26qIcKBFHwnXMenzCq54DCBWNi61XMbu8tu1V9ep54DcRAqGKg0hHjGyze2B5CPjScKx143ZeI4ylyvnH8KQzDGAoGE0v/cMFc+mrrf5BUZR5hEK7utrgZ3+dcIo8PW3KCxJ1o3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408083; c=relaxed/simple;
	bh=KNRAAbqu1Obt0UZbjeHAL9gbNhol/L5We/nxyOLLAyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3FQDtiqbBkVlALguv1xn33CgGWXCvGtVgI3luTwgnrezbk+epwLpwwmriY1tlyLUWS+yOW8+70/ImVz0oXOTFGyjydKTzBlCaG708fGziqI48mzgBtOHmpO6WaeXwzpLHzM3xFQIvBDtc7APdbpC6RVMeHUAhMvpclte6jy/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbJEwkbN; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbJEwkbN"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6651abddd5bso239090d50.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785408081; x=1786012881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ueDqaJswg5YZC13Y+Gtq4EWYGPBi+5EAXfQ3I53DMc=;
        b=RbJEwkbNHoAYoScpr+KPIee7P6ydxzNrcPmg+x50BLwtwELfRp5wS53Q4dPAnXGO1h
         bn3rHm2ngwQwzZStgjQwT4h0pSogtp2unynNOxJwSHRcigRLghb1DjYTiHNee16+ecuo
         DhmYS3WOgn83DMR6dwNPyZY+EmP1hvurb5Ww9aFiMnZkWEUn2c93ymPw47/XsPGcbXCL
         cqVuhd7XJ4tvOIhVwGDTju1vYWr9VyyiR+vziDcBxSgt455j5GPJZCRxj+bSCfKuUYWC
         LhJk/hJIK0RiHU0eYIPKn2IXQqGYHuDwZfvo0KCijWchrBAfyf4pLs3l1eL6KZmgXXnC
         JybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785408081; x=1786012881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ueDqaJswg5YZC13Y+Gtq4EWYGPBi+5EAXfQ3I53DMc=;
        b=YscUstGIA0J6Cv3RLlU9UtcOdpdchQjkyzESeZAEy6zt39g27nc7zAP62bm2TKqG5M
         RbYn6o1/TboW1EyzGUw9dw+JKHYuAMTHXsYDw4TLmqB4Y1YZRVbPFf2de4RD+SiQIIFl
         DU4ofGA8JvsLtWPMEFeTUSLg2oPJYQzdwzbDWAYA8kxhYPJ/o03A7pbWQnQNhTDeM1pA
         piWpwnqsGHOq61G0FIomOsxm1zPbe1JF0f2Ib7PNBGQ1kKPJfC8x6ejDCy0J0yhSD6BE
         puTofZj+bDMWqd+hZUBEghDyp/m8ayJh9eKPNArZJBOjSxVdr10XM3YIHQtnPwvFg5d6
         rU2A==
X-Forwarded-Encrypted: i=1; AHgh+Rqnyxc+j0Ahfs+fx24VdQL0EBhjkAEDE7HwUUc3y+VmcQ9GLvfX07FOoEuyauvKHXOOqxYqiGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHDNEM02XygOWBnsN4AanxYBXlSeNGEXc3jz4uwsXid/vp1ro
	e9phdn/qSs2z8B494lWWkfKk/22CzZgJMMl1+HPld+3uu0VQpHjgSc+B
X-Gm-Gg: AR+sD12opUeOTvzUBz2frlIRUu51ri/CseALNjTkigLe2LRjoQBes3PyXGSsO1dfKqN
	NglSJhfsi5Z2JXmddQG6AgQTYchPDOq958luMOCvvjJwOLsXn6MmvoHBL2t0m4byrUV6/OVgYkm
	S5rAxzqwTjzzTZWdsh86RufRO0iCXa3TSQ9eevltfZOwX+Xaeamau9Z+/FvVlSnWpXtYxxFBrMK
	FQdGcw0OSP/IcAUjN4IiKLYYFm8n0A8Vy614S9lYV7Mgq5OrTDHNeFuxWmRe4afQRWHEDvUU+20
	zV0vFwPXcPv6O16E+XLaKUv2jyeZsHJWou/Sv0utiM2JEwsM/zN6i+68Nyrw97s2lvXLRjsmyar
	EvLQA66ymucInrfkxqRXTZO8fOOgfph/rpL4skSL+kSEOlvXDLrZsUmypEUis7vLl4aqnB8UnTy
	NjACEOSoSg4IJbmwSVOr9NYXbMSVTFZxxr81RBRd+Pztwxc4ZpzWL9HDQfdAPY03GR3Si3eEwxu
	TTuoD2oze+/vNKba/hBCAXvvF9WO+jp9qP5uMWdoHR+q8TNDHnHCyc=
X-Received: by 2002:a05:690c:87:b0:81f:45f0:21b7 with SMTP id 00721157ae682-81fb872a7bdmr25021357b3.0.1785408081018;
        Thu, 30 Jul 2026 03:41:21 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb892f53esm7676037b3.21.2026.07.30.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:41:20 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: hold conn for LE timeout work
Date: Thu, 30 Jul 2026 18:41:03 +0800
Message-ID: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

le_conn_timeout is embedded in struct hci_conn, but queuing the work
does not hold a reference to the connection. hci_conn_del() uses
cancel_delayed_work() because synchronous cancellation would deadlock
when le_conn_timeout() itself calls hci_conn_del() while holding
hdev->lock.

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

Take a connection device reference before queuing le_conn_timeout. Drop
it when the callback finishes, when queuing fails, or when cancellation
removes a pending instance. If cancellation races an executing callback,
the callback retains the reference until its final access, avoiding the
use-after-free without waiting under hdev->lock.

Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_conn.c  |  8 ++++++--
 net/bluetooth/hci_event.c | 25 ++++++++++++++++---------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1966cd153d97..501a2dd2543b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -723,10 +723,13 @@ static void le_conn_timeout(struct work_struct *work)
 		hci_dev_lock(hdev);
 		hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
 		hci_dev_unlock(hdev);
-		return;
+		goto done;
 	}
 
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
+done:
+	hci_conn_put(conn);
 }
 
 struct iso_list_data {
@@ -1267,7 +1270,8 @@ void hci_conn_del(struct hci_conn *conn)
 			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
-		cancel_delayed_work(&conn->le_conn_timeout);
+		if (cancel_delayed_work(&conn->le_conn_timeout))
+			hci_conn_put(conn);
 
 		if (hdev->le_pkts) {
 			if (!hci_conn_num(hdev, LE_LINK) ||
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 741d658e9630..e1e6b5092ce8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1566,10 +1566,13 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev *hdev, void *data,
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
 		conn = hci_lookup_le_connect(hdev);
-		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
+		if (conn) {
+			hci_conn_get(conn);
+			if (!queue_delayed_work(hdev->workqueue,
+						&conn->le_conn_timeout,
+						conn->conn_timeout))
+				hci_conn_put(conn);
+		}
 	} else {
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 	}
@@ -1614,10 +1617,13 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 			hci_dev_set_flag(hdev, HCI_LE_ADV_0);
 
 		conn = hci_lookup_le_connect(hdev);
-		if (conn)
-			queue_delayed_work(hdev->workqueue,
-					   &conn->le_conn_timeout,
-					   conn->conn_timeout);
+		if (conn) {
+			hci_conn_get(conn);
+			if (!queue_delayed_work(hdev->workqueue,
+						&conn->le_conn_timeout,
+						conn->conn_timeout))
+				hci_conn_put(conn);
+		}
 	} else {
 		if (cp->num_of_sets) {
 			if (adv)
@@ -5771,7 +5777,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 			}
 		}
 	} else {
-		cancel_delayed_work(&conn->le_conn_timeout);
+		if (cancel_delayed_work(&conn->le_conn_timeout))
+			hci_conn_put(conn);
 	}
 
 	/* The HCI_LE_Connection_Complete event is only sent once per connection.
-- 
2.43.0

