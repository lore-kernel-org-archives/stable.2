Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30703DEAC1
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125467; cv=none; b=mIgg8ihRUNm60ajJOU8ZuPuYQIuE8xJCoSqEAIrh0CB7qyWvmiC7eVgUOnVk7NXyuMOLXLK8cWSPx49fLT3+iFlVGBIUwDiUIY3chMY//ZkIl6hDYZN5SDlLvb2cE3W73PuSrP31rbAzzcMWkE7cb30BrHRHPGLj7RUU7qqVN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125467; c=relaxed/simple;
	bh=Dfc/Ix8uSNkw071qEVJRL+sTphwl4Xc+/rwfpEckl1o=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=MmLDlnSdBc4RArnVyd6TguwSVMc/OS3e2k6amJDcqGlCSZmu0BtRVDeEsw2zIiL/WRGRC6sxMtQGvoBMcHl9PO4OZ8okicjH4b7/kmQi5CppstbSsDQzkr4czzOC7AToJn9K5+dKOuy//fNyK4OeX0qLlxmNkV3ID1NbTytexSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7fi2Fs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7fi2Fs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25221F000E9;
	Wed, 19 Aug 2026 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125460;
	bh=nz41y+BybP8vx+Y6WHR0Wcdgk7LCAcF/UKRWUmnah9s=;
	h=Subject:To:From:Date;
	b=w7fi2Fs8FYTlnMinXcI3LfnpumRZSBlyh8nnlDh9CnGflQzedNegqZJdLXg/wOf+o
	 dlj+KVAd4YnWclz3sw3h6jRff8zEX4fjldH2BLVcWCdDSFObfAJgsM2UEXCgkvKo4a
	 DbKlZOFcHYe52CzX73B10TSg9IWl5adwJ+Fu7Jlw=
Subject: patch "iio: light: gp2ap002: Disable regulators on resume failure" added to char-misc-testing
To: acharyalaxman8848@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,linusw@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:03 +0200
Message-ID: <2026081903-strict-rupture-4d26@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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


