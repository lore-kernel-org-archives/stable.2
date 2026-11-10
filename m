Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315005;
	b=nJv9fjNQH1hE7i/ZLCmx/3dWVC/p7bexog2q2JE43UmATlUV9AdxeRz0YPecVKBTXvL4
	 tPknZUoR/rGN44KUhOMepq7/aXxBgLyWkVfTNLAbD/l/rHGJlYBi5Lfc+/XWgdg/fl4MZ
	 qAH/2mjGGi5hEMGgf9M7irEbMxMMC+e0P9pD5WWxmbliFLIF0sMBTImAPqbDqWg8CTbKm
	 akOam8BxJrhf0g0FCJsIcp3OGoRXzxQk4+4PBhwqo/HJmGsX47w7jIPdCqijM8cT3ZzHG
	 tDhH2FdqvijaEZcL2SkWqQtmnIAWMcscor7sywlEbB/ZtGb054KxoPsI/dGskj+4RgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O/JUA9mdYQkznlKxm+GmpC0lNvOvd1ML1Oq2x7JoGHA=;
	b=p8teY2JoUTG8niM+omScE7afEYjWqOBWMKqLx4KQRahdJryMi4rtJKaVDvV8BYLAjw+1
	 1UWnee3gBow1uGduZTWuUdeL0rBRkBvV4BS60aFi/NVlp4lWWcSrX4p/O5u2kBjDlS5ue
	 zvYHkoRew1Bjbu1eDfTnlUHj90ExMMfOPSzWFRE2k1kYbDml7s6Qlo5mlddgUktmdApWw
	 JFWfDg6KrKsV6CtxwXwBPyUg9jY2aabr8FRI/F1DlIQ42vvsFog2xrv3TG1EGEoyRjsrK
	 g0og9xd+X/7bOemb+enqEqE8OSy65glA+ZNOVKaPU8PJpnk6dDeHi/2VBvKyrJV0vzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMDt0dFM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A107606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMDt0dFM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC5F1F0089F;
	Tue, 10 Nov 2026 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315005;
	bh=O/JUA9mdYQkznlKxm+GmpC0lNvOvd1ML1Oq2x7JoGHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GMDt0dFM/kNYu5FxAsFpqdp8fMGKAjdCy9BBtJ+voR15MV9dC/fvYIKwmKl05FSR9
	 Y+inDt0wAWy4w1V3vgQNmcv+UYSUwmAz5Z/wwtzpzSZ2oUl6FHMQLPfs7VyDdslkqQ
	 +woiN5lPSYiJhjmDlhA+nod9wwXXnoD2X5Dws4pljFbQUjdgffZPTnWvzPTmpKRMnH
	 BZLn5XD6GhLbbo36U+PC5RR5ObDl8tvOHWcTHlueqDQBbC+s6tpFnMScqtVmHchDLe
	 FtrMQPly7Ad1Vjle88gvqhBmKDPkcdTSGpSRmAYZLS7zLuTBR/L9QwCZ97Y9bUnMgR
	 DVXmjgBLp5IOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gfs2: reject invalid inode sizes
Date: Tue, 10 Nov 2026 07:50:03 -0500
Message-ID: <20261110124943.1531606-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052902-failed-6.6-33ed0a0567e0@kernel.org>
References: <20261107052902-failed-6.6-33ed0a0567e0@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiaming Zhang <r772577952@gmail.com>

[ Upstream commit 33ed0a0567e0abe66ea65e89dad2e35082890fbe ]

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
[ sashal: adjusted context for direct inode->i_state access instead of inode_state_read_once() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index f575cd8ff47c1..0be93498e3308 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -412,6 +412,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode->i_state & I_NEW;
+	u64 size;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
@@ -437,7 +438,12 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
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
@@ -475,7 +481,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.53.0

