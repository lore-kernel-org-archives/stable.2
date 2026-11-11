Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407499;
	b=YDjsK1Y0yzY5AgbrTEcatrxKFyYiy88/FcU5AG1G624VkA5DXKGTsZLIdQzzjuhhnMrB
	 Nk/GB+zR31OgB6jHO/5WV0liWGtP+x2YAhAACpuNjm3ChOxB8T+I8sSy8M/KOn26aOiqV
	 J6HIE1NP8il9p5ekPHRJEqVOGbJV1HQT+SobGREVyi6gSTI2UeMya+kU4Fd5LL+xVxUph
	 qcimws3nSvH641oyQL3cr2abZbk0AgqdO9AR9TqtwcRbYkHOxs3QUyqeIb0KFLmqnCmQH
	 XE3r/otcX4+CaRGdnM2euljaYnSmGx+097of2/OKBkd8gKSS23YRzee/uGgdiNprP5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xPeE28alTEMgn8FyNRYKBpwJZrlqqxPdPlc7ZC1crn8=;
	b=t1ipLmLGCEaczY+Jl1U8jBjscQbkBmaWSe5p5e773NJVcN/zvI5st42Jdsh1T9WuseYy
	 0Kc3qdScRyNmNfTxSnxxh3NG7wmLYg6fZVl0nBv+yMZ18A/lskw80kho5d6afJCQSJC8D
	 avCG7LiO74J0IXNAtSnqZGOcEs+EhBKtgBBJ+20wNXSig2gN/ULkBmNLEUU9ghlx9vO5w
	 Cmgwf2p7/NjnE3B2QxpJ2XF5xdoLpsduC+YZjlS/W51sioe1SxthCHGKKvB9yDhhiRAbN
	 A8Lm0XAlbcuIlpZzTjxGOKbgepWCnHkH/oqmtamrGBMtLLPTMmrHno1kSmaVkpR6lEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDPghvNh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDC606A8BD
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDPghvNh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F43D1F00A11;
	Wed, 11 Nov 2026 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407499;
	bh=xPeE28alTEMgn8FyNRYKBpwJZrlqqxPdPlc7ZC1crn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDPghvNhsR5JD90EeVoQp4pxFjKDLhM8V269rmy+L3CVNfpc2kLcwuTTJT4JOsOY3
	 0ovZ5gDz+8KZoL5Cia050QWRjODOMebpP002/c+TzQ/mOrTFBKcTCe09J5XbCCAAuV
	 snKOLPIJkS9UF0s1n54g/p2aKxa5yjQWWptoo1tBKwLw7IH69vDm9LGQWbTr3fyUp1
	 KWFxRrydv65l7HhO+Zy7rCJhn+7Nzn3K68nbx/2K2m9nwU5L3o3/ouDxe4c2JFJ+LE
	 30dLhiJ25WfjvBIS/leW3273jVl21ag6Hl82Uh36tu5gO3fQN6yiW41DA5Wcy+HxvY
	 y8AktpH6fNsxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte
Date: Wed, 11 Nov 2026 09:31:37 -0500
Message-ID: <20261111143048.2325330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055402-failed-6.1-1ae42513205a@kernel.org>
References: <20261107055402-failed-6.1-1ae42513205a@kernel.org>
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

[ Upstream commit 1ae42513205a38b811afedb6797f9f9c4de37b90 ]

ufs_bsg_request() passes the user-supplied UIC argument2 unchanged,
including the result byte (bits 7:0) that only the host controller
writes. A non-zero value triggers the WARN_ON_ONCE() in
ufshcd_dispatch_uic_cmd() and corrupts the reported result. Found by
syzkaller.

Reject UIC commands that have the result byte set with -EINVAL.

Fixes: e77044c5a842 ("scsi: ufs-bsg: Add support for uic commands in ufs_bsg_request()")
Fixes: 9fb4c793223b ("scsi: ufs: core: Complain if UIC argument 2 is invalid")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261015001855.3450573-5-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: adjusted context to retain ufshcd_send_uic_cmd() instead of ufshcd_send_bsg_uic_cmd() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 118172fd66176..89cb6825dd531 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -129,6 +129,10 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	case UPIU_TRANSACTION_UIC_CMD:
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
+		if (uc.argument2 & MASK_UIC_COMMAND_RESULT) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = ufshcd_send_uic_cmd(hba, &uc);
 		if (ret)
 			dev_err(hba->dev,
-- 
2.53.0

