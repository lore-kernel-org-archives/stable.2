Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF63ECBDA
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794555; cv=none; b=n7iizjmlZIe5/20O9vgSc8Wb4kYy07K/kJS4Mg1WyHVJ60Ymw8BPSholSIBPaHN+rWU3IS/SroWtmw6vKZVXsbRw2tI6MeR7i4+z0kbYLdevnUJwMm9LBjZIFHbS6PrAtlNJpop3QJELxBakYNr0OIhVlR3YlQ2iD6x+BHo9mdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794555; c=relaxed/simple;
	bh=u9jzJTCuSR4v5CZ3TCwHDA26j82Y/8H6b8z/ylkoAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fi13yi8cU7QDeWUUq8DXkE/twCmAbxfxsQJQlQnvJOp73CH8WAaOSPGpXaZJzCHVPjsdDOTefQifihKrZkXuTi837iutvOxY7nN/LXNh/G9th/QwYBsYYPZ+23Dol4jtxvtTFS9Kg4p8yocbP+WRv9wg90AzqSnTmD3R+m6b5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=ESNZzhlj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="ESNZzhlj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4624a44e152so895714f8f.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781794548; x=1782399348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4SVpdsBcLaIGz1nZfhK4QzCtZCeVsaw2otrcfNi0wE=;
        b=ESNZzhlj1X+3hi2Sj2hUHQBcWaaCIbyzREOpg/zsU9thxqKT62MtmEOcAdm2TTX5zC
         Unw8SjULsAUMCb8mx7ZgAte1oltPiSphMWi+mAX6r101t8EGmtbgZG+RydHL1yENydtw
         pc1+VFw0NFy1EfaTo1Jb4foHW6VWWFnKyFxJnexVtDrQklDDTBuUDdZpEVPOOBkKZbkz
         o0Bwuo9uMhADW3tr47+Q7f4rfuU2d4b8WwqqVK+4l9X7oLiKKa7Obiq7iH4nYRToxSoe
         sqk1m9CzOTkpt777rU0yAFV42Mt7D7hdZcESE09raodXqtJeNWkDSq8yU0VuXPD2mJMt
         ungA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781794548; x=1782399348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4SVpdsBcLaIGz1nZfhK4QzCtZCeVsaw2otrcfNi0wE=;
        b=g8AjdO38YX+gMaZ7dCMapDoJZnJUV5gU4LcoKS8FBQFKTFqtVLv4UFtvx5dzWNBSg5
         NVDSNY7F2ypIoHtMVcwzqzOOt3fKETSTJLsUSw0WOT6ssX9K/ascP8+rLIg61vX7L5nr
         73DYR1JnUsmQMJBcNJLY32AUXn3ynM7LQw9o2+4aEHc6DS1GPqQWfdBgtAioCSHIQ0Oz
         /WqXftSG9Is5jqimH1J4kaAaoUgSCVl1RDv5APdxLwTLXHUu3/+ElIkmdxYxafUxJL7N
         Z6x207D6T3sVH8Mso9TVgZ0qEuPoCA/lSkZiWveI5HJ0qkB8FQTf4GNUZfJnZmccRawG
         taeA==
X-Forwarded-Encrypted: i=1; AFNElJ+eHKSd0zx0UAACOYzrdig8Ub+qnZXdTSwNfqr9q0g3Wwfxw66Qn1b45KzMQ4QRS8RGDdwqWPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RLxXz2MEZBzBKGPMHF7To4BDBRQxw1mqFhtRxh6oVwT+Fi/M
	PLxEM0SjgZSdG7PEfndLJ4ktDhOaR226Y6ny/ryF+1Cm8vLB8sIJJHFfs3pO9TDLdssi
X-Gm-Gg: AfdE7cm/4gcxfZosVhz7BCoA+qcXjqHUdNOO1C0aNjSuUEJXpPDRQVpGMMBBemZ0sO/
	UjudjnZjCb79c7+Rnd7JIOXsSRN77O6PCnW5+ie9M+bcmTRCy86KT2vPs7X0a6YUjMgm7MtBxP+
	XHHoAsdq/nnK/6qLviRTthiUbLM4Zu0O90c73WuQWoh03sUb2Hgixjy9hA8JgMvHH7D+l307fKw
	6YCb5g9zvzjwOcB7PC28A6pbV/1548DTtpSQWW7fjLldNk8VW30rz4FAwt00TLYf4M8nhlHmq/y
	m+yetEMfXdAl4ai9ixznv6pd5Z5B3BurDPczq41a3VQAMypESjEJd+le9pDJ9Ibgp8pg7U1dsIc
	v1pi5Sl4aFvqk7/lTKAG8ys8VKkXa5wUEf0FWfMWDnb/5qPLHHnnvR0hdNWVy/EtsfnuNPqJHOD
	iOycq+/qP+wN634SW7IIxF/vv4mZBAfNF3HglKSzTIwMQKIVU7h1+JydOpZuDduzxpVuyV1IspD
	XWAv5ZeY6ve4HPdIMxFZ53RZ6E2bshWygI=
