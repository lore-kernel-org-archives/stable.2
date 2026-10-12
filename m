Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265904A64F0
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819742; cv=none; b=JF2Z+hVmOc4PeeB+3h/7Lhfb1zS1ojUNlMwTVVFk/QORWFnqAw0cfk1r7wH8O+pCkqQHvm88lp5UZyM7h0m2jLFhLkEr581bR12fFrtbvoFm+DgnorW0pAS8ahDjIlqHIZsi5MeXFlk3Smfd31pL3WylMNxpsngZIoz6mf3Dprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819742; c=relaxed/simple;
	bh=GBiblPkr0YaXDzT59ucldk/q/ocCEmNaCr9qhAbpUM0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RaquptqfPO+tDX90WgHA/Q/L36b6f4yiskLXp1nOULuZA9/6dHd6Zq8hlAJvFyOK7gSUAHvIf4UzeXQraWDK+n6gGo7NMIHVKF7aUbANlsgQFd/4yPm8beVub7VQnIr5Gzknb9pVQm5Rx2MfbfxoBqbV1XT3TibWwhcsvz4uxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCjqKh9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCjqKh9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CACE1F0089B;
	Mon, 12 Oct 2026 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819741;
	bh=61CepvYsHRKpAuwWROGVCFqP5KR/529OACVYQuvlqMI=;
	h=Subject:To:Cc:From:Date;
	b=pCjqKh9MRue+0XeVmubGVqQlB7/XEd2ZCO3YA0WpfW1of1F7OsCAWtWesrfA2eysO
	 ZGpnts2C+FlEXXVMdJzzhJy1DsZTKzqa2CZhmJDJ3vWbBiXjDqJiqbSafJZJZTws/K
	 LT7dpr9ONAeTFl364dLppZsa18oghY1yXMZzJ3rY=
Subject: FAILED: patch "[PATCH] namespace: don't copy an unmounted mount tree" failed to apply to 5.10-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:41:54 +0200
Message-ID: <2026101252-skimmed-repossess-aea1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8bacbf6be959973b28b691713a872c12eae69eec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101252-skimmed-repossess-aea1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bacbf6be959973b28b691713a872c12eae69eec Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:27 +0200
Subject: [PATCH] namespace: don't copy an unmounted mount tree

may_copy_tree() accepts a mount whose root is an nsfs or pidfs file
before it checks whether that mount is mounted. This exception exists
for nsfs and pidfs mounts. They are part of no mount namespace so
neither check_mnt() nor is_mounted() would let them through and
bind-mounting a nsfsfd or a pidfd wouldn't work.

Problem is that exception also admits a bind mount of such a file when
it was lazily unmounted and is only kept alive by a file descriptor:

  mount --bind /proc/self/ns/net /tmp/x
  exec 3< /tmp/x
  umount -l /tmp/x
  mount --rbind /proc/self/fd/3 /tmp/y

With MS_REC or AT_RECURSIVE copy_tree() doesn't stop at the unmounted
mount. It copies every mount that stayed attached to it as well. So if
you have a bunch of overmounts over the nsfsfd or the pidfd the whole
unmounted stack is copied. That's a bug.

So refuse to walk an unmounted tree. Copying its root alone stays
possible. So a bind mount of a namespace that is gone can still be
recreated from a file descriptor on the old one. The file descriptor
pins that mount and its root and __has_locked_children() only reads the
direct children which don't leave the parent's list without
namespace_sem. The internal mounts carry MNT_NS_INTERNAL instead of NULL
and are still walked. Copying an unmounted tree recursively fails with
EINVAL.

Fixes: e149ed2b805f ("take the targets of /proc/*/ns/* symlinks to separate fs")
Fixes: ef4144ac2dec ("pidfs: allow bind-mounts")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260926-work-mount-fixes-2-v1-4-f357abf3d17b@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index 6d4ecde682df..c7e252eb249e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3007,6 +3007,9 @@ static struct mount *__do_loopback(const struct path *old_path,
 	if (!may_copy_tree(old_path))
 		return ERR_PTR(-EINVAL);
 
+	if (recurse && !old->mnt_ns)
+		return ERR_PTR(-EINVAL);
+
 	if (!recurse && __has_locked_children(old, old_path->dentry))
 		return ERR_PTR(-EINVAL);
 

