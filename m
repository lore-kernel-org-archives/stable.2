Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F060D2D97BA
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023549; cv=none; b=oxDMSqVync44//7GllBZ+wXwsOA0eFPf2btsH94ubviu5NQcorhSUfGwbg2MRuJJky4pejBoV5DjRcItxd8lyW+jjYBMoG+krR0UORwY62s9IygHRH3OYntNRrKOPIWpIJU5ix5ZtsmEfb8gTXbcrXa+JuDtzO/jhJcYAQKECmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023549; c=relaxed/simple;
	bh=Hr2oK8ttmlpG2D61qsDIhKKQExFfy2D0BxwiCZaK48U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GYJLpxyFx6x3g991zgEFKT9LIhoKwKYy4yE7SqmVBFZR5oK7iZxEmauaRlm23ZP8iNdJQI3ciNJS2+2SRiLyyqtu2iJf/GBzy3QhN/zAHrtPXCcgTPizUXgBfM4rphwll+L36+u0BY+QMW6yw1ScgMuFas1+4QsYmhcsSLvpfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjgZeHrg; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjgZeHrg"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-897bfd32c95so3508771b3a.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792023547; x=1792628347; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ekzn/WWlDOKdo6/4sJafMgrym97HW3GfYUZNRGrTpGM=;
        b=qjgZeHrg66T3D+fTLb8GvjrjD5PDWNJ4IIoqkHpi87ImJ6C8Va2hS3RhCAe+vC9V6f
         INzNOEFb5jHvIW897DwUYeFbtLtEM0ULUExBt7w6uXprygM9t5IzKDE25SHm1QfQAynk
         SMBSc3RkKKJfmwW6gt74EqmOZ3y9y5BWPsvqzDruJAruaLPSMbysVrKzq0LehcyA4PwC
         nEcCMYXD2haH9R4r86Uw+rq86jcZPnwIMkmnknRihdYAfi1Mcz1pCbEj0u88N2tGhSSB
         hLU3G0Yc7P1a4ub3twm+mTIuUiHmBymKsBHuTTs9baNDkwU9opvBG/nWIILCCUaIFpdc
         MzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792023547; x=1792628347;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ekzn/WWlDOKdo6/4sJafMgrym97HW3GfYUZNRGrTpGM=;
        b=fJKP2V1nZsQ6foLkYOcn9kAG6JkGb1/zGrQHqu6ICOdbyGtbUP+PHkY03mtLC/f9sj
         Vq2j7yPswAFEWBwTgUPKFjKNAyfuaraOdLSXKwAZxC07fu2YOEb2EIuBMqjJP0qzH1yV
         /9a35/p0/CKN26QfH7qNERmObYVpXkSttscdq/++0C/B7SSjOJ7BLhPBkIeZ/FgG9TWm
         UJgiWEr68ncVtAVhahLzn0RRZ1zC+8LotiRUP7kE2zCd8a3aEot5t0+wyDAOE9vf0U+Q
         wPeIKaxdj0pxKWQjGlz3ETpEntBMyvXuoTmlMD28vW+MIgVqfNCGiXGYKg/CMF/CqWUS
         RezQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgba+Lo0gjyrFRbGs58Ug2dnUB+9VISnvJEwDbCT2eje4H77vAqNK4GGtyf2vJKmrUDF2UdtI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcLbfHG35yg6dZwN3gZ06+clbYJNV+4rvFvo5VYIQ+uBVlm2rp
	kP6Vzwvk49UJixvsh+E3A0BvMpA6G+W9TB3HiArh3/xGUrp9dLLlgCN5PCR6c/1Gq8iksP3aANp
	zemnQFwlBHSeyEVcOEK3KHw==
X-Received: from pfbay42.prod.google.com ([2002:a05:6a00:302a:b0:88f:3e8f:c0b])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9083:b0:895:b10f:242d with SMTP id d2e1a72fcca58-897c83ac869mr14665480b3a.43.1792023547126;
 Wed, 14 Oct 2026 17:19:07 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:18:55 +0800
In-Reply-To: <20261015001855.3450573-1-stanleyjhu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015001855.3450573-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015001855.3450573-6-stanleyjhu@google.com>
Subject: [PATCH v2 5/5] scsi: ufs: core: Clear stale UIC result byte before
 peer DME retries
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K. Petersen" <mkp@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Brian Kao <powenkao@google.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Peer DME get and set retry a failed attempt with the same struct
uic_command. UIC completion ORs the ConfigResultCode into
argument2[7:0], and nothing clears it before the next attempt. Once an
attempt fails, every retry keeps reporting that error code, even when
the device returns success, so a transient failure becomes a hard
failure after three retries. Each such retry also triggers the
WARN_ON_ONCE() in ufshcd_dispatch_uic_cmd(). In ufshcd_dme_set_attr(),
ufshcd_uic_cmd_compl() also overwrites argument3 with the register
readback before the next attempt.

Clear the result byte and restore argument3 in ufshcd_dme_set_attr()
when an attempt fails.

Fixes: 64238fbd15ea ("scsi: ufs: add retries to dme_peer get and set attribute")
Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
Changes in v2:
- Clear argument2's result byte and restore argument3 (MIBvalue_W) in
  the failure path instead of before the first attempt. Kept Bean's
  Reviewed-by; Bean, please let me know if you would like to look again.

 drivers/ufs/core/ufshcd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bcc2512bf34b..7532fd916bfd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4400,9 +4400,12 @@ int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
 	do {
 		/* for peer attributes we retry upon failure */
 		ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
-		if (ret)
+		if (ret) {
 			dev_dbg(hba->dev, "%s: attr-id 0x%x val 0x%x error code %d\n",
 				set, UIC_GET_ATTR_ID(attr_sel), mib_val, ret);
+			uic_cmd.argument2 &= ~MASK_UIC_COMMAND_RESULT;
+			uic_cmd.argument3 = mib_val;
+		}
 	} while (ret && peer && --retries);
 
 	if (ret)
@@ -4467,9 +4470,11 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 	do {
 		/* for peer attributes we retry upon failure */
 		ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
-		if (ret)
+		if (ret) {
 			dev_dbg(hba->dev, "%s: attr-id 0x%x error code %d\n",
 				get, UIC_GET_ATTR_ID(attr_sel), ret);
+			uic_cmd.argument2 &= ~MASK_UIC_COMMAND_RESULT;
+		}
 	} while (ret && peer && --retries);
 
 	if (ret)
-- 
2.56.0.385.gd3acb90ef8-goog

