Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE6279907
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708569; cv=none; b=qdGiLVfn/1zXHKdH3jS0r0gePBji4dzso4wSqzjWs1rbTM9ZvlVJsXHc61MnkP9CS3GSMU7Q/HyR0UZcfHchBeTEogtnsIbsfj6/1Tc5/sYk57XmW0E33nOQJNOmFKhwbfeeooVQELVQdp4WcmBgvaaVsIzg6Rpw6rLcGIpwQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708569; c=relaxed/simple;
	bh=xkHYSMpPHPn5UAznXrMTLNZUM0GY8dMnzzBw3PK9Ecw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JiVg9D/yaFugFOWky58etubGt5LOAsxHZgakfPzlHcFmMv+ctNGQDv3auJLBmULWided5WgQeYP7Ff7uboNn4JwEQ6gJ83+T9D4NXpb+ucbPGLLoBW3uQMPqTjgQTfds3dnJMnW7g620NWCyfUf3Ikg6cxI60c1D4th2vYuyh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9HoidBc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9HoidBc"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc891373e0so6254975ad.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787708566; x=1788313366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uX7w3zYS1582cLpnHIAGQCV970wUYP+EwxQlHWpL6X4=;
        b=B9HoidBcZfe0MNEqv7cPNTqvIn2B9ESx4YCTXc7sA/nCA3hQAb4DZ2oStAr7BbfnWo
         4Uvsye6HVBhZxqSZEA51IRGDDeBJUt6rfo8qioljVPGUt2knqgya5Jk1t89WkDcfIy9q
         ofI3QlaByJiUx3PKNhaKfp14dqxzBjVRfM2dSSzP3CSEfuzpTqFTWz0MUyYx/iUHsIpT
         53mxZjPWO5T6/X5pB60hgD9sdTk69yYp72TwWyOJ8CfLQYGMCBUufM55/Um18aNGUHsr
         avaI3LKTZ5DB4AcC+LQHA2U3svJh+Mu0/04k1RfO2GGnoYGnuJeAfo1qepqSbitFf2mP
         pE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787708566; x=1788313366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uX7w3zYS1582cLpnHIAGQCV970wUYP+EwxQlHWpL6X4=;
        b=frEa9dLY79BwmSmXpLQW4naX4AAvBIaNqo1j0JzS7fZrBGdpSBM1oqJgRplkh29/Cx
         oBDZEnLBSBg7xoK0avy5kjI/trL0AmwFkeKycBbUjHraq9s/vpuzyQmODDWlHeeK019F
         BI0oRi30vIQOincgTZo6K4kt60AEBDXyds3KUCBPqgXoqa6xIsxXXd9BIgZcb57NSwqu
         Lh1hzw+/pdemc5ZX7xMoRyMnak7gvB+baHKoiPwb/E33+/MXC/QEpVvfabILqc1y73ov
         9n7hXqcNT+xv47nCBo5cH2GnsG+PHbblzuSEVTG9nGOyqDpB1mbBCPlPXMCxsy4j0KC6
         oiEw==
X-Forwarded-Encrypted: i=1; AHgh+RoaLMnABgCvl/h2wEfWuxOg2zFo3syTxQky8i9z+SddVX32Vf0j3I0w7oPpLzzv6QB0DXUoky4=@vger.kernel.org
X-Gm-Message-State: AFuF++mxwbUng0Wp8OjejpDX364rRES028rlEsAMqfVHqTMOySv69OiH
	vOmoHwOnRMlKqlah1hb6LTXD1WHWaR21wqT+wMmQlbr98kFv2foJTMKR
X-Gm-Gg: AR+sD10dJpEM7pCz6A9ZDCFfuhCQpHKxLawEYnC/MQEpELzHFt85IX7DptHamtPg6T/
	/BjzMumQQ05v4xCPdCBlE8WP+y28Hf6exNBRGH/tOvRmQMIgCScdNRU6p1Vuy9Y8V6kGMyMM0wH
	dO8qPJz/2TBPwvOyNzo6Ve59Kv5pjy3riMFjC+nxkeYz2niyZrgpqK3kLLdrduUicbhRVF/ne7S
	Y+PasQxogmHNXtJXtu0llw/qx9QwR9iwxUCPutu+WxaACT7oQKe1j8XJdjl72pLGz1ePi9w1ZQ+
	DVP70hZJsuMVmsu/fuvVgLyZgC4CRKjc98YRvFHq4qOYy8Bt+N393aJaw3ezRpQpo/v1bRMcT03
	fAE9u1o/aHieqfmrDgKVfMSP72vbrh8XkiSNGKQHN9+S6Enx+mmC+nMybQhOQ6suueB67Oaag9D
	fbd6GrLkmdwqtPyhUFHUqczKZegoGJUsA0ZcAzIp9F2ro3rvCcI46271QszLKC+w==
X-Received: by 2002:a17:903:2c03:b0:2d6:ee6b:1b08 with SMTP id d9443c01a7336-2d707a2f363mr42050785ad.3.1787708565680;
        Tue, 25 Aug 2026 18:42:45 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7049aac32sm2943735ad.33.2026.08.25.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:42:45 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
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
Subject: [PATCH net v2] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Wed, 26 Aug 2026 09:41:44 +0800
Message-ID: <20260826014200.362304-1-littleddfu@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

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

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v2: delete with hlist_del_init_rcu() to preserve ->next for an in-progress
    teardown walk, per Nikolay's suggestion, instead of restarting the walks.
    Tested on 7.2-rc7 with KASAN: the original use-after-free is no longer
    reported.

v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/

 net/bridge/br_multicast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..8022c7f12169 100644
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
-- 
2.43.7

