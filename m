Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950203;
	b=SRWOioqbECjtYJgzGvjTIYapY400MHQ3tOGR7ZOIGue+mkauEB27pA6KFH1CaSO+DhQa
	 p0Tj3fKC9N8ia1N88GNG/dsdeMACAoZ/llsarUycsSOCzHJZznskjJhcEQUgEkmhU2Dg3
	 X31gWfdh545b5F0raTy7Tx5pvZ4RzsiuRv62tcspEeKU4lDZ6Yzog1RVt8IjU9+hk46ok
	 7zmDXm1mlORtV9SaRrBo24e4GjAKevT3QTlsL9dgsbVnKOcpew4WHx6QnFnvr5BWiDD7o
	 QswX09gUiY6e9QSwkXTmcAH3JCmneG1KuC+yoBMPtpacTg+FH5VpoiyeetrplS16kRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aSIqaCuGKAAm3GIlrLBE4Sm3yguEB02bGLyZfmuO6rI=;
	b=EMiR4RI7CQmr57crKNjoPETFJXo6Kv5oY47X2GA6caMt2su/RtEg7M8Y8GwkPE2hjniQ
	 L05i2l4HjDLRjsXSrfYjeb9ddbjcuW48OHPg0OtcZDAmLXhsJHXaXjklz+g5fcZDg4uyW
	 hoxwriJnm4mK5dopDMZqemcWPFFLb6jZ9LkVbDFi5/6mHCkAKYEQuD4lwMkFbsOTVVDyJ
	 yC2xxzsDkzEB0D5DOhvdflmI9xdhdLeE1SO4mUbSz4wXdlRPrlbPAFIIZee8Sodx45i1v
	 y96xqbSe9GRaKn/QeQAgbBW6yRNbou8mXtSz24k3G5nocEPEkzXyFC6b4B3sueBuCMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvE8aUVF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F04606A31C;
	Tue, 17 Nov 2026 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvE8aUVF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3711F000C4;
	Tue, 17 Nov 2026 21:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794950202;
	bh=aSIqaCuGKAAm3GIlrLBE4Sm3yguEB02bGLyZfmuO6rI=;
	h=From:To:Cc:Subject:Date;
	b=RvE8aUVFZ2vYKmaEf76csJ4mfnf0cK3VUUHI88V9scAksNusNaNI4xp4L12gl2eh8
	 MyWjTxonX44sJry1digmpaa0AOyu4swHwIBT6069Z/T/k7ajsFWm9soX7KN11qriiY
	 PV+oh4IAe8KVmAjSF4GCngDcjJFvQxH9HXcmAvcXhGcsVLkUHIKWO1WrmTRm6//IGy
	 1ZBnuyvA0GnIgPBos3nECyrUD1nXi9++PMJPyQyrgQaedmvykway5ZmVrcze1Xa0lS
	 7AH1DSWCPsVo9DE9PWGYzyu956tRA0I95MIfzav6Y0rMu/jBQ6EzqXjX8NpcLm+AXC
	 d4A3vAATk/36Q==
From: Arnd Bergmann <arnd@kernel.org>
To: David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: larips <larips950@gmail.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v2] mm/mempolicy: fix copy_nodes_to_user() for odd inputs
Date: Tue, 17 Nov 2026 22:14:25 +0100
Message-ID: <20261117211635.2472067-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The compat_put_bitmap() argument has an off-by-one error that leads to
copying an extra 32-bit word from the kernel stack to userspace when
called with an argument that is one larger than a 64-bit number.

In addition, the size calculation rounds up to multiples of 64 bits
instead of multiples of word size as documented in the man page and
expected by numactl.

Fix the calculation where needed to use the correct -1 offset
and pad as needed.

Reported-by: larips <larips950@gmail.com>
Reported-by: Gregory Price (Meta) <gourry@gourry.net>
Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
Link: https://lore.kernel.org/all/20261117101910.1820066-1-gourry@gourry.net/
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: as Lorenzo pointed out, the off-by-one mistake is part of the ABI
    and cannot change, we just have to use it consistently.
---
 mm/mempolicy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6d662a9a8c74..e471ce615691 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1749,12 +1749,12 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 			      nodemask_t *nodes)
 {
-	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
+	unsigned long copy = ALIGN(maxnode-1, BITS_PER_LONG) / 8;
 	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
 	bool compat = in_compat_syscall();
 
 	if (compat)
-		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
+		copy = ALIGN(maxnode-1, BITS_PER_COMPAT_LONG) / 8;
 
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
@@ -1762,12 +1762,12 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
 			return -EFAULT;
 		copy = nbytes;
-		maxnode = nr_node_ids;
+		maxnode = nr_node_ids+1;
 	}
 
 	if (compat)
 		return compat_put_bitmap((compat_ulong_t __user *)mask,
-					 nodes_addr(*nodes), maxnode);
+					 nodes_addr(*nodes), maxnode-1);
 
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
-- 
2.53.0

