Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3D35F16F
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110247; cv=none; b=TPT17D4CPfWomBmHkBb225BFEAYrfpmZOoE7AQdaYPzqhZsUMtiG19Nmctto97BCYYSmvYKLV8KDkb5s1oGFpJmjH8qBREOWxGon9rirasL8d48USn5RpDWLLTlypkpU0Pddi8jwZDPiNeEkWslbiMFTakjxCPLDIcZVODbB0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110247; c=relaxed/simple;
	bh=If2cfkod5COH947E8eO9zGyS/kqZq0PaVpwmXO0fibc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ifYaMvlDSusvlP46f9DfiSHSPfL99CoXB8jaP8FJJrOFf45t/JI+LGgUGY6MRafntnuerJ2O9BuwuhTIrUlTEESdeoMBiJzgFK8XQFl/qYlvsugxdg8JyFp+ECSWYn8JOtBXZImXK1oH7hct19GpIRfPxTKHmynK+n6z4S4sVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BpcH7p78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BpcH7p78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C200F1F000E9;
	Wed, 15 Jul 2026 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110246;
	bh=Jq50e7sZ882CZCMxnwqnURTi15+AYihDjelnPi0GiNs=;
	h=Subject:To:Cc:From:Date;
	b=BpcH7p78oZNHc2plSzdfQImUma4FoB5hosb7oHR3RJm2dm5nAIUZhW1WAZaPCPsIV
	 IOVBYy+NjikkGeaq8kRpEMaCZt+jkXlJEFPNLS1MVMNcIXkcTak6Y3mAtprjLnTFny
	 akoEg+bIJND3JpHhv2L+KAufh788KB2yP7JHlDLw=
Subject: FAILED: patch "[PATCH] crypto: atmel-sha204a - fail on hwrng registration error in" failed to apply to 6.18-stable tree
To: thorsten.blum@linux.dev,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:10:22 +0200
Message-ID: <2026071522-shy-landmark-49bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 49e05bb00f2e8168695f7af4d694c39e1423e8a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071522-shy-landmark-49bf@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49e05bb00f2e8168695f7af4d694c39e1423e8a2 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Sun, 17 May 2026 18:27:40 +0200
Subject: [PATCH] crypto: atmel-sha204a - fail on hwrng registration error in
 probe path

Commit 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
overwrote the hwrng registration return value when creating the sysfs
group, which allowed atmel_sha204a_probe() to succeed even if
devm_hwrng_register() failed.

Return immediately when devm_hwrng_register() fails, and report both
hwrng and sysfs registration errors with dev_err(). Adjust the sysfs
error log message for consistency.

Fixes: 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 37538b0fd7c2..12eb85b57380 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -183,12 +183,14 @@ static int atmel_sha204a_probe(struct i2c_client *client)
 		i2c_priv->hwrng.quality = *quality;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
-	if (ret)
-		dev_warn(&client->dev, "failed to register RNG (%d)\n", ret);
+	if (ret) {
+		dev_err(&client->dev, "failed to register RNG (%d)\n", ret);
+		return ret;
+	}
 
 	ret = sysfs_create_group(&client->dev.kobj, &atmel_sha204a_groups);
 	if (ret) {
-		dev_err(&client->dev, "failed to register sysfs entry\n");
+		dev_err(&client->dev, "failed to create sysfs group (%d)\n", ret);
 		return ret;
 	}
 

