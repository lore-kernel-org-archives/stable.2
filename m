Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB811C5D72
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179017; cv=none; b=lK3IWMWDC5pSUsicBK1PNmu/zH96yKzNlG7vRzw/mWd53RxP4zO7VOCtoz7ucTQUAjFvzvpkOI57ytm9vLqnj5QG2q1pPdKrjyMi+EoZ54nDpfTxRxvCxBsy+T1D05cJ+beo9Ru5N/ECenHAwOUGEYoa52l9rEraXwlvIiWiET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179017; c=relaxed/simple;
	bh=Ma45SFoliEFSKcRb3X3FA5pYtXxWAbAJejBj9LJijWI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B+QALb6D64g9LarXN/GDtxfhtlTAXhpv5l0eXv43ktB1CDzeBncNfXFytNH9BCqB5UeRtN+VcMtpmf6naVXeHtkOzwXnZbNhmbokS80cVwyKTfDm81OLk1sL819IT1JF84s667gGTLTWZivwIr90t1NqYbJs0ApY2wxvB5liDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G6JSsQjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G6JSsQjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567F31F000E9;
	Mon, 31 Aug 2026 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788179015;
	bh=EDKEXgsmrVSzQhDHAzPIhB3t6FyFY7PmZfmxMCtKbEE=;
	h=Subject:To:Cc:From:Date;
	b=G6JSsQjQlssLQEdRwzJD4BG6y2pdf35XKb5AuLZPhKyVRqLXUjf2qr+whNSKLxJHe
	 43JTt7QNoo3e4vf6Ufxi7jCQKc5BDma5o+QWL0UDfvKUoxOcuqevYJRO6ittupQwj1
	 h/pLmWqAaw9O/dGE5scFeToIFg3EKyPIj8OlOmKU=
Subject: FAILED: patch "[PATCH] fuse: fix invalidate lock leak on open O_TRUNC DAX failure" failed to apply to 5.10-stable tree
To: libaokun@linux.alibaba.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:23:32 +0200
Message-ID: <2026083132-accuracy-outgrow-cea0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a927f1867e61b78f39f9da0bbba3c98c2ca151fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083132-accuracy-outgrow-cea0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a927f1867e61b78f39f9da0bbba3c98c2ca151fe Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun@linux.alibaba.com>
Date: Mon, 17 Aug 2026 23:18:01 +0800
Subject: [PATCH] fuse: fix invalidate lock leak on open O_TRUNC DAX failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7b883cf170ac..3f67348d0f7e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -272,7 +272,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
-			goto out_inode_unlock;
+			goto out_unlock;
 	}
 
 	if (is_wb_truncate || dax_truncate)
@@ -296,9 +296,9 @@ static int fuse_open(struct inode *inode, struct file *file)
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
+out_unlock:
 	if (dax_truncate)
 		filemap_invalidate_unlock(inode->i_mapping);
-out_inode_unlock:
 	if (is_wb_truncate || dax_truncate)
 		inode_unlock(inode);
 

