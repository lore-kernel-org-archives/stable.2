Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482C3C9898;
	Fri,  2 Oct 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949229; cv=none; b=LF5OiQddDeo5HVuwfJzii3xnRWYaC8O87nYLgpuljUgzEjLCJzyWsuF1J6eN8sRBqGLeH3EBHqz98mpk9dooDycx+ORSGRxgG9GxPBsjRoWr1/VE3QZgjbjpyH7dwKczHkvabsZnZ0g2F/o1UuefxvIwDel4SJm9ibAcK1fBkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949229; c=relaxed/simple;
	bh=bpVF2vzxnC9UuJ5wQ8y0TdSxVqkYccvf1spr+1439Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVYX2vzAW2YelGBECzQIq7n5F+kLXvvhtPD5OQ173pAZzEhGWVeNftPipziuIykOZRJbSAE0L6s45W1OmsCV4P+aPI52pWJgxFLQnwgBhQmfw6xGBCnu/NnwATX+ajchcQNnR2CTnHvv3WlwHQSoZr9p4HwOM0d35XSRbXsu4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMkcqeF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMkcqeF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1E71F00893;
	Fri,  2 Oct 2026 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949228;
	bh=xRS12I8i6LwnLlWoJBt9OJ+eOL+UP3qYqo2iJhp7Iog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LMkcqeF+GEX7RKvafnhIITEJAHNNnbnJgf5Rp/RvBPuKQvjpeBD4HPfPr4L232riN
	 knHFzd8u5iRsHovTaGxDn4hiLbiw6CQunuHo3JnZ0LkVwiR8gatNPMmvOWGExRkv7W
	 kq6aDnUajEDyh4UF9VgAW58L6y45Ysfx9gFe4TAy/8/PoFD/fKMSuy7C6H1loNyVI9
	 1LbmUaAvvTECf1P8ASZpOUXhjzxGEwV0OgZp3HIOhMt24LMCpnrWr/JOpdG6TkGrB2
	 zY8UbwIoAcgPRQNfNnvUQ+R4ztYe+rXxcVgTGN+SAVahOJGH4g4YdWfS5LiYMYYmrP
	 zfscdPl6237Xw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:36 +0200
Subject: [PATCH 05/21] namespace: refuse an automount below a mount that is
 in no namespace
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-5-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bpVF2vzxnC9UuJ5wQ8y0TdSxVqkYccvf1spr+1439Tc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x7Z4Nl78/aGhN7sZ7s0XXR3mL3ka+fzqGMUfl8lP
 NuS6Ux0RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETuvGdk+H1rZbbHN35h2ZU9
 ap6r/8RMn/kku1L61489gfEZNzdnyDH8Dz37v0DLwjSIvS/ZN1Ynyqf9tMqirZbXlqklfjTacH0
 lJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's possible to add autmounts even when the parent mount isn't in the
mount namespace of the caller. The only requirement we have is that the
parent mount namespace must not be NULL, i.e., unmounted.

Problem is that clone_private_mount() has MNT_NS_INTERNAL which makes
that trivially true. So that passes the test and attach_recursive_mnt()
accepts that as a mount point and funny enough, count_mounts()
dereferences MNT_NS_INTERNAL. The problem is it is an error pointer...

So we can reach this in userspace via fanotify. A filesystem mark on the
lower filesystem of an overlay reports paths on the layer clone and
reading the event hands out a descriptor on it. For example with debugfs
as the lower layer it goes kaboom:

  openat(evfd, "tracing", O_DIRECTORY)

  Oops: general protection fault
  KASAN: null-ptr-deref in range [0x1d0-0x1d7]
  RIP: 0010:count_mounts+0x35/0x200
   attach_recursive_mnt
   finish_automount

And since that sleeping beauty happens under namespace_sem held for
writing every mount operation on the system blocks from then on.
Congrats.

Use is_mounted() instead which rejects unmounted and internal mounts
alike. The open fails with EINVAL just as it did before
clone_private_mount() used MNT_NS_INTERNAL.

Fixes: df820f8de4e4 ("ovl: make private mounts longterm")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e576a5d6eff0..60b57572fc64 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3806,7 +3806,7 @@ static int do_add_mount(struct mount *newmnt, const struct pinned_mountpoint *mp
 		if (!(mnt_flags & MNT_SHRINKABLE))
 			return -EINVAL;
 		/* ... and for those we'd better have mountpoint still alive */
-		if (!parent->mnt_ns)
+		if (!is_mounted(&parent->mnt))
 			return -EINVAL;
 	}
 

-- 
2.53.0

