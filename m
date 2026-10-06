Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870E22425B;
	Tue,  6 Oct 2026 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323898; cv=none; b=dMMgwBWQOIEkutjDQOGKq+wJv41pPExyESXRdazKPQ/QB4IgupdycNm4SZwI5QIBTx1WUj7wt97FoZjzbF/4fchrwAXYr1b+roosnMahkpMi/1foDQYxeSD8NZGSbfSApsMnjPFolL5tReJOwgIfsIh4Qy9GoRNrf98HxbAq00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323898; c=relaxed/simple;
	bh=T6fT7iO2qvlFpUjlNQco7mZthDU5p5wz+mGHYmPBmJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puxWbau5gZLuS9GOYCUp+XDWg+5CXGeWxZefy5rm8kYsAwYPzXCbkeKEDa0Md4BIlCRNMafwvnAarb/TE0QmAQoYSjJSffd3SaKI8HNvOsmCj2lsCNo5MlIxyjUzeFFm1jwM7VdcmO5c1hTWu2oed1QNozjlvOge++PzxHEmaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdUSx5mp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdUSx5mp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2EC1F0089B;
	Tue,  6 Oct 2026 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323896;
	bh=iEAO9Rza1pEXqjnySCAgbWRqwcbiH5GPpoBCdXnKO1I=;
	h=From:To:Cc:Subject:Date;
	b=TdUSx5mpGRxkqKBk8qk6qTbHtFw2WkksFJfm+fx8sFXHomPgmtFIyGti/UY0ypnQj
	 3OsiPFcQPDpd/GJ+DDyxeJ0MGjH6TIpmYbMhiu1ajG4SfSLXz96xbZeNxjLN+PUI4I
	 D2aeamPdF/Qlqx4bi7YZWTv86k5O/F00kGamMyPCv3ZdhPCtaDknDbB7klUb06EHmI
	 AVRQ1zp2LsqMXywsvmIsJYw6CQnBRVM2hXNG9He0rQu8wdxpdihN7ExPG/5Zh+hOY8
	 WUeNFAt2VEvrFW+bb8oLU+3y3NEv4vv+t7p31Q90kCPvQnBZ+L4VmkEyS1YZDQ+6X6
	 5JlrLdWbZyvJQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 5.15] fsverity: add dependency on 64K or smaller pages
Date: Tue,  6 Oct 2026 23:58:01 +0200
Message-ID: <20261006215801.58604-1-ebiggers@kernel.org>
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
index 24d1b54de807..4e3327ce2756 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -2,6 +2,9 @@
 
 config FS_VERITY
 	bool "FS Verity (read-only file-based authenticity protection)"
+	# Filesystems cache the Merkle tree at a 64K aligned offset in the
+	# pagecache.  That approach assumes the page size is at most 64K.
+	depends on !PAGE_SIZE_256KB && !PPC_256K_PAGES
 	select CRYPTO
 	# SHA-256 is implied as it's intended to be the default hash algorithm.
 	# To avoid bloat, other wanted algorithms must be selected explicitly.

base-commit: a051a4bf909f76f470ccb3761ee0cf6e2395616e
-- 
2.56.0

