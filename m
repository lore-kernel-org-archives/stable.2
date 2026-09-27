Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89608383C6E
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790491247; cv=none; b=jMRBGVbj93T4WNx1eZbvaBMru4YjzRKFVB5JY8BTHdm6RLT0w6UMjsAwSuPd0hRIoC+gkkhvyfdZkAYXAr79ZggeGElZ9KlIKDvIsGUn4moEpwyQlKr072czESh4pmDH+2+36ImxbCPtXElZoRbpONcFWaCcxDU0kj7uhKHmdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790491247; c=relaxed/simple;
	bh=Bc7rp4L028Tl9EXyqCmfTpsUXQ/jC2GtMhU6BV2AJx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnKLsYOBmVYUf5sE2aq9PqLOQOSLGs1ac8LgQmfqGcfqs0+f2OGK3AxQ/c/sEwZKbhu/Z+WXz7Pi4N/mNga1EZRpQktdDgFTG1qfhf4s/Ngxc2YESEXykbvJ6nFzqgzLBghG43UDki+SL+VvKRwhmY2Xot7D1uFUsYxG1V8U+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9jtlfch; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9jtlfch"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-34251480737so107701eec.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 23:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790491245; x=1791096045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wSDCh9Q3eDQkB1vLD3xC3Yg4S14N+M5xHShZ9jLMyTA=;
        b=P9jtlfchoHij9jns25gXzP5CPKFFVGqISsk6J8BiucI6ZDqnWGy9LM6+pbqQjnSwdp
         hsGc3ybZspU/BvEW/Tt7+NS2s+jkOxSbXiyCTEScvpSbuUvnv6gLcxJe6Am1nGJy/erE
         9bJdNRUNFLzF52m/ssSOc5jzrRaOl+GGsz9+X/5idanEWlSPQVPDzrYMzAKZn4uO7+Je
         56uSwyGZK+3z9zUi/KIwOVkA/PWsm+Z01W0soSx15RpTHPkhBJj2wbv8Vk1Q0eDfnDAg
         BjyY9y4bvp/IHeOM46GiEUIwtjsrFUuVKe61g3S8W4wBVPq3tYWVXodP/v/pazOyEjpC
         1khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790491245; x=1791096045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wSDCh9Q3eDQkB1vLD3xC3Yg4S14N+M5xHShZ9jLMyTA=;
        b=FodPawTw7EggvORfsCgkK4kGWL91IJhtuD9yZw9BV5PU3DB2l2fbURSp2F9ZLjJxKP
         If7yBcmlyxwh0MR+0H1eZiPOFex9BzHE9j5O2iDbSgzrhgyZRwB8akFjeyjimUs9K/Of
         FRlOGtdmBGv5cswq2myKS92FcJb50mkUroIm7WHMksDudJMUMN7kXd4Xxf07JmNR35PT
         hQtT1zLMEjqLNYwXhntmu3Q8VO7VF+KXS1CiAbw/oGcCD5jJ5gutIF4qncbla+vZJ94M
         3dLveQpFC41+2IRBnbk5oix4bzN5vh/TrpcyUsW1EqoWEtH87yivA9JmwxFhX7cWZSm+
         UCYw==
X-Forwarded-Encrypted: i=1; AKwUvBxYOhA7bp/jvenW/DoLNcGz00h2mirJnGMkqLHS0RFo6y+eg//mzlYxTZmVm6oVywv7eWPbFXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxeDM5A48HFJrNxA4UcBwDhSEWtltHc+sF9+sszkUypZ1TFGeR
	bJd/EXjOdUe577YDQFujFSiIxjQeJpI5WbYcMNTiBxyuvFcEXbS5llRh
