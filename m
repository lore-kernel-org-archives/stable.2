Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB54AD4BB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055751; cv=none; b=RUzRMlVrTNRNBByl9eSMQN1QS487ZVLzgCz0DJsOoZWhQ8NAqF0XueaMHhPuvbpLspkr5bKBpB4iowKZJfTBpkiUVqEOiQAcUHHJ1EtPXnaU2eyBUw6tyV2Dd5Go5hfMYS8N/gH61Q/n0XXE2Lp8t4jEmBvsxFcZhQwyh4XJX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055751; c=relaxed/simple;
	bh=N+tpij/46jS4bW0hibbj4h6zIewJoSp1jhBSf0vbRmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDWR2nZcdzumvK7yMg2PZFqTAZVoZXER7AvCTjfEFoFZ3HpsFm6PpC0uSPUnSHeb61PIoinBYd3fD/ioS/2/JRnD5WuOr6NLESpVP95vg+tvV/UkRIIXB3XB6s4qBJVaHY41XdEtifM2RhTOFmhznepHw+EllY24vRX/jTvHlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekj0VEfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekj0VEfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418CC1F00898;
	Thu, 10 Sep 2026 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055749;
	bh=RRbZu3gg4AytzQNZhV2eJ6YdF2hhN1E+dzFHmMye4X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ekj0VEfgThYhPYBW1CjBfJFJ5mnL7h6bjJ77OhY4ZDmfeMUoVmBgePzLQsHudssBc
	 VH1a04oe6pUGp90rPpZ3ljQzmnT3U3nxro8mm4XEtxgjb4GdKpyVIfy3alug/nxrJY
	 iPZM9nxQ2MD4QTtwRr3c3MBo09U1nOpgmg43nXR6x9DcHhJHgBisXXYjIKKzr8nVPY
	 vo9QcFjj/37CeebVRXYlsLIySP0GhK1dX5Ypk1ty4L44xH2m4WXZk2YZLQrZldZ3bm
	 /iuTzwMbPKbM2B6KHLv8iJFFjMyC+rWRLtEni7ovZHk+zEvTqR4nXos5DoCnuSKrzB
	 lpGN82LOkMCPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baineng Shou <shoubaineng@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] misc: fastrpc: don't publish fd before copy_to_user() succeeds
Date: Thu, 10 Sep 2026 11:55:46 -0400
Message-ID: <20260910155546.1134527-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910155546.1134527-1-sashal@kernel.org>
References: <2026090820-pasta-equal-9989@gregkh>
 <20260910155546.1134527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Baineng Shou <shoubaineng@gmail.com>

[ Upstream commit a4a1a2bfcb29785292d634d7787edc6fb550714d ]

fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
into the caller's fd table before copy_to_user() copies the fd number
back to userspace.  If copy_to_user() fails, the fd is already visible
to other threads in the same process but the ioctl returns -EFAULT.
The existing comment in the code even acknowledges the problem:

  "The usercopy failed, but we can't do much about it, as dma_buf_fd()
   already called fd_install()..."

Now that dma_buf_fd_install() is available (introduced to fix the same
issue in dma-heap), apply the same pattern here: reserve the fd with
get_unused_fd_flags(), attempt copy_to_user(), and only on success call
dma_buf_fd_install() to publish it atomically with the tracepoint.  On
copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
unwind without any user-visible side effects.

Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
Cc: stable@vger.kernel.org
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
Link: https://lore.kernel.org/r/20260817050457.1005285-3-shoubaineng@gmail.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 576cd9e5b8079..f09702eaa3915 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1682,24 +1682,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
+	bp.fd = get_unused_fd_flags(O_ACCMODE);
 	if (bp.fd < 0) {
 		dma_buf_put(buf->dmabuf);
-		return -EINVAL;
+		return bp.fd;
 	}
 
 	if (copy_to_user(argp, &bp, sizeof(bp))) {
-		/*
-		 * The usercopy failed, but we can't do much about it, as
-		 * dma_buf_fd() already called fd_install() and made the
-		 * file descriptor accessible for the current process. It
-		 * might already be closed and dmabuf no longer valid when
-		 * we reach this point. Therefore "leak" the fd and rely on
-		 * the process exit path to do any required cleanup.
-		 */
+		put_unused_fd(bp.fd);
+		dma_buf_put(buf->dmabuf);
 		return -EFAULT;
 	}
 
+	dma_buf_fd_install(buf->dmabuf, bp.fd);
+
 	return 0;
 }
 
-- 
2.53.0

