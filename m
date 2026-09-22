Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35803369D56
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070138; cv=none; b=pWw2d4v7HUePW7KCK8/hiL5b+pwNclL22O66RaUvsmEEdEsfAq2idIZ7lHOZEvoLGCtdxmmEEMR1rXukEUn8c/BbM+MPFJOcrLZdKHwMSRyYs5JNBs1bYYBJo7JWDKp+TmOcZjCkm5dv8euqbRIr48J2R/jeNQGmqLfi50YifGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070138; c=relaxed/simple;
	bh=HUomVh1VSx3IowmWyIJyxAF0EglVuINOCq0v3FoSJ2s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E9S8Ak+YrsOPXbBxzsMPWxfSSg8W2G/2jecf5Yoxr5yvpk3HibqUCFM9egbPLU0AIh8z8PflT0bcUTImvOWgco2YfnaB0XU0j+FyDhozYIooRnoDZ8rsVKv8p8uA2J8w+gTUe1GwZJOxo7G7plwcqI7p4jomUmmaoU9lT1KYsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CaABdJcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CaABdJcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DEB1F00893;
	Tue, 22 Sep 2026 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070137;
	bh=ioCytmk37zoXbginLjiwHUVZHg+INZ55HpN384av1iY=;
	h=Subject:To:Cc:From:Date;
	b=CaABdJccrJglXQzmIiq152JTtN7rFftdDbqdbQrhAULNRSskDqC7qZJ8ml2x2ncUY
	 6Va/ouYFjKVWoF9X3upcIrhjWiX/aHCLzfCRu/pXbbvz4w3H/sYiLTmpuqA7h6DmED
	 XmBn+mrULTaoewXQdgpcT1gwBgWE/8xecsvYtuTQ=
Subject: FAILED: patch "[PATCH] btrfs: take commit root semaphore when iterating in" failed to apply to 6.12-stable tree
To: zenghongling@kylinos.cn,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:30:45 +0200
Message-ID: <2026092245-unlovely-antarctic-7c00@gregkh>
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
git cherry-pick -x 0594e3423f4ba3137c734371169491f9a98e9af4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092245-unlovely-antarctic-7c00@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

