Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793047014;
	b=chh3lc4gLGfPpQaDYFlCx9Qz3A608YfkI3yzzXdrIW8QG/p3FvgwPZkff5Aq4KLIg20p
	 UO6/zl9UZ28ZoFgD5rkmz0MHgO2/LlBMfRRI4aribsfy1AQCOXfyAn0inVes1WU94lgEM
	 RGuW4DklVtQCNAXtUuN7F8c6v/wN2+qgiDSS1IjT9233uTzppevrYRcxyloyHWwx6wfqL
	 28B6TwSJg68bAdv4Tf88tz8idsab/zFAyGtPUdp+rsEitfcMcZ6N6Gny9UNoAZvFNjMDI
	 +8szZKKHuVClwjUc7dapHPAtvN6rIGtbWEO9+ihhyf+m9JM8Gexiqg/p8WLAvlrfU1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NCTPq4rCLjOU9tU56KP+2bzUZdmxKJi8dy8plluOj+8=;
	b=0mKLt2SKeLmUi0D1HveH3hoc4LmA5aTzWIvC+cyejIJhhaohLb2+JONLI0UWtL/E9Rla
	 VhZ9ma1+L61o1dQA+XKlmPXouvNoPU9+SwTDFicvh6tiL/+RTfbIvndl/thamO8ZgzAFs
	 Q/txMK0mszJ9MkKRqiO2mRJW6HxYG27E6ohU8PvfX5dIwNBrQrwM4Le9QQrWS/7VKa/wz
	 shRpmzCi70ixDxyTG7cdOK2yxzOi+KQKK0G4C+O1n3mpCVUkbBGrt7V+Lc68cLowYeH1F
	 h7DE5j+nYJzYCLZezp6/OwgCTE2UbRsNYeHXEautiikJYE6ubIGRQr+PAft8wvE2Mjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="gO0S/xlb";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBC6606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACBC6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gO0S/xlb
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so16113355e9.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793047012; x=1793651812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NCTPq4rCLjOU9tU56KP+2bzUZdmxKJi8dy8plluOj+8=;
        b=gO0S/xlbTa+jr3c9Y0wut38AfOQtnrFDWvFdYNLoDoocHH07CK6yBeoa07/tt9qQKa
         QTI6KdL92BoCUsC08QVsL/CVxBKoU6ZkuovzM9XrEP5+U0aj5ONNQZQf9GyhoDIgPp5r
         KSfy3fsKfkDDZV0kp6pQE3ex7nSox8klJIO5PkWcFSJlDftsi8X8pxrV84vZ+4VqIgto
         IIyvmi4ZNEa/mfj+E6e19hs/TH8XsJOhdQwJ7j8/fpTaaokm4xzUyZoY3BvI4XCMB8lC
         WS50SZWIRcATs1qmz0ugx452lrL6B4MwqIo+QsKFpDrps9SfqzGVgia9SDpljQJfGsd6
         1eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793047012; x=1793651812;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCTPq4rCLjOU9tU56KP+2bzUZdmxKJi8dy8plluOj+8=;
        b=OrNZy4qS3Nza7vYBYy0w05eAHcG95fS4pyaMZ4JKMOE0h4PMf34fMbBo7W5Wabs7Xi
         9c7bPe+yMzDPwHkPXHHqj45iP+Mvb1ypR5F5OfbrAuF7NMGk/QAT1T4A/9ybNXt1aD/h
         P0aSNDbq4LhzLaOowxVDr+VVykCTk+Wg1oy7VItmsL1p8FbnWhhBHgjbUOkV7W7Gn5tn
         6zhWIJz81vG0smJem2P/GdOT1Un0pa+qDlrQtH5RAO1SVmx4R0fG/FIhIfaRPSogJDVc
         6LZ7cYBfF661dka1zTFnvDUkdTDvYWTtLReCqPiKaUEyt38eLAiNQbVxKe4wVMI75FkX
         qa8g==
X-Forwarded-Encrypted: i=1; AKwUvBw6NFvhT1dqqeTJYuBdIsp3A5O8OiH6O+Jrojy8b3Vr1tOFJssICtRtPrO5vvumFIhMV9+deOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxOLSo04Cl5mX3x1lyuuRrRYo8E7XcD5I1dsd/XZIYkN8G/SFl
	CWP73vjl9rruy2JrRrpXcMNVESQZNoQs4fex1O7eheMCwEdkLCg3kgQU
