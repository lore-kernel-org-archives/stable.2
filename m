Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679768;
	b=As+e0+pR36BX8Wyd0Z0LW8wU3tzf0MqEQOvP0LqV9h+DUvAxeEYh6aYwsDg9kP4vuLCu
	 I4+hY73s2/iXRdBonG3RO2rtxe19a+6ZSlGTBFiq0W8prJynAaep58YIL5GXdK2ahbYbN
	 EZBphrzR6p9BewcxanMuGFNhQttmNgpBPH13ilPH3Y0fZpLb6UlGRD1N9h57kTtLoKc83
	 gK2hxolJUb3N+5wE2jHSMEjhOvJyGH/bYSyt908nOLkvqb4HNEP7vrvebOvdaND67yT1z
	 5Q1fhwZhtn76yj0kEE43NHXC94isTMiG768yeb73ruuJZ0lCbXlC9oIHDZmPFaRCRvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N3Tx02Jp98cRkBGwMPHz68HqVRd2amYTzVID8QsJKng=;
	b=1VWZA2KU2cxG8Q8+Z7hor4yIfhzXn7npv0s6/znAzqhL4cDQW4FclEX3C29VhBek8T1D
	 +6RcrteW2dZGGolQdK0tZyBJSJBuYbMefPh2yb1imnyMOMgE02mU4KsZX4F/ugqkA5lCJ
	 zzebxu6gCyZKy243ndcbNEIZHJR7jhuRWr8UdWm87jTpx067jVNrxzbIO9LKGPbetyoXB
	 dt7dMtGhbvKvhUectHnZyvCfn1WekxuVk0dgQ362UjXKV9MqZi2EAceP+rvha3nbk2abn
	 TdOJLNZK/A3pJoU/0vlXKEc51UzZ9Vt1Ip6hGp7e7n+MfbBQCKFYiIVeWETWtMfLgfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSWCa4xb;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756E606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4756E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSWCa4xb
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdeaea71717so96562a12.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795679767; x=1796284567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3Tx02Jp98cRkBGwMPHz68HqVRd2amYTzVID8QsJKng=;
        b=LSWCa4xbEMFn/1XVUrL8aEGm6aPJ629ADCtFC6HBcfD9UboeWGV/xxFuW8i7ocUMSZ
         3vPMOOgdgZOARtD1Ouo+4ey4ylnH/TONCTG6ZZdJE3AIeGgQxvfabedsxonFpExlAx4n
         7NXfkRA86CXlMcEh2uUvmeJUfTrrNZ11oCiUhhCZpAsjnLsPMMrvdIk0R8aeBCTHCF/y
         1epXY2cb4J9/W3vX+BgopX6Z7BcIM5gkztXdkosHlyJhMKtb78T21Jb9B1HUH8eipG5d
         aqApnn6R8rvCYWj17lK8/RPTlwElruXknIjnqmuaSvOsmx+MNdMhv3L8bgZ2qMpyrktX
         witQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795679767; x=1796284567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N3Tx02Jp98cRkBGwMPHz68HqVRd2amYTzVID8QsJKng=;
        b=Vedfy57L6e0iXA0gXZe678CeXGpasv6gAAl5Aay6NnJio1mpcepAE70uPWA7muYtaP
         zTm5GyFlySgcLOOQwOXZefEveN+Taq2O1VNCms3c44INlfK+CC9/pD2vEePNkpKNo3af
         przhVbzKNaD88AjERje4hFtoopuVPVv4WZWyIBzZKxfaxKsTi7aNrKHms/BhqbYVxX5l
         cRryDl8TGrSgC3EZykfIVNZvsjVNE8lhRUJScgAXKdD2uqdXCuz6itlyJKbZRYcfLRrC
         6Tk5x0JB2Mfz+ckyQgXjtYOOC2Z8ggPm7DVGdgQGNTl98dWpVosBEfQeSmqfw8z7gfOY
         KZyw==
