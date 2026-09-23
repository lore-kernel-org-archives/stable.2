Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D67326939
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127969; cv=none; b=DUAMYZqpq/5ARKC1+IbMrk0yN7JYUiWxEUeIPvGKb3hmoj/SPxehJuyIW0dLf0RUc90x4hZDqoi7x+HowIdu9jR4hgVhB/RwwDRJTZzLpnPQR6XJCm1wc0JkPghM4JeVeW1jjiYU6//AN5U17QGO40dzdMsIFvskw9F/HfygG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127969; c=relaxed/simple;
	bh=3WlbhMAAOan+GZwvUZkZTdoF8LXIy/IxHquBtN8wQvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nN8TzIj+nOhl12M/T502mf5GYUcPom+Z273K2WKeb69XeYHJblQiRzO192LBkRrCIGTXA2eJl9ab5v65F3RygJgFfNhHo/3iNpMifm+CDgPR7DUVXL1eckj7+cQnO8NUoGeFBqTvf+6XsyKpRQhERdug7Cpm4AFTk/FrPhHRxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLiwZsks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLiwZsks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D291F000FF;
	Wed, 23 Sep 2026 01:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127968;
	bh=ITesQs2CSxp+wjZ7/ffQY+GuCQfilWlDVKAH9G9aQS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WLiwZsksL39wpAN8amy7VObsjTDsN2CpyWFA94ojThGwM5oLc8zE3DuNF8REb+uF2
	 Po2uXSsER9nOgr0okj8OTNTpMJ2m98t1GImGyZ2LzVqn9kMQdTLS41CVh8CLtt9bvf
	 nkUGhPQo3KfKmdX0eDPZ433FarCLArVziLl3mzYmtSc5nSBzXIDaiVVip0Zd6SNlHF
	 gcpkMm15b5HExmTzGpW6khA9bKO9BOvaIGL94tn6sudfEMIzPQAixvMGzZOa1NCtPT
	 ZuMA9oNOopNiKK/oDnEETeTrp/2Yg4p4ndyfJ9AZIhrsgbYM8ktT2p9EtQkBi0E3Ij
	 lg60QiLG8DqfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] cifs: validate DFS referral string offsets
Date: Tue, 22 Sep 2026 21:46:05 -0400
Message-ID: <20260923014606.886810-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092230-mobilize-android-8f08@gregkh>
References: <2026092230-mobilize-android-8f08@gregkh>
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
index b4199b4085db3..32b04a461f13b 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -757,6 +757,10 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
 		node->ref_flag = le16_to_cpu(ref->ReferralEntryFlags);
 
 		/* copy DfsPath */
+		if (le16_to_cpu(ref->DfsPathOffset) > data_end - (char *)ref) {
+			rc = -EINVAL;
+			goto parse_DFS_referrals_exit;
+		}
 		temp = (char *)ref + le16_to_cpu(ref->DfsPathOffset);
 		max_len = data_end - temp;
 		node->path_name = cifs_strndup_from_utf16(temp, max_len,
@@ -767,6 +771,10 @@ parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
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

