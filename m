Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799574;
	b=qRy+oSm1i7woEkLAH2ji/4risSiYpmtbNh89rL+rRZGmzljcgExXXPcLikiMNLPWYnYv
	 EwlK+Q6eoNlj92TrxWbBxycvxt6hEmQ4WJXowWAgFMs04VxiuKkkmVVRpTxKs+lza0Mto
	 Vq3LeOfqkUow9MATCuTNEe/+XW4Nb0hTQMQaoIyBIxna14SzWiAlnN8raJNayOU86Vy/t
	 IJPZg9nLp/RXHUYsJKPQn6WMFaHIOkysj8gf0Y9nu62UzM38xjiIXKBhIzMhQ3K04Jc9k
	 IkqoP74ZL9/IsFuti/eo0ovJOLJcRkpH40aMtd5iWL2D6YZqrXVnf+8L3XQwYpOSfHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799574;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9uUMXG1/O/H2muN5NV9vOmGMF8MAQ04Wmdfw8LInq+8=;
	b=PleVlLf+srIcnyM7e2HoCb0C2SeVoGlLUwTZI9mInP/NgsC4yigzn+vkoAn4Kou05Vdy
	 rjmVT/19wQLm7WJ/leY/rM/OuUSHZDI1gclAwj0lHZ1+xX80spIQFEceYfLX2TJvzHrZz
	 q7GwzMkNTk/BMs6RcZ9ddl2GpOQvb4lg8r/XY/hFHZ/eHSgXUVwnP+bMCz7Yf2ttE1wX1
	 MODXzQtcnMlsCOsnBOvnMsZulOoxy4TR1T4GyNu9QGOmQReLtFOrdRzdgSChPufiBnhDS
	 lzH6WDxXHNxQ1K8Ru0aqd6esa9CT9Qm3Rvs73hi97Ej0N5MjCpYrsaJuw5AP3LJhSrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nI1tjR86;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D4606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nI1tjR86
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354AD1F000C1;
	Wed,  4 Nov 2026 13:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799573;
	bh=9uUMXG1/O/H2muN5NV9vOmGMF8MAQ04Wmdfw8LInq+8=;
	h=Subject:To:Cc:From:Date;
	b=nI1tjR86nHFdw9dnoL52+kSXOoCtw+/oxYwkbDPiiUhk530HLBfm8hjCZpY/E+ZGj
	 oWt6aMlcp70WbSLoFHz6Omk1itfsWqhQp1kV5sGV0BNRfa+7O+UC7rjrmuQuOzN1Z3
	 xqqaMkxH0VPr6KucJpUKI1Irjo7KLlyM1KF4HdxI=
Subject: FAILED: patch "[PATCH] media: ipu-bridge: Fix use-after-free in IVSC error path" failed to apply to 6.18-stable tree
To: lhfff@tju.edu.cn,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:39:32 +0100
Message-ID: <2026110432-retry-unrivaled-a1c3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3d42d1c82717f0853379b516a7fab54b636e09cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-retry-unrivaled-a1c3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d42d1c82717f0853379b516a7fab54b636e09cc Mon Sep 17 00:00:00 2001
From: Yibo Tan <lhfff@tju.edu.cn>
Date: Mon, 7 Sep 2026 06:43:50 +0800
Subject: [PATCH] media: ipu-bridge: Fix use-after-free in IVSC error path

ipu_bridge_get_ivsc_acpi_dev() returns an ACPI device with a reference
held. If no matching CSI device is found, ipu_bridge_check_ivsc_dev()
drops that reference before passing the device to dev_err(). Concurrent
CSI device and ACPI namespace removal can drop the other references,
making this the final put. dev_err() then reads the freed struct
acpi_device and its kobject name.

This was reproduced without kprobes by racing normal CSI platform-device
unregistration and ACPI configfs table removal against the production
ipu_bridge_init() entry. KASAN reported the final free through
device_release(), followed by invalid reads through _dev_err().

Emit the error message while the lookup reference is still held, then
drop the reference as before.

Source reproducers and vulnerable/fixed serial logs, with only the build
hostname redacted, are available at:
https://github.com/kimaiden1984-boop/linux-ipu-bridge-acpi-uaf-reproducer

The fixed target builds with W=1 on x86-64. This was not tested on
physical IPU hardware. The tests establish runtime reachability but do
not measure occurrence frequency on shipping systems or establish
exploitability.

Fixes: c66821f381ae ("media: pci: intel: Add IVSC support for IPU bridge driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 0817216f72ea..63470be888ba 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -351,8 +351,8 @@ static int ipu_bridge_check_ivsc_dev(struct ipu_sensor *sensor,
 	if (adev) {
 		csi_dev = ipu_bridge_get_ivsc_csi_dev(adev);
 		if (!csi_dev) {
-			acpi_dev_put(adev);
 			dev_err(ADEV_DEV(adev), "Failed to find MEI or CVS CSI dev\n");
+			acpi_dev_put(adev);
 			return -ENODEV;
 		}
 

