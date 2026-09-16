Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA233F5BE
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789530339; cv=none; b=QPFtzZvsLSk9DjDFJlzFnezW8pMwq0ziwHw32FMZvg3MfaOv55Jf0lRy97xuumnPTSYoCxalEm2uWrK0W1hN43aCdyLsUx7bReSYXVO2qUGx3OzzEvpWNT3kYcXhd2nQeHZ5V8qJQ3Jxy5E0R0AFDEna9luVqHH2E5wrb7uUSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789530339; c=relaxed/simple;
	bh=kj+jwfz2ESgc5zFDsF3Qm12OZV92X1W7h3OVHgPgo7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SD3Q33ZrkeXKJCy3ECUL4YU7MdZvYR8Atq/tjqShu4WMqfwcXDyCRpt/9o5qmDJmN9AeEK3ATG4JpokKgC+2+NhIjWL9jk4v26tPMtfoZWhXlCiAhC8FkcfXcgslf4gA7rZVXMXs+zc4Fc6hSqMqxHCpdXCPWywjb13Cx8DCtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=rKlYr2eA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="rKlYr2eA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1159222a12.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789530337; x=1790135137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G8OBnZpdkznSDHoOVDOJgOwhfNo4gWFfvtnI5e7GBu8=;
        b=rKlYr2eAUhKC02NildikSqpZUTltbAtlFj8cRVwAWM/zt1x1Etb/5wA1cSKN0fbSWl
         2XF0CRkek3auZZVQNszH/ceTS0wRxShcOseNnMIO3rLjEvSU7MgM6Aq3684/WoMtNwkC
         3FcmKKAjTUbdwH1mz1pmmZM/CVGCDNtZO+QhY6Rvtl/aoxBZYjs2Rb754rfQdJhqWiR/
         LffFB56cX2XirC2dU+3hX/3TKIbNHYAS6K9mFOc+SW1nQVafgSEzwxaQbuNyTytj+rcv
         tuCU5iVSGo7hXAbE45W5q0QoYP72LctF7zdJSuBlD92+UNz/ckuzFzWSbL5csCjfv25f
         jgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789530337; x=1790135137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G8OBnZpdkznSDHoOVDOJgOwhfNo4gWFfvtnI5e7GBu8=;
        b=UBWg8BEz90QKgk4Hjwen9diKlTEb23swEHT7FIFrz5pPXJRULMdvADl36wZKwKXjIV
         1z4o1w8VgLceBhEMlqs8+/lqLaL9ZG7XTf3LSQ/mr2/N6aj2VZ1eOb6VR7GTjKMnBt/h
         GosSiviTjXYoHh/h06pOGCiQkNKrr5lGYt3wFWvR8vRACMbre82QBEE45UrsSr5NnnxF
         YJogJtS8WobkTQVi58ZdW9IfmSDIJrUYL5bS0+hwSpOrUi86XkG/gTLkBadOgvrEpi2s
         i3NIFKBYijkbvDNFSuJ6pyUltkHQvTRiKpykhAfAwNjjC5dutIm96Tqz8l5QsQnBYC5Q
         ytbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMk6OEfTP/0LavM5pOIJn6juduYE7z7jWDRNOL2Z4Vu7feVXMbaeBqGII+B7QitbCjiA4WIIE=@vger.kernel.org
X-Gm-Message-State: AFuF++lnP+i09+aIJhVt2wUfLJ+z1cFzOx5lHa/INI/WsZuwmpwDq1as
	5m0JJVkrM7AXoIZf03QtMmXJhZD++JgYMFf5nDlPe4qMWLO3TV1VH77r8hITi4OzeQ==
