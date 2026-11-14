Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794638724;
	b=LctoaZ640uTVFVgc2waoUlHoctqxA5dWT+kZTE1doeIfhlEYDlKn+CQvsUxMDnntFGZE
	 4He1nQbv+UgrPcOf7MKolOv3vIEzxurw4nOk9XG2+ZG8dbDo0+/PDMNVbo3LpwzANoyR+
	 q1sxTxrmmHxhkuJVQzS6y6WpyyoGM8/a8AY7wN6RgmhwTqE7OaPhvVG93ltdczv6N9wLb
	 hjY2asKzj7mtzD70D6kMUZbKBSWUJUwR4KOmXqIQxKspPFK8mc6Tp78cLpkmXl4JAL5jx
	 Q18JmrKgco6Phvie8YBxfdL2Bb2YRngnPIkynOiu506Ll1q+ntG0CffIj/UoYIrAHXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794638724;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DFKiZaCiaRePBzdaW+pavQKIZzCTa4ohuQMWJ3m4AbA=;
	b=QmgbwQejg5r4zaKrpu0bE+fs6D7xYsVy2kNi/JGeDHncZp8AK9RQZgK3YALe7XNER/E9
	 nXD/zkm72nBYqhbVUAeSTUuGEo+IvFggCik6rXt/mVOgLsTDgSVIlflhsMGJQHyj9tKJO
	 h15RROJneTnbU1/B0jZcUrYMLZIE7AnYJzaE4+zjPAd7Hflbk/R5u6REQYGXXktacIMVg
	 QCO88RY+Z81HEDGsrqmjWdoUjTh5skJCRd81i1OEANuAONoIzOpqJtLFyxQZGU9gi8+fe
	 tJuzIaN4+/BBQMdh3QuR2MD5lWQ6c3xpb1abBxM/GR+MR7szfWrIqPMxcqqNBY7nGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MltH0hxf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCD606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MltH0hxf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B319F1F000C4;
	Sat, 14 Nov 2026 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794638724;
	bh=DFKiZaCiaRePBzdaW+pavQKIZzCTa4ohuQMWJ3m4AbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MltH0hxfIMEqN9I2E4x6b8hLjsW2c5u8aj4JnLnPesJBVK9OSSakLw4f7ElYEGzZF
	 KXFgXrauG3eqBzSewqzFAo1S27NwABKa6DeDRtIfjC10XGv48NWnHjNJ/hHq1YHtv6
	 czqTzLSL4rUFKflOA/7nIGfJunER7sC28+WOioACEIp+FzD02Q5KJNzJsNJYFUB5yT
	 3b88FrYcRR9tiY4QkpMEiQoImMoWyKXxOlZQqCLjbH9FSKxoIwSPKBxoJeO04I//Fl
	 l0L/Ph92r9tpH5m3lv4sEnZlTKSQ4lslSEQfX66K7YaisqkPao62GQFCWyJQOlezSL
	 MkkLGF1NfdJvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Wang <x-professor@outlook.com>,
	Yang Xiuwei <yangxiuwei@kylinos.cn>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: bsg: Report synchronous data copyback failures
Date: Sat, 14 Nov 2026 01:45:22 -0500
Message-ID: <20261114064511.3170394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202554-failed-5.10-a52f2ad45726@kernel.org>
References: <20261109202554-failed-5.10-a52f2ad45726@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yingjie Wang <x-professor@outlook.com>

[ Upstream commit a52f2ad45726d788755b525adcf51f65a6b836ff ]

scsi_bsg_sg_io_fn() ignores the result of blk_rq_unmap_user(). For a
data-in command that uses a bounce buffer, unmapping copies the completed
data to userspace. If that copy fails, SG_IO can report success despite the
copyback failure.

Capture the unmap status. Preserve an earlier sense-buffer copy error and
otherwise return the data copyback error. This matches the error precedence
used by scsi_complete_sghdr_rq().

On x86_64, a virtio-scsi INQUIRY with an unaligned PROT_NONE destination
made ioctl() return 0 in 20/20 runs before this change and return -1 with
errno EFAULT in 20/20 runs afterward. Writable controls succeeded in 20/20
runs on both kernels.

Fixes: 10e8855b9451 ("bsg: add SG_IO to SG v4")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <x-professor@outlook.com>
Reviewed-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/2561d633cc8cef513d75eb1df260046a4971e783.1792772194.git.x-professor@outlook.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: applied the change after complete_rq() in shared bsg_sg_io() instead of the SCSI-specific scsi_bsg_sg_io_fn() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bsg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 2cbc1fcc8247b..73d2544beca29 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -137,7 +137,7 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 	struct request *rq;
 	struct bio *bio;
 	struct sg_io_v4 hdr;
-	int ret;
+	int ret, unmap_ret;
 
 	if (copy_from_user(&hdr, uarg, sizeof(hdr)))
 		return -EFAULT;
@@ -185,7 +185,9 @@ static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 
 	blk_execute_rq(q, NULL, rq, !(hdr.flags & BSG_FLAG_Q_AT_TAIL));
 	ret = rq->q->bsg_dev.ops->complete_rq(rq, &hdr);
-	blk_rq_unmap_user(bio);
+	unmap_ret = blk_rq_unmap_user(bio);
+	if (!ret)
+		ret = unmap_ret;
 
 out_free_rq:
 	rq->q->bsg_dev.ops->free_rq(rq);
-- 
2.53.0

