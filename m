Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048788;
	b=aMI3c5agIAQKnV/+AUzcbbkyNMOEyXfCq2Fy5dgZw3eg14gdlo6GRCc63Pm1xKwU+zV3
	 jj6gj9Dtv0Mfb4bRAoBfd4CDV6xJLKJkM90VA5tZJC2wodzQWLlg6gBidZsBZvqotWjJW
	 BIoDlVjnEawrWoxRJlLxd5qNVUG97Nt+52Sjk6LaaQdxiB2ZgNm6lbv8xcX92Y7Rt+y9f
	 HioNVT18z6j65fPWA+ih4gKniqC2QXEIzLNseZCnCvgbQArqqMk92qIOQMn/cLiHZHF2L
	 r3OaNH7vXxuA8P+Z7v8Dpg2fYrjLMf0z8wy/zOD+uiCATvFwXavFoVXzfoGVHDD+bQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048788;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+8ybNJcOlfF9OJibHx0d6l7c5nx8gJ77zNYdVAXXwHo=;
	b=fx5W6Gb3IMu+mNH3xdebzYxirs60wZ0mt35uIJPNnMvUFR+u9RAPnppZZ4XHN/gTrjiN
	 YeG05Ba7Yopj9K4tcN7ShA0szoCAAdF7k5yDHUsouhDFLcC4EPhqupciwkmX0ox+lMK9i
	 eb6fM8RKDt1v+eCcikwIlvJhFD46pnv/e5oSSBLFi+vIGS3DecKtXdEiNTbWAQQHOp6Bp
	 gNHCNSrs3y9nNfut4n8vum3blH5xAp4BDEkhdlsZRhaEP4HHWB/Tv+jeRAUPisF2L4Hss
	 4Qm2TY5dbGgjUSwxCOLM2IROs6soqFDmEESf9fEggJeVsuVUfAinY/sPOCURNcrjOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O793U18d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C9606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O793U18d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D2D1F008A2;
	Sat,  7 Nov 2026 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048788;
	bh=+8ybNJcOlfF9OJibHx0d6l7c5nx8gJ77zNYdVAXXwHo=;
	h=From:To:Cc:Subject:Date;
	b=O793U18d8Ul6Bcvg5z67n3QOif4d6biJUCKmSMkEZHoMgNesyIhKQuXvuEoO1gzWt
	 x2zjZ90/hiF4syHVFfPIBK8C5vUFpz4yhRADcxQMAotAv4NXZE5ZOkKNdgNIT3UgVI
	 wT8Iqb/TysATZaEONLd7RBiheipdyDPUKW5Q5FvVq09F5N7STwcH5i7kwPNvFM95w0
	 lqd8becP3h+mbQPAysOVJrQHXF5Dcy1LbVMYvWy5gOkjj9BscykLx3dSpSsLqujrt0
	 bCzXTPFE4m8aKoWhN1qitURc3Kef1NGdzbTlf8U35kChkndeTEVmUeUc7uC4lt1dT4
	 xaf5uFt6RdgHw==
From: Sasha Levin <sashal@kernel.org>
To: bartualev@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] platform/x86: asus-wmi: fix TUF keyboard power state shutdown naming" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:06 -0500
Message-ID: <20261107055306-failed-6.1-3d9a175707ee@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3d9a175707eeb15a2d577af1e669b98e0236719b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055306-failed-6.1-3d9a175707ee@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3d9a175707eeb15a2d577af1e669b98e0236719b Mon Sep 17 00:00:00 2001
From: Bartu Alev <bartualev@gmail.com>
Date: Sat, 10 Oct 2026 13:15:58 +0300
Subject: [PATCH] platform/x86: asus-wmi: fix TUF keyboard power state shutdown
 naming
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fourth state flag of kbd_rgb_state_index is named "keyboard" and has
long been treated as having no effect.  In hardware the flag, BIT(7) of
the payload sent to the TUF RGB state device, gates whether the keyboard
backlight stays lit while the machine powers off: with the bit set the
keyboard lights up white during the ACPI S5 sequence, with the bit clear
the machine powers off dark.  Verified by A/B testing both values on a
TUF Gaming A15 (FA507NV).

Rename the fourth field and its index entry from "keyboard" to
"shutdown".  The write format is unchanged, the value is still
positional, and the diff is two variable names and one string, so it
backports cleanly.

Fixes: 61f64515299e ("platform/x86: asus-wmi: Implement TUF laptop keyboard power states")
Cc: stable@vger.kernel.org
Signed-off-by: Bartu Alev <bartualev@gmail.com>
Link: https://patch.msgid.link/20261010101601.888709-3-bartualev@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-wmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d1341adc1b3b3..3348ce162ad3f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1130,10 +1130,10 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
-	u32 flags, cmd, boot, awake, sleep, keyboard;
+	u32 flags, cmd, boot, awake, sleep, shutdown;
 	int err;
 
-	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &keyboard) != 5)
+	if (sscanf(buf, "%d %d %d %d %d", &cmd, &boot, &awake, &sleep, &shutdown) != 5)
 		return -EINVAL;
 
 	if (cmd)
@@ -1146,7 +1146,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 		flags |= BIT(3);
 	if (sleep)
 		flags |= BIT(5);
-	if (keyboard)
+	if (shutdown)
 		flags |= BIT(7);
 
 	/* 0xbd is the required default arg0 for the method. Nothing happens otherwise */
@@ -1160,7 +1160,7 @@ static ssize_t kbd_rgb_state_store(struct device *dev,
 static DEVICE_ATTR_WO(kbd_rgb_state);
 
 static DEVICE_STRING_ATTR_RO(kbd_rgb_state_index, 0444,
-			     "cmd boot awake sleep keyboard");
+			     "cmd boot awake sleep shutdown");
 
 static struct attribute *kbd_rgb_state_attrs[] = {
 	&dev_attr_kbd_rgb_state.attr,
-- 
2.53.0




