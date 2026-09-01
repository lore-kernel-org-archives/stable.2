Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03330ACEE
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265436; cv=pass; b=KUrLqKz3K/6pX5YWExKmSmLxmnB5XpBWKbPe5qZfWcZhnTeuBMNXrxfiVJiOvOXJGaGefRfQli09eA0NmPXxyCFLcZlHoAkUb2JOujUcfiY1+NiCkLhSkQQ5Ktkdqt+8Y5Lj7xaU0NMyf9TXXaXFbENQjjXQe2T1CLRUzQ6YMPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265436; c=relaxed/simple;
	bh=Ht5cATAfleiy5G4DRiReKjHxLRj7wcDPgpE6phoygGA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GR842HgkYUHX7rgu1ZA1g6sPFxgv5wx5MvFawsfSxnVrGULwm/0cURGoI7bxKsBV6f7dVgtRgBskx6lp1qb4nm4JBySE/wuDHmGeI6wHLxhbqB3V05InDjiGvqdwcyaT/N+JDlGyIoBYyw2HHXnYpxQHABkH9CLYbDaWr4wc9hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuRCfc4T; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuRCfc4T"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so321131cf.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788265434; cv=none;
        d=google.com; s=arc-20260327;
        b=I8d3SvANIANm6D3Im5nU1NGPkE5ffAk6lbqRIU/xO3I14hPfwLbL8h4Hmqd3bM8L+F
         L7W+PUxsRB9z5Eo6MCrMvM0bNgjl4YP1YhC5fvhPjdXe3L8oVS8J+vQ1haa9JOta6M6H
         tLMI1Dq4fdBy3jCQJeveLeemSp2CozxpX15HA1gcYUKTr7Ue1WZbAYV5ij6JUUDDlqgo
         +S5QPJaLcSiSK0N0GzzKpH+3F/sYXv/73O5FDK9aqXqe4DoGBAXQ0jT9bDtkm7Ws4VzH
         KcCxbKXOBCp0fYm3gMMohvzS4Blqk7AwP0m5NZ3ZvSlwJbNiLPW78x/+yIRX7Gq+U8Yx
         Ys+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xs/nVb2M1FK/MKYSmvmte6+x7BswjnCwSS6fAm+oyTM=;
        fh=ihvj7Bo7RSehlFY8RTU8EeuRpIhSM8T6qNLtkgR2duM=;
        b=oCzi7mDZgxIai7XQiOL/bsFhb3FaW4pWyCNOyNBiVeU7XPl7x7MBXN/yDKsdbNSqIy
         Hq09L8em+CmUmdpv7ubfcZ63q8AJyUqfZcXMs1b0/uq+evkF0goU93L+7+vzZfmENfZ6
         /PlXp7RmuHbsB3vqQntP1nHKIWihIluFmzriUdFL64lRyNfJDe8bZakHOqTk2AM0tigo
         Dy62z6sHFJqJ2I655ijrnoAaD/xoo+TWWGHvLS53ZKiTTuN75fINc6IoFiLTH6rz3HNU
         90ISVs//MizeBWEVboXU8diEXYP5trPKZOvhf8Kj1CmAh5vrltIzJPkZKm7ohThAw3Jn
         DgbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788265434; x=1788870234; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xs/nVb2M1FK/MKYSmvmte6+x7BswjnCwSS6fAm+oyTM=;
        b=CuRCfc4TLjb1itnOPdeYgIB0vWu/Fzo3XOaYzQosePC9QjJLm77xrSfwt/qAC5a/e3
         gfZfa4aJY7syELE9RYB39QliNIQKDroKNr3/zcg5kxPKjOrbbRnHXKdDqs9CSUa/qFoT
         j2aSB6h+PvQddNkJTCEjGQ16D9n2+hRFRntSYWzuV4VBtfoJdEs/YTdc0zPBRTXftnR6
         biFG2xYDMrYncsUIhqz0LieJtw8DzBnIZ9ke9EpTT5d+H0LtnJCfTrfxPPgnG/Od19wS
         CCGLCTr4UW4lkx3teU/wuRfhQwwHUSGFWCMS1bfYJQDPZq4Ks66/MDMayI9hlNgtfnXN
         kvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265434; x=1788870234;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xs/nVb2M1FK/MKYSmvmte6+x7BswjnCwSS6fAm+oyTM=;
        b=Kzyfc/MhffVMRJlzm0zkUsyX/gPHhBOJdPZ8y9MbintCsHl6xaWCMZ5Y5Em7L8sHdR
         hES+vN7pK7Kp1mKedzKVdZ1xZoHg+IIOdEIZ7SdgbKxQiwhICsnO97Ywgi8PL5FBM6IO
         QbF3ZFacl9qzwzDg5SVhlmzlmpI0vWqpgq/0gAPErSR1YQbU3lnpKPM6BAGjHG6slJrk
         ZuqSYYOnAk1k4oG2eLCDPz2HTv2xD1WFKo+5f867lNK8q/lgKRnv5bOqnbcVRvwxJPuE
         y4JOqlp/k6V9kIO8p/MzrhsvNA+kJRQdJQWeGn0jvh2nzH/jyZ3un6qNLqfgzUisprsR
         CsLw==
