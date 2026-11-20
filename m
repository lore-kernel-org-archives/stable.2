Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195101;
	b=16DRTY1mg4W2Ckw+YOU36IiwwnX1WMh4ZGmnLZ77t/38pbMgshykKoB91u4xirLFZWpD
	 1yX4EmyvcebuueRIxGbHLZDuoC9xRZhreD3OsfwLobQdv+5NHcHZEdMhbzuzsTzrbQ95O
	 a1E0GPuVwg8CMuHstkYIPRVpiSK262K7IQFp6y0lhCx9S6wNhYyqYFqwio5EJHl+VsmaB
	 5PfsbkgUoJ84kE6JJW9iiumuMRE8v/vPVFyj/DOAMXk3dovwL3nzFchkwgBcDf7K50hhT
	 RiCGy+kNJofiCO+gQga91qsPzExKb+umpO47Mqb7P6m1lrzaFgI8hHbAmWWdemk7jQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195101;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Authenticated-Id;
	bh=QrOEJiHl97UFvdmQDswqLhAVnrBIT/C6U4HJu34bKcY=;
	b=YWP5Rf9SaeONercfhchC5vD+q1tmxGWOIrj0friJ/+Q7ffSC6SdTgp/S/0qT3BSMTdkV
	 j7wWWQDFcz5hUxF+uyXpz/3vXYayy1WboEsaw1dqha3AMm1AzLGRpvVvNDX1Z8Qy4guHb
	 gluQOAL39ETIIYTHhcyVrO34ih0elKqK4auNsAcja9kV8KxHyWjO8+vuyK4CpHKiFFY2S
	 VhrxYDNrMszCNk6WvOO+ebl7+LOzN9KhEVCtbQUzus+oSy22LfANbzYzgWIZDpRKPsdIN
	 hr5CoaBZB9YHmsbvlqZcjfVQ/Wc9mSoBpzoS6chUpdnPO8eJzPgof8YpQclOaPfqjSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.38
Received: from mail-e677.seohost-mail.eu (mail-e677.seohost-mail.eu [213.239.133.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA25B60A261F;
	Fri, 20 Nov 2026 17:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA25B60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xUSFY-0000000GpTo-0jV3;
	Fri, 20 Nov 2026 18:18:12 +0100
From: Piotr Kubik <piotr@kubik.pl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oliver Neukum <oneukum@suse.com>
Cc: Piotr Kubik <piotr@kubik.pl>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Lavra <francescolavra@interfree.it>,
	stable@vger.kernel.org
Subject: [PATCH v2] USB: cdc-acm: restore the line coding after a reset-resume
Date: Fri, 20 Nov 2026 18:18:09 +0100
Message-ID: <20261120171809.1494779-1-piotr@kubik.pl>
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

Send the cached line coding from acm_reset_resume() of the last
interface to resume, which acm->susp_count shows, before acm_resume()
restarts the URBs. The USB core calls reset_resume for each interface in
the order of the configuration descriptor, so the control interface is
not always the last one. Use the variant without the autopm reference,
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
    Changes in v2:
    - Send the line coding from the last interface to resume, which
      acm->susp_count shows, instead of from the control interface, which
      need not resume last (Oliver Neukum).
    - Commit message: describe the interface order.
    
    v1: https://lore.kernel.org/all/20261119122842.3611681-1-piotr@kubik.pl/
    
    Reproduced and tested on v7.4-rc3 in a QEMU 10.0.13 q35 guest. The v2
    runs used f11fe7603df0, the usb-linus head of 2026-11-19; three of the
    runs without the patch used mainline 20eef29b7c84, which has the same
    cdc-acm.c. The guest runs (TCG, qemu-xhci) with a WCH CH344 quad UART
    (1a86:55d5) passed through from the host. Port 0 is wired to a 115200
    8N1 console that answers a carriage return with a 24-byte login prompt.
    The guest holds the port open and suspends to RAM. While the guest is
    suspended, the host cuts VBUS of the hub port of the adapter for 3 s and
    then wakes the guest, which reset-resumes the adapter. The host's own
    cdc-acm binds the adapter between the power cut and the wakeup, so the
    adapter is at 9600 or at its power-on line coding when the guest
    resumes. The patch applies without offset to usb-linus b0baaf6cbb16 of
    2026-11-20, whose cdc-acm.c adds only device IDs.
    
    Without this patch: the read after the resume returns 1 byte and no
    prompt, and usbmon shows no SET_LINE_CODING after the resume (4 runs).
    With v2: the read returns the prompt, and usbmon shows one
    SET_LINE_CODING per port, with the cached line coding of that port
    (2 runs, one with an extra dev_info() in acm_reset_resume()). On the
    CH344 each control interface resumes before its data interface; the
    extra print shows that the data interface, the last one, sends the
    request, in S3 and in a runtime resume.
    
    Also with v2: a runtime resume with the RESET_RESUME quirk set for the
    adapter sends the line coding once per port and completes. Without a
    power cut the CH344 keeps its line coding, so the unpatched driver
    shows no fault in that case.
    
    Build: make W=1 drivers/usb/class/cdc-acm.o gives no new warnings.
    checkpatch.pl --strict reports no errors, warnings or checks.
    
    Not tested:
    - a device whose control interface resumes after its data interface
    - a reset-resume of a single port that lost power: in the guest the
      reset-resume came from the xHCI reinit ("root hub lost power or was
      reset")
    - a device that rejects SET_LINE_CODING (no USB_CDC_CAP_LINE)
    - a device with a combined control and data interface
    - this patch on bare metal; the fault itself was seen on a 6.12 host
      after S3
    - a port that is open during a runtime reset-resume
    - an autopm reference in reset_resume: the wait without end comes from
      reading rpm_resume(), not from a test

 drivers/usb/class/cdc-acm.c | 41 ++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 666969ffd194..bcbebcd47b3a 100644
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
@@ -1739,10 +1749,27 @@ static int acm_resume(struct usb_interface *intf)
 static int acm_reset_resume(struct usb_interface *intf)
 {
 	struct acm *acm = usb_get_intfdata(intf);
+	bool last;
 
 	if (tty_port_initialized(&acm->port))
 		tty_port_tty_hangup(&acm->port, false);
 
+	spin_lock_irq(&acm->write_lock);
+	last = acm->susp_count == 1;
+	spin_unlock_irq(&acm->write_lock);
+
+	/*
+	 * The device can lose its line coding, for example when it loses
+	 * power during system suspend, and acm_tty_set_termios() sends the
+	 * line coding only when it differs from acm->line. Send it from the
+	 * last interface to resume, before acm_resume() restarts the URBs.
+	 * In a runtime resume of the device, an autopm reference here would
+	 * wait for this resume and never return.
+	 */
+	if (last)
+		__acm_ctrl_msg(acm, USB_CDC_REQ_SET_LINE_CODING, 0,
+			       &acm->line, sizeof(acm->line));
+
 	return acm_resume(intf);
 }
 

base-commit: f11fe7603df07fbb9fa02b0d385c1696c87a6dab
-- 
2.55.0

