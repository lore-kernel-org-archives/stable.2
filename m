Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85F4BB29B;
	Fri,  2 Oct 2026 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949424; cv=none; b=rxjzcEHTaxieJsTywRYfVCvuRGITEcypW9jOcn7Y0i7ejR1jKG2gcqhY3owsit2u2aBJfIc3WL4xc+RpUCwB3szAEvrLQXkDn4wP52MXQeCho+n1yW9Q6YEjMA6t33wFt5e2uOJxh8Jt5O3MKY6h2H9J4XzqN8NIIKQkeFMvIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949424; c=relaxed/simple;
	bh=2zF+Sfj9s5Ein+P0ya4+ac7E4LQ7ElkPTHjYS8Xz644=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q8dkj5fichZ9v0zMWMVYhc0T7C/XV+r7ka4oqJzKBn3kCGi+Cxoo0gLy7oiqH7/l7SWKU5NY7Jm92nWdmsM2gbfx2vrJHOjwnX9Q96MH06ofkcE1ynCBPCr3O2yFf5MLnBLYx2DLv8SXJaud/SUBiNx2i6p56KiVsxLqPEjZQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+CSu43R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+CSu43R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D693C2BCF6;
	Fri,  2 Oct 2026 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790949424;
	bh=2zF+Sfj9s5Ein+P0ya4+ac7E4LQ7ElkPTHjYS8Xz644=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=H+CSu43RNbl4xL0e3yGhk482g5Hebuq+VWgFVSWZ2PDJVgZjZiZRxsh8o1ce9hcoW
	 2TnCEmxm4WGX9YwVIah2fYkOsBBI6Z0mpfRtyyo6bX55VNd8/qKGLPSmgakT1MqwhT
	 jiwNPsWXrFVpth+KlKQ5btnNU6Fr6slb7RdbNOaORItcQ5hisje3uNZc9EKG9pH021
	 L4PPExmMBDWQewyciqJQAm5zSA0eZIObF7I/cQVmkaDWoO7ablqHD7+QyYJxp/HmRu
	 zGlO6nN8y7JbB5otpCf9HxYzj5o7GGYL+vuOQG/h1AbdtOd+rrZpSUPLJAtxgKDn7D
	 LESEE3HriRURg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A020CA5FD4;
	Fri,  2 Oct 2026 13:57:04 +0000 (UTC)
From: Miguel Garcia via B4 Relay <devnull+miguelgarciaroman8.gmail.com@kernel.org>
Date: Fri, 02 Oct 2026 15:56:57 +0200
Subject: [PATCH] io_uring/rw: commit the ring buffer when a read is queued
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-codex-io-uring-eiocbqueued-v1-1-3fb159b33a47@gmail.com>
X-B4-Tracking: v=1; b=H4sIACm4v2oC/x3MQQqDMBAF0KvIrB2IKSr2KsWFmXx1NkmbEBHEu
 ze4fJt3UUZSZHo3FyUcmjWGiq5tSPYlbGD11WSNHTpjLEv0OFkjl6RhY2gU9yso8CzTOPS9e41
 WHNXgm7Dq+eSf+b7/EU0/cGwAAAA=
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Miguel Garcia <miguelgarciaroman8@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790949423; l=3676;
 i=miguelgarciaroman8@gmail.com; s=default; h=from:subject:message-id;
 bh=v57nh9u23dqRQyIlqtlCgf6++EGJa5Mea4ZnWbGP4a4=;
 b=jQegJ5VAriYKw7EOa0I+F4x5Z+3MQ2xzVA1w5ntmnOMbgxKil73hpDK4c274vKo/SwCav2SRC
 szR3lvcKiPpAQXdCoZgkc5wP2cuS0NtxxhMYULY0N+zDp0mFaROJGDP
X-Developer-Key: i=miguelgarciaroman8@gmail.com; a=ed25519;
 pk=EtrxRdQ/icT1qmJwjNNAVoBUhKKWwrhU2m6QT/xu6bM=
X-Endpoint-Received: by B4 Relay for miguelgarciaroman8@gmail.com/default
 with auth_id=1101
