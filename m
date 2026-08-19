Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747ED35836E
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125632; cv=none; b=DCwFt6dk+Co+4NwU+Mji5I4Z5VscRWNkv8ONeqcgh9qSn8RlJ/IerxuZzVxw/a5ynwKwAZwlJ0gEF2xclzF5QeyY8jh0DVoZyYbGCR9u6+C5PqIXemNohTk8U+Gqfjx00TvgHXTHHHiJhy7qUCE3W9vxIW0HDUW6bUeivCNzXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125632; c=relaxed/simple;
	bh=wuCQ6OoNgdhjgIfVsXA+lNfF98bS5MHrhq837jM8p6U=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=dOJbOkwG0QwBl/rn7rBoaqLsdoZtSlRwBuALmgZSAh6MBS1B53kWBNAGbPP9UyzJuCXWjdi+VfvWFpC9Na29pkh0CuVmGYVSj/a/Gr65TQYT7Ws/IlpvBJDdLmDSXLPFSCp3RGZBsm2+6DznnAUzt30fEFy6oy28EAtnUbEYedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gy5aEFzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gy5aEFzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7772A1F000E9;
	Wed, 19 Aug 2026 07:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125631;
	bh=dFLiSQwShY620dKnbhHDEb7lA7ac17RG7SHEb4pNBvU=;
	h=Subject:To:From:Date;
	b=Gy5aEFzuDuiSIbVsLS8sxU9ML9lchpSvAclYy/4Tkf2yckLJcS1Q33LiVPksu5/wW
	 28PMzaT7kzrZ+0F0s+pSnTVUHGSumrDHKODAaAP1MwdAax6YVh23qvyqbLfWzerSeT
	 P7QohkWExvZGNQWNq8xoF/LduZC9u5I7coiQgnvE=
Subject: patch "iio: light: gp2ap002: Disable regulators on resume failure" added to char-misc-next
To: acharyalaxman8848@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,linusw@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:35 +0200
Message-ID: <2026081934-sharply-barbecue-0934@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: gp2ap002: Disable regulators on resume failure

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From a41000ba3a230bed1e422f283486ff8f77fe0d30 Mon Sep 17 00:00:00 2001
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Sat, 4 Jul 2026 14:19:12 +0545
Subject: iio: light: gp2ap002: Disable regulators on resume failure

If enabling VIO fails after VDD has been enabled, runtime resume
returns without disabling VDD. Likewise, if device reinitialization
fails, both supplies remain enabled. The runtime PM core keeps the
device suspended when its resume callback fails, so the supplies must
be restored to the suspended state.

Disable the supplies enabled by the callback before returning an error.

Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
Assisted-by: Codex:gpt-5
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/gp2ap002.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index a8db514cca5e..05773e24931b 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -669,7 +669,7 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	ret = regulator_enable(gp2ap002->vio);
 	if (ret) {
 		dev_err(dev, "failed to enable VIO regulator in resume path\n");
-		return ret;
+		goto out_disable_vdd;
 	}
 
 	msleep(20);
@@ -677,13 +677,19 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	ret = gp2ap002_init(gp2ap002);
 	if (ret) {
 		dev_err(dev, "re-initialization failed\n");
-		return ret;
+		goto out_disable_vio;
 	}
 
 	/* Re-activate the IRQ */
 	enable_irq(gp2ap002->irq);
 
 	return 0;
+
+out_disable_vio:
+	regulator_disable(gp2ap002->vio);
+out_disable_vdd:
+	regulator_disable(gp2ap002->vdd);
+	return ret;
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(gp2ap002_dev_pm_ops, gp2ap002_runtime_suspend,
-- 
2.55.0


