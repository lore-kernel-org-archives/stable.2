Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048395;
	b=L2i71t+I+ysjuX6ewDlInusmxYna2dwIg+dXRT8GkKb7Ln5Whn5+uahC2oFftLNc4ZQ6
	 JqEpLYCTBltodzQWIjVpjhA1eDeU4ujxPnr7Ik5d/+YAq/L/yTs8LUaQKgZ1+CoI/UwTV
	 87qgvUOSWJjYnw2o+T7Ri6gei7mWlAgNznnJ733fWoyJLLAfTLVFQbbtQFrloQm31Zlsy
	 0mFW1mqXefMMA1cUQEWiCqQYkHMBu/ezDV8Ph3uYcqDtyQ6n2XCylMA5XPCLutHUDd9R6
	 i2Gqp/aoR7bA6EICncHBlBlRQ9EwjgC6mzRgRlMcqmtoBlQCeRYg8eLd47qhlFv9ihg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=urwEglP0JRMcWU48t7JiN2H5XI8AitK9ew25HOzxqSM=;
	b=nsHSgfxW2B0CPMEpfZ0kUjsYi6X0Ce4pfAVOAyhvsxtd2uWAqpqLAyIyxwd+XB2zB9dV
	 BK90phnM0h+8x8Sd9ihBQYamu2t23wYOve6lKCifsoTuja2vnvo6QaPHUpanwU2LH+DjP
	 Km32dko+8J3AKFVOBp4m3jMDGUZOEheykI0NrAArnFqM570+9xOzL3e2WACXmoOcaonSB
	 08raSf3rxmkGc3EKPSgqkBN5MR1gkXkNWA159jCnU3kWVPxNZ7lyQ9a+KoiIFi9PyhL+D
	 7j52R2Q0afgI2Kl+i8hATSPBsSvqliJkHpMgxwwqJTbD8aqY60MMj9PatKd8MLsYuzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5DV8uIS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5DV8uIS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C56F1F0089F;
	Sat,  7 Nov 2026 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048395;
	bh=urwEglP0JRMcWU48t7JiN2H5XI8AitK9ew25HOzxqSM=;
	h=From:To:Cc:Subject:Date;
	b=f5DV8uISBruwrHLOSKOmY6/DfNW2i+QLeAbb8wriFd99V8FKvQPQTHEzJZyxFD+Lo
	 Nbxw8ip5MPOjQnDm317CjENx3iv7Qhf2fdYk2EWoZUPTYauZqIyX0CHQSsjRt5f02z
	 yMYwX6pdZ6RfCT/n5+TRWEDh97u5crbWEICgEE9VNti2SnxVtkcGtE6ET1yQaK99rh
	 J+OhqDxsHi2hN42yTxWWcGUjDDKfiLjZLp/Pi+FmFieIe5hgCIR34woPJrFVvLFV9a
	 o0zzxgdsydYH7p++mIb5Vgv/LvtjvUF1yiwodIku0QYbt5T+IP7dENLeUWFGwV0cnA
	 S6rD6KatAAeXw==
From: Sasha Levin <sashal@kernel.org>
To: linux@stevetech.au,
	shyam-sundar.s-k@amd.com,
	hurryman2212@gmail.com,
	mirko.jechow@gmx.de,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] usb: xhci-pci: Add AMD 600 series to xhci-pci-prom21" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:33 -0500
Message-ID: <20261107054633-failed-6.1-29381088ac50@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 29381088ac50a4910d18a5f8079d9bd505f839be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054633-failed-6.1-29381088ac50@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 29381088ac50a4910d18a5f8079d9bd505f839be Mon Sep 17 00:00:00 2001
From: Stephen Horvath <linux@stevetech.au>
Date: Sun, 4 Oct 2026 02:27:31 +0200
Subject: [PATCH] usb: xhci-pci: Add AMD 600 series to xhci-pci-prom21

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
Link: https://patch.msgid.link/20261004002731.49927-1-mirko.jechow@gmx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/hwmon/prom21-xhci.rst | 2 +-
 drivers/usb/host/xhci-pci-prom21.c  | 3 +++
 drivers/usb/host/xhci-pci.c         | 3 +++
 drivers/usb/host/xhci-pci.h         | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/prom21-xhci.rst b/Documentation/hwmon/prom21-xhci.rst
index 7984fb187bd8a..6c0b6e7368921 100644
--- a/Documentation/hwmon/prom21-xhci.rst
+++ b/Documentation/hwmon/prom21-xhci.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Prefix: 'prom21_xhci'
 
-    PCI IDs: 1022:43fc, 1022:43fd
+    PCI IDs: 1022:43f7, 1022:43f9, 1022:43fa, 1022:43fc, 1022:43fd
 
 Author:
 
diff --git a/drivers/usb/host/xhci-pci-prom21.c b/drivers/usb/host/xhci-pci-prom21.c
index 6486f4a093455..5f088a47d79f3 100644
--- a/drivers/usb/host/xhci-pci-prom21.c
+++ b/drivers/usb/host/xhci-pci-prom21.c
@@ -111,6 +111,9 @@ static void prom21_xhci_remove(struct pci_dev *dev)
 }
 
 static const struct pci_device_id pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
 	{ /* end: all zeroes */ }
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a8889081ae824..b407676808fca 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -701,6 +701,9 @@ static const struct pci_device_id pci_ids_renesas[] = {
 
 /* handled by xhci-pci-prom21 if enabled */
 static const struct pci_device_id pci_ids_prom21[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
 	{ /* end: all zeroes */ }
diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
index 11f435f94322a..533efc7db8012 100644
--- a/drivers/usb/host/xhci-pci.h
+++ b/drivers/usb/host/xhci-pci.h
@@ -4,6 +4,9 @@
 #ifndef XHCI_PCI_H
 #define XHCI_PCI_H
 
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43F7	0x43f7
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43F9	0x43f9
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FA	0x43fa
 #define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC	0x43fc
 #define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD	0x43fd
 
-- 
2.53.0




