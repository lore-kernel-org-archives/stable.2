Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5755D88B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095840; cv=none; b=A1C4Z5ffCFtc6rKXTGe8emsv/E+UzwNDQ9atwqJmENkNkzS9q6dbMAYk4pAhKWk3qTTFNHpVLZ6pW/+pwtIRDa6NGHvptvPXpTpoMmfcKpDrTU6j1+gEpE1t8lXKAECC9X/1avwW2X/F1SMR6sPwqveYMWMN92bliF4Xr4wRZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095840; c=relaxed/simple;
	bh=oL/IepsLTpG+oSDmp7NZfZez7u3XUDEeyhKVXqPA+2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyF3PhCtA8Wobt6qdFlUonrS+UDG2nskCBHOAOUp46HDgnP5DC2oVK+1gvOH+0IICbIF9SHuaP/w0HIQYMI6T+fiJ51cxDYDsMqUE55avxHRcTgXrn7F1XBoI203CD199x7+PlWO7/9O4YUX/7ozt8jx7pf56RRZd6IZMDN8lAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSuPH3uS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSuPH3uS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1900E1F000FF;
	Tue, 22 Sep 2026 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095839;
	bh=i+hPOFrq9cPfODtG5H08Rll3CqnhAAIfF8F01zloZ3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSuPH3uS1DcEMp7eGr1MLka6kqekCP26WUnFSsM4CgTnjnMqFZmWtiUtVsz2Za6gA
	 lQDEVvKQ43bzm3C4u00ImJwAT8kifTTIr19xmbo5kTAI++SJ6jctsvxbIMrRdVgopC
	 fCLAPAKZJsNqIZqv3qLlJ5TZpCjHZGJpDsI74zC+SgbADl5bY+4KAC6W/C2FUMdZDi
	 qQhxxKHpvkTlQOqxPqkW0t2vNzWwIZZTT14Uyektdhcl6eNY8NC5Nn7BLjxu+5PGw8
	 at8C1R4gPjt84R2IRdk/OahKMFK71eZ5Q2HqyRK/8+fyNMpE+kYMqOpt/BCM9eJ8Gu
	 KCLndgHsNwu1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] i2c: imx: disable autosuspend on remove
Date: Tue, 22 Sep 2026 12:50:33 -0400
Message-ID: <20260922165033.3134020-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922165033.3134020-1-sashal@kernel.org>
References: <2026092238-babied-brewery-a086@gregkh>
 <20260922165033.3134020-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit e0c3e9d76adbe522dd420a766ce42d03ce887c29 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a0c1a707be676..e35efcd997d38 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1658,6 +1658,7 @@ static void i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int __maybe_unused i2c_imx_runtime_suspend(struct device *dev)
-- 
2.53.0

