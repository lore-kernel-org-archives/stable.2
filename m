Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67779416842
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574463; cv=none; b=GzWo2bqttRXAVdqW1zQN9h3ljFFSIeaks3vZO91V9EfN62gs/3FEpIBkJirgv5xXOPXfLhCAgpQb0J20I4TTLrfSEzUMcbfvJRdDs9XqSpjFRyIT7iZDJew+i402lcP1fnNLAxK/GR3iO8GTfCm3F9d1/Q8vLOaUbqJ2e/otcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574463; c=relaxed/simple;
	bh=CnFgsandvIKLOO6nS5VkPbNNA3Th4UeOJ78xAGTfk3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvnSuHoIet52/N/J9hT8d9RzQytHyJD9Ll643T3OYWUd8P+Gea/WGJ9IOQg6NHXCVUaTVOEDW5Try0BaHdGH47pcWb418+5b624CKGI7wsDOQcYtiMSSYo+9wA1XvyRixa6ITIAlVaSsTGqD++jqQZMsEIa8R6dL+lscoalGt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POcMViAF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POcMViAF"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso19861906d6.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574460; x=1788179260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TVIAHEDU0h/Q2U6nXem5Rp2hov274ycY+NSOIU73n4o=;
        b=POcMViAFAb2SRtTUS+N13g07w0U5iNxlGDhfmRZrtGaN4voFro4CpFseiciAza9aA3
         OXnhOTtv/IUqHjVtG/D6D3UewwqF4neJZm9CQ1Y3mDU72n00MzjGHL2XTXWXDa1psOLX
         CQgwwbBQCIYpNeJRqgSVgvxS5kk9FZkz1OQ+fr/TbFwgoFarLSFZyxIBbLdat8NRB2LL
         8fbTz+OKmZVtk9JKiXYuAqty0u+BYHhvuB6jSlJ9EwrOKxxXEp1YP1KNcxwr6jjy+quf
         Z10c1/7s1m4r72jX2vU/6q7IEj2s4vGmjUWujkoSFy3tQMo7LOc1fJqFFdAmdCqWAUSH
         IoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574460; x=1788179260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVIAHEDU0h/Q2U6nXem5Rp2hov274ycY+NSOIU73n4o=;
        b=VXAugFQEbjNW9YrPOz8cHpaP7C32bX1ZxgqcFzN02Vs6a+udFwKcWyBd8gM7m+yPKp
         yI0q07yAR0OepK7QiIS5A0eqGJS5c+wYikv1uiGbM8XMgJPg8xJoPGAhR1NqTHR/leKD
         fe6SHAAU2va47OWPK19oYBQ127QbRqA/3qyWl6xp7c2lrFYPQ6iRq8qFJ0KQDjYp7IWI
         5PEnKhlqgLzIXik4+U/6cqfEhU+IEB7PbfnpBA0kJojjrZYhvSFBllQpq1H7z3/lyUWu
         pa5zyKMFkUvqsdYeAu6VhO9O7QULRyyPWTQzxJe8MwSlj2bsSm3Yahyq9fFS0l8MBUTS
         VGBg==
X-Forwarded-Encrypted: i=1; AHgh+RqFJsREioQ2Bo3uDP3dALmwB/MSioNVGGh45mptyJxQKrtwbr9EwotNZVeOTB2vkiO8bPSvDlY=@vger.kernel.org
X-Gm-Message-State: AFuF++lpjGru12BGFhCUdLQ1DIHsS5oiL++/V04EOgrb4gmLew6kgaAm
	+1Hk3OVS05IV5NgIezmukr02vL9DDVIsEt+ZvmkrJCzBZ0HLevfMEe9s
X-Gm-Gg: AR+sD104qbzhW9WSqImonZ3AvnnTyUS9SXFanwkPMwk7Txi10nmk5VzOWsqZfnQpS/u
	1SmMzKbjCvhhvMHXCDes+3DnsMQCWecr+mJ+gLPw2PZJn4iISPVuNO3OhgurMlhz7nY+uM23oV5
	XdYbNK2D+but887Ta3SkEaxQOMcU2850F3k8dQfAAaSMWd3PPXSn4KvXIRr8qK4UTdAf90otHw1
	pXuFZtMMay88PNN3aeaEqZrHps/qn/eUlmWxdB1AcGryaROIjORfiKZkMld1pYDFu31XNxY306L
	sV8/SIUSVjEAfWsHudr8mxB7fgQeYRq57saGulat723rSX4KSuFbUozxDMH7DPzJiZMSl2WKQfR
	Khtf7YdtETFR+1qiVbJ001jKd4xdb3EfjVfo5wreMK98s6rzU96W0waJshkffTJNw+RCsmUEN+m
	HBbZk8ZefIfED2vA5ItC6/eJ0cCvChQIHMjx8vfQXfV+dRQE8E7AurcdqKBON7+duKaVgo2Z1Lx
	icT/yjJcPYDyly3NYa0UUo56AqURXGhpWckWbVLPNXpZ+464ckFxoyc64yqE3uNJpSpIykI/RoZ
	oINu0njeBF+wYj7MtFvxkpszXECBhUXzL1o=
X-Received: by 2002:a05:6214:3b86:b0:8ef:76c:cb15 with SMTP id 6a1803df08f44-90c807fb516mr285594866d6.0.1787574460012;
        Mon, 24 Aug 2026 05:27:40 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a4f093sm60745276d6.37.2026.08.24.05.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:27:39 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] Input: synaptics-rmi4 - fix two device-controlled out-of-bounds writes
