Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9A375ADF
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723059; cv=none; b=YIelMQT/kgfLvHqXB4yUHUdASPgg+G0JNYttdsUxOm3LOBnGEMScRXYaidwhJcargikrTJsCKhDBmZcqhTS63fe6jubLPWpAgEvZbCQ7FVhD9sCbBSMBQK9tQ9cCPZY4x2YOMeE16huva0hM+mlryPqIa23aJvEvK6sfBK9EWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723059; c=relaxed/simple;
	bh=UsTQNPbpDZ0ztoqh8RN0nV6fEBPnOtNX4Lz004EPmNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTpXNddfbqDMi8TbzevpYT9wG+R6rQGqc4biFz7CwZPYDig5E39ueOBjSn4s+7BfLFN28IaF13csMrm9b675HXuFrw/68OnBG83gA1jDa+gDB97ZC7pIpYtNn2UhkF2lL/LDpI7+gdkdmWV0E3sXsKlVhjkbvffMuwNY0GJ4FsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBkL5BLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBkL5BLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEBD1F00A3E;
	Sun,  6 Sep 2026 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723056;
	bh=VzDtmaVNOJx/dOFVaF75460wkIVdAULVfR30DCD/wNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cBkL5BLLbPEop8TwBa4us0sKEyfLtbYyduNEfxSE1WEbG1oqhSOSUNOmYvzALnhzF
	 oJwPt/pdXgnDHRhSaWbLGv5SpMEQOMjS2cJVCPK0vmpVAOmj87lp7OAddwO/jfB2C9
	 OL34WIJI4qPoW7U8z88D60Ldj63ALg57oPD54h+aARZgLk1GHsHfpn5uYhYci/nxuR
	 PccIj7zR7vl/QPya22HFicWA2ioOVQZ9ycukfiRnEUzpSSWTCve4IrkyV0EAtW/7MR
	 C3KBwOn9xySRPYQprpWLKHz++lyoURnwXIklp94kRJRf7AIt2zmJGphaxCccnRBt7V
	 /yO1aUKQl4qKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huiwen He <hehuiwen@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] smb/client: emulate small EOF-extending mode 0 fallocate ranges
Date: Sun,  6 Sep 2026 15:30:51 -0400
Message-ID: <20260906193052.1791917-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906193052.1791917-1-sashal@kernel.org>
References: <2026090358-afar-boss-f2c3@gregkh>
 <20260906193052.1791917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Huiwen He <hehuiwen@kylinos.cn>

[ Upstream commit 7a06d3b816d73448b4e38b83d65049f090b7b201 ]

When a mode 0 fallocate extends EOF from 1G to 2G + 1M, the client
currently sends SetEOF for 2G + 1M. This can make fallocate return
success without allocating the requested range, or allocate extra
space before that range.

For example, on a fresh file:

        xfs_io -f \
          -c "falloc 0 1G" \
          -c "falloc 2G 1M" \
          -c "truncate 3G" test

The second fallocate should allocate [2G, 2G + 1M), leaving [1G, 2G)
as a hole.

Before this change, the result depended on the server allocation policy.
With Samba "strict allocate = no", SetEOF could return success without
allocating [2G, 2G + 1M). With "strict allocate = yes":

	# filefrag -v test
        [0, 1G)             allocated
        [1G, 2G)            allocated unexpectedly
        [2G, 2G + 1M)       allocated

SMB cannot allocate that arbitrary range, so write zeroes to small
EOF-extending ranges instead. Limit this to 1 MiB to bound the
client-side I/O cost.

With "strict allocate = no", the requested range [2G, 2G + 1M) is
allocated by the writes. With "strict allocate = yes":

	# filefrag -v test
        [0, 1G)             allocated
        [1G, 2G)            hole
        [2G, 2G + 1M)       allocated

This fixes the small EOF-extending range case exercised by generic/213.

Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 32a7af68df73 ("cifs: add cifs_resize_file_locked() to guard fscache_resize_cookie() under i_rwsem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 3a833a55491d3..c25914888beae 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3553,7 +3553,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	int rc;
 
 	buf = kvzalloc(min_t(loff_t, len, SMB2_MAX_BUFFER_SIZE), GFP_KERNEL);
-	if (buf == NULL) {
+	if (!buf) {
 		rc = -ENOMEM;
 		goto out;
 	}
-- 
2.53.0

