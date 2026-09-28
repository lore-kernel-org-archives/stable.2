Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958C4E50D3
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611976; cv=none; b=pNf/Vw81UiHAn541NvuEr6SPmoGOlIEyQj9KAUnVjLdl4JV94BquYv/z2QoRTVDzFVBJu7QuMxRwFHnbipWXW1Ue2v2QF2nRfBtzlD0HEdi/RtUNdMLTRjidG2Q2kFu6KRlvPI5CMtTfQj6OjtW69E7FZwEPXY0UwsajTaNR6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611976; c=relaxed/simple;
	bh=KaxVleG2xvb+iM6Y+sUsGh7CsQpmseIgZYDZLVCGv1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ss80ORYHAKml+hgyEXtOsDrk70NhdltpLEnv4kv9W8lC3Tu7VOC6XQ9FlVFD0AQnr/j6vLVH9muffvpvKrLcVj3u5bgbAAQJE8s4Vj37+nBIG0vhEIhbbosl5z0PvVhJhqxsmxJ3AIIE4XWeS6E8WsyAbNpX4AVLGO/VkD30hP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO+WZkHk; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO+WZkHk"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e79c06622so315447eec.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790611974; x=1791216774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7Wh0reNQfY7p+WKwJYoOecjSrYMbPXpmuKcjKjItu4=;
        b=cO+WZkHkZZjt8kPxxRDGbWLv5GdGs0BGA2xUDqgQPF+ghUqj6Cp0rihVLS1zVjVXcu
         Luqicjxr/z1jQgSs8UMIEqF3BR19Kn9FIr0e55PzGKg5u1JZiJMKFsp4UPbvUEKmzFPa
         AyCFrY1ftav02OXOuMECEWXIHmmMo0tFctn6FWYOINI9kB6V/ECux7lKONgSQh/B/U60
         BPdIqqT+xbMezLZ9E24ojxHcUrJ/S9bbn7NmUAUUuGHiH+XVrOLOETbSoOUssYfPOnVd
         gJB5ZxpHFOOFJD1+eik4XwY4jvmyZtfrBmh5o6cOy+ZWGSl08plpZZpFahsvn9quwuwZ
         BPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611974; x=1791216774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7Wh0reNQfY7p+WKwJYoOecjSrYMbPXpmuKcjKjItu4=;
        b=178kI6W61SPE9F2lSnLD2kfLA8FVdJG7TIvTRWVeWPwGeApTf7EdLrlNqVVnk5lwaL
         cjZdm+MZVrx3FBf33Fl7+mQRVEvmWh+N8mwnWFjBXRNV6dodnyofRFfsRjip+SVLRVu+
         /1efRzIDZCdbPYgtxBmaVPHF1w3evSlA+6UkdydzjhVkY//ux9VPj5l2AQJVqJlwTA30
         h3Y7n0jOtxIUS9+WiCyqRHNBdi95YZYE9kSer9Mwpl3mlfK8lCI4xQceElQsUo3zXl34
         PBiYnx50WWYMbZON94WZI6Ki9WLCyqnvLRPvnMT8IhfT1/5S7Cohvt1aezR6P9PFv4s0
         vTHg==
X-Forwarded-Encrypted: i=1; AKwUvBx8L1WkQpMnD1UbwuTEn4iHIrByxr5Yc9LQx8kOod/9IVpw9LKmXmigRs+8ERp6QaaJG1I6AH4=@vger.kernel.org
X-Gm-Message-State: AFq9FYImhmtoXzDBpwrDn0IYbyn/EBvsABt+WGC9u2nz016wQcLkAWuQ
	oEjvCNDCzOWglQAS2OrAzlKhzp1f1X2QYzHdDPwlfODNW6+1ksNijBKH
X-Gm-Gg: AYBFou0QQXCnRJJ8sZN9Hc2RDMGdkrvHFasb05p4Ti3Mf1/jqkNve7Bd0FupqvdFjj8
	9B6lHazBntsk+0W5XMUzrnV6IaQuMdqvkK7pN/Z4apl/AJXIuVTA2y5O+gB3cXIa16rHdGNr4I8
	3HMlni8/MRsBTD5DgF3q7b1u36D0crI+hT8upY3pBqQnqrQDtm7he/8aj73Btntw9dvTqoA32YN
	idV8UuIGNJH/n+hcI0G8b6SGTg30ACzcQBPyh344uzi0hKie1ql/jfPkuW5ZNFrXqAt+0dLvqtR
	ucTWfrm1euy4bT2bQhel16KAmmHDs5n/MY4m0Bemy0mUf9+g2NwPuL6LQFo7kOaXvFfWkwvPdAX
	FhtUMlZLLIOaPM0uPHOjBRF/KJn/PRFdOlUzQc21EWxuNYiEuOM2eTfzOMljKa+Ebf05OtjDze7
	imrsOYl6kvCy8aEce7PsJ6zKarFy2EYagGUSQYloBe1uEme8fi7BUSu6lNXMuQmlUrNFCeSsdZ6
	eFkVDzBqgXonjNZrpmJGeHllezko1U5eZhAjAjOWY3zHZ0q6oLNwHK0s2X12tCCEBghuw==
