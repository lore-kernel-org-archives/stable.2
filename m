Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF684E0213;
	Wed, 30 Sep 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775165; cv=none; b=pUSo/29z+7Z1Ie9k3Cg1JOMlBVQxhPHuuMb3SqdkfIgcTybqkT4cVgTlOh5ScZpESsXbj08U8sGCPnHvaxiqgXTAVyj00N8Jlb8S5TC5PM/hPQrUrcmPHjl0FaCuZn3SZ3WsQ9ANHrsSb94zzszdCx2GODHmAMJwcLyXCeQ5gOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775165; c=relaxed/simple;
	bh=bwxyd+peEw7h9/qF9HlhYJK4VprP5WnYZvI4aeZmLmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAeo+EJnExjjPlU8zeCFQyJf+NxMQxB/FQ1ZAjHwisXoNq41V2lKIS/ZfshiBabYhGU+Ceymt9pTEd9MjCiqSqA9yCpJmHYufMKNL0bVUe4MdB5U+C+rNqiewoWtZqtMnNEDtg2YiP2J626gmFzWhq0vhyblZqew7PS7L3wOXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9k96XsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9k96XsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49911F00893;
	Wed, 30 Sep 2026 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775160;
	bh=3ZucXWECji4gkUktkefSBd5DcFs2vae6ciiEpDVZGOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W9k96XsWCgYWvBwjG6tjVstj2F9lKPuUcWKYJHd7WPIgtiElrFifRCvovqvPbU5g3
	 OYs5vqTdd4QHnRQXqIgBaM2F6ZrafrPLRVPtZpcwym3YVApB5Vt1k3a30CwQfiRHV7
	 /XFEof+PebeDBSpgA4y7amETR7xzImZ/ST6Nu2i9upVdaU20TQFCygdHcXhQN3S+Of
	 8yzpY7pPLLob7feAL6kwsYqY9aCsA/siQ+sw8Is4eYo1hinfO9Pf+9UMAzP5FWev4r
	 Ib7SLd4IR2JRNthj5AL5Q/wI7te0x8+jQuyLPgqXMrISL5i19uxT61mdkq6vsZE9Oi
	 12aixnDnTeh3w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:05 +0200
Subject: [PATCH 13/17] namespace: remove the fsnotify marks of a mount
 namespace in process context
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-13-be34c83956ae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bwxyd+peEw7h9/qF9HlhYJK4VprP5WnYZvI4aeZmLmE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5fePn8l/MOtv8Ra91W913wUILH+zX7R3U/3BlRV1x
 z4+sdBv6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI6wGGv/Jev3e63tbSmTPj
 Zy7jozjugIDDb7pypE1fvevmnTn3RQgjw5Gvl7/xXrBv3aNcbRJe+LAp0m3Budutbupas33jeO6
 8YgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

mnt_ns_release() drops the last passive reference of a mount namespace
and removes its fanotify marks via fsnotify_mntns_delete(). That takes
the mutex of every group with a mark on the namespace and the spinlock
of the connector. Fine from process context. But mnt_ns_tree_remove()
hands the reference the namespace was allocated with to call_rcu() and
so the marks are removed from the RCU softirq:

  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/3
   __mutex_lock+0x113/0x24b0
   fsnotify_destroy_marks+0x11b/0x3d0
   mnt_ns_release_rcu+0x57/0xa0
   rcu_core+0x6b6/0x1e40

and lockdep complains about the connector lock being taken from softirq
context. A fanotify group with a FAN_MARK_MNTNS mark on the mount
namespace of another task is all that's needed. Root in a user
namespace can do that for a mount namespace it owns. The task exits and
the namespace is freed with the mark still on it.

Remove the marks in free_mnt_ns() before the namespace is handed to RCU.
That runs in process context once the last active reference is gone. A
mark is added through a file descriptor to the namespace which holds an
active reference so no mark can show up after that.

Fixes: bf630c401641 ("vfs: add notifications for mount attach and detach")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0a7d50db228d..3c90d853e091 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -130,7 +130,6 @@ static void mnt_ns_release(struct mnt_namespace *ns)
 {
 	/* keep alive for {list,stat}mount() */
 	if (ns && refcount_dec_and_test(&ns->passive)) {
-		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
@@ -4279,6 +4278,8 @@ static void free_mnt_ns(struct mnt_namespace *ns)
 	if (!is_anon_ns(ns))
 		ns_common_free(ns);
 	dec_mnt_namespaces(ns->ucounts);
+	/* the last active reference is gone, no mark can show up anymore */
+	fsnotify_mntns_delete(ns);
 	mnt_ns_tree_remove(ns);
 }
 

-- 
2.53.0

