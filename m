Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA143302F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663318; cv=none; b=PBCjUz+ZqZuNVkWDl+7r4QDQ94RXGmiT0yGXH6xyqqyLm2BteaN/nSzRysVkTUcoYuDOPb1ehZ7cYjUhYkx00E7k3CPh/+0w6gmoNwRkKIJACyezDCGChj1Xi9VgdL4Z1LwWXqyLb/x9mDJxal48x6wcZxAuHiY/zHXrBbRr9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663318; c=relaxed/simple;
	bh=mkF4Raw+sjh4xUBfF5MimUxFcC4PEEpucKb8kzG9gX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWXp7wnq861xIwsc7M+7SzBGd39JmGsc5336IY1nF2n5weXbuSnhkCsZJsjKouW5tTnPRdt1QUIi81yf3NxnLWxPnxLixU5PdyiQMdtYFrUjYKJ/GHr1rXM/GJbzNEtvUo9c7FcGz3Ic9bM9jZhh5PSqouMM4ZA5pLtObIbrM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM4fBkmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM4fBkmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF48F1F00A3F;
	Tue, 21 Jul 2026 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663317;
	bh=pjlIkiK6zDcW8afdHY3fMkfEkj757kZtJVW/wUuvm88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kM4fBkmj+yiZ/qjpXrscT80svXgQk5XYTvHOwQkg6WHM7T10/ytIANVfn7ruj1c6/
	 QyMwFaW4k3S4dFR5Os8cxGgIIghuHC3QC3/wDFxAuajMyBxxXdrVJAfK/kjuctQ8Oo
	 C0+vALNml6o3m8PyqWBpKMT+lU0hcZ5kDmzrTrBr2n9DtGe7wjmQyIq7Avc4nBvEIv
	 U8LnHT8YWF9XO0WgLZoyDpPghBe5YojTbafGSPLjy010amdSTR5Xmw1PddQABNpKKA
	 fyShb7jfxCvJKS6N/TuBoMWEhCHeRdJyo69Iy7UH4Y9hwljun+LysJspZpwogK9U4h
	 q2UfbUFXfzOOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] i2c: core: fix irq domain leak on adapter registration failure
Date: Tue, 21 Jul 2026 15:48:31 -0400
Message-ID: <20260721194833.416799-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721194833.416799-1-sashal@kernel.org>
References: <2026071656-confess-dean-8762@gregkh>
 <20260721194833.416799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8ce19524e4cc2462685f596a6402fbd8fb984ab2 ]

Make sure to tear down the host notify irq domain on adapter
registration failure to avoid leaking it.

This issue was flagged by Sashiko when reviewing another adapter
registration fix.

Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not alert")
Cc: stable@vger.kernel.org	# 4.10
Cc: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cb4313d50c6011..9e6cd1942e201d 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1563,7 +1563,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		put_device(&adap->dev);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1606,6 +1606,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
+err_remove_irq_domain:
+	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
2.53.0

