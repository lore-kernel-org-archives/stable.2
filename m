Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B7426EB9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554911; cv=none; b=r4Nyix7bzAGOQOaFRHfqhVbDsMqzgRlqIcXpoCbIRIA9Ff9yuyezn2s/NFHcDQGCy/BPDomTvq6aAAd8VDhErBHswm6Y/36Rh8FKXGZgfpuuZno/cyJgXaevF1x0pxPYdiXwN7/sG3h08ek96XmgqcaMiVsU8JZl9nDZav7TIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554911; c=relaxed/simple;
	bh=WDGm4Gc7pievfgqnyBt2bJ3i9huKRVBUdfmRDIbrTiQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u7inVv+9FFDn8WCqwHXKoLkFBtUbCt1U7rztS5mgaFVjLf6DLMPmYnu1rQBMK2oMdcwi+umkxsmWd6BF78gfEhEDV6VfC/GzmVlc3BAT9hoeHjmiUEGbNQ9MwppWkRToypusHOc+LD7HCIXD/S4R3aYVcSiHYraX+2rBPfu+0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ER5k4s8i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ER5k4s8i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA941F000E9;
	Mon, 20 Jul 2026 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784554910;
	bh=dFdMeSI2JQHgAlJn1/S+S8ZYhuqCNHi9VVuPksx5VsQ=;
	h=Subject:To:Cc:From:Date;
	b=ER5k4s8ih0J6jBN7nlkHRxiTg87NHDDf1pkdiP6a3U8QPzstQ5Vv3iKLtNfkwcchn
	 UHiotlARd7b/nwJct08+685kb4MgsF1ESDtDETh6w25zbcL7/CFi1btJMaBqiywxnV
	 iAXiKs7FIIkitdriAd36+FXg0ml3+ASWUN26ITbQ=
Subject: FAILED: patch "[PATCH] jbd2: fix integer underflow in" failed to apply to 5.10-stable tree
To: moonafterrain@outlook.com,danisjiang@gmail.com,jack@suse.cz,libaokun@linux.alibaba.com,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 15:41:41 +0200
Message-ID: <2026072041-pork-untapped-b293@gregkh>
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
git cherry-pick -x 289a2ca0c9b7eae74f93fc213b0b971669b8683d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072041-pork-untapped-b293@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 289a2ca0c9b7eae74f93fc213b0b971669b8683d Mon Sep 17 00:00:00 2001
From: Junrui Luo <moonafterrain@outlook.com>
Date: Wed, 13 May 2026 17:28:40 +0800
Subject: [PATCH] jbd2: fix integer underflow in
 jbd2_journal_initialize_fast_commit()

jbd2_journal_initialize_fast_commit() validates journal capacity by
checking (journal->j_last - num_fc_blks < JBD2_MIN_JOURNAL_BLOCKS).
Both j_last and num_fc_blks are unsigned, so when num_fc_blks exceeds
j_last the subtraction wraps to a large value, bypassing the bounds
check.

The resulting underflow corrupts j_last, j_fc_first, and j_free,
leading to journal abort.

Fix by checking num_fc_blks against j_last before the subtraction,
returning -EFSCORRUPTED.

Fixes: 6866d7b3f2bb ("ext4 / jbd2: add fast commit initialization")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: e029c5f27987 ("ext4: make num of fast commit blocks configurable")
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Fixes: e029c5f279872 ("ext4: make num of fast commit blocks configurable")
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/SYBPR01MB7881663C927DE9D7BBF4D1DFAF062@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 4f397fcdb13c..e3b2e38e1a1b 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2263,6 +2263,8 @@ jbd2_journal_initialize_fast_commit(journal_t *journal)
 	unsigned long long num_fc_blks;
 
 	num_fc_blks = jbd2_journal_get_num_fc_blks(sb);
+	if (num_fc_blks > journal->j_last)
+		return -EFSCORRUPTED;
 	if (journal->j_last - num_fc_blks < JBD2_MIN_JOURNAL_BLOCKS)
 		return -ENOSPC;
 

