Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001B331EBA
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678332; cv=none; b=id0G3+ZANFu1vnJtJCZD3Lo7Dnp8wPYo3sN0zFqo2kq+m8iVslYDo8b3Prk/9VR/j5+Yn+Pa/L5l37/nQ/7WbzBJVsWgaCCux0D/twAmQ5ydsyHiYB09PV1JgsHP8BhsIGraWYFnYzT+W5U4leSg5+yTOwFJrGDOweTk0yR4e84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678332; c=relaxed/simple;
	bh=rHy4Szbvb5hwqTTBRDX8TOzDDAOCQDYfstbCTfb/VT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukYVt9hecHCO8grRXXeDp9lxdZQiHCp7lvi5bSSoLgOCzOVWAPfYLx5BvK/LPtpxuShOXVTphBZl8csD1srQtR52rRbU1mGISFKEETkZ0xzCuez2pTIpvm1wMDhfXxrumJot+IUlCSPSa1HotoPeKGp6D98tE1SzJK7VTjru54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K708Fbxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K708Fbxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB81C1F00A3F;
	Tue, 21 Jul 2026 23:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678327;
	bh=oiVQuoxbSM9k1ENwiOTSE8kMacbmiXZSYypASKDsw14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K708FbxswHb89yI80+etJ3k859CWwuypY/YDYjAcLfz8pMpADRw6DZfFvCS97BKnx
	 0jh5Ttk1HXJRa6d4YvuJq/UGzXKWL1GjL2zHK9nBXU0u+is3PQtf6OP4+5dlXsfdNO
	 UH7J8odUMgCoBq8KLYRwMY8ZRyl3bgtIqHHKR4gIbbTY5E7OmJYjPLqFi5dptYs+ym
	 RLxMHC+StSR4WNf2ZJEnXlq9hx4upt+Z4gmesYBWjrOHshZlDXauP6Upf0yuI9up3R
	 V5/yAW6S0ofPDSIoLu6h9Jm4pdiFT8UPTT/Vv6QckyyT4RiObim8XrH3+UBxRpbulO
	 dvbBs5gpndIfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] i2c: core: fix reference leak in i2c_register_adapter()
Date: Tue, 21 Jul 2026 19:58:41 -0400
Message-ID: <20260721235844.523900-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721235844.523900-1-sashal@kernel.org>
References: <2026071656-trivial-state-54ad@gregkh>
 <20260721235844.523900-1-sashal@kernel.org>
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
index c9b1818f7779a2..f6e33bb3dd6e6e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1567,6 +1567,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
+		put_device(&adap->dev);
 		goto out_list;
 	}
 
-- 
2.53.0

