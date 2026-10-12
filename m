Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344F43BDBC;
	Mon, 12 Oct 2026 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790268; cv=none; b=PMUXFAXajFd+7BkUmy4CgAolQpq8NQcaBtRoVAfb0GroOrKPUtpDmnC7nWIc2XfMJUQyQ3e0TQYW6FmEvntCGKLUDOwn3xao7TJvYQH6RKKl9r5oxG/kdsvg6ZD6PoNKUvna0FjjbEAIr9wa+93Nc25ue3U1j/e1mTzyR3el5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790268; c=relaxed/simple;
	bh=9/2ubBB//6cAt/GDTJmu+OCmSh9t0gsGY0HZnpEQk7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MUrlJFr7VL7cOGn84U+0j0o/1pUozay/WEv39lrID4dC50V//wxflfJN6TZawa6tE7OCwJ+EH62GyhB2JsNFeRwi8padcEx7OezcwlSIP9D6tws61NnBttJP3JhcdJG/DU5sd+w2xZoz2xeHoyCmshvXY9SetBXpPfA75jUdmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dR/dBLA6; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dR/dBLA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Th
	7i9MmgPqf+eKL72J4AGfFVFML6R6BAitK93cMpub0=; b=dR/dBLA63a+lX0QBZA
	k7bqPIkoFdkezKQP/iVEW6h67BitazIAKcEr7ZxPbpzuyfrtL/xUkQCMOfx25XAS
	kbi9HlWDoys132+CAdkNkUc0ZylfajS077L+OUwgnirccyAMMc2Oe3Rf6OeszN3K
	TLozhq/dTMcuOlissHbSNglNg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3N_p4jMxqvoGeAw--.28607S2;
	Mon, 12 Oct 2026 15:30:02 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net] ice: wait for in-flight Rx polls before freeing a representor
Date: Mon, 12 Oct 2026 15:29:59 +0800
Message-Id: <20261012072959.254206-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N_p4jMxqvoGeAw--.28607S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw48Gr4Dur13Aw43JFWkWFg_yoW7ZF1xpF
	WUKFy5CrykJr40gw15Wa18uFyrCw45trWagryxKrWruwn8JFyrAF17KryY9FyrCa13uF1a
	vr15Z3yrA3s8X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpVb9UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBoP5WrMjHqmJAAA32

From: Linkui Xiao <xiaolinkui@kylinos.cn>

ice_eswitch_detach() unregisters the representor netdev, removes it from
the eswitch xarray and frees it:

	repr->ops.rem(repr);
	xa_erase(&pf->eswitch.reprs, repr->id);
	...
	ice_repr_destroy(repr);

The Rx path holds no reference to what it finds in that xarray. While
the uplink VSI has ICE_RX_FLAGS_MULTIDEV set, ice_process_skb_fields()
calls ice_eswitch_get_target(), which is a bare xa_load(), and then uses
the returned netdev in ice_repr_inc_rx_stats() and eth_type_trans().

unregister_netdev() does wait for RCU readers, but it runs before the
erase, so it does not cover the polls that pick the representor up after
it. Between xa_erase() and ice_repr_destroy() there is no grace period
at all: a poll that loaded the pointer just before the erase then reads
repr->stats through ice_netdev_to_repr() and the netdev itself after
free_percpu(), free_netdev() and kfree() have run.

That order is not new: commit e9942bfe4931 ("ice: Fix use after free
during unload with ports in bridge") moved unregister_netdev() ahead of
the erase so that the bridge can still find the representor by id while
its notifier chain runs, which also keeps the representor reachable for
longer. The missing grace period goes back to the lookup itself, so the
Fixes: tag below points at the commit that added it.

Take the missing grace period. The xarray entry is erased first so that
no further lookup can find the representor, then synchronize_net() waits
for the polls that already did before it is released and destroyed.
repr->ops.rem() has to stay ahead of the erase, because
ice_eswitch_br_port_deinit() looks the representor up by id while
unregister_netdev() runs its notifier chain.

Make the lookup side explicit as well and hold the RCU read lock around
the whole block in ice_process_skb_fields(), so that the netdev returned
by ice_eswitch_get_target() is covered by that synchronize_net() whatever
RCU flavour the kernel is built with.

ice_eswitch_detach() runs once per representor, so this adds one grace
period per representor to the teardown path. All of its callers are in
sleepable process context, so this is safe; batching the grace periods
would mean splitting the erase from the destroy, which is not done here.

The window is reachable in switchdev mode when traffic arrives on the
uplink VSI while a VF or SF representor is being torn down, for example
by removing VFs or by switching the eswitch back to legacy mode. It was
found by code inspection of that teardown path, it was not reproduced at
runtime and no stack trace was observed.

Fixes: 44ba608db509 ("ice: do switchdev slow-path Rx using PF VSI")
Cc: stable@vger.kernel.org
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 10 +++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 13 +++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index b069e6c514fb..465ed7957506 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -556,6 +556,13 @@ static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
 
 	xa_erase(&pf->eswitch.reprs, repr->id);
 
+	/* The Rx path looks the representor up by its id and dereferences the
+	 * result without holding a reference to it. Nothing can find it in the
+	 * xarray anymore, so wait for the polls that picked it up before the
+	 * erase to finish before the representor is torn down.
+	 */
+	synchronize_net();
+
 	if (xa_empty(&pf->eswitch.reprs))
 		ice_eswitch_disable_switchdev(pf);
 
@@ -614,7 +621,8 @@ void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
  * @rx_desc: descriptor used to get src_vsi value
  *
  * Get src_vsi value from descriptor and load correct representor. If it isn't
- * found return rx_ring->netdev.
+ * found return rx_ring->netdev. The caller must hold the RCU read lock, the
+ * returned netdev can go away as soon as the read-side section ends.
  */
 struct net_device *ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
 					  union ice_32b_rx_flex_desc *rx_desc)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..bbbf13b29cbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -223,8 +223,16 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 
 	/* modifies the skb - consumes the enet header */
 	if (unlikely(rx_ring->flags & ICE_RX_FLAGS_MULTIDEV)) {
-		struct net_device *netdev = ice_eswitch_get_target(rx_ring,
-								   rx_desc);
+		struct net_device *netdev;
+
+		/* ice_eswitch_get_target() looks the representor up in the
+		 * eswitch xarray without taking a reference to it, so hold the
+		 * RCU read lock while the netdev it returns is in use.
+		 * ice_eswitch_detach() waits for the section to end before it
+		 * frees the representor.
+		 */
+		rcu_read_lock();
+		netdev = ice_eswitch_get_target(rx_ring, rx_desc);
 
 		if (ice_is_port_repr_netdev(netdev))
 			ice_repr_inc_rx_stats(netdev, skb->len);
@@ -234,6 +242,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		 */
 		__skb_push(skb, ETH_HLEN);
 		skb->protocol = eth_type_trans(skb, netdev);
+		rcu_read_unlock();
 	}
 
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
-- 
2.25.1

