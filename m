Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75B3E3D80
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792366032; cv=none; b=Rm2Ulgxya6LCOmH8LKgpu/XbCqF3b3/B82iWtVCtCdlulONZZfngNDO8/Sk6bTsf1QzI3pWYfFyBfBk7OvX9GHx819wyVgTedeKUqGO5DGeJ68Wo3S3CCaToOW2nocAfaxlS3HxAfXbf7VTelicAzwf6+YcR7hOhV3YaD67Zgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792366032; c=relaxed/simple;
	bh=2KCYfLt5qJEmI2+WklOncv4iJAcjrI56HEp0rR9tV7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUeXM5Gw3hdnoXIfzwTVbbdcuGPw/D/xEEoumGUBWMutaiRTcyEwAmXQ61InuYzZezbCFWClLxA7lY/Ezelw58p5IPVWa5V6xv77oX6/7sx0LoCmX3MiEepDYkVk/NfmZACJemnjxAd202sh+9tlZsezQQbiKWBGqZbBvYh5Xjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgZaHz+D; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgZaHz+D"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3815633eec.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792366029; x=1792970829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5TdL2Y2ZbBg8GY/uY0EyJ065wBCuX4tK3r2mB1aNq4=;
        b=KgZaHz+D08IdWnVzWH67c1oxo2wjsiCe5c+KnxaH15G1S2lzu6sHAk2GHeB/riBYUU
         ucTNFFgwCYr658NWacdCcQ9yP13+47qQ4t6maG0G4kufpH3Z0IQ3epki1945+PBqeHQP
         Dbk751bWYhw+2HMMUctj+nPuv8VcooZkf81TSQNsqHcxUYQaG5T6IikOn8On+KfDtfyZ
         fD3O80CHF6+wfrFNapUwtWr+GIQyoAqqkZeq5dcQVixBmPXG9LpKwIpdYFdEa6DbAvj/
         89BLAXDfRkN9FSUBwhiHvJx7xL8L64a8dY3oKL5eAqr9ckIiEGl6VUIsD6cV/EduHaK4
         Jh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792366029; x=1792970829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J5TdL2Y2ZbBg8GY/uY0EyJ065wBCuX4tK3r2mB1aNq4=;
        b=ARCaQ6yp+32jHyKzH9CAudZ9L7xmE6erx20ySi5Jx9cPI0tTftd8CHNjHRC2aUxVgC
         fIzKdS5qJTNIHbwU1Z1AwyPhmKXy0dYah3tqzBxFAuKozo58j4xkjD7sxsINvm6s2ROR
         ZxW+zbQOUuI70Aqx8vPaC76diZEH1Mr90BFC3ZmOBfhMiaB/VArp7m+pBEQujchwcDrq
         8i8eMHSK4RY7HQWQfG5y/t+LND2b+wOJMsQ/X0OdqYJPlhQMJZPa5aA3VcjNz3M9CRZE
         zRtYyyfLYflbM511iLvFVWl4jGYInWzKe+VcII49RbKzCMCk8PGm74pBc2UcmhiACQ7d
         V/FQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZ1Nm+i4Q08MDKv9cPZPUrMN+3k7/uVwPGTI3Pzv1oCLCRnRDZQX0Ye/XobhFPEJyoYX1eE5U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfGAVxSMFPXx6TrCazOtS4sQwneiEnwGpA4Pe9PM1CvLlAGxMK
	TZHdla2JI1l04vJ1MrnDvjBufvRjIy8d+y5h60Jow4GRredfIuRPmgRf
