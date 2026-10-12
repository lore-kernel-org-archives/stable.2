Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AE3B3C13;
	Mon, 12 Oct 2026 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849570; cv=none; b=rk7OshSxqCK9IJs6u4SIFuCRiODsbKaeTuTK7os9CHmZ7fLPBxqY14wSKOPtONO8yZUPIOQUnUcWwESP6QL3+rkosTPJrHQYy++taHIRr0huBEZBheTRhCD2PwU76cTtMQMGIYNQ3r3mp/S8nXL9kCOSlhTKMrK094AuKfaBN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849570; c=relaxed/simple;
	bh=4YLJeNkoBZLBvwMDnXJDHrf+uR1XgQr90jD0vXxjqpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVTQ7vS4n+fCDVYqKbxkRJXjpEMuT/obatcD/nD/FAh8RN+vRIMiVPGWH705Au0thSfxlPZ9dKy94oRnlQkAjdE9zSRBaIJ/lpn4+nD23RxpG724U8may4M9Fvy/0zoOVvki+lewdNG5HeTHwvLQDt97jdIJBn0kO4J6jdmAjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xGPvK-00GbRU-HA;
	Mon, 12 Oct 2026 19:59:18 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: "Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v1 0/2] maple_tree: fix RCU-mode destroy of trees without MT_FLAGS_ALLOC_RANGE
Date: Mon, 12 Oct 2026 19:59:16 -0400
Message-ID: <20261012235918.773421-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Destroying a maple tree in RCU mode marks its nodes dead and leaves the
freeing to an RCU callback.  In a tree without MT_FLAGS_ALLOC_RANGE the
internal nodes keep their metadata in the last slot when it is unused,
and that path gets the two cases wrong:

1. mt_free_walk() takes the metadata of a 15-child node for a child and
   dereferences address 0x0e + 0x24 from the RCU softirq: oops, panic.
2. mt_destroy_walk() "clears the metadata" of a full start node after
   its slots were rewritten, which corrupts its last child pointer;
   mt_free_walk() then frees the wrong address (double free or freeing
   a live node) and leaks the real child.

Both come from the v6.3-rc6 RCU fixes: 2e5b4921f8ef cleared the metadata
of every node in mte_destroy_descend() and once more at the end of
mt_destroy_walk(); 790e1fa86b34 dropped the per-node call.  Patch 1
restores it; patch 2 removes the late call, which then only does harm.
Patch 2 depends on patch 1.  Both are deterministic, no race needed.

No in-tree user reaches either today: every tree used in RCU mode has
MT_FLAGS_ALLOC_RANGE.  The API allows RCU mode on any tree, though.

Found while formally verifying the maple tree destroy path against the
kernel binary.

Testing: each patch adds a case to lib/test_maple_tree.c that fails
without the fix (userspace suite: SIGSEGV, AddressSanitizer bad free;
kernel: oops at boot, KASAN report) and passes with it.  The userspace
maple suite passes; x86_64 and riscv defconfig builds with LLVM=1 have
no warnings, W=1 and sparse report nothing new for lib/maple_tree.o and
lib/test_maple_tree.o; x86_64 (also with KASAN) and riscv64 QEMU boots
with CONFIG_TEST_MAPLE_TREE=y pass the maple tree tests.

Nickolai Zeldovich (2):
  maple_tree: restore per-node metadata clearing in
    mte_destroy_descend()
  maple_tree: remove the late metadata clearing from mt_destroy_walk()

 lib/maple_tree.c      |  3 +--
 lib/test_maple_tree.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.53.0

