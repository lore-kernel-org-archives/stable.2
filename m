Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB424428492
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556629; cv=none; b=Z3iC413ppDA5y/rdpNEp4L3sGvpjIRDrEp3jbYPu5AEUXyxRsriv91UC6r2CtJMhokyU67ziPIcRTehVfQ7nLmMyRxNSequintREiRGhbkZR3vppqJJ9qxxZ24a9C3Er2HPzTzBD+H3ifYt2IQhzJ0q/bARRiROblLCsXf72+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556629; c=relaxed/simple;
	bh=mWYCcyq+7vQ+pTUbL5B+1Ya+802R7OqoGJ9tbLXQ+tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dodQcnfiiuegeZkaWmoCZuJtMe2au8Pe+gvVSDuaG9VanMd7Mk9t71okG1vR9CdPfqEM1YfatWjfeEFWMQRmj4H1nmlQc0eNTVqZ97U3A0ayvs9IE6O5LvP31XukppJKRSAUJE4dEG4oH0omGG67Yyy+cr2CSpc4ymT4VJcR/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyRt2Tu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyRt2Tu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684281F000E9;
	Mon, 20 Jul 2026 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556627;
	bh=SZrB+CHWQFHn3HMN6J8TzhkPOCloa0oxnWgR+Ng22q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iyRt2Tu1Z5IKKM8soBPT0ay+VeanfJ5NBGDnMJqUk9bBd5LmCzL/PKj8K+u5j8K2X
	 vimguZ5KxvjchED7OLuHbPG6LSJLT6x4i//RbTMkmPDtNZH0uXmutGHY9fC/Co59A5
	 YI0cHnKkLiGzx736PmTuDHZ00AUyBoCHbxe+97OTihyblxA6xb4Y8yjs8a63qdAkm2
	 OI8CtS1QU2H2oiWi97QBvvhEbn7y80YReYS0h/9v19lqmPy1DjzHTGMcZNG6jccOAj
	 zBsZilbAK6LUo6WM1qLsSHLLP+CU4QAvBILaBkwTcFGCRYr9W8nkE1uxK8tw+y9QZt
	 pUiscWjExBQ+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile
Date: Mon, 20 Jul 2026 10:10:24 -0400
Message-ID: <20260720141024.1497393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071425-aerobics-patriot-01b2@gregkh>
References: <2026071425-aerobics-patriot-01b2@gregkh>
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
index abc1ec50933f39..35413a96885e05 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1364,7 +1364,6 @@ ffs_epfile_release(struct inode *inode, struct file *file)
 
 	mutex_unlock(&epfile->dmabufs_mutex);
 
-	__ffs_epfile_read_buffer_free(epfile);
 	ffs_data_closed(epfile->ffs);
 
 	return 0;
@@ -2384,6 +2383,7 @@ static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
+		__ffs_epfile_read_buffer_free(epfile);
 		if (epfile->dentry) {
 			d_delete(epfile->dentry);
 			dput(epfile->dentry);
-- 
2.53.0

