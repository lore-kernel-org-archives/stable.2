Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DFB4CB8B5
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533505; cv=none; b=HDufpH+ExhkADTevwDIxT7/iBbB+RE/22SGS2F4iqzY0Th2bRhXpgIUa1IwMTQG+bjBEzSUKCTLUClDfMm3Oer5b1SiQaFr3Y+p1KIopFr7vgxYt5GAdv/F1w0174I9skB6aGMlm/Dy2VTHtw5zJJKhXcXBYs56m8Sk6RmwnN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533505; c=relaxed/simple;
	bh=701mkRvRwBdHThMHpTJUQV7FhlAgLIMgj6XTFybGDYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6obT914kFotvdjTCdZyFoFA1bGPXOJy9h1hzNpvZ1e4ig2NdJAOBaqEdFkD1q78T4hLpNYxfgehMfkVhPTo350O981z6uQwNbU21I54pICg/0sWAWdjtnvfdFcoVXLiHhHTKSMmgN/KjAa7mMiZjmyV1wjEB9WU+bAWkXc6RIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koR3SlKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koR3SlKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53951F00A3E;
	Fri,  4 Sep 2026 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533503;
	bh=J6zz3924uTauGEr//TiTwfNPgjr3OpuzAA2Q2cniJ64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=koR3SlKp0sSyjfZQmQjTKxu9BoJmMKweJAmuEci+b4lyVf5zLCHV9KNOf2GhS1ImR
	 2E0YJp1jZ/8u9iX5vnGk0MTljzNx32JkLOloCZ6tAg70qZc7HiQb/KSBYGP93CM1n3
	 NJXwVPE6vBIR8ZYmhNKA+p/qIV7TV3AcU/vyYo/yQqIJEZc+aDSWmVGcM24ahBdub4
	 gIWjF55+buOPyCPFmSR51HuwwBulYOAgeWncK0hPtpMxnUgu/lNigP5J3KRGL8t0px
	 yfywYyqQEVAqan1EPmXymTv/jfe+YeKCUYxbcMTqxVCa9b5ov4gllnpkf5DOXLqaOL
	 ZlBPlYzh11kGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	Xingyu Jin <xingyuj@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] usb: gadget: f_fs: Fix Use-After-Free in AIO error path
Date: Fri,  4 Sep 2026 10:51:40 -0400
Message-ID: <20260904145140.837773-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904145140.837773-1-sashal@kernel.org>
References: <2026090332-unwind-impolite-0e7b@gregkh>
 <20260904145140.837773-1-sashal@kernel.org>
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
index 7e228ed9729d5..29f66017be90d 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1219,8 +1219,10 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
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
@@ -1268,9 +1270,11 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
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

