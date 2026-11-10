Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316001;
	b=Gn7Uhe5WgWc+Wg5MY6pAfs6RYKmnKi8G8S569uME/Kc/s09lQPbApfAXNqGM7d2U1Fhl
	 kEka9RX1akydx68pWn54fulg7KsobTdm8Yg3U6ERtfJ07o9yirfAuqjwBAoztnTk43i+L
	 7Rtsk21kCEXm8IT7scQC+bOnh/ubh4z5eVp+gjBXTMH5JIAzxrrDipCyW/FMrzthBS7HU
	 2lcDDxMGxWIrKCH1Yqhasva4hZeFgMI+kYThTOILawiPQzJIBtiHuAwgq/5jY+BbWzrE1
	 kx6G1w4FOXJ6OZOwfGC39CHJzK/hLvkaxVJvsS/juO54rtWiqBySPhnRxKfglxLfR9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SDk9MkejWB4hYtIgxjFuxypFzhH78m677nIxzRqBbqU=;
	b=G5FR0VMAj3OTxzLUUBbRwreHS2ZGPXWKDySw6S20AuBUBHGAJUNyF2q0NNVflyfdeStW
	 u8BCNCw1fajuXA65bcbVGHFDSpNDCzH5VcaVgLnFycRXdlMQ4oQYTmW+p801owR0OJoHw
	 d6ohYQduEy/4C5+Y1D8te39Z0uBR3DjeTTaBRswBxBBtryFPd+BjNqw4xbEMCljMqevlo
	 91PLIgUdSxoS3jxlU9hW6czSP0+114bLwGCZaFNMQbF6vScYoGdWwSkFj2un5/rCSXLMY
	 c+DUhMoNp2lMAo/O7YKQvqmD3wOArDLPAbXL8U59xVP/ewI0bD2MIMVW16leRI0f0mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwMWoKah;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E6606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwMWoKah
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9609F1F008A3;
	Tue, 10 Nov 2026 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316000;
	bh=SDk9MkejWB4hYtIgxjFuxypFzhH78m677nIxzRqBbqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GwMWoKah5kIpp9KxuTnmpSOnVU4uS9WQOq1+gOgMzTXFQ5cPoBRZleTDGY8Ij5C9H
	 BzdEqmBP4AwrjY8rwRySyNKBWPzhAhUytAEQrQuqfZapVHFrPmiQRkGXf8bboUm93B
	 2Q59RAX8MvKPb7u55TkRRCQvCQDnoGwiMYG9Q5YoGRY5KXPh0e9JsWM06r5NLV/wMY
	 BK1q8W1kdPhCRirzLvrR7Jc65kNL5s/tIGhDAvaApQ77jicSGGI0pz44/Yp6AfBDTE
	 2wVoWHCorYGhEPmiG9zoMImwM7tWfRX0MQuqaL4/qZvQ9MmGtjfTaf/iOky5+q3mvL
	 fGoRdB9atz+bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] gfs2: reject invalid inode sizes
Date: Tue, 10 Nov 2026 08:06:38 -0500
Message-ID: <20261110130614.1622849-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061535-failed-5.10-33ed0a0567e0@kernel.org>
References: <20261107061535-failed-5.10-33ed0a0567e0@kernel.org>
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
[ sashal: Adapted gfs2_dinode_in() to use ip->i_inode and the shared corrupt label instead of a local inode pointer and inline error returns. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index a4050468feccb..8e2d3b1f566d4 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -410,6 +410,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	const struct gfs2_dinode *str = buf;
 	struct timespec64 atime;
 	u16 height, depth;
+	u64 size;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr)))
 		goto corrupt;
@@ -427,7 +428,10 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	i_uid_write(&ip->i_inode, be32_to_cpu(str->di_uid));
 	i_gid_write(&ip->i_inode, be32_to_cpu(str->di_gid));
 	set_nlink(&ip->i_inode, be32_to_cpu(str->di_nlink));
-	i_size_write(&ip->i_inode, be64_to_cpu(str->di_size));
+	size = be64_to_cpu(str->di_size);
+	if (unlikely(size > ip->i_inode.i_sb->s_maxbytes))
+		goto corrupt;
+	i_size_write(&ip->i_inode, size);
 	gfs2_set_inode_blocks(&ip->i_inode, be64_to_cpu(str->di_blocks));
 	atime.tv_sec = be64_to_cpu(str->di_atime);
 	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
@@ -459,7 +463,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-	if (gfs2_is_stuffed(ip) && ip->i_inode.i_size > gfs2_max_stuffed_size(ip))
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip))
 		goto corrupt;
 
 	if (S_ISREG(ip->i_inode.i_mode))
-- 
2.53.0

