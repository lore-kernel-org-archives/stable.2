Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A83AE191;
	Sun,  2 Aug 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688001; cv=none; b=UDD3cvu4xGJNJLBVzT854zDIyBEaf2uEVoR+zN+ycQUBmdheNnz7FB/D+AZvWOFIiJ1j4B0Y0Kgi8XobTfsIeemWg3Kn1Fa/ZKng4jhMeyJ2pB+IAOp+PHUng/4Jt/PYVVKRYZZ2XzI5Ep1xokzpEMikL26jwBKFtTY/evjQpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688001; c=relaxed/simple;
	bh=IrR//9SeONznRaq+RQrnAhqX3WSUklUMTBpwTC/aRgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8nVXr/DGQR+19ES10SDUHe4GF5KGQ/ATSgThNZHkoZ1DE4wMVPuj0MwvABbZa3aVeARNsM1nDgFNSSVnuD2excP/UalYzFuSHvJhCt1tkhsIrBC0AN7bkI2MawSfg9K2KuUi2zpKsYIofPRRW7E+5uy+YsFBZ6T2SJOBEbkQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpGRnd5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpGRnd5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221E31F000E9;
	Sun,  2 Aug 2026 16:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688000;
	bh=IGCINO/SWEhcdDZT6Rs7xP4paJCTjootNamfovWsNx8=;
	h=From:To:Cc:Subject:Date;
	b=VpGRnd5wb1TGHH2yVTvKKt7gt559B5Fsyf+0aoryOVBfpVQvbkRRyZloEG7+VC3/t
	 gvOfMvKTT++vfALmsuCfaxj27NDqS80KSi8Bbj9AXQ1RTFr9PqhOpEg2eIkoiQkG/R
	 uGZWNVmawo7KX28etI8LpzJQ2PATd+HrtUkoooKsMY7qxO4tlj8KeiSennLvVbnBE5
	 Nx+sGkyybIdweDudkhozsWjsibmtI8WOVbvt6lD/rtAjp9Iv8XCmZU9eDmkkE5Bjks
	 +XSgL9k5DyciHPhusNV98s/J+Yl6ohfXbOF/IghMuW9SEIQ/hg1FBwPxjTqWLmWlIA
	 QHQu7OnFJXXAw==
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
Subject: [RFC PATCH v1.1 0/9] mm/damon: fix DAMOS bugs in core, paddr and vaddr
Date: Sun,  2 Aug 2026 09:26:21 -0700
Message-ID: <20260802162631.90304-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misc bugs of DAMOS.  Patch 1 make DAMOS less stress memory allocator
under extreme situation.  Patch 2 fixes wrong DAMOS quota auto-tuning
feedback loop start point for PSI goal.  Patches 3 and 4 fix wrong
folios walking in DAMON_PADDR.  Patches 5 and 6 fix wrong folios walking
in DAMON_VADDR.  Patches 7-9 handle extreme and unlikely memory
situations that can cause divide by zero and underflow.

All bugs are discovered by Sashiko.

The bugs are not very critical, but better to be merged sooner than
later.  Since mm.git is closed for urgent changes, I aim for 7.3-rcX.  I
will drop the RFC tag after 7.3-rc1.

Changes from RFC
- RFC: https://lore.kernel.org/20260801173554.94710-1-sj@kernel.org
- Use cached pte content (patch 5 and 6).
- Handle totalram < freeram case (patch 7).
- Fix wrong function name in commit message (patch 9).

SJ Park (9):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/core: initialize damos_quota_goal->last_psi_total
  mm/damon/paddr: respect folio end for DAMOS_STAT
  mm/damon/paddr: respect folio end for DAMOS actions except STAT
  mm/damon/vaddr: respect folio end for DAMOS_STAT
  mm/damon/vaddr: respect folio end for DAMOS_MIGRATE_{HOT,COLD}
  mm/damon/core: handle extreme memory state in damon_get_node_mem_bp()
  mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
  mm/damon/core: handle extreme memory state in get_in_active_mem_bp()

 mm/damon/core.c  | 37 +++++++++++++++++++++++++++++++------
 mm/damon/paddr.c |  8 ++++----
 mm/damon/vaddr.c | 10 ++++++++--
 3 files changed, 43 insertions(+), 12 deletions(-)


base-commit: 481be0db7cfd092f0aea64e65ab0a9cacff88453
-- 
2.47.3
