Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941307;
	b=Pzrw+hKbDLmpdWpGv2nj45DpffqDNcf3MYVRD1Qk2s7nqFkkMdPp8z8yPWfG3mifUTjG
	 p95j04dueuM2XxooYmVZDVtF4vLn4MJaNOmLzm0WswDIKSQYM99zS1xjDdizFFvqhbR1/
	 hcOH2u1FRRP3LtysfmsdBMnePNgy96RmPdl4xbTD8rasBIPm2qRPHgycJxof/dhzU+eaE
	 tXWARCzUbyVDsLhCCMbsJp1aoLQpFmReG7pRzsZrOyPvKZE/aPKX0Ic1JnXMPGA2Ac0vz
	 7QBNwIGI81r8Id9mE0KfcrEtbhwlipmcKdR2rCCm6W8Qh7gN9BKYdMjTR0rrdO+GOVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941307;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XYNLpZZA6D3B9ZCH1XsjfFEUFEQlwdWP8FZ6G9m3nJ4=;
	b=RL9XQHh/CdtL+9lZFm461IrBwgFZJH0bSEfnCRlUieOJFfKURgvmAoSAjnO9VwORqFDN
	 z2vxzdNzuqrVOHnLBp0QmL33lh7v5U4ennotBCHbPXK+bu2UKPbYKvKuVHueu9PNBnp6Q
	 yNiwhOePf/XwpeQWBtDjz+POgaNZYOqUCK+ChqYZG9v6iolxqQv2yE7bZLFW7mjGkogzo
	 gRe4zgvx1NdnjKGs5lK9O1mro9btSX17+1VdK4o3t+pP4uttCZqx4zMiSfdCqez8AsqDp
	 2O9WZEpyL4AlNOboQa1K4oBdNSkV6n/XF/X+jYGuPwHbSTDaIWtkO2Tye899J1srR9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVMwZXaL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D441606A31B;
	Fri,  6 Nov 2026 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LVMwZXaL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793941306;
	b=n+TFh+2S+Qj0EQ8kwZ+HbwEVpVbWXvqry5tjPI0owwmABkj2Q+2HInoUehwBMh3zwjGP
	 0gD2+L6UHQWur33xCf653L9HmYx3z9Sr9tznjTT1L2O3QRfy0Eo+ltsLued6YiS1J3wst
	 n1/nD9W4TouvTfQQrGmsWej3nLtHotL5k/x855OZ1cNvSuntYRzSkr03c9BWZetp4Homp
	 5IJQUMJXOlh9yFOHuo6g0laPvqeJMctHyH7FRt6Imd7duygD1HgLeluBFABaXQJdoyovf
	 RbQwjMuQr/jVshoe8b05rHPx2WBsNhjhQI/W30YjA/iydTWDQnMVX0TlG/GlMmvtvaw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793941306;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XYNLpZZA6D3B9ZCH1XsjfFEUFEQlwdWP8FZ6G9m3nJ4=;
	b=qEPiWNwfLwa1XPDzGHm2LTHFVIMt/jp1oS0G69QS9pdwTVhvPWe/GUkFymgEWHZnYrcH
	 jOs+Seqe7Urvs0ETPpEQKEo4EgXhLmQV0lu9fE4h3UtZMlkDKjmbv/aqlR5IaxTlzVR4W
	 wslOrqSA31GD3cT7XdlWAOFVYEXOaSyCaiXaBpURikzCQu9VhQBffaVn1Qh/wuhHg2h+o
	 4JXwxDOjKZnLRmex26/lIvTZmr/8r6ezbgWuhki6/CfpUYa3wQg4P3oCQAjeCRISIUelP
	 pE+GnQ/IfKdnXOU+5PD5meiCBqN+KceFAbheHpml8Jk+dCGMRFN+RDqIjpSd3KPlmpQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 069D71F0089F;
	Fri,  6 Nov 2026 05:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941306;
	bh=XYNLpZZA6D3B9ZCH1XsjfFEUFEQlwdWP8FZ6G9m3nJ4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=LVMwZXaLnCrC7bQ8/kH+3rIgfrN+QRv/2vP+T/BkebpuUQSmK09vA+SMGUPg6jqrZ
	 7X9BJbUUgM/rKzT6sG6UDjZePIxu0bN7nyuhh7RGrEPWVGX3BlSJSZhDVnExAN27gp
	 ANE5gwa3A7sYI7xYlNQBLdxWvuon+ZMQiv+WbokNT+xLtrnGWNIJqq0AGmbncZ53p5
	 /gAR85YUFvWI+qnRoT7ND1eUrKJtUhVGy8EzJIGfX9POKJUXMtRUAuWxl/A7GalSjn
	 U7P6prKfk70030CgZtyr0muCusb8aJB4UVwAjAJtEOZakwWW5Pj9pei+pwYu0N1rxl
	 nRJWm1sVxQpCQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5751D45BD7;
	Fri,  6 Nov 2026 05:01:45 +0000 (UTC)
