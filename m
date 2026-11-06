Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990625;
	b=K7Q1iwoNqcgpGdPKS9gP32EaClViXRDXT9tNSJb/R2+bodKVJYKz9lAIITWjMMAmD/JO
	 o9Eh7b2tIWkjmhIqnBVLmTZq4CiMAGXAh6fHPUFHjLBYU6ecQQb+jS3nG0NaO5ZRSO+Jg
	 VvxsxexX+8iPtgFqo46B0KMi5e9yUJNA9B0oqn/Kk8sUpAFnElKRDWO17pq3T8JilTad4
	 +rFPMGj69EBXWwsUeEOY61DeSJW3/IYOWcruwjHYRO+Fh3MnX3CJCuievkVqujFnUWOYA
	 SIQEN7+pxE5hZKmOlfraxH0GNhJVA7RHYnAeYSmcuxhje5d8YiGt2W/MfyiIW5BSJQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NbbVNlV0Ddm0y0fksEH13++wT1yMdo/rDKxFHAfvtG4=;
	b=ljdPr9rnS6o1U2z9mF63L6mkSMYouwbdZIs59V0oGKbesVFdF0AvXR0C1kSr5q8Tl0HG
	 8Y3A0WXZu1VhOhpJghtnU2ysPWugL9U+kHHCvN3IgBFulYXHFmcGesCb22WBauiBkSuH7
	 ZdOt+g3PTfSOqwzKqBz/zJ/eL1MfwWt/M7AGnlFuhctnI+K/By6p1nCNMu6IEBxTSNusW
	 DCooc4PPzmAaOc/iEisq+qcalnrQ8aH261HuhQANTEkdguG6CRFs10BYJYkbBtTYJ3lpi
	 wZeH4wXaAiz0FJ29gFU+ylJbFjSoQpyal/hRvsrvQHBflj+efZataglQr6+FfFH27iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nHkTQfou;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E4606A337
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 709E4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nHkTQfou
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1587803eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990624; x=1794595424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbbVNlV0Ddm0y0fksEH13++wT1yMdo/rDKxFHAfvtG4=;
        b=nHkTQfouN0pMR0HzTsq3ECgLIEOgW4xZdy0/pm3K1NbeenoJMembQbTxOIUb9TBjR7
         qip0r3zi2Mwgx9CXiVYKhRPt1lmAroA5RQIx5tN3sXr3uWtH00n51KLxJPKLX/AFJ9nZ
         e8AGnWxWrmFijQf7Ttt+CRvJBUpKb6Q8PSS7G6OHAQrJ1j+5XlPBS43DvBkGpRK5obh+
         RcckWG+JFdcUlQUgVtN0GtLBrhcaJ7XG/7XGKiDCEKBu0xb9VQ3kQzlQ9bK9RyoLCRE5
         NX0//eXIAGMr87MTEz8NgrcCltGZvDOvscKiZdHITOaRBRz7HW+BdFMzBoeO8ZIPaPH2
         mCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990624; x=1794595424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbbVNlV0Ddm0y0fksEH13++wT1yMdo/rDKxFHAfvtG4=;
        b=JFsQu12VZad75LRTTEcrMIBQtvJMTgUKIqA7VQhxYdbzkop+HW8pHNP+XJpLvHxiaU
         vXaRcG1gTUTKF3jMzuYtqaIqfpLs4+vcNaRhfNqAHRFuUfogKcIMlmMPOa2YX0qcNDwA
         Kvo+jzJo9Biedk2BTDOE+NKZ2Yz9oO5/7s3bJNAJTzfeBoBf2B6l5h8bs/+pO4Hlppit
         24oB2ET47yu/yfXHKG8jQtCmJZC4nwLeI0FOJwInutm7h/aXyTniMWO6MTY9ypjNhxD/
         GoemWOKnZZSwianV4fOe8tVzMRgWp53xIr98wrmP38Rqumik4jOBdojDlFOCsPx2vb24
         LpnA==
X-Forwarded-Encrypted: i=1; AL+hErFxdwsqJjR0Pk670n7VvxRwfF9DstmEQQNAgG3xt396WO32c128F2Are+Ki0M705Pbv7C9nAt8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qb8FVajivU2GRe4cJYqEaTAaU/OyMvJFTT54q/ZyBOm9ugBEm
	ulZfbR9CxAItaFaxflxmhWBzGv/4UjQZnSr4FbOnqq0Aq9hp/OweR7bv
