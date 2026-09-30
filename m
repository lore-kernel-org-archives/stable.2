Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB14E5348;
	Wed, 30 Sep 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775152; cv=none; b=BetvpmAa9VU0jJmR041/u2WjwNHyitbVUUzsEi7eyQPWLSPZpTH99K7Oo0R8zYsvYxRX/Y1k/if3V9drIC6eM6qDnzxGi0UQRkyaJpYOiyUQ4Jv3GhM41x1K7xQQDqdX3gJneaBakg4DkO3Ku6TzaEL9P7+DUKT2/65cAAqxan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775152; c=relaxed/simple;
	bh=UxK8bF3qt3vbFG3KEzARNWH1Fiwn96FqixHkj03EydE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/aqluChBwwq8PuGrS6ZINFddqsmi2QF3z35sOn46Q8V0HdT7NkZPIdvaNVQwenTStXLPfP6hmqm0mqgXx/rn8SL85IEzako5xMH8a2su0JhfttCBtigOrhaaNf2eDPDFWqkaBv4UPYqoKAH4T1iDki8QzQVe5H+f6LcvhbNoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu9ZSlzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu9ZSlzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379FD1F00898;
	Wed, 30 Sep 2026 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775146;
	bh=waWOdSbMYqNtmIsW0w2o6IOHyUiuTupxL9Y+LD2XK+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Fu9ZSlzATtCAUBAt52BQEkl183Jpz6s5A3jgak0MrGSLD2/9HzmUDMKEnv1a4mUqu
	 7gPoIu5a/SyVpEzRO4E64exkz0ZYRjpJGR6Nx/CsA+sL85bnZTGkLqTmEuR78pzlM2
	 qKxPZwynrZTHCjY2MhR/Rmt3o7sGifAAprcf4Bq5uGGJsDpdAyp4mfPDHQLkekJmze
	 Qsyb9tOb4vc3+dQdpahdWTDs7DbYW58MCEKBPddUzHmWyNmpk7THid7oVnrqIVXn2c
	 C8ubT1AJVAXuna6Hp8NT0C/9PsOh+6sSZuPFR1nLjrVbVzHzKq06uM7f02ZJ/L7eb2
	 wjsQ9zNTarhdw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:00 +0200
Subject: [PATCH 08/17] namespace: look at the topmost mount for a mount
 namespace file
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-8-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UxK8bF3qt3vbFG3KEzARNWH1Fiwn96FqixHkj03EydE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5fcvjzvYoXLCQ6XMtH4uJ2czu5WfUdM8x4VNz4pcs
 qqFS0U7SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJuI4m5HhikHlE9OTh14szQox
 8Xuwn7fV/Oyr6E2esocib2XYO34/ysjQ/Kfxw4mZl1QrfXPt2p46zmIP3agZ1Oa4UfXi7EM5ter
 MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

attach_recursive_mnt() preallocates a mountpoint for the root of the
topmost mount of the source so that a mount that already sits at the
destination can be put on top of the source or on top of one of its
propagated copies.

The copies are made without CL_COPY_MNT_NS_FILE so their chain of
overmounts is shorter than the source's. It ends below the first bind
mount of a mount namespace file. So while the loop walks up the chain of
the source it remembers the mountpoint of that mount in "shorter" and
the existing mount is put there for the copies.

But the loop ends at the topmost mount without ever looking at it. If
the topmost mount is the only mount namespace file in the chain
"shorter" stays NULL and mnt_change_mountpoint() attaches the existing
mount of the copy below the root of the mount namespace file. That's a
dentry of nsfs. No path walk in the copy's mount namespace ever gets
there. The mount is gone until its parent goes and the copy that took
its place can't be unmounted synchronously because it has a child:

  S      bind mount of a file
  N      bind mount of a mount namespace file on top of S
  A      shared mount, B a slave of A, Q mounted on B/file

  move_mount(S, A/file)
  cat B/file          -> the content of S instead of Q
  umount B/file       -> EBUSY

Look at every mount of the chain including the topmost one.

Fixes: 96f5d2e05165 ("attach_recursive_mnt(): unify the mnt_change_mountpoint() logics")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index de3900dd02f6..f66f4609ef9d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2617,9 +2617,11 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	 * Preallocate a mountpoint in case the new mounts need to be
 	 * mounted beneath mounts on the same mountpoint.
 	 */
-	for (top = source_mnt; unlikely(top->overmount); top = top->overmount) {
+	for (top = source_mnt; ; top = top->overmount) {
 		if (!shorter && is_mnt_ns_file(top->mnt.mnt_root))
 			shorter = top->mnt_mp;
+		if (likely(!top->overmount))
+			break;
 	}
 	err = get_mountpoint(top->mnt.mnt_root, &root);
 	if (err)

-- 
2.53.0

