Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E20435524
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073261; cv=none; b=g3QpOuf1s8GHJZphSmNsbHZ9JNCKN1gw+lGMwRvsH6JI2lEMtdvbKEbJxaOmCD8QdMrj5Jbr7F3VQWjpvh3mYeFdVE+8ps2Qncsg+qMY6uQptOxf8DLlleqy+SqS8MRjj2AAP7JuPFq2+o7O/Mm08O2+gwSOyv2e18wVo8JCoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073261; c=relaxed/simple;
	bh=t2bCjvQESDfrtTkydLO1/4vSR4Czd2I4rz/vDz9rwe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm35EjLdpkO5gs8Rh3Zydqajac1zFROmQkcAghpsPBSivLpsSnUgWiyMhOqkSShC/5W0lmBV4F2pqbhzFSpM/9wIraY1pWKSfAZnoTPRy849g5hT5Ghnnd2gPwhOuSnTxJvN3vI24BistYD18PEXZ7NFHrz6jG0QKsUeGRLuP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=E5Y5HNDW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="E5Y5HNDW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc61541f8cso1262995ad.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784073256; x=1784678056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WEci7FoVON0/ZMv2IFLGjX0V0D6atEWv0SWH6c8vLwQ=;
        b=E5Y5HNDWvSxTdGqodS22W6ncRF8dv27eH5UVX429NgsfXd09KIAJrdvGQUyX34ddYf
         vZvMnCMhEhZhtC3LOFSb4Z4WiwbzGCsYArk8u1I2FGtmRuoGOohQzeANWLPKHvJKnqI4
         zz9mmSY5rdwmgsNjOFc/t45XW5mUhJCFLHVwBQvodWb91198ywkaOgUd6ceSlZs/pBob
         28LGcB6TTjozgL1Z9Coa+lU6+s6+4hEBS4zqZSZus1Zua/3W2BZ0Lt09XBjmYC5W1VJ9
         VWm3HaXRpVXVBk5kyukKWSYn5jhOOBJTaDip+qXh0i8cnLvXQwwyMy8MtpbESt5ZG/uG
         5BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073256; x=1784678056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WEci7FoVON0/ZMv2IFLGjX0V0D6atEWv0SWH6c8vLwQ=;
        b=K53wh4HIPGnZh9o+oF2eqK82Ae6dS1rV98qxSfZZ+so6XuWxn41UotN7lPGXZgKQ3E
         OTNuXBAST+yLdsesxdXYoUkrVm9wCm4VQHlmh8zLVmlF5OcOVogblYBGt46db3HAwUjR
         TfiabK7oZQE6CnAmXKKrJdicPqupmbZG42JWCZA/eOlec+l3BHRG9Z3Issi1y7WQB7HW
         yeESQK574O+DKtkh6Jdwe10ePbhDHComgSwKd/7XEvtaNj2BYXxZtpVfpJOnxEnjnx5l
         tZjoVYQz0nI5KtExd5TmuuHxM9O2qmLe/mszwRnVkB6JTpwnqCOhYgrGWaYdUDaMjLBA
         9/ZA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/augPsZD9flKvSe/jQKjjbgrFtewb/G9TQo15yK/9x7RtqiorftqqdteVp/uJ5LYNwY1bKfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZWdDq54gj7WXiPwCjvs5IOXVIJ+ep8ZQ7fmFLk+T6yOIPBG5
	HidOpCzAscJuPDNyp8BLK4iml47hsiYVWVYq7hL17XC+vnrmI54krJPNV4vsxux7Qw==
X-Gm-Gg: AfdE7cmsXGZzk01uYWM6hMnOpaR5bO91VocthOJhdBIinfm+s3Cm3yFL+QqzWWvZgyh
	kdHe9WbcfV8HPoDa1bluwu53eu0w7IyuCukmYrsqmlWY9DJSN0jgvOOxIrJctAxRNECVeGjyD6M
	8NeWqJ8cD0ATkKy8qPX9OJQYSmNhOUk80VBfFI8c1Ng3X4+pXG609NRTcNWCd3jIfAsbDGww2Ya
	J+OAt7R54oyAibS7wzVsnFuskz3pAOv9YoAN8SfGLm3by/g7hs8U1P3tXIHcf5R1fvTNOynFZUK
	MfK4J7Aq/a0ECE8/dJpqp05MNJmmm5kHB1JSH2NkejFRCQs6uxL9yv9mGDY49LQNAn0phwoYxaR
	18MjtdGMkWHzhgrqM9T5Ow445UWlJ8Tx+6oYqUx8yScEIM2ZlQ395bmh2kFWyPfmCjVEppmymGQ
	==
X-Received: by 2002:a17:902:e785:b0:2ce:b67d:cf06 with SMTP id d9443c01a7336-2ceb67ddf65mr114511605ad.1.1784073256262;
        Tue, 14 Jul 2026 16:54:16 -0700 (PDT)
Received: from p1.. ([2607:fb91:1513:463e:34c6:f6a3:8e91:2983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm123236075ad.65.2026.07.14.16.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:54:15 -0700 (PDT)
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
Subject: [PATCH v4 3/3] fuse: deduplicate the oversized-request error selection
Date: Tue, 14 Jul 2026 16:54:08 -0700
Message-ID: <20260714235408.1666063-3-xmei5@asu.edu>
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

fuse_dev_do_read() and fuse_uring_args_to_ring() both pick the error for
a request that does not fit the server's buffer, and both special-case
FUSE_SETXATTR.  Move that choice into a helper so the two transports
cannot drift apart.

No functional change.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v4: introduce fuse_req_too_large_error as a helper

 fs/fuse/dev.c        | 5 +----
 fs/fuse/dev_uring.c  | 2 +-
 fs/fuse/fuse_dev_i.h | 7 +++++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b8e43e374b35..56c38aca7389 100644
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
index 4529505b2bca..cebd8f871627 100644
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
index b511aaab6bfc..4958158c0f02 100644
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
@@ -367,6 +369,11 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 	return fud;
 }
 
+static inline int fuse_req_too_large_error(struct fuse_args *args)
+{
+	return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+}
+
 void fuse_iqueue_init(struct fuse_iqueue *fiq, const struct fuse_iqueue_ops *ops, void *priv);
 
 struct fuse_dev *fuse_get_dev(struct file *file);
-- 
2.43.0

