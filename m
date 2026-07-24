Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAE483BFE
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937069; cv=none; b=iDXvrYYisVi7eBqhCLIvEpqO+Pws8gnw+kjDPStn1cv62WPlbOXktCAuCQcNWGwoKv73GxkFiVgoOXR3XMLbomz+Vo9lslLKlkgwjFJM01gP9psF2bZ2lD6qnhZ/7cOtXUw0NDqhdHjEJa+8Z0YaMD1MfqPR2Xa9MQaBu/MfPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937069; c=relaxed/simple;
	bh=jlsa4KOozpF8lkrLjI7QECxAXU6Mr2HPk7AjzRmvTT0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hICsmm8/CSOzesjFjzEWqtU6bvzDNyCfNNJXm/Po+pMPEaVE+I/AmVsDVwvEnrOSoX0oHbFK0kh4j5/Qln4qaon7klPFzzJkk9Yfi7sSWdeXciE5AHxjXDTRRuGTJ9T/3M1HtQYqRatn3yNRlZPa9IwwTQy/M6qYZuVfDxs7QTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KrWKA/l/; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KrWKA/l/"
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-43b6de00772so478690fac.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784937065; x=1785541865; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=inDwNhTjfAEReKAs3ZD3SpJEd1qaXM6z94+m+5MyCOI=;
        b=KrWKA/l/K3yEmPVhNxPShdtdmnW2KhIyx5L5cnbi6UqpAyMIKZlGDb+Ij+Ux1h+QtY
         lw/5mqB+bfEzMDok2cpBHdNWC5aWHc2P85hMCD6gCoafp1wFCThuVqr9+wNk5pd4gOoU
         rvwj1rmaMtWxfYK94uM9JFRlXstpybvu1bAddjMbOAQeNKkPiTSXie6YwWrqCZgtboj9
         7oIAWYiwpF6gyoWta1hwNdsFyDVJeRSztGfnKWLnViSYnotvJOiaUrtZ8mMFCuARTSJw
         GYaEoaPp5zl/x3ngNtMqaIbYO1mnYoJYesEbwbFjUcfQRo549sST0b7zRYc58n7+d5N7
         LxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784937065; x=1785541865;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=inDwNhTjfAEReKAs3ZD3SpJEd1qaXM6z94+m+5MyCOI=;
        b=NOVhLeYWeUBZMg0DS0B4oPzXfCCcerYi7UAtg/GfW5stIS7o51KthWfpqm1pn38zZE
         gjrakNhP+SNHwJQFVdLY1jkOOncpcZaSX9T60Hu/DBrnWzOgeaiFmHsT6ktDaFNTtuRX
         15/uqxYRujM7gkqTCzzS3uJ3FbcNVhTMjvjNopOAeNw20B8ZCoaB+p+sOEoUOIHLXJoM
         CyfJ+4hi6FMN+k75AL4o8Oa2BRDDCi62UA/MJA7lcZPqJKlBD0VUK565MOMmuxoXYWxh
         ohZe4w8snbKluf7yh5lGMFxJWyaIWtjlFNNU1GAXzeL77UesMDNHCYC9iw5LRCmF2nuG
         858Q==
X-Forwarded-Encrypted: i=1; AHgh+RpsiwSZZeq0ggesurJLt0QAodRvMZIZDz1luk1/2EvdxJ8hqR9eGrvDXtvhJ53UvZ9aWRosRAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2PurJ1mAesN5ZOm8/Ib9YENn6K4KOuf9YztfF9VRpvNAsvu1
	58qkv3optX0Aul9Smcf3V6/ORWAIvb3mRojAoL07FCvFwG/B/7b4gVPxvucO7ZVovvo4vNW81fd
	tdgP2IJNZQQ==
X-Received: from ilnz9.prod.google.com ([2002:a92:cd09:0:b0:505:f2f1:cf8f])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:23c2:b0:4a4:a693:9d87
 with SMTP id 5614622812f47-4ab69f5951fmr680108b6e.5.1784937065410; Fri, 24
 Jul 2026 16:51:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 23:51:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724235100.106011-1-nkapron@google.com>
Subject: [PATCH] usb: gadget: f_fs: Fix Use-After-Free in AIO error path
From: Neill Kapron <nkapron@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: nkapron@google.com, kernel-team@android.com, stable@vger.kernel.org, 
	Xingyu Jin <xingyuj@google.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
---
 drivers/usb/gadget/function/f_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 073c4cbd90fb..8e9bf0bdbcdb 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1290,8 +1290,10 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
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
@@ -1339,9 +1341,11 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
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
2.55.0.229.g6434b31f56-goog

