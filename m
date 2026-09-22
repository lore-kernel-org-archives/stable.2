Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452844E0B63
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089821; cv=none; b=Sioj21/ZSWm9ODr+X33/7SZxmX0Wt/x9AA2DLRnG5c+FwAEE1UKXvjtou1MhMDpe029m0aw/5NtO8cenOApJLzH1T6cysuSeXbXYZ0v4Psl/aHLTxZ3j/MCatB1YOWxqrjNdkm004tnKHz0bydR1RHG89sFVWFFNS300qcwKFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089821; c=relaxed/simple;
	bh=3wBjg0BV+NDAZM4pkMQiM9bVEaFU3Lfx2bQjFKBS65A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gJm/19lOc+n+UwPJrFDEXf9goZ51FWplJCyNnbG2C82WYvtxMoQT1u/0IkD+CPYCE2MP9yMr6WXnyTunQIKr8WtEkOwPICCXdl4r+CuJUaJDLkd0Wg8Gxiy8qPyqNIc/APAhLNFNsMjU/eHJzxxifjl7XcRnsvo3q1T2go/iSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cViRGoq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cViRGoq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3A61F000FF;
	Tue, 22 Sep 2026 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089819;
	bh=VOs2ewTYNBigRIXcfpS00uzZ1cONeFIMwSQ2XlAiaB0=;
	h=Subject:To:Cc:From:Date;
	b=cViRGoq0GY0RLot4ZlXNX51/YAeCzbFAMTxfPBwkMQC83FufEz9d9y7Xn4hVfmLO3
	 p45NWfYgmD6Z8+fsuL0f7S/u80+6rmnTieEJ7Sgnfmw6fju0Yd9KOz0wFwZ0AhAJv8
	 qG5VHsVJUKX93GLQpGf6gJn4k4lIYA0aaEi6mCUk=
Subject: FAILED: patch "[PATCH] Input: adp5588-keys - cache GPIO state before registering the" failed to apply to 5.15-stable tree
To: alvin.sipraga@analog.com,dmitry.torokhov@gmail.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:52:32 +0200
Message-ID: <2026092232-fetal-skinhead-12b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 21efadc62272cabee9bec27777ae75d84a9ca8a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092232-fetal-skinhead-12b6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21efadc62272cabee9bec27777ae75d84a9ca8a8 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>
Date: Tue, 18 Aug 2026 18:00:02 +0200
Subject: [PATCH] Input: adp5588-keys - cache GPIO state before registering the
 gpiochip
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

So as not to clobber any pre-programmed GPIO state in the execution
of its gpiochip ops, the driver caches things during probe time.
However, since those ops can be called both during and immediately after
the call to devm_gpiochip_add_data(), it is imperative that things are
cached before that. That's not the case right now, so reorder the two
steps to prevent any clobbering.

In the concrete example which motivated this change, a bootloader was
preconfiguring an important GPIO output to HIGH before booting the
kernel. Linux would then inadvertently set that output to LOW while
configuring a GPIO hog on a discrete GPIO line within the same 8-bit
bank (because the cached value was 0=LOW).

Fixes: ba9f507a1bea ("Input: adp5588-keys - export unused GPIO pins")
Signed-off-by: Alvin Šipraga <alvin.sipraga@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 40371f5bd9ba..4f0ddff5baba 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -446,12 +446,6 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 
 	mutex_init(&kpad->gpio_lock);
 
-	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
-	if (error) {
-		dev_err(dev, "gpiochip_add failed: %d\n", error);
-		return error;
-	}
-
 	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
 		kpad->dat_out[i] = adp5588_read(kpad->client,
 						GPIO_DAT_OUT1 + i);
@@ -459,6 +453,12 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 		kpad->pull_dis[i] = adp5588_read(kpad->client, GPIO_PULL1 + i);
 	}
 
+	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
+	if (error) {
+		dev_err(dev, "gpiochip_add failed: %d\n", error);
+		return error;
+	}
+
 	return 0;
 }
 

