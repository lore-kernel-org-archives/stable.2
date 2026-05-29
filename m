Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D13B9DB6
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097967; cv=none; b=Ja1eT68HDMIF8QNaIQErayL/93c1Q6m/TZTgb+eZz6vb+MESZWeNwooZfeYCAJ2fykJlNCpRpilngTEYeSFdd5yx+nx/mYRzqAs3RG4N1FJo3kkDZDxWU8E/GPmzlLUq1Ak7atRIk8fF1JzBbSMp8K3KNRhSV/NwWwxVTV2AiQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097967; c=relaxed/simple;
	bh=WWJ4GGiRuFc3tDDOGIgezWCKnX1vNmkJhyzevq7/G7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UD2CMR0LAD5/gJ+dvH9EP3ZQgRBm3WYaHOYPM9l3SP+lfL+ZwSUIliWk7KN2LbPFEfp0UQQ6gRNAnNZx/ONcmGaM86c7bqhsX/TQEg27Lvkx/wH5sVWcSLPZaDK+bRFg7KHpnEgtgKTRG9bo3fPxlVFXAZO5VSSxFDi8n4PVUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEz0iXVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEz0iXVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC6F1F00898;
	Fri, 29 May 2026 23:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097964;
	bh=isjC+0PXubRs4B8B6ZVkOHQZiCuIbGbYUfOVTz1AVWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEz0iXVCPLLy09zWrfxycABhIOwOMqiINLFIpEn3GJ4KmbrMKGoKW0OGKexf4eX46
	 Xmw8EDoX4xpxpX/pRPJuYh8XHfdUwrgcM7up79aGFIm24bS30PH9lc+HqQ/xHZcs5Z
	 n4zIqKt1F6eEBUpJl6PSbCgwDCESOy1sjrtEmvR2aF7LoH5qzywV3gOGH4C3Dx+YhT
	 hjEVMxDKSWN4dAUMsSRjWPv8qpMUJJo9XPrS7Ks/zLnlxhysTwrLtFBVh9nYzB4HKf
	 4gwU0Fg5p8mtk7JCYFfaUk3PdX6q/UCogDelSv4Ic3MYtl5PnAS8/SSoJcDKH0hbO0
	 SauoGcar1nf8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: hsr: defer node table free until after RCU readers
Date: Fri, 29 May 2026 19:39:22 -0400
Message-ID: <20260529233922.1913663-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052839-nickname-snuff-d391@gregkh>
References: <2026052839-nickname-snuff-d391@gregkh>
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
index 85991fab7db58..47faa8b4aaa90 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -131,8 +131,10 @@ void hsr_del_nodes(struct list_head *node_db)
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

