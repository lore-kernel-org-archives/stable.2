Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61D36194A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828965; cv=none; b=nLn9/3tKAgsZoE2S9wPmooYnmItPQn76c6X1S/tJpVf6mH5h1dsoLmHZRmkq0pyUIdJMPW6WKUNNBv++ClAPP9WXMNLDlGx2T0xB9+Nr9WhvcLxXIC+PDKV5YIpeWtxCKFfrCcpioB10uC+A6QyRwQ29dzi8pnVrUx5L9rjBETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828965; c=relaxed/simple;
	bh=exTnfBbobbuTKp1u2b5AtcOE9fa31gkGpbomdGBMpI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HknU8n5wNFKIPoOrkUMkqzXi/IV12yoE8ZsXZV0sqAie1oKAuX8ScU3nfD5y2/xUmbV1NVEwc4ErJz41xVJ7maibTFfzGwtUPvoOJKBsKnJc/woXhL3CLK/MN2vlQC5bjQ4jpYhRPyfOuoea4a8yyILfyKobSH/pJuxKHlokPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGo0ozm0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGo0ozm0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84830c774a0so1192011b3a.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828963; x=1785433763; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sIFLg1zYJZMoKAp4r00Jfyq94TfQcukLRikqEzkbTLo=;
        b=PGo0ozm0KE8bCnNutL05ZjyLNZawPe9eR6TYdDXZf4DHsaYpF4OFvqjucRzmii/W2+
         +maHJWs+C+RUaqfKfU648Hv2EwPfq1A24nB9mOMgiAZYjvPBZOUHt9+7nIa7Ej/Gp4ME
         I8c1k51RWQIg+PJq2RRc3NaQzHpomB69rCY67UuZNlPl5tdotqqRdDAcYM09EkeP9tvh
         6LpVxFv0UdBDYQ4UmJIWpthz1v9i/3wf6duQbVlqLG/2YKbilDuC3RYVbOMYWIx44Q+Q
         +hkk959jYbOyymaT0bItTeYhWoFGMYnJ3eP9k5eKueToCBVwoLwRiqgs7lycid5YjhRW
         +iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828963; x=1785433763;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sIFLg1zYJZMoKAp4r00Jfyq94TfQcukLRikqEzkbTLo=;
        b=nVYYKCKpn2zVanBJqsSNHDb26T9Nce8lsN3O/ikS7W5sSLfR17X+8zhJnnAJ2WlB4d
         LaARFTUfb1N0L4ad+4MIGt/BvwTNOZHeVwncUF55PIh6nyO3ULaAgYccRCz6qRhHto9e
         qV+jTtY6ND8xNRcpHdw7IqQOGf6L10n7FdoI06frX1KPaNxkQRv19YfZKpsgfi/FQjHX
         Kg6ruJGw21WU6hb2jlH6UVV0j9p2wIuZvnOlVeqa+whmiHtBzhax/aD3AJqge5zbCdmQ
         23GOKLJ1f3lN7U5LKAJj6dhRH1ULnLjDnLckDRtUAYdAQC1qrpHnvjiWhbIGUtGbiaAN
         6//A==
X-Forwarded-Encrypted: i=1; AHgh+RpRtE/m0hvLok2x2saWo5ftdyWmV5+Pi9tj4KIIJcCm9iSMeOOWjzDPPOptscuAnSxZFh83fAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSG54dDaNFLhwXQPbHriLuGi7sjVdnGVWruSRIk6ECcoH9BZp
	75EssBLaKons/Bye3F015jVdXy1+BV7m8+tD2K2xiaiDfW87SSR47qME
X-Gm-Gg: AR+sD11LEHmOGCrPwbw26GnQz/J45xTMkWk4nZqoN+yXy/fsK8EqQ74MQqn7GN7koj9
	vzOZtIwJ9/EZSgYnQSeGyFhbqA9bHmJUJClgY31N11qRczxU719dFaPfe0OWjkStOk4aKqX5nCQ
	LIRfet52p70vlup8Ebrpgho+UcIEt1tavltpqcUDVHbViaO/0TDNDAajVyN9L+BMjFd5rYDBNrt
	dWY0hUa6PhxvSz8NXW/WGgLnVDAU5dWh95Q1tI5cXKI0rFDj/bFTzyrxhLmBtzwI3OHE5NsAKXg
	vS2QQl4HNGZ+eEnXv2kJM0R3o16VjYNfo+fPSmlzq6Z9RcRnFQkRnkgRus9YwPaRxyGBD6ayla5
	q5MyL3LqckAJDgwZ1rjYUdu6BLQj5xGYo3q4rf1mRtC5/ro4ERYKd0pggKhgUYW01sd7GADL7kZ
	FZ8MUkq4k6ogjD/eiACh9fnxr0G5zFdifnMX7Wv31UC3o7YEvF0B1gZp2sZns=
X-Received: by 2002:a05:6a00:3d12:b0:845:d6a5:716b with SMTP id d2e1a72fcca58-84e2b8bf867mr4669228b3a.23.1784828963497;
        Thu, 23 Jul 2026 10:49:23 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175f31b3sm3493036b3a.54.2026.07.23.10.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:49:23 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:49:02 -0700
Subject: [PATCH v3] drm/gpusvm: Zero HMM PFNs before scanning ranges
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-drm-gpusvm-fixes-v3-1-4346a61d093a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA1UYmoC/x3LMQqAMAxA0auUzAY0glKvIg5iomawlgZFKN7d4
 vj4/AwmScVgcBmS3Gp6hoK2crDsc9gElYuBaurqnlrkdOAWL7sPXPURQ/Y9M88dUeOhbDHJH8o
 1Tu/7Ab0vemJiAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, 
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828962; l=1598;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=exTnfBbobbuTKp1u2b5AtcOE9fa31gkGpbomdGBMpI4=;
 b=ndvajkSdPCoDMCJTXGf2I8MdXQUSYNj4q4sKROa4o5f9YHhrv0ejfGLg9Y1MTB278wnpXqOLY
 I0x6IvfsVSqCCoDKy59Y5h827Xrt++JRfwDHNHXduAWhf2J16fAQDNa
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

drm_gpusvm_check_pages() asks HMM to report the current CPU page-table
state without faulting missing entries by leaving default_flags set to
zero. The HMM PFN array is still caller-owned input/output state, and the
framework may preserve input bits while filling entries. It is not safe for
the caller to hand HMM an uninitialized array and then treat entries
without HMM_PFN_VALID as an authoritative unpopulated result.

Use kvcalloc() for the temporary PFN array so entries that are not reported
as valid start from the documented zero state. This prevents random stack
or heap contents from being interpreted as HMM PFN flags or PFN values
during the scan.

Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index b946f920b7a0..52573626387c 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -708,7 +708,7 @@ static bool drm_gpusvm_check_pages(struct drm_gpusvm *gpusvm,
 
 	mmap_assert_locked(gpusvm->mm);
 
-	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
+	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
 	if (!pfns)
 		return false;
 

---
base-commit: baa47c6547b94a164b70924e53d2bcf16f483e6c
change-id: 20260723-drm-gpusvm-fixes-d97ddda62219

Best regards,
-- 
Stanislav Kinsburskii <skinsburskii@gmail.com>

