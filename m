Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A347CC74
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445468; cv=none; b=Ja5suG5cEuzj8hI4w/jCudrTby0eF0TVVtFmmMGMiyHsnbgHJrKATzkoiZVSIYPF80OSERBytxJfnD1xpBHPhZxJrgodKPk9D+dSXvKCZtIJNSd2suho4Lk1ZkW1BzfnVhf7meRNPvz2AUdCmJIn+oFL90SYUvkN7zw8cTVr1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445468; c=relaxed/simple;
	bh=sDnTqvm+PxdaTPLFJ5qTKwNhD1joXPt5N3myf5i7xoo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L/xnnaNxUYEUTUfhHcoQrCflIast47fVZpetg0BPMa/7HIPqUnxxoavKicakgLYlPs2YuZKJEZhnME1NBJaOc9exijaCnleklM3QsmTqDsrgMpYVBmUQ/6GfpE2YRX8de18EmpzHGX+4DM8Bs/oQGpoZG6vyvRk/yDvbQBDPPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FWr62/sS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FWr62/sS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A14F1F000E9;
	Thu,  3 Sep 2026 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445461;
	bh=kFv5kpiBPKkGf+X585Yx90Tdfxc/d3Ma0VJ2cdyqFMg=;
	h=Subject:To:Cc:From:Date;
	b=FWr62/sSUm2CbI7EWXrouRwRRkVNY7dhtTT06EhCVUzT6SkDkAkF0hA2H4EGhx4fh
	 DJ3tWUoKHxfMCsAUyXE3FsR7Ja13/edbwDqcf/gJsw/DRy/vaJASnaQB3e6Djnedry
	 F8W4fEWlMxOYh2HnWTej84Dv8g1Kcb27eAgm0kz4=
Subject: FAILED: patch "[PATCH] jbd2: check need_resched() when skipping busy checkpoint" failed to apply to 6.1-stable tree
To: max.kellermann@ionos.com,jack@suse.cz,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:59:37 +0200
Message-ID: <2026090337-idiocy-unfocused-cf1f@gregkh>
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
git cherry-pick -x f213e12ff5c9590b1034ae8da0e6d09665c772d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090337-idiocy-unfocused-cf1f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f213e12ff5c9590b1034ae8da0e6d09665c772d0 Mon Sep 17 00:00:00 2001
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 13 Jul 2026 12:22:28 +0200
Subject: [PATCH] jbd2: check need_resched() when skipping busy checkpoint
 buffers

journal_shrink_one_cp_list() skips busy checkpoint buffers when called
with JBD2_SHRINK_BUSY_SKIP.  The continue statement on this path also
skips the need_resched() check at the end of the loop body.

Consequently, when a checkpoint list contains mostly busy buffers, the
shrinker can walk the entire list while holding journal->j_list_lock,
even when a reschedule has been requested.  Large checkpoint lists under
memory pressure can therefore cause long lock hold times and leave other
CPUs spinning on j_list_lock, resulting in soft lockups or RCU stalls.

Route the busy-buffer path through the need_resched() check so that the
shrinker can release j_list_lock and reschedule promptly, restoring
parity with the clean-buffer path, which already checks need_resched().
This does not change which checkpoint buffers are eligible for removal.

Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260713102229.1598812-2-max.kellermann@ionos.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 1508e2f54462..5266017565ac 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -389,7 +389,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 			ret = jbd2_journal_try_remove_checkpoint(jh);
 			if (ret < 0) {
 				if (type == JBD2_SHRINK_BUSY_SKIP)
-					continue;
+					goto next;
 				break;
 			}
 		}
@@ -400,6 +400,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 			break;
 		}
 
+next:
 		if (need_resched())
 			break;
 	} while (jh != last_jh);

