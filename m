Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950210;
	b=v+nzTCK5AP3B4wSHgKUCxInBHw38wLmpUIySefcVsBqUktIg82yZj3DM9rbGf+Lf2Rc9
	 rEe7xT0MXsFvh+c2pTS50BgUVLE9UMD9zSiu278TnzPH/EC9kBUklq4nU12bRtd6xG6Yz
	 7LZcmX0k2VUy/rM3EwY2S8MrrXqpMACXYIOVRnOXDoc/aNV1zAgxBiF/zskfCH0bQYI8W
	 C8mlGMYclxnpkcQH63wRIJYkmaq8K1sremgZwNug8n+amvXjjjhukeApgtlGERIWae8Ho
	 2hPv+m4ckt+xvh4+8X5S1319PS0YvTOtjuChF4YtLngTmmXa6F8Oax45XWod5gnpDwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hfxvKveHFk2OvHfqLTovj/80/P2+vLM5DTO5QeElbac=;
	b=lMUCMN0gRbJ+0K+s+ixMRCrOcjRgeD5q7rOZDRoB8qWSqIBb8/EjdabxaEO2AVTT2+Zw
	 i5C+noaVQlz5GVI02qJLlT5ycp/4L+PgeJZcdvoZIBtwWZL8qNTWZ0soB8fGupmyJko0t
	 l6GLwjgVqeDpdtXXZB+UOYywJAP/WfjeGYpcyp2qqCYUS8CypWhD9kGWOcmP2sr1HaCNb
	 Ms+mZVg/X95XlLm9OmlZXDY5KdiEoNe1qUpoYzE6LyzJdzZq3Fk47g/HzpjhzLwRq9r1f
	 8hMLE9Y70Dpnsq8NlcS0QCV8q+zyMzHRnDg4AcJXbaWJHIyIprKJHdR23ZfdN2uLd1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfwQ6lsr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A3606A330;
	Tue, 17 Nov 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfwQ6lsr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542941F000C4;
	Tue, 17 Nov 2026 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794950209;
	bh=hfxvKveHFk2OvHfqLTovj/80/P2+vLM5DTO5QeElbac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SfwQ6lsr/SBIsl1iP7yCYDkLC2SUSnW2KDw6jOTC6o4wb6snv54IA4bPZV9DJjQXo
	 A7EwIcee5X29fdqDlvUxNZeFeMmZQJy04vU3WjKUmq6dYliKzGIlojPniBr7OVJhm6
	 6KVggZBG8G75VgGtgw8zQKsmKu3JZZXOVWolwmL3NHcbKgMXn/LVxR5dfMWY7UncHW
	 Vh9JKboXJJRoBQ4U8g3aUU5fjlvoWbzxfI90d9ULdwS7bPWCB0u3CYie3UaeiTAi54
	 5Fqkb6jZi0OttAbiBKFYPOURP2xRDJboAAXfwriAuSP1ENM7zU3XMTEMjH7ukvKXg1
	 6P9KytCYsAVKg==
From: Arnd Bergmann <arnd@kernel.org>
To: David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	larips <larips950@gmail.com>,
	stable@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jackie Liu <liuyun01@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees+treewide@kernel.org>
Subject: [PATCH 2/2] [v2] mm/mempolicy: replace copy_nodes_to_user() interface with put_nodes()
Date: Tue, 17 Nov 2026 22:14:26 +0100
Message-ID: <20261117211635.2472067-2-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117211635.2472067-1-arnd@kernel.org>
References: <20261117211635.2472067-1-arnd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The get_nodes() function handles copying node masks from userspace, while
copy_nodes_to_user() copies the same masks to userspace, but with a
different argument order and slightly different meaning of the same
variables.

To make that less confusing, change copy_nodes_to_user() to look
more like get_nodes(), using similar name and arguments as well
as adjusting the maxnode value once, with a comment explaining it
in both places.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/mempolicy.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e471ce615691..bb18867ba41e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1713,7 +1713,7 @@ static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
 static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 		     unsigned long maxnode)
 {
-	--maxnode;
+	--maxnode; /* user space ABI uses number of bits plus 1 */
 	nodes_clear(*nodes);
 	if (maxnode == 0 || !nmask)
 		return 0;
@@ -1746,15 +1746,18 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 }
 
 /* Copy a kernel node mask to user space */
-static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
-			      nodemask_t *nodes)
+static int put_nodes(unsigned long __user *mask, nodemask_t *nodes,
+		     unsigned long maxnode)
 {
-	unsigned long copy = ALIGN(maxnode-1, BITS_PER_LONG) / 8;
 	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
 	bool compat = in_compat_syscall();
+	unsigned long copy;
+
+	--maxnode; /* user space ABI uses number of bits plus 1 */
 
+	copy = ALIGN(maxnode, BITS_PER_LONG) / 8;
 	if (compat)
-		copy = ALIGN(maxnode-1, BITS_PER_COMPAT_LONG) / 8;
+		copy = ALIGN(maxnode, BITS_PER_COMPAT_LONG) / 8;
 
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
@@ -1762,12 +1765,12 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
 			return -EFAULT;
 		copy = nbytes;
-		maxnode = nr_node_ids+1;
+		maxnode = nr_node_ids;
 	}
 
 	if (compat)
 		return compat_put_bitmap((compat_ulong_t __user *)mask,
-					 nodes_addr(*nodes), maxnode-1);
+					 nodes_addr(*nodes), maxnode);
 
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
@@ -2030,7 +2033,7 @@ static int kernel_get_mempolicy(int __user *policy,
 		return -EFAULT;
 
 	if (nmask)
-		err = copy_nodes_to_user(nmask, maxnode, &nodes);
+		err = put_nodes(nmask, &nodes, maxnode);
 
 	return err;
 }
-- 
2.53.0

