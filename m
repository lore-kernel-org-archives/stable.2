Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368157;
	b=NAyDEZsNuy+w25s88E6eQiyoesYEBgN0RDaZyxIeOnuFK2q35+MPxOrDRcYmy+wemiSm
	 U42z/WUE0LOjAx9B0WUSOcvVZgJTeB86EG+ANIYhyFhdTezK5VA2cWQHQ9ipEtxyql2hm
	 CRTPgKRNIz5E16verfiu50J/DY3gxe98fHjlUB76JpRaEsRY1zDbtrfd44UesiZ+qbLlq
	 O79ieSdZMtXsyrxXXLhC98AZ2PBaHXKbWS3aVj9Yqev3Hve/IFKxTELeiNnYQ/+sc/FdK
	 NQ5H0Rni99FS1omAZ/RjF0rzhqhVHrpMe69Mfgj+8y0u+jY//0kXwSYIG1y2zZ0MVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368157;
	h=DMARC-Filter:DKIM-Signature:From:Content-Type:Cc:Subject:
	 Mime-Version:X-Mailer:X-Original-From:To:Message-Id:X-Lms-Return-Path:
	 Date:Content-Transfer-Encoding;
	bh=kEBFFd8yOCT0rbB3iMwZuBjqlBV1Cjt28vL9qjdrsTE=;
	b=Qs5vaicu3jIZzDHobsWybTItyZKcM2nPtiMXrvOh0CLTTAREVu346PGcFLG7eAWPqK7g
	 bd3Hx+kxd1rCxmJMk2hFbFKy2vy2gyPdIPkWk/ab9r6jLM/8o884rWd6gCjBiUoI2OPml
	 r/vdveZuuHUhL6RHdOkZiBt6lEKN2Y72yA5GkQ31jn9oWJa8eL4rdev+Vud5RX55J2rJv
	 zGEXlhXnHOfvBbpk698J6cF5eykjCheiKrR3MyygxsHM7pj0wwclvXeoUiZTU44+e3l/H
	 VJwWQyA7V7wBdKzcolRMI1xeDkpqcF2IRcRhRF50BJS4anNcazAiS85iz7NOlgFPqDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=XgbOw9xW;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEBD606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEBD606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=XgbOw9xW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794368151; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kEBFFd8yOCT0rbB3iMwZuBjqlBV1Cjt28vL9qjdrsTE=;
 b=XgbOw9xWcHRzNDHTcHV/X01sL1Ra9EVahKncVbg82soOrqxHWifXFfpmC5cnZ+EgduWunp
 8RPvcSo4cj50JkV2LTg6uJPaZ8ZABjaszpvfDd+QiGRa5M9s9/27YL869h/G4MWacB2nRd
 KpmKN4hDRwYdTD1DXTK0ZjWmmKbV8O42d12PCS+MBK1hpjsy5cFuO1rOSdYcezx/ypocQL
 5vdfpN4WKcLSZ8j+kxk4iS95lxY3Mu2NUymUrUNjIk5pVlorlFs+W5fcpUkbBfgBk9A1dK
 zJlWpK+849oOU8vhjxtKm6SJ40UxlfPlm7TJwScGhaB3QILsdFVT5aMfkO7I8A==
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>, 
	<realwujing@gmail.com>, <stable@vger.kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH net] net: netns: fix INT_MAX nsid cleanup
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
To: <netdev@vger.kernel.org>
Message-Id: <20261111033525.65828-1-zhaogongyi@bytedance.com>
X-Lms-Return-Path: <lba+26af3e295+5ef86d+vger.kernel.org+zhaogongyi@bytedance.com>
Date: Wed, 11 Nov 2026 11:35:25 +0800
Content-Transfer-Encoding: 7bit

A syzkaller reproducer assigning INT_MAX as a peer nsid triggers an
idr_get_next() warning during netns cleanup. With panic_on_warn, this
panics the kernel.

alloc_netid() also overflows reqid + 1 for this nsid. Use
idr_alloc_u32() for requested IDs and idr_get_next_ul() for cleanup so
the cursor can advance past INT_MAX.

QEMU/KVM reproduced the warning without kernel changes or fault
injection. The same reproducer ran without warnings after this change.
Kernel selftests were not run.

Fixes: 7acee67a6bce ("netns: optimize netns cleaning by batching unhash_nsid calls")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 net/core/net_namespace.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 52c2bd447..9d530ac41 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -270,14 +270,19 @@ static void ops_undo_single(struct pernet_operations *ops,
 /* should be called with nsid_lock held */
 static int alloc_netid(struct net *net, struct net *peer, int reqid)
 {
-	int min = 0, max = 0;
+	u32 id;
+	int ret;
 
 	if (reqid >= 0) {
-		min = reqid;
-		max = reqid + 1;
+		id = reqid;
+		ret = idr_alloc_u32(&net->netns_ids, peer, &id, id,
+				    GFP_ATOMIC);
+		if (ret)
+			return ret;
+		return id;
 	}
 
-	return idr_alloc(&net->netns_ids, peer, min, max, GFP_ATOMIC);
+	return idr_alloc(&net->netns_ids, peer, 0, 0, GFP_ATOMIC);
 }
 
 /* This function is used by idr_for_each(). If net is equal to peer, the
@@ -639,10 +644,10 @@ static void unhash_nsid(struct net *last)
 	 * use for_each_net_rcu() or net_rwsem.
 	 */
 	for_each_net(tmp) {
-		int id = 0;
+		unsigned long id = 0;
 
 		spin_lock(&tmp->nsid_lock);
-		while ((peer = idr_get_next(&tmp->netns_ids, &id))) {
+		while ((peer = idr_get_next_ul(&tmp->netns_ids, &id))) {
 			int curr_id = id;
 
 			id++;

base-commit: 070411c1590c8172eb4d86f045d99c372f22fe23
-- 
2.39.5 (Apple Git-154)
