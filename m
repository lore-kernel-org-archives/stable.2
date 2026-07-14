Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327E433032
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073257; cv=none; b=aVdVG2INWFegRWOtPl8fyxMaXHsLdqApAm8oDnEgSVpd6Dshe5tNQ2LBDq8YvAYPZfPKt6GaBvmYHRvCuiPlUs5qPYDNd1C4TP6Xv4NoiA/5XifiNb3Ot/cFg0HB2zsQ6ue3GyvLa29W/3gHU8R0xAY8slUqyZGk9H6UiArKmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073257; c=relaxed/simple;
	bh=iWC3dwTVFS0On/b+U1UVC9eFIiIpL6Q6Bi+esX7/UyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpwGlqSBl0UhNIWhSuQ6taLCpOvKauwLbs2Bf+SQ2Op/Rc5U3TNsXFGi3tUwONF45V3ri9ZHg/3LuE3lYuyNP5qwp5WAKWk9kT5zwHmnlRH2B/KkywNp6WHFmm6ZhLp4xhIZhuMnF4W0NeUOLowQdA0MrQaxQwFxf5vqj+SZAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Waxb25M6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Waxb25M6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cea3004256so49211505ad.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784073254; x=1784678054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yNKCuh3wjjGZi+YwPUxJXNIOv8IEH+SL77HN2XtO6I=;
        b=Waxb25M6IpUWOTf4MJHsEpkppvNwqv5/i+Rk9c4uvwoK9782PALi0veiQUU7O76nT2
         0V3AK64/Wmqp7K8OE7WfDhxaj3VW/gYBcRVjkN+VM/Fn7Ja1eGeq2Fgg3kFambXfGMAv
         VkZH7gtQRIVTqftUPHAGJj3we87RcDTSoPbvvi3QkHIfeyvaTHUY74sueVuj8NhAgR1T
         w/8Z7h0WLWlIezrhd2n18pWMM7m9izxQ5wkH4KTvSVf1YQd+XS37d+CO9JzEIGLOqC0o
         2XrjFl+EIV1PlJx5ZvzSq3n6IJZ/Ul47j3hzCx4mJUos7WmuO0CpoE8tOVqwxIoR7XST
         zg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073254; x=1784678054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yNKCuh3wjjGZi+YwPUxJXNIOv8IEH+SL77HN2XtO6I=;
        b=nNv3QmiiTcb4e+QDtvT9NUmYQQ03eWgKGIz79hVHrbMKQZHIj0IzsMQkXqCeYGk0sl
         p5bZ2ArSATY3By6Nno2J/YfrIW6JcezyDyh2BOV1487J2er2WDDk2E3YsgRuOq9DMQKA
         N9tgECKpnXvDQWuKVXmqgdaJgRf0Ya6N+rDIQUeuqpZ9pRh5b1K9UR5Hdx6koiE6COOm
         c1o16MR+8JWv1/xAGnp4h47Uw6vVyknByAY+GWxGGvW8vCVVW0Udn+4bcwy7xRBqhu+m
         awc5kEvZQ6oplePeBqLd1BDi+oATD2G+ziVzjazm7+B9g6HWrEt91jI4RXd3C8fREBDV
         u9MA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6v5FECOIVjtPTV3qmY9g/YAh7Wy+BniBhYhXdKELj6T4jKKXGSUE48n0p6oVEDeonTbi0i1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRO9DhRM3Rp2zk3Dhp3S9Zcpj2B6g33jFOY8+LkqFcZ70Ph4vp
	Kt6pUarDpo2k+YFmgzNKbAEgkSeOqahKjuMjtW5gNQ121syA6G51iTZvnOFJLSma8Q==
X-Gm-Gg: AfdE7ckA/nzHwxPTSlhQ7WM5wVSX+fCAnpjo8whtIkUBOdyMh8hA3xZN6n+FnDgNgwS
	UFqaBPMzXDJfTY0NK9LmmlnvkmsSRsRpfhdJ9daFiMJXseiGXhZlooA6nBP6Pp1V2fOPX5p6pID
	+nk7PbDIxTHU3rGIDQBvKniKcSAoRlwlH99xCrTub+WSdbkVHL52rKuboBtpQJ5Dp3y77VjQJRU
	7XGW7IOI5qe60jqO6E5ILvriIr/EUhQCXi3GJKGBVzI5Gzsf+/W00ljAm6h2Jnv/KtdwoDQBRsj
	IHHuC3uF/lYMHwQSu5fxDgVE2k5d1i3WHgtpeudDRpU9EYYKIgNI0kObuTy/EgKu5qOsoB4DLUb
	AzxGszN/5UkQnr4q60hi36yv5MhXLm5rNwJ/UkIiwoG/rLor9BAmhwu7HCTUqoTRgUYGYDXNEIg
	==