From: =?utf-8?q?Dani=C3=ABl_Trujillo_via_B4_Relay?= <devnull+datrujillo.nvidia.com@kernel.org>
Date: Fri, 06 Nov 2026 05:02:23 +0000
Subject: [PATCH net v3] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-fib-trie-nospec-v3-1-53da6550dcf8@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAF5f7WoC/3XNTQ7CIBAF4KsY1mKA/qEr72FcFJjaMREaQKJpe
 ncpbjTG5Zu8981MAniEQA6bmXhIGNDZHKrthuixtxegaHImgomWMybpgIrGPKHWhQk0bXTXMiG
 1hE6TvJo8DPgo4olYiOT8Poa7uoKOq7XWRgzR+Wf5m3gp/32ROOV06LnsRGtq2cDRJjTY77S7F
 T6JD4CzX0BkoGIV36vaKGnYF7AsywtOGBkaBwEAAA==
X-Change-ID: 20261008-fib-trie-nospec-5c76028c8e7c
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Dani=C3=ABl_Trujillo?= <datrujillo@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793941344; l=5447;
 i=datrujillo@nvidia.com; s=20261008; h=from:subject:message-id;
 bh=5c7YINK8sjo1SrfVNltMm2KMO1jVWrBXalQL2Wr8bkA=;
 b=Z6qQ/lszbof05Q5gSAbauvuwAu6MsKLFgkjXGFMRArOgu5BrHZ1In+z4rdMR/2GTgXIdoOUOH
 49V2s6kwhXeByzS36DUIbQ4XixZDpouTIYi3o9h8Eu0zV2+hF4X1TeL
X-Developer-Key: i=datrujillo@nvidia.com; a=ed25519;
 pk=AP24zUwENFy2geglpKJAA8oaT41tkteCL9hTWGd88rs=
X-Endpoint-Received: by B4 Relay for datrujillo@nvidia.com/20261008 with
 auth_id=1128
X-Original-From: =?utf-8?q?Dani=C3=ABl_Trujillo?= <datrujillo@nvidia.com>
Reply-To: datrujillo@nvidia.com
Content-Transfer-Encoding: 8bit

From: Daniël Trujillo <datrujillo@nvidia.com>

fib_table_lookup() checks the child index against the bounds before
passing it to get_child_rcu().

The index is derived from the lookup key, which in turn is derived from
flp->daddr. A userspace process can therefore influence the index by
triggering lookups for chosen destination IPv4 addresses.

If this bounds check is mispredicted as in-bounds, an out-of-bounds index
can be transiently passed to get_child_rcu(). The value loaded beyond the
child array is then treated as a node pointer. A later transient
dereference of that pointer can cause a data-dependent cache footprint.

This was found during Spectre-v1 research. Leakage was demonstrated with
instrumentation that delays branch resolution with a CLFLUSH before the
mispredicted branch and makes the leaked location deterministic for
reproducible measurement. In that setup, a userspace-controlled IPv4
lookup key was able to trigger a transient out-of-bounds child access.
The transient use of the loaded value as a pointer caused a
data-dependent cache footprint that was recoverable from userspace using
Prime+Probe. A real-world attacker would likely need to delay branch
resolution, which was not demonstrated end-to-end without the added
CLFLUSH.

