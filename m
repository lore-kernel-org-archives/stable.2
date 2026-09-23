Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE28326939
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127968; cv=none; b=QuqyYOKkobdY+mBBcXX3bNCiPgSCpgEgerSedf1OQQGfslMwu4ukiNdk1X8UJQ26okmC1kvwRgiYykD44dtN0R1z+g4CaFO2LYEpHG2uW6PmwJGM0t3ayiTSfGMHIpPdcDchqWQP8NVOP6/YXoUhyrP9Bq+sbPYnuad8t3v7Sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127968; c=relaxed/simple;
	bh=3BfG+YVsiz1iHqM5VkuenAxwdgjeRnU31dSKNEZniDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwZqdUpQnA3Fnqs1IR/CzSWAEKd+JBVeQLc4AO+0OLb1PKfuS8Lefd0cCJXE/nLCE2VzynM5vk03KJN8V/RfIYKlFfAbAqpU2e0QRMB8VPrMa+JBmTPJMCIna59TbYksA9c6e8xh3wLeap2Ld9cHSKTO1xg4WU3dhoVs4BVKgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B73XS9wN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B73XS9wN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A57E1F00893;
	Wed, 23 Sep 2026 01:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127966;
	bh=W4sSIotsI2hotZtdjnB0qGoWAFpndvIBtVzEzIAQqpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B73XS9wN0KxplGAARgM+jiONx/y5sQZTphTznJTHPGaSpBCSGJY9Y2LiRnsjGHQ6s
	 qFvazQGDTbdaMibE6SVRx+LoBpoxeH2pRtuKUZdPZ1/ykwgkugmgMhiQpuR801BnXQ
	 GzebcqzT3+Tpj9JokG09H+r0Ye2ImdbjSpiVbDWcrPS6swrK3SZGY665LCFL/z6RNF
	 zF6QUrQ3iV5tInRekgMKnB7aaW7RacSVbWhOIn60bbP5BEImA/dmtrYUCqCltL8lE+
	 wxlQqQIofZH21mCgM/iF050L7LLQ79MwW3jda2XCb2pCI+Fvv5eTyqiq+xdbGqWBDj
	 GqmWEyPI+g4Fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: fix reparse buffer bounds in cifs_query_reparse_point()
Date: Tue, 22 Sep 2026 21:46:04 -0400
Message-ID: <20260923014604.886716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092200-counting-versus-1e52@gregkh>
References: <2026092200-counting-versus-1e52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 5f0306e731e2f46e91419eae57eee3a241c055e0 ]

In cifs_query_reparse_point(), the start >= end check before casting to
struct reparse_data_buffer * only ensures the start pointer is within the
response. It fails to verify that there is enough space remaining for the
fixed 8-byte header of the structure.

If a server provides a DataOffset that leaves less than 8 bytes remaining,
the check passes, but subsequent reads of ReparseTag and ReparseDataLength
will occur out-of-bounds.

Fix this by ensuring the remaining space is at least the size of the
reparse_data_buffer structure before accessing its fields.

Fixes: 56e84c64fc25 ("cifs: Fix validation of SMB1 query reparse point response")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Adjusted context to retain existing `rc = -EIO` error handling instead of upstream `smb_EIO2()`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index e7df15011ae33..3ba39c375077f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2793,7 +2793,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
-	if (start >= end) {
+	if (start >= end || (size_t)(end - start) < sizeof(*buf)) {
 		rc = -EIO;
 		goto error;
 	}
-- 
2.53.0

