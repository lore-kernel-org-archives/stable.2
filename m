Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794386184;
	b=azdO5s37oL91pnNZxWHy6mDaSIjH8c5Xgn7LMTdXuyh71Re3hYKo51wFCl2d96tP4sRC
	 Hg0yKIPZaOMPL//CnsUnQsvVVidfZ5XsJJMHcBMo8Bh4EqQQ2Rg0eF9DP52ihQLvPkaCH
	 Nfyt4XZVey7kEkSOMuPdPahwXTa4sJ/l2Fzs38KerMKacYX5DavPbXiQKkIpbThueh3wJ
	 XOKr+4jln0pywLy+A0RAnQ6UR3pFgSeu6yIfu2UQPHcQBxquDkG3KYac/W9NfIb0yuABf
	 5+TkyxlmISt2NSX9YN7Ia2i3SEPquri5XGPHaI/Y7vrTHCUbSc6EKXe06/qLs5+jKAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386184;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=IOUHInSxLvhC2GKoYi9TwSdoZtl4LNESYhfcgh1Lc4w=;
	b=Itv0xlSCIqZWMNdp10vMb0C6c+xfYP1BH28OYBSr8b/hdysQ0BAdt/xqFPwlUX6F3x/F
	 Wg32PKulm3D1vq4FvohWvetSS2BzacTq2JGZEa+kfg/wzwrsnVZiIfF34GJsupF2BNC6T
	 07EUi5BRB3lFQtYnM8tq0qksHimHnD9Tu4LMBxIUOtnEAQN8WQ/Eib0Lun8PiRDo3w30L
	 +Yi8zC6xLFw4CyyKJX/ER0gUgaP0c9HcsL5LTAWNxo5GsZ/6ze7+91B9mE6v9T8ZEld1Q
	 T6+zLkRsCh/JzlUf7X7cyaP6pT0jPViHeH0Ipz7NWOT7JbjbIYL2yJVd2n9y4a3NQNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHSp+jlt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BC606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHSp+jlt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794386183;
	b=FPG9UEYx5TarRgE47kUahfjJUcP2Ok70hUtpKmTT9p401NqEeClrd9CHiuLgc8ZsJ41R
	 n/oXiCvQpmA50LPyPDcntzIfG+6cSV2VlVjXqTfLamOv2M1j4u3fgthjj0fjf1aZFhC1c
	 NM5UBpNB19J1BgAPYZegvjpR7YlVGRnKnH7J5xy1AsJRvcA1ENw6PWO5VwafTWfe2qahr
	 nniKTqMHP5XJVZ1eGdfufUbIIVym7ZdSvrCrE23QbR/Z/x+pC8tMWLH3z4VtNB1QIw3Es
	 h8F4zY1/0big2IU9pONjW+EIBtZndBYJOf5//C00cXvnLfDeAnxHCgLS3h1u5G9Z/tg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794386183;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=IOUHInSxLvhC2GKoYi9TwSdoZtl4LNESYhfcgh1Lc4w=;
	b=wOwuqquI0SguXplv8G6ZfU0Skae7Y0HIoWY7z38wlvXsZkr5mUTTfN444ChD/4/SF0/P
	 xHV/fyKKDIJkN/LR4smRojbP+tcSTLzYhHfSf0mhdGOAKX4ncQLwMlDjCzQlcP4Hd8gvt
	 fbTp0iOkUkFRnC5JnkNtVKgpCa0wm2Z7aKsBn3N1Xni6jYs72F5TtnFXR90K/6JcT2TvS
	 17DaaP4UbwQMx6Fwkw90gCvKE2JMu8qKg123/wokF2BYHTY1nrLolpseKsGNkrUWoWysA
	 eKmG1UunfGv3T9S+5HGZRwwtMBSA4t2FgedEQgDl67q62BhiFwOJ6iHMawGfSLVf08A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9AB941F00A07;
	Wed, 11 Nov 2026 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794386183;
	bh=IOUHInSxLvhC2GKoYi9TwSdoZtl4LNESYhfcgh1Lc4w=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lHSp+jltKLUyG05payQ1KqYLAZiUIJjWRHWi5COChKQ5K7Bkybznyitb28CX2R6oo
	 t1OMnTrAuKmWhE02C5xrRKcfZHcR7feVsLO/yNnh+Zwdni8pJ5fOUSD+YVIhW7rqNh
	 G+IcMU3acAPzxmrppoTvmSLcYqVA+tQ9P2EQJbVKZiyce2VG05jON3YGkOdsbytVSR
	 Ah82thnq56/rgAH07BwVvKGeYXtOCJzqmqryscbxpcbjzdDSlklZC6C4xa+A192nUn
	 1cL4+crfiMsD+NHKhbwTvLNltq162jhKYziu5s6sgRz9QEMR2FRxYOXxANwvu/iMds
	 qoSx8snCGLGyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E39EE48EB2;
	Wed, 11 Nov 2026 08:36:21 +0000 (UTC)
