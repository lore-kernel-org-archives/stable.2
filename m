Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086DA1DFFB;
	Tue,  6 Oct 2026 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323969; cv=none; b=lyfSRZSWYBO2WNkN4j9x+94ldcN7SBCV2S1IjrbUpXD+oRf1Mv+io2I1rq3ppluIJ+iezpbJniYZYapT3gHYxrHGR54RtwNmhV4Ke+4kHHW23JSz580I/f7Oa07Yco5lSA49PD0RiVyJ8nrCZur4DFBlZjEO5Td9oPy/xMVhRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323969; c=relaxed/simple;
	bh=AnMPpF+BexaTJOMlJ43O8Q5ckMVU90MjdwijVyhvCFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RtVtKsU8gwac4/+c54ILnIZqg2TBePs+oYfme5weKggWaaWa34ctAv4X1CnECnDsH/w8PIoCut+YSc5UL5fPYdh4b40u04rSk1dqHpFa7VaXnpFOpmMgmbxv3oqddrI0xI4alUae+T4q2fXLWvRVOFbWXJ87wt9eGdpdt0LD0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVmOT+6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVmOT+6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DD1F0089B;
	Tue,  6 Oct 2026 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323967;
	bh=ib+wpLvfj53sDjhtinQLJ/CACApnmdWdC+TTYk5qMkY=;
	h=From:To:Cc:Subject:Date;
	b=SVmOT+6J/Gg2PtoMPxOkd229rZfzuRIMSG5TUS67bW+jM6mDgu596dMjTnTNVuHw3
	 YZ0kF4sJwurm90qT4A5Bho5IZj9L9lZpqHmy297Ri8Pa1iIgpPYXAguww5Gqr/bpgs
	 aPqj3S7KDIjiX5E0DqDGWbk5zo04Vj+3idQaK4aLptNzeQNKAICKwm/zUvabsBYlK3
	 2Y0awydN38PiHo5iDzRTEHVeiytMNg+Gemq66/r85yj4DM6WQMT35OInNA0WpxkfHZ
	 n3EgvdAHCG7DDRKzIflg9dV8fDYIULsLpowTluYhDC+6lrSXRiV4Piy4qWqeuxaCKa
	 VBdwspQGqPOkg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 5.10] fsverity: add dependency on 64K or smaller pages
Date: Tue,  6 Oct 2026 23:58:53 +0200
Message-ID: <20261006215853.59771-1-ebiggers@kernel.org>
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
index 88fb25119899..e74030597aa9 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -2,6 +2,9 @@
 
 config FS_VERITY
 	bool "FS Verity (read-only file-based authenticity protection)"
+	# Filesystems cache the Merkle tree at a 64K aligned offset in the
+	# pagecache.  That approach assumes the page size is at most 64K.
+	depends on !PAGE_SIZE_256KB && !PPC_256K_PAGES
 	select CRYPTO
 	# SHA-256 is selected as it's intended to be the default hash algorithm.
 	# To avoid bloat, other wanted algorithms must be selected explicitly.

base-commit: 587461ddf5d522bfcb50ebd55078c0dac37be496
-- 
2.56.0

