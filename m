Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AA54280A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872112; cv=none; b=Fa1XGEDTuLMFCuxMrGGKamR4q+bZdQSRImplRJz691BR1xU0TKD4TvcTc4GUxbAVfUuRXUrnbFOenyWa/kQIKTmCNYh1GQLrBmXZsGCGbILtDUoUQKIWd5esWb00W1nXKU9wI31aOOfiLcjKTFd19b5GMLaJm6j9xVOHuZrT8VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872112; c=relaxed/simple;
	bh=n82+7QQZGqIO/HK3D6iGyJXIRqrbXn/U+p0uuwlljMc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YV42s8CaqEfAPYiMkWWHi3A05vtHy1Mw59MiBmNyuJIa07ZbVy2aC5ZAHN6TNG2drdRlKjl8kQPZnqaILCkV9JI7m8/2/Azp4njN0bMbkVqdaIs2LlXZnNfkXGcTFfUGEUfpTft996KvI7RfpVv8Y6y4QPw/5v29YWzmtAOUDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oe3m0sUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oe3m0sUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41D91F00A3D;
	Tue,  8 Sep 2026 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872111;
	bh=UNa+42oVpBI8c4FnJbHjeKGqFTeWPOIsIKpspfoOpnQ=;
	h=Subject:To:Cc:From:Date;
	b=Oe3m0sUdeDmuhoTM7GC0rYkJms9HAgXyeGkTodPEIr8E0DXp5UrsfuU5MROhCFldi
	 kH/tVlAr00rk1K1ZMrnCrxKiPnQMuiFAXKL3acbWdENVRwL+sq4PM9rgzSy8sr9PSQ
	 XwF+EMeeD7Xv0Dce6QklA2hfBzexPriAIJfg5PIw=
Subject: FAILED: patch "[PATCH] spi: bcm63xx-hsspi: disable clocks on resume failure" failed to apply to 6.1-stable tree
To: pengcan@kylinos.cn,broonie@kernel.org,kursad.oney@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:46:31 +0200
Message-ID: <2026090831-flashy-precook-e8f5@gregkh>
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
git cherry-pick -x 3b0cee02664041aea7e4f787c66cb86c82eb4e97
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090831-flashy-precook-e8f5@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3b0cee02664041aea7e4f787c66cb86c82eb4e97 Mon Sep 17 00:00:00 2001
From: Can Peng <pengcan@kylinos.cn>
Date: Tue, 4 Aug 2026 15:20:17 +0800
Subject: [PATCH] spi: bcm63xx-hsspi: disable clocks on resume failure

bcm63xx_hsspi_resume() enables the HSSPI clock, and optionally the PLL
clock, before restarting the SPI controller queue.

If spi_controller_resume() fails, the function currently reports success
and leaves those clocks enabled. Propagate the error and disable the
clocks before returning.

Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
Reviewed-by: Kursad Oney <kursad.oney@broadcom.com>
Link: https://patch.msgid.link/20260804072017.860974-1-pengcan@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 37b3534d0b0a..633164e5a856 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -919,7 +919,13 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 		}
 	}
 
-	spi_controller_resume(host);
+	ret = spi_controller_resume(host);
+	if (ret) {
+		if (bs->pll_clk)
+			clk_disable_unprepare(bs->pll_clk);
+		clk_disable_unprepare(bs->clk);
+		return ret;
+	}
 
 	return 0;
 }

