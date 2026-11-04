Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805223;
	b=tmqvrwdHStEjap955c5YdN9707gHZBdnF+AeXwv5bJnl03Dqtg4k+X7pqAdYBiOauU+Z
	 m2lw3byTqQeBAso3Ym9zD0tY3pvAXBkgxwNvi4CoQZGRuBvQx/qn4MPtvF44HM4xSUGu9
	 zxZyi3+ha0qnWi/HphKa2Ss5Qrzj2qn2Tzg0rbcXr60Y/xICUYOCusi9WGzAmAIctu2nk
	 1tGRsI/djpdlSu/Vri6cbwuOE4/KiHR9zFUlGnIXWHozX2KagOiqjrWM72gw9tUh1f/s9
	 mLzqur05rX5YKfe+9SW1DK2TU8WX3F0vD+cRe+KAwBiWbadN/PpBSv3XpoRP4fMeWzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805223;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pXa63ljelrP51rv9YemZfv13ROBFMY4UsqZPhzA46Xc=;
	b=VMAjKAs5JoSiRe/73Z/7s7P+m7cM9CAQGBQsYIiA4qavaCDQ4XhdH2/kZnNvLULrjmFK
	 F8pHSdDIFHSTuff8ywx/eGGzfOjzPVZ4RJirYoR+xlv9jJc6/uFp9xmPNLS5DPe+n45gj
	 QTM1EirVfepFS6asaROiox87mjVZgOu+TF0ujR7c/IOkd+hyNk2ZdI3mefxsU4dyJsU9X
	 s39iETK5GvY2bzaxTSOSvJdRdvE+QtqPVtq1ilr845JJW/aSfVSj4k9MXkTMowmOMvtM1
	 QIkCcXOyHUC1I35WVrJlj5irbgxp58B2fqX65n4bN7y52F8Q4xeq4BxUzJdi4ybNWWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="wZj91/M7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50497606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wZj91/M7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD5A1F0093A;
	Wed,  4 Nov 2026 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793805222;
	bh=pXa63ljelrP51rv9YemZfv13ROBFMY4UsqZPhzA46Xc=;
	h=Subject:To:Cc:From:Date;
	b=wZj91/M7+2I/NFH5qKaBZJf3h7OgKlwWPtzt/lPhBWJekRlIjOTuMr5dV7HBgxLxJ
	 5zfNLKx54cw1iSV14uV/YS1Ml7bUgTX3CGl/NbdCqZxE6vUlbm/7k8E/XZ2L98Qnbs
	 AQVu+7WLXnR+bqflcdW407a5GcZvWccgXHGKEJzQ=
Subject: FAILED: patch "[PATCH] xfs: fix buffer overruns in xfs_ioc_attr_list" failed to apply to 6.6-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 16:13:40 +0100
Message-ID: <2026110440-penalize-refocus-9272@gregkh>
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
git cherry-pick -x 0b9081a774ee7b9dff1e9ac3765b73c1d6bba5b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110440-penalize-refocus-9272@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b9081a774ee7b9dff1e9ac3765b73c1d6bba5b2 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 22 Sep 2026 22:58:08 -0700
Subject: [PATCH] xfs: fix buffer overruns in xfs_ioc_attr_list

When we converted the al_offset array in struct xfs_attrlist into a VLA,
the size of the object shrank by 4 bytes.  Unfortunately, the buffer
size validation in the attrlist ioctl wasn't updated to notice this, so
the al_offset[0] assignment blindly writes off the end of the buffer.
LOLLM noticed the omitted check and complained.

Cc: stable@vger.kernel.org # v6.5
Fixes: 371baf5c9750a2 ("xfs: convert flex-array declarations in struct xfs_attrlist*")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index 0689cade8f74..fd9d4d8258ff 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -409,7 +409,7 @@ xfs_ioc_attr_list(
 	void				*buffer;
 	int				error;
 
-	if (bufsize < sizeof(struct xfs_attrlist) ||
+	if (bufsize < struct_size(alist, al_offset, 1) ||
 	    bufsize > XFS_XATTR_LIST_MAX)
 		return -EINVAL;
 

