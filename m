Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964D4F93BC
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089864; cv=none; b=I1vXivROwDeWLq+2h19sFe1M01jWJvGMfjB+6F7jYhPf8h64H4Qh7h8gFD4wQKuwyJya/avQGwxIRWUiJLxTzNNdF5mwPGMf0CP3SUq2HSvbKF4gQoxlW5hcGLbMPVou7BIpXdSS0IuR7HunWxXStt6LC41YfANu2aMF2vtpAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089864; c=relaxed/simple;
	bh=y9iQoA/eb47fIRrGEIXZ6WqYfVFgTqKY66SdC9bQWlM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JkK6nR/QN9f/hAb+VyFA/9kOh+YpQDiG9eljznUY2//ZtlF1sIJ6YJzqGFpDu+GwOJo36QbC6TkpnU273XKCQJvqgYDDhONLGK0l3NIBuCanDYzC70X3gZ9VF5rHLo7Dd5FPv5HPoqzd34u9KvYI/UE79GDhUrpzybJvTjPXwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JidO4aRI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JidO4aRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90081F000FF;
	Tue, 22 Sep 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089863;
	bh=k43BVQ9HCmxQvCOufEcbf+P6LxAJuYUzZ8Gg427L65w=;
	h=Subject:To:Cc:From:Date;
	b=JidO4aRIpLTQup6xkFAxek5p3rOlSsG+FVS6ekyOmcJ2les55mETJL+kgFd/rPg50
	 fQ+Tr32gmZNwmeW2DjMIEE+0sompC3A1ZkQnfNPdAPJY+uL/M/kRvM7F+FPNFK5KXn
	 vK0eVVLL8eKQM8g8if7a6/IubVmedopzQ9rh8VIc=
Subject: FAILED: patch "[PATCH] watchdog: rtd119x: Avoid division by zero" failed to apply to 6.1-stable tree
To: tzungbi@kernel.org,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:57:29 +0200
Message-ID: <2026092229-endowment-helpless-158e@gregkh>
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
git cherry-pick -x 5af7d2cbd20f893def03c8310a460ade66a5d822
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092229-endowment-helpless-158e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5af7d2cbd20f893def03c8310a460ade66a5d822 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@kernel.org>
Date: Sun, 13 Sep 2026 14:48:50 +0800
Subject: [PATCH] watchdog: rtd119x: Avoid division by zero

clk_get_rate() could return 0.  Avoid a division by zero panic.

Fixes: 2bdf6acbfead ("watchdog: Add Realtek RTD1295")
Cc: stable@vger.kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://patch.msgid.link/20260913064851.8239-3-tzungbi@kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index 984905695dde..0bfadb58917b 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -98,6 +98,7 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rtd119x_watchdog_device *data;
+	unsigned long rate;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -111,10 +112,14 @@ static int rtd119x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
+	rate = clk_get_rate(data->clk);
+	if (!rate)
+		return -EINVAL;
+
 	data->wdt_dev.info = &rtd119x_wdt_info;
 	data->wdt_dev.ops = &rtd119x_wdt_ops;
 	data->wdt_dev.timeout = 120;
-	data->wdt_dev.max_timeout = 0xffffffff / clk_get_rate(data->clk);
+	data->wdt_dev.max_timeout = 0xffffffff / rate;
 	data->wdt_dev.min_timeout = 1;
 	data->wdt_dev.parent = dev;
 

