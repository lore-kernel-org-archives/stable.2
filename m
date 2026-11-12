Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443339;
	b=0mZrjlZwx4QLa8la3TmRcehta4g0+5iBtRllp6OrpJqMCMk6BIOe+4FFVr26MfJ5KqNH
	 rWVS7CatEUHZreymK/tN6/D0skf+YDvqBhZmP37EMS+uX8lnmu4Nas7oGbqYH+282Z0ki
	 hUrK0+y6HNo4B7vVm7joZ0cAT6bj6rlB7iyqI4S4wjXeDJ+FkGb2Bsp/Z8rId2IqMk4hc
	 S6vhF1j3jK2e97f8ziRiOtqRZcL/llLFeKh5Hck/su1cl55Y8mQeXVBPlQaMaOgI0kMv9
	 gTnWxa8FGi65RRr1XX+jNvdt/WDeAoBm8Rvfkcu/IyXmEEdsseCl08U4k8f3e6USq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NrSzbFzhb/48pQwefucbagWYjcsLjKvWanQjAidltxQ=;
	b=V96StsKJUPV+r2Y09tiJMTBUS/S0/ide6aItCjfMxxwRPoV9OIcRjguYPVq44AwJgIWs
	 U5TdGmaJ3yHrXi71GlT/Ym15cBqC5x/Zf70TtZSvALDWeyWvFFSNs+gHO7LrueFj+G2Sq
	 W5+RZMYa6+nN5Q6S0a64ozTTbryHRpoUFEb4aVCzYpoL2vFIemQvLEc4ywhgDdM9moTF+
	 g2R1TvftBcBTWzeURdvSXNZAUfyoj6ls4eOrd29s30pgJ1UVqDyi9eAXfJIDL2t13c4qL
	 cL7PtJapfxrx0mugPqH6aa/86oRvNEZb/MoJbk/cmOUKTeSsW5Eghuq1p8gy+k1tH7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PAFYordc;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48240606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48240606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PAFYordc
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b350d5fe3aso3142707b3.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443338; x=1795048138; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NrSzbFzhb/48pQwefucbagWYjcsLjKvWanQjAidltxQ=;
        b=PAFYordcAlFwxsujOd7fSn/4PQJ6fa3zPVS6mw55aYy5QF43dixpt3/3X0PUtkRqzq
         Un0sHWSZJcdTv2azHZrdTifJBVehAMUfZTakao+ijmw9SiJ4wy4CF+IXYI/JBLEBGQzZ
         PGDmzt8yGq+e3VAqiMx3dgyeWoGZRnUyCyWJmu0RPIvQEMkt0KVjs8V4AtRcd3aFbrqo
         HnqvhDjnevub0HGIGBNQ6wq2w9w/4T1ny09gndrXUK/+NyFrJh+ofxlhZyh9xMY7FWNg
         ffnW5N2qqx6jsey4o9v1NtDC0B030Obxowvm99m3FQbkALcAJS5yePSk21EEhikrmkPz
         AiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443338; x=1795048138;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NrSzbFzhb/48pQwefucbagWYjcsLjKvWanQjAidltxQ=;
        b=IRgxYVV1NoJ7wCTxdcnsqI9h6miqDZbp29SWzP2D3FnIUBAssJ0gnlOAvAKJhPlneg
         uJPXIfheZ+v3bgVSEg0lJNXPrIWmFiRGqdzAuq7XP1GH8xx1MqEOu6LutJwMUL/ROzwF
         4NyegY5CXmyPn4MM+op8Vm8TascXsqcyDhNw7KfZk3xxA1MkjozxHtMvwnbC5tfXGxzZ
         oLK7UAfo6mIZARx82N89djdJJYXnmSotZPQHBLerUi+URAeIoHvzpqy3GuzuCfJv4VvP
         dpeUA0lQBoYDoBomH/uaMxm+0ha31QWf7Mhcnz0ciJsXpsNhjOLqjAMvyn/IX/S0Z9xs
         bW8g==
