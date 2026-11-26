Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679763;
	b=GIKEJ/9ZfDeCisGfqcISh7lfUAceeDr/iO9M2jmHM5K/K7i20zcAretSMztHTUN7o6mI
	 VWpESB+YpC/RZnX0ZGT7O6hXS5qQokH4KbepDLGLS5/wg0gYEbwzk3DL6hSCwKPchRlty
	 L1ZV/+SGK5KJU1lGhuUE9YJkGd5DykXs5byFSdYzepzHpOvtN109O25tfv0gskBpxaY6b
	 exgSfv5MNwfPpMs4nXMmafbqpDzdRNmNM/QOD2s3hjXasfEnNp5imCNVbW2/5Z7k2xAP1
	 DbgUXOEjjrgYmo/z1D4wRVWcoq42JlwLuYW6/8uZIJ2v8cjyaB3C3XXPPtccGDxt0pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uGv/LgKfEeFUP7Ppdmh49v4/8KqCylcah3LCXsjqiUA=;
	b=eDlFv/rPQM9n6bNuDPunMjwFj7odq95c37R8RkHs+HlpMWyw42a0CD3NPgG8j0p7KAcI
	 eeTf+i8XVf+XSRsH1e+/QwHrXqFXspP6zQXA9hYB+EwjjyZM4kDvJskbugkBNfmVVcvjK
	 gvyWvplWTDKUXjySEfOJEQj+UYmqRJhQeh+0qzZmT21LIYiaZygjlnH/S/YUlGQ2kqCm0
	 bGmHUc4t+GQJ/bCC0tZESdHdEKZGgZv3LjIYUH2KjGWBYZswp+tOg3HTKuSQ6ia6GhOsm
	 k0tvXLD9E3CLorMSg8REkic8pOnrIMpbgHyo3AM4aAqEXwdbIrdAuxan/wiU4A4ueEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HyW1+rfq;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2A606A329
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D2A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HyW1+rfq
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b4166b78b7so743140a91.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795679762; x=1796284562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGv/LgKfEeFUP7Ppdmh49v4/8KqCylcah3LCXsjqiUA=;
        b=HyW1+rfqIwU8jzKGo31B7a4awqN8AFNKCf0oYBO/WIgrTMzOTQxNLF/BQZXkD8ImQ4
         rW+dAUmEUXw0DDKmReOfJZ/8N7E95/M8Yt2mdmcQyWbFelz94ZS80GjjcXgqRENWB5QB
         8B76wRBIGGvhNFONfZMPDALxhrYi7OwCbEx5qul+nfaKjS/PistZ1frcH4EZO47FGs8q
         MOHRzIQ/PO8TdMdYCTCKtGiUKKHFGFr1oOeu4BgQLNdqznhZTDeMrNw0SNrcTMnZkX5e
         dH1OrJjJ8OQxdpmqj0avOwLEEaMo9IuSEP0pU1Z2sSjnkyP7TvtAsU5t4jJLa/HzRSlC
         fxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795679762; x=1796284562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uGv/LgKfEeFUP7Ppdmh49v4/8KqCylcah3LCXsjqiUA=;
        b=P4Td9nlfiig7y9GAbX3OQcw0tJ/j8hmA/3kXX5lFuvo54BofjVfSeAfUc/uKvzvZPe
         wTLzSUNJy+h/4Bp5ppqmvO48lTKkSISNU4RvRujK35CbmKfDMTCyDoulVCzJRGS8b1kM
         qbMcu/BbFDTiwas2WYMf9FB2SVIb1lgg5OGIlNk2BuJY4RyO3lTEnb+JX+YGyYTM+B8O
         RVRjjiI+LbD8ABiiL5+hHZsBe9jWn1NCq/CxJP+jyAxBSqFFSzzDFVjmQewMKnxG1GuD
         4ArV5Te9hnxJpY0NG98Lur4lm9XeyjHx1jsq2KT0jP0Lic1eQfLFNRm4O3UvZFddAuqG
         9p1g==
X-Gm-Message-State: APuU4Z+8m0wmA6oPP08RUh+s7bi5+LD4fcQh02fwgxyNnz4AeoVKaLOV
	Pgx1G/5ilDB92wRlE6W6CSiyYwk58T3U4oky6lQHIjxcBOxFiyZHBLovW3ATSKtG
