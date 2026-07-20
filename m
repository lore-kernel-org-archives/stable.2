Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5794429CD4
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557064; cv=none; b=SNoPA8KW/e7eNWQZv4NC4hZhjyns82RmRSpg/X5jltnScd/hutCSNFH9dquI4YFXOQx+lqifTPqBG7wc/Vr5Qkbqvup84yCNV1k114WPT+dYhh/eJLQjmLRJPfcHhT+1ui/8M6o4FO9zeTZLo2IZV9X58Grnfj3R9Lv6HS4KG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557064; c=relaxed/simple;
	bh=a9rLrD/2IeOxVojBxxVCtrPsvF86absDc1zKBAdGCzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N90h8BbDBABXMNPeakiUINYlGew0n4k4wQ4ipV3BfLUYtPfGi71ZL3l7+oprXUQ9r5e9aSUkLgkcq3fRh/63/zxzUXYnnvPNRrhC9buOqRV7/l7KfnpOvFT/kEHlt1I3/+pY9/rQY1IG+QKjA8FG43mF3w9WTU/R9yDr7X0ezq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbV+YROz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbV+YROz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BEC1F000E9;
	Mon, 20 Jul 2026 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557063;
	bh=ZHi/k/LKg0U7p0FYP/xtJl+HEGZoeAeDPuL7eA9OvW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bbV+YROze0g9l0q3bpBsU0FThhCBD7I8/NfBrsSxj2sXzAE2tjQ/zXZ0Ef6RQ7ZZC
	 up/GK7hhtWCx2AULIf86x/Ab8mF3xZAcPTz+Bs3ON0EnyIA4GDA856THiIoeLjffCM
	 p+0i0POxPgEtOyMb9At5y63kfaSGY8xvga67/Rb2EXB4zJELuLXmFhJgPCJFeeBQOj
	 jnUQpUpXewcmDIQqjMcYSk3PT+Of0RvNAq5yBRP5GdZWsG1PFYPGBe7Xl7V4SFE8T4
	 hZjHAjV/rysHPpMytt3QuU/rcdly+FF57XEWLMeN9gtz20rL/dTXILtUphys4ksQjT
	 5XLVpbd1e/B6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile
Date: Mon, 20 Jul 2026 10:17:37 -0400
Message-ID: <20260720141737.1619471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071425-sadly-dimmer-0668@gregkh>
References: <2026071425-sadly-dimmer-0668@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Neill Kapron <nkapron@google.com>

[ Upstream commit 8bdcf96eb135aebacac319667f87db034fb38406 ]

Currently, ffs_epfile_release unconditionally frees the endpoint's
read_buffer when a file descriptor is closed. If userspace explicitly
opens the endpoint multiple times and closes one, the read_buffer is
destroyed. This can lead to silent data loss if other file descriptors
are still actively reading from the endpoint.

By tying the lifetime of the read_buffer to the ffs_epfile structure itself
(which is destroyed when the functionfs instance is torn down in
ffs_epfiles_destroy), we eliminate the brittle dependency on open/release
calls while correctly matching the conceptual lifetime of unread data on
the hardware endpoint.

Fixes: 9353afbbfa7b ("usb: gadget: f_fs: buffer data from ‘oversized’ OUT requests")
Cc: stable <stable@kernel.org>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260619040609.4010746-3-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adjusted context in ffs_epfiles_destroy() since 6.12 lacks the simple_remove_by_name() rework and still uses dentry-based cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 17724b12b88059..2825fa24242eec 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1268,7 +1268,6 @@ ffs_epfile_release(struct inode *inode, struct file *file)
 {
 	struct ffs_epfile *epfile = inode->i_private;
 
-	__ffs_epfile_read_buffer_free(epfile);
 	ffs_data_closed(epfile->ffs);
 
 	return 0;
@@ -1891,6 +1890,7 @@ static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
+		__ffs_epfile_read_buffer_free(epfile);
 		if (epfile->dentry) {
 			d_delete(epfile->dentry);
 			dput(epfile->dentry);
-- 
2.53.0

