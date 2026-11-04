Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821492;
	b=b0VHlm9txjNvW1KIFpehxiXCd08iIW3NSA0juVL3f0Mpvojnu6sc9x0QxBD2mOdrKSYv
	 yaFMd3/e9bm5khTdLF3EGHSTAI39PBo15wiZmAcYH0g83KsA3Yp97FWH/tXm1kFHpXRh+
	 MuklywLVaBigJyNIrPQEiD27uNxXE6T3mla/6MT5trJ+E6Onbkvi9XtJkSG5LhfocK+pT
	 n6gw/3pR+v3clYrhtBI/rRiCo5KL3SBon9sSZs8UKkIj3L63FMq7mAXtJfQajvFtrTHVv
	 DHBMz2XuPaEtrKi1/EesMlddxk0EMMMLDiRnGYUUskJV16i9LKSa2K+XujBUIcznn/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821492;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J8zo8tD80n4T84UKbrM+8e1btaIM6fVUkZcFkWr2vRc=;
	b=waXTcDav5aP050dSRBWeCIy/G7YjcPCciPI4fdTQG4EFNnMkTcePs6TPPxSziK1sZKdO
	 oIQNGaKl1mpJga31pi+iIaR7KbGJVx+eSwyz4X9hT+k7Ms4eiB8YqGwbvygOa4XsB4oWx
	 OxeAswHYdGa+UZENluFRF65HuQGdsslV9vVy+/ZdZgKCEMsuXahR49Izu6w2jdATwi3tt
	 d2bho7eRChixSzalLCK++/uP3mYK4EhgoWnV1VK+fJhZmKZyO5fr/AqlalN7ugB725Zmo
	 gwTRsUNKIO0G5jX4rvV+uWcRD6HK3RqrYBM0YNTzAEei60xc2jCqgqFdF753Hm9mW5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J01cD6k/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB65608AA24
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J01cD6k/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58951F000C1;
	Wed,  4 Nov 2026 19:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821492;
	bh=J8zo8tD80n4T84UKbrM+8e1btaIM6fVUkZcFkWr2vRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J01cD6k/UlSEFKWQC68SIvCZ7Rnb3Zdg0DBbY/T0hhk5NjbgqjerhJWsCQp44kCk4
	 yE2VPbeX6LDh7ea2TrjJMqYKmEk0JW6iVFuOaVXuae1TN8e23gf5Nv3kFGBTeleLuw
	 DeePQg9KtNwYk9dnQQakTqHkM52Y/4Nuctie0DNPlZa7Viz6VLz2wH/QEZbcK6IafN
	 3NkRRx7alLmp7Ya4PiJ6y3Xrg/WlIWMisZg0ynRME7JqGnOpbz3ksfdp3q4apd2SAP
	 AeHLf6iLIYY8xMKhXxDGbMHvHPH1UKh7U35KN/BFKFz6lOvYbCvfbcsWsqgj/7/F/T
	 rka5ZsAOMM8gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yibo Tan <lhfff@tju.edu.cn>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: ipu-bridge: Fix use-after-free in IVSC error path
Date: Wed,  4 Nov 2026 14:44:50 -0500
Message-ID: <20261104194436.335914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110433-duct-chirping-3042@gregkh>
References: <2026110433-duct-chirping-3042@gregkh>
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
[ sashal: adjusted context to match the existing MEI-only error message ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index bd58adb4c2b45..1835f861eb5f3 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -168,8 +168,8 @@ static int ipu_bridge_check_ivsc_dev(struct ipu_sensor *sensor,
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

