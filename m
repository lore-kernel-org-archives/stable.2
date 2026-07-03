Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A0272801
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093559; cv=none; b=c6hjDzk0H1ykn1m+UfE4SCnVngqIj6GqOToZtQ8Vh6t4xZmtDdRx8hgS6kShuiWK/45xjUaRMIIoe/Bf1/fXEt4VFQ0IK9uNpVw2oeZq2FKqOc9ZDsRbDOV7zrAbiCfV59+DTcH9x6HYMJpaSr+mje7/p8BGHSEDk1bR7KS9KD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093559; c=relaxed/simple;
	bh=o/uG1MMQxGBv8bdBWvrQTSweeOQypt00WBJoZY0FrAE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Md5DyR2EupZIiuzfZA5Qtc94lF9Uj4zpXmccRSh4GdZfe2FS9PeiGw/ReIvz0nKgXRT/bW3UhZRsaQ+BsWyeJ1sfJliYB7wyi/SSWWPvG6LGGjCOUAAWxnSuw9YwVe0PiVlLZUFoO2GUjNaXVIt6unr+uAq1zjCr3aqbqO/jljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8zVOyI+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8zVOyI+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so185405e9.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783093556; x=1783698356; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lepFNd54cQqXRBVlPIXxlwd9q8+Fvo1D1L3GA2VK7Vg=;
        b=m8zVOyI+bhSFLekuIXITrJHVrmnk2cBo0F0Oz+pjb04r1yXCPKRXlZeiz+bXf/uvAo
         zSNcwhpQZEFh2yM/d9hz6fmM+vmxqRSJcPTi9NoyGeheuD+GHkax3sWP+32rd6vMcD1n
         Cy3WFu6TDBVGrC/4sY9U+fksduYDewRNDjbcF73F8hyWkKAHO6U2T6l1ZMwyO1IXUnXe
         Kd+AIWomzWGZfhqjavSSTJ4Dt/8X0aEd9wWusk0Pv56nVr4wwjVhfZU6sMXvrV/k8AR1
         wbZrYxIVZfjhI3uOO+lqbWhNfcC8lY7dno5oKK27d9BQQ8wl2oZP+4k4EmXfOICIDPMv
         dLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093556; x=1783698356;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lepFNd54cQqXRBVlPIXxlwd9q8+Fvo1D1L3GA2VK7Vg=;
        b=rE56yObRMkvhLJsNFrx98RWLmiB0VpWmCNf4pV+BcEVeLnOqmBTxSG3OPhSR7sHbFu
         sMxAaP4zyiOg9/0qAvrbOciT2K3EgQdCNYcvggP1u8nh4l/KNsHQbwNt3ujmHHEK5Zwn
         VBqcJr7Mfc8oBGeRUqXApM9fqug9rusCSwUJyGX2QEIApWjjy50/Lzsq1DPXJ2BVSojb
         q+0HfNRACcGqWhz33ijNJLIGRgxNiGFqpbHdWYS0FK5ts7DRr08gFN9FfV77KTlK66Kl
         kFqtYKPz49pZwPrbdM4BSnyW1dzeFS+i40U0DqNJBcjKqwpHUgEC7pktqaCPvnrJgIAp
         wUug==
X-Forwarded-Encrypted: i=1; AFNElJ/uFYYitoDTdD5FXO19Xod3oT4pIOAM+J2nzDLxBzw7EpivhRV2s3E5+Pi6LeZSvb9featwniY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzStWSnWS90Ny/7/8golEfI3nEH1YafgVO9BmlPmUSO+SyZpc8q
	svvrE9AKrSXYEtvdXw9M7ah1+kA7YUwY2IY07AODpIUKfBxQrUE+DN6R1LOGFxBOGw==
X-Gm-Gg: AfdE7cnRWFpgoy4Ac76EeMRKuDhPlu/5UUmNtDqfUGtHN1KltU4NU+nAIoSjS/BE0ig
	sReUccSQrIbmIwPw8hAqFjxhKbO0hlM3uBYWhmkyvbIyMj7Fsj9rCbBi9MWtsFS0EtP0uf0TZ6j
	AzWH2cK1u6B0FMw1NmXtnmHN2qWF9ktB2dZg3OSqrhqfT0j34mFwJ0Jd5xaatKSkkOE59DNVDLS
	6cgoWrOoAvbMS7aJ3r8DARuD8l+1zWjGoEzsjdGaFcLAoTvOYHQIPnWhkKnhYgCciYUjf0eygId
	tF+7Xhrq+d9BodgWC8neseBt0XPBsXZDGWXT3BX2gyA/f71Ftz3PlK82XlCmJ4WmdlgXhA65/jm
	jLtLVQ2hsyCji7i0o8zMKDUyj6Aj2wNZ9Ltr/Vvb6aG0cruLKOQQC4eb966vMcdxzazykEveifH
	OBz3yPsj0yy5DnM8Tw05TL5X2tiE96l9pkEs7lvAffz//XFpEGNYb9U18zyxdnAcAwKLYk7aw=
X-Received: by 2002:a05:600c:791:b0:493:aed4:8d03 with SMTP id 5b1f17b1804b1-493d1047f09mr22375e9.9.1783093555634;
        Fri, 03 Jul 2026 08:45:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm264121f8f.11.2026.07.03.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:45:55 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v2 0/3] hid: fix missing hid_is_usb() checks in three
 drivers
Date: Fri, 03 Jul 2026 17:45:51 +0200
Message-Id: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDZR2oC/3WNyw6CMBBFf4XM2pq2hCqu/A/DQqZTOj6oaYFoS
 P9dwLXLk5x77gyJIlOCUzFDpIkTh34BvSsA/bXvSLBdGLTURh5kKTxbMaYWPeFd1MqUZNAZqSp
 YJq9Ijt9b7tL8OI3tjXBYG6vhOQ0hfra/Sa3en/SkhBR0lLqqnTO6sucuhO5BewxPaHLOXz0aI
 R67AAAA
X-Change-ID: 20260703-hid-usbcheck-9163e6cf6015
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783093554; l=1046;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=o/uG1MMQxGBv8bdBWvrQTSweeOQypt00WBJoZY0FrAE=;
 b=ssPUe0jp7uYXqquaUNuVXhGkwqovqhLf2wRrnajCifvO+0O3ZE3VL7jPKr31Cf9TwVfUlUzWT
 R0AFHpdFSOLCu2s4fb7I5UjOWg4i4LFDg0uORIIKTme48wrZQeiUuKx
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

This fixes missing hid_is_usb() checks before to_usb_interface() in
three HID drivers.
I've split it into three patches so that they can have separate "Fixes"
tags, hopefully they are easier to stable-backport this way.

Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v2:
- patch 3/3: fix typo in "Fixes" line
- patch 3/3: add USB_HID dependency (alternative would be to implement a
  stub for hid_is_usb())
- Link to v1: https://patch.msgid.link/20260703-hid-usbcheck-v1-0-e80259ff625d@google.com

---
Jann Horn (3):
      HID: asus: fix missing hid_is_usb() check
      HID: huawei: fix missing hid_is_usb() check
      HID: rapoo: fix missing hid_is_usb() check

 drivers/hid/Kconfig      | 1 +
 drivers/hid/hid-asus.c   | 2 +-
 drivers/hid/hid-huawei.c | 5 +++--
 drivers/hid/hid-rapoo.c  | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)
---
base-commit: 51512e22efe813d8223de27f6fd02a8a48ea2323
change-id: 20260703-hid-usbcheck-9163e6cf6015

Best regards,
--  
Jann Horn <jannh@google.com>