X-Forwarded-Encrypted: i=1; AHgh+Room6NHiTHhkFEf0zrp1Y5fFQsPWASP+yCNg8Pu4fW/GarTVR+Aj5FjlaTy7+zVoCfOZiyrCoA=@vger.kernel.org
X-Gm-Message-State: AFuF++n2Dyq1pDEMG4GHiCs8ZLwJawmUOBknpD33PYbUacIPMK6qeYil
	XgPtR1ItiXMuKg9F+hOzMOsvUr/EF2Uium2EapiVu2xRRI5ViFgSfbxCmAsc+Uz1zDvxf+ZDrnQ
	P+V1tvtFg8UhhhYdgTvhn6QBr3aIUh6JmY0saPyKd90NpKYGIthNObSIoKK4=
X-Gm-Gg: AR+sD12rK7y4lAC5W+RUHylx27HaxPjq6ioXWGPCiTEP1Bd17CnvmXdbRThoCIFa0K3
	m5mMAOOWlhVPENaHXoHMYzSPygSpHVB1H2Q1nrlqVwnIKAZQPAYwXl7SoKj5uvYdu2NTn0AAxii
	pdM4qLlQVigNeDyO7+EmwbNc+4pOHIdWIyEfWk7ZBB86dTFeYsecJ2igRx4Y1yj5EMRtEq2EzK4
	t4sJWFNzj4BvFjJIl4Otdx4HfZIY0jjMoY/CH8LNt/GxPIVUOolNBbPT9MsEBdJIF76/v2B+gak
	bzaO0lL0dx3cl73ARVMQ3GxCheH9z1EOI/IT4TZIXOdb
X-Received: by 2002:a05:622a:550:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-53024ed6209mr15248401cf.14.1788265433232; Tue, 01 Sep 2026
 05:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stanley Jhu <stanleyjhu@google.com>
Date: Tue, 1 Sep 2026 20:23:15 +0800
X-Gm-Features: AcwNN1WpJB9_YlNn1Oe8v1rf02Ia4P8dBEY00QCfQskFb3n-rTKkMqg0dRw3YE8
Message-ID: <CAE14pdek6ynze+muDZrK+yNX-3ioe3vprxOA4W22qokg352tJQ@mail.gmail.com>
Subject: [PATCH] scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@sandisk.com>, 
	Bart Van Assche <bvanassche@acm.org>, Peter Wang <peter.wang@mediatek.com>, quic_cang@quicinc.com, 
	quic_nguyenb@quicinc.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reading host controller registers (such as CQTP) is unsafe when the
host controller is disabled (HCE = 0), as accessing registers in an
unclocked or reset state can cause bus stalls and system hangs.

In ufshcd_mcq_compl_all_cqes_lock(), all completion queue entries have
already been inspected, processed, and cleared in memory, so the
software queue is logically empty.

Avoid the unsafe MMIO read of CQTP by synchronizing hwq->cq_tail_slot
directly to hwq->cq_head_slot in software. Upon subsequent controller
re-initialization, ufshcd_mcq_make_queues_operational() will
reconfigure and re-zero all queue pointers.

Fixes: ab248643d3d6 ("scsi: ufs: core: Add error handling for MCQ mode")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufs-mcq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8106d55f4041..0e1f99c8d77c 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -349,8 +349,12 @@ void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
                entries--;
        }

-       ufshcd_mcq_update_cq_tail_slot(hwq);
-       hwq->cq_head_slot = hwq->cq_tail_slot;
+       /*
+        * All completion entries have been processed and cleared.
+        * Synchronize tail to head in software to mark the queue empty,
+        * avoiding unsafe MMIO reads while the controller is disabled.
+        */
+       hwq->cq_tail_slot = hwq->cq_head_slot;
        spin_unlock_irqrestore(&hwq->cq_lock, flags);
 }

--
2.43.0
