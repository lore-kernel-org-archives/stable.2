Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75E4398F1
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903537; cv=none; b=fCcmAKqI2ZwjRJpKl5CP4RO3xN/O4+0my7wFNQnJDdyFn24jqP56tQCuD+E2PLBk/XHx6JSqSZ/vvmnsXBtBl/3ET18zzFprfax5sHOT35MfrOPtMWsUHmcI9LzftqByunJMhTUpngw2eSjq6B0b6dQcLjDp/ikdGHFgspstziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903537; c=relaxed/simple;
	bh=2z05PsLR0ucgKWMN9vPAks1g4BAjgoGGRk7Omt7dCw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0nTvz3MOZba/L4YM3eN3tXrQt4DOkDq9OGKD0uztLPHL5UQw2ygaGDZeGsGXefzQjHzrEePadGwP5bWEFtttzQnk3iOvYh1IXN0KSGS+xKnvxq+QuAnzubUR8uytvyYleInTjxRMzvHGaWgO7+yW1oUFPraNAOqx0H1qaquzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzdqV4+d; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzdqV4+d"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89a837bf00eso228417b3a.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791903535; x=1792508335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rYeCLMrRw+7sZKn7J2Wy4tI9g40PN4nI4PwnmcaAXWQ=;
        b=ZzdqV4+dVLVxbaUbPsHq/gNx0FHdBdgz0z1wKUOwATlxmymIpSDbpx4kxPzHR8as09
         KcrJTinoCPmJDRrJzzTlLNje6CvyLbRv3BmB3DksPS6IKZCTNsHOuJv8WARgxmv4WEa6
         ch5W4yCMMdJxcjxuSPpQ7D36Qzeqk740vBSoaKGwqbHf47RqILZPTAmu00mYOQpMNfUw
         cMVpP830htJugqTh66ijmkBiGGj8frW+grN75xYcbdFWny4mF0yy00ZY/fplxvA1PbM0
         Ydk7RN98Q+0jGfIAu9z9iJljxs2EORk6sxyj9hLgsQVntWsEMpUp7slEpZR089reDLhd
         1iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791903535; x=1792508335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rYeCLMrRw+7sZKn7J2Wy4tI9g40PN4nI4PwnmcaAXWQ=;
        b=rlI4MsF8wz41ExB9Zmex+ZFsEySeU6uZ/BzWsUUNFvmIW+IxNtZ+ibWVUz7TAX6oZD
         a85jjF5UkmJAZFJVCOZw4QF3xNOQVgE4czwPjcAGez4yj+UFIf+3aTPdwwXHo4pqeniP
         7Mwfpdw2twoEUObZxNju+QGw0Te7k4+dHnSpaobIWt+yBfkOmZ15Pk788UvT0YEf8vdH
         SFH9JIBPnyw1cFfSrbJfZ4iZA9N34E7Acm2GpaBlgxfXofaCRH7yeCBkgOWE4sa1lGck
         5KOZQ/r9hewnNXkLBSvP3FiG17KJFkXTyBTiLOUlNa48p3ApXgnOzJdTFqE9uRM6puxe
         /sQQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0yOdbASy3XmuLwZAzyVyUO7ywmUffB2Eja0FLlp6QAg6cNKj3sLNnsRsOK1loGgelXgj98vc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFCkQ/s9gSYnHWnfxNaOhBJYw+Sb+3jcXSCRHltgGfa3laOZgP
	9DKt4/UFF1Wq9ydTXYSjyh43zd1PEJ5M0t3q59TyGe4CLCcpRObTm2kqU0vPvZs9
X-Gm-Gg: AYBFou2qRWU2XnLvboFFzcqo35Mjbg7F5EuRtJxHbZmVKjM/dIb+xlto108Pw/Fhnrl
	R/BesfMDE0qw5wlaVw+sqjgTDFne7GEffexZJQkYCuaR+pTm6yeKeqVRzK5PQIxciv2oflayC+M
	FYaHImo9RZThPRhIfRavUC8V5bGv2VgXzWYoY7RAs8BLCOYDXM5Mwst6LGpaSZkZpgGYaKoGBZa
	GU9VdohGzzA23LJHjNAChn1MxB4L+A6ldK4JdCtS49pYMeRZA7PujWbAfFk/42lkDHph+uPhsg/
	sByOHNFDKhAFcPf67xgvvawv/OUYLR0Fw50/L23hF5Bcpqt5RI89nBqTvyfXgkl4UrO+e5dMuwj
	AEtlLWJTk/7gyUi64u0NLaa0uc9NY7nxIgx5xBDahJfQ6kS/6aRZa9MnqYVpts6s+21mr8R0RaT
	WhaoYm4O27voItyE0zSYkBfVJdCCqLFtwC1NVziLHE/lEYHVkKayxtI5nYlWgIPCE=
X-Received: by 2002:a05:6a00:4906:b0:89c:9569:93cf with SMTP id d2e1a72fcca58-89c9578e022mr2814601b3a.1.1791903534922;
        Tue, 13 Oct 2026 07:58:54 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89a0724a045sm2987330b3a.45.2026.10.13.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:58:54 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ntfs: report block device flush failures from fsync
Date: Tue, 13 Oct 2026 23:58:45 +0900
Message-ID: <20261013145846.56415-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013145846.56415-1-charsyam@gmail.com>
References: <20261013145846.56415-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_file_fsync() calls blkdev_issue_flush() after writeback but discards
its return value. If the device cannot flush its write cache, fsync()
reports success even though the file is not guaranteed to be durable.

Reproduce this with QEMU blkdebug failing flush_to_disk with -EIO.
On ntfs-next at 04fb910da2c8, a kretprobe recorded -EIO from
blkdev_issue_flush() while fsync() returned 0. With this change,
fsync() returns -EIO and logs the failure. The syncfs() path already
reports this error.

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 58afd310d57b..afc2efb4b699 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -417,14 +417,14 @@ int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	err = sync_blockdev(vi->i_sb->s_bdev);
 	if (unlikely(err && !ret))
 		ret = err;
+	if (!ret)
+		ret = blkdev_issue_flush(vi->i_sb->s_bdev);
 	if (likely(!ret))
 		ntfs_debug("Done.");
 	else
 		ntfs_warning(vi->i_sb,
 				"Failed to f%ssync inode 0x%llx.  Error %u.",
 				datasync ? "data" : "", ni->mft_no, -ret);
-	if (!ret)
-		blkdev_issue_flush(vi->i_sb->s_bdev);
 	return ret;
 }
 
-- 
2.43.0

