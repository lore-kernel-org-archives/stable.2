Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB825013B0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782294; cv=none; b=X0roFj3Q/uagAjyWcMJB/iYISjyCbrUbmWKc535SA8BWN6l5mcQ3REF7VMcgYrkPn9ljxX/dee2YZYt531BruV+GGaN91HvL0tXLm98D8CuPR5OEWwyQHMYSL/09NHh7O/4LxARdzdcSj5U0hpAXmARXpVrjz/qM1n5gshZK574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782294; c=relaxed/simple;
	bh=6akVdNJfvU77UNSjivT3n5dvLJaOPZIbjbrtUXilXmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFd36pL0X7sQ1UQjPrVwmU4sv/HDxT575hEx7iYMeG7Hck39oC9bTnSiLm6ZhXkflf/c1irL2O1HbE8b5Yj79tS9UbD37MmGQzFQDIEjImwPK2fwmzfZYT+ItZogWHFs7I04JSTfx+zfUn/T+c2hdUA6Pb2OTaYebm++X12L8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpLE/q+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpLE/q+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4941F00893;
	Wed, 30 Sep 2026 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782278;
	bh=e+SVidXBTJAf8ioyIyzUa/whS7fm78jQf9x40Mg8tk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QpLE/q+FZUY8Ck0k7oY3929tUSolttCsH/ewF5cjgZRTulKAvy34e8I+eeZgPzNdg
	 ksmd7zwyiXATmK+ZvHIute5aqkPneRE3mNZfWcxrwEtTj4o8X4uYMaNj9TWyn4Vat0
	 fXwTUJNu5hXbi+z+uFTWZfOsiBBiRw9btNW0L6R0aMQZ2LCQnRxzxTfO35EzvhVVIe
	 QGF4hC0esQea9TfUk98ZmjnkWd0Qn6UxMuqBXzaLrflQyAYdbKKCI42MnnKI5QghIz
	 2PK6ToKQ2RnaM96a9D5BjGbr2T+nQ9j8L3+diPnMgOUnrLJHG0alPL7Rp1vMMTppXs
	 XD2NbC9NXI1qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Li <yang.li@amlogic.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] Bluetooth: Fix spelling mistakes
Date: Wed, 30 Sep 2026 11:31:13 -0400
Message-ID: <20260930153116.2781860-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092936-wildlife-vengeful-86d9@gregkh>
References: <2026092936-wildlife-vengeful-86d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.li@amlogic.com>

[ Upstream commit be31d11ec9144f7f8f7fcbf84ba6971b664683f3 ]

Correct the misspelling of “estabilished” in the code.

