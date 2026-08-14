Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1235E944
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679347; cv=none; b=SNGGjXfKl4gHZHyFS5UKcF3yO2jCbY0vb3ok+2ro958wodv31/uCehAt72iASa1eiqX794rfK7AX2BkdG6rO7vKfz+c7ftvL8n4zYXAO2VN3fvXYZ9IB2rjdxMoqjfOcZBp35SGDhmRIh+04AYp/uyAFYuNfa7IGnkwyZOxuhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679347; c=relaxed/simple;
	bh=+87YqiqJu7d9RxaLFWzXE7nZwfjSUQ27OKyRS8HpYl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P+7HOgnvTn2m855sxZosOf+QsuwZ4JSqDuns0+P8ierJaRS2s+mfhvrEW3n8z2DFqaYSvuPb15KmeDy4lJeOI/9sQMHj4K/JH49y/UeAL5OeSfjfAwyIbsV6sTC+U4ySGSWdCUTYZZ70Ebkzv3PTWc/szH+RuxGdXRVIwGegVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNULR4dY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNULR4dY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so438774a91.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786679345; x=1787284145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qBZfZK4P3lmJ4BfMzqjxl2Q8NxSCA00MLYzImtjOXNw=;
        b=rNULR4dYvcKQLgcJVF9j4iRQ8rcaruzaNe9NbozNLlNEZo/1WiJx9UvPO0+gBh0eUX
         NJgE7cVrqWpEFYU3uiRa3lDh3OrOTyS0Hz+syRSKUs5m1ZOKIJOyYr2rGYcHKGNopeu2
         ns4mk9j2w9VBWcyYOZsk42s9SFdDLmyGZ/xeYydKgjJYMK40+zIKDp2Ayy8W6oyUpFfV
         2+Gvo2/TUl0+8EPXYyxDHncqccyIc5EorpFdRjwbJvY7RECDJ/bbRWI46w4smQ2W3gUI
         bcopZmYsJ7oT314w8XX4tfOXk5sLuUDy5JWfWymGAiD/AtWE50a/ZHYPodobpRDhAGKw
         xUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786679345; x=1787284145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBZfZK4P3lmJ4BfMzqjxl2Q8NxSCA00MLYzImtjOXNw=;
        b=Zvpbaxm48IKHfOJuVslTtOOiScwncpTrwqhF0CgyVtTyy1Dd96BZQsnHPLUHye6gI4
         i9WLh9WdmN8jGpBeeDO69XigBhn47FhJvgOdpTQp+xSymqH5pf2GXV+UfAGFklJznACt
         QqZWLOdvegubzNZgSYSZtsUoQwMCaJNZMjXKSYV8wFstJOs2nRsgrcP+exFMDdUvH9dI
         PILBUmcKt1OK8Z8fUEfrTWGP2F0Z6xX5bc4FxDkTOxMLV2msAu2IGAWUgGWmwU4ho/UP
         bQ3RYTYkTWu/dXbeGFA933amUb5FGydvM58im75nfHqcuwG3iHSzsq2tkZLsRjO3pYOr
         R8jA==
X-Forwarded-Encrypted: i=1; AHgh+RrrDYKnjlACf8UEQimxm607PWONEeME/VQdOFJamQAP3oZML24+dq+8ZGU1Olt5KEAD8bGFmMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNbEvTS9iReukvRuBA7r1sW+ppkNd50uE1juYAVUM6+1mXh3b
	Z/3ztnFoxLcV6vU3UYiaszaHbThPD/MqzohIyHFG0RgpvMFsg1XlumXq
X-Gm-Gg: AR+sD10LlrHByMV4Mqu+EjKr19yBrIATqWGegLTQNK0e/8K8NRTZXf39pOGxlxFHfr6
	X/dKczOWLkwDU2Ih3MSD7vnG2caKFCz5zpofr9O6Lt26/7UV82gTvrHpzoCKAE2Ie+VKA4HlrqE
	eQ6f/IpDhm1QmmcQMeni2w2SU9XFpplET1lK4nlISs5RBNeAvHfu/HkBY1QyfcSk9l9hg+4YUtP
	IsoCb1Re+apxlQnOMGezRMU9zUqBvY0VTSLC+w4QosXMuf4KqFzKxVbMLL85uoBigl3kQ0KNE8h
	TBDt5pMlV3ybx6J80+bTZK3BvWTvXdTjzLPwUNmhiBfWOd+FzmJKGupHbZPXSOrq00uPkDLJnvj
	12dfzVOltoJN7kI6EmYz0gKWOGQjVAKbGKbaUyRYfxQ0f4ZMfvIk9ASzPUl7dc39OLO6Ys2qzkp
	sF0PFpThSPedbYv2CvUJomOrcT0yqxIz7DiSViNcVNN/8Vm6p8xzHOAsGYrfXm8E+NUFV/PWV54
	4367qs=
