Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348040DB59
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887362; cv=none; b=ddCq03gsvfPKKT1AzFK/q/1PVUjXgdxHao3vIQjrFll3LpX2ZHCspf9UWJgUm07k/Dl9G9RVQ3+wKcDATgf13BiefqScUyqE/9wqjankm69/5IphVpKpoNjyRKcmgesr18pgFTOl2A1o9L74Jo9TdiRzMHfzovAFz29twFEngvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887362; c=relaxed/simple;
	bh=yTZrpMhG7oYJAnjzCIzddDtAInyPWu7nypCHAAGvPo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q0at6rK64g5KmZPN26I8J5Rieq/VCt5N+464xIA4+keuS4wpFdxulYnSSztprIHx+/ED6QZpRUJj+Ufoh5p6HGRUNSY2H+MkKKpZGnxE5b/yKJJ2GmcYlBmW75YEavaXIJPYubFEQdiZYdlEkaRJAjdDnzt6uvEY9sbBoK5xhos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0mlrFGo; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0mlrFGo"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc795ad1f5aso2702129a12.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791887359; x=1792492159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZdaD079cI/p9+3qL8ikHF1wm2BIaNJ6noJDSD0TQRCk=;
        b=i0mlrFGoVedlBTQ9qpYJt+kcDgYn1aFVRyxPn865HnwhGTV2E7m8nADhC0qEuEgmW0
         /3fG9fbOgFPBsQgdsKP1UCpMP5xsUIygUs6TOGzBrsUzssa3xfR8M+Dx8/8gftpXQJZZ
         x84Zmat0N51MiMIKMkVyDbFX5Fp3UQ0GY+8AEdzlAhJv9lCIF6T5UP0J3ujd5gV0Kqvq
         teRHHiPjxJf6fKeWxaksLs4Ty8mczE7QiI2bxyKX4ZuxQHnJH/iFkRtl6xFRDVEAbrAW
         Wbe71d+PhSBF2aZEFsVyZVIObg4wANXo69bfEBlsX4zk81nrXEMBivGbD5LXRFa5RhMM
         2fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887359; x=1792492159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZdaD079cI/p9+3qL8ikHF1wm2BIaNJ6noJDSD0TQRCk=;
        b=aIzSkcuYJge6Nf+AtCTNhEcL45l3reoYQmXHvb/GYL6JwGY+9UzKT+UwiytmuU8GOg
         17xRTud3Kx5/cMLt7HarXrcpmvqm0fyeK5ei2C33Px7cMKg8rL/LrOn/sEIJQmVEfLev
         dc3D1UZTEhT7ThD7DSDfSHmXC0CLWZFr4c4gk9xMS2FQEWIdvXqxmKTru9JChWQJ5/5T
         4aSqNDp+ajiKKM1SMsZrlRRErt0l+o3UvbbOZ1vEVLXMqdJbw+XcFdmvVfuouppcbFRM
         PAwwL+J1UAHDWVnvlKpciPsqpuO4MErVDJzSdRjHe6nWnA/09s+FAG+URLGCvTO45oLg
         BHsw==
X-Forwarded-Encrypted: i=1; AKwUvBx3uadg42Xk8JUVyHYHK1Rb8US3PXz0o4+AUM06JDMPFUGK51Jg+RrkqtQ83WBMHeqXtfxZWK4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4OI+L9AQQIEI+WN5G5EOZTm1f463Dqy1BMAt+PKw4Yogo5lRe
	jKCbXZNZZBTFOSgS63Vu14YnOfUN8McXf5znBWTQY+QTjTIJxvHOFCPGf+AaC4MAgDSanwsUCN7
	Bt/TxhhCfXmFfraooMjRJqA==
X-Received: from pfbay11.prod.google.com ([2002:a05:6a00:300b:b0:886:fe91:dda4])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:985:b0:882:bf63:480 with SMTP id d2e1a72fcca58-897c7adfb77mr10543894b3a.49.1791887359346;
 Tue, 13 Oct 2026 03:29:19 -0700 (PDT)
Date: Tue, 13 Oct 2026 18:29:12 +0800
In-Reply-To: <20261013102913.948718-1-stanleyjhu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013102913.948718-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013102913.948718-3-stanleyjhu@google.com>
Subject: [PATCH 2/3] scsi: ufs: bsg: Clear the UIC result byte before sending
 UIC commands
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K. Petersen" <mkp@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: powenkao@google.com, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	Peter Wang <peter.wang@mediatek.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufs_bsg_request() passes the user-supplied UIC argument2 unchanged,
including the result byte (bits 7:0) that only the host controller
writes. A non-zero value triggers the WARN_ON_ONCE() in
ufshcd_dispatch_uic_cmd() and corrupts the reported result. Found by
syzkaller.

Clear the result byte before sending the command.

Fixes: e77044c5a842 ("scsi: ufs-bsg: Add support for uic commands in ufs_bsg_request()")
Fixes: 9fb4c793223b ("scsi: ufs: core: Complain if UIC argument 2 is invalid")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufs_bsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index dab1f05aff38..331ead0403a1 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -179,6 +179,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	case UPIU_TRANSACTION_UIC_CMD:
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
+		uc.argument2 &= ~MASK_UIC_COMMAND_RESULT;
 		ret = ufshcd_send_bsg_uic_cmd(hba, &uc);
 		if (ret)
 			dev_err(hba->dev, "send uic cmd: error code %d\n", ret);
-- 
2.56.0.385.gd3acb90ef8-goog

