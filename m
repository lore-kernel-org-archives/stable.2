Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35D2DBF75
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790443652; cv=none; b=K/6kGZixudF2ck6ygzko1A01lxZFc+k2kGinws7F2PGH5DYabpZ1FCcTDUeJGArc9XKqsTXfxfsa/kHK3cmW9/mXGApAVTD787tUzXzZUjAvNE5n3b5Q9Rm//Sxid+a2neZIjaRUg5JlzfLoIHKVKFowSLPQqS5qQXqeJKiYaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790443652; c=relaxed/simple;
	bh=2ZTmtkIFSofC2JVrEOSYkSGryK/4WBfRMxRimqC7VJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwny3mo5/qcfDJw8l9ZnyeWPEBH/ymWIWEjHsbdMpQgJtdK99SMf3dKVsNqF+MuIDkcNXzHK0uVqM5hEbGojHvZw0mnBb60MU/zetLtsic1LyDI7nro9Ole/CTahRx61Iu8YZ+GjsiZrYWafDQjDw5orj5MiD50nF/bJeSo8FtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/yE7S3o; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/yE7S3o"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-141a5d476abso60313c88.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790443650; x=1791048450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BWkCXAv8KL7gS3gupSCkFH2TZ/H32WNAz15njK7x33c=;
        b=U/yE7S3oayvOj97t1Yo9gN7YzqOxqVAW2SMBXNxVvfzqDFfD07iJ5ToxAdkR7vz0Ym
         JXM+WSYourTGDdWd20ZKNvokQ368OB0qZJXuOTRsS7JXXPSdjCrCySngN2TUMs1wXvwu
         +MOMFLuWOKsJz6RIM2iioDCp5JPlwURX46y18gU0+HuM9jZPX7WEsI0ggq32ytAMZNJI
         GMyrSeH5yt3z9yUEB/b5fhnQb1gQ3dujEUYji3ZAoxrVS3eIqwO1uEEMVMcskzgatQQh
         cClD+IQMfNo/JdXPYF6ieVtSkOWJpAhkpHr+jLBmPN50R5XMaXIeUyIW/r7hVmDHEaDw
         BoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790443650; x=1791048450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWkCXAv8KL7gS3gupSCkFH2TZ/H32WNAz15njK7x33c=;
        b=E8M5sOrJifgAoHto7wkOI2at0gwifAmrzYnVdNoNKVVJFHsRkIdRgEzwO9VcZvFoJK
         2Bh5Z9LRn3kRnY/ngOAGvypjGKgjv9XRvvcY41/HCTV9NbMesxgTzkRraGnQY3vv1za/
         KQHYsVqLC7jon6vQJuPXrkixnobaGF8jEoWwAKxW/Ff4bw+n4KOp4z7GNApNy3XqyKxQ
         DwsP97s7P1g/Kb9flroEd4wkpwinh+uQJa9OnMc/40pHUdS/Ep0a7ECs7IOwI9SmFDjD
         21imWMf7sSyr/PwMwUzeNukmesJ0L6CLY8BE33Ta4msJF75fxzuZqJFYKFc+3HFXvX9H
         a87w==
X-Forwarded-Encrypted: i=1; AKwUvByrPZ4mEBBpux/x9fmb5tiz9KqIppgN3oNYP1HXc29AOvJ9NEVWKvjKAaiR+z+cprrJuW38VeQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lqgDYzhDU9TBq5wZB+wkgUaJTlS6Zxlb2V5hecFrCUEJjAPvi0
	Zog3hb8FnomdXxGAsreyvazENPaV/F1ZZlH6eAS8bLZA6Hgwa0g1bSi6
