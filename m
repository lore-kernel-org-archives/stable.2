Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CC3921DB;
	Tue,  6 Oct 2026 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322660; cv=none; b=HYg/uC6lNAHTFqaiBYlsKXsOwjy9uF7vmcX4tsyXSCcJ5RXt6PvvF4Pittx+KSXTWFkhhGITUotyX+JSTt2L2QHvfoLK2gJa/07g/nTtNbLdRCTnnCSbfC5AC97cpchi7iI/S43R5Afay5vD0a5ImRFtAqErYvBfq0f3UrHVUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322660; c=relaxed/simple;
	bh=U8ZMDkxuncg+i2o87FiJnLSRE/MqowByuKTE5QtTxL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzfrLwH1MOepBa51Sb3yhZ2SPnn/UfT9itRn3d5aNddknN54CSFzWBT58CM6v98geOr+EYyYlS/tPGcI/3HbSoVuz42f+6ch1ALTYGhInD1+WpiEv6UoHxr4zGKPG0WqwXLFNuWUSH4BRVz0Ig32rMZj7Cyv2grXrw1CP1zQBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfRA6Uen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfRA6Uen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB9C1F0089B;
	Tue,  6 Oct 2026 21:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322657;
	bh=i3anKb1NBOMLbMmJf83GphoNS2/pXGaeKe+PQuqGH4w=;
	h=From:To:Cc:Subject:Date;
	b=nfRA6Uencl0KoDOqAmGw3Q/Sb/GT5nhzOSWeYSbr+RN6Jq8hfFZgSuiDQE1DSwYFT
	 wZ8Ch+8E4xoq/gIDF1mfdnXZQ7v9aI8J+kpFROMer1diRkfXciHarHXcyIJT7r2VGV
	 6yutTlYXQxSDwQn0e+mwxhX7NTTBL85aTNoQ0CXPTGUk/hWnl/zAEXJOORA6U/OALi
	 5FhxAdzQKEUnNe6yyp8lbcTxSz2QtlU0nUEbhyn9AZUjnmGDDCa5entNtLYjer1fNm
	 dyUBDS5/HcT6xdWJBUoYiG7WOfP4mf6zA7UN+wtLlzwLQRfI8XcKSr5W7DPlOxPsSJ
	 LK60IIQiidZqQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.12 0/2] Forbid truncate of fsverity files on btrfs
Date: Tue,  6 Oct 2026 23:37:23 +0200
Message-ID: <20261006213725.47114-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport the fix to forbid truncate(2) of fsverity files on btrfs (and
also the fix for that fix).

Andrey Albershteyn (1):
  fs,fsverity: remove check for fsverity being enabled in
    setattr_prepare()

Christoph Hellwig (1):
  fs,fsverity: reject size changes on fsverity files in setattr_prepare

 fs/attr.c                | 12 +++++++++++-
 fs/ext4/inode.c          |  4 ----
 fs/f2fs/file.c           |  4 ----
 fs/verity/open.c         |  8 --------
 include/linux/fsverity.h | 25 -------------------------
 5 files changed, 11 insertions(+), 42 deletions(-)


base-commit: 7aba70ab2e8d8ab3cd45abcaa15e1119a00dc42a
-- 
2.56.0

