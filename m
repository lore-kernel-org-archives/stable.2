Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555584;
	b=2YXGsrvE0wcapYfnX1bPkh2a9JxgDZeH3L0Owi4X/DOlMHsRZYCaLn42ECYlovrX53w8
	 l4ZIfrfK+3svPp8x5PI3IA7/N6t4az758D2Cc72+ssi9FD7Rt3GOxiWC1tI2oCKBNuEWC
	 bXfPrVeUqPsIVNnM3a7zqVHuk6jM9AzrujnB7iH5MR1Mig7TmotO9fLT8ldIiqgIcXzo0
	 NY8ahCSTJOtB1wpIJ8dOuadHzjPvrLu1jhlSuRzgS0mokYF4QTVldbXsR/2RvoukBxmiT
	 Srf2aBo7WZCBWxzwldh8iHgj0CDiTHMmhBW2/vYBnSa4s8/9akFXJnH5U38cgsLGJoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZjazkZwP//tIu4UQiMntOSVxBKhC31LgQF0W/o5JOFA=;
	b=RdEyqu4Dp5YD6SvNEeZ+iGvuN/8mZ07eVvshZpB/G9kK4/1U8o7RfMASA4gYjowLKsNf
	 12jGjDCFKJXws1ksktukZkp9036yRN0MiusgVEiEUrBeGvNPkqRi68Ozo+J58lIqH/1Ek
	 pQAl/ff9JWZZ5bWGvwXViL6qwqB33fak9BhRxmyJHyM3kY28/GiWyk0LOYUlU1IJKIkXF
	 BLmyCLV3vM0jW01Wl2d70plMeJaWT9BcwkzJQv7SlsrAld4V6CZLuucyTpN4VangHSvoh
	 XfOUViyCWZVs8snzeL9wnhB6mpPJEDl18Q/DOAvEayGTUcoOd402sya0j85YrhdI0hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jUZwhXzA;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE93606A335
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE93606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jUZwhXzA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e8ba4757caso3014435ad.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792555583; x=1793160383; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjazkZwP//tIu4UQiMntOSVxBKhC31LgQF0W/o5JOFA=;
        b=jUZwhXzAIqW/3B89QT7YFMdnfGPqNYd2mgle2ZmJ+WczqnI1TmMyBpx0RBCEBRz9xc
         4guV/oiklfCjo9nSNJ3pXW1PFv6oGnQcfiu/6NzmSj/5vIek6f3PPEjE04eqFkoUvbsb
         1Sk5OvpdLBTrZWYkgnONNyc6rkEYJXrzS0Oo3wBLVwK0iTz97GAvhYw8zuqb5R1SUNUZ
         +Kr2IuKgtRllOXVvOS5pr2Wvd5tpPCJnNUZBJv7b+iq3aB8AMUGEn3t7lR5Is1kWMF7w
         Yri6b/Kk6CBFSJ5KMu779Vw/vOFTidjEvnX6pAwKBiaQ4fyWfduFL1fYWzJbRwN9ihcq
         Q4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555583; x=1793160383;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjazkZwP//tIu4UQiMntOSVxBKhC31LgQF0W/o5JOFA=;
        b=AE4+QDHNiYZDME3b15tk24zJ9NBefA63/J9RyltQoLol8Pz2eE/mdWxm66PNovGNtY
         N3vyV57sLYQMV0TB2JznrpT2FGYQpgktWNd0IvA+QukyIYWEMwQl8IyxhwF0I2T5WRZP
         txAhmP4ugu91haxl9yCyzMKdwjidUmMUhSev284yfZ/ttnx4uo7UMAAL2MCbJe/J8yW1
         DlIyhJjNBmAfaY+0LZnr9lyitleqccP9J53SJRrOFRKDsqI1vhc6Cor3SbW6A7Iu1QqI
         XKnMwupPcYIHEtFyyfMisTg3zmbwDUDuv2PoBZj1w/sBr07Sx28EuHL3v/7CKUk5UH0v
         7ttA==
X-Forwarded-Encrypted: i=1; AKwUvBw40+QlEY2WJoPrLIfnQLRwW60drMgUyrmQ8ySFbBRTSBMo1MPeqBAMCJES58D5tCxdjkO5y9w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtowEnCIJEsYAoZ3NnTBFjudWeCmjQqFk9Nfex74fqOQQ0g5tv
	MM5J5fW5XT+/MKZW/0SKoodpWPZ7Oj9U2xZFOpVqSp0IhRymSFpxkSX752YFvN8NrGv9eRO/Hf1
	fCtazfZAMoj/e9V3oOBSqHg==
X-Received: from plbkh8.prod.google.com ([2002:a17:903:648:b0:2df:6366:11cc])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:324d:b0:2e9:528c:b9ea with SMTP id d9443c01a7336-2ea43dcd6c1mr5259055ad.11.1792555583209;
 Tue, 20 Oct 2026 21:06:23 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:06:15 +0800
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
Message-ID: <20261021040615.3566831-4-stanleyjhu@google.com>
Subject: [PATCH v4 6/6] scsi: ufs: core: Do not release a reserved request in ufshcd_abort()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In SDB mode, aborting a timed-out device management request drops a
clock hold that the request never took:

1. ufshcd_dev_man_lock() takes one ufshcd_hold() for the whole device
   management command. ufshcd_queue_reserved_command() submits the
   request without taking a hold of its own.
2. The request times out and ufshcd_abort() clears its slot with
   ufshcd_clear_cmd().
3. ufshcd_abort() claims BIT(tag) in hba->outstanding_reqs and calls
   ufshcd_release_scsi_cmd(), which calls ufshcd_release() for a hold
   the request never took.
4. When ufshcd_dev_man_unlock() drops the hold from step 1,
   hba->clk_gating.active_reqs goes below zero.

Release the command only if it is a SCSI command.

Fixes: 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/2060a8da-581b-46d1-a510-779f4df716cd@acm.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4f9b34c1d112..49a981b8cc32 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8239,7 +8239,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * Clear the corresponding bit from outstanding_reqs since the command
 	 * has been aborted successfully.
 	 */
-	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)) &&
+	    ufshcd_is_scsi_cmd(cmd))
 		ufshcd_release_scsi_cmd(hba, cmd);
 
 	err = SUCCESS;
-- 
2.56.0.212.g129ede20d9-goog

