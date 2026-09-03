Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE44E66DF;
	Thu,  3 Sep 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450610; cv=none; b=lmVpvuLHjDlc/Gn9WaSB6yvz1lBusatLbWA0WfjO4INiMBCWFaAOksk0Xc7be1JzVePKObCOcOe4k7YUyehv8CfXnFNyi2xc1/JnrnMp5cJcX5Kxq2aL2uktSblhQJlftQ80jhRc7q41DXbwqbWWh0pxMu+voIgrSSaNvsrOJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450610; c=relaxed/simple;
	bh=iXLx0jg0t4q96d8MG/at7ID9R90tMti5kSG6s+gaRo4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A3lgwdDbKyBxdc+ESDIMaetM8ubQDOQENY4y43TJIEUqbpsghOaxiDoYnVjxbNSI+nHtvQt9ysxr27VC7pJQ3B2Gvz7DZGN9UZf2BiGQMvWwWKK6nnbVldzTAwiEJUpMF4hIi/JLmXfkxFnildP4AQ3DGNBtKPwbg1lXMg9l1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN1nzsXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN1nzsXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6821F00A3D;
	Thu,  3 Sep 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450609;
	bh=WI9v6/C6AUAbqLBrww4pmJZ6/5xnMiZgra3ebIh6xvI=;
	h=From:Subject:Date:To:Cc;
	b=EN1nzsXwXgmMd/6TIBOaO7frmhJOfdmraNCi0fc+jLFNArdjnT4PCQm1ustRBCfQC
	 iUBkCLenUEQRBaJTtLBqJTYOig+539m95ixFJ2q9/niMeBgfe6WCXB1mpd9SPc5pwu
	 4fY3uTaBfjOk5u7R/feI8Cku0/+fr144lZ9i6D2twlOCZ1OlBL8jGM0U6L5mLGo38y
	 AMzkLegVvk4D+Fo9uYrU4q4ev+jFJV6WPPhQv+PJ7+mSN2SM2Ts+YbQ7sDlWRIXkMU
	 ssuP2bgQGTi3DXBz63NVw7uhhDe0BGGLGxgXiIw61Hz2kwzdNVZuABvJ+G/aHCACYF
	 ganCIuxkZFc4A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/5] mm/execmem: fixes and cleanups for the ROX cache
Date: Thu, 03 Sep 2026 18:49:57 +0300
Message-Id: <20260903-execmem-rox-cache-pmd-v1-v1-0-11beb2a3d249@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XO0W6DIBTG8VcxXO+kgEcQX2XpBeBhsgV1YI1J0
 3ef2qa7/Ajnl/+dFcqRCuuqO8u0xhKncR/io2J+sOMXQez3zSSXihteA23kEyXI0wbe+oFgTj2
 sAqwzurfSY62Q7edzphC3k/68Pne5uW/yy+EdP5wtBC7b0Q/H00u+rAkKLTBTTuXiEJZs/c9Lz
 PR72xuXJ/uf2FVnYCvUO/AwdupkYOUgwVlqUVsMCkO31u8EP6UUl65q0RiHChuvgzBGc90Ijkp
 obUIr+7bRtSSNkl0fjz9YgrDaOQEAAA==
X-Change-ID: 20260903-execmem-rox-cache-pmd-v1-ab97da2c4364
To: Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

Sashiko review of the ROX cache refill path asked what happens when the
PMD_SIZE allocation fails there. Pulling that thread uncovered a bit
more than the fallback.

Patch 1 fixes a real bug, although rare bug: execmem_cache_clean() can
free a chunk that is still partially in use, because a PMD sized and PMD
aligned free range in the middle of a larger chunk looks exactly like a
chunk that nobody uses.

Patch 2 handles maple tree allocation failures in the cache. They are
unlikely, but silently dropping an area from the tree is not a great way
to deal with them.

Patch 3 deals with the fallback that started all this. The cache exists to
keep the direct map free of unnecessary splits, and the fallback happily
filled it with base page mapped areas that could never be freed from the
cache again. Ask vmalloc for a huge mapping or nothing, and serve whatever
does not fit outside the cache.

Patches 4 and 5 convert the ROX cache to scope based cleanup.

The series was tested on x86 with module load/unload cycles, with PTDUMP
confirming that the cache is using 2M mappings, and with nohugevmalloc
to exercise the uncached fallback.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
Mike Rapoport (Microsoft) (5):
      mm/execmem: free ROX cache chunks only when they span an entire vm area
      mm/execmem: handle potential allocation errors in the maple tree
      mm/execmem: make sure ROX cache always contains multiples of PMD_SIZE
      mm/vmalloc: add DEFINE_FREE() for vfree()
      mm/execmem: use cleanup infrastructure in ROX cache functions

 drivers/hid/hid-core.c  |   4 +-
 include/linux/vmalloc.h |   4 ++
 mm/execmem.c            | 124 ++++++++++++++++++++++++++++--------------------
 mm/vmalloc.c            |  15 +++++-
 4 files changed, 92 insertions(+), 55 deletions(-)
---
base-commit: 8499b4645c7f199707510461779f82d85732e742
change-id: 20260903-execmem-rox-cache-pmd-v1-ab97da2c4364
prerequisite-change-id: 20260816-execmem-set-vm-perms-v0-2-bae847a4f64f:v3
prerequisite-patch-id: 4d8c7989581fd5f4aaa2e315bfc903a9f0aadedc
prerequisite-patch-id: 211c002f2501d5aad7dea733fc6273c76bed910f
prerequisite-patch-id: a328539ba621866e4a63b39ab72a54dbfb3ed0a1
prerequisite-patch-id: 991f843051a913188e0cb671f3e8768682f895e5
prerequisite-patch-id: c05688baf37b3e80a57fe85d351f997f017acea2
prerequisite-patch-id: 36038f3f55748416fe56dc990d3836f70e851f59

--
Sincerely yours,
Mike.

