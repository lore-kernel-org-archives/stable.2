Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484479;
	b=H+vEzC6Oo3GepaH4qvyqHCxp7yaxwdvuoyOxuMHXumC2GgdW8k8I0CtYbP3OMAqnN2+o
	 /0tCDa/l9TTyHrx6pA4YRWULaiexbBp7GtR6YAuZ5FvgT3zlpWWTyWV/VIyl8nrGSNazd
	 ys7GTdrNcdVAfB5hp3SOsLUd4I7l1WhWs6LJRRNCvDk9BIunOAC9clcAoK+tir02XUcfX
	 w5FdXJzvfrLojb/WqJX3QjI66WfuKgQwJ8VLF9fhAJzhhOY23tYRZamsXh8279imDvUJF
	 /EP05MdVnWeT51WUY4ggXPQWUNc20LIuHlyQeHe3z+wyvYtjKD/VOqhlSJyKDl/WoxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YxDpnFYtRSSmHdlBVXg/Qu2h8PYtM96rKGEWJhj/F1M=;
	b=jLakg/40qFWyfDALpl0/lz1jD7NAQMGSCAMzxPksig0oCN8GUm5qCMN//N5wgftYvSFR
	 7FOC6XN8bKsOb6d60L0MNAmDkq4VzrC9+MSf6r4enir+1CiuOitjmII9ykJ6CD4WMSsgi
	 crTQa3Nf2aynF+3CK3bGGY0fOJKV8dnel+Ffok0vTnPxi3tPMUuuZr7ZnvYaMJ9MbLOwZ
	 DbLDYCpth5IjYAA6QnIFsGVlc16+ROuUmcHzvbR3epQp0Rxd9OfAgp6jo7vCnMwnDRh3B
	 vVqEfXa8mps7w8EcOY/vHp7PV6ORZHGxy+lrbmNQ+A95wh8dW2cHWP511fH/H5AXb7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WbRw7Z+N;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B0606A33C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0B0606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WbRw7Z+N
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e8ba4757baso28850195ad.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792484478; x=1793089278; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxDpnFYtRSSmHdlBVXg/Qu2h8PYtM96rKGEWJhj/F1M=;
        b=WbRw7Z+NXtM+d3xWOk+5VQMSiTpBVNPs4G60H4iECFH/kOXPQOl2/6qDzgUp73WmW8
         e9+2PCZtyS2MFBqiRz1F5/z8J0Bwnvpna4bBKl6kATQAumVvGCodRToVSEwGDYx0OWqR
         VbQA5Vj2NPRDlQW5YD5a1YJRfVsZ+B4o/VMDFwbcTx/DhUL5wl+Ps7AUi2yHJkSk9uA/
         h1MGt3jl9euI0qi8JQmTMRX+IkIjMczMsT/UAQTIyZV2WUKGf6Gyu6ci9d5UthXx9yc+
         Hh50XaPftGf0DnA6iJnKtT9ti+HzcxV0H4UhcnnWNLh1uutsGcwMD5ymFicEnE3h4bnK
         eo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484478; x=1793089278;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YxDpnFYtRSSmHdlBVXg/Qu2h8PYtM96rKGEWJhj/F1M=;
        b=xQZ0+HPKvBmJ8RRoQOzxMqGG3I2AXSQnHQouhsJhOqsAOGGlKgxbCQhCZH/uaaXMm8
         hmM5l6Gz+N2JPvz01gwHaVan5JhoZokDIWUn8aR77s+MB6LxfZhHlwaLNul4r1ou/bQ9
         Tgl1XjyfgvfNiDLYmnJkFuSOqIDBriFmUmjVDJ+kwjqzqkIsfz+NsuP8S5Owd226ZgjT
         IE32QFO6gKEIExe09QykyjeZ4OyPn06IBqs8UsKP05BUMc73iSet3x1OVmU8gLfJ2S3o
         88/izEjJO6D1bp6h6a9nhb4zrtP1J9Z3liZK0hYbxy6niO4MXE4u08HzFhD+MY7ZX4vG
         cmKA==
X-Forwarded-Encrypted: i=1; AKwUvBxnINS1mfmRV/GdjU1PIDkgTlbzSNqNZS+tgzkVEr9QFBA7i5/w9+LHtaXYI0w5NkCNnWRJcjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtvIl4QNOgkPV1oVro4yTfwsJd49SFu5bpkYM31CDhBbJmgj1q
	x7jhC00JMHrFtkppWTCPGF/658CAHUSkm2gvT2h73kUr87kI7q5N3h6tGNmQl2JrcFl1JFJ8EDZ
	mQcc/EhuztHAwxEp05V9NkA==
X-Received: from plot23.prod.google.com ([2002:a17:902:8c97:b0:2e5:82f1:b868])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1d1:b0:2dd:c100:80ba with SMTP id d9443c01a7336-2e9a6d36004mr84600175ad.53.1792484478330;
 Tue, 20 Oct 2026 01:21:18 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:21:06 +0800
In-Reply-To: <20261020082110.3511797-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020082110.3511797-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020082110.3511797-4-stanleyjhu@google.com>
Subject: [PATCH v3 3/7] scsi: ufs: core: Fix double completion in ufshcd_clear_lu_cmds()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In SDB mode, ufshcd_clear_lu_cmds() clears the request slot in the
controller and completes the request, but leaves its bit set in
hba->outstanding_reqs. ufshcd_poll() treats a request whose bit is set
in hba->outstanding_reqs and clear in the doorbell register as finished,
so the next ufshcd_poll() completes the same request again and unmaps
its DMA buffers twice.

Clear the bit with ufshcd_clear_outstanding_reqs() before completing the
request, and complete it only if the bit was still set. If ufshcd_poll()
has already completed the request, the bit is already clear and
ufshcd_clear_lu_cmds() skips it.

Fixes: f18fac1e2b72 ("scsi: ufs: core: Rework ufshcd_eh_device_reset_handler()")
Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1b28dbba03a9..778932298e27 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7978,7 +7978,8 @@ static bool ufshcd_clear_lu_cmds(struct request *req, void *priv)
 		return true;
 	}
 
-	ufshcd_compl_one_cqe(hba, tag, NULL);
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
+		ufshcd_compl_one_cqe(hba, tag, NULL);
 	return true;
 }
 
-- 
2.56.0.212.g129ede20d9-goog

