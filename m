Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201A38A299
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097050; cv=none; b=qG1gtaDPL//thlNbqHgKp6BsK7DO3jKRxEgOeXEMB1ZyTK0mDXcWqtXcZHYsuDWn5bPtrb7ZfnSrjhTT39AYeTk2tasyTFRc9Ued5n7Z4BUfrQPE+v/Ux42VACGcXehow1nKbwllDF6RYaDvqPjww/blkIEmGWTLLXOmQYRGYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097050; c=relaxed/simple;
	bh=A5mubb2zxv+M2v5TIsFo0Cna8eaXxIztXCyk3BK7N14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac04abflTUPFh/I8h/L4QgFx5qeUg6C6zF+r6zf7j0JjBPUKJetJFVGXXaJobnDAtEwbVDKJgZJm4NfLSxH2IJG9Oq6tKI0oqzhLIO6h2xDBim2ufpFhOm5whGIhMOqYdbN3f/1woTH0B0GKLHO8Zyj3qIeHCwcHp++dPCc5XD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZkMPbch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZkMPbch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EEF1F0089A;
	Fri, 29 May 2026 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097049;
	bh=L2eY6QKX78W43X21pA5JUFgJmy/vRli+Rx1w5cMywr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZkMPbchJpAQi6VmBZpvZSb4RNnhcNY+mku1nKVJFADC3kz8dtFLQgVV895/vFtwc
	 COnv9OgXBBBCV33h+1MpvQGKCQZX7FkKRKsjq0qtP6jwNXZXa+3odVS3mf3HQGMkfm
	 Uybo0RrhG/2RjL/L9xShtmREJx9wC9w819IGFmb/RMcj2OGvWeUL9vW/dPqWA6PODp
	 U/iM1O9ujas7FQEixm/1w68EgwJ0dkNWR8UjVEDfgi2jNOEkT5/kHvuioKPVSj40TQ
	 IEBGchPLb6F+4cz+2XqmCK0UtAG1hOrVYIzf4wfAwx7YBbtDYEeH+dmaDiAx2joR8I
	 INx6v60Q0FdIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] net: hsr: defer node table free until after RCU readers
Date: Fri, 29 May 2026 19:24:06 -0400
Message-ID: <20260529232406.1883397-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529232406.1883397-1-sashal@kernel.org>
References: <2026052838-cleat-rewrite-24c4@gregkh>
 <20260529232406.1883397-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_framereg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 7e21e607efc6d..177e0879ddbb4 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -146,8 +146,8 @@ void hsr_del_nodes(struct list_head *node_db)
 	struct hsr_node *tmp;
 
 	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
-		list_del(&node->mac_list);
-		hsr_free_node(node);
+		list_del_rcu(&node->mac_list);
+		call_rcu(&node->rcu_head, hsr_free_node_rcu);
 	}
 }
 
-- 
2.53.0