From: Sercan GOKMEN via B4 Relay <devnull+gokmensercan.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 11:36:16 +0300
Subject: [PATCH 7.3.y] ASoC: cs35l56: Wait for firmware timer expiry before
 system suspend
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-cs35l56-fw-timer-7-3-y-v1-1-43fc95730c11@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw6CQAxFf4V0bYkzDZD4K8YF1hZqFM0UH4Tw7
 wx6d+cm58zgkkwcDsUMSd7m9hgyhF0B3LdDJ2iXzBD3sQ55yE7VrapRPzjaXRI2SDghiQYmVtb
 YQpafSdS+v/ARmpLKCU7/21/nq/C4RWFZVs9S4DGBAAAA
X-Change-ID: 20261111-cs35l56-fw-timer-7-3-y-3ef1c3cfcf2a
To: stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, 
 patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794386176; l=9575;
 i=gokmensercan@gmail.com; s=20261022; h=from:subject:message-id;
 bh=rnyqu+zmhrHDhKxyszYRh7pDkoBuPfjqjnpyOWKDTT4=;
 b=XZCoUlHohbouAQaDHgw6W0MhFYKoeC9bWtcDd5LOOhMdgLTqelO1AOKZV/HOTTUXQgKnAQrpC
 9dkYu3owYyDBJV2yrIEboHWvzQ5D8JZ/0M0Wx5srBZQSc80a1k26LQs
X-Developer-Key: i=gokmensercan@gmail.com; a=ed25519;
 pk=nFIlLCcGouUfBov8xxW0K4qUtEjdhJniMOO8WCSqghU=
X-Endpoint-Received: by B4 Relay for gokmensercan@gmail.com/20261022 with
 auth_id=1282
X-Original-From: Sercan GOKMEN <gokmensercan@gmail.com>
Reply-To: gokmensercan@gmail.com

From: Richard Fitzgerald <rf@opensource.cirrus.com>

commit 6cc7db9fdd06c992ee38793b2d556524fc0cf574 upstream.

On CS35L5x firmware older than 3.13.7 (B0 silicon) and 4.7.16 (B2 silicon)
a SoundWire bus reset is not allowed within 250ms of the last firmware
timer start.

This is already avoided during runtime suspend by the various idle
timeouts. System suspend can happen at any time so needs special
protection. The driver cannot cancel the firmware timer, so it must wait
long enough for the timer to expire.

The delay is placed in the suspend stage because typically this has less
impact on end users than delays in resuming. The amp is in PS3 power
state when suspending and no new timers will be started in this state.
An extra 10ms is added to the delay to avoid a race on the exact instant
the firmware timer expires.

There is no need to have the delay for every driver instance. The timers
on each amp will expire in parallel, so the delay is only needed once.
A global flag is used so that the first instance to reach its suspend()
callback will delay and then clear the flag. The cs35l56_fw_idle_wait_lock
mutex is to ensure this is still safe if async_suspend was ever enabled
for SoundWire devices.

Fixes: e496112529006 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
Reported-by: Ferenc Lengyel <leferi99@gmail.com>
Closes: https://github.com/thesofproject/linux/issues/5898
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20261020135706.3573260-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sercan GOKMEN <gokmensercan@gmail.com>
---
Please consider this for 7.3.y. The upstream commit, 6cc7db9fdd06, is in
mainline for 7.4 and carries a Fixes: tag for the original CS35L56
driver, but it has no Cc: stable and is not in 7.3.4.

