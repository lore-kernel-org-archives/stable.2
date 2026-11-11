Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408583;
	b=UL1Ntd5cFcR1dV1ecVFW3jOqUd+YJsXrCqoP+/XIoP9Gy8+qtn2j3qik0oTdaMzrskvG
	 zdUPjOb8DPiOhr8+GuTPg8mh9U509iLeUxHe/dGMCGj8NT0gkW2eyNgztai+jlCWR4fFq
	 9TfsHYxH2EaaNYF1GThi7jRySW2GqdgzJyBibbpfzURjH/q8sNpD8sZsQaeVqklnhMbS3
	 GERb+cr/YesYNyjYQ5xLCnpwV2+EyUwUzGwVsiD1bA35qsCEgS5Q/vTLnM3TlvwvdSEaf
	 wA8Wvr4Aq10i+CXxUM6m+wVSNrb3tzY69GvRW7TOdeQ04gt4cCAejMTd7Mh7Uo0SmFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408583;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9i9IiI3A450HQ9IqVvcRGXkuc1F2HaWaNxBeI3LtCTc=;
	b=hupBRJuRdl+tt6j/ln2GH/FV3haHBRo0SszNYb4fyY3V+7Ao0X3GD5wbQKn36EqTAg6s
	 8QIigimUwd9Kih9/72Ll9WSq7/5LZyr2nKM2BshiFklv3jkpz3iKDwrI4VAYoUqM7AWF/
	 K7liir/ZDsJMSphWh4UC0AK9NDZfnOgM5Wx0vCiUQH4rQI4WS8LSOX282DsnhsYLtMlWe
	 Pnfpqvb2oxqUgxOPKCZayHdnxU1EsVK1V8O8pJtOKqVaCxK8/7FKmkvYIwKPEP/SMqTdb
	 5+na1jvzpQ/bnG5+RIfJ0MH1c5vet/2Hu76MnU/dkpFPWHQoHt9+bdelf6+9EKrYzlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY38nkX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64C606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY38nkX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B2C1F00A05;
	Wed, 11 Nov 2026 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408582;
	bh=9i9IiI3A450HQ9IqVvcRGXkuc1F2HaWaNxBeI3LtCTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BY38nkX5maJhKOONH2WygiR6KM1njPcn3YivlPwEyIzig9Yz4LSmwxdsrFOFLa7u0
	 ugMT6qVqC2/sKgjs8hDJNkzIsTAYuU1y+pLhitFlUpiJGWFTlhlUVAOWdRNFCd7t2r
	 V5blzlJkktDeMdvbXa/HoPWJXeGJmvUzuUSwDIkH75hZ18U3M1rvyX3M6W/kdoMBQt
	 mwU+z/cr2V+JIWdSJPMhDQuXMy+AgkPi2RTVKibH7w0ASHqUS4i6lwbuFaBBk7Bll4
	 JD/xQOt8t8Y6330dP7JOz2sycVCl50V+55NF+BKFLlFU4PnscoCV1f93LhSqBrH3VA
	 2tdsrzTy6sw+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: ufs: bsg: Reject UIC commands with a non-zero result byte
Date: Wed, 11 Nov 2026 09:49:40 -0500
Message-ID: <20261111144906.2397622-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061114-failed-5.15-1ae42513205a@kernel.org>
References: <20261107061114-failed-5.15-1ae42513205a@kernel.org>
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
[ sashal: adapted the patch to the older UFS source layout under the SCSI subsystem ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index b8bbfd81b8ae0..207b220e451dd 100644
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

