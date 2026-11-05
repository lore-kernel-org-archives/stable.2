Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893370;
	b=mjJPkdS0Cr1NW8FjlwNsUpnGzOIdq2iKp+Caabn99zLEQ3/nCNWbhoOxMWT5eS96qhpN
	 2Opq8WsR+MQgc5wEUedbS/ecVH6AiTRy9qJ9+SXKXJnXmrrUe88A6e+il2YoqXsDCoEem
	 Kg2qndJTdTga49l7RWv5ZTlNBSwspUdpMJsWeB0b6FDOCY6ufw0MpX9eVfe+S4VULIHAe
	 ziyT85CIB+1ZRi9dSnY0uGUByiLbWJ6OlY79bb/Slc19uLJtnae6sHc1ylnnmCJ594hqS
	 6wsikLZkdBhx4VLNdHE55zIJz2oWwN+va0cjcmSQNoquxNdr56XKa6lMfgqNBe8vtnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893370;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=njUTYI4oBVmnjDbhYkyzul7xSC2CdBIMpC7eGmomWg0=;
	b=W4MYoSzCGai4ho4YDssR1FSHlpbIejGKXg1C8m9K5+CGbS9V5mT8vfiSciqvi/Augm88
	 auBCmmI747e2sHc7pyjHQQjaALFpAHEEa0yJ4XO+P3XqorIbQR0YjKe9Q/bvYSUwc6Tkc
	 H6QbhV2RYaUN4KEtjyHkLQZtsM/Sc9gRMbqf3JV5g/vw/4J7aePByttiy9GQM6pJy93tP
	 ARFepRsAx2I+8s9Qs122CLFZvAkRE+fDWkypYnSXk3MKkVr3xOeCptuGNUodB4v69BSRq
	 IkFyvUeiklzZbZgoZS+snjalLUutAA1WbkiWTZoyWzdcDiHhOqIXYPEZkinTrjjfJDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgKj4PMl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069BA606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgKj4PMl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1701F00A18;
	Thu,  5 Nov 2026 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893369;
	bh=njUTYI4oBVmnjDbhYkyzul7xSC2CdBIMpC7eGmomWg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kgKj4PMlx1OtqSgvYQXOMShiw2wgPfX+MWZGDwtcBF9r3KCjd0iWctI9ZKJkHqUa1
	 4PeIIZNrrEOpm50t/IzTOurNLn5Bm/8wrXLqPsjHcU9xfBKVqrDx34UVkVAvhRp1kS
	 N0G8LOwpmTVNrQ3TZK+pilAnrE8SoavCFPu22XeEfaHGFRSE/brkXD/9qOZz8dV9vj
	 kmNMrK8eHxRbR0sj9UhW8HtTju8lrQexFK7p3wibALrtnnr9qACPn5JjhNBWo/ywmd
	 VFZ0osTqHiVuDIWfedK3tES3UHkn7UAU+wzXE3co/LzxILwGI75xOObCd/vonKrvvC
	 tTKc0fb5dX3ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: bound da-node entry count against the correct geometry
Date: Thu,  5 Nov 2026 10:42:47 -0500
Message-ID: <20261105154224.1981823-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110406-unheard-batboy-4143@gregkh>
References: <2026110406-unheard-batboy-4143@gregkh>
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
index 9ac99912e7a54..ef0dbca2750bc 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1658,6 +1658,19 @@ xfs_da3_node_lookup_int(
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

