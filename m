Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1A2FE074
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903544; cv=none; b=OKbSDDo3R4Jzdj6z8jWvB8+TLsNSaWnnHef5vX/k24QfxbyRhNm0cUx163RnNHHevCQbYA/pPWB/5nzRr9yr81t0Kdzgz3HWvuLj0rPICBGeK0JrqQ+nyWIKFtTj7g30K9OvnNyqRRbCx7RisVPAqZsvkfVkPa94OMBEZEnsAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903544; c=relaxed/simple;
	bh=A62Md/Uyi/42qVimXLqVhcnX90wP83924gg05eeVTvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWaVYy/bzyOnBqEVeqp2T6tBzFTZ6s1vhwGLZe9hxEymK0vm4GCvnyuC+NXeyun+r+hcNv9I5Wuje9sBEUXArqDyb4FPowB0T+nZ0HwR9W7UiZEjdF0CjC5DuTki5HzJm3Erm5dKUzxRMm6zxu9/z0NpaVJSItxQLTqNYbwaQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYLRvpZ/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYLRvpZ/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485ab7c382so262797b3a.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791903543; x=1792508343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzNvwx+hTE/Sy4DERDQI0AUbkPSf6A0fBJaHS6Z80VE=;
        b=kYLRvpZ/mbqZe62B31Zik+dW2RBXs04Cas5ucpWTDn6veiUq+MSbbBCHAhG0OVO+YT
         CYgs6qaoN/LTE42zjd+tOPDewoyJbE6vdvR3gF/3KaPSs9fi25SPuE0CcpYjg1aJzyEz
         vI8rASzV2IRHibKhXeJQJwPo9dIyfMO7M8QfyqxYApPFzaTT5eLf7+s6o5ycl+We6WX7
         CueQkFV+70eEf5nQ4JeVISrtLo8U2j0k3naEjnTv1L17DENTAZkdaZd2Ub61nN7jvPJG
         MjP3dR28/XJpSA7qI1v/K/GtkepIU67uyYFaQi4ssXy04AEJvu+R+h9Grmas0ZkTv0jY
         qWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791903543; x=1792508343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YzNvwx+hTE/Sy4DERDQI0AUbkPSf6A0fBJaHS6Z80VE=;
        b=q30vwikwxbHJLMDVfz5hNvkGQNkk8PGTuVqgPC01ulo+cMzBflRNfvFiCazHUhuIOi
         ske+5OqRYQPMhWUpMoI7gFAhoSc/e81Go0lKsBUfLpIok+GbivwvvTnMPAY7f7yhUa9X
         j5Xr/xjfE2etQdhvwNC8S6YFYFyFSlUTegXhZxvkzb7ldvURNzf1w3cq0k3negtYmUpL
         dFloz0X8COuOlK1042hYm625ihLd5ZZ1uFgzbsPzFFB2zphXzehW0gz7qE/xkZQN2kQU
         5EOoTWR/7JRoAb1VVyVRldgRGiGlV8cBDyU3QUmcjTIDHXOkL4eytxAKqKnxjh2FWZ2h
         KhXQ==
X-Forwarded-Encrypted: i=1; AKwUvBynZnWz/00v++wC/ZUQrurE+wegHNnuPD+wlcvhWQs0lvGNUmGpttR2KvMc8NVqjxk91QBh5pg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/L7s7sfWhCzJJ9vPFgFrMBbilYmM7OMZz4y2NECuKZQnS31H9
	RVUSWCyb6QzcawxKpqE6//T0NDOo1sQkDWmfbeLuXbSJJ8idxe02uQh4
X-Gm-Gg: AYBFou3k9Ak2eXSTYyvI3feqxbn27XGA9ZR/XpgrOiAuwfBp3uf4FrkYu02XvP/OzKi
	HOQO2VtUpIW5M+/O7/SxTWsLJv2l0CxPcLJnKFy0dO9N1B7Rl6uI1lQp+GvL+/mKnDsclbWdCoZ
	gH2AHVX/Qos0DMYea2V2vGDdIRya65PafgItsJbQ1PqxFlp+5Rbt97H0Ny34QwK3BEWZAlgY9TJ
	Fqy2tAmVNS1ZT7+b9BuH40PwxHf1BmcUTeTuVNok0INPcQYY3JTj8WXdah8eO67tRhU/IKFwWdG
	7+4+CHUzNV1tY+SoKLHL69ecxHkXPlr2OCC/E9NluOeAr9emPNM3fceoDlZYVNKVQTla//V4p5W
	2aZymT/rmIdSP8Mn92GFVEuCTBfMnJMCI6ZPU8kDl4hw2TjBq8qlO32/6H3R8p8fSIjFSuQgn4h
	wAqZ4Ue7UbZa8iINQsOydfkL71IuG4GdKDXGy9lPNe2AP3idgpNw/0Xlyivbs3Uzo=
X-Received: by 2002:a05:6a00:4889:b0:89a:ee91:e894 with SMTP id d2e1a72fcca58-89aeeb074bamr5887952b3a.0.1791903542669;
        Tue, 13 Oct 2026 07:59:02 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89a0724a045sm2987330b3a.45.2026.10.13.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:59:02 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ntfs: flush the block device when syncing a directory
Date: Tue, 13 Oct 2026 23:58:46 +0900
Message-ID: <20261013145846.56415-3-charsyam@gmail.com>
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

ntfs_dir_fsync() writes directory metadata and calls sync_blockdev(),
but does not flush the block device write cache. A successful fsync()
can therefore leave the directory's metadata in a volatile device cache.

Issue a cache flush after successful writeback and return any flush error.
This matches the regular-file fsync and syncfs paths.

With QEMU blkdebug injecting -EIO for flush_to_disk, fsync() on an NTFS
directory returned 0 before this change while syncfs() returned -EIO.
After this change, both return -EIO. A kretprobe confirmed the flush
error in the directory fsync path.

Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 5a0e21e7c283..fce10baa2b93 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1192,6 +1192,8 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 	err = sync_blockdev(vi->i_sb->s_bdev);
 	if (unlikely(err && !ret))
 		ret = err;
+	if (!ret)
+		ret = blkdev_issue_flush(vi->i_sb->s_bdev);
 	if (likely(!ret))
 		ntfs_debug("Done.");
 	else
-- 
2.43.0

