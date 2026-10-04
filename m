Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024339F16B
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135546; cv=none; b=Zjpc13xPr1SeI5C1kyTt4TjSbOCoMlEtBR8kB/wtvTwRavCsbJH1u4nqjSLIiCF2fWAtAh2vSXk4yI0juIi5+fEdrljDSz5qbR4Wn3ibshJgd98wVyHMMuMNJVc9ONj9ZDXNFUrqD3BAse48AFq19tsXscsom5Rk0qireDzKHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135546; c=relaxed/simple;
	bh=+VNfsMK96Xcv9FRbn0fqWwjBWZ1jbumT5jLl3yrmdYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiFxJPbA5kXj+gUJMi24ylp0OQu9UcWMJJLnjApLesXKMuwJNQpSv4xHvYp82hJd53sSPEsKVJACJCdkh+T25iFSqFlh0ZxmjJS6u3I0hmeh5yQv9ISyOW0wz2Jpd7ijGC26b0u69W36/pKDkKK87Vq1PYWIquSzBtcwiY4C95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDUq4evX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDUq4evX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDA31F00893;
	Sun,  4 Oct 2026 17:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135545;
	bh=VbIX2FBU8ElTmA0ZoIOeSKq3qO3y+REc9lIXx6cTvkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDUq4evXSPLXM54CIqDIAZS3adFnki0ovxSybfx8oMdUo9zjVOJoJHU0riloYUEsh
	 69oC2yW5eoCanRkmq5bxXBhjqy2vXSQ9Uy1bRSnSsGgEFBAEH6n7n+JQ/lBR3H2/Ln
	 8Hcvth8oDF89nzqhqcbQyalw2KYrAxljrunv/ZcP/qO1LDpohUouXKNaOOE2LQ05f+
	 nr7sTXrb+MCnqAw+8cs2v7JAlpFxt6MylM7jJRp8/P6RLcTzj56DPjtr2z/eHslLzz
	 wJJCYnh8Y/Pw45NBvsdLQnQQV5HuNxIomHpZMSFHe42jaGN7MyBYrMgITgS/H00lA+
	 X1G03HxtU7U2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] tty/vt: use guard()s
Date: Sun,  4 Oct 2026 13:38:58 -0400
Message-ID: <20261004173840.989210-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004173840.989210-1-sashal@kernel.org>
References: <2026100453-thorn-hurricane-763b@gregkh>
 <20261004173840.989210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit e730c373b6ff16a177e132859bf6ea4dbb15105f ]

Having all the new guards, use them in the vt code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

A local free_page_ptr __free guard is introduced for
__get_free_page/free_page (with proper casts). This could be made public
in include/. But I am not sure if there are more possible users, so
keeping completely private here.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250814072456.182853-16-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Use scope-based console locking and buffer cleanup in vcs_write() so
error paths can return directly while releasing both resources.

Limit the conversion to the function needed by the follow-up console
pointer reload fix. Omit the other guard conversions, including the
selection changes whose context assumes bracketed-paste support.

Allocate the page-sized copy buffer with kmalloc() and reuse the existing
kfree cleanup guard instead of introducing a new cleanup helper. Declare
the buffer before the console guard so the console is unlocked before
the buffer is freed, preserving the original cleanup order.

[ sashal: REDUCED BACKPORT of e730c373b6ff: carries 29/414 upstream
  changed lines; not carried:
  drivers/tty/vt/consolemap.c:con_set_trans_old(),
  drivers/tty/vt/consolemap.c:con_get_trans_old(),
  drivers/tty/vt/consolemap.c:con_set_trans_new(),
  drivers/tty/vt/consolemap.c:con_get_trans_new(),
  drivers/tty/vt/consolemap.c:con_clear_unimap(),
  drivers/tty/vt/selection.c:sel_loadlut(),
  drivers/tty/vt/selection.c:set_selection_kernel(),
  drivers/tty/vt/selection.c:paste_selection(), +28 more ]

Stable-dep-of: 226bd5603371 ("vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 2536635153552..a59d2006b1a99 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -591,7 +591,6 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = file_inode(file);
 	struct vc_data *vc;
-	char *con_buf;
 	u16 *org0, *org;
 	unsigned int written;
 	int size;
@@ -602,7 +601,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (use_unicode(inode))
 		return -EOPNOTSUPP;
 
-	con_buf = (char *) __get_free_page(GFP_KERNEL);
+	char *con_buf __free(kfree) = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!con_buf)
 		return -ENOMEM;
 
@@ -611,22 +610,18 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	/* Select the proper current console and verify
 	 * sanity of the situation under the console lock.
 	 */
-	console_lock();
+	guard(console_lock)();
 
 	attr = use_attributes(inode);
-	ret = -ENXIO;
 	vc = vcs_vc(inode, &viewed);
 	if (!vc)
-		goto unlock_out;
+		return -ENXIO;
 
 	size = vcs_size(vc, attr, false);
-	if (size < 0) {
-		ret = size;
-		goto unlock_out;
-	}
-	ret = -EINVAL;
+	if (size < 0)
+		return size;
 	if (pos < 0 || pos > size)
-		goto unlock_out;
+		return -EINVAL;
 	if (count > size - pos)
 		count = size - pos;
 	written = 0;
@@ -651,8 +646,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 				 */
 				if (written)
 					break;
-				ret = -EFAULT;
-				goto unlock_out;
+				return -EFAULT;
 			}
 		}
 
@@ -664,15 +658,13 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		if (!vc) {
 			if (written)
 				break;
-			ret = -ENXIO;
-			goto unlock_out;
+			return -ENXIO;
 		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
 				break;
-			ret = size;
-			goto unlock_out;
+			return size;
 		}
 		if (pos >= size)
 			break;
@@ -702,9 +694,6 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (written && vc)
 		vcs_scr_updated(vc);
 
-unlock_out:
-	console_unlock();
-	free_page((unsigned long) con_buf);
 	return ret;
 }
 
-- 
2.53.0

