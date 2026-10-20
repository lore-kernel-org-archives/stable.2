Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484483;
	b=wu2CJYYwnVKycs5udWLvgTEaMcdMaWxsdCQ7OcLybK+4yQ01UDZbkYBuarRJbad/Ottl
	 gKrnLwtxEYFTo6ZXnDToYpy9arHuOTEDiOP9ookJTX2VkMDmq5X3yrM/Ml9Sw8erKpEeJ
	 3R6v5OLdBbLX8o2THp3+qa8sPROdhLaXMDS3eAKw7soSzDz7SvFgDZT27oe/wQ0PJsN4f
	 9mmwCLx2k0i9e4EyW2hn5GpWt2C/7RNky8PlTPnIJ67xAejK7ch5IzKMfWg4WqGGMqJXy
	 dqcioMTXJ5jwrZLFgxfjulahM5PHkPRcPj4K9WEnD0YqmHeQg00VW0QbB2FBZVwIH3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Y0S2/1HTQXjT7j6wQIYRpSV26ZEjZ5U4TjqBh9LMm6s=;
	b=EI4vXAYGmbHjL6k806RBeA94Oq7JbQB0sZjoHPjX7wC+2pYlknjCKj4yjkaovBe4RDX+
	 7A4mlLHyLJVje+CoBCot2i7XaPf+5pZY5y0JiHxTDUGRXKy17C2BeLxmm057GSn/6JikC
	 Q8AVsnaUtJABB1DEsfM2KeJdfPnUoZWdqFMBhTwrXZmzK8MGvtqQPNny63x3tKr9sfc+Z
	 /PffflH2kbkbXeT7FCy/tSJBqR1BnPQrxuAqecum3UeamtN8Z0ANHwvMnmvItDJCXbYEB
	 cEuDiRppZdaXMTn2aGgr2TqXL19spTUFmzCKd8cMsuLCv08g5Ci7kIQtwzOgOruxTNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NIlruYmw;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E060A261B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7E060A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NIlruYmw
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-88c768885b4so3848397b3a.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792484483; x=1793089283; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0S2/1HTQXjT7j6wQIYRpSV26ZEjZ5U4TjqBh9LMm6s=;
        b=NIlruYmwjbEE6hjnJ33S+zXOLPmcQLJDErdhDRBEDCb3kF2A9sX7NUITVUGIL5TNDW
         ecTIMM6NdFKmyJT7aVJ4YLansxWpZL9v7YBlfVimFCN3jjyFgUjV+gpsEMJ7jGO6aPAo
         xW4sMgoeE9fQ9yZI6SFiHx35epu3MZoSUPByg/BTM7yQkScU6czeOWzlJQHj2KbQ5GxL
         uN8iTk/WikJDiMI863/+SOhBQCabPHFuGXUEh/4zx1FKxEBg9k3V9Fpx4aGcs+dRTr43
         ufEI40eNlrcYwUNEitEQ50Su+DlCI3LvoHtvANmsOeG5+s7tDdTD/AsTDsh8IWGco/vK
         vz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484483; x=1793089283;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0S2/1HTQXjT7j6wQIYRpSV26ZEjZ5U4TjqBh9LMm6s=;
        b=vmXfbNDf+AE9hjNtqMcKsxEdmoALh6FiRBNpob7GJ+bWZzBb+hbz10IbO9A6Yo10ss
         L7U54qP9+h9OETkIxJHg2y5Jv0FRtqxPNnGzswuya9Elk8NVYegMCcrDPtW7ubsN9J+w
         DtE9pJifeheQAPaJ5pgT9BzkBkavNBLmyQW4hszfPMp7s+TjN+c+BjU5h0DowedDgsWM
         IrYRaYYsitWcOI2mhhsFUVgK73U5N8xalWTrEly2pOf3Y0Ed3ar+vS7R5Utsy0mDDpBU
         KLAtw/+AGXbPC++PKOmRQQMH6HjZeXp/pcHGHC3nr4LNroMJYqTZPNC2QA//BZmckKMj
         DMhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBCIHSeO4ly/+2SGlGwH1/wVLfcA6uJVkYPmu055ljFwiCUmNYbsAWnZ2MTCmsi1uUi1EgXuk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxtY8OuzVICNqC5C5/0NOkfM09bZMPGjsAn3UIomz+KAfZQExF
	LFruop4jyIAwWenLsBjC8NrV81ze4ZWXro4Jbym05uyh2gVEvuj3RtEJAL0yhtk4RNc4vztwuAV
	m9atoBpKPpHkmNMNiJ7AMgA==
X-Received: from pfbhw24.prod.google.com ([2002:a05:6a00:8918:b0:89e:a4f5:3f5])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8009:b0:882:8aea:fbc with SMTP id d2e1a72fcca58-8a04ba04bcdmr8600296b3a.16.1792484482530;
 Tue, 20 Oct 2026 01:21:22 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:21:08 +0800
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
Message-ID: <20261020082110.3511797-6-stanleyjhu@google.com>
Subject: [PATCH v3 5/7] scsi: ufs: core: Fix double release in ufshcd_eh_timed_out()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In SDB mode, a command that times out during a power management
operation can be released twice:

1. The command times out while its normal completion is running.
2. The completion path clears BIT(rq->tag) in hba->outstanding_reqs and
   releases the command. It has not called scsi_done() yet, so
   SCMD_STATE_COMPLETE is still clear.
3. ufshcd_eh_timed_out() recovers the link, sees SCMD_STATE_COMPLETE
   clear, clears BIT(rq->tag) in hba->outstanding_reqs without checking
   whether it was still set, and releases the same command a second
   time.

Return SCSI_EH_DONE when ufshcd_clear_outstanding_reqs() returns 0, as
another path has already claimed the command.

Fixes: 01d5e237b339 ("scsi: ufs: core: Handle PM commands timeout before SCSI EH")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 03efbd85bba9..111f5805f178 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9653,7 +9653,8 @@ static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 		if (!hba->mcq_enabled) {
 			struct request *rq = scsi_cmd_to_rq(scmd);
 
-			ufshcd_clear_outstanding_reqs(hba, BIT(rq->tag));
+			if (!ufshcd_clear_outstanding_reqs(hba, BIT(rq->tag)))
+				return SCSI_EH_DONE;
 		}
 
 		if (ufshcd_is_scsi_cmd(scmd)) {
-- 
2.56.0.212.g129ede20d9-goog

