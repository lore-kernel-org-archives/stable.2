Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792554895;
	b=5XndiM6TRAplNtcFaXnmxvCMRvi1Ri95SUSu78dQ0ix6heAUFsW1pl2bmwheoD0fXbwK
	 F/tpZw+1NcpBErvLRbU0Q7lPgyEU9Bq/jln7WvVDP6TdvVkq5iYJwsBVHCkVe11nPBwWn
	 ff6RTFboyLe8OWosFT3osO5oemf4G4R7s5HgME7RyfYHZGse3kIovoXNxAphuYyrxMX15
	 rdnzRCkUeK82tj0oofUbewQa/2H24/ZioAFdwEQPd09R1H1NQsi9moFUO4K+zdUD0cjJY
	 FEzjE/fC4GuNlC4QAllANf6bbDyOoXfhnM4Ae8qO3lPfQgGiloFUoBTAbnMzo0rQI6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792554895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9paoukZlfMxNYNsrD2iQm9b4wSqYDltUgKwGmmCVVPQ=;
	b=xcS+6shAY36nYtX+kO3fXiS9rEXBGZOCIFh5mHBcE71llKWBROn2AVKCQA0rYdoILwQO
	 VE/WLUq1cNC+rXbzDWyiSx0nRtpuHdCwE+MfRdODnsElkelCDZcJIz3Ksz+5JmARXsSRz
	 GR9CEdrsxgYT9bxcBi3kC5xdjOwlyt9GOekUja9PvV9qFos1S77FzVXYHHsJOkB41/c6V
	 kdUFViicZgbS/IET00uKO5vm1DkoRypLlnM+46wi9T2JIRoGKf1IfStrkroiDcmYaKzhH
	 or7xo7eEB8lfTOu5SBFCbdWR3wgCDdsKzGGZMDqheEQBpYELz6uEP2juWYqPb/4D/Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BshX87k7;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09715606A335
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09715606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BshX87k7
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd61df4951cso258053a12.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792554894; x=1793159694; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9paoukZlfMxNYNsrD2iQm9b4wSqYDltUgKwGmmCVVPQ=;
        b=BshX87k7UqcGhUCcykiPVLuDGUEcyg5uEbcP5dUO8wf/WFnE21oXH99/kzrHsuiVbG
         sti91SiziNuYdhkprKmZGYXWq2XG9M63sjOZ/wKq8WPNQcUY3SlfMj3+gIPYrXD3Lm5I
         GxCzwGu6STyDEiiJR7XgTZCeeAnB51JvIuceU1fpSplKkgsB6goxY8CBVaG63Mlhx6ro
         yHvp7U8MVSK1UPjbEpwQZ6TZlx1R0L/afCEYL23h5BV/1hCB7Tk1C7ypZC+JxpNK62hG
         TTaksVtX4A8I55BgyQUvZb8eeuffjDytCSdurjOmNK8qbobHRhEM2UFuOhG6uNxtphjr
         /52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792554894; x=1793159694;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9paoukZlfMxNYNsrD2iQm9b4wSqYDltUgKwGmmCVVPQ=;
        b=jgpFGV1PPiUVjja20tmPr3tOhC+7qRStdfgTuOErFQzRtaK/Lz07lhwNXYisYX+v2X
         IBFWQKmnN3gaLQ0mduRx9mdjyKhce8SiUDpIKu9C/R59/yC4m3ABBQF6Z9gRy923DSgk
         kr07LTFrzPfHEPECnUCNCm39jXwBmopDuFm5RrN91vBoIEkk3gvVPbWv9aOY2nhZLeT9
         dCPzqBdqrXOcIUS1fcJKopTk3nN5rWWDUpVdm6vEDLJH1hw3M9gakp+5eZwr3HgWzqcY
         7FkbJNZjeoa5fhnoFvsYXPWQOnJkPJ9b0jHX4bDqQkZ1BbWKNGSKWrRciktMg3TIX/v0
         cCrw==
X-Forwarded-Encrypted: i=1; AKwUvBylz/z4iv1hgIhTrGdVHASFqHGGIy83FimHg3do61Al49p/ZpWwt07zSySeFav6hCN6fWp1g/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq+RaVSNwTu3HJWpgLX08Q7GCBdlnQrTRi0vhJ+2DVhYTupCQg
	LF/7nX0HLFhsQN1IQ09kT3fCs7YseAnL6CJ3KFTE9s3JSVpCTduPcxyqAMh+0nocpa7wGjd+vgS
	r5/22Rm7HKF5ji7zVgXd7zw==
X-Received: from pge2.prod.google.com ([2002:a05:6a02:2d02:b0:cc7:81a1:7ffa])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a42:b0:3e1:73d6:692d with SMTP id adf61e73a8af0-3e287bb4274mr725097637.10.1792554894165;
 Tue, 20 Oct 2026 20:54:54 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:54:45 +0800
In-Reply-To: <20261021035450.3488805-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021035450.3488805-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021035450.3488805-2-stanleyjhu@google.com>
Subject: [PATCH v4 1/6] scsi: ufs: core: Remove an always-false WARN_ONCE()
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

Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

