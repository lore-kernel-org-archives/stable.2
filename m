Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FA2248B3
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245828; cv=none; b=MsrNvqNYBsSjQtRAdC3NGY9MiUEmm74L4t5ylwtmZAJzs6hmCZGxERZl/0LrisbOBE8BBCqC5UzZpO7cyMaGw5d8MCWUkKFYyHBNksGcc9rP3EjByGmaajpKVFBWAgcPStE9aUNKnmV1qG+gRQKLDK194hmd81uqkeJ1zumkbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245828; c=relaxed/simple;
	bh=Ipy4jjW6gaWuEzPanC91sb5Z60RjQ5DQx4uG0hnW7AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYl/X8ltcyYP1yXgUZmnbEZlpH/4zG6A1wMYBblfPlBCOw9XGza2KZ9Ns4v0aw21jS3Rz0TT0mG8K7pkLQGFYccF88Rh1wfzZyT+nH4sU+R7z/EXKuRlkmMCPyaevfUAwLCzECk19JBCOyU+4W8gfoe9E2xzv0YIxMRUGlP2vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUWel9es; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUWel9es"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1635597eec.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792245826; x=1792850626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=js+mUJzMMvVUHKyI3sEc56QXGWR7/Maia0gNSzvmDKk=;
        b=jUWel9esvVxhJpIaJ+McShb0DGZzjCF7Cj6cRFFI93uj9cYAxakCI0t5R0xaB9Dh3d
         2m0GmBguYK7GsfQfbp1X4FGhmPsNfd+6K00N7ANr4MLED6ocwExVZVgrTIitugv/Jb1g
         QFBvE9orlx8UTkIE6F4adFPYv6CWh4heyBLqPZQtX30A2PfYB1HHzJ6zskQvlT1H9Ywl
         kH3ZLBIpe1tt0ffOdFv1+2bQnUSG97tgV2cXmnw6rKSeEQC08l5zqY6BvI6zHzzX/sCv
         3VKnnRCh3ry+ZR4bIuTNe7OnEeoMEUoNQTVWZ6HUJqQtwyLpfLcq/DyDjx4sIZXmU8Sl
         iHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245826; x=1792850626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=js+mUJzMMvVUHKyI3sEc56QXGWR7/Maia0gNSzvmDKk=;
        b=L00C32Id3qQiLSI2pbyGsYv2ZBu2LJuz2J/HKiHSZ8m6PevtfkciG2tBCOV9M0Pvts
         QwqcYlhIGGX0Od/XZLBctGIJtxByj+WKWHN87CRFcqOMf/ajSMF12MjOCaVa9rxFissv
         rvhfsTKeNpKAXzE+2LbRG+O99dyWi6Im9rtH9iSakQ1+CTEf1OAqBtPDguEdBbhIir1k
         VtB+dgcDUIB+Dzvx91PhorrzruKJLmPle62QqkVNgtzQgGEv6Azz6HnuL1mJJOlviaXM
         UxO4GWhfLDz85o+s8xKQ/ipiS1MCMWoN5tEjfhCyyJG2nbG4JgHSTjNvowD0Bfx72n6M
         /mmw==
X-Forwarded-Encrypted: i=1; AKwUvBxKHI1uXHYLlGEPj8F7SPHUke6Jhh44y314IV3AyzVleww8bT4ssSznHhE9NZofrzNytmq0hBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3UJ0DGm7tnAk8tPWw7MEbh91xi7WdobLoaj0pp0XyvHB92qe7
	d5RgLfIAjaqwF9lmZ3yNDLtOQoCOlkZUk0XAmqtaYMDbZeUcxcGl37XD
X-Gm-Gg: AYBFou13yFd0zAIGWH1lttJadFjqqR3bGm6yiophoVPHmMTnt0ZlQ5leZz2Q8ypqRNQ
	Qo4t/2vAiReWhm/Vgx7cBvo+coj9xdKpiKYxA/MK+vmzIzME0mtrWzOn4YxYGeHacwB6fDk0a6o
	heudZEC0ox/NYiHsCi8I5WtoLI2xQFwmKi5XwcZZ/QECH+kvLfrLN/tAWbmEAFieSw4+F1sQJjr
	mV64clf83M8EYEf/kDJ3VWXodP8v/3sL7TZAjhEDs0438+5ak0PhbQiVZaijDqiR5EiEj5DyhIs
	VHhjfVhkArMhBOa12nOsUiBC8OOgy5ilj4yR5NV25klyABiEuy2xmPg1xY47R+j85DIXklvm0Y/
	+Kdc7GaslSs3wzdLqGuXpXgvhqgCYvTeTR30jwgwkVWYRrNHNqP8zFd9fkAdg6MC/9P522jKtos
	x0uAIAMBbFEwx/iqS3I9LxX/1wtQBijzMNrMT/sbT15HGgX0B37FemqpR9AQrk
X-Received: by 2002:a05:701a:c90a:b0:151:8280:2c1a with SMTP id a92af1059eb24-18513d85782mr3987345c88.42.1792245825503;
        Sat, 17 Oct 2026 07:03:45 -0700 (PDT)
Received: from beelink ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b37ce3fsm12727648c88.14.2026.10.17.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:03:44 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v9 0/2] HID: multitouch: fix haptic lifetime on delayed input release
Date: Sat, 17 Oct 2026 11:03:30 -0300
Message-ID: <20261017140332.1480375-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open evdev fd can keep the input device alive after HID unbind.
The haptic state in ff->private must remain allocated until the input
device is released, and pending work must finish before HID reports
are freed.

Following Dmitry's v7 and v8 review, hid_haptic_init() now clones the
devres-managed mapping state. FF core owns the clone once setup
succeeds and frees it at final input release.

Patch 1 makes input_ff_create() the last fallible initialization step,
uses __module_get(), and drains pending work through ff->stop at input
unregistration. It also removes the extra HID device reference and
propagates haptic setup failures to mt_probe(), including when hidraw
lets hid_connect() succeed after input setup has failed.

Patch 2 allocates the clone in hid_haptic_init() and transfers it with
no_free_ptr(). It keeps one FF instance per HID device because the
touchpad inputs share report fields.

Changes since v8:
  - clone the mapping state in hid_haptic_init() and give FF core
    ownership of the clone
  - remove the devm release action and extra input/HID references
  - use __module_get() after input_ff_create()
  - propagate haptic initialization errors through mt_probe()
  - drain haptic work at input device unregistration

Build checks on x86_64 with GCC 15.2.0 and W=1 passed: the affected
objects with HID built in, a minimal vmlinux and modules build with
HID=m and HID_MULTITOUCH=m, and hid-multitouch.o with HID_HAPTIC=n.
The full build reported kernel-doc warnings in unmodified files.
A QEMU/KVM boot with KASAN ran 10 virtual UHID haptic cycles: upload and
play an effect, destroy the HID device with evdev still open, then close
the fd. FF_HAPTIC was exposed, output reports were observed, and KASAN
reported no errors. Physical hardware was not tested.

Base: 58161ead29e50d70a317ea26b472e0c7508e69da
v8: https://lore.kernel.org/linux-input/20261016173056.3397211-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: make FF creation the last fallible init step
  HID: multitouch: give FF core ownership of haptic state

 drivers/hid/hid-haptic.c     | 62 +++++++++++++++++++-----------------
 drivers/hid/hid-haptic.h     |  6 ++--
 drivers/hid/hid-multitouch.c | 18 +++++++++--
 3 files changed, 52 insertions(+), 34 deletions(-)

-- 
2.53.0

