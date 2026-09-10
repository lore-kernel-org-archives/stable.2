Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2849BD6C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055559; cv=none; b=KmmCX/iHZuMu7pneHp5u4aacitzOJZmKWuSPvoUkvJj1AmkA90TrYqKfywH7j0Mv8tkFeMkzZ3x/IIAhzF4FKZ1jZfDFj/COpWqWwBnRB6SbVNFFoz8FPulPtGHt0UbOnCFO440OjE6T9YiAJHicEPy3UfSAm8G78dkQpoYWPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055559; c=relaxed/simple;
	bh=XmwJ8V/1mz+8kPYvCf8GcjNmYAeOgK5HrwVVT5cJ4jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjRYNp7wdvE/syI90XnM2Tbgi9gggN8M9TcmM3sYEP1zmrOWUVRLQOkyGr5WwEIlA66AQlJTszutuuWA/3+k+lrcd6l3qy/I75kf9QATWnQfbR+AHDiMYr3Yh81XQiTIuXjeVcOizjJ0wskKoVETqpFg5TvhoE+K6vpfqMfbVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZywIRen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZywIRen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B526D1F00898;
	Thu, 10 Sep 2026 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055557;
	bh=2qOBAmSwWIrCRrcWnsu8mRo+VK7KOUckKIz7g6Eq4E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aZywIRendJXdIn4ayQQvJfIegOZu986+J8YQRIH/ivX9qcG8ahjNfZ6MmxgzbccJv
	 nbyS/a9X/PSkiYtChENObH6mIIeacW4QCYPnQbZjm0BKIYkVFK03ONuVjmYNev28+G
	 VSgDsbbjmfYAzhdcTAqaGf1/ICDlH3DUyF4CRcCGCYteaTPuyuRnjsuFFiVHB3qJaX
	 cYwxdI2lqQPkQDCRSS1dPLvQcCfGau1X+KCRJRxt+kJWGnIQJlmtKbPWtkJvhrgnGq
	 YttkqPVO9vPh95fPrLuZ2/2/0zzBhz0V9eETcJc/Hg7ac0r8PjKGjHOmY7zOhl6EnO
	 tyNrrLPYJ2gcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baineng Shou <shoubaineng@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] misc: fastrpc: don't publish fd before copy_to_user() succeeds
Date: Thu, 10 Sep 2026 11:52:34 -0400
Message-ID: <20260910155234.1080006-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910155234.1080006-1-sashal@kernel.org>
References: <2026090820-renovator-enjoyable-ee8a@gregkh>
 <20260910155234.1080006-1-sashal@kernel.org>
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
index e240b94644809..29f9003999a07 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1681,24 +1681,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
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

