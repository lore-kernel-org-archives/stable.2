Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530773;
	b=QCL4Ej+boIIscF0L0jrdGKI66qVWAHDIE0vp1yTNmYtie0kxYePKK1pvQewm6muyjgOV
	 wVS+PWW/Bz5Zm4JWg/sAGbRdOxytclds1kE4sAMhwe4bKfM6jQGRDcBEOpvnIlUH5mTYl
	 y6H/ztRj9gXV8rtrezSTqj7X5pYM68HLLSGRRMoxKuAKj/Vaz96uMhAkP/0SZvNF+RZKm
	 55C//u1IalcLIZJtRCwcOF0o+Xjqs7rFWTaeR50jxIiV4+4lGvqbUonwkNp64Khyakm9E
	 9ko0WqKD/dL0CQPdPqb2zl3GYlExNrxiZPORi5UkFVu8Dez4OZccKxN7SdBLtjmTakw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530773;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VBvqXZBrg8ZLXBJ9VhBif5IOKYlUEiVGie0TkZwk+Fk=;
	b=NEFvTBJruKSZzBAeFjvHAjlD3oJhJLEpR4Xa5bYoB6W7SFgWlbyf7yh9wg622dxUJIrL
	 aRCpH4WGT4U5jZWBsw/B00te5HlXjF00G2oeRN1F9KIAGCEDfe3mS+Grstv2kslZJjq6S
	 QMNT+hBVBcUU0I2IeT14NRvB53tcfc7XSvLVlc9jqzCS6ea43KgVJMwC1iW+9p3nITlWf
	 olArCp0QBheoSOpAm+qUT2rnb9DOur1JSya37BXX8uMuijxBgBScLv3XUaILoF7Jvqqsn
	 /UPO/aTrd/NwJbdz9MEJxEgyNqIOKsLXbZGCWklU862y2IxaDsQfLEOxgMwIaAOJeoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oy+jbiFc;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D4606A335;
	Fri, 13 Nov 2026 00:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 360D4606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oy+jbiFc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794530773; x=1826066773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FS8xKdlb579ol/9zLRwDxy8aWB7r/U991SRhEfkpzAg=;
  b=Oy+jbiFcGNJiTeUrx6A28sJQY5CpHcGmEDKdEm+Zia0T4EXI9oxZZMgW
   w6+N7eRfCr2aAay30CmtHyYLB7r1sdZPwC/ooCxuWAP6PeyZq/LXPsjF8
   1pDF5JE99j8BuUsKIc4BBmGOhNk9n1wtCNweSpZ6g+48J94HcCNFXnhKd
   jpzpDnjjaahdZMXHrueNGRQ4PZGr4M4sw7hQlJhOFxkPdCJpEQyoO1rkn
   pi1pEqH5w3pixc0Mv+UmHBru6/FboAWY/bNEu1EZpbzhwuScEEiiL0jTS
   rkp8iQi55sMMWv/VRrgT2vDRLSbuDhxyoyVgPW8G9DD6oqxnVTO2slGd6
   A==;
X-CSE-ConnectionGUID: zxxyL4+2RcivWKpwPZ+bzQ==
X-CSE-MsgGUID: /lYdS2SNTm2T0/vWxVokQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3361674"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3361674"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:46:12 -0800
X-CSE-ConnectionGUID: aSRG+HCdSZCurinFYVOaJg==
X-CSE-MsgGUID: 2SU3wGHsTOaoKCNYwYHJbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8724617"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2026 16:46:13 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	mheib@redhat.com,
	fballuch@redhat.com,
	luoxuanqiang@kylinos.cn,
	jbrandeb@kernel.org,
	stable@vger.kernel.org,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 3/6] i40e: avoid resetting BQL state when freeing temporary Tx rings in set_ringparam
Date: Thu, 12 Nov 2026 16:45:57 -0800
Message-ID: <20261113004602.129864-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
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

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Temporary Tx rings built by i40e_set_ringparam() while resizing
descriptor counts are shallow struct copies of the live vsi->tx_rings[]
entries, so they retain the same ring->netdev and ring->queue_index as
the live ring they are staged to replace.

If an error path frees one of these clones with
i40e_free_tx_resources() before i40e_down() has run - either the
i40e_setup_tx_descriptors() failure unwind loop, or the free_tx: error
label - i40e_clean_tx_ring() will call netdev_tx_reset_queue() on
txring_txq(tx_ring), which resolves to the *same* netdev_queue as the
live ring because netdev/queue_index alias. That call resets the
queue's BQL/dql state (dql_reset(): num_queued = num_completed = 0)
while the live ring is still actively transmitting and completing
Tx on that same queue.

The next time the live ring reports completions for bytes that were
queued before the reset, dql_completed() can underflow its own
sanity check and hit:

	BUG_ON(count > num_queued - dql->num_completed);

i.e. a guaranteed kernel panic, not just a warning, given a queue with
outstanding (queued but not yet completed) Tx traffic at the moment
the clone is freed.

Reproduced on real hardware by forcing i40e_setup_tx_descriptors() to
fail partway through building tx_rings[] while flooding real Tx
traffic on the affected queues:

    kernel BUG at lib/dynamic_queue_limits.c:99!
    RIP: 0010:dql_completed+0x285/0x2a0
    Call Trace:
     <IRQ>
     i40e_napi_poll+0x74b/0x1700 [i40e]
     __napi_poll+0x10a/0x200
     net_rx_action+0x2f7/0x380
     handle_softirqs+0xcc/0x270

Confirmed the same trigger no longer panics with this fix applied,
including repeated resize/traffic cycles.

Clear the clone ring netdev before freeing it in both error paths, so
i40e_clean_tx_ring()'s existing `if (!tx_ring->netdev) return;` guard
skips the netdev_tx_reset_queue() call for the clone. This mirrors the
same idiom i40e already uses for XDP Tx rings, which also have no
netdev_queue of their own (ring->netdev = NULL in i40e_vsi_setup_tx()).
Only the temporary, about-to-be-freed clone is touched; the live ring
in vsi->tx_rings[] keeps its netdev.

Fixes: 9f65e15b4f98 ("i40e: Move rings from pointer to array to array of pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ef756487d668..58d842d67642 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2143,6 +2143,8 @@ static int i40e_set_ringparam(struct net_device *netdev,
 					i--;
 					if (!i40e_active_tx_ring_index(vsi, i))
 						continue;
+					/* not live yet, skip its BQL reset on free */
+					tx_rings[i].netdev = NULL;
 					i40e_free_tx_resources(&tx_rings[i]);
 				}
 				kfree(tx_rings);
@@ -2248,8 +2250,11 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	/* error cleanup if the Rx allocations failed after getting Tx */
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
-			if (i40e_active_tx_ring_index(vsi, i))
+			if (i40e_active_tx_ring_index(vsi, i)) {
+				/* not live yet, skip its BQL reset on free */
+				tx_rings[i].netdev = NULL;
 				i40e_free_tx_resources(&tx_rings[i]);
+			}
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.47.1

