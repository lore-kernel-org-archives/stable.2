Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8334E36C3;
	Fri,  9 Oct 2026 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549430; cv=none; b=Xokcq4Q1C27w3F57tTLtwLXV/x0r5dXnbwtwq8JYAGT7bE8AUq665WnNovMd2ebpqfpp3y3EJ7y8ztpjAjJxnUPD/Fnoloh1h2kFaIvOOziHAF9d7HwQYZ/3EMdMRgKIhQr3L7TDhXFRGQ2hzRL1+CmEIDZBwvjDtxByrEPkAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549430; c=relaxed/simple;
	bh=/SM6Jskg9UO5yl27gE035Us+4hjddtOTEAe/vJvuFqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAQw+y2MgtzeotLwv+0CoehZ7wy2uOqKwb59qSlZvh7cZ+2Z22UdUesGygL9UQXxv7jP82TglyufPMV+aTmD9IVVsiJ1lFeLycFmxqUm5VQhihWqW40SzWLnJ0JPcR/u5VoI3XDAcTOavVfOb4NqfWtwTQw87saeuWmXrNMLk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFugK+rF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFugK+rF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3057D1F000FF;
	Fri,  9 Oct 2026 12:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549423;
	bh=+U8nK5mCOiRYjyxqmEh8GU9GatW9PRupTzTZ2IP3jeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oFugK+rFt/dcOpKCz6GNfv01GP2Z6nvPd3sttV3OPsfgY5+Y1gQWehnzBv3lyixbh
	 bJl2r9EDhOypCAorIu8ezuFuusXty66iIZzodEliq9Mq2jkVy31F1rdnKFxHgY4Z/G
	 3zoVsMaFGpoKrdUrjETg7/eR5j+gScnO3biCvwicTHAN+Tc85QcNmZoGsDRzkkKXJJ
	 71uyWmORSstm1WacXM+sK08S0Xhzyvd6RclMEugQqUxokggV5I4jG/T7kGOcTItXao
	 umSCoy2Bu7FQ6CxpCE2IoEdlCSiFuk+TsVphdFk/qRDoT/3jJOILVHcOL/0gbkxv7d
	 aJdNyLc1gGgIQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>
Subject: [PATCH 6.12.y v3 0/2] mm/damon/core: fix last region handling of damos_skip_charged_regions()
Date: Fri,  9 Oct 2026 05:36:48 -0700
Message-ID: <20261009123651.6585-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092948-agency-overhand-3fd1@gregkh>
References: <2026092948-agency-overhand-3fd1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a dependency of patch 2.  Without it, patch 2 introduces
out-of-bounds memory access bug that was found by Sashiko.  Patch 2
fixes a bug that categorized to be backported to stable@.

Changes from v2
- v2: https://lore.kernel.org/20260930101459.56041-1-sj@kernel.org
- Fix out-of-bounds memory access bug by adding patch 1.
Changes from v1
- v1: https://lore.kernel.org/20260930092829.45885-1-sj@kernel.org
- Add missed change for damon_sz_region(r) <= min_region_sz case.

Liew Rui Yan (1):
  mm/damon/core: fix unconditionally skip last region

SeongJae Park (1):
  mm/damon/core: do non-safe region walk on kdamond_apply_schemes()

 mm/damon/core.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)


base-commit: da5a052a482924abb7ca43f3cc70622b3033f5cb
-- 
2.47.3
