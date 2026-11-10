Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342925;
	b=Zvilh2z4GLNb/0TZfKLyfkwm1ZJuRdpyYKHXDN+GQ4PHKEDMSC5MF5d2WS8uHvJNxPPT
	 GD0PRKGgC5jU4Q1oSrcCc0ZX+u1GRLfnYPVNO4jkJFE9gEFlNxoP7Mzz1XwbVC1VvedFk
	 ahvOce6wRoF/qhttU+uwI/eo5LcR7WZd+iScgdUrWtxYKtZEc41SaGs+2fEJlLkBfb8Sn
	 DoxUybtUOpDJmqQxTOp9mq3pmpOO71qR7+B+z4nTtVJ8TxosqSBkP6ZtdRv4NgKVyLOhB
	 vsVJAfpVvyMKw8039Kh89Qv88WMM8Vl+zH+9AtQT7q24zRODBjx9xhvxQGhGD+vBcDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342925;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kMwkySnLfd1AIcE7CN7h3nzaIvEu7x64w6erQOC9nwY=;
	b=fIag3OX8nPOp3avhNmJukasLGsz2wu23i2KyGxoxx+GP0rLBP8lN55khsEzYqCMnWd53
	 FPgEQsxnXPbbOt1HOQLeTl1dPvyUUTMpfi0ESVhwtp3oDB5y43Ysx8BhXNaMfBPfTbi0L
	 4lTOfchm6KwDxtn9OdyMb6nPUDhZ/4bY1hkuUyx/OHVtQ580Jniaor6yZP8tqBekgbSip
	 4I/8XcmwfovL9Q2jjVuwwlkqUuCud5OoHCAqtc2Vem6SB+3WiQR3J8HUw3OyKpVc2aEnN
	 rvtJwPzV5TNC0WiHtBJrlFMIsJn8KzE+JBl1jSdko7yM0Q/4K3nm3ULYIMDrqOwo0Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h78Wfqte;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h78Wfqte
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680941F0089F;
	Tue, 10 Nov 2026 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342925;
	bh=kMwkySnLfd1AIcE7CN7h3nzaIvEu7x64w6erQOC9nwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h78WfqteENOArjpxse3t7E4sErzghvHcnGotC9wDwq73GXd/HNaPDyak2YPaRP/EW
	 HhK462h3RFRE7Na1YWxPodFZucKZJgYDh51CVMDXRzxgL06s0Y3MzkgVy3/owkPeKQ
	 HMYgbnRytqRqu0VgjUogY8B2WbHUnxvm2OMXe8XBGWzLV/W5BaGjWfhMpx0Mfir6qQ
	 aXp7UUN83s1aicF0CwooXbC8AV76nKH4FfzNAmb8/uA9g8tNi0hCx4Kv255NerPNtt
	 j95wDQikVkx74tADiVs7Er5a71npLwL/7k3CIdTf413QXn/47vp+9W5FuGj3ByfKKj
	 RrGSurxJTWNRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: ufs: bsg: Clear the reply buffer before use
Date: Tue, 10 Nov 2026 15:35:23 -0500
Message-ID: <20261110203417.3782989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061111-failed-5.15-2e63ac76cc08@kernel.org>
References: <20261107061111-failed-5.15-2e63ac76cc08@kernel.org>
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

From: Stanley Jhu <stanleyjhu@google.com>

[ Upstream commit 2e63ac76cc08ea376ba61fef52f7b7849e35024d ]

The reply buffer is allocated once per tag and reused. Requests that
complete with a positive status do not fill all of it, so user space
receives bytes from an earlier request on the same tag.

Clear the whole reply buffer on entry to ufs_bsg_request().

Fixes: 95e34bf930ea ("scsi: ufs-bsg: Add support for raw upiu in ufs_bsg_request()")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-3-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: Adapted the file location to the older UFS source layout under SCSI. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index b8bbfd81b8ae0..e27b059ae2d1e 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -95,7 +95,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 	if (ret)
 		goto out;
 
-	bsg_reply->reply_payload_rcv_len = 0;
+	memset(job->reply, 0, job->reply_len);
 
 	ufshcd_rpm_get_sync(hba);
 
-- 
2.53.0

