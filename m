Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4205908BE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897516; cv=none; b=UiKVonNsEwJsK11/Ou9QLbmgA2GKzSX5YR/oemxt6QGaYKxy/fgJQlrcefD4yv+vxI+/CSzZkL4YV2xmdu1M3L8F4/cSYRLlz/o6H1QTwvQtOnms3xAROm3Yt88O0g641Kbjr3v+bXhjo9PK4ZqWEIl545FqDKLwclpa2SooZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897516; c=relaxed/simple;
	bh=Cns2oT1nIczmTx7BA1FQJrYa05Qz1bt5TspJzKY+DpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXK3ZdhvZMn4/bKsXX1JiGlmNnJUACLfB0vNk4apjoUIKIlurjC8f3K7Nrjoe2mqMvQ5AyHhPqfbtNwoCfuiCJFbMxTdaqCZ5X9JOUQkfw4L+0N6sFJBvL0AtxMZDve3ieH+vyT9fCdOcbzmy4HCriGzbzT7/BlecRYvwa/KmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=K1cOj307; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="K1cOj307"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc149372c14so2558490a12.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788897514; x=1789502314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nty+EzL8h2vGEh2tc6E2x5KvUZQ/WGvvcz1FT+MSujg=;
        b=K1cOj307fArWwLUzOrJPwQnvfZQZrXkdF7CnX+JY1TVAT3GcKqy4OysYSXMlyeCr+/
         K03NdnTwL2CXmaOkN3ZWTqPv/7/yfkWdqxsLzdPvYlkX3h5Qo2jaUwdN7DhBFRKpV6D7
         7a1meCNU0TwpSzgj0eHGNgrC8u9fbxfC3eYUsGk1KBVFQm9FGRg2o+BGdnKdvAUtkqxf
         tj3HBStd7ObWFm71yv3btKQXJoRDN6U0CYnhZRQQSAwn78mm+fLYFH/wmeEcMuTmxjKo
         c0tMFtz0uLOILslHzWYg+5mVNYLoqJzGooGUg7GhB2tXUv/jm4t0fdzX30xamSSWAg84
         PWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788897514; x=1789502314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nty+EzL8h2vGEh2tc6E2x5KvUZQ/WGvvcz1FT+MSujg=;
        b=TO2brnlZlr+fZxKyNa3nas/07by9nol7pdknDYFnRmuHHhszPY/s8MQmN4UR1yCKHC
         JQ3hZyWLkeXHqTSVBYftpxm9hQO9NY3BpjkOHSagNnR24rW7wJmg+w2a+0fOCfc9gNcq
         JaqcDbrf9GSEMC3c9I/oz7jgYb4dsV9VSh6cx6zw8V3M1j2D9foP2cApKlh+KO0fl4fc
         RA6hb56Sof0BMbb3QX5gNI2fYWLGVcTcOTLnHK8WxaHrYYhbY0/NBTr1SoIggRN/vtJ3
         ABf8KbvmxmRtaI0nZ68AwuTiBYKV4yQxoa0S6lD8f6UAc4qZg1Uft2l1SPeap5bkJVmK
         c7aA==
X-Forwarded-Encrypted: i=1; AKwUvBzkAqQRnABOZiJVKJ4THnXp+rFfCDxFVlvkFLfgBKo5lfVEph2kdqu/jk1dK1inF1SVksEOYm4=@vger.kernel.org
X-Gm-Message-State: AFuF++lsv6UItwo6fDPgtKx50xR61L7R8QWm5uymphzp+jEkJlBuL0Zn
	kpZaEUt9CG0kczM4aN+kLBrQZSX88BHoqTq/1WyvNki3Fk58vwFruqwRt3oCRp/lqYdYdr57/wZ
	vTc2GYLh+
