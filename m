Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501978;
	b=QDHqZNpvNA9Uji1GMLvcvVIzyEREFFMsxXX1NCtHcRpISdzHLtInm9FyxciOmIovIT8k
	 ibg86gnnDQJn1x2Q19pIh5Zge52cmvfy4fy2lnkA81W4mF1RojL30Klf6k6aLCxzpwcpl
	 FuVBygLW1uOxcUJlCguJcTHawsaVh/nlZaHTLd9VNv89Dz7NuBvYlwgcF2P90P+zqCYb4
	 x9Frtb07clNHfGye3ulGnoNa/P+aw9atop0ciBle7slvDlXd3pSahq9xKzQoa+qDpxk2C
	 YXa93aLBQiZA+ouzDYmXF4Nfe146nNGZx8qlTf7n0bOqPI657XgscsOcnIoBOLY/RXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GXRYtUbRh38fe0NTnBbIezCa9WUPMrbWF4pq21pcnKs=;
	b=UeyFxiSvRyCeadk9vqPBi7hVSz1YOwUpOzsoJbvB2GPRv/dTbH4o2iM4Q7OKojEnEMPA
	 +cwmX0aMudq50ClaqZG3nGggFPbmyHijQwbQGLPjSbcBC/sYI8S75eqE3JeslldkfUi+z
	 Jl/MebwnlYi8QX6bISnlY25+dAneiUMRuEOoLvxjrMTnyJT+4YUbYbJbOndP0Fc16Yzt9
	 J6Hw45sy2z50hWjRgIQM2z+rExjSEhGPyBtnLtBpiGbX87lU8QsS21UWzSXkqFk8PUCkA
	 UVRZbvnERdNmI8H6WKI2jaL7qIf7vhWrjvxkYTlFsKdc6SfFtxIT6+vhhAvs8bl6awQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oUq+JnEs;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64658606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64658606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oUq+JnEs
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db80fcdf8bso18727695ad.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501978; x=1793106778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXRYtUbRh38fe0NTnBbIezCa9WUPMrbWF4pq21pcnKs=;
        b=oUq+JnEsT9zLvoGgGln+QAzgtsRurE/AWDahFSqRFQC2Zo8TVxN/bRKe7p8Zzaqpt5
         kpNsDbMLaUgUS9weHnC812QG0gCnjnEQ12yEpmv3Z+H+cGG4IS82mvxApayxFVjR6sHd
         Lzi/UgyGTjZ6mBHpwcC6LhYb/bwc2xhWLRBYI53m13qPqxO1q1CpHAxnbAFlh+OQSzSB
         ChJ3uTp3OGgsYBWrIjdfBvxiGtwslcXLc3HKrvLJ8eRUEufdhvBA5SlIXkWrLwP2LRgf
         ezcaXdsU/QC77FatEfL3thKrQCZKn5lcpEwBoUo+6Q3WogNBw0wHZ1aSPiP8a7Y79Vgh
         vxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501978; x=1793106778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXRYtUbRh38fe0NTnBbIezCa9WUPMrbWF4pq21pcnKs=;
        b=ooSw3DSs/G6p8SPR7imxDIWYq6aBUlQ3SJLIMH+ci4H8unlJ4mwKgZiT7lWumOckQQ
         i1NGLW8mU45ABLYv6mQWVmOdwWNyXK2oKPG2+c5zxls8eS5+0SPgItRrOpQkV5JPsGDK
         3Y58PbtujfdnJNFMZ5UfZGzpVcNbmKxq9cy9lWN58npoo3+BRr9GxkTL+JmB6g4Tab5t
         eG3IiFkV2r7ySTP4nTRSlaxy1OTusf4hAa+x2bCkIM63QcS0P8LX0E/S1Q7QI/1awz4n
         rohng6KGEaSzhmN24c6LS41VLJjjfY6iBeeS4h3n8v8z+9UbuCuVmb2H/d2D3znBnsOB
         kRfg==
