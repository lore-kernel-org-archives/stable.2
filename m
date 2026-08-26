Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DF3A7F66
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770127; cv=none; b=AfVajYkHg6XmF92oiLlzjowOwkRg60weS3sV9bHRPsAHUk/Yo7dNBsJvY6IEOdpi/mhym14vYKwLIweP5uVViocMzJlKYQVZbwFpwgn9ht3Es/2M8fnSvHp7mG0NBzR01yCdUZQCv2SryYogtUecAttL+/vBitF9sjMLM2FQDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770127; c=relaxed/simple;
	bh=IIXSnDUzVt32Xh6M9IBOKnGfYTit/bSxeMvdD+P2pXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hv2i5QjSL0wyr+MrLONllydPe327wUJ0MlYsEPOxLir/vbifRcEPx9uVveDymcFg84/marSorqR1BZMmn56Qmt51E85RBSDrvhsvWQFTcQlOvylU7jeRPR1eX7lgCgLUhuUm/jIUJ8DZkoCa8TqDeR4hCElwHF4oPRZQIALb8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEd/GFio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEd/GFio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7F31F00A3E;
	Wed, 26 Aug 2026 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787770118;
	bh=zeWFNXoiZFQoK3+mKlJZuH14oUE2/OISI2FONCImVdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lEd/GFio3z990146V7xAbI3u8y7pAooFY9t/TMVj0kLITaQ3QVFhKJcIn2f3nh9N/
	 JFD2UXyrL75LhCVBvKFZlu6lKJFImq83c86WHSqww32ZqS1sFme+utEffnKxnzvAX/
	 MwaM6EJ9C34fFxJKgNHtdycjc2Fci3TPN9+wlKT+r0QOSwjkMJrpoyNC+VlCZ4GpiM
	 /Ku9nSND3bf9dXf0iV/cnd/PXJgyStwZj25IQ+5fyXsFvKmc6+scf4FoUuf1UsHAVZ
	 FBe9GUFCWuc7C0ghnNvFjRPks0akfP/1ywJI5BjcCqk9JDs32YGyXyoY+zVrDuMgGE
	 g45tw8jyXMkaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] Bluetooth: hci_event: fix Set CIG Parameters error status handling
Date: Wed, 26 Aug 2026 14:48:32 -0400
Message-ID: <20260826184834.3559828-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826184834.3559828-1-sashal@kernel.org>
References: <2026082559-suspect-staff-6aaa@gregkh>
 <20260826184834.3559828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit db9cbcadc16e8b9f0b3ef5870f3a38ebafcbe8e0 ]

If the event has error status, return right error code and don't show
incorrect "response malformed" messages.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0acd4eeb4b22 ("Bluetooth: hci_event: validate LE Set CIG Parameters response")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9ddfcf8446e67..41cfd0201d3c2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3791,7 +3791,8 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
-	if (!cp || rp->num_handles != cp->num_cis || rp->cig_id != cp->cig_id) {
+	if (!rp->status && (!cp || rp->num_handles != cp->num_cis ||
+			    rp->cig_id != cp->cig_id)) {
 		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
 		status = HCI_ERROR_UNSPECIFIED;
 	}
-- 
2.53.0

