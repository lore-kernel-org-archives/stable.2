Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1043CE64
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065575; cv=none; b=ogdrTScAsFLRs23KE99KCyFVoiFiaxxYbpsmwYQQBjVQbY6pJYNuxGmEwguS2nY3huGZw9UErkdQRvSZgnvGrJ7VXRRJkRceDq6qaTtrT2bCxK/9YN3qqRxJpyoIyq0bgfKUhoVcC8GVbsFIS38fZANXIEH2x0j+MszCecAsHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065575; c=relaxed/simple;
	bh=/NPabh3Q5TmjnNkkWoEQeYbgcynn5TCw4qYgeg2fei0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tN4ZE7X7jIiBL6JFBWi4rENLCLj0h7TKerDus6irdv6LYZrV08f3F5XrDdGv6XkYBG0phg+hJ44Y5EazlvepFyV6y2FstwhK7cp1tZWOmdXCHEWdpDUM2E3Z3UtT6fZsHFZt7BKhxopOgrvmZm9/BTA++QdfAw+A1Rj5XIGbUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYhkjPLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYhkjPLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8195C1F000FF;
	Tue, 22 Sep 2026 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065574;
	bh=YUa9lsidhIOTfh8rhNaL05SssBxj6FL1LYR+iwD40Xc=;
	h=Subject:To:Cc:From:Date;
	b=dYhkjPLt/fv5mSzyXgbiL3WaaEDNSxgUrNzQUpbyCHvEj1YjOMcc4fQMOV6k+76F6
	 8u7GoECwqKE1TjJItIr32swyGbCfzStzzZnk3I+7In2Rrgtnq5xl0mQtZ6dYTeQAYh
	 Fh7mTLhr0abGHrGAqbnLEN15qWM+U7D1jXguwyc8=
Subject: FAILED: patch "[PATCH] ata: libahci_platform: Fix device reference leak in" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,cassel@kernel.org,dlemoal@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:25:56 +0200
Message-ID: <2026092256-flyer-contusion-4709@gregkh>
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
git cherry-pick -x 0d1cb83337f13af082afb68b28d3fdfe29cde7fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092256-flyer-contusion-4709@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d1cb83337f13af082afb68b28d3fdfe29cde7fb Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Tue, 15 Sep 2026 06:59:33 +0000
Subject: [PATCH] ata: libahci_platform: Fix device reference leak in
 ahci_platform_get_resources()

of_find_device_by_node() takes a reference on the port platform device,
which is only used to look up its port regulator and is never released,
neither on success nor on the error paths. Drop the reference with
put_device() once the regulator has been obtained, which covers both the
success and error paths.

Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://lore.kernel.org/r/20260915065933.1733061-1-vulab@iscas.ac.cn
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6e072d681341..f6524135ea11 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -620,10 +620,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			of_platform_device_create(child, NULL, NULL);
 
 			port_dev = of_find_device_by_node(child);
-
 			if (port_dev) {
 				rc = ahci_platform_get_regulator(hpriv, port,
 								&port_dev->dev);
+				put_device(&port_dev->dev);
 				if (rc == -EPROBE_DEFER)
 					goto err_out;
 			}