On CS35L56 B0 amps running firmware older than 3.13.7, a SoundWire bus
reset within 250 ms of a firmware timer start is not allowed. System
suspend can trigger one at any time. The ASUS ExpertBook Ultra B9406CAA
has two CS35L56 B0 amps on SoundWire link 2, loading firmware 3.13.4
from linux-firmware. Owners of that laptop have reported speakers
losing their bass after s2idle resume, with repeated parity errors and
bus clashes on link 2:
https://github.com/burakgon/asus-expertbook-linux/issues/17

The commit cherry-picks cleanly onto v7.3.4, with no follow-up fixes in
mainline. With it applied, cs35l56.o, cs35l56-sdw.o and
cs35l56-shared.o build without warnings at W=1 (clang, ThinLTO, CachyOS
7.3 config). I have not checked older stable trees.
---
 include/sound/cs35l56.h           |  4 ++++
 sound/soc/codecs/cs35l56-sdw.c    | 27 ++++++++++++++++++++++++++-
 sound/soc/codecs/cs35l56-shared.c | 38 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 17 +++++++++++++++++
 sound/soc/codecs/cs35l56.h        |  1 +
 5 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 747e10ec1a..ce6383c2c6 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -209,6 +209,9 @@ struct snd_ctl_elem_value;
 
 #define CS35L56_GPIO_FN_GPIO				0x00000001
 
+/* DSP1_FW_VER */
+#define CS35L56_FW_MAIN_VERSION_MASK			GENMASK(19, 0)
+
 /* Mixer input sources */
 #define CS35L56_INPUT_SRC_NONE				0x00
 #define CS35L56_INPUT_SRC_ASP1RX1			0x08
@@ -446,6 +449,7 @@ int cs35l56_cal_set_status_get(struct cs35l56_base *cs35l56_base,
 int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
 			     bool *fw_missing, unsigned int *fw_version);
 void cs35l56_warn_if_firmware_missing(struct cs35l56_base *cs35l56_base);
+bool cs35l56_needs_wait_for_firmware_timer_expiry(struct cs35l56_base *cs35l56_base);
 void cs35l56_log_tuning(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
 int cs35l56_hw_init(struct cs35l56_base *cs35l56_base);
 int cs35l56_get_speaker_id(struct cs35l56_base *cs35l56_base);
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index e10f04d677..a49ad69644 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/soundwire/sdw.h>
@@ -36,6 +37,9 @@
 #define CS35L56_LATE_READ_POLL_US	10
 #define CS35L56_LATE_READ_TIMEOUT_US	1000
 
+static DEFINE_MUTEX(cs35l56_fw_idle_wait_lock);
+static bool cs35l56_fw_idle_wait_pending;
+
 static int cs35l56_sdw_poll_mem_status(struct sdw_slave *peripheral,
 				       unsigned int mask,
 				       unsigned int match)
@@ -387,14 +391,34 @@ static int __maybe_unused cs35l56_sdw_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int cs35l56_sdw_system_suspend_prepare(struct device *dev)
+{
+	cs35l56_fw_idle_wait_pending = true;
+
+	return 0;
+}
+
 static int __maybe_unused cs35l56_sdw_system_suspend(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+	int ret;
 
 	if (cs35l56->sdw_attached)
 		cs35l56_mask_soundwire_interrupts(cs35l56);
 
-	return cs35l56_system_suspend(dev);
+	ret = cs35l56_system_suspend(dev);
+	if (ret < 0)
+		return ret;
+
+	scoped_guard(mutex, &cs35l56_fw_idle_wait_lock) {
+		if (cs35l56_fw_idle_wait_pending && cs35l56->needs_wait_for_fw_idle) {
+			dev_dbg(cs35l56->base.dev, "Wait for FW timer expiry\n");
+			msleep(CS35L56_FW_REQ_ACTIVE_TIMEOUT_MS + 10);
+			cs35l56_fw_idle_wait_pending = false;
+		}
+	}
+
+	return 0;
 }
 
 static int cs35l56_sdw_probe(struct sdw_slave *peripheral, const struct sdw_device_id *id)
@@ -460,6 +484,7 @@ static void cs35l56_sdw_remove(struct sdw_slave *peripheral)
 }
 
 static const struct dev_pm_ops cs35l56_sdw_pm = {
+	.prepare = cs35l56_sdw_system_suspend_prepare,
 	SET_RUNTIME_PM_OPS(cs35l56_sdw_runtime_suspend, cs35l56_sdw_runtime_resume, NULL)
 	SYSTEM_SLEEP_PM_OPS(cs35l56_sdw_system_suspend, cs35l56_system_resume)
 	LATE_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_late, cs35l56_system_resume_early)
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 7b3e37d462..b37f65cd4d 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -1379,6 +1379,44 @@ void cs35l56_warn_if_firmware_missing(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_warn_if_firmware_missing, "SND_SOC_CS35L56_SHARED");
 
