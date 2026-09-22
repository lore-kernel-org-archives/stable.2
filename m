Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7139D6FC
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096455; cv=none; b=MrD8D2tfHSRQ1AaZU4flBDKElDgijcD31LGQ/CmrDjn92aabwimj1/wB/1iFHE8JDaWZy9VEyvloHKVAbp6HsnKJqYFN+b3zGbAYERR/T8++/t8NZtLlE1BSH/5FbdIGqWDt6Ro2enVTS7msg0PEuy/WRjRJUoXei4+Q6CEKWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096455; c=relaxed/simple;
	bh=Cd7o5zflmcTC/yVUfB21SEdwDsJo0vRYxEECVZviIF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3CNKE3FhIQ3u305EiIV8YB+q9XouRWrbQ5S3dMqBhe2/SpDHnXxOvDGYwgaJZ5f1Ccw2FMt4Yahpbb/4qkLr10GEPndP+Q9JP6w5xjU6g17ZCBBhx660l4AfIgkKMANoPfAz3+zMp9u9A00ekMZbFy4KjqIVgr0GG1GHdwz+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN9L89kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN9L89kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521EE1F00898;
	Tue, 22 Sep 2026 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790096452;
	bh=4APAyh1XH+IPqxJY+lIcxhlGzz9jOEH0nKiT5cj2rOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZN9L89kjR8cT7fv5d4y/G8x9obc16TdbQisl4d2hoMtFDdPo1dJyAakukTFkWL2Sy
	 y0ASf2RAMXnj5bTQOU/x2g5ysQAnvxgTWTwwe+S1v1S+lcl7VYwrVVZkW2w7Imd+CT
	 jvSRrm2TNoni0sSHHfCLnuC29JUsIn+fQQQgkE8tuWoAjE2hLLeGNm4izy7tcppomq
	 sGyoBmCIFc5oOF2sLsSlQGZ4H4etf6E0c18lAoUB4NioreSGXn7jdQoyiZUMhYnWRN
	 Hpp1QzrFZR14io1OP+cmUsHbeup/CjAF0hAtwRJ/GzLecY3YzXoAmUtMBBZMvqKD7b
	 oReaLLt1FH+2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] i2c: imx: disable autosuspend on remove
Date: Tue, 22 Sep 2026 13:00:47 -0400
Message-ID: <20260922170047.3183673-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922170047.3183673-1-sashal@kernel.org>
References: <2026092238-outwit-provable-7707@gregkh>
 <20260922170047.3183673-1-sashal@kernel.org>
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
index f59dcd3aca0a5..2410cedfcfdff 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1625,6 +1625,7 @@ static void i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int __maybe_unused i2c_imx_runtime_suspend(struct device *dev)
-- 
2.53.0

