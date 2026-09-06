Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DC31E832
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658170; cv=none; b=tt9KZpx3nCIAOPbqefU3tlCX7qaw8yyAG/ELIn4uUDOQlfDT/xHQ6RT1VKkT/gczMU2hyBc4emKrvol5GoaHFydbc7/RLH1/CHncEduGpMZ/iMm/bDLG+OcBnn4Kx3ETMgW/ff9JNJFb+3/wgzphIWg/LZiGepsKhgKe8tUDeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658170; c=relaxed/simple;
	bh=7a1Ndwvoc4REla0vGLCnEWdMwph1amt4g7HmhXPWcCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrUgiVHiNhaJXfLJR0x5g9cFFzLlOUFyyNq8MOp86zTliViim7rcGFTOaiaalYFjT0wg/yHi6rptF3xP9OHYCCdsMOuo4NQ5933byHj2OoKQnfQRRUzMQBoP0JBmTKGfdEXeeT5Ivba38EqcoNd5fGg8SZ2NQKFDSw51XFyRCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=eAAHkKeG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="eAAHkKeG"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1983137a12.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788658168; x=1789262968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oT8Nfdv6MGvf2cFqhsDb4n1/o/u/U/Uyjhc2N7KsByk=;
        b=eAAHkKeGXWX6PgPhM2KKRjBUbHf01ziQBAY1aIAfy8aW2YHAwnZOegM0M1adylhP+h
         BpC9QOPHJ7usrIa5BDy3LHeY36DkkIxnCDTMdYjksq58q3sicsFBywWuoHs6wOkjcSmT
         KRPx8H+nl9BDwVEaHac/FuSRgI3b2D9kJsO2RcVlYmk3hhJ7psGc0qakEudaDp4bEzQG
         7PgS1bPoSZYYfGj+p6miJoyOvjJyYxbNzlk6VltLG8WNr8j4nciUEIRk7krpBzbjAZmL
         CHCAnyOXCHHT25j91by5UXDCKhxf1KsIcCCl7ppNIpPw7RYqeqxa/2Heck4OosWw1nYy
         NiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788658168; x=1789262968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oT8Nfdv6MGvf2cFqhsDb4n1/o/u/U/Uyjhc2N7KsByk=;
        b=jET2mDbw717H5pz8aqrpj2kV3w5jg0cPIMnZjqfhRfnzQw2vO32nRRmeG6FMNOhPil
         ppyrNvgOhTrZaMr4OmhGy7ynFECe5ApuAVFMc13cES/XXeC9QapAU38CgmWI+ExKKy89
         l5/kI8KUObDLUO+8U4Iz+CT7kEdhvOjGHfTzjJEjWEUJkkNeNKW5x7g1qImZJdi/T3/5
         xfO5KA+AUQVfNWqEHdnXU54CzSONCrjeqnNKyNkquazskM45OudKS9ydVovn7Ej/L8xK
         QjT9kJpclDQ69xQGiyCPuDfSHq+Sj+we9QFyAZDfXsbLl7sNU7OUvbYJ8wtvQEamINh/
         bPXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwgqW1ablhl0k0EqrRgswLFac5YD8m4HYEFfjTFaSUCYvvUbep60fkBmy9olWqkVXngiV4UEs=@vger.kernel.org
X-Gm-Message-State: AFuF++kPMTFY0skas4mnY5P0oVToC1B01/K5MEHnLgtS3spTetNkELUM
	gGhPDVr0k1s7IgRqVBm/2q8Qf8Ykof2e0uWrgh8AKnwzuasnxVlOE+Yp/7MKAk87cw==
