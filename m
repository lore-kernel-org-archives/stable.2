Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2C288BA
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278376; cv=none; b=uKXbml2vT/E92inPg0AnPQx6IkNdzUT+1EgvbdnnEgxpTdpYSQq3snw3lB5shfLyVBO4lbY67AwiczBRQOlmjXtg7RcDnOqs1BTwLe5b3cjQHcm0eIIrdynYwJb9Ys89pj+xhZgcn6guLDKvvh8foKhl/YnUz4a00u7e35092M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278376; c=relaxed/simple;
	bh=2vzKfTuuV6hop0/ww1sjszSmF0LLgdeFZH3QaL9hfx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7M28OCi+A7Z+9Itxf/nS9xvx8bZNNJY0bZ4UkQ43ShhvZBDqWOFJCMR3RjeM/jwgCDVTJWlEe63HYl04e8Qld8f2oH6KLD6dC8GqLgwdTvLQBpTcYUSBogpQn+v717EQhOVzogVeyCYVkaNkdv3PZKcIV9oLZ7wtmPxjM1FP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVX/DuNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVX/DuNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD311F000E9;
	Sun,  5 Jul 2026 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783278374;
	bh=4oiLRI1iqRJJ2xYvPAmmlHdsPeDf9BTEoUheCQBV/lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IVX/DuNzzF4NBKE3M4ep3nnCn9wCFrpHH3N+W8Uf6hyKQrXcHx8j89UBjYEHH9Flc
	 PlGosLKvjY1+URn0U8KBk8aDBm7XTh9DMUdVfwesuSGDGB6MKz76SovgV8f8K22bCP
	 wkO7U9fCyFTnpiwCNAqT5a3YfDSDjHjY8jAwBnQH8Zyhj6ESfF3zjjoHoQsd89zuqR
	 XnO/DHfyDiOHpRo4p+qCWyJvaV44jtidqFS7QfKgy+b/UH8YzHRxqm0QkAWdg2BERV
	 RyYw+f48JCtW5H3ROflpznQcqP+/qc4yb8xO0/9XoP5f4QeZF9WP+Bl/XJKU9cXPIK
	 HVeU47GLsySyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] i2c: core: fix irq domain leak on adapter registration failure
Date: Sun,  5 Jul 2026 15:06:08 -0400
Message-ID: <20260705190612.1987801-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070233-lushly-episode-a47f@gregkh>
References: <2026070233-lushly-episode-a47f@gregkh>
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
Stable-dep-of: ba14d7cf2fe7 ("i2c: core: fix adapter registration race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ef6d52a38b5c94..bbb4c8a3d4a6fa 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1461,7 +1461,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_register(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	res = of_i2c_setup_smbus_alert(adap);
@@ -1505,6 +1505,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
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

