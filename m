Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AEE43785F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140847; cv=none; b=GUVjc9bD0EyBl6BUdju926eK6c6YI6tIELyWeErdJ6T/qHMFv2XS9cUGm4TcxekgZIHSEECbG/tu3YdqhkWGyXNBJ5UmeCdZ/0zSJtgVkZiUVcsXxjN/9POrdyO75PVkePkOPHNjAx1MZj6VaJDuZFXitzo4vkAA1meJ3IvJloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140847; c=relaxed/simple;
	bh=ckYyMbA5qrVV29KoZnji8oimJR4kycs/+N+sm5Vfj7M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JzhCbHNeD7vgmiodvj7AdS0GIMi9N7JCwWpgWNTinQ9CiawfjZifIMTNLlu1lWGvuaaWKcw8T0aW9BseikXeIROiy0itIonnBbrxlNsx8vYLE2/7iK1oKJixdWYmVcAgEGaIPACz+DLhpBAfm2WvUbxli9I/Evd1znQLWC6q3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pphm+xz6; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pphm+xz6"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso6506112a12.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792140845; x=1792745645; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Myy+1U6pBdwhlVNx/zaVSdE77IqnEToPWj67mGod4c=;
        b=Pphm+xz6+oCXoK7ewS5K7O7AsWpHOFl0jIFPLCQkzq8cJ7r2AaoEkslVF3NjCfP/Qi
         VEyj6goX6fJruFL6HgUjrndINSPWM8o31VU7scE01nVZ0B33rzoVfefu9aDsvSVNp24Q
         dzQL9Umg9Qm5RpvWFF0uOyFnNwnOdRULEfV3j18ty5/1Ann9phouI7pgD53N3obu2diY
         EQLFGWvQEmy/8fgrAlHNW+hO5vtJngoSH8DTv9D5IcqczBc/36LU2rarAaA9q0v/nCdR
         93Cs9YvlFVMdsTC3gJHY+cXslwsYYLMIcwyZZHusTAYMn/kwwibmKNWWtrlCPsdPJnUU
         3dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140845; x=1792745645;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Myy+1U6pBdwhlVNx/zaVSdE77IqnEToPWj67mGod4c=;
        b=dfH4DvW/18rySJ/TTFTC9GQKEi73A9I70OOcrAYj6mPwjycGJACtCQ40tbAnezhTTu
         oVRP9zCr2MYJHu6zsCVeUV2qp2vDfWeERNRmhIqK6UJfE5UoacgJWqk9JBihwBIHFJea
         9QSqTEBaNv83/4PuZK+XpxYWmOQLkCaN19OrbrtNXyhNRR7cCktDrPu11wZEF1arOUhR
         T/seNzoxmYhmkn39Hkk9Ytv3aJldPOJ95zJHUA/Rzy6p2TL5YucA+X6nvP6ctpZO3HU1
         1+UPQENlhxHVbQue6bdgL2NB65fzJzY6gsgvP8fijXbE4dETFdpbDTnSYpqQWYGMSXTF
         0kLg==
X-Forwarded-Encrypted: i=1; AKwUvByzsKVbZi1mILjW1/ECvyhrS+9oiOtiunwF+FP2F/wiQxk8e3DmpXaYhZw5cWfCwk1CH6D3PhI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSuNNDnNc/3EmMy7E8xb6/B/3ILNBb3sriAjkM3aZCfRDV0qPJ
	jJkEXtgg2cw2je+nGr8WXbAnxneT14/pUEWo2ylqD7MvlLm42ZsWpYEH/b4SCH8oMh3UmXOaW5C
	gvUSLhyu7KT6D19O3HyBD2A==
X-Received: from pgbj21-n1.prod.google.com ([2002:a05:6a02:61d5:10b0:cc7:a1dc:d7e4])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3284:b0:3e0:c346:7344 with SMTP id adf61e73a8af0-3e16befe897mr19741849637.64.1792140845040;
 Fri, 16 Oct 2026 01:54:05 -0700 (PDT)
Date: Fri, 16 Oct 2026 16:54:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016085403.1711740-1-stanleyjhu@google.com>
Subject: [PATCH] scsi: ufs: core: Fix double completion in ufshcd_clear_lu_cmds()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K. Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In SDB mode, ufshcd_clear_lu_cmds() completes a cleared request
without clearing its bit in hba->outstanding_reqs. A later
ufshcd_poll() sees the stale bit and completes the request again,
causing a double DMA unmap.

Test and clear the bit under hba->outstanding_lock before completing
the request, as ufshcd_abort() does.

Fixes: f18fac1e2b72 ("scsi: ufs: core: Rework ufshcd_eh_device_reset_handler()")
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bcc2512bf34b..1ae63d123ef0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7943,6 +7943,8 @@ static bool ufshcd_clear_lu_cmds(struct request *req, void *priv)
 	struct ufs_hba *hba = shost_priv(shost);
 	const u64 lun = *(u64 *)priv;
 	const u32 tag = req->tag;
+	unsigned long flags;
+	bool outstanding;
 
 	if (blk_mq_is_reserved_rq(req) || sdev->lun != lun)
 		return true;
@@ -7961,7 +7963,12 @@ static bool ufshcd_clear_lu_cmds(struct request *req, void *priv)
 		return true;
 	}
 
-	ufshcd_compl_one_cqe(hba, tag, NULL);
+	spin_lock_irqsave(&hba->outstanding_lock, flags);
+	outstanding = __test_and_clear_bit(tag, &hba->outstanding_reqs);
+	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
+
+	if (outstanding)
+		ufshcd_compl_one_cqe(hba, tag, NULL);
 	return true;
 }
 
-- 
2.56.0.385.gd3acb90ef8-goog

