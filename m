Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1DB34F27B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741541; cv=none; b=ame6HDVvV9tLALFP3pVNam+VNe8EYX30OGwzOPhYN2uZVpGNiKVCMpiwnSeZ0SE4ICWkkJTmqpS1u0YevZ7dIiHbSxYMvVvf091hsI0U7elU8NshIlhC7KAS+wtzB+Ri1Q4WdFYbiYZu1yN5qq1oU08E3fy+4SiHhFkxXn0s9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741541; c=relaxed/simple;
	bh=Wp1kvu8ig+V1YLF872Wz1BqEimyjpUIdi0Dh8iuUZY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p0ot5O6d4Z+VRTHzEvtcmrI/ftgKtGxOCLHpbnHrdUxy4pzzwC0t3MnhZEw/dtlCW1hBJMLgEO8hkVIarMgfKCrM21eejuhbxwVvaXYsIfgK2FRyEWn9PmPpnPOI+Vaw2OYstMTGI48UKIYY4n8Kb2kU0l6oBz6ldPAEvbR7cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovxJ+Cy1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovxJ+Cy1"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fb334e72so19676105ad.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790741539; x=1791346339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaAMebMDjZordO4zemF+dXSXfiyMj2MDwrgVhO9zTiI=;
        b=ovxJ+Cy13JIF0KOLe63RpufsLPdgneU+mG1xwXUHliQbK3icqdAbG2aH7L+vQ8EEtZ
         gdBjGKIn48X6vEqvlGH3gY0ZRLDZg3CkbrI8EXxBwKNvlbAWHlmBa+qZcCwhY4lykGXt
         1mNrQd6cH1tZzpstCpsH4X6ydMpk3h5j3bZaIkuKlybR4VpZjbffvZ7LZeI59TdDi9xK
         3ji1Z1gd6jic1tX1Ad/bmL9iSRLrPe/oHnPlFNpPzOlRysJJUuhSPo+4b4IMttF5NTso
         XT/UIZq8qDbTCxKla9Vz1nuHryq7Ct/CewL29+ylbaBgIuk8IQZ2xJdR/MBvGn3RIYyk
         2uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790741539; x=1791346339;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XaAMebMDjZordO4zemF+dXSXfiyMj2MDwrgVhO9zTiI=;
        b=mGUfq4iP4XladBg6gLlO/2NkBRghjIb2jQty5Z6Jr6naZGQT0RVxgcuYESah3dogVZ
         MdcRw4K8iCFpNlQUs/pXlKNQPEUcdp2e8fauek2y0RYypPW65G5J7DQ607jHk2zIHLUb
         QOUgk2OyuJ7XfQnIlb+UhkLz1ckytfUQzTr/1fnqU+fGYPfL1vCsglIDJ058asrpugbm
         AzHbsrsiQ08Uu5aAeOqj+vMRY4RWQZOLpGUyEbto9SuQRASEM6AzQ8TkylWupKp531LZ
         bzOFB53ZKtBquqVv4wdsmYGv8miy1dYK38ecAbJ+xgfMwz94+w+2EIzqCoYV/VovV1BD
         8lkg==
X-Forwarded-Encrypted: i=1; AKwUvBwOSQ4N/zPGZ4iduIu95Pr+ERTby8XmaWs8L7Xy41IZhRYKmDZAOZOXsc7uZccMHhox45ss0oQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmi0ULb5jWaVVR/zCE8/ecbbu0hxTNh33iHPeVxeuovpq3lrat
	QeWk0dmPBZM8Qa/Cofsbhe7O44Ww870VMWj1f2g5vCT4YLz7KxIUBPy6
