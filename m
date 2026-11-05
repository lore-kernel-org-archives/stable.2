Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890966;
	b=cIpLSopdT/PIqiueZr06UrDotw+ygtPCjuhDfEIJAWsvg4hwuo64/V9d6y3Vp62obZmj
	 GPVALaBw1I30KHa0/JE3eZP07TEQMmuHGo0IZpXoDRp+6Rb+cHxFD6/U97KMkdB0EAtbt
	 +IbiiTh6cfbCkP9JvmZsPw1V9eH3jdiV2TVjfYXzYK/r79NEett2KSIZT6/kkz8klGKFm
	 sAMFDED0h9RbXuKi65VLWF7VaT5KmFgTVuHqEOYYsptkbQ3opNXqRD5RKCAzRTD1GFUlq
	 z3pW/BgnoRAfDCcWV4bYb2JFbVT+drrmla8boxEhzgJZBUd3Zn7IGHCYeoQiswtTrfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nGWzdwH9lX2GvytkJ/xTmE6AQM9qs6qZFt36+CCKu2U=;
	b=l+uKhRZiMcPHXUXTbdtEt5ObIOkqADRS7hYwlxZ+LwZSxvShTzDmOsmSS+/PbBojHs4h
	 i17V+cH0Py5WbV+sgxUKXy+FSyHZ95S7Xr2Lc/MYF2M5eqM9o/AtBjQLCfimmLFNz1Spx
	 MUCnMj8ZqDpzdGYzYl3s/eNQkhFyM/pZBcXf9GsrtN+S+unsI1yrF481bee+ufXTaG2M3
	 Uq4WBij/VrtlteqC1BzLCQTHhs+8x6dSUvW23RD7KYk01uTCMTsxfp+UsQXuj6tnFHQmU
	 /opmE6Tj16EfJLc5BPM5dHDwArp5Xmaa8jTh0nLD1BqxyHh/UZh3u7ukaqKrE6oGbxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVjRQBB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9266606D824
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVjRQBB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393421F00919;
	Thu,  5 Nov 2026 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890965;
	bh=nGWzdwH9lX2GvytkJ/xTmE6AQM9qs6qZFt36+CCKu2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVjRQBB9fAXga8qrda5NipSXSwxlPJOWZzLsFmUPrytqteNzzT4ebaBhBkywdtuYi
	 HNTJ2GEp3woTxwCxGFLJPdE8m/71uj1uZCQbbADXkC/Jx7Slj7d/7Ip3PHvHgR2sJE
	 eFE5P3FuAgKUIS6R42qb3uYVOJCokZmk29mnmGOthENnPVYkks45iJo6oCxqLX3PNd
	 M50KunxaDkGecSrMylZNDJu2EJ3Zp3ixtx7i5KOuUXtFysyckxd3ZnBSoR/PcXTsxf
	 cJ1lJhk4t+XRZ/Zra4JB2npsL3RQ/TzwYCkm+u5nNHipSvjI1sGlJCRMysGtA/7340
	 XtgLM6BGWqBgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: bound da-node entry count against the correct geometry
Date: Thu,  5 Nov 2026 10:02:44 -0500
Message-ID: <20261105150121.1844747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110406-crummy-perfectly-a5a4@gregkh>
References: <2026110406-crummy-perfectly-a5a4@gregkh>
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

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit 3df5e5aaa3bc0913236c48ab29b7df3a785aa29f ]

xfs_da3_node_verify() bounds the node entry count against the larger of
the directory and attribute geometries because, as a buffer verifier, it
cannot tell whether the block belongs to the directory or the attribute
tree. When the directory block size exceeds the fs block size (e.g.
mkfs.xfs -n size=64k -b size=4k), an attribute node buffer is a single fs
block that holds only m_attr_geo->node_ents entries, yet a crafted attr
node may claim a count up to m_dir_geo->node_ents and still pass the
verifier.

xfs_da3_node_lookup_int() then indexes btree[] up to that count during
its binary search -- an out-of-bounds read via getxattr/listxattr on a
mounted crafted image.

The buffer verifier is the wrong place to tighten this: it has no fork
context, and the transaction-less read path used by getxattr does not run
xfs_da3_node_set_type() either. xfs_da3_node_lookup_int(), on the other
hand, always runs on that path and holds args->geo, the geometry of the
fork actually being searched. Bound the entry count against
args->geo->node_ents there, before walking the entries.

Fixes: 7ab610f9e0f1 ("xfs: move node entry counts to xfs_da_geometry")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Omitted the xfs_da_mark_sick() call because the helper is unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_da_btree.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 3ec681fdc075b..510e1e8e26230 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1670,6 +1670,19 @@ xfs_da3_node_lookup_int(
 		} else
 			expected_level--;
 
+		/*
+		 * The node verifier cannot tell whether this block belongs to
+		 * the directory or the attribute tree, so it only bounds the
+		 * entry count against the larger of the two geometries.  Here
+		 * args->geo is the geometry of the fork we are actually
+		 * searching, so reject a count that would walk btree[] off the
+		 * end of this node buffer.
+		 */
+		if (nodehdr.count > args->geo->node_ents) {
+			xfs_buf_mark_corrupt(blk->bp);
+			return -EFSCORRUPTED;
+		}
+
 		max = nodehdr.count;
 		blk->hashval = be32_to_cpu(btree[max - 1].hashval);
 
-- 
2.53.0

