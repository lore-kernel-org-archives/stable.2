Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476963;
	b=2Y44mzDEw5+YFzSLQVhI0HmziDPd53Mz7qe9SAmACqimRZW7s/g17j1qR1xZG7L9sRs+
	 QPLQUkUlJh8JN6imdQiWsj78Ci61Es0zQqSlJUCBxzKjBfxbMiE680OmhkuG7EwjtlZ0b
	 Vk5SIw6yGJQtiJYnUREhjUu4ng+oJi/eUdKl2pbFCoFyHo4PSJqcG9xhuXX3mtWa4T92s
	 NYyjuafZto8UTeRuUZCKnJdtEaoUH7wtughj0bqYkVBTCNP42ZVyNDFr7JTicX9sJ3mcA
	 vbasZh3EWQ+UAJ0kT9hKOeqpsDSEXgWkQwr5WtFvi1+f9eE+vurWXvT/UlFWFyrxKrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rNaQ9UR1U1l9ZI56X9pvqj6p0Mr/iO7Q1f6fdA5PWJc=;
	b=HVNmTZvaMJe+bcHxYHRUv2xgj2L0NCGCDEMneVMuyq9Yy14PtZuz7hQ28WoDSQpnbcJs
	 XTojuMA0C58QdKfcwyCAnDaAX4tOInZC+92XRb51bozGK8AOko4VOv5uSnj8BCuFVZRO1
	 nv9iu0+TrN2OfmhZ8atFEOmayOfcFGk7tjyKKyIqzn9UVbDOyarLMfzNd8fiinMZQ9LF8
	 MxJsfq5wVAvIyGc2PB3H+3jD4cJO05TZc5sCZ02rTLDLBhMjPLeHVKwnLDuJ3DF4676y1
	 /FCdR7hCef8XPGIwmgqxZ1fUf94hkS0j+/7fI9PEkYg7TCv7cHdJAk5pn9RVmYP5T8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=cOI1nLBE;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E2606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E6E2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=cOI1nLBE
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so35454935e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794476961; x=1795081761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rNaQ9UR1U1l9ZI56X9pvqj6p0Mr/iO7Q1f6fdA5PWJc=;
        b=cOI1nLBELaMJdSZw1/DxuLYZY3iC+9XRoweG0s/js51fVpuaA+3LaECAg9CQa4tLOC
         /zvHnq8aijpyFZracBEU3Z/YuRPQeyqAnOI+JmURwy5bohIVW3+SJz8eq6LfGDSTVKhp
         IPaDEiTSuTMyvV9LTIXlHOaiyCP3GK21yHWQxgnf79SccN0MAJXvk96S4D4iPDQXiRPc
         ay15saU9OfbL8Rp2t1eTBMu/RiacsrCyXNHRH3Cs5L0qC0Zh8ItuNNb9JF+JNQJ/0hG5
         zJ6VAZCNneQ6U3epAMzWEZI5PTgat1Sc+p30GlYoYDQ5vbnRXJ1Vut8o6LMfkcgMYm+k
         HQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476961; x=1795081761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNaQ9UR1U1l9ZI56X9pvqj6p0Mr/iO7Q1f6fdA5PWJc=;
        b=bb/TnD/Ld24ziGukRA4p6fAwKhvv612xFHRjr2uDp05DrmRW/xzenK2OgmKK7azxo4
         UJPni8riQdhxy3G8btM8wTcCzQli2RSizm+0KJlhqfgsEYukgIDg2zLImEEAQFfMl3ov
         nn6mKSYQ/igSpU+U8VtnzOD6Yyi6X13oY2qCdhW5+8uUKcrilBqday/NTdXmP+pVREdW
         Cn6Qv0CS7bwHdglFym+PRyoa7OmUvbpW9/DoX38YK82h9P3/ndPszOzCMnpGnGhV6nA8
         palX3O4jFNMw5DzFW1Bv98p5GnLtMAbkAF37Cb3fcojIuxD5nD9/cvzKMCV9NPS2zIFu
         Wfyw==
