Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E964B1B55
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444102; cv=none; b=pbo0Sb14HBokINx59DbPY87cWUFfJjPcKAnqdvXe+07FfwH/W7hV4SePxaz2w3o+Mp5cIS7nznWc4HzPEWsr887dVTHRjTPB4BS3aNVI1XnxZh9Z5VvflYbYIx+EnBws9/c06s7J/VLZs6n9Djuzu1/t4r/ciD/LViU1KrHU1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444102; c=relaxed/simple;
	bh=m4c5chcsfbtcJkyYn5KAy0bNE5TsYGGP0gQGDtvjsIs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DmvrsZYTWUu33xQs/wpjc3RLcHb4x7hQ8fpXYnrjmeGdT/BRzSHhoSg5xYWxPn2ppCfe+lqVHSdB6gFqtNMjF8s+vlEp68GVcBw8sP5lb8SrvrO1Q9InEcadpY5kk+lj9I8Fnfm6b58zzc0Hk9ePYj8sSsHa2AFlFv3qXsUiZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e5NalgLE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e5NalgLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078401F00A3D;
	Thu,  3 Sep 2026 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444089;
	bh=gZ5alcQ7dhIonw1zMFERt7+y2QiwxtqhjaRs3rCkfcc=;
	h=Subject:To:Cc:From:Date;
	b=e5NalgLE84Ziy3KmhTZOwmsVzgel1p6g2MnzzHTnihKJ0jxgpS4DGL+Pp9qq2COXJ
	 /Kd+2Z8hU91P4Okoi8pHbgoJRWhfvRiCvApC1Lkhkq+Eu/3EXYe825TB1eHfmCHZf4
	 VPY5tswpI62d/a4ku13/3C+QWjeFHpOh3c1ayRWo=
Subject: FAILED: patch "[PATCH] ntfs: fix resource leak in ntfs_new_attr_flags" failed to apply to 7.2-stable tree
To: zenghongling@kylinos.cn,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:38:33 +0200
Message-ID: <2026090333-reformat-subplot-1cbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 9969d58a9b0417393d033b24c670d57b686cabbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090333-reformat-subplot-1cbe@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9969d58a9b0417393d033b24c670d57b686cabbf Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Thu, 20 Aug 2026 16:14:10 +0800
Subject: [PATCH] ntfs: fix resource leak in ntfs_new_attr_flags

When handling resident attributes that don't need sparse/compressed
changes, ntfs_new_attr_flags() returns 0 directly at line 678 without
calling unmap_mft_record() or ntfs_attr_put_search_ctx(). This leaks
the MFT record mapping and attribute search context.

An unprivileged user can cause a denial of service by repeatedly
calling setxattr(2) with system.ntfs_attrib on files with resident
attributes, eventually exhausting kernel memory.

Fix by replacing the direct return with goto err_out to ensure proper
cleanup of resources via the existing cleanup code.

Fixes: e791930240a5 ("ntfs: fix resident conversion in ntfs_new_attr_flags")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index fcba051b514a..59e5e86e38e3 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -674,8 +674,10 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	}
 
 	if (!a->non_resident) {
-		if (!(new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)))
-			return 0;
+		if (!(new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED))) {
+			err = 0;
+			goto err_out;
+		}
 
 		if (le32_to_cpu(a->data.resident.value_length)) {
 			pr_err("Can't change sparse/compressed for non-empty file");

