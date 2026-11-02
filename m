Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630795;
	b=X2qItx23mivUl9CxXd/7cGQSgXoGTHNG5bXa9Tj+wKsYEMhFqt3kvZUUP0n10qu7KsZz
	 fxUobOzYZVPMR3DYw63oWdcGdcSD56k9fOSrQ6Axkma2plUpHM2eositKB4AdVeISdNWX
	 VcpqHTmNW2fhXVksqPZVpUfkJfW/Js8QxcsP/rBhS4oaJaAdzu5T9LMquCTV9dagB9tpZ
	 7dXzGYg1RqDzkCbZF6HWJ3vfFpvn9QcIIULd3xKVWvwgpoYejgiOKhwdo5qM3wqt8g9Bh
	 2yk4CjmacV7v4YAy/Ez17JKi3v0OV7ksk/dLJfZ/LNkQLjaYVtNBeyVz1gSgtLedCpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+CbOy/w4oZmoVyUdrE5PFeUUqcG8Qy13cgKPirYGonw=;
	b=tA/oWasUSf0zVHptQRpBY1J6greX4c64ZJHa4dE/pnJxiVfV6RUQkqIJ8LPdIvz9oMeb
	 egRM8OgcTqdw/9YWRHg88/ynx2JGOhgl+Q3dPMytRcvZvWNjJdyxKO4mSqEYRyAtpiJV9
	 DN2nYzYxofKo5INAUxxz9Vc/Yi/DfR+HXFT/bH3K01vpm/wpgpCJ4+h/+r0QjwZnvhKkj
	 8VZx86qsml3g5FMNcogG1/+DvxMHlkq0xiSJ7ttiALCW6dzRUNPJiMYzNMArGlYGtVMOW
	 fLK8tSOpxHjw4SSb9f/Hmcex8X9IMk5ejYyAFrLQT3N1CDYKruHrK9d7QYI453BjQnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzgLpTAs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3E6070D96;
	Mon,  2 Nov 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzgLpTAs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735601F00A18;
	Mon,  2 Nov 2026 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630795;
	bh=+CbOy/w4oZmoVyUdrE5PFeUUqcG8Qy13cgKPirYGonw=;
	h=From:To:Cc:Subject:Date;
	b=UzgLpTAsh/8b2lAuCsP4MmQBFlTwq27nXfldudYpUFO9wJWmkv9UIHFAXDDexAlif
	 iO1Q0+qe6cHXAUlIT+U3r4HyjZYBl4HukMhSEITaTw4So/C+I1yS3Syg7C5sIxDZPG
	 5S0ZNudLwPF0WmqBgUtsD6evmUSs8XzPvMYhh9Bl1eVwPb+BqphU2ASIGP7YiG/TJe
	 ZGwuEjboJWhAA6PG6w3PUOPbiFKqwfO9qGu2VmKADh+w6P2mhbFyIdU7jmBJpgBnal
	 IG0ZgOE6r9qhpaa0kScLQ3/QfF4TUP+ddUJtSY/QX/sgQfDsbHDsuF3Ku34F0iemg5
	 EEcdLIA1YJTXQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable 0/3] mm/damon: fix watermark state, kunit pid leak and selftest fake pass
Date: Mon,  2 Nov 2026 06:46:23 -0800
Message-ID: <20261102144627.88843-1-sj@kernel.org>
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

Three hotfixes for core, kunit and selftest.  Fix kdamond deactivation
from missed watermark reset with patch 1.  Fix pid leak in kunit test
with patch 2.  Fix a selftest wrongly passing when it should skip, with
patch 3.

Note for reviewers.  This series is a collection of fixes that were
initially developed by different people.  Changelog is in each patch.

Aveline Noir (1):
  mm/damon/core: reset watermark wait state on each iteration

SJ Park (1):
  selftests/damon/sysfs_memcg_path_leak: define ksft_skip

Wang Xiaolei (1):
  mm/damon/tests/sysfs-kunit: fix leaked pid reference in add_targets
    test

 mm/damon/core.c                                        | 5 +++--
 mm/damon/tests/sysfs-kunit.h                           | 9 +++++++++
 tools/testing/selftests/damon/sysfs_memcg_path_leak.sh | 3 +++
 3 files changed, 15 insertions(+), 2 deletions(-)


base-commit: 395206c0e287bdd981918e033a2b1621ea6a3b9a
-- 
2.47.3
