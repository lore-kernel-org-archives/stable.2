Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28762F5A0E
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099343; cv=none; b=CnjtaQJfXHTpEvYtPsdgF8B/sNxwT5snQhHlZBTaorCEIHJ+UiDVr+VkonRT5D9oMMT/pLEyiNMloWPPL4AaMJYoREcsv7kSfYwEw8F6alW1SwBLnH++cADswAmU4znToOEHQ7y9SMqkxgrbmKNsBLtUDqF1rtMdLgv2g2qGrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099343; c=relaxed/simple;
	bh=VomrjMSgJIiANnzQHQfRzcWxgHVVDFqPNEdiou/q514=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f44L2Kj+YOmZSUSqjKbaOsDyhcgrqKl+jXUNzDPZBF8kMi/I9XfFH1K54vcHsdoFBAaTmY+RQZlCGuM4ODBsl1WInyT27FylYcwAOaq51JaZs97Dh9M0Un6wgNETOZuVpJHd/KKuC1c67EUXv/FgTfhKHGYHM63lOuA3C4y0IR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frDy3f4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frDy3f4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6561F000FF;
	Sun,  4 Oct 2026 07:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099338;
	bh=HjOwu0YjPD+FdsExXXR00XtB68oJtd5teDZOABJbOYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=frDy3f4F2Ff+vFOzDeIU5F3ejPUqibTrh7HQ7ggP56SxjFjb1idxcvAlMyY+79xou
	 sWWdSL9fyJUXMaTfEnDQXrQe7ybwQ1kpWMDZWx1a4I7xGA7aHxLEBYrdtkOQOtwi5W
	 RPoKW6Nsyq2y+CqKNWi8VmIiBCr0n5Wbz0w+ttTLmRg1IDluxIMkKc5gUhuDT323m+
	 rOXSv9XmAEUdxixc9M48OYkPn+qYWU+E7t6N6envyvtimwHo1LmigpIhIMkNicIFfa
	 RhlfclGOHcWsYJsmeBgrEROfSDwVLZKzCLzHPmqBjCyzFk+cg3EePT6ypHw1Ej5sD7
	 J4k/JTtseCg7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] pfcp: fix socket lifetime on netdevice registration failure
Date: Sun,  4 Oct 2026 03:35:32 -0400
Message-ID: <20261004073524.1373170-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100324-detector-remember-9bba@gregkh>
References: <2026100324-detector-remember-9bba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

[ Upstream commit 0f17d2e3dd9cda3ee6d94033d5e5489af168920d ]

pfcp_newlink() creates the UDP socket before register_netdevice().
If registration fails after pfcp_dev_init() succeeds, the core calls
pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
The newlink error path then releases it again, causing a NULL pointer
dereference. This was observed with failslab fault injection:

  FAULT_INJECTION: forcing a failure.
  kobject: kobject_add_internal failed for pfcp0 (error: -12 parent: net)
  BUG: KASAN: null-ptr-deref in udp_tunnel_sock_release+0x1c/0x50
  Read of size 8 at addr 0000000000000120 by task ip/1037
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x78/0x90
   print_report+0x468/0x5cc
   kasan_report+0xa4/0xf0
   __asan_load8+0x7c/0xd0
   udp_tunnel_sock_release+0x1c/0x50
   pfcp_newlink+0x128/0x184
   rtnl_newlink+0x848/0xe44
   rtnetlink_rcv_msg+0x468/0x514
   netlink_rcv_skb+0xc0/0x1f0
   rtnetlink_rcv+0x18/0x24
   netlink_unicast+0x4b8/0x558
   netlink_sendmsg+0x2b8/0x584
   ...

Return from pfcp_del_sock() if pfcp->sk is NULL.

Fixes: 76c8764ef36a5 ("pfcp: add PFCP module")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260924055252.33488-1-xuanqiang.luo@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ sashal: Changed the NULL check from pfcp->sk to pfcp->sock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/pfcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index a6aa30ae0af76..c1c8eaea63fc3 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -104,6 +104,9 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 static void pfcp_del_sock(struct pfcp_dev *pfcp)
 {
+	if (!pfcp->sock)
+		return;
+
 	udp_tunnel_sock_release(pfcp->sock);
 	pfcp->sock = NULL;
 }
-- 
2.53.0

