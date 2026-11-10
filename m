Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315238;
	b=5fOYoU9NVzbaiIfQIhftS1AiMyDJwsRyIFYyoZ55V+IFyNuqqpY9pq0ezMAqK5CAnEWH
	 zkUJI7tSPvkc9FqCk49QBBERoR19cFxKeNIVZusgCkhjonLZSzhWRyvdqKQtquqegNZBt
	 r6gyyvRiZGxHoJgsgmvNhZ+v5tMO7cNdzjj4oTK/S9dQTXfaM0Zc47NSuYdIli7jC2LJC
	 ur28ggJDGVV4H1iiGKqnHblNPOk06YKyEP0AjrVjT2vZ+M8BiHSvbrZivfClrYgSKExkO
	 mqI242IH5hgv02PGs4ksYfQffTR/xF8tvLGRbHBOjzqWffDCjuSgSJwvJ3zkev2qzhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315238;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FwwgScb/STh2Gl3ztKEDuXvhzgp0Co9CrpcAHE4Cd44=;
	b=sa1Fdj5BUNKRgTAPSNWg8vTpCbcJznUlnuSSS9ohRUiiLLNjjK1s9FuTwcgfg2VDRbxD
	 APKDIzSAjgugNtib8N1cn0m8JffJpxrT+SjH9YHY08PNnzMfsZvPSHxSCxqUZGZ4zy3Tt
	 h1zvhdPE8ks0vcZPXkfp4KEeY+0U08Lx9/WF7Trl/XSM8pEI8S5mBWTz0HJIBXM7tKzHT
	 GTbQqadsTK+WwJGJXOHAP0kPssi48uwKQFcvemgcPIgAr/hBTHBcFfk45o/GNR8t0yeWX
	 iLp7q3syXpBfwDH7LSKinzpgOsc3oraqEGEA7ATRb3rIgacpypB1jgiz1n6AF0ZPDew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8ZTTGL9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A5E606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8ZTTGL9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3821F0089F;
	Tue, 10 Nov 2026 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315237;
	bh=FwwgScb/STh2Gl3ztKEDuXvhzgp0Co9CrpcAHE4Cd44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8ZTTGL9T4AVU2JBx0On8R2vCREkvqNLNvDhuD+LGdJSQYeFZOcUkmXWQKzqO2inj
	 wmwtiX4glrkI+n5U40/jiDyHTeQXxxPjIhoF2AgGLA63JPQr0LUMM7Bav7n96VPh3Y
	 SJnVcvuQi6H9sOOquC54RHzUkImY/9xKCchSk6cc/8/qU+qbgZSa3szIuQQXuo00vJ
	 AJmV8z4lyGJV53HnWV6V6fTQD0dPfY89zLkzn0AjHR0S3ABq2d/lVJxOTwcoZZ3IYn
	 XJ6SVLhxUmB8BxS0TIjDFbCyHoMNLbU8MWZugyF2mszoeotkYQqp6vo0po3BIasFQ5
	 2Jn/yTIr+pODA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] gfs2: reject invalid inode sizes
Date: Tue, 10 Nov 2026 07:53:56 -0500
Message-ID: <20261110125338.1544022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054146-failed-6.1-33ed0a0567e0@kernel.org>
References: <20261107054146-failed-6.1-33ed0a0567e0@kernel.org>
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
[ sashal: adjusted context for direct inode->i_state access and existing inode depth and entry assignments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index e7904c1c985f6..0fa7b6f1f4218 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -404,6 +404,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode->i_state & I_NEW;
+	u64 size;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
@@ -429,7 +430,12 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
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
@@ -467,7 +473,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.53.0

