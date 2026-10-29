Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293714;
	b=M/zddr553ZSIiy3eLtDJ4V5LPYGnAU7MTAAOJGEp5sDs64ICw6IkMMgn0fL0yVRG1L0S
	 WkmkKfFrc+cvRV3/RkyunAL7XzOA3rCGhfVOTBjNjf13izCu+a+8Bi5ZqGBbwoGi43Kqp
	 Vkzm5lYZTioCyk3ajqF7Qok3g1kCivsLYzSZoiV/4+BI2rozY2jPiYMyIKqao30vkgln5
	 azE+heqik1KGgItYz8FpYqD58mhHk9rQOuhNu7rLd8EJPvxloAOMy5rovQIEQKmqaiC6k
	 VT4FVXnB8nEeS0map8Tmmpco9KRPxtAcxHu6re/uOu8bGbUz3cJwzLx+XU6NmRruuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2penUq1it6r83a80cbOdtkqLeYJ8CYDR8X6q9mSqcio=;
	b=xLcwwDjd5PWUUa8+i5wcDeNPd83xmOnIQZ3nAQRiLJqferKcUYFhxhCfknr8WpAingzq
	 ASA/Nw/ZRgEV7dyqEJsJbnuvuPjx3rzkdVP2r2/xa2PXYGKxjUpuxGIx33NV3ViU6JNhB
	 1gGCpe85PUPapBadr9eHq1YtFJ7HG7k5iGRFI550QbJWCNOpl4Nd9FP19nS/Q7fVbaYYw
	 YT+zosyDueD28RNwYtEZyQTB8XF9YQ2KtjVGNgPazfmgOjivpkLpLINPfQqNaGJoviDjS
	 IMDGYHTnj9v8ulps83/3FnxfkublMxjD5EiFwWKHPkPCDXQ4Z5x5EodU6G8vSI8Yqug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lxADFK2q;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C54606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C54606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lxADFK2q
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso17650145e9.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793293713; x=1793898513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2penUq1it6r83a80cbOdtkqLeYJ8CYDR8X6q9mSqcio=;
        b=lxADFK2qDTa/RegIfnAQ9tLHMvXwzl8jyeWSwcSOjLzizXN+S+h7jPiLCA4mo6mukS
         L5YPKLjg0rkAk6kAA2aoCKfc+FSYCfAqZfBiGCtkgXNQ4W5CKIclX/Nc0jG9IkHErZTg
         fMi7bQtL4pAvRlS7I1UlMQCWmolig8qq5g5yRotxSi/NwbVsa1FvPYyuZ63j0aHr87cM
         7svpJ9YdofV5dyMNOXUcx/bnoW/t+DD/WY5Xq6izmLpc3P3/RRGf6t9JyIGiDIldy57F
         wOdqMce5OhtTaXheBlrX6zBwMN5ewdvTczaIdvEfUJklNs4dwQgWi3bd+v83JCnMIhyc
         8EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293713; x=1793898513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2penUq1it6r83a80cbOdtkqLeYJ8CYDR8X6q9mSqcio=;
        b=nec+pRLMIbIL5I3ckne4AcFNtyAWU//FTBDa+YG8WrfUdPqhti8hbpcf1C7Nueh42R
         +tKfvcUGL9B5Y1gsrJ2+8AVwy5OLF/VtJGGXYqFjyn9XEuZFznLsuOnfZQonAmPJKCAX
         Vs44lwfVsLiLHsqpmD4XuOn7NhE0dAc6wQPESrX7VGgEFgPQSlRrstXRUOYU9d6a1zol
         fLOvYTUomgvpbipdJFu68xOa4E4cR/yzyyedCGNQVjewMTO2WtTppj4qDK7QGmBQS8eB
         LrIEB8Jbvpk7JHvFJJRpMJtzrb6XKTM1h5pPeWg+nbBJJdetorWa74zVxfB7TfCuuLeB
         mUEw==
X-Forwarded-Encrypted: i=1; AKwUvBzAyLdGKU9oA0viRQIIAUc5lJjkklSAE//NrScTSj6cm3UW7tuA6FPw7KJQNdgoSAetoc1gRII=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0lN2B9IOUmAvnXG9CqFASboYtdY7S2YdxEsKhxqHMEdOXNwnv
	NFkgMEdf1DrS5gGKe3hlySVWq6m0XIVzEbkYQ24Z8nBi0uz7gZPb7Ac=
X-Gm-Gg: AYBFou3wI/1AYufGQZgopovPdaFEH0zy7Au+N9KT/IsE4VTrqZNKwyylGMtnmS0un7j
	VykRY3D0JcnOKyn3I3gQckHpm1AnA4jeWvo1YzgpDkBZZ2KFVzBMC3bW1A7F2oPkQr1H8B8OrL/
	0P3eJFN9s5ktXp2TisjXYwmbB5ltGqOhEdHvz9z+MMZ344GI0WviuL4JYWfWV0Q9uvfeF4oAFY4
	6ltx29yrO17L0ghaLy15hdPtdD3qRZm35P2RVPTdvc6vD2YjqT+GEhaK/X7USZD+S6fDDRWdCJj
	iq8HfK4pv6UNu3r6cXq9crlI9w5B6w58t/EFLrndb/jPwE451ibWHyAV5bbCZ48uswrsCYBSUou
	yDUZ9QWNThA1BJIJN9VmeaDI99gPfkjAGCMsXAk4SpPD3Bor+rTHW4ezPygqWKnDUJ6rEVZQgAO
	qwmSQKEneHkNnJtoWZsGXfP+ivQW5hpIayUgdrUOZ8BH+KDCpIFWmQIfTLuAbSrK8kO0BGr/fOY
	npd64X+fnVbJTwjSuncZ5IWYd92hqDXfo5qOfH1ASO9R3h6ncqZPAdf7sONl/dnGA06n3CVR6A=
X-Received: by 2002:a05:600c:4f55:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4a9661ab508mr141416555e9.16.1793293712558;
        Thu, 29 Oct 2026 10:08:32 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896ecsm82284925e9.9.2026.10.29.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:08:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] drm/radeon: validate ATRM return buffer type and length
Date: Thu, 29 Oct 2026 17:08:31 +0000
Message-ID: <20261029170831.915318-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

radeon_atrm_call() copies the ACPI ATRM method return data without
checking that the returned object is actually a buffer or that its
length fits within the caller-provided size.  If the ATRM method
returns a non-buffer object type or an oversized buffer, the memcpy
writes past the destination bounds.

Add a NULL pointer check and ACPI_TYPE_BUFFER type validation before
accessing the buffer fields, and clamp the copy length to the
requested size.  This matches the validation already present in the
amdgpu counterpart amdgpu_atrm_call().

Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX handler (v3)")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff3..579ba1c1f23a4 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -183,8 +183,13 @@ static int radeon_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
 	}
 
 	obj = (union acpi_object *)buffer.pointer;
-	memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
-	len = obj->buffer.length;
+	if (!obj || obj->type != ACPI_TYPE_BUFFER) {
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
+
+	len = min_t(size_t, obj->buffer.length, len);
+	memcpy(bios + offset, obj->buffer.pointer, len);
 	kfree(buffer.pointer);
 	return len;
 }
-- 
2.47.3