Sanitize the index with array_index_nospec() before accessing the child
array. This removed the observed leakage in the described setup.

Apply the hardening before setting cindex in fib_table_lookup(), because
cindex can later be used by the backtrace path to load another child
pointer. fib_find_node() has the same pattern, with the checked index
derived from a user-provided key in fib_table_insert() and
fib_table_delete(). leaf_walk_rcu() has a similar checked cindex before
get_child_rcu(), and the traversed state can be influenced by userspace
actions. fib_find_node() runs under RTNL and leaf_walk_rcu() is not on
the packet lookup hot path, so harden those analogous accesses in the
same way. Also harden fib_trie_get_next(), where a mispredicted loop
condition could transiently read one child past the array.

I see a slowdown of roughly 10% in a microbenchmark where we call
fib_table_lookup() with 64 routes directly from inside the kernel. I
observed no slowdown in a loopback UDP sendto() microbenchmark.

Fixes: 9f9e636d4f89 ("fib_trie: Optimize fib_table_lookup to avoid wasting time on loops/variables")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Daniël Trujillo <datrujillo@nvidia.com>
---
Changes in v3:
- Harden fib_trie_get_next() against a speculative one-past-the-end child
  access, as suggested by Sashiko.
- Explain the procfs iterator case in the changelog.
- Add direct lookup and UDP send-path benchmark results to the changelog.
- Link to v2: https://patch.msgid.link/20261010-fib-trie-nospec-v2-1-30319b4db8d0@nvidia.com

Changes in v2:
- Move array_index_nospec() before cindex is set in
  fib_table_lookup() so the backtrace path cannot use an out-of-bounds index
  (Eric Dumazet).
- Apply the same hardening to fib_find_node() and leaf_walk_rcu()
  (Eric Dumazet).
- Add discovery/testing details of the gadget to the changelog.
- Link to v1: https://patch.msgid.link/20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com
---
 net/ipv4/fib_trie.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index be1e40780ad7..394df1de1281 100644
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
@@ -961,6 +962,8 @@ static struct key_vector *fib_find_node(struct trie *t,
 			break;
 		}
 
+		index = array_index_nospec(index, 1ul << n->bits);
+
 		/* keep searching until we find a perfect match leaf or NULL */
 	} while (IS_TNODE(n));
 
@@ -1467,6 +1470,8 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 		if (IS_LEAF(n))
 			goto found;
 
+		index = array_index_nospec(index, 1ul << n->bits);
+
 		/* only record pn and cindex if we are going to be chopping
 		 * bits later.  Otherwise we are just wasting cycles.
 		 */
@@ -1770,6 +1775,8 @@ static struct key_vector *leaf_walk_rcu(struct key_vector **tn, t_key key)
 		if (cindex >> pn->bits)
 			break;
 
+		cindex = array_index_nospec(cindex, 1ul << pn->bits);
+
 		/* descend into the next child */
 		n = get_child_rcu(pn, cindex++);
 		if (!n)
@@ -1791,6 +1798,8 @@ static struct key_vector *leaf_walk_rcu(struct key_vector **tn, t_key key)
 			continue;
 		}
 
+		cindex = array_index_nospec(cindex, 1ul << pn->bits);
+
 		/* grab the next available node */
 		n = get_child_rcu(pn, cindex++);
 		if (!n)
@@ -2437,7 +2446,10 @@ static struct key_vector *fib_trie_get_next(struct fib_trie_iter *iter)
 
 	while (!IS_TRIE(pn)) {
 		while (cindex < child_length(pn)) {
-			struct key_vector *n = get_child_rcu(pn, cindex++);
+			struct key_vector *n;
+
+			cindex = array_index_nospec(cindex, child_length(pn));
+			n = get_child_rcu(pn, cindex++);
 
 			if (!n)
 				continue;

---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261008-fib-trie-nospec-5c76028c8e7c

Best regards,
--  
Daniël Trujillo <datrujillo@nvidia.com>


