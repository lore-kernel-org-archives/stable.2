Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968634;
	b=kxa97ovHS2l9umEK2wutcAcYWt7kOI8WsTtAlwmaX+QPwjh0gDtzNTDY/h772F1Ysy31
	 +YLzIVpEshYwbLbg+/WiA/7ZWRFy2+k5DSPV3CYnvU0ClEYPEw/BgU3p8hMnmnM3Z7rMq
	 0aXOGKXvsCXqlpOnIz77aFDx35KEAb8SQbqiOK/tqJz9rh5mnM997nHSqpf6bN8jLQ6Yt
	 M/mb0hROLKHgrQO57ke9n5HCnr6x207y2sfYxF1AvhOZPM/x+rJxl/NRSsjW2Eji6xsiV
	 tA7tmaybvnOx3+O6LEcmgmG2xTIzMaHE1wKf2tc9KdpgnOLYa/jmDlF3BXMP8TpGaPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wUeeTAm4e+gP/l64VYrs9ViLBpK4z7Ubo3j3QA2xch0=;
	b=AquCGG41cjoXpkYJuBOzNRj/GU3OeMPcYlLP5fsEe35R/yUNF4xDMzQ20jDFj5By86+q
	 OqFStA1gp8wZxsFVN1WyIy7gIF/n8KAEPPMyYrsW+0crXW3kgXJlAqpfvcUafOpFcqcu/
	 LJIUsaHsMMG4b7sWa6R9qRl/33zj5ldlfm75Qf5P3ENM1UyvNHKfWyd7OCnjzbgUaQ+xm
	 7PKDZOiJep6xG/fyN48GccWKX4mLmuWrUR1fL7yx5RmhvlU04h0zN8yhxq/SgmEu4lqwC
	 AhlXWzvaPDNqRsCY6hpG7SvSdCUIaqj/0Z+KHUketCMU1MWdbD0jggenn579M6zFG1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E04BmwxA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF27606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E04BmwxA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB37C1F0089F;
	Fri,  6 Nov 2026 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968634;
	bh=wUeeTAm4e+gP/l64VYrs9ViLBpK4z7Ubo3j3QA2xch0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E04BmwxAgJ+nGKHSgMwhtJAy3TV4ekkUCnicPuzmFMXqxnP/M+3aQAu6y4YTVyeIo
	 hbEq2zAhsm9VuSyjHXbqQlZ6Hd9su0nNKaqQGcObZZIf9VqWyCx8pa6m7iKLMQPl9X
	 UaGOfssmDOwCpQejCDVf7fY66BvLnTNpSqZY9+lKPF4JkcNsM1Y8+yKFCXeeHe8J9G
	 jrGbxp4YS8j7H8ImiLQ0UUfzCISEzblbZBurf2V9CJcd6QkfWURVKwM4FkCVyukCC0
	 RTdgB1egD19kTlYdoBck+SyyFMWH/nnvg/1TYlfyR2AQdKIQ2c1EE8WMONNf5jmZDa
	 RVlR8sZSTWVlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] NFSD: Complete a cld upcall when copying its reply fails
Date: Fri,  6 Nov 2026 07:37:12 -0500
Message-ID: <20261106123630.4049374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110445-skittle-silenced-49eb@gregkh>
References: <2026110445-skittle-silenced-49eb@gregkh>
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
Depends on <20261106032728.4021201-1-sashal@kernel.org>

 fs/nfsd/nfs4recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2d6f15e2f9bd5..22c51401b93fe 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -915,8 +915,11 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
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

