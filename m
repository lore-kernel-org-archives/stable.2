Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F293E1683;
	Sun, 13 Sep 2026 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294724; cv=none; b=moaz8a+WTVBMCvwl8d0FELM+bLXRPEa2mtxk2rt8cYSD8Y98JuB1BiA1A4bD2ZY+rLGAb4YgJv9fxHgRsO5GfceNX1RvjXS2Artc2aezrBcYRx0hfO6udZ2bas8VbpZoAapIIgt8hryd3lCC7jSXGd14MDyT14PoaBs4znA8QcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294724; c=relaxed/simple;
	bh=r4wVVkuqRlfIfMfUPDikHgAKFLkUDgQoiT6wrAjRufk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNHs5yeizt8cJ/KcKz8Te3ubLksQoHYPQkl155CmWZl+dZujSGaN1BzvvrELVhWTwmXepZSRNYceFHxWmlg1D7skd/gPCWwRGrPY8VxOtsrvqOgvBfDKjT3I2wnZmwzhjdDcWRp1oJ27aENBZWiE6WiIXQxDK7BvGlxDPhmkGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=F1QP8EfZ; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="F1QP8EfZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789294712; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+26ooWuhqZZHzVkkLL0D9UrBlJ22BeeP2IpYkHGQ+/s=;
	b=F1QP8EfZD4Oy4RtfXlWsPkGmH6O7omqfqPbHLre9nZ3Kdh9vzuTMd2nEzfYPu80Y7gc5s/3WZNV0W6dMn8VWHSHaLzvmhezhllWit+95NrZ5AyKv6CjQsUAeCvt93WZLdVt2DO3nNCMvxBBNyMisYXkzws4feBvXFQ4yGWrzKYU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07882031|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00494777-0.000972548-0.99408;FP=16767890541788292742|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.jCTU3wv_1789294389;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jCTU3wv_1789294389 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 18:13:10 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: David Heidelberg <david@ixit.cz>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Ilan Elias <ilane@ti.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: nci: avoid unbounded skb allocation when max_pkt_payload_len is zero
Date: Sun, 13 Sep 2026 18:13:09 +0800
Message-ID: <20260913101309.891633-1-liuc63@xiaopeng.com>
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

max_pkt_payload_len is taken verbatim from controller-supplied fields,
with no check for zero:

  ntf.c: conn_info->max_pkt_payload_len = ntf.max_data_pkt_payload_size;
  rsp.c: conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;

Reject the zero value in the fragmentation path rather than at the
assignment sites.  nci_queue_tx_data_frags() is the only place that
loops, and nci_send_data() takes the non-fragmenting branch only for
skb->len <= max_pkt_payload_len, which for a zero limit means empty
skbs alone.  Validating on assignment would not be sufficient either,
because nci_rf_disc_rsp_packet() allocates ndev->rf_conn_info with
devm_kzalloc(), so max_pkt_payload_len is already zero before any
notification arrives.

No legitimate configuration is known to be affected.  Where the NCI
spec does mandate a zero Max Data Packet Payload Size -- the NFCEE
Direct RF Interface -- nci_rf_intf_activated_ntf_packet() takes the
"goto listen" shortcut, bypassing the assignment entirely.

Reproduced with CONFIG_NFC_VIRTUAL_NCI by injecting an
RF_INTF_ACTIVATED_NTF with max_data_pkt_payload_size set to 0 and then
sending a data frame on an AF_NFC SEQPACKET socket.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 net/nfc/nci/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 4253edea5..b549cef7d 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -114,6 +114,11 @@ static int nci_queue_tx_data_frags(struct nci_dev *ndev,
 		goto exit;
 	}
 
+	if (!conn_info->max_pkt_payload_len) {
+		rc = -EPROTO;
+		goto exit;
+	}
+
 	__skb_queue_head_init(&frags_q);
 
 	while (total_len) {

base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.50.1

