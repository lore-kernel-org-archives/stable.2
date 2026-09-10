Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E253CA9D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058905; cv=none; b=Bgcq0Y/t/ML0mRPnzqJK2SRsJZH14TSycziJi7EPQRyo/VOBOY7YbvAd07Qq6YyKXjJa61+9GWc/vq7NG8tN3q16TQMc+1DISei6kj6+uD0ADYKmEQfH36rDeCbahv7uyqk+ELoTI65b+DmOmBO1KFzBsevLFCj9qS6BEJe6YOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058905; c=relaxed/simple;
	bh=sLrNuEOT6u/aDupaUEtp+J8hwNcNv9E9HbOhAGDMN18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp/Duq5ftEjkJQ2VxNjClhVXiC0oRZF+n3i4UDZwMSK+Tjz/kMEf71UcK2l5rEMlWY5CsfE8muxCH0pub9O04+U/G6ZH+vamQAKrr9Vix14y3SyvDqrAkPDxh5YqI0+L13gDqdJIRZWW9shVNteXaAQFNG7fnFAUYKrawgKIwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHELM84b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHELM84b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EED1F00898;
	Thu, 10 Sep 2026 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058900;
	bh=zpSlYtiBehn2nYwSJZAJk57+4hU53YnZR1YaLmvtPEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHELM84bm/7PzFf+QSReE3mlBK/VSNoqqDW4pz66vIGkHA08PKH5O/dT04FBR7JO+
	 JYCiGdiVbojBkf35i5pssijQsfEYdVbVs4vg4mW/uB3vCfKGZTSIE79G1zyK/NSvRj
	 2IpPG1jElNveSX6OYrOwdPNf9ZLhK5m3CM/vTFOFJ1ixlNhCoDRUPlXAwzMcv3376M
	 wiYk8OVdsEjMToFF+QhDQN8e7x7V9hV+ENp5GwN50xHW5hdYK0fJfpWiQq9qvcf7Wn
	 1xxrSpkBUTNZ8WlnhdnwmCxqkAAKhkB+ndw0ERTSLO0uBR6aYUKLbGFgm0eqjwYYgU
	 DttLWvCiJXHfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baineng Shou <shoubaineng@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] misc: fastrpc: don't publish fd before copy_to_user() succeeds
Date: Thu, 10 Sep 2026 12:48:17 -0400
Message-ID: <20260910164817.1252456-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910164817.1252456-1-sashal@kernel.org>
References: <2026090842-directory-dispute-5aa0@gregkh>
 <20260910164817.1252456-1-sashal@kernel.org>
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
index 6df7f3ee7a742..9c31fc965b4a6 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1321,24 +1321,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
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

