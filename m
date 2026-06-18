Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A225C818;
	Thu, 18 Jun 2026 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744224; cv=none; b=R+WRQqpq3FOtY/Gzw1GYRpMlPQleO7uSThefYorUbcbgZB2kLjTvjyHTEDzhsY5u9fbZaDkbiumj0L6MIUjXm6yqx0EgbalceacppdK+ufSby1JNAy6V37R18EAxH/vmcbDiz7Y5H78IrQPCE7RtfApIjeJmb23YB5XYTSvK7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744224; c=relaxed/simple;
	bh=evr/VWcy7Bj9tSfj5AwEyYlh1myI1mVY5QSNQUcKA/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvL/HiLfLFCoGllMM40Zjoe7IPZsO+t1ptwWoKwLTM2MU2+mPRPJzQ4FJ2Nq8hkyB3qEl1ZsigUjcoViTQw1r64LwOihspqJ4+sEzaaBrfxsK9g4xhLo0356LXIhgN/nNjbRcFzi5F2MurK8v6UZ2PReChX/jbsHMHfs0lpV1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDuBTmeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDuBTmeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5231B1F000E9;
	Thu, 18 Jun 2026 00:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781744222;
	bh=gdcUowoWlmdk2SHRCzl3vHrMDgH3mpiEDGCJ+4GEJJ8=;
	h=From:To:Cc:Subject:Date;
	b=TDuBTmeUIlIJG5vi4cjyDGzbdJDtI4RwIHhz7IyJCXAiOX8xCo7ciRqhrXJoeY2zj
	 NV+fm2VPvCBHT3rFeMnx7FGnUUfaAIyn4oXISjt2gwv0PMY2SPfFIEtF8ohO4QTyD1
	 HLoP5BBwtDa1LiDT+fiqKM0mdqIS48m/Aj68hEJrnTmFY6LOZU3Zt+Y/+Z/wNGHpTN
	 Uj3qbt4fxjlEiJxAU0YRWdjEMS+X8GRtu5pzIM70IgHlOo29g4b8ZpOHSNmachOjhP
	 4+rBfPAgMTNkayej2tgDgy4Ih0nHPS3JGOt1hhbSnxDbHqyJzos5eal963sR26gC/p
	 oGuszUMYKPTuQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/sysfs-schemes: fix wrong directories put orders in error paths
Date: Wed, 17 Jun 2026 17:56:46 -0700
Message-ID: <20260618005650.83868-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error paths of damon_sysfs_access_pattern_add_dirs() and
damon_sysfs_scheme_add_dirs() functions put references to directories in
wrong orders.  As a result, uninitialized memory dereference and/or
memory leak can happen.  Fix those.

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260617135551.86013-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260617053308.83200-1-sj@kernel.org
- Add damon_sysfs_access_pattern_add_dirs() fix.

SeongJae Park (2):
  mm/damon/sysfs-schemes: fix dir put orders in
    access_pattern_add_dirs()
  mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error

 mm/damon/sysfs-schemes.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)


base-commit: d20942f0d52b1cfa54931e00eeaaa2350ee46169
-- 
2.47.3
