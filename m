Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC763339390
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716236; cv=none; b=bgRncbOXo1SybmyMbWghc5sOyfNTxrDc0IB9AD3H1yuTiRmMSZ5AN9z9mZ+jeYVNPdIFTlNtaiXvVjrKr3/LdgdgTHDGVx6iCvJXdhVFCxZt3NjO9kS+S29NAt5Ua4HLmDeoAUpi9d+G/3cQi5XLAapTW3txNKiicWEH6IPnXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716236; c=relaxed/simple;
	bh=5iEAN97LopZkozzi0jI9NqiMw0QrC+hHNRYqpAbD+JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfa9UDrXZ0SvlU/k9gzSfILMPE29Xzb8nrkNgrIgNqvVNnkrxI889kRujxOsiEqdzAlGiytq6a9uPzjepacM8Ukijms68V2OhtyyO9fabZs+35kvlqkccNIafo446SgPMxyrYD+8K4SDMxfbEja49q8+SPEOyxQojKMPWo86KXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8EmuXW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8EmuXW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350E61F00AC4;
	Wed, 22 Jul 2026 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716233;
	bh=y40TReRac2MsHJuJgMIcGcDe4tasrVOi7w9+34ERbIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8EmuXW5p2H/Lb5WHaj8g1v2IwjUeepBh3q/kFB0lakQwd79d1HyKQmhu6TcrbH7Q
	 ybmbmTuTGJE8vwLRxMno5+UY4N5HgS3dX/GySleBQN6AcOHXVeJbyHIvG/HGz0TSoB
	 izTsTWP27GCFTZ6/SNSGybG6DlL6duGhSFY+tEH3zDb4wZltQq2DtPAMtBNFS0XO3U
	 qfVgOePpx3lRLDBiGVL5gm6bhHpsQLph8ca4os6HoWXDwNl+iHSZnk+pIUiSEQohnS
	 OXpwCdxkSilvFfco8d9cusOXN4Am18xd975Ymnc2SMrNKWuL3BXIajs5oB2vKcS2+D
	 qBLw0uudeHqqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/7] i2c: core: fix reference leak in i2c_register_adapter()
Date: Wed, 22 Jul 2026 06:30:25 -0400
Message-ID: <20260722103029.890864-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722103029.890864-1-sashal@kernel.org>
References: <2026071657-book-manhandle-a0e6@gregkh>
 <20260722103029.890864-1-sashal@kernel.org>
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
index 1200f5fe41e1fa..4e7e8af87750fc 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1471,6 +1471,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
+		put_device(&adap->dev);
 		goto out_list;
 	}
 
-- 
2.53.0

