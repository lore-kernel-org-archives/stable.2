Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DD3CC7DB
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872127; cv=none; b=CykCwDdgVbl1J3eCFFVOeBXwq+4HSEXUwDx2FdXKwJzaHGAfA2RhMsW86qnW2L4jStE5GfUPMH+rkHkAMWrSw4MmnNHHct8eF3W4JwkBJDVgjPeTmoY1bWJ3XW7rq9mAnxKM3/c5hJTwRJqR9iZdrtNdTyDkjbgQEvSZdzg6gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872127; c=relaxed/simple;
	bh=GsxiatRSpuhw+raPU+81ENbEMxgcOzEi62yS/d2IX3M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hTyraRTYrx5/pLTfziIN0yyG28UOdD8foVUhwWp+Uhk8Jnwme81r9itGj3We/mnPJ7IBq7TlhFlB9opHKu+NuHFvVyeK8kTeZhKAtohh1SKwyyMpANPqhd2loShpKoBZ2jP/GQyUyWtEHF2s5vyVHn+vgh4EWYZhy5Akiqh1tEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA7B1F00A3A;
	Tue,  8 Sep 2026 12:55:24 +0000 (UTC)
Subject: FAILED: patch "[PATCH] spi: bcm63xx: disable clock on resume failure" failed to apply to 5.10-stable tree
To: pengcan@kylinos.cn,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:46:43 +0200
Message-ID: <2026090843-quintet-dyslexic-a9ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2b62c2c134fa32d9d3a9e7323c8ac74518eeb4ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090843-quintet-dyslexic-a9ee@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b62c2c134fa32d9d3a9e7323c8ac74518eeb4ac Mon Sep 17 00:00:00 2001
From: Can Peng <pengcan@kylinos.cn>
Date: Tue, 4 Aug 2026 15:18:31 +0800
Subject: [PATCH] spi: bcm63xx: disable clock on resume failure

bcm63xx_spi_resume() enables the controller clock before restarting the
SPI controller queue.

If spi_controller_resume() fails, the function currently reports success
and leaves the clock enabled. Propagate the error and disable the clock
before returning.

Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
Link: https://patch.msgid.link/20260804071831.860784-1-pengcan@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 8cef725aab26..1d8e257bad30 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -653,7 +653,11 @@ static int bcm63xx_spi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	spi_controller_resume(host);
+	ret = spi_controller_resume(host);
+	if (ret) {
+		clk_disable_unprepare(bs->clk);
+		return ret;
+	}
 
 	return 0;
 }

