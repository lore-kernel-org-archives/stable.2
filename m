Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CE23BD06;
	Sat, 10 Oct 2026 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610651; cv=none; b=rm5E1nU1XMEOHfk5zNJmjHTNST2YGkyRXv+yc2Pl2gJhZs606K4aAbfFv6OFLXiwbwcGWNwuidcGOs44fHw+S2HjsEgbPiD979iiM5CoflhGhsfZe+hzJrb0UmLhBOzbs8HNJQQ8lcq0VlCbHIYQcj5yscyk4hzX/1cr85Ey6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610651; c=relaxed/simple;
	bh=zvNfFwc9PoVqkqyauOwXrek9AQ0OfuNidlIRLTVZ9cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d881li0B+e5IdlMKK2ZzkdLxsBv+1+LQSS3dCvP3yHfkzcsO3UecT/lGPXdVX9p6acrzHA5HrulymtC0DotYbzKhmq5tcOfwkeFeOTwT7aRZj2ZJXUEdRnrYxlI3vzaGLG/LTGYmD/5iO/jDAeyBR/rvDiywxmb7YMSghTto3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIZoUwTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIZoUwTc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30649C2BCB9;
	Sat, 10 Oct 2026 05:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791610651;
	bh=zvNfFwc9PoVqkqyauOwXrek9AQ0OfuNidlIRLTVZ9cA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MIZoUwTcxt20+Pao2+4kZ21t5wIU/YagY2yYWP33npHJRQnWxKcl/A6At2cTcQH9E
	 qrbpZ88vhvb9JupXZMUwRrBymx9cych4U5lxFcm8HGHVbkJfrSqc4HW4VtwnQJ650M
	 LIKORJ5BX4pzEPF6l0GOpuKFvjW4Naf+VYMsRvhY0LGtTOt7vHZbXVRHIn0aX+G5il
	 d2le8/kUQGtPxK9Dh5QU3kChslMvQXj+gun40yBhSI7W0cBbdfUulaTcGOVpRAS7LI
	 Pku3OiTp/cURBxjwI4ntRsy1945X2yCoWDfr++KjohHrb7/99APyxUSrkMFcpOP4is
	 rmEmM/Vp4/+OQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDFACA9EBE;
	Sat, 10 Oct 2026 05:37:31 +0000 (UTC)
From: =?utf-8?q?Dani=C3=ABl_Trujillo_via_B4_Relay?= <devnull+datrujillo.nvidia.com@kernel.org>
Date: Sat, 10 Oct 2026 05:37:31 +0000
Subject: [PATCH net v2] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261010-fib-trie-nospec-v2-1-30319b4db8d0@nvidia.com>
X-B4-Tracking: v=1; b=H4sIABrPyWoC/3WNwQ6CMBBEf4Xs2TVtI9B48j8MB1gWWRNb09ZGQ
 /h3C549zuTNmwUiB+EI52qBwFmieFeCOVRAc+9ujDKWDEaZRitlcZIBU5mg8/HJhDW1jTKWLLc
 EZfUMPMl7N17BcYLuV8bXcGdKm2vDZonJh8/+m/UO/73IGjVOvbatacaTrfnisozSH8k/oFvX9
 QtzVgi6xgAAAA==
X-Change-ID: 20261008-fib-trie-nospec-5c76028c8e7c
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Dani=C3=ABl_Trujillo?= <datrujillo@nvidia.com>, 
 Alexander Duyck <alexander.h.duyck@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791610651; l=4726;
 i=datrujillo@nvidia.com; s=20261008; h=from:subject:message-id;
 bh=uPUNI9Kq4YpKNfBTtH+vsvHA/nWcjMUXLW9WxS1V+UU=;
 b=fPgxJUeP5Uvj7gW1hYqR2cTHVIiRiMhX/53xfA2JJ2ZlCcnpkBBc5nYlv+tAev3S6G2HAKUdi
 Neh+sOmwpJ7AqxvfTf1puPwPidZhG/Os77qQXGqlxbf02Us0Bkz144H
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
child array is then treated as a node pointer. A later transient
dereference of that pointer can cause a data-dependent cache footprint.

This was found during Spectre-v1 research. Leakage was demonstrated with
instrumentation that delays branch resolution with a CLFLUSH before the
mispredicted branch and makes the leaked location
deterministic for reproducible measurement. In that setup, a
userspace-controlled IPv4 lookup key was able to trigger a transient
out-of-bounds child access. The transient use of the loaded value as a
pointer caused a data-dependent cache footprint that was recoverable from
userspace using Prime+Probe. A real-world attacker would likely
need to delay branch resolution, which was not demonstrated end-to-end
without the added CLFLUSH.

Sanitize the index with array_index_nospec() before accessing the child
array. This removed the observed leakage in the described setup.

Apply the hardening before setting cindex in fib_table_lookup(), because
cindex can later be used by the backtrace path to load another child
pointer. fib_find_node() has the same pattern, with the checked index
derived from a user-provided key in fib_table_insert() and
fib_table_delete(). leaf_walk_rcu() has a similar checked cindex before
get_child_rcu(), and the traversed state can be influenced by userspace
actions. fib_find_node() runs under RTNL and
leaf_walk_rcu() is not on the packet lookup hot path, so harden those
analogous accesses in the same way.

Fixes: 9f9e636d4f89 ("fib_trie: Optimize fib_table_lookup to avoid wasting time on loops/variables")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daniël Trujillo <datrujillo@nvidia.com>
---
Changes in v2:
- Move array_index_nospec() before cindex is set in
  fib_table_lookup() so the backtrace path cannot use an out-of-bounds index
  (Eric Dumazet).
- Apply the same hardening to fib_find_node() and leaf_walk_rcu()
  (Eric Dumazet).
- Add discovery/testing details of the gadget to the changelog.
- Link to v1: https://patch.msgid.link/20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com

To: David Ahern <dsahern@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.h.duyck@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/ipv4/fib_trie.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 248514dce0cd..bdffeff58c95 100644
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
 
@@ -1466,6 +1469,8 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 		if (IS_LEAF(n))
 			goto found;
 
+		index = array_index_nospec(index, 1ul << n->bits);
+
 		/* only record pn and cindex if we are going to be chopping
 		 * bits later.  Otherwise we are just wasting cycles.
 		 */
@@ -1766,6 +1771,8 @@ static struct key_vector *leaf_walk_rcu(struct key_vector **tn, t_key key)
 		if (cindex >> pn->bits)
 			break;
 
+		cindex = array_index_nospec(cindex, 1ul << pn->bits);
+
 		/* descend into the next child */
 		n = get_child_rcu(pn, cindex++);
 		if (!n)
@@ -1787,6 +1794,8 @@ static struct key_vector *leaf_walk_rcu(struct key_vector **tn, t_key key)
 			continue;
 		}
 
+		cindex = array_index_nospec(cindex, 1ul << pn->bits);
+
 		/* grab the next available node */
 		n = get_child_rcu(pn, cindex++);
 		if (!n)

---
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
change-id: 20261008-fib-trie-nospec-5c76028c8e7c

Best regards,
--  
Daniël Trujillo <datrujillo@nvidia.com>


