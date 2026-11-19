Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094728;
	b=mjyMA/2GEHmIlbBBEw6gMUQ2P43zDU4JDhOaq2OlTwkt01qbXsxUgzbGsv/7dZU+56s8
	 OYSG/khIOCEGnobJmBiMXXiJPTyJtbvZtsdTUVO80LoEchwh/gle6ABX5HUJygnVm/btE
	 EoSyBaRVFeUoW+jsjc9rHADT9XcWLRWc3vPxWtjKIEMdv+ibWnjHXAVZRgMhyDsEhW6J5
	 hK81sb5g4ayEqwa/TGzj0fyp1umrAvGyFil9MHimI382C21557HQ6UMLg69dVhKqQSZJG
	 9oBo/jNsQAApdmpU3lfiZ/i0y0MLTrAv9ki1ukhcocGArwXgyHIKeSJmEQmlaDCz2zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094728;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=asmzVKl6VjZXqyUMQcsnnGy/M5UxrAuHCwO9nkITWKg=;
	b=zW9Idm355Ofj39oHAR4fhGoVFS3rUSkFZ78P7klssz+WLyFDiVcG0gl5bL1AG6o3tmWK
	 Z0smPdOhwzO3AEliRZPvtWRqBKBQhS3ko/XR+GKD5rEenKRtuoJIvlJw+b/kqAcmORVxv
	 BJ3kq31aRdwY6p5gBgIeByvbfQv8reINIVtTp263+EPqfEj0x63bIdwSn3KruzRvt/4iU
	 7K6QIepwflTenqdJjNSzqt7aYWGOeeGUot3ad71k3OG9tLdlZ3m5GCtDnk640a0KWjgKN
	 +v4tgsIOr3Vbz1TL7fl66hoq2CEOKA/rKK1gARcx9QHYilWz8C27ZkE+IAqV/vkvBmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JHA/QDas";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37860A263F;
	Thu, 19 Nov 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHA/QDas
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2371F000C9;
	Thu, 19 Nov 2026 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795094728;
	bh=asmzVKl6VjZXqyUMQcsnnGy/M5UxrAuHCwO9nkITWKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JHA/QDasI7qkyLvRhzfhjUtjNTh+srHQLIqdAS/FA949RuGHdkO1ngj7DeBwUeiMO
	 gI154b53nztuycz8rFqnWyYYNNtv1Dv9Z2kTEFX2AOmydOjwJzj5nn/SIoPYnjz2CX
	 F7LjkS+LfJfNMEmGXtYmgTFrMlzva53JQEe5yEOtDxU1mBLm8rEgJFUfgE8++BbNgr
	 fkrCUdi2i2mzxK06FLUKburbDhpBa8h9znqgxfxWkuldBYmVxOOEGi44nBeCNzyIeO
	 x1e99MdnM1k4/7hVnmYO88tcZed12iaVRF5C5ciSWBKD+yKXorJW5OIWBlnL5Y1t39
	 OA+rJ00KQZ0rg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 19 Nov 2026 14:25:02 +0100
Subject: [PATCH 2/2] fs: don't reset userspace_init_fs when PID 1 stops
 sharing it
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
Message-Id: <20261119-work-fs-pid1_unshare-v1-2-b6a7e468bd68@kernel.org>
References: <20261119-work-fs-pid1_unshare-v1-0-b6a7e468bd68@kernel.org>
In-Reply-To: <20261119-work-fs-pid1_unshare-v1-0-b6a7e468bd68@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Akisaira <akisaira@outlook.com>, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=4860; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r/00EL6FbLgCa8L/wM1EanNSfj22DeZcL/B8qrXXWGU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9+7Hf8g/PpooDE3Vf2JdIbeqe5Cwo3We33yt5+6XZr
 wt/zznb2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRmhJGhv45MVOOHJYImfVg
 1fO3U25yOT7cuvGbteSk6gX/uwqnLOtn+O999Ei7+exNkio6tq/S9y2YOOc/r7yvX4LeQhVRsfO
 JYkwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In Android's second stage init StartPropertyService() spawns two
threads. They share PID 1's fs_struct via CLONE_FS. So they share
userspace_init_fs. Afterwards SetupMountNamespaces() calls
unshare(CLONE_NEWNS) on the main thread to create a second mount
namespace and setns()s right back into the initial mount namespace.
unshare(CLONE_NEWNS) implies CLONE_FS so PID 1 switches to a private
copy of its fs_struct.

