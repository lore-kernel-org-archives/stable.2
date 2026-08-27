Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134E388E6B;
	Thu, 27 Aug 2026 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804970; cv=none; b=qaeovXZJ2esCKYekqJbayHj7fhdwJ9qUWpldKWyPqcNDuPhr7PysbTolAILeLdOT2zVvexcn+lG8Dw/5imFuc1ADZOn+re3t7XFdWz0ZP1YrFSG1GOnQMKkEPYzZewFNt3yNIj9d3gUBrUyiDWMbCjLQKIez/uEMHUi5mQYH54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804970; c=relaxed/simple;
	bh=CN7TnHK1jRbMvNXbEv5ryFzFhTXgXshSyY8DrSZpJeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2JhrrlIjzDLZUxP2JUwrdg0B7zWB2jjG15k5xc9/AJYitaVIlPmm++ZGDeyTT6gKEti25kU79L/35uNYgY5bpAsUduNWgsyy3yXC7LzgOznUojUVaRTvjfnv12GJqYCq3TeNE/PEEMdXH85C7zYL9ZF5DDkaDDyNIcNzTLcoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0EV73fE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0EV73fE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD51F000E9;
	Thu, 27 Aug 2026 04:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787804969;
	bh=5sVxBkMVIpMIF72iutGGV8B5DQ7okKTomLo3LhF86uw=;
	h=From:To:Cc:Subject:Date;
	b=m0EV73fE31t1JvuzLgUuLNfLTlA9hNctvUqQIXSlKjlhTm31fRTbUfEyWbqEAYC0v
	 1Ofduja4pfM6GjDfkfuUJhn0n7xglmmsn7ijtCIO/usQ4V8QuLG6yj5U8w0Zieiohy
	 zZTKQPtah1fCu0CxK80DZnInL2JiwHyDf/ayoQWHex7Wcin4EoWYpUaBhyGMA6rspF
	 pUKLzM4yh0vav4t8v8P+tvUA2+c93ymTvYLPM0sH3CYeGiZtVOgoGxqIj1YDolALbg
	 CIrmlpZXXwSm4DgL/VOwMDK8Gp4lcY8OloDq0RB+a/arcQ81XxBsD1zU9jG7AJ3UVb
	 8Kcurl1awPcvQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon: fix wrong behaviors in DAMOS PSI goal and sysfs refresh_ms
Date: Wed, 26 Aug 2026 21:29:17 -0700
Message-ID: <20260827042920.93580-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PSI based DAMOS auto-tuning and DAMON sysfs refresh_ms file have bugs
that can produce non critical but still unexpected behaviors.  Fix the
two bugs.

SJ Park (2):
  mm/damon/core: initialize damos_quota_goal->last_psi_total
  mm/damon/sysfs: set next refresh jiffies per sysfs context

 mm/damon/core.c  | 16 +++++++++++++++-
 mm/damon/sysfs.c | 11 +++++------
 2 files changed, 20 insertions(+), 7 deletions(-)


base-commit: 3b3eb2976e2dadfd8624db7ba32ed28addb7e416
-- 
2.47.3