X-Gm-Gg: AYBFou3MVOvbvN3A33xMFeoYSzGpt7YWkWoI5M31ktT2yPwWoRKZlbELLy/Wi/oXxhx
	GEYnEwbo4VPkC3QnSdgk4gjXIpMz/BjcccOTi0fFbDRNKFtcMBvUKtsIVAPwxMQ4X2dwpsn6le0
	CiVz6VQAyAU1xSKczalHJsh9XllifBA3qVEPBp9MK7kRAXPQt8LC4AwLBODNjVY7yz1eQ+UAiXT
	ZvsdgPMNBlNccT321GS3PcpxyTchDNeHm2zVU5WmIgk4Z2xm+faST7ZbIB1mk0bdG1rURaZht9L
	7mjqdyiRfoHlb7jZy/UCONuKiEBxRtmnCAVg8rm/J5bG+V0vUWwJCzb3te5XnjEIJqTTElkEES3
	uMsodSUXWZajcmPpPLxBvQRRL+hAXwT5lM9CDHebKPLE4Sq/Vqnp6HxginB8lmAkFrxPiYfnF5F
	RXYAiw+EmFEfo/ytojr+zkR58RouBrRJ400lq7Ilj1mpsntShm7AGBVNjh9Wvi7tMKdJxD0z9Yq
	r2q7MeJN/5gYN9g
X-Received: by 2002:a05:6a20:2d0b:b0:3d3:af85:eb99 with SMTP id adf61e73a8af0-3da3a16270fmr50562135637.27.1788897513761;
        Tue, 08 Sep 2026 12:58:33 -0700 (PDT)
Received: from gio.tailc60d82.ts.net (129-219-8-8.nat.asu.edu. [129.219.8.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm50931202c88.2.2026.09.08.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:58:33 -0700 (PDT)
From: Giorgi Kobakhia <gkobakhi@asu.edu>
To: mrkobush@gmail.com,
	dpenkler@gmail.com
Cc: linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Giorgi Kobakhia <gkobakhi@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] gpib: agilent_82357a: fix null-ptr-deref in primary_address
Date: Tue,  8 Sep 2026 12:57:35 -0700
Message-ID: <20260908195736.1554837-1-gkobakhi@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function agilent_82357a_primary_address initializes usb_dev with
interface_to_usbdev(a_priv->bus_interface) above the guarding if
(!a_priv->bus_interface) return -ENODEV; When the usb dongle is
unplugged, disconnect() sets bus_interface to NULL and the NULL
dereference is triggered.

Commit 8491e73a5223 ("staging: gpib: Fix Oops after disconnect in
agilent usb") fixes multiple NULL dereferences in other functions,
but this one is left out.

KASAN report for the left-out NULL deref:
 Oops: general protection fault, probably for non-canonical address ...
 KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
 RIP: 0010:agilent_82357a_primary_address (./include/linux/usb.h:752
  drivers/gpib/agilent_82357a/agilent_82357a.c:922)
 Call Trace:
  ibpad (drivers/gpib/common/iblib.c:466)
  ibioctl (drivers/gpib/common/gpib_os.c:1507
  drivers/gpib/common/gpib_os.c:675) __x64_sys_ioctl (fs/ioctl.c:51
  fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583) do_syscall_64
  (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
 Kernel panic - not syncing: Fatal exception

Remove the faulty assignment.

Fixes: fbae7090f30c ("staging: gpib: Update messaging and usb_device refs in agilent_usb")
Cc: stable@vger.kernel.org
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
---
 drivers/gpib/agilent_82357a/agilent_82357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpib/agilent_82357a/agilent_82357a.c b/drivers/gpib/agilent_82357a/agilent_82357a.c
index 2468a471d175..7abe5540ffc5 100644
--- a/drivers/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/gpib/agilent_82357a/agilent_82357a.c
@@ -919,7 +919,7 @@ static unsigned int agilent_82357a_update_status(struct gpib_board *board,
 static int agilent_82357a_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
-	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
+	struct usb_device *usb_dev;
 	struct agilent_82357a_register_pairlet write;
 	int retval;
 
-- 
2.43.0

