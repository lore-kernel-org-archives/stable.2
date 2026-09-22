Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D54BEE51
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070235; cv=none; b=nl9034WNJxYSm/L+5Yhb1W9AaKH4ZPRcaX6OgDgcBdSiGAnLLCThgro/Kz6Pp6aN0pZuCpnm29gRWbM2YqOk7143kGbjloWzDULDwVPv+FpYceOBX93HxROablNVLOp/DQWYUoYE02Tq1C2rpOpqvkH5rIxJbLNAvELs47cx8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070235; c=relaxed/simple;
	bh=oZCTPYeZlQ8vdWOu2iLsGH9pZmc6OxjHe8iYhiuUAb4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tk06MQmiUMU7Iwh5BdZLEW5Q83q4+8XH6prk9X5GbK/bqa96tKDxKAl7ohnu2vnK2GfrIbxiLVXd1/DL3eSCScNhwD7ge3ymqvC6N9D2HnWxxAQxCc6B7+6AfbJOiRILhEnCg2N4X7q7yb9Y6r0lLawjxC0EQb+QJthyYVcv6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6ewz1B2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6ewz1B2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9736F1F00893;
	Tue, 22 Sep 2026 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070233;
	bh=GS8be+ef1ctnQSOSlc0tZaGxHhMvgJJLC3kUOqqPrRA=;
	h=Subject:To:Cc:From:Date;
	b=H6ewz1B2aqML2Zhj9haJRtRhG/KFfg4x82tle8u62fkMBZ7V3da5ISvGZEANdZ/bx
	 QxO35BsQpe8r43VoIEc8rSyKntHgcojPtYZiFOWaB/RSKQeFG9A718E4SzsovS4ogS
	 5XtPFhlSMdiphfCv6fTXB+hzkH5gnIIoMxZ6dnY4=
Subject: FAILED: patch "[PATCH] i2c: imx: disable autosuspend on remove" failed to apply to 6.1-stable tree
To: lgs201920130244@gmail.com,Frank.Li@nxp.com,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:39:38 +0200
Message-ID: <2026092238-babied-brewery-a086@gregkh>
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
git cherry-pick -x e0c3e9d76adbe522dd420a766ce42d03ce887c29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092238-babied-brewery-a086@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0c3e9d76adbe522dd420a766ce42d03ce887c29 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 14 Sep 2026 17:15:44 +0800
Subject: [PATCH] i2c: imx: disable autosuspend on remove

i2c_imx_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
set therefore leaves the runtime PM state incompletely cleaned up after
the driver is unbound.

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the performance")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Cc: <stable@vger.kernel.org> # v4.5+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260914091544.1667137-1-lgs201920130244@gmail.com

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 19ec056b00af..4dc3df6a41a4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1920,6 +1920,7 @@ static void i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int i2c_imx_runtime_suspend(struct device *dev)

