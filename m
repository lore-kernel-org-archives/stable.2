Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F30449B11;
	Sat, 26 Sep 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430312; cv=none; b=DeDpHb3TEwmn4A29JX3OqE34myuHlFUJ5QSVfHUaQJredJpSiGvtEymRs4GTY6n2Tdc8LlNNda8+wAe837Au/6WEK9CdCXI7qzyzK+v3fLqiieNgtsHYzh28bgj+jFT53NKmLctI2W8NtRf5S5eshH2m8bPIhry/GjUUY3QFFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430312; c=relaxed/simple;
	bh=9Ke16FF5IWS/LUC8c6AFBYfn6zb2w8Ms7qYYX9oabUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzDz1nmMxzGPLY75KDvHj6/LJOmdOuLh+JP/zIS3DyL9JZaHb7WBdnIyMCVMsiofoMhctV6mfA9OH3OETQqWMI+v/BgGUSVSNGdxisMbYJgGd5ag68qyQSyxdupntdkrEWI3jk14NZBny/KCRfJwSOHZeNfts4bthAKWln+mN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5uHCUft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5uHCUft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08FA1F000FF;
	Sat, 26 Sep 2026 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430311;
	bh=TlIaIKq4za3aRuCylTXYp061aDVgJqEIoySalVX1nBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D5uHCUftzvtRtrvn8QJN/Q+6Lyi+RhZnDaaEGwKv5uGjhcgRBiSKdVTUgA83YSrmd
	 dc6hfPf6sQR0vZ8SYpel7RJNwvtkr3Gqt1hxNyexwWxN7cSZJMmaDaDuJvzq8JFscB
	 B+72eaDuiOHlrOfqeScMLKqqd+XbA3OCtyyWWqV9tXkNZbZ+mCc+WLo6wCgYihwOHg
	 kCmOQweiVrlYdlJf1GvVLA8gAl4K0NgL/JOxLIDGam+/s/HR0lc9UEFGiB88JXfTOj
	 GH3T4eMo7l/WzMZkLZ6nVgyoe9oeEEIrIfT2uuxJQ48bWqHSu4kJ5n0ITYFOoAN7+v
	 dOwBecyuSUmPA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:27 +0200
Subject: [PATCH 04/10] namespace: don't copy an unmounted mount tree
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-4-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2094; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9Ke16FF5IWS/LUC8c6AFBYfn6zb2w8Ms7qYYX9oabUA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxN1QXyxpGDkk4DPFbEsKzvCOfl9AqaqfK1/4Fiv8
 c4nVseyo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgF4CK9jAzfQu1KXqzW/X6oZeXB
 5fzSNtWvbjkfYFztnvEyaUqqt0Q+w//6Nlufw0VXIk6JqfGdvZvNIPG06obpk1jzDB4/E+nFa/g B
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

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
 

-- 
2.53.0

