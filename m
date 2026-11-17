Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925595;
	b=3d7QvVaGHc5zP7ZIQXUhJ52f/jO56hZ8ysYV40+1YnlqBDjDrOSBMoM8m2JUzZ9OW/PJ
	 AhtZJiw0e1fT9naHcGtc9me1JuiGDP3T0Mbjb+9PXOq8+WTJFtuyJBQeirUfZQ3UuxCFS
	 LHefJ5oYsL9OLaTYBWPz8JTmw2UnFOjp0K2wkykth46M73JQip43qUgdfMZTrzB416rDw
	 K69gPWxb+DP4A+oDj7ehdGLd714ExJQocG4wzC8FUsX85xjvFGKx7AG8NLEp3krglDO2A
	 jLSaqaO3CNinlXTHbLfvMKuI8sEe9smcmQM25lwk6Nu9LfPPmLobtjh9Vwo9ZfxSSOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925595;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rlQlNnIZ/8+czgBS03uRUWP6VlvdPXDkWQ0M5ulQFY4=;
	b=km0KasFB5qQ2sFW6nokaro/KbjTklV5XX/PD932hjwkwmKuAwLpqEmEWaUpqXaehOK/R
	 SwAIyKdU6H4QSuxLnSOOgKdTWnI8cUHmloEvpLgguXiBWbbs1pUg313B8sphfaOTXbm1+
	 VfPpiT8TFeEIbF2JrGIYCRrG71wbrwiXMdqoo3Ex9PpOc+x0OrCnEYd2TMEIHodMeWcD/
	 KUDuHhsQCBVqdQm6+EHYd/k/QJyxcBIYTAn47XULsEk9kHfDYutHwQZiJ+hNFs67iL14m
	 5tJou0fMlHHCcwDD507o28vbVdVBSFluKeLTS0U6BzMZ+/yMGSzruGGcr+W8dGBhb8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a786Rfbu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62555606A323;
	Tue, 17 Nov 2026 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a786Rfbu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97441F000C4;
	Tue, 17 Nov 2026 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794925595;
	bh=rlQlNnIZ/8+czgBS03uRUWP6VlvdPXDkWQ0M5ulQFY4=;
	h=From:To:Cc:Subject:Date;
	b=a786Rfbua0e0KJuPtqYPrAIOolUAlNtoH1SVZATqAvSLv5QCYzTn6e5ZZA3a3CXny
	 cfYU2pdCDUr+8PSpqVQH45cyGXtnH0KcTKXZChHeqW3yCdz2yvjSv3dER9ldKvWinU
	 pRybFcIIIcJ1x1gVcDse8TFcN3hO2F6bLrYBQvCAo6D7TOleOtwQ53V5oGlr7EKEM0
	 kK5eXgT7ULE0fn5gQuNToj51Fn2ORWLRIoFLkaNQ4ZmXOovexDaF5bhF8n25xErblJ
	 uVZYrvqMo9ETwQcBDzyZjuDO+zGRShjt5/qw3N8oqLjMr8+LEV7EHw19Fgm3n0obgH
	 2R7eQdFuYIeTQ==
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
Subject: [PATCH] mm/mempolicy: fix copy_nodes_to_user() for odd inputs
Date: Tue, 17 Nov 2026 15:25:53 +0100
Message-ID: <20261117142628.3931151-1-arnd@kernel.org>
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

The ALIGN(maxnode-1, 64) check has an off-by-one error that leads to
rounding down too much, and ends up not copying the last word when
userspace asks for one bit over a multiple of 64.

For compat syscalls, the effect is worse, as the actual calculation for
the size does include the extra word, but the check for the input size
does not take it into account and can leak a word of stack data.

In addition, the size calculation rounds up to multiples of 64 bits
instead of multiples of word size as documented in the man page and
expected by numactl.

Fortunately numactl always passes multiples of 64 here, so none of
this affects userspace we care about. Finally, the 'nbytes' calculation
for compat mode makes no sense since that is the size of the kernel's
internal representation, not the userspace side.

Fix the 'copy' calculation to address all of the above. Note that the
off-by-one error has been in there since the beginning, but commit
e130242dc351 ("mm: simplify compat numa syscalls") is where we starting
copying the wrong data.

Reported-by: larips <larips950@gmail.com>
Reported-by: Gregory Price (Meta) <gourry@gourry.net>
Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
Link: https://lore.kernel.org/all/20261117101910.1820066-1-gourry@gourry.net/
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please double-check the calculation and retest this with the original
reproducer. The off-by-one error does explain all of this, I'm still
worried about getting this version wrong again as everyone including
myself seems to have missed this in the past 25 years and there may
still be additional subtle issues around it. Apparently we had many
instances of the same off-by-one in this file but all (most?) others
got fixed inadvertently by other changes in the past.
---
 mm/mempolicy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6d662a9a8c74..f318e1155770 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1749,12 +1749,12 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 			      nodemask_t *nodes)
 {
-	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
+	unsigned long copy = ALIGN(maxnode, BITS_PER_LONG) / 8;
 	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
 	bool compat = in_compat_syscall();
 
 	if (compat)
-		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
+		copy = ALIGN(maxnode, BITS_PER_COMPAT_LONG) / 8;
 
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
-- 
2.53.0

