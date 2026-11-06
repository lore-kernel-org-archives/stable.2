Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935133;
	b=u8692qw3KVSVdg7E7HC1CubmsxkHC4JQjlb8aAOmI1Z1zh4ginn3YIkD6zrow3+Cth5A
	 /0P6KCVzBsSrhB+fskZop2vo4Ki3Z2ZgKd5JDZvwePoiK0/e9Gw64xwSGkfPcuM5bw10N
	 349AgrzdMQe2I2N+j/cBk4CiEZguDBPMSSNhllezhDv7mp+Llv+x+tVFTX5sT/SxAGgrS
	 iXXQprocc9krr8P45aRzGs2c5TdvTxnfjAIbDNX/9unUr5HDXCfJWRGMRbX90HoEo49FC
	 HSe3U1SoTSwEibK3s798YLN9tTRFTtW1905a40IJLKmX6+uIIH4yV230SQ0o3/5G7UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935133;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+yrjqJ8yvuiqkSMV6JVJlb1fE+pc6P4F8g26Wtrkh54=;
	b=Xa3WEbBAt/x36rAxEyskxKSd+IcDp0vDicqoyls4YtapCOlNO4kM6aUbbdQ0eYR4A8/K
	 pDTqI1a/7gdz5yoXVoLrl+jhbdhycPjNG/FztSJj5nPNZkVbNwo3dY/3f9HeH6uM7S11E
	 ai7W49ytdGywx3Oa1Cd39HkJ7mTG4A6uYXvtE/ZJasAeuOirkvdctBI3RmkzaxGfHr7+N
	 YxRtj8lHtOXzS5NsQ6XNlrCDIahsXESNgv0tOp25Negu8gWU7ys0cZ0m+IaKVkRCaPYO9
	 u150DmGSP9YHzDIZ31zk8tnTqfsuMuVWr9H3e77gtVKGZNykSqlBxXiLW6/pB/GN3Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP+xcY2I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186D606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP+xcY2I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE6A1F0089F;
	Fri,  6 Nov 2026 03:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935132;
	bh=+yrjqJ8yvuiqkSMV6JVJlb1fE+pc6P4F8g26Wtrkh54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aP+xcY2I7YWQZEURwvLEodlZQlrQ9n2TFqDtdAuWfuXLpM56OAcf3mQIaTBqi4E5O
	 PqqeCEWfZ5x7NmNh4uVDiwkphhTIFMQtwL0/a5oV0hozj8R9DzaX8zCRLjCfTd8lfO
	 mesykmfUSRvxc3fPFhHXHk9OpddkLRMnlGOmySbjht5fmMkXy2Ehje5schFTHXAr3X
	 F5U1xvfzFycxuX0c+HDYRrKKS3WgasuBGCW6UEfgxI5H73stz9liJ5uNQkeYPPnnIL
	 ymta4Ho41NhMjDo+x6d7UUJHxcUEqVPwfaPqz0ejv8jSAEneFLmP00n/hK2dNBsm9P
	 ZybbxHRFMfPlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] NFSD: Complete a cld upcall when copying its reply fails
Date: Thu,  5 Nov 2026 22:18:50 -0500
Message-ID: <20261106031843.4004610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110444-revoke-slobbery-ab11@gregkh>
References: <2026110444-revoke-slobbery-ab11@gregkh>
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

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 8cef2b0a01d28647facc57501a3df7ccd8d13ccd ]

cld_pipe_downcall() removes the matching upcall from cn_list before
copying the daemon's reply. When that copy_from_user() faults, the
downcall returns -EFAULT without completing the upcall, and a
retried write cannot reach it because its xid is no longer on the
list. __cld_pipe_upcall() waits on cu_done uninterruptibly, so the
nfsd thread that sent the upcall is stuck, and nfsd shutdown hangs
behind it. The pipe is mode 0600, so only a broken or hostile
nfsdcld can trigger the fault.

Record the fault in the upcall's pipe message and complete it, so
the waiter returns the error to its client tracking operation.

Fixes: f3f8014862d8 ("nfsd: add the infrastructure to handle the cld upcall")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901-alemi-v2-3-e163f94a3a6e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261106025913.3959182-1-sashal@kernel.org>

 fs/nfsd/nfs4recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 9c7f6d90a1b99..ef0388d92aca5 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -920,8 +920,11 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (status == -EINPROGRESS)
 		return __cld_pipe_inprogress_downcall(cmsg, nn);
 
-	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0)
+	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0) {
+		cup->cu_pipe_msg.errno = -EFAULT;
+		complete(&cup->cu_done);
 		return -EFAULT;
+	}
 
 	complete(&cup->cu_done);
 	return mlen;
-- 
2.53.0

