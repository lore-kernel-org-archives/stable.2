Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802903;
	b=v5PgCGossvV83FTskaD0XGhi0A1p3daJhwNTsWUppHhqsefmHaMNTjGKxZR7f6WrJPHe
	 bVUguprdDhgxvRaov/nfv9cvFcSvsA+G1dbYANyvetz6aoHBmRrfM+B64KCm98R9Hklzg
	 YK4mH092qdy4RL0dNNpGm0Fq0ryv1jpOCPOxVLqakRQFsAw/tNs1YoMyZFrqcPN2LxtX6
	 8p7mvgVVGr0xIXPXDHnp1Z6/cfYjx7b5WtuE7bc1YNB3azhpwHM9afcqJ0rcELpjhDP1P
	 br5J0uXZxeRzrEZcDbpwGsGX2mvxR2YIpl3vbBQozr/BP+samgZKf0dmZBhe7Bafxjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802903;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y7CrHQ4ti0GM6O92gqLtke41Pg0gFDotl6e7h40owX4=;
	b=FNeNysrejprYdotemo564QibcwlGLpsvdr2uQE5CP6C8cRDXupQImejz/ywWN5bbsqif
	 YhEmIqPPyL2/zUUhFXojDgRcSq4EqibJ84sMj2ORPJSPenHJymcC4jKxvnVFG/CJOTf44
	 cx9y0EkEbKDxZmu27tXEiDyG6Vp3P0wB23C2dOxjoBaQwYT5vHL7VVszEbsmIbQZm/h+g
	 BI26p8XXlXRP5s1RGQprj0CDyh/IUBvXctlrLEq03cmP3bFb2lD6vDl37G0QImsJ56BpW
	 tqpD/hqfVhLTDjT0LPMdHP5e3S/il+5JbpWPKDR3jgodoZ9sjtWJIKrKpz+vM3ivhFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="XNEXVX/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F277606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XNEXVX/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2401F000C1;
	Wed,  4 Nov 2026 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802903;
	bh=Y7CrHQ4ti0GM6O92gqLtke41Pg0gFDotl6e7h40owX4=;
	h=Subject:To:Cc:From:Date;
	b=XNEXVX/3jTglP7tpLTgesd30hW3dhpb2X/Gk8Wz8paUTjV6IcUdzIkDgjFZ5FSg5M
	 sfzgDpBqn/GKDbkcJQ/wmsFHQFR1pK0CP95XYG5wPe5LIfWm72qwupK0pf3Bv7vNcy
	 WOx4d1GzQ3kBTjRX0wugFSTSVSpZp+VUS8rql1LM=
Subject: FAILED: patch "[PATCH] ovl: set OVL_WHITEOUTS before publishing the upper dir" failed to apply to 6.1-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:35:01 +0100
Message-ID: <2026110401-mammogram-henna-1edc@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cbec8610ec5aaf35df50094ff639febc23f20773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-mammogram-henna-1edc@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cbec8610ec5aaf35df50094ff639febc23f20773 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:01:19 +0000
Subject: [PATCH] ovl: set OVL_WHITEOUTS before publishing the upper dir

Listing a directory while it is copied up causes a use-after-free of
the readdir cache.

A merge directory must never be iterated as a real upper directory:
that mode frees the cache in OVL_I(inode)->cache without looking at
its refcount, while files opened in merged mode still use it.
ovl_copy_up_workdir() publishes the upper dentry before it sets
OVL_WHITEOUTS, and ovl_dir_open() samples both without a lock, so an
open between the two stores finds the upper directory and takes it
for a real one.

With a delay between the two stores, an unprivileged process that
listed a directory during its copy-up saw only "." and "..", and its
next getdents freed the readdir cache of another descriptor.

Fix this by setting OVL_WHITEOUTS before ovl_inode_update(), so that
ovl_dir_reset() agrees with ovl_dir_open(), and by testing
OVL_TYPE_MERGE() of the path type in ovl_dir_open(), so that an open
that observes the upper dentry never iterates a merge dir as a real
dir, regardless of the order in which it observes the flag.

Fixes: b79e05aaa166 ("ovl: no direct iteration for dir with origin xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: test OVL_TYPE_MERGE() instead of smp_rmb() in ovl_dir_open()]
Link: https://lore.kernel.org/linux-unionfs/CAOQ4uxh-1J2OBjnDVbrrrjy1puSOW0kABvghN85ih6dtKUBTyA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index eee22581b14f..92b3d08a0234 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -819,9 +819,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(inode);
-	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+	ovl_inode_update(inode, temp);
 out:
 	ovl_end_write(c->dentry);
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 7d6f7f6022eb..ba542a192012 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1055,7 +1055,8 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 		return PTR_ERR(realfile);
 	}
 	od->realfile = realfile;
-	od->is_real = ovl_dir_is_real(inode);
+	od->is_real = !OVL_TYPE_MERGE(type) &&
+		      !ovl_test_flag(OVL_WHITEOUTS, inode);
 	od->is_upper = OVL_TYPE_UPPER(type);
 	file->private_data = od;
 

