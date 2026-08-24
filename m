Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9CF3DDDA3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550621; cv=none; b=K4u20mxNnQfK5UfHEZAmE1VoSAMq76BTX+M+q3VXcwLaGHtVezqhkiZ91CrMhUpyMlveZikBrAik+wPFI2DVRmo2sTwf2E52JOGqmdH4XZZvr3ewzVN91VoWJc4pvuxPbc6FG4wtcukliSJCJJwM6kplTNYP+aC04ZIJa3416Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550621; c=relaxed/simple;
	bh=LKqlCrOkqJ+yHwu2xim2fGa59Ex5ZiUy4lgPkuA0YTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKzQgeqSbEfGC6lMCvKWMdj0DO1+oJmd7Ho3Z4XzALGU1dO/DdeCtCPOl8MoD6yZVj6apaKdzvB51dYWBKeUpPQIxkkOS6Odupps0/VRRhMFW8n8J0RK9GUR6xcWR2mSqTW0MR20fKyHGc1coIkOtjRc7qhrOl9o5AnFRUE8PAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B67zjBf9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B67zjBf9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d049069377so25494245ad.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787550619; x=1788155419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yVJTYkkQH5gOYluDI9SFf2oC6ea5cSp1/xayNBayQbA=;
        b=B67zjBf9VJl3XAm8DN9pCoYI14czMxp5k2G+0lTHP5gx95MFSXjP9HlelXpiGolJn+
         eVeL0MV1s5uGNuIVrU5RrlJelx1sBawTZouAxb5YYsdF5YXQ+d3F21+mbwu0d03njO+J
         JkSZ4FYL7THUUYdD9BWOMDvUuFnTIKM7Dd55++nUI391sQE4ibWFQTNnHTnvX65wTCBO
         JM9jxEG8kGPK95Q2SyHmrClcPDE1LePg5zptmNPvY6nly7J2exSuuhqIJ+xfOYGtjLgU
         EiXaUIIaK1X8QKamqzq+Xo0iWZk1t9PPOe6NACNie0xjYA4CRs8TNmEdtP/1tIv/Z36+
         V+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787550619; x=1788155419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yVJTYkkQH5gOYluDI9SFf2oC6ea5cSp1/xayNBayQbA=;
        b=bZAwuXnhhZOie5gcBJjt81jmfAw7G88iTdgysqjXSrR/PCHDMjBsHqxCdKucrolrJ1
         +vaiK/jt+L64vydRgO0EQ1a856PubPJuX8I7nLEBVJVtGxHNOCYnEhtZd7abcgJ37GIn
         kf3P00/ILSthbN7eQ0MxRz7uvzS8Rf3gC1LH7Xhb/mw6cBc4gs3TpWz3IefzIqRwXsi/
         +CjSFWAytHWRpejZXmjL02HMn4BvP6QTHnZWnCLHhKJuAL+v2ym+I9uGyfn6uOBpGJ2U
         u1E7DszJM1e+3Iz3HRYNzuW5eIGkA8mOIMTx+mtAkrLSRqKx5vidyerlnEbW9KLeh+b0
         Kswg==
X-Forwarded-Encrypted: i=1; AHgh+RpD1bG88fj7IptGi7T56+pyIoKLEcYOhSV84TCMt4jSJVPGEnYcwGGB58bRZqc2vkLHyoOthWE=@vger.kernel.org
X-Gm-Message-State: AFuF++kgvnx3IKAK5JZdVcshtrGbdVZbmWseI9U5MWeRofmgRIW4ogUs
	7/5nunbTBkYitJdlLHieWd9RyeJQx1R5OjDkW+W/WH9KRg7CZHFKDPIfwzu5gWVv6aY=
X-Gm-Gg: AR+sD11Z2UeI7679CtikAak4ed1pwPUo1Da3Lrdvhp0By+xKv9KOxk3vtSVQItauzuv
	c4A4WgnHZh75f1e4WF2bf+UJZU4ujIP3T9MfLKRnDsVyBxK5j1kWwI71RUS+X8b4j6bvdTteTXU
	aPJtrUvXIgFpOvvnue/8IBjspc84PIIln4Hy6psGMlVH7+Iz1X/6pVhyOHkRf1k81FgjJGhMXOd
	w2/OLe5S2TCYbz17JnlOoLR0hdK/OuhpTZ9+ISmCGB+IAJ2KWCSzpBvxhub6uJCZUPgFaR+y52R
	pWd/mW/K4RMPy6cKZKQrWQNwJv0H4tpN1MwjH0ujqpswh8ObYnNtz7Jky9MLzNLsOUEBxas/m09
	KCRu+SGhaB/fWOp8YPHutKAfQUgl61N+nQAKCwnbhHwR16LlQi46WiVnTWo63BiALdbahiH6Oug
	0Hdn9/AVzoyJeaVrjWs3CZ015FGptY0D3nfiKNxUeImHtQgOFsPj3l98f001zQuPMmmW8fuA74A
	mAaH6+fgIOI+z7UyhH/F6TpEzSsHJ/chwS5Cc2bE1nTVVRaWHwHoAOuJRFzHTanxGUstVBhce13
	JOjUwWdupw2JQ/mR6Bgx+V185Xq/zYdbvQY=
X-Received: by 2002:a17:902:d544:b0:2d3:a6db:299 with SMTP id d9443c01a7336-2d64adec78fmr462478795ad.6.1787550619067;
        Sun, 23 Aug 2026 22:50:19 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768c9876sm13955655ad.68.2026.08.23.22.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:50:18 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] Input: synaptics-rmi4 - fix two device-controlled out-of-bounds writes
Date: Mon, 24 Aug 2026 13:50:10 +0800
Message-ID: <cover.1787549234.git.98lawweijie@gmail.com>
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
(v2 posted separately, [1]) I found two further memory-safety problems in
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

How this was verified
---------------------

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

[1] https://patchwork.kernel.org/project/linux-input/patch/00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com/

Wei Jie Law (2):
  Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
  Input: synaptics-rmi4 - reject a PDT that grows between scans

 drivers/input/rmi4/rmi_bus.h    |  9 ++++++---
 drivers/input/rmi4/rmi_driver.c | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.43.0

