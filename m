Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082209;
	b=eKZ+gdApyDkIRyy7D+YMG3cjfrkG9+nc1WBjPKIVsVXbagFQNpRZRv/Xg7mV3zySn6YU
	 6VZvK5yXyS80er/rNtor3wpNMFNGHix66t/JTZwhqgXR7Y9gS+nWKoj3Z6qlMDolWMDMi
	 D4zfm7xXxhJIdTD8H0/QNHuNYeflpsqWrqcQYBfjmfzR03Ls4J/2jnD01aScoIQzCe50K
	 ywtLq56i2xcukgWFTktTzfPUCmQzRQkNlN7XahdwEnjT+438uxiLSKFpMd7MjHrT3J6sy
	 JB2mFGD39MmU7Gr9rmoHS6rhr63ynfi70T0cryzcC5tepNDyM+l8csYEoTtawWC/AdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KcvosEEs4C5uASYPUIJSJcPZ+WqW144BqAVvtj0NdMI=;
	b=woWUuSscmruA7gmidL8nXNq0z3N/pQXtlcRKSpm4GTreZ2Bt6v332IN14ArRIt1D+JNL
	 eGbyInW9tZUgxfIiVgyJRukZgziASBSNJmkq/kAPuj1dgnVFnl1aOcKrHujBq4t9CxmTk
	 fRzw8+uoK6DHaTkm/CSmanteiMhJWl81xkHLPm4ES2lhmFp17bJuhqyxrGEFNkyZfdjt9
	 6KR8vbjGp5Cp1utxBD9DTUiCpFy9K2DJnH1HLv4xQFUnzTTcqlfXepUxqlASEkfrvWasW
	 5uZcLFXUxdPJ4KihJwZHdbyCEW2HVuL7tQR78GTTfArOujVR9TTaFCF8qjhUU9xpJHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IudT9GhW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F585606A32D;
	Sat,  7 Nov 2026 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IudT9GhW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153CB1F0089F;
	Sat,  7 Nov 2026 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082209;
	bh=KcvosEEs4C5uASYPUIJSJcPZ+WqW144BqAVvtj0NdMI=;
	h=From:To:Cc:Subject:Date;
	b=IudT9GhWhndqHy3FqR1+Izf6avXc2zjv/IR9kPWwCH9tNrYphn/6NCI/49cR5+/a0
	 6TwTZTzxSXdHzqwsRREk8fg1FtpV47aBkAQA3MDPvdA39fOf6U04VAUh5O8SbpPp7K
	 jX6c+kQAKNKP5+hmDt9AumFD72AtJEDzrLhoZYvWzyGrla/tLU4PhFm30+CpD2Iu5O
	 TYomYie9xTmU9eg2pZb/shCd64b/ifeswFnc0yLaS6hbHsyGFljPgh2SNPPen9THt+
	 Yj/sHltHlorrI8FX7CJOMH+cTZ7abahlxNWAesAKocstZRw8yK93WgdENyKIDeJ56b
	 OjhoxfHrpyTNw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.18.y 0/5] mm/damon: porting fixes that cherry-pick failed on 2026-11-07
Date: Sat,  7 Nov 2026 12:09:56 -0800
Message-ID: <20261107201001.206120-1-sj@kernel.org>
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

Manually port five DAMON fixes that cherry-pick failed [1-5] and turned
out to really need to be picked.  Note that seven patches [6-12] that
also failed in the same day were having wrong Cc:stable@ tags, so
ignored.

Patches that this series is porting.
[1] https://lore.kernel.org/20261107050847-failed-6.18-90c2fa6adfed@kernel.org
[2] https://lore.kernel.org/20261107050851-failed-6.18-29c6084658af@kernel.org
[3] https://lore.kernel.org/20261107051039-failed-6.18-af19aff38d6f@kernel.org
[4] https://lore.kernel.org/20261107051438-failed-6.18-5695abc4e742@kernel.org
[5] https://lore.kernel.org/20261107051441-failed-6.18-bbeec2d8324d@kernel.org

Patches that also cherry-pick failed but deliverately ignored.
[6] https://lore.kernel.org/20261107050853-failed-6.18-df7d9a0f8d91@kernel.org
[7] https://lore.kernel.org/20261107051022-failed-6.18-6f276422aded@kernel.org
[8] https://lore.kernel.org/20261107051024-failed-6.18-1bfb9384ae0e@kernel.org
[9] https://lore.kernel.org/20261107051027-failed-6.18-1d2397b2c414@kernel.org
[10] https://lore.kernel.org/20261107051029-failed-6.18-cec08aad3def@kernel.org
[11] https://lore.kernel.org/20261107051032-failed-6.18-a1c7fdaf1657@kernel.org
[12] https://lore.kernel.org/20261107051034-failed-6.18-409d2ab6d982@kernel.org

SJ Park (5):
  mm/damon/core: skip applying scheme if region split for quota fails
  mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
  mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
  mm/damon/core: remove unreachable damos charge_{target,addr}_from
  mm/damon/core: filter out damos address filter-split failed region

 mm/damon/core.c             | 63 +++++++++++++++++++++++++++++++------
 mm/damon/sysfs-schemes.c    |  5 ++-
 mm/damon/tests/core-kunit.h | 16 +++++++---
 3 files changed, 66 insertions(+), 18 deletions(-)


base-commit: 270830fb661321a6230f2433667a328e41b2fb7f
-- 
2.47.3
