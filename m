Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F9533596
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067325; cv=none; b=jLbJlrpeKdN8ybvas+DTTGfOtXF9R+mHNprj6Aiw4gSq2s/lHIr3ZbajQtZDh0mHcIYmi0beX7jyOYD1uA7Y2H7eNXs4d/15qfbTCz0cNi58Hwzv49Ydb81s3yOghRFGWAcRLt6JcS19T0ilGp0qROeuwAeZIh6Qxvduw22vY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067325; c=relaxed/simple;
	bh=RGhBklHQrfRgquonb/TvKkyvSrTngroKxE+eppS8DQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNa3OCV77o2oNpGPphhmIKek2+bm+COOcStK7pBaMIdwT+UXU21X61LvqYfipMl/6naurpzjz2HhA7yPI+/B79dBxx2uUIc71nkH6WcA01t7hvxrdW9ydPVw35n+lS6DVhSp1aImEAzUFP0tE+eY5Z82eovrqBbgRnF99U+TYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJPrjH9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJPrjH9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88CD1F0089B;
	Thu, 10 Sep 2026 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067324;
	bh=frUlhyL4wr4R59t9IPGCt5grNGJ+WNOHes+WzSACcaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BJPrjH9vgFnWXcHy+a/thkX9wMXO/Otr30XU1YUSB407ZdkVBXsTpc/37dZH4wHRw
	 rDqQw2WswOwek7Ire1y4Cup0s0La8hxEjSVZi26EupDUOA9PUITKERtzNoRJq/a0n7
	 l/uIT1vqRBOloPwoQOFkrFgLgSBjNYrd46q1kJBNraaui8k8E7ys78BKHsMAOrP36d
	 d05YcKAMl5wjOgcKe6ZbVpmWqsapwoOW54c+Wt717FJYWeg+p+TvyDRtoj1xKMmqIp
	 vFuLW9JODRRJx3lkR7i+I2jJQPadKXmjPBZPnIc7RYIMtvlVuKSyjjFa872ZRJ15uY
	 Ybl8ms+INFWfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baineng Shou <shoubaineng@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] misc: fastrpc: don't publish fd before copy_to_user() succeeds
Date: Thu, 10 Sep 2026 15:08:41 -0400
Message-ID: <20260910190841.1453617-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190841.1453617-1-sashal@kernel.org>
References: <2026090842-deluge-gloss-a643@gregkh>
 <20260910190841.1453617-1-sashal@kernel.org>
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
index 6f1787e83b65f..eba3191a6708c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1319,24 +1319,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
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

