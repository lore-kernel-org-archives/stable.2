Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C542938CFE5;
	Wed, 15 Jul 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126559; cv=none; b=Q1xmwv5MGAjsfGHVtyopwcf5jW6puIAWuUAkAuKY2SMERsLlt9SDCGCWn9L2E1xzM+SQmGBM87bQyLD1CFzTyXQHejvA0c00+Yo8c7qlOL5p/27uiwJZH3CXfYCtUZUmrr/NCgDZofEOkDlTmHt9J+Mqll223FP3gb+E+9+ieRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126559; c=relaxed/simple;
	bh=vamqCZzsK88iemRihMcPPTqVeb6aNBXuUVyYjTVP0ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAnJ5pBkj6t0ZVO+bchvBB+gBzG1GsSUl3TtEM7xh7fDDmhFPlZ0BX2LpRsUSNBQOCIo+IJ+P5WBOgjyMTMcT/FgYdhxB1V+a6lnKx2ZM4IToalLbzKJuKsB51jJZhyqZO/QZL3hohAV1LDxeUHjnlnB8pe5qRThFSX7QI745c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=zoyBLhW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oLTF8C6b; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="zoyBLhW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oLTF8C6b"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 855837A0086;
	Wed, 15 Jul 2026 10:42:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 10:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1784126556; x=1784212956; bh=O4fAs88PU8
	PfSDLqf7jj03THLume/iu33/P+wiz3f2I=; b=zoyBLhW8Dyb63VF18W2n5sJeVh
	2DkBdw62n9c7peMRioObqRsMJU+binOkxO4ATRTwwvJVw5HlQSGeYzRA52iUOQR8
	lLZZlN2vGT/8ipr2gR8CsUAHa+V53sIu/6H5pommo/yfCYLe7uApOfz4Js7KLlQh
	ermSCm0NnmWm6tRbt3Xc3MU5yd2uPLLGu0rNyOnYxPhgvSSYXN+x5Jox9YN4P7B2
	YTLkyBQM9S1m1P1RbPdRtSgIvOBg1+e3+G1+OZf0+fH3EaZNcAO9ARDtCBaJ+OUw
	KRPC/ppPaW4T49TV7T82TIgT0ZBSu0M5Hva/3wVDhW1RBzkppiFz8TVRq/6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784126556; x=1784212956; bh=O4fAs88PU8PfSDLqf7jj03THLume/iu33/P
	+wiz3f2I=; b=oLTF8C6bdjQWAfFZq5MjRbcBj9Q62IwxoUS9hdu6dk7fFXISb4i
	G4iYf25B8xBYVBYk9TIUOWTHiqZ72QGdCM2eBFN/I9mRaQtAuVK1wy5cEIpcH/iQ
	ixrnKvDEAhHJ/ajGzgaMdy3t5czVdLK+91KrPvpsEN0NqzZB83mHOp4hVz5RWWWh
	btxJBqPxQXDkGLYaIQRAZVseyN9o37c+ws0tbsb9GE6UZwgT7T49E+GVPF+MbkHM
	zYH86qb6UrQZh2dpUnuyEm6c+Te9i0+N4XC/PLtaduiBq3Iac7ckyiVYEEwCxwcc
	Jz1JHnb2v3L1wjqGbbyx3kah1nwbL284vnQ==
X-ME-Sender: <xms:XJxXajmxfaRO-iqmHoYzg9lFDhU-5Gl9Yxt50tAsvQGE1dhDlmEYyg>
    <xme:XJxXaiv6TKEpB-JrY1NnSvEkUGf-mWGKH4Z34CLQfzl3lVRN6o5HDDeN77Xg5Gue_
    FqBlcYraZQaZh7TV3QmXhWm0lEEqTrv-f32JLckdi6xAJ0pDRxRJt4n>