Ever since v7.3 validate_fs_switch() notices that PID 1 stopped sharing
userspace_init_fs and resets root and pwd of userspace_init_fs to
nullfs. But it does that in place and the two property service threads
still use userspace_init_fs. So they suddenly find themselves in nullfs,
libselinux can't open /sys/fs/selinux/access anymore, every property
write is denied and init stalls.

Before commit 14adbd5341aa ("fs: stop sharing fs_struct between
init_task and pid 1") PID 1 shared init_fs with init_task. So
userspace_init_fs was init_fs and the reset was a no-op as the first
stage chroot had already updated init_fs.root.

There are a couple of fixes to not leave stale state behind but it seems
that there is legitimate userspace out there that does need this. So
stop resetting userspace_init_fs for now. I can probably rework this to
something sane but I'm not sure it's worth it. Kthreads and
usermodehelpers keep using what PID 1 left behind, just like they kept
using init_fs before PID 1 got its own fs_struct. Keep the notice
though but downgrade it to pr_info().

Fixes: 9a8e29695888 ("fs: make userspace_init_fs a dynamically-initialized pointer")
Fixes: 14adbd5341aa ("fs: stop sharing fs_struct between init_task and pid 1")
Reported-by: Akisaira <akisaira@outlook.com>
Closes: https://lore.kernel.org/TY4PR01MB14006C85EBAAA186836A6E05CA67A2@TY4PR01MB14006.jpnprd01.prod.outlook.com
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_struct.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 538eaaecbadf5..56dc79b065bd4 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -165,46 +165,24 @@ int unshare_fs_struct(void)
 EXPORT_SYMBOL_GPL(unshare_fs_struct);
 
 /*
- * PID 1 may choose to stop sharing fs_struct state with us.
- * Either via unshare(CLONE_FS) or unshare(CLONE_NEWNS). Of
- * course, PID 1 could have chosen to create arbitrary process
- * trees that all share fs_struct state via CLONE_FS. This is a
- * strong statement: We only care about PID 1 aka the thread-group
- * leader so subthread's fs_struct state doesn't matter.
+ * PID 1 may stop sharing userspace_init_fs via unshare(CLONE_FS) or
+ * unshare(CLONE_NEWNS) which implies CLONE_FS. That doesn't mean it's
+ * done with it. Android's init unshares to create a second mount
+ * namespace and setns()s right back while its threads keep sharing
+ * userspace_init_fs.
  *
- * PID 1 unsharing fs_struct state is a bug. PID 1 relies on
- * various kthreads to be able to perform work based on its
- * fs_struct state. Breaking that contract sucks for both sides.
- * So just don't bother with extra work for this. No sane init
- * system should ever do this.
- *
- * On older kernels if PID 1 unshared its filesystem state with us the
- * kernel simply used the stale fs_struct state implicitly pinning
- * anything that PID 1 had last used. Even if PID 1 might've moved on to
- * some completely different fs_struct state and might've even unmounted
- * the old root.
- *
- * This has hilarious consequences: Think continuing to dump coredump
- * state into an implicitly pinned directory somewhere. Calling random
- * binaries in the old rootfs via usermodehelpers.
- *
- * Be aggressive about this: We simply reject operating on stale
- * fs_struct state by reverting to nullfs. Every kworker that does
- * lookups after this point will fail. Every usermodehelper call will
- * fail. Tough luck but let's be kind and emit a warning to userspace.
+ * So never change userspace_init_fs behind userspace's back. Kthreads
+ * and usermodehelpers keep using what PID 1 left behind, just like
+ * they kept using init_fs before PID 1 got its own fs_struct.
  */
 static inline void validate_fs_switch(struct fs_struct *old_fs)
 {
-	might_sleep();
-
 	if (likely(current->pid != 1))
 		return;
 	/* @old_fs may be dangling but for comparison it's fine */
 	if (old_fs != userspace_init_fs)
 		return;
-	pr_warn("VFS: Pid 1 stopped sharing filesystem state\n");
-	set_fs_root(userspace_init_fs, &init_fs.root);
-	set_fs_pwd(userspace_init_fs, &init_fs.root);
+	pr_info("VFS: Pid 1 stopped sharing filesystem state\n");
 }
 
 struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)

-- 
2.53.0

