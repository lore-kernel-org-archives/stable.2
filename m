Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7598834;
	Tue,  6 Oct 2026 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323208; cv=none; b=G61CzZJhSbujt3N03TE6CGy6h1WllbGN17/P9a+ehtMCIwsP3FGCp9GIkzDRbTFm71853n31HiPWx+JHHfn/RlRemv45uyJmKaWXhe3K8UbJPm/l8R8vPb2Q6XuANeW9E+pSdKMyUn1vx1kS8jw/vrjfGOsdz3fgs+5ICZrTwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323208; c=relaxed/simple;
	bh=2/buW4DlQ7rZIP5KQq3JbXOQcrkzsiwUVpTYvSGvBLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWyOQWb7qKIP9QslUeYfzNfaiGiIx+4PndMKcJC6Cjmf56YyIFedG32IT0fwH0QJTBzxW9NaR1ze21h0nta8dcCFH3Z5Uo1d+gwH2iGxIugM4dw5DSW1jP9cdAlvEMfk+VWzB2xaecM3sfmAAnslU5PIe1Yq+30oeio5PvbIRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN+qjX1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN+qjX1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91891F0089B;
	Tue,  6 Oct 2026 21:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323207;
	bh=sqm3/UNS9b6MNG0YFeKfI3J0xKKM34VoV295PTlLOXc=;
	h=From:To:Cc:Subject:Date;
	b=JN+qjX1N9Kd65Sn3wHiz6oYQQ0LI2IXDrTvhSeWZOVNaDg3ZNLq4frKMRNVUNy4h1
	 rkZ5b/etyAFDYMiDlJsoWjUQjdqSNPOEKlXIjP9yhs0ovC0zg1y9lrDZvR9opGOewW
	 pY7z3YaOimtmbQaBZKNUhxMrgpzpm8xGgL8xJx9p7Q2mSF1VNDFl9TLSuVVfaELn6S
	 LwzYuZbRivY44LYuS+PyE5GqQb9eqRM0nuEPdXJVsIgdOd/V856ZPSOZ8Ze6miSJ3a
	 I+phzhmtU7cliXdkCXGZx5S1Nlaihx4rOVA+QORKbvd2Jbu64GdOZFSM5vwfmluqdy
	 4hZcaf8+m2nHw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 6.12] fsverity: add dependency on 64K or smaller pages
Date: Tue,  6 Oct 2026 23:46:21 +0200
Message-ID: <20261006214621.52195-1-ebiggers@kernel.org>
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
index e1036e535352..db8fc01df798 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -2,6 +2,9 @@
 
 config FS_VERITY
 	bool "FS Verity (read-only file-based authenticity protection)"
+	# Filesystems cache the Merkle tree at a 64K aligned offset in the
+	# pagecache.  That approach assumes the page size is at most 64K.
+	depends on PAGE_SHIFT <= 16
 	select CRYPTO
 	select CRYPTO_HASH_INFO
 	# SHA-256 is implied as it's intended to be the default hash algorithm.

base-commit: 7aba70ab2e8d8ab3cd45abcaa15e1119a00dc42a
-- 
2.56.0

