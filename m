Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799584;
	b=chqkHVSmlCsVHeUlXoKvFykWShmXu1Y4AkKnc2NCFwL8cf+iHT7RmvFXZKcoyFo1dAhI
	 vWk/2NawVV40wqGlFth0enn51lTGzjmSRGiVyfnXvrSVJPBPnTaUkq8TGjA2U7r4Nsg3B
	 7awcjlXL4xTf/3Vdie+Hh9oXb9iAfVXilumN2nioPlEOqdxH4no/3s+K7L+WladNYNxct
	 hv0ScoG7Aq62p29sXan8jBKkBqyTqG6TVVkZxN5ECUcQ8WFVRAnLcbb0b8wjQD1RJOk6U
	 2Y1objdqozZBTk+jM/kOMVCpoXfn7hD4eXCIm+7jMklOSTOC60GexQ+KQAA2CWAiKtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799584;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mCJNY3r8YtKgsmghl478HhCuYEAsnWch75vYiL/3NdQ=;
	b=RKl630c7dxB0tU51LmynhMSKefcJAypftMWItGA6mW97ekt2UhVCwbpZHi04dwLMqZJO
	 IDbYQKOM0pbYC29+lil91UCB7ET2WgH31vUhJeAvgGp899QT5VI/YC1iX8F9ywmuhcrkB
	 a4JiMxp/afNOTXNK5qorXaSNGVenkenqdD99KtckcosZtopTRJDMKLCHPPUlekiCkns/I
	 FkHrue4UqAFUy0dN3cuYrUgHZq6QMkDo5ta5xrVsWRWJ37CSt5AvjdrjHnLpeWd38BBD5
	 c9AU9GFTR+F8RaS27pjBwmqKaxVuzQM5kghmcfU0EG2XgLJXXq/GIvzPa0YgzmtwIDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tpf+psJr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E16606A334
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tpf+psJr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A9B1F00A02;
	Wed,  4 Nov 2026 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799583;
	bh=mCJNY3r8YtKgsmghl478HhCuYEAsnWch75vYiL/3NdQ=;
	h=Subject:To:Cc:From:Date;
	b=tpf+psJrZQP5xetSFVPVOGnh7fvzxhouOW9Cx03Oo0YKdZ1PwkF0WvShzVNijDw7K
	 LjNaCVkHCgHiJGGh3DjPq+jwHSZqe6kAP40zk8A18Ar+ooI2wPoleRinFAoCFQl78h
	 5UNWFk6wu26+XvUrg6IBaXd+sxCJ0tuA1utabFHU=
Subject: FAILED: patch "[PATCH] media: ipu-bridge: Fix use-after-free in IVSC error path" failed to apply to 6.6-stable tree
To: lhfff@tju.edu.cn,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:39:33 +0100
Message-ID: <2026110433-duct-chirping-3042@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3d42d1c82717f0853379b516a7fab54b636e09cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110433-duct-chirping-3042@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

