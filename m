Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC21360EE5
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681452; cv=none; b=FhGQcFcmIEFvNkyLOIsHZbIau5y20ewHJpKY++alZsoe05gAAS1lYCUTp9CqNxv2HMayGup5DfcQqImioiIblLmJA2erL7SyMvBRSx4NW0EQ9qJpz9Q2nSOtUlV9jTJ2gceb3FwoiOM4TsG0+A+OpP0PzObom2/OB+4tFFtBWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681452; c=relaxed/simple;
	bh=qrwFas4yLlV7uo5WtikPFi4mO+WH7B36GhqhSwOjx0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS1WfKrTYqAnYeCq/IDJdGmt5m9fT/gEGS5Zw1/t54SJKoNaUNSY1oPM1Oyn1KM5irE5gOTXMcoO83PjwspaRsIy2YF10xqWT29Z125+hL8JgNCHZVmqOl4ufLLWCSkAWze6UC74r6bAkEfU7qbXS09BVfBa3pBQ7cvkFQTbewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyaAoKSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyaAoKSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4481F00A3A;
	Wed, 22 Jul 2026 00:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681449;
	bh=G3QWXRQo/mUETWjX7m2+npNiPN9UQfAfeKsB9CrGU84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DyaAoKSIhpfGDR+bkNyhwt0sxvpXLx0+d3EU3db1cRn78/rU2KkVG25QARwhc+KNx
	 9VXu40WplQirfhud82IW4fjNTGp1j9Kl3yNAgwBBRY3vWm3YIirQjgddfu3uwbJ08/
	 jwpwiMFpSb8Ng+9Sv7WXq2EGZF1P7Re0IJ/bsfANXFJqL3sK+FnL2eWu+dH3bWMaU6
	 kQc8pCn9NOX74QKG5+tQCATPe0Sm2U7oYgslpyBnbcT825sdelO44JR4cZMFQnQBaO
	 oWLqcr0b0rhFWYkFYf14+sj6N9+hQSOQdVQnHKy9wBm7C22duxMHfGVHIzToFruYwW
	 TBUl9cdassHyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] i2c: core: fix reference leak in i2c_register_adapter()
Date: Tue, 21 Jul 2026 20:50:43 -0400
Message-ID: <20260722005046.603973-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722005046.603973-1-sashal@kernel.org>
References: <2026071656-dullness-penalize-0e99@gregkh>
 <20260722005046.603973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit 3f8c4f5e9a57868fa107016c81165686d23325f2 ]

The reference count of the device incremented in device_initialize() is
not decremented when device_add() fails. Add a put_device() call before
returning from the function.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 60f68597024d ("i2c: core: Setup i2c_adapter runtime-pm before calling device_add()")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1df75dcea8b97f..4b3960fa35f7bb 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1564,6 +1564,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
+		put_device(&adap->dev);
 		goto out_list;
 	}
 
-- 
2.53.0

