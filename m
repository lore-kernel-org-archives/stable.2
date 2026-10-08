Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7E43933F;
	Thu,  8 Oct 2026 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497450; cv=none; b=LUqLBDhMsEiL5+VCmSw9uJK5z4IwSBBXQbJ8QzfwgXdVL5Moy4XC6BqGV5szslwzpv6sMyuy6OKCcDlEpMPObsDRBgSBf1X4u1CibBpgXsPMvbue5WFpWNj3HtIyfFeOWadN7TJ1lyHQH+Zt5T1LNRlaIUxpVUFJFz2H1kBlXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497450; c=relaxed/simple;
	bh=2I+EmY3mbtv7VjjzqsO0KGbYkgiqcaiXpFxLJFltkLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TsMNK3X1bmB66b5tX4SdB8txYqubxLWxsgEh1nMIq3/DPzFR/EuXHEmS/GyRSMXdyle1NH7NkazF7G4jDgQHznQFalijB1Kqvbrk66YZuhhBOMKyN8vZvd8T2mbenHdJIT5d2gmGOC0uanmO0XF2lyB04fNQp+cmVZiEngIA2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR9B8sQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR9B8sQS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BADC3C2BCF5;
	Thu,  8 Oct 2026 22:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791497449;
	bh=2I+EmY3mbtv7VjjzqsO0KGbYkgiqcaiXpFxLJFltkLE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uR9B8sQSVjcMexdckCbpwVObH+grZkrx9dCvBKNXOS6sV8Vn0gy9uQsuHkoKrfQy5
	 31hYmZtMNeXNO79iMf4RVzjKkJH2c4QOIfQkO9yF6Mnqhhyb/wnsdPb7XcI0wVXsCs
	 BTYKKDMX5q/46Yl3OMjls8uSCZGO6NKpKwVkTZvRqA6t2EiNu1lC54IWJDg9K/Lk9+
	 HmfdjB0tg0RmdguhRTYG2Bc5pPdFckftfbUnUSE9lroOL3sYHxQakOALJh3Mhjrbsu
	 hyDHQ3r8JkzkDaArOAXebXcqlceJX3/Luj9fqU6HgcSsxF7KUXOeJT22HUV9FpNjyf
	 eVCXuksAe7uQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37FECA6016;
	Thu,  8 Oct 2026 22:10:49 +0000 (UTC)
From: =?utf-8?q?Dani=C3=ABl_Trujillo_via_B4_Relay?= <devnull+datrujillo.nvidia.com@kernel.org>
Date: Thu, 08 Oct 2026 22:10:49 +0000
Subject: [PATCH net] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAOgUyGoC/yWMwQqDMBAFf0XeuQsxoIb+SvFQ17XdHqJkowjiv
 ze2xxmYOWCSVAz36kCSTU3nWKC+VeD3M76EdCwM73xbOxdo0oFySSjOtghTw13rfOAgHaNUS5J
 J99/xgSgZ/V/aOnyE8/XCeX4BztmtWHgAAAA=
X-Change-ID: 20261008-fib-trie-nospec-5c76028c8e7c
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Alexander Duyck <alexander.h.duyck@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Dani=C3=ABl_Trujillo?= <datrujillo@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791497449; l=1811;
 i=datrujillo@nvidia.com; s=20261008; h=from:subject:message-id;
 bh=xnFr+ktZBjHYJMb2dgrr672XmryMDvsweL3LbYJlrKI=;
 b=QAIQxu04rBsFZ4Fxj+43aqwMG1AkLo/JzAr74GzYjH648cOjifagKJGv9Z2KIMVti4++R5V3l
 /eM9rxWRIKUBvPsm4W0RllZ8H1X8B5SEr9fTvgVPZmfC0wq1gOJB7EE
X-Developer-Key: i=datrujillo@nvidia.com; a=ed25519;
 pk=AP24zUwENFy2geglpKJAA8oaT41tkteCL9hTWGd88rs=
X-Endpoint-Received: by B4 Relay for datrujillo@nvidia.com/20261008 with
 auth_id=1128
X-Original-From: =?utf-8?q?Dani=C3=ABl_Trujillo?= <datrujillo@nvidia.com>
Reply-To: datrujillo@nvidia.com

From: Daniël Trujillo <datrujillo@nvidia.com>

fib_table_lookup() checks the child index against the bounds before
passing it to get_child_rcu().

The index is derived from the lookup key, which in turn is derived from
flp->daddr. A userspace process can therefore influence the index by
triggering lookups for chosen destination IPv4 addresses.

If this bounds check is mispredicted as in-bounds, an out-of-bounds index
can be transiently passed to get_child_rcu(). The value loaded beyond the
child array is then treated as a node pointer. The next loop iteration
dereferences that transient pointer through get_cindex(), causing a
page-table walk whose cache footprint can leak (parts of) the pointer.

Sanitize the index with array_index_nospec() before accessing the child
array.

Fixes: 9f9e636d4f89 ("fib_trie: Optimize fib_table_lookup to avoid wasting time on loops/variables")
Cc: stable@vger.kernel.org
Signed-off-by: Daniël Trujillo <datrujillo@nvidia.com>
---
 net/ipv4/fib_trie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 248514dce0cd..bd8a368c5502 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -61,6 +61,7 @@
 #include <linux/export.h>
 #include <linux/vmalloc.h>
 #include <linux/notifier.h>
+#include <linux/nospec.h>
 #include <net/net_namespace.h>
 #include <net/inet_dscp.h>
 #include <net/ip.h>
@@ -1474,6 +1475,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 			cindex = index;
 		}
 
+		index = array_index_nospec(index, 1ul << n->bits);
 		n = get_child_rcu(n, index);
 		if (unlikely(!n))
 			goto backtrace;

---
base-commit: 37f12441f557468a56c1e27790413aa78c82afa2
change-id: 20261008-fib-trie-nospec-5c76028c8e7c

Best regards,
--  
Daniël Trujillo <datrujillo@nvidia.com>


