Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803062;
	b=iD0ottWD0eNaVqAEyWuGYReNuLwihzyu2djPFbmYm61wq3lV5sffaCfQDxfSow6qmlYU
	 Rpm6KNfQPqutWpenRJZZFXzwvgagVPAYZWJdNVd/ZpZvd8oIuEv0vW6k/98suxIyMLAG/
	 n8xpjd+AhbDnoyVVvCPfhtUGjRdsyQ0ZWhzaSu92oy9I5MzEYluNOW2uLsDyh3dybc1kF
	 aJLfMgOEOjjn9pTxc6C/NwHJsXwtmwp1TvEs2o4omDfV7iXalgjka2EIrZc/BnqLt+jCr
	 4j3U5Ws7DetCNojWpWWfin5ivjWPgAMPNRNqqw8qseCAoTGQ0gATD6c3QD0Tqwjun3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803062;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fmEWIcBLmS0wjOJa7FofB9MGtYl7DqaVQp7bFYD3CrY=;
	b=iccUZTdkDkGJaEK6TDEMJ6425rEW+4SFltHlOQW9Clu/vTUUG6dQGFWT8vOSrXG22MAm
	 ylMOc7icCri6CNTnTo/Qukc9jfu0z+A3wgJaN525iwN6dRARaizXJ6dbUN6K7cbQmo4VK
	 ZgYNdswEwQU0tXblDkLXHRF7zhT0RSPtFOem1DZ+q5PiLhH8ogy57z123tsbT6QT3CKx7
	 nF/YkDThetu3J1cDSzLBgTFcARigMLMUhAGDK1EoIgVWEyMCGAU4kWLwHJNjUADPGka92
	 xTCNDT17zKkqiZN/VJmeKiKXgzhdiQrDHh2eNomfr4HDBzg8A0S8gcFiUM3iaHRpiIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MEugl9Z1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACF606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MEugl9Z1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA0E1F000C1;
	Wed,  4 Nov 2026 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793803062;
	bh=fmEWIcBLmS0wjOJa7FofB9MGtYl7DqaVQp7bFYD3CrY=;
	h=Subject:To:Cc:From:Date;
	b=MEugl9Z19RzvOT/ywk3xno1wdiM8IS6nER/hz7h0lwEYsOL2a1Hi79d3tXRKTfGkQ
	 0NiNZH3oiPs6/CoUHuydW0e/ZSPmX3lOxN7ge+o5e0jpa9oUmqm9bYfj5oNaZ1Qmm1
	 Dv9HZqR8gnStfOG8bkMZhX/+qC3PA6Up9Dv4EspU=
Subject: FAILED: patch "[PATCH] ovl: set the revalidate flags after d_instantiate()" failed to apply to 5.15-stable tree
To: mason@kernel.org,amir73il@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:37:30 +0100
Message-ID: <2026110430-console-huddle-2e1b@gregkh>
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
git cherry-pick -x 75e89c0055c1d7f7eeb462995f11253ca5864f79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110430-console-huddle-2e1b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75e89c0055c1d7f7eeb462995f11253ca5864f79 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Fri, 16 Oct 2026 21:17:23 +0000
Subject: [PATCH] ovl: set the revalidate flags after d_instantiate()

stat() of a file on an overlayfs mount triggers a kernel warning and
fails with ECHILD if another task is creating that file at the same
time. This happens on an overlay with a FUSE upper layer, which is the
layer where overlayfs creates new files. Write access to a directory on
such an overlay is all a user needs to run the two tasks.

The revalidate flags are DCACHE_OP_REVALIDATE and
DCACHE_OP_WEAK_REVALIDATE. They tell path walk to call ->d_revalidate()
or ->d_weak_revalidate() on a dentry, so that the filesystem can check
that the cached dentry is still valid. An overlay dentry only has one of
these flags if a dentry in one of its layers has it. FUSE dentries have
the first one.

When a flag is set on an overlay dentry, path walk calls
ovl_dentry_revalidate_common(). That function only expects a dentry
without an inode in RCU walk, while the dentry is being destroyed. For
such a dentry outside of RCU walk, it hits a WARN_ON() and
returns -ECHILD. So a negative overlay dentry must never have the flags
set.

ovl_instantiate() breaks this rule. When a task creates a file, the
overlay dentry for the new name is hashed but still negative.
ovl_instantiate() then works in this order:

- It copies the flags from the new upper dentry to the overlay dentry.
- It calls ovl_get_inode(), which can sleep in a getxattr request to the
  FUSE server.
- Only then does it call d_instantiate().

A second task that looks up the name between the first step and the last
finds a negative dentry with the flags set and revalidates it.

Reproduced with a FUSE server that delays its getxattr reply: stat() of
a name that was being created hit the WARN_ON() and failed with ECHILD.

Fix this by setting the flags after d_instantiate().

Fixes: bccece1ead36 ("ovl: allow remote upper")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b3f6d4b82f68..f716ac13badf 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -304,7 +304,6 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 	};
 
 	ovl_dentry_set_upper_alias(dentry);
-	ovl_dentry_init_reval(dentry, newdentry, NULL);
 
 	if (!hardlink) {
 		/*
@@ -335,6 +334,13 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 		d_mark_tmpfile(tmpfile, inode);
 
 	d_instantiate(dentry, inode);
+	/*
+	 * Unless it is a tmpfile, the dentry is hashed and a path walk can find
+	 * it at any time.  Set the revalidate flags only now, because
+	 * ovl_dentry_revalidate_common() does not expect them on a negative
+	 * dentry.
+	 */
+	ovl_dentry_init_reval(dentry, ovl_dentry_upper(dentry), NULL);
 	if (inode != oip.newinode) {
 		pr_warn_ratelimited("newly created inode found in cache (%pd2)\n",
 				    dentry);

