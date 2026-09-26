Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C893793B1
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452742; cv=none; b=YKicqpboHQGqkZ0elnVmNhgJV+Y3oLF2Y/AurZxeTo8JPiS+hiqGlpcGVlRqpvCrqwf++/L1IJaPsLYIMSqhFCZbawv9Hnbbmp4fU6MCl2INXZOUg9yEgwR4mFHQO/419iuDLcyN2exAyEzPga3DLz+6hxjm2LDkXOQCUsLQDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452742; c=relaxed/simple;
	bh=8UOZbOPEi4Ge9a21iEwLQt5UuMD2DMDLNGwGB/guOUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccNIpliXoZeEi9fzd6RY3veYJycYixUyhtfMs4NiDGB5CKxuA4E8JEovy/334jLboTT8Mz23jWspq0MU07GF9lrlgL6NBMD6JvfafYq2Kz3eYqgkewBKOksavoU9d184TkWvLlFF8PxnUKiuq1bu9bHkYZVh86kq/9GAUpE2uaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIoMkuvA; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIoMkuvA"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c67e5059f8so554928e0c.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790452739; x=1791057539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BEHFYKvdtxBCG1FtsLCemOPEWS8unZFjNSw09BPKGlI=;
        b=IIoMkuvAfPgvTTzFjOk5U6NrMBiVqXTUjVDoSi+wn5CWYLS8N4Iy/uVmh7Gfnpt9wu
         qhIgZhO4UzK5L1G0pxuyP2uk3vSgt27n9HlBQPY5rsNjkKjBRU2mBNkQto7GCoAQNkL0
         OePiCO+clFTxZzbOTQJR4ajONGx+nNHlDyLXsIzW7TWkjw0ZmhuAIY/28YJZVrsduvXQ
         samTawWtioauhuh3gUGXp4IUp7jOfvg6bCNQJlflDIU9wDgwzUxygTjkrgT+XzTWmfjD
         raoAEBpxYlkkKIZ6aGXuNsR6oXWlvmgtdpq0kaFPixl8LkvWiZhVBe7Mec1VUe5jw9wj
         MtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790452739; x=1791057539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BEHFYKvdtxBCG1FtsLCemOPEWS8unZFjNSw09BPKGlI=;
        b=0eUod0X8pthX0HzEkTQp587RqOuhdmksknVWjH9Wiea6K/UXWXpmhjrpesWagodcD5
         fN9OsmqFvySFICKnE/XY8MMEWPpyS7+a47/DTuZWrQoTRFLI8P5yioe7zjPeksAqQl2+
         EYTG8gWycDQHFTPtwYwlDA4GFD5QdkGY7h+dgn3otwbL/+mSwezDcFn4bwY6ZNHbcekR
         N4wQX0eHwTDfLLuw6uhbzwter/rvcvBX9KiUP9w8xZfVM39IgKfVQKBjp53Y7pPd8BRm
         X4uarroCy97ysLg/KNDxkdzGJRBfDoL4NSu+TdO4aXHmk4nrSmEv3VQ/GnM9pUB5gSJ7
         hpCA==
X-Forwarded-Encrypted: i=1; AKwUvBw/7a+o6Y27i7l5IJOD9stdaMDSTeSMJf3TiJ3g/Jm+YE4ShQDZiJn1Cq3m5tplSveTFBMzhgc=@vger.kernel.org
X-Gm-Message-State: AFuF++mRSJC5BUBcyLIG0DPoGh4NdErpfWFbMvCqiPAzewZsGGFEftQv
	bsn27cEJCh9dGhuPtGItdX6IRIHnrIDD1jb+uiWVoOT/McK+j2/1LUfV