X-Gm-Gg: AYBFou1t3hFGlC6deLtRWVeDi0NLJJGpD7/epzO3+N6BCOGzLdc2+0aEDP6JqmNNocG
	Fq/RwlM08dZzm3HZuwydaXof+Lhq2a/XzwDqSPZGbwGvVf4UXQH39qFNkARQFlI/3zeE9mUV/11
	qAuKCS+8RCK+TSEcxSOMjOBVk8juHWLOdLTyLUK1DH00LmBQImlV9w4zSkhuGj32kRODoDf8kHP
	YLPZNu0TfkfyjjnE/nr3AlYqU1NGPRKUF/M0x6zn6trnGQ2hSRqAufdL8g9nH7SjNbOEe0MlkuJ
	yg1QrLCu6Mq/FKhw6VAewrmdwV/fDYYLNUC4TNL4My5dc3uM5t+hUrszpi3A/bwX5+82MdD56a4
	sgS3/Gv6uxOoCKzd8EVsYAcP1dKPKeCmg+/2JyyiIvbdQL5VDBYruDuKVu1rQQBuAmQ0n8YwO/P
	d5QvB0o7g4EruQ/d/A7qN447lBG2l7+bs1GSROhXt/TmmAof5g7ycK2OdAM+EEctEMZUXZkYYy6
	amvsQSFcVQrzG2lsw0raetW8fyKdNPRoPOfMOZABwY6LaDTz3G5GMIzLUXIIcDhD41tGH9gIgOh
	twSU
X-Received: by 2002:a05:7301:4d08:b0:343:fdea:9a0 with SMTP id 5a478bee46e88-343fdea25bemr3651955eec.2.1790491243693;
        Sat, 26 Sep 2026 23:40:43 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414504fae2sm19985283eec.20.2026.09.26.23.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:40:43 -0700 (PDT)
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
Subject: [PATCH net] tipc: hold a reference to nodes found by link name
Date: Sun, 27 Sep 2026 14:40:36 +0800
Message-ID: <20260927064036.3691962-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_node_find_by_name() returns a node after dropping its RCU read lock
without taking a reference. The LINK_SET, LINK_GET and LINK_RESET_STATS
handlers then lock and access the node, racing with timer-driven cleanup
of a down peer. Generic netlink serialization does not exclude the node
timer.

The following interleaving can leave a handler using a freed node:

  CPU 0: find the node under RCU and release the node read lock
  CPU 1: tipc_node_timeout() clears the links and unlinks the down node
  CPU 1: drop the list and timer references, queuing tipc_node_free()
  CPU 0: leave the RCU read-side critical section
  CPU 1: complete the grace period and free the node
  CPU 0: acquire the node lock through the stale pointer

LINK_SET also uses the node's media address after releasing the node
lock, when passing queued packets to tipc_bearer_xmit().

KASAN reported:

  BUG: KASAN: slab-use-after-free in _raw_read_lock_bh+0x1d/0x40
  Write of size 4 at addr ffff888112723808 by task poc/87
  Call Trace:
   _raw_read_lock_bh+0x1d/0x40
   tipc_nl_node_set_link+0x30e/0x680
   genl_family_rcv_msg_doit+0x1e0/0x2c0
   genl_rcv_msg+0x419/0x6d0
   netlink_rcv_skb+0x11f/0x350
  Allocated by task 28:
   tipc_node_create+0x9c1/0x1fa0
   tipc_node_check_dest+0x121/0x11e0
   tipc_disc_rcv+0xdbf/0x1430
  Freed by task 87:
   kfree+0x149/0x330
   rcu_core+0x50a/0x1850
  Last potentially related work creation:
   __call_rcu_common.constprop.0+0x71/0xa10
   tipc_node_timeout+0xb1b/0xe70

Acquire a reference to the selected node with kref_get_unless_zero()
before leaving RCU, returning NULL if the node has already been released.
Release that reference on every caller exit after the last node access,
including transmission in LINK_SET. Keep the existing link lookup order
and locking so concurrent link removal still takes the existing error
paths.

Fixes: 6a939f365bdb ("tipc: Auto removal of peer down node instance")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/tipc/node.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index bd91378b7540..2726bee3bb40 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2424,6 +2424,8 @@ static struct tipc_node *tipc_node_find_by_name(struct net *net,
 		if (found_node)
 			break;
 	}
+	if (found_node && !kref_get_unless_zero(&found_node->kref))
+		found_node = NULL;
 	rcu_read_unlock();
 
 	return found_node;
@@ -2507,6 +2509,7 @@ int tipc_nl_node_set_link(struct sk_buff *skb, struct genl_info *info)
 	tipc_node_read_unlock(node);
 	tipc_bearer_xmit(net, bearer_id, &xmitq, &node->links[bearer_id].maddr,
 			 NULL);
+	tipc_node_put(node);
 	return res;
 }
 
@@ -2558,12 +2561,14 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
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
@@ -2634,11 +2639,13 @@ int tipc_nl_node_reset_link_stats(struct sk_buff *skb, struct genl_info *info)
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

