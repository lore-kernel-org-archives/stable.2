Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956189;
	b=WCeUiYqEVmXL+DC7bff/pcwfxuLqlBi6Y6ol2DVkZ+cd/u0oiYAFi2SrdZoXRd8wGSI/
	 c7m7ofap082LnWegPZm7LyHcnUd62IyHznS4PwUUqRHfucSxsab2RPmycJTzkNj56OQ8V
	 i/smEZ0J489MvnTuPIRwli5aP+F7i8vNhJUqSBaRngoKWDmNRzaqanMHCj7/Qr1QCoFJx
	 6kPwV3dwJEbaiQCYSDKsMhqv/+wZifQgXKbOwxf3zTYU4j+QFHxWgG+PcRg4pfgncsR9T
	 W+Eb3NR42uEavwMPHG6v5qBJogHC9DjcmDKicES03GMmIJhuWCx7ZNtZJMaT1Tbsegw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956189;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Received:
	 DKIM-Signature;
	bh=jNhF0RsAjqQgmOWzAdc/K6AtQWNPxxUaVfOzPmIFQKI=;
	b=GuaGVAu1joBlD9//OL37YjVg0o7NYRPonV/gY90sBkAxfyiKIGRyctmnGQdhzdhubOpJ
	 sOzbWgYme2tvr5JM1CJleHPCzC+VHCyS2Mzn6Xa7PFzGTB7KE5SXFgJTbqHzKGwTX3nML
	 Aaefbrji0xGCewEa7dJW73bauoh3lCfxzqgK+Cyus5BvSekFDq/EXggGlSv1JLXu7+k5U
	 UoT7WXS71SM1QD5aPVp5VzPS4WHhjPcMAY2RZW1xvbWHTM4GXzGVQVXE4+PZaq58pKYVT
	 K8FA/iGKZF6vn1NFFIxoan2jajrPJ1SFCR5+lbvN2MsDCw79K1oWpA1npkcHWMi10hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=a0d3Y7oF;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20177606A32A;
	Tue, 17 Nov 2026 22:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20177606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=a0d3Y7oF
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
Subject: [PATCH net v4 1/2] net: atl1c: wait for in-flight RX polls before the link-down ring reset
Date: Tue, 17 Nov 2026 23:55:20 +0100
Message-ID: <20261117225521.19689-2-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117225521.19689-1-federico@rimpianto.com>
References: <20261117225521.19689-1-federico@rimpianto.com>
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
	by mail.rimpianto.com (Haraka) with ESMTPSA id 1A751935-FDFB-4345-9147-8CBB6C5D7B43.2
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 17 Nov 2026 23:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=s20260314391;
 t=1794956122; bh=jNhF0RsAjqQgmOWzAdc/K6AtQWNPxxUaVfOzPmIFQKI=;
 b=a0d3Y7oFqdupBCr5xixfeNYiapQWRvd2Ukm81KJhHQc+gpcGvH45I55p+1HJ5Unz0nU9oJelZ
 vKLqDoa4jYylT6ru1cBYRbju2CdQWsrO+V6prD0IWY48IXUYbLbxEl479Ti9FT7rFiE0Ds4DGH8
 od0ofO0v8M1QM/HluKbkvEtzq9yrXlp6mbLed4JTmOQdmYOdmwEikqiEXCAIx0gT70fiflN7JfF
 5P8U75Ww46IrWJlcjjitDXstgQObPp1EgO6OLQW9NStaaszSLRt+rohJBWYS3SeucyjrmVTdgf0
 Teshaz2avUPOTQP7Juzm2+V1hJG4QzTZkh+LVstYCTXw==

When the PHY reports link down, the work item calls
atl1c_check_link_status(), which resets the MAC, frees every RX buffer and
zeroes the ring indices through atl1c_reset_dma_ring(), then posts fresh
buffers through atl1c_configure(). Nothing keeps the RX poll away while it
does so: atl1c_irq_disable() masks the device interrupt and waits for the
hard interrupt handler only, and atl1c_clean_rx() tests the carrier only
when it is entered. A poll that passed that test before the carrier went
off keeps walking the RRD ring on another CPU while the work item frees
the same buffers. Both can unmap and free the same skb, or the poll can
hand the stack an skb the work item has already freed.

Once the carrier is off, wait until no RX poll is in flight before
touching the rings. A poll that starts later sees the carrier off and
returns without looking at them, so NAPI does not have to be disabled.

napi_disable() is not used because it cannot be made safe here without
serialising the work item against atl1c_down() first: the two can run
concurrently (MTU change, ethtool, suspend), a second napi_disable() on an
already disabled NAPI sleeps holding the netdev instance lock, and the
napi_enable() of the first caller then blocks on that lock.
atl1c_check_link_status() is also called by atl1c_up() before
napi_enable(). For the same reason the wait gives up when the interface is
down: a disabled NAPI keeps NAPI_STATE_SCHED set, and atl1c_down() has
quiesced NAPI on its own.

Found by code inspection; the race has not been reproduced.

Fixes: 5e5c0964d9b9 ("atl1c: do MAC-reset when PHY link down")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
New in v4. The Sashiko review flagged this race on v2 and again on v3 of
the next patch: pre-existing, but made worse by a free in the same window.

Not addressed, both pre-existing: the TX side of the same reset
(atl1c_clean_tx() and atl1c_xmit_frame() against atl1c_clean_tx_ring()),
and the missing serialisation between the work item and the callers of
atl1c_down().
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index eddd8406867f..e9baee8fa7e5 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -248,6 +248,26 @@ void atl1c_reinit_locked(struct atl1c_adapter *adapter)
 	clear_bit(__AT_RESETTING, &adapter->flags);
 }
 
+/* atl1c_clean_rx() looks at the carrier only when it is entered.  Once the
+ * carrier is off, wait for the polls that are already past that test, so
+ * that the link-down path can reset the RX rings.  A poll that starts later
+ * sees the carrier off and leaves the rings alone.
+ *
+ * A disabled NAPI keeps NAPI_STATE_SCHED set, which is why this is not
+ * napi_synchronize(): stop waiting when the interface is down.  atl1c_up()
+ * gets here before napi_enable(), and atl1c_down() quiesces NAPI itself.
+ */
+static void atl1c_rx_poll_sync(struct atl1c_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->rx_queue_count; ++i)
+		while (test_bit(NAPI_STATE_SCHED,
+				&adapter->rrd_ring[i].napi.state) &&
+		       !test_bit(__AT_DOWN, &adapter->flags))
+			usleep_range(1000, 2000);
+}
+
 static void atl1c_check_link_status(struct atl1c_adapter *adapter)
 {
 	struct atl1c_hw *hw = &adapter->hw;
@@ -265,6 +285,7 @@ static void atl1c_check_link_status(struct atl1c_adapter *adapter)
 	if (!link) {
 		/* link down */
 		netif_carrier_off(netdev);
+		atl1c_rx_poll_sync(adapter);
 		hw->hibernate = true;
 		if (atl1c_reset_mac(hw) != 0)
 			if (netif_msg_hw(adapter))
-- 
2.47.3

