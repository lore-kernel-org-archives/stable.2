Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86053AA1AE
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568728; cv=none; b=JX7DtE6KSgvWF47XkCcKzyOFSjZUOEYJWNLVGaN/2vsWGzbnzrkJtjMTK8xj4cdgUOtruJcAjMBXIQM74ad12NuwbsTtD2QPU8Xzt6TK8J2XaDqSf5QMnbizDMwXs488kxfKN6A1OtFnj+Dej00nTxVOpgoGeTRZq4r7+o9nZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568728; c=relaxed/simple;
	bh=3xYJiVa+cPZD3bN2klpdcgzLSlvOeq/NJz7NVqgL2LU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OKuJQfU6MdfRpual6GnV6uAhLwdkGLRU9m9isJZeu7f4C3M0KJjd8Necby8kM2Xkhf933N9x7tprOL0+PV3oEiZwrFXBQGV6EMCsShaTuqPJ9Rqp8XH6xecuAihb5+S+yGnBbBxjo7y9nohIoZ5Xs6UTfvae/Y5eCAp3K/6NDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o0fm45FW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o0fm45FW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0861F000E9;
	Mon, 24 Aug 2026 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787568726;
	bh=stYFAwsqz2bjqI1SabyOzhoL5il3TEnEUw6m7aT8MB0=;
	h=Subject:To:Cc:From:Date;
	b=o0fm45FWnRuPIxUMxAcVt1o0IsKPmjE4oECzRvLzCt56ol8pk49YSIWhvREE9J7d8
	 0UkE1N4Z/tbyufDcpra0Ckqq9SzJNBWce2NfzMzmbmt+cakGiTEWuAV4VKuenCr6lW
	 4H0Jf/c4QFRbOdTBsavv5tXFTEJvBZ1Jr2Xh9DKk=
Subject: FAILED: patch "[PATCH] futex: Avoid private hash use-after-free on final put" failed to apply to 6.18-stable tree
To: f3lix.dev@gmx.de,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 12:51:54 +0200
Message-ID: <2026082454-obligate-cultivate-908c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1c7efabfbaf796f11000a46094a69955a01ec6cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082454-obligate-cultivate-908c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c7efabfbaf796f11000a46094a69955a01ec6cc Mon Sep 17 00:00:00 2001
From: Felix Hoffmann <f3lix.dev@gmx.de>
Date: Fri, 31 Jul 2026 17:50:24 +0200
Subject: [PATCH] futex: Avoid private hash use-after-free on final put

futex_private_hash_put() drops the reference to fph before evaluating
fph->mm for wake_up_var(). futex_ref_put() enables preemption again before
returning. If that put drops the final reference and the task is preempted,
another task can pivot to the replacement hash and free the old hash after
an RCU grace period. The first task then reads fph->mm from the freed
allocation when it resumes.

KASAN reports a slab-use-after-free in futex_private_hash_put(), with the
read at offset 24 in a freed kmalloc-512 allocation. The allocation and
free stacks point to futex_hash_allocate() and the RCU free path,
respectively.

Load the mm pointer while the fph reference is still held and pass the
saved value to wake_up_var(). wake_up_var() uses the pointer as a waitqueue
key and does not dereference the mm through it.

Fixes: bd54df5ea7ca ("futex: Allow to resize the private local hash")
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260731155024.1150011-1-f3lix.dev@gmx.de

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 0864c6e8cde7..d3fcad4ee716 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -139,8 +139,14 @@ static bool futex_private_hash_get(struct futex_private_hash *fph)
 
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	if (fph && futex_ref_put(fph))
-		wake_up_var(fph->mm);
+	struct mm_struct *mm;
+
+	if (!fph)
+		return;
+
+	mm = fph->mm;
+	if (futex_ref_put(fph))
+		wake_up_var(mm);
 }
 
 static struct futex_hash_bucket *

