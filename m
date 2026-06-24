Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764673C769F
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311553; cv=none; b=UWTY55gJua+69tFU3ES+xoSQYnWh8Bnt1d8uhfSymxFSTSI+BX9V8574vkTp0ZoFW2tZVI4c1xWVCJ5YHnFv1YMcr30wWYCjevc1Tqq3dS36hMZCTDcUd/BZl7EhhVsodqlFFJmihXKZONkeeganPafoh9oMRUfxKoHeO8HLmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311553; c=relaxed/simple;
	bh=3jw0dPXicuYVunThsf727I5c27B62CFGeg4SsJeHGQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nA3Azm4vFvWdOL20itDhx6Eh8AJqRAXIc4J8U8usvy+6hc+4JvPHiIv1r8yh4pLBCJay0k+Bl1uilMIh0G60tml+TMRQ3xTBf5roJ3wGzB76lW+tRF/A2NGP65vOvGkMdJ5cMaULOj+CAN4FFFkU5osoBiQIhmjy/1P8r5pZDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swIF575m; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swIF575m"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8ff15af279so675726a12.3
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311552; x=1782916352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX+FzcCzMCbQ0Z1ebqZSA2AR+d8QDIytple7rfFBzzk=;
        b=swIF575mS5Ur30T/8G1gPle775O+beJTenK15aMYNhtT4sP5TyF4cxVF27Q+V/mBRT
         lYmElDpwOnY+ay1SuULYE1VMuV9Dqh4MRUCSHjf5DZNvWoXM0OEJ5UG9MRoDH93nos6t
         JMRZ5Linc3QjCFC8DVnxJreXW7DMu+Nv3gz2pf5Je90RnwwIO70fB/X7qxGBWi3Nhbgd
         bNPGGeKouofNoH8w6JrxOd/NgXD2NuTnS3VE1TcW93GKV2GeoSWA7GA6h0Ab+o2LP2KW
         Pz2QpnbOVJzm/lFmwOd5NIwPp4OMkyQdbAIKomvzc9okfcWK+9+aZZke9C+NMfaK/gWa
         3uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311552; x=1782916352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KX+FzcCzMCbQ0Z1ebqZSA2AR+d8QDIytple7rfFBzzk=;
        b=IDZZt2u+plwTH6BCbLoY1XV/o6Wx9VFpS2CDIE/FH2ZR2gvep3BuWMYdtPd/PzduJ2
         DsOxGM9nS2Mx/i7WFtXYbOgKoG0Lk478kAjK9tBwS6g3pVcSe14srErHTu6Ds7xHV6md
         7G4pntLCXt6Cr9clYMTs8HE6FjdY+DgkpZ1Upj8+tU6CgmHWGvDbfDF5L8SLxbr+j31a
         lbuuTIHyJkWmJHramvGGCk+0/kw6/kcYvqalLp1kfBdmT9OBGjmC2KXPmaXj36nMVYhI
         EuUgl8uDTmbg3/1qZOPESN2vE7yRbq68hzRaBF/B/f/PNk+fpLuHVc44mlyXchm/Fz/X
         PCTA==
X-Forwarded-Encrypted: i=1; AFNElJ+LqjhLsuufaibQe46NSUYHbGXil0xVRt0Yj3+0puRz9THVwYFeR8aHjArx2rU3NujqYqOH6Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcZJNOtSJPKh1TBdAcf37TYTfoPZDFiRt5tmvxjBND0UswL0s
	3V/SqL+MHhELm9MYWjTqr3ejxIXDHWTILf3n0XaT5r9Uff2MkUMogBsE
X-Gm-Gg: AfdE7cl7D3ntx5g8maNwb/fItvvjEbW1/fUgIK8tgrRKn8l+3Dd5qrCgyyx1RStQKtO
	cf8TUFwefAW8gBeAm60SW3H5FuYpR6XhJCC5mAZG65o59AovOpvY/tm4i+NWW6z2Goidyj9pN1B
	qKOG/vPB3Qz7pvYncDjnhx709fJx4TkhPl6LZaqwyozkjjbY7r6nh30HilhOvreJ8u8919+dIz7
	BwH8WjusmlnhlFRr7+6l9RH9ee7tpUv2vVBGk01wtL6gMfqIFgvaLMrdlFQSGf0VNe0WVQ7nZKL
	Lw6vkmenCORlNWi8OxY7ZuTmyE6/RlfAHXuIxk++imcz7pBCufhXoan5XmreuTlO15bhuH5vUFo
	zvz/wUGH9Ba12GD/XhdWxVoPl21QA90DtvMKOenGtCoZUo36GNYOqoJ8mhMnGcXAjG6EEv8HQR4
	3YJ+fLbc6ul7VmieOu1l5cJN4I9OeehNpTB80EtOvt1vV5NZKymHcgt92fHNDrTlk1gmHRaQprb
	zNFwQ==
X-Received: by 2002:a05:6a20:3d07:b0:3b4:b275:c5b1 with SMTP id adf61e73a8af0-3bd2d2341b0mr4675063637.26.1782311551485;
        Wed, 24 Jun 2026 07:32:31 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5d04858sm12884295a12.28.2026.06.24.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:32:30 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: eir: Fix OOB read in eir_get_service_data()
Date: Wed, 24 Jun 2026 23:32:22 +0900
Message-ID: <20260624143222.883120-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624115439.868817-1-sammiee5311@gmail.com>
References: <20260624115439.868817-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eir_get_service_data() walks the advertising data looking for a Service
Data field with a matching UUID.  eir_get_data() returns a pointer to the
matched field's data (field + 2) and reports dlen = field_len - 1 (the
data length only), while the field actually spans field_len + 1 = dlen + 2
bytes once its length and type bytes are counted.

On a UUID mismatch the loop advances:

    eir += dlen;
    eir_len -= dlen;

The pointer advance is correct, but eir_len is decremented by only dlen --
2 less than the bytes the field really spans (and less still when
eir_get_data() skipped preceding non-Service-Data fields).  eir_len thus
over-counts the remaining buffer, and the error compounds across fields.
As eir_get_data() bounds its walk by this inflated eir_len, it ends up
reading the length/type bytes of a "field" past the end of the buffer.

For an ISO broadcast sink the buffer is hcon->le_per_adv_data[], filled
from the periodic-advertising reports of a remote broadcaster and parsed
by eir_get_service_data() in net/bluetooth/iso.c.  A crafted PA payload
packed with mismatching Service Data fields drives the walk past the
array into adjacent struct hci_conn memory -- a remotely triggerable
out-of-bounds read; when a drifted field happens to match the BAA UUID
the out-of-bounds bytes are copied into iso_pi(sk)->base and become
readable from user space via getsockopt(BT_ISO_BASE).

Keep eir_len in sync with the pointer by recomputing it from the end of
the buffer on each iteration.

Fixes: 8f9ae5b3ae80 ("Bluetooth: eir: Add helpers for managing service data")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
Changes in v2:
- Untab the commit-message code snippet to satisfy the gitlint check; no
  code change.

 net/bluetooth/eir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 1de5f9df6eec..a55696820b22 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -369,6 +369,7 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 {
+	const u8 *eir_end = eir + eir_len;
 	size_t dlen;
 
 	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, &dlen))) {
@@ -381,7 +382,7 @@ void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 		}
 
 		eir += dlen;
-		eir_len -= dlen;
+		eir_len = eir_end - eir;
 	}
 
 	return NULL;
-- 
2.43.0

