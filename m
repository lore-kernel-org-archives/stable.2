Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807886;
	b=lN4VhMqJm9pKpe7tjCAMr9kMZSqR5G5wItRqUDb+Tkc8xGyY9sT8BjOvRmXnZwu971i7
	 tOyfw+TRoVO3eU3PXWy+SepAvYcH5aeucOJHFNEPGKsbAav4kAgF1oV62j+ShJPQ8xjXn
	 M+HLpKHZmSJ8wFc9jZxAZdfDfQOzl++E2qvH480DDqG/OHg5BWuqTM/4RlqvGonDjMfpF
	 eFql3oGy/QMNBRYJa8QnvFQenm84XULivBXrF+NHE+Succf1qzPHwukH2I7EWjAve0BKP
	 pVpZdT8iPkWfEM5yhFLfNIWLUf7uFVCIy5ERGf5DwmnBBMpxW2sWomDfEc5ZtosvbjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807886;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=18af4ooA2M/CV3PjsddkbdOkhKI5CROPA8mm1PxMJnY=;
	b=PrtukiAw08+WCITEQwDMeD7Z+OBhIPEDyoAMPB22f3AO13FsVRBSlpEZqMWZAqiqoJZI
	 T3raP1a2fEl2Lawyt2Azg5u6i/Sdt9OArjCMaw92X9+X4DXGkESJW9p9TfUXHUB/Mo4L6
	 N4ycvxjIwhJyDvMmBIMmDcA/6M0/Q0zA6Y2cu093Nf4TsUDpi/PSQaogXfhnbkELmDTNo
	 Ob4b/K6vcKvY3Hxl3ZWJcZjJ03NIv0aVkB7bDOXLSM2EXqP6fyOWmAg9hbc3dMelaKeZg
	 Q5EXVk1fkFiS58Z/6gv9Uia/8WqaeIDDhCSceg+F1KcyZdCSiC8Orz0srUum2GjSxug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuUdCPO1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E860A6F7E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuUdCPO1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C34E1F000C1;
	Wed,  4 Nov 2026 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807885;
	bh=18af4ooA2M/CV3PjsddkbdOkhKI5CROPA8mm1PxMJnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZuUdCPO1bV084/BvJqk5gE2KeQ+U+h2kuRv5qWTjhZm0eTjJUNgmF5zYCp9FNRiZz
	 VV7Q+ZSyahvv7opmNrCOjG+xMLFqMeiJgefffCwXI/XUKKEo5VJ0r2zhTD7/yuAX7v
	 bsTiJ/qwhRZf8NsXn1ehB7/6k3knOTOie8imcwIyfmxo2OrOPkW+lyEDVD4jtcVMac
	 Ld09f6yuG6N0q/znVaHTEXxXt9nq4m+D3vZjJNOVnAWlHI8PW+aDo74gqI19Xg/yde
	 wf3XIT66lF2cAV/HODSL0NtMvXGEfZcbk2UnrcTdmuj7/sDYW1ATCCGi1B9t6mQrey
	 4yGkKA1ZTw4pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yibo Tan <lhfff@tju.edu.cn>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: ipu-bridge: Fix use-after-free in IVSC error path
Date: Wed,  4 Nov 2026 10:58:03 -0500
Message-ID: <20261104155730.3919501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110432-retry-unrivaled-a1c3@gregkh>
References: <2026110432-retry-unrivaled-a1c3@gregkh>
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

From: Yibo Tan <lhfff@tju.edu.cn>

[ Upstream commit 3d42d1c82717f0853379b516a7fab54b636e09cc ]

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
[ sashal: Retained the existing "MEI CSI dev" diagnostic because CVS support is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 4e579352ab2c0..a5e221f42193b 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -191,8 +191,8 @@ static int ipu_bridge_check_ivsc_dev(struct ipu_sensor *sensor,
 	if (adev) {
 		csi_dev = ipu_bridge_get_ivsc_csi_dev(adev);
 		if (!csi_dev) {
-			acpi_dev_put(adev);
 			dev_err(ADEV_DEV(adev), "Failed to find MEI CSI dev\n");
+			acpi_dev_put(adev);
 			return -ENODEV;
 		}
 
-- 
2.53.0

