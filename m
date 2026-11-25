Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608292;
	b=kAHrK6lbTd5aYwEiDpMU2SXvazCXV/lBbsdxUkngwlUyj+TKD1HeCV1rMCT0Im+/K9lG
	 SR4ycMf+L8EuXFlArZBvXtFYupwCLJDmqYdX3bWHkZeVxFzBm1O/QzVOKhpabzArbdTFn
	 r7SdVDYTnCYnNU+VGPU5qEMnI6dlqE5/u+YTpsTOldgyPGQNQLhSWishvNlYequ395Xsz
	 jD6j478aQGfrnumRlOhHjhfFU1KYjYEdCA1QJdBgERep7Jo7i+2ITf+eKVPlMK7ncSPGS
	 BGh5baSYbbGVuUI5hVRGPzXUL2hcjcWmtSFv+KecQ4guYGD2FE8lR3p/Tib+z8yyEAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608292;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PghfIw5FkDOWeuIpOC4fp+g5iHrz81XWJyRUzrTRwCA=;
	b=gaSstFq5EOXs24G9zB4Qw2GCph8eORHVNCw6VglJAwCDzpvSobVO5nBlhoVr07mhxQdq
	 Kp9nxf/mqyQU3Ll1+qTjzlrLDj9AM3kbmt1YNFvc0nLqd6Ofg3W25GXrY+bkjZee9oez3
	 3vryCeUpe91xoO5dsBvxZT+kaX/Ured3bAGSS6WI4fAZ/jHHC1FDAlzMGP4zttoEHS07B
	 i5rjm6D7xxbyyewDPj2wYDDM/r7GnpEKM5Mk6zGdQ5/Yw0iUWN+K+TaLmhtfo73kJGjE7
	 hwc0+GGD+g4tNTtLcfsLofWtc2q+/bAKtySGJ92Jua5y23AV68XqlSnbnxw9bbHcxmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=le6mXG5g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B5606A31E;
	Wed, 25 Nov 2026 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=le6mXG5g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1685B1F000D1;
	Wed, 25 Nov 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608291;
	bh=PghfIw5FkDOWeuIpOC4fp+g5iHrz81XWJyRUzrTRwCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=le6mXG5gFsuHR9GZAlf2bLTFh2WVDklnebyY7jI5vwZxtnG5Wy60JVmlvU+VI6TX7
	 zYxTVaIR+bEhE7JuvPXgRwh0O7Z6OhRZaeAbOmtSjwENOkZt8B0j0/n8sO62cPvx+p
	 GxW+LgQZ6cvEAqY4IewGfo6AGbTGlu0IaNIXq3/P4PloB0J/qVse3QYlnnLA/uibb9
	 KHiK746SDEIleDq7sBIrJgOLOgAtAIxX4vV9UwPaN1S3DpMSeGQ/h+k8VQ6FbEhteF
	 oUVbylCEobt9lqLStwTFOwB3GqQ3DU4MJIsa6PHlZbBHNRrPWlO7UR6vLiYvfBrz4V
	 krNRwfONwyg0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 25 Nov 2026 13:04:27 +0100
Subject: [PATCH 1/2] libfs: don't copy the child's ctime to the parent
 directory
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-work-libfs-mgtime-v1-1-8022a81d0b9e@kernel.org>
References: <20261125-work-libfs-mgtime-v1-0-8022a81d0b9e@kernel.org>
In-Reply-To: <20261125-work-libfs-mgtime-v1-0-8022a81d0b9e@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ydmLsipCJR9WepNKTHyAeGjqs+DJAXxw0rk3lS/y+zE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSznbt1OHrFxUulpfsWblwxae+9E6d5OZXf3Arf8+cVx
 +MZGydMndxRysIgxsUgK6bI4tBuEi63nKdis1GmBswcViaQIQxcnAIwkeabjAwrmT2MHxxmm25l
 8omziUWI4z2DcfPspo9JfQaqJUv3vGJnZNilbyo/K3Xqbo5HZ278Ondox5WVjnvbp0RcdI1u7Vi
 uOIsFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

simple_link() and __simple_unlink() copy the child's new ctime into the
parent directory. With multigrain timestamps that ctime is only
fine-grained if the child was queried and copying it drops the parent's
I_CTIME_QUERIED flag. So a queried tmpfs directory keeps its ctime and
mtime across link(), unlink() and rmdir() as long as the coarse clock
hasn't ticked. shmem_rename2() unlinks the victim of a rename the same
way, so a rename over an entry from another directory changes nothing
at all that userspace could see, size and link count included.

Give the directory its own inode_set_ctime_current() call.

Fixes: 234d8895e3ad ("tmpfs: add support for multigrain timestamps")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/libfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 96a6e9b1535fb..07331e829c133 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -754,8 +754,8 @@ int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *den
 {
 	struct inode *inode = d_inode(old_dentry);
 
-	inode_set_mtime_to_ts(dir,
-			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+	inode_set_ctime_current(inode);
 	inc_nlink(inode);
 	ihold(inode);
 	d_make_persistent(dentry, inode);
@@ -788,8 +788,8 @@ void __simple_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	inode_set_mtime_to_ts(dir,
-			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
+	inode_set_ctime_current(inode);
 	drop_nlink(inode);
 }
 EXPORT_SYMBOL(__simple_unlink);

-- 
2.53.0

