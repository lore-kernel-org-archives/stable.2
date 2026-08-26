Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372F3B14A4
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770132; cv=none; b=HdxPYKhHHR2Y94HDECjtAAYj+4h5SCEUZXSU6N8B0j8ev3VnbbU78UuwAuQY8Os5bbwKQ/WmerOpVU9iCxfCQL290p37yfkROP879eIIndnorItgiVCfbC55dlT0dYZ9QebBT3WGWS/RQSG6iPOMlCbOXtU/Xn+LEjYywr8QrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770132; c=relaxed/simple;
	bh=4RoHH6J5/tSXKdVoC7aA6J4594pLyov1Z75F1vobpHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKsGJn34IYUgDKglSAU5nhJvvzt9mqOFyAC89sP+BAaRICoLWXBuyD/s3oQ4hiJlEH2K5bgohTm9KgWYtZPiVbl+eafCrjDQGHgR22+YIHuYkd3787t44h3MQtspqTggEoRpLjZVCKmiBT+ZpwIOV6jNoQ9Xuw1JQOrQkYIndlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKjzSsRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKjzSsRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B781F000E9;
	Wed, 26 Aug 2026 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787770117;
	bh=y9x9iBvfUT7JH0AxgGpgCtvmuC3yH42UNi4wUDEhi+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OKjzSsRersKEkKoVP+zCoacge6VM0Ujanc4+a8bH0m+5EnJL2WRaIV6ODbngPY2w4
	 mLlvx/D9Vwn2U406zh+8dEhEFQ+GFu7dtRCtNhjOk7hZY4pQqZ8c6HhJRxim3yq0NF
	 +GiAEZM+LT0O7P41v0Dw6nnvuZbU/aNuUC7zfLaWPMJtqXyZFMviIoTnoSnWPa7Enu
	 r48mugavKrBx8cw35hWRGQzY04aErWnHbgqfSrklM0avo+3PlSIj3ejHQF9W5plscC
	 hm5JJ33HiksM9tkqZhlFh64zeJj5F2lcrlYmUtqPiJXtgvtCyw+DT+A5V0hz/X6HBi
	 xMi7hWbBKx/kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] Bluetooth: hci_conn: Fix not matching by CIS ID
Date: Wed, 26 Aug 2026 14:48:30 -0400
Message-ID: <20260826184834.3559828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082559-suspect-staff-6aaa@gregkh>
References: <2026082559-suspect-staff-6aaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit c14516faede33c2c31da45cf950d55dbff42962e ]

This fixes only matching CIS by address which prevents creating new hcon
if upper layer is requesting a specific CIS ID.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 0acd4eeb4b22 ("Bluetooth: hci_event: validate LE Set CIG Parameters response")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h | 12 +++++++++++-
 net/bluetooth/hci_conn.c         |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1023f78132457..4f47f9ff25b30 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1178,7 +1178,9 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 
 static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 							bdaddr_t *ba,
-							__u8 ba_type)
+							__u8 ba_type,
+							__u8 cig,
+							__u8 id)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1189,6 +1191,14 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 		if (c->type != ISO_LINK)
 			continue;
 
+		/* Match CIG ID if set */
+		if (cig != BT_ISO_QOS_CIG_UNSET && cig != c->iso_qos.ucast.cig)
+			continue;
+
+		/* Match CIS ID if set */
+		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.ucast.cis)
+			continue;
+
 		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
 			rcu_read_unlock();
 			return c;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1da112825b18a..d7cc13644b367 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1862,7 +1862,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *cis;
 
-	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type);
+	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.cig,
+				       qos->ucast.cis);
 	if (!cis) {
 		cis = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
 		if (!cis)
-- 
2.53.0

