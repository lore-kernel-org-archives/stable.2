Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606356;
	b=JkCb0M8Pks1aLStMjm2Lv1M3QiNtXUIDoo8GjIf4UtEdO3/qBfPfWtbEspIvy5xqgxfs
	 ZAXMJWXJoiydkH2PFq9Cy7l+w5OHdT6F83I7W7T8HG4ABYTwBdID8HOfSY0m+1B/3Pl5n
	 m8RySYCk8CMFTFW5GRrAWQjI6Rgmh78ILN0TrYuEGQTD4sO9mDOh7SqdR6k7pCE7thaaQ
	 0gbWUCpSIs7wg9M4VbYdddEtNsTE65C2J5RIPyxD6NbwvKXqe4wBD7vpMh4KoHHQQLfvS
	 7gU+u0wylbnULlgTBvQ8rKZelmfaxSZR7qM/Llzzw6DV+OYSFaNlwRK4TDBUPTrFw5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606356;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Received:
	 DKIM-Signature;
	bh=b5/u/al/otVDeJI7AX/e/YrAlHDpoWQ4QAjq8dJ7v/s=;
	b=WpVMjQejj0gTOLHqjSNIy/62bZbRMhRfWgVpSdFxHlkF/4WG0hGL0DMqSAawhHodaV7O
	 7ZNX+mJ0cKi552/Aqz909HaJelUIhRO0QIXlOLgWdu8cIXpVTJ3Ah9U7Kt3+PirqR+0RH
	 Fke11m1ubNIv7kjKqw8hknfXfkPpAbkalxfwiR/bmtR9/ZjcgL1hIFaYgbbfJoS8Aed90
	 3pK3jDFxeXy/TFI1IymUtQOcCjxXL+/v86yKfh7hl95OsdHNlFyUJc8GGJS6Apz1Q2hHb
	 Rj/81IrNmSHBY/D5nsPf+76Jp4rxU2N3aDgsJXSt3Bj1T5D8Xe+f7bkppVanihBVBsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b="SNEht/71";
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EC606A327;
	Wed, 25 Nov 2026 11:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F8EC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=SNEht/71
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Federico Musto <federico@rimpianto.com>,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/2] net: atl1c: wait for in-flight RX polls before the link-down ring reset
Date: Wed, 25 Nov 2026 12:31:19 +0100
Message-ID: <20261125113120.99743-2-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125113120.99743-1-federico@rimpianto.com>
References: <20261125113120.99743-1-federico@rimpianto.com>
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
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 455A4CB8-EA41-4A84-AB6F-0475A2A7EF25.2
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 25 Nov 2026 12:31:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=s20260314391;
 t=1795606281; bh=b5/u/al/otVDeJI7AX/e/YrAlHDpoWQ4QAjq8dJ7v/s=;
 b=SNEht/71rCBfAMMscYpIupiYDUAXc9a3GxJ2NruecOOVZUynNx7CR/GRsia491DnV61jNkK1h
 eJyIsHHeS+Q3RlvNSw8mGuWViXscmIjwRI85Q2RDsLQSFyMXVq8KA9+sGiOmkH0H9057Lu4Bqfc
 WunUFvmTrbMYRIPUFPcGAjIQ2scKtEZd/QeqsL5rwqKU5IrcarEciRC5xehyfQrPRLlmRCpXJSt
 IyOZORvacQ4EaFyAAzmCIhrbx4rifaG2d2+Q4DTSM1+Vh/tmvCbZ2T6n8OeoR0FDevWvQYfFG+P
 pdHHIhiH9c5bkCa4vhy9zQTdQWZgVxvIK8Qg4BJJhmXA==

