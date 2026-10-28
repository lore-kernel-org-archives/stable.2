Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176522;
	b=oE9DjovDAVz0PPazeFclk/WdQM5C75pkNTwC/mGnRkOm+6iqZ0QB5aVA17sXz90fUhLq
	 n/WlT2YABobpzZU5gw0nsOTraJVa6AdrByrdcW1j4XhDOZZcJRNTU4jPiRREi64pAHpGp
	 t6/AMwFCHsmVHFfLXtmbDW7nB4xQeCzF/NUoqrHQ28tvNcagd2dVPyi0EbYf8w2lrWcKq
	 7B0VspjQdXEyptEcbrhU4Y4vB30KBn48J8S0m14onU+XcrWLeqrvRn+N8JjZj+v9IqrVA
	 odqzHqUYcS9AAPc5DH9cSTqGtiwU08sNKEAIYp3W/BQxjaAPKDOQuG0qHmVGof3O9ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176522;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HngzdtMkaQYMbxt2oHzsqKb38Y5j6eD3ic4/a/KrYdo=;
	b=13EV3p74lA1O10g80A2B/gbJeZeN0BhVPrG9o6RagYSVy67y7FJZ2uBtAWh9Wunw4tpF
	 ayu2FfPlR1KWgfvC/pRBXzD+J5aShdgW5205n3NLTalVt5uy7caQraBhRiRaq88bpNl98
	 KwWe+bfvRgG0ZL074Buf3D6E8o/zpb1dLZ8NjcurxWpijcXCb+UXMtHT1Dp3W6rtcxjZU
	 1ltcGtVeSeN7QfuyY9nvCQBNlUHnNfe7SFQiF7wP10ORL6Wf+ftgE7y9rd5Wr6zwSzJpI
	 hY+YefDjHrGikWUtkdAB1mnvbPAxIzbDcEvY1q+PDaqmJKSFIY+KrAwYC2rmGXFMbwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=avh7A5Ax;
	arc=none smtp.remote-ip=109.224.244.20
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD36606A32E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD36606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=avh7A5Ax
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793176519; x=1793435719;
	bh=HngzdtMkaQYMbxt2oHzsqKb38Y5j6eD3ic4/a/KrYdo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=avh7A5Ax0jWQ66VAFqlx/uTUK5s7ru3RsqJ+yVCJcFAx3EB0LpRvXfcZJr6EgFqcB
	 mTQvvo7znYeGaPbzG/9FRrmaTSTKXHZzLfs9QHPaUMX/KA8NHiCDW/GHmKtoOpjAmX
	 2i041iR13+F3x/KtPjsevsTYkoFGCx4X0G7hE0JK0jHkA91eCDCQDiOVnxmmAzN2Hk
	 K/YT3r52EMgWFF0tOVjMV8886NxSWpOEWyT55Zn96epFm9arB6+NSbR0+de54p9gZP
	 7Q9Xhit8EN7YdygrGJRPcYaCoO9y4NG3a0R5iHXcaQVnY8nM0HobZxE5dBHKzstQO8
	 Z47wZFxjynLmg==
Date: Wed, 28 Oct 2026 08:35:14 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com, maciej.fijalkowski@intel.com, andre.guedes@intel.com, aleksandr.loktionov@intel.com, avigailx.dahan@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v3 2/2] igc: fix AF_XDP receive buffer size for 2K UMEM chunks
Message-ID: <20261028083344.3047350-3-p@1g4.org>
In-Reply-To: <20261028083344.3047350-1-p@1g4.org>
References: <20261028083344.3047350-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d759728150bb8cbe67e82d639351f824e9829844
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

SRRCTL.BSIZEPKT has a granularity of 1 KiB. With a 2 KiB UMEM
chunk and the default XDP headroom, xsk_pool_get_rx_frame_size()
returns 1792. Programming this value truncates the hardware receive
buffer size to 1 KiB, even though an MTU-sized frame fits in the
usable UMEM area.

XDP on igc is limited to MTU 1500, so configure a 2 KiB receive
buffer for XSK rings. Limit RLPML to the maximum supported Ethernet
frame size while XDP is attached, regardless of PAGE_SIZE, to avoid
oversized frames spanning descriptors or exceeding the usable UMEM
space.

RLPML is currently programmed from igc_set_rx_mode(), which can run
without RTNL, for example on an IPv6 multicast join, and could then
use a stale XDP state. RLPML does not depend on the address lists.
Program it from igc_setup_rctl() instead, next to RCTL.LPE, and from
igc_xdp_set_prog() while the rings are disabled. This avoids
netif_addr_lock_bh() usage.

Validate that the XSK frame size accommodates a maximum-size frame
with two VLAN tags, FCS and the optional inline RX timestamp. Check
against the maximum supported XDP MTU, rather than the current MTU,
which can change after the socket is bound.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 33 +++++++++++++++++------
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 11 +++++---
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/in=
tel/igc/igc.h
index 17f213cc9..ad1062f85 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -765,6 +765,7 @@ static inline s32 igc_read_phy_reg(struct igc_hw *hw, u=
32 offset, u16 *data)
 =09return -EOPNOTSUPP;
 }
