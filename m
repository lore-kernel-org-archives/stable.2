Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602870;
	b=XTrXD/nQeILrdGxYStDbqb+ZUMkln6DvIlKduyx3mrfXwQJf+ACxRXcFRtkGsN2g6DjP
	 5HqY/g5r/e7yTIFoqnznsSsUsD2EpD/2+SWriV090rnFpi7DZ6MpwwMdKVeAytE4f3gCz
	 llE/vewkcV0wjeM5/i+e849NOLwT3k9UyN4v1fdgdLb2tdYsLFedTPe2XhPZFhWVJ/EeM
	 roPTvBBd6lu5b2MFc7Bu0+i2R+eL7jzPtx3/pq70dqgIEyuGlSaDwS9F3BUsVD3RQFjjg
	 MWjuzBD6HEkYfS1Dt1rNRs8vJpgYztiLZcA5SzaPndfb35Z6oICAwmMjo1p0mGNqiOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602870;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IuJMKMd8YwKGAw3o9EshHhKAYXOr+OfXihc5xKzTDsc=;
	b=nmbhFSCUk2xVNZyye6eAM48/n0UrbjrDfO+ws3C+UuwiU37qyrGgRI7ZbdkQMJp0a7Vm
	 IA2DP8YBQiMc758EEk+6ZGbgZEJJj5NkgwtzEcjTY7vd7XcoYtziaazGhs465B30Cl3tI
	 9elURbbD96rIjt3qKZHexjYHYf34psQ7XK9ZSINvhEy5Dd2RUYBt7e1EfBMU3yQQeHtrU
	 tfdohQbHZv68fXQEdyc0i9PKTVy50ulI5EJMSwXqKqCnET7LGH5rjlnu4C06rdDvEcWav
	 pIG1bCFLVziVrh2kcNSabpCSU9ckKoe/MuVLPmjRQYBRLmIylNyj8UWnBPw7M3pNhDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Tb6AryMF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7A606A6B3
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Tb6AryMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E6F1F000EC;
	Wed, 25 Nov 2026 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602870;
	bh=IuJMKMd8YwKGAw3o9EshHhKAYXOr+OfXihc5xKzTDsc=;
	h=Subject:To:Cc:From:Date;
	b=Tb6AryMFTPVodEX+PbN/DkwbixPc6QguU6GOwsf/YVdaYlUd1B08ULFJA+9yxJNvh
	 FeZ/YksWRXq3xHT4Fh4FhRwUZskFgPwrlPkYJJhrvT9DaJvwyt1CWCV0es+RHsbm3A
	 Ipee9dk4nR6oKeGfRKeWonTadYBG/zQEf0ncbC5Q=
Subject: FAILED: patch "[PATCH] watchdog: rzv2h: Use pm_runtime_put_sync()" failed to apply to 6.18-stable tree
To: prabhakar.mahadev-lad.rj@bp.renesas.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:33 +0100
Message-ID: <2026112533-carton-removal-6b77@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x ca800e625d18a9f5b19f94ab837ceb3fccdca22f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112533-carton-removal-6b77@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca800e625d18a9f5b19f94ab837ceb3fccdca22f Mon Sep 17 00:00:00 2001
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 1 Oct 2026 17:51:56 +0100
Subject: [PATCH] watchdog: rzv2h: Use pm_runtime_put_sync()

pm_runtime_put() may trigger the idle check after pm_runtime_disable()
is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
runtime PM active.

Use pm_runtime_put_sync() to ensure the idle check runs synchronously.

Fixes: f6febd0a30b6e ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20261001165201.763882-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 4353fa677778..27ea0ad7e91c 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -175,7 +175,7 @@ static int rzv2h_wdt_stop(struct watchdog_device *wdev)
 	if (priv->of_data->wdtdcr)
 		rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(wdev->parent);
+	pm_runtime_put_sync(wdev->parent);
 
 	return 0;
 }
@@ -269,7 +269,7 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
 }