X-Gm-Gg: AZFdTZfwiQnKQVvUJL/DBGwdx6s9EkzVjVS810oNmuAhY6IDtev+pnb4bpN2JjtVqXi
	+fjRC2EqNIOG+k5jqAHQMudtfpuht48rc21g1LQ+rtDjdKme73RSjGcDyMFMM7gc6pGSxdd4Qcg
	uBr0S7O98xhbouOUpUjKaBsS4Tv3UiH3jdaKEF3s7hyet/ShvQwgdSC5eOBiGelAf48L6Qre2sG
	SR3TqFt1SJfjUIa8KVIs2bA4KstvRNgIAUAGs02hx53gn3n+wOuHocY26BTu57OWUZfcyWRUyvU
	R+KNz6eeyke9fBifybJQ83inRocqWry/Xrlk/7D/lNkEb2KaVFrBzagXxuCD4UWGkXDonv77Lg/
	vXCcPAJvHzh5e3CuixFtZ/ZXn7S6Gk6ywiT38l64KwHrTF7zmgyGyTC83sHrdzPl5b5Y89nlzNS
	qNIAaz1bWhMHtsbtrAgrsNWxiLvglRcBNmXbL0XX5zwY9VUwnsje7i6qyhzTFeNPHa5qBGtia0K
	ntHrhJBkc+gOOWZic+SXqElUMsmaU8TOeWziG67MPUZaY4V8AGUFskbbp3mwr1SxjUBRnnRecDw
	BiyNnrx1JaDCrdE47yKIPPEatwMPL3CoiZIKcKkpzZtgwaKh0pI=
X-Received: by 2002:a17:90b:2e48:b0:3a8:9db2:a59 with SMTP id 98e67ed59e1d1-3b41c556e6fmr32172575a91.0.1795679762112;
        Wed, 25 Nov 2026 23:56:02 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm10690855a12.23.2026.11.25.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:56:01 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] Bluetooth: hci_core: lookup hci_conn on the ACL and ISO RX paths
Date: Thu, 26 Nov 2026 07:55:52 +0000
Message-ID: <20261126075554.106-2-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126075554.106-1-junzheyu1@gmail.com>
References: <20261118123533.25-1-junzheyu1@gmail.com> <20261119035758.45-1-junzheyu1@gmail.com> <2026-11-19-1-daily-reply-0012@kernel.org>
 <20261126075554.106-1-junzheyu1@gmail.com>
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

commit 79a2d4678ba90bdba577dc3af88cc900d6dcd5ee upstream.

Move the hci_conn lookup into l2cap_recv_acldata() and iso_recv() and
hold the protocol object before dropping hci_dev_lock. 6.12.y already
has l2cap_conn_hold_unless_zero() and iso_conn_hold_unless_zero().
sco_conn has no kref on this tree, so the SCO path is unchanged.

Cc: stable@vger.kernel.org # 6.12
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
Signed-off-by: Yu Junzhe <junzheyu1@gmail.com>

---
 include/net/bluetooth/hci_core.h | 11 +++++----
 net/bluetooth/hci_core.c         | 49 +++++++++++++---------------------------
 net/bluetooth/iso.c              | 30 ++++++++++++++++++++----
 net/bluetooth/l2cap_core.c       | 23 +++++++++++++++----
 4 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f846865db..22ac4870a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -843,7 +843,8 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
@@ -862,16 +863,18 @@ static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 
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
+static inline int iso_recv(struct hci_dev *hdev, u16 handle,
+			   struct sk_buff *skb, u16 flags)
 {
+	kfree_skb(skb);
+	return -ENOENT;
 }
 #endif
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3a713084f..fe2900960 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3865,13 +3865,14 @@ static void hci_tx_work(struct work_struct *work)
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
@@ -3883,23 +3884,13 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3940,13 +3931,14 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3956,22 +3948,13 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
index 2733cc8b8..4e3584266 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2424,13 +2424,30 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
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
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	conn = iso_conn_hold_unless_zero(hcon->iso_data);
+	hcon = NULL;
+
+	hci_dev_unlock(hdev);
+
+	if (!conn) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	pb     = hci_iso_flags_pb(flags);
 	ts     = hci_iso_flags_ts(flags);
@@ -2480,7 +2497,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			/* Complete frame received */
 			hci_skb_pkt_status(skb) = flags & 0x03;
 			iso_recv_frame(conn, skb);
-			return;
+			goto done;
 		}
 
 		if (pb == ISO_SINGLE) {
@@ -2556,6 +2573,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+done:
+	iso_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb iso_cb = {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bab8caf18..e7915e847 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7895,13 +7895,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
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
 
@@ -7909,12 +7920,13 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
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
@@ -8028,6 +8040,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 unlock:
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {

-- 
2.53.0