X-Gm-Gg: AYBFou1IJdZ1TPT+o3kH6sJ+T52lS24BjOopkt4j3t04TDTMVg5POMFlUlQlJNoXrDU
	v4lRexNmH3tfm1qW6I24UtdTRRxF8oKbIDfe8npnOnPeF/B4UxqwIcB76yvk+X1OQxIYEIwaMSq
	qFvQbTbhk8npLAkzHrFVgaaupnQ4Mm1/QeJNUZb37bXliRvlEGrf8Z+MDhG+CVrdrPmpqO0jpCz
	OCuhgX8Toui/+uB78v4Ur3sELkUpK2QpgGduZ3iY3vHK1/uR9/I6nlL+bXJB99D3QI6+Niey4Cm
	q7QGAzfDY4Kuxfqxe0N1PblcIhJTR0Gxx2Ni5Ouo+QLFaSkqenEBmccru9Xd5mws6JZeqfY8w0R
	AeZMNAAueFcol9g3K7YK/hRf1MCbgk42S0wMciMO6+vEht2DAT+yVnLqIk+rsQOyAsUvgBXJyDA
	ZWM2JjS1IRYOnC065OS3dKBNIolkzq5i4R1+E19p2UJ/+i2clVTY4TSMHbGwdtdMAV9vsiFdWKe
	n+FLbXfjxzAhvaPZWO77S6S04z4zHq6fH5UTgVUp+5bxmTpZQNAJcVUKfRD4+4KANsDcUr/wDu6
	83uB/TyuF26CuQ084an9xLqXCo82ojKsPdt/2jgcJO5ODFtW+zPI6BqNiMAImX7fwGABaBe/8C+
	J3z9YuGwPND6p3GXO1NZpS7W8RS+4r9+SboCslDak2yg0Pohc5sjkelqokTnPq2HsyGiYUwFuJW
	ukZOMsxHR+lyempfrjQgxw5XpHmFfD0gh3QsNAh1kLYr45gNEfmQ4d2GYBdZ2ofE+Yzh/lmcrg6
	7dWMcbBguPwWWl5TKhJxOhoQ09RSGTukweqzjIiMzMWb+LW6nZi8M+8/kQ8IJFN6h9wMCAn4g5e
	DyqG8znISt0=
X-Received: by 2002:a05:600c:1909:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a35ac95fa0mr139540185e9.16.1793047012059;
        Mon, 26 Oct 2026 13:36:52 -0700 (PDT)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de. [91.65.217.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f3e00asm380680195e9.0.2026.10.26.13.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:36:51 -0700 (PDT)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Jack.Xiao@amd.com,
	Erhan Bilgili <erhan.bilgili@gmail.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: Fix DC scanout position handling
Date: Mon, 26 Oct 2026 21:36:19 +0100
Message-ID: <20261026203619.41601-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025084506.62881-1-erhan.bilgili@gmail.com>
References: <20261025084506.62881-1-erhan.bilgili@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The scanout position and vblank boundaries were decoded with a 13 bit
mask, but the hardware reports wider values. With VRR, the vertical
blank can be extended beyond 8191 lines, so the position gets
truncated. This results in wrong vblank timestamps.

Decode both values as 16 bit fields. No hardware generation uses the
upper bits for anything else.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Suggested-by: Michel Dänzer <michel.daenzer@mailbox.org>
Cc: stable@vger.kernel.org
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
v2: Decode both values as 16 bit fields (Michel).
    Point Fixes at the commit which introduced the 13 bit mask (Michel).

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0a8dd7241750..9ceb2921ccec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1784,15 +1784,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
 
 	/* Decode into vertical and horizontal scanout position. */
-	*vpos = position & 0x1fff;
-	*hpos = (position >> 16) & 0x1fff;
+	*vpos = lower_16_bits(position);
+	*hpos = upper_16_bits(position);
 
 	/* Valid vblank area boundaries from gpu retrieved? */
 	if (vbl > 0) {
 		/* Yes: Decode. */
 		ret |= DRM_SCANOUTPOS_ACCURATE;
-		vbl_start = vbl & 0x1fff;
-		vbl_end = (vbl >> 16) & 0x1fff;
+		vbl_start = lower_16_bits(vbl);
+		vbl_end = upper_16_bits(vbl);
 	} else {
 		/* No: Fake something reasonable which gives at least ok results. */
 		vbl_start = mode->crtc_vdisplay;
-- 
2.56.0