X-Received: by 2002:adf:ef8d:0:b0:460:1f32:628d with SMTP id ffacd0b85a97d-4623683a4bdmr10901952f8f.11.1781794548276;
        Thu, 18 Jun 2026 07:55:48 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm63857002f8f.3.2026.06.18.07.55.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jun 2026 07:55:47 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: borisp@nvidia.com,
	raeds@nvidia.com,
	ehakim@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v3] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Thu, 18 Jun 2026 16:55:45 +0200
Message-ID: <20260618145545.53035-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an offloaded MACsec RX SC is deleted, macsec_del_rxsc_ctx() released
the per-SC metadata_dst with metadata_dst_free(), which calls kfree()
unconditionally and ignores the dst reference count. The RX datapath in
mlx5e_macsec_offload_handle_rx_skb() looks up the SC under rcu_read_lock()
via xa_load() and, while still holding only the RCU read lock, takes a
reference with dst_hold() and attaches the dst to the skb with
skb_dst_set().

A reader that has already obtained the rx_sc pointer can therefore race
with the delete path:

  CPU0 (del_rxsc)			CPU1 (rx datapath)
  --------------			------------------
					rcu_read_lock();
					rx_sc = xa_load(...)->rx_sc;
  xa_erase(...);
  metadata_dst_free(rx_sc->md_dst);	/* kfree(), ignores refcount */
					dst_hold(&rx_sc->md_dst->dst); /* UAF */
					skb_dst_set(skb, &rx_sc->md_dst->dst);

metadata_dst_free() frees the object even though the datapath still holds
(or is about to take) a reference, so the subsequent dst_hold() /
skb_dst_set() and the later skb free operate on freed memory.

Fix the owner side by dropping the reference with dst_release() instead of
freeing unconditionally. dst_release() only schedules the RCU-deferred
dst_destroy() once the reference count reaches zero, so a concurrent reader
that still holds a reference keeps the object alive.

Dropping the owner reference is not sufficient on its own: once the owner
reference is the last one, dst_release() drops the count to zero and the
destroy is merely RCU-deferred. A racing reader that runs plain dst_hold()
on that already-dead dst gets rcuref_get() == false but dst_hold() only
WARNs and attaches the dying dst to the skb anyway; the later skb free then
calls dst_release() on an object whose destroy is already scheduled, again
a use-after-free.

Convert the RX datapath to dst_hold_safe(), which returns false (without
warning) when the dst is already dead, and only attach it to the skb when a
reference was successfully taken. When the SC is being deleted the in-flight
packet simply proceeds without the offload metadata_dst: skb_metadata_dst()
returns NULL, the MACsec core sees !is_macsec_md_dst and skips this secy
(rx_uses_md_dst path), which is the correct behaviour for a packet whose SC
is going away.

While reworking the datapath lookup, also guard the two NULL dereferences
on the same path that an automated review (forwarded by Simon Horman)
flagged: xa_load() can return NULL when the fs_id has just been erased, and
mlx5e_macsec_add_rxsc() publishes sc_xarray_element via xa_alloc() before
rx_sc->md_dst is allocated, so a packet carrying a freshly recycled fs_id
can observe a non-NULL rx_sc whose md_dst is still NULL. Check both before
dereferencing.

Note: macsec_del_rxsc_ctx() also kfree()s rx_sc->sc_xarray_element without
an RCU grace period while the same datapath reads it under rcu_read_lock();
that is a separate pre-existing issue and is left to a follow-up patch.

Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3:
 - Also guard the RX-datapath NULL dereferences flagged by the automated
   review: NULL-check the xa_load() result and rx_sc->md_dst before use.
 - Note the unrelated non-RCU kfree(sc_xarray_element) in the delete path
   as a separate follow-up rather than folding it in here.
v2:
 - Convert the RX datapath dst_hold() to dst_hold_safe() so a reader racing
   the SC delete cannot attach a dst whose last reference was just dropped
   (per the automated review forwarded by Simon Horman).
v1: https://lore.kernel.org/netdev/20260615140534.52691-1-doruk@0sec.ai/

 .../net/ethernet/mellanox/mlx5/core/en_accel/macsec.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 71b3a05..fb2c64d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -829,7 +829,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
 	 */
 	list_del_rcu(&rx_sc->rx_sc_list_element);
 	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
-	metadata_dst_free(rx_sc->md_dst);
+	dst_release(&rx_sc->md_dst->dst);
 	kfree(rx_sc->sc_xarray_element);
 	kfree_rcu_mightsleep(rx_sc);
 }
@@ -1695,10 +1695,10 @@ void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
 
 	rcu_read_lock();
 	sc_xarray_element = xa_load(&macsec->sc_xarray, fs_id);
-	rx_sc = sc_xarray_element->rx_sc;
-	if (rx_sc) {
-		dst_hold(&rx_sc->md_dst->dst);
-		skb_dst_set(skb, &rx_sc->md_dst->dst);
+	rx_sc = sc_xarray_element ? sc_xarray_element->rx_sc : NULL;
+	if (rx_sc && rx_sc->md_dst) {
+		if (dst_hold_safe(&rx_sc->md_dst->dst))
+			skb_dst_set(skb, &rx_sc->md_dst->dst);
 	}
 
 	rcu_read_unlock();
-- 
2.53.0

