Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913D366DA3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073254; cv=none; b=GrHaw3ootAiujiuST66oFUr+ghsNSRfjlZrjV6XwqKEUZVZjquwlRG3O+xr4tluxjXihZ5fO5Rcr0iR/NDxOqQfv8UBXpZa2qGz4h5OA/6giwN5Dyn5M83T/DhkZa93F7zlSeAwd7K12U8DXX0e4PQrVgRGCtqo4aJwaPkaiioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073254; c=relaxed/simple;
	bh=AuZlmqiR8+NPISpjMyL03Y3+6R9Uu6pS6O/DvI2I34E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpYfVTt5PBdyKF27KjdC5Dyd9606Fn/618af3bz1kl0CyAmnnkeFrsLEVCe2LzelI/unFRikQQDeCO0rU7PLcIdYr8LlV+H+g2lZlVG5jgD44PyDzr2qcAlxn4P6lzU2ic2TQqYxJfqq8yL7N826opfRpsKrkjlTRay0lHwJgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=tlhg3TXO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="tlhg3TXO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so43916955ad.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784073251; x=1784678051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6qOgI3AhwNY3MyS5Yl8AT4tj9fOaqiCdXwpSFV0QdFk=;
        b=tlhg3TXONtvK7oGvTT+6+gc5hQQA3faL1//xtfH2o7C142VXPCp/XEePr4U0yGJT5Y
         Xv71C0Dk7pYeaQL9G7DkOmm6jco/LvENbXhU4gMmLYhGRuhvoxCJvfu4NT6s3UyUcBY0
         +H02ruSUFLPZs3DdrhWHY0ryvWgsCYnOmvV8otkmuCSRoco4CU+uS3nn8w5PgQMQw+l8
         tWUAe7rAreBvPSnnWE+/TCbA0Fdvz1c7ycuj7IicFlOaGxj3nVLRaATNTMVrXSODCcNk
         +tqEKNtMA6ibxfuNi6KwyBqdY392p+np/gnYPRn7cKCjf5Tn0jHdAgbZ2zzD1WrlUl8x
         8Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073251; x=1784678051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6qOgI3AhwNY3MyS5Yl8AT4tj9fOaqiCdXwpSFV0QdFk=;
        b=pbA3TfcIXgI4oj+yG7+77GMqMOzPHvShuI1M8weIcVx/gLnALbn0GCP/UNDYKvjlnW
         hoyDfdGodJbyFxiJ3S+WTCdud9S5cdZ5PuNsNd6VUgy9OaT3gg6+41DmYFE/owvZQi8N
         OOPkdH9N9vAe0toAUAE/QZZk/e0gBY2bfrWYyOzyEBi8DYeYA4Zu4EburbH0KSQhBT8G
         M2hBij4OxScMewpqEco486lQR89uDgXwOu2ITdL4MsgkRjZ6ZdSJ7FPAzEAWD1/xziLp
         IsGyuNoWnj06hLuDaEIqKoJezxiY3mh1Y622aS2J81hYhGJhmROu1cjcFxO1gbUOtlSk
         Thrw==
X-Forwarded-Encrypted: i=1; AHgh+RphgADt8Y46sWE1IvfDXNt/zEwKdlOZq5byCF8xTqsnAtZ9AiseVQqJyeF91njs4g+WjqGF1wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2CygNycjutjwzG2Yd5xfi/qv34e9yXEalawF8Gth+QZMhLYh
	yagVBmEP2dEfBK7HsGNHZ4dS78MZGQyMgf3lteuGu9kEekiwuqmACmaExiG8rBF7Kw==
