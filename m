Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257731;
	b=MVxG7WcfHQ8aRlWTEe13/44NHaGm6bHU6EqefzK+4zdy9oqPQLrKX8TcgYhdLbdStdlu
	 LPO1OLg/kou9UHFxs9BsNfuWPfZkyYJjCNRmTxRheeeNyjh0lNJD9uInyTxLVPC50D55b
	 rrNYPeRNBbxENv9HjLsTLK3uR/tHUH3DmgHB5JeZcolK+VF10Ntepc4fS8O/GktLLSzIQ
	 rFS6pR1r2Y68AUHGjmB7RvMF9HL4vCixwQiTvV0JRuXyIHeWm900ARgDF2Un/aMIrjdjH
	 gjraoBkE2uHhtEJM06uq76CbjH02XRGpqc3O1WsPy1Sz1oUfrcLRj8yfaFJbhubBQQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Uif8SUPiQxvyHMNjuvXHHFnBYtEULndqqGbcF57aROM=;
	b=I371Yg87OJdS+y+OhJwx83bPBgIE1D2+DHHH3tCV9yhcmGC2AtdYKr83PGQL8wZDlbiR
	 9ujCY4oZZww8YiGdYWiw9COdRhjwKro11H5rYr4nd7QeRiYwxZ+YbwMnGKGNSHbQphjQp
	 FKRBsjsxHWpNciY8a35xBt6e4RtXZPIvMPtFl9yrvMKiBxq1LWTf/kYK3WApunuqrAwxz
	 Wjke7xMNCQKnz8ZQuVSmOnRU0UmW4CEgocW+EwQdTu0jiU9r8S+BGqCyRLRrAvJkSjim/
	 3vNZYh9//sw2I1mq7O0BWRWkvzM9L7gjTw1703Dqm44J4SaTCIhEwoRatrLcVbmlNoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="F/h5VAaW";
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFE606A32E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19CFE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F/h5VAaW
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a086f5d91aso2468128b3a.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793257730; x=1793862530; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uif8SUPiQxvyHMNjuvXHHFnBYtEULndqqGbcF57aROM=;
        b=F/h5VAaWMxiH+za1B5Ex14pfj2Q3R2j5BfA5jvwvwgh7NU1VdN23MnxXbbaQcIA80Z
         NYyYanIIBoOQeQBBnLySKyy18thxfRn6fK7RyQxH1LxnNVW/eebRhoMUeKp4yHRSwLfB
         QFz8vjnPnbdJk9DNp6vokaehhxuP8aeOkmIweJLwi+Cp3vzD52cYPwrptjtebPoIztJq
         rTjYOl4Akuzv/koMaTxFO3FxHAHl400hl+3F1OVHb55tsvue8UdyDNiWXG6/9PFwEf2a
         5DwJ5j/OsgaNrXmy5ab1An9qfGp1yqkeLCY3nN7GgWn0n4ngs2mG2fuuRS+J6+3aD2w4
         uyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257730; x=1793862530;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uif8SUPiQxvyHMNjuvXHHFnBYtEULndqqGbcF57aROM=;
        b=ZItXxTnH7YYcL2BqjafEAZo03YjRUROg1MU9cTGrTan9JaWlpO0pdOzrnITLZkS1LA
         /+Pma1rQTkHfSmyT5glEo4uidIrHoOmLxYwdtyEugUciHYpSsfEQfeerqGJ/jNI8U1h+
         XNmfxS5D5ceoixQUMOaQXM4zWk9rRBgldkH3oacpwpDF9/jwH5jf9CpQeNEZBUqU3gxr
         Br5Aqaq91FDn3jkgR/FsZa5i2QORi7bizqJB/vCuHiMDcF6fvwttT1NzKETsGBPCM3NW
         TxUpidUciSn0PwJBZ0Lsb+kIkmH8DZW9w0bSBzHqnSqo4GWU/Arlht5MvceRPke/1xXr
         hEpw==
X-Forwarded-Encrypted: i=1; AKwUvBwY09JBxiCxROPYvZRefN4RRqTAlW2SD/X1wPuVvI72dTJ66DBHt2c3M4RVkXqqOXNgrsWEGuM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvH3iL8JVyDR0YN/TbnWvH966FXM9DV6hAu0VL98/GVGPypWRd
	lYN76pQNCC/ra9JWxPKI91ByaQ0YrcswRmIbTpdtxeM+6qqgkyfsk3Jax52I73dUZp/Mjyav2+G
	UrjkjI1KfaeZ7/oY6oKpkqA==
X-Received: from pgbj18-n2.prod.google.com ([2002:a05:6a02:61d2:20b0:cd8:c6c2:d403])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:49a:b0:3d3:ae50:97c7 with SMTP id adf61e73a8af0-3e90226ce3amr3469934637.20.1793257730310;
 Thu, 29 Oct 2026 00:08:50 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:08:39 +0800
In-Reply-To: <20261029040003.2100003-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029040003.2100003-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029040003.2100003-5-stanleyjhu@google.com>
Subject: [PATCH v2 4/5] scsi: ufs: bsg: Abort ufs_bsg_request() when runtime
 resume fails
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>
Cc: Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufs_bsg_request() resumes the UFS device W-LUN with
ufshcd_rpm_get_sync() and ignores its return value:

1. The W-LUN is runtime suspended.
2. User space submits a BSG request.
3. ufs_bsg_request() calls ufshcd_rpm_get_sync().
4. The W-LUN runtime resume fails and the W-LUN stays suspended.
5. ufshcd_rpm_get_sync() returns a negative errno, which is ignored.
6. ufs_bsg_request() dispatches the BSG command while the W-LUN is
   still suspended.

Use ufshcd_rpm_resume_and_get() and jump to out_complete on error so
the BSG job is completed via bsg_job_done() with the failure code
without dropping an unacquired runtime PM reference.

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Cc: stable@vger.kernel.org # needs "scsi: ufs: core: Introduce ufshcd_rpm_resume_and_get() helper"
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufs_bsg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index baf6ae917d36..8df1a2c6abf6 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -150,7 +150,9 @@ static int ufs_bsg_request(struct bsg_job *job)
 		goto out_complete;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret)
+		goto out_complete;
 
 	msgcode = bsg_request->msgcode;
 	switch (msgcode) {
-- 
2.56.0.313.g2479322e68-goog

