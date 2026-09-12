Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BD3321DE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789247723; cv=none; b=Fs+uLwcnltiLRV4nE0g0w3gPxH25NySvRh5wzxIoquwAqhWRAlOpwjgsr5n3Bn2MAnijHzyLzxGYjF4e1OaRSJZQIz1rJJ1X+2TbbvrkgQdh0awbnY59LaMtSd862LULxYguMcDlZ4WXXwQ73v0FJlbZ8HnFigDWx9mLpHLy6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789247723; c=relaxed/simple;
	bh=pgLeJ7lbYd/VmJJyHy7zS6Ae3vYXECbsVtUpoN4gxKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsMgjowVKKhFfKM2tuewJUVMxU0dXn/jDyJJnkZvGVrghQdgh2EqsOb0SnPhRoGouF/ER6Th/z3f43pjHohm3FkJL4QliQ/ry1xX4gEinx33HdFUjIsXUHuH6i8uglvi4V+KuC9DQpqEVi+iuYTzLvyUXAFdB1XkXlSCKSREOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=MaHgSS13; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="MaHgSS13"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b28df1f600so1903394b6e.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789247716; x=1789852516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jn+jkXZgmdqQdeTiGXA67KlphU8PH0hw9LcDIFI9mXU=;
        b=MaHgSS13XzwrZKp8JkPlWnkILeagBN1XIzJ2gmqGL516gplI1A+PatW2SrHKOii+0I
         uaxPxv1euZ+NaLHp6X2SoCxnk0GbjmvsXaY3oEaLKR8O1/hV/iG/zVr0NHtCKRAtMHBJ
         f81+mKas58R7cGZSMTuP/H3tPFYC2belLpnwB4L5ewbJPfaPjtwyTucnEsxFNoyxEPzk
         l94/sSLodoa7olsFB61LUcoAzR3nRIeYLKmlxuizvU/8if5UADtNRMEh3djXokqgsrNT
         qU7fUj54CfMHs5oixXqp6rjnlpS3mntlKMocoYvjfzul49sgMKYxoR9BXSPDoUK9mJvt
         sn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789247716; x=1789852516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jn+jkXZgmdqQdeTiGXA67KlphU8PH0hw9LcDIFI9mXU=;
        b=aciSCKnM0pJhzXbLeV6TCGgZTuf7AjYamsOEwN1pYBgMyVWegvPa6biqwqL9U0o6Tr
         Qn95cJ1kDcOiXLXQ2YFTqe4asDDSY9EcHmE1Y7P6yCJtr4Axg6O2nGqF0pTSpSEsFo8u
         rZdPSNBMqoR1aWuQvMXwzHTXH9wto8HPnEXkIhvhjZQQCxKnhsCsUzHK0RrWaAucKue+
         jb7pOhW8ntzJrkZisSocUIIxv89A19fYQz4offHrK4UaqpYm4niXhumJzIWQW/HptyT4
         NgFSE1r6T3UYaTm51KIV8nJksST8gH5bsdV0ujarvpHSne59FEdb9PvVNF52vwtiAyEr
         oLag==
X-Forwarded-Encrypted: i=1; AKwUvBwyeEGrDkdFPxvt3A6Ys53zp0DBZKdehSmgsctw7APz83hbZMq+jRdwViG0xF7Jb5q/Q37Kgkg=@vger.kernel.org
X-Gm-Message-State: AFuF++kKNZYdYX3ISnP45pxvb4mQEpnywAht8Z44DRjcongdzHfHLmw6
	yu66GnGcIOgmfOABUwqaKJwQlTGTWAbrymxEmuwIxT69+ZXWPChWyXEDiy/9bs2M/g==
