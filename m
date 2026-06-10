Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AC175A68
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096246; cv=none; b=MXfX/Tt3nonfO2Y6WauSsL5CPgTaya3Cpk6ETY2sLvpA0wiI/e5Jd8h3YybIPTAPDom24xGH6YX4ZLn/+r2+4BvMV9KGBuJaSfiZa70IYTRG8BYQQR9VCMsq01/rcYFL0KDGAbqJ889OIT2StBmGJwM9wNZmS8tRGqHD3k24JEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096246; c=relaxed/simple;
	bh=6YA9f27qh9mxNMJTy0t4qFwBEHKoclJ2oyWrLICkyF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+TmizhctjFBf850/mt+Isv6gBvpObis4SKTcgHipdU7P5c2NlC8fXny4lSOyRetLEMxYNvzCmCNhuXhyfL2k0c1d4NK0bXiqoaxC2d0Hz3jyVHCbxIXJwM1izWv5q0w1vhnY91ZQFeGtkfVL1mVYDo1oY+HyW5WaxmiuEOSXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pBSI4TWs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBSI4TWs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so43720375e9.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096243; x=1781701043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5uqsocWiifn9fI4qO/LPuRHJe9fzJpovNTdwKX0G8U=;
        b=pBSI4TWshHy8z07GkK8iUK7BKMvUWX9HIEvO4tsOnWS6uRIi+8B3+j7t1X/B47JMTj
         NygS53LOiDkCpo/aBGuxtAIZqqpLmPoVfd3iy0kAKCvMpDFc/Olc/9VD9++PrCiHuWMb
         xsRL9JbYXlF64fR1Cz62AliOJmKJd6lRA2n/d5ufcQ7grxKFnvq4i/zDLh3swOR9dh1X
         i9Ae3iLjdDds0F08Dk4h2nI1EU9ta2zVhyf8vGOXbn/XdxpMfbL/++ki+TuvehfNjLVs
         L6yjTghPwb2XAAQ/qKkxxhdWi3wBaZiTpvXb60DVgbMLmxkeYKohd2Dp3MzCDkNX/lXy
         Wsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096243; x=1781701043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H5uqsocWiifn9fI4qO/LPuRHJe9fzJpovNTdwKX0G8U=;
        b=MtHGqETo7zLlVicp0nImm5WXGuoeIFrIxWaztEOyD2+8TFLYIPqnVP3eYy+TF6szKl
         dlA2td1+ALqgbJKft2RTP2wybeG9GGnikcUPRE5rQiWf13nNRWZYnQZN03WQapALZOuf
         UNASJucngsG4vJTBkhE7RZuRqK7jQ5MSzaj8n/uQg/phFktJYeAjPQf5eGvbPBWrY1wK
         7mTu7WNbamKbBblvrUWOjmvrxyW2dmarYLPNuEsChCanBX9eFYb/yIWY8Wv8RTur2skf
         TYM9qbi7T3Qi+kpy6YEbXam2Y/Z7gqLgYzpx6xXYk2mTDOGUVB5usRYkaWf2YSwBfuBn
         vzeA==
X-Forwarded-Encrypted: i=1; AFNElJ8fIMIPx3JoU/DVpj8bG7sPKFIZw2Jq0O7l9WfJ564zkTTQToxFtI0yebDD2pB0jV+rEQIO2Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2fn0btg1mw9EV3doc2gLW56lkryB6cfHyUIMr+qG+Ln/8h9J
	mTteP9NA2elvFTDJ8khSeIbasx+KzPEkWVflKIeVmHOmbn7M0wXxbbM=
X-Gm-Gg: Acq92OEymlDUIU1p+z+a0+rjl/QF5QbuQGH6n2nFtEBZHikP+gVpteLCKoYnngnpOhk
	IYPoHqSi2prm9x5oZgHcCdjgodwdQjSJvemrPjWrrjyRPzxzq1HZTLiZp+ZnG5GKa92Hlnzmczk
	GvBy/OjayvD063cA9LZRUhJtgGTU2PPGThrYpumYFsVucdCAjETImI1ZR3PLBrwPncZhMG0WfCj
	xnHVH1n6thPzmoH/FPyXlHKV/I4jaY5jPA+EPs8ikMIBkgi+uKvnAvrgZXnDcuWBPWdeqA1FgdX
	IFVWSLC0gjS9dSHXCcNMzsMlz0QXA2Wl1d7eEsLUieB0AQt+60Q526YWS/zwcvLvtBBjni9VksX
	g4eRIZP6OBUSrIDisPq8grXsw+7JhFnRPSGroK3dlB5eIcQK5uulziQuUns1cwIGjb5cQ4+FyCR
	p2hT7AhW1tebmecx77Vva/lIKFWAuRzXLGJOhJoq4ZLotzF+F409icvygWzH8o2cLdmc6GBSna5
	+ImkDrnw9Rt2WNeuMUkovDDNIrUs6cK+fBMZ5bpcHZ3jweZK5865Ds=
X-Received: by 2002:a05:600c:4444:b0:490:b9c3:6c59 with SMTP id 5b1f17b1804b1-490c260579fmr398877765e9.29.1781096242349;
        Wed, 10 Jun 2026 05:57:22 -0700 (PDT)
Received: from localhost.localdomain ([196.119.91.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm537328905e9.10.2026.06.10.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:57:21 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: quic_vgarodia@quicinc.com,
	quic_dikshita@quicinc.com,
	bryan.odonoghue@linaro.org,
	mchehab@kernel.org
Cc: hverkuil@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] media: venus: fix payload size returned by parse_caps() and parse_alloc_mode()
Date: Wed, 10 Jun 2026 13:56:54 +0100
Message-ID: <20260610125655.10517-2-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610125655.10517-1-med08elkadiri@gmail.com>
References: <20260610125655.10517-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_caps() and parse_alloc_mode() return only the size of their fixed
header fields, excluding the flexible array payload. hfi_parser() uses
this return value to advance through the firmware response buffer, so
underreporting causes parser desynchronization.

Return the full consumed size (header + entries), matching the correct
pattern used by parse_profile_level().

Fixes: 9edaaa8e3e15 ("media: venus: hfi_parser: refactor hfi packet parsing logic")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 drivers/media/platform/qcom/venus/hfi_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 1b3db2caa99f..e2af4e9901ee 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -85,7 +85,7 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		type++;
 	}
 
-	return sizeof(*mode);
+	return mode->num_entries * sizeof(u32) + sizeof(*mode);
 }
 
 static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
@@ -146,7 +146,7 @@ parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_caps, caps_arr, num_caps);
 
-	return sizeof(*caps);
+	return num_caps * sizeof(*cap) + sizeof(u32);
 }
 
 static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
-- 
2.43.0

