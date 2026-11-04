Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804765;
	b=idrIFJR+FgnGNdMjLQ2Y6vui6aWGNi4S1cp4TzlEFfVJcQEuFWRa0eYDZwKvT/dkgk/G
	 chuqjCt7Lan2BDuTJumAvLqGbAH3k11yx1Xa+hirSh5PUzhbeuTq5IlUKcInroN27tj+z
	 CH/loyfQKBVvkssSIpehMsbm2eizQQRCpFbwtfMcS6ruCIGVrg95twz3n+rfw3d6DM95E
	 MZmQUoDofJwei34wKTN7tp14wQbjuada5uighR9VFKITqNi2bi282m7Z6MEg51LQwriMP
	 gMv9gFPj5/Ouo3foHM+j5aObFB5MIyYzKvdrmafCajbG0A8TQ1iJY0uwQV2zq9gRtcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804765;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9EajEXcJU3wX04xAb92gkG8x2pcZYsziAmTaXGodNwg=;
	b=pssqZH5agt+NMWUvF9bMzUXM/Q7EnXlXK9nem9oJHmJGxjmO2QAYoOMGDJApfpv1eWNo
	 iP3xSVkqDuTRgt/ahF+RtNlE7TLkyQxhUYLlZ/aKNWP+70p0Xo76VuOHfZmj0qB2LGTbQ
	 F39BGYpxIgTx1P2FmYgUGzUtSZNeepHnrqFJek+6km97odc+5Ua+aJn8xe1wEa4MJ+Trh
	 JHubDejDILJ9MZYmH8sgxHWVtU5N/vnrU0ssn4mzgDRQRVZG3hAwWXaqfbK2YAhmjrl+o
	 mifCGo6+9w14X8i5y2gzskxcEiKfk4Cj4PFRuVPmevbJyF2rN0UlD0ufTsZRE462COA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JgONsgeL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCB3606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JgONsgeL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5DD1F000C1;
	Wed,  4 Nov 2026 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793804764;
	bh=9EajEXcJU3wX04xAb92gkG8x2pcZYsziAmTaXGodNwg=;
	h=Subject:To:Cc:From:Date;
	b=JgONsgeLFORVQv03ZVDWrMDhgspmh7PCCg/hN06dQfWhuN5+Cd6NKbWLLgSh668UQ
	 LSypF0zrHiXLToF6FKDTG7aDHygNBDA9jpkrbgIOqRBTAOtvA/jIENoLgdvbaza6SB
	 H6MiG/oaeaL56VCEv5l+OJeKyQAr/Mm8y52STPfg=
Subject: FAILED: patch "[PATCH] ovl: do not take a name snapshot in RCU walk" failed to apply to 7.3-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:06:02 +0100
Message-ID: <2026110402-unmasked-crown-b7f9@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 0b691c3c59a58aa6a2fc3f87c10cc1e399f1d33f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110402-unmasked-crown-b7f9@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b691c3c59a58aa6a2fc3f87c10cc1e399f1d33f Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:38:39 +0000
Subject: [PATCH] ovl: do not take a name snapshot in RCU walk

A path lookup on an overlay over FUSE loops in the kernel for ever and
stalls RCU.

take_dentry_name_snapshot() needs a dentry that the caller keeps alive,
because for a dead dentry the refcount of an external name stays at
zero and the function retries without end. In RCU walk
ovl_revalidate_real() holds no reference on the real dentry, and the
eviction of the overlay inode on another CPU can drop the last one.

With a delay in ovl_revalidate_real(), a stat() loop on a 48 byte name
in an overlay over FUSE, raced with drop_caches, spun for ever in
take_dentry_name_snapshot() and stalled RCU.

Fix this by using try_take_dentry_name_snapshot() in RCU walk, and by
returning -ECHILD when it fails.

Fixes: 5be1fa8abd7b ("Pass parent directory inode and expected name to ->d_revalidate()")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use try_take_dentry_name_snapshot() instead of open coded snapshot]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 18f56d463572..cc4b0959faf6 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -100,11 +100,17 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 			dir = d_inode_rcu(parent);
 			if (!dir)
 				return -ECHILD;
+			/*
+			 * Nothing pins d in RCU walk: eviction of the overlay
+			 * inode may drop the last reference at any time.
+			 */
+			if (!try_take_dentry_name_snapshot(&n, d))
+				return -ECHILD;
 		} else {
 			parent = dget_parent(d);
 			dir = d_inode(parent);
+			take_dentry_name_snapshot(&n, d);
 		}
-		take_dentry_name_snapshot(&n, d);
 		ret = d->d_op->d_revalidate(dir, &n.name, d, flags);
 		release_dentry_name_snapshot(&n);
 		if (!(flags & LOOKUP_RCU))

