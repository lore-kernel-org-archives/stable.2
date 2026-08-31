Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E44854F2;
	Mon, 31 Aug 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184983; cv=none; b=EFrqO1MsORt+F0ipz5rA+p++wAMba5/aJ19PLPbZbuDE6PbxY8m51+lkJRUvM688oPrPJzX2CajKebVNZhvoEnSzkrt0VUlNB++0fo3aLRxBMqJBYhW5Fk22guFnqGtued62ckjNWPaV18T7fPRtdKPM4iD7EbZhdAPxEsV2ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184983; c=relaxed/simple;
	bh=ZgzJ8xNsJonkAYjq+FTVYNFVRbALFz9xF6x+nNbB9bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ihzb+fccJ7oZBwFSZWCa2SBKFVki3zi2VpwPY3DEV3IzVIPyUqNZ6H0lsklcMCfGpvLA2lRpeTaj78BfbjGhJUAozUA6CHskhT0VJTiP+UKw4dMcqrvPbQlfuXHRDegVGac+lVAqK3G+fCd5c8w6syUHjdA9J//BoB1QEPnlbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWF0A9jU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWF0A9jU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E351F00A3D;
	Mon, 31 Aug 2026 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184982;
	bh=paIdgif6hw8T3V3Zj2lvN5z7nl45Qgmr3NwmsBxfwpA=;
	h=From:To:Cc:Subject:Date;
	b=VWF0A9jUIsDIf4RCs5BXyowwOSvrSz3CgGBYwd2l6Ijs0Ap3U25FEVv/GLHswkXgU
	 tK5JOF4gDLPa3K258uM691drUtp40UT/n3wKxRQcP7hgo7ClbsLlUW78bxF2+XuSPT
	 7xAkjrwCyejfH3CSSEosqAtFoOuWWJ0sMc6+VS2VnMgz9i+KmUaagAgLBGTbRozI0I
	 kylJpb5iEgxbHFR21rS2l7LUSZHrUxgab3XZhKE3i9DFZMrZJz5iBYV7TWR4OP5g3P
	 ylR5Z12bVJ7nPCpL1y2wPs4nygz9+LbqX/cwd+kUHLeJOcH2tsrvY2YBIUfBkst2Aw
	 ykkiRGmTbj+8A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 0/8] mm/damon: fix DAMOS bugs in core, paddr and vaddr
Date: Mon, 31 Aug 2026 07:02:39 -0700
Message-ID: <20260831140254.72004-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misc bugs of DAMOS.  Patch 1 makes DAMOS less stress memory
allocator under extreme situation.  Patches 2 and 3 fix wrong folios
walking in DAMON_PADDR.  Patches 4 and 5 fix wrong folios walking in
DAMON_VADDR.  Patches 6-8 handle extreme and unlikely memory situations
that can cause divide by zero and underflow.

All bugs are discovered by Sashiko.

The bugs are not very critical, but better to be merged sooner than
later.  Since mm.git is closed for urgent changes, I aim for 7.3-rcX.  I
will drop the RFC tag after 7.3-rc1.

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260802162631.90304-1-sj@kernel.org
- Fix wrong commit message (patch 7).
- Return 100% and 0% for used and free memory (patches 7 and 8).
- Drop incomplete last_psi_total initialization (patch 2).
- Rebase to latest mm-new.
Changes from RFC
- RFC: https://lore.kernel.org/20260801173554.94710-1-sj@kernel.org
- Use cached pte content (patch 5 and 6).
- Handle totalram < freeram case (patch 7).
- Fix wrong function name in commit message (patch 9).

SJ Park (8):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/paddr: respect folio end for DAMOS_STAT
  mm/damon/paddr: respect folio end for DAMOS actions except STAT
  mm/damon/vaddr: respect folio end for DAMOS_STAT
  mm/damon/vaddr: respect folio end for DAMOS_MIGRATE_{HOT,COLD}
  mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
  mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
  mm/damon/core: handle extreme memory state in get_in_active_mem_bp()

 mm/damon/core.c  | 18 ++++++++++++++++--
 mm/damon/paddr.c |  8 ++++----
 mm/damon/vaddr.c | 10 ++++++++--
 3 files changed, 28 insertions(+), 8 deletions(-)


base-commit: 59a8d789d9478797978640a7a640b086ad400b37
-- 
2.47.3
