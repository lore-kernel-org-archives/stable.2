Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484475;
	b=uoz03xd441Rb+7FQddhSKcvDg/7Bpbqe6NujJCzPeE5TW5BNWCS0A7tkyPsgYoMpndWP
	 LhQSYFx0NLSPBeJ1k+HRmHBjijqBlQ1ScrBe1fv0OAWdkDAflo2qkIspxslTQWT+81Z1M
	 EvPKeTk8kXh8qq2O6BcaKkKsiGDui3O1yH4stGrbKvT6BsalEhXEMJILzqquD5p57tWYG
	 9wd01FXcd9dZZ+KphD3O5waHAAL+vcw/RA5suB958ekBTDcYRZ3l7ZyfoQuSuJesnvYtk
	 flpTBnbC5ihigupXyUU8RiLuxgVwuPJEQ/M7E0hBdBQQXAACHJmg5WzCOkDDk048lDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Ab3Ppi5U2ZBtscUyANpv309FwIIv3hXfnmRHZqkMu2E=;
	b=w3wbbQsybUcH6+1pV+G07ocu+a6CSKk3vt0pit+eyi02NivwovU6cYxM2uCe+zBPFhRM
	 BVnHBuN/Z/EzKQ1lAXlZ4L6DRxTxgsOp1xm7chsMX3dmrfD9GrZs5lBlcLHZCra2Qqb55
	 IryGxen5KVGBFogLhH5nWzH0gl/GMSzyupKj7jE6zkmSZxOP5W+K+U6ZB0s2EcpMs9uNX
	 MODOgcNEFrBKCXzVPiXYVqGKBRIN1FY6Sxrn3YzLfddLIGb5OHd1oUzzPmQe2gAT5zyVN
	 /8hmMNwdLAkebGFmkzs9o1HBVM4RxPVQRmHDnYnk/FyHWJupdp0+p+q61uxxAOSgJYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nGgmHFlG;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED948606A332
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED948606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nGgmHFlG
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso2920221a91.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792484474; x=1793089274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ab3Ppi5U2ZBtscUyANpv309FwIIv3hXfnmRHZqkMu2E=;
        b=nGgmHFlGOHR/4CdMZ9jRrEtoCBGol5VD2dAbWN9yFfQhpgsZaXtFMH7yOTkmmfS2Nt
         I0BZUsdfeim80nDPaju41SSmHv1KiU1Ly9Fz3P8e4y5ZftrH0iFWzxg8tuhgdG7Ux1tB
         /Xju31a7cc96C5aBB+DFKXop4o94CNo05NUZfCmEqBPBcSN7V7CsNzpGwDo+7Xmdsb2E
         F+H/BzYfOCXRIxnfwBfSnBw+M2CtwxDhq06PI7EVCbG5PI7DvtYrRa+8WmxV9t5xo1eC
         gUyKduYKozgxFeB+2uckyvSOo12NgY9NFKalozeufUynOX5SoSafwrSMfSizp9l81Ab3
         jdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484474; x=1793089274;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ab3Ppi5U2ZBtscUyANpv309FwIIv3hXfnmRHZqkMu2E=;
        b=m83NS9AI3cZTLgGTczpneZEfWmnfYzbA0QeVkeOOd+sU3/xhN0TzgNc2cx2e3+cGJw
         UK3Dw3XE+pMlJMIBM+haEQWQO8RqmE/vs9oz7W9Vuzeamaz0xm8yRMUwb0W0H8VD03z0
         3AB85kpHArC3JKF88JhHA8gk3C8JYsxKYxauSbllrENGSF7sK7qBULUlyVaWksReqn3g
         yMfhZjPJqMQrM8HDfViYmp0AAtcK3gSmlWHhGuv1awIS1I+m+17E7j0cq/gkTS0WEEyU
         qICPQ5sqTuHej2d1V141m/rx6EoylOlutARyagQ5WBIR0fWTS4ng1V9gGb+MZZTEhUpc
         FtlA==
X-Forwarded-Encrypted: i=1; AKwUvBxtV44fabAJ9i1hmUz/X628baCOeklu5to4GnXfkTtx6GacEbxgpvqcDLS0x9nQiuxWZIjVhwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1SSkHw+Puj6HKtoMa8eM7YpO9ni0A7zv5ACJPABmGv+pmKXPr
	eSdefL7QoskcTAmLg86Cvc+WHiIDxmNHc+U1lQ1vq6JjMUvSoc/SRdPeFiytMp2lD8wO9dspiZC
	Peau0vO3+VagrAc4rCvK3rA==
X-Received: from pjbpb2.prod.google.com ([2002:a17:90b:3c02:b0:3ab:54fb:2a3d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d0d:b0:3aa:fdad:7d6c with SMTP id 98e67ed59e1d1-3acef5b08bamr8689912a91.58.1792484474134;
 Tue, 20 Oct 2026 01:21:14 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:21:04 +0800
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
Message-ID: <20261020082110.3511797-2-stanleyjhu@google.com>
Subject: [PATCH v3 1/7] scsi: ufs: core: Remove an always-false WARN_ONCE()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The WARN_ONCE() in ufshcd_poll() can never fire. completed_reqs is set
to ~tr_doorbell & hba->outstanding_reqs on the line above, and
hba->outstanding_reqs cannot change in between because ufshcd_poll()
holds hba->outstanding_lock. So completed_reqs & ~hba->outstanding_reqs
is always zero. Remove it. No functional change.

Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bcc2512bf34b..12aafcf1f9b3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6072,9 +6072,6 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
-	WARN_ONCE(completed_reqs & ~hba->outstanding_reqs,
-		  "completed: %#lx; outstanding: %#lx\n", completed_reqs,
-		  hba->outstanding_reqs);
 	if (queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT) {
 		/* Do not complete polled requests from interrupt context. */
 		ufshcd_clear_polled(hba, &completed_reqs);
-- 
2.56.0.212.g129ede20d9-goog

