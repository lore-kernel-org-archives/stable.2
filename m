Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAF332913;
	Fri, 24 Jul 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883747; cv=none; b=FUvh/pBWy97cOA5r+PQR6zavYC/TEIXMoEFIi2JX6D+lXGAwsPXEOIAP74XIG8i080rxPF1pjwdhpa2Timu/EcSRSvAUfH9qLnYSEo5eDU7stE2NA+XfsqgYsryrJ15T8dSUNmaQjf8AuqhbTvJHbRkb0HcMjYL6sG+arGAjWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883747; c=relaxed/simple;
	bh=EvtcL2NUiEJOTUWUDoNmjN8xHYQ/OKx/SJ93wkS2qAY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LS2kPyqEXeYoDZKg975tzkj0KWR0FMWOS54H4UIIHhefpCjtJ5sLk7yiB94bK9PGYo4dtzG/YdNFvkLgIN4O7aG9N4Ctc+7fWT+GJHo21RU/VfO92CEwLb09bq9ojDdXFZKMTaKBXH5GZJlUAbIh6KgpEavrhP4Fyy9M4XvLH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f5xtTtQm; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f5xtTtQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784883734; bh=QyFlgoeYRjeI4DQuiSC8DugoBorAfJKSqJNj4EACvo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f5xtTtQmX+vDRNR9h7fLDo1hLJjqTQA6FywNlLENXCxXih5+cPXfKtFS0To8Nfw/K
	 6xGG7WvLTejVDs2KixTBpOU12DUqkebMYYGgzp+exI6FKOH6GwKQ6FYElm1ZmqyBVk
	 l5TpvYzW3pxiDses+BhteXJ7Kzme4Z94GsHe90yI=
Received: from localhost.localdomain ([240e:37c:2242:cf00:265e:beff:fe6a:4da1])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 89B18AE; Fri, 24 Jul 2026 17:02:09 +0800
X-QQ-mid: xmsmtpt1784883729txebgdhma
Message-ID: <tencent_F0FD0A4E6AFB381AE042C7AC87583506F10A@qq.com>
X-QQ-XMAILINFO: NR25d0ihy8j11ORAqCNTWcE1G8ujvGKpWwYBDZ7qk/ajgZRzlvdwwnU3FcopPC
	 TfYeTxqwOJLZNxbcTFl0uQ/5ZbsYrQ+E634088YNdcc37oGKGYqtK3HX9dZikGmUVqqInysS2pmP
	 EodK0XQXZ6KfQRfKqvqsJ7xMKRToMaorWzehwW5QLrmjIQzN55EYXm5QDHY5Om9W/tRISdWQCMmC
	 ydIQxVtaVfroVGuxv/1nJuh6paQ5ajj0nGrlWC3S9p3yzzuABL8BiFaEzoy3kFWQWHWWVqYbTDmt
	 RvEjftp06MDpG7KhTBx9qpVisvib+NO5x5Ty7+aobfTi6A1zha1z1rp4Y6WzBwjIduR+GiXl9fVh
	 PHu4yHYtDbH8idTFwDSh7hLLASdZm4NZgSMhmDGPeRYC7o2jXCUgs9kbUGcBWw8aw5f1Asp96CUh
	 AunVkv5Sn33IwCYXiCM6L5xZTKR+Dj0GcFn63gznuAPY1NpSnOQ6bXeNa2b3KSw5HgmwcAOm9xGn
	 RwUQBMlfbxqqaMaJCY7cIVYQCOtpaxSUgM0xCoXH94tStqm9mkNBghVlNxcQQp7l66ujoBPJXzIB
	 kw4H8FVDekT319ZpqNdrtQ9DO/cSoY7Wg3nQsH6u+nswqFJzlswucNAfBr2w1sS7l7uzwBWPNKU9
	 Z60XtAJ0OU3of9UM4Dz9I0QZDWoA16SRZYX2ORbtCijJy4KOe+ARgW0zxftk+LptVknDj2/ZetDx
	 mwVA0Wzk8NMh4wI3pj3g/0f2FjGYOjYImJtzO67DfjphLTaY1IhSZoUfOgcIaepk/5WbpyNXUqVH
	 6XNpZK2icgse9qvMZ427JucfNkF/RWEjbwOONp8oRQh0+avKuoCmuuWTau+D6wy+TOxTD9craxss
	 udLeB1JvRaonBJsMOeaef3vHIAFcxhKxj2aZSuzEV5PntRjTan/vYUxoeMA0igRFw0eEBdNLodud
	 U7DlHLfNOE+BR7MJJxCPRKx0kIZMXFVNtsq/Ww0VAexTw29Zm1U4b3PLUnOIbZjTeQKS5MqTDlRm
	 BbYg7gz1cGj2DuBL8h7ZwO498Zf7hBUxXtZ60kPl6zH/1xdMveYJrV0tm+0dkae77musPhA5EE2a
	 4tHUpLg0DBslKOxoOn+RYlykslkpO1Pk9O2bkn
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Igor Russkikh <irusskikh@marvell.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net-next v2 2/3] net: atlantic: free RX pages of consumed but not refilled buffers
Date: Fri, 24 Jul 2026 17:02:08 +0800
X-OQ-MSGID: <20260724090208.10556-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aq_ring_rx_deinit() only walks [sw_head, sw_tail), the region posted to
hardware. Since the page reuse strategy was added, a cleaned RX buffer
keeps its page (and its DMA mapping) in the ring for reuse, and refill
is batched: aq_ring_rx_fill() returns early until AQ_CFG_RX_REFILL_THRES
slots are free. Slots that were consumed but not yet reposted therefore
sit in the complementary [sw_tail, sw_head) gap with a live page, and
the deinit walk never visits them: up to a refill batch worth of pages
and DMA mappings leak on every interface down.

