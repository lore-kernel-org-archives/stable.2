Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050218;
	b=TFm8ukcJvHJfmPNlFFdXNf4R4ZKds1eNLQpGblf4UvovjmfsG6jNPOdwd31UQAa8Q1IO
	 w2ZgAKzhZ1UzJH9Q+7mbbmjZ0DX69X22kVm7BzbtDHTFAPkigh64DpYU9DOLchOddV3v8
	 qKL87ZiqdNirU1erEry5nstnMqzRr6JngKPZvrN+s0HFCU6mXNOAlUjBFUEpI/EgZX08Y
	 Ho3XVJftMNWi0F98+iSkv6/ToomEAP/u/r21y5MS+j/5scX9+KeV6ABm1xYylUKXLr6sF
	 7UThYHU3eaNI2vS/X6T2MxqSM7hNhp9UbQZNetlOXWCPJiq3Rkk8Hyr6l0AOeebMz+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050218;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1kJ14Pv5uDchQD+ZnmeCsd26DgTyHBDcCk6Sl0JUG58=;
	b=iSfuHfajt9OQKjMUDXZOyRiVjw03WY9Szf60DqJIXctG3IDS6s8OW5MVLw2pcYp81Okw
	 Jav2B5aKqRRujzhr0aZUGY3vZDjAWA2IQQ0n+6GxCM7kN4JcvL/Ap3dS8faUgyKFgIKgz
	 oXV1e8aLYD5FDz8SuiSFYEBzgvzYVTM0ZuAterpzS46jpEDSgxT/b3u1dEWfaEMoTPK2d
	 GPJhdod6DrM7/kb0jQn8Q91XAYQyCl9RLzu1IW/+N8+/41nUD2Mny5ZmvWMyPihQoTB8b
	 SpoA7ha2Xon2aSpD4HoxSBX7/gml7fSkNK2iTRSarsVwKYbYB76fwdK4HBfcoWODQ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJVyX3yn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJVyX3yn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9914F1F0089F;
	Sat,  7 Nov 2026 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050218;
	bh=1kJ14Pv5uDchQD+ZnmeCsd26DgTyHBDcCk6Sl0JUG58=;
	h=From:To:Cc:Subject:Date;
	b=dJVyX3ynYgAyh2hXJhrNj0m1SOycFoYsA3ev+fPSYssFRxtk0DGPkdotparv2xk7k
	 FzomLMIZUPV5/kx41Ty2M7zrDBxgXA/kKf1QgDSz6sdb4zN1QYqQamRfK6GhEbguwB
	 IyPiGv0bGuoihzaGnQiMHBEPoGUHemnTJGnzdXYJzwWGSqDk/g1kEu89iIkNQePGPj
	 TQHwz6GZDzIhwKoYkqCUlq5d9gRMVleEtgyH6WMygbfY3X7HZb7cnySYlu2DSVqs+n
	 2rjndLz7SgVDsV0CehJNh3fUBcRePXB8tdBVu8/Pv+zuX74G9wyiIaTG2rM6+rdmsu
	 prBnxf2JxRmgw==
From: Sasha Levin <sashal@kernel.org>
To: wanglin@open-hieco.net,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (k10temp) Stop matching Hygon devices" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:56 -0500
Message-ID: <20261107061656-failed-5.10-08e6615c909b@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 08e6615c909b2504a5862764f3a7fca00c7ab066
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061656-failed-5.10-08e6615c909b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 08e6615c909b2504a5862764f3a7fca00c7ab066 Mon Sep 17 00:00:00 2001
From: Lin Wang <wanglin@open-hieco.net>
Date: Mon, 21 Sep 2026 13:56:00 +0800
Subject: [PATCH] hwmon: (k10temp) Stop matching Hygon devices

k10temp matches the Hygon F3 device, but derives the node passed to
amd_smn_read() from the F3 PCI slot using the AMD fixed-slot mapping
(slot - 0x18). Hygon PCI slots do not encode DF node identity, and
their SMN roots are grouped by socket.

The derived node number therefore cannot identify a valid Hygon SMN
target or provide usable temperature monitoring. Removing the match
does not disable a working monitoring path.

Remove the Hygon PCI match and Family 0x18 branch. Hygon temperature
monitoring will use the Hygon node and SMN interfaces in a separate
series.

Fixes: d93217d84c6c ("hwmon: (k10temp) Add Hygon Dhyana support")
Cc: stable@vger.kernel.org
Signed-off-by: Lin Wang <wanglin@open-hieco.net>
Link: https://patch.msgid.link/20260921055603.25112-6-wanglin@open-hieco.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/k10temp.rst | 8 +++-----
 drivers/hwmon/k10temp.c         | 5 ++---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/k10temp.rst b/Documentation/hwmon/k10temp.rst
index 91b99adc6c487..9680c4f3383c3 100644
--- a/Documentation/hwmon/k10temp.rst
+++ b/Documentation/hwmon/k10temp.rst
@@ -28,8 +28,6 @@ Supported chips:
 
 * AMD Family 17h processors: "Zen", "Zen 2"
 
-* AMD Family 18h processors: "Hygon Dhyana"
-
 * AMD Family 19h processors: "Zen 3"
 
   Prefix: 'k10temp'
@@ -128,7 +126,7 @@ it.
 Models from 17h family report relative temperature, the driver aims to
 compensate and report the real temperature.
 
-On Family 17h and Family 18h CPUs, additional temperature sensors may report
-Core Complex Die (CCD) temperatures. Up to 8 such temperatures are reported
-as temp{3..10}_input, labeled Tccd{1..8}. Actual support depends on the CPU
+On Family 17h CPUs, additional temperature sensors may report Core Complex
+Die (CCD) temperatures. Up to 8 such temperatures are reported as
+temp{3..10}_input, labeled Tccd{1..8}. Actual support depends on the CPU
 variant.
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3e7e63edc6a30..e0a7211a513ca 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
 #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
 #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
 
-/* Common for Zen CPU families (Family 17h and 18h and 19h and 1Ah) */
+/* Common for Zen CPU families (Family 17h, 19h and 1Ah) */
 #define ZEN_REPORTED_TEMP_CTRL_BASE		0x00059800
 
 #define ZEN_CCD_TEMP(offset, x)			(ZEN_REPORTED_TEMP_CTRL_BASE + \
@@ -475,7 +475,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		data->read_tempreg = read_tempreg_pci;
 	}
 
-	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
+	if (boot_cpu_data.x86 == 0x17) {
 		switch (boot_cpu_data.x86_model) {
 		case 0x1:	/* Zen */
 		case 0x8:	/* Zen+ */
@@ -583,7 +583,6 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
-	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
-- 
2.53.0




