Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792870439;
	b=xAzssHrprEnT6X+eTkhn0tdWykJ5UFOsSufSXs8Y4oaJno0EJZNi+/tygEVSN9xCyeXu
	 FlSiZTmq+C1OxlZ4fTX4f7/3XFMxYgg7fgB84KQSSAP0y2b08BrO1ZAjDxTqv+a8HOQ7Q
	 YZFzc7CTXJx6jSXVwmGPssW7waVWUku8Uq3uzan7fETS50sWkMCarEUN6WsVbWgpvTLAW
	 hl/xic9o/5ruLAU7DBefZkkJGDsFOAzkx7w4UkyXu/UuUlMpO9S64jYTwPiGQAxSSQ4th
	 RCeDBX4T2hyLh7Gvwf4t+/tgF0ZPYu906OhbRvPqXWdmfpEYhXf1Q6l7pdNwTZwyeKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792870439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B+9LPpeyWJrESAgg+ZQjlbIQ+zZneFd2FYznRyvKzQ8=;
	b=aHk3Cmdl+wjBSVE44ar/2+MCAj6KdTpHwYyPimroNiRLAtaj/IeA3j0Vg5VA8PjRDrCg
	 aXKGup+K3b1OQiPVPqhgP9cM1BHceJp3meHMbccl52RRgDS99ntXW/N3TK0kgSDIzLR1f
	 Ii16UrEzNSqqk3gOoHmmR5fOSodszCOS8VGqnNWUMT+iZufenxdyfTAMLrLgFChvnl4+a
	 oVIilYh3oBaI7ACuDmUeFS3ooQAkUl0NSLeL9njit3IdzA2KFi3unVPvEMp8wFvoQgUT9
	 8LpjihQESDLsVe2ZHr0WslFXPz4sTms8dVgeh++/C4ewgEbyOFeGAFO1yBrFVVfLqsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i/aG3jxE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88179606A31A;
	Sat, 24 Oct 2026 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/aG3jxE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15F01F01825;
	Sat, 24 Oct 2026 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792870439;
	bh=B+9LPpeyWJrESAgg+ZQjlbIQ+zZneFd2FYznRyvKzQ8=;
	h=From:To:Cc:Subject:Date;
	b=i/aG3jxEddkj7xtQ9f3WYVMpUdNeqlPxwj4ciVD5BchuvceGln2DXw8sx1RReEiFR
	 yUVmEz/gLrY0iuGzOCzT4ZOJT0370ye3AB8krrxnKd1wmKG1YW4DrpbEPlesZhv3gf
	 y5buFfvDheBg474TrlT/ICDVbdESfWutV7RXpmfqvU1t/wAp+HSLivn9EOu7N+z0S1
	 ABLrHwhEMrzZLab5gnwJDJ6x81N/vjKB0x6VwpDFANxz0cRUq32O4u92UzI5ARUJ8a
	 Yp/czdUdLef0U0qPRlP+nfgwhdj3z14nxxu1b8/M4Gugutxah8A+1MBS8RxE0UYQ4e
	 AbWFYk7IdHHKQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/3] mm/damon: fix three race bugs in sysfs and core
Date: Sat, 24 Oct 2026 12:33:46 -0700
Message-ID: <20261024193351.87130-1-sj@kernel.org>
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

SJ Park (3):
  mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_metric_store()
  mm/damon/core: move static variable last_nr_regions to damon_ctx
  mm/damon/core: move static variable rotation to damon_ctx

 include/linux/damon.h    | 10 ++++++++++
 mm/damon/core.c          | 10 +++++-----
 mm/damon/sysfs-schemes.c |  3 +++
 3 files changed, 18 insertions(+), 5 deletions(-)


base-commit: f390255d9de653f4e7a9bae8c9a5ad881ad25a87
-- 
2.47.3
