Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802981;
	b=zr/V4MNVKckOdTGWuGiJGl6bpUTBufRZhYPEiWSxzaH04wkwWVXal7XqOjSsSXqpMwgt
	 wjs+iI2dWluJH2tHKdCWUN0GUAKyriZXh82BFAa4CWkZGCRzsJ8sX0pze+mR3ErG/bIRI
	 RUABQHte1pZsifsHCExjhBZxp4g1h1Q0dAndSmfGWDwcDP2rwEVDut/1GP1YiwpBZO/hc
	 gdNxIwhp4JDCAhi5U0a2sJBolF7A5/YDfp5+H3koZEnvUpWIESEydbK+NmMLRbM+Ui3UJ
	 QAt6TImkgxt0VOrwyFiQ8JohQP1L+Mkq8QJCb8VgTT+rtql+DztL7wTCOd0PqYDS7Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802981;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BH4zBaYC81rKvrXdCXqCp5r8Uml6k1FAfAdgKb6xwLo=;
	b=J+BGi36MwS1STrnsr2Pu7RbxQj43YBldDrjzLCoxpYcIyzFxVFmc11NWABNaWDxTvSme
	 5eaRHh7HehcN5smmDlXqdoHOfbT42kOWn9TS5Qz5ja1FnoXcm7t4J/l/is7rfGUJzAzGn
	 LdrRUGpFX4vTJ87MrbAK+IkSrAlIqDCZq7tKs/YIVUfxMKTEqCEK7Eb8wSUP/35qe9Hi6
	 dPZtdyZtv7Jh8d85FRSBElv2++bh/yHdSu9gOj05rxUFvSmfSpUm3WjVfyTzoBstvscjL
	 gRfXNabqXcSq5xZSUEXQmWnsDQoKZ8sThug/ZrNlhwRO9VENHZ5FnI6sQBqA4vf1KOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UdFoCGl9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20E606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UdFoCGl9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA5C1F00919;
	Wed,  4 Nov 2026 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802980;
	bh=BH4zBaYC81rKvrXdCXqCp5r8Uml6k1FAfAdgKb6xwLo=;
	h=Subject:To:Cc:From:Date;
	b=UdFoCGl9X/OOpFxl0CejUv7skKyG9Gulc2J5NVbqIajA0rw2K0RDqrFtXN4gbN2Cz
	 AgLXyTPUwPU/dqUdm1EQZwSUNWh1iUgzXUu1nUNEdOuGloCKuYjzw3VCKbwRffXOf1
	 inAbi76CxM31SkrLAZ9no6ZX5jnz/LQnVxFgXDY4=
Subject: FAILED: patch "[PATCH] ovl: do not copy up an xattr value that was never read" failed to apply to 5.15-stable tree
To: mason@kernel.org,amir73il@gmail.com,fahad@codepure.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:36:19 +0100
Message-ID: <2026110419-skeptic-dictation-d90e@gregkh>
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
git cherry-pick -x 755b5c5c9277be251a51623d6065abab948c61bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110419-skeptic-dictation-d90e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 755b5c5c9277be251a51623d6065abab948c61bc Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 09:45:28 +0000
Subject: [PATCH] ovl: do not copy up an xattr value that was never read

Copy-up stores uninitialized kernel memory in an xattr of the upper
file, where the user can read it.

ovl_copy_xattr() may only pass bytes to ovl_do_setxattr() that
ovl_do_getxattr() has read. When the read fails with -ERANGE the
function asks for the size again, and if the new size fits the buffer
it stores the buffer although nothing was read into it. The buffer
comes from kvmalloc(), or it still holds the value of the previous
xattr.

A FUSE lower layer that answers every sized GETXATTR with -ERANGE made
copy-up store 4096 bytes that the server never sent, with a kernel
pointer in them, as an xattr of the upper file.

Fix this by failing the copy-up with -EIO when the size that follows
-ERANGE fits the buffer.

Reported-by: Fahad Alharbi <fahad@codepure.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com/
Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e963701b4c87..c220cb5d0b70 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -131,8 +131,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
-		if (size == -ERANGE)
+		if (size == -ERANGE) {
 			size = ovl_do_getxattr(oldpath, name, NULL, 0);
+			/* Nothing was read into value, so it must not be used */
+			if (size >= 0 && size <= value_size)
+				size = -EIO;
+		}
 
 		if (size < 0) {
 			error = size;

