Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581107;
	b=NVNatXCGFIea0qoYNB9M0GA5Urd+Dud2+/k6meVToCN7efUCbyHZWKs8MtYGINTagOmY
	 luGFQmIppB03aQoMJcEFoOIMBPve9N+dBwV0sjGbSwdYHs9Us0KjoNg7ycdTRiGW+9Ac9
	 39bcjGpmw2LO8Wgaxtz9KCvbiPM1tNOXpR7ysG0Z+rWylP4WTe2oXqfYNGYDJzKTMfHTW
	 LXGu/tsQFVtu/9Q5krbikf0cu1uWDa6HXEFQOhVYWIf7IpSkf0Olzv1CTasnJpQ32wds9
	 enG3cPE06NCfcfCsRYRH2+VnHeYwezcpalWlFhH7DqvaJoGkUSPiH4jmr+LWMTkEsoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581107;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jF1g0y9jm2+R+Wr/UKLxocL5q1AxkOT9H3ZTJEWe8qU=;
	b=kqJePN7QzE38GM8Tg4q5cVzy6YT4ltrsO3f2kDG3+UvJ0zYSalc5CzBhk98jklxN+B1C
	 SXmoShE7r7BHhUqvYl32LgS9HzAed97k7S+Pdv5W7a6r/VJqRS8GO81ixGgFr6aJm5iH8
	 1VUGLxhK2syJ29Yz78sw624ajd4YaXq/7RLeBHrb6Nwvp4ezCsDMvrhsUDnScJsdkV7zW
	 rG2lfrQs24wRLJhT3AvZLFB0VFATC/tJjNmZ9mUCSukviHSKld/N99GAqPXq1aLd+ybm7
	 ga6DC4wFwXWE3zN15EL4XTuZ4SmKgPTfwC9BRx5wB56DXtN/O1u7XZzLP6T6CHOVyRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=becholey.ch;
	spf=pass smtp.mailfrom=becholey.ch;
	dkim=pass header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=eZ+hWB5r;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA21606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA21606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=becholey.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=becholey.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=becholey.ch header.i=@becholey.ch header.a=rsa-sha256 header.s=protonmail header.b=eZ+hWB5r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=becholey.ch;
	s=protonmail; t=1794581104; x=1794840304;
	bh=jF1g0y9jm2+R+Wr/UKLxocL5q1AxkOT9H3ZTJEWe8qU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eZ+hWB5rKx9yw7tsb9VfFGbwJXq6PfJADS0FueH80SYh8XdkWoTKLu98iOytoAjhD
	 zZOz6jgQ5zjVaX2cU0gM/0XjbjjpeVi66yZfrLEy75v42LXYZNzw/9anG7twqk4Trk
	 9VCWOj9g0qqzj3YR7jlUFuwp6Y6VPieja8YzsRofqkAHNhAtS3LhNlF+v2/19E4LJB
	 6XAQcXm9byM/BbQo+tXa/Y6wyUt2pf8axlyjwCcjvVUdHi44lBeeSlKp1WcAgv0Vot
	 uPmEJ/494T23o+LK+Rssxn66+F+ERNTmcOa/qZt+i32+rYdE+ySl9l6y5XUpU7T9v1
	 WzCIJCSznlz9Q==
Date: Fri, 13 Nov 2026 14:44:58 +0000
To: Lixu Zhang <lixu.zhang@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Haotian Zhang <vulab@iscas.ac.cn>
From: Alexandre Becholey <alex@becholey.ch>
Cc: Alexandre Becholey <alex@becholey.ch>, stable@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: ljca: Validate the pin index of interrupt events
Message-ID: <20261113144432.1354180-1-alex@becholey.ch>
Feedback-ID: 60743817:user:proton
X-Pm-Message-ID: 95b8c980a6ac2b92f83445eea46e14d4d1eefe89
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ljca_gpio_event_cb() takes the pin index of every item in a GPIO
interrupt event from the device and passes it to set_bit() on the
reenable_irqs bitmap, which is only LJCA_MAX_GPIO_NUM (64) bits long.
The index is a u8, so a malfunctioning or malicious device can set
bits past the end of the bitmap, in the members that follow it in
struct ljca_gpio_dev: the output_enabled bitmap, the connect_mode
pointer and the irq_lock mutex. connect_mode is later dereferenced and
written to by ljca_gpio_set_config() and ljca_irq_set_type(), so the
device can flip bits of a kernel pointer that is then used for a write.

Until commit 4c4e6ea4a120 ("gpio: ljca: Fix duplicated IRQ mapping")
an index without an IRQ mapping made irq_find_mapping() fail and the
handler returned before set_bit(). Since that change nothing checks
the index.

A device bound to usb-ljca can trigger this by sending one GPIO
interrupt event, once the gpiochip is registered, with an index that
sets a bit of connect_mode which is still clear in a kernel pointer:
175 (bit 47) on arm64, 174 (bit 46) on x86_64. The next GPIO line
request then faults in ljca_gpio_set_config(). With dummy_hcd and
KASAN, on arm64 (torvalds/master 067c5c24cef2):

 Unable to handle kernel paging request at virtual address ffff7000023dfd30
 pc : ljca_gpio_set_config (drivers/gpio/gpio-ljca.c:212)

and on x86_64 (torvalds/master 7e1392a42ea2, nokaslr):

 BUG: unable to handle page fault for address: ffffc8800f5452b8
 RIP: 0010:ljca_gpio_set_config (drivers/gpio/gpio-ljca.c:212)

Ignore event items whose pin index is not below the number of GPIOs of
the chip. That number never exceeds LJCA_MAX_GPIO_NUM, because
usb-ljca rejects larger values at enumeration, so set_bit() stays
inside the bitmap. Valid items in the same event are still handled.

