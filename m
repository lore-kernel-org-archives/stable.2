Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555580;
	b=JZY0ML4OxYZ/FrW23mHtAIsyUgOwuDRyJPbzqoKddhDpIdI1ASAf8t/3SDa/u49mtTjX
	 vz3qs3KoiuCFKQKKS/desKr8HoOLqi6eAZp36VKiebAlm9KXHNbsmCRnybv8+JALzjCpM
	 SGZLLGZPOyVJLENGqBtn/ee5KmcYnq6ozt4YarzXGf1p28qXgaWt109VGNUNG/CbE5mAc
	 LhhtdmOEMRd+oNxgCjEJh5PBLH6P1vOMeIWTYWNXBvUillrhcxavnPez9S4CKJnVH5+mV
	 FkNoP0rMj6H5pPR1stSlpi6BtD3xApuLpJy4sRPS5aSYYy0RvgGL4Lj4Brbz7w7V9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SfY/SEah692s3Y5+TnEOtAVmjoLjea2BnPP2RXOzKdo=;
	b=bixn3x92bcgAX7YAqm1h8qq66M/jKTvqzvULGP2ewRzFeuiJA3sDD7A/ubHzEFXVSoIS
	 5/FyQ462Mx5xPTS8MQlF5Zac0RzhTfmZs1xUZmZXsoJRn/jQGwN5rln9XJ/MKEbyTI2qV
	 27H2QjOfmr7ZjVtARGTZlxjwP5Ixdb5wYi7NUUEO5UgAPXf/ygDxACk4gdPg9RPqVjYI4
	 jKsAYet6CM9IXjUg9JWyrxvPLqQcwr+JJT/RQugq+DFjOlzxCcQXmhrGggoFl9a9RLGer
	 ws1h7N1h2ewJPxpITEspzJMK585dM5HUdfJlO8VpOvE4ppxL6524QxpCzZ2gmi6eb+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cSUa00z+;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BEB606A329
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06BEB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cSUa00z+
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so395630a91.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792555579; x=1793160379; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfY/SEah692s3Y5+TnEOtAVmjoLjea2BnPP2RXOzKdo=;
        b=cSUa00z+oP6RfVR7byNTBDWLgBqaNf4ATrzW+iemZrn+llX0sRAb2V4Cr1rKVieCTW
         tIwFLo0G6j+PWAVh4NQhCog8qT3BxKOsQDvlWwZPReRBfhiEFQEud1VO4UgtOewZn9BZ
         tPiOe+LUu7l+4a6G0fdbbuz6j2r4p8an+KT8V5p0UHY4PLHqW20YtpdfYzSo7hGsErC+
         J1lCXK8MsL4wR62qIhhhqh/V4LvNzntdvPzyqnTQnuPV0GtP89ueXJifAYt+/zNrvwAH
         Nd2C7T/lnCldXyKjW0zCwAsEuYxUrlk6WiW9iQx3WQnbRMQioXZ0J4GHxXMZeU225k8R
         k9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555579; x=1793160379;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfY/SEah692s3Y5+TnEOtAVmjoLjea2BnPP2RXOzKdo=;
        b=LAM/v18q59pikIgCKo4pyri0TSnzZnj8jjdZqC/o+Fn0f/jGtY815IEid+5CO42ZR4
         EH+8MgdCcUTpuc8nX4tvc4+qY90zi2HJI9wVwrF449Tt1Ce0vKq5FdFdbr6XgfpwW+lt
         uykppGZZrO/4Asl/JM5G5rV1JudV7tiem7sgoLR1tUOXv6abGjJ/xxGv8uilr1UEOdFQ
         /02Uf+fJxXUQiIRjySeDMg8CVdJ8j4wwlvwJR66ZHvZ5KEkfDwOV2W2dsjPNBrEiqeuU
         pOR5bySwHk4F3+gBazqYZ3zLuFLTTpIDVCIz2kfjYtiKuB0Ht3JR37CYmTJFaGBWqwzx
         TRqA==
X-Forwarded-Encrypted: i=1; AKwUvBxCYIFjxAye34L2EHslLSruShVTwjxVJpYAoZcZPRgkH4h+sqYrV/JFMrG6fiT8w9FbpI1OIgk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPQuOG9fcbPpjqY8benhTN1GhSzxsJlUrLOhcrM6WRK32++5Mt
	hMOkq1ofJrkgQFVbsDwxaId8ggcJGnhKIScCd/hFQt0CdRigKBIoqjziB5RqrnTwNqheYaeH1w4
	J6urylbPdefB36OJcH/WplQ==
X-Received: from pjgp5.prod.google.com ([2002:a17:90a:4285:b0:3ab:fd4b:afa8])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c92:b0:3ac:9717:afd1 with SMTP id 98e67ed59e1d1-3ad86cdc6e8mr779320a91.63.1792555579181;
 Tue, 20 Oct 2026 21:06:19 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:06:13 +0800
In-Reply-To: <20261021040615.3566831-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021035450.3488805-1-stanleyjhu@google.com> <20261021040615.3566831-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021040615.3566831-2-stanleyjhu@google.com>
Subject: [PATCH v4 4/6] scsi: ufs: core: Fix double release in ufshcd_eh_timed_out()
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
2.56.0.212.g129ede20d9-goog

