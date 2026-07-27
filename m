Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C753A9DA3
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195442; cv=none; b=SAbIvwAXniVI7AGWJsHbTQjiHJBpxXLvFP+rbiKBFWyVYMFWEmC0K58oXD633nvgB62Xr0prbMjJSdOoljinPrhqylNHVKo5T/99SbPuQoKl5jJlvBQiRVELnpoVtkFfc4Jyy4iNvRzAKStDcUU/AZDtCUEthxPC2PB1yjmqDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195442; c=relaxed/simple;
	bh=HF9Ry0dfbzlzU3T6bGyS1FE6ZfUi4xBEOfOFRYytFZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPekQpqAwCnr9SvRi2ws33diJlgGBfhzH5xeuNhX6SEuqu1VBKYljWRRRp2Ncig0UJHvZdW/8SXUfJLnP10JAJpSC4vuJaC37N2js8QzdPlxu2aLZ7LoOvMbpbNObgLxH3kwIfJ4DNgB7r9Q/aTj7OqS74nl0DRYJVWbSLFTJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=aTSaVGEP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="aTSaVGEP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cad8076b01so40462005ad.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785195439; x=1785800239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uoe1e+GzdQiS6kND7+XHKSW0CtkxIftVFnFlad8gR4A=;
        b=aTSaVGEP2z1sXU2uHdV3LfbXAi/WALUbpDbfqEPRA5J2BgvYn0PiT1MOG8vkNZMQGc
         2remz9pggYOch7+8ZvRhS3n2Q5HJ53QfXUtIeDCu17b/QeXhGcSje0915k1RnV9RcnYz
         o8MHC+MDQRFGWAYItZWtIbUFYYD/sp89vkkbU+Aw3UZTFkGy9yi6h8gg/DyEs8q8Gwr0
         dHsFCfhVGvAjUBwPI1JGCZ/b0vTMYwo5v24ahBtb3D/Mq/7tjp6Ls+D42CWeUXP0eUD/
         e2BQyWy/UhZOdhDpZhIuY1bZ6WwxmTJ3gYR3VABVsiweYtoMkJ2BPQ4OUAZUeHlvLGqd
         xBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195439; x=1785800239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uoe1e+GzdQiS6kND7+XHKSW0CtkxIftVFnFlad8gR4A=;
        b=RDcRIPcmMx++xPuABtTNXmBnn6HAK3v7HrUC1NgmIfGfoUrf5d8HEy9lwfjfy8ReHS
         vqaEdR9I0gIL2wYBgNuC9ksq/vInRcpYi3Y+BSK24kcuYdN7Yuk+RuGPis8D82XOQ92B
         ZBbda5ai2FSBt9r+DUWFzoKW7h6O9vWsrBc+XIsONq5IEjUydr1wnzEaAh89thlfHAN7
         1EMEcVvXvSaaPeRRCYgL3TPuEO24SFhCdoBdUnKHiE43s63wJqWDkC6/0oSgU/UZ5SKl
         wJMNsPsWk68n+uoc8mVS2F5FtO5H8YUsGPW3sN+8q3Nv3o3kjdPCmy7RYFhuUN14En2D
         hmow==
X-Forwarded-Encrypted: i=1; AHgh+RpjwfIjCzfzCdF0z1qnQuYtiGoF/NaEQLqlWWjsqgeuR4dfy/E2B9Qr8OEoXB6tQ2d+Q7AxsNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPxsINH0EvgDMKy27Q35/wwoBHueL2SgAhvoORagm8ePiadIt
	6xw1qwyEje3S61pxsHtm9137HdO6mzOsFqJ2f/CPkKZBU0XQo4B7JxLk7fofZoU9Vu1dWmAliO5
	SRCc=
X-Gm-Gg: AR+sD10d4L0827An2VGYuaL2m369Fe3YPKtvhERvXpQElifsstZxxjVsZSFwkBvSgRQ
	bXbuZionEEx031GrDYIoTwNJAH1QlpsxDUkzv37w3S/jl6f/DvP08Y9AHGjs4rVNPZ0gCjJl1+o
	UJ85hp5xtcwPQJqKGbyhV1MROyUJ3DTLwpfyXkhTTmPRwMwRBlEiVf3l3v5pCYbieONtK08y7xy
	g3MagAhqCjgvFN7W2teItjZqFRtF85ipdxtwDpwuXqEja4Yt57CLgkK83vaHl2+lbD9PAhuzNaA
	yBAT9Fq+SwYkYoJ9m8lXS9nLyO81EwvcKb8PT+xSnv5bBu9wenO/fmFcVgUqgJyIII+e86XJnEE
	lX8PPCPWJDkyKrH+qh1izuHzWGqrUI09aiDAjluC6hG8GeG7IlR7T9/Lkro8L+fB3+bC1N0aU6w
	==
X-Received: by 2002:a17:903:1106:b0:2ce:b096:e50b with SMTP id d9443c01a7336-2d00f5f7411mr11253795ad.47.1785195439553;
        Mon, 27 Jul 2026 16:37:19 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec26:45a7:d22f:3f56:f9b2:423f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde4650a5sm42256915ad.0.2026.07.27.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:37:19 -0700 (PDT)
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
Subject: [PATCH v5 1/3] fuse: copy request headers via a stack buffer for io-uring
Date: Mon, 27 Jul 2026 16:37:04 -0700
Message-ID: <20260727233706.218446-1-xmei5@asu.edu>
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

Bounce both headers through an on-stack copy so the usercopy touches
stack memory, not the slab object.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
v2: add: Cc stable and Reviewed-by tags
v3: no context change; add Bernd's Reviewed-by
v4: drop previous tags; use kmem_cache_args to reserve usercopy area
v5: revert to the stack-bounce approach; restore reviewers' Reviewed-by

 fs/fuse/dev_uring.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 77c8cec43d9c..0814681eb04b 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -744,6 +744,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
+	struct fuse_in_header in_header;
 	int err;
 
 	err = -EIO;
@@ -765,8 +766,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
-				   sizeof(req->in.h));
+	in_header = req->in.h;
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_header,
+				   sizeof(in_header));
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
@@ -871,11 +873,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 			      unsigned int issue_flags)
 {
 	struct fuse_ring *ring = ent->queue->ring;
+	struct fuse_out_header out_header;
 	ssize_t err = -EFAULT;
 
-	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
-				  sizeof(req->out.h)))
+	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &out_header,
+				  sizeof(out_header)))
 		goto out;
+	req->out.h = out_header;
 
 	err = fuse_uring_out_header_has_err(&req->out.h, req);
 	if (err) {
-- 
2.43.0

