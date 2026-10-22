Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640686;
	b=2/XjksOzqFl3FJAdHB8D3vvMDTy8Q6Z/s3Jd+0HjIVcwrXdor9H3fzwHS7fvHxYCb8Tz
	 YHfzmY+Lj2hU/+QHbDcwrLS0+YTK1YSOGzl+Z/BcAkFvKxJ6Ltpa476rFRBUHSDzFqmGX
	 R4X9Wk4MLO3X3aRIpoC5/b/NDaQCgYk73noby0iNBJipEYlLobXAz3zzdyP/qR1UCNWKa
	 sA7INKM/Tt4Zgn7kh2HoI1ayXOtvDCfBMbkVMcICvyYV3eJrMRFE/t70LOECfnLlmduaQ
	 mfdWpScuVyq5CEH9VYBcW2fKtGzmUsJm2xjw2mgvk61gkS997wWaTw0nUE9ByGW8LEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cAOkPWRp8YvKWUWIxl2IXJ8ilv8tHvpDegM+zVdAFT4=;
	b=GdNeJ5x7BSI/uYEgcD6S3J575UHnp4/aRDDvnq60IJBd9DEAQuG11/5mpGP9OMvz4sMA
	 Z1MHhMmCvJxftmaJ2H9p1MKDZL57FoumSkoPH9gvDibIxtqYuSp+WCS9yJnhLuVnn4WOw
	 4UhjJ1gkXlWU88vdNiA9jSMWH1hHXRseByyn3PA/834jIBbIZaCylOe7Oxk9FNQUiLyK0
	 AAAPTi2VrWiN+kLtCrq9nnsoImGpQOBpG7B3nc5D2Mj7jxrFEcBnr/EFF4t8cUECU4IU0
	 OQoGdbhcHysq5/gXvwT0RfNdZaF6CLAEBO0EpTeisyC/MlPrtihGhct8EwTQovxlEeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZC7snNqo;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE23606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CE23606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZC7snNqo
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a086f5d91aso1641572b3a.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792640685; x=1793245485; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cAOkPWRp8YvKWUWIxl2IXJ8ilv8tHvpDegM+zVdAFT4=;
        b=ZC7snNqoz/9upuvpChHKN54cnDw0ELy0L2uPW2Uwe3xOm461emWb30h4KjqdWiCjdD
         KvmuTMGWajGD7QTkkpn8fXDToMvmn1y9clydOHcTSz3PfFi2HOy5dOA78Ah86XctTJ62
         z93I8CIKebO0f3M8bUmZiC1Hnirvk+dIM4ku1ykzE5z1C5Vx2c+xFVFNV70JiCGLbVpa
         SfW8jf6+vvYrc64jxIpbc0KXlofZxbsIYnVO28i5ltQbYHEuXsabwg2LB0n4Hp3TPzBf
         KACBEVeK34ndwlGxSm1ebVnfD1BN90WEZSjv2c+anMq2jsEZkd9KSJ7nUE8HdYUA9OF6
         3jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640685; x=1793245485;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAOkPWRp8YvKWUWIxl2IXJ8ilv8tHvpDegM+zVdAFT4=;
        b=SF7l2iKA5rIfETjpqfBSJk7h/w6c840wSWcGrhuUB/KJPui0ekVDjfU508KViTZ502
         LgMy6L3FYFjidcOBw19T1WOZt7IUGh069RWjRsgfmmgT8v010reA/ltBEb3y02gqpx/S
         YwNKAC+fWGbsvISj0ya9pXM6S/Q6FeEuwAfKa0hCyBLURZKVVqb+gIhWVPgiklbvTYyh
         6sAJiMTIbPfhbf2nQQVn8QgSGhKwpIIlu/p8iN/I6LRcAFufNfHYpoY6kppiTcBMSTIr
         ReKHyUdAX4hHFTc0u2ypS8Ja5+bOyiH9WeUj+w+4IlTfiDzL1NIcUDHt1GrWzeLk9qRD
         AuCw==
X-Forwarded-Encrypted: i=1; AKwUvByR8qm01yCNt6lG8vtbSP7iEHWMChDeXnxwRhNPSfVlyiRup914p4xVogAXhXrWnT02UewzxeA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaUJ4jefe7VLC0wBtrBjhr6+kKc2J4K/4MWdsi//o7keIginUM
	44inH6CwM4gzwt4OevFHoEPzLY7olzOLLk9SXvVbKi3c8fPriBNBPpA506aUTDYdIBfZLXEQc6e
	N3eyDNrpVOKD1sTomqez2DA==
X-Received: from pfmu4.prod.google.com ([2002:aa7:8384:0:b0:89e:861c:6b1f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e1e:b0:881:750f:b142 with SMTP id d2e1a72fcca58-8a089d532b5mr3181649b3a.55.1792640684699;
 Wed, 21 Oct 2026 20:44:44 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:44:37 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022034443.3034432-1-stanleyjhu@google.com>
Subject: [PATCH v5 0/6] scsi: ufs: core: Factor hba->outstanding_reqs helper
 and fix double completions
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In Single Doorbell (SDB) mode, multiple completion and error handling
paths can race on the same transfer request when bits in
hba->outstanding_reqs are not claimed atomically with completing the
request. A stale bit in hba->outstanding_reqs lets a later poll or
reset complete the request again and unmap its DMA buffers twice.

Patch 1 removes a WARN_ONCE() in ufshcd_poll() whose condition is always
false.

Patch 2 adds __ufshcd_clear_outstanding_reqs() and
ufshcd_clear_outstanding_reqs() to share the bit-claim logic across
ufshcd_poll() and ufshcd_abort() with no functional change.

Patch 3 uses the helper in ufshcd_clear_lu_cmds() to fix a double
completion during LU reset.

Patch 4 uses the helper in ufshcd_eh_timed_out() and checks its return
value to prevent releasing driver resources twice.

Patch 5 removes the completed-without-interrupt branch in ufshcd_abort()
to fix a double completion on timed-out commands.

Patch 6 skips releasing reserved requests at the end of ufshcd_abort().

This series is based on mkp/for-next (db8b4d2bf2d3).

Tested: QEMU ARM64 in SDB mode across probe, I/O, abort, LU reset, and
PM timeout paths without double completion or resource underflow.

Changes since v4:
- Patch 5/6: remove the completed-without-interrupt branch in
  ufshcd_abort() instead of claiming the request there (Bart).
- Collect Reviewed-by tags from Peter Wang on patches 4/6 and 6/6.
- Link to v4:
  https://lore.kernel.org/r/20261021035450.3488805-1-stanleyjhu@google.com

Stanley Jhu (6):
  scsi: ufs: core: Remove an always-false WARN_ONCE()
  scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs
  scsi: ufs: core: Fix double completion in ufshcd_clear_lu_cmds()
  scsi: ufs: core: Fix double release in ufshcd_eh_timed_out()
  scsi: ufs: core: Remove completed-without-interrupt path in
    ufshcd_abort()
  scsi: ufs: core: Do not release a reserved request in ufshcd_abort()

 drivers/ufs/core/ufshcd.c | 70 +++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 29 deletions(-)


base-commit: db8b4d2bf2d3e02b4ff78bbf69d00e11795840de
-- 
2.56.0.218.g1ec904b173-goog
