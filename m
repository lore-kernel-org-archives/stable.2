Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888953;
	b=L3QfANZf1qsNIXtwd5auwjOD/nSOBMeUdKQw1H0BhAU4DIuzW7b5PTjWmohQqgm/czbR
	 HmEIT5W+ufS/5YUIB9XFTUXE7D3DR8aloGr4eeZeOEMTwah42na7oHrgL1MI0tmTholdD
	 KIZsLb9pcQt6pEfU7VMYp1lNTs9pUPNym7eHTkuN1JovE2WQwOsMHsN9zhygdTTaUf2Mu
	 JXnrI0S0wA1awuzJLYjdxvNoiKKxUvYKxpHqTHHQVU3NGjesq6DWsum76QsFSu/sTPUpN
	 dtDKNK/3Y6jI/7wgag3F55RFp+gw0uyg7fFyM7fqHKfP2rU6zSZThAbDmsPK2F92rWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HnabHOLSoaCSq6aI7dcnR6oifrE7YLZQZg968B5fMmU=;
	b=X75Dv6UIe7jFY8PgPcFOoQWoLC8469L3C6Nit3xqTFMUtAHR4hkuw7YXDAe8PqsVSBZ6
	 UkbTsWoNGfTlKhFlLZXbmHWBmk9usz+xY4xhvc6sdAfp+2Q0LyWp3iDVtPHbXKom4WHx/
	 NJUlOSImnytsdeNTkGJclcxasxSahg3Wz/e9CqGMyj3gmlCAmwrWzZKI4sBGMgo4kjiYk
	 I+LqDkEPxQ4QlyP60Htla+zXJ5pJMQHgU0+lkoMCDHh76m3qIKCaQS/R6YeCxopZ5/7Sd
	 VjYhqLLjZ1CqMyC5RWtns/eR45Qyp7pjyiXnAuCuLE34Bbl3OWt4RvPGwnYck2tdzsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxoqnypI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E0606D824
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxoqnypI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52B61F00A17;
	Thu,  5 Nov 2026 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888952;
	bh=HnabHOLSoaCSq6aI7dcnR6oifrE7YLZQZg968B5fMmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cxoqnypIq03jtVhtsbu88Mcxf5+ufdpc1pd3EkBxNn9IgAufOseJP4PMoGwl39rh0
	 rIit18/+4Nl/1aInxQuRbIgy6erSbV7km/C52fkp5FOf3TCYsDkWoQmENhn4KpH91K
	 iE8FhgC4NAv4XSOPh8TljxpD3phVkvBvYjYfStNTOKsCbpjk8x7j7HnBwINZ5gA3LI
	 8i6Ik/y6qsbj2Z7JT3egbQkVDdDvDwPHCkY42qHDwklJ2vGSEZttordiOadjpe0IS2
	 OIeZ+lvu7udsZNmtKZFUmJsTMweq+ijBl1nDGEFC1XlogwTWb/ufNv65hKmbd0bgHL
	 HW7xmU78031Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: bound da-node entry count against the correct geometry
Date: Thu,  5 Nov 2026 09:29:10 -0500
Message-ID: <20261105142750.1661575-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110405-unleaded-ongoing-7d17@gregkh>
References: <2026110405-unleaded-ongoing-7d17@gregkh>
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
index 1efd45076ee2a..7869b3f5c19b3 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -1671,6 +1671,19 @@ xfs_da3_node_lookup_int(
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

