Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821025;
	b=npWtEvtYun2YHSB7+l+vVRj3pxlElJf7WoQcktMJVZ36KeXqKOJiEKLljZXaaqa2PBsy
	 cY1afSTAQBKfW8xJz9XJT0o/ysjbGtwVB3rMCeVFIXKlrEj+DRnvVs0YRoWOifTRlWnae
	 KaUGV8+wrpl4p48WdbN663hhuUF3aokfRU3sFc0TiYOclMPLBqc97c5tfjMxVNbcaxi/n
	 gGTnRM7pKjwuZYnZ+jj+MaTlpSRW0A8oZeeI9Ju8nzvcJ8UeEksrbvKdTq3IPQPPMTv6O
	 +aflRLefGr/+tVX8h+04yoFcE+VaridyT3GRbIhQoTOe614AWna0XKHpn8jGWtDFGfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kvIKGUbGBZe+fbHeLDKxde/EPVg4wF8vUp8aGSxNZkw=;
	b=3p4gA7EgABCT3lhRKGs2GoK9KYnwgPs3bEBfzAO/kzN8fYqCdYXQPgcMobwLjJt4lgIC
	 Ik/IpU4YiJgJvwyP2M4wcQHNAIm6QpMopfgq0sXbJdLYAZh4Qy1whA5xh71Tyl5Xk/tYE
	 aa4XDRab4yMVgUbsIbte1xJ+qadQTXqqmvQgVtrd1p2uHaaYovnPq6IFrFLzngNdOcmEi
	 njB+Q7dpCC7CLQffu/2NY1HMiSEZOhzn11QA0c8kujnsSOFErBDm+x64hADZEqbhQ/hDo
	 5Znv29oGrCPWIEdG3eMPqc3Fpkd+bOSjxzmzvCghZuJYvD3h1MCDTGEc9v6c90pGcyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aohKYpG8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9146070E44
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aohKYpG8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B2F1F00A02;
	Wed,  4 Nov 2026 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821025;
	bh=kvIKGUbGBZe+fbHeLDKxde/EPVg4wF8vUp8aGSxNZkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aohKYpG86cFeUeAD61VvJO31s8VBVl0K/g0H3NL0txRJY6c6/i8d/utV3RgaCn1xd
	 /SZhk/iqrCyhA0ncNB8iF2GUYLT9pv/f5PKb1WWnpN+3voMsvScFbUUIlhql+wpbP4
	 ogxMrBvx+4r5IZuiO6dBT/SIbGaMSRZD4A/y3wrzUBhcgGe3kEURJrD4izxJjJxAgr
	 9EraWbIcQESskv8bpgMdjXmZcNErNcHkrr5pD6AMrGqHSUu+8VUpWeyhyDpx1cboEG
	 Qj32HedQOL/duZehCASVIpYJoHc4jTcTMjgdPIxv7oV4GC5MeLNHCzfz8LZa2MExql
	 RNUT70w1Xvvsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yibo Tan <lhfff@tju.edu.cn>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: ipu-bridge: Fix use-after-free in IVSC error path
Date: Wed,  4 Nov 2026 14:37:03 -0500
Message-ID: <20261104193643.3971310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110432-fantasy-carnival-a002@gregkh>
References: <2026110432-fantasy-carnival-a002@gregkh>
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
[ sashal: adjusted context for the error message that mentions only MEI instead of MEI or CVS ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 4e921c7516293..faa7e538bc2f2 100644
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

