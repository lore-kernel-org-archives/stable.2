Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE293E121A;
	Sun, 27 Sep 2026 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510394; cv=none; b=QljxlL+zyhTySm7CBrpo+II1WBK1SgpDNUEhPkwitYXQkzU1eH8gSq3JiVGUSs/8Km8laC4TbrJJsp3ZLaY0/ZxIS6zp7efVyRVE/+fsZu8lSjTFlR4dERNdtH07Yldl/Q6u0iFnRFkEsiY3ZoHSWP2bJtbDtHAtXeiWv89L8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510394; c=relaxed/simple;
	bh=fTkVwd2Y7QM/AiOJV9TQhYvcq5o2fo81OnE8HK9d50A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3+CRmqrzWmt+RYhRWdd/fk155J3+0Df/SGvlEXxwRNVEBkBvkc5agSguMYaevkr91D86Kbg8oZ9Hnu3oMmCSeFSxf1SZKPGjt6avwCUtMob6pGf4cIbUkgH12bEr1IEYEjl/dOszLT/kmuuGap68cnchfkMpuPG2tFVSvlQgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Gv5HSU3I; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Gv5HSU3I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790510381; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PBee7+V8zEKXVMTs+wwTx5B3tNdbnkyFJUEXDrj7INg=;
	b=Gv5HSU3IhInWGbue91hfEVJJdSoKH0s+8pyXQ13fYiY8/WUeAWAtA8wa+DvCh+fA1qgD77uAGCs+wh+o4fzABWURAxVpHdJWkRoYgIKlAup07DTLkYupVF0iKH7U3BGh+LFXLoGX+7sTniToS5CxiliENwSTsgUO5vnugXmDGHc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07438608|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0132348-0.00388059-0.982885;FP=10282059465953380003|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jP8tcBj_1790510380;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jP8tcBj_1790510380 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 27 Sep 2026 19:59:41 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] nfc: nci: avoid unbounded skb allocation when max_pkt_payload_len is zero
Date: Sun, 27 Sep 2026 19:59:40 +0800
Message-ID: <20260927115940.3817019-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_queue_tx_data_frags() uses conn_info->max_pkt_payload_len as the
fragment size.  When that value is zero, frag_len is always zero and
total_len never decreases.  The loop then allocates skbs without bound:
none of them are freed inside the loop, they accumulate on frags_q, and
there is no cond_resched() in the loop body.  A single sendmsg() can
therefore consume all allocatable memory, and on CONFIG_PREEMPT_NONE it
occupies the CPU long enough to trip the softlockup watchdog:

  watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [kworker/3:1:57]
  Workqueue: events rawsock_tx_work [nfc]
  Call Trace:
   nci_send_data+0x1ca/0x6b0 [nci]
   nci_transceive+0xbb/0x170 [nci]
   rawsock_tx_work+0xb5/0x1a0 [nfc]

max_pkt_payload_len comes straight from controller-supplied fields with
no check for zero, and it is read several times along the TX path while
the rx workqueue can update it without any lock held against this path.

Take a single READ_ONCE() snapshot of the limit in nci_send_data(),
reject a zero limit there, and pass the snapshot down to
nci_queue_tx_data_frags().  The fragmentation decision and the
fragmentation loop then consume the same value, so the loop cannot spin
on a limit that differs from the one just validated, and no plain read
of the field is left in nci_send_data() or nci_queue_tx_data_frags().

Rejecting the zero limit at the entry of the TX data path covers the RF
connection as well: ndev->rf_conn_info is allocated with devm_kzalloc(),
so its max_pkt_payload_len is zero from the moment the object exists and
only becomes usable when an activation notification assigns a
controller-supplied value.  Checking where the value is consumed catches
every producer of a zero limit -- the initial state, the notification,
and any future writer.

The two producers of the field are annotated with WRITE_ONCE() to match
the snapshot read; the remaining plain accesses on the HCI path are
untouched here, since nci_hci_send_data() loops over a different
conn_info instance (ndev->hci_dev->conn_info) and needs its own fix,
which is sent separately.

The "failed to fragment tx data packet" print sits on a data path driven
by controller/remote data and can fire on every transmit once
fragmentation keeps failing.  Rate-limit it so a misbehaving controller
cannot flood the log.  Note that with the zero-limit rejection moved into
nci_send_data(), a rejected zero limit returns before this print, so the
per-sendmsg flood does not occur through that path.

No legitimate configuration is affected: where the NCI spec does mandate
a zero Max Data Packet Payload Size -- the NFCEE Direct RF Interface --
nci_rf_intf_activated_ntf_packet() takes the "goto listen" shortcut,
bypassing the assignment entirely.

