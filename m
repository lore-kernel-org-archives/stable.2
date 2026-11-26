Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736926;
	b=gYsMgIp7XPiPESURYsFmIwXrm06TDje1zv/zNMZZ9zmMhb196KnjGA5sfsjjBb7cHvIX
	 9G5ouxiPLcdOkrSR7FOFz/NKlC29l09m7wkURl4HFvwii7NcTAAVINtNLFB0s3o0CO8DL
	 CE9ciCjnIbKvPWjC0XXpPsGH/KspXtv770VE0hSVU3uiLFcV6ZJHVLG+sYq3WRLrUOIS6
	 Ncr37DVHcDFsykXCT/hxAZmQnCNeVq1met6u1++ayhFaV5L6qf4N+QkdlG6m8QzFLpAP3
	 bqv5ljiO54YA/j3aTjdPekZy+lVJ6IONv6gldxDDzGqINDLCMyB1LP6z1Smp0XHKzcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VxeD4WAIT3mFKrFVmaWm8s04eoB2/2UJsBXQx10SSts=;
	b=QPtv37Bcr9+XC3YSX/FxpnKebfGPQ1yc9dg9Q1kz7DjOog8oJ5T3WdE8qRCI43Bbf8pS
	 UfhNUw55XJfaGZ+O6YqDZ70EhgBbz9EsGMiNPHR8V9Jh5/yLde7Pj2HZ+plpROSDI5Cw4
	 98sFzWmUFa3z5QPNj1EXEWTlTMQUV+Xr3VV+c0JLL8jHQBxrYKvmt5eU2rAaKSgQwYIeu
	 tgW/vHyUD2U9MlZ2aPGab7efksnuFBmhVmKsWzEFpL0PhscV+YPZraIpJ3TW/Ir3D3ruk
	 QFqSDRJ/21KvagkNWw6RvmJpQq2gws7OG2iXKn2c/MGlTAOr9wUzKpa2tKBf+BEzeEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J0woiC7F;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0ED606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 23:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E0ED606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J0woiC7F
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5364d86f7f0so78553401cf.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795736925; x=1796341725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VxeD4WAIT3mFKrFVmaWm8s04eoB2/2UJsBXQx10SSts=;
        b=J0woiC7F/RACfXylDb2Pg7RFxj87Lf/WXYuSrub40GGj7yRZLI+lCaJTE7cSfsZNP9
         NRDLm+Dh3Rngi2KnlH5tdMM22LVP+/FBnLvxr0syYNeCJMh8ev7DwL6Qdyw+uYo2FGX7
         WzJnj13FLrL+y2E3/6fsU2tgJYajJ0oEcUYf7EHxwcTUmjHYAcNmheNJI869x/ka88d/
         es38XreCpxgFDIKafUBUIE3qb9Vk679SDfnxw3IvE/d4ZPeUSeyqffXUzPIUXKpPyqeM
         rHJTiQ2wTKAQkWJ/EP+vAsNwYKbIqeuDyBCS8C7IqlkMQiq1/iT9PE+HUbNXJduAmUkV
         fH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795736925; x=1796341725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxeD4WAIT3mFKrFVmaWm8s04eoB2/2UJsBXQx10SSts=;
        b=P/ZgYrVx5iPhmByu25ztQwKePefAKPQxQ+Ko3vjy/99Vd38m8KkFSQgUgx0Ba4bWPS
         St4f66HO8FB3vnO6O4hl7hc/XGIYR23GWnpBtzaYe8yE4baZl+oB1AmmwJUj26wNjdJD
         wfPgQQAhh6zHeinZTArcsol37KLjIHMt6uFLVxCdknlwUEaCssNvjqMYsEKNTjFuS/fE
         +JsgEy5QSnoHmoKHEGw62/ZUkBtaanK2N+lOd/Dg3903UNNNe8lavsOPa6hYIHLy1zm2
         rtsJMwGhKE88+BUqmoApol4wY2o8afEDFCnFEhnXNclBW8t/akXw8tuzXiAn9dWYZr5U
         CqiQ==
