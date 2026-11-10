Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314483;
	b=pJKZH9jTJu65BynvZMvMI3gsCmHgMLdttlpxHkhPBiJy/fu7PT3Br7jH3DM0p1O0FdX/
	 fzqted29DvawpzWelMMrHANZRqjZt9WgYUMPVJ0hrymzloqhISuhL3UI5yWx5VikSyWRK
	 zJi3cm2eawEOVUIcxYMotjtjic0YQSuzOn/yUyii8DS/DbhDVf0oGuq8Q+T8vBCF96XeP
	 bzZqE4OmJdBCxYEfzZsaVYgLFboO8huBLBDVz2u9e0td4qAU9jsOHoyi45W5t5aYqXHag
	 YZDezUKqgAlDno8Il6r8xg9l/i28kuJlapPRO8OuEvgJjNZOILWI3tnDaK+ZpmLThkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DadmkYf647/FQ3Sm7Ul+REV7wHLCXxdXzaEbmYr1wRQ=;
	b=nkRwjqvEvOExCIA1i0x2UwXNcfK3r37od9SMU7zOjnZLC7GRotsnwnaDCiUJxUnH/eWw
	 rXn+GbUJ1Z1fpUoIcXrazzfxAN4SOa/K37qorO2dzwAYe0C6qVeNSjuIqP0iZhqrJLGeO
	 FRfdL2B6+T+8RdP3rrvJghDO48COtXP/OhlhnPqRHHRuNgObJvc19Gn3vhVcgijV04FNx
	 rQelZvR7RkNSNvYcytxDSFVKcejRiIyqfC4TY23xUE1bTWXk64+vRqsYgiTXJMSSAkqEH
	 KpuIpDdfGx2I33WKSDs7ct31zMPv2Cl9NWxRGz5RUb4xNCGdCRKxUiK39uE2JC6n6ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfPMrX6u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5154606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YfPMrX6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54C71F0089F;
	Tue, 10 Nov 2026 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314482;
	bh=DadmkYf647/FQ3Sm7Ul+REV7wHLCXxdXzaEbmYr1wRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YfPMrX6ucyxGka6RqOvahZqHNd85kl1qjojwcXRemOzt6cfhdf4m9iF8QUiX0ZX0K
	 ttFH9cz24xtRvr2RUveh2IS0gvumD9OXWXGk5gDyVrW0prI5JhDWjquf4vCmJdBUU1
	 QvjXDj+YQdGhzq54mJzfd9EDpOU7d2V+EvfMGyoyohd1Kc9CeKhISwogKGd+ehcYYF
	 ZACWS0/tcw1ssItO2FipivBsx97dyv3gDOZNj+na97MraSUJloLVJNjiF6pKdu4eSK
	 NaZ6TD9KCbQB7Tt7VQ/7JvrNqtMzCAJPlKTREXCSlI1qGZ4TqQTgv0o4R/eO5pt6ac
	 jkIlWEkKFFYRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] gfs2: reject invalid inode sizes
Date: Tue, 10 Nov 2026 07:41:20 -0500
Message-ID: <20261110124104.1313054-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050637-failed-6.18-33ed0a0567e0@kernel.org>
References: <20261107050637-failed-6.18-33ed0a0567e0@kernel.org>
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
[ sashal: adjusted context for direct inode->i_state access and the absent adjacent directory-consistency check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 242e47926b39d..35ad44d13e8b6 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -392,6 +392,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode->i_state & I_NEW;
+	u64 size;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
@@ -417,7 +418,12 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
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
@@ -456,7 +462,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.53.0

