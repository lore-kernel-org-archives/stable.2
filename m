Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1193CF032;
	Tue,  6 Oct 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322935; cv=none; b=KSW8ou9uL6DSvxiS6j8xXr+0IP0oP6GkYchVAkx3ZtvhWA15C2/nc4/jYalcjYkXLGyalMiZ8kMAVLnuJZUGGEfLY30jiPfwLLwR65SZKYGGthBDSJKyJLUXLTSObVwPfrGT144J8q+x4aLtgoclSIf4NWhBlKgexiluQQBGjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322935; c=relaxed/simple;
	bh=axTm0GG0bamQUmiFK1igzXz96183ieb1R8hZEsZ0Jds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsvDEA2vQl9IwN51bPI/dWVaZ5zkwyJ/DXRC7NoTmMVe0wQGrWMMoehtvB1J4FQG1q4NfIkHTaUmUXydwgMHKoxJhiT7eQk9qMqd0dyQNQciF7ajrQ103e+Ovzjb2VjsH+aqn2W3fE8hrXMuJy2yrpao+B/pUZtlleRY/Rprhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdY+U3Rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdY+U3Rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FEB1F0089B;
	Tue,  6 Oct 2026 21:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322934;
	bh=igVu62EMrDWPMR9iK+wQcb0ONppwveZ197JGOKRapQ4=;
	h=From:To:Cc:Subject:Date;
	b=UdY+U3RdEuVLArKFbIG/RUagOCC/2sqA2GOGsyU7r9bj+Ig1GUfcvLEzOV4ylXo3y
	 apBsaX6W2xe3r9rBkDbwZMfuzZwsD/LmU5pQTu5ePlPGzlsGo0uQKyz3fqvSDPLh1G
	 KPNiYmBxhE1Vc7JkwTdTMhSt0OXOTRpj6yyaDSotzqVosYwy0qkdn77L/oX49WkBXz
	 LX0CLAGwQZ7QQFa45bdXGjsxv0dtB0nJ9OdrjIViV34clAtUbmH6AirzbvljPPx8lX
	 toQGRXEE0SuyOpyVyJvuvkKyjgl6i5hkeNiPIWtTPH29YM0OunoE0HxnlxPFajSAer
	 RKNRQakFbwerg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 6.18] fsverity: add dependency on 64K or smaller pages
Date: Tue,  6 Oct 2026 23:41:37 +0200
Message-ID: <20261006214137.50903-1-ebiggers@kernel.org>
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
index 76d1c5971b82..b20882963ffb 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -2,6 +2,9 @@
 
 config FS_VERITY
 	bool "FS Verity (read-only file-based authenticity protection)"
+	# Filesystems cache the Merkle tree at a 64K aligned offset in the
+	# pagecache.  That approach assumes the page size is at most 64K.
+	depends on PAGE_SHIFT <= 16
 	select CRYPTO_HASH_INFO
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512

base-commit: 725bd2f3c81d54edccb66fead01d4c0c222e2231
-- 
2.56.0

