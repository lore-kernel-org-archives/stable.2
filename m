Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983984BEE51
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070232; cv=none; b=uE/7huQwYPqa24ZlAgbGwYlN0bW3UNHNZnTYDLUCG7PrQ8Nk2kzPjYqNHOLZtoJ0fSZ2rbLLBxvmqAB01MW73f7pbFyaBwOa2iz9VjuDfWD++WYmFl5MbX58yPFxULhcZIXA3LLRC1LU5fv1qCY/MiiJcwuvkQwWhLCfvJd+6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070232; c=relaxed/simple;
	bh=VWVOVbrRONJCJ16+iOOrCDf3vHK5ouu7hWGfw2jneI0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AAnAitw2CFcO8dUbCkVjuoD1xhWh9TOdLHt54ubrH85/GkAGvHv7qtR6lBgWbhl+6vhlxMdI3eNx9xbdOTM9MFoIJ39/H00fKMzKv3xFB0WZrWptWanuZ7eFegHng02AOKAEOooFi8qeXgBg8Sr0OicTMQj2GznNtJPr2h8NXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ulWi2eg2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ulWi2eg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542721F00899;
	Tue, 22 Sep 2026 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070230;
	bh=iVUje/hVczq85CQdlWARaQzG1eIaiUiH4/6S8uFI078=;
	h=Subject:To:Cc:From:Date;
	b=ulWi2eg2mRB4XJwH5bIDg0LXS/bz5vQtIi7H+ODAcPoVdcE2PInPChKwLsFurw1GL
	 777WqS/0k1z8a6sBtRunLW/72cTDs6CqCbGyPUFaBOcJwQ4u7uCFhtv/OrYNUMQ6ya
	 xFqCf0gjiTAZagLU0r2wdSDnrib/doYOXsw/1IBc=
Subject: FAILED: patch "[PATCH] i2c: imx: disable autosuspend on remove" failed to apply to 5.15-stable tree
To: lgs201920130244@gmail.com,Frank.Li@nxp.com,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:39:38 +0200
Message-ID: <2026092238-outwit-provable-7707@gregkh>
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
git cherry-pick -x e0c3e9d76adbe522dd420a766ce42d03ce887c29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092238-outwit-provable-7707@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

