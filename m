Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E023A1686
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178444; cv=none; b=vBQ/aIx6x8SuN2a0tpEh5zsx+l1u5QX1IdWMvdxeZNM7xOn1lMoHDkK7MZmRvE/OC4ZPx46hDX4bIv8um4TxgDe04DuCJeXa66wCvX8aa4iq2dMvhYdDBQg9YaSstcQD+nx6LdMfRCSdTKjcI4Kv7SDKAwSEbpR2KmUZ8l2wQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178444; c=relaxed/simple;
	bh=vJg8lY4pUVOeZJ1U19usKAAraIsn6RxHL9rhCS85UvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqFyUOr/cGmwbAhMC9ur8QvTS2RVs+LTVgpH2TOa1GbsUN2+VgCVEcOCvhoaNHWDpdwHFDQy7t5e5sNIjaTFdvkYfE9uAZNjMFaGJOrTokEVRbYQDsIdABj1thYCHrrTzsW5btsoB8uvolCIOdG6WiPd2GmxBzd9UvRiqnpFvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ihWTKagu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ihWTKagu"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 68BD920B7169; Fri, 16 Oct 2026 12:20:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68BD920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792178438;
	bh=471uqV7xM590Av6IlNdyAFoMZVO21QUjJoqOgiUlOGI=;
	h=From:To:Cc:Subject:Date:From;
	b=ihWTKagumHTUCPqoqQSP5dJ+r021XdopULEW70Jh8s4BxoKFuvFzO+Pejhbdu+/sc
	 OfpV1I54uTX98K05zd7pMs6jNFiaLMwCTi0wYX7R8zcc/ImK6w7LKU4TPdDMr6bdYB
	 y5S8WBrwozk6MrrYd7emmuMvhAL/B3fqRiXtfgqY=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Andrew Chiang <andrewchiang@microsoft.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 6.6.y] ext4: fallback to complex scan if aligned scan doesn't work
Date: Fri, 16 Oct 2026 15:20:18 -0400
Message-ID: <20261016192018.839676-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit 1f6bc02f18489b9c9ea39b068d0695fb0e4567e9 ]

Currently in case the goal length is a multiple of stripe size we use
ext4_mb_scan_aligned() to find the stripe size aligned physical blocks.
In case we are not able to find any, we again go back to calling
ext4_mb_choose_next_group() to search for a different suitable block
group. However, since the linear search always begins from the start,
most of the times we end up with the same BG and the cycle continues.

With large fliesystems, the CPU can be stuck in this loop for hours
which can slow down the whole system. Hence, until we figure out a
better way to continue the search (rather than starting from beginning)
in ext4_mb_choose_next_group(), lets just fallback to
ext4_mb_complex_scan_group() in case aligned scan fails, as it is much
more likely to find the needed blocks.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/ee033f6dfa0a7f2934437008a909c3788233950f.1702455010.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Fixes: 83e80a6e3543 ("ext4: use buckets for cr 1 block scan instead of rbtree")
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 fs/ext4/mballoc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4ec4388932ea..646f55ba0dd1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2954,14 +2954,19 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			ac->ac_groups_scanned++;
 			if (cr == CR_POWER2_ALIGNED)
 				ext4_mb_simple_scan_group(ac, &e4b);
-			else if ((cr == CR_GOAL_LEN_FAST ||
-				 cr == CR_BEST_AVAIL_LEN) &&
-				 sbi->s_stripe &&
-				 !(ac->ac_g_ex.fe_len %
-				 EXT4_B2C(sbi, sbi->s_stripe)))
-				ext4_mb_scan_aligned(ac, &e4b);
-			else
-				ext4_mb_complex_scan_group(ac, &e4b);
+			else {
+				bool is_stripe_aligned = sbi->s_stripe &&
+					!(ac->ac_g_ex.fe_len %
+					  EXT4_B2C(sbi, sbi->s_stripe));
+
+				if ((cr == CR_GOAL_LEN_FAST ||
+				     cr == CR_BEST_AVAIL_LEN) &&
+				    is_stripe_aligned)
+					ext4_mb_scan_aligned(ac, &e4b);
+
+				if (ac->ac_status == AC_STATUS_CONTINUE)
+					ext4_mb_complex_scan_group(ac, &e4b);
+			}
 
 			ext4_unlock_group(sb, group);
 			ext4_mb_unload_buddy(&e4b);
-- 
2.56.0

