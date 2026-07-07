Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC547CC91
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449863; cv=none; b=T7NC9PxPmtoJMW19cD1CR+w/+LAJiE8LvNiJ9CyQTPO25OxOXYXTpF4de1hdIccNJO4dQ0tMNTpKIsIXEozjqTFwEOYhGDEW8NMY+i5xYBlMeXSzMsaQZf1SMQ50Ml4yiMYTeUxpM9NFUBocylEEz0RGhDchkDB2/gaJk9KYlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449863; c=relaxed/simple;
	bh=tVaPzEu25VZ5MPzDS8rcCp4zCPUYf27Xxie92Gu93Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRCwzcW+RSa41YHIb+WAerRgHn8QyHlBwVLVKx48ld/mUdhKa87RUITgwTz7UUczHbcBdJsw6XAsGmPmy4DbXggHJ0m75c9f/P1zwufmCCJqspc0zkBMbPJQ6qzoWGqByQf95pGhuru9bXOpdY5UTRXV+e0m/scMdjqlmxMtffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=D+IUm5Rv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="D+IUm5Rv"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-385b78b44a0so2880268a91.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783449860; x=1784054660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jP4h6VniRyqPYT0eivggxMmtksbXxq2J0S7p8JkxqDw=;
        b=D+IUm5Rv2DrnvpJopA6a5/AhEdUtQCmgU2RDzfSuIVVWulnO3mm+p1ijRvZNVoui48
         oaWSH4yjL1rNbWGAW81EYvv4LI/TmtIhG2B0BEW63K+ZmD/Y4ZWKOSqtOZxcKigKEf1W
         f+NAQzqOnE5MUy65lcIGVpLG+UsWhL17EeFYXq8LExXCf4PXWdyFzsF44OMUBwV5mtil
         QOeJmDbL+HIhI8pYlquY4TLmp1gbMusN+N8lZiEKI7M+WEx4hDzldpU0LyYCg5c0re3u
         JMXJHUr/bD3Q8IuzaF3+8PSyO5hasZT5xkDTjo2ibyA4phPIndPfOZdV9629kMZnNJOC
         1Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783449860; x=1784054660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jP4h6VniRyqPYT0eivggxMmtksbXxq2J0S7p8JkxqDw=;
        b=DuHjS4gRy6rli7UmI82ctyuRnJq7rQEfLEbbQ4R8DsjcG56TXHUr1EVIXNjGiSeeiB
         lZmEbiXJsF7WZ3KYly4L/eIj945Qej02gkRgDISfiyBnLdEZtHqHthO/xGvBqSNkKCi9
         KnGsQZwJy3ElT+h+wAvW88UVk91EVbTNc/62N8QSQ9DM6v3H7YEPbanrglniTLL5s6ek
         fdOiwenP6NaWcOTw40jnF3udCXDxQlF25kMHA4/ilkxRMB1v8rsBQQuWHR7V3LjdaU/B
         y3ZYlA7rlzhLL8u3hvhORampsYdLSSdgaGPrtxAjqlODQ+v1rDR90e4xLDXAEPYcBVLD
         vslQ==
X-Gm-Message-State: AOJu0YyY6VRjj4GnAvCER2uCm/7gy6C1lvcWEssnQI2gVDllaxcTTQxk
	DwWHIa8U8ZhaZaNYhrWFJLcB7Xki1tR+kiP3FuzRDZwjRS58DTFjvHorCXYABZONQw==
X-Gm-Gg: AfdE7cnsgT8Qq+Q5TSYJrOlKeGms57sFwyzWXwblu//6toGp96stZl5sEzJg50WBuA4
	mETcUkjtvPwX8XEp9AX6TUNoo7J/kRxWfXG0bm2JQ2beS5FIFenVlnpS+5AtLPT85hrSzNzqX9u
	3c+AnUzK+b6dtnV/xg9+7x3hr3c28MwNWi0M2kCh5mg4/lI4wxj7VvuuCmKjigcxSF2AEkR3uuB
	8XP+WDCP1RwaAbgPtOZkEeoCfU/jTfzZTLE03KsZpIAupESxDeMPQ8yZwb73kufzX2jbo2tVWmt
	iCndROShhTyuIXdV4Eu2HjAkWqxV+8MYejELYduS9BY6NrusIj7yMLzYD0Cr9cwq2Z5856cO1jq
	+GqCWwb4LvRd4q3iGJXXgUc5F7FGjD8ru0ojanfWbqObtB0pDZNL+pJfX5q0hu0Uas/Icz3JnOp
	I=
X-Received: by 2002:a17:90b:5403:b0:380:9504:9780 with SMTP id 98e67ed59e1d1-38758062363mr5844804a91.29.1783449860563;
        Tue, 07 Jul 2026 11:44:20 -0700 (PDT)
Received: from p1.. ([172.56.105.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d12fcecesm1575432a91.1.2026.07.07.11.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:44:20 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Joanne Koong <joannelkoong@gmail.com>,
	djwong@kernel.org,
	Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: stable@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Luis Henriques <luis@igalia.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v2 1/2] fuse: copy request headers via a stack buffer for io-uring
Date: Tue,  7 Jul 2026 11:44:16 -0700
Message-ID: <20260707184417.3682270-1-xmei5@asu.edu>
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
  RIP: 0010:usercopy_abort+0x6c/0x80
  Call Trace:
   __check_heap_object
   __check_object_size
   copy_header_to_ring          fs/fuse/dev_uring.c:618
   fuse_uring_prepare_send
   fuse_uring_send_in_task
   ...
   __do_sys_io_uring_enter
   entry_SYSCALL_64_after_hwframe

Bounce both headers through an on-stack copy so the usercopy touches
stack memory, not the slab object.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
v2: add: Cc stable and Reviewed-by tags

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

