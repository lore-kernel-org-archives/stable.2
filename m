Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94B3DB64D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174844; cv=none; b=JB25QrOdgW5KJOL0YBa+bxSJP2lVoVfInbMJ/ZpsN9THY3pvmV+BeFwYUF+8/MmwWu1etxvUyhYNpV+40CbgApcCpj1C+z85Nv1lLVAu3fPH0vlqJR66ZuZsxJeSSjqxrKh+jUzIYYHoL1db0SHzliL0b0WOZmRawT1YIx5iWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174844; c=relaxed/simple;
	bh=6oLHWoiKE6PxbL40mPCFbnvkhnQ7KTpkUturhUz+hPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlnFRm25vdlYrYSIf7VEmRhhLsoYwj3lMTtskjc6nkegJlYkivLqtge/NLg/nX56zZtaNmxMqNy5o9aUhiqxZ2TviVVyaQ+Cx9WAP7Edi0TcSsBEw9txHz9wgXi60k1O/UGfrA15XQcvNK4twfbb8ooNqLy2uZh7yQfqQZHv0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3zeQyxe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3zeQyxe"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-855d2bfae95so3397681b3a.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788174842; x=1788779642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/7mL4yqWLEKqVvJuqvWtKvTVqgdZx0s+TSdJcgWJMQ=;
        b=M3zeQyxeJ1x/YJxQdUeZmf/JfrgaZB+HBLciaRosKYjjbT/9mOmcBbCS/WNW5JocKs
         9X8EjrVHKG3fQSGZ7rqF8sLh5NdpX5e4GolQfzp1FVOaexU77E01wVa5c8v4rU7q+p/O
         wwRNKWwJn2WCl32Qd/G84NOX59UOpoSL7fLrw8dvv6Na2jwdIL8MaWmARMjCO9KguqUJ
         47swK1WlAEnmWTTUrLOcHNYVhoz3qLxJSnlXgNFYyVJ5m58i1OsgRirEhb8Tu1fEvC0C
         XwVPczhqz+91zKKUSLOJRnHuzHG5Ge3m0sNMgrq2ay7vC0z+42cYaCtR2gpFmlTD6SCn
         9hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174842; x=1788779642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/7mL4yqWLEKqVvJuqvWtKvTVqgdZx0s+TSdJcgWJMQ=;
        b=OcjSU9CPAQ+cy8+3g37/YgfjVzWKvvrw9oaN90DfdaKzVlVNP6iRiDgsAlLDzQ9Tda
         ojvyrLuuYslmXIwpLXwNn4JeMPQJxKd0hSp8JGnUbygae7sONTvcAzOVHkxKFsxcDFUy
         01Qf3rfZL0l9hmYNQQkWtKUNcI7zvV/08SjSu6r5vgb0N0d1Egs88M/yLiH3/suwa3/F
         Wyf7tISEevlsU26zJkKZlXuwblIukL3f6wwg/SjHeNCYB0ZOAr4ftfpQB73YJsmSEfRo
         sfYKhPIVyQ8DQBt47/y1NeQnSD5BYAe/HsHMZHophaD8NjFmBSx8Xiv60yZKKhAfJLLX
         Bk9w==
X-Forwarded-Encrypted: i=1; AHgh+RrQGrhNwEUqE9wt/sSivCoo2QHA/XhMQ4osohvhErxvFPNfhL1kA41xQc28wnKzv0jk+UiffV8=@vger.kernel.org
X-Gm-Message-State: AFuF++kGoEo9MEExgveMGccPo8/Z3ZDt1sqVu8LK6975F6bJjfeFf9Gs
	PPhnD8Z6leZVebRhqmEL+6wjij6ZI2w+03wE0SNlYulbzdxAcE88LyX5