X-Forwarded-Encrypted: i=1; AKwUvBzteytOdeJxihAVXHgT5CZHoplXVe25fHGQ5RaChnu1CWKTw5X8jAA+qZKlWcdF/BYHuIwC1PA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlaZ8D7G32zjEHjbwhyFh8KixQTQdrCEd79Pj/yngYmctDVOkE
	Ukccvmwcb1cOEa7jnqOVrDSu048H7Z4RTXGozeudTTU9G03arWEBJhW3
X-Gm-Gg: AYBFou1XB2X4Hgi5P/AJWmosvuV1p8dPgT0LGdJV0s+L0FCa3EC1KDQzurWH3igF42m
	1eqVA6PcfgK/GyckCGdVHsFwpU6OXEm/HR2y6QPwyXwXxxznMNOhtxi1uykZfhnbxFauHHs1l8B
	qEiEm2v3aclq1UZ4LZE5rzYrUaY5zK6Pqm5E+LHYxAE3Iaw5MsVVst2BvaUN8/Nv/O/zv8uoc/I
	jNeIfmZIAqUfz848qzw3txvnJDe7cO7+CFXqiR1ofV80mY2NSWOw6qiKjryvL9goINl/AlfRXMz
	VNWEbv6UUWV2wtClSPc9nLyJyur4oIM5pyL1F4it++P9J/1fSDsFpFfb6FxV8MZlsQlbXFt1462
	ZkreZ6Tbcy3uVak0wcWcfjRI8spje6l26kzkjNChiBMlyBns1GFwalwU7QdL8HKoklMV1JagUcb
	qsNCsfWPif2HanNpgh5ybVWSpA4d9pANlfv7RtG8VS9wRGM5pmlymB4q8xdIPvM1Sww1UDjw5m/
	Ejmhg==
X-Received: by 2002:a17:903:1a2b:b0:2e6:13b1:e196 with SMTP id d9443c01a7336-2e9a73571b7mr84573785ad.74.1792501977648;
        Tue, 20 Oct 2026 06:12:57 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1502d425sm11910725ad.49.2026.10.20.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:12:57 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2/cluster: remove zero-address nodes from IP tree on teardown
Date: Tue, 20 Oct 2026 21:12:50 +0800
Message-Id: <pm-ocfs2-node-ip-rbtree-zero-address-uaf-v5-e7f64be16b7c3b0988d1@gmail.com>
X-Mailer: git-send-email 2.34.1
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

o2nm_node_ipv4_address_store() accepts 0.0.0.0. It sets
O2NM_NODE_ATTR_ADDRESS and links nd_ip_node into cl_node_ip_tree under
cl_nodes_lock, but o2nm_node_group_drop_item() uses nd_ipv4_address as a
membership test. A zero address therefore leaves the rbtree node linked
when config_item_put() releases and frees struct o2nm_node. A later
address store or IP lookup can then walk the stale node and dereference
freed memory.

During teardown, drop_item takes cl_nodes_lock, skips rb_erase()
for the zero key, and then calls config_item_put(). A later
o2nm_node_ipv4_address_store() duplicate check or o2nm_get_node_by_ip()
lookup takes the same lock and walks the stale cl_node_ip_tree entry. Use
O2NM_NODE_ATTR_ADDRESS for teardown so every published nd_ip_node is
erased before configfs can release the node, without rejecting 0.0.0.0
or changing lookup semantics.

Fixes: 0c83ed8eeb28 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ocfs2/cluster/nodemanager.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index e08850a5d736..be184c5ad54d 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -626,8 +626,11 @@ static void o2nm_node_group_drop_item(struct config_group *group,
 
 	write_lock(&cluster->cl_nodes_lock);
 
-	/* XXX sloppy */
-	if (node->nd_ipv4_address)
+	/*
+	 * 0.0.0.0 is a valid configured address, so nd_ipv4_address does
+	 * not tell us whether nd_ip_node was published in the IP tree.
+	 */
+	if (test_bit(O2NM_NODE_ATTR_ADDRESS, &node->nd_set_attributes))
 		rb_erase(&node->nd_ip_node, &cluster->cl_node_ip_tree);
 
 	/* nd_num might be 0 if the node number hasn't been set.. */