X-Gm-Gg: AYBFou3ks+pFCYnOPGuDicBY7vjTTnKCe/06JRxDs5VfFvvRjHktTXf3x5zBtMgfR+a
	Pgq3QFO2VaGY0K9CVnU0WnbC0ECCW210XAUc5y0BX20LGA/jo/ouomEz+I00US1GxQlQRV6tPlR
	ZFWu07rd6RbgGG4ugkoTY9Oz+QfJDriwHkvkegfqIjCieEtjjuIlOrv2mQaCMFER8liOjLkDWDO
	FclR0g/Lzu1/MUcCnXoEXMv7kTPAviRds9M32svJ8d8eoSDenpF7rvC2guHNbjRsfQOLts/R5wK
	4e1ZPk5AkSkEy/n0jh2kD4YIjxoygOfJ3nBEH2QwZdE0sbO650qSz4gDTqMLT1HyBDAkb4I+CxB
	whjE7H+Y067d0xcIXS+tFU6nl0MEO74m5x8vcR/hUjgDwGylsZSfRoFdWtucB8qjGlAHW8i3+w1
	eLmQBZuKrQ+C/qGE22ktlmbqzVZoqC8XoRqMK58c7HXnkV2PwcG8pT5hig6PX14TRbUOcQO4kL+
	Gv7J1cyuRyNM7B9etBpcMwYew606rvPzvMY7kW4YQg=
X-Received: by 2002:a05:693c:884f:b0:35f:2858:aa4b with SMTP id 5a478bee46e88-361a2c36e5fmr8217730eec.30.1792366029272;
        Sun, 18 Oct 2026 16:27:09 -0700 (PDT)
Received: from siegeengine2 (c-73-158-156-210.hsd1.ca.comcast.net. [73.158.156.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm25571908eec.9.2026.10.18.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:27:08 -0700 (PDT)
From: Mark Pariente <markpariente@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mark Pariente <markpariente@gmail.com>
Subject: [PATCH v2 0/2] HID: logitech-dj: Restore device configuration after reset-resume
Date: Sun, 18 Oct 2026 16:26:52 -0700
Message-ID: <20261018232654.70571-1-markpariente@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018224627.60328-1-markpariente@gmail.com>
References: <20261018224627.60328-1-markpariente@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Unifying receiver is reset on resume, for example because a USB
KVM switch moved it to another host while the system was suspended,
devices that reconnected in the meantime lose their configuration. The
most visible case is HID++ hi-res scrolling, which leaves the wheel
about 15x slower. Patch 2 has the receiver re-announce its connected
devices on reset-resume so that hidpp reconfigures them.

Sashiko pointed out that on Unifying receivers the re-announce can also
hit slots without a known device, and that HID++ connect notifications
then add those devices with an incomplete report descriptor. That can
already happen today, e.g. when Solaar sends the same request on
startup, so patch 1 fixes it separately: on Unifying receivers, unknown
slots are enumerated through DJ notifications instead.

Changes in v2:
- New patch 1/2: don't add devices from HID++ connect notifications on
  Unifying receivers (reported by Sashiko).
- Patch 2/2: code unchanged; the commit message notes the dependency
  on 1/2.
- v1: https://lore.kernel.org/linux-input/20261018224627.60328-1-markpariente@gmail.com/

Testing:
- Both patches applied to the v7.2 driver and loaded as an out-of-tree
  module on Fedora's 7.2.11 kernel, with an MX Master 3 on a Unifying
  receiver (046d:c52b) behind a USB KVM switch. Devices enumerate
  normally, and hi-res scrolling is restored after the reset-resume
  reproducer described in patch 2.
- The unknown-slot case fixed by patch 1 could not be reproduced here,
  because this KVM switch fully disconnects the receiver, so it was
  verified by code inspection only.
- Lightspeed, Nano and 27 MHz receivers were not tested; patch 1 does
  not change their behaviour, and patch 2 sends them the request
  logi_dj_recv_query_paired_devices() already uses for them.
- The investigation, patches and changelogs were drafted with an LLM
  coding assistant, then reviewed and tested by me.

Mark Pariente (2):
  HID: logitech-dj: Don't add Unifying devices from HID++ notifications
  HID: logitech-dj: Re-announce connected devices on reset-resume

 drivers/hid/hid-logitech-dj.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)


base-commit: ae6927c533a4454570950125ca8ba909c45f20f9
-- 
2.56.0

