Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702870;
	b=5UxYrFsR3dki7OG7PeGK6KqdZRTTdFKGazJ5gZLBh9ZAV76gjeAFi6sDVR+vwbbw6aiX
	 UQmFWjUxOL+E5EwG0O7QnJVbEbwuE+5YzFJlWSgDXWb2aX4fzRHqZ/xX66B4yAkkZd66q
	 dELT6IRdn2s/FMU1h5YzSLEuDIA12UE96UjDrGlXI+VOHGthDvuCt3yXF4/xXNgDSXajb
	 tFVnSAOWc0gSHh18FdzluADLWJrApznbAF12hNJyBDKwF8L8q+pF33S0hl3PgYQGHhIie
	 Bci2nOpjR1S9Jd9zShjWvb1IRXppcOcqcebuXWe1s0yiRnxPBlmj05CFC4yPwxKpFYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702870;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=D0pjJTxEJsexUvjwKBHn30dB74ZvbzYzJnQNYqhPQEM=;
	b=IV0uQO7jKD+LxstJ9Ak7JMOEPl5m1IruoPJwSHUE4wqjAZMlg8FlGGTvp8qV0BxUlcJU
	 BXRwZkEFPVTpWyPaVZ/uHFud7GrjdNvlIuIDx6DV9JfgTit1TpO0OCZPRKifRKcgvzk8N
	 akc6EB/hu3RXbF0m77AemYONfA1B+2Mp6eGAPpmJN0iywPBK1L3kwd6Mu2H4mfNha9CE9
	 GLV4sye4MJ1Qj3dNSmkpNxcozGfZAVHcCNUS4yBMSmabTYfcV/fYq+rPSjlLic3/pcqpO
	 r+/vHME/6t/+3ra4bgcSGS0MVb+I1PJg5BCEU+or+l15BpXDRoayqaIWnegs+Pa1YMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ayKyI9Pw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59126073787
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ayKyI9Pw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261DA1F00919;
	Tue,  3 Nov 2026 10:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793702869;
	bh=D0pjJTxEJsexUvjwKBHn30dB74ZvbzYzJnQNYqhPQEM=;
	h=Subject:To:Cc:From:Date;
	b=ayKyI9PwT/RdTftStZOUYhJpgbN1DZ5qOaCO+agavr9EoIKR3plrK7vvQ2nB2rDR0
	 64DL4UaEDIbytx9v+SkZsdwJlYuBl4kr8YHRHmOg5wegt3J3d/efGdbXe1yjftwwwu
	 0/vqfRjlvBnLUlvxiMFUDLUGvVSDTm7aP8FUE8+A=
Subject: FAILED: patch "[PATCH] ksmbd: prevent share root removal through empty paths" failed to apply to 6.12-stable tree
To: linkinjeon@kernel.org,zachariah@aplosai.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:45:37 +0100
Message-ID: <2026110337-chute-essential-cb01@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9fd1fcbbf84986a7bcf601a2b90540899069d263
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110337-chute-essential-cb01@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9fd1fcbbf84986a7bcf601a2b90540899069d263 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 23 Oct 2026 08:53:57 +0900
Subject: [PATCH] ksmbd: prevent share root removal through empty paths

A FileLinkInformation request can supply "/" as the new link name.
smb2_get_name() strips the trailing slash and passes an empty string to
ksmbd_vfs_kern_path_start_removing().

ksmbd_vfs_path_lookup() resolves an empty pathname as the configured share
path, without LOOKUP_BENEATH. With ReplaceIfExists set, smb2_create_link()
can therefore remove the share root from its parent before link creation
fails. An authenticated client with a writable share and DELETE access to
a file can trigger this if the share root is empty and the mapped user
has write and search permission on its parent directory.

Return -EINVAL for empty pathnames when for_remove is set, before
resolving the share path or acquiring removal resources. Ordinary lookups
continue to accept empty pathnames for opening the share root.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Cc: stable@vger.kernel.org
Reported-by: Zachariah Mithani (AploSec) <zachariah@aplosai.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 5360c6999bb3..4ee72eda9bc0 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -62,6 +62,10 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 	struct dentry *d;
 
 	if (pathname[0] == '\0') {
+		/* The share root must never be removed. */
+		if (for_remove)
+			return -EINVAL;
+
 		pathname = share_conf->path;
 		root_share_path = NULL;
 	} else {

