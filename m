Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C3490C12;
	Thu,  1 Oct 2026 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893503; cv=none; b=aCeFJWYzJFUJJf9/YC1A1NH8Uwb/e9/SyaNGjo4CdsdPBrsZBja4i1aJbtR+aoWhK+Gup0yny+SbIWPlJizkFlTKzJqLKXt27qcwX1myovcyTtZ23lZozH164KQkXyql/WwyLM5+kCGELt7NL8+XezczZdsuXnqcAwJlW25uP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893503; c=relaxed/simple;
	bh=EeKakClpgaipfdNzkpsEZtlL5gC4aMH0hdHQlBkbHRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGuRNOc/FQ2jwWQKWcppvMY5uZyX7d4amuNSoaMIe4tYam5t0STEKkMLBjfFjqnzupEzadCNWa/35rMGnPcAnle5E6BFQiVgasg0JmM4hD5jWoRpZhNZxblaVcCauoYnW5craeVWVg/WonLpLNWC5xi8tJBg0Iz5Or92ngxUSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+LYazVa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+LYazVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790893502; x=1822429502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EeKakClpgaipfdNzkpsEZtlL5gC4aMH0hdHQlBkbHRk=;
  b=W+LYazVaGokGz/gyJCJGtTExmt4qmZmgAv8FW4uhWJV1QV7ry9UFSHWe
   s5593SbVcX7bA3wr87+eBFLlzy0lLqDlOm+dvFJ1VRjZ4wyvq+bF3IBc8
   WPLkjpvOh/qrDyoixFUGEnyxmGCby9SZkFeZ0qwapEsQp5vENNisHi9Tq
   jtumRI6nLw37ddN1t8JhbVrlfxFr/YEY9zqYByjJQH9KGZm/xb9vzbTuj
   ROBBqXWnvE9XIe4eMQNuTEWooMHxqEcu9YQbzE00bWULhD06lgYnrW/Xo
   9Y0bEYOdxyzadQIMAHGiQSv3ba5T8t6PKyrrY5tXfWU1OWlC0b4E8yaZ+
   w==;
X-CSE-ConnectionGUID: hM+uiZKuRzux2zSQz8E+Kw==
X-CSE-MsgGUID: J7IEwyKzRC+ZOLn5/mSMBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90567706"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90567706"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:24:58 -0700
X-CSE-ConnectionGUID: 6xtCCnkzTIKqMVOgqDRrcg==
X-CSE-MsgGUID: Ui2qMos2Tf2PGu363bv/Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279863769"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2026 15:24:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tjerk Kusters <tkusters@aweta.nl>,
	anthony.l.nguyen@intel.com,
	florian.bezdeka@siemens.com,
	meng.ding@siemens.com,
	p@1g4.org,
	jiayuan.chen@linux.dev,
	pulehui@huawei.com,
	richardcochran@gmail.com,
	stable@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 3/6] igb: only strip Rx timestamp header on the first buffer of a frame
Date: Thu,  1 Oct 2026 15:24:36 -0700
Message-ID: <20261001222443.3500206-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tjerk Kusters <tkusters@aweta.nl>

When Rx hardware timestamping is enabled (e.g. ptp4l, which configures
HWTSTAMP_FILTER_ALL), the NIC prepends a 16-byte timestamp header to the
first Rx buffer of every received frame. igb_clean_rx_irq() strips this
header inside its per-buffer loop:

	if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
		ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
						 pktbuf, &timestamp);
		pkt_offset += ts_hdr_len;
		size -= ts_hdr_len;
	}

For a frame that spans more than one Rx buffer (e.g. a jumbo frame), this
block runs once per buffer. The timestamp header only exists at the start
of the first buffer, but igb_ptp_rx_pktstamp() is called for every buffer.

On a continuation buffer the data is packet payload, not a timestamp
header. igb_ptp_rx_pktstamp() already has two guards against acting on a
non-header buffer: it returns 0 if PTP is disabled, and returns 0 if the
reserved dwords (the first 8 bytes) are non-zero. Neither is sufficient
here: PTP is enabled, and a continuation buffer whose payload happens to
begin with 8 zero bytes passes the reserved-dword check. In that case the
payload is mistaken for a valid timestamp header and igb_ptp_rx_pktstamp()
returns IGB_TS_HDR_LEN, so the caller strips 16 bytes of real data from
that buffer. A frame spanning N buffers whose continuation buffers start
with zero bytes therefore loses 16 * (N - 1) bytes from its tail.

This is easily triggered by a GigE Vision camera streaming dark frames
(mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
the all-zero frames arrive truncated while frames with non-zero content
are fine. There is no error indication.

No content-based check can reliably tell a continuation buffer that begins
with zero bytes from a real timestamp header, because both are all zero.
Fix it structurally instead: only attempt the strip on the first buffer of
a frame, which is the only buffer that can contain a timestamp header. In
igb_clean_rx_irq() skb is NULL until the first buffer has been processed,
so guarding the strip with !skb restricts it to the first buffer
regardless of payload content.

Fixes: 5379260852b0 ("igb: Fix XDP with PTP enabled")
Cc: stable@vger.kernel.org
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..5c09dc4a2566 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9069,8 +9069,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 		rx_buffer = igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
 		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
 
-		/* pull rx packet timestamp if available and valid */
-		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+		/* pull rx packet timestamp if available and valid; it is only
+		 * present on the first buffer of a frame
+		 */
+		if (!skb &&
+		    igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
 			int ts_hdr_len;
 
 			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
-- 
2.47.1

