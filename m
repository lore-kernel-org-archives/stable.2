Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58863822A3
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532367; cv=none; b=feLEXA3xglc+JisZ4JRtecE6FGew4+8Q9g/apvDcmMrjinQ8TyrTsXRNblFAxhSeZqWC72EwOktwrXdDq+m8fwcqn/ZQm5rKPXsRnsniRGkRYuJmi4oe6XWz9pqLnb+Hboodk2vldRdOu1/wXBTnd8R99f4pg7fb+5HhBrlU1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532367; c=relaxed/simple;
	bh=xaUBdRDO+uViIivb33QBwlkmEXsjunmO1YdW1dJtxu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibf9PSwInwFKCoKN/m3zP4zsFJMirVCkQHo4an70NhO6V6/kXt+PbFR5N/4pY1magp6DOgOrLf0xDHEUJMIMPOaQ0LuYusvqLfuXbHa14wyJZM8xWckQaZtYngIa4vNGN5rrFIt1StcY4rS9xxWvTbrIwi+HnXSuKY5S8I0ZryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE1SxaH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE1SxaH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8621F00A3E;
	Fri,  4 Sep 2026 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532365;
	bh=CEsd3On9vJB4nteA5ndtbsxPcnsFVjkeOuyJRy6JTxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fE1SxaH/JhLCj81lMEtNBoyVQWXQiVqGm5Y9+cqk7y2w12sFMsX8HH559eJ1d+fAY
	 96fkz/aRLPmbSP4j1Glt1QZQKhYiME4qNAyrE4wpsu3LsVXyQje9/h5HbcHbOfkW08
	 U4YAocpE53qrqLWjkqwcErvgWZMBcCjZxwhNwRqkvDJtvXs8Z2AarDOeiKvYulD/p/
	 te3bX0nvEWCArU8x8MRYTNHVu0DXEqKuBWYfVT8do6zF4e88VZMBeTTkyFlnS0kUdu
	 YcdGI9vdl86lFde7pxKfpaJUJgIlCqIbtOwy9Q85qrHdjOntMZamBuRVZoG70Epr89
	 HgaSGJXFHm8oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	Xingyu Jin <xingyuj@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] usb: gadget: f_fs: Fix Use-After-Free in AIO error path
Date: Fri,  4 Sep 2026 10:32:42 -0400
Message-ID: <20260904143242.806049-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904143242.806049-1-sashal@kernel.org>
References: <2026090332-backlight-leggings-4547@gregkh>
 <20260904143242.806049-1-sashal@kernel.org>
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
index c6eadd3433f27..8cfcddc4dc160 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1267,8 +1267,10 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
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
@@ -1316,9 +1318,11 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
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