X-Gm-Gg: AYBFou35waBltS9rXSDUlF0FD3TG2VwKtrz9YaDlVKWxU2SrQjdgjvLIJGLQ2QLxt8Y
	rh6UyQ0DPVzAALvhKsksELQBFUw1bnoFWkkzLGu5t8JoiGuYMng0B/TfMy9CcLXOj4VSveKEULw
	LRy91FhtPooggSRCiCictQurfyOLyiKwud5v88KsBOUmJ9sNmyoJNFw5w1pXpk2rgabg/ktlzDv
	UlE+ybtap3AECNIoeWBNaLeWxDX4jZd0LWiwzBrEmCgBiG9ou28yJu6BMlAMlIuUSb/AgYWoHhh
	Ib3ILOd9RkAjKFyH+ITnhDWJdSMGohegHkEFrlmmTxF2FojizKy5z+eLZFqTlhgn4eDYgxo23zm
	aOIWU7Zo91kJ3YYVJyzYcAXqhsAWujM9mk6RD2nmY4I1feeJshwatK7VAm0jLRj/vxm2BAxWmob
	llbI1SAY80BcoI9+xuNti4Ony9SuK0fTeqfYmsd6GAAQx6BOpdL+jlkwwuP6UeowDNycip95NUf
	PBKCpoSLavN3Uj0aeGIn6Jc
X-Received: by 2002:a05:6a21:e081:b0:3bf:6222:2e7e with SMTP id adf61e73a8af0-3da39b4390cmr22662653637.4.1788658168307;
        Sat, 05 Sep 2026 18:29:28 -0700 (PDT)
Received: from p1.. (129-219-8-31.nat.asu.edu. [129.219.8.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm17456853eec.19.2026.09.05.18.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 18:29:28 -0700 (PDT)
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
Subject: [PATCH v6 2/2] fuse: deduplicate the oversized-request error selection
Date: Sat,  5 Sep 2026 18:29:23 -0700
Message-ID: <20260906012924.1928316-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906012924.1928316-1-xmei5@asu.edu>
References: <20260906012924.1928316-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dev_do_read() and fuse_uring_args_to_ring() both pick the error for
a request that does not fit the server's buffer, and both special-case
FUSE_SETXATTR.  Move that choice into a helper so the two transports
cannot drift apart.

No functional change.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v4: introduce fuse_req_too_large_error as a helper
v5: add the explaining comment Joanne suggested; add her Reviewed-by
v6: rebase on fuse.git#for-next; no functional change.  Dropped the
    Reviewed-by tag.

 fs/fuse/dev.c        |  5 +----
 fs/fuse/dev_uring.c  |  2 +-
 fs/fuse/fuse_dev_i.h | 12 ++++++++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4fec31fc0b84..9fa90a48357a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1613,10 +1613,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 	/* If request is too large, reply with an error and restart the read */
 	if (nbytes < reqsize) {
-		req->out.h.error = -EIO;
-		/* SETXATTR is special, since it may contain too large data */
-		if (args->opcode == FUSE_SETXATTR)
-			req->out.h.error = -E2BIG;
+		req->out.h.error = fuse_req_too_large_error(args);
 		fuse_request_end(req);
 		goto restart;
 	}
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 981b7c295e5e..197d277023a5 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -898,7 +898,7 @@ static int fuse_uring_args_to_ring(struct fuse_req *req,
 
 	if (copy_size > ent->payload.iov_len) {
 		fuse_copy_finish(&cs);
-		return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+		return fuse_req_too_large_error(args);
 	}
 
 	/* copy the payload */
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 4b412a76225f..5435ee069b4c 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -13,6 +13,8 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 
+#include "args.h"
+
 /* Ordinary requests have even IDs, while interrupts IDs are odd */
 #define FUSE_INT_REQ_BIT (1ULL << 0)
 #define FUSE_REQ_ID_STEP (1ULL << 1)
@@ -367,6 +369,16 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 	return fud;
 }
 
+/*
+ * A request that does not fit the server's buffer is rejected with -EIO.
+ * SETXATTR is special, since it may contain too large data, and is
+ * rejected with -E2BIG like the VFS setxattr path.
+ */
+static inline int fuse_req_too_large_error(struct fuse_args *args)
+{
+	return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+}
+
 void fuse_iqueue_init(struct fuse_iqueue *fiq, const struct fuse_iqueue_ops *ops, void *priv);
 
 struct fuse_dev *fuse_get_dev(struct file *file);
-- 
2.43.0

