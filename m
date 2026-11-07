Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049118;
	b=dSm/s84tcMg9Jyf3ujyzE6VTWcTB9DyAcSCrtJOobUG6ONTGL2WDpy+hwZ/t7dwgw/1C
	 rvpu4rfxtAV472vaVMs1k+U8cAU99T7XfuGLgla7LiafnI0SF+2uIWdHjFYYumEQD/xXQ
	 HFznNW+LrpYtt3aLvrtcx6AHfYiSyUpFamf6nAdCD1Ni9nebDqtaDR98AW4VYUGGCK1tb
	 uo1cyBWkaykvs1WHxEpT2n8p//LewJNP9rbHD4liS+6FPF1mYMBT4ja3r3NeBi7iJ0XVO
	 2RIVsqsG5OneDvXWdkoHPVtW0Y5Pj7qpkWmOpoeCJxSqI0perMqkmo0CJqR8o3VlDUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NqGky0UpvbavdAbxIsRs6r8jXICtl4A64LdytUV5pO0=;
	b=Jlx8wQDWkxSr8O6opTWm/dVqUKWxiomlnt7zGuUIoLcp2oR1Mj1LbD5Ipt6/G8qHlfb1
	 5U52LXjFWj8r16FtO1P1zOiJRUJlq+kLUgVaEGgnadQeprnNosuCGagZYOBL3DJ/PqYyJ
	 nXrQTU79/uxH7eXJ/bzdDWF2u2dXMoXbatitvHbeFU7XxClw7OcaXqk8ON3dLQibdsOa8
	 FnvwD1pWZh0HVeL98NpWk7c8nomaiOp3/FlB5/z07NzNAat62+o38ZKq8R1t4T7IEP0d/
	 N+8lUNCSgbD+NACySPQtEZxKLCw4etRkN6lUGNSKKa+3S+cOF96K57h5kFxpxtKV5DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZArzhaH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8FD606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZArzhaH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DF31F0089F;
	Sat,  7 Nov 2026 10:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049117;
	bh=NqGky0UpvbavdAbxIsRs6r8jXICtl4A64LdytUV5pO0=;
	h=From:To:Cc:Subject:Date;
	b=LZArzhaH+TUBTQvhHHY4tAn3EdkswZhv9QDGOuj0pw+I1/h/acyYxaS4PCgMnB8df
	 jnbHbrCuviB4DqyFf0zloNWgLsV5ZkhRxDts/UkI3MTg7+Zj3AG551B/IOuRPkM2Mm
	 WSwQs6NXN9IBEgrzFF+B+dG/VuBuNfM8+zJkbVDYMy7NFghKi/jjh1q9LhaksRq0mR
	 zZ7PG2TgESxA6gs2mIpuBii+Bp5W+SORLlEU4Q6Z0y3Wptv3CYXNTiBZaiw84RLdVe
	 47GDuHQ+PcgJ3iSx98334dqhIBxenPR/FrlgB1wR+f4afk4+tqHv53m3qJh3sYDFNW
	 ptxmI+nrsha+w==
From: Sasha Levin <sashal@kernel.org>
To: r772577952@gmail.com,
	agruenba@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gfs2: reject invalid inode sizes" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:35 -0500
Message-ID: <20261107055835-failed-5.15-33ed0a0567e0@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 33ed0a0567e0abe66ea65e89dad2e35082890fbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055835-failed-5.15-33ed0a0567e0@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33ed0a0567e0abe66ea65e89dad2e35082890fbe Mon Sep 17 00:00:00 2001
From: Jiaming Zhang <r772577952@gmail.com>
Date: Mon, 31 Aug 2026 18:54:25 +0800
Subject: [PATCH] gfs2: reject invalid inode sizes

A corrupted GFS2 image can store a dinode size that is larger than what VFS
i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64 and
writes it directly into inode->i_size. If the value is larger than S64_MAX, the
incore i_size becomes negative. That negative value can bypass the existing
stuffed inode size check:

inode->i_size > gfs2_max_stuffed_size(ip)

Later, gfs2_quotad may try to sync the quota file and unstuff the quota inode.
gfs2_unstuffer_folio() reads the negative i_size into an unsigned length and
passes it to memcpy(), turning it into a huge copy size and triggering a
out-of-bound issue.

Reject dinodes whose size exceeds sb->s_maxbytes before storing the value in
inode->i_size. Also make the stuffed inode check use the raw on-disk size while
it is still unsigned.

Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 662d033fd2caf..2597e1cf2315c 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -393,6 +393,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode_state_read_once(inode) & I_NEW;
+	u64 size;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
@@ -418,7 +419,12 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	i_uid_write(inode, be32_to_cpu(str->di_uid));
 	i_gid_write(inode, be32_to_cpu(str->di_gid));
 	set_nlink(inode, be32_to_cpu(str->di_nlink));
-	i_size_write(inode, be64_to_cpu(str->di_size));
+	size = be64_to_cpu(str->di_size);
+	if (unlikely(size > inode->i_sb->s_maxbytes)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+	i_size_write(inode, size);
 	gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
 	atime.tv_sec = be64_to_cpu(str->di_atime);
 	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
@@ -462,7 +468,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		return -EIO;
 	}
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.53.0