X-Received: by 2002:a05:7300:f64b:b0:33e:4e49:d08d with SMTP id 5a478bee46e88-34272b4bc81mr16112119eec.1.1790611974003;
        Mon, 28 Sep 2026 09:12:54 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a49febsm31252256eec.2.2026.09.28.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:12:53 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	GhantaKrishnamurthy MohanKrishna <mohan.krishna.ghanta.krishnamurthy@ericsson.com>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tipc: hold a reference to nodes found by link name
Date: Tue, 29 Sep 2026 00:12:46 +0800
Message-ID: <20260928161246.1895273-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_node_find_by_name() returns a node after dropping its RCU read lock
without taking a reference.  The LINK_SET, LINK_GET and LINK_RESET_STATS
handlers then lock and access the node, racing with timer-driven cleanup of
a down peer.  Generic netlink serialization does not exclude the node
timer.

The following interleaving can leave a handler using a freed node:

  CPU 0: find the node under RCU and release the node read lock
  CPU 1: tipc_node_timeout() clears the links and unlinks the down node
  CPU 1: drop the list and timer references, queuing tipc_node_free()
  CPU 0: leave the RCU read-side critical section
  CPU 1: complete the grace period and free the node
  CPU 0: acquire the node lock through the stale pointer

LINK_SET also uses the node's media address after releasing the node lock,
when passing queued packets to tipc_bearer_xmit().

KASAN on v7.3-rc5 reported:

  BUG: KASAN: slab-use-after-free in _raw_read_lock_bh
  Write of size 4 at addr ffff88807e06f008 by task poc/92
  Call Trace:
   _raw_read_lock_bh                 kernel/locking/spinlock.c:287
   tipc_nl_node_set_link             net/tipc/node.c:2475
   genl_family_rcv_msg_doit          net/netlink/genetlink.c:1114
   genl_rcv_msg                      net/netlink/genetlink.c:1209
   netlink_rcv_skb                   net/netlink/af_netlink.c:2575

  Allocated by task 0:
   tipc_node_create                  net/tipc/node.c:539
   tipc_node_check_dest              net/tipc/node.c:1196
   tipc_disc_rcv                     net/tipc/discover.c:252

  Freed by task 92:
   kfree                             mm/slub.c:6801
   rcu_core                          kernel/rcu/tree.c:2919

  Last potentially related work creation:
   __call_rcu_common.constprop.0     kernel/rcu/tree.c:3181
   tipc_node_timeout                 net/tipc/node.c:814

Acquire a reference to the selected node with kref_get_unless_zero() before
leaving RCU, returning NULL if the node has already been released.  Release
that reference on every caller exit after the last node access, including
transmission in LINK_SET.  Keep the existing link lookup order and locking
so concurrent link removal still takes the existing error paths.

Fixes: 6a939f365bdb ("tipc: Auto removal of peer down node instance")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Take the node reference inside the matching-node block, as suggested by
  Tung Quang Nguyen.
- Reproduce the UAF on v7.3-rc5 and include a decoded KASAN trace.

Link: https://lore.kernel.org/r/20260927064036.3691962-1-nicoyip.dev@gmail.com/ [v1]

 net/tipc/node.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index bd91378b7540..d7cbfa786c13 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2421,8 +2421,11 @@ static struct tipc_node *tipc_node_find_by_name(struct net *net,
 			}
 		}
 		tipc_node_read_unlock(n);
-		if (found_node)
+		if (found_node) {
+			if (!kref_get_unless_zero(&found_node->kref))
+				found_node = NULL;
 			break;
+		}
 	}
 	rcu_read_unlock();
 
@@ -2507,6 +2510,7 @@ int tipc_nl_node_set_link(struct sk_buff *skb, struct genl_info *info)
 	tipc_node_read_unlock(node);
 	tipc_bearer_xmit(net, bearer_id, &xmitq, &node->links[bearer_id].maddr,
 			 NULL);
+	tipc_node_put(node);
 	return res;
 }
 
@@ -2558,12 +2562,14 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
 		link = node->links[bearer_id].link;
 		if (!link) {
 			tipc_node_read_unlock(node);
+			tipc_node_put(node);
 			err = -EINVAL;
 			goto err_free;
 		}
 
 		err = __tipc_nl_add_link(net, &msg, link, 0);
 		tipc_node_read_unlock(node);
+		tipc_node_put(node);
 		if (err)
 			goto err_free;
 	}
@@ -2634,11 +2640,13 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
 	if (!link) {
 		spin_unlock_bh(&le->lock);
 		tipc_node_read_unlock(node);
+		tipc_node_put(node);
 		return -EINVAL;
 	}
 	tipc_link_reset_stats(link);
 	spin_unlock_bh(&le->lock);
 	tipc_node_read_unlock(node);
+	tipc_node_put(node);
 	return 0;
 }
 
-- 
2.43.0
