Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484485;
	b=c9nZQkTassEAf63PEUt1WOiHZ7J4RsajjtazWRxqKTOKZoJsZ89yVuCYQSXwOjr3TCt2
	 prBCi0/BtshS3Le3JmpuBu51x1wP1dv3LXMiY7v+Rp1NCmu1Kraj0YkfEWoheflXV8Scy
	 ZTNKwFIdLATALvF4TOKdChoSYTKTSZKLbOhqOXcRXQwoDN5zEHjPbR8MpHomIiEN3jFdY
	 HddzyWFvUPjGu9nbf5Cb0Kw/81qExQvJGTng1O5mG1mjGqVsmk5OIfQtl0Gx9swpVZlDW
	 zi4igYGSChIwBEQdFim9IAVeQxA+oo7U87lmGBMYFQqxVouZ67Oh1RaWeitagzau9rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hbR4VFV5Nch4/QGCypxNBgz7f6sFPq76eP9tBsWnbEY=;
	b=0QqDaLaoZDTgdBAZ+p5QXVvoWfoP+wFe9jL58Lu3cPvqSmKS3EtBRAROEWDJK9dZ7KZd
	 +pDr3XvxoxwXdbD5/tzDMWsVBhsgAyjLxPBgpPirThs2lfooYDqfEp+0k7E/8gU9sIpFT
	 NK+7B4NUWZ70WoBAb5Y1gsh8E5cZ5j74NAwap5LVkb5ikPSCJKkPgCuE35V4yZsCt19ZU
	 ZpSVAiXT0WBbG2pisopNzqOPJ0Wma4dD+UvtiLxKsR+BS5b+tHQ8wMAt6zpUmZj/mRG0M
	 5mBvhaCtonYBP8KbGnUtSZ8Z6HOuzZhNRrsnzHQVq+cQmpacyfglzCzhm9qjiAERsxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=O0YPHe+1;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1060A3813
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE1060A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=O0YPHe+1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab27eb38d6so3219335a91.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792484485; x=1793089285; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbR4VFV5Nch4/QGCypxNBgz7f6sFPq76eP9tBsWnbEY=;
        b=O0YPHe+1x6qt9TY5oiAGsoXpN/mMmo/xHdL4NCdgd896fcTSq7RPoG8oZM4xah9peo
         /igpeGsV2Lq6LzX+Jpz4Yw5WYFVmdnd0dR8ieZ+cbnPjtJZYhAhSeTVlqaM/eNxycJ7m
         pBUAMdkkGBDFozH4cRSMiOhkyJdObEvAIXgKB2NdyhDMHgL7nqcUIy6OqBgp0IvO2JFH
         UP8pGwJHcD3JDvJk0yJC3kT2TEiC8ktzPKfPdKAjJAYQZRUDFLpelxNl+og3NOTbaRJU
         7cX4e6kPn33Zg7s05xIoqIpnC4s1ccxN9BUi9lQQTZqjY6QbNeojnAvALxdiQy+pVwWN
         TLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484485; x=1793089285;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbR4VFV5Nch4/QGCypxNBgz7f6sFPq76eP9tBsWnbEY=;
        b=1o9X6ElQkhXG2dgDJSgmsjt/SgfCqcB2iLZbY8EQWtsnGWwqD8g4WjN16XEdAB3o6N
         Jhb0Pmdq/tTg9I1x/ZwtLcL1hIqwhoUmZ7OvzJGPE89T25MxDG9cOEPO3CIdz8QRmHps
         IkLyfhCwlXrxhIZA53ZTcCLP3YlZ0nMiVNnkp1JAhngeujaGDSBJ0UtXDgLRuISrKt6H
         SWN3T4s+yZSpW9gVhsXQByLivYoxCtG9ylnY5+glft3MMlrTGgR2gYoElG0WEbLpOzTU
         ixf0HoazlDDXmqSOXErGuadT+zJ3nlbhVuTwcCDqZCSKtCNf4g9Ckwgv5dtdPQoyY3UZ
         4s8g==
X-Forwarded-Encrypted: i=1; AKwUvBwh4VCVQRHSUfue5WY7395gubyGR3wHsi94eULR121EK3e41SA2L5XeD/G7IOg0lUu0aPiQfHg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlfY3JE5746meJRQr2TJTXWvTztXXs1LLxA8iD8aL/Uur67p1/
	ived3nJfe1kTJ4k0Tdbh5jMOD6eWVkTMG7S0l8PsmgPqjC8MNMWzMauoE/ncZ1rivdWgb0LsQ/b
	naLC/may0gAAqRn71zbL3NA==
X-Received: from pgq2.prod.google.com ([2002:a63:1042:0:b0:cc7:e8ee:9777])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b8f:b0:3ac:b185:fa16 with SMTP id 98e67ed59e1d1-3acef3dc9e5mr8054564a91.43.1792484484540;
 Tue, 20 Oct 2026 01:21:24 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:21:09 +0800
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
Message-ID: <20261020082110.3511797-7-stanleyjhu@google.com>
Subject: [PATCH v3 6/7] scsi: ufs: core: Fix double release in ufshcd_abort()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In SDB mode, a timed-out command whose completion interrupt has not
been handled yet can be released twice:

1. The command times out and scsi_timeout() schedules ufshcd_abort().
2. The command finishes in hardware. Its doorbell bit is clear, but the
   completion interrupt has not been handled, so BIT(tag) is still set
   in hba->outstanding_reqs.
3. ufshcd_abort() sees the doorbell bit clear and calls
   __ufshcd_transfer_req_compl(). That releases the command but leaves
   BIT(tag) set in hba->outstanding_reqs. ufshcd_abort() returns
   FAILED.
4. The next ufshcd_poll() call, or the logical unit reset that follows
   the FAILED, sees BIT(tag) set in hba->outstanding_reqs and releases
   the same command again.

Claim BIT(tag) in hba->outstanding_reqs with
ufshcd_clear_outstanding_reqs() and release the command only if
ufshcd_abort() claimed it and it is a SCSI command.

Fixes: 169f5eb28869 ("scsi: ufs: Optimize SCSI command processing")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/2e042211ca0ebc974ad5ec4c0de9f3f93b3c75c0.camel@iokpp.de
Suggested-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 111f5805f178..ee898f4a5bb1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8176,7 +8176,9 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		dev_err(hba->dev,
 		"%s: cmd was completed, but without a notifying intr, tag = %d",
 		__func__, tag);
-		__ufshcd_transfer_req_compl(hba, 1UL << tag);
+		if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)) &&
+		    ufshcd_is_scsi_cmd(cmd))
+			ufshcd_release_scsi_cmd(hba, cmd);
 		goto release;
 	}
 
-- 
2.56.0.212.g129ede20d9-goog