X-Received: by 2002:a17:903:380f:b0:2c9:c18f:7446 with SMTP id d9443c01a7336-2cef143b0aemr46392065ad.27.1784073253712;
        Tue, 14 Jul 2026 16:54:13 -0700 (PDT)
Received: from p1.. ([2607:fb91:1513:463e:34c6:f6a3:8e91:2983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm123236075ad.65.2026.07.14.16.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:54:13 -0700 (PDT)
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
Subject: [PATCH v4 2/3] fuse: bound io-uring payload copies to the registered buffer size
Date: Tue, 14 Jul 2026 16:54:07 -0700
Message-ID: <20260714235408.1666063-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714235408.1666063-1-xmei5@asu.edu>
References: <20260714235408.1666063-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fuse-io-uring transport imports each ring entry's payload buffer at
ring->max_payload_sz and bounds both copy directions against that value,
ignoring the buffer length the server actually registered.  Both the
server-supplied reply payload_sz (fuse_uring_copy_from_ring) and an
oversized request payload such as a large FUSE_SETXATTR value
(fuse_uring_args_to_ring) can then overrun the imported iterator and hit
fuse_copy_fill()'s BUG_ON(!err):

  kernel BUG at fs/fuse/dev.c:1053!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1022)
  Call Trace:
   fuse_copy_args (fs/fuse/dev.c:1329 fs/fuse/dev.c:1351)
   fuse_uring_copy_from_ring (fs/fuse/dev_uring.c:686)
   fuse_uring_cmd (fs/fuse/dev_uring.c:1226)
   io_uring_cmd (io_uring/uring_cmd.c:271)
   __io_issue_sqe (io_uring/io_uring.c:1395)
   io_issue_sqe (io_uring/io_uring.c:1418)
   io_submit_sqes (io_uring/io_uring.c:1649 io_uring/io_uring.c:1934 io_uring/io_uring.c:2057)
   __do_sys_io_uring_enter (io_uring/io_uring.c:2646)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

The request path overruns the same way, via fuse_copy_args() ->
fuse_uring_args_to_ring().

Store the registered payload length (payload->iov_len) in the ring entry
and use it for the import and both bounds checks, so the buffer the
server provided is honoured and an oversized reply/request is rejected
(-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
fuse_dev_do_read()) instead of panicking.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
v3: propose the patch fixing another issue found by Bernd by Joanne suggested way
v4: no context change as v3; add Reviewed-by: Joanne Koong ...

 fs/fuse/dev_uring.c   | 9 ++++++++-
 fs/fuse/dev_uring_i.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 77c8cec43d9c..4529505b2bca 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -650,7 +650,7 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
 {
 	int err;
 
-	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
+	err = import_ubuf(dir, ent->payload, ent->payload_sz, iter);
 	if (err) {
 		pr_info_ratelimited("fuse: Import of user buffer failed\n");
 		return err;
@@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
+	if (ring_in_out.payload_sz > ent->payload_sz)
+		return -EINVAL;
+
 	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &iter);
 	if (err)
 		return err;
@@ -725,6 +728,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		num_args--;
 	}
 
+	if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->payload_sz)
+		return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+
 	/* copy the payload */
 	err = fuse_copy_args(&cs, num_args, args->in_pages,
 			     (struct fuse_arg *)in_args, 0);
@@ -1159,6 +1165,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	ent->queue = queue;
 	ent->headers = headers->iov_base;
 	ent->payload = payload->iov_base;
+	ent->payload_sz = payload->iov_len;
 
 	atomic_inc(&ring->queue_refs);
 	return ent;
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 55f8d04e4b0b..efa7f034496a 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -41,6 +41,7 @@ struct fuse_ring_ent {
 	/* userspace buffer */
 	struct fuse_uring_req_header __user *headers;
 	void __user *payload;
+	size_t payload_sz;
 
 	/* the ring queue that owns the request */
 	struct fuse_ring_queue *queue;
-- 
2.43.0

