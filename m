Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049A374A1B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653890; cv=none; b=XmMC1zo1r4ce+NrtcxpYTUqCBadf2BzL6poVJ2Q6OFqqiZiMN+yLP/UijmZbcfRtVAIGDu767pVn5om7m5jRKb0BiYpCvRqgRVaV+twf7MzKT6LAERSmaPIojkW1OrkmeVykpd9fgoVXBk17zL4wf991ehhpzr7Yarvlplb32js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653890; c=relaxed/simple;
	bh=ecRH6f3n0A9WCcmmqyQOhhX8KcRsly/b46bpVYvnjCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIYwQLqsCUJ1RaKMRIkLrHTEhpAWWglXIOU7F96Oo0fltsrPjG22VfVpDKkYG2jEcCov0eTSOiza48/B8SlRWyscF5qRXRLh9kuKjQmVfXMSUVEJfnE3OWPknL24uLNuw0CjZ+TGy9sOx9PHh7wfV2qzmOHPX9M0qktu6AXtWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRD4tzeM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRD4tzeM"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso5218874a91.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653888; x=1788258688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=REATS7voFqoNywzV30mao+wmg6Wfq4WIq8H9i3ieVWg=;
        b=LRD4tzeM+tJBR7DmiasmVAzNNFKdIstffzCkCMJRZ0J11/dpQPXYjXgKqTpN8vL/Gg
         eq1VsZZweUJbBKGzQF2/pjzAL8OFHGfrmBojS6Povx6H6Z0dNwkU0qRoMZB35QA+JSf0
         gdOCeMnBsIgMtZKMojAFgMPbiO3D34UwOSUaKzCe272LOFfWUxhYcap4Y29iSGPEcCoL
         s51IIVJlFdBg8dkiOzEX5OiR7o+kCqGlNZSQmJH0bkw7k7GFJrKBnzipA0swC8pY5E0S
         FsojJe5uMotw3xRiOKgh8u22uI6GwPDX/C1sO9qsPMEcACCeaps2TT+ERrUWEGr93XWc
         K8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653888; x=1788258688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REATS7voFqoNywzV30mao+wmg6Wfq4WIq8H9i3ieVWg=;
        b=rIhOEwoj2f6zHAvjpYKnm8RyVnS3y5zGT+whZLq7AUDGqeQ6V/7Hit3UCqy3Xs96lE
         ze6WGIdDTz9Ee1mp0JtK5WIUX7Ymy7FmwtFhQXfz7SL9fhYy2d2EsU/ayw4Ca3q8fwQj
         58eQaLlnZzlMkIclff3wiKq6KCG2+Pkxe2YhZPRXGfG56SGgxFkr6VI3WjJ/s3zRVDsx
         M077oJfWorOkL8ZVO34i+wQAxj+C69ZihYrr8lGx8iiY2oym5h4YyzKVpMi/fcliFgHg
         0ytBKXWoE7Xz//6LQ2nZlhv+fz508l+8cOuhjXu1E8FB/pMgEmAXmVhtbi3jLkvfnynO
         5gmA==
X-Forwarded-Encrypted: i=1; AHgh+Rqwj3lMUTbSD0sQHog44FD71nGeFlSCooDK1AomrckDKCeRyC93Y4lx7GqJ+dbEWBNZAdUd0pE=@vger.kernel.org
X-Gm-Message-State: AFuF++lm482zItjZHu34aH8Mqc7ZUvnXhtp3UQlEv+IDuaw5v6+fmkBm
	84pUKlN4GF4K6F64pi/cGH5haUpks4qb1mLxqslPpv0adyP24nP/sk/w
X-Gm-Gg: AR+sD12txru1XSq7Jv1SayMngb6tNVUFv9tEjtMlKPSmWsySykhlJUsX6HD/U/Gymt4
	kgDIDIffQw5nDvH7uOqeKbOp4gl3LDznb1h/mqLA29GUc9pnkMLikRgzi15kvtG342NJMNFkLO+
	yWcdTq/uiakQNuC3hJxmldoZ5FHOWHxM5KblyyEHlakBw67wBiMeqpKCHYC7rQ6yoM42Y8xRGxf
	1qls7s0E+XF3s2mJkUW6Iyh1orSMi436155H/RKRLd01xAbtOkw9McESviGZ15UZioHAcJVe2Hb
	M9ebMkQgBmV3lM8iycx8h95M3YnJfyOWtiChmy/s/wBJJd5byQ+REsAroQQO9+y7lI/yC6lkcYf
	JM2BBEj9XyhtqP1WiUfxV//wTTb+KBEr9xYd2cEqlukU0J6n6ehotp+C89SXiID9BLtCVGvGRlV
	kPIyV2i+is6h5H1H2WwTwYB9yovGGU0S0PQ1ICd7Prl9CiyNawYJYlTm3lf4kmjjWyj27QH7+jO
	lB9eHVBVmY7D3iY0lu8SudzfWGEal5uw3pjj7TVWEYOBdkcWwAtYd1UALHmc7s2EQJO1ERUU26B
	JOlmvF557AsFS9dAuHHqzxXD
