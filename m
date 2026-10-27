Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114287;
	b=G2RFEUfqW07bbBO0NdyxOuWUHw1FOqIX+neMn/K1lY2alBbW7wTIJSVVFB3EHNwOLF3l
	 sGINcNO+dlBgCXy935tEJZvEp5KFQCHA4uCBvk1BzRoiWZVEU9bZWu65Elk+wBLLiaNB2
	 gjlgFsQmo9vdBY8gdGf0kasl03qUei686uh029VK6TH+rXE7CR6RxxVCnjqSem2WO2y7w
	 TC1wttcl9JiLSROOdfClTBH8JOraiWgwDqil3OYOfPjvl7UyKJuAi3KaV/VadDGKMXTou
	 VVs/c7IsrJWQv/f+uX4CTqZR7vKqS3QwtGfz4K2oXaHEDWFh4OkWbA9MLntazbmGxtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j3Qa+V3IuRI+P0CHYRVzERRph/QnLAAsDUYydB4MNhM=;
	b=zT4htwFHsF0mN7hfU8WdTamgF1heb4x7xDvtIwqhmT2QHzAQvr0Hg0CnV73iwIiBNodc
	 3PdrUgXURQPpj700e88gN/Rip7aSvFaxoYhQ3mFK4ioB9m90PmcHTPrQaSG6v+DMK8EvZ
	 MI3rbppB9Q0AfNOa+cwRtWSw6howRq2KKfQsMxIRUF0ro5FGnUvqj/2ak3efF7P974M4k
	 910l5yVnJiCaJdBf9MRcpeHX6dmIAtQxPuY5rISTR4OpVmlQpqfXH2+YKvgpEMYFeLXmO
	 9oVeo9CBcgLhUePLJdeQ2W76wSz3lO0rMGiz5n5QV3knW/3B6LgCzm1TaQEwUFWiKdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLkRowIQ;
	arc=none smtp.remote-ip=74.125.231.192
Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D50606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D50606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLkRowIQ
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-533fe730856so1900195b6e.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114286; x=1793719086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3Qa+V3IuRI+P0CHYRVzERRph/QnLAAsDUYydB4MNhM=;
        b=WLkRowIQXIhcPuk+Jxnyn81h2nuzryWq6PMTu+RVzNQM/XPlRZQlUuG++FIpXZw5Pk
         L1g3NAW/uBM/eUK/pgryfRBsgFyOT8aKwnY3xUHRr+cH3zysJe6Ntw5vD7qgQ1ImfJLB
         n11iJpyW0L1/pjzWnRVpHhfzj0+UvdweqZ1Mf3BFd2CneEKT9TyYvxTg5G0fJ1WbC8jS
         MT5GoU5vUOp/JeuOngShJ02939g4gGnG2dC6HLLkDG503hvKmubrg1kmnZ1kF1A9a44X
         SEm+8dSHbIakR44suIjh4+/HzV3uczmMxaWgg3f3cKlgPfSANCKHeK0SB0uTkLfhLGyO
         a/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114286; x=1793719086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3Qa+V3IuRI+P0CHYRVzERRph/QnLAAsDUYydB4MNhM=;
        b=Lq4sUCze3lJujMth8/OExWUNOiWgXtAQlCg8usR6lyNGoIilExjC8D1/Aj8yhAhci8
         g5G01eoYTilYQE3nXW/iUCVo/q95cPeYe0gqYAf3ZCjggz3/GLmSQyD001MqeJhCkwzW
         UrGscbZz0LlQ/bCBVRmWUdJYySeS0l9EXADv4fRA1sGarBKXH/M1riEz6kB9pgBzWqg3
         tR1MmmoQ7DJJaOvAcXvCVoW7fNvmuSJLDwTIjVD0ZQ5FSELaZxVVMKXnjPLoWfnspQuq
         8ejQWvDblJLO+Pw7n0L0bdYjCS9Wi5eFUGrZND+UWXURG9hC7ITmjbROYe1BzU4zuk3S
         6Djg==
X-Forwarded-Encrypted: i=1; AKwUvBz6pG/rMwSlFd25Am3isliPDRHB8PerNVYemOnzX9qaIvSvH6d2p7nmqM1TmnLmJIsLOfjFM0M=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9+cphjRkAuq0dZln3gv+6g4VOL3Wn2IgaAFdywNadEtWO79z2
	NMMUEGrisQfLVr6j8aVcuYDq79uut1elER1W4zza3/HiQx/bU9ncgDvi
