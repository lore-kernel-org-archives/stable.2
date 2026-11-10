Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314639;
	b=q+utvdfuqFCa0M7FZELn29Yez2Wnjzrf0tA/JmtC9Za/8MVXTiJwKXJRvDi1nIFE3pqA
	 pUTd37VKCqZ0UHvDhjeznsoyqO7QrGoQ+PCorAicAER2zBCcEsWguB1XhvsU7ttH85TOg
	 WC5ZmfA1g22ASN9iufhzOWdiGePAmyPWaX5oaVjkckLZLGFAeNE6MDzx0GeBbpDnpnI20
	 K46NE9P2TtGCmXeia6W0QTdaWbiO21P09PsqF8EIlsOHpn/u5VKQgGdGNmVsObcV9ffHP
	 PbLBAPOVE7TlnclnrBJiuIdMEFtN2NsLtcvpCSJX7bC10l/0lKOqPfyuJA4kj4AJJwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ohFowJPqco0U56RrpaloSzSKPZByZSzw6O2ol1pjeXM=;
	b=4U//32VN+pDObu7CUolGMqeAKQYi+ytuU3hXDgvpFqnTZ4NwhWdHHkSdfAZEkFHuafWU
	 LhJSatMLLpCaey+xbNrP49OBDok39bTsbNxI7Y7yBILPkW13fvb89ZatvmbhyS/NfMGB4
	 q5wYtzgs4HGB+pbMO0ew5w05QamYBrS/6QOUP8Ov+/dgwvXcRrWy20iBobtB45yj+JQBZ
	 wk21z37nUjigRF2nXo7Y7yBCNazxy5y9lQC2S6KT6Nwcnhe9nn/jf8uT/rgq6riwTEfAt
	 g4IWHbsa1xDy15msPYlpKuxdav81R4LLBxoyFRv/kNPrY6Dr5OlgYkFBwsK2VUNOQEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cS/DmoYd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cS/DmoYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779911F008A1;
	Tue, 10 Nov 2026 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314639;
	bh=ohFowJPqco0U56RrpaloSzSKPZByZSzw6O2ol1pjeXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cS/DmoYdTXrDTPa6cLPsHwLfTIY+/In0DXOHKEU6fhYu/RvXT0igR13zpt83UOn5K
	 1+ApW5wh71k69J+6cXP5zTgD2XNBdH/SzZpJ/sVP2E+1ti5NzlKpmkw1sLt5IcYxmq
	 FW4C+waC3JLUL1RCXLPwS7RfY4pQ2rC2Pk0/asr6wFrHHkahfNnS8PBvO3EiRoCJDL
	 CzWXbSEgLX+6Q4j4pKk1+PjsDDZkoodr8A/3Ng5jvmNIubbaVioqdgf9dEOmOIkrdA
	 YMWgrpZvjE3G7lO3IzzBC1Va2k9fVeQP7KEYNXCK8fTJLX35L2hEyDdHPlCnojIOn0
	 3ztjUHN5IHfCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] gfs2: reject invalid inode sizes
Date: Tue, 10 Nov 2026 07:43:57 -0500
Message-ID: <20261110124337.1519945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051654-failed-6.12-33ed0a0567e0@kernel.org>
References: <20261107051654-failed-6.12-33ed0a0567e0@kernel.org>
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
[ sashal: adjusted context for direct inode->i_state access and existing depth and entry assignments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index d13a050bcb9dc..dc51608272019 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -395,6 +395,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode->i_state & I_NEW;
+	u64 size;
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
@@ -420,7 +421,12 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
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
@@ -459,7 +465,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.53.0

