Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887FD35DA6E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127623; cv=none; b=DIV/HdhD3Roaebg+zzaDQkf3FXhTDgPleshS6N4h/j8d17KXm9i8jkGlQQFHELVTLZcuq8AKPrxeutuQgOAEplbbLVIbb1ACv+W5dZoVB+Vog00afl088dkO2r34lsZXDAC2f2kkOOmzjPBFAWVWZenHMJ2SXoiH1X7PK3lVSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127623; c=relaxed/simple;
	bh=VW1Hiwp2ILKHWnJEmqpnNyO/disSdziOQKQ43tEoiwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0u1nWee689z4nstmvZrDOEDBvGngEefYdri63pNfXd9a3EDdYAAyCEkkFWbG9WYghbznOtI7iStmAX+zoUndicMfIPb5q4/UpeqU+mIi/tBu5nUJzkrfGFDN4L22GyrpGzB8QghPQMTrK1vnA9qwNPHHHlci2F/9ofxXH0QRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbRiAn13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbRiAn13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9231F00898;
	Wed, 23 Sep 2026 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127622;
	bh=83zIyWJUxHzATQIzUHRMSVie/cH0tnz3rHwLlpsjd5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbRiAn131aOxKKbIqz5w5MnRgAKAKeruzQ3R/CERQ7Nvz+X83Mod/oz3d7pRoV/Qs
	 Ls0NtEmLMkd0vyHBXAMI/FlhFVKgVK0AK2U/PfxbQ/Y+EsewQX8cYRwt72vTWqkAZJ
	 BpuVOZT78Cj8hFTMq1/KyYR1wrJxCgOGY3393xU2v/sZFrqRF/KUi6Jn3GqFLCI9b+
	 oSj6HfakOMZgYjOJE8xvHt4AeW3ZFLOqchqNkrDx3RtRmhxD3cbIpB57Bfsvz8RRaA
	 sJ4imhi7rX8PfQcPaig4UfWU1HKM4d7m1Ym4T935OdhClJVlO+CpfxIvkS4ZVIq54n
	 ig8P9GjR9nCkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] smb: client: fix missing lower-bound check on DFS referral string offsets
Date: Tue, 22 Sep 2026 21:40:19 -0400
Message-ID: <20260923014019.880289-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923014019.880289-1-sashal@kernel.org>
References: <2026092229-hypertext-grunge-945c@gregkh>
 <20260923014019.880289-1-sashal@kernel.org>
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
index 729624ae9d876..a477bffdd3e80 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -920,7 +920,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
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
@@ -934,7 +938,11 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
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

