Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DA383982;
	Tue,  6 Oct 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323625; cv=none; b=u/WTXmhbmW181BDuCmpTdGV2Mq7qRsq+wBBAYFG3/wg7TXffU0lWOGG8j2P1Dg73t/6bx8VHc13NjOtfu9U5jCV2zPIzISEGoJ43+L+V1FKQPjsbJjfbS/2iGhQ4roGLdZC0uzJEYVLDBT5esD1YPqyDWYI3e3oM+reYy9ny2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323625; c=relaxed/simple;
	bh=RXtaMNqet/SpNG5MAc6p0J2UJ5llZv7wWrxxri4sNnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g17rMk5WYUIekCqjudwLmHNq7yjrtHE/MLai7H8ETyUMhlKt9bPf3QUhP8/BTLpH0X+OGCo0x/YTGsEXnlve2eK3BMyVm8dO+Tr+7qtQw6Fdh7CgYPuQszkCTaEWoTobRktGj6/u7VSrR3NwRKMNDdhkWHZFhiGk3X1WJ8XMRI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6BHa3Qr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6BHa3Qr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A1E1F0089C;
	Tue,  6 Oct 2026 21:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323624;
	bh=BSeLwi348Nb+glv1qZ9usObeM6e8iVd5kL1OdFCCb/I=;
	h=From:To:Cc:Subject:Date;
	b=G6BHa3QrcZ7u0jw2u48VgpIlcHH2UHt3i5/m4vfYDqgvX6iUcDYn4Daf//EWMaWyq
	 jec3BjzMISUXmNvqaKpMQ3HvGZffb/FMs5C6+qtTyFTQx2xf4/iP6WLmNriaONij9e
	 46G4SAmNOx6lHeQyJONUnJZoJzHaiKS4HXh0BPxOdzaz9KaY/QC3VXfjUqVg7omCuk
	 GiOrd5TAVaoYG6hzSTnC/Cwv4OqZjCrJm2+Me5ecF4BAlBYHNXizRp4G29BD9tWVCY
	 9vH9oeaqllmNpW3OdjuLdPeGnkujpdlg4WGaL8Z4l16bii+RW7QGTij+5aNXFBX3O2
	 /4P1ZoN+PXctA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 6.1] fsverity: add dependency on 64K or smaller pages
Date: Tue,  6 Oct 2026 23:51:24 +0200
Message-ID: <20261006215124.55296-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a300000233a9ff842e2fb450fb9a79f7827a586d upstream.

Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
cache the Merkle tree in the pagecache at a 64K aligned offset after the
end of the file data.  This offset needs to be a multiple of the page
size, which is guaranteed only when the page size is 64K or smaller.

64K was chosen to be the "largest reasonable page size".  But it isn't
the largest *possible* page size: the hexagon and powerpc ports of Linux
support 256K pages, though that configuration is rarely used.

For now, just disable support for FS_VERITY in these odd configurations
to ensure it isn't used in cases where it would have incorrect behavior.

Fixes: 671e67b47e9f ("fs-verity: add Kconfig and the helper functions for hashing")
Reported-by: Christoph Hellwig <hch@lst.de>
Closes: https://lore.kernel.org/r/20260119063349.GA643@lst.de
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20260221204525.30426-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
index aad1f1d998b9..6882f85e0a11 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -2,6 +2,9 @@
 
 config FS_VERITY
 	bool "FS Verity (read-only file-based authenticity protection)"
+	# Filesystems cache the Merkle tree at a 64K aligned offset in the
+	# pagecache.  That approach assumes the page size is at most 64K.
+	depends on !PAGE_SIZE_256KB
 	select CRYPTO
 	select CRYPTO_HASH_INFO
 	# SHA-256 is implied as it's intended to be the default hash algorithm.

base-commit: a500ba24937a966eab140b95eac42782a7ce2c85
-- 
2.56.0

