Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315501;
	b=IccsFzLBIXzSLkYMwLiiAyQ0m13zADEDmckmY/vv+shRUx0mJ3FwwgUSnnxWYb07QyXD
	 BGxBvz3cMRMp0Lo8pGg34vLvsUUJk0UyJdnXZny4vlmCIdK3Xc5p/Q0qE05JwXqFobR0n
	 EileMk/rMZg15TkuniURp8V6e8o9my8Ca23DOFy3oE3BpcFmDmE6t9V/a5EBmy3EEHK0W
	 r+ZR+sdFC6Au45zXMdq5Zl5BjgWYS5hHWvV38N00N31NJ3iFgBSmVHIzu+5vWP4QuwySC
	 9IgK90sREQpIsRufEeeMbmuDgoX/QJklnngKh/PnxgaiX3YFafw4CBg4Y/iJAo+VdjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ywYVID8G930j6+bGkd3cU7Eb/95G4BaEVDPJSul/Tnk=;
	b=mUKgrDQ4+v3TVC5SsnM6sgITuvkRChvjq57R1/avT1QhvykDAW3Bn8A/gULvdccX6j87
	 MRhJvfEHlvqG1biUxfguCPK4Uy7oHIu0zgE/9tqUlLGrMTU35AUEBIMjWVh6lqH6OEl64
	 g7k+DjEGtJtWTqwLqlPo4BfMFIfl/eRPX8Bcxv7NnRl+uoq0H7Aj4WHJOfPoNw87i1yLy
	 TZtzpufjI4No4Tde+/Hk1wIrfFaUX+jzKMMYCob5E4HRy07rlzRMqNEqfFE9PMxbLsaxG
	 SQrwvOt+k3tFEljofwrphbSEKiaM8ac1hPlRhMnyWCpvru2Z/+pIRtpVmR1nOuADqzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YZ4Hjy0/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE67606BFF3
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZ4Hjy0/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6331B1F008A1;
	Tue, 10 Nov 2026 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315500;
	bh=ywYVID8G930j6+bGkd3cU7Eb/95G4BaEVDPJSul/Tnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZ4Hjy0/2oBznL9GbtmGUtLEos2PV4oid8+0j7OVhPn8Ob2Aj3x85mbdoOwLBWVy4
	 M0JVBp61yIkzcpcIBT+BLjgcrq78BFJ2Xl2oMNTp18oHkrXmV1X9vUaNEdObcRKJsW
	 Rs1bCUyKEYoved0VFCADMfTZmUM4zpeXYceiVHWUOFl71TfcQcCdbmqT1ZHglhePju
	 3q2hNQgPHAlHFu7OYzLJ+JRqHvc7/lEcjpk1yGG5XBXsXzUHSRFjpCcw65ArGCTNdX
	 RdMgU1bGPcxKjGcbBFEyH+cjYclmpXg/GWwPM9+QuPbrVxim886HAMpJd0DT+ACi5P
	 arJasaHBzQ2KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] gfs2: reject invalid inode sizes
Date: Tue, 10 Nov 2026 07:58:19 -0500
Message-ID: <20261110125801.1569612-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055835-failed-5.15-33ed0a0567e0@kernel.org>
References: <20261107055835-failed-5.15-33ed0a0567e0@kernel.org>
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
[ sashal: adjusted context for direct inode->i_state access and existing dinode field assignments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 8a077de9ee0a4..67351df7b4b33 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -405,6 +405,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode->i_state & I_NEW;
+	u64 size;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
@@ -430,7 +431,12 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
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
@@ -468,7 +474,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.53.0

