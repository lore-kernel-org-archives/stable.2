Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081027;
	b=wTVp49VlwYSSRCpnurNkZcKl7LkpYg2F3NqWWjDS0o35kipiUflDMLQ3NfV8S6iqVKV+
	 NHtDudJ14cMwZAA4E+ZA/iqdQ66Q1+QO/017l9XimgZfSSZHfluu8ysVXpP5FRRpkflBF
	 GVOPYtS4LVUx+kpCHvm0SDb1ri9qyKfA2DFAa5ZCDD22vuvVwjeEA0HqfQU9qjrYum/Hv
	 eUid6vNQ+Hp3v6C+FBpIZhMUMNVPs7ICys2PvQoZpZN6wJEoId80YLomwTIgbNvbQOowQ
	 sp6xWvHj6W0eSlb6riFCLBRAbls2SLoi1KDzLfiBE233oxwnFLyui8FMmO4kJ+eWgoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081027;
	h=DMARC-Filter:DKIM-Signature:References:In-Reply-To:Received:To:Cc:
	 Mime-Version:Content-Transfer-Encoding:Subject:X-Original-From:
	 X-Lms-Return-Path:X-Mailer:From:Date:Message-Id:Content-Type;
	bh=jYM1DAbh+cz3dSnLlenICfYe6j/AX0ZQHVRJv2n2sio=;
	b=O5Et+2Yg24LhJMBzVR685TILKnNwLlZPjoDjZYaHH/UxNb5KNVRtneXQTFpbx0CK2sjl
	 FQItNaZLbz8cvlSAescaSabTyzr6DbX3/BY0bmR8G7Ur5mxG0UCv+GawDK1TKXTIbznhs
	 07Y8H0BSNVwfm8r3fgK+UulKJYmot6TYGbYsUWuYAWtcwIxAxuAFtYqypdJjSLNDV3EVn
	 qbu/ZwwMmuc4NeLb1miJtvr0PUt3HpRib7zeK6OJvnBz2Wjt1p57Xuk7rl09Kpsbb4BVE
	 O1FSyFAiH4B3956drVqVDnJWHlNVcbf4wPYRfxFvOU/JHDpMqIBh+F3aqXqJsZ9yYNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=Wr7Sp9xq;
	arc=none smtp.remote-ip=71.18.227.4
Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49C606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB49C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=Wr7Sp9xq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1794081014; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=jYM1DAbh+cz3dSnLlenICfYe6j/AX0ZQHVRJv2n2sio=;
 b=Wr7Sp9xqkV4fUjDunRCYnqFsE54BQQMBDoayE0WQFLLAfr/atOq90wuBMQnS15etN43r00
 RJvEHAyHMy1tpBQ+t+amr2yXs4AwMVf+lqnFsbLdu/Ef30gRDMigz8ebt6PGdQZmdfDukv
 x9p2xkQBWNtMGTIcvVcAVdW3hkWxc44MUpLTGLTVLpSrbwET0WVbT/o89UYH0ej5dfKXdA
 SN/9R2oqbcbwDQu2QcpPZgEIHQq7gMxkxChHvnqhkTzhYWBUwBhx0fi09qpRRHS28grHa+
 eezL+x7E/+ZO/rEcEe7ltyqHis/oMUi2oAS/IkSFFUIwrU7mLHRocCwgOh7Dxw==
References: <20261108-twin-20261106-fs-xfs-da-node-v1-0-0d4bd47938ba@cherr.cc>
In-Reply-To: <20261108-twin-20261106-fs-xfs-da-node-v1-0-0d4bd47938ba@cherr.cc>
Received: from [127.0.1.1] ([111.40.58.155]) by smtp.feishu.cn with ESMTPS; Sun, 08 Nov 2026 03:50:11 +0800
To: "Carlos Maiolino" <cem@kernel.org>, "Long Li" <leo.lilong@huawei.com>, 
	"Darrick J. Wong" <djwong@kernel.org>
Cc: <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>, <stable@vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2/3] xfs: bound attr node entries on inactivation
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26aef80f4+eac1ed+vger.kernel.org+me@cherr.cc>
X-Mailer: b4 0.16.0
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Sun, 08 Nov 2026 03:49:59 +0800
Message-Id: <20261108-twin-20261106-fs-xfs-da-node-v1-2-0d4bd47938ba@cherr.cc>
Content-Type: text/plain; charset=UTF-8

The da-node verifier can accept an attribute node count that only fits
a larger directory block.  Inactivation bypasses the lookup path's
geometry check, so __xfs_da3_node_remove() can read and write beyond the
attribute buffer.  For a v5 filesystem with 4 KiB blocks and 64 KiB
directory blocks, count 8184 causes a 65464-byte memmove.

Reject counts above mp->m_attr_geo->node_ents before removing entries.
This also bounds subsequent removals, since the count only decreases.

Fixes: b854e1c4eff3 ("xfs: close crash window in attr dabtree inactivation")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 fs/xfs/xfs_attr_inactive.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_attr_inactive.c b/fs/xfs/xfs_attr_inactive.c
index a5b69c0fbfd05..b8230fa458fff 100644
--- a/fs/xfs/xfs_attr_inactive.c
+++ b/fs/xfs/xfs_attr_inactive.c
@@ -153,6 +153,14 @@ xfs_attr3_node_inactive(
 	}
 
 	xfs_da3_node_hdr_from_disk(mp, &ichdr, bp->b_addr);
+
+	if (ichdr.count > mp->m_attr_geo->node_ents) {
+		xfs_buf_mark_corrupt(bp);
+		xfs_trans_brelse(*trans, bp);
+		xfs_dirattr_mark_sick(dp, XFS_ATTR_FORK);
+		return -EFSCORRUPTED;
+	}
+
 	parent_blkno = xfs_buf_daddr(bp);
 	if (!ichdr.count) {
 		xfs_trans_brelse(*trans, bp);

-- 
2.47.3