When the PHY reports link down, the work item calls
atl1c_check_link_status(), which resets the MAC, frees every RX buffer
and zeroes the ring indices through atl1c_reset_dma_ring(), then posts
fresh buffers through atl1c_configure(). Nothing keeps the RX poll away
while it does so: atl1c_irq_disable() masks the device interrupt and
waits for the hard interrupt handler only, and atl1c_clean_rx() tests
the carrier only when it is entered. A poll that passed that test before
the carrier went off keeps walking the RRD ring on another CPU while the
work item frees the same buffers. Both can unmap and free the same skb,
or the poll can hand the stack an skb the work item has already freed.

Once the carrier is off, wait until no RX poll is in flight before
touching the rings. NAPI_STATE_SCHED is held for the whole poll, so
observing it clear on every RX queue means no poll is running, and a
poll that starts later sees the carrier off and returns without looking
at the rings. NAPI does not have to be disabled.

The handshake is a store-buffer pattern: the work item stores the
carrier-off state and then loads NAPI_STATE_SCHED, while the scheduling
side stores NAPI_STATE_SCHED (the cmpxchg in napi_schedule_prep()) and
the poll then loads the carrier.  With a full barrier between store and
load on both sides, either the work item sees the poll or the poll sees
the carrier off.  The cmpxchg provides it on the scheduling side; an
explicit smp_mb() after netif_carrier_off() provides it here, so that
the wait does not depend on how that function sets its bit.

napi_disable() is not used because it cannot be made safe here without
serialising the work item against atl1c_down() first: the two can run
concurrently (MTU change, ethtool, suspend), a second napi_disable() on
an already disabled NAPI sleeps holding the netdev instance lock, and
the napi_enable() of the first caller then blocks on that lock.

The same concurrency shapes the wait. atl1c_close() and atl1c_down() set
__AT_DOWN before quiescing NAPI; if the bit appears while the wait runs,
a teardown is under way that will napi_disable() and reset the rings
itself, so the work item must leave them alone rather than reset without
having waited. The wait is also bounded: a poll that never finishes
would otherwise stall the work item with interrupts masked. In both
cases the rings are left untouched and the handler runs again on the
next link-change event.

Only the work item waits. atl1c_up() also calls
atl1c_check_link_status(), before napi_enable(): no poll can run there,
and a disabled NAPI keeps NAPI_STATE_SCHED set, so the wait would only
spin. It passes false and the link-down path runs unchanged.

Found by code inspection; the race has not been reproduced.

Fixes: 5e5c0964d9b9 ("atl1c: do MAC-reset when PHY link down")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
New in v4. The Sashiko review flagged this race on v2 and again on v3 of
the next patch: pre-existing, but made worse by a free in the same
window.

v4 -> v5, after the Sashiko AI review of v4:
 - on __AT_DOWN, skip the link-down reset instead of proceeding without
   waiting: the concurrent teardown resets the rings after
   napi_disable(), so the work item no longer touches them while a poll
   may be live;
 - bound the wait (~0.5-1 s) and skip the reset on timeout with a
   ratelimited warning, so a threaded busy-poll (which keeps
   NAPI_STATE_SCHED set while the interface is up) cannot hang the work
   item with interrupts masked;
 - wait only on the work-item path: atl1c_check_link_status() takes a
   bool and atl1c_up() passes false, because it runs before
   napi_enable() where a disabled NAPI keeps NAPI_STATE_SCHED set;
 - order the carrier-off store before the NAPI_STATE_SCHED sampling with
   an explicit smp_mb(): the handshake is a store-buffer pattern, the
   scheduling side is ordered by the cmpxchg in napi_schedule_prep().

Not addressed, both pre-existing: the TX side of the same reset
(atl1c_clean_tx() and atl1c_xmit_frame() against atl1c_clean_tx_ring()),
and the missing serialisation between the work item and the callers of
atl1c_down().
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 65 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index eddd840..afab3e1 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -248,7 +248,52 @@ void atl1c_reinit_locked(struct atl1c_adapter *adapter)
 	clear_bit(__AT_RESETTING, &adapter->flags);
 }
 
