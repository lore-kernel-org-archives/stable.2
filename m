Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB614BD7A8;
	Fri,  2 Oct 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949232; cv=none; b=uyAw1jMQhMZfbv3ahgxHCeBM1adeh2AElC/tbf4E6l5vDpSE3PBNINsK70UJ1kPkop8M26Ty2wIn0ycBTR8pllAoMBqx5+1021/KW6YIE5AomXBEb0ErlRtPAIlYi2RDWpXlBOjybo2jmbQxhaWvSBRhLYE/AyNGv98FnvuHeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949232; c=relaxed/simple;
	bh=ar1GoMlzuK3lXu4byA4338PHPrSuouPjHVKJiCoVEi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEoEYQ2L2b88OdoSaqwe/DUXfM2i+ueESzkby3eNYq0Z8feuXaYb3Zt2X6m9QWXkW0na1s1VQHGdcUSVfkyhgSrs+icZ6zFJ5gSkOk9qbcPZ2zbYrnCHP7Ip3xSkW+2ttNORBs+N6Deu4PB1jHamKnjTvZm1A/AOrP97WRvTZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXuhrRFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXuhrRFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9A41F00898;
	Fri,  2 Oct 2026 13:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949230;
	bh=Vn2b0fcZzBpGrxa1yMFhqVq+Q10I01fHE9QviUKpcrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WXuhrRFheHUGSqUc3zEpR9CrgDITDfBpD/U347kwDeBZVPqeMLYwmkYO6tR7cSYnC
	 1d/xS6SoO3dQf2rxlQ4GvvO/KErmtKWLA5Dgntnwu/zHWYpP6+gkJWFcC5z8VrTh63
	 0Iv1141QplvKYHm8fFVWAwTbBEBT8ZuJHSHtyz0XKXkZbYIe8X8HfdsgttOvyXgwuC
	 GEI0BFQ5aVhkaL+bos9BjhrnirjyEANLtN09RCUyxy7olDP8yM5N/7ATojNF1rpGD2
	 7do3Tg9W25VPkP+IySyGK6B6jKTGcxCA/FZuiREKPvsPPB/FzN6RUo40phrP7G8b5O
	 lJGpUkGIgZRng==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:37 +0200
Subject: [PATCH 06/21] namespace: handle mount locking for automounts
 correctly
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-6-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3747; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ar1GoMlzuK3lXu4byA4338PHPrSuouPjHVKJiCoVEi8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x7J47awXJHr1LbVR1TeNG9s050wy+mPXmXcMyeG/
 8aeJvIHO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyJ5/hnxVrv4w914Z7aRny
 kzaazDLj9XumaKYb9+9Z1W2jiiOr/Rj+2YpO2F13+5KpadSyzcbOD3l5ZH8ZtTGytP82nSRhyXi
 VBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 60b57572fc64..27bf8665ed58 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2604,11 +2604,11 @@ enum mnt_tree_flags_t {
 static int attach_recursive_mnt(struct mount *source_mnt,
 				const struct pinned_mountpoint *dest)
 {
-	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	struct mount *dest_mnt = dest->parent;
 	struct mountpoint *dest_mp = dest->mp;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
+	struct user_namespace *user_ns = ns->user_ns;
 	struct pinned_mountpoint root = {};
 	struct mountpoint *shorter = NULL;
 	struct mount *child, *p;
@@ -2617,6 +2617,22 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	int err = 0;
 	bool moving = mnt_has_parent(source_mnt);
 
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

