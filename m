Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046608;
	b=dx6HLyi8rwSKQ7kK9EhQ5sQZgt9msXe7qfIrTSQaGlhn+tzSkhKggfMsWq0VUCxvP+TS
	 OEuPNKIXVWnvqxb7VraqTR6/t8nNsgKdTySTPbksoSF869eCCBYWc7EmryBzpaGzRgob8
	 dGf4eaXhtRJtXon8ecyF/3l3DGffFh2bP6pStdcPve+/yy5CVrqElTog87cQUsEbwlZAK
	 n2qgTCcEvHw/4+PDQ2OvZ8iJY3cBOfMU2j0JJ6xKabQ1KOYytPH1puZbJYrZYXivsAZ/G
	 4DN0aVoEqmL0njYqGBZMnqaWMd7ZVdTOSUEUqxq/C/jFUrefquIyz7IRUkbtVEWXnKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=blonuOr2wJ60ObJy2od9dQs1VQ+LnRnRzmBmTtor4iQ=;
	b=ZAAIL3zf3jpnG3X+r8yabAWzZ3KULy/nhUgECs6pNAwd2q6yvrFxL7RTSm7mO4ZbiMz5
	 cJOMqIN3PPTCuotnB3CG+AeXk9rDlFEnWduXJiVnYEz8sy9wLsWDcroIfK+QP4ZICHekw
	 K9ww4BbEuQktn9dr2hQmDeVmsqBvI3Y2lkOQ0rsT3KopZFq89bjwiMmLtSO9sJaz7913T
	 948THiSPx6OmDdI0ywDRyITXbGuJx+Bna4NysHDWup5+s3m0xnkazmD59AuW9OCRudquU
	 9evdOEr5o2d1FdJ7fz/EHEvSwADjzfH6Y8YdZKjduKc3cayfKD0beWPrRaRifInFpiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cclpnIhd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E4606D832
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cclpnIhd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9881F00926;
	Sat,  7 Nov 2026 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046607;
	bh=blonuOr2wJ60ObJy2od9dQs1VQ+LnRnRzmBmTtor4iQ=;
	h=From:To:Cc:Subject:Date;
	b=cclpnIhdAaSENYo0PeyN77LHmv9RYQYQ6ZWjR2K9O1KIQXJQrrvL0IlKGkINPp7iE
	 7S6RXVl5PY53F63s6ugBc0mZORO12bLOxUvkg4RiJtH715A3ph8qz9kG6Ufjy7jpqG
	 taXOOLSk7+cUMev731Wcvk5kdKQv2Q5ZqsOQIHfzWeO/Y+kekSCEDVit8ohT8LYXz7
	 v3L7lYopUNY5NpUH4akPjIBPNt/bB4xo60YPwMiN7dlxkcXyqmqcAj+IGBsLhoZYi3
	 u7/yQzwt1OAZ802mFA0bJpFUQccf8vzPD8VO7DZSDjlglwuh7QAmQYJu/Gs607Xhf0
	 6V9JpxyQAUS9A==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	dipenp@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hte: tegra194-test: shut down timer before GPIO release" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:46 -0500
Message-ID: <20261107051646-failed-6.12-30167fadbf87@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 30167fadbf87fa901a2fee49c30a5c5a506a43e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051646-failed-6.12-30167fadbf87@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 30167fadbf87fa901a2fee49c30a5c5a506a43e8 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 4 Sep 2026 14:11:37 +0800
Subject: [PATCH] hte: tegra194-test: shut down timer before GPIO release

tegra_hte_test_remove() releases GPIO descriptors before stopping
hte.timer. gpio_timer_cb() accesses hte.gpio_out and rearms the timer, so
a callback concurrent with remove can use a released descriptor and rearm
after teardown.

Shut down the timer before releasing the GPIO descriptors.
timer_shutdown_sync() waits for a running callback and prevents it from
being rearmed.

Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/hte/hte-tegra194-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index 32907d951ec9a..cca33868fb03d 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -217,10 +217,10 @@ static void tegra_hte_test_remove(struct platform_device *pdev)
 {
 	(void)pdev;
 
+	timer_shutdown_sync(&hte.timer);
 	free_irq(hte.gpio_in_irq, &hte);
 	gpiod_put(hte.gpio_in);
 	gpiod_put(hte.gpio_out);
-	timer_delete_sync(&hte.timer);
 }
 
 static struct platform_driver tegra_hte_test_driver = {
-- 
2.53.0




