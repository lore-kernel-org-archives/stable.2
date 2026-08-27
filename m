Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34D46DFFD;
	Thu, 27 Aug 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838284; cv=none; b=UAvmw2/e60psxtJKw8iwffWcFS48qaoesFxY5n6w0zvuFRn3Q3evk3zhkW2zmuHzSed58WiQqe3nfDxescELWDd+80oYY1Ue3R3pulTVH0LWZxlhyTZFHhiehs/ax4KlAzOLop77z9U1apM2K1jBJXDh9cGJecX0/wuqpkH5qZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838284; c=relaxed/simple;
	bh=9F/LYuNo1vfzrkdBVAEmgYTt7fTBaP9XpE8yGLs37wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auAc0rJuJEsj0s0TgiPqgnzqQmSeytVDfPObrF0Ld6F525QHSn35BlgN77Fx7DXsI/aNrs3lmohc56R2Be15ErgTfm/odDMTxpwH1zhQV8gyRIeUIZVBvyWhbpCOwngxkItAjJEx1K4i0Trt3tr9aoVwLz1bKMMkmsBDlfXXD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B47RYJky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B47RYJky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7181F00A3A;
	Thu, 27 Aug 2026 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787838276;
	bh=MnS4ty+RKYNyC5nGC8tLvTuVTGSdFsmrW5pkVTeJfPU=;
	h=From:To:Cc:Subject:Date;
	b=B47RYJkyewAm9XsyDKqhwZfHkKQIggkE4zsOVvEuX/vLZP7V9HjqH6Q5Vq2Hqiq1I
	 qDLNfcpVknpQi1z9gYdOrjV6JgMnRJL0+Hk3rxdhZPYlaV/DCC+IPtBLhMaJ8jZ6/e
	 BxMfLOwSJCWze6geE7qJ9e2gIqwdRDA320K1xUJV+oKSMFJje0CuiAL+63PHEoA3ko
	 9IFlpg/vJhtW6LnbMkK906ozBBAg1DiEXJ+D7UJQCMuCG+bnsatKArVG9MkdEOcqek
	 XJd1AG4nQ6jGQ/bG98Oz8DcmgYNapzTZT5l1CxNNuje5rXZsutbq1TGhfRr61lgIm/
	 2yOpQ0uvSqyGg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 0/3] mm/damon: fix wrong behaviors in DAMOS quota goals and sysfs refresh_ms
Date: Thu, 27 Aug 2026 06:44:25 -0700
Message-ID: <20260827134429.123023-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS quota goals and DAMON sysfs refresh_ms file have bugs that can
produce non critical but still unexpected behaviors.  Fix the two bugs.

Patches 1 and 2 fix the bugs in DAMOS PSI goal initialization and
eligible_mem_bp online commit, respectively.  Patch 3 fixes the bug in
DAMON sysfs refresh_ms file handling.

Changes from RFC
- RFC: https://lore.kernel.org/20260827042920.93580-1-sj@kernel.org
  (Mistakenly missed RFC tag)
- Fix build error.
- Add eligible_mem_bp nid commit fix.

SJ Park (3):
  mm/damon/core: initialize damos_quota_goal->last_psi_total
  mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
  mm/damon/sysfs: set next refresh jiffies per sysfs context

 mm/damon/core.c  | 21 ++++++++++++++++++++-
 mm/damon/sysfs.c | 11 +++++------
 2 files changed, 25 insertions(+), 7 deletions(-)


base-commit: 9e11dd3caaf0ac70acdc0f568265a7fa5085ef42
-- 
2.47.3
