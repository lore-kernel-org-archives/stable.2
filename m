Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005339;
	b=WMsXQ4mVpx0ZwrEPuXl7mgCkNOaaXAdL6UkzQBQW+n4etYs26tX5PjcvCgCwPNdbC06G
	 wpKhxL2H6NadvuJDwRJchKR2N2hAgQAK1L3EZVBUupyMbvj7aZ+gk46Juc6fwKHIBzy02
	 pALUs2IjZAUppAOssCpW3kWUMDXxDqyglZzvUvCtNxBrcoeCjvevEkspmEayXZge5GtEj
	 BVV8Z2q30j4jxH4jNjZr1jMqZfPzUSCxAtC6aqVELWCMxRJNnwqoA0DtXmp3+M0kgdQj9
	 utvaaAFOdGyTE85iIXjrJ9ZDWzq79c+hYkeZwFDG4IBdgS/r/b/UvNsZUyCdRTPOoXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LJABUKTN7kpkN8XdhP9ka8xCIsWxRGSyyuS9ICn+GoM=;
	b=EjqPCFm9zTsb9HqcPQVezLgg/0Ztmlv0991/OVFUtr/7XtyT7+Wg22yEs8ISaSaXWHCm
	 CtImAaE36+CmlrTV5HeWZyFmUu0w3FjApkwp5KSXaon3CrpU1FEgV620tq4HVLYx/HK5v
	 FlTQRdEAjGzhDuBtMIg0iJ+DSD472aiEjWuTtkhutagBvRTy3FXqewWXjTVSdvKT8/NiD
	 HMelO7iVqG2uqIBpCbA/a1+Nn0JR0/pBIDfJ/DgeOxJUEB251Yyw0VNoRmkwcoXKn20p/
	 h33etwxLXp4vXlYq3jaE7Jo+s0i2opseOdJGEkuFUUadWI/c/bjmrJD9P+c/f1mJehg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnfms0QW;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CBC606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95CBC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnfms0QW
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2edcf6c3a57so1348305ad.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795005338; x=1795610138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LJABUKTN7kpkN8XdhP9ka8xCIsWxRGSyyuS9ICn+GoM=;
        b=Nnfms0QWxkSnJSNcwXez2Rq4hDfI4LE4q0O4T3nrnT9N2vxM5XjmE51txUY4vvVpk1
         dIW1i/VLRko8c4e2FzvgD1hIbluIr9hCf+NGB50cn+k8qPAYo0ugXCrnOktT35smLh1L
         MCwsKAjjWbbt6kP1ZlMsfl507Rl4nfgwS+wcDtUUH7zktgpngCCU5XW+A+/JVoyS8HB/
         KBUfXFXdGO6lgsXD+yB+jz3UW0HkHfXyXUXkEl4vvhG66UvVMp8LWzVNF8wGqR3TrZE0
         SbDivfHfIsB5zB5v360TeSJ+GNlRRho8Y3ufNVybu9k81AQyR+I/We60nEx36/iJfN1D
         Qe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795005338; x=1795610138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LJABUKTN7kpkN8XdhP9ka8xCIsWxRGSyyuS9ICn+GoM=;
        b=j5ysstqtsE2K76JRP4vMMBtXBtMBgVJFlJruGv3DcSKqd171Qz4sQLTXu4T/w2BXJe
         f+yapP+V5+iOvS+pDjo6Iw7jiHfKgS1+rEgnBYV8phhBRcjcozx/xT5XOjciAAQScOIO
         QNKTB44htGIuPIWJVPZ2zBEkfgBEcUoPv6HKDKt7TrEzY9zZFbgFPWfwFN5yEz+xCC+1
         qwgESylDf75J96eoaNoVV97beoTdIA70hBTegoGMR0QkFVSwx6rhV93aFIfphVAHlzJd
         zvcgsq+aUvGWcbgow2QNo1dMadA5xGCITD3wivzW5fj6adNZTSfZWGFTHK74KUkZRzHR
         RAUw==
X-Forwarded-Encrypted: i=1; AL+hErELKjQ3UC/qnbQ7O4ty+zd+0JiUYI6AEvK+W2UAaPcX5yqlpLKKWJTJ0hV/bVT5kU2yO80+bJU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m9TyhYrMuJuOxEuPtdXfkEwRgDl1IWc75cGNVmVceCdjMO+tJ
	y7j/Eo5pB2BD0H/tEU881m3bLTy46Edd1TIP9KWDC05Xp876gB8+woCk
