Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555587;
	b=2l4AA1dkqWI8uXATUkFWWPYFHx6N4qARsUF81nWrHEuzZgoBLyLiwPAKco1lXIPoIZbM
	 4jC2EOcINwl12Gc9d6uzZjR8t6rBw47OriRTMt91sfuJsnS2cEuBDtupWqUmE38VxjVtp
	 kj+L+se/MAJDPnuffjUcRq7aGXS1XIkHnAUgsP0x0kfK3dffCeHv63X6eW7JlbF3pAfqQ
	 u/uAqF94a73+o1U6PcAJfn2cyNOKMyPXBk1IBdfEFLnCzNwKt+anj6w/TPvelIRTbBunz
	 J8QDiP/MzF6UIttMOSz4i8BP1QhTBDID/23eapBnIM3U5ugtivDxrwRrG/seSZXEERQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nT/VS/RnRqL2ufemzKKyohkTbyAY8bWGEfnEEtY5EnY=;
	b=FOvhcL1/wUrpNyDyprfgtF2b5N+c5RTERyYgb+NV52nwl+FPgLZS+pIhctTbTY/e1wG5
	 vjto9zAafqS7AJjiUp3O6IDUPY00isVP94AFAfjeDXxqN75VY/0RVwfGAV0SJQrxMAuXo
	 nWlAN0ZvvJYExAL1HZU/+DhuQWL4UrSppG8quRGZuwM6dkVGf5yhzyRmoFfMT/nHHdthz
	 8nw6nz1DeoMH4wGybFwgi+XhtPsOE2iWQc2CqSE7kq9tmQuh0c16aqoqdnFqK1pzNLYhk
	 /BWgpTpQzFN/3tX60WvVIF9pnNMFlBVKgBMYFrQqCto0jAUslVYNAkKTRfSQm6zsi3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EyQJZLYJ;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17132606A324
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17132606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EyQJZLYJ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aca98f01c1so372273a91.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792555581; x=1793160381; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nT/VS/RnRqL2ufemzKKyohkTbyAY8bWGEfnEEtY5EnY=;
        b=EyQJZLYJzsyDFKbh7s/0XwlNw4P7pO2/3wcRlA3lal8CrQla4lVJB+X6QX9n6pd/KW
         dEZnRNbM1nZXMoEJAwuJuGOr/H/HlgMYRH6Lb6SI5F6SLdgIvxH//9cCYtbGCcqQ1HE/
         X6tpSRNgUnZ2W/IMmUBCCwijmuckjqh9ZwgD1jnAPYtowjbvcPmlay8a1X1pL8JXTnSp
         4BhHXCtCIJvQAkybvMEcJ+SiMraxmrVLIL++JcxRqXxuSdCbofFCeETIkK/q5/AAfzot
         2x/+K081EElQHHmk0/GckW/FMu7Iyo4uGTfJ/CiXSNaPt55c0hHcN0TBnvVld5eLb//B
         4K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555581; x=1793160381;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nT/VS/RnRqL2ufemzKKyohkTbyAY8bWGEfnEEtY5EnY=;
        b=uRQshf4givKyyQRcMF5ejDA6XLaPNvkqLErGk99QKLzaoRb2fsJVlqV8VnCVY7kRj4
         QXDPKLMOdGWQX/yAne8cZkIsbEGoagC39oVbE1du/ODKs8erxQs1himgocvjWr8ioTno
         ZtXifl4Y3wfc8766459baQ+984oQ3ARdhPYsoCuDvFIT/Kz+lDdU8lrmqrK7EtYnrIjD
         9W2pJZ/M1i5eCD58VP7uGFwZRazQsSVfbAFQf37EiANOsXEISBQutqmGvqzkj4T6EwPC
         EK29MnO5U1lty+gY1+IL4jOtrb5onur3nnfAkFoUj+Pc3CDOLJM9UGBZNf3J/+mqPxaV
         sSQg==
X-Forwarded-Encrypted: i=1; AKwUvBxQFmqC2zYSt61Y/JF22BGhk3y2bvKAR9z+wdgBXt7plrlZZD6FvDCCDrns0Mfsw5QeMyxUMg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8xAbpvetakJ+VP+gop7agwIF3gwldhmeeavb/0l4cFVZOrqOG
	7wK48xK4bSFSUc5hos/fLV8N2KjMwmaa+nbqCn/tci+buq7foou6vCmnt0FN4/+1i4G1vCf87bh
	fPRYmBRLa6UT8yAR+IvfWIg==
X-Received: from pgca10-n2.prod.google.com ([2002:a05:6a02:638a:20b0:cc8:1e94:558d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2710:b0:3ac:a7ee:6761 with SMTP id 98e67ed59e1d1-3ad86cc9140mr835137a91.21.1792555581186;
 Tue, 20 Oct 2026 21:06:21 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:06:14 +0800
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
Message-ID: <20261021040615.3566831-3-stanleyjhu@google.com>
Subject: [PATCH v4 5/6] scsi: ufs: core: Fix double release in ufshcd_abort()
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
ufshcd_clear_outstanding_reqs(), release the command if it is a SCSI
command, and return SUCCESS when ufshcd_abort() claims the bit.

Fixes: 169f5eb28869 ("scsi: ufs: Optimize SCSI command processing")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/2e042211ca0ebc974ad5ec4c0de9f3f93b3c75c0.camel@iokpp.de
Suggested-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ff5977f7da68..4f9b34c1d112 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8185,7 +8185,11 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		dev_err(hba->dev,
 		"%s: cmd was completed, but without a notifying intr, tag = %d",
 		__func__, tag);
-		__ufshcd_transfer_req_compl(hba, 1UL << tag);
+		if (ufshcd_clear_outstanding_reqs(hba, BIT(tag))) {
+			if (ufshcd_is_scsi_cmd(cmd))
+				ufshcd_release_scsi_cmd(hba, cmd);
+			err = SUCCESS;
+		}
 		goto release;
 	}
 
-- 
2.56.0.212.g129ede20d9-goog

