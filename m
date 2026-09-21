Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0E2BE02C
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789957224; cv=none; b=kt7LzM+PjBxraXsPtk6isQobJ6+HyD6T3DOC6l10+ObkBlXZzOYWotduiNz1ERA57nc3rFR6dMorrmeSdBkCFFqQo/BwW4+xDei9i11EdFhhH2qetAQpOPFzPsRYTa6W2jYDA1rbEc/Sr1RcJRbMdI5EngD2SftjDng7B0hPehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789957224; c=relaxed/simple;
	bh=vUf7QAanQ5dKq7z/fJvehLlpKSca00cy1tgrEizeFrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L88/Dn4D4vA1+lbKliIXcI2LcHIuNMFmVVPoiCvTrAa/qZ0hFhRWm9OquAToeEiPmCJVW8VqAJnR5L3bapW+V6Wmg4seZPe92CH9l5UlDIt88J1RDz/iY3n+MnW7IORXHjgWMBd05McIuZIZFMVbXxNrGVz7z8e32poC3KfPiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0skpZ1p; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0skpZ1p"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso2046278a12.1
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 19:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789957222; x=1790562022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTEAVZypIz1LkNdblYydsxE0PH83Gg7fz01btoAhDQ8=;
        b=I0skpZ1pJIiIOg5VKbG985MPt0AA6F0R5zFL3/qkDidr2Zbc/6z+2i3syYoSGooqP7
         p+39zbfeUDa9iz0i0ew0Kk1XR2hBMrrTgtRy1A7mKbnADQ4ByThct2Yhkp0bNMBm9D7w
         HcBiuSN/5qmdlnfE+f+mVmvUV0OzPqmi1yi8dv2TNaPdZGDdRnROfIPwRh6DCXGnehBy
         9BqoCEL6cJSOP2k7RKEVzcnyuwvIf+DA9XN8HcNbgd04RvHUcYmp3Z0GnDxMYg6Nzpcy
         3oeMrdHjMwncV8fwHlq9H05w00MkYxHt6NYP1uteM0ihvL11Mpv4FJDsRmCcc8ZQjIb/
         xCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789957222; x=1790562022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FTEAVZypIz1LkNdblYydsxE0PH83Gg7fz01btoAhDQ8=;
        b=1CU54S1FIsQ6OHibKemin0FWtTzbRaWXpJ7WGjatFQp7CdCVsp/tzQjDCpnC4Y5fpY
         NK8xERHKi3eQKQeGj96t5yol+ikDy2Styv7Q8TQX6bb+hKz+nuXRQcRbJdcPOpiF/bly
         04SkUyLlEQp9kuQJNMbSiHaGIP10GeC/skTic2lNa4L4C8EIZ3KH4zKXg23BsCHulZiy
         +ml2ecBQATIhScPGRuf4tgfVNOUOC2dnhDvSyGiaw96GvazFMfc1UShb3gmsB1ctYFS8
         ZFdGf02vRKqsPCx+0SHJccf6m9M19wwYzrp5TgsSM3yUko577gLZq2Xz0iyuiTNjCo4T
         Y2bA==
X-Forwarded-Encrypted: i=1; AKwUvByYoY21aoKQyDIyvCSRpsvwN+EtUfcNpb+hWSb6XPYj7XYeAf4/w5hEbkTPAfESnmda1AjM+5o=@vger.kernel.org
X-Gm-Message-State: AFuF++kPImJrqlNp204mx6hB+IeyyWrtlYm6bdRSfQYDvf2i20zWjwXw
	Mgiw40CabU/u8C4uH5Hl4kF4fACvG0d32YCpaEFot8tvoXW1ylpkCnu/
X-Gm-Gg: AYBFou3xy2sbby/t1QvEkU2xrA92/giJQCu6HdBaQN04XsuVGeYgHqRppdBfo3d0A6/
	K/mXqjSsoiMjhvE/3ZUyw85x//rbrLBLdXpRepxMCAKlVXgkTXeHGHxjKK4YoxbW/jEJUUvY975
	KEhyafMPKjWchdzn8qER5aaA6/Nb8vMeIlNCdHcuh3gziLUTfXvJem8DxJe7Sc3wylSv9PQinib
	6lHp5mzUWeCNbwb6h/LrVIZyF9kRFi8yn4xpC2nAOO1cx4mkRF2sJe9i1qcLsXyOU4qwY8bKPie
	IKhoACfhEL55+9h6XTHpiBCA7fS8VcKPPB0xfp5uUWNQEOWlcXdPdxB1suOc0TF7u2zlaiyq/ig
	9wUPln6SXipqkKn4kO0Z8zXzE3fmBl2HYJ0Llrm05dnX38R0/Ao4T/GmetmBZPoaPbT2tNtDFRJ
	fJZnhYLNVmZJFIePhtz7crSAH21rRhmfih4/sgpR4sHwmE1CsBViypDfIfxpcVt4MINo2Lu1p/O
	t8WAXPKlMisgjnwZgzXLFvZRNqpznxAXXQE83gLbhm5I4zPysQQZWnh9avqDlkXe20v6cU53A42
	YUg5Zp2p3A==
