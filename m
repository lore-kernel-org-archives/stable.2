Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82236074F;
	Mon,  3 Aug 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754753; cv=none; b=M+LaTmZlK0WGh5lXNn/RnU7KKZZTKLJCtv/t5UHKXJ9QHRZ4zp2/59yrSS4D4oV7mMSec3Jm8gwiL8Ut1bmdA/sF8A6nnCBpJywGCxeDqzWnK3H1FC+HuEvIUBUWkwwblceFj0ngV72cofx0zeoAXaouTBK6JST3vBdhDNdxGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754753; c=relaxed/simple;
	bh=6SXnFRSdDbm70UHjYscRPhkZ6SMWvOFLDzHbm1/9TzY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M3nLpX8ydldNok1JFaKwgMObxl3K+yAdLk09AIlC4YUT+nVVpjc/jW+Iyt82C5+PrdLZmniO7x5PI7EL73EE3nOXKA/WZHpj35DWvPaVi3F7PGiotQeeYUp59TIcX2/AktQXAaHM8NcHmHNK1LloilPWmioHNByHu3/aCKxY6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 3 Aug
 2026 12:43:59 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Mon, 3 Aug 2026 12:43:59 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
	<shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Nobuo Iwata <nobuo.iwata@fujixerox.co.jp>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Wiliam Puranen <wiliam.puranen@actia.se>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, John Ernberg
	<john.ernberg@actia.se>
Subject: [PATCH] usbip: Stop tracking work context in event_handler()
Thread-Topic: [PATCH] usbip: Stop tracking work context in event_handler()
Thread-Index: AQHdIzT9TCrRTEFXHky+/yhIrax9MA==
Date: Mon, 3 Aug 2026 10:43:58 +0000
Message-ID: <20260803104342.2790105-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.53.0
x-esetresult: clean, is OK
x-esetid: 37303A2955B14556677266
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Wiliam Puranen <wiliam.puranen@actia.se>

The work queue used by usbip is not pinned to a specific context.

When usbip_in_eh() evaluates if the call comes from the event handler
it doesn't actually check if the call comes from the event handler but
if the call comes from the same context as the event handler was first
called from.

This can result in "sticky" devices on the client side, due to the
teardown path in stub_disconnect() being lied to, and thus skipping
the teardown when it shouldn't, or vice versa.

Fixes: bb7871ad99ea ("usbip: event handler as one thread")
Cc: stable@vger.kernel.org # v4.6+
Assisted-by: claude:opus-5
Signed-off-by: Wiliam Puranen <wiliam.puranen@actia.se>
Signed-off-by: John Ernberg <john.ernberg@actia.se>
---
 drivers/usb/usbip/stub_dev.c     |  2 +-
 drivers/usb/usbip/usbip_common.h |  2 +-
 drivers/usb/usbip/usbip_event.c  | 10 ++--------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index abfa11d6bde7..407ac55d85c5 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -474,7 +474,7 @@ static void stub_disconnect(struct usb_device *udev)
 	}
=20
 	/* If usb reset is called from event handler */
-	if (usbip_in_eh(current))
+	if (usbip_in_eh())
 		return;
=20
 	/* we already have busid_priv, just lock busid_lock */
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_com=
mon.h
index be4c5e65a7f8..2c91187e6469 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -321,7 +321,7 @@ int usbip_start_eh(struct usbip_device *ud);
 void usbip_stop_eh(struct usbip_device *ud);
 void usbip_event_add(struct usbip_device *ud, unsigned long event);
 int usbip_event_happened(struct usbip_device *ud);
-int usbip_in_eh(struct task_struct *task);
+int usbip_in_eh(void);
=20
 static inline int interface_to_busnum(struct usb_interface *interface)
 {
diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_even=
t.c
index 0e00c2d000f8..695af652c512 100644
--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -57,16 +57,10 @@ static struct usbip_device *get_event(void)
 	return ud;
 }
=20
-static struct task_struct *worker_context;
-
 static void event_handler(struct work_struct *work)
 {
 	struct usbip_device *ud;
=20
-	if (worker_context =3D=3D NULL) {
-		worker_context =3D current;
-	}
-
 	while ((ud =3D get_event()) !=3D NULL) {
 		usbip_dbg_eh("pending event %lx\n", ud->event);
=20
@@ -186,9 +180,9 @@ int usbip_event_happened(struct usbip_device *ud)
 }
 EXPORT_SYMBOL_GPL(usbip_event_happened);
=20
-int usbip_in_eh(struct task_struct *task)
+int usbip_in_eh(void)
 {
-	if (task =3D=3D worker_context)
+	if (current_work() =3D=3D &usbip_work)
 		return 1;
=20
 	return 0;
--=20
2.53.0
