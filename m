Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B313D53C
	for <stable@vger.kernel.org>; Sat, 30 May 2026 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100445; cv=none; b=ojtyzaj0IGEuyDrheGX1mnKdwCooBM8PNiziDXm/Pr++ObEJJlEyZ9ELNPuKNwFeHunRwABoMPRIV6qmvVSjPSiWye2yF/vNn17TLnwp27lk4tp26DOWHcKtWmfK0NuW/AkkYlaEsS8tR7mcAc2CBBsVwg0czxxKHBudTgmd4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100445; c=relaxed/simple;
	bh=fxyAaXNw66hV8yC0hsbvdPT646FKNuhoE9lEbFC3oRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjdDso4UVNd3nVLdsOt+IKWwmQh9IwOQJU6gLPfZRPEexDMZCQpRB2PH/NU68qKuFBRpoY0zXtWkgS46o0bJ8qztH3OaFi+kQNiHG1Wvn/5Gogb+cTndc2rELNBbsTmYWEfBbpcDugQGtmdKxLXZp+kFF0VXv5yGprqm1u+X68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDbcQ3s5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDbcQ3s5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7391F00893;
	Sat, 30 May 2026 00:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780100443;
	bh=zqtx8n1oeb6WHGp+mVpd4ZUjOhKq0pbEBq9nHg4DkIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDbcQ3s5pI4DYPgQGRLAJHfmjeRHvbvQz3msfs4ODNK5hWcin9VclIPmeUiUdzk1l
	 LenlcEOQPwqvpIDMp7sZ6PJ918zP+F/KoYMDsteVBCMmg6mQyQ6KsnyCDZx/R/b0wv
	 dSjxH/WnwsmcAipT8JbnnwcpYizd1sCm2TXH4OszjpLQ3I+lx0uI4sQRmqaGwilbFG
	 clffoTTdAYSiM6K1AIQ+Q8GErckphp7NnsJ5F6vBlq0AWnS5ghTiGMVybjq7SeRzvu
	 DxH04+KGwG4n94T+VpniU1jtlA81Qyb8wb0+LrgKGtZwV9o/dbA8gGq0ucU9Jc+9Pa
	 ofKmIe99hiaxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: hsr: defer node table free until after RCU readers
Date: Fri, 29 May 2026 20:20:41 -0400
Message-ID: <20260530002041.2171280-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052844-wish-motor-9cd5@gregkh>
References: <2026052844-wish-motor-9cd5@gregkh>
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
index fc9fb3e5ae3e2..eadf44811f3cc 100644
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

