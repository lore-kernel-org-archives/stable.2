Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC444B5CC7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445471; cv=none; b=DhZdDSsc6uTdZDP9d/UMMOmrE85FDcM+YcxnxdiNzpfeDqJZNSLtl9YeClVmVTB/CUNb4YTjbv19xM0z4n83Gfkg4sUvT/3YXccGOtDfdgOAfw+9JojJX9F7iegOpAl+QpuY8W6zmS6emai9JT27AqwbQVdrF52r0GocufF6b6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445471; c=relaxed/simple;
	bh=x8Sr5IAC+scGNA77Sp4aXL+gSTQY/kfLxRlbdZdNiJA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B7hqhM7ckmdYvXnnTK2TzHnoNqr0E5ltNBoAJiQsLYHG3gr/BWlSmushWw9zUDRNAZ3cEy235IXcZ7rEhr+C1w6OZfhHp492qJecSJHJ3C//5pvK41ODW14oB9NtqzEVEiygjlhfJeBxT1QQY4+kVK4shfv/aeypvXNHcvtc7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgtIzgDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgtIzgDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9BD1F00A3A;
	Thu,  3 Sep 2026 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445458;
	bh=Vpakw36MmdpUUwuUXRLVaPvKiVTBZUxPrhapv1p0sv8=;
	h=Subject:To:Cc:From:Date;
	b=SgtIzgDOt2UH49TJZPol+qjWIqKDqlQRqTV+SyNBAc7TdRuhy8psTqp3eSHQMcUjs
	 1qV9ex4IKvkeARCFgIIbm2mcAj/uf8L9hs6Vu0VGY9xdkEbHnCeN+rT+re9haxqTYK
	 BY+a6nrK7PYST6FcOWLnYQwvDRspVzq3oUjgKU+U=
Subject: FAILED: patch "[PATCH] jbd2: check need_resched() when skipping busy checkpoint" failed to apply to 5.15-stable tree
To: max.kellermann@ionos.com,jack@suse.cz,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:59:37 +0200
Message-ID: <2026090337-absolve-bonnet-5b19@gregkh>
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
git cherry-pick -x f213e12ff5c9590b1034ae8da0e6d09665c772d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090337-absolve-bonnet-5b19@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

