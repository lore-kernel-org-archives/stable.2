Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DB1DE4EF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945908; cv=none; b=DMGAKENiBFBuJgazRCCsfQNtlRcODBNt0yf9dmgZ/CCCzD3eIlKzW4Sv3LCUx0mmKpl0A60WoCk+eZX6J5pRhsMWwv6mODV/ymXHJ5DOHRTTWavGulqjVDLUJvqnHc23kRE1HRFbvhXYp8mEdIQcStTieVcXvjaD0YqzQAgJ028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945908; c=relaxed/simple;
	bh=JWZ7acxifdPKQqKXijY7peRPxh7wrfs51HSrNjjySyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHvtBQ4KgzGMj1oK0Vom0yhB8gRVYhozV37WNa/4EbcXZ/8dG5Wwckr4Z4zfRP3kwg2Hehp/hgqdIBOTNTeLj5LP09QdBhunaYebwFR3b4EnKe+dENFJMZe62m5x5EJY3Onez5lRdaOBZjrUbNoERGPbuThPp9hyRH6GZLJ3V9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDlneAs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDlneAs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7801F000FF;
	Wed, 14 Oct 2026 02:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945907;
	bh=+Sx79Rpmcs8VYH+nLVa20oLW+IJvnZaQjQJbX91vFgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UDlneAs8Dup/7MrM6T38zkvn+IE/mGJY0DjwsWaFboAq7Ix5e6yfP2urBiZ9WinUA
	 IUcy9ZuhKBlIOMWRj1V8HJan/zo/iZVrhlOS7IPQ8Eh2EdbENxR458y8k0pEGIYwu0
	 XGgehyCqeFY3CEKoyyIURSm14asv3b/NfK7mpzJomVx1PMZs7beXnQqpHfOmv1bUCc
	 ikuJZ86IyKIWZ3FXurHmNR3/X0mCzxTJqrok18B0NLmhigwjHR9iq3nxfyAdkLwUHp
	 4sgrY6tJGXmlBEnVNrvWYeS9TpUKTmU7xDKQh5YhG6AX1r27qNfg7D9Qwf33Tjrfg3
	 pVU115a8xKkNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] namespace: handle mount locking for automounts correctly
Date: Tue, 13 Oct 2026 22:45:05 -0400
Message-ID: <20261014024428.1659609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101253-pelvis-snuff-c746@gregkh>
References: <2026101253-pelvis-snuff-c746@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 33aadc7c72055fca93cb5a3691d836ebf8b31c9b ]

If mounts are propagated across user namespaces, attach_recursive_mnt()
locks every copy of the source mount to protect overmounts from
vanishing and revealing the underlying files or directories.

The user namespace is taken from the caller's mount namespaces since
this is where the mounts end up. Except, that's not always true.
Automounts may legitimately get popped in by tasks located in a
different mount and user namespace during path lookup.

Then check doesn't make sense at that point. The copy in the namespace
of the parent - which may be the host's - is now locked and the host
cannot change the flags of its own mounts anymore.

Here's the reproducer:

- host has debugfs mounted nosuid,nodev,noexec and shared
- tracefs automount below it is not yet active
- hand a child process a directory descriptor on that mount
- child process enters auser and mount namespace
- child process' namespace now holds a locked copy of the host's debugfs
  mount that receives propagation from it
- child process stats "tracing/." through the descriptor
- lookup runs on the host's mount so the automount lands below the host's mount
- propagation puts a copy below the child's copy
- both try to clear the flags on the mount they got, with a bind remount:

    host, on its own automount:            MS_REMOUNT|MS_BIND = EPERM
    child, on the copy in its namespace:   MS_REMOUNT|MS_BIND = 0

So the lock landed on the host's mount instead of the child's copy.
Congrats. So we need to compare with the owner of the namespace the
mount actually gets mounted on. For all regular cases that is the
caller's mount namespace and so nothing changes.

Detached trees in anonymous mount namespaces by be handed over via
SCM_RIGHTS or inherited in other ways on purpose so the attaching task's
mount namespace is authoritative, not the creator of the detached tree.

Fixes: 132c94e31b8b ("vfs: Carefully propogate mounts across user namespaces")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261002-work-mount-fixes-4-v1-6-dd44b89d44ce@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: adjusted context for attach_recursive_mnt() using separate mount and mountpoint arguments instead of pinned_mountpoint ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ff8d16a3eeb2d..9eda86de1efca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2168,14 +2168,30 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			struct mountpoint *dest_mp,
 			bool moving)
 {
-	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
+	struct user_namespace *user_ns = ns->user_ns;
 	struct mountpoint *smp;
 	struct mount *child, *p;
 	struct hlist_node *n;
 	int err;
 
+	/*
+	 * A caller in an unprivileged mount namespaces may trigger an
+	 * automount and propagate locked mounts into privileged mount
+	 * namespaces. Take ownership from the target mount namespace.
+	 * It's equivalent for everything but the automount case.
+	 *
+	 * Detached trees in anonymous mount namespaces by be handed
+	 * over via SCM_RIGHTS or inherited in other ways on purpose
+	 * the attaching task's mount namespace is authoritative, not
+	 * the creator of the detached tree.
+	 */
+	if (is_anon_ns(ns))
+		user_ns = current->nsproxy->mnt_ns->user_ns;
+	else
+		user_ns = ns->user_ns;
+
 	/* Preallocate a mountpoint in case the new mounts need
 	 * to be tucked under other mounts.
 	 */
-- 
2.53.0

