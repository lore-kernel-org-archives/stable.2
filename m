Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200782;
	b=eZOy5oqNaYssOEhNz3c564BTJ3I0gwzyM5WoX+3kYc6u+TX1XkkJ95IUU1L1sIRFB2P1
	 sOt56DbVyzSrNvfSzpzxeyqAyfCT9ebG/Ajsy1LBg7ZX99DjmSRkzBnYD0ZZY+RWHA1ka
	 /4sdzd3naxWKPAJTCtP/Otfi2jIVjs7ahY/m2L8WDTMnR+wNDyxN+wQNblx4auucV7zKn
	 8MvUf5vs7S2BxnbhjZZQUgImvQ2uRvBPAqlTt2oTCwVZ/13AK0dHCHVy5Hd6wd3QF0Evf
	 OBP1GJ8wS27QfiQpBcjBlrshlJPQ+d3C5zTOjxItSTfCWmmgLnqs/25zDYcKVrOF2Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o8v/BZgYUbcYBIe4CB9T7ZtFdceVMuVvuQywcZxh+ZQ=;
	b=fGZip2OA4gFqeOB/GZTE0kMt8VuxTBl5fBExwTzq1O0FhcOCSrOmQesLnaOKUniLGAPU
	 D/xwMX2tveGcbGDdDlZb7RZIhYVS/NKyW83tdYvUjw7/rT8AuAcwRVOy3Bs++j/DPA52b
	 Ci/EjiizGfwPFUQW9ckBHg92BGNATjqXuitNLd+epHijHwncUA3TcSx0L/OtYiQWjvDth
	 URwpGJaMlyEQs3cKd8n3FZcjdmtuEz0Ncy0mGFRh4XMunA4HuBNj/vly8D7QV+csf/I3N
	 4HvcS4MkDiX9e3mqQYKsjgNrq4S558a1AXMmFQ4/nCLqkjQLktnY5HZK62IBL8E2Sjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWgo0r0r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646860A261B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWgo0r0r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CCE1F000C6;
	Fri, 20 Nov 2026 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200781;
	bh=o8v/BZgYUbcYBIe4CB9T7ZtFdceVMuVvuQywcZxh+ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWgo0r0r1vT43l43ZnUCs7L11gO2wYTDrsaDv2oJlg18DbRar2LJXEzGoNqqemJuu
	 DcASk2vntTTS/LPryVF5dq+uau+qOSF3XhUJswL5i7ox/dUpTDUPDj5pM3SB2iLG3E
	 J+XG/LObwAmALYgp1xxlescrrMlNP1ReNQMArjY0Ff5r7p8zrZkICiHOJkAbawm7qs
	 Qdib+6WJijoNXcL9hGOTY6d0MSYKNqIA3nTAM2QMBJRIAtpPYEJO+1R5qntRE5bW82
	 363uzycEl8cFu16wNETEZ3JUoQemxHogWQnzlLlZ9rlFwpr5f2pIkXqgaZfZn8uSFO
	 KYlBjeJp8OnVw==
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
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org
Subject: [PATCH 2/2] [v3] mm/mempolicy: replace copy_nodes_to_user() interface with put_nodes()
Date: Fri, 20 Nov 2026 19:52:13 +0100
Message-ID: <20261120185248.823415-2-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120185248.823415-1-arnd@kernel.org>
References: <20261120185248.823415-1-arnd@kernel.org>
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

The get_nodes() function handles copying node masks from userspace,
while copy_nodes_to_user() copies the same masks to userspace, but
with a different argument order and slightly different meaning of the
same variables.

To make that less confusing, change copy_nodes_to_user() to look more
like get_nodes(), using similar name and arguments as well as adjusting
the maxnode value once, and restructure it for readability.

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/mempolicy.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index afe614efb77c..b240acaa8cf1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1736,7 +1736,9 @@ static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
 static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 		     unsigned long maxnode)
 {
-	--maxnode;
+        /* User space passes the number of bits plus 1. Fix that up. */
+	maxnode -= 1;
+
 	nodes_clear(*nodes);
 	if (maxnode == 0 || !nmask)
 		return 0;
@@ -1769,31 +1771,39 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 }
 
 /* Copy a kernel node mask to user space */
-static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
-			      nodemask_t *nodes)
+static int put_nodes(unsigned long __user *mask, nodemask_t *nodes,
+		     unsigned long maxnode)
 {
-	unsigned long copy = ALIGN(maxnode-1, BITS_PER_LONG) / 8;
-	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
-	bool compat = in_compat_syscall();
+	const bool compat = in_compat_syscall();
+	const unsigned int word_bits = compat ? BITS_PER_COMPAT_LONG : BITS_PER_LONG;
+	unsigned long bits, node_bits;
 
-	if (compat) {
-		copy = ALIGN(maxnode-1, BITS_PER_COMPAT_LONG) / 8;
-		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
-	}
+	/* User space passes the number of bits plus 1. Fix that up. */
+	maxnode -= 1;
 
-	if (copy > nbytes) {
-		if (copy > PAGE_SIZE)
-			return -EINVAL;
-		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
+	/* Don't exceed what would fit into a single page. */
+	if (maxnode > PAGE_SIZE * BITS_PER_BYTE)
+		return -EINVAL;
+
+	/* Process full words, which depend on the user space ABI. */
+	bits = ALIGN(maxnode, word_bits);
+	node_bits = ALIGN(nr_node_ids, word_bits);
+
+	/* Clear anything we won't copy below. */
+	if (bits > node_bits) {
+		if (clear_user((char __user *)mask + node_bits / BITS_PER_BYTE,
+			       (bits - node_bits) / BITS_PER_BYTE))
 			return -EFAULT;
-		copy = nbytes;
+		bits = node_bits;
 	}
 
+	/* Finally, copy the bitmap. */
 	if (compat)
 		return compat_put_bitmap((compat_ulong_t __user *)mask,
-					 nodes_addr(*nodes), copy * 8);
-
-	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
+					 nodes_addr(*nodes), bits);
+	if (copy_to_user(mask, nodes_addr(*nodes), bits / BITS_PER_BYTE))
+		return -EFAULT;
+	return 0;
 }
 
 /* Basic parameter sanity check used by both mbind() and set_mempolicy() */
@@ -2054,7 +2064,7 @@ static int kernel_get_mempolicy(int __user *policy,
 		return -EFAULT;
 
 	if (nmask)
-		err = copy_nodes_to_user(nmask, maxnode, &nodes);
+		err = put_nodes(nmask, &nodes, maxnode);
 
 	return err;
 }
-- 
2.53.0

