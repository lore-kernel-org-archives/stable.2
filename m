Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704E4ABBA4
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820638; cv=none; b=oWY3lgu35TfbAjF+XNA4XUjrCyJagg2P8L+yLnXBGBiTxnBfJHZB6o5EGup5wNiQNu6pg1byy7cGreQaGWP2KW5g0FRpYpDP4lmT0XnocyQFoXl5cxqCE/OMYZsj7yaOCPZ1AYRzSvGj7Ca0+11PcVMvmEOmh61BiIwNvbuDbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820638; c=relaxed/simple;
	bh=67frg9OtT7eBqfqw+qvkHeUKAIuGki5oOZaf38P0pL8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OAptHnZ6dQrM0Q6KdhMMJ8ySfUnFhpT6FB0OhAFpQ8N5hxmRJf7Wtuw9MJImXHy/Kl2KpxmivMz12vXcqJY+GeTMb6bXX4JxzzPQyaSmmrpFZ/OgXUU/lU5MCn4itg5r5x4wqEW8qU6EpyAAKdc3902l/ModJQkfpEYLlf8ph1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vMtHbF1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vMtHbF1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9082F1F0089C;
	Mon, 12 Oct 2026 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820637;
	bh=/R+iNOoahi7wv835M6S1GBTjt7aeEUmdn5OoSowU93U=;
	h=Subject:To:Cc:From:Date;
	b=vMtHbF1mPvLkKDcJQ609vzh0+Urivybcky1uiADVyJwTfP8My0ssx0jMZo0AOaR6f
	 k9a3fg+IM6+1bvqkuR2PEM/fjY8H1vPIvHIskbfY7toQUWHrQ2ks6X7dIQXLFuOFuu
	 r9nmFy6sTnDrOii5Z8HQ+ObPQAt2Wawl+LANmC9Q=
Subject: FAILED: patch "[PATCH] fcntl: refuse F_SET_RW_HINT on an immutable inode" failed to apply to 6.12-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:57:22 +0200
Message-ID: <2026101222-human-eradicate-1a07@gregkh>
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
git cherry-pick -x b0d1022b9bdb1e98aa7fb3244fdd50a58c61766c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101222-human-eradicate-1a07@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

