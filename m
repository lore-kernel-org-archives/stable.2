Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792946900;
	b=fjmnxZ5zrrt7aBlWLtFAUBfCr25Bb0q9gKJqJOXGjn0D6hWCMh9AodIOiVs+0lPF2pg4
	 Umkf6X1MdND1z7p6hYP8DM3PzDE0x76+/MLQrgXIUF4f/x84c6rNIYJAi1/OQLTO4MI0F
	 IF9+Hs5F01chqQT1KcXCg1hqg5byPQOp0zJTeZ0rD7ZdAAymVPdWnHZTeJwxTIA1Rwy7q
	 e5ETJvTLd1ppCHOeGHETC43JRstzm9ECwhkbL+i+8Fe58hvtEXYm3X5yUub1/H1maz9Jd
	 appmg3G60PxBwgXUNLePpNSofReQcGseWwJL7DODS4oMh1QkmyO1wWlHbDob+9T9f0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792946900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Q80p5MCUlafYdcYjwuOtEqPOJb6ACREJHt1LW8otA0U=;
	b=BIR2UBVbsuzGLwnCZdpNA0eY+s/in87qI7ohO0DFYubX58RnS32EB0VoDpG7pPNjZwY2
	 DfBQj6YP+t5f1VIWC72s/5E8w9H40f2Im98MLhKaPjqOPLEksTXzU+hYmd7/Xgw5EHqN9
	 YRM6NH4m5f55B8CIHucl/2WzzNul0Cfy1vym6O94cELRyNMv6hOQDlolpXE5MsaGskvr0
	 qzCZJF8aAN58juiOROwBxc7j70mxuHxpUed8gxviUR7MkejL06/APgqsiUzUxDgIMP31c
	 pkToWNjD9il5KonvhW5KWERb93VM9iI3eL3j7Q73D42wf4OTp42gajXtiK6JAIMykZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BE59L+tX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934F606A31A;
	Sun, 25 Oct 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BE59L+tX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F6E1F01825;
	Sun, 25 Oct 2026 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792946899;
	bh=Q80p5MCUlafYdcYjwuOtEqPOJb6ACREJHt1LW8otA0U=;
	h=From:To:Cc:Subject:Date;
	b=BE59L+tXgKsr6xmG/v2ova9IBI5Ez0pYWp5yRRfHpJgTtL9+iX+yTdY7eS/Xfk/w3
	 jLfAWkaugebck40qc3kL1tzD462m8fb9d9PbCdA/lv8PyLcTzF89tARN3sj0FKPrwM
	 nYiwCeVa5orPCVQfJE0AWBT8xENUJk7d0b0LZDlN6868enbv5i7EQvD2PCzSyEEEjf
	 tO23WIIWmat/Dfb7et2QEjrCRjPBBxdOjMDHEzsgnkd7iaRdkq9KWinnBkGXn0X8+c
	 gaD4QRhwd95iFVVHPgRE4ud8rrqPSCMadF1j0/kIQLo3UHmS43f1Hf44zdJZ1hYX0u
	 wZI+FrfvFOGHg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Fernand Sieber <sieberf@amazon.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm/damon: fix three race bugs in sysfs and core
Date: Sun, 25 Oct 2026 09:48:03 -0700
Message-ID: <20261025164808.152048-1-sj@kernel.org>
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

There are three race condition bugs in DAMON sysfs interface and the
core layer.  User impacts are not critical but better to fix sooner than
later.

Patch 1 fixes a toctou bug in DAMON sysfs interface that can mess up
DAMOS auto-tuning.  Patches 2 and 3 move static variables that can be
wrongly shared with multiple kdamonds and therefore make DAMON
monitoring results be a little more indeterministic.

Note for Andrew.  These are not urgent but better to take the hotfix
track in my humble opinion.

Changes from RFC
- RFC: https://lore.kernel.org/20261024193351.87130-1-sj@kernel.org
- Rebase to latest mm-new.
- Drop RFC tag.

SJ Park (3):
  mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_metric_store()
  mm/damon/core: move static variable last_nr_regions to damon_ctx
  mm/damon/core: move static variable rotation to damon_ctx

 include/linux/damon.h    | 10 ++++++++++
 mm/damon/core.c          | 10 +++++-----
 mm/damon/sysfs-schemes.c |  3 +++
 3 files changed, 18 insertions(+), 5 deletions(-)


base-commit: 34b81edd2a3300a88493222637ea010223c00ecd
-- 
2.47.3
