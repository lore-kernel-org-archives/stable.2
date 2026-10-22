Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640698;
	b=jOH4gcfkMnTCQuod084p9g9LCa5esv/MhEV+bsVA7dvPmpwOE2P4IxabwjWh4zYOa5Zg
	 BULCuhYMzYtPCOUvnwXG7sESnXPoyFxEWTSWkZVJsTwy6HV14cfy1L0FTrUlK/kaMMDn5
	 x/+v509/MWyFU0iW05A6wDpo9WVUD9P9p/09xtLNpfYMlKN/Npag0LgElJ/YbD1we68Ig
	 mCLBNge+kVtLYB3fFi9zbTcrXI5L7t0pMtwo7vlyP+UqrgyholznGzUCDHbm0a+UVQCyg
	 VbuYeCstj4jOUPVy1KccIf90skiK681F4k71/PYG4xNdQMS0KYzx+8NUTuJPP5JrNMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+TrhtkhDFVvIhKjfwyEiGtODopfUQQu0bSw6HzfCj64=;
	b=GWggN2sroGURjrtkNRjLdO1lLoPjhDU2Tpii2YcIIhIhkZpoUDheFR6Dzj/7aD1KBPct
	 aECYSO/4UFvI/QspKWSXGTOPFtkitXvebjbD0Hoakpfm8bd8wiWeSX2ZAM6VRF6/tJpNa
	 z75i70V90xv7sSh9JlQjFKYxsKdFEw9sKMy0LnkARL7tLHcsitaGC2+ru9Joz8Dxs9rKS
	 gMNquSGBCTUunbNFQN+2tO1rQV/svvTNgIPKJXQs/DGVJTIjG4fqB5CXgz0Ouy2G+7AzA
	 +HbwE50VpVAIMFG3PIn9KiHOWr7QDCA7SyFqMS/XOKqIjc3r/D1dHjPgILXBZUOPufQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=L5YZ4T5F;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BDA606A33A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8BDA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=L5YZ4T5F
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d02df2bf09so10093125ad.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792640697; x=1793245497; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TrhtkhDFVvIhKjfwyEiGtODopfUQQu0bSw6HzfCj64=;
        b=L5YZ4T5FMwlMRd7geS0utbQnmXwYSMoYkAjK43frJeyBoNyqNNRv6QvGnRvU5T0TQD
         FhzuyMJcUWrVzBL9ZUbDX7D67coXKwtr0/LGBEkZHA+6tQfeewJa7jp4BGmB4pNzgU5+
         C4GRznlc0NUn3ZYs5O+UCpKeRn9s8cVGKsInd7fNK+LBlSFFfOX1dICydnFNDzJ2ilpj
         dHhL89cktc3IgEOfphV4F2YTbHacWKevDpZZeF9jGmj6aPF7S2HX1/IQfp5CU4rtWN+V
         tGSPfcutKmgtWaNXz6ryGJ6blzxAZw560O7MonhaBEZKK4Gc6nXTF+T5PQ4DxcrnD6XE
         iHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640697; x=1793245497;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TrhtkhDFVvIhKjfwyEiGtODopfUQQu0bSw6HzfCj64=;
        b=Y1PFjRks19XZ96pZEJzOZ5NfCOLeY4+x6DWHa/h9ysQ+6KFDlYp07lozAIkRVd/TNZ
         Hm2skTrKj0ujCSAFAKeTBNkS7aYDlF5EpSte/OQtSKP3NCdP7NGUwK4opN8H5oNjVFg6
         svVAAy3QpdNg11EWdcbKAaJuX6JO/R1xsdRg6jArOBZwumilxsyj7TJnv/gWUyzQOB+x
         Vx2cPmeYWWmpMbG9im5ACqAniE697ErtZnozxUKSPqH5S+MN3nUHcPGZDXrcPYGOeEdE
         Um2rrqZSY6IiSp2a+2baDayZ8CFn8tDhVQUWHCAa1EFLrusv0HYLHMpDD6IHuUR1j3V1
         SxIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKtv7quiwyyXF1BY++E+oDJZESM6OTRP3ngq0DsTokM6kyb0ux7r+n5HRrjEoiw8x4TqZxM3c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgG1+7b/alpK0oW+OieePZ9uAOCkYA9kbxBn1j84zv5CgiIW2u
	ZXZ5lywEzmsnM7C1rkdRObFYYm6sFMKqhpdtbNwYMMDYnH/wZ1cK5OtO1s+13UMtwoui6F6SKXg
	DCOiJ6JgR8IejGukNBMRYPA==
X-Received: from plsm24.prod.google.com ([2002:a17:902:bb98:b0:2e5:ce48:124c])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2405:b0:2e2:cebe:d811 with SMTP id d9443c01a7336-2ea43fe0efemr30804745ad.46.1792640697160;
 Wed, 21 Oct 2026 20:44:57 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:44:43 +0800
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
Message-ID: <20261022034443.3034432-7-stanleyjhu@google.com>
Subject: [PATCH v5 6/6] scsi: ufs: core: Do not release a reserved request in ufshcd_abort()
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
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 87efa2925867..141ad1be4848 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8226,7 +8226,8 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * Clear the corresponding bit from outstanding_reqs since the command
 	 * has been aborted successfully.
 	 */
-	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)) &&
+	    ufshcd_is_scsi_cmd(cmd))
 		ufshcd_release_scsi_cmd(hba, cmd);
 
 	err = SUCCESS;
-- 
2.56.0.218.g1ec904b173-goog

