Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD624A067;
	Fri, 18 Sep 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757724; cv=none; b=JlJwHxf1Lj5YcI6vrqdy8Lu3gJgmrDsEZyz98Bby2+jrPoMeY0oP53OwBbd8OY/5MZbiQ5KwxtGU++A9Qr3vMZ5HLfaAL1zb3S1wcoyN4AENhW+A518KgbwzEuttdr4ZTa/UuDcQfQj9pXg8ZD4EdxubVESS7FeCcTS0ltXYMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757724; c=relaxed/simple;
	bh=TkEkOV/UTIbv9coI61MU3VKkRcZ9B9xyYVO+E3VZ1Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf9uqZj/804/8336ZmcloYUOCfixP9Xp0J8YI9fSsVK0uVmnTuk6QGtNNZ+aP4ttWmsoTDOLDTmE08h5zm1/nbUNa32lghErk9VuCavq/ZJl76B35K0lNJwHkWtZxEHZC2TbJQ96Iqj9nI4cvlaQr49bHM0bo+xdAlAi4uiGFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=da5ZCPcq; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="da5ZCPcq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789757702; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lgFp/9B42kvQa+Z8zuuYk6q+bpP6I85Dz4+oQQPkRsg=;
	b=da5ZCPcqgIc/rqbqdv6ItIvjG9Hu6DZyKWw7nm6pgrH/S5fFgKMz2sRIB+TaZDOaEaokcRQMSYlNMIW9BSyMYy0Ka+aL2pUs1u3+cLrb2MyCte62cO/DeO+uXlu0dHaWyDSTLGlTdktZhKQ4dL+lhoeIelLHFM+UprbkIvi4mbU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07440566|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00347207-0.00176248-0.994765;FP=14173271799656615558|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.jH4dkGS_1789757700;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jH4dkGS_1789757700 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 19 Sep 2026 02:55:01 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ilane@ti.com,
	david@ixit.cz,
	linville@tuxdriver.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH net v2] nfc: nci: avoid unbounded skb allocation when max_pkt_payload_len is zero
Date: Sat, 19 Sep 2026 02:54:58 +0800
Message-ID: <20260918185458.2711284-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260913101309.891633-1-liuc63@xiaopeng.com>
References: <20260913101309.891633-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nci_queue_tx_data_frags() uses conn_info->max_pkt_payload_len as the
fragment size.  When that value is zero, frag_len is always zero and
total_len never decreases.  The loop then allocates skbs without
bound: none of them are freed inside the loop, they accumulate on
frags_q, and there is no cond_resched() in the loop body.  A single
sendmsg() can therefore consume all allocatable memory, and on
CONFIG_PREEMPT_NONE it occupies the CPU long enough to trip the
softlockup watchdog:

  watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [kworker/3:1:57]
  Workqueue: events rawsock_tx_work [nfc]
  Call Trace:
   nci_send_data+0x1ca/0x6b0 [nci]
   nci_transceive+0xbb/0x170 [nci]
   rawsock_tx_work+0xb5/0x1a0 [nfc]

max_pkt_payload_len comes straight from controller-supplied fields,
with no check for zero:

  ntf.c: conn_info->max_pkt_payload_len = ntf.max_data_pkt_payload_size;
  rsp.c: conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;

Reject the zero value in the fragmentation path rather than at the
assignment sites.  nci_queue_tx_data_frags() is the only place that
loops over the RF data path's conn_info, and nci_send_data() takes
the non-fragmenting branch only for skb->len <= max_pkt_payload_len,
which for a zero limit means empty skbs alone.  Validating on
assignment would not be sufficient either, because
nci_rf_disc_rsp_packet() allocates ndev->rf_conn_info with
devm_kzalloc(), so max_pkt_payload_len is already zero before any
notification arrives.

No legitimate configuration is affected: where the NCI spec does
mandate a zero Max Data Packet Payload Size -- the NFCEE Direct RF
Interface -- nci_rf_intf_activated_ntf_packet() takes the "goto
listen" shortcut, bypassing the assignment entirely.

Snapshot the field once with READ_ONCE() and use the snapshot for
both the check and the min_t() bound: the rx workqueue updates the
field without any lock held against this path, so without the
snapshot the check could validate a value the loop no longer
consumes.

nci_hci_send_data() also loops over the same field, but on a
different conn_info instance (ndev->hci_dev->conn_info) created by
nci_core_conn_create_rsp_packet(); a zero or one there underflows
the loop arithmetic and will be addressed in a separate patch.  This
guards the path carrying the reported bug.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>

---

v1 claimed that nci_queue_tx_data_frags() is "the only place that
loops" over max_pkt_payload_len.  That holds for the RF data path
(ndev->rf_conn_info) but was overstated as a blanket claim: the
Sashiko review of v1 pointed out that nci_hci_send_data() loops over
the same field as well, albeit on a separate conn_info instance
(ndev->hci_dev->conn_info) -- pre-existing and unchanged here; it
will be fixed separately.

The READ_ONCE() snapshot follows the same review: with the check and
the loop reading the field independently, a store from the rx
workqueue in between would let the loop spin on a value the check
had just rejected.
---
 net/nfc/nci/data.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 4253edea5..eeb5260c5 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -104,6 +104,7 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 	struct sk_buff_head frags_q;
 	struct sk_buff *skb_frag;
 	int frag_len;
+	u8 max_len;
 	int rc = 0;
 
 	pr_debug("conn_id 0x%x, total_len %d\n", conn_id, total_len);
@@ -114,11 +115,18 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 		goto exit;
 	}
 
+	/* the rx workqueue may update the field concurrently */
+	max_len = READ_ONCE(conn_info->max_pkt_payload_len);
+
+	if (!max_len) {
+		rc = -EPROTO;
+		goto exit;
+	}
+
 	__skb_queue_head_init(&frags_q);
 
 	while (total_len) {
-		frag_len =
-			min_t(int, total_len, conn_info->max_pkt_payload_len);
+		frag_len = min_t(int, total_len, max_len);
 
 		skb_frag = nci_skb_alloc(ndev,
 					 (NCI_DATA_HDR_SIZE + frag_len),
-- 
2.50.1

