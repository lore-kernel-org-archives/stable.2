Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C647209A
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390043; cv=none; b=VVuy1FcGvQfS15DMNkMd3TrI3iadqA939U69IwEW9T+8vfiDLOTlY9Mmff1Y24T1gO7iEOyGvXG+aMaaw93pRNqocrBL/uyXabA6krZF1JoYGEHxYnEpuM6Z8E288NzwkFpoAFVQlioeRdvVBzaDRD2jp9GMwIZD7YWIpBW6QGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390043; c=relaxed/simple;
	bh=Htw90uawr0RBheWt4lJbAM8/suqyu0iERBnRDYZF+q8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dt6LLFSu7l/nMY3GlOelywkCv+ctjXfZx/6119a7n/Lb6MecXhqaJAcKDDYzkD3vqSEI32jdnMw9wwnOvir36dR6nWK3DqOalJsiN96BPakJXeCZJxglOIoNXysDsKF4Mjeb7jt0ZZpZLjYz38sYjKaHnL4fG/e/ykDnAwX75CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tfbdxv3e; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tfbdxv3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1789390038; bh=F/XKlI1t6HEl9goJUxx6FuIR2PC/mUku42HpEnc5F3s=;
	h=From:To:Cc:Subject:Date;
	b=tfbdxv3ev00nzrnXUGinsv6ttUXQnKr2lbj1IdSS3LMvtrxCB5OYGyfX326JUDlAU
	 uE6I8FWOnmQQSkhxRmEkBilmBpxQSkhO+KRryzkB8sIIfh0DSR+QNV/qeYWG8hhnWE
	 074VnF/1f5Fs7ZjvOqI4i5CMxO4IEWa1ZJntYn7c=
Received: from fs.localdomain ([221.176.157.243])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id B86970EF; Mon, 14 Sep 2026 20:46:06 +0800
X-QQ-mid: xmsmtpt1789389966t1bxy4pu8
Message-ID: <tencent_FE3BBC743E8B31B9B7B928007B10E0AD750A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GyY1OsoeWamz/LZZqpb3hi01XQhEXhnmw4mWHUVgRhpHLXIWYdm
	 f28eWgbFroQU05uGtSh7mNJtWGdHNm0d3AaAdGWYZnDwvrfagYHa8vmT5XN9LC10dV/BOmHbyq3w
	 YlIEPAWdbpR52jiVVlLFgYhNA99KTdD0mTcX4YCALgVJH3ng7HPYOCrxAZb/Hg4q7IrZcC1ilG+h
	 iyk2vlLhJHEyYhG7uk0t1QoLnS1i1k82ayZ0afXCcoyy4xD6NXf3jE7RZfpkEwODot8SVxv//YBJ
	 /5A31cmAdb0jyOvMO3uquOvDOZul1+mKupqeOS19FX3EFztpg4qkpdixWeGaQ0AbPZtNzGn4vMKy
	 N5KCjVFDFwGOkEdvsj0tXN//GyoEPgCVGJ/QSAmie6ey4zf2o443VCkZ+wncB5069SsPKwbTCQfT
	 a8OJjEq7b6X2JKxDqWExC/yQJPaveaZKlhXmfhSpxuA2jvuXM6hN63nOMNmTZiBTstLO2BPdfZ5A
	 rJ/qy/LqrNmTCkZ8xEVjkzTD7OtekiIQIwXzgb35aEJn7k9G7VtyVqmCNd7EZPtuifx9eGy0dXFW
	 Sy5cVr1nyrRznULrSIPHCdNtWCk2XGCDiNBObOOYivEZVNjRjDj7l3by5cwde7Aq3wZpKyo+U8Gb
	 BTDV6UNJVyXaZww+sTzoHqHqH9U/jhwyArtrbJtpdtmGs7DrHR9ug1FL81HoqrIrWir2uaYTglud
	 MPNlyzZCN5IP/Bw16qLsS0r3eVsUrYv2NA5lWhvt0XWYBZZlLdP7xw6wcbgSayafO3qmXPiLHakr
	 8Z69YjzieBwpx7zGhEFTCkSRJPVB1CtjN8VnqSN9qnlvGymD2chYhm1YvkQi2kJadNGgxMumC4H1
	 Ciay3Wu79XsfovuXXEYyHYl917gtxWyTjjQNcFBu/4iwu2WZkLZN9vp9niroSS+Ky/AOoQz2gIkc
	 p03hyP1OpjOsNSgxqA3ue4BniqV8csN87lLwV6RadcTFp7ppwOqe02gmH8wtGCOXthN6TAWb9tJy
	 hLLjo2ddyiqpd1saNDUiGzVylZ7Vw=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: lty <781735889@qq.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	harshadshirwadkar@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lty <781735889@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: propagate errors from fast commit block cleanup
Date: Mon, 14 Sep 2026 20:46:06 +0800
X-OQ-MSGID: <20260914124606.843852-1-781735889@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4_ext_clear_bb() stops scanning when ext4_map_blocks() fails, but it
returns success to its caller. It also ignores failures from extent lookup
and replay-region allocation. ext4_fc_replay_inode() ignores the helper
result and continues replay with stale block bitmap accounting.

Propagate all cleanup errors from ext4_ext_clear_bb() and abort inode
replay when cleanup fails.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Cc: stable@vger.kernel.org

Testing: QEMU fast-commit replay with an injected -EIO at the
ext4_ext_clear_bb() mapping call. The unpatched kernel completed recovery
and e2fsck reported a free-block count mismatch; the patched kernel aborted
recovery with EIO. Also built the ext4 target objects with the expanded
error paths.

Signed-off-by: lty <781735889@qq.com>
---
 fs/ext4/extents.c     | 31 ++++++++++++++++++-------------
 fs/ext4/fast_commit.c |  5 ++++-
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 76038b6c3655..f65d254c0d5e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6363,29 +6363,34 @@ int ext4_ext_clear_bb(struct inode *inode)
 		map.m_len = end - cur;
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 		if (ret < 0)
-			break;
+			goto out;
 		if (ret > 0) {
 			path = ext4_find_extent(inode, map.m_lblk, path, 0);
-			if (!IS_ERR(path)) {
-				for (j = 0; j < path->p_depth; j++) {
-					ext4_mb_mark_bb(inode->i_sb,
-							path[j].p_block, 1, false);
-					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
-							0, path[j].p_block, 1, 1);
-				}
-			} else {
-				path = NULL;
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
+				goto out;
+			}
+			for (j = 0; j < path->p_depth; j++) {
+				ext4_mb_mark_bb(inode->i_sb,
+						path[j].p_block, 1, false);
+				ret = ext4_fc_record_regions(inode->i_sb,
+							     inode->i_ino, 0,
+							     path[j].p_block, 1, 1);
+				if (ret)
+					goto out;
 			}
 			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
-			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
-					map.m_lblk, map.m_pblk, map.m_len, 1);
+			ret = ext4_fc_record_regions(inode->i_sb, inode->i_ino,
+						     map.m_lblk, map.m_pblk, map.m_len, 1);
+			if (ret)
+				goto out;
 		}
 		cur = cur + map.m_len;
 	}
 
 out:
 	ext4_free_ext_path(path);
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 #if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0cac890cf370..ab7263b4f9e4 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1941,8 +1941,11 @@ static int ext4_fc_replay_inode(struct super_block *sb,
 
 	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (!IS_ERR(inode)) {
-		ext4_ext_clear_bb(inode);
+		ret = ext4_ext_clear_bb(inode);
 		iput(inode);
+		inode = NULL;
+		if (ret)
+			goto out;
 	}
 	inode = NULL;
 

