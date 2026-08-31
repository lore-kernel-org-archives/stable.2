Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFBD369D7A
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199219; cv=none; b=roO18JH438EqnQ2YSxA0k0BN3OGryv17GP3HcP+Ui+lpR6asfclqDD6lkTHaJiGpjmNnHhJGsm0xHsveo6V4Rd/t0BtBeQ/LWHigFvk5efzxWUUdbfulTYh5To209CPjKrD5Oom7FrXe5MDYpBZv1T1Q+PqfFQsmPX43vyMKbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199219; c=relaxed/simple;
	bh=TYCCfwU9qoL5plDOYBtMHs7ovo5ggSgW7Eiiy8HPVJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VetRRua69WqPIPPF6GwyjPRsTAmPLRxtJFDv3V0z8Fnj3d2ZgMAXkV/QiaMYCCWCfzPww2cWANPMQqeHnTmUU0rbAjcKJyINJH7b1TJESD2r7G50+ZFf7oUbXHefMF2lY3UotQClkmKc8Rbi4c1p/2QUTgjmqBoYwF0EDnj9XA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMHxgWp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMHxgWp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC381F000E9;
	Mon, 31 Aug 2026 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199217;
	bh=9QsrOz0dByIOVwDo0wHvaUoBWQoUKf/JKw8bYGQRsaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OMHxgWp2uuaqOnpQaPgth1rzEtXmwDi2c+toaNZ0TMawAwMh6YpMlJocCcC0XsFIe
	 EtbkUR0Y2zyn6302X77huJxivfuhMigEsZrFjm3d9GV4tuUkuMeH8vZtd9D+PwtRE5
	 7m9tux8JVY4VusgkaXSBg9LQgTd62H7+1wz8tCIEN1+C766EnqfqePBXuBl7e5f0Fz
	 wPPyJ86036cC5bw/RbNw9ojzydNho+qqWh0/y9ykOnybdi2qjSSHcVjMaFH4Y8zJxj
	 G2kuDB3YeJBaRLvsVjPCKQuygF5YZA9afli97hboXcgMbqOSQbM3l14zR4Sp/Yhe2M
	 cQh6ajTlAIXVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fuse: fix invalidate lock leak on open O_TRUNC DAX failure
Date: Mon, 31 Aug 2026 14:00:15 -0400
Message-ID: <20260831180015.1630532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083132-accuracy-outgrow-cea0@gregkh>
References: <2026083132-accuracy-outgrow-cea0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun@linux.alibaba.com>

[ Upstream commit a927f1867e61b78f39f9da0bbba3c98c2ca151fe ]

fuse_open() takes filemap_invalidate_lock() for a DAX truncate
(dax_truncate = true) and releases it before the out_inode_unlock
label.  But when fuse_dax_break_layouts() fails, the goto
out_inode_unlock skips the unlock and leaks the rwsem, so any later
fault or truncate on the file stalls on the stale lock.

fuse_dax_break_layouts() can fail with -ERESTARTSYS when a signal
interrupts the wait for busy DAX pages to drain:

  open("file", O_RDWR | O_TRUNC)
  └─ fuse_open()
     ├─ filemap_invalidate_lock()        # dax_truncate
     └─ fuse_dax_break_layouts()
        └─ dax_break_layout()
           └─ wait_page_idle()           # TASK_INTERRUPTIBLE
              └─ fuse_wait_dax_page()    # unlock, schedule, re-lock
                 └─ signal → -ERESTARTSYS
     goto out_inode_unlock               # <- lock leaked

Fix this by moving filemap_invalidate_unlock() below the label so
that all error paths release the lock, and rename the label to
out_unlock as it now covers more than just the inode lock.

Fixes: 2fdbb8dd0155 ("fuse: fix deadlock between atomic O_TRUNC and page invalidation")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ changed goto target from out_inode_unlock to out_unlock and relocated the out_unlock label before up_write() on i_mmap_sem, adapting the fix from filemap_invalidate_lock/unlock and fuse_open() to 5.10's i_mmap_sem/down_write/up_write and fuse_open_common() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a8c080b485d03..a8678753b2d33 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -239,7 +239,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 		down_write(&get_fuse_inode(inode)->i_mmap_sem);
 		err = fuse_dax_break_layouts(inode, 0, 0);
 		if (err)
-			goto out_inode_unlock;
+			goto out_unlock;
 	}
 
 	if (is_wb_truncate || dax_truncate)
@@ -259,10 +259,9 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
+out_unlock:
 	if (dax_truncate)
 		up_write(&get_fuse_inode(inode)->i_mmap_sem);
-
-out_inode_unlock:
 	if (is_wb_truncate || dax_truncate)
 		inode_unlock(inode);
 
-- 
2.53.0

