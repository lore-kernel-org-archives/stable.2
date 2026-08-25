Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252A3B2FCD
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638234; cv=none; b=LzlZCz8lyTQwQ3q37C5SjseolTu1Rwsdg9m9JZXno3B7LveApCAWZQU3yr75LbjjydsewneDjj9yEkTnhiJdxjampGJa/IIgHK2stTiZwuCwLzQZUtzkNkXIvCkwkWR6MuX+s6bo/cOGYkJ+GstCXFaaZCN5wkEtWNmLPNBrNec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638234; c=relaxed/simple;
	bh=DBF668l9B/7yP1l8Bq8o3mRzzEWoot6ovlsfJLxgj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F116Mm10cIo4uReDS/BwIQX0634VbMH1rrbtDlWHtOvOKJOZE8BHf4U1m7TZy51sAnTGPLFV5R+fHsSvOIP4ukUliRAp7wr5Zfjby4ExNT2a9DFlR6AnjE6ihRBAIxEOzAwJr9LneN9AVQY5aEVLb+SN2B9aw8v5aBN5Mgd/R2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjd4crZp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjd4crZp"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6f55a7089so2342715ad.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787638232; x=1788243032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8+6TIhz1pRamzT0kLtU771dhQEvC1j+KiuM2eJGbpM0=;
        b=Gjd4crZpPn5n9v7K8OJL02ewaqZ0BkzMIphLgELXpKAWPaSqUoQpyNeHUerEBKQnAX
         bNDnDcsVx1PsFx592gx0jfX32VJ/G7LekrPkdmCKMAGjNVJFBkSC5tyKXwclYzUBZ0Tp
         JuuwMmLvhVJQ3S4o7f2HlhwKxQjnDrdqMH7PZcFYPBwPu2668u5L0BTK9kAmORfYXZkX
         0F7ixsCImKSceZhLBbg5lDQ/OZhlLhuUJibIImafjFw4S0JwptrxRDzbrjtA6Yau1HfT
         TKyVe/Jkp1aumCwgUthaG1H7vJE6spF+llSj3DZskxenuXqe1HVXpxNFAxGu570YBXry
         3yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787638232; x=1788243032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+6TIhz1pRamzT0kLtU771dhQEvC1j+KiuM2eJGbpM0=;
        b=l1LFhiJrmr68L5FeHBjh+yTgtiwy3eZoqw6WiTd7FNgIK5exDlelgEcK4ysUS9Ss5u
         GKGQnbpJB6slwQTLXuPKBwhNSr8v+QQW+dxEQYBHIQ2L2Cg2YGfyWUTsYMQ8GLRBgsxp
         2Muq1Ln+fQc08CErtC8DsvQkcWmN+BCr0NHnyuBqv0ag1NvoeXOO+5oth3t4lofl/VPw
         oaaOhi6eethI72FUfn/4J31OgGZ/M2+BcWAu18qu0Xr6PHbi5knyEL+1/XgHlHFQkH6f
         qPGvW4FgqetlLWd/FCTJ82pn6TMGy2FhX2NWYypJiX/glvqG11Bmjy4rEHJuNa0R0HTr
         NQcQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSEqs0MwESrsp+ERPAC0yInnnUMTnklNSlPlRA5Tq9LXiTEE9vrepaXKquN1YkQcSf2TDLyKA=@vger.kernel.org
X-Gm-Message-State: AFuF++kJkLdrxtyfSEjbL7uy/zYfAdVU2UmhSeRock7jb/tm6PmXO5c4
	27Qa5nh65YbEyiiZztWiIuhw2VAer/Y51djihBVd2WMCaUaFtuQGKR5h