X-Gm-Gg: AYBFou1Wu5tHsnDBa7O1JMyzI3eWwN5m0qOc/t+dY4bUPrmHZjGjSrWE1kxmMUgaRxk
	uHDEFWcIxviEoThEqgB3wiavmp2WCW2kSh6KNL2mJ/nrvodXKui4qDKNn4j9qkVgkilyWYjUjqK
	www2h+4klryMZnISl0/9pQedLKu31Qh84fvAQ/4yaBP2Mh2zQBMYNoqSyY1QtrOIMFh4LXUD/6j
	J+NMa6/mcVd26hrMytS5/ASj37B6TSveZ1SNZmhlepbUnob3ruHa4RZXpI+Uef0wMyHPkb4XOC6
	GuJAchl01ekuzO9NrAhT1bueh3Q3+fpTVMjMnWoNhMShlYUFafAECODszVbv/El0TKsotXE0Gnl
	omzoS9wnBjRBUlV32HBMuvni0JPVHY7ZRGzfPM4JZezP5l5NqUTLd23LK5XsJnkUDkHcH5dVw2H
	0QWSURVOcRRJfc8ZMpptXftwQPneuRXtlHe3OrJW+qNaXxK2bN/NSzUerFAtnn64RAnOR176R9s
	Ye/LDBSUSEgzmrG3pKSh6f7PQgQSxaDcjKKZs+YAH0QtnRVFL5X9PqpvzdrH6pAkzsOcg==
X-Received: by 2002:a05:701a:c919:b0:143:3240:89ac with SMTP id a92af1059eb24-146cfdcef79mr6165010c88.2.1790443650232;
        Sat, 26 Sep 2026 10:27:30 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm13436097c88.0.2026.09.26.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:27:29 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Tim Bird <tim.bird@sony.com>,
	Kees Cook <kees@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: Fix initial port reference race
Date: Sun, 27 Sep 2026 01:27:23 +0800
Message-ID: <20260926172723.2405885-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For RFCOMM_RELEASE_ONHUP devices, rfcomm_tty_install() and
__rfcomm_release_dev() both use RFCOMM_TTY_OWNED to decide who drops the
initial tty_port reference. The release path tests the bit separately
from the install path setting it, so both can drop that reference.

The synchronous hangup does not prevent this race: port->tty is not
assigned until tty_port_open(), after installation. The following
interleaving is possible:

  1. Install and release each obtain a reference with rfcomm_dev_get().
  2. Release observes RFCOMM_TTY_OWNED clear.
  3. Install sets RFCOMM_TTY_OWNED and drops the initial reference.
  4. Release drops the same initial reference again.
  5. TTY cleanup drops its reference and frees the device.
  6. Release performs its final tty_port_put() on the freed port.

KASAN reported:

  BUG: KASAN: slab-use-after-free in tty_port_put+0x22/0x190
  Write of size 4 at addr ffff8881001d3d5c by task poc/92

  Call Trace:
   tty_port_put+0x22/0x190
   rfcomm_dev_ioctl+0x1d4/0x1930
   sock_do_ioctl+0x110/0x260
   sock_ioctl+0x380/0x590
   __x64_sys_ioctl+0x134/0x1c0

  Allocated by task 88:
   rfcomm_dev_ioctl+0x8f6/0x1930
   sock_do_ioctl+0x110/0x260
   sock_ioctl+0x380/0x590
   __x64_sys_ioctl+0x134/0x1c0

  Freed by task 65:
   kfree+0x131/0x3c0
   rfcomm_dev_destruct+0x23b/0x2f0
   release_one_tty+0xc1/0x370
   process_one_work+0x661/0x1090

Use test_and_set_bit() in both paths so that only the caller that changes
RFCOMM_TTY_OWNED from clear to set drops the initial reference. Each path
keeps its own lookup reference until release or TTY cleanup, preserving
the existing callback ordering and error handling.

Fixes: 80ea73378af4 ("Bluetooth: Fix unreleased rfcomm_dev reference")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/rfcomm/tty.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index b2c1060394e6..dc3cdf614def 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -462,7 +462,7 @@ static int __rfcomm_release_dev(void __user *arg)
 	/* Shut down TTY synchronously before freeing rfcomm_dev */
 	tty_port_tty_vhangup(&dev->port);
 
-	if (!test_bit(RFCOMM_TTY_OWNED, &dev->status))
+	if (!test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status))
 		tty_port_put(&dev->port);
 
 	tty_port_put(&dev->port);
@@ -724,10 +724,9 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	 * when the last process closes the tty. The behaviour is expected by
 	 * userspace.
 	 */
-	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-		set_bit(RFCOMM_TTY_OWNED, &dev->status);
+	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags) &&
+	    !test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status))
 		tty_port_put(&dev->port);
-	}
 
 	return 0;
 }
-- 
2.43.0

