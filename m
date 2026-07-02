Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6924A1395
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997794; cv=none; b=RVviZf3duc8fUU3mP//QosAIBbW8uOS/IebXIJMxN+NekE/qq0/XY5OQ/tTYZqyteX6tDC7djxGRKhUMLVoyXQFrIW6f1idEs3MbxeJP4qO1ir5a7WkEDntql3ao/5Z+3RsfkD7aF944AmmnIqZOVu6ypdO3ElJ/69MuimnLTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997794; c=relaxed/simple;
	bh=TOE4fP6so6fk5XFGmyWX1F/BIlasPBOC7vnh4I2Xpzs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jrDHeRjz39G3OlEid688ICtOvsY0sfFQjbYX7k30GXvAXDGsiaCC7LcC0LUG0t2WeeZ1CHDlVx7BDhklv582RfQ9jdDJjOei6j2P4y8In0h+4gVTErETA0ykwCkhzYs3ms9SThLbOlumu6mATZRqKfvB3MIUWJySHj68UY2TjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QxBvekeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QxBvekeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FF51F00A3E;
	Thu,  2 Jul 2026 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997788;
	bh=iwXdXS+YZKlA14is1mNdTQOl/dk0C2xzdtaEht9rsNw=;
	h=Subject:To:Cc:From:Date;
	b=QxBvekeCpU2s/la+v37+GvkYC8OaRdV7GSYU4+tmUaSyZoYZIWNNWXE+sihLhbqLr
	 0fcZETzKAeH41jLMyrjNlzRL7bDViF5iebJ7WVNccP1cJcbWUXikSgGFcj2skYeamT
	 iHVGI0l6TdybUwHAtU/CUbenIhJkgPJSoxAerwnI=
Subject: FAILED: patch "[PATCH] f2fs: fix to round down start offset of fallocate for pin" failed to apply to 5.15-stable tree
To: s_min.jeong@samsung.com,chao@kernel.org,jaegeuk@kernel.org,sj1557.seo@samsung.com,youngjin.gil@samsung.com,yunji0.kang@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:09:55 +0200
Message-ID: <2026070255-livable-cheese-d39c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4275b59673eb60b02eec3997816c83f1f4b909c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070255-livable-cheese-d39c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4275b59673eb60b02eec3997816c83f1f4b909c4 Mon Sep 17 00:00:00 2001
From: Sunmin Jeong <s_min.jeong@samsung.com>
Date: Mon, 22 Jun 2026 14:28:17 +0900
Subject: [PATCH] f2fs: fix to round down start offset of fallocate for pin
 file

Currently, the length of fallocate for pin file is section-aligned to
keep allocated sections from being selected as victims of GC. However,
for the case that the start offset of fallocate is not aligned in
section, the allocated sections can't be fully utilized. It's because a
new section is allocated by f2fs_allocate_pinning_section() after using
blks_per_sec blocks regardless of the start offset. As a result, several
unexpected dirty segments may be created, including blocks assigned to
the pinned file.

To address this issue, let's round down the start offset of fallocate
to the length of section.

The reproducing scenario is as below

chunk=$(((2<<20)+4096)) # 2MB + 4KB
touch test
f2fs_io pinfile set test
f2fs_io fallocate 0 0 $chunk test
f2fs_io fallocate 0 $chunk $chunk test
f2fs_io fallocate 0 $((chunk*2)) $chunk test
f2fs_io fiemap 0 $((chunk*3)) test

Fiemap: offset = 0 len = 12288
    logical addr.    physical addr.   length           flags
0   0000000000000000 000000068c600000 0000000000400000 00001088
1   0000000000400000 000000003d400000 0000000000001000 00001088
2   0000000000401000 00000003eb200000 0000000000200000 00001088
3   0000000000601000 00000005e4200000 0000000000001000 00001088
4   0000000000602000 0000000605400000 0000000000200000 00001089

Cc: stable@vger.kernel.org
Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Reviewed-by: Yunji Kang <yunji0.kang@samsung.com>
Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8acdd94272a0..4b52c56d71f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1916,8 +1916,15 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 	if (f2fs_is_pinned_file(inode)) {
 		block_t sec_blks = CAP_BLKS_PER_SEC(sbi);
-		block_t sec_len = roundup(map.m_len, sec_blks);
+		block_t sec_len;
 
+		if (map.m_lblk % sec_blks) {
+			map.m_lblk = rounddown(map.m_lblk, sec_blks);
+			map.m_len = pg_end - map.m_lblk;
+			if (off_end)
+				map.m_len++;
+		}
+		sec_len = roundup(map.m_len, sec_blks);
 		map.m_len = sec_blks;
 next_alloc:
 		f2fs_down_write(&sbi->pin_sem);