X-Gm-Gg: AZFdTZeYC49sdj3RY+QvxiCAF2Vt+AFSoq3qmLVx4rvUfC+5Uy0jGQsaedFG1XOrlc3
	aVNOQZF0O5EL3sPUJ6upISFBais5zZtH71KhbU66PqRaj2LJOlHPp7X69iYeuMsYd/5l5o91rap
	53x/XCa7vVUdg3ipy7mhAOotM6Lq1kRiMIeoSDoQHA8VD9+VGESLQnb1yZwjLs3V64DeD3Bgaeu
	SxlLjC5OkjTfo/nkxRPQuILWOyv+RHsF/egvG2PXbCjnSN0IDKauoCksZzW6SsCiWBqceVyWRIR
	RUOvAKNu2/PSDM71Vo8k2qhf508Qi/G2NxpWBklNUY0cRc1+YAq+6ktvT/UVSdOug08XwDXbMx+
	+Ca71n9I3lxaqCI5I1EKA2d/7MPpvnFGPLqOcpb/bTZvvZxoZQsVbtFSC+oDBxARaaPk8u5nQLg
	QNLe8lEJwc0jnRv6nSQy6ajDPhdE03yEnsCSDfmPCu03IzNB3Ady8VfAStpDjv2h6RmQisjxFtk
	xMLmXpuySC07bFk65e6+u8/r+a7P4a8TmFRZt7IX9DeMX8cyTFxO9kQzIMFT1poHfqEoKKKTMCg
	pevERnpvjmlmFo28ZAUdlR4vpfecmEl2GZ6uk2FeaazqB+TROg==
X-Received: by 2002:a17:90b:1d47:b0:3b0:975b:2256 with SMTP id 98e67ed59e1d1-3b3d07a8e0fmr4090356a91.4.1795005337818;
        Wed, 18 Nov 2026 04:35:37 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d5570208sm1700937a91.0.2026.11.18.04.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:35:37 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6] Bluetooth: hci_core: lookup hci_conn on RX path
Date: Wed, 18 Nov 2026 12:35:33 +0000
Message-ID: <20261118123533.25-1-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Bluetooth: hci_core: lookup hci_conn on RX path

Backport of 79a2d4678ba9 ("Bluetooth: hci_core: lookup hci_conn on RX
path") for linux-6.6.y. Adapted to this tree: 6.6 still pulls ACL, SCO,
and ISO headers with skb_pull(), and sco_conn / iso_conn have no kref,
so the SCO and ISO paths take hci_conn_get() under hci_dev_lock and
hci_conn_put() on every exit. The L2CAP change matches upstream: look
the handle up under hci_dev_lock, call hci_conn_enter_active_mode()
there, and take l2cap_conn_hold_unless_zero() before dropping the lock.

hci_acldata_packet() looks the connection up, drops hci_dev_lock, and
calls l2cap_recv_acldata() on the raw pointer. The first access there
is hci_dev_lock(hcon->hdev). The hash lookup takes no reference, and
bt_link_release() frees the object with kfree() from hci_cmd_sync_work.
SCO and ISO have the same shape.

CVE-2025-68304. Only 6.6.162 was checked.

Tested on Linux 6.6.162 KASAN with /dev/vhci. A userspace racer does an
outgoing high-security L2CAP connect, floods ACL data while the
connection is still hashed, then completes HCI_Disconnect with status
0x1f so hci_conn_del() runs on hci_cmd_sync_work. The unpatched
campaign kernel (6.6.162 #3) printed:

  BUG: KASAN: slab-use-after-free in l2cap_recv_acldata+0xcc8/0xe60

Read of size 8 by kworker/u17:0 on hci_rx_work. Allocated in
__hci_conn_add from hci_connect_acl / l2cap_sock_connect, freed in
bt_link_release from hci_cmd_sync_work, last related work
hci_cs_auth_requested. The same program on the patched kernel
(6.6.162 #1) finished 99 connect/auth/disconnect rounds and 1589888
ACL frames with no KASAN report.

Cc: stable@vger.kernel.org # 6.6.162
Signed-off-by: Yu Junzhe <junzheyu1@gmail.com>
---
 include/net/bluetooth/hci_core.h | 19 +++++++----
 net/bluetooth/hci_core.c         | 69 ++++++++++++++--------------------------
 net/bluetooth/iso.c              | 29 ++++++++++++++---
 net/bluetooth/l2cap_core.c       | 23 +++++++++++---
 net/bluetooth/sco.c              | 36 +++++++++++++++------
 5 files changed, 105 insertions(+), 71 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 62804d98d..7a2729f86 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -837,11 +837,12 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb);
 #else
 static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  __u8 *flags)
@@ -849,23 +850,29 @@ static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return 0;
 }
 
-static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+static inline int sco_recv_scodata(struct hci_dev *hdev, u16 handle,
+				   struct sk_buff *skb)
 {
+	kfree_skb(skb);
+	return -ENOENT;
 }
 #endif
 
 #if IS_ENABLED(CONFIG_BT_LE)
 int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags);
 #else
 static inline int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  __u8 *flags)
 {
 	return 0;
 }
-static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
-			    u16 flags)
+
+static inline int iso_recv(struct hci_dev *hdev, u16 handle,
+			   struct sk_buff *skb, u16 flags)
 {
+	kfree_skb(skb);
+	return -ENOENT;
 }
 #endif
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 84d9a445e..defa61803 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3798,13 +3798,14 @@ static void hci_tx_work(struct work_struct *work)
 static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_acl_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ACL packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3816,31 +3817,21 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.acl_rx++;
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
-
-	if (conn) {
-		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
-
-		/* Send to upper protocol */
-		l2cap_recv_acldata(conn, skb, flags);
-		return;
-	} else {
+	err = l2cap_recv_acldata(hdev, handle, skb, flags);
+	if (err == -ENOENT)
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
 			   handle);
