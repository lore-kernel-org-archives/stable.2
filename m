Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230F4A9D4B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532183; cv=none; b=bhuTCZRYhRqqPscF5FRnS/R/Qlpu/xMgjbjMwb/HxUbxnlqza8MOSclHsf+oUASQwv485T734kt7/d6b3mygMkc7a56NnogayNBUjJMVXZb4dQcgR1kOZGX3TGpmtKcOwjp+MlDxumEe4dQY/PzsaDrOW5wjJBpfaXnBO+Y3LcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532183; c=relaxed/simple;
	bh=JXH6+ThsPYnrXpFrMNIvtXwvciUNvcR52qq63GHuS2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvZuRVlJUppTgAhbxY1SOCbtcocG3Td5xXMSDffh3VUPjetpgr5JuiKToZ7JlB5b9x0caePKP3lF33DdP6lZLHp7QqgjiBVK/wKx5WteJqo00EU9T6Z0cy831W2cJS5FJ0MocqT1xREst7pUTrX3aU0gI6EoLvpD4Lv3eZm60kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMrkgboW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMrkgboW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77871F00A3E;
	Fri,  4 Sep 2026 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532182;
	bh=YD7QdqAjh3xTqu5dJ4IuD81T6B2V2IX/BtFI8Oo0fvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WMrkgboW7RQ1dHuYXa3TlIrC8IxNtUZ+Yr4NbGS6S3KiUMsdwhwVIfRFc7eTecR8N
	 1H9THnhb3WGLb4cCWwLqY6prYNH+/33P6D+qd/1vXGdgGW3qOLCBVtImfQl0gtbRiH
	 cmrUvYEdSap+ihYK18oTnkHHRG5Ma+qJH0ZtwS+Xbf7U4ofDYobAMUyF2WtkosMrvm
	 AKkCkO2Ej9YNPsCU6spOztUO8TDHCANL+ffQmdqpDyAHEqnJIrjZd2jBhxqjgMQs2Z
	 /wwtCioV+CHCS1A4JtIO5R/Coy8Rc8KKYp79yO4MTlYQlxFxs7PXbImwYTizJv11BS
	 u7GLPsrqierZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	Xingyu Jin <xingyuj@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] usb: gadget: f_fs: Fix Use-After-Free in AIO error path
Date: Fri,  4 Sep 2026 10:29:39 -0400
Message-ID: <20260904142939.798242-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904142939.798242-1-sashal@kernel.org>
References: <2026090331-width-covenant-cd4e@gregkh>
 <20260904142939.798242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neill Kapron <nkapron@google.com>

[ Upstream commit e78dcb1f7ec271449c54984dc90c62a5ba272de7 ]

In ffs_epfile_write_iter() and ffs_epfile_read_iter(), when ffs_epfile_io()
fails with an error other than -EIOCBQUEUED, the io_data structure (`p`) is
freed. However, for AIO operations, the kiocb cancel function was already
armed and kiocb->private was set to `p`.

If a concurrent cancel operation (such as sys_io_cancel()) executes after
ffs_epfile_io() fails but before the function frees `p`, a Use-After-Free
can occur when the cancellation handler accesses the freed pointer.

To securely fix this race condition, we must properly un-arm the
cancellation. Invoking `kiocb->ki_complete()` does exactly this by
acquiring `ctx->ctx_lock` and safely removing the kiocb from the active
sequence. In doing so, it ensures that a parallel io_cancel can no longer
discover the kiocb, effectively closing the race window.

We then return -EIOCBQUEUED to notify the VFS layer that the kiocb has been
consumed and it should avoid attempting to complete the request again or
triggering subsequent completion handlers.

Fixes: de2080d41b5d ("gadget/function/f_fs.c: close leaks")
Cc: stable@vger.kernel.org
Reported-by: Xingyu Jin <xingyuj@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Neill Kapron <nkapron@google.com>
Link: https://patch.msgid.link/20260724235100.106011-1-nkapron@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index a00bf66bdf878..df66441bec46f 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1255,8 +1255,10 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 	if (res == -EIOCBQUEUED)
 		return res;
 	if (p->aio) {
+		kiocb->ki_complete(kiocb, res);
 		mmdrop(p->mm);
 		kfree(p);
+		return -EIOCBQUEUED;
 	} else {
 		*from = p->data;
 	}
@@ -1304,9 +1306,11 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 		return res;
 
 	if (p->aio) {
+		kiocb->ki_complete(kiocb, res);
 		mmdrop(p->mm);
 		kfree(p->to_free);
 		kfree(p);
+		return -EIOCBQUEUED;
 	} else {
 		*to = p->data;
 	}
-- 
2.53.0

