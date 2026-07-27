Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0433CBE84
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195448; cv=none; b=PXGCd1V6jyMEFdAkZLCBt47nctczNrcNe4bAIHqqtqANh+tazr849vTcZs2jtHTZ48ISPyUtbxgjNXIFZrkTcSianKf1w7cRHRzZgSNHfZAOvC75I6FIK4S0qAl2fg1E4snKZMij92eA1ardkc3qqJYKs/ulWjJRDpNU+9AYXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195448; c=relaxed/simple;
	bh=1WH8L/LQfwbDgvXOX50fs46GCINEST5r8Hk4xbxZhKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJBAbPtrpjHcRzUL346BLpa9vTcDjnXRpjeDq9lN0VOtVYPXtbHFfEmCZIRcxQ/DT3ri9S9i0kmJi9eBEay/903Pw2E009hPPZQ3dh+7n0DTeW3vxMdVarGtP6Vtar7tUSL6F4eR+zqJQX6Fch2UZUwW9JtRwLmexni0nB4RlIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=UmPjvOpr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="UmPjvOpr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so30583145ad.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785195446; x=1785800246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+eTeB9Y8fSbfXXCJFsPp6idegL+ISd+9LGy++ETIMQ=;
        b=UmPjvOprotKzd7csbjpftr3o0XZfhfS1WI4e/JsncqvWU4ngJn4LLIRVzuLm81HU3u
         ZekQXZ1zLJIDERuO1hgIHpJzF/pjoVNwZbgYnSsLWnVGMUAdrrEmqQ2JGNml12vWmp5U
         vEnp333Q7Plh5AIbr6Sr06l/1bjXpKt4pKXeBzO8ld0XI0mFe9WxVZO0UojGaV87wBnx
         9ZbI/xsNuxfHDvbt+ULnUeJVykIl8eWCAt2TPdHxPXzUJCjra4YgUKSpunvGD9rINimT
         ArEOkaT5I3K/Sg+3uwv9hO5udcP3sjFREAHgyPcYuf0nbGxcrzAf1wEaHJvwqlFDBBVf
         NpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195446; x=1785800246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B+eTeB9Y8fSbfXXCJFsPp6idegL+ISd+9LGy++ETIMQ=;
        b=C2BDBWFkc0JfMUYA08vQMfMs+6KV8Osu7T2+wpvn8oY/sj4V1J3l2iF9ZTFitn+I5a
         KmqbWi4BzZz9QrGLB5oyY4Hpb/jcTL1/iXe3LthT2gy3JciFqkGz0q7rLGItZ7RxiJ4/
         7eXEUS0BtZ+ifb8lHFSpR5BihofcQpgYaPd18dFDfDvrgoQL8gUTwVClQl5RldKaxUhG
         6n3/C+q7UObKIrJzAUMrvBUzAerY6v33hBPFYzBYl0xlIl7WU1Sl2eJ/sy8ETzcZ8rew
         DGTgTtTMbrxxvgYVgi+kUMIhVqupHvgyo2pTAjel69Ra2aq9OLSLqg20KOcCCZNY51D/
         81mg==
X-Forwarded-Encrypted: i=1; AHgh+RoAxFjiV1itMeKmsOlOj2yO/dcGh+QxJw9TFMZvbcD1b8exKYHZA/f7+zRt7KPKrOT1uG4NaqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+tFJKgwz7Sy//LjLW79wOTeZyxjnSFzO0ZSFobFqJcDZ7iXc
	ZPuwIamZB3xf6aIT8/tWSQOfKEBVLo8km9A4CE60f0fJpliX+OafUvrY7oIFsl8jsA==
X-Gm-Gg: AR+sD129eBWo1JndGQXIUbnFTh/6ixSRi0ZiOxf2hiLEGeyjKXIItBDnqoALdAfgbTu
	XyrScjOeXxr5WtOvKXNFLvLClEssPjY8MhDIWGdHH212me8xAjUYFRooYnzsrj88TE68rVQuDLx
	7aaY5oH4ERdC5Oq76h4L/yNZOnIZPNAsxgqO1YdmgwvFSteOXnuwTagqfNywqU+yTtT6VaepVEW
	tVcaZpOw2WPZrBpLKQahC42vMyoyLUnIGRrKobWog5kw4CLif0BT4eeaaHWEkYpqWSJQNckke5+
	4jDqCtAonXdAAWvdXQNB3XAq86AJFyJIY1SW+TiLyt4ySgw3KLCju2FzIicCoAKUJu0VF4oKIRw
	B49XAqjIvVF1YityOeA0/2NWoyfk+DjoYP5psb9GobMzyMSXAX9ucb9OiTdUH4qluImSrVu2D7w
	==
X-Received: by 2002:a17:903:90d:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2d015a87ab5mr88895ad.10.1785195446053;
        Mon, 27 Jul 2026 16:37:26 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec26:45a7:d22f:3f56:f9b2:423f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde4650a5sm42256915ad.0.2026.07.27.16.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:37:25 -0700 (PDT)
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
Subject: [PATCH v5 3/3] fuse: deduplicate the oversized-request error selection
Date: Mon, 27 Jul 2026 16:37:06 -0700
Message-ID: <20260727233706.218446-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727233706.218446-1-xmei5@asu.edu>
References: <20260727233706.218446-1-xmei5@asu.edu>
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
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
v4: introduce fuse_req_too_large_error as a helper
v5: add the explaining comment Joanne suggested; add her Reviewed-by

 fs/fuse/dev.c        |  5 +----
 fs/fuse/dev_uring.c  |  2 +-
 fs/fuse/fuse_dev_i.h | 13 +++++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..d290d2a215d5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1584,10 +1584,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
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
index 248e5a3e340e..46d948a047e4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -729,7 +729,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->payload_sz)
-		return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+		return fuse_req_too_large_error(args);
 
 	/* copy the payload */
 	err = fuse_copy_args(&cs, num_args, args->in_pages,
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 668c8391d61c..0bd5611e57c1 100644
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
@@ -362,6 +364,17 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 	return fud;
 }
 
+/*
+ * A request whose payload size exceeds the transport buffer size is
+ * rejected with -EIO.  The exception is FUSE_SETXATTR, whose value may
+ * legitimately be oversized and is rejected with -E2BIG, matching the
+ * vfs setxattr path.
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