+bool cs35l56_needs_wait_for_firmware_timer_expiry(struct cs35l56_base *cs35l56_base)
+{
+	unsigned int fw_ver;
+	bool prot_sts;
+	int ret;
+
+	switch (cs35l56_base->type) {
+	case 0x54:
+	case 0x56:
+	case 0x57:
+		switch (cs35l56_base->rev) {
+		case 0xb0:
+			ret = cs35l56_read_prot_status(cs35l56_base, &prot_sts, &fw_ver);
+			if (ret)
+				return true;
+
+			if ((fw_ver & CS35L56_FW_MAIN_VERSION_MASK) < 0x30d07)
+				return true;
+
+			return false;
+		case 0xb2:
+			ret = cs35l56_read_prot_status(cs35l56_base, &prot_sts, &fw_ver);
+			if (ret)
+				return true;
+
+			if ((fw_ver & CS35L56_FW_MAIN_VERSION_MASK) < 0x40710)
+				return true;
+
+			return false;
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_needs_wait_for_firmware_timer_expiry, "SND_SOC_CS35L56_SHARED");
+
 void cs35l56_log_tuning(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp)
 {
 	__be32 pid, sid, tid;
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 279db3f13f..573cc71a19 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1693,6 +1693,10 @@ int cs35l56_system_resume(struct device *dev)
 
 	dev_dbg(dev, "system_resume\n");
 
+	/* Assume the firmware reset to default until we can check it */
+	if (cs35l56->base.init_done)
+		cs35l56->needs_wait_for_fw_idle = true;
+
 	/*
 	 * We might have done a hard reset or the CS35L56 was power-cycled
 	 * so wait for control port to be ready.
@@ -1707,6 +1711,16 @@ int cs35l56_system_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (cs35l56->sdw_peripheral && cs35l56->base.init_done) {
+		ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+		if (ret < 0)
+			return ret;
+
+		cs35l56->needs_wait_for_fw_idle =
+			cs35l56_needs_wait_for_firmware_timer_expiry(&cs35l56->base);
+		pm_runtime_put_autosuspend(cs35l56->base.dev);
+	}
+
 	/* Firmware won't have been loaded if the component hasn't probed */
 	if (!cs35l56->component)
 		return 0;
@@ -2231,6 +2245,9 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret)
 		return dev_err_probe(cs35l56->base.dev, ret, "Failed to write ASP1_CONTROL3\n");
 
+	cs35l56->needs_wait_for_fw_idle =
+		cs35l56_needs_wait_for_firmware_timer_expiry(&cs35l56->base);
+
 	cs35l56->base.init_done = true;
 	complete_all(&cs35l56->init_completion);
 
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index f7cf8aa653..b46f410f0e 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -43,6 +43,7 @@ struct cs35l56_private {
 	bool soft_resetting;
 	bool sdw_attached;
 	bool component_registered;
+	bool needs_wait_for_fw_idle;
 	struct completion init_completion;
 
 	int speaker_id;

---
base-commit: 7595a62d45ee1a2297eafa5f2ef5d0a45142d84d
change-id: 20261111-cs35l56-fw-timer-7-3-y-3ef1c3cfcf2a

Best regards,
--  
Sercan GOKMEN <gokmensercan@gmail.com>


