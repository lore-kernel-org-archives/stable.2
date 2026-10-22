Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640693;
	b=KtrpZJoUj7dUkK9MM857DdsprogxhxMp/R+p/bT6u2DDFK3iWpVVslCpXbbH1x0Z9J4X
	 3JKquAs6phxpXYVShqSLtquVGKVwMjKM1P/AExNeAbqtA6LgDYignQn+dLQLcRPpOYW3/
	 3sSroz4Imv7cPfdlXEbPL+QzggZlrUYOZUtUoVN3FNGoYJT4IJ9n27ibdpLaEf8gdyLbs
	 Xz+lwgTq0ysRRzRcjklasqF9EUhcU+1qmFG2Bv7wY+meDoNf5ehGlnv7GzFByY3fJ1LbL
	 ZYyF6Bh0NhbmTqlnBvTsWgd4/gioJs5+X7x6xUQhElZTvc7cACvah+BqFFBhucg31SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QysHKveO/DaUTR/+yTGHWsUkdc+eQUjN9l+8Og8ZM+o=;
	b=jIr3eJ312k3JWFuUql+d17hvYjut10dvcFopNqH1mTH0nT0XfsfQFOpaWnbWrYr1q4mv
	 HVr8Or5Ku9K11JnIeKGiELIHexx6N4/DM5+uzjYzSzDh3Wf51+FzksTRQtDybNwiLYbWl
	 Urhi+v/pIJtps4ZozRqisASMEW98067J4dSCKzaLfeUEMctdaWNX271xPyaF1KIU/dmE6
	 3Z1hzPAWAKfVFjx2Yc7jOB/fEZItxS3Arqre/WEEi7Wtj+Q/wnzBZsP6Do7b12+ShkelB
	 Yth/Kxore14s/GhUpynxsAVM0E1HtOOsOG5HkfLFg6v6lUp3appYiurUyy8Fp+Yp+wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="fuf/+Nka";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A4606A332
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B45A4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fuf/+Nka
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd68bf391e1so853834a12.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792640687; x=1793245487; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QysHKveO/DaUTR/+yTGHWsUkdc+eQUjN9l+8Og8ZM+o=;
        b=fuf/+NkaZQep/4Dm3Bg0EttWWWZKtCXjz1Bs2Hzhxd1HMvgjlfMN5iHvd/uMxBUKAG
         8gXExvEgAUfElOkB2pA4tDmZHy++9uj84uc7Iku+4Gy+YhUuUP+GSuFMxACXLmEHkBcL
         4RpxuDkr4Q5xTNduhcLTFkfmYoGWd6lAmgL2ziWsJv/HSOapfQS8KUGnBY+vYUoRcfr9
         Pk5u5YILLBrQxiqRbU2GIpPSlH9oSWgT4Bk9l7x4U5SXCq9mxKUzvaNB9RpBMwqT6Q8i
         f6VNJ3F9mUMEYLKRWXBzZ7RJZK3q/bjSkgdqgel4SOgiQGMxPz4ivRINqMoDyk54hCg6
         FzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640687; x=1793245487;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QysHKveO/DaUTR/+yTGHWsUkdc+eQUjN9l+8Og8ZM+o=;
        b=0cG12LdkiwmpOPmILrbAQkmQr1wZ657TYi8LFJ9AZcN3okUA79VH3kvt5hR/nwOQZk
         fKt3nJanzJqKl1MugoaA/5VYomV2EXmj+0vPwcJW6/VK2R13rzC2P5do3w+TMylpLRJg
         y17mtQ3nvYYrkWyrTD+BH0mwSEWynAoiKteUx/egXWhIAselMt+SL8qabiYrBAIbjQjX
         KSq3oTTY2Vx1OORoqcP4t68JCHB2sYVpejDqHnaijhdLfQZ3WTPd5zm1kWrH9N91App9
         cjViyGzJ8rBrZxQpJukBwRCJhiNxt5vjgfQVaMHzKpIv8PVUksmollbl93RmqN7Z4oRk
         DRdg==
X-Forwarded-Encrypted: i=1; AKwUvBzHsutxWr0dmstDSo4xxInTXyKqCMpA+JdvMRt/E4ObExHxmBZ/ZdBz1VHw6XmJRb+t2/qT3J4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdsVnKD2htmjborZHeWYeNQGqc/fFyF36oBTewOCDO92tZtJr+
	6Y+MwQS1d12E8OGL4CddJm6BPk4w31SkUph3Zl910uDun9i0rkfAYFohI9QL4HJvcic3/VJ/0TH
	/5Qw44qAO+b4ilkf0yNdljQ==
X-Received: from pgbx7-n1.prod.google.com ([2002:a05:6a02:63c7:10b0:cc7:97a1:90ad])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1789:b0:3e2:1922:c13b with SMTP id adf61e73a8af0-3e287ee40d7mr2467505637.60.1792640686752;
 Wed, 21 Oct 2026 20:44:46 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:44:38 +0800
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
Message-ID: <20261022034443.3034432-2-stanleyjhu@google.com>
Subject: [PATCH v5 1/6] scsi: ufs: core: Remove an always-false WARN_ONCE()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The WARN_ONCE() in ufshcd_poll() can never fire. completed_reqs is set
to ~tr_doorbell & hba->outstanding_reqs on the line above, and
hba->outstanding_reqs cannot change in between because ufshcd_poll()
holds hba->outstanding_lock. So completed_reqs & ~hba->outstanding_reqs
is always zero. Remove it. No functional change.

Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index bcc2512bf34b..12aafcf1f9b3 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6072,9 +6072,6 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
-	WARN_ONCE(completed_reqs & ~hba->outstanding_reqs,
-		  "completed: %#lx; outstanding: %#lx\n", completed_reqs,
-		  hba->outstanding_reqs);
 	if (queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT) {
 		/* Do not complete polled requests from interrupt context. */
 		ufshcd_clear_polled(hba, &completed_reqs);
-- 
2.56.0.218.g1ec904b173-goog

