Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15767383982;
	Tue,  6 Oct 2026 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323428; cv=none; b=PZaQ7GMPk3Jz7h+TGn673x2iSN1jhExRUsXC6NygJ4CvDPfRwX0eqaAUuvWJoRQ8Q8ySH1Iu9uy2XZhHkkTZaDATWislHHNvZ9eNT6of3ej3kRXaNTrLQRyx8kNG9XSQ9MqfnCsQv+mGac6Jj8DGjqVFM7R3Jrl/uVx/xgTvJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323428; c=relaxed/simple;
	bh=aBoRTbHwjwc4M3lFBs/ODzVYUShKn73UMPkHz1eNAPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlPqoC9l62voMhO/iJDECqNJyka0aB4RWWRTru5GC6J7MMSWULbd+IDgUcmWyworv9M8yBG4Z0vBIjddXnBooHgM2wdgbPU8VaaiCH0S3KD2CTZpQXW9eCutz3jhZLbkS2rhTEoR9P33ck5Np+B/lXwXhx/K1uR+87SRWF1AgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/aLPYqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/aLPYqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910011F0089B;
	Tue,  6 Oct 2026 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323426;
	bh=Pgdhntk4iEhwn6+Mv7QbSeg2lSyNn/EGcvB7seDPNUk=;
	h=From:To:Cc:Subject:Date;
	b=l/aLPYqrefvnOVTGaL1xGDlUv1BvGby3Kcw1i/FFDqtxbBCx4inC1Gye5NdBwYMSX
	 VAuBPttec+BzS805HuD/Q0+AnEhqhYRNa4+xnI+2gQn0/ez0DjMYlPEh6aUDwHwXwC
	 gKSoPdicwaWy+SvXEzt5AGEto/lgVb91JE9Zayujd+OBmgvlw5pFm05un4IZlMow/2
	 UWAUhgFFwrfzVpdNyrDe1/Wz7Bix/UALMFCBTV99EcBw/IbbyeHnJerd0ymB6PaqE0
	 LcjQRKe987dRTqAQffX2BCjz1xzdpAmPNhPls1Lm+z5c1fW7oxZkcZqQ0b8I8bHgFv
	 vV4I/W7+kZYpQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 6.6] fsverity: add dependency on 64K or smaller pages
Date: Tue,  6 Oct 2026 23:50:02 +0200
Message-ID: <20261006215002.53757-1-ebiggers@kernel.org>
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
index e1036e535352..5ff8d9a9052b 100644
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

base-commit: a91a6aa9253c64936f0bd8273a2a3c11522ec9c3
-- 
2.56.0

