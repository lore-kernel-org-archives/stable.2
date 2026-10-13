Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AEA541E62
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933280; cv=none; b=b3JhFnSub0Ci+GXd+ckHqGGst+9I0VGujOsUfGweJdGXuaBjBw5zP2A3s7lmVnQn0G7uGSYlD415tMCDMFd9EBnpOEdv2nCpzQbaMnz44T88RLHw4IUVX8HKP9UmtzPTVw1xPGUXOkSYNF8CjcA67+INZBN23f08NnmYTrF1j4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933280; c=relaxed/simple;
	bh=DC42cWd2trpkC3wxiUy1rcWuGzrdo7MnCskLH/OFWU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTuCUqIUrRTzPFAGHcvXlgJwmdNvy3fwZRvB4R0vQwhkIVFia6cacTmd+tSdwO0KOWmHqtaja8AerY02Qa9HG5J8/1ySMozM0bxWto6UOb5DO4SQhSUPXhCkTAS6DIxqMTF/0hJTjCBU8y+frYEScyEoq8eyhL5Zb/M4XelEIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YazW4scO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YazW4scO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E101F0089B;
	Tue, 13 Oct 2026 23:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791933279;
	bh=AH4fBKAgmnByv5N9xi6rG4qDFmjGB+AipYU2dyW8K3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YazW4scOeYi/Tgdy4V4B04s1RBBM1uEORfTSrbi//YqcG3Vc4SssbX4V0I/bpX7sm
	 8K9iSTF9U38mfFp6wShO99OJYopzIdb+DGlU2wK4CA/OzO9RiIikO0ONLBZdcP7IAS
	 uVDKZvGbZ8tFGm4BzCoojoHhzYMu6+G+joTnzHOQRlGimgNqF+KsTYyzZfP3c/hJlr
	 r+mgf+8Xw8/ZQeTl5m6vSkw0DBMj35JM70QvS9c3HSZM8qxnBqVg87ohsglY38/Yj1
	 V8iMDw/ery+0/THWSLFBmXx/TM1cqXMy6NsyhoU6Vc1sc91nVHvFOh2uJDQGrxA3ca
	 jd4LI9vR7IsWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] namespace: don't copy an unmounted mount tree
Date: Tue, 13 Oct 2026 19:14:38 -0400
Message-ID: <20261013231421.1476273-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101252-skimmed-repossess-aea1@gregkh>
References: <2026101252-skimmed-repossess-aea1@gregkh>
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
[ sashal: adjusted context for the inline mount check instead of may_copy_tree() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 769f22c0bc66d..66fcf3ec886b8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2360,6 +2360,9 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
 		return mnt;
 
+	if (recurse && !old->mnt_ns)
+		return ERR_PTR(-EINVAL);
+
 	if (!recurse && has_locked_children(old, old_path->dentry))
 		return mnt;
 
-- 
2.53.0

