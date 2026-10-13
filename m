Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64B36F8EB;
	Tue, 13 Oct 2026 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851227; cv=none; b=JJ+CBgCWHr1Og9ROR3hQW5GPwyLuEBfv/NWTyx2a8PAaBQPt9VeE2C57uCTCBaqoz93yqBOCVON2pFT3bq5ZPLr7y2Ofa54RQVg36SlnkYIWJRydLYvrv0dSTJkSLj2b4bvz2LUpDFoszNwvrxPQm1UhGGwdEzxDf5oAj96dyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851227; c=relaxed/simple;
	bh=PyTViPKIo6zP0wstwRlry+UZCuAJbuvP2KAXh17+Tok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IS08Wb7ktc0zsk4b7zq/4MuhC9kHkr9eXaM+R7bfXKFnfp1Vi1HFqHGC2fQ3aygKysMgJJxuseWsqH4lfQSFo8qIkyaWz1OScHIX8qN91gq1tiiy51wucNsKgyTsVx/T+znIoZ18+W+X9yArZsQE1BQqv0ZA/CD776rJOOxPDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xGQMC-00GgqH-3E;
	Mon, 12 Oct 2026 20:27:04 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1 0/3] ida: fix the allocation failure paths of ida_alloc_range()
Date: Mon, 12 Oct 2026 20:27:00 -0400
Message-ID: <20261013002703.773923-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These three patches fix what ida_alloc_range() does when its xas_store()
fails for want of a node, found while formally verifying the function
against the kernel binary, where its resource accounting could not be
established against the code as it is.

Patch 1: the bit set in a new bitmap before the failed store is not
cleared again, so a retry can store an ID that nobody owns (exact-ID
callers then get -ENOSPC for a free ID, and the chunk's bitmap can never
be freed).  Patch 2: the bitmap of the failed store is leaked, on the
-ENOMEM return and on a successful retry.  Patch 3: the node
preallocated by xas_nomem() is leaked on the "nospc:" exit and on the
-ENOMEM return at "alloc:".  These need an allocation failure under
memory pressure and, for two of them, a concurrent allocation on the
same IDA; they affect every ida_alloc_*() user, so they are tagged for
stable.

Patches 1 and 3 add tests to tools/testing/radix-tree/idr-test.c which
use the node cache callback of the user-space harness to run a second
allocation in the window where xas_nomem() has dropped the lock; they
fail without their fix.  The leaks of patch 2 cannot be reached in the
harness (it cannot fail a GFP_KERNEL node allocation or let a
GFP_NOWAIT kmalloc() succeed) and were reproduced with a user-space
copy of the function with fault injection at its four allocation sites.
The complete lib/test_ida.c suite and idr-test pass at XA_CHUNK_SHIFT 3
and 6, and in x86_64 and RISC-V defconfig kernels with CONFIG_TEST_IDA=y
booted under QEMU; lib/idr.o builds without warnings with W=1 and C=1
(sparse) on both architectures.

Nickolai Zeldovich (3):
  ida: clear the bit of a bitmap that ida_alloc_range() failed to store
  ida: free the bitmaps that ida_alloc_range() fails to store
  ida: free the preallocated node on the ida_alloc_range() failure paths

 lib/idr.c                           | 16 ++++--
 tools/testing/radix-tree/idr-test.c | 77 +++++++++++++++++++++++++++++
 tools/testing/radix-tree/test.h     |  4 ++
 3 files changed, 94 insertions(+), 3 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.53.0