While at it, drop the conn_info lookup in nci_queue_tx_data_frags():
the caller has already validated the connection, the function now takes
everything it needs as arguments, and the lookup was the only use of
conn_info left in it.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
Changes in v3:
  - Snapshot max_pkt_payload_len once in nci_send_data() with
    READ_ONCE() and pass it down to nci_queue_tx_data_frags(), as
    suggested by Simon Horman, so the fragmentation decision and the
    fragmentation loop consume the same value and no plain read of the
    field remains on this path (review:
    https://lore.kernel.org/netdev/20260925155040.GP13925@horms.kernel.org/)
  - Move the zero-limit rejection from nci_queue_tx_data_frags() into
    nci_send_data(), so the check runs on the same snapshot the loop
    consumes; this also means a rejected zero limit returns before the
    "failed to fragment" print rather than triggering it per sendmsg
  - Annotate the two producers of the field (RF activation NTF and
    CORE_CONN_CREATE_RSP) with WRITE_ONCE() to match the snapshot read
  - Drop the now-redundant conn_info lookup in nci_queue_tx_data_frags();
    the caller already validated the connection
  - Rate-limit the "failed to fragment tx data packet" print, which sits
    on a data path driven by remote data, as discussed in the review of
    the v2 series
  - Keep the v1/v2 subject so the revision is tracked as the same fix

Changes in v2:
  - READ_ONCE() snapshot of max_pkt_payload_len in
    nci_queue_tx_data_frags(): with the check and the loop reading the
    field independently, a store from the rx workqueue in between
    could let the loop spin on a value the check had just rejected
---
 net/nfc/nci/data.c | 34 ++++++++++++++++++++--------------
 net/nfc/nci/ntf.c  |  3 ++-
 net/nfc/nci/rsp.c  |  3 ++-
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 4253edea5..935e1fe61 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -95,9 +95,9 @@ int nci_conn_max_data_pkt_payload_size(struct nci_dev *ndev, __u8 conn_id)
 EXPORT_SYMBOL(nci_conn_max_data_pkt_payload_size);
 
 static int nci_queue_tx_data_frags(struct nci_dev *ndev,
-				   __u8 conn_id,
-				   struct sk_buff *skb) {
-	const struct nci_conn_info *conn_info;
+				   __u8 conn_id, struct sk_buff *skb,
+				   u8 max_pkt_payload_len)
+{
 	int total_len = skb->len;
 	const unsigned char *data = skb->data;
 	unsigned long flags;
@@ -108,17 +108,10 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 
 	pr_debug("conn_id 0x%x, total_len %d\n", conn_id, total_len);
 
-	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
-	if (!conn_info) {
-		rc = -EPROTO;
-		goto exit;
-	}
-
 	__skb_queue_head_init(&frags_q);
 
 	while (total_len) {
-		frag_len =
-			min_t(int, total_len, conn_info->max_pkt_payload_len);
+		frag_len = min_t(int, total_len, max_pkt_payload_len);
 
 		skb_frag = nci_skb_alloc(ndev,
 					 (NCI_DATA_HDR_SIZE + frag_len),
@@ -171,6 +164,7 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 int nci_send_data(struct nci_dev *ndev, __u8 conn_id, struct sk_buff *skb)
 {
 	const struct nci_conn_info *conn_info;
+	u8 max_pkt_payload_len;
 	int rc = 0;
 
 	pr_debug("conn_id 0x%x, plen %d\n", conn_id, skb->len);
@@ -181,17 +175,29 @@ int nci_send_data(struct nci_dev *ndev, __u8 conn_id, struct sk_buff *skb)
 		goto free_exit;
 	}
 
+	/* The rx workqueue updates the limit concurrently: snapshot it
+	 * once and drive both the fragmentation decision and the
+	 * fragmentation loop from the same value.
+	 */
+	max_pkt_payload_len = READ_ONCE(conn_info->max_pkt_payload_len);
+
+	if (!max_pkt_payload_len) {
+		rc = -EPROTO;
+		goto free_exit;
+	}
+
 	/* check if the packet need to be fragmented */
-	if (skb->len <= conn_info->max_pkt_payload_len) {
+	if (skb->len <= max_pkt_payload_len) {
 		/* no need to fragment packet */
 		nci_push_data_hdr(ndev, conn_id, skb, NCI_PBF_LAST);
 
 		skb_queue_tail(&ndev->tx_q, skb);
 	} else {
 		/* fragment packet and queue the fragments */
-		rc = nci_queue_tx_data_frags(ndev, conn_id, skb);
+		rc = nci_queue_tx_data_frags(ndev, conn_id, skb,
+					     max_pkt_payload_len);
 		if (rc) {
-			pr_err("failed to fragment tx data packet\n");
+			pr_err_ratelimited("failed to fragment tx data packet\n");
 			goto free_exit;
 		}
 	}
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index f5c9a8ab7..c818c09f3 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -856,7 +856,8 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		if (!conn_info)
 			return 0;
 
-		conn_info->max_pkt_payload_len = ntf.max_data_pkt_payload_size;
+		WRITE_ONCE(conn_info->max_pkt_payload_len,
+			   ntf.max_data_pkt_payload_size);
 		conn_info->initial_num_credits = ntf.initial_num_credits;
 
 		/* set the available credits to initial value */
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5ac..c0c689526 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -345,7 +345,8 @@ static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 			ndev->hci_dev->conn_info = conn_info;
 
 		conn_info->conn_id = rsp->conn_id;
-		conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
+		WRITE_ONCE(conn_info->max_pkt_payload_len,
+			   rsp->max_ctrl_pkt_payload_len);
 		atomic_set(&conn_info->credits_cnt, rsp->credits_cnt);
 	}
 
-- 
2.50.1

