Received: from mail-vs2-f28.google.com (mail-vs2-f28.google.com [74.125.227.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B539CD10
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452745; cv=none; b=OMNBA2PGPpWlYUAIES/PWPnzPJp3zy4KtJkLO4+GM1vC7NJHqCxET12R6gLrtju1Y5hMD0uvKuDkxpMXWNlIIKjO/fpQ6LSlnEzE43CqPk9EtThG22laQV7yNZzJvR0/VevYyZGNwO5BahRZQ3349fEJMqcEQLDUp4XHFDeo7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452745; c=relaxed/simple;
	bh=pJiK7ZtLoIcftmOoWyXhNhrwyq68Wzdhbk2Nfje+Cic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vm2XDuGdlRRPHBFXQAGtQ9StLJ804d9O0Mg2dq+ELCY9UcHu3+52ZIf33153Eyi93uyohQm1GEdnTS1qWB8dtzcHEDoWFrcQE46rlBVpgRRNjmQw41jhcK+srrc7rsUoHNnDV/ytd/XxJlHcem7azC/zlyzMjOxHMs4JwBrMTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYM/QwKe; arc=none smtp.client-ip=74.125.227.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYM/QwKe"
Received: by mail-vs2-f28.google.com with SMTP id 71dfb90a1353d-5c9031e714dso644913e0c.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790452743; x=1791057543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Ww3AExQEh492MzEx3J90ZjmI7uAFZp+mMSUVOyh4tk=;
        b=kYM/QwKeKThz00qYYdTpabmRa5qepywzZOwN5cOY1PIS/9xwp9f3Vd6u07fHdHJd7Z
         eGpwNL94cn0eI2bFflEyubSRo7vtekQgUC+6E9z5hhidqYyWsb7aXL6ff6UNUfv4kWK0
         OemjoCk+WeoDthVjGfUAsALTH7qBsuHiXwdCKqYWOG4kDsbYD3dbQ3XE1qxdoLpr7REZ
         O+6j9/wQ1k0AY44MXS0mQ/aEuSZ0NlB5M7zHMloEGfMWJFUyU7lmD5TMwvnXlbZfKguY
         EfpzuH2DCny60H89YpgRovVZ8sSMlOtJzW6KS+Q+KsGKk4FBfBTOIptzu5f60mRXfkt+
         AA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790452743; x=1791057543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Ww3AExQEh492MzEx3J90ZjmI7uAFZp+mMSUVOyh4tk=;
        b=bEsuqgf0D4hgiHysjfBiXsx+STrJKz17GMpdCd+p7wQV6ruURPaHdGdN+RWi1hvqpd
         VPRfhNnvFse8FvroDR4cQ3lC09d+wmpGC+d0Jz5b248wn+ofW+xXtKx3iuXsqLUybYwj
         4L2Mc090VQmC3ry6ess3EnYkKwjbJrzSKQNACFRSwhqHCepmnazPbJfO2sJ3uDtwtIpn
         CccQOoST4uB4G1iwWxYQXv2mk96xFOjW7BW1mctgvCVUSahXfIhMBDko/k9fmc6cwZOT
         Xa2Dq5Gft4Ig+tcPW5sJMpmAli5UHLRzeuCwjny++wYB07qtEVDYQ1smZMidyLR4fQvN
         DY/g==
X-Forwarded-Encrypted: i=1; AKwUvBzDSFECy66ad+3WqZo45UYaAh4gC9abTAzhfb4oYS8WOr/POF6IHtCJDcYLRXT76r/VhHuYFeU=@vger.kernel.org
X-Gm-Message-State: AFuF++nMg6Awguq+gAfVWmdK1jt7OLelMfpCZ0ttwGUaOqC1Ip8zynAz
	m34QMxqEJHI8gHR+f8VOMOXC79tvI/ip0vZrpCh6KO8srzLIiOcs3BNr
X-Gm-Gg: AYBFou1cwHUwhcjhdffbBAu67qhBCL5hFUF0fUHrPdfog2IGSvRTtKc3zoQmpZumYt2
	qJ2cQjS7GwdOLENYTTY0eExWuN9C7pqfQgRzRvhYgTcc8/oR0mLscp6nuZyqhEuK80+Geyf7lFF
	g1NM+pufwokkYJAD08ynclhNPOeGSuIQ7A/6acYfMytNH9lQCZUqeKEL/GTLH8Sa/QC26sTKu1G
	9y37vkkRvfPzerHBZYtUS2Inq/W72FpVNJt1onVvTyB4NP9rE8zBdl/QH4rifCtw4aI2E9CN81T
	ATq+vBRtvuUdPNKz0iy/AFw2wgh3ij0PCiwvGDdDyOJNp2PpYTWOPleLx6Y37ravRaagc9Nm8Mz
	PSqhKQhPTFUtOsSU/my/F9Sex960yIhBaTO9+zBHTW0six2wSxmvrzer9Whpl+qujvXIXwR4sNm
	HLOTA5oXNkdF+CjxKmujTFlUWfmw/XSMzD/rqVVyu5/in2ji8zAZlv3wI+OncSkCE=
X-Received: by 2002:a05:6102:8098:b0:7a7:1db6:c769 with SMTP id ada2fe7eead31-7b1c751f1e3mr1477646137.22.1790452743026;
        Sat, 26 Sep 2026 12:59:03 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861afedba5sm7437742241.8.2026.09.26.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:59:02 -0700 (PDT)
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
Subject: [PATCH v4 2/2] debugfs: serialize concurrent writers in debugfs_write_file_str()
Date: Sat, 26 Sep 2026 16:58:44 -0300
Message-ID: <20260926195844.1296333-3-qwe.aldo@gmail.com>
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

debugfs_write_file_str() reads the current string pointer into `old`,
builds a replacement, publishes it with rcu_assign_pointer(), then frees
`old` after synchronize_rcu().  There is no mutual exclusion between
concurrent writers through the same inode: two simultaneous calls can
both load the same `old` pointer before either publishes a replacement,
and when both later call kfree(old), the result is a double-free.

Serialize writers with inode_lock().  Use rcu_dereference_protected() to
load `old` under the held lock, satisfying lockdep annotation.  Release
the lock before synchronize_rcu() + kfree() so RCU readers are not
stalled during the grace period.

Tested on QEMU/KVM (7.3.0-rc4 + KASAN).  A reproducer that spawns
concurrent write() calls on a debugfs string file triggers the
double-free reliably (~3900 KASAN reports in a single run):

  BUG: KASAN: double-free in debugfs_write_file_str+0x194/0x200
  Free of addr ffff888104542ec0 by task poc/305

  Call Trace:
   kasan_report_invalid_free+0xb8/0xe0
   check_slab_allocation+0xd9/0x100
   kfree+0x163/0x510
   debugfs_write_file_str+0x194/0x200
   vfs_write+0x1ed/0x920
   ksys_write+0xe5/0x1a0

  Allocated by task 307:
   __kmalloc_noprof+0x264/0x680
   debugfs_write_file_str+0x106/0x200

  Freed by task 306:
   kfree+0x2e5/0x510
   debugfs_write_file_str+0x194/0x200

Cc: stable@vger.kernel.org
Assisted-by: sashiko.dev <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/debugfs/file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index f9a1f7739..7a9d33772 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1072,40 +1072,44 @@ static ssize_t debugfs_write_file_str(struct file *file, const char __user *user
 	if (unlikely(r))
 		return r;
 
-	old = *(char **)file->private_data;
+	inode_lock(file_inode(file));
+	old = rcu_dereference_protected(*(char __rcu **)file->private_data,
+					lockdep_is_held(&file_inode(file)->i_rwsem));
 
 	/* only allow strict concatenation */
 	r = -EINVAL;
 	if (pos && pos != strlen(old))
-		goto error;
+		goto unlock;
 
 	r = -E2BIG;
 	if (pos + count + 1 > PAGE_SIZE)
-		goto error;
+		goto unlock;
 
 	r = -ENOMEM;
 	new = kmalloc(pos + count + 1, GFP_KERNEL);
 	if (!new)
-		goto error;
+		goto unlock;
 
 	if (pos)
 		memcpy(new, old, pos);
 
 	r = -EFAULT;
 	if (copy_from_user(new + pos, user_buf, count))
-		goto error;
+		goto unlock;
 
 	new[pos + count] = '\0';
 	strim(new);
 
 	rcu_assign_pointer(*(char __rcu **)file->private_data, new);
+	inode_unlock(file_inode(file));
 	synchronize_rcu();
 	kfree(old);
 
 	debugfs_file_put(dentry);
 	return count;
 
-error:
+unlock:
+	inode_unlock(file_inode(file));
 	kfree(new);
 	debugfs_file_put(dentry);
 	return r;
-- 
2.43.0

