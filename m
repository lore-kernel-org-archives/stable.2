Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064E3F23CF
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997942; cv=none; b=PLNybnuBr3hQfMhZ1w5PTNPqy1QWFw9whLCq11F/lWqVuCKjf0RV2Rq4m1boYstB6hex/5UtoGgWW5NiEMnK0AUksyL3FAnFLxMd7SCUxlgQAdbTXhhNIZmKhWJwSdXh0JEb5jCZ9QxK5SS3lS+NCZdb1Yk6Kvk3+dXAjOrwleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997942; c=relaxed/simple;
	bh=TeJ+RFdoHFnH0dNuqMllf6Nt766eLNZM6RPBPCfBMo8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RyunEUeCFz+ecahgZNSEhyIj/Ak7VCBKR4j20wDNiiTLvwNLVBs/hJ1zLLssWpe786Uz465GbFysWKB36wkGA0bT95zfrleATXCcIOkBHBum/aUPVkzlEVFjl6LYjxHWWEqsBnvcwuygnRReKDafiv/syISR5eyMmBu4KLsu0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jIsrSlBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jIsrSlBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D78B1F000E9;
	Thu,  2 Jul 2026 13:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997940;
	bh=OBH+DuHYJ0eqaN/NwZI6nOUD1BxFh5cp3q0vdGoAxHo=;
	h=Subject:To:Cc:From:Date;
	b=jIsrSlBR/HuYp9oqMy2mikrTXKqwpWbx3PPBvI/wjvTu4pNvoV6FbwK6wm24atQ7v
	 9upcOsOSSoNAG8r7yp+l+iHbaoce9o8uqW6zpexcUNYlAv+v6iwwhj+K5ev0alhLl5
	 BeDi/Nh5/+3KoKH7N64/3hTnVr8m8i7wM2Jzg8OI=
Subject: FAILED: patch "[PATCH] f2fs: fix listxattr handling of corrupted xattr entries" failed to apply to 6.1-stable tree
To: iganschel@gmail.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:12:01 +0200
Message-ID: <2026070201-xerox-struggle-538e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5ef5bc304f23c3fe255d4936472378dcb74d0e94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070201-xerox-struggle-538e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ef5bc304f23c3fe255d4936472378dcb74d0e94 Mon Sep 17 00:00:00 2001
From: Keshav Verma <iganschel@gmail.com>
Date: Mon, 22 Jun 2026 20:44:21 +0530
Subject: [PATCH] f2fs: fix listxattr handling of corrupted xattr entries

Validate the xattr entry before reading its fields in f2fs_listxattr().
Return -EFSCORRUPTED when the entry is outside the valid xattr storage
area instead of returning a successful partial result.

Fixes: 688078e7f36c ("f2fs: fix to avoid memory leakage in f2fs_listxattr")
Cc: stable@kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Keshav Verma <iganschel@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 24cef7e1f56a..ed33e5110f2a 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -583,8 +583,6 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		size_t prefix_len;
 		size_t size;
 
-		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
-
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
 			f2fs_err(F2FS_I_SB(inode), "list inode (%llu) has corrupted xattr",
@@ -594,9 +592,11 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 						ERROR_CORRUPTED_XATTR);
 			fserror_report_file_metadata(inode,
 						-EFSCORRUPTED, GFP_NOFS);
-			break;
+			error = -EFSCORRUPTED;
+			goto cleanup;
 		}
 
+		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
 		if (!prefix)
 			continue;
 

