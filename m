Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E13D093E
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338633; cv=none; b=s0lsQi4IsnGB2BYGISc/dQkUJMvWuo5B2ooQrECSjJ7Lwjk3uZ9wjm3DeZS3wYS+t9/1paqibqVWVwcHhKxu88QSeNsX3N5/Sn3axAmonAFRjkfdpttDB/yR08oDpscQT0aorSx7WqCtjLD6zNjWD5JB5iMlLFFIu6ELaYGlxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338633; c=relaxed/simple;
	bh=bU0Jd6AMkmLJEjZPbDQkgBQGjplB+FArAvcmlt+Zkvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQKhq9MNXPTrpCaNmfRM5Zs8BPWqEZlB+nBzz+ORk8Wy4n1Z0DZ+g4HbngD2TJLgBmql0SFhlsRUp2/KJlr/U4kuB8tPRrEJ+HCGphzQSfCEkj9kcaJkokh1k2pStwABEzjNQJGKIWqbiDXMdroz+K2vMT3Yc11PdNr8spGHrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXyfJ3K7; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXyfJ3K7"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so188276366b.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338630; x=1789943430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quQ1ROjqXOesVl7wNiBN30U4SehH2NXzlCj3tCS7Nn8=;
        b=nXyfJ3K7Gykyo9HAFIx2CVqM4OvZAyO/RQusivvyi4wgrmwtADeaqTTtuyzqy1UxMR
         WGuTEvH7fsHJUEjS3nvre+fKXy1DFeKNVP7xPQ+j8dmcEPLTh4ZC6j1CtDJAqBiV9m8y
         to7hMKmYcJwsARYYrBp/S7v8+bSnAIP2sC/9U2HoeR9+C/Hq9g7HvRdkoDEmAOXMjTFu
         pSuYCSTNKuvFmoClfvWpsEiJlTzRTKulqLpi++/i3TpLQzbdqKs8Nu8dPS+G7uzUiYXh
         XCEQRk+DEdRGWnKUifRTV4XFp0f7THXice9Q32BO3L/YiC6XK5GbWJnKfl4tmf4VIA08
         CRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338630; x=1789943430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=quQ1ROjqXOesVl7wNiBN30U4SehH2NXzlCj3tCS7Nn8=;
        b=da65lxba1cw2/T/KWVkxW8mEl8T6nKgIZBOQt35CsxITHow/TKO+YRSO7UryvO+lG7
         GaoRu4hLF2/eRZLcOk3xSWLM69hk/THTM+rB1MZZLcSKk/fN2YQZnzXChSoD4tch1KUG
         WIXdnS1ELTzxwbICqeQ8IaR1discmtPtp2OrcLpL89jFWH2jQnr1+KGcm8tGQLbRWZsQ
         RW8Y+A/7sPq/fCkO3/794hhT/R1p2vFdisWRLbOjNLtgV5cnPonsgkcmp6keGP9ixm/s
         Zh6Pbl1w4t8H3h6btBorrnYwpTZAINQ54yQTQ8+wSU99vh6xZ+cmUXpCnwhFKW5g3Gjl
         O1vg==
X-Forwarded-Encrypted: i=1; AKwUvBzyp6k60kN2XWnkbO5xWntyqT93br3hD2Tq9NmCWNpAAgGzXUlgnWoJm1dWbeohmCN0JaD23Fs=@vger.kernel.org
X-Gm-Message-State: AFuF++mZUtXJ+eFaPp2C07tTke7r192w299k4hfLBmKGWaxo2E1z0swz
	1gw3rQyvjXiumnD0DcxvLNZWH1v1xOLrP5hDHIhsORbA8oLjvFO/YT82
X-Gm-Gg: AYBFou2Gg5QDgxlyuZ+ryu8wje8UZUxGi0fS3DyyfCgFlzS3l3Y1kL+mVcVRbV1n5n0
	LzT5Lf1outLX646DHr0yED2Crz8yRy7VfLbAvWxp2J7w7Q6SBpFd9AHrCcwsKSsep7y/KqNO8XK
	3aHLrugy5ZdJaORxDWa+w2PUhFzTwn0vlr6oklF9kPKRiolqXQD9bHmQ2bfiXlWBK4C4PjfNZPH
	d0IkggKeknbjObZt1XgXvna82KRjFukobYDoYYvgU3XUYQGHM3xEac4Fta9eDlOJ4Y8I4mIgDDC
	gZUi1XHiHEQNm9EnAS/89XoaF3dvLJJRED8seLNNg/rs3zDyGwmDSxCJCXqr7NGHmPWYmH0v7xI
	y2LOqIoelL89EifWOc8n1D7Hcm71V7zsxrir3zH43tK3pttDRTHeqQ4HvJJPuwOu3o6rUjkGkyR
	/dtWKxBktNnQ54IbUWkB1HHna5m5BjN4QK8KJ1qcudBb7p48pQYFRUSNphROqPtS7GHufr/HIST
	4I=
X-Received: by 2002:a17:907:7281:b0:c24:4128:c19f with SMTP id a640c23a62f3a-c29b85f7454mr6110166b.11.1789338630318;
        Sun, 13 Sep 2026 15:30:30 -0700 (PDT)
Received: from beelink.. ([186.247.78.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:30:29 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 4/4] drm/qxl: validate relocation src_offset and fix type truncation
Date: Sun, 13 Sep 2026 19:30:00 -0300
Message-ID: <20260913223000.695299-5-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913223000.695299-1-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UAPI struct drm_qxl_reloc declares src_offset as __u64, but the
internal struct qxl_reloc_info stores it as a signed int.  The
assignment silently truncates the 64-bit value without any bounds check.
A negative or very large truncated offset is then passed to
qxl_bo_physical_address(), which computes:

  slot->high_bits | ((bo->start << PAGE_SHIFT) + offset)

generating a physical address that points outside the source BO.  The
SPICE virtual GPU then interprets this forged address, potentially
reading from arbitrary device memory.

Fix by:
  - Changing src_offset in struct qxl_reloc_info from int to uint32_t
    to prevent sign extension.
  - Validating reloc.src_offset against the source BO size before
    the assignment.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 9fba6e26d..6559ba7d8 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -75,7 +75,7 @@ struct qxl_reloc_info {
 	struct qxl_bo *dst_bo;
 	uint32_t dst_offset;
 	struct qxl_bo *src_bo;
-	int src_offset;
+	uint32_t src_offset;
 };
 
 /*
@@ -259,6 +259,10 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 						 &reloc_info[i].src_bo);
 			if (ret)
 				goto out_free_bos;
+			if (reloc.src_offset >= reloc_info[i].src_bo->tbo.base.size) {
+				ret = -EINVAL;
+				goto out_free_bos;
+			}
 			reloc_info[i].src_offset = reloc.src_offset;
 		} else {
 			reloc_info[i].src_bo = NULL;
-- 
2.43.0

