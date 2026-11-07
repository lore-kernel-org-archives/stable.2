Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081024;
	b=dVknmVLYI6l5FUClcEYOVVIXRnmwFMq0JfA0zGSumkvLfgTzZ6sp1N4A9f83h6DHbPwA
	 rULd15TaYWM4lLRhhbG5ZO8ULk+WGn/C6OzhBJgsEV/dGtjMXVIn2qAJFQNvnRds4SnN+
	 1W6pdQvlwTO/tCNempWFjfCCdBqa4rcmo0R322KRMupBfyIo1LeEERfx3arCXeNFahNXZ
	 RR4oau8zYCAuqbVaHP0zPSAwLQenc0/tSTDLXbWRq+OWGvQW8Jxmm+67Rl1OimQMkkIUm
	 yF92pMzVn2XOZQHUjgdcV893LCWu6h0lzQE+wSEGogiNVH9DJuyC3eBqDOrX1UG7Ecg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081024;
	h=DMARC-Filter:DKIM-Signature:Cc:Content-Type:X-Mailer:From:Message-Id:
	 References:Subject:Date:In-Reply-To:Received:X-Original-From:To:
	 Mime-Version:X-Lms-Return-Path:Content-Transfer-Encoding;
	bh=rlLgG5I3OPDKe+s2G/vyZAlDqa0Clnytt8kFvaBbu38=;
	b=0VEV1HcOeIv6qqvPpjmMwaag5tDOGUsBaD5HPSS5XcvThesG1Me8Fi7faPfte/d7IETq
	 1merNtwEoXswdiBirwPJq/YSUC6/9W8cpvxMySsQuslBAfdH35Nq7kaioLehvuvqhp5OY
	 lWfDX49CGPTzdd/ZCRqdn52OQnOBrvlDrlmDOeTk/7/Y0tJRKI4G/+4Uk2GJdsLr5N4mK
	 zQRRXQSnFhczjN1DhTs4xpvsSLrc90JuSDOMpe+om9nCT/EPxJEBX6WOMC2TkakAbyk+0
	 hzBzuO3In8nRlDj69+zrgfWL1o55cKc01++/IJi3571fvxVxQzQerT13mh75ntBUWzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=UD8oXflt;
	arc=none smtp.remote-ip=71.18.227.2
Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE738606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE738606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=UD8oXflt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1794081012; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rlLgG5I3OPDKe+s2G/vyZAlDqa0Clnytt8kFvaBbu38=;
 b=UD8oXfltWgNb54C0XxVzSRRvDjkZKpEjt4xHyHCiwENX6poD49ME1YP6yhGSb70BreyzWo
 mSR3IpLTQD6lmTjo/ZsablwyKvUcj1nMFrL7PZ6B8A23IRNHbrM3JxMhGG6onisqXFCW0q
 VCQVpshQzUVzLXytiAnGw0vv7CmD1gsH/Tlm4igVqLuowuApqaiMGf5bXQchts9f7sm482
 JP5SiV14u+odYd8ZyntmQQSUmW7Xt9tCDhJHQZhb2K0KcwlZwkEZ9W+MVvpl/Di/Z4FTO3
 KXvrNXx+/7ZwRg94itJMz5phb/5K4VGpjIAdEcnWZJeN2IyjrD/25uuQTkDW9g==
Cc: <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>, <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Mailer: b4 0.16.0
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20261108-twin-20261106-fs-xfs-da-node-v1-1-0d4bd47938ba@cherr.cc>
References: <20261108-twin-20261106-fs-xfs-da-node-v1-0-0d4bd47938ba@cherr.cc>
Subject: [PATCH 1/3] xfs: bound node entries on path shifts
Date: Sun, 08 Nov 2026 03:49:58 +0800
In-Reply-To: <20261108-twin-20261106-fs-xfs-da-node-v1-0-0d4bd47938ba@cherr.cc>
Received: from [127.0.1.1] ([111.40.58.155]) by smtp.feishu.cn with ESMTPS; Sun, 08 Nov 2026 03:50:10 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
To: "Carlos Maiolino" <cem@kernel.org>, "Long Li" <leo.lilong@huawei.com>, 
	"Darrick J. Wong" <djwong@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aef80f2+e78aa1+vger.kernel.org+me@cherr.cc>
Content-Transfer-Encoding: 7bit

The da-node verifier uses the larger of the directory and attribute
geometry limits, so an attribute node can pass verification with more
entries than its buffer holds.  xfs_da3_path_shift() can load such a node
without passing through the lookup path's geometry check, then index
btree[] beyond the buffer.

Bound the count against args->geo->node_ents before indexing the entries
and report filesystem corruption if it exceeds that limit.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 fs/xfs/libxfs/xfs_da_btree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index faf88488265c..88788ece69c6 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2242,6 +2242,11 @@ xfs_da3_path_shift(
 			xfs_da3_node_hdr_from_disk(dp->i_mount, &nodehdr,
 						   bp->b_addr);
 			btree = nodehdr.btree;
+			if (nodehdr.count > args->geo->node_ents) {
+				xfs_buf_mark_corrupt(blk->bp);
+				xfs_da_mark_sick(args);
+				return -EFSCORRUPTED;
+			}
 			blk->hashval = be32_to_cpu(btree[nodehdr.count - 1].hashval);
 			if (forward)
 				blk->index = 0;

-- 
2.47.3