X-Gm-Gg: AYBFou0DOUs9bGCFP9pW/gMKz7EE0LSAyc9VTz3RuqaknXKUY7huCaOQii8xkFp0oeg
	/YuryIAMuk3gREiMrPDnBOMUptWcdBPI9Y7SAnS0fe1k1N9BdSIP13+lWD82zRpnzyA6CrH0gsh
	ZpULGtsZEUetwVxY4h1hbpreD+ktw46v9oZnPyz3HJH3OtgtDakkmh8elWsDDAM/6Fx++LTfRtz
	ST+Ilmhbk1akNOVvXJAsxyLOIzVEwDSiPor6Q4TRvnde6k2l++1awgAq8K3oaWpW656YhaY1GIM
	vww0vInLir5M/yNnIuSSzv9z+4ktWDXg1SUv83tnXu6k7xryG9+kV4vLXudbAJnTBTznwmu5o3T
	aSsEiZI/xHoTKaUHJy5AkPalP4/dgdAwtJV8m81RFrEcM2FXtEdJGEW7cw6GeCWj9IqydFD3aD9
	WhZySQpRnxGvzYEemXW68o5cpq9cqCWQBk/8pKFqEyAaAxpfzmlRoz1lpncm1tjCx+scWO4nl8E
	W5O6FPqrbjqdC7+Oy+d+aJkeV9teHlnNt/F/TN7OLNVsD3qow==
X-Received: by 2002:a05:6808:2224:b0:4c3:cd49:bbf7 with SMTP id 5614622812f47-4c3cd49bf95mr7236782b6e.42.1789247716315;
        Sat, 12 Sep 2026 14:15:16 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c331bc937bsm6003521b6e.11.2026.09.12.14.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 14:15:15 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: bernie@plugable.com,
	deller@gmx.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: gregkh@linuxfoundation.org,
	co+ed9902f2e44184d9@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use
Date: Sat, 12 Sep 2026 14:15:12 -0700
Message-ID: <20260912211512.2049147-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dlfb_setup_modes() frees info->modelist with fb_destroy_modelist() and
rebuilds it, but fbcon holds raw pointers into that list in
fb_display[i].mode and nothing un-publishes them the way
do_unregister_framebuffer() and store_modes() do with
fbcon_delete_modelist(). The function does refuse to install a new mode
while the framebuffer has users (dlfb->fb_count != 0), but only after the
list is already destroyed. Reached from the 0666 "edid" sysfs attribute,
an unprivileged write to /sys/class/graphics/fb0/edid therefore fails with
-EINVAL and still leaves every fb_display[i].mode dangling; the next
console switch reads the freed fb_videomode in fb_videomode_to_var().

Test fb_count before touching the list. fbcon takes a reference through
fbcon_open(), so that condition covers exactly the states in which
fb_display[] points into the list, and the errno returned to userspace is
unchanged.

  BUG: KASAN: slab-use-after-free in fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:905)
  Read of size 4 at addr ffff8880107b449c by task kworker/1:1/47
  Workqueue: events console_callback
  Call Trace:
   fb_videomode_to_var (drivers/video/fbdev/core/modedb.c:905)
   display_to_var (drivers/video/fbdev/core/fbcon.c:998)
   fbcon_switch (drivers/video/fbdev/core/fbcon.c:2182)
   redraw_screen (drivers/tty/vt/vt.c:994)
   complete_change_console (drivers/tty/vt/vt_ioctl.c:1141)
   console_callback (drivers/tty/vt/vt.c:3358)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  ...
  The buggy address is located 28 bytes inside of
   freed 96-byte region [ffff8880107b4480, ffff8880107b44e0)

Cc: stable@vger.kernel.org
Fixes: 7d9485e2c53c ("Staging: udlfb: Add functions to expose sysfs metrics and controls")
Reported-by: co+ed9902f2e44184d9@bugs.sh
Closes: https://lore.kernel.org/all/1jSCSNaDKmuUG7h40rTsSl1rMaSwdlJef4rp%40bugs.sh/
Assisted-by: Claude:claude-opus-5
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/video/fbdev/udlfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index e78d6f95c9c5..92b352bc7e96 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1293,6 +1293,11 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
 		goto error;
 	}
 
+	if (dlfb->fb_count) {
+		result = -EINVAL;
+		goto error;
+	}
+
 	fb_destroy_modelist(&info->modelist);
 	memset(&info->monspecs, 0, sizeof(info->monspecs));
 
-- 
2.43.0

