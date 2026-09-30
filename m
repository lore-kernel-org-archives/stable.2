Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7E4FDE7B;
	Wed, 30 Sep 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775183; cv=none; b=qQNPMfmtrjwdwSQRWK3C4oQnaWpwFVMzA01VuPaypDytjcOiLTifxs1KJWVQE/n3XzPBMIpyO3b7IpnqKBY7N2e4qaRteuiymAcyXUGXVyNKKcSvMm+Zwn5Qqh1SneT5LHN6JqIZP83vHbFsOngWl5O0tKUw9ovS0QsUD/OWdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775183; c=relaxed/simple;
	bh=mW/Is32joGnGf0Bpv9glBLuZOAnyk1YMwflHaSBhn5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QG5nVi2jmAjyoV3s+e8I+1EEVejqRMj9mE06IdB5ee31cSNj7CSK3MYSCgdu/xMY+FY9Q3bG1rtXg20VOHWkVzoURg5ozx8q1NXShvlAziGSilonLSaJpbrjCWiHhwQOEbc8fxZTSSXnqPo8DJRjaLdN87pK8YPgvyDxIZxjUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPbLK/E/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPbLK/E/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F06B1F00893;
	Wed, 30 Sep 2026 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775171;
	bh=I+vtktdQBcG7CDSemXGmUl+kTdIK6PHkwcTzTiV8jlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lPbLK/E/uGoPVjuWQkISiUpLWwzrSyJZo/fkVKpMObrKKQbGhNVwoDxvcrvZaDcpz
	 vFjWUerWPaF/4O3SlLIsS0VTFXDz73IGP+H0j5oj052SErr1lYOuhEx/+xRVdeS3If
	 ozqEGvFSVJpiiknsiwqrb9fPzWhGhRe5/dEGjIhCb0hz7xUw3Lbn+wLrvrNjoSDm3G
	 1hh2RawryONVwjRoOEJhUxcaXK2cwnMKNcJaS5JvS81HYqLD3eGSNsEvbMVvoP0Ck1
	 Egz4xlBtccMVGTY4uATQpWoxQbf9P/0XwYFuWvXcJ0VX/pAl+/m3eZ4AEobGzUkakP
	 sI1RvAYT/yDwQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:08 +0200
Subject: [PATCH 16/17] unshare: don't drop active namespace references that
 were never taken
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-16-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3013; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mW/Is32joGnGf0Bpv9glBLuZOAnyk1YMwflHaSBhn5E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ffPnWb7KmHepvhT0W8OaC4O2Tl1WS3vy+d8F5y3y
 zQtP6HH1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRyiiGf3YeUTvtatPzDxme
 878zU3qL5jrmqitsGs6sak+3LhVKWcXwP0z/rbpU7Y0vRRHvXTzur7lm41l6VyRnBmeP45qPXMV
 qPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Active references on the namespaces of an nsproxy are taken when the
nsproxy is installed into a task in switch_task_namespaces() and
copy_namespaces() and dropped again by put_nsproxy() through
deactivate_nsproxy().

But ksys_unshare() calls put_nsproxy() on an nsproxy that was never
installed when set_cred_ucounts() fails. The new namespaces of that
nsproxy go from zero to minus one and the namespaces shared with the
caller lose a reference that belongs to the nsproxy the caller keeps
using:

  WARNING: kernel/nscommon.c:171 at __ns_ref_active_put+0x1cd/0x230
   nsproxy_ns_active_put
   deactivate_nsproxy
   ksys_unshare

Afterwards the namespaces the caller lives in aren't listed by listns()
anymore. set_cred_ucounts() only fails when alloc_ucounts() can't
allocate and it only allocates when the real uid of the caller differs
from its effective uid.

Commit cefd55bd2159 ("nsproxy: fix free_nsproxy() and simplify
create_new_namespaces()") separated the two cases on purpose.
nsproxy_free() frees an nsproxy that was prepared but never installed
and that's what a failed setns() uses in put_nsset(). Export it and use
it for a failed unshare() as well.

Fixes: a98621a0f187 ("unshare: fix nsproxy leak in ksys_unshare() on set_cred_ucounts() failure")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/nsproxy.h | 1 +
 kernel/fork.c           | 3 ++-
 kernel/nsproxy.c        | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 5a67648721c7..dc2447f5f092 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -100,6 +100,7 @@ void exit_cred_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
 int exec_task_namespaces(void);
 void deactivate_nsproxy(struct nsproxy *ns);
+void nsproxy_free(struct nsproxy *ns);
 int unshare_nsproxy_namespaces(unsigned long, struct nsproxy **,
 	struct cred *, struct fs_struct *);
 int __init nsproxy_cache_init(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index da48168c504f..d442cd68a37a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3338,8 +3338,9 @@ int ksys_unshare(unsigned long unshare_flags)
 	perf_event_namespaces(current);
 
 bad_unshare_cleanup_nsproxy:
+	/* never installed, so no active references to drop */
 	if (new_nsproxy)
-		put_nsproxy(new_nsproxy);
+		nsproxy_free(new_nsproxy);
 bad_unshare_cleanup_cred:
 	if (new_cred)
 		put_cred(new_cred);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index d9d3d5973bf5..3fb1595a4a59 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -61,7 +61,7 @@ static inline struct nsproxy *create_nsproxy(void)
 	return nsproxy;
 }
 
-static inline void nsproxy_free(struct nsproxy *ns)
+void nsproxy_free(struct nsproxy *ns)
 {
 	put_mnt_ns(ns->mnt_ns);
 	put_uts_ns(ns->uts_ns);

-- 
2.53.0

