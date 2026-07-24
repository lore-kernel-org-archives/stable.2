Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36042376B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890146; cv=none; b=Nt4bcm9qyHa53dKzFc6PZ+zjfx9ea4uDsDTOZaqZkY6EI/YwzB/dioemD9CImqrtvEmqwlDxsMJy1E91eoKfg59dl102sqdRddqsioq24DYFT7EyJTfiJgJxN3xtQgUSghJjKhl7NWVlKHjhQc7goLbfid/ZR3qFbVCHrUsgRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890146; c=relaxed/simple;
	bh=uFHAQNmmzqiIH5Uj7wkw0geSc07A55/89tNEu6rGY4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXoNqrnwMeYSWV3hSiDigyNVI7gDryLTTorpm6Wn0KQj04ZHF4VyxNHWdKKQoFbQtxiof0kxsHa03kqIHnjE8k2rMqplqVMJD33wyyAA+dcEW6LWrO0DE1qSYpumsX78KLsPBizXSUNVj1DT4pEQBXVoM2ymwBoTrgNnlO5I4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrdH31dz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrdH31dz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A2F1F000E9;
	Fri, 24 Jul 2026 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890145;
	bh=1K0MRmSSNqI/Epnm/oOhdFRRSeWD6wT+cM2XzL+a+x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrdH31dzW1noXuKH61uHcvLjFBLk2qqTihaAYKBmg7UV5hAW6AwtnMLherlkVba9N
	 92GkYVSj/lam2I2117V46r0ZAJ3TTv/GRYho5nR29WnRlea6LAmQtBkoyMEH1od9ez
	 m4rjJUD4RGmI6s3oIsPY7xUBwhLMT+iSJA9DMOzVjxfwB8ak1g2gHPHOpRyayRPG/f
	 yolj+SfSH2i2iy9WO6oxsrfbM1EeyMQg7iQK5na5fLjSVPrlbuMluhG31yKLGc8eH6
	 6aVTZzUOejyuMM8j6vtbiOBmCi/Lxt8nV6sd4hBBarN3l7j+Yo6GXbCw36q/V18Pxi
	 Jr+NAWO9qaYxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis pass
Date: Fri, 24 Jul 2026 06:49:00 -0400
Message-ID: <20260724104900.3973962-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724104900.3973962-1-sashal@kernel.org>
References: <2026072042-litter-retold-6915@gregkh>
 <20260724104900.3973962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 5e7b598660cfa8e5af172cf4c65cffc126333307 ]

In log_replay()'s analysis pass, after find_dp() returns a
valid DIR_PAGE_ENTRY for the (target_attr, target_vcn) tuple,
the copy_lcns block walks lrh->lcns_follow further entries:

	t16 = le16_to_cpu(lrh->lcns_follow);
	for (i = 0; i < t16; i++) {
	    size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
	                        le64_to_cpu(dp->vcn));
	    dp->page_lcns[j + i] = lrh->page_lcns[i];
	}

find_dp() only validates that target_vcn falls within
[dp->vcn, dp->vcn + dp->lcns_follow), i.e., that the FIRST
cluster is covered.  The walk through the further entries is
not bounded against dp->lcns_follow.  For a malformed LRH
where target_vcn = dp->vcn + dp->lcns_follow - 1 and
lrh->lcns_follow > 1, the i > 0 writes overflow the dp's
allocated page_lcns[] array.

Add the missing j + lrh->lcns_follow <= dp->lcns_follow guard.

Reproduced under UML+KASAN on mainline 8d90b09e6741 as a
slab-out-of-bounds write of size 8 from log_replay+0x68d4 on
the mount path.

This is distinct from Pavitra Jha's 2026-05-02 patch
("fs/ntfs3: validate lcns_follow in log_replay conversion",
<20260502154252.164586-1-jhapavitra98@gmail.com>) which
addresses the separate version-0 dirty-page-table conversion
path's memmove(&dp->vcn, ...) call.  The two fixes are
complementary; both should land.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
[almaz.alexandrovich@paragon-software.com: clang-formatted the changes,
fixed conflicts]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 09048409fe981d..8653c05e7b13e0 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3368,8 +3368,8 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 
 		if (run_get_highest_vcn(le64_to_cpu(attr->nres.svcn),
 					attr_run(attr),
-				        le32_to_cpu(attr->size) - 
-				                le16_to_cpu(attr->nres.run_off),	
+					le32_to_cpu(attr->size) -
+						le16_to_cpu(attr->nres.run_off),
 					&t64)) {
 			goto dirty_vol;
 		}
@@ -4547,22 +4547,34 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		 * whole routine a loop, case Lcns do not fit below.
 		 */
 		t16 = le16_to_cpu(lrh->lcns_follow);
-                t32 = le32_to_cpu(dp->lcns_follow);
-                if (le64_to_cpu(lrh->target_vcn) < le64_to_cpu(dp->vcn)) {
-                        err = -EINVAL;
-                        goto out;
-                }
-
-                for (i = 0; i < t16; i++) {
-                        size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
-                                            le64_to_cpu(dp->vcn));
-                        if (j >= t32 || i >= t32 - j) {
-                                err = -EINVAL;
-                                goto out;
-                        }
-                        dp->page_lcns[j + i] = lrh->page_lcns[i];
-                }
+		t32 = le32_to_cpu(dp->lcns_follow);
+		if (le64_to_cpu(lrh->target_vcn) < le64_to_cpu(dp->vcn)) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		/*
+         * find_dp() only validates that target_vcn is the first
+         * cluster covered by dp.  The walk through lrh->lcns_follow
+         * further entries must stay within the allocated
+         * dp->page_lcns[] array, which is sized by dp->lcns_follow.
+         */
+		if (le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn) + t16 >
+		    le32_to_cpu(dp->lcns_follow)) {
+			err = -EINVAL;
+			log->set_dirty = true;
+			goto out;
+		}
 
+		for (i = 0; i < t16; i++) {
+			size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
+					    le64_to_cpu(dp->vcn));
+			if (j >= t32 || i >= t32 - j) {
+				err = -EINVAL;
+				goto out;
+			}
+			dp->page_lcns[j + i] = lrh->page_lcns[i];
+		}
 		goto next_log_record_analyze;
 
 	case DeleteDirtyClusters: {
-- 
2.53.0