-static void atl1c_check_link_status(struct atl1c_adapter *adapter)
+#define ATL1C_POLL_SYNC_TRIES 500
+
+/* atl1c_clean_rx() looks at the carrier only when it is entered.  A poll
+ * that passed that test before the carrier went off keeps walking the RRD
+ * ring.  NAPI_STATE_SCHED is held for the whole poll, and a poll that
+ * starts later sees the carrier off and returns without touching the
+ * rings, so once the bit is observed clear on every RX queue no poll is
+ * running and none can start.
+ *
+ * Only the link-change work item needs the wait: atl1c_up() calls
+ * atl1c_check_link_status() before napi_enable(), when no poll can run,
+ * and a disabled NAPI keeps NAPI_STATE_SCHED set, so waiting there would
+ * only spin.
+ *
+ * Returns false when the caller must leave the rings alone:
+ *  - __AT_DOWN is set: a concurrent close, down or suspend is tearing the
+ *    device down and resets the rings itself, after napi_disable();
+ *  - the wait timed out: a poll is not finishing (threaded busy-poll
+ *    keeps NAPI_STATE_SCHED set while the interface is up).  Resetting
+ *    under a running poll is the race this wait exists to avoid.
+ */
+static bool atl1c_rx_poll_sync(struct atl1c_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->rx_queue_count; ++i) {
+		int tries = ATL1C_POLL_SYNC_TRIES;
+
+		while (test_bit(NAPI_STATE_SCHED,
+				&adapter->rrd_ring[i].napi.state)) {
+			if (test_bit(__AT_DOWN, &adapter->flags))
+				return false;
+			if (!tries--) {
+				dev_warn_ratelimited(&adapter->pdev->dev,
+						     "RX poll won't finish, skipping link-down reset\n");
+				return false;
+			}
+			usleep_range(1000, 2000);
+		}
+	}
+
+	return true;
+}
+
+static void atl1c_check_link_status(struct atl1c_adapter *adapter,
+				    bool sync_polls)
 {
 	struct atl1c_hw *hw = &adapter->hw;
 	struct net_device *netdev = adapter->netdev;
@@ -265,6 +310,20 @@ static void atl1c_check_link_status(struct atl1c_adapter *adapter)
 	if (!link) {
 		/* link down */
 		netif_carrier_off(netdev);
+		if (sync_polls) {
+			/* Store-buffer pattern against the poll: we store
+			 * carrier-off and then load NAPI_STATE_SCHED, the
+			 * scheduling side stores NAPI_STATE_SCHED
+			 * (napi_schedule_prep()) and the poll then loads the
+			 * carrier.  A full barrier on each side guarantees that
+			 * either we see the poll or the poll sees the carrier
+			 * off.  The cmpxchg provides it there; do not depend on
+			 * how netif_carrier_off() sets its bit here.
+			 */
+			smp_mb();
+			if (!atl1c_rx_poll_sync(adapter))
+				return;
+		}
 		hw->hibernate = true;
 		if (atl1c_reset_mac(hw) != 0)
 			if (netif_msg_hw(adapter))
@@ -349,7 +408,7 @@ static void atl1c_common_task(struct work_struct *work)
 	if (test_and_clear_bit(ATL1C_WORK_EVENT_LINK_CHANGE,
 		&adapter->work_event)) {
 		atl1c_irq_disable(adapter);
-		atl1c_check_link_status(adapter);
+		atl1c_check_link_status(adapter, true);
 		atl1c_irq_enable(adapter);
 	}
 }
@@ -2435,7 +2494,7 @@ static int atl1c_up(struct atl1c_adapter *adapter)
 	if (unlikely(err))
 		goto err_up;
 
-	atl1c_check_link_status(adapter);
+	atl1c_check_link_status(adapter, false);
 	clear_bit(__AT_DOWN, &adapter->flags);
 	for (i = 0; i < adapter->tx_queue_count; ++i)
 		napi_enable(&adapter->tpd_ring[i].napi);
-- 
2.54.0 (Apple Git-157)