X-ME-Received: <xmr:XJxXalINQckga0XBIco3o1De2T63ZqD-FKkkkwHQU6dPLUXdRbs5wzJOiASasA>
X-ME-Proxy-Cause: dmFkZTEG1jEV0FcsqtAU48Y3TLxFVDgAUFXicFOqtxZWeQi2NNrOkI/0gy+tQRavLR9UFO
    00xLocveBGJCh8tsP0C0qGuOeiDfcfpgGVloAAwET/E3i817oggIs66tBP/lKoY49rvJKm
    iF5Opm3WbNBDLwR3ZymnFRYNzURG+ejz8yI+XnG8zGyH7SQf89KyMoJN1j/EMv5UGsfED2
    13EXmDiswQfIlvflUVH2dr5ATUu7WR6leXGCw2aVd64eSyDTEGWT4vsmLRaoe6y5PWOPfz
    ZYnw4YoYqOhkJgBryC2cXYoZ5QveER5whbamXQnbUQQQL9jkfAJPw0Ag+P75n4TGjCJAD2
    DGjA61sdAIufyWsv8Hu4W/mNNyjAY9oODIe/mLrq1KjReVi1y4w1dntGazIhBl0DcPre9F
    2jfEUSdJHkyBHn2GOC7O0Pp98I6vFRIvJOgZs+iIuavEK1QHTFXniOC7WbZwgmd5lQvinG
    DuSHavyv+3u4uRLwKODRINgvOSDBeNpmI0EUPfU+y93qElAgQkx9iukyVT8wKitbtX+9E4
    xrJ1QV0xNDHvTxUS5jwqQWLDPRLsDlhUhPNpj3CE4dWhupKZN6A+JsnAyaoJhPeacBQt5L
    eVsW0oeqz45uB60b+AsSMkRyfKxN5Zf+BwWoMEf4FIRVR2tLmek9nTet5CfQ
X-ME-Proxy: <xmx:XJxXavhBtdll9C2IFgRq_8XwOc2zAQKJ_0xU4fn41HiWLMMcr_vKDQ>
    <xmx:XJxXapuffedjRT2JcnVC0seRXAVsmzpc7UHfjvzv9EvOkrskAa37VQ>
    <xmx:XJxXapjNIbvQxwM6iAq9IhcnCb80x62lgpwcMHC6iw9Rgyg0yxkZcw>
    <xmx:XJxXakc7BW4Nyp5gOi5w1OC-AygmGyb3Xj4vgWRZXiN9LnVL3tVz8Q>
    <xmx:XJxXas7qJyYIYaYEP3ScfB6UaH9852M7eRCPdkxqqkLzfeqY8B2CyH8L>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 10:42:35 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org
Cc: usama.anjum@arm.com,
	peterx@redhat.com,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	david@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	zenghui.yu@linux.dev,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 0/2] fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD holes
Date: Wed, 15 Jul 2026 15:42:32 +0100
Message-ID: <20260715144234.442721-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Patch 1 fixes PAGEMAP_SCAN reporting a PMD hole in a uffd-wp VMA as
not-written (Cc stable). Patch 2 adds the selftest, split out so it is
not backported.

Changes since v4 [1], addressing David's review:
  - Split the selftest into a separate patch (2/2); only the fix (1/2)
    is Cc stable.
  - Rework the commit message and shorten the code comment.
  - Rework the test: mirror unpopulated_scan_test(), skip-and-continue
    on setup failure, rename to unpopulated_thp_scan_test().

[1] https://lore.kernel.org/all/20260713091710.206548-1-kirill@shutemov.name/

Kiryl Shutsemau (Meta) (2):
  fs/proc/task_mmu: fix PAGEMAP_SCAN written state for PMD holes
  selftests/mm: add PAGEMAP_SCAN test for THP PMD holes

 fs/proc/task_mmu.c                         | 20 ++++++-
 tools/testing/selftests/mm/pagemap_ioctl.c | 66 +++++++++++++++++++++-
 2 files changed, 83 insertions(+), 3 deletions(-)


base-commit: 9795ad96d277c4af049fe30de1cebd4e39d7bcbe
-- 
2.54.0