X-Forwarded-Encrypted: i=1; AL+hErH1GKZ2nDPv9JkIPDR8LR7o8W9Yne1NN+DCHlrrNPrzi5SB9T9Gxta6TdvM98Ljk3FijxXfPR0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VLFw7BF22r6vKHM5S9YuJDexgKnyBstbmP/dMtStlB3H8eGI9
	ZORZ2vVLhfaCw04VdTnpUtCnWeDWm8F4LqWvOnyXDMrRAbyi25qTcsseMLpuUekTgNY=
X-Gm-Gg: AYBFou1Cv3IdDWhCNcLUgxYrzOC2F1kdrTXxwnE77BE6JsUfxI+8VcELWoFD7Cf6qJV
	O9QTZWp7//ewug/nAC4CXE5c7NFvXqyG2Vm5H7cJT9oHgCMjNcjfLuOKgwKXFxclWzC5ZZWlG6F
	6peAjB160iG25XRz5b8RCD85GJjMy/hFK87eyg8+J4DNRxUvTZ3GdGhILNNUCsKbmwKIBsuYVNq
	nEYkT3JY4ownKnmEiKjhMr2pST3VoLFgrHwg61WnG5/FBt9Il34zlLJCNqy+X7anJsoZOJ++K2E
	9RW1iqeVeFs4Rki7IXAeFoKALV/lYxKoTNSzU6EhBaS9XdAJknV+0j59UXrn7UClgCU/FJTRYCr
	PNo7RyTqOYFv713YFQLHcd/+eqxb9Qqv4gS0T3Fh18TeYqzwvw6xfAssGfBTzvc2ZWG0iWlHdRO
	LQcjgTDqbHBrT6tlsmtkrtJSxqUnPnrPVTOgHng4Vx1nc1Zg4rAgWTAgOhBxWnMexqDYhXirB4x
	GwEK1HHDJl78KtfA3xzHbzCIvv+eZB+Dd/2a9k/xDoFp54uFooFT/BIB0tH0rhOdOwR1k6Go9F6
	RwH8fB5jBN6KC/YVvVLTLHQwfub9m7TQfcQfKw==
X-Received: by 2002:a05:600c:8b78:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4ba0939162dmr85782365e9.32.1794476961026;
        Thu, 12 Nov 2026 01:49:21 -0800 (PST)
