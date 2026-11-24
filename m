Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536585;
	b=I1c9Cs6KSUhnugylcQ3UpNUzVeZTxlSEkSiwMUoOmxigrCN0ZMqY/+t748Wy/coVwDQ+
	 ChwfHrFAF3MQ3crwRq1BQjuHnoV8c/XCuY3QrFpue2BtgRRnKy8K08a2opeoe2q6TBPSu
	 rFYKKkPLY15eXIabnt9WLLkB30WTYzQZq5NaJp2t5zdeJYVuYYgVMIvhgQCa+t+2sqegD
	 GkjeiXcp3slFa2nfMvW898cinfFNbGhr+P0LXuY3yoRtbnx9bpHETNMF8omK/VZVe5IDT
	 LkM/2vhiHD+OZyWXfTT1biRR4vdYD2hy56pM55UuGrp8MW0feeRFcyw7Pu3UGQqO+Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536585;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=26ZmCVTURw57N9TGILUG6PBhQ6HWjicTw+3qmyg9qhI=;
	b=vxNUoBfl9oTNKvoBqq2MUg0hYG+VUo96gYodxYjJlzS+/Tcfr+HG4Jl235briSPV9ZqL
	 FASaaaRGzDBpIZb+c24vmtxTHi80ariCe8gfmM8fwFeU9WM60RXkw0+zzq2hbOpyqijUm
	 VzMG3+chd222VLffx2hbQNVKWWPWxXkOpRDL4CQqzgocKe91LRMuJKHcN3dJKccRW82sl
	 r5tfVZGlO2xyR+hQ8fJ1UyyoYZEUAFUo5VPmUVa1d7WgxhYTZCOAJ5vHFXGhQ2Luesm/v
	 55q29n9ZiUsZIHt0F5c7n5JY6aHm0Eq8fc3AVGd9hX+Oi4QtbIE/C1fOXsNmjj2rdZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ohgghLL6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72097606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ohgghLL6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A6F1F000D1;
	Tue, 24 Nov 2026 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795536584;
	bh=26ZmCVTURw57N9TGILUG6PBhQ6HWjicTw+3qmyg9qhI=;
	h=Subject:To:Cc:From:Date;
	b=ohgghLL65GJ2AMPVflvkd+HUsGYtNJTIqyVovvY4wQjgyo9/81rL71JBpOvt/VL0d
	 7e1Uwd2TDGtRR6Q9mCCMoLeZmniooThP1bNOoKkRUTz33GlpPT2IoABBhEdyXL8EOr
	 08SVk3S6961seZVkuim04vvu44aDH0y0pBE4Fwuw=
Subject: FAILED: patch "[PATCH] coda: honor the append state of each write" failed to apply to 6.1-stable tree
To: dennylin0707@gmail.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 17:09:57 +0100
Message-ID: <2026112457-parasite-maternity-b897@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 87ea037a9166a5842356ce68e3585fc6e756603b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112457-parasite-maternity-b897@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87ea037a9166a5842356ce68e3585fc6e756603b Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 5 Nov 2026 05:14:06 +0000
Subject: [PATCH] coda: honor the append state of each write

coda_open() adds O_APPEND to the container file's f_flags after it has
been opened, without updating its cached f_iocb_flags. An O_APPEND write
can therefore overwrite existing data instead of appending. For example,
writing "Z" to a file containing "abc" produces "Zbc" rather than "abcZ".

Pass RWF_APPEND or RWF_NOAPPEND to vfs_iter_write() according to the
incoming IOCB_APPEND state. This also honors changes made with F_SETFL
and per-write append overrides instead of relying on the container's
open-time flags.

Fixes: 164f4064ca81 ("keep iocb_flags() result cached in struct file")
Cc: stable@vger.kernel.org # 6.9+
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Link: https://patch.msgid.link/20261105051406.52442-1-dennylin0707@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 6ca8bfcb58f2..c9fba41f7cea 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -71,6 +71,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *host_file = cfi->cfi_container;
 	loff_t ki_pos = iocb->ki_pos;
 	size_t count = iov_iter_count(to);
+	rwf_t flags = (iocb->ki_flags & IOCB_APPEND) ? RWF_APPEND : RWF_NOAPPEND;
 	ssize_t ret;
 
 	ret = venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
@@ -80,7 +81,7 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 		goto finish_write;
 
 	inode_lock(coda_inode);
-	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
+	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, flags);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));

