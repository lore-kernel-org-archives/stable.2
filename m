Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BD3D8909
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690764; cv=none; b=B70urecDXtDhQlry/u7QrQb/jz73pFcj/SxNH9q16NdKntiRT1jlMAGiZdwc2XHtKl4M6De5CJrHObGQfiGgL6rK0LlWwn35v6UuHB663U9eY5zApaqm2tqTD4/cEAS0kvUSGZWiHlr7WmpC55xzaxAuro1fJpVPqHNPlB+bIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690764; c=relaxed/simple;
	bh=+lUniz+q8lUs9BYGcRRkAl9bdd2QYzCYyRz+e0Nv9cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tT7jb9biu1nG1uCe9hzUD0vyrWG+UYATnfvvLaz6KNh0XB2044aMDtoErrMMWRBWdr6jR5M4h8j1LqPKaEU4fZ0EGJ9JMprI7+qk6qoNnaaSyO4Z0e0mA+wEDo92oqb+HFU9m379+hOa4syhzPkuIQyzwKD3X+Es58GEvdU/A80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=KLGHlWWI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="KLGHlWWI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso7390845e9.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781690761; x=1782295561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUCt6L8NGGOm3y2JBJxNOs5/dk/YzppXFeUdkifdqiU=;
        b=KLGHlWWIQWV95gRGvYrlg8zMuKKgIvOP+3By4nnVx1YX+fVHJ8QQffgBV4ciqjmmyd
         L1tscgyFu5SU9qqpxN7FikREOjy5cIIQvKLggUoLSxK5xdKvO2E44Uitvor6nSHnaXw5
         n4sbCnw+8OWpwJtSI3wVs8pjrMgN7PW2xIiIktnsAVoBwMY9/7Gr4Bwd3NRL1vpVtrLt
         VAaSKz+t5AcrJ2yICYjx96c8LCWjrxS7a/LzQGkwq97Z1W82wDHIl5Fm7+kPE1Q5JcVx
         JjLuQVhYdZasdESO+aCLKFiO648xfECbjYiTcHV6zUisBV9oMNtp2o7lRYvgWP8419lL
         dWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690761; x=1782295561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUCt6L8NGGOm3y2JBJxNOs5/dk/YzppXFeUdkifdqiU=;
        b=c4r8flRKOvkezA67c99XxB1W5u70Dip/Ogk7FQdA+He6j2Vwe0deq2f+NKuU1cojsL
         sSTG+KQNfKloVYKm804cHje9Vj9Cdb9nO8Rg1cqzK78/bxuH/a3rBvNB826cAx/ocDjB
         /v1CxjXt/5RqFgPxVqwadWDkuRtXsVtiUTvyilC0jNQxBUN0dzF3qp4cEBCd1stmjFox
         MuSHKspSL22NH9h2h7Vj7lBtO0qo+stzjJOmjwG2lIaMvI0vgQ9MrFjjvlzJp5uj/Ltq
         Kc+JKL/Op8Id5u+88ym6Gv5DyVtVy+Q9PfCNEjLk/mxd+P4pFU/K8gsyzAuVU6pbB7Nv
         FhAg==
X-Forwarded-Encrypted: i=1; AFNElJ/zj5s9rYoSi98b4OmGr+t/EaK78047vu/z4QTG+CSgW3WC93dZC4K1Ro11U5oBx6Mr9ZNFpOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeN+F7mCDHBTeC/iLYLa0joWh0o0m3ZSzHY/0tc+MnWPa4RLy9
	Ck+SSQqkw50E2OKlMhyzuhPIwzaQElvWMWsB851UHgJAQlNupeiAYn3liIOmkD339o+k
X-Gm-Gg: Acq92OGZfKfugh3XJDtB+jeWkxgf+qzrO53YUSLYNLxrJCwe5bxisgHMvGPyxPflvVN
	QDq7HHclw9BV16hf5s5mc8ZfAHxK2yMV37W+np3gP/9gf0f/28TDoXpqZzT4uYRtJUeSkdP5Xti
	etMvMRT3xUrzuhVamlAuRthT8lkIkrN4i4ojZa2RVccDUAhfpt2YLBifsCX+Mz9gyvVIPyW8EXM
	8XFsS/+0bGXuB7Vwg/tv9mGFA4zDGGYA3Sa01ayBrFtuNH5mJIyoXQCo09nmBfQarXBLNEbHmN5
	ML2Eoz60sB8Fg60bMrrVagn4q1CKu11xNrxYQz7ym0+4wsuDomou1mLYsfPNmG9BWRNlZNQ8XRP
	KKg3ZbRsyLmHSm7+wjL/b5+tZodNwmL7fwBXgGUGOX0PZ1vzTaaC+lImneQvX6N76Gfvc5mKTpx
	1tdP9HhnV+BFiSFNOsChWteZ258FZY5itfMrZTdV49vLmFTnwAxSPD133GdQfQ9L42nF2uoh3L9
	2CDsWHnVnQHlNWrQ/qqnGQmCcJLIm1gR2Y=
X-Received: by 2002:a05:600c:a45:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-492340f6f3emr34524455e9.16.1781690761127;
        Wed, 17 Jun 2026 03:06:01 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4fd31sm142422875e9.4.2026.06.17.03.05.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jun 2026 03:06:00 -0700 (PDT)
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
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Wed, 17 Jun 2026 12:05:58 +0200
Message-ID: <20260617100558.83654-1-doruk@0sec.ai>
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

  CPU0 (del_rxsc)                 CPU1 (rx datapath)
  --------------                  ------------------
                                  rcu_read_lock();
                                  rx_sc = xa_load(...)->rx_sc;
  xa_erase(...);
  metadata_dst_free(rx_sc->md_dst); /* kfree(), ignores refcount */
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
calls dst_release() on an object whose destroy is already
scheduled, again a use-after-free.

Convert the RX datapath to dst_hold_safe(), which returns false
(without warning) when the dst is already dead, and only attach it to
the skb when a reference was successfully taken. When the SC is being
deleted the in-flight packet simply proceeds without the offload
metadata_dst: skb_metadata_dst() returns NULL, the MACsec core sees
!is_macsec_md_dst and skips this secy (rx_uses_md_dst path), which is
the correct behaviour for a packet whose SC is going away.

Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: also convert the RX datapath dst_hold() to dst_hold_safe() so a reader
    racing the SC delete cannot attach a dst whose last reference was just
    dropped (per the automated review forwarded by Simon Horman).

v1: https://lore.kernel.org/netdev/20260615140534.52691-1-doruk@0sec.ai/

 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 71b3a059c964..e5d9a14c92b8 100644
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
@@ -1697,8 +1697,8 @@ void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
 	sc_xarray_element = xa_load(&macsec->sc_xarray, fs_id);
 	rx_sc = sc_xarray_element->rx_sc;
 	if (rx_sc) {
-		dst_hold(&rx_sc->md_dst->dst);
-		skb_dst_set(skb, &rx_sc->md_dst->dst);
+		if (dst_hold_safe(&rx_sc->md_dst->dst))
+			skb_dst_set(skb, &rx_sc->md_dst->dst);
 	}
 
 	rcu_read_unlock();
-- 
2.43.0

