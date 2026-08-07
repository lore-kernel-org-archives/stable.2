Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5E146A66
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072557; cv=none; b=cpz6gy414b8mZumxh4TtX2YPYQ9WO4Ucij54P9lKobGxo10b0az8LNtYmMKsQVhWBvCtA2Lrl5GbuJSBMb246+bGC+RqILZzGYra69ivvwovsPWKzxbrF34qoG/IXtWOVFjT4+zvsdHpx6M4YsHJpfGS/tKjPZzKsZ+3dFircAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072557; c=relaxed/simple;
	bh=3A5C3EXvvGEoWJ1l+7sfPmTDNuAFh/3jvfuQgavhu6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4T8daJM7QQhBlleLP7aZn1PcGmwhQLc5J7JK56SlkcBraelHE5DRVD5ABeL+aplyM75sJsV5qhwLz03e0CryyC7ESf8aRe5YAkqOoeWLdfGBaOvf8gYZZw+wAtMsQHlzYl0oyARVbaN8ndkvuSv13etU0gvHIv+r4jH6dTGY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTXrDPbm; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTXrDPbm"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fb1883fbfso1073549a91.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786072555; x=1786677355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RCJZpBnqKALyKAEdfIL5xWelEc6Lw3PrSrs6EoGxV8w=;
        b=MTXrDPbm7z3BBJFr4sa/JaG+xLSwJElgo4+W1fou4zOLNokuQJb7uApJ8zVzmhL6RF
         Q49mT1MJUliaXTXngc8EVaEUHxAwObOCcCY/r7TmHTh1trtPeVUUkR5cnRAlvY4bM0Ro
         tEBHi4TpACdmrcvhRPBAvt0yKiIx5LYqvtz8POE4HClnRp35M7xcux2GJqoJipu8/aDN
         fJmTd0ke5JgUDlbWqQGV+23MRU+q8RA5iIUTzgL5mmhbXUNhytLdGGjaPg3AZRb2j5Lb
         55eh32FiUs12ZFwJa11KG8A64Boj0/z/q+WXJKuud4zPL3AyseCvcWtRCqwYG5RU0agK
         RF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786072555; x=1786677355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCJZpBnqKALyKAEdfIL5xWelEc6Lw3PrSrs6EoGxV8w=;
        b=PR2b4CALgF8VwWn9zBvFCJPNu24JzIYksKwKeeaiunB6GSjWoD32neBQCKJEWq7ER3
         aF2uIYYcwXMquWTEfVwREkPegSVS/hCPnM5ggL/YrtmfW9OG5/CxCN8JxkU0zD8Yndgr
         4uEGntltXR/tjeStq8RguodT5Hbt3DLZcaN24Ota+6/LJe4iCvwVrGfjPlmI4pwftWoe
         /kMLehxxUAb+cA9JfbTHyEyYXq5TNPxdAjfJ0WSnnepBJSKpQ2FbX3gzWkU5H/aHt5Yk
         h3zuzmSNmlacWnzexVd/+MRfqoY7MCJFtsZUzfcYcv0eq8xFYoGsC7xAMSFUHmDVMNub
         CaJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7LhyPHifchcN7cL1tJAKV5AaeQ4lQwf8z7Z2A7zgPEfWgLjybPW/0/86orZ+ucbezh55Lkwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEEALmbWZ62n/O9ibNG/rXrZrh94mRRk5QjWsR7E0vPrAij+H
	BPxpq7a1i4B8EOhuAnfmjsph8bg4jHPFExJ9zh7fqi3umtiDoaBQtEjH
X-Gm-Gg: AR+sD13E9mmgB8+eeT33rzJdOQ8Y3JXdNnldZ+UVmeKXIZB1PSPMtqar3t2B2Ylj4dE
	d5n8nkakv7Ye0uBWVvqMeA3SUuJ0BVR7/cFKIUM01b3irgF/VG2tV5jKdrbiPYJGrC2huUId4Zm
	jFIgfBhLkyfXESQ9i7+ppUa3Mz5qNOmob3YEgm7vPtgGIkH0FlBZQkqETvxwHmQzfe9yJNcmpOM
	BTUWeTn+Md2CJv9kX8YxE+gNzCd6ddsRcLwnHq9lmmVNjSkAzTDcuJWM5OUiGI7XUNAl9W+uaib
	yug2IssauUy7wgrY55ae2utj6oR+blS2nU0OY7cm7CmbpFvYuKm+wnRXAs3R/NL5hdpk0ShoDfE
	FbPvaW7b6UhPnpKbFp3GzXgrjUzkSd6KXIpHKqXJKrEpuyAOlTL3LfJ5tn9mM8q9WidjY5uqBfS
	ZUMWKdDGws+buVGvLWGjlHhpaXRdFbVSM0xaNfRAKgWCEV+a/ojVkrfgADZwZtpxiL3DCi5uU8y
	NVKznDfEQ==
