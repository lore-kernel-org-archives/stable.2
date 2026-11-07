Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049203;
	b=ax5xJm98lsYg4FUr+8nivQi4+XzrFBy7534Uttugus//GLhWYlBbjZkHGMa7XiAUy+Fi
	 jma9mFuuAx1uuhWm6+x1+GH7XnVPEh4mgH6+zy+D5MokRvKRjnvofG4BUvsoUu5dIb/ZZ
	 5ni9mAt5lH5BKHdsrqlnGcSlY54YcOOgKiLdpIHtg+We/WAB9twT2uDezfdgDrvRVUN7W
	 cPkt/edP2R/S7ZslZmFLxR7mJa/7Xonijox8Xz5LIJc5b8mkORztc2ywpN3FE9bmSfQEw
	 nRbf555QzMzK88239053LboScuODGTjzWWIqpE6opobyOBqnaPaNYDZ/5lI0rlVSkvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RUTxvCvnx4IOTXkd0kZysUiUgbxg/XycROl4VQBTCLk=;
	b=jj6bububkhDa13qOoJICld4I7Bv0DMb1ctIoqgXepSia1L/3MC7stFWaudESrMQGi6Er
	 6MkLezvk195qcHLSFd3TJxubcUyDJD+YsKl05z/ns/3oBYFvAEDreIpvrxnphtDBLoGVI
	 /8JOjUEoK2QBCXUHga65EoaXkKeV7M2zkxH+V9edYb9RgpeEWU3mQMgr4YLSot4BKZP0t
	 Km5Gw2qylOekWqkc7018H81Im7xKvw3/DwewuMb+WXpvt7CXMU1TOEoFgl7nsJ4eyD7e3
	 UbrbvhJail1JJ1HReKc7qtD2kOLXeBaWRo0zc8sXHPUc3gj4QEzEvVu3TA5F4icGu1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeyRWfaM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B06606D802
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeyRWfaM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039261F008A3;
	Sat,  7 Nov 2026 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049203;
	bh=RUTxvCvnx4IOTXkd0kZysUiUgbxg/XycROl4VQBTCLk=;
	h=From:To:Cc:Subject:Date;
	b=TeyRWfaMk083COhOMxUIF+tAyyo3qvABfPz9A9wUO4Gvh6g6SdBkmF1Fmj1p4VSxB
	 p+PZsXQJNfgYtwKYL3Pd3iy36HpsQzoNuPn39rrmcHk7YPBdODrCJStwPNAOR9wzpP
	 X+yNYYCmKjFLl31XKFhlnNn5UoW0oDrW/qGsEWjivDd+Wn7g1f0I5Kcf45LN42RDxQ
	 G5D/U7yz+6MhlQNEIqc8AYzY5sL7Sx1FyFzesjvWKnZnc1YFIOFuhdiz437odud197
	 EZe/Urlq1d03/2lhfksxCjAdD/YaieL97kZxKTa9yZEfSv0FjxGXSHSNjJhIcT3ClO
	 kTIlsKpFAVAlg==
From: Sasha Levin <sashal@kernel.org>
To: wanglin@open-hieco.net,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (k10temp) Stop matching Hygon devices" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:01 -0500
Message-ID: <20261107060001-failed-5.15-08e6615c909b@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 08e6615c909b2504a5862764f3a7fca00c7ab066
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060001-failed-5.15-08e6615c909b@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




