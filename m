Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC27431E53
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972315; cv=none; b=IVwLgoF3Skngr7XKI04IcXBa1I41/DJPFD8Ji6cmRi+1qs5+Js8QCtu50mswT6z1u/B/XZoZssuZni7aBiqBhI7hQAbB7Un+HPsKXSvzR6gccyTdsd4t9T+8/5qYeHH2qgaBh279vXPMpcVGXcKJ0C32qh83ytSx6r67rhct/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972315; c=relaxed/simple;
	bh=2HV1yYTYb0Ay487GUq4L0GgVuWSUs/G9f9MSBlsf878=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gTT5H6Gazsd3j1vDQzBg26wfUrSwt5DhR4uU4yVlgdysBrfHicsM9IHGZIxKyeJF+1GS/5HEQdIXE9XQHBCcEFUoG/4kbLySqDMXhNH9h2GkVtTH6VQd0gZTb7YIpIkj27gPe66j8y2uJb6WlCdd/lYi8WPK2v6jBZ4YzLsIWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=baNvmV7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="baNvmV7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDC91F00A3E;
	Mon, 17 Aug 2026 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786972311;
	bh=KpKJMTzpGr9WF0vg2ywYnS2luWsp+DBcnPP5bSoZAWs=;
	h=Subject:To:Cc:From:Date;
	b=baNvmV7M8yL2bwE07/s8xagHYdZMRXhOadEaFM41xKMl72/pKLd044lRYhoQ2ikeZ
	 aiCIUoq9jdp9ZQaHl3rTp2y2AgYaEUGSATGpqaDp6yg/YLCKapljPnZxduGAWz9aEf
	 tbRx1lT2YUimwLT3T9dfdeP1SPJ/pCp9q9/sxVVY=
Subject: FAILED: patch "[PATCH] fscrypt: use the mount idmap for the owner check in" failed to apply to 5.15-stable tree
To: zhanxusheng@xiaomi.com,ebiggers@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:58:50 +0200
Message-ID: <2026081750-cardinal-nature-4923@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x cf6c993c0feca7984797e634deba3c80342e199a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081750-cardinal-nature-4923@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cf6c993c0feca7984797e634deba3c80342e199a Mon Sep 17 00:00:00 2001
From: Zhan Xusheng <zhanxusheng@xiaomi.com>
Date: Sat, 25 Jul 2026 16:00:04 +0800
Subject: [PATCH] fscrypt: use the mount idmap for the owner check in
 fscrypt_ioctl_set_policy()

fscrypt_ioctl_set_policy() calls inode_owner_or_capable() with
&nop_mnt_idmap before allowing an encryption policy to be set, instead
of the idmap of the mount the ioctl was issued on.

fscrypt is used by filesystems that support idmapped mounts (e.g. ext4,
f2fs), so on such a mount this compares the caller's fsuid against the
unmapped on-disk owner rather than the mapped owner: the actual owner
can be wrongly denied with -EACCES and an unrelated caller wrongly
allowed.  Use file_mnt_idmap(filp) instead.

Fixes: 14f3db5542e6 ("ext4: support idmapped mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Link: https://patch.msgid.link/20260725080004.929328-1-zhanxusheng1024@gmail.com
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 9915e39362db..c80b24a941ad 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -534,7 +534,7 @@ int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 		return -EFAULT;
 	policy.version = version;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);

