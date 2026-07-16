Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A041E6A5
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205665; cv=none; b=mm1Iibjkd4tOeV2VJMAyVI3Iiy73cr/6v229s97otJI4z8YA66pRGf2e4xKLkrIusWCtyJV0aOuPfdnWxhZwJ4g4dqELBiFuadrw0LGdW/VIZdZDytiT4wE3RRkvLN7apmQMNRBGCf4xm5wFkTSpcFl9520KgW+SoqtONmrdZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205665; c=relaxed/simple;
	bh=pY/qD2v6fgrqccASF+4TdWK4Pn2IbCRiyYHfpJT9swU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PQMhBeYza9O2io2YWIkr0eIPY3FEnjnoXRTY9CIsg7/kf5aXeosaOLRb0ZNryfXnkOi4ziGRgS0pOoAh/NYrRqCFEWj4RV1g/1cnC7ySc87/ZFa59+z5FEFtJEml87NSuR2CIIywHGu0sXgAfDRa7pmTgtZyKES7gOsY+AkYO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1aCkJdhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1aCkJdhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B868B1F000E9;
	Thu, 16 Jul 2026 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784205664;
	bh=S1ZTfVD4Ep69Zqdn0sgriIVAe8WFE/bkzSYyNt1X0MI=;
	h=Subject:To:Cc:From:Date;
	b=1aCkJdhm6L6w0cLegm5FC79xpMSxO7cpnd1Va0mqkAwyonIlgvo8lC2Q+z5VLOsXC
	 YTKFP0XyBvahzFUAND1BMemF+bfd5X3L+wq+UqldNJDqCt4UiH1svINzEZR4AENbxB
	 t4DRTSVnbOE9tMGEUERDPmADoUqf5K946Mgf+4/g=
Subject: FAILED: patch "[PATCH] i2c: core: fix adapter probe deferral loop" failed to apply to 6.1-stable tree
To: johan@kernel.org,codrin.ciubotariu@microchip.com,wsa+renesas@sang-engineering.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 14:40:56 +0200
Message-ID: <2026071656-trivial-state-54ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 158efa411c57111d87bf265a3776614f32d70007
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071656-trivial-state-54ad@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 158efa411c57111d87bf265a3776614f32d70007 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 11 May 2026 16:37:09 +0200
Subject: [PATCH] i2c: core: fix adapter probe deferral loop

Drivers must not probe defer after having registered devices as that
will trigger a probe loop if the devices bind to a driver (cf. commit
fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).

Move the recovery initialisation, where the GPIO lookup may fail, before
registering the adapter to prevent this.

Fixes: 75820314de26 ("i2c: core: add generic I2C GPIO recovery")
Cc: stable@vger.kernel.org	# 5.9
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index fa9db415e219..1caaa3b3ee10 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1562,6 +1562,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1583,10 +1587,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
-	res = i2c_init_recovery(adap);
-	if (res == -EPROBE_DEFER)
-		goto out_reg;
-
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	/* create pre-declared device nodes */

