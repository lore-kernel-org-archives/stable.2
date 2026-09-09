Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000B3B2D24;
	Wed,  9 Sep 2026 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944161; cv=none; b=DAzxK9n2HQJ28B8T4LxybJEpxWBg1n+i5vkYr/3tUTjkIjOhMa2uFaSo18Qhxq/a3Jy0inCNm+BF1oRttW/RcKHwpMtgWxyvx7szbYI9VqSXmfspCy54J6ojc/t/nAaSS2r8yzWRDR+x3AOFQI08ZEPxTnZxyO+ze+i6rP/K+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944161; c=relaxed/simple;
	bh=D9U5g7q9v+rnJDJNy22p+Pe5KS+zbVIaqFGLV1VvEt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mrzihXkJ8WYQ0+w9M+7ZsJnAenH6MsbqC1B1FtqPUgcs1yQUngYC5aClEWuelNecfpDtEKfmt//Tfmki0SZiT3Yw4cv0hVNfxI/dGxpewwUqM6b8AIg4c0LR5ePV1vbzM2mk8RJwHrICKswIud6d94vHmqA5a8brzqCcRGdy+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=aqAkk7t3; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="aqAkk7t3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1788944159; x=1820480159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mWBjSLBU925hAFawF2eAchvZnolvusgBQ8n8QxE9OVM=;
  b=aqAkk7t3za2X2SBwJ7fxe/XKoEsj6ZOlCEiDtfXGj0ZligTpaPbPg++8
   6VKmOxadJDWTgCxuSpWH8epcIWXGoiL3e30OzniiTVH457IyjZnyHkLLv
   M/RvQWk+Ko+DhOeQc6a2nGKodvTNa44fKn0mbAhWG+zXDvQtYaGsqFpOk
   Wyl1buguQ6i2hvis8Mn8glKqo9xCngfsiKH97nr0QIiT+2F/sxAMC9MOn
   EV9g9T3KFUA4N+lhdgOvfl2gshW48i/BHFqOubCr9up97NMwC3bhyTvzG
   MV+85TzhyiEaLPutlyQVOt8Kn0NPS+xbFOZsaABHBRv97nI+gqZFtM0RE
   g==;
X-CSE-ConnectionGUID: d0JHdyqaQPmU7Dfjyo4vJw==
X-CSE-MsgGUID: EQnoxXBEQd+tMXMHwqWNjQ==
X-IronPort-AV: E=Sophos;i="6.25,270,1779148800"; 
   d="scan'208";a="27991648"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 08:55:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:22904]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.196:2525] with esmtp (Farcaster)
 id 4952f932-5e69-4f2d-92d6-ffc2bd750591; Wed, 9 Sep 2026 08:55:57 +0000 (UTC)
X-Farcaster-Flow-ID: 4952f932-5e69-4f2d-92d6-ffc2bd750591
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 9 Sep 2026 08:55:57 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 9 Sep 2026 08:55:56 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Willem de Bruijn <willemb@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Bjoern Doebel <doebel@amazon.de>,
	<stable@vger.kernel.org>
Subject: [PATCH net] loopback: orphan zerocopy frags before releasing the sender in loopback_xmit()
Date: Wed, 9 Sep 2026 08:55:42 +0000
Message-ID: <20260909085542.3370986-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

AF_PACKET PACKET_TX_RING transmission over the loopback interface can
silently corrupt packet payloads in flight. tpacket_fill_skb() builds
the transmit skb using zerocopy frags. loopback_xmit() then calls bare
skb_orphan(), which runs skb->destructor (tpacket_destruct_skb()) and
marks the ring slot TP_STATUS_AVAILABLE, telling userspace the buffer is
reusable while the in-flight skb frags still reference that buffer.

This is ok if the packet gets processed immediately in loopback's xmit
path before userspace gets a chance to reuse the frag buffer. However,
if the packet gets redirected for instance to another CPU (via RPS),
this opens a window where userspace may already write new data into the
frag buffer before the receiver reads the original content.

Reproducer using txring_overwrite from the net:run_afpackettests selftest:

  ip netns add ns && ip -netns ns link set lo up
  ip netns exec ns sh -c \
      'echo 100 > /sys/class/net/lo/queues/rx-0/rps_cpus'
  taskset -c 0 ip netns exec ns ./txring_overwrite

Commit 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
is meant to trigger this copy from the skb_orphan_frags{_rx}() call
sites, but loopback_xmit() calls bare skb_orphan() before any of them
run. Address this by taking a kernel-private copy of the skb frags
before going down the receive path.

Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
Cc: stable@vger.kernel.org
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Assisted-by: Kiro:claude-opus-5
---
Verified that the reproducer in the commit message fails 100% right now
and no longer fails after the patch.
---
 drivers/net/loopback.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 1fb6ce6843ade..31ae10a9d7911 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -72,6 +72,23 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 {
 	int len;
 
+	/* The skb_orphan() below will run the skb's destructor, which
+	 * for AF_PACKET TX-ring senders marks the slot as TP_STATUS_AVAILABLE
+	 * again, even though it still has zerocopy frags pointing to it that
+	 * will only be copied later in the receive path's
+	 * skb_orphan_frags_rx(). As such, if the receive path gets deferred,
+	 * for example by RPS steering the packet to another CPU, this creates
+	 * a race where userspace may fill in new data into the frag before the
+	 * old data gets copied out.
+	 *
+	 * Take a kernel-private copy.
+	 */
+	if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC))) {
+		dev_core_stats_tx_dropped_inc(dev);
+		kfree_skb_reason(skb, SKB_DROP_REASON_SKB_UCOPY_FAULT);
+		return NETDEV_TX_OK;
+	}
+
 	skb_tx_timestamp(skb);
 
 	/* do not fool net_timestamp_check() with various clock bases */
-- 
2.50.1

