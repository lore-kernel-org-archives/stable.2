Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802904;
	b=4RRkAhoVoVyn3wMFNQsk/Nr7UUFtQmu0QJW4KBYrsNCjKlJveSzBHW2ajaahfp6+kEP7
	 ArxGmjdoQdh10Hu7NqkcVkU/YP3O/luiA9Az+vJKrXWvLa8FFIydI5EEhLP7yRCCvXbHp
	 LoqKTmNZN5lzvfLGC0ehBGpDC72cPUrew9JPT8M4L1v7FUCg2cOEVG5tvoUmd3LOiAyRk
	 PCFTvPQlQhxqOmWDCoS9bJKtWB4dtPKELP5LNC8BoBlpdxjFZSfUik4HwwNJufB+PE1Mf
	 pzrixOQJ+mJSpI87weDB4HJGme+h2eQovuXxNDlWYfQYoi+b3Zt/3tJt7uyvI2TlnKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802904;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I/kaN3LGjSpNQn77iPrUgWp/1cx0Le77/h6IPn97OWk=;
	b=rOyVxboXnLFKtr9Y0mbWy/xrl1XxmJyEwgRkHlUocE4qe3w/CX0m62wplv7suQiHsj3v
	 NMOi8ej6Vy+8Gc6hF9oz7XpM5qTVwMxd+RlwaW6H/YPP3982q/Mpku3xmQ+9gr8u/MNZ8
	 OIkaKtc165kQ27k6WPvuswMqI8MQ4Wivz22Pyg0Z5mD9UvZq5Vnstw0AivBpDBqejmgDL
	 RMBkY+dM/QmLiqbvfuyn3+zN2r6I3MgArqgOYOzbYdBJzk/Eg9gFu/QHwO8ZOCb/cYl/A
	 YdO4gydKiSHqi1gvBY31aYbknooRHYtINV1SFXVHZoRvQTqgeAKu1MQcnRztKAtRpJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nRLK5128;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E3606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nRLK5128
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6CB1F000C1;
	Wed,  4 Nov 2026 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802904;
	bh=I/kaN3LGjSpNQn77iPrUgWp/1cx0Le77/h6IPn97OWk=;
	h=Subject:To:Cc:From:Date;
	b=nRLK5128cDN4Hqz59O1ANH/nqVJQn4QVyI0CB6hcRMyOhWCaLf/VyWwkM+GBW8R3x
	 PCqsXwgbZYoCwVu1Y73tIWUDkAnK4n8xiVOtHHAZqrH4Ydf+tjEKPtTEa+XU558olK
	 d/OJoqaiVa7RSG83AYJ2aQ3n7kLbmeQOSqSNp9Cc=
Subject: FAILED: patch "[PATCH] ovl: set OVL_WHITEOUTS before publishing the upper dir" failed to apply to 5.15-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:35:01 +0100
Message-ID: <2026110401-photo-throwing-2a3a@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cbec8610ec5aaf35df50094ff639febc23f20773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-photo-throwing-2a3a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

