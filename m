Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640692;
	b=BqnHll1vGe1+WGRx3saIvelvgfB46XyHsKLfpfFcsCPwrL6jAn8bUViXHSUbF4sqCInM
	 URHHSK4IrLjsenvuXGBHwfjIuXY+60QCeOBYOAo1kJeoI3sUIKmY2Fq2pS/9yuG7Nsey3
	 P2kYcPj41YKeq/EABUA2RUafjaqURNiGHLNOdzt6S91MNW3ePAAJG6+5GVApKoDE5NueU
	 JknFkCg4PEHhw+rx/oOa368knJHGCnlZUm2gcAGmygnragcgDSuPZpnQXA+GfxC1v0UtU
	 PGifz3qdPeDrV6iFmAKDSwqRJzcDiGvltoS5f417oLipl4ypuNck2IeE2leK1waeoiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dmUAl43GwZhqnKNGkW+S2KU6p3o9wRLHowPUl3QmkvM=;
	b=N87UgpA1TeJ+CveVkIZuz1v5IeIy+b2qAct0zMPH7xQUx8EsUkZunZN6MmE4bRHi8VXY
	 1dFd815hKJ3TgJwrWAE/x9G7n47ZrnwvyTym1BywA3cVUdrPS2bWJQT4UEer//O9GPpTK
	 4jx2kc9dp6Wpr6nzQ/Sonlal94v/iK5UCm/SCeiVGdSWX5KWCRdZVeE0Ra9DkGK74nIb+
	 xDgsWrspHQ9Yg/lj/wpvwH7g4MVdODzBrjl/ZTP9dAH4zy78AfUkhXMHgwz3fBK6otdu9
	 gVNkoKJgOO4trO1A9yuHmiVBPrYcmjVAFrm2UdgP4ZajNoegnKlL/fjwQzP9Z/6Uq7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Is02QbK5;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8941606A32F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8941606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Is02QbK5
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd68bf391e1so853863a12.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792640691; x=1793245491; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmUAl43GwZhqnKNGkW+S2KU6p3o9wRLHowPUl3QmkvM=;
        b=Is02QbK5MAdnWLelVLAJTZTNDF/cK3Hq5o1cxG5ZKigyMeYidgPh0ftYpw4DSdC02j
         fiEUDX1fncegDLqO7A6fuK8c0bvfIH7fxjkiQ2la4DTrIqAied3orx7uxTxNII1OLVUn
         dQMXNQw8f/dZDXiUEnSpNsdA53wVdu5D/zk4AKeMQ6sgpx7hrxhJHRR7wpKvD/Sx8pRV
         Q91DCpWVeSn8qGkhdOvNCG7gtBBLf2zlh7qjbLy7dVecrgG69m2AEh7wM1vuQbStY24C
         oFYBx2o0zrwjhJ88BXZrgaYSGZppbOlaDDWRsCp4xog6zEPWwuMLNKmvWn/NixbLMWb5
         XYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640691; x=1793245491;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmUAl43GwZhqnKNGkW+S2KU6p3o9wRLHowPUl3QmkvM=;
        b=1k887LJQYlS6i9Ds5AUncDqV2NNGzccBJ7GZKfwInOegknxvlAeCfOZLcK8Qug3b/w
         v3ToKhFH6HBuJ96Ejpi9xJSF5ApQzadGrJ/WBiHn4Cn+0l0QiVuP9q2VCXzX28tnEK1u
         1ph70xNW4lIKpNyGPRikrtwGAglX3J8ypyO7efVgEz2w6StX7Gl6GD27oY8lh0Nj+APd
         ygIq/1oCjOLB0vJnQJa5fG1TeolR/bd9mNSEAw5r5vcywIDqshVnUniu6nzaCKQJY//9
         H/FPezWX/xHLXBVZ5153aH9/PtNtkQHakCnXGewQg5CnVcsX27U0UK0/yNpj/MMuhkOv
         tbOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxsyZasuRJsKzceLgWwloUCreXBOifiYdRih+WiU4gfr+OlKK0orjQUzfbkcfxR0g8cQumxC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIY9qpZWWy0MtKJYo+6XdwjvOYm5Mo4l+nGCrmXPIbaqcx3wejo
	G7MxiczQltrz1CJOc/R+xEc798oMg1RwdafJ7Y1l65iT11Cg3X1REIjSF+Tk+NjJVitGevUXnB+
	rA8/3BrYtsbMjseNxhy0ZoA==
X-Received: from plcq17.prod.google.com ([2002:a17:902:e311:b0:2e8:a577:d361])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:124d:b0:2e9:7dda:bfc7 with SMTP id d9443c01a7336-2ea4409f85fmr29606375ad.66.1792640691044;
 Wed, 21 Oct 2026 20:44:51 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:44:40 +0800
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
Message-ID: <20261022034443.3034432-4-stanleyjhu@google.com>
Subject: [PATCH v5 3/6] scsi: ufs: core: Fix double completion in ufshcd_clear_lu_cmds()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In SDB mode, ufshcd_clear_lu_cmds() clears the request slot in the
controller and completes the request, but leaves its bit set in
hba->outstanding_reqs. ufshcd_poll() treats a request whose bit is set
in hba->outstanding_reqs and clear in the doorbell register as finished,
so the next ufshcd_poll() completes the same request again and unmaps
its DMA buffers twice.

Clear the bit with ufshcd_clear_outstanding_reqs() before completing the
request, and complete it only if the bit was still set. If ufshcd_poll()
has already completed the request, the bit is already clear and
ufshcd_clear_lu_cmds() skips it.

Fixes: f18fac1e2b72 ("scsi: ufs: core: Rework ufshcd_eh_device_reset_handler()")
Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1db572f84971..68b53f89f8c6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7987,7 +7987,8 @@ static bool ufshcd_clear_lu_cmds(struct request *req, void *priv)
 		return true;
 	}
 
-	ufshcd_compl_one_cqe(hba, tag, NULL);
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
+		ufshcd_compl_one_cqe(hba, tag, NULL);
 	return true;
 }
 
-- 
2.56.0.218.g1ec904b173-goog

