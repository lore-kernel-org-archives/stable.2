Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5245352021
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098588; cv=none; b=tKlCtwJ8vCQe1/aByTrPNNQGhsQEb2yhWT6VsHn6ZmwqNlHzMlCqgAcjQuwDNF1lIYFXtrU78gMzydXmxEwn6bLnHRr2mfZ2q7v09t9YZXO+tKU//OTGeGv+N4AIhVuG7FqveKaCKGf9iPRuuSINuyrzRYRl3hETz+UB9mdZHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098588; c=relaxed/simple;
	bh=QrOxchwV3Ka/8yfig2dtWMs8Cp7MP7OSLKvZbKA19B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjTZ2dufNHhTBlFM/SR28u3E8armWk10S20aERdRrqqj4Geqk/RTiRPBpDmhcR3nZGv2iMft2XHP7gLn21FdbK8YV1IiZrd6nXoS3P4eDqdBeauFZNrfB5IPNnLqNRNOoFpf5IpMcoi1PhIq0wsKzb36ZM0e47qR4w1Wdb4OYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nup+spfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nup+spfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE681F00893;
	Fri, 29 May 2026 23:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098587;
	bh=OcOtLRujMJ9lJ56KOBHxyRb9jSlXHWv790cpdr5HsHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nup+spfEpR5KG7Y1RJ/O4WI/rBy6iXj+6A0y84g036Sp25rk6DH+dl/aYY09cmdp5
	 QfmPRNQXRyFCwDvcdrhzvTOR8BMhJ/sh09y1oGpw5Vmzniy+c5PMaWREzBkuOjxDsB
	 TnY3Rhq0RHpmAE4tYam0/QLTNie11PS+4T30oLzsrFX8Y2zaCqtzS4Dr3uhVOaBZ8+
	 IF/mUTCay8pgC7ZgwhXK78iuHQS2MSUYkQHMCuBSjL4iqwDftDa/Ix1bd08OzM1drn
	 gRXdzjy7YDSEAexdy3DnrPwQQaljQGCLtW+T22zFrys6CwKR2VR+oJ0AM90agxQh4F
	 41tnjRDAGW2aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: hsr: defer node table free until after RCU readers
Date: Fri, 29 May 2026 19:49:45 -0400
Message-ID: <20260529234945.1939832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052840-drizzle-buckshot-3d43@gregkh>
References: <2026052840-drizzle-buckshot-3d43@gregkh>
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
index 26329db09210b..3f6c412721822 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -114,8 +114,10 @@ void hsr_del_nodes(struct list_head *node_db)
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

