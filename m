Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A652BE4F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920287; cv=none; b=PY2dV3X9L5+8drb0hMD1XbKSJbIE7hLc/D2/5e1vvWHcHz/9fbvAoV0rLA6y+2iOcHQ6m3VhCUzVW6ibpnssl/TGKqrCkVIxVjBdz0285BFixqNahYbqBuXoRi+S12mbSYBQAnqdHFKzZmdp/R9JeK7O1ew2q0lL8HvD7fGzzDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920287; c=relaxed/simple;
	bh=lwn36pR2cp2bgPp19rZ1JDzCItN7IHkIEcKKIjTRs8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf775/EPhfNtSwlbU0cwvNx3toGw7k69FkFtUJzrzsYpPzyLp17mcRqmdMPsvUZci1WXBQVfnDJPrz2+kukJ5PXEY9NUm/UUoNobflZCf05/paJMb10BnFbBbQYzQ83ao51VSwETSu8jstB/pRhcvV1bml2xhnV6Q1HXmXIeHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKpi/XEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKpi/XEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF891F000FF;
	Tue, 13 Oct 2026 19:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791920286;
	bh=60RfD7zTj4vrKF0NeVK8U4H5Id4V8dwyldTv8D199g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKpi/XEhwV+cErnkHoeVxApf3GU2Niom4RWxeDOan4b18fTkWRhB5prlCi8bB5yAd
	 erVOtTexsDAOfMn7KgZw6HscsLn9a5SBu0zu9iOnVVjAh+lEdYWCzaXA9oaUoD0+3B
	 jH3vJqcVFnTQR/ULTC+45vt986Iba1EP+haojlC3FLN2LyCQFxwiE+ph/Wv6FXQCBb
	 IBSgQiPhDaSshrf2U1I7olPHuuqdjfASjmVZ8KASoSlQnp5PnmXxycs7ndVtrtODd4
	 QTuHlVQCzRuck6z2ZTNGxT86QdkGLPkzZy81U9tzTeZLogkqaDdzcVK0QMh32OQz2c
	 bhbF7XW6THZGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] namespace: don't copy an unmounted mount tree
Date: Tue, 13 Oct 2026 15:38:04 -0400
Message-ID: <20261013193730.828484-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101251-collage-refried-0dba@gregkh>
References: <2026101251-collage-refried-0dba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 8bacbf6be959973b28b691713a872c12eae69eec ]

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
[ sashal: adjusted context for inline mount validation instead of may_copy_tree() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 42ecf070b6f76..78e521ee3ceb3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2428,6 +2428,9 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
 		return mnt;
 
+	if (recurse && !old->mnt_ns)
+		return ERR_PTR(-EINVAL);
+
 	if (!recurse && has_locked_children(old, old_path->dentry))
 		return mnt;
 
-- 
2.53.0

