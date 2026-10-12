Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D64A4EF7
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820657; cv=none; b=OuhH+ZNpNiDAkaesXzZLPak09YjbSkNWhUugbjzOY5JbqKy65deQdSR5juKD/xWpod7K6Mz9tsGRYvSEfCLXdyEyq/H/rbV8Qg3jQV990v9y507IzqdfKz2xqev6RoTGuysEA3Af3rsQpA2uSDw2oIRvQAg8XIBW004tgkgtUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820657; c=relaxed/simple;
	bh=Y+P2iucTqOjFOht2J1s9LWAnCp5XzuOe0RiILuWqgsY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LJVGUD970x5rcMB5f0OvjNyHmrnOp5jFH7hPsZzcMnx+s/eeZHDAfD0F85zJd6jtjBtHYnWD5UdKNpPF7kkFI1c5sEErUXw7vMRjSbBGBnngVvZdO1BFxf/iHneeHr6xg0lMnHE4LHvWhWaw48hhNECJaSeUHyUsZodLhvgZxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uKd8YJQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uKd8YJQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD6B1F0089C;
	Mon, 12 Oct 2026 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820655;
	bh=S0/Q1I6iD67RKy/D+OYM/sUi4NTNPX3u5N1zDk5fUQM=;
	h=Subject:To:Cc:From:Date;
	b=uKd8YJQ/K+kX5CYgpW0STwnVYEpjuTrUDgiVi96NHEG1wcSAPLhiKltCazjXNNEol
	 QpUjSevn1evxI3V4cXW/60hU9T/XkStyCRuOmzPjSXcLKqhBtcIHBMKr/sxaswCi2t
	 mZ3uIsGWC0HCCQWLyLFEbGJvdUc6jYqqnROwfSUs=
Subject: FAILED: patch "[PATCH] fcntl: refuse F_SET_RW_HINT on an immutable inode" failed to apply to 5.10-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:57:25 +0200
Message-ID: <2026101225-umbrella-overlabor-1e8a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b0d1022b9bdb1e98aa7fb3244fdd50a58c61766c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101225-umbrella-overlabor-1e8a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