X-Forwarded-Encrypted: i=1; AL+hErF93cdk4t48YdizbUtE0K3yh5LqA8a03EjnJB3zzRQPTUgtye2UvqcaQ8j+2KnZu1T6MedSP1A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5vXVGPKckqnh4szwPMH/iNvFMOPtYBEFrtLgR3y0+ewReN5xs
	WKL1L5TrUPhhRNjNnOgEVeeKsQEv9Uh9AwLbJIFuNxMerqlNyitU4pVs
X-Gm-Gg: AZFdTZeMemc9dBHkZgVrKeq48nMwxXCay1uIM4vxUjEsEEOP9STQlOqeDMGaiDY1/Qq
	idGGU8ojZVG2eeg9iN2tVqADaBq8HzcysuCQycWGXzmUwXuDXGf2dKxlzMpXlxWiAq7VFYfzgJ2
	+UnKbzwJqcp7WRqEcSKOOXVR4n08F01SnIjl5KqWjyCsrIZjg4UYtudeKuheXXVtd1Kkpq10s/Y
	xOG/pVvJF23XfqQEojf9QXTnLg1a5pNh64LKoOa3i6+Y6stMbIc4UrsVzlPvppp564iPgemXXLS
	vP0YMlf+rH2BMxWBJwqNbA4BXuY6vFCdbmyZF+eGZFexQ1ySPr11fuABFUWlSkGtxGpF8mtJoea
	LHfVCWuu5EOmCxeTrgvqwEn47LDlIuk9rTvzq/acA9ML01i32x6a72WD9UxyMBvlL8R9mMtSOe4
	VaxtvyT0quoZLO6+vSrnet1Q+RmEqFAS1SconNQpB3l0qGhb1NsgGZ2RzdOT6MwftEGnR+SAH2P
	qRZo0Gikp0K43sWYi7SeGDUQuP2RzNzHPHuAfV7XIuXC8AsgUkot164YUC5VaVmsOmwgus14LOq
	yMtFn3NXoAIpLux2IJWV0tbyKNJulZd4f5/Eo0GP0MRV9z4iKLPg+B3/uB7UroN/lD70Ecj7M6V
	ROhwzKCLHgfs2shbzw1Kq/QjttIti8+Ykp7swZUQ8j/RgYLqCmEMy
X-Received: by 2002:ac8:6906:0:b0:55d:330f:e2d3 with SMTP id d75a77b69052e-55d76a204b7mr376177381cf.34.1795736924942;
        Thu, 26 Nov 2026 15:48:44 -0800 (PST)