=20
+void igc_set_rlpml(struct igc_adapter *adapter);
 void igc_reinit_locked(struct igc_adapter *);
 struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 =09=09=09=09      u32 location);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 41b293dc1..6b418dc71 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -674,8 +674,11 @@ static void igc_configure_rx_ring(struct igc_adapter *=
adapter,
 =09ring->next_to_clean =3D 0;
 =09ring->next_to_use =3D 0;
=20
+=09/* igc's XDP limits MTU to 1500; all XSK RX buffers can use 2kb;
+=09 * RLPML limits the receive length to fit after UMEM headroom.
+=09 */
 =09if (ring->xsk_pool)
-=09=09buf_size =3D xsk_pool_get_rx_frame_size(ring->xsk_pool);
+=09=09buf_size =3D IGC_RXBUFFER_2048;
 =09else if (ring_uses_large_buffer(ring))
 =09=09buf_size =3D IGC_RXBUFFER_3072;
 =09else
@@ -830,6 +833,25 @@ static void igc_setup_mrqc(struct igc_adapter *adapter=
)
 =09wr32(IGC_MRQC, mrqc);
 }
=20
+void igc_set_rlpml(struct igc_adapter *adapter)
+{
+=09struct igc_hw *hw =3D &adapter->hw;
+=09u32 rlpml =3D MAX_JUMBO_FRAME_SIZE;
+
+#if (PAGE_SIZE < 8192)
+=09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
+=09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
+#endif
+=09/* igc's XDP currently does not support jumbo frames. Limit the
+=09 * accepted packet size regardless of PAGE_SIZE so it fits in a 2kb
+=09 * XSK chunk.
+=09 */
+=09if (igc_xdp_is_enabled(adapter))
+=09=09rlpml =3D ETH_FRAME_LEN + VLAN_HLEN * 2 + ETH_FCS_LEN;
+
+=09wr32(IGC_RLPML, rlpml);
+}
+
 /**
  * igc_setup_rctl - configure the receive control registers
  * @adapter: Board private structure
@@ -874,6 +896,7 @@ static void igc_setup_rctl(struct igc_adapter *adapter)
 =09=09=09  IGC_RCTL_CFIEN); /* Disable VLAN CFIEN Filter */
 =09}
=20
+=09igc_set_rlpml(adapter);
 =09wr32(IGC_RCTL, rctl);
 }
=20
@@ -4117,7 +4140,7 @@ static void igc_set_rx_mode(struct net_device *netdev=
)
 {
 =09struct igc_adapter *adapter =3D netdev_priv(netdev);
 =09struct igc_hw *hw =3D &adapter->hw;
-=09u32 rctl =3D 0, rlpml =3D MAX_JUMBO_FRAME_SIZE;
+=09u32 rctl =3D 0;
 =09int count;
=20
 =09/* Check for Promiscuous and All Multicast modes */
@@ -4147,12 +4170,6 @@ static void igc_set_rx_mode(struct net_device *netde=
v)
 =09/* update state of unicast and multicast */
 =09rctl |=3D rd32(IGC_RCTL) & ~(IGC_RCTL_UPE | IGC_RCTL_MPE);
 =09wr32(IGC_RCTL, rctl);
-
-#if (PAGE_SIZE < 8192)
-=09if (adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
-=09=09rlpml =3D IGC_MAX_FRAME_BUILD_SKB;
-#endif
-=09wr32(IGC_RLPML, rlpml);
 }
=20
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/etherne=
t/intel/igc/igc_xdp.c
index 9eb47b4be..a0f1ecb2e 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -34,6 +34,8 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct =
bpf_prog *prog,
 =09}
=20
 =09old_prog =3D xchg(&adapter->xdp_prog, prog);
+=09if (if_running && need_update)
+=09=09igc_set_rlpml(adapter);
 =09if (old_prog)
 =09=09bpf_prog_put(old_prog);
=20
@@ -69,11 +71,12 @@ static int igc_xdp_enable_pool(struct igc_adapter *adap=
ter,
 =09=09return -EINVAL;
=20
 =09frame_size =3D xsk_pool_get_rx_frame_size(pool);
-=09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
+=09if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2 +
+=09=09=09 ETH_FCS_LEN + IGC_TS_HDR_LEN) {
 =09=09/* When XDP is enabled, the driver doesn't support frames that
-=09=09 * span over multiple buffers. To avoid that, we check if xsk
-=09=09 * frame size is big enough to fit the max ethernet frame size
-=09=09 * + vlan double tagging.
+=09=09 * span multiple buffers. Check the maximum supported MTU, not
+=09=09 * current MTU, as it may change while the pool is bound. Account
+=09=09 * for double VLAN tags, FCS and inline RX timestamping.
 =09=09 */
 =09=09return -EOPNOTSUPP;
 =09}
--=20
2.56.GIT


