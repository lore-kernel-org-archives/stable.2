Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A0547055;
	Sat, 19 Sep 2026 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796988; cv=none; b=VgvA+QFh1pkWHgN8P1fkzU2gXKVHLZak8yjO3jsDyPUJGdeUB6P2GZn5vHRIKY4FQfqVH3PZd47Pz4cDaudZ86H34dVVvrD5hl1PKwNY9gFVlVVrsk6NojCwSbR+NXiwu6ZXhiEbDuZf1QrgzxCNrG1b2HbxW/PJPyDJo4WGDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796988; c=relaxed/simple;
	bh=bMmgKzBF78SHTxUQv1F4w1xY0Pp6sO+Czmhr1P38ZfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vtc9lZQn2GPoUhyPlmeAF1gYHhZgmhf8scSn/fMuwgHCwu7mOjGf5lhKLdeebWpNZFfvsf+HVkGo/RKu4+zoZuWjI86M0wymZBRgDlnqU55O4AcqlwlkeHDL7dHSD4euzMsK0/8SnyMI0OnQY4n/EWLt6lrN+UsQKrKKdViWP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=nqdH4hND; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="nqdH4hND"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789796973; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MbpWXWbyUiGYCNruzUaTkx1Gle7IUutRJNOmCgXfr6k=;
	b=nqdH4hNDo71QvhztPoOSu3wXiIgW3ssfe9WjtpfGDOpSfBEy6CWHVvj1RBZDcd0uFw279j4laLQ6DZgJZHVao2MobFxSGhy7NpT1Kqge9JHDowuVdvmUxGibq2S9hnnobcA6/p1qZ7oURY+SrNpMOTKBi30ZEugQOIaq/ckPQgQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07466451|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0082232-0.00508614-0.986691;FP=18370472093206318729|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jHKXW7N_1789796971;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jHKXW7N_1789796971 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 19 Sep 2026 13:49:32 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: netdev@vger.kernel.org
Cc: linux-nfc@lists.debian.org,
	sameo@linux.intel.com,
	krzysztof.kozlowski@linaro.org,
	simon.horman@coderberg.com,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: nci: reject unusable max payload limits
Date: Sat, 19 Sep 2026 13:49:31 +0800
Message-ID: <20260919054931.2157758-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_core_conn_create_rsp_packet() copies the controller-supplied
max_ctrl_pkt_payload_len into the new connection without any
validation, and nci_hci_send_data() sizes its fragments from it.
When the controller reports 0 or 1, the subtraction in the loop
underflows (skb->len is unsigned), the "last packet" branch is
always taken, and skb_put_data() runs past skb->end into
skb_over_panic(). A limit of 2 still works: the first packet
carries the two HCP header bytes, and every chained packet one
payload byte.

Reject a zero limit at parse time, before the conn_info is
allocated and published, so there is nothing to unwind. A
zero-payload connection cannot carry any data anyway, and both
in-tree creators start sending right after the connection comes
up: st-nci sets up its HCI session, fdp downloads firmware
through the generic data path.

A limit of 1 stays legal at the NCI layer, since
nci_queue_tx_data_frags() can ship one-byte fragments over such
a connection. Only HCI needs two bytes for the HCP header, so
that check lives in nci_hci_send_data(), which snapshots the
limit the same way nci_queue_tx_data_frags() does and returns
-EPROTO below 2.

Fixes: 4aeee6871e8c ("NFC: nci: Add dynamic logical connections support")
Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
Link: https://lore.kernel.org/netdev/20260918185458.2711284-1-liuc63@xiaopeng.com
---
 net/nfc/nci/hci.c | 22 +++++++++++++++++-----
 net/nfc/nci/rsp.c |  9 +++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index c03e8a0bd..d68fe55b6 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -144,6 +144,7 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 			     size_t data_len)
 {
 	const struct nci_conn_info *conn_info;
+	u8 max_pkt_payload_len;
 	struct sk_buff *skb;
 	int len, i, r;
 	u8 cb = pipe;
@@ -152,8 +153,20 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 	if (!conn_info)
 		return -EPROTO;
 
+	/* Snapshot the limit like nci_queue_tx_data_frags() does; the
+	 * conn_info is published before this field is written.
+	 */
+	max_pkt_payload_len = READ_ONCE(conn_info->max_pkt_payload_len);
+
+	/* Below 2 the unsigned fragment arithmetic wraps and the first
+	 * skb_put_data() runs past skb->end; 2 is the smallest working
+	 * limit.
+	 */
+	if (max_pkt_payload_len < 2)
+		return -EPROTO;
+
 	i = 0;
-	skb = nci_skb_alloc(ndev, conn_info->max_pkt_payload_len +
+	skb = nci_skb_alloc(ndev, max_pkt_payload_len +
 			    NCI_DATA_HDR_SIZE, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
@@ -163,12 +176,11 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 
 	do {
 		/* If last packet add NCI_HFP_NO_CHAINING */
-		if (i + conn_info->max_pkt_payload_len -
-		    (skb->len + 1) >= data_len) {
+		if (i + max_pkt_payload_len - (skb->len + 1) >= data_len) {
 			cb |= NCI_HFP_NO_CHAINING;
 			len = data_len - i;
 		} else {
-			len = conn_info->max_pkt_payload_len - skb->len - 1;
+			len = max_pkt_payload_len - skb->len - 1;
 		}
 
 		*(u8 *)skb_push(skb, 1) = cb;
@@ -184,7 +196,7 @@ static int nci_hci_send_data(struct nci_dev *ndev, u8 pipe,
 
 		if (i < data_len) {
 			skb = nci_skb_alloc(ndev,
-					    conn_info->max_pkt_payload_len +
+					    max_pkt_payload_len +
 					    NCI_DATA_HDR_SIZE, GFP_ATOMIC);
 			if (!skb)
 				return -ENOMEM;
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5ac..70aafe0da 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -314,6 +314,15 @@ static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 	if (status == NCI_STATUS_OK) {
 		rsp = (struct nci_core_conn_create_rsp *)skb->data;
 
+		/* A zero payload limit cannot carry any data; reject before
+		 * the conn_info is published. A limit of 1 still works for
+		 * one-byte generic data fragments.
+		 */
+		if (!rsp->max_ctrl_pkt_payload_len) {
+			status = NCI_STATUS_REJECTED;
+			goto exit;
+		}
+
 		conn_info = devm_kzalloc(&ndev->nfc_dev->dev,
 					 sizeof(*conn_info), GFP_KERNEL);
 		if (!conn_info) {
-- 
2.50.1