X-Original-From: Miguel Garcia <miguelgarciaroman8@gmail.com>
Reply-To: miguelgarciaroman8@gmail.com

From: Miguel Garcia <miguelgarciaroman8@gmail.com>

io_read() recycles a provided buffer ring on every negative return
while REQ_F_BUFFERS_COMMIT is set. -EIOCBQUEUED is one of those
returns. IOU_ISSUE_SKIP_COMPLETE is defined as -EIOCBQUEUED, and
io_issue_sqe() turns that into success and leaves the request in
flight. The queued read still writes the user address chosen at
buffer selection.

For a pollable file issued under uring_lock, io_should_commit() is
false, so recycle clears REQ_F_BUFFER_RING and REQ_F_BUFFERS_COMMIT
without moving the ring head. io_req_rw_complete() then skips
io_put_kbuf(). The CQE is posted without IORING_CQE_F_BUFFER, and a
later IOSQE_BUFFER_SELECT takes the same slot while the first read
is still in flight.

FUSE reaches this from a user mount. fuse_file_operations supplies
both .poll and .read_iter. A daemon that negotiates FUSE_ASYNC_DIO,
reports a non-zero size, opens with FOPEN_DIRECT_IO, and answers
FUSE_POLL with -ENOSYS or POLLIN makes io_file_supports_nowait()
succeed. fuse_direct_IO() returns -EIOCBQUEUED for an async kiocb
and keeps the user pages pinned.

Commit the selected length before returning IOU_ISSUE_SKIP_COMPLETE
and leave REQ_F_BUFFER_RING set, so completion still reports the
buffer id. io_req_rw_complete() passes a NULL buffer list, so
dropping the recycle alone leaves the head unchanged. The list
pointer is stack-local, so the issue path has to commit before it
returns. The committed length is rw->len, the same length
io_ring_buffer_select() commits when io_should_commit() is true.
Non-pollable and IO_URING_F_UNLOCKED issues have already cleared
REQ_F_BUFFERS_COMMIT. -EAGAIN still recycles.

Commit d8e1dec2f860 ("io_uring/rw: recycle buffers manually for
non-mshot reads") made io_read() recycle provided buffers on every
negative return, including -EIOCBQUEUED.

Grok, a coding assistant, found this by reading io_read() and
fuse_direct_IO() and drafted the change. Debian gcc 12.2.0 built
io_uring/rw.o and the kernel image. QEMU TCG booted both images.
On the unpatched image two buffered reads shared one address, the
ring head stayed 0, and both CQEs lacked IORING_CQE_F_BUFFER. With
this change the head moved to 1 while the first read was still
queued, that CQE carried the buffer id, and the second read returned
-ENOBUFS.

Fixes: d8e1dec2f860 ("io_uring/rw: recycle buffers manually for non-mshot reads")
Cc: stable@vger.kernel.org # 6.18+
Assisted-by: LLM
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 io_uring/rw.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0c9494fd21be..a40263d21afe 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1034,6 +1034,21 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 	if (ret >= 0)
 		return kiocb_done(req, ret, &sel, issue_flags);
 
+	/*
+	 * -EIOCBQUEUED leaves the kiocb in flight on the selected user
+	 * address. Commit the ring buffer here. Completion reports the
+	 * id with a NULL list. Error returns still recycle below.
+	 */
+	if (ret == IOU_ISSUE_SKIP_COMPLETE) {
+		if ((req->flags & REQ_F_BUFFERS_COMMIT) && sel.buf_list) {
+			struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
+
+			if (!io_kbuf_commit(req, sel.buf_list, rw->len, 1))
+				req->flags |= REQ_F_BUF_MORE;
+		}
+		return io_fixup_restart_res(ret);
+	}
+
 	if (req->flags & REQ_F_BUFFERS_COMMIT)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
 

---
base-commit: 648611ee6ed0d27f8b43b7b5863facc3ec94c31b
change-id: 20261002-codex-io-uring-eiocbqueued-c97655b372cb

Best regards,
-- 
Miguel Garcia <miguelgarciaroman8@gmail.com>