X-Received: by 2002:a17:90b:33c4:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-395c3552287mr59229276a91.13.1787653888365;
        Tue, 25 Aug 2026 03:31:28 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e8csm3244968a91.9.2026.08.25.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:27 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 0/2] Input: synaptics-rmi4 - fix two device-controlled out-of-bounds writes
Date: Tue, 25 Aug 2026 18:31:21 +0800
Message-ID: <20260825103123.12216-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

v4 is a tags-only respin: both patches carry the Assisted-by tags that
Documentation/process/coding-assistants.rst now asks for.  Neither diff
has changed since v3.  Sorry for the extra round trip.

The rest of this cover letter is unchanged from v3.

Two memory-safety problems in the shared RMI4 core, found while building
a reproducer for an out-of-bounds bug in hid-rmi [1].  Both are driven
entirely by data the *device* supplies -- its Page Description Table --
so they are reachable from a malicious USB HID device with no code
running on the victim, and equally from I2C and SMBus RMI4 devices.
Neither depends on the hid-rmi bug.  Both are present in mainline and in
every stable tree I looked at.

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
Page Description Table crafted for each case, driven two ways with
identical results: a /dev/uhid program, and the same device over
dummy_hcd + raw-gadget with Facedancer so the reports really traverse
usbcore -> usbhid -> hid-rmi.  Each bug was exercised on its own cold
boot, because heap state left by a previous run changes what the
out-of-bounds read returns and UBSAN reports each call site only once
per boot.

With both patches applied 1/2 produces no UBSAN reports and a device
whose F01 declares the full 7 interrupt sources probes normally, and 2/2
fails the probe cleanly instead of corrupting the heap: three
consecutive runs of the growing-PDT device give three rejections
("F40: interrupt count changed between PDT scans (pos 1 + 6 > 1)",
"Function creation failed with code -22.") and zero KASAN reports,
against 14 from the unpatched core on the same boot, with no kobject or
refcount warnings; devices answering both scans consistently still probe
and report their real product id.

I am happy to post the reproducers, or to send them privately if you
would rather they did not go to a public list.

Changes in v4:

 - Assisted-by tags on both patches.  No code change.

Changes in v3:

 - 2/2: reject the function *before* allocating it, rather than
   disposing of it afterwards.  The v2 kfree() is correct on today's
   stable trees, but wrong on mainline since commit 58d42ec10b73
   ("Input: rmi4 - refactor function allocation and registration"):
   rmi_alloc_function() has since run device_initialize() and
   dev_set_name() on fn->dev, so kfree() there would leak the name
   string and skip the kobject cleanup.  put_device() is no alternative
   -- on the pre-refactor trees the stable backports target it warns and
   leaks exactly as v1 did.  Checking the counts before
   rmi_alloc_function() needs no cleanup on any tree; the error message
   and the -EINVAL are unchanged.
 - 1/2 unchanged.

Changes in v2:

 - 2/2: dispose of the rejected struct rmi_function with kfree() rather
   than put_device().  The rejection happens before
   rmi_register_function(), so device_initialize() has not run and
   fn->dev is still all zeroes; put_device() on it warned twice
   (kobject_put on an uninitialised kobject, then refcount underflow)
   and then leaked the function, because the saturated refcount stops
   the release from ever running.  ftrace over 405 rejections counted
   810 rmi_create_function against 405 rmi_release_function, matching a
   +407 growth in kmalloc-1k; with kfree() there are no warnings over
   206 rejections and the slab count is flat.  Thanks to the Sashiko
   automated review for prompting a closer look at that error path.
 - 1/2 unchanged.

The earlier postings are at
https://lore.kernel.org/linux-input/cover.1787549234.git.98lawweijie@gmail.com/
and
https://lore.kernel.org/linux-input/20260824122733.76321-1-98lawweijie@gmail.com/
and
https://lore.kernel.org/linux-input/20260825061027.105062-1-98lawweijie@gmail.com/

[1] https://lore.kernel.org/linux-input/20260825060954.104890-1-98lawweijie@gmail.com/

Wei Jie Law (2):
  Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
  Input: synaptics-rmi4 - reject a PDT that grows between scans

 drivers/input/rmi4/rmi_bus.h    |  9 ++++++---
 drivers/input/rmi4/rmi_driver.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.43.0