X-Gm-Message-State: APuU4Z/g0Prv8+UaCp+ESDszupvpxpzeYtec5XTgKlM0Sr/wR9QvPISf
	RuuomT6JaoQwJG3VUQ4xjQSjGuDFBhHbGP8R/v4X4yC6NjuGeFpTHnoTQH7qwjaW
X-Gm-Gg: AZFdTZcakCqij9hD806Y1kpDCeeOu1F3g/F+IJ8/wfxacpEMYdd6ldAwe9eX0pRw458
	d5V29a6mKZcdr7QlLiv7OLgmjT5088tJuSUUF+DYtE5PATdJWFkJMLFEj1DH2rayC8z/j1fNprQ
	6o+H/PmkSGPxS6tzkb5qnuHOwlwsS4sszbhnuUOPhQivOQT+KBdD1tGj4e+4g6wURuBdk6WPUdq
	YkBMKQMH2hqzTxj7GDcEsz0Z3Pxi0MbEo62Wi6QMOhQBqVhzrbVNTBT45ZTX+kIuQOYoNVeBme7
	s8k9vfWzzkdeGA44REC34aI32N4EZhpZJUMTs79QaerH+vWwZuw1Q2nqskolzEcgs5xsTRczqaC
	aDcdk5wrchkAFzR6wmW1krXPGDVaMo0Dj7cl3K26ZBAJ6YxAAe6XoBfjqiOhZxVvxcgllKOP0OV
	8XGYxrNjYoWHM4QG34xoHBJecCRyyA+1lI9D62JeVDaohUYjpguwpm8d9ab9RNlgCghMktuvR7A
	iIUb+Thl2yI1F1pX6rWyPNypK5bpjkxF57GhQPa6mzAjhQHyE2HPulFNHlYj29/RPMl1JzH/d6/
	sZ2M843hb236HKrLoWPlxi8pz6sVikpCANO5ASfKxch2tUl0LA==
X-Received: by 2002:a05:6a20:9f08:b0:3ef:2f72:c7e5 with SMTP id adf61e73a8af0-4014ae6fe31mr34992104637.2.1795679767425;
        Wed, 25 Nov 2026 23:56:07 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm10690855a12.23.2026.11.25.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:56:07 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] Bluetooth: hci_core: lookup hci_conn on the ACL RX path
Date: Thu, 26 Nov 2026 07:55:54 +0000
Message-ID: <20261126075554.106-4-junzheyu1@gmail.com>
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

Move the hci_conn lookup into l2cap_recv_acldata() and hold the
l2cap_conn before dropping hci_dev_lock. 6.1.y has
l2cap_conn_hold_unless_zero(). sco_conn and iso_conn have no kref, so
those paths are unchanged.

Cc: stable@vger.kernel.org # 6.1
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
Signed-off-by: Yu Junzhe <junzheyu1@gmail.com>

---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_core.c         | 25 ++++++++-----------------
 net/bluetooth/l2cap_core.c       | 29 ++++++++++++++++++++++-------
 3 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f47a88d39..1a483be00 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -824,7 +824,8 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7ec3af3a4..580921ff4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3802,13 +3802,14 @@ static void hci_tx_work(struct work_struct *work)
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
@@ -3820,23 +3821,13 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
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
index d7bb11931..a8a3afabe 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7908,13 +7908,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
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
 
@@ -7922,11 +7933,14 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		conn = l2cap_conn_add(hcon);
 
 	conn = l2cap_conn_hold_unless_zero(conn);
+	hcon = NULL;
 
-	hci_dev_unlock(hcon->hdev);
+	hci_dev_unlock(hdev);
 
-	if (!conn)
-		goto drop;
+	if (!conn) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
 
@@ -7954,7 +7968,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (len == skb->len) {
 			/* Complete frame received */
 			l2cap_recv_frame(conn, skb);
-			return;
+			return 0;
 		}
 
 		BT_DBG("Start: total len %d, frag len %u", len, skb->len);
@@ -8020,6 +8034,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {

-- 
2.53.0
