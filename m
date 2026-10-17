Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADBC3D903B
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792226651; cv=none; b=tPB94xkiQl7Q7ZEP1xKB8XoawX7GT/5mS0RvG6PdAg+FEpfevkZhs379dU0owuVFIVoQL6JRiQiirMx6lv9nqj0xZKiFSWQcR7+lfHlMQhnLx+mOXQB20fgjehnGLekZklui8FPpxorNoBUqH9kEvW129ftiMKJKe14Rudbqxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792226651; c=relaxed/simple;
	bh=Q/X/QgkPV9GRHvc0llHqXagnyq759chf6kmMWWc+gqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+/Ct70SUQCp5h62QjrcB1ZGDd2+/5erdBJ0CdXEWwppKpcSVrSTnnnwjTuQaZIddheNqpEPp+Fr8qfpcDitUnk472Of0POGGRkra3a8R4gLg6LXEwyfU8/CQrDqCBRmN6SWjTuDfyDRdHExays1gs3JgGy27cDlsKKPfN/r0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaQrOPMK; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaQrOPMK"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso691826a12.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792226650; x=1792831450; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJtE2MOebaI4Aow6a4In64UuLQH5fsqvaP48yIJtyGs=;
        b=jaQrOPMK5/nkBS+4JNVuIMbjhmSao4kWuxclO+19454HM+zEc8jrj1pzgLCiW2l+L4
         EFUjRXWCpkd5kHjUx2gzR/RpbPeZFW5mO4ItC5uTQmmc7nQd1323+te98EivGsuBziJ8
         xIFE8lz6C1643wEn+36lUXnpeQcWaB+KpQ/MUzVAjb3mNq49WAuGUzaU8csAMR8KGX6N
         cCppdcLbrURgYL1+2EbxshwhHT/+wy1U64XIGJVxSXVHUCmR3ZDNBzJfI3gCORJmcsrV
         a+TDJd+WGLTS1jXtkqkcNpkR+tvLY/ZjwzOi4X5KRz5ZcmwFjrI7HuOoBF2NyXulzVjN
         oHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792226650; x=1792831450;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJtE2MOebaI4Aow6a4In64UuLQH5fsqvaP48yIJtyGs=;
        b=SL/nyf8MReGSVgMq2YtskULGS1JPn9pXMUmAppTNb3OY5v2lMG1Gv5ZgZD9w7/5XGr
         jRRp8EaSIQFNgNHNGxRvl3CXlC+m53eHbcvV+C68MxXf9m4UGJMvZVFKaaoqug0Edz2y
         S1ji1bNx1gsRylaV4hyJtvslMLOG3bODd2b3Y3Kma5XYCWiN5yKC/jaHBCp1tTBXZAKm
         EiuP0W8bYSn+oso4UlLzjP/LHfX6tIBOPTSE6vC6mg0rY0v7jshrXS+nyiZHPFaU5tjx
         Ebb6Q7q5RhE9X2v4J0X6cMTi2dg3uM5HHBdakqJ63BiC/gieeNxtSQfxkyUu6BVG63bO
         7OKQ==
X-Forwarded-Encrypted: i=1; AKwUvByk0zwO4HkMftljhBVfozmallmtXmVvPZSuim1oZDG7y0CN0ERqFKi7xnHaPK3uiy8LKVm3exg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0i4gdi/HwYwIs9S31vp5Naq66wAJPhciuOVh5bg3eZaja04Vj
	jNsk3WWm2Ow7bExNFVhDYqeecshMYhCuA48FVQBbAafRk0vjAdvMmbB4+5P3W9+LAfzh1hXVXQU
	LZeljepPI2cwVpb7jgvWE4w==
X-Received: from pfbky37.prod.google.com ([2002:a05:6a00:6f65:b0:8a0:582e:68f2])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6f89:b0:3d8:1f68:59ac with SMTP id adf61e73a8af0-3e225fe8c5cmr1674818637.23.1792226649454;
 Sat, 17 Oct 2026 01:44:09 -0700 (PDT)
Date: Sat, 17 Oct 2026 16:44:01 +0800
In-Reply-To: <20261017084403.875420-1-stanleyjhu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017084403.875420-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261017084403.875420-3-stanleyjhu@google.com>
Subject: [PATCH v2 2/4] scsi: ufs: core: Fix double completion in ufshcd_clear_lu_cmds()
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
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 71f4b9d0a850..531309c7fb79 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7986,7 +7986,8 @@ static bool ufshcd_clear_lu_cmds(struct request *req, void *priv)
 		return true;
 	}
 
-	ufshcd_compl_one_cqe(hba, tag, NULL);
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
+		ufshcd_compl_one_cqe(hba, tag, NULL);
 	return true;
 }
 
-- 
2.56.0.176.g3575e65682-goog

