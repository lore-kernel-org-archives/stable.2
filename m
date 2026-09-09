Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946F52B1D4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954248; cv=none; b=kPIiZR7sRCyx4Z3G7WYdKpirZWihgPkAEoAAMWzSpqJ6EHrnjyDX5/z0EY5TnNuH19K4NCshfvBDyXqMqefyCkHsxCdjmcwVXo8fV6zmKI9PtAl5cwszWmspSxTJ02jhlXvuASrBHGFaKVduxVjhjqnFp9az0SFc/gpv0Tfj0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954248; c=relaxed/simple;
	bh=reMvtZMrE0QXG8FrUrQ4xUe4oRA13pz8qk5YgORbwys=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B7U1545Kz1JDbwXw8XSLFebgJ6GAejVAx4ZZKoW/q/PuEhWmBsXfJIJfaQwMBwAbrjHXkO06L1jc+gymKamNI8d2Ol+86EIUHmFGm4ZGNeQOqIU6IAibLWwTN4KRbtFsjkuCxTunS8l982s5bE0LHZWJspTrpiFobKgSoqup0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EJ5ueT42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EJ5ueT42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E8F1F00A3A;
	Wed,  9 Sep 2026 11:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954247;
	bh=ZTKf+3ptZyhQcWFFJM8d5O3qTfQlvFs55XyrgjB47OY=;
	h=Subject:To:Cc:From:Date;
	b=EJ5ueT42ty+B5pjOLO0VBCUssJmaWehXegm9+L+keLZL8xnnRWiYGii/YSZfjcIs7
	 QmXPXHDkH/U++Ew/0lYKxgPAH7HGAdgDH2KZsX/IPL5Nx5+J0lxC9VNB4URzyAmHQ8
	 mCX2ZW29ml1v4YLUSNJGS63NZRxr5S/2+Um4xcvQ=
Subject: FAILED: patch "[PATCH] f2fs: avoid NULL checkpoint thread access in sysfs" failed to apply to 6.6-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:26:30 +0200
Message-ID: <2026090930-parkway-apply-1c3d@gregkh>
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
git cherry-pick -x 5cb33b00c8fbb6e8f1fa3d281c3036d5f7c7c41f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090930-parkway-apply-1c3d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5cb33b00c8fbb6e8f1fa3d281c3036d5f7c7c41f Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 4 Aug 2026 09:48:48 +0800
Subject: [PATCH] f2fs: avoid NULL checkpoint thread access in sysfs

checkpoint_merge can be enabled even when no checkpoint merge thread is
running. A read-only mount is one case: f2fs does not start
f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
sysfs.

The ckpt_thread_ioprio store path updates the saved ioprio value and,
when checkpoint_merge is enabled, calls set_task_ioprio() for the
checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
NULL task pointer.

Protect ckpt_thread_ioprio sysfs writes with s_umount as well, so the
checkpoint thread cannot disappear under the store path while updating
its ioprio.

Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d9f81edca04a..c976549ff1bc 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -557,7 +557,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 
 		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
-		if (test_opt(sbi, MERGE_CHECKPOINT)) {
+		if (cprc->f2fs_issue_ckpt) {
 			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
 					cprc->ckpt_thread_ioprio);
 			if (ret)
@@ -1007,13 +1007,14 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ssize_t ret;
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
+	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio");
 
-	if (gc_entry) {
+	if (gc_entry || thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
 			return -EAGAIN;
 	}
 	ret = __sbi_store(a, sbi, buf, count);
-	if (gc_entry)
+	if (gc_entry || thread_entry)
 		up_read(&sbi->sb->s_umount);
 
 	return ret;

