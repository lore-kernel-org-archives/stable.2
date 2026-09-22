Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35F443C14
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070149; cv=none; b=J/+W6g4sfJ4iCuPfcYM+DwHG9Rju7Aq+w9lhBh6VqMyvxCWVGfpEKFoM2tZryvj8Q425EP+NJ/3mYIbGYdAkAM8b+rzbrSZTXujygtrjHvxGs+h8bUWGuxfnCqUzM05XarLAD9OkhI73bmZsZjBdsMdBXF9mmTbzsZ+vgshY3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070149; c=relaxed/simple;
	bh=/prZ8vgUPLdr/iN+dNER9SVaa4RPoBAU39k5SlBkJ08=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EFfBAaWj07Xbss8KFA3SdhXYNn7bwQj+MKqYl3G5lB8SfIVtig45bPcjITCRRvkgb1pNoR1lcRkZMJChGpF2+lQ0X3DsSBKcVRtjqjEQn4TqS0/dhDd2xqroaoJv61aI98cCt75oYgRwv+KWVa9HOXlvgNm0cbWPjOLz4yCsJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1sJQhP/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1sJQhP/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F5E1F00898;
	Tue, 22 Sep 2026 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070147;
	bh=8z41Xpl8hoAuUtdRYqucayp0in522xrvfYb9S90gKtw=;
	h=Subject:To:Cc:From:Date;
	b=1sJQhP/i4jEZiO+NcleJCAVnQYyLPkrRMjsh/w8vnmltW5xzQd6g9IeS4Lavb15MH
	 N3cSxB+jjbSjacnnk8vKloAPGjyQSDT7VcRf6CtFWE5DvnRjXAhPx6BEgyy/PkfLnS
	 zlk08VsqNh/TmMzYUANNaDX7FD3ZbFVnxVRtwvDg=
Subject: FAILED: patch "[PATCH] btrfs: take commit root semaphore when iterating in" failed to apply to 5.15-stable tree
To: zenghongling@kylinos.cn,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:30:47 +0200
Message-ID: <2026092247-irritably-diabolic-9ca6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0594e3423f4ba3137c734371169491f9a98e9af4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092247-irritably-diabolic-9ca6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

