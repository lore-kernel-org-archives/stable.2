Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6343846C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563003; cv=none; b=WR/EBkjdVdUGyyVdZI6d3DJL2ScsM4oAw1okxmtep3K63cyI4fe3IcRQm41rCNlaqkgOkYd4J2z97aMVvjX6sYICpIVlM4HXnoR01VxTwNM8d/TzPqGFofS7w51bij9Qchy3KxF8Vi907fggZdB1IAP4U/VGCwRO2o4XEZsLQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563003; c=relaxed/simple;
	bh=1LT6XJsHrN5uZoARUGom1qpkrmwited6NTlXqA8lRQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgVIoqqfrtNAAKTIhXSC2fbzTkTYqHsF8EhGvd8qWqlZ0MOWRhRgGnr/Zst2d8pc2k4VEUkDnqYDHglebbsBDenu0bNFlsiK+QPAq6MvDsRt+rhH+8U27T5tY3jZGbJpcdcCIgR8OP5ZXwStGkph+ENPStyYSv3Eonoju5f3b1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBDIOT8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBDIOT8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73AE1F000E9;
	Mon, 20 Jul 2026 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784563002;
	bh=Fcx07nb9Qdj1+RRwA6dT2mtI7OSLJaCxkaIFPbZHzrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBDIOT8Ap4JXSWFFNNlAkKC+i7ZmqwiJeN2OTln66UyyBm/FsXmwbHew6nRQU8eVq
	 3NhQEpj4sI2JD45l82bUgnRZz2YP/l2kEHOey7hNN9awPK0OkFLNJgX5wEeN9sbGq3
	 nZa17WEv1CwnyGTqSYTBniKHUxtSElih4pm9f4yz54n8wlrz02xQGCPf5egaFyDbhE
	 vrEoIDjJ02TZ+WzkH44bfnpRi9s7sJFDb1ViJhh6xbyGFKkcTxc1RlS1mNAhykYeg9
	 YIp003UtVwYXxQ0Hg84kuwaddKOodzj2HRe4zuOQE/Kiqkxjgxkj4BFls3sY/6VMcO
	 EIyq0cADTjzaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: gadget: f_fs: Tie read_buffer lifetime to ffs_epfile
Date: Mon, 20 Jul 2026 11:56:40 -0400
Message-ID: <20260720155640.2425938-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071426-variety-sudoku-2c50@gregkh>
References: <2026071426-variety-sudoku-2c50@gregkh>
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
index e6c7844b8d1c2b..883875883c1b33 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1278,7 +1278,6 @@ ffs_epfile_release(struct inode *inode, struct file *file)
 
 	ENTER();
 
-	__ffs_epfile_read_buffer_free(epfile);
 	ffs_data_closed(epfile->ffs);
 
 	return 0;
@@ -1943,6 +1942,7 @@ static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
+		__ffs_epfile_read_buffer_free(epfile);
 		if (epfile->dentry) {
 			d_delete(epfile->dentry);
 			dput(epfile->dentry);
-- 
2.53.0

