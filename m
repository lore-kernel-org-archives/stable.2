Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B85476D9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954147; cv=none; b=hfhuQ/R7qUrNx6cS+Of2pvD/9czd3025lT4AkkQSt/yj3SLrXK7JTQc35d9iYIWJeWMwyGJSNkdWlHp5tluGeO+Es2hg3nVjlk2XpdtU7kkqqPVNbZt48cN8IPiwijTheL80EHfeFFRxLzRHTxA8ts/DjoHhp3iO97GwHSf8wXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954147; c=relaxed/simple;
	bh=LOg/1bv3KPEh9gB+JXuKQNZJNsSMIHNOdCFgq+O/ft0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eNOxkHjIh9xIZDi3n6TjC4/Y4GWQoVqdgycmTbIpYiOX4Hp8R53hI0/dMbsWmM/CmCLxiF1gPM2rGG4Jtq4zaCWLxm0UoSc8qTWa5Q+yyaMC1RlMenrllyYdxKvJwT4CsMw114KRjdXcNxv6SpA2S26otTyw4A0uVEpUxOFDk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4D/zA/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4D/zA/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFA71F00A3A;
	Wed,  9 Sep 2026 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954145;
	bh=z+e9+zw/mqVWX2Mf4ev9KsuRWWW2mmJZCaAjav7Nlsw=;
	h=Subject:To:Cc:From:Date;
	b=J4D/zA/xnJHi/qdbiHtguNVFhAUMQWeVTYbmtq90F0OOzonOtRq80y0qPyLb3oFkW
	 /rzf4oMMbuflR16sMrY/7UPiuyhsmUY+P4DBtzTx7tA0iwxLDVi3NJDqNeQyPLQZ68
	 uB8q7Vy2+IsdkV2F71y3YSCMtguxvorY+UIv24TI=
Subject: FAILED: patch "[PATCH] f2fs: validate MOVE_RANGE destination size" failed to apply to 6.12-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:24:31 +0200
Message-ID: <2026090931-net-monotone-74ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e533889fc26aea0cd83c90327063f272061dd820
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090931-net-monotone-74ea@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e533889fc26aea0cd83c90327063f272061dd820 Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 30 Jun 2026 11:17:00 +0800
Subject: [PATCH] f2fs: validate MOVE_RANGE destination size

F2FS_IOC_MOVE_RANGE checks the source range, but not the destination end
before updating i_size. A source hole can expose this: __clone_blkaddrs()
skips NULL_ADDR entries and returns success, so the caller can still extend
the destination inode with unchecked pos_out + len.

Reject destination overflow and use inode_newsize_ok() before extending
the destination inode.

Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
Cc: stable@kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c54897a25981..170c485eafaa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3127,8 +3127,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	struct inode *dst = file_inode(file_out);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(src);
 	struct f2fs_lock_context lc;
-	size_t olen = len, dst_max_i_size = 0;
-	size_t dst_osize;
+	size_t olen = len;
+	loff_t dst_max_i_size = 0;
+	loff_t dst_osize, dst_end;
 	int ret;
 
 	if (file_in->f_path.mnt != file_out->f_path.mnt ||
@@ -3185,8 +3186,15 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	dst_osize = dst->i_size;
-	if (pos_out + olen > dst->i_size)
-		dst_max_i_size = pos_out + olen;
+	if (olen > LLONG_MAX - pos_out)
+		goto out_unlock;
+	dst_end = pos_out + olen;
+	if (dst_end > dst->i_size) {
+		ret = inode_newsize_ok(dst, dst_end);
+		if (ret)
+			goto out_unlock;
+		dst_max_i_size = dst_end;
+	}
 
 	/* verify the end result is block aligned */
 	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE) ||

