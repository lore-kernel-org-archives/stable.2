Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E784078CC
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935722; cv=none; b=QnzTee1WMymC9Q4qHP09xDCzyIC9o9k1CFaR5YGenOuc9bn8kcatCJjqeOuOju7KLD0rEINdGa5EHNAAvkCe9opD2b9rY4b7z5DfD2jgRsAXeNN9cq2tf/EJSvh0ovd8FhgZ2Jk1pF89el7NHbnCnO9xyY/fc9nZeTKNl12MLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935722; c=relaxed/simple;
	bh=nSx06jX+ZSSMG/sDU9THwQnaYTDmqzViH1OrP8aClZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW68viExvwQbMDDSH3PV/KR9ORn+CwuAhB23vzIhsW9Y4XaqipX1KTjVniJPr/6ZKuyaRH5I/JKNd8OxLINEaR6Viixdct65UDBiDi98TSJZLVdvFU21lTVnklxQRHbysKZkW90QrRMPepTlaIM9vjU1/xdaPK0cGCep4pfr5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyum2qzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyum2qzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497CD1F000FF;
	Tue, 13 Oct 2026 23:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791935720;
	bh=/J3M6Doc23rBQr9ms3YtHoRXpHoa15IWP0b327eDgXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyum2qzsJEyWfMFbNl2HaEQiEBDh4brj0QX9FRdvJuLJCIm4CCPJDdpq2W8onsG/f
	 T15Ocd85WSbaN9SiSoQ+5jqcT3vgUUfKnuik3QF9z0YFtWL02wdt7wuiKUw8od/RTQ
	 Q4IjO1D2R5Nwd9pY0tKFfex/K2IPRibeQNRwcIFmWDFVDcVjVFd7TfDAQaYOLcFOo1
	 viruitXEjuWV+5LMk9O12Lct5F3YD/xRIBtQHSyUtLjBYYbSobSMoJWoPYR/ljhFmt
	 p+JMT3r5ePOgCm907ervO88iLbojnzdMcgxxCjmHXkzT48X2srLOw999HD5bk6HgBL
	 DXv0kydCT80/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] namespace: handle mount locking for automounts correctly
Date: Tue, 13 Oct 2026 19:55:19 -0400
Message-ID: <20261013235446.1479584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101252-smog-yin-39f1@gregkh>
References: <2026101252-smog-yin-39f1@gregkh>
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
[ sashal: Adapted the namespace lookup from dest_mnt->mnt_ns to top_mnt->mnt_ns. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3311e4edbc734..6954292409531 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2313,15 +2313,31 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				struct mountpoint *dest_mp,
 				enum mnt_tree_flags_t flags)
 {
-	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = top_mnt->mnt_ns;
+	struct user_namespace *user_ns = ns->user_ns;
 	struct mountpoint *smp;
 	struct mount *child, *dest_mnt, *p;
 	struct hlist_node *n;
 	int err = 0;
 	bool moving = flags & MNT_TREE_MOVE, beneath = flags & MNT_TREE_BENEATH;
 
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
 	/*
 	 * Preallocate a mountpoint in case the new mounts need to be
 	 * mounted beneath mounts on the same mountpoint.
-- 
2.53.0