X-Gm-Gg: AYBFou1hmn1nc9AX/Tc2wjJtnHgzDaVZx5Cac2iA9bVYTa8KhpUBbqLhA/UD+F1DsL6
	WLWKeh3pjMJtWCBcbtXiZQc6fJL1DegdW7eyEtQ1CQXHC8qakg/EzSzO5APkMF+BHK+na3buiOR
	yf6aq+nMqGKlYNN0iVbT66bShpZzHECfFzgDoL3CC+CaMLGnqRronFMye4dPv0uAvzdr994vmY8
	p/tw6QQtXMyPmh+CLHWZspWI52ZzM58/XGwQTmGYX6wNQEttYChI1ojxnSVFwZMfwhTOM0igWPK
	UNLUekUP2zhYuWVFaoL8HmrqizveiIDQHTeTOEXQrjGRv42RKfb/a+q/2FuWJBwYjLMjI8D9AW0
	jY6szB48fH2J8wypAPfjVaL6ENPmXNqbVIlGXsEN3pPR5hITqnCCv6O4ISD7EPP4dQWOTWLwewv
	DN5zG9yxDJsTWPnQ3agXuA9QQkNPWmbcnQ/uosznKDa0AsyQBTxV+zlxLAaESR7zmpr/+p0mBl1
	2GEC3Wud+LLzEmYNSDfyrzD0QNGQuYTdAfK1FGI/mSzdd6+QLee28wwktPmNWqt7/e4/0QAfsSt
	qg35PIW7ADKgHObGGzw=
X-Received: by 2002:a05:6808:244d:b0:4f8:4ec9:b170 with SMTP id 5614622812f47-55bfff9736fmr6281431b6e.2.1793114286462;
        Tue, 27 Oct 2026 08:18:06 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.39])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c04311a8asm8009673b6e.16.2026.10.27.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:18:05 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Hildenbrand <david@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	James Clark <james.clark@linaro.org>,
	Long Li <leo.lilong@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Javier Tia <javier@peridio.com>,
	SJ Park <sj@kernel.org>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Myeonghun Pak <mhun512@gmail.com>,
	Likun Gao <Likun.Gao@amd.com>,
	hongao <hongao@uniontech.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Cihan Karadag <cihan.cihan@gmail.com>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: fix out-of-bounds da node read with a crafted record count
Date: Tue, 27 Oct 2026 23:17:54 +0800
Message-ID: <20261027151754.975492-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

xfs_da3_node_verify() bounds the on-disk record count with:

	/* we don't know if the node is for and attribute or directory
	 * tree, so only fail if the count is outside both bounds
	 */
	if (ichdr.count > mp->m_dir_geo->node_ents &&
	    ichdr.count > mp->m_attr_geo->node_ents)
		return __this_address;

The "fail only outside both bounds" conjunction is forced weak
because the verify pass cannot tell directory from attribute nodes.
On filesystems with a multi-fsb directory block size (mkfs.xfs -n
size=64k, sb_dirblklog > 0), m_dir_geo->node_ents is much larger than
m_attr_geo->node_ents (~8184 vs ~504 for 64k/4k), so an attribute
tree node with a count in (attr_ents, dir_ents] passes verification.
Consumers then index the in-block btree array with that count and
read out of bounds:

  xfs_da3_node_lookup_int()   btree[max - 1].hashval  (max = count)
  xfs_da3_path_shift()        btree[nodehdr.count - 1].hashval / .before

with count=8184 the read lands ~61KB past the 4K buffer, and the
out-of-bounds "before" value is then used as a child block number.
The read path is reachable by an unprivileged user via
getxattr/listxattr once the malicious image is mounted.

Tightening the verify conjunction would falsely reject legitimate
large directory nodes whose counts live in the same interval, so
enforce the per-fork bound instead where the geometry is known: at
the two consumers that index the array with the on-disk count.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: f5ea110044fa ("xfs: add CRCs to dir2/da node blocks")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 fs/xfs/libxfs/xfs_da_btree.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 3d02a0d7ba44a..ab3deff11111e 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1787,6 +1787,18 @@ xfs_da3_node_lookup_int(
 		} else
 			expected_level--;
 
+		/* The verify pass cannot tell directory from attribute
+		 * nodes, so its count bound has to allow both geometries.
+		 * Here we know the fork; enforce its geometry so crafted
+		 * counts cannot make the array indexing run out of the
+		 * block.
+		 */
+		if (nodehdr.count > args->geo->node_ents) {
+			xfs_buf_mark_corrupt(blk->bp);
+			xfs_da_mark_sick(args);
+			return -EFSCORRUPTED;
+		}
+
 		max = nodehdr.count;
 		blk->hashval = be32_to_cpu(btree[max - 1].hashval);
 
@@ -2161,6 +2173,11 @@ xfs_da3_path_shift(
 		blk = &path->blk[level];
 		xfs_da3_node_hdr_from_disk(dp->i_mount, &nodehdr,
 					   blk->bp->b_addr);
+		if (nodehdr.count > args->geo->node_ents) {
+			xfs_buf_mark_corrupt(blk->bp);
+			xfs_da_mark_sick(args);
+			return -EFSCORRUPTED;
+		}
 
 		if (forward && (blk->index < nodehdr.count - 1)) {
 			blk->index++;
@@ -2227,6 +2244,11 @@ xfs_da3_path_shift(
 			blk->magic = XFS_DA_NODE_MAGIC;
 			xfs_da3_node_hdr_from_disk(dp->i_mount, &nodehdr,
 						   bp->b_addr);
+			if (nodehdr.count > args->geo->node_ents) {
+				xfs_buf_mark_corrupt(blk->bp);
+				xfs_da_mark_sick(args);
+				return -EFSCORRUPTED;
+			}
 			btree = nodehdr.btree;
 			blk->hashval = be32_to_cpu(btree[nodehdr.count - 1].hashval);
 			if (forward)
-- 
2.43.7