X-Gm-Gg: AYBFou1u1Er1lR0W34LShwsNCOq3aMDInw4gdGDB5pfeTh4i1dPVMlgUEJHztOpQdUC
	I+/K5h/GyoFBdyvqFetVBwuTNB1mPs4nZ+WsfcORBYdfWZkIw9fZmc1AyeU3nBmf+R6vltM974e
	Lo7/N41py5sRsJMyvCLcuT4AGfMPi3Tf9KcyxcZ5wJ2QVuzAt+s4TQPHq+IYhGdfEyI7uEknctq
	HBySBxvE+/uzGHNTtI0SWcc1q5bmNK01d3lT7wKoXgXWfd2vLIBrycaywU9INNSob7Anzs8iymZ
	VKE1YlxTk3dGdBtost4DP1tFx4TJxikH1cirjysUZ0qyBGWz2c9I95JuVMfIAN7hUXQRZGpdzi/
	D17mxbyDK8AFQTNgYN6b+vvLZ5bnWQwexUT1fxlj65afhjQY5JDKVWLMQXqRTmnu/uIyYKzReUT
	03EjO7tZGyBdunNH7fGxP0kViTWsbpdiD0V5Q6FZ9Hrj6Fk7YDww5tzlrhdb7SXQtUT/9qDDdCX
	lsajO+bf3pSEOUwYP9INp/VnnLdhujfR8X9jc5sfxp8j80TcQtlWLqN
X-Received: by 2002:a17:90b:35cb:b0:39e:1e25:c6fd with SMTP id 98e67ed59e1d1-39e1e25f48cmr1670277a91.30.1789530336957;
        Tue, 15 Sep 2026 20:45:36 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm6953812eec.31.2026.09.15.20.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:45:36 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: hverkuil@kernel.org,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	co+ac0ebfcd53bd2316@bugs.sh,
	stable@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] media: go7007: only set audio_enabled if go7007_snd_init() succeeded
Date: Tue, 15 Sep 2026 20:45:34 -0700
Message-ID: <20260916034534.863732-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

go7007_register_encoder() sets go->audio_enabled before calling
go7007_snd_init() and discards its return value.  go7007_snd_init()
assigns go->snd_context only on success, so a failed ALSA setup leaves
audio_enabled set with snd_context still NULL.  The disconnect path tests
audio_enabled and calls go7007_snd_remove(), which dereferences
snd_context unconditionally.

go7007_snd_init() returns -ENODEV once its never-decremented static card
counter reaches SNDRV_CARDS, so SNDRV_CARDS attach/detach cycles arm the
next attach; no memory pressure is needed.

Set go->audio_enabled only once go7007_snd_init() has succeeded.

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  Workqueue: usb_hub_wq hub_event
  RIP: 0010:go7007_snd_remove (drivers/media/usb/go7007/snd-go7007.c:273)
  Call Trace:
   go7007_usb_disconnect (drivers/media/usb/go7007/go7007-usb.c:1336)
   usb_unbind_interface (drivers/usb/core/driver.c:461)
   device_remove (drivers/base/dd.c:618)
   device_release_driver_internal (drivers/base/dd.c:1349)
   bus_remove_device (drivers/base/bus.c:664)
   device_del (drivers/base/core.c:3965)
   usb_disable_device (drivers/usb/core/message.c:1478)
   usb_disconnect
   hub_event (drivers/usb/core/hub.c:5966)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  Kernel panic - not syncing: Fatal exception

Cc: stable@vger.kernel.org
Fixes: 866b8695d67e ("Staging: add the go7007 video driver")
Reported-by: <co+ac0ebfcd53bd2316@bugs.sh>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/media/usb/go7007/go7007-driver.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-driver.c b/drivers/media/usb/go7007/go7007-driver.c
index 453ab5c3aa03..7db2440886b0 100644
--- a/drivers/media/usb/go7007/go7007-driver.c
+++ b/drivers/media/usb/go7007/go7007-driver.c
@@ -306,10 +306,9 @@ int go7007_register_encoder(struct go7007 *go, unsigned num_i2c_devs)
 	if (ret < 0)
 		goto err_free_controls;
 
-	if (go->board_info->flags & GO7007_BOARD_HAS_AUDIO) {
+	if ((go->board_info->flags & GO7007_BOARD_HAS_AUDIO) &&
+	    go7007_snd_init(go) == 0)
 		go->audio_enabled = 1;
-		go7007_snd_init(go);
-	}
 	return 0;
 
 err_free_controls:
-- 
2.43.0

