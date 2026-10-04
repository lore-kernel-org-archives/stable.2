Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258D14A8B;
	Sun,  4 Oct 2026 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791073662; cv=none; b=euusMBXgamgnHova2SDqQBcpHPaJi5iQZsnFnAG1ujGaj4oE/x1NMmMUXnX5/iXpMJ4aCjqdWT2TFAjnh1hkyhhXukKTwG6DzKCz4j9kAcDCz7AStB3cFXin5xO25WazSVR5br8TSasKhnQRsu3A+ZyHF4Oj5ttn4mnBeciWxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791073662; c=relaxed/simple;
	bh=fNWUa0VN9KVJYTPp9eZ1Vw5IdZul9zeJtLwOyZPQHwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q52/IM8BRWP9R+fGufYS8eUOIQM2SLCuqF6tK/W/UyXGubVI4r0DiVc2cN6WbemD92TNxrc6w3rjJSQOXSiaS+csCilJYzonN3GxeDtXl6SL17Pv9On54qKi77Fk2gVOUbn99FvTDxy6DH8UkNu+Z/QmGqDvFubRxTEy3GLyIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=mirko.jechow@gmx.de header.b=DxMSWRm8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=mirko.jechow@gmx.de header.b="DxMSWRm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791073658; x=1791678458; i=mirko.jechow@gmx.de;
	bh=TWRzGL9dFLo5bCwDF/Zlp2Q3/qrjalr+cmn7kX58pEQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DxMSWRm8YRSbf0U0uubscv6t2axNwB10VEtYZi4Ds+EsSJQFj+scjI/yr+hUR8P2
	 0/qVQHG8DQn54etZQ4zKaj3MznApeTzjWc2TtdNaPa7Dcmi4S/BCpvB7TM8kp0H5b
	 PHikJFcd73KPByuHOiXNQeCCXqHANOC7g6hXK2RIlGwe8MkYWTdJ/o7VxdL12Zq0b
	 RECUSn4cBdRSOm8J6wDfafuSmxm04U128Ef8Sl9yCInnQX5jjXfKteyeodn+aGeXO
	 SiGoquuLeCacrnR6cC4u4+vpmkdx7RUednk57UFbTfD9d2T4AqMnumBUWix7f2qru
	 KVpWAZRmmKAw1q5OEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe9s-1x1f481FH4-00PqtK; Sun, 04
 Oct 2026 02:27:38 +0200
From: Mirko Jechow <mirko.jechow@gmx.de>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Horvath <linux@stevetech.au>,
	stable@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jihong Min <hurryman2212@gmail.com>,
	Mirko Jechow <mirko.jechow@gmx.de>
Subject: [PATCH v3] usb: xhci-pci: Add AMD 600 series to xhci-pci-prom21
Date: Sun,  4 Oct 2026 02:27:31 +0200
Message-ID: <20261004002731.49927-1-mirko.jechow@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zZzojEyzjIx9zaXDvLnefAC5ik0DaaG/Ut0AJQv2dltkfWAgVGQ
 qckMmDLWZ5CorxxTD96+3Dt+2If1iX2KIGMyO0VqNiGrIdI6uavAhffmWEV+WjGlEWbK+Rp
 BvVEh/ACRjxruo9h9zE7ilMmVmL2ML0bzxGEmLsMEWpmAz59MmMRaIH7G3lsdbCej2kNyS0
 pz+d54vzusOxlNtAHuLmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8VOsx5viDUw=;jmVEH9l9IwRhJVwAKPR2csZ4ljh
 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

From: Stephen Horvath <linux@stevetech.au>

It seems the xhci-pci-prom21 module only has IDs for the 800 series
chipsets. However, the 600 series chipsets also have Promontory 21
chips, so we should add their IDs to the list as well.

I have tested this on my X670 board featuring DID `0x43f7`.

`1022:43f7` also appears on the PCI ID database
(https://pci-ids.ucw.cz/read/PC/1022/43f7).
Device IDs `0x43f9` (B665) & `0x43fa` (A620) were suggested by Shyam.

Also list the new IDs in Documentation/hwmon/prom21-xhci.rst.

Cc: stable@vger.kernel.org # 7.2.x
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Jihong Min <hurryman2212@gmail.com>
Signed-off-by: Stephen Horvath <linux@stevetech.au>
Tested-by: Mirko Jechow <mirko.jechow@gmx.de>
[mirko.jechow@gmx.de: add new IDs to prom21-xhci.rst]
Signed-off-by: Mirko Jechow <mirko.jechow@gmx.de>
=2D--
Changes in v3:
- List the new IDs on the PCI IDs line of Documentation/hwmon/prom21-xhci.=
rst
  (requested by Jihong Min)
- Picked up from Stephen; v2 had no follow-up since 2026-08-23
- Link to v2: https://patch.msgid.link/20260820-xhci-pci-prom21-v2-1-638e5=
958fbbf@stevetech.au
=2D--
 Documentation/hwmon/prom21-xhci.rst | 2 +-
 drivers/usb/host/xhci-pci-prom21.c  | 3 +++
 drivers/usb/host/xhci-pci.c         | 3 +++
 drivers/usb/host/xhci-pci.h         | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/prom21-xhci.rst b/Documentation/hwmon/pro=
m21-xhci.rst
index 7984fb187bd8a..6c0b6e7368921 100644
=2D-- a/Documentation/hwmon/prom21-xhci.rst
+++ b/Documentation/hwmon/prom21-xhci.rst
@@ -9,7 +9,7 @@ Supported chips:
=20
     Prefix: 'prom21_xhci'
=20
-    PCI IDs: 1022:43fc, 1022:43fd
+    PCI IDs: 1022:43f7, 1022:43f9, 1022:43fa, 1022:43fc, 1022:43fd
=20
 Author:
=20
diff --git a/drivers/usb/host/xhci-pci-prom21.c b/drivers/usb/host/xhci-pc=
i-prom21.c
index 6486f4a093455..5f088a47d79f3 100644
=2D-- a/drivers/usb/host/xhci-pci-prom21.c
+++ b/drivers/usb/host/xhci-pci-prom21.c
@@ -111,6 +111,9 @@ static void prom21_xhci_remove(struct pci_dev *dev)
 }
=20
 static const struct pci_device_id pci_ids[] =3D {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
 	{ /* end: all zeroes */ }
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a8889081ae824..b407676808fca 100644
=2D-- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -701,6 +701,9 @@ static const struct pci_device_id pci_ids_renesas[] =
=3D {
=20
 /* handled by xhci-pci-prom21 if enabled */
 static const struct pci_device_id pci_ids_prom21[] =3D {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
 	{ /* end: all zeroes */ }
diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
index 11f435f94322a..533efc7db8012 100644
=2D-- a/drivers/usb/host/xhci-pci.h
+++ b/drivers/usb/host/xhci-pci.h
@@ -4,6 +4,9 @@
 #ifndef XHCI_PCI_H
 #define XHCI_PCI_H
=20
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7	0x43f7
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9	0x43f9
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA	0x43fa
 #define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC	0x43fc
 #define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD	0x43fd
=20

base-commit: 639df5d23876a548b86fe6526bed8b97edf64d96
=2D-=20
2.43.0

