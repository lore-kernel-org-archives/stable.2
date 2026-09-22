Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029035158A5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089872; cv=none; b=jQs+ixpo+HDJXsD5xroxbOGiPakQbdakp9gjwAVUWNJpIJ0wgnustYL+2B9eYebk5NY9EWkU0lUzINcvUFRcwdrrqDcBX9A+hspB2ewnOxxHHd2ZnNjD5os8R6tXbbcsWatx43BfLfRor2bknvVrd8w+h9tSLzzj/3XTy8LggNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089872; c=relaxed/simple;
	bh=9kVygVsi68dWoXbf8cjvdx4adVS4DppeQQ8RvqlQuIU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dR4kBNdI5PjRwWIG7221OWacJF49G2y8Tp/067G/oLMJJiLCBc405z34JF/F2xacC/ARBGsBwPP/RCa9x1IExBt2/CY4Gb/j2z85CitvTni9F0GtlgrPZ3TT6ApC44jSDn0/ZBqZYpodShn7VUew1fLxGqbmB4YNSQ2Lo9Jbxlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xRi+XrL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xRi+XrL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71CB1F000FF;
	Tue, 22 Sep 2026 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089870;
	bh=/eMYDXK3FqphtybsoSxiGTOXJHy8r96j4TFYD9SRmak=;
	h=Subject:To:Cc:From:Date;
	b=xRi+XrL3R8RqfJUgFZEGVbvSSUhN80rmftM1dRspcZv6JfWez5MJkkrlsNRWsMLtZ
	 p8/jX9EcT0PJUp35Qg4QmT8djMMHK33p3tsSgb678mQv9kHxlhoLSy//rvv51EZXJA
	 5GJuCNEJmJ3ACtNuXw4hhXHoorZkBGcMhdQdAekg=
Subject: FAILED: patch "[PATCH] watchdog: rtd119x: Avoid division by zero" failed to apply to 5.15-stable tree
To: tzungbi@kernel.org,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 16:57:30 +0200
Message-ID: <2026092230-thriving-ungraded-3c65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5af7d2cbd20f893def03c8310a460ade66a5d822
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092230-thriving-ungraded-3c65@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

