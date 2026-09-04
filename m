Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78551E42B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546924; cv=none; b=nyjDlFhK6CC1xHCQjGQnc5J5wNhlvmsdPa8xy6Q6bypvTYsN+kSHEduyGylwqZC27nlpqqh7ePzg89PPV9AYxbQyUFUJLYGTK0ZBEDDkrQeM/nOa/1edDY0DVLVT1OFoXxaAXOAYeTzBaeS3IzmrxQI3x/RF7uBHxQnM9MSTNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546924; c=relaxed/simple;
	bh=WYgXGktuRjobafyL5MvKI84Atzaq256crnQ2j/Abijs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFUW6SZjmPI0j+reaJRVC5YUuz3evRFvDU2amf/8bOWRigZJSw8WwkpAAZWIRhYZzFf5cxVUjbza7D+VDrn2nqNMqgeIM2Pm2dVG836PC9PTiQKzVfl2xZFxH+3k6dzX+krFG0aiOh8g+w/nHTShqE1fk+ZtEmEJY1LM1C5+1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIdNLMpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIdNLMpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267A11F00ADB;
	Fri,  4 Sep 2026 18:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546913;
	bh=+BC0BYeObthNICC7r6fNuVsswfI/HMrA8OfRYovXsJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YIdNLMpVNtsJIq5q8X4MiQuP7p/MeZe0pkCKkih9WrkYmRyao4z6yteD7umRfNPug
	 UXvqBriKABqGhe02woaqloTyvJOf6txkQopWm7GBSiDrlmboXxDnk42iBt0OYgsAfA
	 p8CzNu6t2sSZJMN2Oj3etReBVdcsXxoVmIEg5e7QM46K6yntq6sNWCIY2ET5Za7Re0
	 BskXCiAizJCHPBeT4ut3v06ODYzDfQ5n/U1Ot6vFaujo3kjQ4eYKqZRYfw6mHofHca
	 eMKKLFMp1poEMT4YCH1Q6gKxjYrT6I8UK2azcSi/Ajp1POh+ftoycp/3Quu9fZVnh8
	 2JyW3DRn+OngQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	Xingyu Jin <xingyuj@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] usb: gadget: f_fs: Fix Use-After-Free in AIO error path
Date: Fri,  4 Sep 2026 14:35:09 -0400
Message-ID: <20260904183509.1323404-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183509.1323404-1-sashal@kernel.org>
References: <2026090334-tiring-good-fffe@gregkh>
 <20260904183509.1323404-1-sashal@kernel.org>
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
index 19d7b0cec0b03..3d4b8d9b355ac 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1225,8 +1225,10 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
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
@@ -1276,9 +1278,11 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
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