Signed-off-by: Yang Li <yang.li@amlogic.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 0fcd4dad555c ("Bluetooth: ISO: release unused CIS holds after channel attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_event.c   | 16 ++++++++--------
 net/bluetooth/iso.c         |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4a3c99d1aabc1..46bbbd6dcac36 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2832,7 +2832,7 @@ struct hci_evt_le_create_big_complete {
 } __packed;
 
 #define HCI_EVT_LE_BIG_SYNC_ESTABLISHED 0x1d
-struct hci_evt_le_big_sync_estabilished {
+struct hci_evt_le_big_sync_established {
 	__u8    status;
 	__u8    handle;
 	__u8    latency[3];
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8a7ab3e755af4..97dedd90e074a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6400,8 +6400,8 @@ static int hci_le_pa_term_sync(struct hci_dev *hdev, __le16 handle)
 	return hci_send_cmd(hdev, HCI_OP_LE_PA_TERM_SYNC, sizeof(cp), &cp);
 }
 
-static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
-					    struct sk_buff *skb)
+static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
+					   struct sk_buff *skb)
 {
 	struct hci_ev_le_pa_sync_established *ev = data;
 	int mask = hdev->link_mode;
@@ -6738,8 +6738,8 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
-					struct sk_buff *skb)
+static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
+				       struct sk_buff *skb)
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
@@ -6989,7 +6989,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 					    struct sk_buff *skb)
 {
-	struct hci_evt_le_big_sync_estabilished *ev = data;
+	struct hci_evt_le_big_sync_established *ev = data;
 	struct hci_conn *bis, *conn;
 	int i;
 
@@ -7169,7 +7169,7 @@ static const struct hci_le_ev {
 		     HCI_MAX_EVENT_SIZE),
 	/* [0x0e = HCI_EV_LE_PA_SYNC_ESTABLISHED] */
 	HCI_LE_EV(HCI_EV_LE_PA_SYNC_ESTABLISHED,
-		  hci_le_pa_sync_estabilished_evt,
+		  hci_le_pa_sync_established_evt,
 		  sizeof(struct hci_ev_le_pa_sync_established)),
 	/* [0x0f = HCI_EV_LE_PER_ADV_REPORT] */
 	HCI_LE_EV_VL(HCI_EV_LE_PER_ADV_REPORT,
@@ -7180,7 +7180,7 @@ static const struct hci_le_ev {
 	HCI_LE_EV(HCI_EV_LE_EXT_ADV_SET_TERM, hci_le_ext_adv_term_evt,
 		  sizeof(struct hci_evt_le_ext_adv_set_term)),
 	/* [0x19 = HCI_EVT_LE_CIS_ESTABLISHED] */
-	HCI_LE_EV(HCI_EVT_LE_CIS_ESTABLISHED, hci_le_cis_estabilished_evt,
+	HCI_LE_EV(HCI_EVT_LE_CIS_ESTABLISHED, hci_le_cis_established_evt,
 		  sizeof(struct hci_evt_le_cis_established)),
 	/* [0x1a = HCI_EVT_LE_CIS_REQ] */
 	HCI_LE_EV(HCI_EVT_LE_CIS_REQ, hci_le_cis_req_evt,
@@ -7193,7 +7193,7 @@ static const struct hci_le_ev {
 	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABLISHED] */
 	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
 		     hci_le_big_sync_established_evt,
-		     sizeof(struct hci_evt_le_big_sync_estabilished),
+		     sizeof(struct hci_evt_le_big_sync_established),
 		     HCI_MAX_EVENT_SIZE),
 	/* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
 	HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 6e1fac4b1cf63..52d8dcebb7828 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1930,7 +1930,7 @@ static void iso_sock_ready(struct sock *sk)
 
 static bool iso_match_big(struct sock *sk, void *data)
 {
-	struct hci_evt_le_big_sync_estabilished *ev = data;
+	struct hci_evt_le_big_sync_established *ev = data;
 
 	return ev->handle == iso_pi(sk)->qos.bcast.big;
 }
@@ -1944,7 +1944,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 {
 	struct sock *parent = NULL;
 	struct sock *sk = conn->sk;
-	struct hci_ev_le_big_sync_estabilished *ev = NULL;
+	struct hci_ev_le_big_sync_established *ev = NULL;
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_ev_le_per_adv_report *ev3 = NULL;
 	struct hci_conn *hcon;
@@ -2059,7 +2059,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
 
-		if ((ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) ||
+		if ((ev && ((struct hci_evt_le_big_sync_established *)ev)->status) ||
 		    (ev2 && ev2->status)) {
 			/* Trigger error signal on child socket */
 			sk->sk_err = ECONNREFUSED;
@@ -2118,7 +2118,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 * proceed to establishing a BIG sync:
 	 *
 	 * 1. HCI_EV_LE_PA_SYNC_ESTABLISHED: The socket may specify a specific
-	 * SID to listen to and once sync is estabilished its handle needs to
+	 * SID to listen to and once sync is established its handle needs to
 	 * be stored in iso_pi(sk)->sync_handle so it can be matched once
 	 * receiving the BIG Info.
 	 * 2. HCI_EVT_LE_BIG_INFO_ADV_REPORT: When connect_ind is triggered by a
-- 
2.53.0