Walk the whole ring instead and release whatever is still there. Also
bail out if the buffer ring is already gone: a partial
aq_ptp_ring_alloc() failure frees the ring but leaves aq_nic set, so
aq_ptp_ring_deinit() still gets here on the unwind path.

Fixes: 46f4c29d9de6 ("net: aquantia: optimize rx performance by page reuse strategy")
Cc: stable@vger.kernel.org # v5.2+
Assisted-by: Claude:claude-fable-5
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---

Notes:
    Without this fix, the following page_pool conversion turns the missed
    pages into fragments that page_pool_destroy() waits for forever.
    Reproduced on an AQC100 with the conversion applied and this fix
    reverted -- ordinary small received frames (<= 256 byte header-only
    packets, e.g. ping replies or pure TCP ACKs) are enough to populate
    the [sw_tail, sw_head) gap:
    
      ping -c 200 -i 0.005 <peer>%enp99s0
      ip link set enp99s0 down
    
    One short ping flow left three of the eight RX rings' pools with
    stranded fragments, and page_pool_release_retry() warns for each of
    them every 60 seconds, indefinitely:
    
      [278084.929092] page_pool_release_retry() stalled pool shutdown: id 123, 1 inflight 60 sec
      [278084.961064] page_pool_release_retry() stalled pool shutdown: id 126, 1 inflight 60 sec
      [278084.961087] page_pool_release_retry() stalled pool shutdown: id 125, 6 inflight 60 sec
      [278145.346737] page_pool_release_retry() stalled pool shutdown: id 123, 1 inflight 120 sec
      [278145.378745] page_pool_release_retry() stalled pool shutdown: id 125, 6 inflight 120 sec
      [278145.378759] page_pool_release_retry() stalled pool shutdown: id 126, 1 inflight 120 sec
    
    With this patch the whole ring is walked at deinit, the pages are
    released, and the pools drain immediately. On the current code the
    same gap leaks the pages and their DMA mappings silently.
    
    Applies and was build- and runtime-tested independently of the rest
    of this series, against the current page scheme.
    
    New in v2: split out of the page_pool conversion and made a
    standalone fix for the existing page reuse scheme (Mina); Cc stable
    with the affected range.

 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 81685a4dc5a6..e1193c6719d9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -950,15 +950,29 @@ int aq_ring_rx_fill(struct aq_ring_s *self)
 
 void aq_ring_rx_deinit(struct aq_ring_s *self)
 {
-	if (!self)
+	unsigned int i;
+
+	if (!self || !self->buff_ring)
 		return;
 
-	for (; self->sw_head != self->sw_tail;
-		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
-		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
+	/* Release every page still owned by the ring.
+	 *
+	 * Walking [sw_head, sw_tail) is not enough: refill is batched
+	 * (aq_ring_rx_fill() waits for AQ_CFG_RX_REFILL_THRES free slots),
+	 * so slots that were cleaned but not yet reposted accumulate in the
+	 * [sw_tail, sw_head) gap, and they keep their page for reuse. Walk
+	 * the whole ring and release whatever is left.
+	 */
+	for (i = 0; i < self->size; i++) {
+		struct aq_ring_buff_s *buff = &self->buff_ring[i];
+
+		if (!buff->rxdata.page)
+			continue;
 
 		aq_free_rxpage(&buff->rxdata, aq_nic_get_dev(self->aq_nic));
 	}
+
+	self->sw_head = self->sw_tail;
 }
 
 void aq_ring_free(struct aq_ring_s *self)
-- 
2.47.3