X-Gm-Gg: AYBFou3Xkf82KkIECf0BFfOV9CZWtJFNqcgSZiJpDAhGMkOvmeUrJ69AqEz5YszHWFZ
	4u2G/XejwBay+RyuZZdL6w2HqKMXt4KQkgyzB3u/rPnBg5OS1taA14KRnnZ+e6wzLrgGUAWsbDE
	P3FE9Lzve65rHKi0XRPbriiz9wC3UXBxbycQ0IRhEjy1tB/mAcTpma14CAUi4AeslQImpsNo7TB
	QmTQdG7hbJcGkPYVQfyrwJPHfIfhm3tiLjZmAWrbPK8krwQKuvv9dPr6G4NDNUyHUm3/82VQyr/
	UUec1Jog0ZVOgRpHlQyYYekfcmVJeorVqMz8XoPx6auaPHUfP84eysLGBj5snPtwGFGFqQPkgIJ
	GSYVQm7lEztmE1nsAY4mguYHOIFnyin6NzqQTkykKbEOSuYlPlzChjgItjZTVcrTBhvD2VdSXjj
	nug7il7SQKtR87KieGfTgOO16Pvds6yi12LOTr2vhx1Wr+TgQp78arIcJtDiqKekhs
X-Received: by 2002:a05:6102:41a9:b0:7a8:3fba:361a with SMTP id ada2fe7eead31-7af1f3f6a52mr3135256137.37.1790452739061;
        Sat, 26 Sep 2026 12:58:59 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861afedba5sm7437742241.8.2026.09.26.12.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:58:58 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: johan@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"sashiko . dev" <sashiko-bot@kernel.org>
Subject: [PATCH v4 1/2] debugfs: fix use-after-free in debugfs_read_file_str()
Date: Sat, 26 Sep 2026 16:58:43 -0300
Message-ID: <20260926195844.1296333-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926195844.1296333-1-qwe.aldo@gmail.com>
References: <DLPDB44JJRGJ.3K6JNS746M71C@kernel.org>
 <20260926195844.1296333-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs_write_file_str() publishes a new string pointer via
rcu_assign_pointer(), waits for a grace period with synchronize_rcu(),
then frees the old string.

debugfs_read_file_str() dereferences file->private_data without holding
an RCU read-side critical section: it loads the pointer, calls strlen()
on it, and then copies the string.  If a concurrent writer completes
synchronize_rcu() and kfree()s the old string between the load and the
use, the reader accesses freed memory.

Fix by measuring the string length under rcu_read_lock(), allocating
with GFP_KERNEL outside the critical section, and then copying with
strscpy() under a second rcu_read_lock().  If the current string no
longer fits the allocated buffer, retry with a PAGE_SIZE allocation
which is the upper bound enforced by the write path.

Cc: stable@vger.kernel.org
Assisted-by: sashiko.dev <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/debugfs/file.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 08de6652a..f9a1f7739 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1018,7 +1018,7 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos)
 {
 	struct dentry *dentry = F_DENTRY(file);
-	char *str, *copy = NULL;
+	char *str, *copy;
 	int copy_len, len;
 	ssize_t ret;
 
@@ -1026,26 +1026,37 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 	if (unlikely(ret))
 		return ret;
 
-	str = *(char **)file->private_data;
-	len = strlen(str) + 1;
-	copy = kmalloc(len, GFP_KERNEL);
-	if (!copy) {
-		debugfs_file_put(dentry);
-		return -ENOMEM;
-	}
+	len = 0;
+	for (;;) {
+		rcu_read_lock();
+		str = rcu_dereference(*(char __rcu **)file->private_data);
+		len = max_t(int, strlen(str) + 1, len);
+		rcu_read_unlock();
+
+		copy = kmalloc(len, GFP_KERNEL);
+		if (!copy) {
+			debugfs_file_put(dentry);
+			return -ENOMEM;
+		}
+
+		rcu_read_lock();
+		str = rcu_dereference(*(char __rcu **)file->private_data);
+		copy_len = strscpy(copy, str, len);
+		rcu_read_unlock();
+
+		if (copy_len >= 0)
+			break;
 
-	copy_len = strscpy(copy, str, len);
-	debugfs_file_put(dentry);
-	if (copy_len < 0) {
 		kfree(copy);
-		return copy_len;
+		len = PAGE_SIZE;
 	}
 
-	copy[copy_len] = '\n';
+	debugfs_file_put(dentry);
 
+	copy[copy_len] = '\n';
+	len = copy_len + 1;
 	ret = simple_read_from_buffer(user_buf, count, ppos, copy, len);
 	kfree(copy);
-
 	return ret;
 }
 
-- 
2.43.0

