Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE034445AF6
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543005; cv=none; b=EcFfWmSlfm9ExElbGm00jY86JtJc3bhz5vF9W5bgHaVrv2C4YXFSflokA4kp0zm8tuB07JDUtLGnqToXbWsMmnCkl+ZT7ATltkIkjkQb+IyEEcvAUjFvr5C9N5sHaxYIGFwb9VcgaZ+dRFEOwmHUCgmifzSfQoUDFtQ0bPONRwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543005; c=relaxed/simple;
	bh=LjZ2tbkH5xa0TtWXG72trjxTo/BU3RCyCRK/EAXwPsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rz5JcbjYDYJ/iR4nM2IThW/v58Gadvluhoe4L7iWZpFP6jOVwApaZ2jnk3fObyGxkjOlmq3706oNDLIT1A9PowEgeUnYR70v8p8l9oot91qVWG+QPzTzbqQseRpgv6g5Rfc58Q74VZAd+ALHSTKGgIV83IS9gMFBkHkKy3LvBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjmiBQJ/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjmiBQJ/"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-473987fc217so81189f8f.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786543002; x=1787147802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cjqqYdlJxczb+huWu8sxbAJ3m1jklduZMwUdXKo3Ujw=;
        b=BjmiBQJ/0f/5GOxsyiGGNE7Xe+xuXTmX1YOUW2pNgiuXbzUhcSg62+Gq3ShJdHcnuh
         R47BMlsklqgMIMYRcpFgYs6/lewjuOq3Hr9YzRsTB536FLXFzg0PCh6s15/0Tk+Qvp2T
         jQHIWZqVmL0UAl3EQp+V5QKUsctaqxngAih9JHVVxDTQJSKjkzfdu1h6c3GPC9fGTuh8
         lodJxToL8zAJLs2QK9YdWjKdD89SYEYAHA1hzo1ZOX3RvzfiMwlyGetMy/Wh8x8ZfX88
         201Dl06zzShzjdyovZ7wJCm+aBfF3Iry33Pqt7XLGGqNqUwXSEeFK1uJiejCbkCPaqdv
         ARag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543002; x=1787147802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjqqYdlJxczb+huWu8sxbAJ3m1jklduZMwUdXKo3Ujw=;
        b=TWIATANKMtTyrF590sFNcP8Y/Nm1tWcOsBhtggTxv2+IfyZW8+6umSOHgGumiP1Ubv
         K4thBOhuxbdT0Bk+NdohdhxnBIuSm37LyqSi72Hah1Ko8hpm98OL+cBdHdu/tt/0/y8d
         UU2Bsklgm1gakKq1v8p5pMxoXLqVbbOmepTT9CcQ/MVyCa71t3aPGHwfuNQyfIYazVe5
         eQhrKzVD6RUsSbxifBnSmaumAIhqzvpY7o7GMECXt/Pl/MJB3RfzjI9uLcqG2ntSKn9B
         lqv0aTmtvRcQoE3r0YH+iwMy6oOZo6/tje2pJjI3A284cG9Pn+v/qSFL2iqiTdSvsVgh
         nTqw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6VTblabyX3zAKujyy41hIudOJprWaJPnCH2NukhOnIhlYkEegyayG7Gh2H4X0zs9OmlbKhRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTe6wmn0V37PKB5thL1t+HroSVQHd6aHGi60iZ5JWHCXZqO+t
	WmloGwJ41B6t0+RQNyNASIBjxz5yU94VrbWjmfmqyAROdVGHlgoBFdJj
X-Gm-Gg: AR+sD11dWBBlTBCGHjiNIpTHTin4plScWwJKO9Z/59yw2xoFsAEI02V3ySJUnuCvWcv
	fEAdloVqfYMBU+wkk50xGh9DJo3sHPXOjxCGGUZHkjCJH8QfwD7ANjP4K7sJgwfw5BR8TxgAe3U
	BAAco1qac9oDCPu0T6yVJEngK7Qp1GviETwG2HI7R8mWv56s6kKRFNqgeLL6hE24FX6CeUH/0hb
	dO6btK1g8rQD6ZNZqWH1x0iiF1VXF732n9r0sPZOiuoU4hLi6Q7yvi6qm8cX3FIsCNJ3SMz9PZJ
	XWE8RgJPfzgpMKtmTOD+mHj41pyU696BnTRT/0Elu+YadXtXgTvwbgxo9dsJtHbogz1uc/ohDIf
	ScPs91skPVhI/Ho6LSeifuN2uW3zeC19EheToR1miOVYzJJsQsMkNMHNz+N+EKGe5alNmItgNIh
	u0eV2k7kJpkXbebbsQvgmWxXg6ZLssgdAmooW2iDctxmDabNnSDNRbB1sWSrIkHDga9uY=
X-Received: by 2002:a5d:5f41:0:b0:47f:6fbd:f23e with SMTP id ffacd0b85a97d-48152cba2aamr4137759f8f.4.1786543001607;
        Wed, 12 Aug 2026 06:56:41 -0700 (PDT)
Received: from localhost.biz ([185.61.25.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf5f27sm7351303f8f.1.2026.08.12.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:56:41 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Michael Cheng <michael.cheng@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm: i915: fix sizeof argument in reset_csb_pointers
Date: Wed, 12 Aug 2026 16:56:26 +0300
Message-ID: <20260812135626.16959-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In reset_csb_pointers(), drm_clflush_virt_range() is called with a size
calculated using sizeof(execlists->csb_status), which returns the size
of the pointer rather than the size of the object it points to. This
could lead to incomplete cache flushing on 32-bit systems where pointer
size differs from u64.

Replace sizeof(execlists->csb_status) with
sizeof(*execlists->csb_status).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dc0406820ee7 ("drm/i915/gt: Drop invalidate_csb_entries")
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index e693b0c9d2a3..9ac67a0cbb1f 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -2833,7 +2833,7 @@ static void reset_csb_pointers(struct intel_engine_cs *engine)
 	memset(execlists->csb_status, -1, (reset_value + 1) * sizeof(u64));
 	drm_clflush_virt_range(execlists->csb_status,
 			       execlists->csb_size *
-			       sizeof(execlists->csb_status));
+			       sizeof(*execlists->csb_status));
 
 	/* Once more for luck and our trusty paranoia */
 	ENGINE_WRITE(engine, RING_CONTEXT_STATUS_PTR,
-- 
2.53.0