X-Gm-Gg: AR+sD10yoIvLVJ9M/u/iy5WNLxhRw7TgnFrvsgwZ8x7Eb9aEtaG8rmbO9+Ag51pdpkR
	ILV6FWP5Uc7MQ6aJdti1EUOR1Cyz9bf9mUKslT+A+tboOqETnmFJYDycTUMCpKatXXJQsSdG0RR
	k02vVFNfEcemn8TcJ6cCredLJda467gkpXA8DpyiypkrBn+VK8OoE7wjM4rE7uLv8PI20ma8XW0
	NEXFSp0L3wsfaqkimCDTMANNuToCcRgthjr3HRYRIxpaxVMXGw+YVlLklXFJPv7Hazs1bXfyzUo
	ZW52Zu5Ay50nIEZqzxbj/yERkphuhNm3q2JxxOrSdeFOEunzxxWsVSfgpA77l5MSndPwrRwyQiW
	DHjAriA1x3FH06mKAkFV8n/j7g/g4tr/E4E/n9jyPTx5BEU56zhebTJ0JThwb/dwA/Uvl3nREtQ
	6TZ3CD9aQrnS2RJwdRLhQH/potdiHrSJVQQaJVPnDbzSF22QmkBZJgMuGsKJMYLhsLqNYbtPc3r
	Q==
X-Received: by 2002:a05:6a21:3216:b0:3d3:aed2:6f27 with SMTP id adf61e73a8af0-3d5da1aa7bamr6686426637.27.1788174842238;
        Mon, 31 Aug 2026 04:14:02 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36aeb7esm4133282a12.15.2026.08.31.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:14:01 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>
Subject: [PATCH net v3] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Mon, 31 Aug 2026 19:13:04 +0800
Message-ID: <20260831111330.199543-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__br_multicast_disable_port_ctx() and br_multicast_del_port() walk
port->mglist with hlist_for_each_entry_safe(). However,
br_multicast_find_del_pg() can also delete other entries from the same
list through br_multicast_fwd_src_remove() or __fwd_del_star_excl().

If such an entry is the iterator's saved next node, hlist_del_init()
clears its ->next and terminates the walk early. The reproducer triggers
this in both teardown walks, leaving port groups in the bridge mdb with
a dangling ->key.port after del_nbp() frees the port:

  BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
   __mdb_fill_info+0x1191/0x1320
   br_mdb_dump+0x594/0xe40
   rtnl_mdb_dump+0x1cf/0x5d0

Use hlist_del_init_rcu() to unlink the group while preserving ->next.
br_multicast_del_pg() and the teardown walks run under
br->multicast_lock. The GC worker must acquire the same lock before
detaching the group for destruction, so the node remains alive while
the walk uses the preserved pointer.

Preserving ->next means a walk can now reach a group that an earlier
iteration already deleted as a side effect. That group is off mp->ports,
so br_multicast_find_del_pg() would fall through its port scan and hit
the trailing WARN_ON(1). Skip such groups at the top of that helper: a
port group is put on port->mglist when it is created and only unlinked
when it is deleted, so hlist_unhashed() identifies exactly this case.

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v3: skip already-unlinked groups at the top of br_multicast_find_del_pg()
    instead of in each teardown walk, per Nikolay's suggestion, so the
    preserved ->next no longer leads to the trailing WARN_ON(1).

v2: https://lore.kernel.org/netdev/20260826014200.362304-1-littleddfu@gmail.com/
    Use hlist_del_init_rcu() to preserve ->next, as suggested by Nikolay,
    instead of restarting the walks.

v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/

 net/bridge/br_multicast.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..ea0a50eb8b77 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -808,7 +808,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	struct hlist_node *tmp;
 
 	rcu_assign_pointer(*pp, pg->next);
-	hlist_del_init(&pg->mglist);
+	/* Keep ->next (held under multicast_lock, freed later by the GC work):
+	 * a port->mglist teardown walk may have latched this node as its next,
+	 * and deleting other groups of the same port must not truncate it.
+	 */
+	hlist_del_init_rcu(&pg->mglist);
 	br_multicast_eht_clean_sets(pg);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent, false);
@@ -835,6 +839,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 
+	/* A teardown walk over port->mglist can reach a group that an earlier
+	 * iteration already deleted as a side effect. It is off mp->ports by
+	 * now, so skip it instead of falling through to the WARN_ON() below.
+	 */
+	if (hlist_unhashed(&pg->mglist))
+		return;
+
 	mp = br_mdb_ip_get(br, &pg->key.addr);
 	if (WARN_ON(!mp))
 		return;
-- 
2.43.7

