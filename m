Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA4418361;
	Wed, 16 Sep 2026 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542912; cv=none; b=PCXiu1yUDphlPXpMzr3rJff89eV1le7NmhVr/lbsILP4X/RtKtyjd1bH1jwLW0xxOYGlntrxJV4Zd6yL6q/XciyV41noPDsd0UrRIcNFRh5st5n7V8r2ke5r7o0zdkyjl9NHdsan0mWN5DDbJvoaX56gn+ngM94HcmiiAJ27pJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542912; c=relaxed/simple;
	bh=qhuzwXAH6Q8cakD7aUs3SGJaPAkXJYDMYEW2hqEGcBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZXSYDQ+tZM1HjvLjvo251mjwM6n1eaqBzZi/dhG3KoUEdnFbYWzL2ZLNJDjcYLYKAM8b3iSjogrJ63k70xmDiDmhvymAEbGfgCLGrBDZTNxjUiTtOZQZu0aVOgSKrY0NicYSGPMHHLdKN656lTt2bn/326v3xG++TS38k6Ma1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnrTvvQapqkP7eBw--.40755S2;
	Wed, 16 Sep 2026 15:14:55 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: cezary.rojewski@intel.com,
	kai.vehmanen@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	sbinding@opensource.cirrus.com,
	tiwai@suse.com,
	vitalyr@opensource.cirrus.com,
	yung-chuan.liao@linux.intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 07/20] ASoC: Intel: sof_cirrus_common: Fix device reference leak in cs35l41_compute_codec_conf()
Date: Wed, 16 Sep 2026 07:14:27 +0000
Message-Id: <20260916071427.1966427-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrTvvQapqkP7eBw--.40755S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF18Gr1fCF4rAw1rWw47CFg_yoW8Gr45pF
	40gFZxKr90grWrury8uryS9F1Y934aya1rGas8Gw15Krn3WryruFW2q340vr4YkrWkGr1q
	yr9IyFykG3Z0v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUCNtxUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgMA2qqQJUGAAAAsT

In cs35l41_compute_codec_conf(), get_device() is called on the physical
node returned by acpi_get_first_physical_node() to populate the device
name strings. However, this extra reference is never dropped, leaking
a reference count for each matched ACPI device.

acpi_get_first_physical_node() returns a borrowed reference that is
valid while the device exists. Remove the unnecessary get_device() call.

Fixes: 1ca726424a12 ("ASoC: Intel: cirrus-common: Use UID to map correct amp to prefix")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/intel/boards/sof_cirrus_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
index 88fc6cb2bfd4..2d23e16bd206 100644
--- a/sound/soc/intel/boards/sof_cirrus_common.c
+++ b/sound/soc/intel/boards/sof_cirrus_common.c
@@ -168,7 +168,7 @@ static int cs35l41_compute_codec_conf(void)
 				 cs35l41_name_prefixes[uid]);
 			continue;
 		}
-		physdev = get_device(acpi_get_first_physical_node(adev));
+		physdev = acpi_get_first_physical_node(adev);
 		acpi_dev_put(adev);
 		if (!physdev) {
 			pr_devel("Cannot find physical node for HID %s UID %u (%s)\n", CS35L41_HID,
-- 
2.34.1

