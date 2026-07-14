Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2943B4A6
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044130; cv=none; b=NY94KiCN0YroP3B9jZLrUekS8DMAe3p19yMk4YXui5ybRYY99wZGVDHUAYJFekQ5276adPXEPMRrf4HEuqmPz0wibfjP/XlFY4tvBaXRUYAW98kHJf8hJjQKvAYuaXhyVfB7XlKY1/UHIHoxS+PByokQSvEcWM4GV2yaOc2lCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044130; c=relaxed/simple;
	bh=XSj69FcyOlIcHJ6YeKaqLlq0nkUskSNmW9Ms4+wUYLI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q70t306Iz7ie1U8Dwa0VN/5UIv4ovz5/JrmMuMfkrUQ+X2/TlKNdTVCMEGrw77IPG8dAvXKwn1fvDvYm/DdzHh0yK5r0XPJ8pnMb0LUEs9i9vSEuKgYfZ0VZjCQ4YZVGmhfn3pmzo61u7okAXHp0M9ztxPqv6+3xYyPWPKxGBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BA3+rbMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BA3+rbMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B24A1F000E9;
	Tue, 14 Jul 2026 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044128;
	bh=6kKZwmagYFJR1ROhOVGgw/berrdvlk8j95hfEvMmLLc=;
	h=Subject:To:Cc:From:Date;
	b=BA3+rbMFy6WC0l3e8NZNkE1Yy9589XgaDPvgUqqHgTB8gGyGAPWQ+KDdr0l4//WDR
	 8pl/gfI8YJQzFhPFCG8fqKklM5zqb40Jxxxj02lQTO8CBnhtRWKmiSMG7wbj6yfLeV
	 WwQpDS7U/GRMfpqEAuFufiI0GwOtpiRpsm0YNSsw=
Subject: FAILED: patch "[PATCH] hfs/hfsplus: fix u32 overflow in" failed to apply to 6.6-stable tree
To: tristan@talencesecurity.com,slava@dubeyko.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:48:27 +0200
Message-ID: <2026071426-streak-landmark-fd09@gregkh>
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
git cherry-pick -x 966cb76fb2857a4242cab6ea2ea17acf818a3da7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071426-streak-landmark-fd09@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