Date: Mon, 24 Aug 2026 20:27:31 +0800
Message-ID: <20260824122733.76321-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

While putting together a reproducer for an out-of-bounds bug in hid-rmi
(v3 posted separately, [1]) I found two further memory-safety problems in
the shared RMI4 core.  Both are driven entirely by data the *device*
supplies -- its Page Description Table -- so they are reachable from a
malicious USB HID device with no code running on the victim, and equally
from I2C and SMBus RMI4 devices.  Neither depends on the hid-rmi bug;
they are in drivers/input/rmi4/ and need fixing separately.

Both are present in mainline and in every stable tree I looked at.

1/2 is an off-by-one: RMI_PDT_INT_SOURCE_COUNT_MASK is 0x07, so
interrupt_source_count can be 7, but struct rmi_function declares
int irq[RMI_FN_MAX_IRQS] with RMI_FN_MAX_IRQS == 6 and two loops walk it
up to fn->num_of_irqs.  irq[6] is the storage of the next member,
unsigned int irq_pos, so the function's position in the interrupt bitmap
is silently replaced with a Linux virq number.  UBSAN flags all five
stores plus the read on the unregister path.

2/2 is a time-of-check/time-of-use across two reads of the device: the
PDT is scanned three times and re-read from the device every time,
irq_mask[] is sized by the counting scan and filled by the creating scan,
and nothing verifies the two agree.  KASAN catches the resulting
set_bit() walking off the end of the flexible array at the tail of every
struct rmi_function.

2/2 also closes the device-driven route into an older problem in
rmi_create_function_irq(): irq_create_mapping() is called without
checking for failure, and it returns 0, not an error code.  A device that
declares one interrupt in the counting scan and four in the creating scan
makes the mapping fail, and irq_set_chip_data(0, fn) plus
irq_set_chip_and_handler(0, &rmi_irq_chip, handle_simple_irq) then
replace the chip and flow handler of IRQ 0 -- the timer, on x86:

  =========== /proc/interrupts, before ===========
    0:          9          0   IO-APIC   2-edge      timer
  =========== /proc/interrupts, after ============
    0:          9          0      rmi4   2  timer

  error: hwirq 0x1 is too large for unknown-2
  WARNING: CPU: 0 PID: 56 at kernel/irq/irqdomain.c:688
           irq_domain_associate_locked+0x2b4/0x390
  genirq: Flags mismatch irq 0. 00002000 (rmi4-00.fn01) vs. 00215a00 (timer)

With 2/2 applied the same device is rejected before any mapping is
attempted and IRQ 0 is untouched.  A standalone check of the
irq_create_mapping() return value still looks worthwhile, but it is a
separate change and I did not want to bury it in this series.

How this was verified:

Linux v6.12.69 (CONFIG_UBSAN_BOUNDS=y, booted slub_debug=FZPU) and
v6.12.105 (CONFIG_KASAN=y + CONFIG_KASAN_INLINE=y, CONFIG_UBSAN_BOUNDS=y,
booted kasan_multi_shot -- generic KASAN otherwise reports only the first
error per boot), x86_64.  An emulated Synaptics RMI4 device publishes a
Page Description Table crafted for each case.  Two independent
reproducers, giving identical results:

  - a /dev/uhid program -- no hardware, fully deterministic, and the easy
    one to run;
  - the same device over dummy_hcd + raw-gadget with Facedancer, so the
    reports really traverse usbcore -> usbhid -> hid-rmi.

Each bug was exercised on its own cold boot, because heap state left by a
previous run changes what the out-of-bounds read returns and UBSAN
reports each call site only once per boot.

With both patches applied 1/2 produces no UBSAN reports and the same
device -- F01 declaring the full 7 interrupt sources -- probes normally,
and 2/2 fails the probe cleanly instead of corrupting the heap.

I am happy to post the reproducers, or to send them privately if you
would rather they did not go to a public list.

Changes in v2:

 - 2/2: dispose of the rejected struct rmi_function with kfree() rather
   than put_device().  The rejection happens before
   rmi_register_function(), so device_initialize() has not run yet and
   fn->dev is still all zeroes.  put_device() on it warned twice --

     kobject: '(null)' (00000000cfabc269): is not initialized, yet
              kobject_put() is being called.
     WARNING: CPU: 0 PID: 9 at lib/kobject.c:734 kobject_put+0x1cf/0x4b0
     refcount_t: underflow; use-after-free.
     WARNING: CPU: 0 PID: 9 at lib/refcount.c:28
              refcount_warn_saturate+0xf2/0x150

   -- and then leaked the function, because the saturated refcount stops
   kref_put() from ever running the release.  ftrace over 405 rejections
   counted 810 rmi_create_function against 405 rmi_release_function, one
   orphan per rejection, matching a +407 growth in kmalloc-1k.  With
   kfree() there are no warnings over 206 rejections and the slab count
   is flat.  Thanks to the Sashiko automated review for prompting a
   closer look at that error path.
 - 1/2 is unchanged.

The v1 posting is at
https://lore.kernel.org/linux-input/cover.1787549234.git.98lawweijie@gmail.com/

[1] https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweijie@gmail.com/

Wei Jie Law (2):
  Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
  Input: synaptics-rmi4 - reject a PDT that grows between scans

 drivers/input/rmi4/rmi_bus.h    |  9 ++++++---
 drivers/input/rmi4/rmi_driver.c | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.43.0

