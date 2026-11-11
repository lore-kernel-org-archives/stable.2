Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387857;
	b=1yKfAxevjR/Q0HpKHefgVpLJGRPOyKWz9V5lHxE8PSDGhhlDAdoh0X7wR6WVJ7L4MKnR
	 V35JgU+jHc1RMHHinqHkRfy/yewng3fLIvMfXybNwes5onJMwHh+4KWibofFaLGvJpU0P
	 M2za/PJ6aF85sOs+Aswzf/qDPmIMtDj6Wenm5WL3NQy0jyYzEXX7KGf+hhjy/aTCSf6Yr
	 LG2tS4S5ObfW4ubDxqr0c/eCqfkZh7wbEfMOF3c12ofeQltesW+1RCABavNdXtJO/NqGM
	 Cp7nD2Dp2XFuGCkbHiMohNHMkM2yAXhfH84FnRpXbtOoenGyN8HXBSLQddPTsh88UHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387857;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cngTStRSbCTlPKjELIo0XWShwxU2pjKN6j7stn5DOCg=;
	b=u4+MbJCDgj1dtZ6Z6q2OQx/B1vpAVwFAUiCAQTPduXhZT1LEJQ/6gyWYvDP49MAfCVIW
	 tjKiz0GNzFqLFGwWC47cC2dskatSvqrGjEzjsZCs4cIXeOju2iz9WQsCmIXtEofCNDCPJ
	 sv6+cSa44WnGZxaWaqCa0dzXvPbijOd9q9+/ZmZ4evhuJ0v1zJrkELQAod8C7C7z2UcVU
	 mN+r8GluQ0wNiLZUDLB07tUrZGv0YutkhRHsaJoWS0XPqiS1b6fDNht//GP3Vbdxbmp80
	 eab7ITg1KVvirhHEhxX9ABn2v3aTZqtNU+JSFOlKYrM98iGcJGyKNhHj0mHeuFScNfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PFnnl6XS;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D6606A31C;
	Wed, 11 Nov 2026 09:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E3D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=PFnnl6XS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PFnnl6XSCosrOI5fNjI1M91BJk18RDKOx2Hrjn0TuCwAyWmH8ZQGtuE089EOX6vr5ktJYOcr2STIM
	 3K+qgpPyryf+IqQIujWP0Uqqynn3I4rEGw42I8VvoZjN/n1PlsYd5Xb60+G91hyuzrhx2rckhs8djK
	 39vC/PkXpQm/Qpt0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af42f8dc60-a351e;
	Wed, 11 Nov 2026 17:04:13 +0800 (CST)
X-RM-TRANSID:2ee36af42f8dc60-a351e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.112.32.189])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af42f8b6ae-d67ed;
	Wed, 11 Nov 2026 17:04:13 +0800 (CST)
X-RM-TRANSID:2ee46af42f8b6ae-d67ed
From: guohongyu <guohongyu@cmss.chinamobile.com>
To: jeff.chen_1@nxp.com,
	francesco@dolcini.it,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	13057616121@163.com
Subject: [PATCH] wifi: nxpwifi: fix tid and reorder-window bounds checks in RX reorder
Date: Wed, 11 Nov 2026 16:57:00 +0800
Message-ID: <20261111085700.109141-1-guohongyu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nxpwifi RX reorder code indexes several MAX_NUM_TID-sized arrays
(struct nxpwifi_private::rx_reorder_tbl_ptr[8] and
rx_reorder_tbl_lock[8], main.h:548/550) with a tid that is neither
validated at the callers nor at the function entry, and accesses a
win_size-sized flex array (tbl->rx_reorder_ptr[]) with a pkt_index that
can exceed win_size.  Both are remote-reachable through a received
802.11 frame.

Bug 1 - tid used as array index without bounds check

  nxpwifi_11n_rx_reorder_pkt() and nxpwifi_11n_create_rx_reorder_tbl()
  take a tid parameter that flows directly into:

    list_for_each_entry_rcu(tbl, &priv->rx_reorder_tbl_ptr[tid], list)   (11n_rxreorder.c:187)
    spin_lock_bh(&priv->rx_reorder_tbl_lock[tid]);                       (11n_rxreorder.c:324)
    list_add_tail_rcu(&new_node->list, &priv->rx_reorder_tbl_ptr[tid]);  (11n_rxreorder.c:325)

  These arrays have MAX_NUM_TID (8) entries.  The tid comes from
  local_rx_pd->priority in the receive path (sta_rx.c:232, uap_txrx.c:405)
  - a u8 filled by firmware from the received frame's rxpd, range 0-255 -
  or from the 4-bit TID field of an ADDBA request (11n_rxreorder.c:379,
  range 0-15).  Neither path checks tid < MAX_NUM_TID before calling into
  the reorder code; sta_rx.c:224-226 does gate the rx_seq[] write on
  priority < MAX_NUM_TID, but the subsequent nxpwifi_11n_rx_reorder_pkt()
  call at sta_rx.c:232 drops the same check.  A tid >= 8 reads
  rx_reorder_tbl_ptr[] out of bounds, takes a spinlock on a garbage
  address, and writes an out-of-bounds list_head.

  Fix: validate tid < MAX_NUM_TID at the entry of both
  nxpwifi_11n_rx_reorder_pkt() and nxpwifi_11n_create_rx_reorder_tbl(),
  covering all callers.

Bug 2 - pkt_index not bounded by win_size

  tbl->rx_reorder_ptr is allocated with win_size entries
  (11n_rxreorder.c:280, kzalloc_flex).  In nxpwifi_11n_rx_reorder_pkt()
  the out-of-window drop check (11n_rxreorder.c:459-470) uses TWOPOW11
  (2048) rather than win_size, so a seq_num within [start_win,
  start_win + 2048) passes the drop check regardless of win_size.
  pkt_index is then computed as seq_num - start_win (11n_rxreorder.c:491)
  and can reach 0..2047, but the write

    tbl->rx_reorder_ptr[pkt_index] = payload;   (11n_rxreorder.c:500)

  only has win_size slots.  With win_size = 1 (allowed: create_rx_reorder_tbl
  only rejects win_size <= 0 at 11n_rxreorder.c:276) any pkt_index > 0 is a
  heap out-of-bounds write of up to ~2048 pointer slots.

  Fix: bound pkt_index against tbl->win_size before the rx_reorder_ptr[]
  access.

Together these close an out-of-bounds read + spinlock-on-garbage and an
out-of-bounds heap write, both reachable from a received frame.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: guohongyu <guohongyu@cmss.chinamobile.com>
---
 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
index 87cf2ec85991..111225594144 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
@@ -266,6 +266,9 @@ nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
 	u16 last_seq = 0;
 	struct nxpwifi_sta_node *node;
 
+	if (tid >= MAX_NUM_TID)
+		return;
+
 	/* Existing TID/TA: flush and move window to SSN. */
 	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, ta);
 	if (tbl) {
@@ -421,6 +424,9 @@ int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *priv,
 	bool init_window_shift = false;
 	int ret = 0;
 
+	if (tid >= MAX_NUM_TID)
+		return -EINVAL;
+
 	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, ta);
 	if (!tbl) {
 		if (pkt_type != PKT_TYPE_BAR)
@@ -492,6 +498,11 @@ int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *priv,
 		else
 			pkt_index = (seq_num + MAX_TID_VALUE) - start_win;
 
+		if (pkt_index >= tbl->win_size) {
+			ret = -EINVAL;
+			goto done;
+		}
+
 		if (tbl->rx_reorder_ptr[pkt_index]) {
 			ret = -EINVAL;
 			goto done;
-- 
2.43.0