X-Received: by 2002:a17:90b:2dc5:b0:38e:ad9d:1151 with SMTP id 98e67ed59e1d1-3909d79f314mr7651334a91.4.1786072554897;
        Thu, 06 Aug 2026 20:15:54 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([2409:8a55:94ec:7c81:f9fc:df1b:ed1e:972c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b30d465csm388060a91.2.2026.08.06.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:15:54 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Zhao Chen <winters.zc@antgroup.com>,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fuse: fix use-after-free in fuse_chan_resend()
Date: Fri,  7 Aug 2026 11:15:34 +0800
Message-ID: <20260807031534.4362-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_chan_resend() sets FR_PENDING before acquiring fiq->lock
and before the request is actually inserted into fiq->pending.
A concurrent cancellation path may therefore observe FR_PENDING,
incorrectly assume that the request belongs to the lock-protected
pending list, remove it, and drop the queue-held reference.
The waiting thread may then release the final reference
and free the request while fuse_chan_resend() still holds
and accesses it, resulting in a use-after-free.

The following is a simple race scenario:

CPU1                                CPUx

fuse_chan_resend()
  move req from processing
  to stack-local to_queue

  set FR_PENDING
                                    request receives SIGKILL

                                    fuse_remove_pending_req()
                                        sees FR_PENDING set
                                        list_del(&req->list)
                                        drop queue reference

                                    request thread drops its reference
                                    refcount reaches zero
                                    req is freed

  access struct fuse_req
  lead to use-after-free

A FUSE request being resent concurrently with fatal-signal
cancellation can trigger a slab use-after-free.
[   27.327266] ==================================================================
[   27.329157] BUG: KASAN: slab-use-after-free in fuse_chan_resend+0x29c/0x7c0
[   27.330554] Write of size 8 at addr ffff8880079975a0 by task exploit/1711

Move the FR_PENDING publication and the other resend state updates
under fiq->lock, in the same critical section that requeues the
requests on fiq->pending. This prevents cancellation from observing
FR_PENDING while the request is still on the private to_queue list.

Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
Cc: stable@vger.kernel.org
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 fs/fuse/dev.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..e54567bd247e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1760,7 +1760,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 void fuse_chan_resend(struct fuse_chan *fch)
 {
 	struct fuse_dev *fud;
-	struct fuse_req *req, *next;
+	struct fuse_req *req;
 	struct fuse_iqueue *fiq = &fch->iq;
 	LIST_HEAD(to_queue);
 	unsigned int i;
@@ -1781,18 +1781,9 @@ void fuse_chan_resend(struct fuse_chan *fch)
 	}
 	spin_unlock(&fch->lock);
 
-	list_for_each_entry_safe(req, next, &to_queue, list) {
-		set_bit(FR_PENDING, &req->flags);
-		clear_bit(FR_SENT, &req->flags);
-		/* mark the request as resend request */
-		req->in.h.unique |= FUSE_UNIQUE_RESEND;
-	}
-
 	spin_lock(&fiq->lock);
 	if (!fiq->connected) {
 		spin_unlock(&fiq->lock);
-		list_for_each_entry(req, &to_queue, list)
-			clear_bit(FR_PENDING, &req->flags);
 		fuse_dev_end_requests(&to_queue);
 		return;
 	}
@@ -1801,6 +1792,11 @@ void fuse_chan_resend(struct fuse_chan *fch)
 	 * intr_entry on fiq->interrupts after the request is re-queued.
 	 */
 	list_for_each_entry(req, &to_queue, list) {
+		set_bit(FR_PENDING, &req->flags);
+		clear_bit(FR_SENT, &req->flags);
+		/* mark the request as resend request */
+		req->in.h.unique |= FUSE_UNIQUE_RESEND;
+
 		if (test_bit(FR_INTERRUPTED, &req->flags))
 			list_del_init(&req->intr_entry);
 	}
-- 
2.43.0