-	}
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "ACL packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_sco_hdr *hdr = (void *) skb->data;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	skb_pull(skb, HCI_SCO_HDR_SIZE);
 
@@ -3853,33 +3844,28 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.sco_rx++;
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
+	hci_skb_pkt_status(skb) = flags & 0x03;
 
-	if (conn) {
-		/* Send to upper protocol */
-		hci_skb_pkt_status(skb) = flags & 0x03;
-		sco_recv_scodata(conn, skb);
-		return;
-	} else {
+	err = sco_recv_scodata(hdev, handle, skb);
+	if (err == -ENOENT)
 		bt_dev_err_ratelimited(hdev, "SCO packet for unknown connection handle %d",
 				       handle);
-	}
-
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "SCO packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_iso_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ISO packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3889,22 +3875,13 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
 		   handle, flags);
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
-
-	if (!conn) {
+	err = iso_recv(hdev, handle, skb, flags);
+	if (err == -ENOENT)
 		bt_dev_err(hdev, "ISO packet for unknown connection handle %d",
 			   handle);
-		goto drop;
-	}
-
-	/* Send to upper protocol */
-	iso_recv(conn, skb, flags);
-	return;
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "ISO packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 static bool hci_req_is_complete(struct hci_dev *hdev)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 217ba98b0..cbb315922 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2059,13 +2059,29 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	iso_conn_del(hcon, bt_to_errno(reason));
 }
 
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 {
-	struct iso_conn *conn = hcon->iso_data;
+	struct hci_conn *hcon;
+	struct iso_conn *conn;
 	__u16 pb, ts, len;
 
-	if (!conn)
-		goto drop;
+	/* 6.6 has no iso_conn kref. Hold the hci_conn across the recv. */
+	hci_dev_lock(hdev);
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+	hci_conn_get(hcon);
+	conn = hcon->iso_data;
+	hci_dev_unlock(hdev);
+
+	if (!conn) {
+		hci_conn_put(hcon);
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	pb     = hci_iso_flags_pb(flags);
 	ts     = hci_iso_flags_ts(flags);
@@ -2115,7 +2131,8 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			/* Complete frame received */
 			hci_skb_pkt_status(skb) = flags & 0x03;
 			iso_recv_frame(conn, skb);
-			return;
+			hci_conn_put(hcon);
+			return 0;
 		}
 
 		if (pb == ISO_SINGLE) {
@@ -2191,6 +2208,8 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+	hci_conn_put(hcon);
+	return 0;
 }
 
 static struct hci_cb iso_cb = {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 94fddc456..5b5a9e763 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7752,13 +7752,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
 }
 EXPORT_SYMBOL(l2cap_conn_hold_unless_zero);
 
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
+		       struct sk_buff *skb, u16 flags)
 {
+	struct hci_conn *hcon;
 	struct l2cap_conn *conn;
 	int len;
 
-	/* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
-	hci_dev_lock(hcon->hdev);
+	/* Lock hdev for hci_conn, and race on l2cap_data vs. l2cap_conn_del */
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	hci_conn_enter_active_mode(hcon, BT_POWER_FORCE_ACTIVE_OFF);
 
 	conn = hcon->l2cap_data;
 
@@ -7766,12 +7777,13 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		conn = l2cap_conn_add(hcon);
 
 	conn = l2cap_conn_hold_unless_zero(conn);
+	hcon = NULL;
 
-	hci_dev_unlock(hcon->hdev);
+	hci_dev_unlock(hdev);
 
 	if (!conn) {
 		kfree_skb(skb);
-		return;
+		return -EINVAL;
 	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
@@ -7885,6 +7897,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 unlock:
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 75609dbd5..98fd0c89b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1432,22 +1432,40 @@ static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	sco_conn_del(hcon, bt_to_errno(reason));
 }
 
-void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+int sco_recv_scodata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb)
 {
-	struct sco_conn *conn = hcon->sco_data;
+	struct hci_conn *hcon;
+	struct sco_conn *conn;
 
-	if (!conn)
-		goto drop;
+	/* 6.6 has no sco_conn kref. Hold the hci_conn so the lookup cannot
+	 * be freed before sco_data is read. The lookup stays under hci_dev_lock.
+	 */
+	hci_dev_lock(hdev);
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+	hci_conn_get(hcon);
+	conn = hcon->sco_data;
+	hci_dev_unlock(hdev);
+
+	if (!conn) {
+		hci_conn_put(hcon);
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	BT_DBG("conn %p len %u", conn, skb->len);
 
-	if (skb->len) {
+	if (skb->len)
 		sco_recv_frame(conn, skb);
-		return;
-	}
+	else
+		kfree_skb(skb);
 
-drop:
-	kfree_skb(skb);
+	hci_conn_put(hcon);
+	return 0;
 }
 
 static struct hci_cb sco_cb = {
-- 
2.53.0