Received: from winnie.home.arpa ([62.4.45.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2969e7sm50816695e9.10.2026.11.12.01.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:49:20 -0800 (PST)
From: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Daniel Mack <zonque@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergei Nizovtsev <snizovtsev@cloudlinux.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: caiaq: Kill EP1 URB before unregistering the input device
Date: Thu, 12 Nov 2026 10:48:54 +0100
Message-ID: <20261112094904.2430318-1-snizovtsev@cloudlinux.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_disconnect() unregisters the input device via
snd_usb_caiaq_input_disconnect() and only afterwards kills the EP1
command URB (cdev->ep1_in_urb). The EP1 completion handler
usb_ep1_command_reply_dispatch() feeds snd_usb_caiaq_input_dispatch()
for EP1_CMD_READ_{ERP,ANALOG,IO} replies, which report into
cdev->input_dev. Since commit b04dcbb7f7b1 ("ALSA: caiaq: Use
snd_card_free_when_closed() at disconnection") the input device is
unregistered from snd_usb_caiaq_input_disconnect() but cdev->input_dev
is cleared only later, in snd_usb_caiaq_input_free() from the card
destructor. As the dispatch guard only tests cdev->input_dev for NULL,
an EP1 reply that completes after input_unregister_device() but before
cdev->ep1_in_urb is killed reports into an input device that has
already been unregistered and, with no evdev client holding it open,
freed.

Normally the window is closed by the USB core: usb_unbind_interface()
calls usb_disable_interface() before ->disconnect(), which flushes the
EP1 URB as long as endpoint 0x81 belongs to the interface being
unbound. But caiaq addresses EP1 through the device-wide pipe
usb_rcvbulkpipe(usb_dev, 0x1) without checking which interface owns
the endpoint. If a device declares it in another interface, the URB
stays live across snd_disconnect() of the interface that owns the card.

This needs a crafted device descriptor; a device that has EP1 in the
interface caiaq is bound to is not affected.

Kill cdev->ep1_in_urb (and the paired midi_out_urb) before the input
and audio disconnect helpers, so no EP1 completion can run once the
input device has been unregistered.

Reproduced under KASAN with raw-gadget + dummy_hcd emulating an Audio
Kontrol 1 (17cc:0815) with the EP1 bulk pair in interface 1: only
interface 0 was bound to snd-usb-caiaq and then unbound through sysfs
while the gadget flooded EP1 with EP1_CMD_READ_ERP replies. With no PCM
stream running the window is very short and was only hit by stalling
the unbinding CPU with a kgdb breakpoint at
snd_usb_caiaq_audio_disconnect(). With the fix applied, the same test
runs clean.

  BUG: KASAN: slab-use-after-free in input_event+0x3a/0xc0
  Read of size 8 at addr ffff8880151a4028 by task sh/118

  Call Trace:
   <IRQ>
   input_event+0x3a/0xc0
   snd_usb_caiaq_input_dispatch+0xab2/0xf00
   usb_ep1_command_reply_dispatch+0x1f3/0x580
   __usb_hcd_giveback_urb+0x246/0x400
   dummy_timer+0x1415/0x3380
   __hrtimer_run_queues+0x39d/0x800
   hrtimer_run_softirq+0x187/0x2d0
   handle_softirqs+0x1ff/0x930
   __irq_exit_rcu+0x15b/0x210
   irq_exit_rcu+0xe/0x20
   sysvec_apic_timer_interrupt+0x81/0xb0
   </IRQ>
   <TASK>
   asm_sysvec_apic_timer_interrupt+0x1a/0x20
  RIP: 0010:snd_usb_caiaq_audio_disconnect+0x0/0x70
   snd_disconnect+0x81/0x110
   usb_unbind_interface+0x1a0/0x860
   device_release_driver_internal+0x2c5/0x470
   unbind_store+0xde/0x100
   </TASK>

  Allocated by task 80:
   input_allocate_device+0x47/0x340
   snd_usb_caiaq_input_init+0x4c/0x1ac0
   snd_probe+0xab3/0x1160
   usb_probe_interface+0x2ea/0x810

  Freed by task 118:
   kfree+0x1ea/0x5c0
   input_dev_release+0xab/0xd0
   device_release+0xcf/0x250
   kobject_put+0x169/0x320
   snd_disconnect+0x79/0x110
   usb_unbind_interface+0x1a0/0x860

Fixes: b04dcbb7f7b1 ("ALSA: caiaq: Use snd_card_free_when_closed() at disconnection")
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Nizovtsev <snizovtsev@cloudlinux.com>
Assisted-by: Claude:claude-opus-4-8
---
 sound/usb/caiaq/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 634dc36f2eade..d28465e916df2 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -600,14 +600,19 @@ static void snd_disconnect(struct usb_interface *intf)
 
 	snd_card_disconnect(card);
 
+	/*
+	 * Kill the EP1 URB before disconnecting the input device: its
+	 * completion reports into cdev->input_dev, which input_disconnect()
+	 * frees without clearing the pointer.
+	 */
+	usb_kill_urb(cdev->ep1_in_urb);
+	usb_kill_urb(cdev->midi_out_urb);
+
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
 	snd_usb_caiaq_input_disconnect(cdev);
 #endif
 	snd_usb_caiaq_audio_disconnect(cdev);
 
-	usb_kill_urb(cdev->ep1_in_urb);
-	usb_kill_urb(cdev->midi_out_urb);
-
 	snd_card_free_when_closed(card);
 }
 
-- 
2.56.1

