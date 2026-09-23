Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30635E1BD
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127970; cv=none; b=lVQtGfmZoteXScJFK64wYG756gligMZ6lZP0UcRO8jH5ykdAILf/4i35BG2v52AO8P98peGNOaQsB5yo++KXYWfUNpm3vYpAn3Ondxj3RVroNQhgW7WyAgNcBIM0U+YrWi9CL1I0IVbMJG+Sg6b0dUQp4iF0GqhYLvjaJ3y2dC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127970; c=relaxed/simple;
	bh=c9WTH2fAx4O26my8A0H3dUrE/uN/VcmZtjFma6CQvh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxafvcOLjF0jH9Eh+HshJMX+ex219iRJBqT3G2rHP1CMZHmvJ7wkUmfEq2TOzrpFZnyp6TyEhIBccr8aF6nvZb6+0m2OrCYarCyNiGv9MTxJqXt78ub/vNTkzH8sM/n8F1qD8n3Dl2sPAC+Cz3CraNIOJ4Cv2K4IgTD+k3Z4gTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naKkHeRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naKkHeRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E5E1F00893;
	Wed, 23 Sep 2026 01:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127969;
	bh=gMiy2SkcrbONAYOAdWjBa/jr2TBMWR0vrrDfu0fBq68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=naKkHeRdiW+AOCWclaGDwB+1m6P7+WETiNo8PX7VuyAl+ipJBSq1nf31QsvbT1SxQ
	 Up2tls8jwgQGRGzUPz4+VRWBrqhM+Bg3P74oqyoOD8nTdv/0R5Hvs9TlaLfsUEgVKz
	 4//bXhBJK6cQiyfugvZFwYKswM0TIHufRG5NUHObfsVG6dar95fm5DFMumDzo0fgDz
	 jA7/HmKOucerh2q1+B3jHgHsWc4DPVMVKUju3Yhl3UrRCTTUwl+CdfO6e9/f6Ee84A
	 B7ZsKqcq82x/6FWSfjW0HjBdoGgwJhbBPUUVFdBF741zzhxeYsS8ieOzGp5okxGA3G
	 dlRP4tCu4QZqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] smb: client: fix missing lower-bound check on DFS referral string offsets
Date: Tue, 22 Sep 2026 21:46:06 -0400
Message-ID: <20260923014606.886810-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923014606.886810-1-sashal@kernel.org>
References: <2026092230-mobilize-android-8f08@gregkh>
 <20260923014606.886810-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit e83330c55edc0c3ac08aa6c95e49e4694c65523b ]

parse_dfs_referrals() checks that DfsPathOffset and NetworkAddressOffset
do not exceed the buffer end, but fails to check that they don't point
inside the referral header itself.

If a server provides an offset smaller than
sizeof(struct dfs_referral_level_3), the derived string pointer overlaps
with the struct fields, causing cifs_strndup_from_utf16() to interpret
header data as UTF-16 strings.

Fix this by enforcing that string offsets are at least sizeof(*ref).

Fixes: 4ecce920e13a ("CIFS: move DFS response parsing out of SMB1 code")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Redirected the patch from fs/smb/client/misc.c to fs/cifs/misc.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/misc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 32b04a461f13b..0d4751a568e1e 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -757,7 +757,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		node->ref_flag = le16_to_cpu(ref->ReferralEntryFlags);
 
 		/* copy DfsPath */
-		if (le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->DfsPathOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: DfsPathOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->DfsPathOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
@@ -771,7 +775,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		}
 
 		/* copy link target UNC */
-		if (le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+		if (le16_to_cpu(ref->NetworkAddressOffset) < sizeof(*ref) ||
+		    le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+			cifs_dbg(VFS, "%s: NetworkAddressOffset %u out of range [%zu, %td]\n",
+				 __func__, le16_to_cpu(ref->NetworkAddressOffset),
+				 sizeof(*ref), data_end - (char *)ref);
 			rc = -EINVAL;
 			goto parse_DFS_referrals_exit;
 		}
-- 
2.53.0

