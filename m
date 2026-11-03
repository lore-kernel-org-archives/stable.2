Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702866;
	b=dGCP/Ace1l66PyLoC5tHjmvgenkCXuQLGI0tsmIVFlTOi7pP2Z/WM8mjWCb5bSGDky3l
	 PS3KvnSzryZPRiU2oNIVnOohUM+PUfhdjamGClCAM30FvvtkXT0cOOec/mpRH/jLTcAjZ
	 aLUjsk+867mD8yNUcRhzrqnhOA16V2pa1yqgbadsRnNSICul04zBI1TOUenq+5W7eWYZC
	 kHxDTsjBGRszR8O9oMS/ocRjp+f78KKUa8g6nTzSDIYoCEnoy196+h3B+hrnXxe8ddS+O
	 xSOcnfEXt/xHMZltoGkf222OEmUH9UTgdy8Msl/jR/+k6q9hRzHAM3kvrW4/yn0hWeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702866;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zHBI0l1cclh9lVcu11iu7wBxLJB1gPW1s8i5q0hhhTE=;
	b=2zX8k7+6WAurhKeDjwf7VYa5A6zm2YIvXc3yif8yNngbxZVUMsz5bq6Nh+z5Q59zLVxy
	 uv66UFJARy67YvIPB4qsx2tk05GSRsgYd8+vRnVqQ+OoyAUfKj6c3EJCJ51Dv3AUYLZ46
	 97/JgM7FCEoDRMRP56We2sVEIvzHjAQc4Q/bkxLigylMbfxTYCYpweZJ3a/B9qUekNWeA
	 HGkwc22eleXQg2z/puwbeLbqCufu3MXtf2GY4LuHL9TWmbAv9lwgaegMiiGyk7xnxyGlT
	 RKsr2/u2dQCpY96jBYgX78HVJ/ZohgO1UfD45jLlFc4w6hp4zhPV/6pY+OwwRtpxYUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=O32zEIhV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8260736C0
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=O32zEIhV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F671F00919;
	Tue,  3 Nov 2026 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793702866;
	bh=zHBI0l1cclh9lVcu11iu7wBxLJB1gPW1s8i5q0hhhTE=;
	h=Subject:To:Cc:From:Date;
	b=O32zEIhVORv5AFc792jkfC2EajpQrQzkA4194fQuJ8cIE8I3Nj6raWu/lslEKt2UB
	 ChgE7TzXmOCNTYM81Z1W6Sr3IQXbzEJPWzqfItOMThpF8fTzZnfo3Bpy6aOWwcwbPx
	 xevBZb7GcGfU5C6gQlH+MQnsJeSrA2/n7yvv87os=
Subject: FAILED: patch "[PATCH] ksmbd: prevent share root removal through empty paths" failed to apply to 6.6-stable tree
To: linkinjeon@kernel.org,zachariah@aplosai.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:45:37 +0100
Message-ID: <2026110337-caboose-tile-5488@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9fd1fcbbf84986a7bcf601a2b90540899069d263
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110337-caboose-tile-5488@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

