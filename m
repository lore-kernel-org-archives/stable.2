Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36F17DFFA
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093861; cv=none; b=SWp3tuc8aJQS0ffzabGcZ8Mg/Wbb8L/6CSB3Ihs6Donvj+zQpp+pXMsi0cAg1UXvz9DlZKPpu4gJkLRv9YQ4gf/AfCnZkWzBVKmlER3npn2RkkYe2hTevSJhlL4hWwgyvFDleHLoWJX0JE2fKAL+wCVmxBCvIE1TPPZxRTOvyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093861; c=relaxed/simple;
	bh=uQ+CBS/l4IEKjlDBxzJ4fXQqsvkEyBMk3Zd3WJHVHW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHa5f/35DJm4uiUityen4uQ5ptkOY8D7nVtt/RUui5cw/vfv6npIBmTYVr2zWnD+ANqqPeH4Pys0wN92dW5VSpHcNwRZ0uJq6qh0h9+CPfncSiOK2ubNT2xT8zCmw+rHG7Vf/dsMOlOZqpu3tZo9T9CfbBw03J60F4rsowTbAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgJZ8OUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgJZ8OUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B4F1F00893;
	Fri, 11 Sep 2026 02:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093860;
	bh=fMvVGQcZRaDktweY1b+mSo7l4t1ZVjI6CKui6gOt4y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TgJZ8OUT3It03EMSEazsFyUpyWREcHKQ5uIQB8lvz8hSW4n8Qr0i94gWLlUZhvtLF
	 VPRJWvl6D/K5PNh3c9SrnXwXJB8AEzH6vszi0NuRrRVUR624bnFENMA/mYHk9tIbM8
	 BBXRD4ZcNPj6AZH/AVPgYss7Qr+mDOR/23kSoeBUR5nc1LH45l41YdaIzatFBaZd5A
	 RB2ykdTZi7nvUsfwaQHsCH03LgYNeHjX9SoMLPCnZqtHj0GMo0GNJ0QzpuZJAuwBrv
	 nobF2LIyoNFyIVFuZthP2J7wfYmTe9RHHkNPydY7RWpetEHV97rOh8iNmd843dvEgc
	 ogE2KEItYjxRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Moksh Panicker <mokshpanicker.7@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iio: light: apds9306: fix PM reference leak in apds9306_read_data()
Date: Thu, 10 Sep 2026 22:30:57 -0400
Message-ID: <20260911023057.75546-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911023057.75546-1-sashal@kernel.org>
References: <2026090902-spruce-sleeve-2bcf@gregkh>
 <20260911023057.75546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moksh Panicker <mokshpanicker.7@gmail.com>

[ Upstream commit d378fceaafd79e0dc59d3546bda251a3058062c0 ]

apds9306_read_data() calls pm_runtime_resume_and_get() but several
error paths return directly without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference and preventing the device from
autosuspending.

Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR() to
automatically handle runtime PM reference release on all return paths.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/apds9306.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 389125675caa4..5ce01037ae554 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -471,9 +471,9 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 	int status = 0;
 	u8 buff[3];
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret)
-		return ret;
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return PM_RUNTIME_ACQUIRE_ERR(&pm);
 
 	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
 	if (ret)
@@ -537,8 +537,6 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	*val = get_unaligned_le24(&buff);
 
-	pm_runtime_put_autosuspend(data->dev);
-
 	return 0;
 }
 
-- 
2.53.0