X-Gm-Gg: AYBFou2DxQPcFuCTddR6HKThdVx0TeQtqjloWY7j1pgH4x6FkQJpz7N73ZcNGF65+Y3
	RouLfxu4VLE1jfI57TSBy2P4L/dUov1P/O1C3aiUmbP1levcwuX26fe6KnIXRRdBVv7lo5yGGMz
	aWWdHRqWgHSu9taVAm/FAf/YRTCThULtcaFwb4SnXrvrrj19XznGFw93PlcJSLjkYNJVZQ/oAxh
	Jv+KRJiqMji7tHGDKXiv35H1xA0QaGn1C42FwucKvO5ZR0fDO1jT9VO1FAqOceQYSgpfD8w+Yd7
	emBg6D5CBhJoDUTmhIFvAnbxbzMKEmARvUUbH08qokBfnwjEhMYUENV8LoHgSP+3OPfVZuv+yAI
	BP6CglSiJ+09+bQZSWT6prfF9ScsTq8dN5IYsaAV3D4E0afPv9r9KE0i6WioNAEAW8ru5dAnuja
	PE8B4V/rcsSSf/wccqAq/Rh1i3iqZzx7gZfyuB/8YXL42KeO2jOPuTN65rCufNrxxQPIhoMs5Yj
	TkFs4PWCtCsR1AgAje44qvIgF5cvr+8EGeJfcwCR3h8qL7nDSYWzAWWz0fsF28GCwE59NAhrz3X
	dyZYP2rD8ng1Cj7gGun5hgAZxScArA==
X-Received: by 2002:a05:7301:921:b0:36c:9bc6:3ec with SMTP id 5a478bee46e88-36f72cc1d9fmr4534575eec.3.1793990624382;
        Fri, 06 Nov 2026 10:43:44 -0800 (PST)
Received: from JMD ([2405:201:d028:10ff:eceb:5028:6b10:da7c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea414sm8278073eec.16.2026.11.06.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:43:44 -0800 (PST)
From: Atul Akella <atul.akella@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	sibi.sankar@oss.qualcomm.com,
	quic_srichara@quicinc.com
Cc: linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atul Akella <atul.akella@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] remoteproc: qcom: Fix bounds check in q6v5_wcss_da_to_va()
Date: Sat,  7 Nov 2026 00:13:10 +0530
Message-ID: <20261106184312.100-4-atul.akella@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261106184312.100-1-atul.akella@gmail.com>
References: <20261106184312.100-1-atul.akella@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

offset is calculated as da - wcss->mem_reloc and stored in a
32 bit signed int, while da and wcss->mem_reloc are both u64.
For a sufficiently small da, the 64bit difference is truncated
into the 32 bit int, bypassing the offset < 0 underflow check
with a small positive value. Additionally, offset + len >
wcss->mem_size can itself overflow when offset and len are both
large, providing a second bypass.

da and len come from firmware's ELF program headers via
rproc_da_to_va(), and the result is used by the ELF loader
to write firmware segments, so a malformed firmware image can
cause writes outside the carveout.

Rewrite the bounds check entirely in u64 arithmetic. Reject
underflow before computing offset (da < wcss->mem_reloc).
Replace the addition based overflow check with a
subtraction based one (len > wcss->mem_size - offset) so no
intermediate sum can wrap.

Fixes: 3a3d4163e0bf ("remoteproc: qcom: Introduce Hexagon V5 based WCSS driver")
Cc: stable@vger.kernel.org
Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_wcss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index b391724cfd08..e67dc3ff8a07 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -740,10 +740,12 @@ static int q6v5_wcss_stop(struct rproc *rproc)
 static void *q6v5_wcss_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 {
 	struct q6v5_wcss *wcss = rproc->priv;
-	int offset;
+	u64 offset;
 
+	if (da < wcss->mem_reloc)
+		return NULL;
 	offset = da - wcss->mem_reloc;
-	if (offset < 0 || offset + len > wcss->mem_size)
+	if (offset > wcss->mem_size || len > wcss->mem_size - offset)
 		return NULL;
 
 	return wcss->mem_region + offset;
-- 
2.43.0

