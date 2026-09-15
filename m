Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E14A8438;
	Tue, 15 Sep 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461207; cv=none; b=hODQoWtWPxkWeIqZOSxcO+ODyvPRc0wnfMWuMyt3XziJAMU+NT6vc7lD/sOUqUK68aYZ8sjE0+HeJFRuWI2ISx0ij9qWTxCJdzBqzcTJiGny6e/x8iRNFeKmYIkJFQC19Q3W8IBUwtvv7SLY2tdRADDZUr7jmdkxShJ2GkyjA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461207; c=relaxed/simple;
	bh=cxPKCV//uGbcvndnKx8KC2CJa5aIAbyz+N0Tg1uQDDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeNDuXkYRI3QUt5aD2ALTVLYoamJEB8e8ScBCnLuuIxLNGHK2lpqGOPT2xPPTHWH/2On2m2xrMv0qRaKp/eV0PaMVh966R24Vj5wjcrDtoWgSXI5KZLgmQl9ic4mNwKtCEty7zlMWU/Rn9aiJMevVTOvPT4f58gPeBT3ZW+CZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=nMJhAglX; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=AABgxvue; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="nMJhAglX";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="AABgxvue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461204; bh=cxPKCV//uGbcvndnKx8KC2CJa5aIAbyz+N0Tg1uQDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMJhAglXymYvFOSBu4H/bhYSAaefmztTRTETRCnkO4UyAE/Tp00sDL2P/2G/fwApg
	 ikyN407eQI+52qqraANzEl+yxVfTcFUrZ/skd8kALQxHVe49K6Wo+ylAanp/bKsyqS
	 tkKi2nKe4mtdW3a+Wn1QyrQZjrMC+c/1X5VqFNTUaGPE2BbjInOSGXgJYzOrEU5Nzg
	 x24IZIO3MiWr8sdony2ew/lmBMHdbfrHvOKCcYDXSxEztgVVttDzzhyw0yV2P8XxsT
	 9aoDCo9jm5NR+9jzO4wFJeuK1/Yp4/kmAX1xWQW8LstZ3hvWaTcvX02uLu8v/Rp8m8
	 Zee+TxcooGd2g==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 1DE5D40B71; Tue, 15 Sep 2026 09:33:24 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1789461203; bh=cxPKCV//uGbcvndnKx8KC2CJa5aIAbyz+N0Tg1uQDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AABgxvueC2/SebJbNEfKQl8KGQl1SdXF/XDyZPVfvt+3CzLMFaMvHT23ewM3Ns6Ai
	 BWgqE6Ky6HM7JK0+jIfgof7/9jAp1ITEaPRoLyYfm768QP+6uhRhVIphPODxgIP/7K
	 HCk4QonLQNT54/cEsl9U66eFLd5BBL5A9OvZf1Td7oUrTCk3CDNCDO++51IK0Gc494
	 euhEnq7CLu0rXtM+MgRVFLu67X3Hyk+vTHOX9cJJilSU11N3fg3Z2X386iSJQdbKzH
	 YCjPS7YIvMmw0l5m20QQouBAoUpDzjm5l/yMCqKkCZVdcwnutfBmA1nZYKgRCyFjzx
	 d+2NzLm70Pipg==
Received: from maru.home (host81-158-254-226.range81-158.btcentralplus.com [81.158.254.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 3894B40155;
	Tue, 15 Sep 2026 09:33:23 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 19/20] media: ir_toy: Validate the maximum tx carrier
Date: Tue, 15 Sep 2026 09:32:29 +0100
Message-ID: <36f7ad6de88697d39a3ab1729aabd856cfd1d81c.1789460680.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789460680.git.sean@mess.org>
References: <cover.1789460680.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject any carrier the hardware cannot generate. This also fixes
a divide by zero if a carrier of U32_MAX/16 is set.

Fixes: 8bff1386d62d ("media: ir_toy: allow tx carrier to be set")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/ir_toy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/ir_toy.c b/drivers/media/rc/ir_toy.c
index 286c8543aa5a..58b23d08a897 100644
--- a/drivers/media/rc/ir_toy.c
+++ b/drivers/media/rc/ir_toy.c
@@ -372,7 +372,7 @@ static int irtoy_tx_carrier(struct rc_dev *rc, uint32_t carrier)
 	u8 buf[3];
 	int err;
 
-	if (carrier < 11800)
+	if (carrier < 11800 || carrier > 3000000)
 		return -EINVAL;
 
 	buf[0] = 0x06;
-- 
2.55.0

