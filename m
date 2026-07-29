Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349638B124
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297517; cv=none; b=atpBYB5r29YmJ5aiRRFIy8RCN9DRSGCj6IsT5VfXzj+UOG3W0q/4G9ecQupw/uE0VTxsb18WYGODIWub7HcdgsJ+2wZRe1tVbUsTT7dJeK3+U/UJGAJ+kZ/0bKoCMEWIMtM38qAXHYBr/G0Qq2Wn7vyftdgMZaB4QTByMdC6GQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297517; c=relaxed/simple;
	bh=BW5oMf9ZJRxwbkqXuNsf1TnG0yj7BgcZXckUGlK/0nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIKc7wAKrifJSfsQJAXu7/uhWyitDc8q4GL6D3khsCwJPFKPkP/hcU14hMzsbn8rTxMrJhFWQ4czFCRAGkGSOxVTqepmFAlHkR+sCwMq5Y+upCKC7EASpwj1mCwWjmKnHX+3JmgnzlLBDj9Ru+cVZ3mvtnbUrboSAhbgZlSLzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DgqxAMeE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgqxAMeE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so332757a91.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785297512; x=1785902312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AheFru43gQWGPPuujNoti5N0XT3IQznbkDZJX2JAMsM=;
        b=DgqxAMeEiglMoBjdGesMOJ24WYfHxoHC2a/6cfFSnkhWaFyZA914mv4MWmRdTwndq/
         8RnNeRtfhIjSCNcTEjF4qRcLMe0a8X2Zu1+38yNz89+X8+GXfspoddnFWcy1sSNgvblJ
         FT91M8r0PTwyGv5XKZRpr3fBpRwIZqL0BstWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785297512; x=1785902312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AheFru43gQWGPPuujNoti5N0XT3IQznbkDZJX2JAMsM=;
        b=cjbn5072HlwmBqp+vinBR9Bihonb9zAN12WeDh1db2AjG2ApW4NwzZd/d6z0OF3ZnM
         1VMobr7/GVR8lQwY6kS5iJiIFdaCMPilic+CXgmQ/VqWW5/xGDrvo4NH29e9yNSkDpPQ
         VzMiWx7vM6esDW/gdmYweUPYmLbz7eyR3I7hl6wIzBx31GYgRidWfhCgyBxg/Oi336oo
         UDwM3E2MlLHOAh0ggrVpRXL1TGEYuRbjz6x+FDhCRtZM5AIfEpCOxzqZd1QiPhKKb1nH
         JFyBmy26ObjewDzfgH6SzMH9+cr1xJ3mttDN/ph1ZBoaWWij8oDyiTMY3lWNyjqHrTNb
         8v/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp7P4y9Zo9GHkTgR7skaFFom4cEbeWbbYKHHgs9RtGj9YAkzbxA30441xQDKKZmB8JQLwtLUXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgrUHP/5G2CgypoBMRWrT4dC/skKJwk6zTqzTYoCga3P5aHJG
	XgiPOKFN+TFGfI8jyd5RSnRATNEQQcqQfp+IQtwunNEx7MOLBTJp7KH4FPeptbVucA==
X-Gm-Gg: AR+sD11x4yDBV0WgPn96T1+ooUoBj4OybqAIpQqpPoGXAm8ysv/LOLFGUHnCKT2mpCc
	dIFbJW0hN3+aVgselhq9fZYrmY0S7I7etTUAn6rXTbvSBef5AVkyFsnMP+vlj5aHQ8lJjnQV//e
	A/tmkdwPHLwYoTpZwGwhKWVLD84flVxOgaaBuwmdwO9/11F0xJkbHMUOXiaI2bwPYq/0JTbZJoI
	TxJR6s6EhWvFVyFXW/nXIXdYzTw3FPyCuIrfRUGoQC32Ash+/tcV1hxPopCPEO+wGWwSbTum/8c
	QwM4dsJOv9H9+/5pqoLqSqF7fhOVf1hRz8GPxYf12y+a1Z5FFuSnJPfvgUB0Um90o17oKC9zPfP
	cSgI2JYtursM1I9PdAwgYIQwRXABTNGTPChrRzGo8sJNVE46BRelJbbhLTV1s5MVrhlsKGK6DRq
	icAxFE2p19xAHAXgwzXyMMLCDUiIrbXjvhljlHZNVh0f4UD/hdmVPOwpyp4kMqyUWo67s67mED2
	C8AT5j0NGdLylUPFmSfxT70mY8L+j0BBklnTyx/X2E4rQ6M5GE=
X-Received: by 2002:a17:90b:270c:b0:38e:5e2:6dce with SMTP id 98e67ed59e1d1-38f6a5aa922mr5609043a91.39.1785297511770;
        Tue, 28 Jul 2026 20:58:31 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7eef9c5asm722087a91.0.2026.07.28.20.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:58:31 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Haoqin Huang <haoqinhuang7@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] zram: validate deflate params
Date: Wed, 29 Jul 2026 12:50:33 +0900
Message-ID: <20260729035820.751990-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729035820.751990-1-senozhatsky@chromium.org>
References: <20260729035820.751990-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must validate user-supplied deflate winbits before we
pass it to zlib_deflate_workspacesize(), which triggers
BUG_ON() if winbits value is outside of valid ranges.

Fixes: dc75a0d93bd5 ("zram: support deflate-specific params")
Link: https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang7@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_deflate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index f92a52a720d1..729ac734dd6c 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -24,8 +24,14 @@ static int deflate_setup_params(struct zcomp_params *params)
 {
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = Z_DEFAULT_COMPRESSION;
-	if (params->deflate.winbits == ZCOMP_PARAM_NOT_SET)
+	if (params->deflate.winbits == ZCOMP_PARAM_NOT_SET) {
 		params->deflate.winbits = DEFLATE_DEF_WINBITS;
+	} else {
+		s32 wb = params->deflate.winbits;
+
+		if ((wb < -15 || wb > -9) && (wb < 9 || wb > 15))
+			return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.55.0.508.g3f0d502094-goog

