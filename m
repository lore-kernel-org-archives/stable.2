Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165749;
	b=IClJGt06QsdTl6dcAz8eszQ4W0FvlLAaoYpA6uzDBGlLdiwPiJDza2ykfZk+OSybEM6A
	 xfqXXT4PhANdlbdHiexQJgbTxNUr39oZ/5T4QWXk2Ekep3Z0N1V6Dc2LggqTF7hliRuB0
	 HPYPgj+KLFmQsyM/nzPTnhfeQnf5hvIf81C9QeDUFmvQGcdlrVlfNBiXiqmNBBw7yUQOS
	 +HoNfQrBv6cdnAxt4n0CPMER7z6omTnH/+hzBErcs4oLWg59cNw0BDHge2jwu6YY3al7o
	 dIodXc85nGVX8teFNeDwrr0FPYx3D6KUxOahvERT77AJU44/HRT5Mn5B36T+MbmOciQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ft3w4NHx2XhqSXh6hSv9Ma4EbAR6Gk/3pG2daDXPnLs=;
	b=dq6w0okiPrHKitgloyCbgrupAftqGhYRzkxS9j/ctvmuh4Vjwj9joPFoYYh7/eCXx7iQ
	 fkwvStpHSp4x44hxccaBEaV1RzGXGmx5HWGvBB5qG0xWhsUo+RgJSMNO0L0ipzb3hAAoH
	 q0G4s5BXx/q7FebSSVEvjEXJFnHvvEmoOnxLUiPUuXht4oXQ/SsHR2zWE4PhXAdUZrjtm
	 fpsik4tjhSe3ku5VRPsfk7mYJ+CrsERLpgSvABBrJpwjw57S9mrmr8XONN1G6K5ohqbLv
	 BWy0yEAjKpA4GES1Hp4wAI74MUt+/XkLpWoEny3BR74pFSWhP6q6Bby8B2G9phtorlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gq5aVxEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABF606A31C;
	Sun,  8 Nov 2026 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gq5aVxEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2D1F0089F;
	Sun,  8 Nov 2026 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165749;
	bh=Ft3w4NHx2XhqSXh6hSv9Ma4EbAR6Gk/3pG2daDXPnLs=;
	h=From:To:Cc:Subject:Date;
	b=Gq5aVxEQjhFtWKv0iJoeNxpWJQDtUdPV5yyZ/QQuKgYj1VH6s4vQyQix6AkWVDaXK
	 EPmljqF9krYy8xFTo/OTXpWS9yrFIoZkoO4gzstKPL3LZQXkse4C0Q8ETMBdbhIBCz
	 uX9MXecOUHM9o+8vSCzCq5Vd3Coe6RgpZzjIlrIgOj0JDhT2XtODCTkgtrAdIdYBuS
	 daD4aUXMGHylY0KuETM/kXGJ8IZRuOPLMjJrH8RBHUbevI7B1dosksZvdEqqiSukb/
	 R6CbE8l/04BqlzzUCPIzlhob94f07nzHP/sNbmsUqjfkJfPqtqMcA8bjcq5JfFJUWp
	 pA2epMetNwbxw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.18.y 0/5] mm/damon: porting fixes that cherry-pick failed on 2026-11-07
Date: Sun,  8 Nov 2026 11:22:15 -0800
Message-ID: <20261108192221.114362-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Manually port five DAMON fixes that cherry-pick failed [1-5] and turned
out to really need to be picked.  Note that seven patches [6-12] that
also failed in the same day were having wrong Cc:stable@ tags, so
ignored.

Patches that this series is porting.
[1] https://lore.kernel.org/20261107050847-failed-6.18-90c2fa6adfed@kernel.org
[2] https://lore.kernel.org/20261107050851-failed-6.18-29c6084658af@kernel.org
[3] https://lore.kernel.org/20261107051039-failed-6.18-af19aff38d6f@kernel.org
[4] https://lore.kernel.org/20261107051438-failed-6.18-5695abc4e742@kernel.org
[5] https://lore.kernel.org/20261107051441-failed-6.18-bbeec2d8324d@kernel.org

Patches that also cherry-pick failed but deliverately ignored.
[6] https://lore.kernel.org/20261107050853-failed-6.18-df7d9a0f8d91@kernel.org
[7] https://lore.kernel.org/20261107051022-failed-6.18-6f276422aded@kernel.org
[8] https://lore.kernel.org/20261107051024-failed-6.18-1bfb9384ae0e@kernel.org
[9] https://lore.kernel.org/20261107051027-failed-6.18-1d2397b2c414@kernel.org
[10] https://lore.kernel.org/20261107051029-failed-6.18-cec08aad3def@kernel.org
[11] https://lore.kernel.org/20261107051032-failed-6.18-a1c7fdaf1657@kernel.org
[12] https://lore.kernel.org/20261107051034-failed-6.18-409d2ab6d982@kernel.org

Changes from RFC
- RFC: https://lore.kernel.org/20261107201001.206120-1-sj@kernel.org
- None.

SJ Park (5):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
  mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
  mm/damon/core: remove unreachable damos charge_{target,addr}_from
  mm/damon/core: filter out damos address filter-split failed region

 mm/damon/core.c             | 63 +++++++++++++++++++++++++++++++------
 mm/damon/sysfs-schemes.c    |  5 ++-
 mm/damon/tests/core-kunit.h | 16 +++++++---
 3 files changed, 66 insertions(+), 18 deletions(-)


base-commit: bd28b146e1b6b6048a00f4d240d0f6b2e1db6b3c
-- 
2.47.3
