Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013E49DBB3;
	Wed, 23 Sep 2026 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166499; cv=none; b=FjSOsveAsBX74s8v9Fg20x9Nwt69LXjwrw/qtDciWmGHXYtfVZYYO2/2uecF6kkabSssSuhn49po8GrNNewHlPBKsrokMXuYRqtGo5O1l7FrT4h0UIT8RxYQb8VW5Mspm8pqfyXpF6Nf1A7eZYVV87B/u6V/Oo3rNeCsYyv0pKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166499; c=relaxed/simple;
	bh=x9hD7kM2i0bK9AH0c7wGE8PLIlQnY7AZ3iJjOG+ricQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cU/rOfWeW9j88BiX9i3dYDMlcRgLXoZMX2Lp7kGbPzPyK6DEJZTJV+9zr4dT9Tq+aLOCaR6ab6M8LYSmAyPCZE+LlRy2VuGNrUE0hXCxgOvjTQC/FoXi7ss8gNs1YzeIinu86DThqwgd5GVdLztFMrsaGe+hvYz3lj/pS3+sEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ7l2aIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ7l2aIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A491F00893;
	Wed, 23 Sep 2026 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166498;
	bh=xa0iihi21cS2sTIlimicqhQYTLmU7luc8l/boaaezg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hQ7l2aItTkekVHnvNtnJLefRLfG1kTGAfgMNt6pbmE/BytfKvOAMFHwiZrjVJpcIn
	 HxW1qJ9kxIIkyl5lQyWhmU2W2vedRbO9xq/fg7r1HFYvzUwJ6w6TF+i+vYNiQ1vZUq
	 ilpsryVo7t4MRxuAAsYwoFObuxUv++WFlQkyu0lycBQen2gsOJm9p/GqYguBCpdMcP
	 g6ipkK/CIFt8RefJqmDB0krXRKSMhpb5jcFYuwwsqyviEHZKeYw/5wwOyS5Lb4D2dm
	 g1kjhICy3b0I89MgGiy98Hn12gdMM7wf99h65MWZT54Yxy8JTxIDbvCkxwYyR6Ts2H
	 HMHpTlwcJCsJg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 23 Sep 2026 14:27:53 +0200
Subject: [PATCH 1/8] mount: keep a copied mount unbindable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-work-mount-fixes-v1-1-f424cf8d3242@kernel.org>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
In-Reply-To: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x9hD7kM2i0bK9AH0c7wGE8PLIlQnY7AZ3iJjOG+ricQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnrn+D8fkZoKvtAj0w4fZs6/e9hejLmrWthmYfgtj
 rwu7rfVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ/ILhf1zap6TSWz8e9mh+
 X1rsX5OZ7m0pd+Ch2/ZVC3TF9I405zAyHJexc4rOt0zwciiuar9wbT737nmHuTo2xV5feK7/aHg
 pHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's groundhog day.

MNT_UNBINDABLE used to be set in in mnt->mnt.mnt_flags and was not part
of MNT_INTERNAL_FLAGS. clone_mnt() copied it with all the other flags to
the new mount. This guaranteed that the copy of an unbindable mount
became unbindable as well. Unbindable copies that ended up as shared
lost the unbindable property.

But then commit 406fea799925 ("mount: separate the flags accessed only
under namespace_sem") moved MNT_UNBINDABLE from mnt->mnt.mnt_flags into
mnt->mnt_t_flags as T_UNBINDABLE.

clone_mnt() doesn't copy from mnt_t_flags and specifically doesn't copy
T_UNBINDABLE. The only place a mount gets marked unbindable is in
change_mnt_propagation() for MS_UNBINDABLE.

This reintroduced an earlier bug we had already fixed. It resurfaces in
copy_mnt_ns() which clones unbindable mounts via CL_COPY_UNBINDABLE. So
since v6.17 a mount namespace created via clone(CLONE_NEWNS) or
unshare(CLONE_NEWNS) contain private and bindable copies of every
unbindable mount. The following snippet:

  mount --make-unbindable /mnt
  unshare -m --propagation unchanged
  mount --bind /mnt /tmp/x

succeeds. This used to fail with EINVAL. This also applies to
recursively binding a tree that contains an unbindable the mount. Such
subtrees used to be pruned when they were moved onto a shared mount.

And Documentation/filesystems/sharedsubtree.rst still says that the copy
of an unbindable mount is unbindable.

So once again let's fix this. Copy T_UNBINDABLE in clone_mnt(). Let
set_mnt_shared() mask it off whenever a mount is made shared.
This restores what the old MNT_INTERNAL_FLAGS mask did.

Fixes: 406fea799925 ("mount: separate the flags accessed only under namespace_sem")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 580877e46b1a..a052f847c5df 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1254,6 +1254,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 
 	mnt->mnt.mnt_flags = READ_ONCE(old->mnt.mnt_flags) &
 			     ~MNT_INTERNAL_FLAGS;
+	mnt->mnt_t_flags = old->mnt_t_flags & T_UNBINDABLE;
 
 	if (flag & (CL_SLAVE | CL_PRIVATE))
 		mnt->mnt_group_id = 0; /* not a peer of original */

-- 
2.53.0