X-Gm-Gg: AR+sD130EKCThm06LV/aET50jmIrBWHkofsp5eGaNmXxXhFt59/26ieQElD8+5n/rsQ
	KP5QeoNLACXH48QROx1wOq3aGUZOjSViIT+mD2rIJDkkEkIyr+VUHvyd5+KccJKf1ja0EyPn3Ln
	wlUuaI5Lk6pWRHqABVPcbMD8zcZKc6g0pU088eVh/GaE3TpniLpkTJL0j7Xs9208P9YD3K8STH4
	w+EKSCPkA2JdBntVHXpeJKxp78R2+hMkitEZQ+e4Z2SBu82RP5kALta1aoopnyx8wL9mga6v9aq
	z61PW3xDumZL6k1g/3o10czXblsqvR64xpFGH7V3Iw/9YAbh19FARdMAHC+ktRtpoSthB/q9HHZ
	bxaSyU50btpdBincHPXzMY6EmxamS8THVX2itobjjfpRALC7sCCuNzrWk6h/5sJtlOIALL+7mDI
	FFUTr+dfWNwlHp462T4WyGjI8vNA2HUdX7h9mE8RQEzKRaSn5zHWG52OX6m+buSh9cY2D6qVpPo
	ojbe+HZx2gUKFT9bSUPl4csBIWBDHpCqBxuaTvGW7G9vlNGdGZGF2EviW8lMucb8gdsszlKkD2W
	HnebtDFmpTdZJ1XgKx65acWp9jQXSw==
X-Received: by 2002:a17:903:350f:b0:2ca:e9dc:7357 with SMTP id d9443c01a7336-2d670d1ff53mr450905635ad.9.1787638232368;
        Mon, 24 Aug 2026 23:10:32 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676408147sm23954825ad.0.2026.08.24.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 23:10:31 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wei Jie Law <98lawweijie@gmail.com>,
	Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/2] Input: synaptics-rmi4 - fix two device-controlled out-of-bounds writes
Date: Tue, 25 Aug 2026 14:10:25 +0800
Message-ID: <20260825061027.105062-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Hi Dmitry,

While putting together a reproducer for an out-of-bounds bug in hid-rmi
([1]; a v4 fixing a hole in its own error path is being sent alongside
this series) I found two further memory-safety problems in the shared
RMI4 core.  Both are driven entirely by data the *device* supplies --
its Page Description Table -- so they are reachable from a malicious USB
HID device with no code running on the victim, and equally from I2C and
SMBus RMI4 devices.  Neither depends on the hid-rmi bug; they are in
drivers/input/rmi4/ and need fixing separately.

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
and 2/2 fails the probe cleanly instead of corrupting the heap: three
consecutive runs of the growing-PDT device give three rejections
("F40: interrupt count changed between PDT scans (pos 1 + 6 > 1)",
"Function creation failed with code -22.") and zero KASAN reports,
against 14 from the unpatched core on the same boot, with no kobject or
refcount warnings; devices answering both scans consistently still probe
and report their real product id.

I am happy to post the reproducers, or to send them privately if you
would rather they did not go to a public list.

Changes in v3:

 - 2/2: reject the function *before* allocating it, rather than
   disposing of it afterwards.  The v2 kfree() is correct on today's
   stable trees, but it is wrong on mainline since
   commit 58d42ec10b73 ("Input: rmi4 - refactor function allocation
   and registration"): rmi_alloc_function() has since run
   device_initialize() and dev_set_name() on fn->dev, so kfree() on
   this path would leak the
   name string and skip the kobject cleanup that device_initialize()
   obligates.  put_device() is no alternative: on the pre-refactor trees
   the stable backports target it warns and leaks exactly as v1 did.
   Checking pdt->interrupt_source_count and the running total against
   data->irq_count before rmi_alloc_function() needs no cleanup on any
   tree; the error message and the -EINVAL are unchanged.
 - 1/2 is unchanged.

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
and v2 at
https://lore.kernel.org/linux-input/20260824122733.76321-1-98lawweijie@gmail.com/

[1] https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweijie@gmail.com/

Wei Jie Law (2):
  Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
  Input: synaptics-rmi4 - reject a PDT that grows between scans

 drivers/input/rmi4/rmi_bus.h    |  9 ++++++---
 drivers/input/rmi4/rmi_driver.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.43.0