X-Gm-Gg: AfdE7clFfO1MV9ZwTApNLm2UBH9ICGYuyyLYOWM8SP9jgkQ02JIDo09u3W1aoC6936a
	oOYR3kJn1W3o6EGuqphGsmfctlDmihvVqjZ96dWA5Sagzrt7vaRpGueJ4qOqGITKxADMHMh9lep
	Del8nNaOtwJb3oV1N3c1RkX1gCAFefcM2Z/BIB4ACUjp0GQ5kgMN2N3IrXR2HoxqUDiV6boiwxP
	Zs7WNNQ/aSUFwAv61JO8Rxzc6HMj1E9+LaV6WqvGudslOzpiwGZxQyyN3cQ30aWc+izboq+fqUx
	ByeNhGVFCldBfEImMKSIvdCjkVHH3FBAnXZAnff3bwGE+s91y936jGlMUgmujBspWJP3zcp5EoK
	8RAE6gdOTil2+I7qrlLni2bWNwaaffBTuplriRLzWUy56CLMKFwnQyZAjy08KtAYc3Znrd4KQCw
	==
X-Received: by 2002:a17:903:186:b0:2cb:ea0b:9164 with SMTP id d9443c01a7336-2cf03c7f0f7mr5116715ad.6.1784073251584;
        Tue, 14 Jul 2026 16:54:11 -0700 (PDT)
Received: from p1.. ([2607:fb91:1513:463e:34c6:f6a3:8e91:2983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm123236075ad.65.2026.07.14.16.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:54:11 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: fuse-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v4 1/3] fuse: whitelist the request headers for usercopy
Date: Tue, 14 Jul 2026 16:54:06 -0700
Message-ID: <20260714235408.1666063-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fuse-io-uring transport copies req->in.h out to the ring in
fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
Both headers live inside the fuse_request slab object, whose cache
(fuse_req_cachep) is created without a usercopy whitelist, so copying
them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
panics:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'fuse_request' (offset 56, size 40)!
  kernel BUG at mm/usercopy.c:102!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:usercopy_abort (mm/usercopy.c:90)
  Call Trace:
   __check_heap_object (mm/slub.c:8268)
   __check_object_size (mm/usercopy.c:197 mm/usercopy.c:258 mm/usercopy.c:223)
   copy_header_to_ring (fs/fuse/dev_uring.c:618)
   fuse_uring_prepare_send (fs/fuse/dev_uring.c:776 fs/fuse/dev_uring.c:785)
   fuse_uring_send_in_task (fs/fuse/dev_uring.c:1306)
   tctx_task_work_run (io_uring/tw.c:96)
   task_work_run (kernel/task_work.c:233)
   io_run_task_work (io_uring/tw.h:84)
   io_cqring_wait (io_uring/wait.c:278)
   __do_sys_io_uring_enter (io_uring/io_uring.c:2685)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

in.h and out.h are adjacent in struct fuse_req, so a single usercopy
region starting at in.h covers both and nothing else.  Create the cache
with that region whitelisted.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Suggested-by: Baokun Li <libaokun@linux.alibaba.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v3: no context change; add Bernd's Reviewed-by
v4: drop previous tags; use kmem_cache_args to reserve usercopy area

 fs/fuse/dev.c        | 9 +++++++--
 fs/fuse/fuse_dev_i.h | 5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..b8e43e374b35 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2404,10 +2404,15 @@ static struct miscdevice fuse_miscdevice = {
 
 int __init fuse_dev_init(void)
 {
+	struct kmem_cache_args args = {
+		.useroffset = offsetof(struct fuse_req, in.h),
+		.usersize = sizeof_field(struct fuse_req, in.h) +
+			    sizeof_field(struct fuse_req, out.h),
+	};
 	int err = -ENOMEM;
+
 	fuse_req_cachep = kmem_cache_create("fuse_request",
-					    sizeof(struct fuse_req),
-					    0, 0, NULL);
+					    sizeof(struct fuse_req), &args, 0);
 	if (!fuse_req_cachep)
 		goto out;
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 668c8391d61c..b511aaab6bfc 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -81,6 +81,11 @@ struct fuse_req {
 	/** @flags: Request flags, updated with test/set/clear_bit() */
 	unsigned long flags;
 
+	/*
+	 * @in and @out are the usercopy region of this cache (see
+	 * fuse_dev_init()); keep them adjacent.
+	 */
+
 	/** @in: The request input header */
 	struct {
 		/** @in.h: The request input header */
-- 
2.43.0

