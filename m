Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4A39150A
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075547; cv=none; b=JG1AOStdNh3HU5BdgCIdZ1xXi/LeyMEn/aIw5DkkI1xdpJti26RV2nS55qBJSjiglKIY2dYbxHhMvksI8Ap2EvjF072KXAsqyQv3vD9lw+NlkUzfzU+zljoVS47JHYvtPkL5qGyaiHT2t9MDQhyC4KuvHiuvYpOhutlc1m3FBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075547; c=relaxed/simple;
	bh=KqaFdb/wIMrXU4NJPIxv7mUtFJvHfRoARGXB/EwsKBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OFc1SkwyB+aU4kkAS2kqmxD95AFAMGx/zhu5MlXCtz9kD8f936PS1VI1/7qFQP3pMewToh3zooUb08H10Wxa9Zuf1agbJexIAAng/IPVeq6QoYpl9SNNsL53cDK926j8PP4oLvjuET0FOch6c12pu1CaS+wGHxEFSkR4unRxA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=eKHkaJsb; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="eKHkaJsb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792075546; x=1823611546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mno5u7ZzRZU/+mTenUA2QzGfL90+kMbsdzEVFvrdQKc=;
  b=eKHkaJsbmurS9NLwM2jqv+pq5YGenNBVicwbiFPc0NsHtdMTK9vYRm5d
   I58P+g2/QIP1w1LfkOaL2cdEO8dncD9XYfpTP/6hc60EDb+q6ARbpr6Pf
   FKUhvIU0ADnXskOe2sPGNftMxy0JN3COsd+8ZLuHiWcqDLkqf/yIaEjgf
   PCPZns7ClGL/+D9Hiu8a3NuPHh+HnQAcvVfkm6pCqIs7PPiej5wpPr+lF
   I7wrwR8tLRGNSe7hqs8mRLJ4zSrJ7CLHA7Sz0LW4SZx86BgartB8pyLZB
   yOvjZBQbg2rf8hOX/qshUpLmS4Wjvr6KvB9TMTxFSRgn7ra3aYO0QuMUy
   Q==;
X-CSE-ConnectionGUID: TQuNEdILSB+qoRk8DsfdOg==
X-CSE-MsgGUID: AMc/D2JPQk2nJkK7XniR7A==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31325232"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 14:45:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25214]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.1:2525] with esmtp (Farcaster)
 id 42897119-f455-4005-98a6-06b7136192d6; Thu, 15 Oct 2026 14:45:43 +0000 (UTC)
X-Farcaster-Flow-ID: 42897119-f455-4005-98a6-06b7136192d6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 14:45:43 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 14:45:41 +0000
From: Federico Parola <fparola@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH 6.18.y 0/2] kho: free buddy-allocated metadata with free_page()
Date: Thu, 15 Oct 2026 14:45:27 +0000
Message-ID: <20261015144529.76911-1-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Commit fa759cd75bce ("kho: allocate metadata directly from the buddy
allocator"), merged in 6.18, moved the KHO serialization chunks and the
preserved memory bitmaps from kzalloc() to get_zeroed_page(). Two places
still release them with kfree(): kho_mem_ser_free() for the chunks and
__kho_abort() for the bitmaps. kfree() on such a page hits the
WARN_ON_ONCE() in free_large_kmalloc() and returns without freeing it,
so each aborted or failed KHO finalization leaks the metadata pages.

Patch 1 is a clean backport of the upstream fix for the chunks.

Patch 2 fixes the bitmaps and has no upstream counterpart. Upstream
removed the tracking teardown from __kho_abort() in commit 99cd2ffac697
("kho: don't unpreserve memory during abort"), which relies on the
unpreserve interfaces and the notifier removal that came with 6.19. In
6.18.y, KHO users still preserve memory from the KEXEC_KHO_FINALIZE
notifier, and the teardown on abort is the only thing that drops those
preservations. I kept it and changed only the free; patch 2 has the
details.

Federico Parola (1):
  kho: free phys_bits bitmaps using free_page() in __kho_abort()

Pratyush Yadav (1):
  kho: free chunks using free_page() instead of kfree()

 kernel/kexec_handover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.3