The bug was found by AI agents (Claude Mythos and Claude Opus models). The
analysis and the patch were reviewed by a human, who also reproduced the
bug on x86_64 and aarch64 with current master.

Fixes: 4c4e6ea4a120 ("gpio: ljca: Fix duplicated IRQ mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Becholey <alex@becholey.ch>
---
Notes for reviewers (not part of the commit message):

Trigger: an emulated USB device (raw-gadget + dummy_hcd under QEMU)
with ID 8086:0b63 that answers the LJCA enumeration with one GPIO bank
of 32 pins, one I2C and one SPI controller, and acks every command.
Once /dev/gpiochipN exists it sends one GPIO interrupt event
{num =3D 1, item[0] =3D {index =3D 175, value =3D 0}} (174 on x86_64, see
below). The bit flip itself
needs no host action. The fault happens on the next host operation
that touches connect_mode; in the reproducer a host thread requests
lines as inputs through the GPIO character device. KASAN does not
see the set_bit() itself because it stays inside the object, so the
reproducer makes it visible through connect_mode, and the index that
does so depends on the architecture's kernel address layout:

- arm64: index 175 sets bit 47, ffff0000... (linear map) becomes
  ffff8000..., which is unmapped.
- x86_64: bit 47 is already set in every kernel pointer, so index 175
  changes nothing and the run is clean. Index 174 sets bit 46 instead:
  ffff888... (direct map) becomes ffffc88..., the unused hole below
  the vmalloc area. Boot with nokaslr so the direct map base is fixed.
  Reproduced this way on torvalds/master 7e1392a42ea2 under QEMU (q35,
  KASAN): page fault on a supervisor write in
  ljca_gpio_set_config+0x76.

The reproducer is available to maintainers on request.

Decoded trace, torvalds/master 067c5c24cef2 (arm64, QEMU virt, KASAN):

  Unable to handle kernel paging request at virtual address ffff7000023dfd3=
0
  KASAN: probably wild-memory-access in range [0xffff800011efe980-0xffff800=
011efe987]
  Internal error: Oops: 0000000096000006 [#1]  SMP
  CPU: 0 UID: 0 PID: 76 Comm: repro Not tainted 7.4.0-rc2-00092-g067c5c24ce=
f2 #1 PREEMPT(full)
  Hardware name: linux,dummy-virt (DT)
  pc : ljca_gpio_set_config (drivers/gpio/gpio-ljca.c:212)
  lr : ljca_gpio_set_config (drivers/gpio/gpio-ljca.c:210)
  Call trace:
   ljca_gpio_set_config (drivers/gpio/gpio-ljca.c:212) (P)
   gpio_do_set_config (drivers/gpio/gpiolib.c:2862 (discriminator 1))
   gpiod_set_transitory (drivers/gpio/gpiolib.c:2885 drivers/gpio/gpiolib.c=
:2896 drivers/gpio/gpiolib.c:3404 drivers/gpio/gpiolib.c:3394)
   linereq_create (drivers/gpio/gpiolib-cdev.c:1672)
   gpio_ioctl (drivers/gpio/gpiolib-cdev.c:2435)
   __arm64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:598 fs/ioctl.c:584 fs/ioctl.=
c:584)
   invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/ke=
rnel/syscall.c:49)
   el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:121)
   do_el0_svc (arch/arm64/kernel/syscall.c:140)
   el0_svc (arch/arm64/kernel/entry-common.c:797)
   el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:816)
   el0t_64_sync (arch/arm64/kernel/entry.S:606)

The same crash reproduces on v7.3.1. The only change to gpio-ljca.c
between v7.3.1 and 9d66f26fefac is the treewide devm_kzalloc_obj()
conversion (4dd10fbbeb9c).

Testing on v7.3.1: with the patch the reproducer runs clean (10/10
with dummy_hcd, 1/1 with an emulated xHCI host), and so does a variant
that sends every index from 64 to 255 after a valid index 0 (3/3); the
GPIO line requests succeed after the event. Without the patch all
three crash in ljca_gpio_set_config() (3/3).
Testing on 9d66f26fefac: with the patch the reproducer runs clean
(10/10 with dummy_hcd, 1/1 with an emulated xHCI host) and so does
the sweep variant (3/3); without it all three crash in
ljca_gpio_set_config() (3/3).

Related, not addressed here: ljca_gpio_event_cb() also does not check
packet->num against the length of the event. That is covered by the
separate patch "gpio: ljca: validate event payload length"
(Message-ID 20260720054906.69588-1-david.lee@trailofbits.com), which
is not in 9d66f26fefac.
Both patches touch the same loop, so the second one applied may need a
trivial rebase.

Thanks,
Alexandre Becholey

 drivers/gpio/gpio-ljca.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index f32d1d237795..301c898f4a64 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -292,9 +292,14 @@ static void ljca_gpio_event_cb(void *context, u8 cmd, =
const void *evt_data,
 =09=09return;
=20
 =09for (i =3D 0; i < packet->num; i++) {
-=09=09generic_handle_domain_irq(ljca_gpio->gc.irq.domain,
-=09=09=09=09=09packet->item[i].index);
-=09=09set_bit(packet->item[i].index, ljca_gpio->reenable_irqs);
+=09=09u8 index =3D packet->item[i].index;
+
+=09=09/* The pin index comes from the device, do not trust it */
+=09=09if (index >=3D ljca_gpio->gc.ngpio)
+=09=09=09continue;
+
+=09=09generic_handle_domain_irq(ljca_gpio->gc.irq.domain, index);
+=09=09set_bit(index, ljca_gpio->reenable_irqs);
 =09}
=20
 =09schedule_work(&ljca_gpio->work);
--=20
2.53.0


