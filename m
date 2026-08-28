Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D8356749
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953989; cv=none; b=EGS3hq+CPntqMcYUI5R8ZTGYtGFtI6eupt81FMHLJ5B31wY5eZrRe1DJzfZ+Nh9fwI6NgkGPo/p0vKWrub5k7einvYCK8MJeQXirkNue8MR7RXk/37s+eKQJylcq5o9zH69IwptXajQvI2IjMneNmRyzsMAVdKueFWDoBsZl2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953989; c=relaxed/simple;
	bh=WbiNCMptjrmcEYIdC33C0eKNoewr84F/bHo0BDCR3Cg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jTwWv0NTZI+f3gwRnMPn/xE+6AokKj1BMEXqwKVIm3wCbJe1LSxkyxFG+4a31wJ5/ft0J10hIDYUo+yvVSJTVHELm8eg8IYu1JRCqn7ibDbfsdkJnN/JxVAGtCr3zlo9KindkGpx9F8xHGdbCGimlz8BxxJ8zoyY0vNFu3l05Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--eperot.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jw+H3Kax; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eperot.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jw+H3Kax"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1768107a12.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787953987; x=1788558787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YpFWj3Pa3XG+6oUGMVressHFkgt3PbCUN84lnIAsqyo=;
        b=jw+H3KaxkeQBk7rLDHnuEFQyBMjGhyfs4r+GysHgqJp46O7VqrC1/+8jAg59wIYYMl
         1fzo0xKm6GKPi/f3I7LfX7T6EWyO68z+jzi1X3y7bGKQNWI/tpWCyVXb9hrspC1ihzS1
         1qK25xhOGnVbL53t+JkZhNRxXXZhdfOy7no1Mvpyfu+GqvgUcIvwU4FFHP8TrHU12AEF
         HOfOY20l5ZNopfTeOVAgxkDQCMWi/jVgzkoKM7xtBOQUZWEguz6SipOOyg++NcW5bKjd
         3zrzl8hI1+TEB9z+0IwDFUW+1Bd7zmg03h7mtGB+5LvYdMzYgkm1gU9DoUVDVqOi7DXP
         YY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787953987; x=1788558787;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpFWj3Pa3XG+6oUGMVressHFkgt3PbCUN84lnIAsqyo=;
        b=UnmgFyPstEIphKjZufuYt5Fqc8R5Zk79XiUYNxDBmN62CU+/45+Id6ujeCzqXapyY3
         Q9NiNJSyZwcJCXMQcJqhuLsZqTD6l4n3XaJD9UWYXQZGgrJ75epFSR/w9Kv38y5189V0
         SL3UDNZX1oCMUYWQZMDaXC6wLrBBoB9UN2iFWshtwOl8GHDAO+FQOOQ4NhfxiXyRnUMd
         7mC2+Euk3j9E5lV28C55QTnaVDLRQWG6anaKZWCdHjSUfMTyPW0f8r1G0Z9UZSWm9Xnn
         CaSA4EO/Mfe3fTUneXAjhmHeyR7xSCQxWiAn1kOzXkI6nFVa/MhISodz4GtP3Swm/wt7
         eL2w==
X-Forwarded-Encrypted: i=1; AKwUvBx5J4YS+iTTOsgr6Jw7f6Sg56oIAYGqorVBUXKZb3Vcjv/k0Wq9rxGXS8Npj5LShfcqvsHiHrw=@vger.kernel.org
X-Gm-Message-State: AFuF++nEfdxM+CB1otRguW8c/US+vY5aezdHzzb3wiCZotDA7vGBbH2q
	mwjMq5YQVjwQ4lX+NkmlAtlLhiHtwNjNDc1AunXtNi46Rrb7edMqP1bi0Oiw/k1v1wQjKKbU1Bv
	6cxEtzA==
X-Received: from dyay16.prod.google.com ([2002:a05:693c:62d0:b0:323:c18c:3b31])
 (user=eperot job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f0d:b0:2c9:aae1:a61a
 with SMTP id d9443c01a7336-2d74e07003dmr185797365ad.14.1787953986865; Fri, 28
 Aug 2026 14:53:06 -0700 (PDT)
Date: Fri, 28 Aug 2026 21:52:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828215252.4126811-1-eperot@google.com>
Subject: [PATCH 1/2] cgroup: fix spurious SIGKILL of CLONE_INTO_CGROUP children
From: Etienne Perot <eperot@google.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Etienne Perot <eperot@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit b69bb476dee9 ("cgroup: fix race between fork and
cgroup.kill"), the fork path snapshots the kill_seq of the child's
future cgroup into kargs->kill_seq, and cgroup_post_fork() SIGKILLs
the child if that cgroup's kill_seq has changed in the meantime, to
catch forks racing with a cgroup.kill sweep.

For CLONE_INTO_CGROUP, however, the snapshot in cgroup_css_set_fork()
is taken before the target cgroup has been resolved: kargs->cgrp is
always NULL at this point (it is only set at the end of the function).
So the "if (kargs->cgrp)" branch is dead code and the snapshot always
records the kill_seq of the parent's cgroup. cgroup_post_fork() then
compares it with the kill_seq of the target cgroup, so the child gets
SIGKILLed whenever the two cgroups have been killed a different number
of times.

As a result, once cgroup.kill has been written to a cgroup, every
child subsequently cloned into it with clone3(CLONE_INTO_CGROUP) is
killed on the spot, for as long as the cgroup exists: kill_seq is not
exposed to userspace and never resets.

Re-snapshot kill_seq from the target cgroup once it has been resolved,
and drop the dead branch at the early snapshot site.

This does not reopen the race fixed by b69bb476dee9. For
CLONE_INTO_CGROUP, everything from the snapshot to the check in
cgroup_post_fork() runs with cgroup_mutex held, and kill_seq is
only ever incremented under cgroup_mutex.

Fixes: b69bb476dee9 ("cgroup: fix race between fork and cgroup.kill")
Cc: stable@vger.kernel.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Assisted-by: LLM
Signed-off-by: Etienne Perot <eperot@google.com>
---
 kernel/cgroup/cgroup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c3a12fee7528..2d532bf2c0c7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6873,10 +6873,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
-	if (kargs->cgrp)
-		kargs->kill_seq = kargs->cgrp->kill_seq;
-	else
-		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+	kargs->kill_seq = cset->dfl_cgrp->kill_seq;
 	spin_unlock_irq(&css_set_lock);
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
@@ -6940,6 +6937,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 
 	put_css_set(cset);
 	kargs->cgrp = dst_cgrp;
+	kargs->kill_seq = dst_cgrp->kill_seq;
 	return ret;
 
 err:
-- 
2.55.0.897.gb25b4bd76c-goog

