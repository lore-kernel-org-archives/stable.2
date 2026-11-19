Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091369;
	b=EeFXe1JHxYC8lzbC1wdHL5w9HfsZ+txeyz4KXzifoAR8DD1IZqmPwdz6TJJw+my0Zb7l
	 Q3ypMfDLSx827mI6q6+5iCJsL318JAzaBemgAU3p1W/sqNzaXJ9+ci2yoebFdvgiNMl5C
	 FX1vet4J2pDtfpdkgiSx8Eq1YSs19r4yX/bdH5NEt0QSa/oiobG0+eG4TSktx6X/XNfwA
	 SvtIB/YKDXV1Tqt48yklZZn17XGS1KihaYNAIIX4MmSV0EwqdEMvVSvtSgY+tvvCfWR3R
	 4S8JaRQsOFHuSGgRrJsyKuBGzCeohm5c+9iK1Zukp3zmb3VDtqesh02u+LXneF6TnWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091369;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Authenticated-Id;
	bh=Q0+FiVv1KNhpet7pyzkRxe46PeVX79jJKB0dtJFKUXY=;
	b=rhkh2H2tm5a3nq5iCoXflOKDaLLmZqm/ESc282SSLuiYBq7ToOuS8qZQ71cicsP+toEy
	 vcYXLHhULSVEwksjr74w9T1l8qUyCUXYadSE5QBZn+QgxqGuBI2JHT9Jk3NXZPV589zWi
	 oy9uzUHu3hE6ghrYVCFmMxSpa/AM80JtiuCtWMpCRqTRX86AOWrHy6AyI19PA/+pFlbav
	 xYtxPY0DQi/1KOtacM9cRk2sXprMtBGFJgOHQI257kAkIp41Tz0QR0sJu/wstoNo03Wb+
	 IaHCM1QZchvkXsXUH/G4SYZ+N4Zn7iM1giilPXluVUxA954DaFPAFP+D2pej43NdRfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.37
