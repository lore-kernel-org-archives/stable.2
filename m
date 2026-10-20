Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484481;
	b=NDOr8PK3JTzLhhi1BzAa2Lf4tL2geTvMJ5i4gBcpOSAh4hXGiNVFEB9P28SK4laIGA5i
	 DwkAjTUBQUXQDAgDoAkdsRMjqFjmB7k0489ZRFF7kZ5mFYNLLxUr2OlM5BK1EZwnItsJP
	 gnqHvg/RdeqoCHLK4awpxP+PoiAjTecXhotpQSUDdiY1ssEVkgGxZX0vHCpcTKjVckfyC
	 IiT5QSY7vIKNagl6/aSxGgs92QaoS4DYFN9ZrCsDCjXlJdH3c4tEyM+nA+Cms1+8hwDsi
	 z+/sU6IRaipWh/PvC1EhMAmE59YzyeSIj6j/Fo++6ek8adF8Bdl6kfcpZddvjBxnXmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kUb4PjDJE3jmbIXPSQFsF3M/wgWILtNCIkP/sO++VrQ=;
	b=zdY7jjxcbfxgQ9vvUhq2geq2VWX+tFDn9sD5UP6tHPn5eB6XbnBFxe1abPGIrs5zZ39K
	 xz95v//rkS326ZxmRCK+/SRt+/kiZVj+vvhhSUcdPyyRgmQwhwxQz/x6Tc5RZ+9s/GDbL
	 0hzxnzRdHz41dVIaTQDWtJnISoJWmgVB5QndWi/PdqBo8Fnw+fuXm5l42vuc7h81vTrNd
	 +P4hu49althOIfd5hYHyoNZTx1xEBhBXkueBzob6q4V1/pzdVyKvfbRwD5hbWIVYkKkxw
	 t7rhu2pU/E/PuJI4r7XrPmzMGwFYy5nP1ba+5ipw2W+SSy63QMtlN2a893sG36p0MsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NWyv+XgA;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE1606A329
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41BE1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NWyv+XgA
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so1997720a12.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792484481; x=1793089281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kUb4PjDJE3jmbIXPSQFsF3M/wgWILtNCIkP/sO++VrQ=;
        b=NWyv+XgAyn89Cjyc1kpyFtEvrseSFaaSjvJKD00zUxxAqRwBDNLtDh7+0yKZ2rayjb
         b7pJ4qSmGrbQs8tV8jYWtw8yzkEI7A7bjoBckHaNcEwjfmPmkk1L5aLmcxqeE1rYjqP1
         GjemQvDzEjslx97UJ6jiiFrT94X5dPgIG2LlKYmx53KFctsNjEkcp2lN9Pfmn2IiUctL
         AYxU+d1EO8dBOdNd1q+6cMeMAgXry2ZEBeVTxwP/3FC+17HXXMaQG487bl9K/lgwXfmB
         lV3QGv/DxOmcV0LKaJhrjXJzA/uIn7PJku5X7L7Fzx/yo3nNx7+lB0j9lyqkLD/oN2UF
         7y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484481; x=1793089281;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kUb4PjDJE3jmbIXPSQFsF3M/wgWILtNCIkP/sO++VrQ=;
        b=MnIgytM7thlzgLENmf5uKRG4i2Bke7+fcUKf5wzn8hnO75feZ/eT0S/wIWeaB1P+kd
         ++bwggahti7XJ+iMONuZrtCPxRPdlIlU+QBpAJCOHxAYLs9P5FfrsLTPIen/zarumkrY
         TCJpgJtoTeoEs6xLLV21CmClgcCcAqdXtFOacAIt1JK4kq9Pk0wOh/rEsVMtJX3GR9/a
         /6MHT54pKlWtZiOTz8E92Q76v1RcDUeaoMJf322Oqcd5HaflaaiQXULYe6OvWwSfa16p
         Nxmd2R+oUpXZYrWkY92QSSXKpK7A/yo4zO6rvYjvvLhsOmeOBOz88hmOggkX2QQghfxF
         718w==
X-Forwarded-Encrypted: i=1; AKwUvBw9408RCfYC7TYRuN7CtBkHRmSCwsPmDI9Od7G7TYXyPrUd/fdlILPkb0QnX4yAwITeymaGO/g=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1d2WqBkQA1JQZ1pqz8Gfb1ZNvgeDazNMkqpXAzMHz/D18RGSX
	/kC2CD4iy/kKM4arH9bC2pkNIBCBYGSnnpj7I4mYUee6SqrPGvPlUB44UA+lF1fCutZHAyIKEy5
	aL7nxbf1Ek5//7sS2xLrg4A==
X-Received: from pfbct6.prod.google.com ([2002:a05:6a00:f86:b0:8a0:4085:d831])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:730c:b0:3e1:e757:205e with SMTP id adf61e73a8af0-3e225f9fd41mr8502692637.42.1792484480229;
 Tue, 20 Oct 2026 01:21:20 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:21:07 +0800
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
Message-ID: <20261020082110.3511797-5-stanleyjhu@google.com>
Subject: [PATCH v3 4/7] scsi: ufs: core: Use ufshcd_clear_outstanding_reqs()
 in ufshcd_eh_timed_out()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufshcd_eh_timed_out() has its own copy of the code that clears the
timed-out tag in hba->outstanding_reqs. Use
ufshcd_clear_outstanding_reqs() instead. No functional change.

Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 778932298e27..03efbd85bba9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9651,12 +9651,9 @@ static enum scsi_timeout_action ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	 */
 	if (!test_bit(SCMD_STATE_COMPLETE, &scmd->state)) {
 		if (!hba->mcq_enabled) {
-			unsigned long flags;
 			struct request *rq = scsi_cmd_to_rq(scmd);
 
-			spin_lock_irqsave(&hba->outstanding_lock, flags);
-			__clear_bit(rq->tag, &hba->outstanding_reqs);
-			spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+			ufshcd_clear_outstanding_reqs(hba, BIT(rq->tag));
 		}
 
 		if (ufshcd_is_scsi_cmd(scmd)) {
-- 
2.56.0.212.g129ede20d9-goog

