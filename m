Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621FB33D509;
	Tue,  9 Jun 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014883; cv=none; b=RF9hAaD4CZHiPlcoF4w0NmCHol+yG/qpKKSBfIOhZE8W9h9O1p1sF2Aolx1oYwSohGpRxW0Gp/feqXJ/PgXFnWZTc0qGcTwkjj2kdLYy47fzDgL1jegjbp6DXGw0KB833UhP2NIfWf1LhJlwlskmv7CI6VukLFYL4xPVJahj1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014883; c=relaxed/simple;
	bh=wlOodJMKwWlojPiGSUEaRK0mtYPwLBvKfjqYfKQwbM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1IarG9QMs4X5ZJuH4VAgGqsE8dTntRirILopsMx3D4N5/qqgye3mSSAy4bEXIvPDPj/JQWT+Buk0BsXXpRaGNVgyBNLowLemiMKeZ/SwygVgBS3LofNoPiXOiIVyqkND8ylpFT7H5umutbbPE5HCqmJhFjnJpeefNgvlGcfhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vgd6qLQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vgd6qLQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6FF1F00898;
	Tue,  9 Jun 2026 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781014882;
	bh=/I/SdsNq46aL/damhiClubyVX87JXrkNh5YqDS3XJXw=;
	h=From:To:Cc:Subject:Date;
	b=Vgd6qLQ2U/g3hmzeKh6rrNLiIX9mT7W+eOTz3YeN0q8c3rwLC0jp+y8pWWQAM98YC
	 +QZoW9QCtt17jZ2t8t8b/y66NhbQJUCGav/vkfdLpBnr9Bi/ByPyiDdIvyaXdqDpun
	 t9iJyq1k/gJL0SaPmJDU8cPTQfZyIjtiDGFexzecEBZdwTe8gt6oYI9JNX9z16TbZd
	 GX/kIxN9e4IN96SvipZ+ctWSjKHopOVp1+dMfhVBLQx4VrON/e1EjM4+A5zQb8YiRk
	 iiyvWAsIpBrAnr5Q+S9dRmn0wYi4EMEC5TK5pXKvduK8uInegjm0FzhQ6tqSGdtJhg
	 73oMtye6V7UWA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/2] samples/damon/mtier: handle damon_{start,stop}() failures
Date: Tue,  9 Jun 2026 07:21:15 -0700
Message-ID: <20260609142119.68120-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sample module mtier is not correctly handling failures from
damon_start() and damon_stop().  As a result, it can leak memory,
disrupt next DAMON operations, and dereference freed and random memory.
Fix those.

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
- Add damon_stop() failure handling fix to the series.

SeongJae Park (2):
  samples/damon/mtier: handle damon_start() failure
  samples/damon/mtier: handle damon_stop() failure

 samples/damon/mtier.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)


base-commit: f822d98f51b6e2b3ab41cad2e8bc1013d06f93bb
-- 
2.47.3
