Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296614;
	b=28DZhJQROiGnmyAEgPQ3TLkiy8tKmrcGp+KPl+b39SDHbLMH+niS1qJ56URrfZbcql7q
	 irV7vd7oBFk4eBzQT8b7ETHiKkryc9GmmYnzsgjYOSQ/jyjldz0SiLH+i3li0vNmEinlW
	 qYc+lKha2AzMrHTrsxxpFVwoBR2K4TKDV4+f2i6sHNHiigQpVPfV+3pdmlqJS6jZtvw5u
	 vzC/Hd2pKfgV5jqdzG2VKKN95yqAV4XB34HrD90qe1uo02/H49YAORqhC3MZkZq7Kt3I6
	 dvDoqVvh8vm3sYbO2jC8vJyF5Z7hlkj+sdYucu5cYADWk73xorueNmJgEA154+PLnHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MSfLaYgVJFA/7kh0ajpfQ0VBoFswEd8KsIXoE/nQmBE=;
	b=cqjWzy5HLxeX4AGyaNaMvD0JvOpHTXvJctNE+cvsLtjF9uRa65DoH9lx4AS+h256Q1e+
	 ipoAo7+c0pIjvqd887Cp78JnSaVBt051FcGP0zHmCR6e2dWTrFSfR4El5M8v8GuRO5HKS
	 VdzXVkmwq4JxYBj9230lYbvuCEnO2sbwXQssiepqZsThij0oKemvjxYm/eslxRqZGihcu
	 jC3q7yyv1QmoWtv4u3LB+vXEP+EZ0bl75sKeBnUINFnhHkv9P61oidIMJpoZjdBMOS9YA
	 VVHbmkpLSiw7EvtimJ1AmS6Qp9rUVLBQn+zcxVLjrxsr6867W+7hLO3+1+y48XroH2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=fOGu3HWE;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30795606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30795606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=fOGu3HWE
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-717080a2d50so1971866eaf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296613; x=1795901413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MSfLaYgVJFA/7kh0ajpfQ0VBoFswEd8KsIXoE/nQmBE=;
        b=fOGu3HWER6JPbxJXGkdrq6u3JEV27b1QrHBrW768c0S3mFNNbXsA4LOyJJPP3vEZ8V
         bXr7cxrOCc+8PfuoOjl117Yx2uW7B60I0tW289MplP7CVebBgXr5wdC9jnyZyIr5XPB1
         QgWmGk7dBdUWajLyCo2klGCKYrb0Ydk8ZhCiedWcRprZbSOvkxRxGuRb+dvTuKNShxGc
         Hv5hZ+qMTZ0qWvlzIhIQy3iyoSFNpwiDRRV/fugd/jVYQrF4zRdGtJIfWtv5nEbYHYh1
         WkZp4x6mHb+s6qkco16DOhbLmb9/VLbCo5h/8w0b27nl7bdOmF2+0K3TqMi1LD8Ffbfv
         Y9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296613; x=1795901413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MSfLaYgVJFA/7kh0ajpfQ0VBoFswEd8KsIXoE/nQmBE=;
        b=IB2zPtI1cSCYSKbmHhl3XsvTg/+Rl9MbQsCvR2KVTDTyXeBkeO7V8QEMmM1Yms5RyH
         U/X6EUwRVDpI/69LQyqQBHeqFwTGpkt4t5b6ZkzLJlXn9sHA0FbClMCoKxgeqRFvKO6p
         ESrh6IT24wDsEn/8S3G1MDO9hLB6p0lb6TOHaYJ5ZPZqc81lIyxbv9gVeVq6NWsAsHEN
         Kxs4ABGmmLDzl/Zurr71Alxs8j6xmoxQuBuFl/28cXftAorE70+kdU36/mUYhdU5tDjS
         EOoMO0Bqydh6Mulkj5iAOLEx3wmEt7u1zKQGcK7p5bCTsx5TlbLrcHxytzHVyoQfsGzN
         vJQg==
X-Gm-Message-State: APuU4Z++XAuxoEFyQ9GnjSWMVRnOotTLV/jAkyc1p3w+zwkjL8L8MycT
	xByRmFlACxXYM6gfHcdHQAE5SFvWBkzO4SXaMibr0vD3XYeumbYC6kSHfYiyQam7n9eQ8CaRM03
	0zZGVgf8=
