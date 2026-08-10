Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A672BE656
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368877; cv=none; b=Yk2N9cXQx9s5aqKhlqnVzynQ8OX6Z520nHBMrsgqofmGEyPv1Ep0+FLXAXy/r/rnGJ1ilycBZT259bEmAtXuULfsTantSl2+qR1tbFY5O1z00Q1QdFqBm5vFlFQxeCM76flAcIaavuOyUIYI3ZY2v+Zvr1xNlUoaBl8cHHgyNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368877; c=relaxed/simple;
	bh=kZ3IJ7C1etC2oWIqfP3jJRx7kab26f0r7hZMrS1ozKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0ZCvdYLAcF3GK2huhijGxfkFNG/RHM9LpAR7b+WLsVsPM8mZLoFEATFe3qptUXV151aa+T5KKX299TWyE7c9fnv/TXIjP1QtUycWqkOVIQwGgLvbWhzDg6oVWGtw1cOsl7MiWqFOshyWRHxk5n0uZSn9J4uhbBDRM4nLEcMHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHDkNZEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHDkNZEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECC81F00A3E;
	Mon, 10 Aug 2026 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368876;
	bh=crShtVWwfLtnAfn50c3XQJInpEB6POo97dIjIWhh/2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nHDkNZEuYjiRAAjAE5eiM1cP8FfoW8EisfMQRli0PBZMrYEom9FsBhrsirb+uJsBu
	 UK9vapWiSHcZEGHircJai1ohck8+JXBaU/ngavBWGSUuQNVucTi9IxVGa/JWNgI+30
	 t/kMcSIBmzVrJawSqhhTBk5lyQJEYaNx5HsD32YtrpL6x2UUjO+bBOeib9xeZK2RMD
	 Ka35kbpxjX21nKWU54L5ssZuixxKe0SOG5RPGjDahPwxFZ2WvX7wt6WovKmiJ0myqI
	 i7MLJlN7mJbHVJFefIgdV9kpECU7XwqggafISdpcezBkf5+1Kb+9HC4wa6Z6rnALTO
	 zA8Pa5zawYgIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sangho Lee <kudo3228@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] Bluetooth: HIDP: reject frames without a transaction header
Date: Mon, 10 Aug 2026 09:34:32 -0400
Message-ID: <20260810133432.1246348-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810133432.1246348-1-sashal@kernel.org>
References: <2026080515-broadness-backlash-dde1@gregkh>
 <20260810133432.1246348-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sangho Lee <kudo3228@gmail.com>

[ Upstream commit 47778d2c2087b5d192398f6fddf692d16a5431cf ]

hidp_recv_ctrl_frame() and hidp_recv_intr_frame() read skb->data[0]
before checking that the L2CAP SDU contains a transaction header. A
connected HIDP peer can send an empty basic-mode SDU and make both paths
use an uninitialized byte from skb tailroom.

KMSAN reports the use in hidp_session_run(), with the uninitialized value
originating in __alloc_skb() through vhci_write(). The control path
produces two reports and the interrupt path produces one.

The byte can also be controlled by a malformed lower-layer packet. If an
HCI ACL packet contains an L2CAP PDU with a declared zero-length payload
followed by an extra 0x15 byte, l2cap_recv_acldata() reduces skb->len to
the declared PDU length before dispatch. The current HIDP path nevertheless
consumes the extra byte as HIDP_TRANS_HID_CONTROL |
HIDP_CTRL_VIRTUAL_CABLE_UNPLUG and terminates the HIDP session. With this
change, the same packet is discarded and a subsequent feature report
request succeeds.

Pull the transaction header with skb_pull_data() and discard frames that
do not contain it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hidp/core.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 068c3c2505170..8e9e07684ff78 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -550,16 +550,18 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 static void hidp_recv_ctrl_frame(struct hidp_session *session,
 					struct sk_buff *skb)
 {
-	unsigned char hdr, type, param;
+	unsigned char type, param;
+	u8 *hdr;
 	int free_skb = 1;
 
 	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto free;
 
-	type = hdr & HIDP_HEADER_TRANS_MASK;
-	param = hdr & HIDP_HEADER_PARAM_MASK;
+	type = *hdr & HIDP_HEADER_TRANS_MASK;
+	param = *hdr & HIDP_HEADER_PARAM_MASK;
 
 	switch (type) {
 	case HIDP_TRANS_HANDSHAKE:
@@ -580,6 +582,7 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 		break;
 	}
 
+free:
 	if (free_skb)
 		kfree_skb(skb);
 }
@@ -587,14 +590,15 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 static void hidp_recv_intr_frame(struct hidp_session *session,
 				struct sk_buff *skb)
 {
-	unsigned char hdr;
+	u8 *hdr;
 
 	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto free;
 
-	if (hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
+	if (*hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		hidp_set_timer(session);
 
 		if (session->input)
@@ -606,9 +610,10 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 			BT_DBG("report len %d", skb->len);
 		}
 	} else {
-		BT_DBG("Unsupported protocol header 0x%02x", hdr);
+		BT_DBG("Unsupported protocol header 0x%02x", *hdr);
 	}
 
+free:
 	kfree_skb(skb);
 }
 
-- 
2.53.0

