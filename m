Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002841;
	b=5T/iw+BX6Wf6ePXozFqPN2AZ8mqM/ybFdvAg+lf4Jw68GVgqnN1KozglMOT1W9nR4+7g
	 P9949x680dPcgO33pcC6zGTrMce1XPwVmpYWiOvyfarRE+42WLpHRjeh6V8JWTSi8FUj7
	 pTk8BeXCNeIBFitax7kYpK7+PyGDLWcOOL0J/tJY9lTmhXyLvZrCW44auHaLRfcJAgq/6
	 zSO6mGic1kEZBNaKprMnidWRU67mIUS0A9dCCkAmohorDQF53Ys8xuTuu48YvBJC3tSGd
	 6c3TkULv0xeoUL+hkb3rw50AoIGF8tbeDrWNwnt0N5FUxjLZLOWfDVRT+/R7Lm3bssA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WBEeqIL73Y3FKJoTIAQjnok5Bu6VuhGrKsIfDtMI/rY=;
	b=NH4Qk4dTAZ9/FFtSrXYP3ajNJdRUzy3Dqh7dNoD/sXqZfzB6lPmmTDqoIL/3a4baLMZy
	 sPxLCuxL+lOvHUDZjSJl+QlfdzLBHmN7dbIzn836sG38RTTRsZq7F7GNhE2BXmVAa8U5q
	 bhNp6u1yzCaRzNFtkWnJgTUWBWXNFwewws5LWoCUBNdUjL3OXLIUhGqUJ4cFiRpcUd3Kg
	 0zBRycAiPb1i7NVVwy0Kg+iZ3KXrRuBJ+VTv5Zc7/dZNpS4zaXTvgM1GAiAjbxpZmTdVz
	 udrHpMFmNF7934XQlI0HDbYCYEPUabgYrGAViO42PvOxoOKLHV+c1NArU43gNvs+BCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4kR4p6K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805A606A31A;
	Mon, 26 Oct 2026 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4kR4p6K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1A81F01825;
	Mon, 26 Oct 2026 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793002840;
	bh=WBEeqIL73Y3FKJoTIAQjnok5Bu6VuhGrKsIfDtMI/rY=;
	h=From:To:Cc:Subject:Date;
	b=h4kR4p6Kjjvcsi43A2s6kzYrXCv/D+zWq79JhJQ8GQQ7r3BWVXfaayIDGV5Un9B53
	 hi38DVfAg4IvK2atYhu3EBKIs1gua12jOuaOm/cPDkVfgqSZL5xYPzC+pSyMuMwBhA
	 LBzPbb+M5nYyFiHm9WgHg46BG727RaNyg5u1iDy535LKPLvSgY+w4TKcWIBbx9ZSuW
	 bKWLwwSuhjc6ohLFTCEQgbgm+nrgiLXFBzoT00xdu7Yvxm6Zj/HHK1kE/aVcHmtp/F
	 YmH7aGQhgAZFWX4edDGoNCwqCkmJe05OFlDSK5lgj5m6GSGfYca3UASn+ZR8mWYtR8
	 VwMl1DEB0OmwA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	stable@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net] ixgbe: reserve TX timestamp after skb preparation
Date: Mon, 26 Oct 2026 09:20:35 +0100
Message-ID: <20261026082035.335770-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

ixgbe_xmit_frame_ring() takes an extra skb reference with skb_get()
for the pending TX timestamp before preparing the skb for transmit.
Several of the following steps may need to reallocate the skb head:

- ixgbe_tso() calls skb_cow_head(), which reaches pskb_expand_head()
  when the header is cloned (e.g. a packet tap holds a clone).
- ixgbe_tx_csum() falls back to skb_checksum_help() for unsupported
  checksum offsets, which can call pskb_expand_head() through
  skb_ensure_writable().
- With DCB and a software VLAN tag, skb_cow_head() is called to
  rewrite the VLAN priority.

pskb_expand_head() used to BUG() on shared skbs. Since commit
c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
pskb_expand_head()") it returns -EINVAL instead, so these packets
are dropped (TSO, DCB) or sent with an unfinished checksum
(skb_checksum_help() errors are ignored by ixgbe_tx_csum()).

Reserve the TX timestamp right before ixgbe_tx_map(), after all skb
preparation, as i40e and ice already do. The timestamp request
remains covered on the FCoE path, and the cleanup on ixgbe_tx_map()
failure is unchanged.

Fixes: 891dc0821d20 ("ixgbe: Add ptp work item to poll for the Tx timestamp")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 40 +++++++++++--------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f91856498eb2d9e0e4173153c8c00bc2248bb708..b9496f0bee1312499f28c2f3c24fcff9a1e66e0d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9444,23 +9444,6 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 	}
 	protocol = vlan_get_protocol(skb);
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    adapter->ptp_clock) {
-		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !test_and_set_bit_lock(__IXGBE_PTP_TX_IN_PROGRESS,
-					   &adapter->state)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-			tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
-
-			/* schedule check for Tx timestamp */
-			adapter->ptp_tx_skb = skb_get(skb);
-			adapter->ptp_tx_start = jiffies;
-			schedule_work(&adapter->ptp_tx_work);
-		} else {
-			adapter->tx_hwtstamp_skipped++;
-		}
-	}
-
 #ifdef CONFIG_PCI_IOV
 	/*
 	 * Use the l2switch_enable flag - would be false if the DMA
@@ -9525,6 +9508,29 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 #ifdef IXGBE_FCOE
 xmit_fcoe:
 #endif /* IXGBE_FCOE */
+	/* Reserve the Tx timestamp only after all skb preparation:
+	 * skb_get() makes the skb shared, and pskb_expand_head()
+	 * (reached from skb_cow_head() or skb_checksum_help())
+	 * refuses shared skbs.
+	 */
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+	    adapter->ptp_clock) {
+		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
+		    !test_and_set_bit_lock(__IXGBE_PTP_TX_IN_PROGRESS,
+					   &adapter->state)) {
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+			tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
+			first->tx_flags |= IXGBE_TX_FLAGS_TSTAMP;
+
+			/* schedule check for Tx timestamp */
+			adapter->ptp_tx_skb = skb_get(skb);
+			adapter->ptp_tx_start = jiffies;
+			schedule_work(&adapter->ptp_tx_work);
+		} else {
+			adapter->tx_hwtstamp_skipped++;
+		}
+	}
+
 	if (ixgbe_tx_map(tx_ring, first, hdr_len))
 		goto cleanup_tx_timestamp;
 
-- 
2.53.0

