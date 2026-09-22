Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B934AE115
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070145; cv=none; b=ZL1F5a14sr1s2KFfoyRmoNSTbDrf1rBPPBal+X7UhdDyLDs6guyj7lpdYJrUCB0FJk/DA/LzEiWpYcad6vhzs2mhTKwZ6Zfxyi9jQG2bib/BJw6ReyCIW5HTUhrJPA5wbEuPbRHMIGXvcatEwIYlcKu9J142MIRzK8K07gZ64b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070145; c=relaxed/simple;
	bh=48OvAHwAGjzOvkkwxZ3ip5Th8ViNS0JHJN5TB777bRA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fi8VAkkPClBY5SW1hGyiV7Q4t1UQdVpwaVNAPRXiAQcba6+3gSTPdHLh8aDNZDJSpN0uI7rzhwxnMN7xmlFj353XEIziP/rSm7xxPe19eVAkPZ3VwIHXio9lNxqvpTqV4cVQ7/BBMuj6bprNJLOtXbVcRV7svfjBaTTxXbKS8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZGqhVmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZGqhVmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A0F1F000FF;
	Tue, 22 Sep 2026 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070143;
	bh=jbQGxke2ry3jf38ra5qGCRsjEGRP/ayTLfZwetG860k=;
	h=Subject:To:Cc:From:Date;
	b=BZGqhVmTX6Vlm4x0f/jh4xURPRodRisnSFd4vQeoYIxdqhAbo6myzc8etGmeAgz9F
	 GWBAhD3wQEgPaPgPRFzXz+wwxLellsUhmeiHBdyOABsaW9verH7sUnrodLm+Ma1t00
	 PmpfU92JREEPta2j2mAO3R3unqcbhpfJReQ42bl4=
Subject: FAILED: patch "[PATCH] btrfs: take commit root semaphore when iterating in" failed to apply to 6.6-stable tree
To: zenghongling@kylinos.cn,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:30:46 +0200
Message-ID: <2026092246-stagnant-delete-08e7@gregkh>
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
git cherry-pick -x 0594e3423f4ba3137c734371169491f9a98e9af4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092246-stagnant-delete-08e7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0594e3423f4ba3137c734371169491f9a98e9af4 Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Mon, 31 Aug 2026 13:38:01 +0800
Subject: [PATCH] btrfs: take commit root semaphore when iterating in
 mark_block_group_to_copy()

mark_block_group_to_copy() iterates over the commit root with
skip_locking=true. A concurrent transaction commit can swap and free
the commit root during iteration, causing use-after-free when
accessing extent buffers.

Fix it by using path->need_commit_sem to protect the commit root search.

Fixes: 78ce9fc269af ("btrfs: zoned: mark block groups to copy for device-replace")
CC: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index bf0b78790171..1894c7ebe9d9 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -493,6 +493,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	path->reada = READA_FORWARD;
 	path->search_commit_root = true;
 	path->skip_locking = true;
+	path->need_commit_sem = true;
 
 	key.objectid = src_dev->devid;
 	key.type = BTRFS_DEV_EXTENT_KEY;

