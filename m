Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59024071E4;
	Wed, 17 Jun 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704581; cv=none; b=Qnjm1gglJyoluC4TdLyTufGw3XEtZDcb2ecKKyNfzFD+pVRW6znuSMsgO2Ht0ghWZ3cK++1fxpYoGEtQ4Whj41jXgKR9+BNZnEO9l/Y2YkI8BrRm5FlHQNKVKUtEV43qlXvK+NNrBjDKXok+Ta1jmrRDPR0A4H5XQR5eOMZOPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704581; c=relaxed/simple;
	bh=jc7t4Krk/2K8A7ZNDFivqVlFXwKpNByAkT5TKwKGrw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsRx+fpXA19z9xfz6cnbvhK0lDLIiFq+ZB+myfXBaf3sAY2eXqcqq5MoxikwhwZlP0+3h7jdaUggz696psnq+KzWzTXbRtdedZY54O2tTMZDDeqxA4UCobVMlgBRu/74QbSqxpol8DIGl36/iuW/h08PHA4mlC4l47Ms19OTDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSjo2ERn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSjo2ERn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C411F000E9;
	Wed, 17 Jun 2026 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704580;
	bh=+k7GiQAr5qIJGPs8oEGZMT3wvgrsyPuY/ZtZCXE0gOQ=;
	h=From:To:Cc:Subject:Date;
	b=JSjo2ERnKqWiDkNoaxp6FQ6YwVXthztVeQbIPBL55PdCXbJe94JT7T4zYvG2AHJza
	 YJhElL/k2RQJzN4HvMawBsEk7tT67FQ/luwlnsToBNV+WAJQ+6Y1byV9ikNb61tnVY
	 pZc103+uS4TWTIQOr752xzX0Ofv9/nfvqX9HC3E4+lwcoaC21Y7Jg3j1U+P5p8vCfP
	 gG0177c2H9m2cZ2YxewSspS/Fvf7H+tUipQgSZbznRZ1pGi9aGrQj8Eu+BBsXgiWDc
	 jO1mo4Dtf7AOp11nfcp5iVL1J5UTB+kXqBgm5B4NvF2ICONcneILEkUIJXcx/5+hLZ
	 yYbXxOQ3gnOpg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 0/2] mm/damon/sysfs-schemes: fix wrong directories put orders in error paths
Date: Wed, 17 Jun 2026 06:55:47 -0700
Message-ID: <20260617135551.86013-1-sj@kernel.org>
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

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260617053308.83200-1-sj@kernel.org
- Add damon_sysfs_access_pattern_add_dirs() fix.

SeongJae Park (2):
  mm/damon/sysfs-schemes: fix dir put orders in
    access_pattern_add_dirs()
  mm/damon/sysfs-schemes: put stats for scheme_add_dirs() internal error

 mm/damon/sysfs-schemes.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)


base-commit: 7590ff339c62226d7e1eeff03918b8d27eff0872
-- 
2.47.3