X-Gm-Gg: AZFdTZcWzs2CYs/mAegQCZQx7++l1M01E3Oc/lgg2Kh2ZVnQi7QD42lRJJkwa8tqIGA
	q6/IdwSMYhoVLYP0C6wg5ESRpN3UxkZKOhQgBpY4YtV/ogTn16OT/WkpFOaKSDzr+hlwK2r0qKN
	L96Okqy2IK9Hz2cGOCOsx12GpqVFUkN1f8rR976wFWEd/jQGY+OQRjwUkxcdBasF4IpNWnl9Sh/
	WRGZsAzYyt3zZrlUz4aDkgYpoikendfELdlKbQePdYeephEpQ3eJBaKGHBhJ5AjP5HVuXiBjhD9
	+BvR31021+gSDenCJoFlld5G6QtsPT879NS1sAO6ci8mngI+v6QnZkH+zRyeDIq2q/rz3ag0FJv
	HD6LJutiB2hP1w1qr9w4LzCwnWrwgX+mLfYcrJO+E0+0hGefCEM6aCUGpBL6ziJWXmagscUldDh
	yn5cdlNt7X1iyNPtKv8aXD1I1lX9Il0u13YaOd2dY9FVVxXVhj+zMed5RgtyOwqv7JzWTO/jBYA
	iRSVS238rlYIIyH5tOLJuAyR2SUcfOQpdx0s0o1laSxbKteSAvikJn7Pzxdk++co79JCKXpXUAb
	uWHHnozXR13EBaUz2FKNL30GkAfPZZsnq9LYCB3X1NUg8ns3xcq90XU5tRoNrs3Z033Fc5RzPxh
	dcz5PKz0WjeDKTPtp0HKGGqGqXGWVVzh/m/91
X-Received: by 2002:a05:6820:c5d0:20b0:71a:f794:49b5 with SMTP id 006d021491bc7-71b395c1759mr3834937eaf.89.1795296613064;
        Sat, 21 Nov 2026 13:30:13 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdbb4fsm6110825fac.5.2026.11.21.13.30.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 4/4] io_uring/rsrc: keep the old file when a file update fails
Date: Sat, 21 Nov 2026 21:30:06 +0000
Message-ID: <20261121213006.1787626-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213006.1787626-1-axboe@kernel.dk>
References: <20261121213006.1787626-1-axboe@kernel.dk>
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

From: Cheng Yongkang <teel4res@gmail.com>

Commit e5a346e4309d720c47fe8331a00068608fad47dd upstream.

__io_sqe_files_update() resets the slot before it calls fget() on the
new fd. If fget() fails, the fd is an io_uring file, or the node
allocation fails, the update stops and reports that entry as not done,
but the old file has already been removed. Later requests that use the
slot fail with -EBADF, and if the old file was registered with a tag,
its tag CQE is posted as if it had been removed on purpose.

Reset the slot only after the new file has been checked and its node
allocated, as io_install_fixed_file() does. Removal with fd == -1 still
resets the slot right away.

Fixes: c3a31e605620 ("io_uring: add support for IORING_REGISTER_FILES_UPDATE")
Cc: stable@vger.kernel.org
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/20261116044531.281978-1-teel4res@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 has no rsrc nodes for files, the old file is queued for
removal with io_queue_rsrc_removal(), which can fail. Get and check the
new file first, and only remove the old one once that has succeeded]
---
 io_uring/rsrc.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index eb91f5b28924..485e6571172c 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -438,7 +438,6 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 	__s32 __user *fds = u64_to_user_ptr(up->data);
 	struct io_rsrc_data *data = ctx->file_data;
 	struct io_fixed_file *file_slot;
-	struct file *file;
 	int fd, i, err = 0;
 	unsigned int done;
 	bool needs_switch = false;
@@ -449,6 +448,7 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct file *file = NULL;
 		u64 tag = 0;
 
 		if ((tags && copy_from_user(&tag, &tags[done], sizeof(tag))) ||
@@ -466,15 +466,6 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		i = array_index_nospec(up->offset + done, ctx->nr_user_files);
 		file_slot = io_fixed_file_slot(&ctx->file_table, i);
 
-		if (file_slot->file_ptr) {
-			file = (struct file *)(file_slot->file_ptr & FFS_MASK);
-			err = io_queue_rsrc_removal(data, i, ctx->rsrc_node, file);
-			if (err)
-				break;
-			file_slot->file_ptr = 0;
-			io_file_bitmap_clear(&ctx->file_table, i);
-			needs_switch = true;
-		}
 		if (fd != -1) {
 			file = fget(fd);
 			if (!file) {
@@ -494,6 +485,21 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 				err = -EBADF;
 				break;
 			}
+		}
+		if (file_slot->file_ptr) {
+			struct file *old = (struct file *)(file_slot->file_ptr & FFS_MASK);
+
+			err = io_queue_rsrc_removal(data, i, ctx->rsrc_node, old);
+			if (err) {
+				if (file)
+					fput(file);
+				break;
+			}
+			file_slot->file_ptr = 0;
+			io_file_bitmap_clear(&ctx->file_table, i);
+			needs_switch = true;
+		}
+		if (file) {
 			*io_get_tag_slot(data, i) = tag;
 			io_fixed_file_set(file_slot, file);
 			io_file_bitmap_set(&ctx->file_table, i);
-- 
2.55.0

