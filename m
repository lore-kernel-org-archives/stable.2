Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060683;
	b=SPhrzT90oCqbwLRheo+MzJP7NifdXeyebU07LJCOCjcSYqUA0Q6eP5YADn2IDe3Sae3+
	 h4mWa5Tm8hSLTo14+urfx7TFLKgLvshPM0OTcTN+aggMo3PJIiap2xg5sfv0S3v/a7zns
	 FGv9+gfQhMDBrJKmaMnuJweTpXzddS+BBI92/AEa5lVxTNgMREphJt2JmN3Ey+6ZJayHW
	 L0zGXGEebjsjunKCTdTIt6YH2mv41QO6ObosR5Qc1uj2jy/VYVH/Si83btTatRR9+/j/a
	 CZWH+T86wjSbmprtZfbJHMn1gFFTRvv8ygngMzOckFJJbCGx0sCZUagiGUPcFcjqbng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Es6jUIuOc8irjGqlIWyhRGN6lehmXeYhL9z691YuNpU=;
	b=XPmoy0wpbo/dpbYysvQo+/OSMOqWTZq+EtPho9/ZQX+cJnV2UdnvIOFNCJkt2mtroxJk
	 6BVv+9LIp9yKr55uW2PDJ8RjYFiYi60hI6aAKwpN4/1UnrDAa4ow/9gKWhxrSwcJdqWsm
	 i0gS+xWejQrp9lNu4jhU5h14zKL22APmK12fWAb7S3MVT8EzqaSFz4vORXHXtAP57eu8I
	 zSYPS72LFgccK5ZIaIBfzIkrQFvabhMvWVbxqYwdr9fn8k7rraQtNyoBKJChtxhtIOYYJ
	 qwkK+NpsSHfjhhOSCd4e7gZHZs6FscgDAaGWG2MVRJbua0yyMcGurV+ensrLlWAPhEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrjIJ73g;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCA606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9DCA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrjIJ73g
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0b133f64fso197112a91.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795060682; x=1795665482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Es6jUIuOc8irjGqlIWyhRGN6lehmXeYhL9z691YuNpU=;
        b=MrjIJ73gYk3aRujuoLQBYpbcnUQZGOtxSly9o44v6kJzCMFAd/JHdLEJ2A+YPyBxqO
         4n9mbvUAKiDnLyJ0CiiVaKNDFZ5sPdy9mhQSLLUG3aELV5ooNU34mkp7NfhsYN66ZjWg
         x99kdZ0TpYbgdxdmt9sFfUYQhuN5UFGSHp+sdC1XiXOZ/VWlDyRtRqeI5ylDkJBP0Z0z
         gmSJzOdt5c85F5YQ0aDNUrXbw7Cm6xf3MBRzurryY0vob6oWSyjBWAcqZ8shr0fndM7F
         OrhsInuUsQ+ls1Ok4YHRNkLasj9uK4tkUucPiXrBiY9JwLAkRyoDPH5KqSUpq9ooYZKr
         QQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795060682; x=1795665482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Es6jUIuOc8irjGqlIWyhRGN6lehmXeYhL9z691YuNpU=;
        b=x7HmOpkXXoYAh/qxCD62ApZ/OR8q2JXIkFei6rOzWsBahOzapRFFilau34Jmec3hLB
         wG2dXsaTfCaYXxYOk2ubBQ+2a8eTA6Jcgly1pEgJ3OjR+jfSWL/wr6dMoVfa2sEPsy2e
         Px+PQL4DDilY/5kctIJI5Cj9fzLhPO9bnGLhNVAPk1UBt3CB9pShCtugMLEiliD9hQXO
         CyjAyREWpn6JuNl1fwvEx61p8/FpSvhn1kDJSy4GweSBDdmaCbQKAUSykdtHoFuqOBBL
         LlOP5ltVBzgg15sM9fXoTTLNTSnRMq5rf5vgMx+utzDpSuQUbKfLsJ8l1qRBlep3VHoI
         X6rg==
X-Gm-Message-State: APuU4Z98jXH8063SmXSV10j2XSjDJAe3XFGWsA7tfWGjJG7e3U/e0eyS
	BVHR9uQBJ4P4RtIKZ0hdREUJrSubzB+5+ozbWR+nxGEfY9+216LFljf+m6xR7qZK
