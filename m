Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763852;
	b=MAm2jhSezenJp29REIsLWKSLx/8Cw3+2z97QQRynEEekZx83GFKJZAzqzxa7wQJYCI3K
	 US2fIkmolsNgnF2Y7cdAOnipKdncucqogBuKZRSSSV3AWxYR6tFRrTV8JABN05j0XEH00
	 eNJSVd+59WmsX6pbI1UDr+KLMVP6yh3lTSj8pylI9WMIp+ow71pkjMQQE0O11SFAZ8i8U
	 GoFoeaPgSouUomh8VoWA8YxnUuMa6pwNA7P1belVB/mEtbyQaqfIUCMbHHEOT8OGlpn8M
	 HwMeBnZ4Os8yjShMSHnADZjBrp+qijjS8ONZpyh+Kc4lCcvT9z1MNKcRg4VMW+zXAkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UnzrsY8G/SWjwoHnSGm3SIOWLUzW8i2qmZeZsBb1utE=;
	b=SgVHDLqeVIgiLZ6Y0i6N2R34mv0oAjfkOfTJyUX3XSrqKER8L7WO79y/fCNSw6wNwv0d
	 ECIET69VwR+4/q3pyX9Jm+nBVsw/iKvD6iuSbPPruFC0yjoPt2U5gqAR7h7rLwEzJNe77
	 VpD2eqdcASQQoxDsBw03H3Ly99kZ8hWiYBDDwsyyvpsnm3TW41864N0f6OLzzWrnxZIdi
	 wDK0jI4RhoWlNiizIS5qm6uCOqVx49AvitV5GjBSc1Je4jNvMgGqmYdShIlRN4ymOa17O
	 bS9MzLu+gl4bbIwFnO5TbcOoNU1oYxS9Dz2+ITs6d7YakkbvRmrXfv4IP4os3bfRvfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="aU/o+LQJ";
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF48606A330
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 13:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AF48606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aU/o+LQJ
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eadea8f0edso468654e0c.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763851; x=1793368651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnzrsY8G/SWjwoHnSGm3SIOWLUzW8i2qmZeZsBb1utE=;
        b=aU/o+LQJtik59Zp1xO1fBC3w0QQvJJw7j8sOXoWMy3T7Wg4GNBFcgE92bgA9TkzLgF
         tOmnlrU8fpUya2eIsYzcXXNnqCKKOJG9qrZDFDGWHTRg/a944vgqJ4UaBPiJn4qwIuh3
         681UyAM5Jj8V2lpy+Rpt5xfudXkUG0O04uMkRk7rsxE5AoQL+9VM3P8/+8NBVvD+N6d7
         CocAvSW2yeAqv2vd38ePiQN/h62r2Z0h/1DOlbRGhBrkqjoHiAjy8XPJgt5EQDKsRkyB
         xfeIj2ss+Lp3QCVhNpcandfFwB0H/yIq73O4KbYGdtbIRbwwCQ4pQC5hgW1c5J5YA4iz
         8y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763851; x=1793368651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnzrsY8G/SWjwoHnSGm3SIOWLUzW8i2qmZeZsBb1utE=;
        b=uFn+xPGO2hJuseXxZ7z6ffSSuKmaNid/whafFfUhOLN24KUe/dfmqzeSqVMG3pVD7b
         QKhE4m71CDzKy6cZEtN1w6+BsCfd7+QzTPiQg8ahS6qsQIuDKe6G5xtQc3a2kFDVRZ6y
         6srdOlCiiWG/okPXDq5oeBKIa7E+vQg2yfgwPanIw73SLTlJXgSlv/h01AKv/3z7utMb
         aTcJVmnmQA5uJ1sBwKgJTkv+i9bVM0vHgP6rLA/ssrX1e4l5Oqltq7P2q9qTyJuXPZe5
         IvZIvJAxleMSFdFxw9OV1Yn1I45MyOTt8/Wgpo9f6vwecp3KRO0mCpezRBsDCYAixHhe
         W4HA==
X-Forwarded-Encrypted: i=1; AKwUvBxJcaY0zEE/cNQYwg1lIDewhreIX253hPc2DpM4bz4C550u6yILCnkzVNYX49wcLESmmfhDi2Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYICZ0JBWZcLgAfblxoHHhzZYb14Oocy7m5CUQkQrQ7GVfgGlWQE
	RG5Z7tVQOMCdbtGE6ImwtOb8CyCBIWLm+uObrJCX2CC9Z3RyGv/rGGpZhpbZpXqj
