Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B4325483;
	Tue,  1 Sep 2026 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268740; cv=none; b=TE3VtPlzurMxhhx0rPVJ7xInk+o4APg5ANo8ihEOh6P/TxD5qvSD4vRvfqVCLZPIfJKWWPpv+ZXOHWcp5sc05jroCtQ6JK32K3PHMsTdNEoh38DYibTLfJudiMAteBIzKjfmnRAEh4aXcnV86urYq2MylEtFmzax4eRzWYeolY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268740; c=relaxed/simple;
	bh=yUNM5+u50+EI4TtSaI5kgsm10G6q1gGI2KIWPQ0t//k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnlI37WGa18SuEe+49S2w62wFfmmgfR2EcUekF+Z67mmQtz0/9mUjnt0MKRCEzbSjD0Av9xyBJ8QodF1G3wJnUO/phwHHa/T7O6ONlZhOHDMX5ZfAgstKVtYAGCc6u9t7/AZkC8xqJAAHCzfES65PI3ZO9BVD33JZbAfQcrygO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/r6dn9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/r6dn9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312871F000E9;
	Tue,  1 Sep 2026 13:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268738;
	bh=MqAfrIBx5SvDHugoYUw0lcd20KCbw1hgg2CnccvhE0I=;
	h=From:To:Cc:Subject:Date;
	b=L/r6dn9EC67/opcBAX3umt9W1+djaQGCUF+kuSFFcp+2TcORzFbd3Z0bc0Vpi9NUU
	 s2R3ApF90dBL5shgUoExIvYWPnHHqUSRe39mTY4F9izZh6dLeC3dkpVlOhxWSYfqnL
	 n2IotXA3GxaCr+FYyJ/Bv65wxb1tJo+wjwLKXCNil+YGkBW1NabNNU+6z9914M/TUL
	 vv84Kn0t4Xvkz8j3e8fK4xMPCHcRjWSotZh+0GC8oP4SpJS/YJ8+JXlfkBv2caLIqZ
	 M+Xl1lD5wCcKJt8rh0R0WdwZpgPazAsT8TbAFqqNC8QIk3FT6l/S5n2eiw4flNhTbV
	 lt+SnTUybEVvg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>,
	Yueyang Pan <pyyjason@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] mm/damon: fix DAMOS bugs in core, paddr and vaddr
Date: Tue,  1 Sep 2026 06:18:41 -0700
Message-ID: <20260901131850.98037-1-sj@kernel.org>
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

Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260831140254.72004-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
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


base-commit: 0926ef526f90a707f59c0790cafdb5a9b9cdebe7
-- 
2.47.3
