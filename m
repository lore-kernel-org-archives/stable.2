Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F3233932;
	Wed, 10 Jun 2026 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054069; cv=none; b=qpkBqMVfeNqnbZFAORmifrxsTKGbzvt/1jNIZqzGYW+6MJ9EIKyM9dLCFJDE3DI1yi/eBk2ckUcM3UpmuxJ6yuV/rYruaqVBfKEiM1KLWlZWAWSvuY90T0fY2aXVFiwof3PPqui19JW9Z6zykG60ZvNulelTKThZgLX2oStkAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054069; c=relaxed/simple;
	bh=uMVEwMVFrhCzwBVqhAabVTfwILN07guP822tmOWUmbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mKhwhL5skuqyCMzAfk7IRQtAIeZAavQ0/Nk1ABHpL3oWPR7O0T5wGCHBO3knmztrvUH7EOgIunZIX0DGUWjQ6oKZKZgwcqXfKfCx4RDwT9GZb9zUGwVhphzC4TlMKJKp7++WqrH1D6ELwgx2PFJoBNpqw9Ryq+SC3YdKL9RREnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI9v+5GR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI9v+5GR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3711F00893;
	Wed, 10 Jun 2026 01:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054068;
	bh=nk5e65x0+gfzE8iKCczyf6SQjc2ncZIrrJUIfyl4290=;
	h=From:To:Cc:Subject:Date;
	b=RI9v+5GRjs2r/QxLEZ1S9doOh/Anm/jAi+G9SyO9Z0i4DC1y237xMHA5wVdt3UpMa
	 3Mn+sBs6chHbnhJ9Dz2aud3Bc5xTdGAcVc0SQpMrsy3/yLivVP/Q/hk6cnHeMwUgmk
	 NCIvMQm0j6VryyFUyutC01DlaVzYwbCY9Qg/xgsNwMCzwpZj8swxWp3g88Z122cLMJ
	 9y9vk5f8nbqfVu9RnSKWsYLKv2rAL3bUI5flFiKwKcF/eedMiE0bf55/hJKVl1zJyO
	 rEbDyVYmW/qhknrdS+u8HfmVwMjaeY5Utcx1Yw2fqL+GE5B3zEYaXb/r/vPuPpy7Vz
	 lR7ZWlv1Jw4Nw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 0/4] samples/damon: handle damon_{start,stop}() failures
Date: Tue,  9 Jun 2026 18:14:13 -0700
Message-ID: <20260610011420.3018-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All DAMON sample modules are not correctly handling failures from
damon_start().  Among those, mtier also has an additional problem for
handling of damon_stop() failures.  As a result, memory leaks, next
DAMON operation disruptions, and use-after-free can happen.  Fix those.

Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260609142119.68120-1-sj@kernel.org
- Add damon_start() failure handling fix for wsse and prcl.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
- Add damon_stop() failure handling fix to the series.

SeongJae Park (4):
  samples/damon/wsse: handle damon_start() failure
  samples/damon/prcl: handle damon_start() failure
  samples/damon/mtier: handle damon_start() failure
  samples/damon/mtier: handle damon_stop() failure

 samples/damon/mtier.c | 14 ++++++++++++--
 samples/damon/prcl.c  |  4 +++-
 samples/damon/wsse.c  |  4 +++-
 3 files changed, 18 insertions(+), 4 deletions(-)


base-commit: e38932476396c4da618a9e904ba4e45f1891d910
-- 
2.47.3
