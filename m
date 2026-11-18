Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989047;
	b=lUdXkYrq7KZLfzZ4J+ZfnwRBgNtbQ/IQ5YHZylSRC83gxqV9+OtDUdv2odan6iyKtvKm
	 7gl58v0lGUgo7sn9cC+k7W6Jc3C7VssfX9pqAPvQ0O2pv82uADL7XL7GbtBDNZh/BKMEz
	 PlIHCGC9QyGKfR8+Yj+K8hpbrELybuPVlv7Dl+09Y3P1Wpa6/AU7opD8/O1MIKunwZMua
	 eChvCR3nGf3Z1J+QYX5/T6cOaqQ4AnyYfszWEyKSA3xCyqok/Vu1Z7WxQnKvt5W6gw8iq
	 EeqLHlOzHInZSIHsRzFIUOsXKxPVo04LdTA8Ve7CiZdxnFGoOsRkyWEglTuOnPHKORA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989047;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:
	 Content-Type:CMS-TYPE:cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:
	 References;
	bh=nPhL0RFOndKGV3TeTmHBKTR0OS8aIiM1zP688dzTiqg=;
	b=dJ2N298zimAfb9gGvdmEHUo6IyXpsjNeweK9dWTKomJUx4gVAN0/7+KeL8lzW5sStV7T
	 1MGiwNb+XEFSyHx4mfS5CV5YILhdLaGbCTb+YPeB5buC4xEZDYHFXg4HxFiRHOIvW5soQ
	 hCc3ne3yE2+vs3UX/6yb0KYkMHGwDij7mfSvOjiqrJ27EkeC7ecL27KT1xQGonw5t5Q98
	 a4Z+q0gybrJnCiN70kGDixe1SN0MebQQ9ZEiih/7KaKbxLNeJ2jEK7Qj8LgsipdtmNI6w
	 nGxtO0ZERUTYo0KtOfv+UgrVsnncbyXJpeoI41Lp3jDaZpyEb4W5befqZyMinjIqMUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=HGXI6JwP;
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832A606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C832A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=HGXI6JwP
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261118080358epoutp031b09fb728b714910ceea00648a91ad7e~pFQU4fadC1932719327epoutp032
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:03:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261118080358epoutp031b09fb728b714910ceea00648a91ad7e~pFQU4fadC1932719327epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794989038;
	bh=nPhL0RFOndKGV3TeTmHBKTR0OS8aIiM1zP688dzTiqg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HGXI6JwPRZPUstWKn1NEH+XK2WL4YG0mnI1hotWo1ohLsqZcM6Nv1fpDfC3I/1ITA
	 wuxsMGkgbGPf+ssnhCQiJCUCO3nsnRoWZDn1xHKd7acxBwaGQIFCHPSyB2hKejVSqA
	 pt+c4Ui3Je625uC6EImhFtIub3Cn0+mZsFuRKJ6c=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20261118080358epcas1p3e4fc31cbda05e79feedd1a24414a7b3b~pFQUdCW0W1665316653epcas1p3r;
	Wed, 18 Nov 2026 08:03:58 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.192]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jTvHx5glxz6B9mG; Wed, 18 Nov
	2026 08:03:57 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261118080357epcas1p1d496c3dcbc37d76fd71365cbab494352~pFQTn794N1277012770epcas1p1U;
	Wed, 18 Nov 2026 08:03:57 +0000 (GMT)
Received: from VDBS1420.vd.sec.samsung.net (unknown [168.219.244.32]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261118080357epsmtip2c76d579b429228f941281ab6ec066621~pFQTlEMFR1491614916epsmtip2B;
	Wed, 18 Nov 2026 08:03:57 +0000 (GMT)
From: Gichoon Han <gichoon.han@samsung.com>
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gichoon Han <gichoon.han@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: host: ehci-sched: Don't let a bogus siTD remaining
 length underflow
Date: Wed, 18 Nov 2026 17:03:48 +0900
Message-ID: <20261118080348.172772-1-gichoon.han@samsung.com>
X-Mailer: git-send-email 2.50.1
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
X-CMS-MailID: 20261118080357epcas1p1d496c3dcbc37d76fd71365cbab494352
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261118080357epcas1p1d496c3dcbc37d76fd71365cbab494352
References: <CGME20261118080357epcas1p1d496c3dcbc37d76fd71365cbab494352@epcas1p1.samsung.com>

sitd_complete() computes the received length of a split isochronous
packet as desc->length - SITD_LENGTH(t), where SITD_LENGTH() is the
"Total Bytes to Transfer" count the controller leaves in the siTD.
Nothing checks that this remaining count is not larger than what was
programmed.  If the controller reports a larger value, the unsigned
subtraction wraps and the class driver gets an actual_length of
nearly 4 GiB for a packet that can hold at most 1023 bytes.

This was seen on a Novatek TV SoC with its on-chip EHCI controller
(DT compatible "nvt,NT72668-ehci", handled by ehci-hcd through a
vendor platform glue that is not in mainline), running a vendor 5.4
kernel whose ehci-sched.c matches mainline in this area.  A
full-speed UAC1 microphone behind a high-speed hub was streaming when
snd-usb-audio read far past the URB transfer buffer:

  Unable to handle kernel paging request at virtual address e8756000
  Internal error: Oops: 7 [#1] PREEMPT SMP ARM

The faulting memcpy() still had about 122 KB left to copy from a
full-speed packet, which can hold at most 1023 bytes; this
subtraction is the only place on that path that can produce such a
value.

snd-usb-audio now rejects such packets (commit eed0e9583a29 ("ALSA:
usb-audio: Drop capture packets with bogus actual_length")), but the
root cause is the controller hardware reporting an impossible
remaining count, and other class drivers trust actual_length too.

Treat a remaining count larger than the programmed length as a
protocol error instead of reporting a wrapped length.

Link: https://lore.kernel.org/r/87se19ufoi.wl-tiwai@suse.de
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gichoon Han <gichoon.han@samsung.com>
---
v2:
 - Identify the EHCI controller rather than the CPU (Alan)
 - Attribute the bug to the controller hardware, not the driver (Alan)
 - Explain why a wrapped length is the only explanation for the fault

v1: https://lore.kernel.org/r/20261116052851.2272125-1-gichoon.han@samsung.com

Compile-tested only (ARM32, W=1) on linux-next.  The oops comes from a
field report that included only the kernel log, so the siTD contents
were never captured.  I'm trying to reproduce it with an instrumented
build and will report the raw siTD values if I catch it.

 drivers/usb/host/ehci-sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 57d07d1c2dfa..12a10248a4b6 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -2241,6 +2241,10 @@ static bool sitd_complete(struct ehci_hcd *ehci, struct ehci_sitd *sitd)
 	} else if (unlikely(t & SITD_STS_ACTIVE)) {
 		/* URB was too late */
 		urb->error_count++;
+	} else if (unlikely(SITD_LENGTH(t) > desc->length)) {
+		/* controller claims more left than was programmed */
+		urb->error_count++;
+		desc->status = -EPROTO;
 	} else {
 		desc->status = 0;
 		desc->actual_length = desc->length - SITD_LENGTH(t);

base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
-- 
2.50.1

