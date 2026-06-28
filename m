Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38472282F10
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665211; cv=none; b=mJwV8uLxYr/ut6bx8/WcIZFjFuI5jkaOKnqyqHkw9S3ZsPGB78Wa5X2LUd+FIwtsj4RhIv1oAZihXY38dtRUnncSbzdMiJdi49K0fKG9xZnD3+f483DpPuzOQ3EvykpMQjES+orBmcXS5ymw2107OgrBQo9aJfv2rBvjO9Cl3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665211; c=relaxed/simple;
	bh=H12shJ3HB7mf8AuLEd/viE9gKwwN+PYCULrOQyf53bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwtrISIRGetST2veMrWdIZ30PCTO/3r7OH6M2n+2EalL+soOfMSnCCjGzZDrJJsJlbWCgyO/4ETUBitaI2+iJhYC3CmH/Qm3CxSYm6QCYVnQSWxVPUa9HcnhE+7DXagNFEwsHLHLe5w9RAZ6PM0QmhqZsZEDrIusU13LssnsL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoUXdGtI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoUXdGtI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493a285ff0cso3828915e9.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665209; x=1783270009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzAFh70BrQW/5qshjiSX3ckNto34Zub+8TA4deGg+EU=;
        b=KoUXdGtIxL8dY/7ppoAEktFn6I8SNXb1WtLf5436rK/e00hslV6eNpCi6mehOF6qyG
         vq6/OzAayeRb1iCkJbH/56egf64BFAfnGXYz05B6X7MvyQklWz+LDUavGMgpdtFZIng9
         oQbjVlXafoLX9WnRlRkepb2dLgUcOXhluWQkzbmECZPuWnijoGjgSlW94uydThxPvWzU
         u1Lp/gIJzMEDCxOd25Vh8e3G+MapPcRNQP1bNxX3uPHG5S9khxyQMk+VTJcq9BWdBPgk
         OuGeNQpcpZOzRXmicAQkv087xMpRZXflxidQTO8pfwKlUD5acjPO/tHfEA62Hjs/Gldl
         7P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665209; x=1783270009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzAFh70BrQW/5qshjiSX3ckNto34Zub+8TA4deGg+EU=;
        b=Q40Y9M4KXNS0uSbKitBdQNuyZeQS5FVDYKpS3WfowINEmsXQ86su2nJqvFtIk2R92W
         FDA7opC7AWNEpxR3kIv0vGsLz9DXR2lJubWoVLukJQ9sodH0PUwBRlUrkoAE08vVPHWj
         UJW1Z4QGWtw0IvPWLuODPcQo6ZazWvHOCdvttmkRSU5/fWmV95wrU2+t86Mi1OJutBr6
         v+TSlX9JwfBBDYqSRXPrqvdFt7Ti/1tyvOPFtPPSl2QlA86rtGENF7KcUs3v6EOyskQd
         51hH9cGvQy8lP82KtAdpP1qKiEIgWFpYZJdFHDbAuVfjvr1ZoAzk9GXKqbVOgZiqVdCd
         pd1A==
X-Forwarded-Encrypted: i=1; AFNElJ9rLbia+JcqogAV9rWNKCiCVXdtrVaVvcOXI/36FbNxMt3yBoAqHwbAn+YijkFICPfyDNiOhYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXObrBgxlEIuOLRzFXq2P+RaCle38okZGGCX7oKP+tA8qft25I
	Ab/K2nB0aCDOEoKD+wp9V/o31LtBc35U8vI078LELME2uGZ4qgpSWp7wS1SCURbjYqEqNQ==
X-Gm-Gg: AfdE7cnTzV9ghbW7Jc+MmUweXtxWPiJNedpsiumOgZrDmw7aqll31Q0rRtWjN3vlKCf
	MblAYtuPizrM/XmQs/88tB+FE7e8a1rjoEW7wvf0QUdgJDVWNBvBNU/+l9pG9p39zLOMAI6OOgq
	lfm6pLkyqqRIPgNWc9hDcs5k8Xsc0PiaEw0RZoYw/5zJQqCkbYhTyJpIm9Xa76hljFDxWzq/ist
	x0jB+pRzupx7hudBq+IvqYh65nOHG4haJe7AmdtEBnM43fNTEyz9FMuHbKpUAce1FrtuSDFugue
	wuCQRILhiDnT1oMvgslf//n1GwIyuIjpXz6ZsMdaeq22b9d8lnmoiWa1Nh+t6dvxs6+8kFlAGFx
	C0Xa01kcJRyBpa74miGJiZ0VC+BfviCma3REbwyYP6wbPnvNAl88wAcgFSOICcF4PdaDhqHGg1A
	MxoFGmbt2ErOqTOn2OToMvRfwIbQ==
X-Received: by 2002:a05:600c:8283:b0:492:5551:19c6 with SMTP id 5b1f17b1804b1-4926683b0f2mr219586205e9.7.1782665208544;
        Sun, 28 Jun 2026 09:46:48 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:47 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 1/6] HID: roccat-koneplus: reject short button reports
Date: Sun, 28 Jun 2026 18:46:06 +0200
Message-ID: <20260628164611.17467-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Koneplus raw-event path casts button reports to an eight-byte
structure before updating profile state and forwarding an event. A
malformed USB device can identify a shorter report as a button report
and trigger out-of-bounds reads.

Require the complete button report before either consumer sees it.

Fixes: 47dbdbffe15b ("HID: roccat: Add support for Roccat Kone[+] v2")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-koneplus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index f80a60539a96..e0f35251e81a 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -523,6 +523,10 @@ static int koneplus_raw_event(struct hid_device *hdev,
 	if (koneplus == NULL)
 		return 0;
 
+	if (data[0] == KONEPLUS_MOUSE_REPORT_NUMBER_BUTTON &&
+	    size < sizeof(struct koneplus_mouse_report_button))
+		return 0;
+
 	koneplus_keep_values_up_to_date(koneplus, data);
 
 	if (koneplus->roccat_claimed)
-- 
2.54.0