X-Gm-Gg: AYBFou1eZ+fIBQHzUfiBFQfzDgt+IWXHyv40gsHa9GoIetYLcxwiTQs+/a8CQSXDiFs
	teWHsntlsTo5ry/9d0b9IXQpeqLW5kkAA7EApIz4rNgKXpgsWSNU42Y/WGnwgDiSkQo7MsmONsE
	LuITSZLhAHNOHRbhg6iUpjGnWh5ETP8i/yULzf7dtpv8izc94Sw55MR3YyKikOaB5+73Yj4P1yP
	IK94wVzjw73CsHoWH8BhWmXrsDqGhQ54sWSYRXg9K/ZT6SsmCeKKzx5SblyF333gzyIJ1dZ0bIU
	oP+bfpbgOwntclsylyP1FMdMqzdkerw+fXexkHDg1QOdeGLMJH+btVpGXivSBEOoY/nJmNlsjfn
	VR6k0KDIuyb5V1aYeOUulwK143qy1xk8DcUZbTDSomZ/meZp09J7a9MM8EnK3GLmc2O+V2THGKZ
	B4iMOSEdSZeO6obFPINf1Wve0VshMHgwlEk7qLhIfRQ2IBp7UNuupxtr1uOIuB+Gr0/ZRkRi8GM
	3xSd+CBK4N6i3yL7PejpsQl3WAp6zBf0KMqatKNdASe2yXuTkLqXeTJHdZjOq8QNzWWDRC8xPQ9
	0LpyAvTY0c2Ch/TqLs9U
X-Received: by 2002:a17:902:cf4c:b0:2d8:de9f:9a44 with SMTP id d9443c01a7336-2e2e499dfe0mr1806435ad.19.1790741539055;
        Tue, 29 Sep 2026 21:12:19 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c4a240sm160065ad.81.2026.09.29.21.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:12:18 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 0/3] serial: fix IRQ chain race, baud fallback, and uartclk overflow
Date: Wed, 30 Sep 2026 04:12:13 +0000
Message-ID: <20260930041216.155911-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes three bugs in the 8250 and serial core drivers:

1. Hold hash_mutex across IRQ chain lookup, linking, and error-path
   unlinking in serial_link_irq_chain() to prevent a use-after-free race
   with concurrent serial_unlink_irq_chain().
2. Allow a third loop iteration (try < 3) in uart_get_baud_rate() so that
   when both the requested and old baud rates are out of range and try == 1
   clips the rate into termios, the clipped baud rate is evaluated and
   returned on try == 2 instead of returning 0 and causing a divide-by-zero
   in uart_get_divisor().
3. Reject baud_base > UINT_MAX / 16 in uart_set_info() alongside the
   uartclk == 0 check so that multiplying baud_base by 16 cannot wrap
   around in 32-bit unsigned arithmetic to a small non-zero uartclk.

Changes in v5:
- Rebased cleanly and tested for applicability against tip of upstream
  mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of
  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux").
- Dynamically verified all 3 issues in QEMU KVM with CONFIG_KASAN=y against
  unfixed vs fixed kernels, adding explicit test methods to commit bodies.
- Patch 1/3: Updated diff to align with upstream guard(mutex) refactoring.
- Patch 2/3: Trimmed kernel stack trace in commit message to 4 key lines,
  as suggested by Andy Shevchenko.
- Patch 3/3: Collected Reviewed-by from Ilpo Järvinen.
- Re-sending full series as a fresh standalone thread per Andy Shevchenko's
  feedback.

Changes in v4:
- Patch 3/3: Check new_info->baud_base > UINT_MAX / 16 before
  multiplying by 16, as suggested by Ilpo Järvinen.

Changes in v3:
- Patch 2/3: Collect Reviewed-by from Ilpo Järvinen.
- Patch 3/3: Add missing #include <linux/limits.h> for UINT_MAX and move
  the new_info->baud_base > UINT_MAX / 16 check to the uartclk == 0 check,
  as suggested by Ilpo Järvinen.

Changes in v2:
- Split the 8250_core.c and serial_core.c fixes into a 3-patch series,
  add Cc: stable@vger.kernel.org, and document how each patch was tested in
  QEMU, as requested by Greg Kroah-Hartman and John Ogness.

Hui Peng (3):
  serial: 8250: hold hash_mutex across IRQ chain linking in
    serial_link_irq_chain()
  serial: core: allow third iteration in uart_get_baud_rate() fallback
  serial: core: reject baud_base values that overflow port->uartclk in
    uart_set_info()

 drivers/tty/serial/8250/8250_core.c | 10 ++++------
 drivers/tty/serial/serial_core.c    |  5 +++--
 2 files changed, 7 insertions(+), 8 deletions(-)
