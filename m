Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257725;
	b=Lf/6EdN7/cDjorHO205U/k0XYp5oiL/w/KNAPOQaJF7db8RuKH6b0sU5t1HNPWYF0ltM
	 oQKmw38NG1mx3kCUr/BRXE8qdofoPxDTryeQsLI3TQ9ihTZtOAaQnDBgWaZIb+Ny1itO3
	 1K3Fum6lvFKjYWSXs+vyeZlB8aAr4dkwTPfgXrqwEfIGtJ5JEdu3vQaErAmafX40n5jx5
	 LPLfZQ/wYVL4262XdIrtw8Knn+iEEEEhlXS+eCMbdlMjWJ+VLvg8mVdQu0y4L9ltupxTR
	 pZe3/g6wpwRiZPxbHzIDMkpPM9iyKotcE716o7p27pLEEQMTYf96a+ankfQEjStroUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=c2wt0/O9P4h169mOPfGdNt9HMfMIWbdoAewi8Z+Zhoo=;
	b=tJqPQYKTSzKizvgtEYEYs5kcyyrBK7caQ88MTHtzXZNIsJIaZPSAS5FLrCr7wGvFMsve
	 BbhrDPEsCfTmhw/G4rAIFa1VaRXQKYfIc6dUI/BC4DlFKO1n/5fTblUmgKnE7mff3ZO8M
	 cCJLyZVW9UkAklCy94Qsc5Z8mDDVcEe/uPBUfy6BboWG4YViIWGBuJv2nUWGdSViNu5R3
	 Q6BB5UaCgQY0CHD5IaZ4lM6f8hKmnRObxPSHnjuQF8y7bTqgFqFbC2x6xeqqFXetpmhvh
	 xK1X4VIOn3we4RUq1xF9wvNogmkaQxfP/A5UsEvchYMNJW/nzzWwquejsS7gx7eJH9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G8w0gCtP;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C9606A33D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 894C9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G8w0gCtP
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89f71ac2e2fso1618905b3a.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793257725; x=1793862525; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2wt0/O9P4h169mOPfGdNt9HMfMIWbdoAewi8Z+Zhoo=;
        b=G8w0gCtPvtHfdPkRoHpX5bKVfSBj2vbcM8IdNuCuhd90wmJFzTVagaN2CO4SH9D5Qu
         xhGqnBq3HBijXRGx63AGeG5LN3vBbsDSUWX+oI3R2Rv57lHs6npjOM78etALD5USt09X
         ZL5mvZvwhDcoWLldvm3+tuQiWpyFVY3rvY6fvX5Uf+JKe0dfwMAHvCRkTCLrD8duQrbp
         M+UUeXG0g8YpecEmSMvan711a+DKe3HEMp2mFxJc16PIPx+xZKlRrG7/jOWLoMl4W7Kh
         2kMnSrWEmi61LMchzpdmoaihOhtFhVH15cfVZYUyCj/5BEG1NNm7RsTfXJ1gQ3zmI5NM
         Z8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257725; x=1793862525;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2wt0/O9P4h169mOPfGdNt9HMfMIWbdoAewi8Z+Zhoo=;
        b=wIW/DeIAm8lT4GYNjE6aznFH9bBUaQT1GyTlRSTtPrtS3NN2MRHHB3eGdTonfNWif2
         Tyl2LrVuZtWmphGfqoNg9WJK9sQMVIH4dYu6FOpQwfMD/VCXfLDOt9IcpH5omJEhWxm9
         kTv60mvmMfzjLzdyWA2qUzZiehU1kG5Yx4t4ejYtBQ1QbGig6mDWS9xwnOf+7rhnEiid
         reGewsj+/pYasZHngX9d/Zcra7b86F9va+uG8Cpnfr5C3rNc9FqvFXRiQ4sf3Noe+/Pw
         SbaMj+oQf/KPFIsxxyBTN+7kqlcNaQqLO3ZZjI/mT1vmLN3/AcxA1upSq8mH7HiDBXBr
         piMw==
X-Forwarded-Encrypted: i=1; AKwUvBxc71HmVfZDD3do0rO84bSh9KnOGFlNKRVJIvEPfybxa4OZXZlD3jFEIwux44Fw9BTAa/c7SFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+v8TX5rTH/HXyCYN8rxgpVjEgRAk4YEsKzuUeDYGfxvN1sdM1
	VodA/dFPnsaz3gO6WZjXIP593a9GPeaLq+MNgZGGl0yYEi/8fx44IqJLq5dDRHw32z9UahjJbrK
	+Qz/sW/iBYjlzcb1PjPM5AA==
X-Received: from pgdo13-n2.prod.google.com ([2002:a05:6a02:620d:20b0:cc7:52da:b682])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a21:b0:3e0:d5c0:74b3 with SMTP id adf61e73a8af0-3e90243d45fmr4171831637.65.1793257724559;
 Thu, 29 Oct 2026 00:08:44 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:08:36 +0800
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
Message-ID: <20261029040003.2100003-2-stanleyjhu@google.com>
Subject: [PATCH v2 1/5] scsi: ufs: core: Restore jiffies conversion of device
 management timeouts
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>
Cc: Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before commit 08b12cda6c44 ("scsi: ufs: core: Switch to
scsi_get_internal_cmd()"), ufshcd_wait_for_dev_cmd() converted the
millisecond timeout with msecs_to_jiffies() before waiting for the
command. That commit moved the timeout to the block layer and assigns
the millisecond value to rq->timeout as is, but rq->timeout is in
jiffies. A 1500 ms query timeout (QUERY_REQ_TIMEOUT_DEFAULT) becomes
6 s with CONFIG_HZ=250 and 15 s with CONFIG_HZ=100, and NOP_OUT_TIMEOUT
and ADVANCED_RPMB_REQ_TIMEOUT grow the same way.

Restore the conversion with msecs_to_jiffies().

Fixes: 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index fd52deb72d21..68a98cde5812 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3390,7 +3390,7 @@ static int ufshcd_issue_dev_cmd(struct ufs_hba *hba, struct scsi_cmnd *cmd,
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	blk_status_t sts;
 
-	rq->timeout = timeout;
+	rq->timeout = msecs_to_jiffies(timeout);
 	sts = blk_execute_rq(rq, true);
 	if (sts != BLK_STS_OK)
 		return blk_status_to_errno(sts);
-- 
2.56.0.313.g2479322e68-goog

