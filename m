Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799583;
	b=jGL2pzAUFZ/3hRga/kiIhSoSTlrkK757q4MEt48vLwKAyEH1P9u0dGhrO980fjGowTMB
	 4YnMbyLgiX+94AFgGZ1FBmSW/Oq3Eq09tsGHIgagUpaiOIL0ycP3oUf7jt7Ez7yY5NFGV
	 1yoS3uy1Id+pL1LuD528PzXDrcNN1ezk6hNwfXyv5htg7QFxMxc1tT2y3UOiC9hcv2i9p
	 Lg8U5ostk45/T8LWT9bUdkqizUTBn6FTEL2G7C3JD5gw1XbKzj0JcTjkyVYP9yze1q4LZ
	 3L6YRajFKg8tC8xYDrqxhP5vtBl1oEFUIgGL+tAUT1WecEwzHnBlCXWQaLsj6mtkzKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799583;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ssTtZPCwSjguHipPNCwujFWTs8TH/UpTbK5uEqNQ02w=;
	b=Np0S6YoPwO+rSv0hnpr5Lo3ThuiokDIl/hcDIWZLjdapiSAub5UUYX5cj3We0+F+yppK
	 fx7U1DQ9pvfW/4h7WVrqtg9zPAFleWFYQ+3RALc/shlwrKf40P04nlDsgX0Y23S+ASAie
	 D99F0zAgf/Ym61N53dVJpk/QfL3atB3hwhIt1LMFkpKkRCgpiLSCAzThqvXyWwphYs1HZ
	 M/RS+IjelMsZlCUbfPOrVL0Lz7SIE1CUbsfr0NioLy9R5oM8b4cWVdgphEelRwpdBfFJ/
	 z/YRbT7InvZ4U490+EjKjhL6XtURbzcHqsEAm4mWhNkBWohG9YZ/lVLCz8nObufTf8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="F8okARK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A0606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=F8okARK/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8881F00A17;
	Wed,  4 Nov 2026 13:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799582;
	bh=ssTtZPCwSjguHipPNCwujFWTs8TH/UpTbK5uEqNQ02w=;
	h=Subject:To:Cc:From:Date;
	b=F8okARK/BzkwD0NzBit4o7wlWU74BOJBlZMJcqU2lx9Dt1RPf7CZCENJm/jbxiCgv
	 QjA7ajp2wGzuHMM4bskZnQ1iftP5F6ni2eAzon1/tdWbkAUhoPPfRytP2ldH52AZsb
	 2JCeB6bZvqeurDQ1mQJ0iwTsm7rZ1Tydy18yHiCQ=
Subject: FAILED: patch "[PATCH] media: ipu-bridge: Fix use-after-free in IVSC error path" failed to apply to 6.12-stable tree
To: lhfff@tju.edu.cn,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:39:32 +0100
Message-ID: <2026110432-fantasy-carnival-a002@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3d42d1c82717f0853379b516a7fab54b636e09cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110432-fantasy-carnival-a002@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

