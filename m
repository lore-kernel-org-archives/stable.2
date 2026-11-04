Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802971;
	b=O5E/mAmodBDLg94Ke/emCq3J+qXu1ISXg6+vPXKBpeVFM6lNoish3Cmeg4k6qsOpgsv8
	 jUlGPVQrROKULwk6m6cXy15QYzbemfu3eUB+2Mo5bylQMiY4Zn5/ToXtU6lgWsMv9RPJQ
	 4wjQSas0gZsQZAXtqr+bVu711pqZnoMkuLZngAdk3JeWh0Rwm/KWuSG1SHRS7LQ0ZLhNS
	 qwS+sM2H+dc61VongLuiFjLA/qEtzM3kpmQP0K/B8EQztx9euoUNWgDtBceRFQT2/KuCg
	 33wY/WlZRC7A6m5mqwy+bgm30DzKAN3Z+HNmcoaRIET9tn2tEoeYx/4Ft4OFvW/o0bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802971;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C96PqgkOUWoc7+MsPmXUFrhcx6J4AJ3Wp3qVF4ARrNQ=;
	b=MZB8wlYjSVWcWILMKO/KWphjWiTOToJnBL2QjuZ+UPwItIeuCP3JnZB7ZLvE6e7D3AiU
	 UzUz6Hrz/AOzNUVwKNPlrpoPyQAVEQGeOMSyY4TOxFzCQbl5mJ6P1eEdqPPrIyGTNXL66
	 T+XX7q9Jh0LIkCPsT6Hpq4B4EOwZc1ZA03p7U/4zJ0OX/LKGM9EBgIX7CoQOZrOvPKhYh
	 AxgoKxl57uo10cYi+LsIDT0zczWPEaoIbp/1y6McB59rPymSR/92HfJ/1nNrE83VsoPF2
	 PLWd93fSGmFeep9cpqxtg+p3P9iqf9Qmo66Hr7tdZHWg1wnYUdk4BOY/guJFs3Ykw6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OyHaVZJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E19606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OyHaVZJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD7E1F00A02;
	Wed,  4 Nov 2026 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802971;
	bh=C96PqgkOUWoc7+MsPmXUFrhcx6J4AJ3Wp3qVF4ARrNQ=;
	h=Subject:To:Cc:From:Date;
	b=OyHaVZJEhs8/TCN3+US6uSYJYRZKq4XX85SrmqWQ69bDVasKtEbcKuy2Qx8R5auTz
	 puPcS0yajibW+E/HjDJF/0QOZAGiJs+jQbH1c72EUyQYe5vPKZUkV/pYC/r1SojBSL
	 iX7jvZufq+v6aQm68Mzfju6R5L7OLiQqg88Hq+TI=
Subject: FAILED: patch "[PATCH] ovl: do not copy up a dentry that was removed" failed to apply to 6.6-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:36:07 +0100
Message-ID: <2026110407-bobtail-armored-f04b@gregkh>
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
git cherry-pick -x f635192ad223d2009ee640b63adf5ce3198aa338
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110407-bobtail-armored-f04b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f635192ad223d2009ee640b63adf5ce3198aa338 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 11:00:06 +0000
Subject: [PATCH] ovl: do not copy up a dentry that was removed

A change to a removed file through an open descriptor replaces whatever
has its old name in the upper layer.

Copy up must only create a name in the upper directory, never replace
one. After an unlink, an rmdir or a rename over a lower dentry, a
dentry that an open file keeps alive still has its old parent and name,
but in the upper directory that name is now a whiteout or a new object.
ovl_copy_up_workdir() renames the copy over it, which brings back the
removed object and destroys whatever took its name.

An unprivileged user opened a lower FIFO and unlinked it, root created
a file at that name, and fchmod on the old descriptor replaced the file
of root with the FIFO.

Fix this by looking up the target name of the rename in
ovl_copy_up_workdir() with LOOKUP_EXCL, so that copy up fails with
-EEXIST if the name is taken, as copy up with O_TMPFILE already does
when it links the copy to the name.

Fixes: e9be9d5e76e3 ("overlay filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: use LOOKUP_EXCL instead of relying on d_unhashed()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 12000e45fefc..286978d47ef7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -793,9 +793,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	rd.old_parent = c->workdir;
 	rd.new_parent = c->destdir;
 	rd.flags = 0;
-	err = start_renaming_dentry(&rd, 0, temp,
+	/* The name may have been taken since lookup, never replace it */
+	err = start_renaming_dentry(&rd, LOOKUP_EXCL, temp,
 				    &QSTR_LEN(c->destname.name, c->destname.len));
-	if (err) {
+	if (err && err != -EEXIST) {
 		/* temp or workdir moved underneath us? map to -EIO */
 		err = -EIO;
 	}

