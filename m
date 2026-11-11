Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409149;
	b=r1LH4cSTqgHPHP+Hdmu6DNR6bxQE2ZP91aAMDLjI+9HG0ZP474TqVOq5PJ867fA3dtIo
	 f46y/KFeInB+HJDQ/9u9abdrVVz43CT4aWht4vFRWT9pFzmZcIYuaJnN/QM93tOVtXty7
	 eXNzjurF1FgQi8Rvg3dPPr54lhlzAltxMummLp5aWGd8tr/f6b45GfMQKZuM73ibErVm3
	 VyEm/RCuknTndTZkSpK9hCB3JD6CEzDFaI6q71Md67dZvgMIUTGPz8E9frG3OFjbq76/G
	 R45bVCZHyLh1FOnT2KofUcT0OdCkTf+leR0VZ2mE9ybxGJv3IAMpOEWOQ27lq2XN/Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409149;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vo/tPjeVofP6LhqesaLq9g/lru8Sn/b6MpuGYpOjH6c=;
	b=mCVJxqI7yr0xJVyeXngo1DcnMeymMfsj18pT0UFphH13BlG0UXfze/ws42QpYsdMtQAU
	 T6R09PJDXJ/ma41kjSWvqoyfU7IM9yoqTC8lyz5OKzHxlAmNuvwDgXyQC/zzaC7WJU3bZ
	 OY5KNzjBUyH1gkteAM4aj427XuP3+vRvu5ujBkdiw/WU5mHLnTLF/CUEkPi9t9EzqVn7C
	 3bTXHFdvFQKmPjm0B+BuCyi6FxS7/5VGwxKcflLjYetAL5fLZd5Ab75A4X/fkCzCXRC7W
	 bBaBWExn02bLWjdo6JflHZBJSo0qOUF3CwUrM+k3yagKngSQW7XBcEq/BafVAVq06rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ejqziwpq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333F606A8A0
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ejqziwpq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DE01F00A07;
	Wed, 11 Nov 2026 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409148;
	bh=vo/tPjeVofP6LhqesaLq9g/lru8Sn/b6MpuGYpOjH6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjqziwpqMX9qPvMc4yr3fL+sdd1eJs2XmR/N1EuZY70aOD/jk2iwI/qUW4Be6ukFm
	 c6QYALi73fiaCUfqE+0EiVnPIRQY8i9dxX1zLNljhXR6Z0jef0/ML8EVZWGnMqWjjZ
	 G+ya1EcLgg9hOeGvWa5yJO8q7jGEB9CRPEeuIrd4mjk0u3zY1HxwpXhZEV1GcKbWzu
	 eWd7ShzgzLOGnFALEsDY3HfXJT4QjkeYUrpr4/2vxsrAfts2aUg9Kac3yUMSSY7Qy/
	 S+DoID1rnLu8BFw135u4eTlRy8FPwpBBexuGgtaZXdX1TC9OAeULnrzvpZyeJooA8F
	 JSGdjf2yGiDnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte
Date: Wed, 11 Nov 2026 09:59:06 -0500
Message-ID: <20261111145842.2491213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062821-failed-5.10-1ae42513205a@kernel.org>
References: <20261107062821-failed-5.10-1ae42513205a@kernel.org>
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
[ sashal: Adjusted context around ufshcd_send_uic_cmd() instead of ufshcd_send_bsg_uic_cmd(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index a7e1b011202bd..4c77f6e8de3c5 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -123,6 +123,10 @@ static int ufs_bsg_request(struct bsg_job *job)
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