Received: from Apollo.mynetworksettings.com ([2600:4040:a89a:c500:a9e0:bc34:811c:7ed0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7884d01csm193792991cf.21.2026.11.26.15.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 15:48:44 -0800 (PST)
From: Enjan Chou <zhouer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Siwei Zhang <oss@fourdim.xyz>,
	linux-kernel@vger.kernel.org,
	Enjan Chou <zhouer@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: Don't leak hci_conn when dequeuing its create command
Date: Thu, 26 Nov 2026 18:47:01 -0500
Message-ID: <20261126234701.215190-1-zhouer@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_abort_conn() returns without queuing abort_conn_sync() when
hci_cancel_connect_sync() dequeues a create connection command that has
not started yet. Nothing else fails the connection in that case: the
destroy callback of the dequeued command only drops a reference, so the
hci_conn stays in the connection hash with abort_reason set, which makes
every later hci_abort_conn() on it return early too. For LE, its
connection parameters also stay on pend_le_conns.

For an LE connection made through L2CAP (BT_CONNECT, still scanning)
this leaves the adapter unable to make LE connections until it is
powered off. A new connect to the same address reuses the stale
hci_conn and never completes. Once the peer's advertising is reported
again, check_pending_le_conn() queues the create command again, the
controller connects, and le_conn_complete_evt() bails out because
hci_conn_set_handle() refuses a connection with abort_reason set. The
hci_conn then stays in BT_CONNECT, so hci_lookup_le_connect() keeps
returning it and connection attempts to any other LE device never
start: hci_connect_le() returns -EBUSY, which check_pending_le_conn()
ignores, and hci_update_passive_scan_sync() does not start the
background scan they wait for. A dequeued BT_OPEN (ACL) connection is
likewise left behind.

The early return was added by commit 881559af5f5c ("Bluetooth: hci_sync:
Attempt to dequeue connection attempt"), when hci_cancel_connect_sync()
only tried to dequeue BT_OPEN connections. Commit 12917f591cea
("Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()") dropped
that state check, so LE connections in BT_CONNECT started to hit it.

Queue abort_conn_sync() whether or not the create command was dequeued.
hci_abort_conn_sync() sends no HCI command for a connection that never
reached the controller (BT_OPEN, or LE still scanning) and just calls
hci_conn_failed(). If an advertising report queues the create command
again in the meantime, that entry runs after abort_conn_sync() and fails
hci_conn_valid().

Reproduced on bluetooth-next (ffb95458a0f7) with an RTL8761BU USB
controller passed through to a KVM guest, without bluetoothd: an L2CAP
ATT socket connects to an advertising LE peer while a BR/EDR connect to
a non-existent address keeps the cmd_sync worker busy paging, and the
LE socket is closed before the page times out. Without this patch every
round that dequeued the create command (11 of 11) left the stale
hci_conn, with or without discovery running; with it none of 60 rounds
did (50 of them dequeued it) and LE connections kept working. KASAN,
lockdep, DEBUG_LIST and DEBUG_OBJECTS reported nothing.

An AI coding assistant (Claude) helped find and analyse the problem,
write the reproducer, and draft this patch and message.

Fixes: 881559af5f5c ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Fixes: 12917f591cea ("Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()")
Cc: stable@vger.kernel.org
Signed-off-by: Enjan Chou <zhouer@gmail.com>
---
Found on a desktop running Ubuntu's 7.0.0-44 kernel, which carries
12917f591cea: after repeated failed connection attempts to a BLE device
the adapter could not make any LE connection (noticed when a BLE scale
stopped connecting) until it was powered off. What kept the cmd_sync
worker busy at that moment was not captured; the reproducer uses a page
instead. The same reproducer also leaves the stale hci_conn on that
kernel, and does not with this patch.

hci_cancel_connect_sync()'s return value is now unused (hci_abort_conn()
is its only caller). I left it as is to keep the fix small for stable.

Reproducer:

  # Reproducer for hci_abort_conn() leaking an hci_conn whose create command
  # was dequeued.  Python >= 3.14 (LE L2CAP addresses), run as a normal user.
  # Needs an advertising LE peer; bluetoothd and discovery are not required.
  import socket, subprocess, time

  PEER = "E1:E9:83:B4:21:65"      # advertising LE peer (random address)
  NOBODY = "02:00:00:00:00:01"    # BR/EDR address that does not exist

  le = socket.socket(socket.AF_BLUETOOTH, socket.SOCK_SEQPACKET,
                     socket.BTPROTO_L2CAP)
  le.bind(("00:00:00:00:00:00", 0, 4, socket.BDADDR_LE_PUBLIC))
  le.setblocking(False)
  page = socket.socket(socket.AF_BLUETOOTH, socket.SOCK_SEQPACKET,
                       socket.BTPROTO_L2CAP)
  page.setblocking(False)

  le.connect_ex((PEER, 0, 4, socket.BDADDR_LE_RANDOM))
  page.connect_ex((NOBODY, 1))    # pages ~5.12 s, keeping cmd_sync busy
  time.sleep(3.5)                 # peer's advertising queues the LE create
  le.close()                      # hci_abort_conn() dequeues it
  time.sleep(3)
  page.close()
  time.sleep(30)
  # Without the fix the LE connection to PEER is still listed (state 5).
  print(subprocess.run(["hcitool", "con"], capture_output=True,
                       text=True).stdout)

 net/bluetooth/hci_conn.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e86b7a310a..3b172e8f13 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3311,11 +3311,12 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	conn->abort_reason = reason;
 
-	/* Cancel the connect attempt. A return of 0 means the create command
-	 * was still queued and got dequeued, so there is nothing to disconnect.
+	/* Cancel the connect attempt. If the create command was still queued
+	 * and got dequeued, nothing reached the controller, but the connection
+	 * still has to be failed: abort_conn_sync() does that without sending
+	 * any HCI command.
 	 */
-	if (!hci_cancel_connect_sync(hdev, conn))
-		return 0;
+	hci_cancel_connect_sync(hdev, conn);
 
 	/* Run immediately if on cmd_sync_work since this may be called
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
-- 
2.53.0

