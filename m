Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE737C10D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219298; cv=none; b=KLHdMeg4fRCur5X9yIvRzGZnWIOvSEsQzc12PEAEg/tHhfM63A+z4V+hItEc9eghIKEHDnzRVid9M9efe7y8/0pXYeJVmqBBup15jCEInpM8HEpmvnyr8DaXOM/0VNxv63k2K9x5Oqa0/f1GKLitaXYb2Y/z6UQK1C1Yj0/aFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219298; c=relaxed/simple;
	bh=3A0ys5txRIGGEbNLtfXd7cTMliL3qLMjjGwGc7gE85I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYdKkFyy/wWy3/vfK6rKl+gRY1ZP92Sw1ixt+mkAC90HVxMF1zXfaGkIhA1wuC/R+zIACtkDvH3NYGng9MtkFdVlDHyEwoF9u6xD1qh3R4510sOdsUqvXqImHm9y5klePUwUNM8HiyywA2ePQD3wjJNT1o7uQzfj+WL3Czhf/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ8PADVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ8PADVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828641F00A3A;
	Thu, 16 Jul 2026 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219297;
	bh=834jB4XVlpjW74BR6/SvqR/KoXwCV00e2zUXwVawwC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZ8PADVw9FMEJGfBNnaVKdQWuECACKCJzD2O+VLyKls319q5vv/RDsK3hQNGJAKwl
	 U37FS4GUYdWAM2qSd7RRGdML78/kNSlsRl5ib2jV94RTaBqSv4sCwqolHysJoWufzL
	 UgpFQx/9GvrcUep0mJv4mtL7ixwvnWW9aDMlcuPWjM0E8HknjyrOFIHou2xDzCoTag
	 /QKtRepHTijS6U5uinP3jisdFQePYVFBdaG7EHEYtnrguJL4g/dMuo8/aEJa/JiWUZ
	 QHbl9RV4F2WHj0t/8tmuEYhlznQarUNx+bvM0DR5/NT9M098NXMmZNg9d2BEu//fzt
	 CiUtD6phiri8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <xizh2024@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: use unaligned reads in parse_posix_ctxt()
Date: Thu, 16 Jul 2026 12:28:10 -0400
Message-ID: <20260716162810.635369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071412-earring-oozy-27d4@gregkh>
References: <2026071412-earring-oozy-27d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

[ Upstream commit b86467cd2691192ad4809a5a6e922fc24b8e9839 ]

The server controls create-context DataOffset, so the POSIX context data
pointer may be misaligned on strict-alignment architectures. Use
get_unaligned_le32() when reading nlink, reparse_tag, and mode.

Fixes: 69dda3059e7a ("cifs: add SMB2_open() arg to return POSIX data")
Cc: stable@vger.kernel.org
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 4197096e7fdbcc..da65e36794ee84 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1975,9 +1975,9 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 
 	memset(posix, 0, sizeof(*posix));
 
-	posix->nlink = le32_to_cpu(*(__le32 *)(beg + 0));
-	posix->reparse_tag = le32_to_cpu(*(__le32 *)(beg + 4));
-	posix->mode = le32_to_cpu(*(__le32 *)(beg + 8));
+	posix->nlink = get_unaligned_le32(beg);
+	posix->reparse_tag = get_unaligned_le32(beg + 4);
+	posix->mode = get_unaligned_le32(beg + 8);
 
 	sid = beg + 12;
 	sid_len = posix_info_sid_size(sid, end);
-- 
2.53.0

