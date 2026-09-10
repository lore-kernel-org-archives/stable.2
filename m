Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A43AB285
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067306; cv=none; b=jTmBWuTBMbOTyQqSrUneclTk3971GntgaYuJc7rUJQhr80iIxc3v+nxXio8JX3ucuwNgnV1jZljCyBjUUyoc7W1NJenj1BPuDYT3y5p1rydEmJKmY1Xfry3GIuSU/BhVzST0J8IXEpq9ebO29pZUZk7/cEiBxwrBcS77lM3GTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067306; c=relaxed/simple;
	bh=MKztazk2LzLSy/Y02l4g9J8sQY3q6F80C5JRH7oiGxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vz0LBw8WmFShJjmoCYf9yujTAa720e7+K+hVxZwQ15CoDxdZOXyQRnoTfSgwtdoNmLwvc7QagI8MYKVIRID5C5PVb0J+tZdnUSbsoR58ZfGgUwzyJxoxIaIqfHhhenWgJ67KTUeagAB+QwInKyH4cv11QXJUYUOqNcI0hgqBRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+I8phWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+I8phWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEFE1F000FF;
	Thu, 10 Sep 2026 19:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067304;
	bh=qnVz+aDY3cMyMtwHpaFFfpLn+qoqOIDvSyPgIrFazvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+I8phWBeCEiFJOirHR+nYYMTvyBDHO1MTkbJH27vZG2CFzTxxTIC2hEAFs+ua5ma
	 wLzfBEWa+gHUWqlqZZU62w61vBdfD/Al3N0BjdeEfIIQOj2F0fyVFOhnW2A3/2Ox31
	 tIBKP54tsiwkEJ/DweSaEtMRg0PDTfw5UdBF4DBazkRhVM1Fs6f3TKsAfO+pYAgDSy
	 VKhAbxOYdMC2ZpKcwayIJbOWIqedSo0G64Ga3HPW8sgG+xcypCTW79HVnat02leEpi
	 NtL4hsWeoki8uueMgHwdIK6RuaF80wE6LjHyfDnXSk+JbVX7pQGKUQdTEvq826XFdU
	 4JL0NfnIyb98g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] i2c: omap: Improve error reporting for problems during .remove()
Date: Thu, 10 Sep 2026 15:08:19 -0400
Message-ID: <20260910190822.1452673-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090909-unmarked-juggling-ce1d@gregkh>
References: <2026090909-unmarked-juggling-ce1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 9496fffcb28f39e0352779a0199b6e61861c9221 ]

If pm_runtime_get() fails in .remove() the driver used to return the
error to the driver core. The only effect of this (compared to returning
zero) is a generic warning that the error value is ignored.

So emit a better warning and return zero to suppress the generic (and
little helpful) message. Also disable runtime PM in the error case.

This prepares changing platform device remove callbacks to return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: f98d49864821 ("i2c: qcom-cci: fix autosuspend cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-omap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 256fa766b1d3a..7378467c2babe 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1513,14 +1513,17 @@ static int omap_i2c_remove(struct platform_device *pdev)
 	int ret;
 
 	i2c_del_adapter(&omap->adapter);
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(omap->dev, "Failed to resume hardware, skip disable\n");
+	else
+		omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
 
-	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.53.0

