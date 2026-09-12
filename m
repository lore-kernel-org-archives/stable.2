Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353A47ECC8;
	Sat, 12 Sep 2026 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219476; cv=none; b=OWHykf5cq9dcftKQySKQn30GEE+BUVEVb8BBrCyA5DOs5FBzPVRFlWU5paFPq6NBeryhtAzPhJA87covIhClKVJPtPIJL18IOdZ2iBlal8w5qJtT/S9mBpYNMGZFmMsAA5H29J6bdbQSiRChmYJN9LCVflsPEXqfFGKWfoG5sGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219476; c=relaxed/simple;
	bh=cx8ElelaTV7eZyiBsfE1V8uwUvvjA5+KksKIAI5ELz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfuGAn09OFuJ01MEybOPLeiY4Y9TTq1Sc0OW+mVLccXkfYM48Ds6iQkQNcLgDcCnk1I7aj1oDtHWlZmHo7tSJ60Sg3VDCrvhtGQ11+9LvTmIqEBwYKIkQOs6IaqcdWfOomLsCZHTrz6Ty0xR5cFJcY56/ui2TAeINxlkW8MAlow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=mOLGufma; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="mOLGufma"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789219465; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jzV7XDeWKgThRsxfS2R0FUhAhuKHogRQYt9imK9hL9Q=;
	b=mOLGufmaDSZrZoCh7fIN7ahAsfNUbL8hR2At35w6rONAphkUk45wBLSN6mu/tpYsl32TSSusIKpNvQb8I9R/B6GMocx5sI14nHKkhz/o1ICELrUKd1P5JJjlgE5e9t7T2opf2i8i8bHKv0rVHVanjhADrU3yEfX/5kpUXUD+/94=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07535123|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0104515-0.012407-0.977142;FP=17212780250025952569|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jC..l8z_1789219136;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jC..l8z_1789219136 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 12 Sep 2026 21:18:59 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: David Heidelberg <david@ixit.cz>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] nfc: digital: reserve proper headroom for chaining_skb
Date: Sat, 12 Sep 2026 21:18:51 +0800
Message-ID: <20260912131852.1651462-2-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260912131852.1651462-1-liuc63@xiaopeng.com>
References: <20260912131852.1651462-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

digital_recv_dep_data_gather() allocates chaining_skb with
nfc_alloc_recv_skb(), which only reserves 1 byte of headroom.
Once the chained payload is fully gathered, it is passed to
digital_tg_send_dep_res() or digital_in_send_dep_req(), both of
which push a 3-byte DEP header plus up to 2 bytes of SoD, needing
at least 5 bytes of headroom.

skb_push() unconditionally calls skb_under_panic() when headroom is
insufficient, so this is a guaranteed kernel BUG.  A remote NFC peer
can trigger it in target mode by sending MI-flagged DEP_REQ fragments
followed by an ACK with matching PNI, or in initiator mode via the
symmetric chaining ACK path.  Normal DEP frames use digital_skb_alloc()
which gets headroom from ddev->tx_headroom, so the bug only manifests
through the chaining_skb path.

The skb_copy_expand() reallocation in the same function preserves the
original 1-byte headroom and does not add tailroom for the CRC or DID
byte appended by the send path.

Switch to digital_skb_alloc() which reserves the same headroom and
tailroom that every other send buffer in this file uses, and pass
ddev->tx_headroom and ddev->tx_tailroom to skb_copy_expand().

Fixes: c12715ab3f01 ("NFC: digital: Add NFC-DEP Receive Chaining Support")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 net/nfc/digital_dep.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 3982fa084..6d8e662a3 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -240,8 +240,8 @@ digital_recv_dep_data_gather(struct nfc_digital_dev *ddev, u8 pfb,
 
 	if (DIGITAL_NFC_DEP_MI_BIT_SET(pfb) && (!ddev->chaining_skb)) {
 		ddev->chaining_skb =
-			nfc_alloc_recv_skb(8 * ddev->local_payload_max,
-					   GFP_KERNEL);
+			digital_skb_alloc(ddev,
+					  8 * ddev->local_payload_max);
 		if (!ddev->chaining_skb) {
 			rc = -ENOMEM;
 			goto error;
@@ -251,9 +251,9 @@ digital_recv_dep_data_gather(struct nfc_digital_dev *ddev, u8 pfb,
 	if (ddev->chaining_skb) {
 		if (resp->len > skb_tailroom(ddev->chaining_skb)) {
 			new_skb = skb_copy_expand(ddev->chaining_skb,
-						  skb_headroom(
-							  ddev->chaining_skb),
-						  8 * ddev->local_payload_max,
+						  ddev->tx_headroom,
+						  8 * ddev->local_payload_max +
+							  ddev->tx_tailroom,
 						  GFP_KERNEL);
 			if (!new_skb) {
 				rc = -ENOMEM;
-- 
2.50.1