X-Received: by 2002:a17:90a:da8f:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3933b95e327mr2864052a91.14.1786679345041;
        Thu, 13 Aug 2026 20:49:05 -0700 (PDT)
Received: from n232-175-066.byted.org ([36.110.163.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebc32b24sm641057a91.17.2026.08.13.20.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 20:49:04 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	bretznic@gmail.com,
	guzebing <guzebing1612@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: reject delalloc to nodelalloc before applying remount options
Date: Fri, 14 Aug 2026 11:48:55 +0800
Message-Id: <20260814034855.1573759-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 97f5ec3b166d ("ext4: prevent delalloc to nodelalloc on
remount") rejects switching a mounted filesystem from delalloc to
nodelalloc.  However, it performs the check after ext4_apply_options()
has already cleared EXT4_MOUNT_DELALLOC in the live superblock.  The
failure path eventually restores the bit, but leaves a window where
other CPUs can observe nodelalloc.

test_opt() reads s_mount_opt directly without a lock shared with
remount.  If a concurrent truncate's __es_remove_extent() hits this
window and observes nodelalloc, it sets count_reserved to false.
Delayed extent status entries are then removed without calculating
their cluster reservations, leaving reserved at zero.
ext4_es_remove_extent() therefore calls ext4_da_release_space() with
zero, leaving i_reserved_data_blocks and s_dirtyclusters_counter
elevated.  When the inode is later evicted after unlink,
ext4_destroy_inode() reports:

  i_reserved_data_blocks (...) not cleared!

CPU 0                             CPU 1
                                  ksys_truncate()
                                    ...
                                    ext4_es_remove_extent()
ext4_reconfigure()
  ext4_check_opt_consistency()
  __ext4_remount()
    ext4_apply_options()
      clear EXT4_MOUNT_DELALLOC
                                      __es_remove_extent()
                                        test_opt() sees !DELALLOC
                                        count_reserved = false
    reject delalloc -> nodelalloc
    restore EXT4_MOUNT_DELALLOC
                                        remove delayed ES
                                    ext4_da_release_space(0)

Follow the pre-apply validation approach used by
ext4_check_quota_consistency() and reject the transition in
ext4_check_opt_consistency(), before ext4_apply_options() changes live
state.  Use mask_s_mount_opt to determine whether delalloc/nodelalloc
was specified and ctx_test_mount_opt() to check the final parsed value.

Fixes: 97f5ec3b166d ("ext4: prevent delalloc to nodelalloc on remount")
Cc: stable@vger.kernel.org
Signed-off-by: guzebing <guzebing1612@gmail.com>
---

This issue was first observed in a production environment.  It can now
be reproduced with a shell script.

  1. Create a 768 MiB ext4 filesystem and mount it with delalloc.
  2. Start 16 workers.  Each worker repeatedly runs:

       xfs_io -f -c 'pwrite -q 0 32m' file-N
       truncate -s 262144 file-N

  3. In parallel, repeatedly run "mount -o remount,nodelalloc".  Every
     remount is expected to fail.
  4. Continuously sample the live mount options with findmnt and record
     any transient nodelalloc state.
  5. After 300 seconds, stop the workers and unmount the filesystem,
     then inspect dmesg for "i_reserved_data_blocks (...) not cleared!".

On an affected kernel, 7 transient nodelalloc samples and 9 reservation
warnings were observed during 101 rejected remounts.

With this fix, no transient nodelalloc state or reservation warning was
observed.

 fs/ext4/super.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 245f67d10ded3..9e1ea94664775 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2816,6 +2816,14 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 	}
 
 	if (is_remount) {
+		if (test_opt(sb, DELALLOC) &&
+		    (ctx->mask_s_mount_opt & EXT4_MOUNT_DELALLOC) &&
+		    !ctx_test_mount_opt(ctx, EXT4_MOUNT_DELALLOC)) {
+			ext4_msg(sb, KERN_ERR,
+				 "can't disable delalloc during remount");
+			return -EINVAL;
+		}
+
 		if (!sbi->s_journal &&
 		    ctx_test_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT)) {
 			ext4_msg(NULL, KERN_WARNING,
@@ -6660,13 +6668,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 		goto restore_opts;
 	}
 
-	if ((old_opts.s_mount_opt & EXT4_MOUNT_DELALLOC) &&
-	    !test_opt(sb, DELALLOC)) {
-		ext4_msg(sb, KERN_ERR, "can't disable delalloc during remount");
-		err = -EINVAL;
-		goto restore_opts;
-	}
-
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
