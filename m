Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640695;
	b=g7dSAlREVssZOgvBfGDJ4Rb0nfYH04+UQDCCppPjcZsau4lqVThv+gAB1FdwD89RbF+7
	 tJTpWi1bfh+zeSfdpE/IPBtCqIhhzYZPPQEz9WjZC2vczK/XAymHCq/d/v4viTBezb/HR
	 B1/e+QrxhgCvZtZjABXpEmRRTEdEuI/p6wsYB2MZTx7hyv5atv19ZPpUvyEbStGvGDjmj
	 iwQy7ZwrVp6yKxtOJwST0lZHWDgvcgFB+ELq5Z+4k2hpwu/OjzbolczvCPP6DVD+RyxGS
	 2ywg0OokeCUNvix8YO4FuLrWPuQ0tjZReHIC5Bb+9crb0lIdRsNPUzTZ98gngg5OdQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=akknKNV58WXQ7nC2UkOhMmYCn/cmxofWONSsK2knhEA=;
	b=JvHtqx7k4g8c8gYAj8C5ICxnrQ4FuoKGQP5jstBMlWfhgcaR3UeR+z+VYoGJfmIYkkIA
	 7u/ttCV6qVfIFspMQKJRqBfrFtaAL5D89RKQdTvxJpNp/JzbBw8Zi9DyFK6NUFMlnHOIa
	 6Dd05MUPl093mhSs1pien8intCojw+xrgHG5CY9WdbzGDOi8JMRd6lB/V3c9g2UASmbh7
	 HeX1bA6RwoeQVyqyQuRLY7kM7+IwSzGCLXWfU7tdgdw4iVeEwS8kzinJNjTF+lLwM6eQD
	 cGPyVVy+/KgCXw7CWfGiWFj9r8Z3kdSQRTgOYLxiSvnpLOEXmRSuywA9LkBCeAA/eZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gXlDNRPP;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DE606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 089DE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gXlDNRPP
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aca98f01c1so1471252a91.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792640694; x=1793245494; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=akknKNV58WXQ7nC2UkOhMmYCn/cmxofWONSsK2knhEA=;
        b=gXlDNRPPAj+18BRsw7Cvf5oS9s1o+E/frEJatVnKbkZ0gg5/PB0Ep/MG7LyS9mLS12
         pYyNX04Nr99DAOmBPxznH5sfPIS9vG88rhqq/4NbZSibfHR3DHip09PRZgLpFsaJgOtl
         TQm+dDrePf0wMyG99nNj7kPy1JjH9FVdfskwvVc3MPVP7BT1gUnYeQqMfsoIFg2xHHB1
         7Kq3lP2jMnVyJ5zy8EDmQWqMzkIU1Dv4sY0iIJcdJM1chz5NVuR1LbT4qHHERnxaHt10
         2KfWDbASKoxxFAMZCNdVtd8ja3sJlUIRt9typ4nigm83xYBPYvIZZ6T4H5FFRg4TsPY5
         lj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640694; x=1793245494;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akknKNV58WXQ7nC2UkOhMmYCn/cmxofWONSsK2knhEA=;
        b=wOBT/OBSRI+xC27vzAleeafQs55ZIbXuEkMUmtWu4Q/66rRpodQU2L/UkZV1cm4eWk
         uy62QOTCLlAvMHytpT1NoKY5gtqGlWyVMAywRc/LBgOn2gTaIxH7RXYAwbk3myD8LA85
         fLn8JZp2wwE5HNHYYjXPW5ezgseUw2t4Lti+J8lj6r7GHi8l+r7wKW7YTbgvQe8oukSe
         pip3D6a544ek/I5CimTFYs5CcZ3zVM9GVGVwwioUGBLqDZkveW5KmG+7HXzSihpmhHAy
         0//XLajuWHgGG+M/ts1IDmPWH4y52zOPjGvkk9r6w+lnY3A3dO4h8oFcuZxoqSDAZ1eI
         6tAA==
X-Forwarded-Encrypted: i=1; AKwUvBwAQaxdUTNQ6DA+j/72uO5vAtYNAZoTsJfCiJIf/u83IRyAVTOtUlAoQNkKKqXvoUiRp0C6CIM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6Vbibs5tXKP460rg7NBmgi1iharBNgmjf++CXXVG4uEARk5Jg
	RzkY9CPszWTFlrCAtr7HBzEhu4CyRqZlDmqAPcJQE+WPJEbv28leQYlRiUkL7ghIG3Fa2HYvAeq
	3NjEuaG6w+sDyoMG7OqXHvA==
X-Received: from plso12.prod.google.com ([2002:a17:902:bccc:b0:2e5:e1dc:c5])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b8c:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3ad86d0bc21mr3695120a91.41.1792640693097;
 Wed, 21 Oct 2026 20:44:53 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:44:41 +0800
In-Reply-To: <20261022034443.3034432-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022034443.3034432-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022034443.3034432-5-stanleyjhu@google.com>
Subject: [PATCH v5 4/6] scsi: ufs: core: Fix double release in ufshcd_eh_timed_out()
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
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 68b53f89f8c6..ff5977f7da68 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9660,12 +9660,10 @@ static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	 */
 	if (!test_bit(SCMD_STATE_COMPLETE, &scmd->state)) {
 		if (!hba->mcq_enabled) {
-			unsigned long flags;
 			struct request *rq = scsi_cmd_to_rq(scmd);
 
-			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			__clear_bit(rq->tag, &hba->outstanding_reqs);
-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+			if (!ufshcd_clear_outstanding_reqs(hba, BIT(rq->tag)))
+				return SCSI_EH_DONE;
 		}
 
 		if (ufshcd_is_scsi_cmd(scmd)) {
-- 
2.56.0.218.g1ec904b173-goog

