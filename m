Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B040D564
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205759; cv=none; b=Jp/fjEeO0gRlrEBTcWtwWIbxhZ4Nn3ZNps7k8hMv8BJA42/Hd6HGaBQ1n32nbuSw/jfS93z/hAaAghbHH5q6e3lBhAOaf7VKVPX0LkwdVCOpH8zTmXd9nv20LBSWrM/PV+gypALPZko+2APxFy6+AqboaAUfGbflsntgW1/TKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205759; c=relaxed/simple;
	bh=VLZCs5lu+M384xSOV86DVk6zTJ0VLrRy3XdqQiXu5oI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LG6pDKeNhIIFOvRBsi7aw0kkVa/RjtZ+vFRbzlDgLi/RrnB0kfWRB+5qZtPRJNxLeRQKhK3j6/w/xpD+v5ZzE1uviXZGN/4N6F7Jyugy29j08TkJafR968jOumATPIjz8mgg9STopl0Q9RsWfSdfjYKCU0Gl0Alrh0v1CNNNCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qQk3Ew+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qQk3Ew+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD081F000E9;
	Thu, 16 Jul 2026 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784205757;
	bh=83cOOnpLsp744qw3I1ZSa12ATH9z7Tsal39xSh0kYOo=;
	h=Subject:To:Cc:From:Date;
	b=qQk3Ew+KRccZ6nunVGq7b5BFuvNxvb3xFt4l/9tRyFE/bHqfd50k6txAltknZKfLp
	 UMXLqu1x5pizHACDHrc8eszqfp7iuZu+yPPRDZde4LrzRjUFEyGR3YtC9uFG2EGJv/
	 1wdCiBoW5vDhwr+6iJCsMKf5OuoHlRSvGeDvIw+U=
Subject: FAILED: patch "[PATCH] i2c: davinci: Unregister cpufreq notifier on probe failure" failed to apply to 6.1-stable tree
To: haoxiang_li2024@163.com,andi.shyti@kernel.org,bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 14:42:19 +0200
Message-ID: <2026071619-reunite-unleveled-9bad@gregkh>
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
git cherry-pick -x e43f32816a1b1fe5a86279411626fe3a9be56d45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071619-reunite-unleveled-9bad@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e43f32816a1b1fe5a86279411626fe3a9be56d45 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Wed, 10 Jun 2026 11:05:13 +0800
Subject: [PATCH] i2c: davinci: Unregister cpufreq notifier on probe failure

davinci_i2c_probe() registers a cpufreq transition notifier before adding
the I2C adapter.  If i2c_add_numbered_adapter() fails, the probe error path
releases the device resources without unregistering the notifier.

Add a dedicated error path to unregister the cpufreq notifier after
i2c_add_numbered_adapter() fails.

Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Cc: <stable@vger.kernel.org> # v2.6.36+
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260610030513.2651018-1-haoxiang_li2024@163.com

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 66c23535656b..0617f416cb0b 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -818,12 +818,14 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);

