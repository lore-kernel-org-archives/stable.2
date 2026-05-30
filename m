Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209479DA
	for <stable@vger.kernel.org>; Sat, 30 May 2026 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099658; cv=none; b=mPq5UEsbNq9OxwltrdGf3IkWmv/t/eUlVcjX9lGW3cv3RVXFt02Jr7YLiKozTWW3cAzsR7xf28OalH30u+Wnulcc1Z+8LRL8u0DA5JGZb1EIFQzz+dqQnQ1KctjVs4GPf+Hlf6PW2jqZGBgRsQsAJdg/VE91rwxTAQmdIr/GPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099658; c=relaxed/simple;
	bh=Nf0gC+nUI0o247QQy39MxQAavm4EqB30b/69xAJIWHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue8P5LlnqdtfBAzsQx23fmnKAICTNhnlipXGJ1hhMyDFbJCdhLBcuw8tqU84HkISAEmdoLTmYBAYRDo1T0t1QCYqLQ3znmQEgKweaDHO1zXCLCjRNAy+jEd5rTOs/w8BtBu0OfM2ZNr0JG59bS/EIjk/ezi8Ny3c9vyW8ZNsyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuoIoqA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuoIoqA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A66E1F00893;
	Sat, 30 May 2026 00:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780099656;
	bh=aZ8hmM9nAVbgoOpLD6uItGZeQBHho8n8QLcIS4n9O4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HuoIoqA9vZy4tXFz5eQBIIZ/h2Cv2ltu5WJIFTWRgY2yeio8D973GYCHnV2vcC+q3
	 HEQuFTIHXFn6wJ5Ou4Ha8vUm9ss17XSWFxp/ss0Wuo+lSpXg67bxeOMa8EuymSbX6K
	 DIY+3vPkG40M4dvl22TvMSxYmAOxV30tlzeD93cJFWJfFcZSL2C9jjtVPm9/iBM76s
	 sgwgd9uyId7m5Yr3n4J+OGCp9N3ldNuIUlriirN6wpvW/XJxvdRSULHoaR/bKpGgx0
	 g+dXlMTz9DR5XeNAHlKPI9His3MIqKBIscWsI6W+bU4McHtD2XSNeJ7Y2bfs8HNK+v
	 h34lszi754OMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: hsr: defer node table free until after RCU readers
Date: Fri, 29 May 2026 20:07:34 -0400
Message-ID: <20260530000734.2087399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052841-straggler-greeting-f0cf@gregkh>
References: <2026052841-straggler-greeting-f0cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit aaec7096f9961eb223b5b149abe9495525c205d9 ]

HSR node-list and node-status generic-netlink operations run under
rcu_read_lock(). They walk hsr->node_db through hsr_get_next_node() and
hsr_get_node_data(), but RTM_DELLINK teardown removes the same node table
with plain list_del() and frees each node immediately.

That lets a generic-netlink reader hold a struct hsr_node pointer across
hsr_dellink(). In a KASAN build, widening the reader window after
hsr_get_next_node() obtains the node reproduces a slab-use-after-free
when the reader copies node->macaddress_A; the freeing stack is
hsr_del_nodes() from hsr_dellink().

Use list_del_rcu() and defer the free through the existing
hsr_free_node_rcu() callback. This matches the lifetime rule used by the
HSR prune paths, which already delete nodes with list_del_rcu() and
call_rcu().

Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260513233838.3064715-2-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ replaced `list_del`+`call_rcu(hsr_free_node_rcu)` with `list_del_rcu`+`kfree_rcu(node, rcu_head)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_framereg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index e0aeeeda3c876..0b3d9dfbe6d6c 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -123,8 +123,10 @@ void hsr_del_nodes(struct list_head *node_db)
 	struct hsr_node *node;
 	struct hsr_node *tmp;
 
-	list_for_each_entry_safe(node, tmp, node_db, mac_list)
-		kfree(node);
+	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
+		list_del_rcu(&node->mac_list);
+		kfree_rcu(node, rcu_head);
+	}
 }
 
 void prp_handle_san_frame(bool san, enum hsr_port_type port,
-- 
2.53.0

