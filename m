Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196718;
	b=ogvrAYEmmdAOpiNoxkgnvk29cw9tVIYJhiRSWqlL49Tb90Oqm/NuwSyXv0c6Yq8AvGWV
	 zxOt0nnoB0R198glaGpevjSRCAFxYI0vOJtY5NFMoZxf8t75TeskGxZQtaP5atUMIwhsj
	 q35NaV0i2JI1+4TCkb6ZpVYIxBhJRN0yCEFC4ULcyWduVfMbFo3A8DDZ8i3qK+9uC3+ZR
	 Kh3ehE0fWgTtW9FAHyEN3n6qFdkswxKiZTlt27iH7PeMWOWgbS54R6ECdctIeD3C/Q9TJ
	 kzyaDT1EJ9b1NX76TMed8YI+CI+ffPnFpX3w1OcG0nGo/MeyQMOOFnBGLwKJbtuT5OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196718;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DBAwupr574cqsrPW8LZMhh/I92Jfido+74PsyFCXFnU=;
	b=pir7KkMRS9k3rFx7VELHvFjAe5mZtUG6/MpzYJHG2LWNEVOEhBy/FWbrCE/OeguVQ7md
	 VcxDlG5Ue/MXdk+AiQZB3exFIy4fHkSR/Sx34qjYfe5I5lJtuuiv8fgCZS3CCiDX67vod
	 vHIJt4b2xpAGVjPorngMobbgsAcZx/BNOU9Li8bw7buB9SyEpRic90qQelHLyQA8u/Vxf
	 zPRZdOpKBG7ATlAk9znZbMdA/fBpmH7aAr/6i/nVsHE2QhTOGM+QxiSfu13iS+3oPskwi
	 1uXaQF2gkxrLdnHG0jQZXEw9ij6xsH3AEjrTHoKFQvVI56/5hIVlc42fKi42MwXYReg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftx4v6cB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8723606A321;
	Wed, 28 Oct 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftx4v6cB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569361F031E8;
	Wed, 28 Oct 2026 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196717;
	bh=DBAwupr574cqsrPW8LZMhh/I92Jfido+74PsyFCXFnU=;
	h=From:To:Cc:Subject:Date;
	b=ftx4v6cBTQ46AqtV5OsXjBLzK2VZEfSGpWSzh7CkWjresyhm7DwBOHHRqgUhqClrt
	 cpoP1kXSBgT9E2TVC/mm9xrJQ0JCIxsQeHrHRohqt+ZgK5Or5CBCR9tBmZViDEEBN7
	 dzaWEbFQt0wGylL0iQI8tJzABrTGD8pOtUq3SlSpE7i0ED6wYN6Y36krgehar4eY2b
	 X2PTMBtxH3RhpGtV2s5u2HMmSWCNZ3Mk684Gq2dH8zuCitzzKYXfbxQLiRIrYC+VgZ
	 HuZ+2FgJZpQuYo0lPJKW4GcUXdHAMBMaeGF01PT0nKY9CtRkgITpdHJWimRzHVj5Pk
	 ToRQwPwkClIwA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Wed, 28 Oct 2026 07:11:47 -0700
Message-ID: <20261028141150.160711-1-sj@kernel.org>
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

DAMON sysfs interface can leak pids due to wrong error handlings.  The
issue in the mainline has been fixed with code refactoring.  The
refactoring is done with commits including 7114bc5e01cf ("mm/damon/core:
add cleanup_target() ops callback").   Porting all the refactoring
changes to old stable kernels will be challenging.  Hence submitting
this non-mainline hotfix series.

Changes from RFC
- RFC: https://lore.kernel.org/20261028042617.165657-1-sj@kernel.org
- Drop RFC tag.

SJ Park (2):
  mm/damon/sysfs: put target pids for damon_start() failure
  mm/damon/sysfs: put target pids for apply_inputs() failure

 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 355214ae5d8da08854c5749cc79b688e4ff265f7
-- 
2.47.3