Received: from mail-e842.seohost-mail.eu (mail-e842.seohost-mail.eu [213.239.133.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBB606A320;
	Thu, 19 Nov 2026 12:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71CBB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xU1GQ-00000000NtP-3R8n;
	Thu, 19 Nov 2026 13:29:18 +0100
From: Piotr Kubik <piotr@kubik.pl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oliver Neukum <oneukum@suse.com>
Cc: Piotr Kubik <piotr@kubik.pl>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Lavra <francescolavra@interfree.it>,
	stable@vger.kernel.org
Subject: [PATCH] USB: cdc-acm: restore the line coding after a reset-resume
Date: Thu, 19 Nov 2026 13:28:42 +0100
Message-ID: <20261119122842.3611681-1-piotr@kubik.pl>
X-Mailer: git-send-email 2.55.0
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
X-Authenticated-Id: piotr@kubik.pl

A device that loses power during system suspend comes back at its
power-on line coding. With USB persist, the USB core then resets the
device and calls acm_reset_resume(), but acm->line still holds the line
coding that the driver sent last. acm_tty_set_termios() sends
SET_LINE_CODING only when the termios differ from acm->line, so an open
with the same settings sends nothing. The port then runs at the wrong
rate until the termios change or the device is probed again.

Send the cached line coding from acm_reset_resume(). Send it only for
the control interface, because the USB core calls reset_resume for the
data interface too. Use the variant without the autopm reference,
because reset_resume also runs in a runtime resume of the device, where
usb_autopm_get_interface() would wait for that same resume and never
return. Ignore the result, as acm_probe() does, because a device without
USB_CDC_CAP_LINE need not support the request.

I saw the fault on my workstation while using serial consoles.
Claude Code agent (Opus 5.5) traced the cause to the cached
acm->line and wrote the first draft of this patch and this commit message.
It also wrote and ran the test: a QEMU guest with the adapter passed
through, and a USB power cut while the guest was in S3.
Two other Claude instances reviewed the patch, the message and the test
record. I reviewed the patch and I understand the change.

Fixes: a91b0c502285 ("cdc_acm: add reset_resume method")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Kubik <piotr@kubik.pl>
---

Notes:
    Reproduced and tested on v7.4-rc3-178-g20eef29b7c84 in a QEMU 10.0.13
    q35 guest (TCG, qemu-xhci) with a WCH CH344 quad UART (1a86:55d5) passed
    through from the host. Port 0 is wired to a 115200 8N1 console that
    answers a carriage return with a 24-byte login prompt. The guest holds
    the port open and suspends to RAM. While the guest is suspended, the host
    cuts VBUS of the hub port of the adapter for 3 s and then wakes the
    guest, which reset-resumes the adapter. The host's own cdc-acm binds the
    adapter between the power cut and the wakeup, so the adapter is at 9600
    or at its power-on line coding when the guest resumes.
    The patch is based on usb-linus f11fe7603df0, where cdc-acm.c and
    cdc-acm.h are the same as in the tested tree.
    
    Without this patch (3 runs): the read after the resume returns 1 byte
    and no prompt, and usbmon shows no SET_LINE_CODING after the resume.
    With this patch (3 runs): the read returns the prompt, and usbmon shows
    one SET_LINE_CODING per port, with the cached line coding of that port.
    
    Also with this patch: S3 without the power cut, and a runtime resume
    with the RESET_RESUME quirk set for the adapter, both send the line
    coding once per port and complete. Without the power cut the CH344 keeps
    its line coding, so the unpatched driver shows no fault in those cases.
    
    Build: make W=1 drivers/usb/class/cdc-acm.o gives no new warnings.
    checkpatch.pl --strict reports no errors, warnings or checks.
    
    Not tested:
    - a device that rejects SET_LINE_CODING (no USB_CDC_CAP_LINE)
    - a device with a combined control and data interface
    - this patch on bare metal; the fault itself was seen on a 6.12 host
      after S3
    - a port that is open during a runtime reset-resume
    - an autopm reference in reset_resume: the wait without end comes from
      reading rpm_resume(), not from a test

 drivers/usb/class/cdc-acm.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 666969ffd194..2e6710baa170 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -108,15 +108,11 @@ static void acm_release_minor(struct acm *acm)
  * Functions for ACM control messages.
  */
 
-static int acm_ctrl_msg(struct acm *acm, int request, int value,
-							void *buf, int len)
+static int __acm_ctrl_msg(struct acm *acm, int request, int value,
+			  void *buf, int len)
 {
 	int retval;
 
-	retval = usb_autopm_get_interface(acm->control);
-	if (retval)
-		return retval;
-
 	retval = usb_control_msg(acm->dev, usb_sndctrlpipe(acm->dev, 0),
 		request, USB_RT_ACM, value,
 		acm->control->altsetting[0].desc.bInterfaceNumber,
@@ -126,9 +122,23 @@ static int acm_ctrl_msg(struct acm *acm, int request, int value,
 		"%s - rq 0x%02x, val %#x, len %#x, result %d\n",
 		__func__, request, value, len, retval);
 
+	return retval < 0 ? retval : 0;
+}
+
+static int acm_ctrl_msg(struct acm *acm, int request, int value,
+			void *buf, int len)
+{
+	int retval;
+
+	retval = usb_autopm_get_interface(acm->control);
+	if (retval)
+		return retval;
+
+	retval = __acm_ctrl_msg(acm, request, value, buf, len);
+
 	usb_autopm_put_interface(acm->control);
 
-	return retval < 0 ? retval : 0;
+	return retval;
 }
 
 /* devices aren't required to support these requests.
@@ -1743,6 +1753,17 @@ static int acm_reset_resume(struct usb_interface *intf)
 	if (tty_port_initialized(&acm->port))
 		tty_port_tty_hangup(&acm->port, false);
 
+	/*
+	 * The device can lose its line coding, for example when it loses
+	 * power during system suspend, and acm_tty_set_termios() sends the
+	 * line coding only when it differs from acm->line. Send it once, for
+	 * the control interface. In a runtime resume of the device, an autopm
+	 * reference here would wait for this resume and never return.
+	 */
+	if (intf == acm->control)
+		__acm_ctrl_msg(acm, USB_CDC_REQ_SET_LINE_CODING, 0,
+			       &acm->line, sizeof(acm->line));
+
 	return acm_resume(intf);
 }
 

base-commit: f11fe7603df07fbb9fa02b0d385c1696c87a6dab
-- 
2.55.0

