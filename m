Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E53D891C
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792226655; cv=none; b=ErVCMULwXSqAZdD1idkYCjGNPiyYasyifdiWP/NnPHxILZ19IMgTanWsiwaB26lWNVElsc/zSnMLq3El9TwzKwIPIQEiiLcs6ASq7VFrVIbneVmy61BCVuvw02RXUehYzWBT6sWjOGp/ZkWAAwfya+BXcUZo7KjKdOS2kthQTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792226655; c=relaxed/simple;
	bh=nNGZPxGajGScZteR3AEZleUpWmZWOj/MZH2azt7bWWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DXMDnGRqTSPLV9q+h/WOlSExl/f9gx2JjJqdO5MCMUnsfWBAwMLLIVazdhhCayyYrhTSE40Lkj7poS03Bt9lrDlzNCfR86hZK7J+04TrRXNUIk9qQOC5WcGidc9jZBNRl/eQ51lnHfB+tXQrE4ZmhddFN8dSKRNrGAuGL1/r1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJmz9R7H; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJmz9R7H"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso391768a12.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792226653; x=1792831453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RI1tfjYq23KVY/xwmwRN46w/ZXhzGsWBQ9x8Pqo81Ko=;
        b=HJmz9R7HMUr7X/YHzUggWqLdS40g6ctPqSNDNKVOK6aZCZnR6B94+xk3xpYQsax1or
         Z3Zfu2dT2pOWeyim0tc2faT1/lOP0JBld/6Sd9u8mERrV3pbMP798EXjegZnINYyIzDd
         jlnGUlYBQBJNrWsEydVzr3cJMpxAjSiGkn7oJraAkaQdjj0CwmjRlumltUeYb1C7ul5i
         FBJT/so/hzNmsDY8JH+zIIONxwipNwviQG39aJH6Z9FYIATDYZKm+Vy8GjGPOJkOxXug
         lYzWPMt4jd6sb4ftzcqCFPTmsNqFn3qojHBnv4Ul+YvVKgi/clPoVbmB/O7kSbiif03F
         souw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792226653; x=1792831453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RI1tfjYq23KVY/xwmwRN46w/ZXhzGsWBQ9x8Pqo81Ko=;
        b=AX5GOAJ7Lb3geg8LWgr3zr3TlX40ECB7UbznZ9UqalcF5FYaEzLpKxh0W0zgnRZXhD
         /QBmQuBgSfdv4KpqWh/wlMy5/qeSlEjaz+nYxJsvw06IxlkcnYmcIirseBAEWheBGx8I
         TIpMuW6qw8BIMLnTdXnnqTqLuyQmWezS1i8NX4K556d6U+qUk7qryuITWpMzQMIz2Ypr
         1tr77RwvWU4XQATenNQOIkr/pWZj09LNxxR9RqbjDIO+q8UUpjcbODThpYxegE71mJJ8
         wtJJk06HpXweltP3N8XZkw1YKytHUzD0en1+6fhQ8zap/6UlmTaQgRJIROtPXe8UgCAi
         tU4A==
X-Forwarded-Encrypted: i=1; AKwUvBzmiODbrMHLddIzNw7B/KbZ3RcGI/kiMU10v/wsc+bq5W89wck6GnGSNEHoUyCQKRKj/XoFmOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJY8ByxKLmHYCWl2++XRNmdSQM5LNQgvu5gIgdtoA9G0qJpUwFT
	PkTiyzCuFHeoGeGEHjJ0Wsuwx2XTzzgxLGru9k+TYEyq4cQl0YjsJ18GHNyeCE//JGVx7+ldxtO
	gujmYAfCLyy+lFS2pfB7Oqg==
X-Received: from pgcz8.prod.google.com ([2002:a63:7e08:0:b0:cd0:bb2c:3923])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:244e:b0:3e2:799:f2dc with SMTP id adf61e73a8af0-3e226080597mr1399659637.40.1792226653445;
 Sat, 17 Oct 2026 01:44:13 -0700 (PDT)
Date: Sat, 17 Oct 2026 16:44:03 +0800
In-Reply-To: <20261017084403.875420-1-stanleyjhu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017084403.875420-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261017084403.875420-5-stanleyjhu@google.com>
Subject: [PATCH v2 4/4] scsi: ufs: core: Remove an always-false WARN_ONCE()
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bean Huo <beanhuo@micron.com>, Peter Wang <peter.wang@mediatek.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The WARN_ONCE() in __ufshcd_clear_outstanding_reqs() can never fire.
completed_reqs is set to mask & hba->outstanding_reqs on the line above,
and hba->outstanding_reqs cannot change in between because the caller
holds hba->outstanding_lock. So completed_reqs & ~hba->outstanding_reqs
is always zero. Remove it. No functional change.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 44e571757535..716dab2352e9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6059,9 +6059,6 @@ static unsigned long __ufshcd_clear_outstanding_reqs(struct ufs_hba *hba,
 	unsigned long completed_reqs = mask & hba->outstanding_reqs;
 
 	lockdep_assert_held(&hba->outstanding_lock);
-	WARN_ONCE(completed_reqs & ~hba->outstanding_reqs,
-		  "completed: %#lx; outstanding: %#lx\n", completed_reqs,
-		  hba->outstanding_reqs);
 	if (from_irq) {
 		/* Do not complete polled requests from interrupt context. */
 		ufshcd_clear_polled(hba, &completed_reqs);
-- 
2.56.0.176.g3575e65682-goog