X-Received: by 2002:a17:90b:17ca:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39e54cb43c7mr14530866a91.6.1789957222045;
        Sun, 20 Sep 2026 19:20:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm11294882a91.13.2026.09.20.19.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:20:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Hui Peng <benquike@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] char: hpet: prevent hard-IRQ divide-by-zero in hpet_interrupt() via HPET_IRQFREQ
Date: Mon, 21 Sep 2026 02:20:19 +0000
Message-ID: <20260921022019.865442-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919203515.2581203-1-benquike@gmail.com>
References: <20260919203515.2581203-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hpet_ioctl_common(), HPET_IRQFREQ computes the timer period as:

  devp->hd_ireqfreq = hpet_time_div(hpetp, arg);

where hpet_time_div() returns div64_ul(hpetp->hp_tick_freq + (arg >> 1),
arg). Whenever arg > 2 * hpetp->hp_tick_freq, integer division truncates
to 0 and stores devp->hd_ireqfreq = 0.

Although hpet_ioctl_ieon() (HPET_IE_ON) checks if (!devp->hd_ireqfreq)
before enabling the timer interrupt, HPET_IRQFREQ neither rejects
updates while HPET_IE is already active nor checks whether
hpet_time_div(hpetp, arg) evaluates to 0. As a result, arming the timer
with a valid frequency (for example, HPET_IRQFREQ with 1000 Hz followed
by HPET_IE_ON) and then calling HPET_IRQFREQ with a large frequency (such
as 0xffffffffUL) overwrites devp->hd_ireqfreq with 0 while the timer
interrupt is active. When the next interrupt fires, hpet_interrupt()
reads t = devp->hd_ireqfreq (0) and computes base = mc % t, crashing the
kernel in hard-IRQ context:

  Oops: divide error: 0000 [#1] SMP KASAN PTI
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0
  RIP: 0010:hpet_interrupt+0x20f/0x360
  Call Trace:
   <IRQ>
   __handle_irq_event_percpu+0x102/0x400
   handle_irq_event+0xa6/0x1c0
   handle_level_irq+0x205/0x5e0
   __common_interrupt+0x60/0x130
   common_interrupt+0x7a/0x90
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Reject HPET_IRQFREQ with -EBUSY when HPET_IE is set in devp->hd_flags,
and return -EINVAL when hpet_time_div(hpetp, arg) evaluates to 0.

Tested in QEMU (-global hpet.hpet-intcap=0x0c24 with noapic) by opening
/dev/hpet and calling ioctl(fd, HPET_IRQFREQ, 1000), ioctl(fd,
HPET_IE_ON, 0), and ioctl(fd, HPET_IRQFREQ, 0xffffffffUL): on the unfixed
kernel this immediately triggers the divide error panic in
hpet_interrupt(), whereas on the fixed kernel HPET_IRQFREQ returns -EBUSY
while HPET_IE is enabled and -EINVAL when hpet_time_div(hpetp, arg) is 0.

Fixes: ba3f213f8a31 ("[PATCH] HPET: make frequency calculations 32 bit safe")
Fixes: 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation for delayed interrupts")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org and include the QEMU test procedure and
  oops trace in the commit description per Greg Kroah-Hartman.
- Add Fixes: 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation
  for delayed interrupts") for the mc % t division in hpet_interrupt().

 drivers/char/hpet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 285c6037417a..ada95872e148 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -625,13 +625,18 @@ hpet_ioctl_common(struct hpet_dev *devp, unsigned int cmd, unsigned long arg,
 		devp->hd_flags &= ~HPET_PERIODIC;
 		break;
 	case HPET_IRQFREQ:
+		if (devp->hd_flags & HPET_IE) {
+			err = -EBUSY;
+			break;
+		}
+
 		if ((arg > hpet_max_freq) &&
 		    !capable(CAP_SYS_RESOURCE)) {
 			err = -EACCES;
 			break;
 		}
 
-		if (!arg) {
+		if (!arg || !hpet_time_div(hpetp, arg)) {
 			err = -EINVAL;
 			break;
 		}
-- 
2.49.0