X-Forwarded-Encrypted: i=1; AL+hErF4y1j4H7mm/kGmS5rUmDWcA2zbf9FWcSPVNDYJWI0dWTvpTxqn6o3QG4ui7/+84bPErh1nDvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z97QMXpa/7NFF2r5pqH1OkKGs/ji70+a2s8rMQVq7UwUOc3RPfg
	4vcHbeTmN8oQNDVw+kaBaaSWCoai7v0zNY9mnCDnYqZtUuTX2E4+Kwrg
X-Gm-Gg: AYBFou0fTUaimNoo7/WMEt6rwFKz2f3jiS65nFINr85ElOXz6+Qg8HZTag5r5UHN89S
	Hq1hXyEbC0Tv+A6MOmyLywZl9KWhq+6PcjPMecIDIvQ5Kjt1+opZMDz0P045yFA1gAAdMJkn+/E
	1Y1EMyuXyFYrEPqxX+d9UK5RjlvbDwaonpDg11VNoAcP8rvy+bHMYC5J/ExHogSYe/4u9deCrjA
	42qKiyRsL1Tg7oCtZ5D6tJh0MXPYduiOxzVbWL1gz3sbfQAnRuPfETDAQXl8SDSSRnNPWIbUaY3
	Oj5Nn0dAj631PnOyroLBY/LDY7Me994uKZTYpZqpQcbK1D++8UxHNvP0uJogfhQIrPG8jjHMOGt
	EMBKo1lZkeGu9N+HWNKTqGhtlscFvFddWNFnTiQohr1jZxB42QUIcAxtRHe1dxkwf9r50lh2IGM
	rpKqAyHrGNUxHM0qVFRUZIVMzDy3OADiCg1yuoHFsPR7sxqfSGUTHsMQ6ZfqmY4khSQ6Mkw8Fgf
	DTkAe4NKUFMpkBd+FwsJdEWokhdE504NiSkoOV+0ENxl7/s9Kd/DJXw+XlXEIj/RHONc3qOhBo/
	dI7fAoGX7yWH01ziJyKHou8P3OcCpBGKjYAQFpSZ3tsZGnODGjE7X2yBwgNxlbbzerr6kvdTFKa
	5sqD0JhfsMbe64SuvkhPJnqc3pUk4yjnDoyhz073jImajgtEjZtB0Zq+XhVUOIg==
X-Received: by 2002:a05:690c:c0c3:b0:8b0:6722:6734 with SMTP id 00721157ae682-8b3bb155926mr6839747b3.34.1794443338082;
        Wed, 11 Nov 2026 16:28:58 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933a6554sm57571227b3.12.2026.11.11.16.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:28:56 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 11 Nov 2026 19:28:56 -0500
Subject: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE2iIoiriEW1gxFaaRFJ4+6Kt
 /sW7w/gyTF5aJIAjk72bE2ESBNQkzQjIetoyLO8FHF4jlJZg2wdrXJDcywLSl2oStRFX2cVxOf
 maODrq7bdb3/0M6n9TcF9P4NsHx93AAAA
X-Change-ID: 20261111-vgacon-ioremap-null-ad4c7184b807
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
 stable@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=br3GFCtz3RXFRK3DsA4LkWP9fcwbxa8J0zn4MRkuUF4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLK+criL7v37qOiykO8rawfHuuk+WyP0ikzsHuj9nsVwQ
 sin7fCvjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmUTAjQ9v1oF3ZfR
 8OxC4xawm0WOOg2hj571rb9g/LopWvnRE9dpPhnybXhpaPzH/zz0vn7L19vfNZ3UWnSt4l31dM5
 BKapXb7CDMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
NULL. vgacon_startup() then probes video memory through that NULL
pointer and oopses in console_init():

  Unable to handle kernel paging request at virtual address 0000000000000000
  pc is at vgacon_startup+0x174/0x910

VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
failure like a failed probe and fall back to the dummy console. If a
VGA card is present, locate_and_init_vga() still switches to vgacon
once PCI is up.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 drivers/video/console/vgacon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index e7e6750f1f87..09f7c376b468 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
 	}
 
 	vga_vram_base = VGA_MAP_MEM(vga_vram_base, vga_vram_size);
+	if (!vga_vram_base)
+		goto no_vga;
 	vga_vram_end = vga_vram_base + vga_vram_size;
 
 	/*

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261111-vgacon-ioremap-null-ad4c7184b807

Best regards,
--  
Matt Turner <mattst88@gmail.com>

