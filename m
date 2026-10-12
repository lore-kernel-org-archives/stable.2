Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD994A9D59
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820647; cv=none; b=ZVOjt1/PguVux84DYI0GRHUAWnPBgir//wIIegM7bxSfrLAwMw34wHeCV1dDJp/TKN0I93TW+DfRbo05JhAqFRCaOswPZFCh3BnPhZ74lZ+LMhv+GGcxQTI1gadYlI+PrebWFzFVXdLporA2dhBFb4pGFAs6k/FaNm0AX03Vy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820647; c=relaxed/simple;
	bh=ns2xSP9IfEbazOdEKxm9hl/t9EVjCjHU1qY/uIZK2/U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uEo8QCOJTlCgtpQhqc057NjF4iJNVV1bXK+4dc7dSF3OhOlo751bpbHY3Oz2MVPgmEtI3IhOq/RlozGbrhbeLs3SH0nGg7qRksnlOZPh1yu7FFGvcg1Umn5ahEYMLhtEI2uiB3spV5sgU+hqRtNlfwzqS+ohxdVV7siIdzSG5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=17ZB4cYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="17ZB4cYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924881F0089B;
	Mon, 12 Oct 2026 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820646;
	bh=0ma4bLkOc3NNdCx/dskv/gMusTIKMfuM1bzH/3/8O/8=;
	h=Subject:To:Cc:From:Date;
	b=17ZB4cYsYDuEhHVqxriFlLJ+ZdwUEwmjBLnHvdirqt+MQ+0F6zVl0HSO8/IZIyRsn
	 l4Mj3ZxpdPrPyNE+SMmXNKqQ6xP5k8lU3SXvA7bRoNwsLW3lypnmPsjNyZRnm3TQMS
	 jOg7A8V3O27y0YonW8o/XC4Kyq/xEEYDbwcqR03c=
Subject: FAILED: patch "[PATCH] fcntl: refuse F_SET_RW_HINT on an immutable inode" failed to apply to 6.6-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:57:23 +0200
Message-ID: <2026101223-sprinkled-coming-7d84@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b0d1022b9bdb1e98aa7fb3244fdd50a58c61766c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101223-sprinkled-coming-7d84@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b0d1022b9bdb1e98aa7fb3244fdd50a58c61766c Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 2 Oct 2026 15:52:34 +0200
Subject: [PATCH] fcntl: refuse F_SET_RW_HINT on an immutable inode

An immutable inode is never written to so write hints are pointless.
Refuse the hint on an immutable inode the way setattr(), fallocate() and
etxattr() refuse their changes.

Fixes: c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261002-work-mount-fixes-4-v1-3-dd44b89d44ce@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c158f082f1da..9b71bc9d71d1 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -372,6 +372,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned long arg)
 	u64 __user *argp = (u64 __user *)arg;
 	u64 hint;
 
+	/* nothing is ever written to it */
+	if (IS_IMMUTABLE(inode))
+		return -EPERM;
 	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EPERM;
 