X-Gm-Gg: AYBFou08DlDDIh+QnMVn8kdP1rEO1aj+6mcna05ADMbjNUOd53CveAXUxeZfyyZcgXu
	8Q0ZCNZqOC7uAU9OIUCRLQnfyKjoL2bqqX6nCwr3hf3vH4UN4OEPsGu3PaNPfCNgu9rHZkB/FM1
	utVx1w5JV0LQvStc0oP9qEgcSzTd7JcrC9P4Uq7y4sUhK8z4Cr0BkPqEhc45GptylCNfK01uyeI
	rCxRA29IqNMHPtKkYFC2joaysDuz8Jy79aSc+a6uatNx1jDweuPFT+UVA8CsJW4lNQc0rLtVQiw
	YQ08UqyNabCS7hIXQWAZM3iDDwn4ak3ekXDMDgQxx7Bqj+fNrvVLrIYdH4HOyNtE56P2xvyxrlK
	P3yVxkPHy9HFvZ10YCalrno51UPpT24dRuMFrwkt9/EyAMd0D+mtHbc/Bverw/YFfTv90CdNdXv
	7ueLpvdO1Hq+mvoDI4EedCZrp4r1DvCC2IdQ2SX/KHbarupIAhX2o0tRoVDq9bqt/RWfNv95hKm
	SdhpoasNtvgo3zUFKYRnkEydaC6e6cldvkfRDpLRS/VaGWlFODftW7xpZfbarFs0hhXYV4dXnSD
	XD5UAoOIjUku+3BvSZSmQuw=
X-Received: by 2002:a05:6123:4009:b0:5ea:d2d7:37e4 with SMTP id 71dfb90a1353d-5eafa439734mr1174546e0c.5.1792763851035;
        Fri, 23 Oct 2026 06:57:31 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec1feb44desm161827e0c.5.2026.10.23.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:57:30 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] exfat: fix bitmap lock ordering and inode cache reinitialization
Date: Fri, 23 Oct 2026 10:57:13 -0300
Message-ID: <20261023135714.49481-2-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023135714.49481-1-breno3011alves@gmail.com>
References: <20261023135714.49481-1-breno3011alves@gmail.com>
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

Two correctness fixes for the exFAT allocator and inode cache.

1) exfat_alloc_cluster() checks sbi->used_clusters and updates
   sbi->clu_srch_ptr before acquiring sbi->bitmap_lock.  Concurrent
   allocations can therefore observe an inconsistent bitmap state
   and double-allocate clusters.  Take the lock before the checks
   and route the early error paths through the existing 'unlock'
   label.

2) exfat_alloc_inode() relies on exfat_inode_init_once() to seed
   the cache_lru fields, but slab objects are reused without
   re-running the constructor.  A stale cache_valid_id or a
   non-empty cache_lru list can crash __exfat_cache_inval_inode()
   when an inode is recycled.  Reinitialize the fields on every
   allocation.

Tested with 5000 create/delete cycles on a loop-mounted 100M
exFAT image; fsck.exfat reports clean afterwards and dmesg
shows no exFAT-related warnings.

Fixes: 31023864e67a ("exfat: add fat entry operations")
Fixes: 719c1e182916 ("exfat: add super block operations")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 fs/exfat/fatent.c | 13 ++++++++-----
 fs/exfat/super.c  |  5 +++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index a8b11e2ce43f..7dcb2819849d 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -427,19 +427,22 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
+	mutex_lock(&sbi->bitmap_lock);
+
 	total_cnt = EXFAT_DATA_CLUSTER_COUNT(sbi);
 
 	if (unlikely(total_cnt < sbi->used_clusters)) {
 		exfat_fs_error_ratelimit(sb,
 			"%s: invalid used clusters(t:%u,u:%u)\n",
 			__func__, total_cnt, sbi->used_clusters);
-		return -EIO;
+		ret = -EIO;
+		goto unlock;
 	}
 
-	if (num_alloc > total_cnt - sbi->used_clusters)
-		return -ENOSPC;
-
-	mutex_lock(&sbi->bitmap_lock);
+	if (num_alloc > total_cnt - sbi->used_clusters) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
 
 	hint_clu = p_chain->dir;
 	/* find new cluster */
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index a9ea36ba2693..2d142bf68b63 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -195,6 +195,11 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
 	if (!ei)
 		return NULL;
 
+	spin_lock_init(&ei->cache_lru_lock);
+	ei->nr_caches = 0;
+	ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
+	INIT_LIST_HEAD(&ei->cache_lru);
+
 	return &ei->vfs_inode;
 }
 
-- 
2.56.0

