Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D193A4F55
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044132; cv=none; b=UH5QU7WounGFqqued8C1nAnciZfpSw47G0IPM+tN1k3Is2rTv4r0PTJ01z8B7EaOpcr6tUGA2kDiISRFtuUm4iv1IWxVsGBXYMM0JotTiIdID4LI40OR590fpGiTKVfT/r0jjgmAzsKwZN4I6rT8wfF8CPGtqPhEhd1nRw/Bstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044132; c=relaxed/simple;
	bh=6+gA7DOVrWMGCMks2RS6ZY3ZHhn3JZ+DlXDkdLRuY44=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hZQjoF4ZTmiBzwM9KraW6eq/sgh//1CpaRP7xUwGzyhcmvAPIeiqfNtDcvqEitSHnOyb4xuK9Fslt+q9v81KLP0Q6CJJFMKp6lPe1xCzqwDvCr2LY9O4OXf+YLEFkDXzpLYIalxUeCYOFDm5U9fdZAK2znfieKh0BTAvcJiKisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=13ZJAsxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="13ZJAsxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B9C1F000E9;
	Tue, 14 Jul 2026 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044131;
	bh=z6evEWmb5nfaXaIaOvqUrWTAk8mTQLCZAAYgO12Zdp0=;
	h=Subject:To:Cc:From:Date;
	b=13ZJAsxqA72P69UJTPmMMjZo4C9hP3N8vyJZwLGuJ9IwfVc2Yn7Rqw4Qbyq8L1wAw
	 ytW37c95v0VTNTkxtgrC55BaAIyricptAICqNSRum4vNZzNxiF/RmRvDiJ1Eca/XeJ
	 SGUA7xX1IIFDWAUIn6IshFoYyqVlwzCxx+WJT7l0=
Subject: FAILED: patch "[PATCH] hfs/hfsplus: fix u32 overflow in" failed to apply to 5.10-stable tree
To: tristan@talencesecurity.com,slava@dubeyko.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:48:28 +0200
Message-ID: <2026071428-shoplift-askew-e8dc@gregkh>
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
git cherry-pick -x 966cb76fb2857a4242cab6ea2ea17acf818a3da7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071428-shoplift-askew-e8dc@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 966cb76fb2857a4242cab6ea2ea17acf818a3da7 Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Tue, 5 May 2026 11:12:58 +0000
Subject: [PATCH] hfs/hfsplus: fix u32 overflow in
 check_and_correct_requested_length

check_and_correct_requested_length() compares (off + len) against
node_size using u32 arithmetic.  When the caller passes a large len
value (e.g. from an underflowed subtraction in hfs_brec_remove()),
off + len can wrap past 2^32 and produce a small result, causing the
bounds check to pass when it should fail.

For example, with off=14 and len=0xFFFFFFF2 (underflowed from
data_off - keyoffset - size in hfs_brec_remove), off + len wraps to 6,
which is less than a typical node_size of 512, so the check passes and
the subsequent memmove reads ~4GB past the node buffer.

Fix this by widening the addition to u64 before comparing against
node_size.  This prevents the u32 wrap while keeping the logic
straightforward.

Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6df204b70bf3261691c5
Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e76bf3d19b85350571ac
Tested-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20260505111300.3592757-2-tristmd@gmail.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index b0165de7640d..3a8a3878d7b0 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3545b8dbf11c..0e4268de9e60 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -600,7 +600,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "

