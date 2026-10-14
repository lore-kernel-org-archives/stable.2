Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89151B4F09
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791939658; cv=none; b=QsEDz7bWl2EB3bqGMS1aghghZ7wdQ4ZP6i8HITXUFt2LH5GVCdms7WRs70dlWcDf3Z8iqZJpy4RDo36bisAjPMNV58ZBWLVBKQ8AbbVDhlU5HsvYK/Jt0QrtHb1Vfu87onDceSj5ByiNGHxJ2AuE2iBvSuLlJdL7SvDqWR4pJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791939658; c=relaxed/simple;
	bh=YxvnBeXs0vjZ5XLc4jgBN+uuZxOa8EvYYcX8GGVxTb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXg2Fix0u76CtMC5XEa+6XiQCSQcm0LHU42H6NAbetDNcdQ9weXkQQQ44Vl/aNoX8d8WDLqhYj9bp+5A1jSTvQs/95MmFzcqv7w8p8awnT4EmH7lTHYyNfXBs/StTB9gCR0JMu1boSBIeSVUlZAgqtWKw0t7UisJDkwtbsY0M3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBVA5Szf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBVA5Szf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C131F000FF;
	Wed, 14 Oct 2026 01:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791939657;
	bh=OHqMcR/Vl4zkK+uYfuHayyqvM5xWC1zrVKo6h+xTCTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BBVA5SzfPSSlyT0kQK7sWWD4bWOKKesSkIEpaeJ59FTUcQHE55F3Y3H7SjndTS0QQ
	 BxbKKl+/TCREjNyo6ckX8r8uQZRLYer0qjS4gqedDYAnrmeXhgjGSsfOe20WcNtxWw
	 rp4NlCUiOUxYCXZtPO/zFJyzo6eJOGTuB2teEZBlXGQOEk4VhdRDJTGiFMm2xmcIKZ
	 AiurVDBg7HUPein3YFyDwGDd+NmCkK1fX155/bM9L5UFal/XpmboDe1nIx17nl3wF4
	 Wkgsqzr+/JcXXswK5KWeuzaMndHgrDUGK22MpsXX2FvJp9VQH/pJ1fgPyfl4Hu8jaV
	 yvAyd5gdrVSGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] namespace: handle mount locking for automounts correctly
Date: Tue, 13 Oct 2026 21:00:55 -0400
Message-ID: <20261014010021.1583239-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101253-annually-delivery-a359@gregkh>
References: <2026101253-annually-delivery-a359@gregkh>
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
[ sashal: Adjusted attach_recursive_mnt() context for direct dest_mnt and dest_mp arguments instead of the pinned_mountpoint interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 42ecf070b6f76..c476cd7c42a8c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2212,14 +2212,30 @@ static int attach_recursive_mnt(struct mount *source_mnt,
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

