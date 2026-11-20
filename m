Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200775;
	b=mB6LJ1rlfOFFURILVC0jN3lsBnawUpfGeXU6Y84AC+fP2x1+QaWeE7URm6t+PFscipCk
	 rdeuDibLKSCMwpe+ofOYov0U6Ien1rYaXQj77dLAK0AYhC5Ph/Auz6G3qRQFZaKA1PWwL
	 U+G3LssJyruaa8ALE01Z4Gt0HehqCcW9rm220gS9Y2I9vzy1katttyJPYICRg89UvH9QP
	 ifSNQnKkVmiJtxvQU+cj/fMixDSa1Bkk6UBjpCvL+UlSvREtV+BSKMgTJAdQdqYyEK+N0
	 SpOWmUBDeqqNu+qtTDdNnVCj7t6Or9cERblDd51jbQ0E4uCZZEzVHj2lZFLgOuOF1LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200775;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vFu71F4VU/EdQcXZhad8GczLSYIVyzi2P+9OjoRpNEo=;
	b=gkkV9ai84il6jMv1T+VTVcwmdVTPqLaULYKKwTl7/Fj4DzyQBwdCGNFVzbZzFSM7l5k8
	 J8cpcCScEEGbtx3/VWmnTxtK1chaQClHMI6/BvQ8Q1EgiWg28pLN1lvGyEB8TKwInsqnM
	 bwmPcZaz4lrC48uHmMQtFxYPGZMMtqOvL4am6Bh3l71V7bkusrPIn14bFwBIXd0h3+qnt
	 H+5cTNDleBa+If1FTgKhfBm3MUTr84FpQ/79tVqPl9XIEo9wAYvuV/2hxWnqPGWbOtUOt
	 vNaBpyRwMyOK0nd9/G2FLbeptVG75ln/6as+pqc8TtJba/hTzRDdqoTIJP929IXgEuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGNmkv8B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937D60A2611
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGNmkv8B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C761F000C0;
	Fri, 20 Nov 2026 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200774;
	bh=vFu71F4VU/EdQcXZhad8GczLSYIVyzi2P+9OjoRpNEo=;
	h=From:To:Cc:Subject:Date;
	b=iGNmkv8ByFAtY7Lm/PR+Fg4PUMeb2KRjz4XSN/5mJuVUXppzYRSjYAKIzjQl4jm1V
	 +ugc2KySZr5runzMywFHgV2FKrFo2rd6RUCGXuxAP7DzUFFUyUl/NMnrbBSRaffJZD
	 cE9B9XLUH12iMVnVosV1hIuGgZFmL5inkuIUKSup6Zxujcdi1vRRDnM21mW21sunnO
	 qoYeiOmE/wFf7Y16T4swiyol6EmXZHCBn5jlBcsOozuetRyN6nmhXaBkLkpqjGDLa3
	 D3aW86B34td0Kz2CtXE41VH349f0EGhcZ+LJxRysbYTvQ2wTCKFPM+f9HXhioNoMnr
	 HZRUKc3GdYugQ==
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
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org
Subject: [PATCH 1/2] [v3] mm/mempolicy: fix copy_nodes_to_user() for odd inputs
Date: Fri, 20 Nov 2026 19:52:12 +0100
Message-ID: <20261120185248.823415-1-arnd@kernel.org>
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

copy_nodes_to_user() is broken for compat userspace in three
distinct ways:

 - Passing a power-of-two size plus 1 as most normal userspace
   does can end up calling compat_put_bitmap() with the wrong
   size, copying an extra 32-bit word from the stack into
   userspace and overflowing both arrays as compat_put_bitmap()
   expects the actual number of bits, not the number plus 1.

 - Asking for an odd number of 32-bit words rounds up the
   userspace buffer size full 64-bit words, leading to
   an out-of-bounds access in userspace.

Fix the calculation of 'copy' to be based on the userspace
word size and use this to for calculating the final number
of bits to copy as well.

Reported-by: larips <larips950@gmail.com>
Reported-by: Gregory Price (Meta) <gourry@gourry.net>
Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
Link: https://lore.kernel.org/all/20261117101910.1820066-1-gourry@gourry.net/
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: don't introduce a bug that skip setting a 32-bit word to zero
    where needed.
v2: as Lorenzo pointed out, the off-by-one mistake is part of the ABI
    and cannot change, we just have to use it consistently.
---
 mm/mempolicy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 62d4c9e57035..afe614efb77c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1772,12 +1772,14 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 			      nodemask_t *nodes)
 {
-	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
+	unsigned long copy = ALIGN(maxnode-1, BITS_PER_LONG) / 8;
 	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
 	bool compat = in_compat_syscall();
 
-	if (compat)
+	if (compat) {
+		copy = ALIGN(maxnode-1, BITS_PER_COMPAT_LONG) / 8;
 		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
+	}
 
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
@@ -1785,12 +1787,11 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
 			return -EFAULT;
 		copy = nbytes;
-		maxnode = nr_node_ids;
 	}
 
 	if (compat)
 		return compat_put_bitmap((compat_ulong_t __user *)mask,
-					 nodes_addr(*nodes), maxnode);
+					 nodes_addr(*nodes), copy * 8);
 
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
-- 
2.53.0