X-Gm-Gg: AZFdTZc57TbVKKs07Ol9P0aXMrJwbBkHnXm0Re84SFZTF7DNcwyOW86jpXBdPnvyPvX
	XMeIRSr7H+5pxl0dG7ueCmgwDnpT/+XWwATxgcKoVmTjNZj1tgFj/w7W0qe9uJ9ca16vqf8x7Lq
	fF5/P7oaziMOng/ped2oxjDnnXIRts/AnqxrxMdqhQyWs3P4vJv5mcBdfKzznYQ3UBzRBpFTHfE
	Fgz4bEGatNP1fJ+LOdPbsGi5HGLimJevFHEZ45hHABlEySrAZ+aMUhpLZWVdAP9rrLMbRinIQs8
	L148QXkfvfb6luV++8IE0Zahw7vu93V8430MyMakro+/nnY9W1cmBQg9RN3ZYmX6YYp1dJURbbr
	szR1WJrbVpkBCecgeLt8yIuBXn3oyEs/bhqHGwg83Sp3jjm5rbhQq27THhv8eYYvkmGOBzypEeZ
	RrO0L9xIGFHB/HmlJC1QhGwIDdloNeMAD05fUI/m/Ny0udiU3MSHQ/jgy+DTxOt3wVCjqxEcl+R
	oX4HhQTL0ftuwh0UMABt7IR7KH35NKaNjB6KV3EnAvvTUv8YplE3e4l5+Hq7mhGF4UsXZWDIWet
	Lg/Ctmbmx9KCtB34dpFuWEaePSbkcGo12VZjVdkMPsG9xix3Mw==
X-Received: by 2002:a17:902:e888:b0:2ed:29a5:782d with SMTP id d9443c01a7336-2eff72e15f0mr75485285ad.2.1795060681939;
        Wed, 18 Nov 2026 19:58:01 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff5ed137esm22770055ad.3.2026.11.18.19.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:58:01 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 v2] Bluetooth: hci_core: lookup hci_conn on the ACL RX path
Date: Thu, 19 Nov 2026 03:57:58 +0000
Message-ID: <20261119035758.45-1-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118123533.25-1-junzheyu1@gmail.com>
References: <20261118123533.25-1-junzheyu1@gmail.com>
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

Bluetooth: hci_core: lookup hci_conn on the ACL RX path

Backport of 79a2d4678ba9 ("Bluetooth: hci_core: lookup hci_conn on RX
path on protocol side") for linux-6.6.y, L2CAP only.

6.6 already has l2cap_conn_hold_unless_zero(). Look the handle up under
hci_dev_lock, enter active mode, hold the l2cap_conn, then drop the
lock. hci_acldata_packet() used to drop hci_dev_lock and pass the raw
hci_conn pointer into l2cap_recv_acldata(), whose first access is
hci_dev_lock(hcon->hdev). The hash lookup takes no reference, and
bt_link_release() frees the object with kfree() from hci_cmd_sync_work.

v1 also rewrote SCO and ISO to call hci_conn_get(). That does not match
79a2d4678ba9. hci_conn_get() is get_device() and only delays freeing
hci_conn. On 6.6, sco_conn_del() and iso_conn_del() still kfree the
protocol object. sco_conn_hold_unless_zero() and
iso_conn_hold_unless_zero() arrived in e6720779ae61 and dc26097bdb86
(v6.13), so those paths are left unchanged here.

CVE-2025-68304. Only 6.6.162 was booted, and the KASAN report is in
l2cap_recv_acldata. The ACL hunks in this v2 are the ones from that
build. This v2 itself was not rebuilt: the booted bzImage also contained
the v1 SCO and ISO edits, which are removed here.

This is for linux-6.6.y. bluetooth.git HEAD already has 79a2d4678ba9
(v6.18), so this diff does not apply there.

Cc: stable@vger.kernel.org # 6.6.162
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
Signed-off-by: Yu Junzhe <junzheyu1@gmail.com>
---
v2:
- Drop the SCO and ISO edits. hci_conn_get() does not pin sco_conn or
  iso_conn on 6.6.
- Address this to stable. The BlueZ CI applies mail to bluetooth.git
  HEAD, which already contains the upstream commit.

 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_core.c         | 25 ++++++++-----------------
 net/bluetooth/l2cap_core.c       | 23 ++++++++++++++++++-----
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 62804d98d..e0deaa54b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -837,7 +837,8 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 84d9a445e..a54d29bad 100644
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
@@ -3816,23 +3817,13 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
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
-- 
2.53.0
