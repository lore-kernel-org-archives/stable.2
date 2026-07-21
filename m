Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40293A9624
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634420; cv=none; b=rbxJQTZKYtevF6VHtKVNzVHZv6e5r13r/biP3WemAUq/scsO66orfcdsmd0C2paT2GUnEe0u2YyWHiwlk5EJzknJOQzT9fZk10AAq1BGU+9WtCUFYLBk416qDXDnQLVPrUsaWCg0HETYwuIxEUqWoqddfIgUbBs9weQLUQcQoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634420; c=relaxed/simple;
	bh=8EpDO0gWS4PBWE9LYzEDvPJhleAi9XASWn9B3cS8Tlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSQlzhgJV6HCqjt04t4tfXis3V5/efNIrSJwjuJCIW3j266ahe4uk9U5YimLWiMSO4fiU6WaF3sMLtd+xNMsvfK5Uqpj4H31XMCUr88JwUcYRK08oJ4c6qGuomia3ObqOV746zw95k8K5Kpb7ewXDr98y3Hu82iphYbOVmNWazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af0IgnQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af0IgnQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359ED1F00A3D;
	Tue, 21 Jul 2026 11:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634419;
	bh=HfOJpsEFQytYGFVZ35/wxnAKDLq/pO1oClbNdgyEcoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=af0IgnQPwOfixzHF8ctQ5JksV3hUOT6E0BkeF/xu84wgdkKKzNv3tc7x/tq+B7NPt
	 hBIkLy3uGGQ1iLKwers4sjKqCZi1rcC39k7vKi6KGAkptAk49f/3BtwD1ldbHdJj8e
	 +KVh0lfy7rOXNGOBl/57jSHWm0kuZK7H8hkOgXVXUsonTzIcqbC6bBPCcMn0+EenDy
	 1q2zkJW1SRL8V2KDPmcK6sIZKBvxRwvSSIF49wk6lsiHpr0zqkzfin8DmE0auITGGx
	 y1g8tA2IYBoboNWW/D0PcMpiSp6YXIusRBzyAbAd1Rt+V9cAH4gGQ3KUX2eFZT2uaT
	 //fylUnQ6b+hA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 3/5] exfat: add data_start_bytes and exfat_cluster_to_phys_bytes() helper
Date: Tue, 21 Jul 2026 07:46:54 -0400
Message-ID: <20260721114656.3687966-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721114656.3687966-1-sashal@kernel.org>
References: <2026071548-sinister-joystick-e062@gregkh>
 <20260721114656.3687966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 3b9450beeb961c7ddf4cccddba37fcfa6d1fcb7a ]

This caches the data area start offset in bytes (data_start_bytes)
and introduces a helper function exfat_cluster_to_phys_bytes() to compute
the physical byte position of a given cluster.

Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 044472d5ee7d ("iomap: consolidate bio submission")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/exfat_fs.h | 8 ++++++++
 fs/exfat/super.c    | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 6ec480b53fe6dc..d2eec3a0bbc070 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -227,6 +227,7 @@ struct exfat_sb_info {
 	unsigned long long FAT1_start_sector; /* FAT1 start sector */
 	unsigned long long FAT2_start_sector; /* FAT2 start sector */
 	unsigned long long data_start_sector; /* data area start sector */
+	unsigned long long data_start_bytes;
 	unsigned int num_FAT_sectors; /* num of FAT sectors */
 	unsigned int root_dir; /* root dir cluster */
 	unsigned int dentries_per_clu; /* num of dentries per cluster */
@@ -400,6 +401,13 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
 	return ((loff_t)inode->i_blocks) << 9;
 }
 
+static inline loff_t exfat_cluster_to_phys_bytes(struct exfat_sb_info *sbi,
+		unsigned int clus)
+{
+	return ((loff_t)(clus - EXFAT_RESERVED_CLUSTERS) << sbi->cluster_size_bits) +
+		sbi->data_start_bytes;
+}
+
 /*
  * helpers for cluster size to byte conversion.
  */
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index cb2f8eefff9957..388db271c6bf53 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -499,6 +499,7 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	if (p_boot->num_fats == 2)
 		sbi->FAT2_start_sector += sbi->num_FAT_sectors;
 	sbi->data_start_sector = le32_to_cpu(p_boot->clu_offset);
+	sbi->data_start_bytes = sbi->data_start_sector << p_boot->sect_size_bits;
 	sbi->num_sectors = le64_to_cpu(p_boot->vol_length);
 	/* because the cluster index starts with 2 */
 	sbi->num_clusters = le32_to_cpu(p_boot->clu_count) +
-- 
2.53.0

