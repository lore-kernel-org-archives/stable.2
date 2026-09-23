Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA990345750
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127622; cv=none; b=jt4xANifHDw8X2vAxVaoYOPBU4+amH2MtKrPz1oYh4TryL3GB0fQLZxsGsn7reC51/lnSLNQcZ8AQvQ2zCbsaXu2J7qvLJ2GunMJnwpsciRifvPGV/gBrE98SpJ2+1tFU2LW6DuDrHR2QR7/da32TyzeUeNKy6QVw7lKxJTOe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127622; c=relaxed/simple;
	bh=dGBht1LB6t09O9U3kT5sMJ12e9zHqbBGWDtv6DAt3so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUiP05L50/IY28UwVZCibwa/Qquh2kyTzcCxwlq6IR8cUYwf1eoSKMBwOmvUK4cR8exPK+zr92MG6vjqUrsu25VpbQzIN3vPtEgjAnFTjUFwQZzREU8CQp/9z/QbTA7K9EXoiBU1o/5cjLMXLysIeNFzRiKL5FJAIXpAGlUB15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORWdWu9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORWdWu9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9551F000FF;
	Wed, 23 Sep 2026 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127621;
	bh=m7uf9D3KhpCprGKbthyvDnA5CAINALoo4mG+34OVSMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ORWdWu9X6IXwK9mN7oY7U0sHD/zYQfAUezgonjajN/zWel3GjKgt67wknb7Cudc2+
	 dC9DWPmTAZbXbx+WJFpHfUxSqb0dODdeOSRr6rDyddLNVIG+ihdkF4ZJ4z5pPzplgc
	 /6hH7rV7U3Xo7Tbs3AHEBlnBJoRJyHidTSzTqUEIgpUyhBf2Tp+omg0bBtbeNsb7kt
	 5gSNzaCNuqfYxwvMZbl1LcT4MUpr8ENTkqIzwL6CNaGlz04/f4NUcRjY9hx97ism7e
	 iDlr8NnjdmIgeeGhNIs7eh/y9Ze9qqcGKp+aka72u013czWdM433RIzB/wdUrk0Zhh
	 E4c1ZlFXf6Wfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] cifs: validate DFS referral string offsets
Date: Tue, 22 Sep 2026 21:40:18 -0400
Message-ID: <20260923014019.880289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092229-hypertext-grunge-945c@gregkh>
References: <2026092229-hypertext-grunge-945c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 027a84ac6b50c12ef767c15abfc58aa865820e9e ]

parse_dfs_referrals() validates that the response header and referral
array fit in the received buffer, but each referral also contains string
offsets supplied by the server.

Those offsets are used to compute the DfsPath and NetworkAddress string
pointers without checking whether they still point inside the response
buffer. A malformed referral can therefore make the computed pointer
exceed the end of the buffer. The resulting negative max_len is then
passed to cifs_strndup_from_utf16(), and the non-Unicode path forwards it
to kstrndup() as a size_t, allowing strnlen() to read out of bounds.

Validate each string offset before deriving the string pointer.

Fixes: 4ecce920e13a ("CIFS: move DFS response parsing out of SMB1 code")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

[5.15 backport: Apply both offset checks to fs/cifs/misc.c, where
parse_dfs_referrals() lives in this tree. Preserve the existing parser
and error cleanup; no new functions are introduced.]

[ sashal: Reduced backport -- upstream 027a84ac6b50c touches 1 file(s), this
  backport carries 1. Not backported here:
  fs/smb/client/misc.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: e83330c55edc ("smb: client: fix missing lower-bound check on DFS referral string offsets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/misc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index cb7fb2c4ea71f..729624ae9d876 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -920,6 +920,10 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		node->ref_flag = le16_to_cpu(ref->ReferralEntryFlags);
 
 		/* copy DfsPath */
+		if (le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+			rc = -EINVAL;
+			goto parse_DFS_referrals_exit;
+		}
 		temp = (char *)ref + le16_to_cpu(ref->DfsPathOffset);
 		max_len = data_end - temp;
 		node->path_name = cifs_strndup_from_utf16(temp, max_len,
@@ -930,6 +934,10 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		}
 
 		/* copy link target UNC */
+		if (le16_to_cpu(ref->NetworkAddressOffset) > data_end - (char *)ref) {
+			rc = -EINVAL;
+			goto parse_DFS_referrals_exit;
+		}
 		temp = (char *)ref + le16_to_cpu(ref->NetworkAddressOffset);
 		max_len = data_end - temp;
 		node->node_name = cifs_strndup_from_utf16(temp, max_len,
-- 
2.53.0

