Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DB3CE0A7
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401904; cv=none; b=RbBGgNsoUGdxjYx0qVQ6pXxDNPF9cAZKZ2HEANYaoT1f5pCqZR8n9dxixSN5p7ej6bv9odswALuJmJYRqOkY6JQ/LToGnWLLRgGcQxzAS9/BzksTHSxm/5npGZDc/0Dkz1x5MRuFzaN/qKLK4a+lLYLDKBaHRuF44HJ/XjVAIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401904; c=relaxed/simple;
	bh=y+D01CuHJwBdiuyjGFvWK/XS+nCNrE4YSYUYDFas9Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCRKDwA3zhWROf9tLhV2N+RDiJVJCdZ4yNpc06J7RBv5nvHt6/Dpxfs+9UujanH5CHjP57/VjKbOQa8kk6W16d+UT0lQer6DKBWkXZrWSfjtAYypvyV9tyhKCtvJ5lenmBKrp5GyWpcBMNMKzMaHsfwBl1I6IcVKTOcm4UuIC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyMfXppw; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyMfXppw"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6651abddd5bso228325d50.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785401902; x=1786006702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eih1Qog6Vz/sV/m2LMmZM3AG7QY9Vu5/xohu2UqBfEQ=;
        b=LyMfXppwk99ZByn/qhgoaHeYOkLTexbZjmdaPci8PTUftiusdhKFsNx2rBjGWVdp6w
         w2OxsH7gLUNnjYWCjy+T0GZJLYtl654udQwxgThs8BpVFbSGvkuNnWCmmNxbxFK0uA9D
         NvUIxK5u9DY2xEkTaaCFlwSZKKqozCADSrDcp/0a3NZCbea+ce/kQD+tqLnvmK4vSBN3
         x5Tdq0eJBouoUKdKM/OQMTSaic2N+umh0kYEJNILDtzZC+wrmkemwMiExXU+EvP3sKFI
         ToW+fe/17WXEHHpJRQLp5VVocv+57PcJgCF/V1iFmDe+0SULYp8V47XahsqTTarP+9b2
         faxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785401902; x=1786006702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eih1Qog6Vz/sV/m2LMmZM3AG7QY9Vu5/xohu2UqBfEQ=;
        b=LGzqdrxyeo6j6rBW+G1AosUUP1BhaCbZXkUy7tFUJSO9p+j1LJY+3oGuh4l7sBzcvF
         a3ieXXD4CUwhdMAjS2U7bB2PIDpPpLdZGqj75nKd7oKYMDquq6osl4LPH+eS7NbH1Mqx
         zmWqAfvH1lCQjBbyi5a1OzxErFQkhvZxxUaLhol+2c3pvBP7b/ckfT+lLnMsGvNS89by
         IZLZipLX2wVNM5Z0m9iN033LhqnQkhEQ8vuqm9/G5TNH5Y3wkanVYO0aB5oZJ9zb2Dhr
         tgFWlMqmw3Khisqp0im/Mr4vt5JHUZudmMBfCjVf9GXuuV/SuTrh8kiG4tmOjU4SNcWc
         F8zw==
X-Forwarded-Encrypted: i=1; AHgh+Rqdeuh2A5ncXfw106RzN/Nn4iOPVTMIHQgqf07mbC1Qrr8/M6dvlGN7uiXiD7iv26seRfUlxdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuuWzKMfuhD35w23Mj01koYFPxXm6nqJ+ZOdMqCFyFhu2VzoTs
	aA90QzfHqGzty7ByJQS6cN0u+QqV/tvTKKKhAWD/cyYbF3uxnbDM/TJe
X-Gm-Gg: AR+sD11t5935pcm9JdBLCabFS1VolwgApunVjocB2UyY38KSsjmXOZuFR3NUBaWX1vi
	KfeE9bXoN+AZaqI2ed2UK/VHGRSGFbqaeQ3Ra5YP00y/skDTPvNp/olYLdNAbnKmjz66qUE42Ij
	yny2VtzfzMJKSLELrbl8GZDZHfBiA9n6nyvJbvqq7yqYsQcNp4XdET6zFPNqA6V3N75mj+9SutN
	zQVIYaF18ieVjGGe0W527ImJng1LwUOFYdTLpk2xdSWp9Nn2x0PR2+M1mjovbs1zj+vKNQmWvz8
	Tead843N6WYXvGhha3CO3HJQ+nN2LgBjJQm+rqKskvKBKwwjynMbGXF/PWYQDxMJjlLrNK3Qz+S
	rKX9NOs9DsxEU0LySCNKRaxOzo0Luqb/vktfrKoAKLpAdiFgtA06sDupzcKUZAFgiTrnoTs9Bxx
	D2QSU7vlCz8WjAXAzHaGk9qqLWiQcAvsDLf2n+rjOOKfqtx8jTHTxlozNCuDHOmX0k/3rlgxUA4
	SCPaxNTUCJk4izWjR5VDSdtNCmy3mYf4iTtRmnQOmmH3UP4SHtGUlQ=
X-Received: by 2002:a05:690e:4296:10b0:668:99ce:a033 with SMTP id 956f58d0204a3-6692f6d5c95mr1537316d50.2.1785401901862;
        Thu, 30 Jul 2026 01:58:21 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c8e2bd8sm865842d50.10.2026.07.30.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:58:21 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fanotify: fix use-after-free of file range info
Date: Thu, 30 Jul 2026 16:58:01 +0800
Message-ID: <20260730085801.2068723-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsnotify_pre_content() builds its file_range on the triggering task's
stack. fanotify_alloc_perm_event() saves a pointer to range.pos in the
heap-allocated permission event so copy_range_info_to_user() can report
the offset later.

The event reader can set the event state to FAN_EVENT_REPORTED and then
sleep while preparing the file descriptor. If a signal interrupts the
triggering task at that point, fanotify_get_response() changes the state
to FAN_EVENT_CANCELED and returns. This unwinds the file_range stack
frame while the reader still owns the event. The reader then dereferences
pevent->ppos and copies the stale stack value to userspace.

KASAN reported:

  BUG: KASAN: use-after-free in fanotify_read+0x293e/0x2970
  Read of size 8 at addr ffff88811434fc50 by task fanotify_inotif/95
  Call Trace:
   fanotify_read+0x293e/0x2970
   vfs_read+0x177/0xa20
   ksys_read+0xf7/0x1c0
   do_syscall_64+0xf9/0x540
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Copy the range position into the permission event and make ppos refer to
that event-owned value. The event remains alive until the reader finishes,
so the reported offset no longer depends on the triggering task's stack.

Fixes: 870499bc1d4d ("fanotify: report file range info with pre-content events")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 3 ++-
 fs/notify/fanotify/fanotify.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a3555bebad63..c97d1be70310 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -601,7 +601,8 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
 	/* NULL ppos means no range info */
-	pevent->ppos = range ? &range->pos : NULL;
+	pevent->pos = range ? range->pos : 0;
+	pevent->ppos = range ? &pevent->pos : NULL;
 	pevent->count = range ? range->count : 0;
 	path_get(path);
 
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a0619e7694d5..c964df6c0514 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -438,7 +438,8 @@ FANOTIFY_ME(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
-	const loff_t *ppos;		/* optional file range info */
+	loff_t pos;
+	const loff_t *ppos;		/* &pos if range info is available */
 	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
-- 
2.43.0

