Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FA347BBD
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754305; cv=none; b=mCRlvrNi35G6BQRkNN+lW9GoLaCWP7+Cir0tSw6rVhYwHjI6A1qc0EI7P8RTCcqno20ifiiemrMQYTCwk2N8lzam+nd5QalGGO7LI6GksIgMUnGj+gk+F91fk2oF1K2LyZ1Pzu15HFMWSIBzUw0GIbhJnZ3iURIcEhzERwdsDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754305; c=relaxed/simple;
	bh=TL08TzO3D3qpCBAqoDnd/7ghYJ3m8ofj+GSg0J5faFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fEvTWsBe8tScet9Rwo4Xpt9Uteu1KEwjabcxIlHc0YrKREZgFn5PVvCX+a018v7fExEwLRCdSC5rKSBdVD1PKoL7DcbfbQM7OrMBOe8Hy9c4I2xymLINcXydiR8pV3BP90ZFhWO+DckdRIkd/pbE/eCzl4mYz1ddu/EZQEY4+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=REYFV+to; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="REYFV+to"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so1313516e87.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782754303; x=1783359103; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EUpiZVAqkBSshI3JVd3gOCLUNBz11MuKzvqTDhb6VI=;
        b=REYFV+topJ/PKOhq5twnY20wYQ2qF5/AEsdB0rFySr8BDZM9NeQ/7dmCkHbKLQQI+X
         IrGvErpXKLdjqCuA3M83GxXYc4n8cPuwLPqbdbOMfOzrThCtrgDgVJPl/cOWLfPxnpdb
         NkNgkldJ78V6J9N2BgGDBokjh+I4l7Al//Xgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754303; x=1783359103;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EUpiZVAqkBSshI3JVd3gOCLUNBz11MuKzvqTDhb6VI=;
        b=BihMdQhf/G6UYPXN39qvfR1cvnAPGXaMmvKfWYk9BiFfk+JpNpMHSqS0WHNrQf0J25
         mkh6WzR1oJ+GNhw7elSKZQuWsDTLAAzyZDi4Fj5Qn6caOf0F6FcDXDMUpgr/XLyX1lKd
         Kc8XCqiPOpzmgNcQCWmTsrhF2XRGXFMtHydLeD1gsECTKrZ3V5Dv3oVPnlnwLigw53hP
         t22HB/XYpHjEO/Iuu/rOYr1gC291k45X85JongMMB0DzMoQ/yttY9x7xMZ+3y2z+vyTc
         e/br8y3npcrHLiNcffAx+KiZZhfqgbxIshmIFmKsePSMl74yXbDnOAweYFa0n8oP1o6J
         Uryg==
X-Forwarded-Encrypted: i=1; AHgh+RrIweZWNb5IcnIGX1qE9Xq4PhwzLCm67B16MLNZrDEf1LZ+6NiH7yDzfX8XiJEmJc42ESdKrwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBNkjVh0Li4Gi+xzYN7YCZtOD1Nz+Kv/r8CnyDXFatSme2TF9
	yNegYq/pW3iD2DhKJIsUMPxcqInYS5hS0sok9hGZgKuh4uicJ1VU3G2rMQrGsaJEdHRPL7diiRx
	3tngQZFKF
X-Gm-Gg: AfdE7cngIsA9JgDzaFm+BVBdQI0ZpwKBE6s/vGBDmPAJvOF+z9nO8oEcv69dMMAKN8d
	u/OAwzBIjoZZwAuBu+2P0tThkap81+mfaJzsnQnFKLPFgEplHLrQDAphztQoZuRtfnPi1jExun8
	7WyfT1e3WEjDCBXzr5qYTyFferq7sO7TFe1l9SgJfHgq8XEJzRCXIJRVirofC5cytjZBqmMot7f
	nLVAO1SKf4uacsAmf95HizaZmiJePMt1USOnInlby2UvakJyczNV7ohHbH61UCQED2VJNP6Pr68
	NskYG+zwdnvwqXMyxSspqFmOn/q7CQdP6KeF4yAPrvTAJg0yTbgWPcb6TnD1NmYaiOlytmkWyuG
	j1gfDAkUkVa8ZX87YdytOrcQqYdZIyltnT3asPkDsrY11CEHcuqgb3qydaa1PMvMDqF4BT2ZvI3
	IKErdJfyvkxVvpaBGoYlVfCTGAQRIvEAu6AyfHAzVS0WHidPmjWyxzUU8injUDmWyshAff
X-Received: by 2002:a05:6512:3d19:b0:5aa:671d:9960 with SMTP id 2adb3069b0e04-5aebdb7d433mr66040e87.6.1782754302744;
        Mon, 29 Jun 2026 10:31:42 -0700 (PDT)
Received: from ribalda.c.googlers.com (216.148.88.34.bc.googleusercontent.com. [34.88.148.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aea237d2e7sm3973868e87.28.2026.06.29.10.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:31:41 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: uvcvideo: Fix race condition on metadata
 buffers
Date: Mon, 29 Jun 2026 17:31:39 +0000
Message-Id: <20260629-uvc-racemeta-v2-0-10e91d2afba0@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPurQmoC/3XMQQ7CIBCF4as0sxYDaGvqynuYLigdyiwoZmiJp
 uHuYvcu/5e8b4eETJjg3uzAmClRXGroUwPWm2VGQVNt0FK38qauYstWsLEYcDXCIWrs+nF0doJ
 6eTE6eh/cc6jtKa2RP4ee1W/9A2UllLh0cqqeak1vHtZzDLSFc+QZhlLKFyC8sbGrAAAA
X-Change-ID: 20250714-uvc-racemeta-fee2e69bbfcd
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

This series fixes a race condition when calling streamoff only on the
metada queue while streaming.

The first patch fixes the race condition and the second patch replaces a
busy wait with a waitqueue. It is probably overkilled and this is why it
is a follow-up patch.

Feel free to apply the first patch, both, or squash them into one patch.

Regards!!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Use a new flag in_flight to avoid keeping the spinlock for long
  periods of time
- Link to v1: https://lore.kernel.org/r/20250714-uvc-racemeta-v1-1-360de2e15a9a@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Fix race condition for meta buffer list
      media: uvcvideo: Use wait queue for metadata streamoff

 drivers/media/usb/uvc/uvc_queue.c | 11 +++++++++++
 drivers/media/usb/uvc/uvc_video.c | 32 +++++++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h  |  3 +++
 3 files changed, 45 insertions(+), 1 deletion(-)
---
base-commit: 253355887a1ab0ac8f33b356c7c1140eee554d18
change-id: 20250714-uvc-racemeta-fee2e69bbfcd

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

